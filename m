Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172EB5AA666
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657166; cv=none; b=gQn0fZX60GB6tRQK6i2VUzYGjrVMiXSMOoWViMw8ENpZGV6jx8VqYdZ1LbWA1N1Ph3vpViWe9NPlz6nqnU5nH0VN9DiXgUC6EFyalgd1w1FQNcKwhmOm+qgxip+bla6aPMnYI/LnGrz8JYFUYOC4Ci86u9CkObFC56mtBhHz+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657166; c=relaxed/simple;
	bh=5iHOVdgdoi7zBLIQTQ/zhxUt3zqdXpgjrpJNJ5p+ptg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=FzRGPMD+JW7XSkkAXnDNeCrajZQbxJWMI/HuSdA0BCDXlyYcVblvWplFbrkpBxqlBSHzRSOuSMEDUZxFItUEKAza6w0w2TToZ1//T1Urt0EkmHk9t3RkwcG4EM0D1eAdf1o0N1Nq1SFdcf77By56UapGH+E4HHjyzomHLuT86MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Kr1Vx6Ot; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Kr1Vx6Ot"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-395cf2535acso949585a91.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789657147; x=1790261947; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x6ZSOKLHMvhuaL1JUMH+yv8vb8OWDKEFuWoEkZsdWag=;
        b=Kr1Vx6Otb7AFJyXl12dgcJqoy0eUBjd5KwRuzcHRcESVWRDRvniiQswWjAVp0eQo6d
         DJjiaSl3PFmjoNwfEvcAVR3NQ5US55B7ngzloZ19E0IINBi8KRdwpI42RpwxVsIaLin1
         5VytA4JcGLPNzJx5nGoN6O6gnDmtp7hLfICvvvyybtw5HJ0viaD4eYqiuPEbNBzYiLq8
         +YflnKZl1VDzs6rhEhCHjHLZH3wGjoWI5PmiAIfGakhpGDYilba0cyCn99iBg9ojufEn
         fYtGmYzIWP6QA1nfA8DfMIkJ605EZ0f0FTdICJxnsa5mtVesdiH5jbX1AnG9M//qJCff
         6npQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789657147; x=1790261947;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x6ZSOKLHMvhuaL1JUMH+yv8vb8OWDKEFuWoEkZsdWag=;
        b=ED51FSHsrhr5682nF3CYUnawZSN8ictS1ok8L/3rJwxdxRGjWFphkjlCLTqKUZiZSL
         Kb/6uRQBZIZP11Uq3g9cNaCoyCdF4enQH03p9fw4l1XqX95O3QCKaazzFoHhLxrAc0TV
         bBZpjbzLMQWUpUNLRzFspcLCOLYXo41PiYGqbifkUf+rGbDYwHi3cl0q+l5WCxyA11RK
         /mizxob/Cpq6E3ymoxywngipbypjHBbwY+UKFUNZQw6G9HZiAs/huHjRMu94JMEgQrYT
         b64hyiHxGaW6hRk29X9+NeWY/vmPiXOpVWh7RHilu7R9w8Tuq9enmAO8jJ1n3yqNAQEB
         JxJw==
X-Gm-Message-State: AFuF++nTbaZEte4VGiMMqyn0/LnC6yxeUbQ3VcBVRfD8+VlxjQI++IyH
	c54TW7oI5PCZzLl4y5fvsP4M6MmspGJ6daersQsfkJLLnoLP/m2XE/fpie5XzCtLjvRbFx3/VAV
	4FEXf
X-Gm-Gg: AYBFou2MVgNopCHEiZ1Et3nt6VTu7A8mpo/SdSMDlo1CSqJTD+C7ifZBVkru5+4WlzH
	JOSvolkxdls7I2H+DJ9EhL451+1Su7q3/3jmV+zz6jMbWud206qkE9QPtrz+96AWw9d9FBw/XVb
	2OLSTsdm5uf/ms/QughAxRTlwkL2krzfK101ZGPqFGG/KpbMo1058UTMGuUG/J1ME41RMvROqX2
	yb8fcBHeDoZ/KVvNkkJZpZbOh5YvuoJOXk7iPd92ZqE3HiklnhdRvUWte0Tisn+aMZj0zhZJwyT
	R6L6Xy9xBj2BlQ+eT1Oyim9Lk/WsDahiKDeLIxrkCtMa1fl0lOHpiIVbsLTfQKKM6OFynGVIBqd
	dGegFZfqlENCHWrEW9MHQuxmXhwvqgW6Kfrml7xikbk8mb0trbwY06iT+I1DzzRgh6XyjHYeDHq
	07qZK3e99rV/z8oiLWR2UjmCHkh85aeA0YwlRUWdBKLIux3LLKzI6STnRrGfHnLRmokTTofY2oM
	g==
X-Received: by 2002:a17:90a:1188:b0:39e:39a0:b5b3 with SMTP id 98e67ed59e1d1-39e39a0c33emr2973816a91.1.1789657146656;
        Thu, 17 Sep 2026 07:59:06 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144c9f0da19sm1365729c88.7.2026.09.17.07.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y:
 (build)/tmp/kci/linux/kernel/sched/ext.c:3838:6: error: use of undeclared ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Sep 2026 14:59:06 -0000
Message-ID: <178965714575.146356.4641350436601014735@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
/tmp/kci/linux/kernel/sched/ext.c:3838:6: error: use of undeclared identifier 'scx_init_task_enabled'; did you mean 'scx_ops_init_task_enabled'? in kernel/sched/build_policy.o (kernel/sched/build_policy.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
In file included from /tmp/kci/linux/kernel/sched/build_policy.c:63:
/tmp/kci/linux/kernel/sched/ext.c:3838:6: error: use of undeclared identifier 'scx_init_task_enabled'; did you mean 'scx_ops_init_task_enabled'?
 3838 |         if (scx_init_task_enabled) {
      |             ^~~~~~~~~~~~~~~~~~~~~
      |             scx_ops_init_task_enabled
/tmp/kci/linux/kernel/sched/ext.c:867:13: note: 'scx_ops_init_task_enabled' declared here
  867 | static bool scx_ops_init_task_enabled;
      |             ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:27e19781bd7b6b6ded8afd999bf3be0405a14d28
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  09da4c7d441294e4264cc4804d8bc76433d5e0c1

# Builds where the incident occurred:

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aabeae2fc1857a999df1069

#kernelci issue maestro:27e19781bd7b6b6ded8afd999bf3be0405a14d28

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
