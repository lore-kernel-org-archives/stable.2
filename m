Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E63126B0;
	Thu, 27 Aug 2026 05:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810273; cv=none; b=NkVXwiWKACU+ubeahckFI4qAi9KqYprecInyt2LMJMG29Qy7Hp6SdaLanZxkkYOdaUJEh6mJuscX7ARId1wzf/s5wu+9stNFbFxNyNqunNydFgiDwcI4caxhqp17UZZSToW2LkCSg6CDOXn8A/gQFnxXCGt9ZP7wF9JyWYvKEJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810273; c=relaxed/simple;
	bh=D6IfXCIxBWnM2h/VXKG1+imgPbsjmQ4897XonfdgyQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PkhCUQGIe3w7n7/PNqzGybIMbAMrCmsE2jVnDO4gPoNCNWc6GPCdjQIova89QYSFPnxLLVKV4pYHXNEM6Rdg+XFte2pz+wU5SlVnj2tutUscp1qlFENpRERU6jla/d7EpYwKEKF2yivRq+t9gRIxs+dmFCuB6u0Zs+8ac8ZKCPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBE15kah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBE15kah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CB61F000E9;
	Thu, 27 Aug 2026 05:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787810271;
	bh=N1JB8XH1+DT64fHYiYYgEaw2dlW3gycwieqqVK7Br+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nBE15kah98yBqImA1PE0BcJDj8ltqTGrh3BYdhVistOnfwXaN/2rWyTcJ+KQ58icd
	 q2I5uxbxWVd4Nd0H0kQr8woZv+yV1D4Rdw1lGuwhmLMxnH3uS9o72M+PqRWvfMay3q
	 /1RIEEcC7AFFMpcWd2FrMyaxaR/YsIEkhg/9/F5Gj4M/Tvb/QY4Me7lLvC6PDOMgHm
	 I79rtP6/tDOff0GXTFFGRhs9Lc8IKdUYcOZ7iMGWx4mK0BJOmVmWYbAFCHgCPKrsGH
	 922FYfhgD2B0eEtgItJh2c2yXh0udK1MZ0aUx9q2vk0QvQo8Oe0MXZ4Yf2CbBm2uAn
	 qrYWmcVDIQ0LQ==
Message-ID: <0db5871f-f638-4891-a79a-f256d44cbc06@kernel.org>
Date: Thu, 27 Aug 2026 08:57:48 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: microchip-isc: don't sleep in the clk .is_enabled
 callback
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Wenyou Yang
 <wenyou.yang@microchip.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260819061920.22954-1-balakrishnan.s@microchip.com>
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
In-Reply-To: <20260819061920.22954-1-balakrishnan.s@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/26 09:19, Balakrishnan Sambath wrote:
> isc_clk_is_enabled() calls pm_runtime_resume_and_get() and
> pm_runtime_put_sync(), which can sleep and are not safe here, as
> .is_enabled must run in atomic context. clk_disable_unused() calls it so
> at boot, and CONFIG_DEBUG_ATOMIC_SLEEP reports a "sleeping function
> called from invalid context" BUG.
> 
> Use the atomic-safe pm_runtime_get_if_active() and pm_runtime_put()
> instead. A suspended ISC has its clocks gated, so report the clock
> disabled when the device is not already active.
> 
> Fixes: 01192aa1c5c2 ("media: atmel-isc: Enable the clocks during probe")
> Cc: stable@vger.kernel.org
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
