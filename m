Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851947;
	b=WZ3Ip7bJCbm7ZWmVbiKpiiC+X1C97CTgdK7eYQz1ByiEuYRMgE468GgcJ3ad6BkKClDs
	 Xts9RkhpDaxrNEs9NXZMAftfRhH3/yU4hUrzIp8wRRXs8w7enmbFCB4JVc/Vx9Z9GbYAu
	 PYIWxmN5d+RhZtMeFTdlh0LpVckyRlb9eVE4NIdT1CMy8fiXhtZtLwrhsAqQVDTI8g918
	 ZzlnJC451MqXCEC/63AygIswGtwxP7A/V7Hgtf1n8H/SP4dHAA0juXtzAMKInJKB/s9uS
	 U9v2IhaEvbZ0Az4P5hfRSPRBHuF5lzTgwXan18IJWtfNhECMMUq6GaM8RJJjJMBuMXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=fWBfn4U9/EenzJQH2Fcg3Ft/JofA1KPr66FsvYTQJQw=;
	b=3E4Q/BSzYIlse2xus3Yd9+cnlQ6DtueDOrFl2wFX7svl8YMUd1OzMUrZVZ9avXLPQcQr
	 Ax8MV7AeJ427tnOeNNue21GbschohzHBbtsha15AFx8ZO286Yxaa11ODflfx6oqDHlyYg
	 FT/FqUX/AWZBGAT0A4uA2FNCYSqkg3Hc73SdEPErilvi0BCF2ulKsBaYt8UoS25PptgsQ
	 IJ7hPTYUMF0en+rTy9LKaowLjcFArpR6flrNHbuK73Mw33By4vG8IBDV39L1bC5XISUDx
	 mGBHql9eMVGfNsiOcZ6bpHmU5HmJzQBUpXK4bHw/WrECya1fcXSKTAo+yj6bho4+3bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=fPruq4pD;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CD9606A333
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75CD9606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=fPruq4pD
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a2761c69fbso5343626c88.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794851945; x=1795456745; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fWBfn4U9/EenzJQH2Fcg3Ft/JofA1KPr66FsvYTQJQw=;
        b=fPruq4pDK6CLAkHN8KaxHx5j34kpHQ8hjT+b9gaAQxpBaATeVMnYmxZBXuCccs4iSb
         fqdXT5InhVfR39MK/tn1aKghdMiEs5xRZCrBT/jgSiGBZqjUjVsdUTzhS8SGL8B9B0+i
         j+l4r5TKYZ/4Ku6CTl8a8jT6SE93ZL4N1mPoaK1j0Ks4SJhuOVoNXLVpEcTen+3QeRg8
         ffLqMj1OCDIPrA0r1mOu0XQzeVUpCPaQZmH3egymhCZu3tn61rmjVH6GHsG1wJFQzxQl
         OPF/oMlGrVMHjc4yYd7XhI3c3hH2cpeo5etGedGQh4mkKec8XynNH2A2+QdL+q7rghH+
         XALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794851945; x=1795456745;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fWBfn4U9/EenzJQH2Fcg3Ft/JofA1KPr66FsvYTQJQw=;
        b=pguhgELrbiiNLmPd3h6y8dqRG2ACCBv9fVORmuNrHmloyfpzrgtWM3osDgLVnDcrCE
         5MwwknQ6EvA5gQrKyrYLnW2RwdlIEQ9FN27PJTjlvelITZ55X1JHjyoQFJ+lfyEg0kt+
         cAAbvsKpwS/SbV2j2slJP1bqzg387SRO3nXpNA/El8Zzdqb2JGrVLyz7E5XjzPvlq0e5
         RKEuORyvjeqWOm7Hw+0e80c183Te/nnlJe+5uIVOR9ZpOsWc7HxJIcNIW9H5AzOMovkD
         CyEaudK8rxYXT6rB4/q8hF7eN7nVQfio4u4qOAlV+yqYc/YapmTFmx0NDgTRoWiul2MY
         DtTw==
