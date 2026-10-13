Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEB9395AE4
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883076; cv=none; b=j67Yv+KsDwK8umUsoSn0LZVT5punkSFimIGk6iRhF0X+EbYeUoyNLHbsnyND8BSFD/T6g4VcxILNNavb+8q/tnyIhmcOWEhpOE/9pKVVkOlpDbgBLis9vVISHFQO61QkTKQNWNqU3ABwLI6gVazqmfueovWTbd/FqmcdwNk+k2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883076; c=relaxed/simple;
	bh=b0WouZwkIzP19EsEq0Zzmc3OoBcJHUB8MdkLHNx6RI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X87Gp1t+ICaYXbisRqmZyqMYXJjVikDhiXQPNzaEzL9TSAjjGfJX0N4/aegRpRPJAneRZ8BMsn0f3cX2dihLgG4nakNKICvcBM5E1elTOogRPKM6ZgJ7/q7nSZ0kQZIIXGhHShRHgXR/oD8jrEuHyuzbXmYMVvWybkiTyYhUQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0WfxoEw; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0WfxoEw"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33bb5afa736so292331eec.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791883074; x=1792487874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MIhtYvHUWNyU/lt1efJRDPOudyxWKfzxLqq2jTOG1dg=;
        b=f0WfxoEwmmLYF4PLxdosm/HQ23XDjboFttsfEtyuUgup0BM76NJvHlbraYakKLdb9Y
         jRaD3Y+sX7GU6DVzuJQ6hHZTJp0TpogKFDWzVZxaY8WF3qIFMCsvWFIhk/YQ3wrood1F
         N9PMlmRjdhxJwWKRlLXs1OjOmLe6QRTrTRk3BFKlHnm2H+Tbjcx+ngDbEgj8/c02p0nX
         R5obAX97644MNco9DL8KhBbW1H3dj5a1rPXvtMeyL5bUuIDcGnywXU0yDj/PO5l2Cb7E
         OnpTKxONiAQO1j7dZU33EbF8dAf4uv6384N/aH5aiMm1SPQ1Uzx9uIGQjVpVvlMwrDUA
         hrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791883074; x=1792487874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MIhtYvHUWNyU/lt1efJRDPOudyxWKfzxLqq2jTOG1dg=;
        b=03iEcMN63ULj2P4dqAFm+7XQJWoclkSYRJGljri8G4nPCbQd4rQMCBG4tjY4Mg3S4O
         wlqhKrnkg7YhvzLlMLBCijEspUpi0gBWUYm2jz/GbYhI4ToYH+L3zg24w+4OTwq4atVN
         kI8TInlCiY8ToW9oeEsbZcEMYQVCNy80rjmM3QpyVb/1HZXvQv3xPiRrkk736OgE2uul
         qc3qEjoj1sXbeqNPXIPlkOMsGaW0gYmGALWGMKsq7MC4CafnRIEsIwqYkWsZplOe9v3I
         YxWzDYiUBbxpPdtb4EbslcYuzJqjh5EmAaY10XhSZ1mJi3XDGcu/IgyNHCZGymkgkswg
         39VA==
X-Forwarded-Encrypted: i=1; AKwUvBzWo/zPdGx6eW+9XnJtuLBb+GCP4hpcwXDcdLpngbQNx/t0fxRIoliQyK3Tf7vgkTyzn5uO6sM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhYV1KVVS1XZF7SzcYPeGq55IMkh0Df30VUVfF5p/9l6WW+OsP
	PwzpQ4N+OtGc8ETBJJjt0oQJqaACi84sNUhlTjWB/ZUf2my40sYWGEyb
