Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618760;
	b=k38E//jh18GGw0x+G3wwfv47b0KrgFpkAyOvZK2STm80CcRc6rqfPiRPNXYNfD7ZePnL
	 dGeTIzWvJhHefFnlrfApcBSXoLMPFhQiPjnBNYya4+mlB+lc31HZMwTj/eIQQtxjXdT9d
	 yGpnYdXvEC0rJ5eEwmG4Q4lNfSxBPH98XG9j2wDQVCkd/CC/TRbbPOjkQLTZSfKIl8aqG
	 Fc1/K2So69csl19IGuBkvdpXd1082qS1yei49mKjob32aDnU+5QhiZWmGwawm5Tf8Bjuo
	 8rLvuYltX87ql8fP9+I/xRSBBJqHGHHA/9AxqJnn79hos2qKyHDE495QiUF/g7Pe3PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=eSWlAceo++fC2UCywahcqtoTHl0T7MtiewPG0FiHyOM=;
	b=KbX9UdDPcdWFVatwm4YHxX6RmeaP9Q6h8DoA2k80sM2K2aRQAKU+u9WOlR9KKw9UAM+h
	 Bhv6I/K/oKvzh2lMRzN+x+yhSQo8F0MqLi2/lm8bMRyEhB0/q+YHjpDiO++43cXR4WJxP
	 dTFmpHCk4kslpl+ahkPzeDxX09dfR10wCH65C8wiZSepwbGQ3/3KlqXDGMHf6IU00ilnE
	 X5fjFI6kB3ipA+UDeRyYVNbYroKqRvvqARBCxit+RwBwfCq9jv9qe5OPAjDyYHlvO/apR
	 +CtMeFnlte3m8Fpl9YY5UY6WUTqOKcMxWaQbQaXingQDTpWlV0Dv6d2lVEevqoC1Rag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=ZX6zKXCY;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F32606A32D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8F32606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=ZX6zKXCY
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3863db981d4so8199233eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795618759; x=1796223559; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eSWlAceo++fC2UCywahcqtoTHl0T7MtiewPG0FiHyOM=;
        b=ZX6zKXCYx83YQ6g3qmzuwKA42qkioRiIQzNvgl0JGNaFpr3K+AaKNbAo+uYzKB1K7Q
         yTHNRpzKeVOVPq73t9zEPDtORDa9dbgoWizhHsQkeguWQRQDtwEbdy15MzpdFY9qB54l
         L6c4lxkQOTi+lN6OVml/huVtP4Tl0ch38x/yxyX4sKBlcODki7ChLImwWO2BxEAaL5gE
         3X+Hala+obIVZfbAZcMUU0dXfKkGhADwazNrRid62Q/DSCn6fv8edVHhi0N4MoSHgbm/
         8GNkqqNVyvhDQvEtjgGrDl6NGa0jCELODHhukMB23i1HQfcPV+B1caU73gdDPqYp0obb
         iIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618759; x=1796223559;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eSWlAceo++fC2UCywahcqtoTHl0T7MtiewPG0FiHyOM=;
        b=RHbScyHZuVfQMEj+GMw9/qEc6OixfnFWeaAHI2m6EivFD7HtZ0sAdbQgpMtbC3vKHO
         2uqz9KZ3aGcB3xJLRLoiIWRAT+PRSXwD7Wdj/kfd3YZuiwH+oSkG+9kf6iXm61Cwe3A1
         xUm6Tc8CTRydKQNKf7TQxSezqpM0YoOr3rw3WL/6F3mLkxn4Sv8ZtSANxQghSRDwckqJ
         gZm46gSKM6OzEK2VVH2QSqSdyTKOQJGsSPT5vdhW/YeValWtbiSlGwviBCCXdeHew5ky
         PTRxUxQC8cy26eOH9wodXI0nH70ZVVAieAP9mJh+mugWcGmPnoVqJrGyXifpwglbIdhq
         34nQ==
X-Gm-Message-State: APuU4Z/qI5TtsAixUhZ75r4ug9sD/n8lYCYIbSNSxcnRAikfdXr6CK76
	AicLay4DqLPRSm73M3R/v4VhPFLZLrpCfmHLHxpH4gwSK9arvF5OQivYjGKNYGgqPI6K1wqF4Rz
	j0Dfa
