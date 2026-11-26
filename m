Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699715;
	b=hf/dhvYckbnixiI8ecopWr4xzibogoUfGjhAHGfeHgOsyGHZgrc61P8kPlVGPTyWko7o
	 B5Ox+YYZXqOXrmtMf2CNyKrVyeU55I9wtDFuiXrHHP2LcNJccNL17UDu5m2fVG/baFIb/
	 GQWCve6fHtljPDTWNo94n9dAzCTBdZNBhIleOnk0uuVFRbtRwX+X+Ht15yRJLgEcCIqK+
	 6dAxNrPKcmr//+Gz5W9EiZlKu7J7GSAbyi1ejRYffd0PLxSMndZ131zwdGnOKDoeMN5h6
	 CciwRmAVH9I9Pu3t7Dc1J5A0VqALcIixvfryb2rnWtP6mbQCEHc6p50XC2kjgfMbBZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pFahHhnApCqp4xWzSbnlx6J9bvCFbftUctTIaRpbdJw=;
	b=cfDOA9wtaNa58ilw0wb984TGRvK1PctyHxiIQ5eCyTskHv2xDPuQ7FOngyby+F68iI+R
	 3OsaZeevDRBvNc65A/ZncWpIdfiOEwxArJpKvvsIt4wRGFX6ghMgBLXKnSMxK6xCjYhv4
	 HNd+WVY+jCJKvYpmE4YpsFcRF0ACVPjrvgkI0c/8xekvmAoX4TVD1BjzOjYACjbDSckim
	 ntoYQpP4QW2ce5eZD4LVGYNJ4YRR6Ia2Ico0AUBP9/o83rd9HqcvkKM0cfSd7j4Bf+OaT
	 dkH1jKpk+1hQaxdSH85OkgF1kz9vmR6o6ovWfllaMMR0cdm9awbek22bQqTT08fg6rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="MC/TKS47";
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6348606A335
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 13:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6348606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MC/TKS47
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-38190551625so13610926eec.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795699714; x=1796304514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pFahHhnApCqp4xWzSbnlx6J9bvCFbftUctTIaRpbdJw=;
        b=MC/TKS47PCVThH4hxBVbgYAI17PI8aoyvnUrzLlf5cUFLIk+p2ddtVf+hQToBZH+Q/
         rB5Im9GJK7ymW6o+kw2H38ubAlvFSPrnLV7QUMeiielvCCVXjFgTv9pPaMj7j5bKFWgq
         IbMU6BMgevQG1NxYkx63x1CZ1CrFMrFtSuCi8sABEky3K6kX7E0ldh4+6UPuYNnMdTHW
         Bz1jigNK9fpe2VkAaSyGXsKvGbRhb+8I4k8LzZkkFdqc/bZrTYAIonP49b8b0MsEuwkT
         GAW+ARRDnT9SD9ayDaZpUz7XLSvG1CfXy+gvHuMerhQ22jporeapnIv76onGGYCGVYpw
         lXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699714; x=1796304514;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pFahHhnApCqp4xWzSbnlx6J9bvCFbftUctTIaRpbdJw=;
        b=PhIxU9ZipqkPGU++lM6CX+YnlvsV0v7UuRVvO6Hu4L8QPHIzWbuL97Rph1WZnYaBZZ
         viyBhW5BcCESEIwsD2nOimh7emLQYeRet1FQjYDPBOjXbKo5Y7jt4bwKkHbgFQ2EMEyC
         SFB9UywBZswGzSTCu05qMz0PMefAwD5dldjltN5EI7PxINxlqVrK1kqo0q+G7RA2irdp
         bsBYXCVLsc7EZRSRWhQYb8wVXAV9qwEN/NI7uIkrfPRrTqujaBW5oTWwVu3/RWqT15sU
         ssUNSdKy+EiG6dkRf+7cgU9YW4V0a1nZEmdTK9DmT4EUHun217TaaYbskriaSiRZNuZg
         A51Q==
X-Forwarded-Encrypted: i=1; AL+hErErE/zL8+Rd6ZzjcDHs3Ip1yDOFojJmieaJO199Zal3+qNy5Mu/7jddVF25H3rWhV0TSAFmO6g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/s8Eu9PMj9VEOj06AOh53ps+WSUdTpXsmRBgC5d9fyDgZGA8Lt
	JpRxlpzSZqZkqd/5ip0FnqMUGhGRJ9IHj7ZjfS8jH47dmFrxrZKuc4Uu
