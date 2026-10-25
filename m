Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792907113;
	b=eMfd3eeALbkNpfSGakFgUvE7Oa00Hm/CNY57uwnWh0JZFJggL5k2etseQE6FXUxtsJUA
	 y3Srxd7I07a2nUMULZ0s/mfHrGiEyiInttNJbKDPs3ZoRXVLz01TBxUUP6wt5fooU9Wct
	 7nTavIwZATzVcgoy8TbXOhyGryE90otL/kPSzQdFPW7isZtIbm5GmxHuL/urZfx/Iel7f
	 BlLpOgCsuCiVxTIB/dmAIEJxS843R40P6NgdofIJXL5CQgGCppH/u3UV67k6rcvPnofZq
	 8zY1kRM+BY53fUizmPuBmIt/SgIb75LRKM0ePydJHVQYfFy7It0UazGngiLj8U/N9Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792907113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6ZPKCuuJrE0W92gMDuc9JfWeZdsdjWw7nqJZx60/ZFk=;
	b=r4bEyW+dfp9QKteV3rpzXuJc655uEzuJ2RBLz2BKoYb89cSUlqB/MzsjGxM3VYJi785G
	 G6oZ8zBaxs9qtKbXHECCLWKXDqRc69UEvAQX+ScLCE27vc9sLMNb+T7OMApXFf0f0FsxS
	 sZoYBJZcyR594QTxpdOekvxRE+8y5TupVQTro/tgpGFGJmY3nNd6+q4mWmJ1AdFAGWHtl
	 mCgKsVhX0rHW06C3Z8JU2iPj1UD16Ki1ibQh5yhmVgkXFZldTsxndqWY/3h168yj5wzrH
	 7CAvXrCB9W2CJYtvaM243anRvJg4mV6dTRtkSiLqbjS0eWlerH73IzioB9NCiKLjwqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZkfPe7Rc;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395E1606A31F
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 05:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 395E1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZkfPe7Rc
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso1483054a91.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 22:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792907112; x=1793511912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ZPKCuuJrE0W92gMDuc9JfWeZdsdjWw7nqJZx60/ZFk=;
        b=ZkfPe7RcpAPNeC4dPG1wPy/trz92ztffsGgt4kzw21I4s2BqIMHcYAAkilWi3JeOWe
         Bt1Vm7GKkxnAr10PTJbTlbz+jUIGSFgQkIAS3mxiNDIfNQYcvNg0BfrQaoNLvJ9cOTh7
         va/PQO/P6tzuZN8BOpSwZXoSa7SiVigQDakmWpt/f7LC25zssuCFegvz63iVOXrknEoC
         o/Dzx7co6BjFveuRzpmi2rcZsoKerVEoPnnh3x/O/HJo2J7e1qI1soA0Qff0VSzf9xXl
         K/qb7IPWGS7jY3pb4nPtN3RP/YoR48HqlCin1UumhStkv3WzyEOva7b46jwDOJLNb+Vw
         /NGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792907112; x=1793511912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ZPKCuuJrE0W92gMDuc9JfWeZdsdjWw7nqJZx60/ZFk=;
        b=LsBHedWghISnSn5VMjgiZClkn6s1yEbXd5TgKMw9/lbA8iJW0Vhv68nxiftGzzfaw0
         D1kI1YByxbaORclTFQHQ8hTaH/Y+qVRWz+YT2cEqvxLDXhA4+sS3/t32inWsVYNAwcje
         sq4KUhsFg+8ec07GW0yuBfD4kti2luEXBMYLEDBAZ8CiVWhkA2ScmyTHzI0pxo7bogLq
         F8uRcHFvBqOzGDWZad2t0k3fBXSuo8ecb30wcXqMjRzbi7nymj6mUnrFPT48NgIR8SPd
         mMcVvos4h8/9kyEII87UDa8Hgm4bJMGKjG1xMSj7TVjJolrP3puEzI19syNvJz5zh15v
         XiZg==
X-Gm-Message-State: AFq9FYIJKQJr1uUZN40XC58u52k04LkBm0g1H0DBaG2oc2O+m1o9AgFB
	XfB9x6XWBziecXndjS4yr1FFlMV6GhgUzZHCMrPXOiiwQnYz1Uic24ESP/Ko
