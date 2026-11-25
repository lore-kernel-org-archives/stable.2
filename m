Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622346;
	b=CdHsm99Uwa0gmRTFqM9EkPCQnjJStpoeJ46jtF2PeXEPCiri3SFtvY3HMtCRA/bfv3Eo
	 Ru08/NAiqswmYkveMzpXatCEwW3+BFvJUf5vF2UQlaIsc4rgc20sHbwnkYwp9D5EJwilT
	 thJ+45J3NlNK2vk1v+tZ2/uPTCfGwKEgxTGs7FN+TTU5oEeI3erzNKLunkrLcT3QsokWC
	 vWV1bAwUf3dJc0PJzbEN7zNf8aJ8qiiZqd0sEEwi4qRjOKt3CKkT8vIUE5iX7UR7l5KO3
	 I9u3jU0srSvViYO1bR7QF4lNqJf38SMdrt/O83sH49kv30ZD0P2rEjhXiO1nzdTabdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=XKTfj8rrvHM63+JZuSfn+eZUyZAKKYMU4swDNmv/7v4=;
	b=LDzO9cid33yDSE8uaKCKZhOwv+IWUIWMCDDiMesOL29fwwM6SmCrEzIO4Dq/dZJ6O3WT
	 9Ir7j4FqVo2nhMxhKJKiJMPslQyDuyNO+6mCC5DNXuqWce7UmKFIp3Dd+d1IwiIxuJ/59
	 x3WIDEyx+TvBQmj8tQVMLA3DfMOtJVu4cNxL2wg/hX9yZJOEOXiA3RtusIzXMeOHYUD6Y
	 YziMl+I0sNI0oO8mudOgSmpCPjqEzqstEPmWUsd/ZCS0/H/h70wq7Tr/QfphC/AQbbOzx
	 0yeiE2kwsER1I1HSlpZSlfHQa1ZQzUhi+0DSoHj9WQKjbK/stOVgb5/lOz8ckqfFEow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b="BA2LUFs/";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE94606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EE94606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=BA2LUFs/
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-385c497bf94so3107336eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795622345; x=1796227145; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XKTfj8rrvHM63+JZuSfn+eZUyZAKKYMU4swDNmv/7v4=;
        b=BA2LUFs/djPslX1ZIFgUPVDRWmVqQOxbY878BLSsl0NEJUManKtHyVEWuQkmNlrIyX
         X6otUK00WQ6dMbDOZvJmBa8k06O48mNVt6AG6iz3hV5iB9pxWBePAZvOjZw7w4ExOHOa
         I1Y428w8PL0WIj81zXOnl8dss0+009gpZyOkXCNtcykEBCuqZ0NfnoFoJGwhmFwMPE7e
         PH9mCQ7c9G4Gb2AD+zZQ/WBglILkK+Yev5toB6GvBYMgA1REMAbpcVFaWf5NHM8jfv6J
         h3vkKgnFgaCVfT2K8WbkaWPH/htSpvSJ0lNNuuJeqDNVnIGmAr6DMUF67nOcl1OjG1zC
         dyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795622345; x=1796227145;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKTfj8rrvHM63+JZuSfn+eZUyZAKKYMU4swDNmv/7v4=;
        b=KheoJIzt9MVeharcIhm4nY072EOV0vqv23tCkZl1IE0rtbd6kSJKSGpOK5oAsYEWdp
         8Jdliq5+7QnXK+dHYPwQotZOSkoN31SjcBPRgRhzIY3MWXnYq8s/h64Ek+HlQV07pCyv
         nNtPHIar1ndlBlIfuWoOyC7ISRGXVo3//gf5RIQ7Oce0gZcQYHWE4kvvtq+5r2pyI+ix
         lSdSs6CQAoJcgMfdOivAbHBp9WZFnk2qZ2lUedRV3b7nxGvtBKiRA9CJgwojHU/bmrf3
         C/cLGRMjlxxQqNU/Utz3/uGzhyc6NkyxD/v1q51cH5wtmfw/siFXPQJel7aCoWliQA3s
         Tujg==
