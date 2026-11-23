Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472739;
	b=v+iX++d9YR0G79/RGXOQkYk9b/LKsdXv2ofBemSYXoG7RAIsUFXGqgmt+clbR5LD2qs/
	 g7o3S6iFqpGf/laxZszGDrLk1pr68k+TsywH0G/OnZkENsU93fTBALr1bGLqyvrw8I7x8
	 C3e1DzEb0VapaGizuLR1kIOpqvVHLRYRALTH09fzQXY7ZN1SW4+amE9ifWgruvrwXkW7a
	 8DgoSyPT3BphfDpIMe9Y5rsyo09uca5a1Wo/9DcZDbc3ioq/kdMsRkIi4Tgnm+9g6AypY
	 FsLuwk23ZKRZ3QnllU1plFdf53T5OmrrtIzQWLNfGMsS72PZaWmGgeOw7bUcMGfOFbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=O1a7RAdIgYYpZ0y9e91WZapXgmnwOdHR9E+EflWRRo4=;
	b=2oaoqjquNgiO+Yd2wRmqe3N9iFI2ngHAb/VlNqJRZPxJvdWr9wz8Ee4ClL0165r/L2q6
	 4Ep7eQBc2AHdUE8HF4hHS2yA/RNl/xH+7Uo3d4WflEEDTJzLUrc1dfsjpZN6VvYW8uQnJ
	 v0XqlVtA60W+bUjgHNTHZvVd7e8juqSKIehXE+nEfBDFMbYx4Y9iVcGBSeCXhbaWJ45xs
	 BfiWr/O/CAMYJfRc7+42IzIC5b7vIHpOjeyKQIaIIKRGKVV3RUkYU0+uD8Qemxlgf75wC
	 Qo5inZU03IRyJOz8Co+qqRu2PhqeT6iT4YpfdahWxuT7Plifhi3QVY+sj0zr2qq/q3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=riscstar.com;
	spf=pass smtp.mailfrom=riscstar.com;
	dkim=pass header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=6LEkh1Wz;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A1E606A322
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 22:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5A1E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=6LEkh1Wz
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-71ac798b8bbso2504041eaf.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar.com; s=google; t=1795472737; x=1796077537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O1a7RAdIgYYpZ0y9e91WZapXgmnwOdHR9E+EflWRRo4=;
        b=6LEkh1WzWlOSIoIIHWHHvGGe8ls6F5uMHZ1h/oA0Mfj/yUszyLlz328XQa9sRllh0p
         tVUeWXGJcqXx9ToqGSMoiqIXv1E7puZXYIJTrpse7wiOimDRxg1VWeA9864K5z7DuTPa
         iDKLedXwVP1geqUl+GNOhRu11khMsxrj3SrIfw0k2lxgSTTsR5qEBPlQsbzZzVqnOoyp
         64/NqX3sCgdpxbp7WX7Cx1QzlVVorxFLiiLf2bE72H+3UlP6o4AQCaJn0Ru4kBM/y6Iz
         /V/6jfXFmv49jLvEo9diYhTSYIrK3tnOyQodcRn6CIPXedblij46nG12w6shkcsVS0g1
         UZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472737; x=1796077537;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O1a7RAdIgYYpZ0y9e91WZapXgmnwOdHR9E+EflWRRo4=;
        b=Ke5f+od+Li4/3K6fDvawjT0HeZwx41T5ivjsdYJzZoHGhypi1N7EkV3tu/skweyA38
         yrvLgJHZ7S1SJXn9dwYlxvn+LgBYFxlTVUvXKRjGrVqqU6e9Shx6IcVyiqjxQDNahwIb
         TsKGt6s+ahJI5LZPMWsXvd6Lgn9wSQMwawyIcJw5jaBUCP0wTlGjdPmL9kU9jOB6NwH+
         K49DQP9/SD3D999V2XsxSnvrU1+aedMdTKEGDoELgmNXQaF08U++2CXb8ZqeJ2YXxiAx
         lSJ+AHEB4p1BemRT/dPt/Wi4z3jnjvcDMtCyMQ3lru10/fjpAV9sSMA85G0FnvLEALGK
         e27w==
X-Gm-Message-State: APuU4Z86olQoEWH8/9sHptZ7qV5yvdF7I7aPMVniWfyPnXeLNcmg11sE
	bzcJciMD036xOEqOSd/aOV0DEJ+LQ4Fx38iQRRX8Eh1zejzcTrkJlfgTRWAySWFL6Dk=
