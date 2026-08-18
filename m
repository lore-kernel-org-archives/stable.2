Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA4383984;
	Tue, 18 Aug 2026 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066566; cv=none; b=HqemCGPx+/HTttUqCem3NXNZ377DEHxQultf/9MMG9lr8qVYl3fB+65RU5jwKSAN1WGVljx7bCwrUidiipV3V9MxTHpF/MC2DYmPZxHelDO5xPzcYWkp5j2NtQQIgsbW9aNfflaZaQY8PryDXE7qyqJyDr3ngLRrnvQiDRJyXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066566; c=relaxed/simple;
	bh=4yY5A6/tK2n1HYt6hWmY0BN/TF4w/tEKWmTDk65hZ3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYHRqkDRQ1W/BHMyPx18n/x1CMkYHhAJe7UM9joG+vqz2fSjs5yhkK76H+60zNrtB6E/U6QKHwHx4XL4t4BiqU3ubekmdDjzX0u2JF8RF/c1/TV/qyVsXmFKm1Dd2f4lU24mBINe0kNTqZSF3EcuzKRxoYa6W5IRRVjiZq6RNiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IK2a2agC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IK2a2agC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A631F000E9;
	Tue, 18 Aug 2026 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787066565;
	bh=5LC1hAOyQZZ2H+I/QLGInjPhUwgspzt3AdGP7AyAaqk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IK2a2agCpAENystyFiEPkn7MjYazjlt1hpkU0w0Fxs95Y7+xlhpW2PP548YdfeoeX
	 e9DKJU8wWNbKYZ4TM4SkS7rEIi+0xCmUOPJi2w2YnbgTyrUYSvkhW9UFSfEl0oZ7ae
	 7EFXiDYgIqmphl0d06eVsBt2k+V7e3M2BuDLwE6kW7YyuGn4N9dL442zt35AzhWwMy
	 4DJAqpaI1vfEU+T9rR0erU33Ii2yPzDjfvkPvGxMelpm/3TAxWo4KTew9Hr36RKeYU
	 +6po5CS9YcOTBlLICfTZ4iuhIJovL3SnLna9IzbX+6RWS8wD3nCIFKgvzUooSX+9JD
	 C8Na8ZJIYS2SA==
Message-ID: <54d5f790-95a6-4e2a-a667-a8302d086650@kernel.org>
Date: Tue, 18 Aug 2026 18:22:41 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] media: microchip-isc: disable histogram and
 flush AWB work on teardown
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260817-balki-isc-prefix-fixes-v1-v5-0-2514df336c5e@microchip.com>
 <20260817-balki-isc-prefix-fixes-v1-v5-4-2514df336c5e@microchip.com>
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
In-Reply-To: <20260817-balki-isc-prefix-fixes-v1-v5-4-2514df336c5e@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/26 09:52, Balakrishnan Sambath wrote:
> isc_stop_streaming() and the isc_start_streaming() error path dropped the
> runtime PM reference with the histogram still enabled. A HISDONE firing
> just before the stop, or a failed isc_update_profile() on the start path,
> can queue isc_awb_work(), which reads the histogram registers before
> taking its own PM reference and faults on the unclocked device.
> 
> Disable the histogram, synchronize the IRQ and flush the work before the
> device is left unclocked. isc_configure() is the one enabling the
> histogram and then calling isc_update_profile(), so do the cleanup in its
> own failure path; isc_stop_streaming() does the same on teardown.
> synchronize_irq() must come before cancel_work_sync(), so an in-flight
> handler cannot re-queue awb_work after it is cancelled.
> 
> Fixes: 93d4a26c3dab ("[media] atmel-isc: add the isc pipeline function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---

Reviewed-by: Eugen Hristev <ehristev@kernel.org>
