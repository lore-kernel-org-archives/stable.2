Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F374A99DF
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364938; cv=none; b=rw6SHPY2NgZH9AiKkRvqtjodNF/R188UWgCyqVMk0Zrw1i4/DTgFDBwnL9pjmPP5Yrwsbtz2BNDpMfh1hJ4qMl3bleQfWq0pVcEtmVTSmUzu7W2qAwTevkkKmWSB4PthzPfVYyqndtD3dNkZa6oLdbgbrscaY7L7RuRLFTRE7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364938; c=relaxed/simple;
	bh=hi5B8631ZCUoKVXebUUqejKb7iuOqQZ55/o1Ipl83eY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lyHQxnD92KOpXyWInWES+SsyPgfuZdYSOWizODP6G7nYGXpcrb5crcm69VJyxn6bsCKPV/b8CGwYNUjH/3DL4UXcyZvcZIewjBlTBAizSGmMq88TQQiLM7H08CUEyuyUVGAm1Ozv8hB6OT4SQEzsluRUWbHBs8mXzPqMty38FXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apCCKf0I; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apCCKf0I"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3964dfb5a69so1675118a91.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788364936; x=1788969736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nevPdevDdDWdAWCNH64YiGAe7oXmwOpEPCd54OU20M0=;
        b=apCCKf0I7HPgyI7jhZthJngYpSGBrO2bqqoq5dLkLmxGLL2pIWwhgvsA8cJ0eNz48D
         ALB2wcvBEDD6S5oXmnFAPGuzDEn8uogA3qr8bcDRf82beu4lce3xATbH0wSNORlxA3Nn
         esKF/94XOw7dmSTSZTXzhuxR6gkBLZa/xVqGVNeuZuucS/dAM6izfpIyy8DmzoprmPCq
         XmmTCaXCtr6/jfLgHuhD7D0aphney8bikg1V1Auck7dJ3hq5TRXa5I7fL2o9NYH8fI0Q
         a/aL0xOgsEHXbValfUMKUsBszsRbfOEweTzOpn5RlGjPv8Ri97jL6uL2/ZA4miWiju2j
         siUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364936; x=1788969736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nevPdevDdDWdAWCNH64YiGAe7oXmwOpEPCd54OU20M0=;
        b=KdPMZ4vBZSLgv1FBurvLpl+WsJy0ktH3JIohuaxkLxawmM+vZhelBLflILBcvj6aG9
         0u3Pm+aJ34o2GCna+wrhdaTFnermPfjdYVYpY/qpdVjauRpMaAxNqr3xvoLLnZjK1ZnB
         uuIWcVlDA8C5j2Ov9WtB/tC2NVZZilj7LovzvBSd7HNqsM86RMA7/V3tFAGO87jvSpZm
         i09V8dQL9QI+b5JhilLKIB97yVC9Dnnmv/U2TI22piFM6ug4iTefvRI6Yf8fdIcEAIi7
         ezPyvowThgiDVk+Mv+d78HlUCinw/cb8rWSDRUQ8UR3U12fkwIERjilYiK2TrwXB9EXQ
         POuA==
X-Forwarded-Encrypted: i=1; AKwUvBxEGUmXXvrLeA205nv5ZUEMSMVN2QDb1vXbbp9MaRwnemkXjSBItccRlzS7qh+lv2QNAtqWg4M=@vger.kernel.org
X-Gm-Message-State: AFuF++kvfAH9zD+hpk3LQTajlQCgTZevTscgfl13jLykqF2CHxSiCj/s
	hnexFY4Ep9baYSGg4n6pkQO7LQYpGAd/0r/LhTAGBweaA6mlMPmOqzku9lZmJVM=
X-Gm-Gg: AYBFou2y2G5cLM9ZFbzuV8x6qALyP9XPKFmp23LYuhpgVJZYzenKRTchb9z0OL3DV68
	WJPUEoWf66DBqm5CVOJty5QGvw5kMiLNasmoOE2/B7E7+ESEbx73E9I/7/dL0x1ecLk0t1cHy59
	WBiSdgSjKkcqPnO7Q7a67yc2nGBu8sgcQmDSZIgFtC2sfD/OdWisrre/FeuBq8VKcHNKBiJg+TR
	rxWdO95DeEBjI3748f7DjuThiD0qtp3o0oSI8VFCQbPDIDxpIB3Evc6gVrL/eooIYG0MgpqgsdU
	6LlVoxt+2bzWddtud51zjUOCo+Hd6q3am45tZ9h2BJpHMLQ9i24lp61CmhN2yqdMspi/U2ynFJ7
	zTCcyHYym1DLSqtebNQvpjjx3IlkX3QAYP+Pv9kLeYDi3lBNdcRbdhx6lfPtZ2A+/vc09PJC8tr
	iByx1urXuDxFXJU0izuNPNKfinEOqCPztcToMRVP1Q7m+ev9M9LHEZIEitih5l7QXeUbTBCQb7N
	rCusBe4gHIoP1Kc0KxObjUa7cQ8bltB/WoMe6gs
X-Received: by 2002:a17:90b:38c8:b0:399:221d:63c0 with SMTP id 98e67ed59e1d1-39aee292b17mr6402646a91.25.1788364936343;
        Wed, 02 Sep 2026 09:02:16 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([125.19.217.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b7bd00sm7327447eec.14.2026.09.02.09.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:02:15 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: axboe@kernel.dk
Cc: colyli@fygo.io,
	gregkh@linuxfoundation.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v7 0/2] badblocks: fix rounding bug and validate input range
Date: Wed,  2 Sep 2026 21:32:04 +0530
Message-ID: <20260902160206.322319-1-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two related fixes to block/badblocks.c:

Patch 1/2 fixes the actual reported bug: round_up()/round_down() don't
modify their argument in place, they return the rounded value, and the
callers in _badblocks_set()/_badblocks_clear()/badblocks_check() were
discarding that return value. Depending on caller alignment this could
leave sectors unrounded or, in the reported case, stall the CPU with a
non-advancing cursor when reached via the nvdimm ioctl path. It also
fixes a 32-bit build breakage reported by kernel test robot, since the
old rounddown()/roundup() macros pull in 64-bit division helpers not
linked on 32-bit builds. Unchanged since v6.

Patch 2/2 hardens the same three functions against the input-range and
shift edge cases the round_up/round_down fix exposed: s + sectors
overflow, and rounding itself wrapping past ULLONG_MAX. Revised in v7
per Coly's review of v6 -- see the changelog in that patch for details.
The remaining open item, bounding bb->shift where it's populated from
the on-disk MD superblock in drivers/md/md.c, is being sent separately
since it's a different file and a different root cause (missing input
validation, not a rounding bug).

Both patches carry Coly Li's Reviewed-by.

Ramesh Adhikari (2):
  badblocks: fix in-place round_up/round_down usage bug
  badblocks: validate sector range and shift before rounding

 block/badblocks.c         | 52 ++++++++++++++++++++++++++++++++++++++++-------
 include/linux/badblocks.h |  6 +++++-
 2 files changed, 44 insertions(+), 14 deletions(-)

--
2.43.0
