Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C74AA00E
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366896; cv=pass; b=tU0l4HuVHVA48P4PqAm0y7z/+qRpNQ/yqhdtGwB1TBTAFtB9DQobY4sClvBppVeQr+QVgO0PMugvigyiJ7wuzldVN6xAHkB6fQhOequrM3KvEZiz4ImXP1gNVakEVpDTGetKe7CTFOyyiIjbpqyO0Nc7LfIo05Ay9tpGiC+C8Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366896; c=relaxed/simple;
	bh=BfEmlkBKcWe2ccNduTBti/ySDv9Dy75blbe5/+Ct4XU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qJbMRAJVASvU47BwcBGSDUBRhYIggqeu2o/TGPldVwgfGUPzRMh33iroxucVL38YsgW/yIiUY/CHDjMg/kkJ86B6MjLTQtWWSEqdRj9ia1hspyEgF7bJmii6/IQ3UEYWFLCB2wXde/9gu0EYUGUuHQCcMp2vrC+rQOlP4OMbHlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cy8rpqnI; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy8rpqnI"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6acc74fef22so555713eaf.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 09:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788366893; cv=none;
        d=google.com; s=arc-20260327;
        b=pVWbEibSHWtvVwjKlU+kxlVLi1ByJBpXSKc7XL0MgQmMQdcXf8uLTqw+rR3htAH/8f
         xmoWasCkWyZdK9BkWHdPLWBCqMFBhJig4pB0Hj2hQMT1rKESi29B8fsiCyaf78lbWFnD
         1p5xhNqJRy4LZpmBhgm1WLuN2kNxPo02ks/LI3QOHJGrrCUArZlKUO/ZyYHpALZAxy35
         5j8JDYURf6Gc2vzoV0mEDc9vahVjeo0pa5GmVV9SeFRlkdOrJIZNxENwsFQHJ+gvqzbT
         19sRf9UkefeCjidWJ3QEGWosDqidTf8fU2x0uKzv6Jy7P4G3xmzRC8lctFvBD4ede4B5
         +Vtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=US9Ylb+9AiTeXprRTRZTmUqpRaQkuKyTcR67E8oUP7U=;
        fh=XocobJeE4p62zhC2bIG6aW5fIdN+uec73hjoHP8/txk=;
        b=Ys6Q+H8ywn8OCjkTEBLJWuk9z1Vd6Y5BIY6ZvlqDdvILGoAS/j+OrAlbkm4uDl90h6
         PHJO/4K3wkpS161c7YOKD3dU1PPopixywFPcWif6RBsnT5he8YZJthnIabQe/ht7a6+j
         uaFZn3uqYp8R4FrPiZJprvawiLkqTO0rt8/JPa9jywhrSKCjc6YQPqN5CxBanoXEkluc
         6wip1fUbdrZ6g6VaRUqp0TevjJdxPGCLUuOcwzWjjO2ET812EEkr5sTNTpVxDN32p59S
         512ZOSoxlaNi4meHivzyGojWGEpYeeN1kB7xFmm+WOpGy/+FM49fB1KylEtu48Nqj7Qv
         dlyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788366893; x=1788971693; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=US9Ylb+9AiTeXprRTRZTmUqpRaQkuKyTcR67E8oUP7U=;
        b=cy8rpqnIQ+2VJ4lINHfL74L8S9OhYhckBddCBaqsdhpu/+kTlXr66den4h5ZiYrqRK
         O3XzW5PpGUVUyWFyfZsMM/RJSCfGY9lQYqGfmPK/DSlWng1bvgd/BHYokxfippxaP1Xs
         KL7HwhjyX/MXM06hhaP8AZ+355XS/jiwX3O2/T/ZzENfb/wIfsxUqD8IB4ysOhfXkipM
         8sIXG415I79dE5eeoR05szl6VbYlm/cmHyribtNuQIQqh8ZoDWDzn6RSr/6554v3qkuV
         J2mi6c3jSFIJtrV2qf6HI9Q8Pe/2qNl14r4Pu70ISL3ZVjIKLe0z0uO7Fbx6YTQxy1W5
         iQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366893; x=1788971693;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=US9Ylb+9AiTeXprRTRZTmUqpRaQkuKyTcR67E8oUP7U=;
        b=Ok7IaD96608bKgdzpoMiak/ssBlz3uxiNQB6cUO2WEiBF5cYv1MGi/ApnxeNHfqnSL
         NQDee/AyyYZRAf5MYqcsxtMcAYj0pxtz6Pw/b6UulOUzwzV8oknp49bM4scGReU4Pv4f
         bAJlXZLOvWYuLvpmhcvjmDXJs+cr1URT6gSRWt/Fm8N9SxD0bgunANYcv1gv9jfvV3Vg
         yxU0KKEQSpwqG/yRvwgN428sGg7PtlqC9bhiqDe2MbFA4b4ocWvzRqT5CYKYh2I38rEG
         g4OMD0oJSyzC2Rshbmmg47tocKeIVta+8groMSAuWoe3AfffkdL1cUajC0p+OYBpevT6
         VvmA==