X-Gm-Gg: AZFdTZc84M8oJ6eHkiWMhUqfCWNfq/q4H0Y1O8GFZYZycdIs4623GqAso25ApXBjbwR
	Ep1+4QWtFR/jCKuUSxX100FTKZ/Hui0c45JBuZxXhiUIMw5jal64/2B+mCFITN9o3UqjS5KkTEw
	rx5mfftwnVQugc6D4AtITuq8KlytGHSVRqLUVvDWq8q8cPUeWfY6kgQ36RXgSyAGmA7prZGEP2g
	EM4v8UFNHN2f5QhO0Rj/IFSnWH4/oxPdB8w+TO7aD84/PODU/W8JlE05KUn9YADdyweWYJNmNAz
	FO1Lpf2jVFw3ErnVw7LWX+UCOcUg+pgJ4k8C5ihUGdLez2tBRYZH1See7II2d9MN6Ig23BC91ON
	9uk0Xvz2lI89u7/8q2zTIbp3iPINOj8u9OI8FidGJmluSe2OG+XkyAxMc6PJr/20I8dQhlMm36T
	9iNGZ9IL3qntm2u+xuV8Mdh798Yd5F+cZhWfJ18PHWZSApI5qapIpAMcoO9NOpOPAJ/1NHVJDNK
	5ipiKqGKDYdXtOOBnNAZcJwZh4o/HLseK6XphgHT0gtNa8/hcZgWq5tYHCs0f9zeOMN/JuxrnSc
	XDbcsf+XbgNXgqHXMSekZFICGbff2koY
X-Received: by 2002:a05:6820:1391:b0:71a:dd93:2974 with SMTP id 006d021491bc7-71b39039602mr10599042eaf.0.1795472737591;
        Mon, 23 Nov 2026 14:25:37 -0800 (PST)
Received: from [172.22.22.28] ([76.156.233.211])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm8511306eaf.13.2026.11.23.14.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 14:25:37 -0800 (PST)
Message-ID: <ca6115bb-1c45-408a-be55-68b74977a380@riscstar.com>
Date: Mon, 23 Nov 2026 16:25:36 -0600
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
Subject: Re: [PATCH 08/10] remoteproc: qcom: Skip unregistering uninitialised
 SSR subdevice
To: Lee Jones <lee@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Rishabh Bhatnagar <rishabhb@codeaurora.org>,
 Siddharth Gupta <sidgup@codeaurora.org>, Alex Elder <elder@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261123172140.3547896-1-lee@kernel.org>
 <20261123172140.3547896-9-lee@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20261123172140.3547896-9-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/26 11:20 AM, Lee Jones wrote:
> If qcom_ssr_get_subsys() fails in qcom_add_ssr_subdev(), the function
> logs an error and returns early without calling rproc_add_subdev(),
> leaving ssr->info NULL and ssr->subdev.node uninitialised.  When driver
> probe unwinds or the device is later removed, qcom_remove_ssr_subdev()
> unconditionally calls rproc_remove_subdev(), dereferencing a NULL list
> pointer in list_del().

At first I thought a failure seen in qcom_add_ssr_subdev() should
mean that qcom_remove_ssr_subdev() never gets called.  But now
I see that doesn't return any error, hence the check for a null
ssr->info pointer is necessary here.

So... this looks good to me.

Reviewed-by: Alex Elder <elder@riscstar.com>

> Guard qcom_remove_ssr_subdev() on ssr->info being non-NULL, matching the
> GLINK and SMD subdevice teardown helpers.
> 
> Fixes: 5abfe5cf0b83 ("remoteproc: qcom: Add per subsystem SSR notification")
> Closes: https://sashiko.dev/#/bug/linux-5594c348-0c41-4482-b001-481878256d30
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/remoteproc/qcom_common.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index c53190f0c537..6fd92c33392b 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -537,6 +537,9 @@ EXPORT_SYMBOL_GPL(qcom_add_ssr_subdev);
>    */
>   void qcom_remove_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr)
>   {
> +	if (!ssr->info)
> +		return;
> +
>   	rproc_remove_subdev(rproc, &ssr->subdev);
>   	ssr->info = NULL;
>   }

