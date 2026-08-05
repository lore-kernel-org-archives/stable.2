Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3683DB333;
	Wed,  5 Aug 2026 06:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910789; cv=none; b=T3QPOmqnl9Ec3IO0ZHCGu1iyadU10Hf+WfDZ0jE0axN5PpjcpXUGStOaSuyvU24b3P+ZFIhyXCsWb9QPu5NpSQ6ie1PErakOsQJmt7jT+CHSiUXl4eNEviNNAC1dsetG2TRoWVMbLdvrh8fSaT+7OHsOq6mV/u99KT0MRpfR9XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910789; c=relaxed/simple;
	bh=GSPEiZoqFvfBahytNotfVQDrLLb4iGT19tymEqSI0ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPcD4lqDDPhBQMk7LKvcjGZvjHKV4gIqMNSq3VXRRAunyWbq7iO5oIqsbBeWfFRKfL7shSagYFguSIJSSwZMCZlRYh/hGG977b0KpmFmWv73lKoDFvq8STu8aATipXk2o4tomRX218q1sYrtx8db2sfGGH0S9REteYLGU8G7cic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAvrtA3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAvrtA3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B241F000E9;
	Wed,  5 Aug 2026 06:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785910785;
	bh=RT1fwkr852lWGJ4/B0K7dopEZE1JuLaHXleT9PZGcyc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mAvrtA3RaDiJ28p99XQB2l0NprCbHdx3ZUH24Zdiba9xQ81qR/2SdbTCMJY5Rtw+R
	 SSBKpqwLBTov0BUSqOEz8l6i09F/cJqkkhUBdx6x5bNSwHfQAyH5jC+ls5NXBnrr4J
	 ctHKkpyqLE38qijhiaDmuQH2cd0eWjLtgDLkqznGn5ov/2hIURJHb5KThIcRL7oSvX
	 mPMlkeb488w2odfppvgb4wltIoxelN+nNoBhpT4bY+P8Gj97qCXDzA2PogK51a58Ta
	 3WtvMJEPJ55aXZzM/6PCcx5ERY5OPgb5jSF82AxZIG2NN1AQqGUXpH3U75L1kwt73l
	 Jiv872mmftdIA==
Message-ID: <521fa022-0e7a-4a6f-bcec-b87319471d76@kernel.org>
Date: Wed, 5 Aug 2026 09:19:42 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] media: microchip-isc: fix awb_mutex and lock
 lifecycle
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260803-balki-isc-prefix-fixes-v1-v4-0-f625d6aa0ae1@microchip.com>
 <20260803-balki-isc-prefix-fixes-v1-v4-1-f625d6aa0ae1@microchip.com>
From: Eugen Hristev <ehristev@kernel.org>
Content-Language: en-US
In-Reply-To: <20260803-balki-isc-prefix-fixes-v1-v4-1-f625d6aa0ae1@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/26 13:20, Balakrishnan Sambath wrote:
> isc->lock and awb_mutex were initialised in isc_async_complete() and
> destroyed in isc_async_unbind(), tying their lifetime to the subdev
> bind/unbind cycle instead of the device:
> 
>  - isc_async_unbind() destroyed awb_mutex before cancel_work_sync(),
>    which takes it;
>  - a failed .complete() left them initialised, and isc->lock was
>    destroyed only on the .complete() error path, so the normal unbind
>    path leaked it;
>  - a rebind runs .complete() again and reinitialises a live mutex.
> 
> Initialise both with devm_mutex_init() at probe so they live for the
> whole device lifetime and are freed at remove, and drop the init and
> destroy from the .complete()/.unbind() callbacks.
> 
> isc_async_complete_err then only returned ret, so drop the label and
> return directly at each error site.
> 
> Fixes: 314c96e5203d ("media: atmel: atmel-isc-base: use mutex to lock awb workq from streaming")
> Cc: stable@vger.kernel.org
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>

Reviewed-by: Eugen Hristev <ehristev@kernel.org>
