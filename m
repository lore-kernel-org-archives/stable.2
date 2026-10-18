Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A583D45C5
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 06:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304061; cv=none; b=MYqina+dkXFP+3xC/yFcUlcfE276mVa7w+w4MHtyMEVYrJ18JmABMEWW4Q6g28m0qtsMsV0C9VIcXdS7FbWWXfaB7PMocjHKi4Mt0Ogehn8gPieKoxZRlL7wWBc+HTlnF1KfElTxCXub6ZcDsacTVCvC01mwT2PvFulMXBpD+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304061; c=relaxed/simple;
	bh=+2lEsHyBEj6ioBUM00ZaO+fos5og6KcV34JeUe9h9kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC79J35iLvb25VRyeZ59yn3Ma1XHlmOzRVGEbHFP3MX2rKqwx+OOvD22ph13wM0Q5ji2JzcNBPiOQhlTLIw6y0s4B9scIkFdnp5tAaI69/vKz5G3Dsvz6VA3c78X3HSiWUGH5zN7VEhKZaS+e2WwKWKnij9kkLIFck6zCU4c8ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qASQ5Cbe; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qASQ5Cbe"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15354aa70e8so394052c88.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 23:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792304060; x=1792908860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hcz1sgIE2hsxMXDV8dXqqMZVM6gJO/fdOKrjWhvUYTA=;
        b=qASQ5CbeSnYv8rF9d4E/1QQXlPU4xp4jS4DDecT7VuB5icPrBfwyAT2RXA5+FaVero
         0wAgr+O8UvVyg5AII9C4OF3aZKQYuwPLe6p1OWiwCwAdZ60/9ttMtbHuutao3USzx2PO
         EKN20kDKftlH8gO4QfgR0KfUE3KqaoISx7DPnDuSAjzAk++0PapxGeKBfiU1wtyNHnoL
         ziWdc5Us3JqWWP3+lHmq+jWYO5X3Pz7lSulv0eZrRXk0DAS4XVp2f1/8ygxDM62zqudB
         dopUT0t6Rhq7DJLEXwmz1r4oCse7VBfXh8ufJRkUc5GgSIM8afkgBM0YIdypWhYcBt8n
         81Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792304060; x=1792908860;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hcz1sgIE2hsxMXDV8dXqqMZVM6gJO/fdOKrjWhvUYTA=;
        b=gYXNeBzbnrP+050/kTXQ9sxx4Nf3U/Kx1FUI01iq7xNQEHrEpOIJWFrMsYgdYhkiuF
         oQVtP35FhzxFditt9lKrLS3D1IFixQNBv9JDpY4+rfM1yvSkAAxxb5868D5RZSLpTqRi
         p0MnqNsKGR+5nHo9PT4rAFZYxe++s+QlPgIfVEyY3mhuOi8/2YGJ2sQULqHEmRBlt0HF
         RYS0EwBZLWoQyVl0sjoxyzQ/zhRvZVgCPKeaKst+4rE3s9kjQkhRL56+2NwxigtWitfT
         IYxUJ3sUS930F45Ne44rU4O7hlLLYbMaITWl+eAU9pHrm9bb/Pepo+R454vpErZq+YaV
         a4TA==
X-Forwarded-Encrypted: i=1; AKwUvBwicc4VJeHdOZAn5BVtecZQYmTp56nkhxF+Mxa/LnVsp83t6ZZeUtv5lFSPweN7c7WA0/Q1GxE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6fRHahVM9TCyda54byUzBYhmB2mjaa7SQYS6AzsPWTbqDVu7M
	eTV9oIGDFCoCNW/1MaOxgeyNqDQgmLjCXX1/TZX3nYolXD6ggxx/vI5x
