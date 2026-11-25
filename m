Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618754;
	b=QT+7b+noY2YyxHUNW4Qw1HA/StTmmkgk1c9BZoqshUEGRgiGjxcZ2ncLxwDVlb6rM5a0
	 5Rrdg79rqOZQ5LijSg90XOMLI/UZEWGMIbWxs0AvsGD54SKw8H9o7wkfLNfNXIEuWHdqO
	 3nmjxGe5oH2N3bZbnQx5lw5y17Yk+dbDDTthVOwK0x1h4yurQZ3M7mJMEokTKMmDOWSx1
	 O3wV6BxK8a5cyZUtrkR7zExHgSeIpePNgwoAmk0Dj/WECVvufR1RvYm9IzK6YKQEihbcn
	 VAvMu5EK+piZi5/3VzB9jSErtfY1TSScxJtZ2Z9OMEYFLH690gcvAU2U2+dS86FHmoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=8UEIir17Skw21TkKSz8A3QMYMoRVWE0BGlhNJdL4Zco=;
	b=p+tSzLXKlRIo6ISqNcclCXHkx0BwS48o0VIXPe1DM+x0NLVmLoYz6BexeTfvdrCg8iPh
	 nxSaL+BmtlYTV7iORfCvycBaMUnUStilwWlg/AOHUO/TdOclKCVemOW4c+CoU9PmjxHae
	 zSjc+u4pdQJnG+NuQbpqiG7GojNECMFYBITiVc++mZzenIq9fsH07NHMj9kH9incsUI5t
	 NnamWubHvERIFlx+jWDMT0mDkT4818pxSCcR4FVYU7LS4btavOM5PnarjyAzxPAOqiAjQ
	 N5wNl/3LaR2c4ZGLB6rAnNmKJ0hpm37TZnl/XELV9xFOacriYxG3uMKa9ghtoDBS+Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=h6UHlJcH;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E930E606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E930E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=h6UHlJcH
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33fb4680717so160918eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795618753; x=1796223553; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8UEIir17Skw21TkKSz8A3QMYMoRVWE0BGlhNJdL4Zco=;
        b=h6UHlJcHcgww3NSOmgVJOUSpcFAJjrpG5bbKfj1+njEXgF1iIOQG0mxJsxgn0JLjcg
         lfcTPYDb7SMHBxYIxNLqLzwTEKz3bV1aXvMHFxi1jApZ4X3vSrEbV71FAYhU73G4vkSE
         12aTJTqBRELzm84nK5+yYeKPF2jcHOp0O2dqMsXvZgSqzvdD+8gKNDqKSw7kMvi2FIoW
         DhmzrucSC2E9uqKWaGzPRjHbi7UcdCCOALw1ukhjysA1l+FxV1+3ihww1f9AY8n76jcg
         jtmIOlo0uJgtr1Su3V653ktOPo4Nbpnc7PR85aifDa0n2A+2imQFf8JEk4FX6z9e9oOw
         a+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618753; x=1796223553;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8UEIir17Skw21TkKSz8A3QMYMoRVWE0BGlhNJdL4Zco=;
        b=uHZbWMCFQaej+ibKp2NZp1gVKGAHwqgGf1PrHCWMC3IOI/lSfBYPQobjvYz8AEJ7PS
         ohCF++DjegH082wppNv/Yt9s9DKeyzTtDX7E//4fOKxZso+0gp1waOVRg+AvcXjtysAq
         GH1bVN4SElLc0RsebJQywb0z/9phPsBjLTAGQ5/qKf612RHwgwkWGATjAL1nMFT7zTEc
         pUyW7Mok/67rhKjNsTIpRgY3j6X5G9MSEIs/CtrJwaCfNTIAg2nhRtQR4+/+iB37/Uot
         kGMyifMGnI0QQSG8Tjm+5lXZeCNc6msLqXAbzK0v7ni2tlJAeOEjxfTG19wDIkYfpOxW
         cpPQ==
X-Gm-Message-State: APuU4Z/fvQ7CtjDqn7J14t/qxEuqlgqbh1GQokXPfd07wm9RadpiMDwq
	3W6a8fKBe9AdLHecpOtndileny26Som6iDZftLLcWDfAJJjvlUK9CsyCFPYp7VKDM5mpiMxN/tk
	SetXy