X-Gm-Message-State: APuU4Z9kUgEGpEKsgG6h0gQ+CVHsZGZNpCQ7TkIb/B5MSqD23j2EIfj/
	2XViAvmkeY2HOZWGjAJUX7dC89K2OmArmZtNvi7xqjNyW6/xtzsrhQJgXvweV8N5SYrILfN/VbQ
	PRqql
X-Gm-Gg: AZFdTZfztc6UW5gXUbpJKrvd6ar97+ShGTJyn6jP8oeAj+YhwVBSWvYP9gyZ+/oDkoi
	MR87Stbt2ja4PQImLli5/OznJNvWhM8Mhf2r+gkWy5DjlOh/SbwaREqrRNMkJL6JYE+2XNFZ/FW
	/l5au9McndsvH3kx52+RiyNrzmSPZxd8J3B2at+CKi7rOji9c1ognsIcpi/M+GjycCI2qfFp6hO
	HXR9j+0A3AdzoHTISIt6Wj6Zi/25XW1dG8zXD47sH+AMHgSDLW1m2VFjOMp+Fy0yThflPjBOcbZ
	I6ELwPGfJVr0Xa3SJ+RyryiVNpsArIUXyp00WMO4gGV9aw7j4nWOLT4qhfv6VqabrOCila3ODal
	chfiV19e9hl+JHHjkTeB5YD+10D4IPG2RTIS8EYQsJdNOfXqyqYK9cPPWqVU5dn4iOZa9btefQn
	QVnHuplmUWlNyAiApVxZ4uMJhhXHVJ7yODnLThQ46pnrHfpur2ELCgA6sF0nqzACNsXncT0fhdI
	VHZDO2e9dhT8mW9mrNck263FpuM71llFpCjm0W0YZOdLdK1fxwyO0GFIIysU9cgIaBPx1fX0+FQ
	FZ/bz+kt29dta+ukVyi4hw==
X-Received: by 2002:a05:7301:fd06:b0:369:f05d:6c5c with SMTP id 5a478bee46e88-3856f549471mr18626000eec.28.1795622344554;
        Wed, 25 Nov 2026 07:59:04 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm62518369eec.26.2026.11.25.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:59:04 -0800 (PST)
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
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-7.3.y:
 (build)/tmp/kci/linux/kernel/sched/ext/ext.c:10432:13: error: call to unde...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 15:59:04 -0000
Message-ID: <179562234371.103722.8784217523902735616@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-7.3.y:

---
/tmp/kci/linux/kernel/sched/ext/ext.c:10432:13: error: call to undeclared function 'kf_switch_rq_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in kernel/sched/build_policy.o (kernel/sched/build_policy.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
In file included from /tmp/kci/linux/kernel/sched/build_policy.c:71:
/tmp/kci/linux/kernel/sched/ext/ext.c:10432:13: error: call to undeclared function 'kf_switch_rq_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 10432 |         entry_rq = kf_switch_rq_lock(src_rq, &flags);
       |                    ^
/tmp/kci/linux/kernel/sched/ext/ext.c:10432:13: note: did you mean 'switch_rq_lock'?
/tmp/kci/linux/kernel/sched/ext/ext.c:430:13: note: 'switch_rq_lock' declared here
  430 | static void switch_rq_lock(struct rq *from, struct rq *to)
      |             ^
/tmp/kci/linux/kernel/sched/ext/ext.c:10432:11: error: incompatible integer to pointer conversion assigning to 'struct rq *' from 'int' [-Wint-conversion]
 10432 |         entry_rq = kf_switch_rq_lock(src_rq, &flags);
       |                  ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/kernel/sched/ext/ext.c:10450:2: error: call to undeclared function 'kf_restore_rq_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 10450 |         kf_restore_rq_lock(src_rq, entry_rq, flags);
       |         ^
4 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:5b691d641098271a2e8cf3da1e29e6a2b37ae280
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  15fae5bad807ac3cbe5fa7319a897a72db112bd7

# Builds where the incident occurred:

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f324286e1965ecb3a6f8

#kernelci issue maestro:5b691d641098271a2e8cf3da1e29e6a2b37ae280

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
