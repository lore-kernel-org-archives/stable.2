Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794504756;
	b=IgvCA8grLP2q/Q4EUEM8whnXRD6k0R++OxtOV84qr3OT9kEBPyWdVJullHRhwOu86NE4
	 TSJiCujHV4+Gk1MhYhNaHe+sO1OE33JIboEw5ujLUm3tmGP4ADCHUdYjqEMaY+Bt8Xqpb
	 /MIPwxlvacoBq0Tpy7903i0F9f2hNH3i0pVl/Ey0+FkKIB6wmVetXsO0/2C959/lHZX9J
	 3ytmZ7emI4ivIZ8sHaOfs8AOZp8/HAyAlg3lfXwiqVGdih0dY/AEMDPEUi2PmTi8e0io8
	 XpkP5+iW9fRhHOHkKT4Y+FmyY7PP/TDXxrabkQAX5z1ZBScdWqWuU4z14o0joeGl7+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=uvlpRV6PcTM08/lEakwe3Mf9uWtn57n5IAUH/fdgelQ=;
	b=Cume9I4Iu4JAoXRUPo2VqDIUKQpikSzIqUlXnt3WMrq7dVnbHHdgVBXQoBLSidyyW9ZQ
	 MJW0qhFkAhQhcx3fwOewPO2u6DlydXGcQzQi6tOHhGdjV/GbYmHHVwjzCBnqta4IoSgwc
	 JJcAGPOJ5kMul/mB6IMYco1ST1LI9jyflYVAOtJOfbVjssnoX+Gi5+XX/8hsZevfD1Qxo
	 SAohU7tEMfDo92bqsU3408gJmDDaWk5cV0BAxcVFwbYsPPJF3W57mf5nJaFllcKyhW3Gw
	 7KK8LDAjw4kAbkJjM+vzbwChtEhr+WnkVZ56tfgiQYi65x5LKTqtXJTD66C24F4hwVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cPYgXY+E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7FB606A332
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C7FB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cPYgXY+E
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3adb75e65ecso1474111fa.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:32:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794504755; cv=none;
        d=google.com; s=arc-20260327;
        b=n5rRGPQwcqpDBS0dgMzp76bnrcJCgHYz/XkRey9oUXos4kE3X3dAS/6wBe5XR4VE5X
         IiwVS9R1gKOE7PTprmP4rjudl9Uq0RaLbwdH3AEo3z3nhyJaMdIuITIwcu2O9IB6y4SB
         L/K7bwXjX+nOdfea5RzuLtj3fiB2QeSgCqI7NcyYwX2bBQBXGWxrzCgNJ+tyIm6PsWAr
         1aaRIHF2cgdf3roHuSyDRJOHZfKr8MPNxtHiOUWVmy6pk/C12Mr92hQeM0JKc2bOV9lo
         I+Q+2j43ntJH1mr1ybKlTwrsEqgj4m+my6NmQ8J+BWp5jClqKnouBn0ManUhbMUvrQfw
         17FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uvlpRV6PcTM08/lEakwe3Mf9uWtn57n5IAUH/fdgelQ=;
        fh=Od4BhZ1N1s4ieyxnsI1Fxl2NLZPW4KVi72/l+Zplhkc=;
        b=Iv2+LJDYWegR1gWxDS9PwQLvRqxkGi6Ven0Pnfx0wTs7XUCDXzkCsjPWFD4Df/EfJu
         ZNwaD2teEmUTcz8StGzaT6JfwLP2WwBLiQlcPBL/ZAG1k3jEyuCjhd3PBA4LxQjIl76a
         tt6wJSDI4rzArvKTcdV0egYHIyRRrbSLormWpOoIcruLOsktvHd5/axBsStaPFuqEhNp
         56Kpcs6uvJhYhvQ3ZVEJRiQ/KwhRkkg1bWDiw+YR0fDo2R5AA5rlz66xnwgvMyzV14O6
         c2c9r0LUPjjA76Oe6Y54q4vd49OOGSuyvmygpqA75BQPTStf/t2BMfFtLNb825mMGQE1
         IlnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504755; x=1795109555; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uvlpRV6PcTM08/lEakwe3Mf9uWtn57n5IAUH/fdgelQ=;
        b=cPYgXY+E7vomXUXiemWyiQitJ8jT6w2ZLe7bOXWEzdEWJS94K5FgEdC+j00BRJeUuk
         C36z8XglLt3Bhpy9JGLe1SD8KgMGBjK7qulURDLvHYBM+pt7dwbpkAQZWyYaz7aCk3+d
         FE29rmRQyOJJOLGci7tIyAWGAambKQJhElA9pyZ2JmYPlZ6/oKXEgkNHihpt/dSxFhfw
         V28x/gsoDAXdfjbCAF+Bby5x3K4v9sgtU54H5jb1BMGYQCD5lDt88fqHRs7UE69ZZR6s
         +12A9ZV/AA9AlZ6vG9CVlI2E862CXkHOHhGtDbakt+WpxKFh3T9mto/7COtk1K23IhWD
         tlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504755; x=1795109555;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uvlpRV6PcTM08/lEakwe3Mf9uWtn57n5IAUH/fdgelQ=;
        b=XUpfnDxgXuFliwJhrfggMmiVqlAlFi82e/vKqOHAHr/YMf+CQ6DGURo07N8XLsMxiW
         eJp+Jui2XbMXh3/4jDMFMjUyDwXhJN+aCImHOtQs4zwv3MixvxU9m42wjnuLrZgLytT9
         rDrv5hcADooi5NPI05O/CCtH9hh1BuAYMhe3Uc3Rzv7b87fJfgpU7hzf7K6OUkE3aA2+
         FIpOD1OYnH5j5XmovIockbgwgPRLPmnTwKucjBG/Ld18IME88TZpO4LQKT1RCEMVou7d
         2CSkfgGUQHcf7cgvShNLRPzUJLtXo527w4PVts6z7zNC6NmusU//Y0bjqtakmrh6npg0
         xsyQ==
