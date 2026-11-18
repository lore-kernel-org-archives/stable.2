Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003147;
	b=ayE8oOad0hXs1MlkoHzJEEbgViGHu4EtX3VnvBP01pIlJqGrM31A6nlNaPuIZ4R950TG
	 4c6cbcLEHOQ544R3euruXmuOdD2/fULSHC1CDJBiW10l16OlKdqllhQz6y2hdmhwQC6sL
	 jZiPd4E0CVQ2Uy4dJ8PGL4lOOqkGcduHbUSl0/C3wcCrQQa8OKhPfpvAD2y64onkSYlVz
	 QmtHozkIuvOZckF7xmgq+83H6EC4Qn/toi97Sf0XP9bagsFfoqxS05/yOK9LAToKcLiUp
	 9Va8ZqJlnKSIdyll9WJwM69JA5P3zIw2Ugcl4hDQ3GEASkHDo38L+IwwZbEuzD7F3CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=CnwHe6Za0gioBrJSOjEXfX4YMSK/pWetGW+W3ruXwR4=;
	b=EBcdWc6s+pjOkFrlu6S/z6fraDrLu2Irk4BsaNXJ8635RXITQ3+gkS2J5B6SpRyj5lun
	 VV4FO7NmMLOOK8wygUya1zMmuyk0ZB+1+/ak7H3Y3w8/D/Wx7A7MSw/9KEPQ7wGjXDJrW
	 ijxXYU143FPv7uG1ToKRPxtdBR4gURHDYQPcJWnhZAsnvHOp/kwCEY7TWBdLvT11B2VHS
	 Sfz2hkdt+nuCC38Uoe96/nXJ8UWUChkz7HoCGOlJxtQ4xQBaHlAheaDgZDVwUS2HPswKG
	 GQKFXbpreDeFKhO7d+2aZ8OA2apkJ616mskHY0X5ZIyYM9T8YQuaS69i0aFsGVhGLAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=OtTWgeSn;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44B0606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C44B0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=OtTWgeSn
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15ea896ddc8so1593583c88.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795003146; x=1795607946; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CnwHe6Za0gioBrJSOjEXfX4YMSK/pWetGW+W3ruXwR4=;
        b=OtTWgeSnKXHJpwpe/aV+0Gl7gLdzflqFqpIORqDeElkhJ7/AEXopMcZfY7jLrEQ7Db
         KA9kbOkEzyNgOzoh8VIg1JBa/CoWiU5REMu2QZuWk+a/YXksB3i7eFzv8rVu3B6dC2ce
         ZynOhTyhxEIAw4mS9gcX4PZzzPpZc/FFG4kEv9Ihpa8lVKldopeLHRFMYnrn6NfqFvWO
         C35+UCr8/0DuV9fora2COP+KNodMKsPS0GZHijDrouEyz86ZeDSnKwxMkxEDB5CrDcXA
         dahEOJrOTCT4pMt1nf+c+QD4yyQSM+TLBEAIjls+3amGUWZIaJ601/VHPVoCEq+ms/RT
         cGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795003146; x=1795607946;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CnwHe6Za0gioBrJSOjEXfX4YMSK/pWetGW+W3ruXwR4=;
        b=vKDyCIOJXvKeCu1U8yme/6QEESzkslYa0jCDwRzt7SFLBBsZ4C/9Ntv+2RP5I0iFDU
         0s8dp6f9T0sAio0KPAnnmSAmSlCp+F3Tz0lykqfN70x5BVwjVq9fVrTojdk296OVts4j
         RS3Lyau2mXvKxHRpefhmL2SLO55Oiqm+vKSJryzv5zauLRo56J4qRvCNMyxUGPxIR5LN
         LYzgXIbvhnwdnXYJdx0DkTpK6L9kKQ/7yL+0PLvScISlSlH4MgIZUsIcUbJbGIiB3Jty
         +SI98btRngHekhu7yfXUM7clvZeVp+5KvyVZpdYUJTjR3zfGUjVXz2sDQk8xW+a82dbW
         Uu4g==
