Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618750;
	b=lUxOvotKFu9ofCayOtZS4MALJRKgVRt3fwpn96I30Tk5ragJXP66qJHzHrWhegSlEBNm
	 SnC6aYvBpY75kuxKsYHEFbiXyOUsUqdpLuNhgizW5PgT42GApeWSj0zIu78kQMt4+K/Q5
	 lTPmSFlB7LLQntbxUKTlnZWqDHmnyrYYLQx8OUk+0Fl9WvKKqjZgi6gDjpsr+M2W9k6ck
	 PDOUnr3AQjcn2cAOKUNMfbpG31jMdxzk3+EkH47t2pQHxcTMZ5WcMMJmeohJ5bdTMoGVk
	 sS5DQ/2D0kKotq7ixog9aqxqA8DJ1jwN0bHJp4iNFRQD457JWC2EkI5IY5P1ASSayIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=qfoYmtNvqYs4tK+rA2hSIfkhdv57G+cAGPgZLK2sRXY=;
	b=0CHb5IbYNq3+9yyvaMvyqGA9whRWXoaScZ6ryNLCHOIs5th3NnbDnAGsgud7HecROyf/
	 US+LSiLWrBeOQsGCDO3Fzo8Mq4tQpjQetyD2y257P93K+lhvQdi8szIGLxJ/1Yz70XPr8
	 ZM1Jh4oGsZZF4o2Oqim/X5AZBS+yM0Mlm7eWKC+pKgdyNj+VsfTmMMibpRNMvk9E7emJ/
	 4amHK1QfzZy4Ur72HsPd1aJtq2R7h0xsM7A60KwZR5jjD88vyNGFPQ04dbHhRaHu2bsoR
	 mT0OHRzjMEiEkfd6czSwkp6BQi6obaHYe+9dHVEeT0lnxWutKrUJi9h8Xo0XhjytGBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=RouzlfWK;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37B9606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C37B9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=RouzlfWK
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-38699cf08dfso6944911eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795618749; x=1796223549; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qfoYmtNvqYs4tK+rA2hSIfkhdv57G+cAGPgZLK2sRXY=;
        b=RouzlfWKE896Hfkvmj78XRFX3E4QEPqp1T07KC/GNALnUkHvdaI5w1vT9BPxdHuJDx
         kIsrskS8j8waFiIagv1W/hq7jrj3FeHgnBl/HCDPhow2EP5XI+P64hz+aL06iVsf7X5q
         zlymn248qOFB8NxrCpHRYoVbIF7Mc1uAkN7GVfiAeKgo15NNPKCEfHx5YaJBla+ZsaL7
         oZAHAKddc9g8qFEYaLwpoeBpFImcq3OCG2AHlyOLuuiXRqCpruTVsCkRH7mkS0Ibo/nZ
         2f+SqHDTWFhdtZP0pHQwyyHriY5+PO/5i9C+3sSEUR+gVLw8Qq6FlOK1GBFdpT5687c9
         zqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618749; x=1796223549;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qfoYmtNvqYs4tK+rA2hSIfkhdv57G+cAGPgZLK2sRXY=;
        b=gFWTKt49p5F7ah4peYqgqIYAVs8PnNaJhBUaI22yHiD6mEbGIhOd3gsJaNLxHnb/OI
         QXXySfSfQ8Iwonph9mpbhzQpaFBur9/y3IAxb07mQgRpVCm+g4RmQMvu7Bgi0HQZ6Bpa
         D/QbEUgcx9oCuU50si7pdD9Ne8ZMTubb59krz1KKzpHbZS3ldhvyM9ftxbdflG3vng3w
         1uJSM38IEjBDfdKxjbQT9hxyMKQaKTze45qgvmIevMT12InEVQ+Ng9pVINRH4UF4gezP
         4dW2DR+cEvhgTD0rwQA+vAE+tFQ69QG7rLYK9ITiIBnRAOgYb9l4jVVHSSdLsc8lZONG
         mZwg==
X-Gm-Message-State: APuU4Z+EsiQuSDAeESwOQ0Wjexo2OMjR+2+zzTknhicH+6/EAOM5ZTXS
	lfUy1eL9r8RjgtSX2fNVAdHAAdw0ObHUPED6eUnKBh4SpY4ONdDmJK3SSbgFOLFS1dc=