X-Gm-Message-State: AFuF++mwxMxn0OTYZyI/vOykuTrcrEk4P07/hVr4hK1szr4U4tgpFdAm
	Ypu0hnGXmLFKt4U7SmAfkIsyo09dN3DYOC3Oxj1q92KOQglbZGkvLHnsLko6LDYmlW6xaYP4Wu3
	wQAAk8/i+BLTvxL252Ugkd4ucZg7wzoE=
X-Gm-Gg: AR+sD1163r6nlmduARMuGNm1DZTkdD3qWpzLPKmoffxQ19TkwAZNpPl65xTXXZxHdZB
	Bhba94UuZsWMRlkb5mBE8q9EIoTXr3BMGtDinwGAtzKNI+do9N20/nByWEzc9qiP6gbkPUu/Grw
	+IzLonCpRyK3Er5rlaH9fnaz1FsR878RQ7hCj3fD2ixASkRKEFx0KaqTvtxln411CPAS3b6YJDy
	v9bCG74IZVImfrAicQ1yag57ku2uj/mZoF5LUhRo2htbuh0wpQGtKkhfQ48chLukak+hQq5HMJy
	GheapLlcdrCXQPoPbQLzFDeCmNBgHULZICDWhiCLYtsezKjhOguaKD4xhWT6JfkvJeZVCgbM3/l
	IQdhc6cyL8x+jjZ4+S7zAsUF05d98GmFOHGaswLUyOIkeOtoXIn36JcagBontfEE/RK4AIJqSB+
	WQqxvK9zJu7jAryWp5VZaXxWQJYbncijLAQZX/NrU1
X-Received: by 2002:a05:6820:16a9:b0:6b1:445d:aaf9 with SMTP id
 006d021491bc7-6b47d4cd775mr4034068eaf.8.1788366893040; Wed, 02 Sep 2026
 09:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrew Wilson <wizlonex@gmail.com>
Date: Wed, 2 Sep 2026 12:34:41 -0400
X-Gm-Features: AcwNN1WhXm-Lt1F0X-OQuMqxjgk1a3bMvVoyZLhgjbgALurTS0LPjsCCof-Lok4
Message-ID: <CALAyJWrn7OQyQMd5OPoifn_3qe6iWNf1+xSSg_six-+po9kpvQ@mail.gmail.com>
Subject: [REGRESSION] [6.12.y] crypto: ccp - Move SEV/SNP Platform
 initialization to KVM breaks SEV-ES VM launch
To: ashish.kalra@amd.com, seanjc@google.com, aik@amd.com, 
	herbert@gondor.apana.org.au
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	thomas.lendacky@amd.com, john.allen@amd.com, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	1145026@bugs.debian.org
Content-Type: text/plain; charset="UTF-8"

#regzbot introduced: 3f8f0133a5fc9b32d0c308530320c3f2430ba5ab

Hi all,

I am writing to report a regression affecting AMD SEV-ES VM launches
on the 6.12 stable branch (first noticed in 6.12.97+ / 6.12.101).

I completed a git bisect between working and failing kernels, which pointed to:

Commit: bb1c84647025 ("crypto: ccp - Move SEV/SNP Platform
initialization to KVM")
Upstream commit: 3f8f0133a5fc9b32d0c308530320c3f2430ba5ab

### Bisect & Verification Details:
* Last Known Working: 8a599f4f74d4
* First Broken Commit: bb1c84647025
* Tested on 6.12.101: Cleanly reverting bb1c84647025 immediately
resolves the issue and allows SEV-ES guests to boot normally.

### Failure Description:
With commit bb1c84647025 applied, `sev_platform_init(&args)` is
removed from `sev_pci_init()`, assuming KVM handles on-demand
initialization.

On bare metal, the PSP firmware appears to remain uninitialized (does
not reach SEV_STATE_INIT at probe time). When QEMU initializes KVM and
queries host SEV-ES capabilities, the ioctl fails with -EPERM:

  qemu-system-x86_64: -accel kvm: sev_common_kvm_init: guest policy
requires SEV-ES, but host SEV-ES support unavailable
  qemu-system-x86_64: -accel kvm: failed to initialize kvm: Operation
not permitted

### Hardware & Environment:
* Tested on: AMD EPYC (Rome / Milan) Supermicro platforms
* Kernel: Linux 6.12.101
* Hypervisor: QEMU / KVM

I have access to Naples, Rome, and Milan test hardware and am happy to
test any patches, provide dmesg traces, or assist with debugging.  I
am not a tech-expert of any kind, but I have time to do some testing
if it helps.  THANK YOU for the great work.

Original Debian bug reference:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1145026

Thanks,
Andrew Wilson