X-Gm-Message-State: APuU4Z9p5W7/x+/o9kyZhLOsCvGlla03nXz22810jSwoHc9cuvqrSCIq
	xteDBoZmnO4ow9hyYe2KP7k0WD44oNutDD1FiH5lvBrxraLSfyx52raJLeqzLAm1F6A=
X-Gm-Gg: AYBFou1VRpJIuk0ClkUWoTbSrtf+CsinsbYhA0rYQxRndswwGC28UZwz3yLh7V/gJPy
	dRib7Bia2NXjTmIXQIIJxowE7gRTVWpxAbvj8iyD7u2AQmFp8eMJyXHnBCdwM8e9x8PPWIBRQsO
	/QVtHROyDfV6sZs4Ai9ZWYR/zhWkwDNaxBxT0TEu+vv1KKKTlgq8w649a3c1Vv5NLtEaLG+7D3X
	5ZI6ELDAZnMC8QO3Ja0wao9ktC7RtokOAZgQnS3EbPUISFZco+5SSJ6Q6XsRHnSV7yrRVOTxSDd
	RmQ2XcItG9iCExwpdretDLIM6gRMmPECTuEoK6hoT+6+l8u0rO422ViM5bPhqMGGmPju72qyCQl
	rtZqs+MMBhdr+zi87TpOXMrn0cvzbyHv+mf1Mz+B5l+CCgKhZomyBL2hKyVRCO32LQKwR08eXui
	4Gh9GBvC15Qp80bLox3K/q1lRSd3aNf2UtSApC8vEUWp9LJ4d5FM+6bgB5gwByShcz/9U8B5/a1
	Ul9b/EaEAFHweISk75Iv9ckMXQGyM8tgXAYS0XIUDvcFa6X+empGb9h3hZx+tmK4+Prfbl3qD1a
	Y6hMuWkfs2s3axMTnmoMcLv/SiyEcyx0bOHSnojkKog=
X-Received: by 2002:a05:7022:150e:b0:183:3c2a:ae8 with SMTP id a92af1059eb24-1b543d40ca0mr2399653c88.41.1795003145548;
        Wed, 18 Nov 2026 03:59:05 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447c1193sm6170107c88.7.2026.11.18.03.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:59:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E15=2Ey=3A_=28build=29too_few_?=
 =?utf-8?q?arguments_to_function_=E2=80=98pm=5Fruntime=5Fget=5Fif=5Factive?=
 =?utf-8?q?=E2=80=99_in_drivers=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 11:59:04 -0000
Message-ID: <179500314336.299494.11551223325196238800@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.15.y:

---
too few arguments to function ‘pm_runtime_get_if_active’ in drivers/dma/ste_dma40.o (drivers/dma/ste_dma40.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/dma/ste_dma40.c:1681:15: error: too few arguments to function ‘pm_runtime_get_if_active’
 1681 |         ret = pm_runtime_get_if_active(base->dev);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from /tmp/kci/linux/drivers/dma/ste_dma40.c:19:
/tmp/kci/linux/include/linux/pm_runtime.h:56:12: note: declared here
   56 | extern int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count);
      |            ^~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/dma/ste_dma40.c: In function ‘d40_hw_detect_init’:
/tmp/kci/linux/drivers/dma/ste_dma40.c:3292:32: error: returning ‘int’ from a function with return type ‘struct d40_base *’ makes pointer from integer without a cast [-Wint-conversion]
 3292 |                         return -EINVAL;
      |                                ^

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:e10ef55ba949bff0f9ed8929e20efddcb2074871
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  4bb8d342a2c791584ece3d8430e5c03eecf3b3bb

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd908e99c74e1a997d36da

#kernelci issue maestro:e10ef55ba949bff0f9ed8929e20efddcb2074871

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