X-Gm-Gg: AZFdTZehepTMPe8KDKFSAYoCv/dgT9RQgjqKjAr7QiPLZMXwX80KaD/CuTh2KnLfd83
	xf8CvuT+k5r9HubueEkgRm5Lx66fVdDRUtklI6Vb9ObqTE5ikPZsJGYWz0WWNd7gNSwha0hJmcW
	NdiDFQOnDip+aM4lIq7gKKPRmuB9TGq0Y8rPNH7DIaQHlx8xW4rPQPHAHDJm6okqD+pNVbeGKop
	JNXvmOiMueIA6tYDYoPq6FPPtIqunhfZ/RsL2s1le+zUHBo5eMuX2Pqk/qYxal0m2UuVnZSpS/6
	/WW5HPBIHZUouEuQaxnKdT41Osyd7jf4OGTF2E1P9SWSRcMnZEfTfmZxaaADb8nK8JiCHU+yfXB
	61ezDCMdi1KiqsIXpakbSxYH+CCN5IrIAb9c//KFIetpRF6nVxAKDe7Hd/mmUrp0qc86OkOqCnf
	zuouU/IUBDthh2KE9hsBXtoWsCBf9Hi+pKlyPVdizNJCkbVyoFJqQfp7DiEwz7UzMAoOQ/eMZRr
	FEclCJdpxrPStVIM9SrSjzvnE+2jhmeOq2A2yqllHxo6HhqqTHAMM3/JtutIqwuR4EtHSPpU1Kt
	85u44YkDC1znSWhtR1rnDJ9XtZWv7CtElT2iFCrPO4s=
X-Received: by 2002:a05:7300:1909:b0:383:f646:9feb with SMTP id 5a478bee46e88-3856c4b8304mr27391041eec.2.1795618748644;
        Wed, 25 Nov 2026 06:59:08 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm62347612eec.26.2026.11.25.06.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:08 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-7.3.y:
 (build)/tmp/kci/linux/kernel/sched/ext/ext.c:4223:17: error: implicit decl...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 14:59:07 -0000
Message-ID: <179561874757.101431.2104085708555126408@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-7.3.y:

---
/tmp/kci/linux/kernel/sched/ext/ext.c:4223:17: error: implicit declaration of function ‘scx_reset_task_fields’; did you mean ‘scx_set_task_sched’? [-Wimplicit-function-declaration] in kernel/sched/build_policy.o (kernel/sched/build_policy.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
In file included from /tmp/kci/linux/kernel/sched/build_policy.c:71:
/tmp/kci/linux/kernel/sched/ext/ext.c: In function ‘__scx_disable_and_exit_task’:
/tmp/kci/linux/kernel/sched/ext/ext.c:4223:17: error: implicit declaration of function ‘scx_reset_task_fields’; did you mean ‘scx_set_task_sched’? [-Wimplicit-function-declaration]
 4223 |                 scx_reset_task_fields(task_rq(p), p);
      |                 ^~~~~~~~~~~~~~~~~~~~~
      |                 scx_set_task_sched
/tmp/kci/linux/kernel/sched/ext/ext.c: In function ‘scx_bpf_dsq_reenq_task’:
/tmp/kci/linux/kernel/sched/ext/ext.c:10432:20: error: implicit declaration of function ‘kf_switch_rq_lock’; did you mean ‘switch_rq_lock’? [-Wimplicit-function-declaration]
10432 |         entry_rq = kf_switch_rq_lock(src_rq, &flags);
      |                    ^~~~~~~~~~~~~~~~~
      |                    switch_rq_lock
/tmp/kci/linux/kernel/sched/ext/ext.c:10432:18: error: assignment to ‘struct rq *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
10432 |         entry_rq = kf_switch_rq_lock(src_rq, &flags);
      |                  ^
/tmp/kci/linux/kernel/sched/ext/ext.c:10450:9: error: implicit declaration of function ‘kf_restore_rq_lock’ [-Wimplicit-function-declaration]
10450 |         kf_restore_rq_lock(src_rq, entry_rq, flags);
      |         ^~~~~~~~~~~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:936230b9eb1a669c510f4d2d33d1c33403dd8276
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  15fae5bad807ac3cbe5fa7319a897a72db112bd7

# Builds where the incident occurred:

## allnoconfig+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f3cc286e1965ecb3b104

#kernelci issue maestro:936230b9eb1a669c510f4d2d33d1c33403dd8276

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