X-Gm-Gg: AYBFou3CTHNe10kPuWHzl+HHfMX4pu5uL8pOr+4iPF8m+dV/qE/l6K8JcB+8oBzMYsm
	Zpi2SiU6cn9GnGCCfZ/yKn2/YXADjDyJN3pcHFGl89n3Re0GZ2IinZreCd0F3D4GP/efF3Mqha+
	nOah4KhlBUgRQEdox+fDM2X1XqG0Ml2GAosHNWxxfPqy8uZViKZ5hVJ4JSB+4QPuesvM9PAZ83+
	G/jL3WZu5Tn+493EsCKU7jDeNJmsvTKXPO05YEYE3kR8PqoWIwhKeejbZw2C53o+e4C6+EfDCXl
	4wVlW+2GkW2ItNZfqd0gYr5eq3OdjPL4RSDItrLkueFev5uIlpDObujjCuCHQYoWcNJK1in1Ft0
	2DzyffUOWWpTniOeewRE+KX9OsI4cIIonzvF8oF+fNt6y9jjnMKgYL0LCfl5HWaZ25J+OAJzISw
	TP9gnju+/+yJW96EgN1QzMEV3NAVd6p8k9iI+IMAkb8DHfSnaYMOzcLCxgR780QdLERaY7akyZh
	dq/mRcJGW9yH4Y1EmYQBzgEEk/+KhzGBFPxW1ix4Uk1NKUr3a8uEUTDvyAsZM3C1G7tbGUb3ZxB
	BNCUgcmfGbXJQQAwCMU=
X-Received: by 2002:a17:90b:4b05:b0:3ac:86a0:5764 with SMTP id 98e67ed59e1d1-3adeb197eafmr2937361a91.64.1792907112145;
        Sat, 24 Oct 2026 22:45:12 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb75254sm2620167a91.4.2026.10.24.22.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 22:45:11 -0700 (PDT)
From: "JongHyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: stable@vger.kernel.org
Cc: JongHyuk Kim <malhyuk97@gmail.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	linux-mm@kvack.org
Subject: Please backport aedf2efd1897 ("mm/pagewalk: fix stale walk->action escaping walk_pmd_range()") to 6.12.y
Date: Sun, 25 Oct 2026 14:45:05 +0900
Message-ID: <20261025054505.1448278-1-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Please consider aedf2efd1897 ("mm/pagewalk: fix stale walk->action escaping
walk_pmd_range()") for 6.12.y.

It fixes 3b89863c3fa4 ("mm/pagewalk: fix race between concurrent split and
refault"), which is in 6.12.y, but the fix has no Cc: stable so it was never
picked up. 6.12.112 and 6.12.113 still have the pre-fix layout: in
walk_pmd_range() the "walk->action = ACTION_SUBTREE" assignment sits below
the pmd_none() block, so the continue in that block skips it and a stale
ACTION_AGAIN survives into walk_pud_range(), which then re-walks the whole
PUD with walk->private never reset. Same thing in walk_pud_range().

I hit it on the stock 6.12.112 KASAN build:

  BUG: KASAN: use-after-free in __mincore_unmapped_range+0x1ca/0x240
  Write of size 1 at addr ffff888105ae2000 by task exp_root/191
  CPU: 0 UID: 1000 PID: 191 Comm: exp_root Not tainted 6.12.112-dirty #1
   __mincore_unmapped_range+0x1ca/0x240
   mincore_unmapped_range+0x5d/0xd0
   walk_pgd_range+0x8b0/0x1b10
   __walk_page_range+0x418/0x600
   walk_page_range+0x2b1/0x620
   do_mincore+0x1a1/0x350
   __x64_sys_mincore+0x1aa/0x390

The -dirty suffix comes from the kernelCTF build, the tree itself is
unmodified 6.12.112.

Reproducer shape, everything unprivileged (uid 1000): map a memfd so that a
mincore() range of 4096 pages straddles a 1G boundary with exactly one PMD
past the boundary, have a second process call MADV_COLLAPSE on that PMD so
collapse_file() -> retract_page_tables() clears the PMD without holding
mmap_lock, and spin on mincore() in the first process. The raced PMD has to
be the last one in the range, otherwise the next non-none PMD resets
walk->action and the leak is lost. It takes about a minute on a 2 vCPU
guest. I can send the .c off-list if that is useful.

Note that 6.12.y has no CONFIG_PT_RECLAIM, so the MADV_DONTNEED path used by
CVE-2026-89754 does not reach this on 6.12, but MADV_COLLAPSE does.

I only checked 6.12.y. Any stable tree that carries 3b89863c3fa4 without
aedf2efd1897 should be in the same state.

Thanks,
JongHyuk Kim(MalHyuk)