X-Gm-Gg: AZFdTZeoD2aeWUi7awMycW0DEX1djsNylbSo6SXuQpFoo+AW2HEyzG4d6833cBOkYfM
	Q80qiqPuyozzcLFCciGTCjLMlncrR9deUZ5hD4F/LyFrjM5jOcsQPbj7+p+m5mGBdk/E6ifgIYr
	Rhrj294MpZArYNcv/dmT+icBIOZ1Z/TQ0uhpj5K355wLlVhmvLJRJxhpRkfQuulL7wK4b98J+/Z
	VCHax1QMNGLc+OC5dlrwcDjH1AUfOuXLJCVToa/bqZ/BnFFw6drQ0f2HGWVWmOPjYXiqp8FUyXG
	prWnbVN5uG5Ez+xXS3sJZ/baVl/NB93E9NLNVJcj/ycZgYklORoHXzRf/AGbfIwdtzc86t8tnwD
	RBzuRuoEG3gGpLnKcyR1vxfremYEhvIbb/0/2gMMpR0JupumHEpvmH9zl8SIYLwkyq6IXj6Iia4
	C/RrkkitEgLuM8t93dJUB8OYRJ1So41Vo+rfdvBhGwP2ZPTWIUhJ6S+YqSH+kXYQ4a4rooGATX5
	6XV74+lzAu/Oc+owB8/Q3NQBA4s6Ma4KKifiFjQU03aFJYMIysKXlrG9gLUqxKtcNWMwjEMar2p
	bHryAdmm5RdwP9LET/Wz0EAq5pY/HY7Drs/HrtQABlTA1mzxi3rNND2SFKP+cDMdJpw=
X-Received: by 2002:a05:7300:c00e:20b0:386:c3ab:ab7d with SMTP id 5a478bee46e88-386c3abaf3bmr8681892eec.3.1795699713612;
        Thu, 26 Nov 2026 05:28:33 -0800 (PST)
Received: from [192.168.35.43] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm59213477eec.7.2026.11.26.05.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 05:28:32 -0800 (PST)
Message-ID: <86a7174f-c44b-4663-862b-3631b0d6c5bd@gmail.com>
Date: Thu, 26 Nov 2026 22:28:28 +0900
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chanwoo@kernel.org
Subject: Re: [PATCH v4 00/11] PM / devfreq: rockchip-dfi: cleanups and RK3576
 support
Content-Language: ko
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
From: Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/2026 10:01 PM, Sebastian Reichel wrote:
> This is a combination of the DFI driver patches from the following two
> series to ease applying to devfreq tree. It is based on devfreq-next
> and there are no other dependencies.
> 
>  * https://lore.kernel.org/linux-rockchip/20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com/
>  * https://lore.kernel.org/linux-rockchip/20260921-b4-rockchip-dfi-rk3576-support-v2-0-04f847016321@collabora.com/
> 
> Changes in PATCHv4:
>  * Link to v3: https://patch.msgid.link/20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-0-32ff1546b0e4@collabora.com
>  * In PATCHv3 I accidentally used the patches from PATCHv1 as base with
>    the wrong DT bindings; this is now fixed
>  * I've fixed num_clks typo in kernel doc (Sashiko)
>  * I've fixed incorrect LPDDR5 BANK_MODE_MASK for RK3576 (Sashiko)
>  * I added a fix at the start of the series correcting LPDDR5 bank
>    mode value (Sashiko)
>  * I've added a fix at the start of the series avoiding usage of
>    uninitialized memory (Sashiko)
> 
> Changes in PATCHv3:
>  * split out DFI driver patches from both series and merge them into a
>    new one; clock controller and DT patches will be sent separately.
>  * rebase to devfreq-next
>  * collecting Reviewed-by / Acked-by
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> Nicolas Frattaroli (6):
>       dt-bindings: devfreq: event: rockchip,dfi: add clocks to rk3588
>       dt-bindings: devfreq: event: rockchip,dfi: add rk3576
>       PM / devfreq: rockchip-dfi: move to per-variant const structs
>       PM / devfreq: rockchip-dfi: add NO_INTERRUPT perf capability
>       PM / devfreq: rockchip-dfi: use bulk clock APIs
>       PM / devfreq: rockchip-dfi: make RK3588 use its clocks
> 
> Sebastian Reichel (5):
>       PM / devfreq: rockchip-dfi: drop incorrect shift of LP5 bank mode
>       PM / devfreq: rockchip-dfi: initialize dmc_count structs
>       PM / devfreq: rockchip-dfi: move register offsets to variant struct
>       PM / devfreq: rockchip-dfi: prepare support for v4 DDRMON
>       PM / devfreq: rockchip-dfi: add RK3576 support
> 
>  .../bindings/devfreq/event/rockchip,dfi.yaml       |  89 +++++-
>  drivers/devfreq/event/rockchip-dfi.c               | 297 +++++++++++++++------
>  2 files changed, 290 insertions(+), 96 deletions(-)
> ---
> base-commit: f9316c13d6f621af4f6f4a6089d3c989ffe899e6
> change-id: 20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-74727d64d729
> 
> Best regards,
> --  
> Sebastian Reichel <sebastian.reichel@collabora.com>

Applied them. But you also need to send the clock patch[1] and get it applied.
[1] https://lore.kernel.org/linux-rockchip/20260921-rockchip-dfi-cleanup-v2-6-43ff34ac8599@collabora.com/

Thanks,

-- 
Best Regards,
Chanwoo Choi
Principal Engineer, Samsung Electronics
