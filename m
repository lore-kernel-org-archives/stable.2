Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072753;
	b=LBojrq9IALUFoMcL4x4/JKQo9+JxClhwkU2Y2SugfgwW1+OsNsSUgpSPO4QyThvxAQMo
	 munBgDivsOsNk3/GK53M42YxXfpErbP32gFVD+qmT0fs4khbHfnuuvGQ9iHkxZDLEkQlf
	 SZGf4m9woILM5mquQJ2dRhc9OqE00QrFx54lmykeFK5fkWatrD3F4I8UrHHZTFPD3l2R1
	 21RMakgCS0iBtnRflwy55aqEZ0DOab69Y1TSrLzd2XJhehjts7aZEBQMf7Phra2coPsoF
	 nfb/daNTzt+4coA9kc9Uks6/jr4S3a1HXZ/psD0ClUuUUInBDUDGhN0r5P/Bjs8UtRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072753;
	h=DMARC-Filter:DKIM-Signature:Cc:Subject:Date:Message-Id:
	 X-Original-From:To:X-Mailer:Content-Transfer-Encoding:
	 X-Lms-Return-Path:Content-Type:From:Mime-Version;
	bh=ULr9bgQ6yFnrOUoUUAJX9WlVlG9/9n0WdEkZqyzIDlU=;
	b=TYfys+TuZ6M4R8jPLtCE1/a00LZEdzJdixf9fDnJ8pZ1WseDTXHGrhR/tCGcK4nGz69d
	 jVEML04r/RrRTfbd+JiIm/NhM2CpBJnZ4hMXRe4FBFb2d/LgC9TqNmIX9PG/zgym61uEE
	 b//ZOskooGyEUmnYicfonN/4nHzd0c01vjJoR0HryH9jiyYLidnSwVOg8O6stZpSTmvZN
	 VSyiDTBLbYFOJ6B2GwuqdiJlPsFDNcCOeevldmB6jUnFWBLK2ZkBxworrP5yRDoVclZbS
	 1w21IP2skVA+DXDmdRoa5OZATZK7KWZB4Wk5GucOW4RXkzjw9RUcoE6RGpoDc6gNgPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=KRUnrtrp;
	arc=none smtp.remote-ip=209.127.230.112
Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40403606A31F
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40403606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=KRUnrtrp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1793072743; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ULr9bgQ6yFnrOUoUUAJX9WlVlG9/9n0WdEkZqyzIDlU=;
 b=KRUnrtrpDHoHc9xFObs/VqlzU5RuhQYm6qR2sL5250j7/HOS7KOp19kT69VrDHpbdvguUJ
 Jsm9FKzTgb9UqYk+yxX+JhL4y7bxoZQirCbiT2Un9WV9jIN13k/Aah+vsw8R5QVbqGIGcE
 F4WQvQYSKlIbWfM8zx1ZJJ0nAk2drbyeIVWXl0qEm+w5YskqS3cyeE7cDKU+IVoH+L1368
 T3enpr70PR0lWdxvrNH8eVViwbcGgiDnAKSIcUMmEp+s1uFHccriOKZ68Zikfl6LKWAt69
 7T0JgNqPGiXxnMo88MmcE/n2QtJ9FgmxRGoUh00DhcPNnJEH5xEkIfpj48BI+Q==
Cc: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, 
	<chang.seok.bae@intel.com>, <shuah@kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Guixiong Wei" <weiguixiong@bytedance.com>
Subject: [PATCH v3 0/2] x86/fpu: Fix dynamic fpstate leak on exec()
Date: Tue, 27 Oct 2026 11:45:25 +0800
Message-ID: <cover.1793072271.git.weiguixiong@bytedance.com>
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
To: <x86@kernel.org>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26ae01e65+101b7a+vger.kernel.org+weiguixiong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Guixiong Wei" <weiguixiong@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Message-ID: <20261027034525.n_XFdGRdfYdist2-1b1BUKZ4u1Fn2qa1xpUPfMZRII8@z>

An exec() after using an XFD-controlled xfeature leaks the dynamically
allocated fpstate. Fix the cleanup in fpstate_reset() and add an AMX
regression selftest.

The selftest reports FAIL on an unfixed kernel (verified 10/10 FAILs
on 7.1.3 with the leak reproducer present) and OK with the fix applied.

Changes since v2:
- Free dynamic state at the start of fpstate_reset(), keeping the
  fpstate_free() interface unchanged. Clear the inherited fpstate
  pointer in fpu_clone() before resetting it.
- Replace nested self-exec with a parent fork()/exec() loop.
- Add a pipe-synchronised pre-flight check that confirms the dynamic
  allocation is observable via /proc/vmallocinfo before measuring the
  post-exec() delta. Without that gate "no new entries" is ambiguous
  between "freed" and "never observed" and would silently PASS on
  kernels where the allocation is not reachable. /proc/vmallocinfo is
  the only user-visible signal for a leaked post-exec() fpstate (it
  has no task scope once the task is gone).
- Compare the set of allocation start addresses in /proc/vmallocinfo
  before and after the loop; addresses present only in the "after"
  snapshot count as new allocations that outlived their task. This
  compares allocation identity directly, so unrelated vmalloc churn
  elsewhere does not change the result. SKIP if any matching entry's
  address is hidden (kptr_restrict) because the diff can no longer
  distinguish allocations.
- Report leak failures without preventing subsequent subtests from
  running, and simplify the commit messages.

v2: https://lore.kernel.org/r/cover.1791428412.git.weiguixiong@bytedance.com
v1: https://lore.kernel.org/r/20260929151013.81562-2-weiguixiong@bytedance.com

Guixiong Wei (2):
  x86/fpu: Fix memory leak with dynamic fpstate and exec()
  selftests/x86/amx: Test dynamic fpstate cleanup across exec()

 arch/x86/kernel/fpu/core.c        |   5 +
 tools/testing/selftests/x86/amx.c | 251 +++++++++++++++++++++++++++++-
 2 files changed, 254 insertions(+), 2 deletions(-)


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.55.0
