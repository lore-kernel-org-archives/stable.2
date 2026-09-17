Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EF1525A92
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653551; cv=none; b=ufcnlxwjpXGjF4y/QXhWmi3YxjvWU37U3HT12CxmSHbEGX28Lqz98RZQn0wUiAmXehk36cC2PxudABiec35nZ3DMOT3eWoQ9QwakwbJBoAi6tp/o8vtOpXsqcWibOGYDwQ5yn38Oyk016rwFsRF5JvG8AzcBj+ehxgq8+aDx8QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653551; c=relaxed/simple;
	bh=G+Ahir+8x8HEKUn0LP12YA0gqfsddY9p3oaYKf84OwQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=lOEF6Q+fa7yu5yJ6T3yHi0EuFq0rBlGkTu1MQbIzoKvRNmjoGFdb6lJxt4Am4dVtoYB+WFxB1uAPc3+sFFSXURJ7nuAZZg87Jkfoxov9X4TNlxwBgNqAEPaLqZVh9aSFMav97Wx4cKyqfX2BZoDalMuCcsBdtXHHsL4SjeurPA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=d59sHJsn; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="d59sHJsn"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed6d6eso7768625ad.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789653548; x=1790258348; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZpBlAeS83C9Eqc+PS5vvQZlP8X5+raFQXukQp1D3WRM=;
        b=d59sHJsnwNsWJ6Mjd5pDMc8p3haN7ybHotX5d5DNioiIWXgWNrgSXiE2uUY69tgVWW
         HvZEHcQlo7MFLTh5PguzWfCveNPnO8aLWmzMdmO/LBmYoeseCQemfm+dhXFSsgYVyO2k
         cAGc5RKByybh2AvBp6AEKOCtglpSJjdwX+P3Lj+gfjaBi/FgArBs+d4R3LdHMhXqpyHx
         mEyxElEH2nEMjwuGdCPIRiF7LB4zEX/eONXmM/8D3vr3HFKe8STnZN4l9jCI9iQ/9XAd
         OjtuDrjwNeuXm7taA8N5z1Oj1nYuf7BlqO+mHRSfn/vlW2YPZw8sMrOtFfZqebbDxoSE
         n7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789653548; x=1790258348;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZpBlAeS83C9Eqc+PS5vvQZlP8X5+raFQXukQp1D3WRM=;
        b=mYlUrR9lu7N3N9i9wyb8dR7y0NrEARbNr1KnRf7QTl+mM3dVTZyjH3NxLU9qvV+uHV
         CS1eB6LXzotgqzjNoor15rT1et0wnOkHRnO74ZcwQBn4RZ6hbd+vAk2gwobu9D+ga/Q6
         x47F8ucMvQHduu3s03RwC7vLTiB2YPZdZe7x0m+prN1AoBW78Ty53PThi9tjO7cPyK1d
         nbS/seeoKlqOdrEJ4eq9KRiay+ZkC6dpqJIlhN1EKd1IBUBfYpPv6H/gx1TbaxjypGb+
         uJhZhO18r6tzoXHfE+SHrNGhxdNAtIvCuJkAZdXgew+od5qWeZvs4NeYSfls5FD9hYUb
         EWsA==
X-Gm-Message-State: AFuF++mNKynCllUTMNq5I/g4E1R2PCcfoIoTYdK0ZwLhB+kEepCiW2BL
	LOlohnrYY00QBw0sXxP3CkGtYaxlSfL/UR8pMRBarUT2mOwc8W9SF8rtsvJREAYhHmbJreASNhh
	Kaqje
X-Gm-Gg: AYBFou2WBALJti05GMeX7PLGUHcP3xRlFSrpI7/quUD+VwvrYQdLmIdwJNoQ80TefGH
	Kzql4go7tW0puXYppBmFNmDwFA3eITvlqQBN9RWxA+bcQ/OXw4n7k1iCwuPOOVKRQ9KnaG3aSdl
	lUu2uBZR5/dZIBjEBFv1q1jBYGr56KjQAuzq1efI7Qu7HYKmr3qIeizusOTmFtStRI1QvALeM14
	8T/3NA3ytIuxh9TQ4hwiMDEY08zSBf0ptVq96A+5GFY7QcSmOkzEZbNoFTGnPEMClEyMoweLv+e
	rYeqrMlVjmpc9cgeRR36Ki+koSisetdC0EVEfVQUDoGVTVwMtd0ExeSiDyE1wSLAAe9dTp6H3Fe
	PbbceJCPe4D68Xd2/t6gug/xBo9Gb+iVlkDPJC5qugjGK4a3FgLJFanLgHBsF2Qvdz2viF5PyQ0
	qbFb0eJEGK57dlJDTOziwqnK+cxqX8gq3zcBGf0PeX1sNSVF20rNCOjv4a9VCFpqg=
X-Received: by 2002:a17:902:c94a:b0:2da:e634:370e with SMTP id d9443c01a7336-2dd8e40cfbdmr141835115ad.14.1789653548268;
        Thu, 17 Sep 2026 06:59:08 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a6a182sm17305532eec.8.2026.09.17.06.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:59:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEyLnk6IChidWlsZClrZXJu?=
 =?utf-8?b?ZWwvc2NoZWQvZXh0LmM6MzgzODoxMzogZXJyb3I6IOKAmHNjeF9pbml0X3Rhc2tf?=
 =?utf-8?b?ZW5hYmxlZOKAmSB1bmRlY2xhci4uLg==?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Sep 2026 13:59:07 -0000
Message-ID: <178965354733.144182.3599012631280321500@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
kernel/sched/ext.c:3838:13: error: ‘scx_init_task_enabled’ undeclared (first use in this function); did you mean ‘scx_ops_init_task_enabled’? in kernel/sched/build_policy.o (kernel/sched/build_policy.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
In file included from kernel/sched/build_policy.c:63:
kernel/sched/ext.c: In function ‘scx_cancel_fork’:
kernel/sched/ext.c:3838:13: error: ‘scx_init_task_enabled’ undeclared (first use in this function); did you mean ‘scx_ops_init_task_enabled’?
 3838 |         if (scx_init_task_enabled) {
      |             ^~~~~~~~~~~~~~~~~~~~~
      |             scx_ops_init_task_enabled
kernel/sched/ext.c:3838:13: note: each undeclared identifier is reported only once for each function it appears in
  CC      io_uring/poll.o

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:bea4dd538099462d8c92badd44596b9958bf40cc
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  09da4c7d441294e4264cc4804d8bc76433d5e0c1

# Builds where the incident occurred:

## defconfig+netdev+nfs-root-boot+kselftest on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-nfsboot-6aabeb25fc1857a999df12dc/.config
- dashboard: https://d.kernelci.org/build/maestro:6aabeb25fc1857a999df12dc

#kernelci issue maestro:bea4dd538099462d8c92badd44596b9958bf40cc

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