X-Forwarded-Encrypted: i=1; AL+hErEsUf48XtToP07/hWq0ImWZeivd5N4N4/av9P793yl2yrMl0842GaoDqE9PqS6OGp3LiEQiV3U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cMawkJ58ZV7h7Z8WAr3nJhk0k3PYixYVKFne4w2NRfZCA5eEJ
	Nvtem5suRzwWBcS0HKxArFcSvc7AxsuBdUgNnTGHn1BpPXvFZ+nv+vvt1+n8dT/rmrAb0amAe5y
	0jWK0O6rb5KkDFQpB2yieifBuRaPjea8=
X-Gm-Gg: AYBFou1rq1QkRtik8+9QMij709HM6EWk6kcYhpdjQ3XwLdtO3ftYQrVfwd2QiY2WlRY
	4j5Agfw1vncNtStBlNsn3g7RUJ9Ml/ByVnIpyhOVJwCd+yUZL/Wo++IExUAsw5kCwQnCggmt/f6
	uc7pYXIwB5TY3rX6xmCybCARhjDSqnmfqTqfNa14AzXF8N7TWPNuR8+adEP5DSoL3dDTfXdPusJ
	1y4oSD+NIDhyNl1YTJVpuz9W+DhFef0dDrdKkfGK4Tmn0GSoP0HcmB1vr4oIiAvRKcIx/+Ygvtc
	PE3mH1x6HEKlUrdPJoU5mOqx2kZGuciSQM9TGdrRBVr4ibBCLVqlwb2OzKt7hxIY8HYsnVANl0Z
	b3zqTGYeUPOQpQmLZA8MOwlgjW3lxsBmumrNvoLken7cfcAT6lYodCgI4+bHijpx/Dzj3g3I=
X-Received: by 2002:a05:6512:1288:b0:5c1:5703:46ed with SMTP id
 2adb3069b0e04-5c170a00a41mr22428e87.6.1794504754625; Thu, 12 Nov 2026
 09:32:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-iommu-probe-race-v1-1-8c0b986b7e6e@gmail.com>
In-Reply-To: <20261112-iommu-probe-race-v1-1-8c0b986b7e6e@gmail.com>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Thu, 12 Nov 2026 09:32:23 -0800
X-Gm-Features: AclHuK9Z7jBSZWw9Fn8TnUnk2iUH3q-Sin-aeWc7hO6RSzhS2Undt4qpZ9_1474
Message-ID: <CAEy9hNXRwH9qD-=Gj3NiY=ZVrVq02hAj0dPU+o8YfEmCcbSdNg@mail.gmail.com>
Subject: Re: [PATCH] iommu: Don't let a driver bind while bus_iommu_probe()
 still probes its device
To: aiyengar1990@gmail.com
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please don't apply v1, and it should not go to stable. On re-reading
I found three problems:

1. "A fwspec without a group means a probe is in progress" does not
   hold on ACPI. On the driver bind path acpi_iommu_configure_id()
   creates a fwspec, and nothing there probes the device or frees the
   fwspec. So a device whose IOMMU probe failed earlier would get
   -EPROBE_DEFER from iommu_device_use_default_domain() on every bind
   attempt, where today it binds without the IOMMU. OF does not have
   this, because of_iommu_configure() either probes or frees.

2. Drivers with driver_managed_dma never call
   iommu_device_use_default_domain(), so the window stays open for
   them (e.g. pcieport with a modular IOMMU driver), and the changed
   WARN condition can then hide it.

3. Replaying dma_configure for a device whose driver is inside probe()
   is wider than I described. It applies to every such device on the
   bus that has no group yet, including a client that went ahead
   without its IOMMU after the deferred probe timeout; that client
   would get its group and default domain while its driver is probing,
   without a warning.

The race itself is as in the commit message: the client's dma_configure
sees the dev->iommu or fwspec of a concurrent bus_iommu_probe() replay
while iommu_probe_device_lock is dropped.

For v2 I intend to mark the in-progress probe explicitly in dev->iommu,
have of_iommu_configure() and acpi_iommu_configure_id() defer any caller
other than the replay while the mark is set, and leave the replay
condition and iommu_device_use_default_domain() alone. The other
ordering in the commit message (the client sets dev->driver before the
replay check) would then still warn, although nothing is wrong there
besides the warning; I would look at that separately. If you would
rather see this solved another way, please say so.

Tudor: you are on Cc because this is the same "!dev->iommu" gate on the
readiness check as in your thread
<20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>, for a
different case (one IOMMU, concurrent bind).
