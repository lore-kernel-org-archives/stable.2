Received: from mail-ed2-f1.google.com (mail-ed2-f1.google.com [74.125.228.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4988314A6B
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 04:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263661; cv=none; b=owTFfnldfd1T+im/YB9Xpb8YeDiVyKMRpsqXn2Scfc2JBYzumXgm7llrS1sCHbGw1OxWA/k9ykKfJA1mqoHL9sVGYR9cAvwMK1J6pAhTRkXgYFxl7o0pe3jUHLAg16vFM9TrkxYOybM/U6Kp0Kyhcs5ZWrRURIS/9hzR0jtNJAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263661; c=relaxed/simple;
	bh=dFwwbddi436lZ04xBgAScK+cVA2/cK0wHX5M8zZf6Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iqn4pDBGx44JjtQ7kCShoUo+y35iRS3XMrEcWHAvJvEw2YI3X/aD6J0iLRBlsFweC2YO4OTgzvbeG5A3jeI5ELDbv6Rw2vxt5xPM8qd68sPwIdddd+pLugs2iUwlv3u9dn49/Az8e4fKF2CVQr1NRZW6iCxgFJNOCRn+NbzX/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SK33cnbl; arc=none smtp.client-ip=74.125.228.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SK33cnbl"
Received: by mail-ed2-f1.google.com with SMTP id 4fb4d7f45d1cf-698aa235a9dso4783916a12.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 21:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784263658; x=1784868458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V99zj7iq8MUudw2Yr6Iyox0msy4Zs+nzuYqOJgmh9Ho=;
        b=SK33cnblPGWwFS+GXBvMPuOsiIUnlzIKYpAZXtcLyldJqY/RuadRJXryJz0O3u7tA1
         OLMTYKeK/kZM0gbx592LsrLJMD2FPojoecBdLN1O/bOSFwkHAoR2CEvnbXZf9mwNHggN
         +UHFqigMfqLRoFQtaatNvrQd6ILVSs/TRxNbvVO7XFd1LDVCQApS2WJcaYDyFAU4Qu19
         5nzBytNsugX295WshC9Wf1xrp6fye4Pswl70YaPvnRpZhzXQdPKGcRHYfBet/vMsSfUd
         zirFg3HcD/X7gSvkCkPCGl76RcBaVIewgaR3zzzXhhWtYFHlynBVpYTTzdYc9+ADivQ/
         1P6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784263658; x=1784868458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V99zj7iq8MUudw2Yr6Iyox0msy4Zs+nzuYqOJgmh9Ho=;
        b=XgumpPKgWaXqzX8Nq8tYXwSQ+1GYrq1fcIW9mcY5LzqehO7sEhrWksljwnGA9Ak47u
         7s5C+XDswalU+gPoc+c3yrWQPO+JixPQofwtgHEYdIPo0+TwfpM+ih7erFzHrW3bYQ7t
         rmVcpyAZoTDf8EaS9wpR4FAuzylPUIkH+GJT918XGC1nSS0zKzpF/GEiFML7nDNFfUys
         B0wKVyGiTTjuXA/z0/VsugXwxObRcpZwJswEBbe/DNlxRpekDGd+U6FurA6muk85Fzol
         HzqSBDlGK0X3er0Ro2Sovr2q0G2WneYmX1bhyIW909jm+TCApav4oNV9d/dHpLqLk9HS
         mKEg==
X-Gm-Message-State: AOJu0YzWWJXf4HHgylgzqWJKNbQNjXgQ3++W6X4zmFCl6Pz6P4bPE5g6
	cb4iLK72xbnH7PwQgLRx6g2hLhURHE9YTeS18yHypcZD1BxQTkRFN4Vks3yuuB+zK8Gf4leKXLE
	RwxAGEpNHwQ9/
X-Gm-Gg: AfdE7ckKfE5LJLcvHghv6Sobu+FQxz/wSjxpiIrOPX9Qh9CLrY+Z27dHWl1rjsWjEWF
	iwdQRrZOFqTI0Xg0BI518KQ6KTLDf04ykJjpz4w84HZ/0JOXzlzjZhYGqqaRcNv4AdcUJRWRt24
	JHJ1W/marXhN4R+FolvOVQmc3OZdvoxYL7h3PG45iMmD5wtXmc56T2deuwILCD9lz+wvhB2pGy0
	LzWY6T6t/EyRs9W/wWYXCub6b7R2WxzJuPdxJLb0Xi3X0IutjGUEcIFNauTWQ7YnWGY0Pv5jesC
	3G7b4XUC5mw04mZFE7GGeDTOckjhoq0284o14nGj/9OFh7O1+TbQvEqvtsWRCMQh6pvn+IIYyyI
	878xH0hhw1fRUIII0PhoYblnjfDkU2NNNUtigss+lVA02hvHUaR90sDfI7mulBuOUPmqH7hAeLI
	Io2scbStmExPfydTKbZ7mOcdH2zdL/Yoo=
X-Received: by 2002:a05:6402:4349:b0:699:f204:1953 with SMTP id 4fb4d7f45d1cf-69e652aecc3mr242023a12.24.1784263657760;
        Thu, 16 Jul 2026 21:47:37 -0700 (PDT)
Received: from localhost (106-64-25-226.adsl.fetnet.net. [106.64.25.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4b22a0c7sm347791a91.14.2026.07.16.21.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 21:47:36 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.18 0/6] bpf: verifier: linked register tests and fixes
Date: Fri, 17 Jul 2026 12:47:23 +0800
Message-ID: <20260717044731.121353-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset mainly aims to backport upstream commit 1b327732c846
("bpf: Clear delta when clearing reg id for non-{add,sub} ops") (patch
4), and its selftests patch in commit cac16ce1e378 ("selftests/bpf: Add
tests for stale delta leaking through id reassignment") (patch 6). While
doing so, I find that a BPF selftests patches are missing as context, so
backported them along to import coverage.

The full list of patches that were backported are:
1. "selftests/bpf: Add tests for stale delta leaking through id reassignment"
2. "selftests/bpf: Add tests for delta tracking when src_reg == dst_reg"
3. "bpf: Clear delta when clearing reg id for non-{add,sub} ops"
4. "selftests/bpf: Add a test cases for sync_linked_regs regarding zext propagation"
5. "selftests/bpf: Add tests for improved linked register tracking"
6. "selftests: bpf: Add test for multiple syncs from linked register"

I have confirmed that after this patchset is applied, BPF selftests
(test_progs*, test_verifier, and test_maps) still passes on x86_64[1] and
aarch64[2].

1: https://github.com/kernel-patches/linux-stable/actions/runs/29553646000/job/87801246946
2: https://github.com/kernel-patches/linux-stable/actions/runs/29553646000/job/87801246917

Daniel Borkmann (4):
  selftests/bpf: Add a test cases for sync_linked_regs regarding zext
    propagation
  bpf: Clear delta when clearing reg id for non-{add,sub} ops
  selftests/bpf: Add tests for delta tracking when src_reg == dst_reg
  selftests/bpf: Add tests for stale delta leaking through id
    reassignment

Puranjay Mohan (2):
  selftests: bpf: Add test for multiple syncs from linked register
  selftests/bpf: Add tests for improved linked register tracking

 kernel/bpf/verifier.c                         |  50 +-
 .../bpf/progs/verifier_linked_scalars.c       | 556 +++++++++++++++++-
 2 files changed, 580 insertions(+), 26 deletions(-)

-- 
2.54.0

