Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2223BB67F
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 21:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286578; cv=pass; b=qBM+ErFjH3xnlJRI0OlpJAtvrBUIhyWXs5NRQSBFXfY2H0hw/0gIpND/o59mFWhoG54RQa2bjptP52CxeL5MQq6SeEhUvR1xLWNOfMYuGzsuXV3tBwtITx50jImFHbe4zjQXN7BdwSjv5uBVPBG8yKyQQxk/iJ6g0BV4LCx0TvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286578; c=relaxed/simple;
	bh=EYwriSULvYePD3iJ2T4Pa8I2fYA+Ygahe3VBHSaLFG8=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oljpYxNTtupjVMiQPwXg6w6KBCyH/LuZPzxIsFaEve4eFvSIRf6kaTyj26s37mtkM4t8F/l4DwPEwGcCStXxrH29rA+kC3RfVZkB2bdshI1/fNjuDEnNC3FaIs0HkD3zb3qNdMoEgCRAE55oWpe9Alqtt1rFWOOCiXJ+lCd34OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4R9qFfc; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4R9qFfc"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55eff0so34269566b.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790286575; cv=none;
        d=google.com; s=arc-20260327;
        b=oyNbS0s5yGvNA/sgx27vXRpgB+gOjCg2yvLWH/v3aHvnIQboPjOi2MmacnQctpIkQj
         FB5aVwXD19Q9I1wPNmF1KAhUVUeToweL8WSS0fnHbSpM1whKU+DEnJT1+q/Mlcmc2WyU
         pExhi20ZC8fs+X2ojRuV3hMMMjFP9UZvl4n68HwDOKov5+QHmozwL+mp+rCEUmUN6zF6
         kJ84vttZXDgTqFYUqL7UcyzS4fOFmSgBvsNn99Art6B5IGYVTKo0uPB98m4UlPGdpp74
         +SYZpb9oKT1xqxFMsqBXVN3nTQNtVFHdH8GiZ3M4D1aepLmaCpR51YjnLjV4ZtpNrQqT
         lWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=IlXhqmO4UQN1t5S6AwF3HMJwBfhvJfo1PV6ZXzxULoI=;
        fh=zCGt7UhBGh51in7YAqPI56v3QXI0ljSwgypqLlZCZBg=;
        b=iAE8i+CyciDiapb7/Emot7sRMJ9AkbpidZHoEnmahAOJQxazc5YZaVFEMQiFfvCuBK
         k1XZXT2jM4R4w7vp5Y40bYXPMLVllRKU9wye6Y7wMSKdYaArNJ5+HkC3VPhGh5y/QN0X
         mtHxKVEdqmWf7RogdviLTfhVBEmqzWylPOO1vX9XwHJikt03SzX1J54O94KvlwJRMK3Y
         pnYUAFxW21+hrsNFA0NZLsD4OHSJG/5ccaBST1axlLHZIGDOABPVdYYgmEJn/DwsrKux
         yKm8zxZnRddpdNQAQ8u/olMu9YtXzmkbJTd5j9dC6URaveHJQR+4WfNFUNIKgPluDVRn
         FI5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790286575; x=1790891375; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IlXhqmO4UQN1t5S6AwF3HMJwBfhvJfo1PV6ZXzxULoI=;
        b=r4R9qFfcwXWDXMw2frbD61TNqnMSExox+VkYBMY40DJCxA2qh2sWTgzymsK/XOdeaQ
         phYCiyj43hC4NKG3ve6x0xM9aH1D4JRZAtzuSYn9cQpXvgKluPSsG34mtzLym1rN+o6S
         VkiTKdSD0JvuFZZotChNO9Fi/VAJBBQKJm3dL0s2IyApn3mkwGzsmW3kVGA0AfIgAarO
         oJRBC1XFaEgt8pvC7yxQnvmthYx9yDQIEq70EubAAGkl95832m/aJPDQNje+qPw4ms1/
         1yR4PU7Ga0g5woa614Uren5Gny10kHM+atrUzS7NyDVUjgvjOcjFmLmSI3+JfAFpegvD
         3CaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286575; x=1790891375;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IlXhqmO4UQN1t5S6AwF3HMJwBfhvJfo1PV6ZXzxULoI=;
        b=M3O6xKJxKA9OC2Wi0WbQqufq/LKN6E83d7cqbskDtysKlJf8F62/5O8YgXlfNfCJT9
         wp1j1A8qKiAU+rX0VlWfvBVKdOJ5DYG0lPW6Cg1oQfEn6PuVsoFrKdaDeU+tVN5EMHrQ
         a8mIC+pzelHR3EE6rlMJfRSIzV95uVNhORo2MWAMUI1JKep7NegIMgpa3vm66+By59q7
         dv1jmGdgAK2YOHM4K5RNtyrkB4f5baM1YZtnCt+4hB3Pd/M+NXqsg3zEUu9RsFrJfbBV
         2ru3OPOHmdIfME7ySwswdLBYY+Kua9VhHM88DxnBks3LhgbzsbFCN2cK4aCb/JgIoaK+
         fhyA==
X-Forwarded-Encrypted: i=1; AKwUvByv4D6SpAKUhdKJvLkhdMDunY90zBFWhk7l8f4vE7O+U7MxsH7NXCnpazjHK88OmvgznENDJy0=@vger.kernel.org
X-Gm-Message-State: AFuF++kyZHyPvwPBSyVxcWR5xTo/Btdzlq+txXlVphPHkhRauxT3clef
	YzyjSt5AkK4SLGFXQYa7Zz9nUr+A6S4QAq1IDzSTIataHFOvfLbvQWUwrQueLw7H3DPENJoR4GW
	6yHUvw7DmEkY8ARP1ZntkJ32itXqpug==