X-Gm-Gg: AYBFou0SrV5fMSfVE4JyhyXwZpsUhMWromNAoFKkQQj28ZP4VUyCkZxpcwLXcSf/Xwb
	V4PrxdAxE2UV6a/kwPaAFhLk1y3F6W6oLe6e5GSP5eVsFU1BxJXqM8k12PHGMbvyU/kYc8kX2fv
	F3Q2VeNJLU9fSFGiHu750ZZRGs8TL+8Hx1noQ79vce1dxbSx1SFKCWHdfSLZ/VBNiOx9Jc2Y2nm
	vJnlhLhhjS022e2DychmUi1emK/P2Rzu5yS+BiymdXSaa3KlsycUPcFci/MmnoH+Smaosp2TlV4
	o5ChoVK75nHTtTYvMgNpk7Xdkdz1RrlXbAMPxk+l5XcN1lP1m6lzT2PG137ZlEFbgnKhdfYD/nb
	ARe3t6Y/RBE7oWoykIuROY3J4OKANBHY6rv3n22ZaSUoydh8heBRB218+KyNoIkbbCcpoVG0q3c
	Th8sz0OaHC8JLmYrVAzkxobYHM+IHBkzXhJe/XdHQRes7bFprBCpI6Ahpa/DvOkmHipGQw5Salt
	xotoRJE/Vleen7QyTKvw1TpFlKgSVtjCEC46fPEiaBvnKRJ0fEcuvMzFpehlrK3
X-Received: by 2002:a05:7301:428b:b0:358:7ed4:a049 with SMTP id 5a478bee46e88-3587ee40938mr18688457eec.0.1791883074227;
        Tue, 13 Oct 2026 02:17:54 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb6a279sm41437975eec.30.2026.10.13.02.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:17:53 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	mjambigi@linux.ibm.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 0/3] net/smc: fix link group scheduling, registration and work lifetime
Date: Tue, 13 Oct 2026 17:17:13 +0800
Message-ID: <20261013091716.1210420-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This revises the two-patch v2 series and adds a separate fix for the
running-free_work lifetime issue identified during review.

Patch 1 serializes delayed-work admission with the freeing transition.
Patch 2 gives early cleanup a single teardown owner, pins its callers,
and rejects first registration after teardown has claimed a new group.
Patch 3 gives queued/running free work its own group reference while
retaining asynchronous cancellation to avoid the existing wait cycle.

Each patch is a complete logical change. The work-reference acquisition,
cancellation and release changes all appear together in patch 3. Patches
2 and 3 record their prerequisites in their permanent commit messages.
The pre-existing callback issue remains until patch 3; no earlier commit
acquires a work reference that needs a later patch to release it.

The original KASAN excerpts in patches 1 and 2 came from instrumented
runs. The registration and running-callback gaps were identified by
source review. No new runtime reproduction is claimed.

Changes since v2:
- Serialize first registration with the freeing claim, and clear conn->lgr
  when registration is rejected before it acquires a connection reference.
- Add the running-work lifetime fix as a separate third patch.
- Correct the cancellation comment and document commit dependencies.
- Rebase onto current net/main and validate each cumulative revision.

Validation:
- Applied the exported patches one at a time in a clean worktree; each
  resulting tree and commit message matches the corresponding source commit.
- Built net/smc/ with W=1 after each patch, with CONFIG_IPV6=y and disabled
  (six successful builds; CONFIG_SMC, DIBS and INFINIBAND enabled).
- Strict checkpatch: zero errors, warnings and checks for all three patches.
- Runtime and SMC hardware testing have not been performed.

v2: https://lore.kernel.org/r/20261003183237.2284245-1-nicoyip.dev@gmail.com/
v1 scheduling: https://lore.kernel.org/r/20260927074520.3694663-1-nicoyip.dev@gmail.com/
v1 early cleanup: https://lore.kernel.org/r/20260927063607.3691520-1-nicoyip.dev@gmail.com/

Chengfeng Ye (3):
  net/smc: serialize link group free work scheduling
  net/smc: serialize early link group cleanup with termination
  net/smc: hold a link group reference for free work

 net/smc/af_smc.c   |  8 +++++--
 net/smc/smc_core.c | 59 +++++++++++++++++++++++++++++++++++-----------
 net/smc/smc_core.h |  2 +-
 3 files changed, 52 insertions(+), 17 deletions(-)


base-commit: aaaaf87ea99b8766c9a8aa0e71aa42e6bc8a5320
-- 
2.43.0