X-Gm-Gg: AZFdTZcfkowT7XijTAuEpblpwkSMeyKqm5m0g5XwdwENdG6G57YnKYpHvliFSZUtd2l
	Da3oByfwhDaMovQee/JY9BPn+pUy9nhEOEvsV1TBsoG1s7tu5qFp1u8n3DXb7umL19NR5H4dM1L
	gzvaWo5+QZEOBr84cGamaMcoTABR2G9ZUgqv1C4pbBqUUXKZcbL8nZhqo1douH5kyeQJq/YwK8o
	c6+xmX9yyV02egFUfXYwpaYx4Id77OZ30EC/uolzsG0XzUla9tGqh3hn2I5ne3bCbymoR9iuRMj
	3N7YIs4HA0CRPWBRFTbRs5P8z6ry/eZpfmOm3rcAaXB3bJk/ZxbcwHoiS/jZzZ7sabBgGGiH2fn
	qFRYJue0YzpadLviZj92ziHeWALzM2kqUP4ieMt20/IJhDR540X5TPojkOjLRiazl6VWs+sQGUK
	8wg+8EgudjNf2O15X6W3qg4hickyHPFzUEDR1NxoK/6YrpekgFoTQhBN9sDklZJLIrY1xhtrb75
	kUr0vGnUXch4Rlx4ZMM5rGFHw3quA8XhJE1WjurCe8o0O5S25jKrPMXlA0x5g4ruJblA9ZSgI9o
	gCB3EHGfZeVe1seMHGx5sg==
X-Received: by 2002:a05:7301:d81c:b0:386:b7d2:a279 with SMTP id 5a478bee46e88-386b7d2aba6mr7873273eec.34.1795618758784;
        Wed, 25 Nov 2026 06:59:18 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm97882557eec.3.2026.11.25.06.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:18 -0800 (PST)
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
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E6=2Ey=3A_=28build=29variable_?=
 =?utf-8?q?=E2=80=98cbnl=E2=80=99_has_initializer_but_incomplete_type_in_fs/?=
 =?utf-8?q?nfs/nfs4p=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 14:59:18 -0000
Message-ID: <179561875783.101431.18184321733378410507@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.6.y:

---
variable ‘cbnl’ has initializer but incomplete type in fs/nfs/nfs4proc.o (fs/nfs/nfs4proc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/fs/nfs/nfs4proc.c:7108:24: error: variable ‘cbnl’ has initializer but incomplete type
 7108 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                        ^~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/fs/nfs/nfs4proc.c:7108:54: error: ‘struct cb_notify_lock_args’ has no member named ‘cbnl_valid’
 7108 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                                      ^~~~~~~~~~
/tmp/kci/linux/fs/nfs/nfs4proc.c:7108:67: error: excess elements in struct initializer [-Werror]
 7108 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                                                   ^~~~~
/tmp/kci/linux/fs/nfs/nfs4proc.c:7108:67: note: (near initialization for ‘cbnl’)
/tmp/kci/linux/fs/nfs/nfs4proc.c:7108:44: error: storage size of ‘cbnl’ isn’t known
 7108 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^~~~
/tmp/kci/linux/fs/nfs/nfs4proc.c:7112:33: error: ‘struct nfs_client’ has no member named ‘cl_lock_waitq’; did you mean ‘cl_rpcwaitq’?
 7112 |                 __wake_up(&clp->cl_lock_waitq, TASK_NORMAL, 0, &cbnl);
      |                                 ^~~~~~~~~~~~~
      |                                 cl_rpcwaitq
/tmp/kci/linux/fs/nfs/nfs4proc.c:7108:44: error: unused variable ‘cbnl’ [-Werror=unused-variable]
 7108 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^~~~
cc1: all warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:20281a672da98ffc027fd493c9b3c4151dc58b0f
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  85b40f175cb821478d26f4304e9ae2f574441f49

# Builds where the incident occurred:

## i386_defconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-6b06f0f6286e1965ecb39288/.config
- dashboard: https://d.kernelci.org/build/maestro:6b06f0f6286e1965ecb39288

## i386_defconfig+kselftest on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-kselftest-6b06f107286e1965ecb3929d/.config
- dashboard: https://d.kernelci.org/build/maestro:6b06f107286e1965ecb3929d

## x86_64_defconfig+aws-ec2+aws-ec2-arch-x86_64 on (x86_64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f133286e1965ecb39453

#kernelci issue maestro:20281a672da98ffc027fd493c9b3c4151dc58b0f

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