X-Gm-Message-State: APuU4Z9pGNO1v5zcLZBoRZcJUvM27JWJ1DxWzCJvx4f+wiyWy2c9INRm
	wtyLfRHmvBuOY7Dav+KNa4TEKwggdVeEI/owzFPPxpBELyiZqavPrY/ejC43sbVeQjpyKk5f32s
	ZNNKC
X-Gm-Gg: AYBFou1+txjhhch9UM8HqWerTKVvFx44yupTe5i9J9BCUvZPenD8Dua5al8qkoDgx+5
	64DnWPcoJH6sNn5WPTsCOD421/BoAaCOtePE+klG98eS8fe8VMZ4/wtm/gr8WuQDgNOD8QLeC/b
	XA1HwTRMllazIkHRNeiBhJ2B//5wCVLYsNCYdCTTpFd8XqwEBIfYh2112te2+iRYJx9NWABeFdr
	DBOReV3YbsoJAfU2RFH3u8DmCG/zHa/1F0Qa29lS2PogTMN/HhjtA37raUO3ZsK9tOiSnV7j1V8
	jtG6t41DIWlvkfL8I7yeOIxI77vWzwabPW6Kb6CDW1L8NtkTGV0i7d9UBaWxSwZ333jMpDhqnmO
	4xSIsE8Ivs6gRAz36P4WODI7vxpsp8K/sjrry3Q9sZOk7i1UlaEh6qui/fU/QSaIqKtIQMQfwOr
	FGfNdQyiWopMaSjL0TWaj3tYjUfzcQZ0888MAN18+ybC2t1B9zRLOAM/MRk0YLy26u7iJXigCb3
	GqiA1siXkOeI+dOQoZOS8uHFqy8NX0LSCKlT9V9eWVytSv0HIMNON2JuNIXWrOjQvNOz2mgqW6q
	+uP84CWD4Gkz4H0jPwFDmQ==
X-Received: by 2002:a05:701b:42c6:10b0:1b3:ba92:145a with SMTP id a92af1059eb24-1b503171008mr12148711c88.19.1794851945449;
        Mon, 16 Nov 2026 09:59:05 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm39228776c88.5.2026.11.16.09.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:59:04 -0800 (PST)
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
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-7=2E3=2Ey=3A_=28build=29/tmp/kci/?=
 =?utf-8?q?linux/include/linux/mmap=5Flock=2Eh=3A604=3A25=3A_error=3A_?=
 =?utf-8?q?=E2=80=98struct_mm=5F=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 16 Nov 2026 17:59:04 -0000
Message-ID: <179485194441.205922.12481724883718062348@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-7.3.y:

---
/tmp/kci/linux/include/linux/mmap_lock.h:604:25: error: ‘struct mm_struct’ has no member named ‘mm_lock_seq’ in arch/riscv/kernel/asm-offsets.s (arch/riscv/kernel/asm-offsets.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
                 from /tmp/kci/linux/arch/riscv/kernel/asm-offsets.c:9:
/tmp/kci/linux/include/linux/mmap_lock.h: In function ‘vma_end_write_all’:
/tmp/kci/linux/include/linux/mmap_lock.h:604:25: error: ‘struct mm_struct’ has no member named ‘mm_lock_seq’
  604 |         if (unlikely(!mm->mm_lock_seq.sequence))
      |                         ^~
/tmp/kci/linux/include/linux/compiler.h:77:45: note: in definition of macro ‘unlikely’
   77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:692d4377bfb692ff787168227126528168bbc6cc
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  2a640ccd9d0b0927413e9778fa8970767b7d97d5

# Builds where the incident occurred:

## nommu_k210_defconfig on (riscv):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afb3cb999c74e1a99619260

#kernelci issue maestro:692d4377bfb692ff787168227126528168bbc6cc

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