X-Gm-Gg: AYBFou1OUiGZaj260XyNNAAR3Prd6NUd0s7iZclP9zTfdMmd6PSF8jD6L3sBFA7H+93
	kseH12+uyEERRB6VtgdpuVGhpVeXsiW/ee/ZGIRgVEjCYnqI/o4Pg8ZL0e2CY0GJh0KDJk7re9s
	HD2VRar2tLngoqIh6hzskFC/JDFGYZu4ey2hZu6ZWd48zdYX2WjyResCpDt+rWH8mfleG9Et6yR
	FSQPvbpBtTRalL3676dv8yduL98InJAMkHM0ewUB4sUzyrXfkfK6K6MkmqUClxes221VJqU/rJa
	TUxH9LM2xdCXXdKge+eLO7H4NplDMNqYPLvOsx7Wmgrx/oKs9DDG3sok43DaBOpXs1NGUcRSpbs
	mycNy2WXtbwIlZiACVO5OU9sA5VQZ10q/0hN9L3xXOSXGNjxEwHuMMiUhS/t0rLah
X-Received: by 2002:a17:907:c71b:b0:c26:1691:b371 with SMTP id
 a640c23a62f3a-c2ac2538398mr364279966b.42.1790286574820; Thu, 24 Sep 2026
 14:49:34 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 16:49:33 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 16:49:33 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGEsz8HmUoQq7XLr5ZN7diWt-sWYoUwYd400vpq5jYEDEB7_vQ@mail.gmail.com>
References: <CAGEsz8HmUoQq7XLr5ZN7diWt-sWYoUwYd400vpq5jYEDEB7_vQ@mail.gmail.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 24 Sep 2026 16:49:33 -0500
X-Gm-Features: AclHuK8YiU9a_Ru4QSeqUTrJVzzT1FhyKaFMooPwpYN9sMpvSeDBkg2s-WQ3MVQ
Message-ID: <CAGEsz8GqYcGK8zaos_PTeto0de4+9nkyqo_815gjac3CNSOo_g@mail.gmail.com>
Subject: [PATCH v2 2/2] media: amphion: prevent unbind while video instances
 are open
To: Ming Qian <ming.qian@nxp.com>, Ming Qian <ming.qian@oss.nxp.com>, 
	Zhou Peng <eagle.zhou@nxp.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"

An open video instance holds a plain pointer to its devm-allocated core.
Unbinding the core or its parent through sysfs can release that memory
while the instance remains open. A later ioctl or close then uses the
stale pointer.

The video file operations pin the module, but sysfs unbind bypasses that
protection. Suppress manual bind and unbind for both platform drivers,
and warn if core removal ever encounters a live instance.

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/amphion/vpu_core.c | 3 +++
 drivers/media/platform/amphion/vpu_drv.c  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/media/platform/amphion/vpu_core.c
b/drivers/media/platform/amphion/vpu_core.c
index a0c58ec97a42..2e8e08e05de7 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -696,6 +696,8 @@ static void vpu_core_remove(struct platform_device *pdev)
 	struct vpu_core *core = platform_get_drvdata(pdev);
 	int ret;

+	WARN_ON(!list_empty(&core->instances));
+
 	vpu_core_remove_dbgfs_file(core);
 	ret = pm_runtime_resume_and_get(dev);
 	WARN_ON(ret < 0);
@@ -846,6 +848,7 @@ static struct platform_driver amphion_vpu_core_driver = {
 	.remove = vpu_core_remove,
 	.driver = {
 		.name = "amphion-vpu-core",
+		.suppress_bind_attrs = true,
 		.of_match_table = vpu_core_dt_match,
 		.pm = &vpu_core_pm_ops,
 	},
diff --git a/drivers/media/platform/amphion/vpu_drv.c
b/drivers/media/platform/amphion/vpu_drv.c
index 2cca61f41bea..9c6f32c5eae9 100644
--- a/drivers/media/platform/amphion/vpu_drv.c
+++ b/drivers/media/platform/amphion/vpu_drv.c
@@ -205,6 +205,7 @@ static struct platform_driver amphion_vpu_driver = {
 	.remove = vpu_remove,
 	.driver = {
 		.name = "amphion-vpu",
+		.suppress_bind_attrs = true,
 		.of_match_table = vpu_dt_match,
 	},
 };
-- 
2.53.0



On Thu, 24 Sep 2026 14:49:08 -0700, Myeonghun Pak <mhun512@gmail.com> wrote:
> vpu_core_unregister() releases the message FIFO buffer and VPU reference
> before draining queued message work. An open video instance can also keep
> a pointer to devm-allocated core state while sysfs unbind removes the core
> or its parent.
>
> The first patch drains message work before releasing core state. The
> second prevents manual unbind on both platform drivers and warns if core
> removal encounters a live instance.
>
> Changes in v2:
> - Move vpu_core_put_vpu() after the work drain.
> - Keep runtime PM and mailbox teardown unchanged.
> - Address sysfs unbind in a separate patch.
>
> Myeonghun Pak (2):
>   media: amphion: drain message work before releasing core state
>   media: amphion: prevent unbind while video instances are open
>
>  drivers/media/platform/amphion/vpu_core.c | 18 +++++++++++-------
>  drivers/media/platform/amphion/vpu_drv.c  |  1 +
>  2 files changed, 12 insertions(+), 7 deletions(-)
>
> --
> 2.53.0