X-Gm-Gg: AYBFou2yF4P+k4itUP6O68F+6DSQDMh9kKxVIVk9tDEGDHyJNuApocdi5+RRrcOapXO
	hTHJKljtqCDk5cwMuiOGqfJvtLLBUwoukog8sgbUS+xoZhJLUxqsBJG4ulgAa7+AqLalVyEhoMy
	qLFaaQg+q3Xu1ZYSes0gzm91UIw8p1p/U+kM8/ti6HXh4L90Bezj0JBBuJK1lPOZQePX2ssiU31
	RruBAGFubNZUetvlpWVlMtC4+HVlrQ+xC1i6qoucmodxbVC4J5GW5fNzms0zXzZZ9mKt4agdz+b
	KLhPiSS0iJZ8oC617TBfeRwHfZhw9i0cHS5+SRcgJvCOjS5aufRAEC77bu/FdjwAwXPE4lZ+tLE
	/wT5BuGovWSBvxbkpxyK7nPOe0QPn0SF0/MMKB7ngPb3+5AJLXnZlBrLXJTUZcmobHwSfWQXf+6
	5qsKlvIZx2b20BlDsykdW+oAUtDm10gL1YiRz5aGa4NQjumx41O2nuRcWNHIIZ+2ARLRVqWxa4T
	rcEoYaoQ3CoWggOq40iSkXXXtkuXpzLxjnEmJA=
X-Received: by 2002:a05:701b:2319:b0:151:2e62:fe8d with SMTP id a92af1059eb24-1851238b627mr6194268c88.9.1792304059620;
        Sat, 17 Oct 2026 23:14:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:297c:6f48:9e5:4e5b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa411sm21099809c88.4.2026.10.17.23.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 23:14:18 -0700 (PDT)
Date: Sat, 17 Oct 2026 23:14:16 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: lee@kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, 
	mfd@lists.linux.dev, linux-iio@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: mxs-lradc: Pass mapped IRQs to child devices
Message-ID: <atRjqcFvWVSSKKgX@google.com>
References: <20261018022400.599028-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018022400.599028-1-festevam@gmail.com>

On Sat, Oct 17, 2026 at 11:24:00PM -0300, Fabio Estevam wrote:
> The MFD resource tables store indices into the parent DT interrupts
> property. Since the MFD core is given neither an IRQ domain nor a base,
> however, it exposes those indices to child devices as though they were
> Linux IRQ numbers.
> 
> The touchscreen interrupt is at DT index 0 on both supported SoCs.
> platform_get_irq_byname() therefore rejects its child resource with:
> 
>  0 is an invalid IRQ number
> 
> On current kernels it also returns -EINVAL, preventing the touchscreen
> driver from probing.
> 
> The child drivers try to map their resource values afterwards with
> irq_of_parse_and_map(), but the touchscreen driver never reaches that
> call for index 0. More generally, translating the parent firmware's IRQ
> indices does not belong in the child drivers, where platform IRQ
> resources are expected to contain mapped Linux IRQs already.
> 
> Have the MFD parent copy each resource template and resolve its IRQ
> indices with platform_get_irq() before registering the child. The child
> drivers can then request the mapped IRQs directly. Use per-device copies
> so later instances and reprobes still start with the DT indices.
> 
> Apply the same fix to the ADC child, which uses the same IRQ mapping
> scheme.
> 
> Tested on an i.MX28 EVK. The mxs-lradc-ts driver now probes
> successfully, and its interrupt counters increase when the screen is
> touched.
> 
> Cc: stable@vger.kernel.org
> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> Closes: https://lore.kernel.org/linux-input/CAOMZO5CgTzo6GuXptD4mFTN=UsJJqpkixDW1Q64gqZGrij8+uQ@mail.gmail.com/
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> This is a long-standing bug that I reported in 2020:
> https://lore.kernel.org/linux-input/CAOMZO5CgTzo6GuXptD4mFTN=UsJJqpkixDW1Q64gqZGrij8+uQ@mail.gmail.com/
> 
> This patch touches MFD, IIO, and Input. Since the IRQ mapping is moved
> into the MFD parent, I suggest merging it through the MFD tree, with
> acks from the IIO and Input maintainers.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input

Thanks.

-- 
Dmitry
