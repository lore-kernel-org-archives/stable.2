Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16763AB299
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347954; cv=none; b=kObfFhkwn7xPHf9rrw/FP68NG93SNPvXBPoYW+AoLh/r98UIagh+ZWyOoODsY8cRYzHBfjj4f1EUdIuof/na5rpGf/553yRAuO3b5BEpiM//K5jlhPUU/mNNNee1nO+fFyw4Cknf6qf41iErnYakc09eR5bMqWKc+YAZbBfDu1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347954; c=relaxed/simple;
	bh=1B0bWCAa4vBzKZbs1GkUik7bcpO12WluCoPDs8soRX0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=D3HPgPgYYQaAWo6mHhXvpca6/22j2evL3HwZem0hQO4/a6ex/uKTvJmJhiK6bLHyoP8TqRJIRl6xZV08Ia000ibegwwqDbas/q2pdM6/fSncGPec1eQ/5Bx8QdxGAEvHY/tKQlNEYWWOL5GNTnQWnTntizRZGeb4kHNP9ZdLoeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Io3kKC4Y; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Io3kKC4Y"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1311529a91.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1785347946; x=1785952746; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XmTq+OVWflw+XeI4TpGq1DL7ongqlozFWL7naBHtXG4=;
        b=Io3kKC4Y8JTdy6TPTDzvVEzZyW3PW4Sy1w2gNJX7/5X4soiLnjpg7JQkjK9LbV/Og5
         bgpSEhvWdEdNBvI0ys35EMaOg2JiR0hwAB4fxJSdCFe5iMTvGX0M1ZirLM+hPcEwrw+u
         TLtoeUv7GrokqIpGlAEDy/mUGj7+puTTKtTlLUfGXd5+4AqRUmqDR91e0KMrcdfbv3W0
         bXh+dGNpzgU3beQJHo/nh8rmnYLLA9XwaFKznv+lVXdcjDDXyhGOGZjj2nL53DRevoEb
         yOakKGFxtoQyOKK9lr0HeNsDLDULg5Qmya0Rn6IH9/rJMKqspzEJWOOWjcqKv3T8dOum
         yzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785347946; x=1785952746;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XmTq+OVWflw+XeI4TpGq1DL7ongqlozFWL7naBHtXG4=;
        b=bng+KFP+aYG/gFiYIkfUpM3TO93sLn50yINwAgMb2t3sZ1PC15pC+jD9RIDMI9wbZE
         LAZRDxi9BXTpwjxXlCJleE1G0YNgWHAWvXA0HWzAKO5hRuCu6gCq2vbQly70CzMpI20J
         s0JLsQ8rfEyf4rXWIahzC+ZHSEJvTZ157L3TWET0r4yDqs4sKqy53TGxn5YjogSsw1p6
         VC8RGRRyWojLJVHLkPv/Wj1McUkBU6NFT8/7ocXzV2oElRE53VpT4zEJLFtGjoxkcraf
         4dl+RZL2HELddI79jLAo7EqGaN4hjcFm4o4c06QEswt2d/c9Y0d5zr00XwPnaS7Yr5uP
         6vBA==
X-Gm-Message-State: AOJu0YyH31q3APv9Cw7PXWl0h+QD52YIb6RPhhUqDmVaKkSOELNu5K57
	ygz4bR0jCDc2UgeVesMWu3VydvV6po4Yr4itXfhTA6tTY+OkMQYNwywYjDfdD7hcqjA+ybvlgb2
	H/Fv8
X-Gm-Gg: AR+sD12lvFAB01Yr/Bz6MrPuQ7BArly1dM5ffvsFr04Bs9b+hoDqIq5VKD6i2wMhKHB
	Li1u553i7OatPfdgjDxJsbtir4bGUgEknOJBKKDP17nAdIV0FpBSOs/z1gEqGzTWHwVn6pkFaid
	00/CMD/cBq2nJCegKt7ptAVU3h7eRO7iUUsOHZXbxQidemGjqHCNqf4YikILBv4Wdjb9I79EpGr
	qso6o/d9OiicUvrg4IRKlc/SrrDweC9DvW5VDW+DxDeJ/H+3lj30G7ASlvPFxVO2td8WJ2b79Y0
	dUZiUngAWgE+fg+VAR9sbm9jtBQv6oIqWaOvbst2KMAcq08esVNsTNAVd3lBSG9H4lT5l1zhjc/
	Cz7YwyBfAwyOisLJSXBYzK5Unr0yQHdiy3XZKA1F2wThHZuySUkAOnu3jtsoUCK6X1MpzKcVAjm
	V0WYvA/9P60HsLsCaGJiAfMFYpxlQrQi8z8uAyme3S7dru2ZY/6Gb6fg==
X-Received: by 2002:a17:90b:53c7:b0:38d:ec31:4840 with SMTP id 98e67ed59e1d1-38f6a37cd14mr7302622a91.13.1785347946264;
        Wed, 29 Jul 2026 10:59:06 -0700 (PDT)
Received: from 92650adf53de ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b88e12sm12042379eec.11.2026.07.29.10.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) call to undeclared
 function
 'kzalloc_obj'; ISO C99 and later do no...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 29 Jul 2026 17:59:05 -0000
Message-ID: <178534794418.3623.17642308816127570360@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
 call to undeclared function 'kzalloc_obj'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in drivers/firmware/stratix10-svc.o (drivers/firmware/stratix10-svc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/firmware/stratix10-svc.c:1068:9: error: call to undeclared function 'kzalloc_obj'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 1068 |         pmem = kzalloc_obj(*pmem);
      |                ^
/tmp/kci/linux/drivers/firmware/stratix10-svc.c:1068:9: note: did you mean 'kzalloc_node'?
/tmp/kci/linux/include/linux/slab.h:708:37: note: 'kzalloc_node' declared here
  708 | static inline __alloc_size(1) void *kzalloc_node(size_t size, gfp_t flags, int node)
      |                                     ^
/tmp/kci/linux/drivers/firmware/stratix10-svc.c:1068:7: error: incompatible integer to pointer conversion assigning to 'struct stratix10_svc_data_mem *' from 'int' [-Wint-conversion]
 1068 |         pmem = kzalloc_obj(*pmem);
      |              ^ ~~~~~~~~~~~~~~~~~~
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:d7049d831d969b7c179d99cd0fc427dbcf4c3865
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  fabe22c975a2fb71a936f5d1961fd4b0583dc498

# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a6a326e798ea6c1ef87aba4

#kernelci issue maestro:d7049d831d969b7c179d99cd0fc427dbcf4c3865

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