X-Gm-Gg: AZFdTZfr3Gdc86MydYbSZMeIkE1/RgFm6v+3biV31BofcfF5Y00eYd7HxqCjt4RNPGJ
	Yr1ee/b7fDhcfTvUmQU9zBw6Uu3WYZyYqR/ofnePklCqBn8Ys7aWvMHoimqq/im9W5pjDhR6jS0
	fsa3AIMfTBAoPjNUS5DzAKqeyyrvy5u5uvbcRTJ5Dvp1PbGRG47qNSRfQF89hWapV9ZpcmBJ2kr
	lJrzsrKyIh27zWHFMDX8B/S2OY/z//sgg2bo7Pg3t8k9A4e5MnrHHFb/qx6wZfd+hofrNZ7haUY
	Ppec2r2yvy9RsjLpb3AmT/xqDrTAQmwgJ/3tIpwNp+fAo5OvObB2p3uynPsALuV7qCgELZEBGLy
	MqQqUbhcd+K2TKD0PXAiCWArQZ4kAMAyMqH1gNEqIB2abFJgMj/lV1fkBaD33BeBQDJ1k9OT8x+
	ZTVgViD7g9SPcdYJ0su+eGGEWZOUhTpNUlMVxYuvSUaEryF4o2kgDh9J+bGLx8p3vpQ/SHHAQbD
	i4ry4VNEuzn6Np/eLDCm4Jhi1fhbUdYmrgRnCwbk0MVAMB6L/FbDu51oLjZSNcLk3JowVhoU7VO
	RBs74NBY+a3SfK1aFfN6VA==
X-Received: by 2002:a05:7301:df48:b0:386:a5d0:15d9 with SMTP id 5a478bee46e88-386a5d018c8mr12210345eec.37.1795618752962;
        Wed, 25 Nov 2026 06:59:12 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm67607680eec.11.2026.11.25.06.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:12 -0800 (PST)
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
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E18=2Ey=3A_=28build=29variable?=
 =?utf-8?q?_=E2=80=98cbnl=E2=80=99_has_initializer_but_incomplete_type_in_fs?=
 =?utf-8?q?/nfs/nfs4p=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 14:59:12 -0000
Message-ID: <179561875212.101431.7093342870032313401@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.18.y:

---
variable ‘cbnl’ has initializer but incomplete type in fs/nfs/nfs4proc.o (fs/nfs/nfs4proc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
fs/nfs/nfs4proc.c:7331:24: error: variable ‘cbnl’ has initializer but incomplete type
 7331 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                        ^~~~~~~~~~~~~~~~~~~
fs/nfs/nfs4proc.c:7331:54: error: ‘struct cb_notify_lock_args’ has no member named ‘cbnl_valid’
 7331 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                                      ^~~~~~~~~~
fs/nfs/nfs4proc.c:7331:67: error: excess elements in struct initializer [-Werror]
 7331 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                                                   ^~~~~
fs/nfs/nfs4proc.c:7331:67: note: (near initialization for ‘cbnl’)
fs/nfs/nfs4proc.c:7331:44: error: storage size of ‘cbnl’ isn’t known
 7331 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^~~~
fs/nfs/nfs4proc.c:7335:33: error: ‘struct nfs_client’ has no member named ‘cl_lock_waitq’; did you mean ‘cl_rpcwaitq’?
 7335 |                 __wake_up(&clp->cl_lock_waitq, TASK_NORMAL, 0, &cbnl);
      |                                 ^~~~~~~~~~~~~
      |                                 cl_rpcwaitq
fs/nfs/nfs4proc.c:7331:44: error: unused variable ‘cbnl’ [-Werror=unused-variable]
 7331 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^~~~
cc1: all warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:4ea9099c04756562789a42faa282e9f79086510c
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  2a9f2c755feca19315a7f06d3ca477059f4c16af

# Builds where the incident occurred:

## i386_defconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-6b06f2a7286e1965ecb3a0a5/.config
- dashboard: https://d.kernelci.org/build/maestro:6b06f2a7286e1965ecb3a0a5

## x86_64_defconfig+aws-ec2+aws-ec2-arch-x86_64 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f2e3286e1965ecb3a4c2

#kernelci issue maestro:4ea9099c04756562789a42faa282e9f79086510c

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
