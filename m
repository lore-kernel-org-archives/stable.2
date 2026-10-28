Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210350;
	b=f+/Ndw64XJu5Nah0cCRJTdKNO3FjK/1ypG7nIWG9b7Qd+CRN5QLDhpjInAn0diYUBZ+t
	 LST3OQlz71h279UXuK+pYP6Nm9OqMoxe0QUSWnPKfjhUekwo5mWVTwFIxm8p9TUChZPsm
	 s2xeSlrXf+TgmfrGYfH0ZlbU+aqbqHnyYMcfwm2aDTNVeAuCHKHcrOgj3eg691ICLQ5Dd
	 6lvTcT9eUgq2rxOfh5eOi+gqlLqKAaQRrFeotZCZftkIP1bwlFzyOtfb4ETFyt8q91BQQ
	 pOC3XOMPJdYTnh/p6GYlfF2696kovkIZh6+EteriGTAC199czivSR7EcaSbAJCW72dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=WSkGX42WfGdX69olvoEpu3biG1g+lIj/Jeu9pF+3lmo=;
	b=zf1ISVFxEl7WSXTNuy2tSbV1Bg/SthLInGvA1C/OY0WJmT21epbOOoW9GNm6MHAbJhyg
	 Q4ZbA2qcfTEVqGllrL7DF5XQQddGkuX5mRAcmqiyJNjueBk7DUhVT9fMUtGrDccQE5M70
	 kjnbwN2U3bebpdYkYp63itHL+9DpvevC17lq5L6YRH+vVfMJ4Sp8PgaUFXNjRR17f3U6Y
	 l7Z9Viryj0tsvVCRqMvkREOqJrGQLq4+CPIp43mcKTWzFi8MEfU7CbrEk6Yk5wsp5EreM
	 8isCTjo9LivZ8LNTfLF9x40Zz+MWxwuBgi57nXsamiaqoxeQA9pM015Rj3Mjq+gPstA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=WD0ossUf;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E929606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E929606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=WD0ossUf
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-14394530ec6so1477007c88.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793210349; x=1793815149; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WSkGX42WfGdX69olvoEpu3biG1g+lIj/Jeu9pF+3lmo=;
        b=WD0ossUfupL6jDfF/pC7QSfFYpDWIa98B23X/vG9DsWgAA8A1txtDAR8GpEUPBjaQO
         aSe6LyO7jolpIFSSMlU2w0L1rnC27srklGso0fq1sQ2w+NTjQM0sP/cB4bRpupbMTTtD
         0A09miuFDvzx2VyrUtgT6c/ied1F04dA/G1JmUuZ1EP4XOzAqGZzlgk4rnrmliYHTobK
         hp34/PiRwcgg6jmnYIMFdwBWLJs9zOeoqQDnfv3SzxIyAXg9MWL9Oxsc2JnImakvnSdI
         v0rlUUNFBqh2FW0CL1/162LctTtpnK5Pe3lpqIS4MlFj0gbVeHL8yQ7OGA6jdza1c+C6
         CsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793210349; x=1793815149;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WSkGX42WfGdX69olvoEpu3biG1g+lIj/Jeu9pF+3lmo=;
        b=FfIn904zwpZT3zc4zNOOk21o3vaOwBDPCJP1E46KnZUVS/nWhClM2pqJPhtD3svoYR
         7/4SgxuCExA8AnaIK067IHBCNuYXeGCfQTktsx3980JUItthMMRcse/JY5qxE2P5iT63
         eI228aFDpaQIN4RfyQr7uCOO1DlMXmmvGzVdXxG3upWLwCsE5ZW6l87pwLdRcRNvbSVT
         /P2QiFvoKJaLmS+PH1csLRKBvetsJrmjtGiRFlwF+DbyMGeJ5oX2RVllHnWnH2T6wS06
         GvjKnd9UShA9QWw1KDdsC2X4qh4JkqNa6XtY38EpU7YcB6GVmIpngkSSx2zOnXApIhxh
         ajxg==
X-Gm-Message-State: AFq9FYK3KmgQadAegqWHJHa/W3D8LdMtUzY8ieN6tGBO5uE1q8g7MsHZ
	al3flRlqRGyeFCPvUFkTsdB7PL8y/am7hiXikrktW7Ng3Bffu+DlO3RoIGH3RRsk1Ds=
X-Gm-Gg: AYBFou0+JDyBVZ2xP5YfcYCmfxNniLnTfEWqeKG6l07sDUJkf7CKYvoNX21G6AYHeJn
	s5TyCrsdobL8nyq1iRR33kIt9joWyXBg17gFQin9ywmvWN8hUm7+8Qi8NuSadkHZFGetdC8rJIe
	gTwujq7aJIHiEjOpK+oeaYbUjFmyzIYlwY1SeDS7+y8jflOgFpBJPCcePQkhc31beaBonzZ5fKh
	6DMJ3yp9btFQrJ2CYTbHjZBw//xO4mF+OLDMeXDSw/HqWTKz6W8GjRdK6tdywt+J3ou1bFTfQCN
	sKX88G7QC/IfDQ0y16hJNw/63508zK0yQkQZ1Ar1atN5v8A5viSYfbnp3YhUnBHlY2ac8iB8lXT
	+ogXG3ii3NhjbyIlPmzYSMlT4847LBV+Xd3UYUpSggBNTA5hc29V2nH/hrKp9tr6+BHnTAz3Cr1
	9L534FxE6ByZMOd3WcvbCWrsxhekWRgORdnQ709KpRciLrb/4SWQLI5+Va8dWZ+902Q1Zuua+s7
	U2mTyJN0fh8bMYNHPklcOGpiJYLh0f4LXLhO0nmVnebiYU8Ygid7HY/NfPE2wHmYRfzKAsPNN+p
	IOVDf+kOvms4bnqFmtxm7kc=
X-Received: by 2002:a05:701b:4302:b0:1a4:4194:fc04 with SMTP id a92af1059eb24-1a6d0d4dc27mr3977885c88.28.1793210348926;
        Wed, 28 Oct 2026 10:59:08 -0700 (PDT)
Received: from 4cb1f8191411 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75d85f23dsm6060326c88.11.2026.10.28.10.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:59:08 -0700 (PDT)
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
Subject: [REGRESSION] stable-rc/linux-6.1.y:
 (build)./include/linux/highmem.h:427:21:
 error: implicit declaration of fu...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Oct 2026 17:59:08 -0000
Message-ID: <179321034779.43309.2420164541440725034@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
./include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration] in arch/mips/kernel/asm-offsets.s (arch/mips/kernel/asm-offsets.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
                 from arch/mips/kernel/asm-offsets.c:19:
./include/linux/highmem.h: In function ‘memcpy_from_folio’:
./include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^~~~~~~~~~~~~~~~~~
      |                     folio_test_hugetlb

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:2f28b78cc7e9ab65aab395a4b33d537d560b09cc
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  406de00ce2971abe3010eaabc26c71e84b4ee9b3

# Builds where the incident occurred:

## 32r2el_defconfig on (mips):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-mips-32r2el_defconfig-6ae228c35c0836a8c2f04c07/.config
- dashboard: https://d.kernelci.org/build/maestro:6ae228c35c0836a8c2f04c07

#kernelci issue maestro:2f28b78cc7e9ab65aab395a4b33d537d560b09cc

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
