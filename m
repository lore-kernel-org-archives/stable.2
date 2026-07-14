Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435533921D6
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029908; cv=none; b=uJEtyIqVmJjw/u6MyFV3/oTvlWgf5ZCj97oecTB9tA/z+fLv7bz6meW4j5GOtTpP0drjfq7INDIBMxH0wlBgrZMvqVc2/6GZGVoxozOMljtxjSLRvZFXDgMRZDhADkbUiyOD5J3JHHMGtMwJuLmjGfArsvVEt9MV2VR9nHwfbUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029908; c=relaxed/simple;
	bh=vl3jDc1g7GWPDBQYE9IRz43uzIH+JdTPGZ6uFY1GAqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mXJZEu6d0WZZBalansII1ZJrYwF0RwITocUIYikOyT/dy3amZq05N5pZ6GcK2XsBbUTb6vwHM70pj9TWMsV27IoLMnu5d7KH3joiyTScyAuBXkH1H9nIgnpww79jdKtQse5Xm5DXDFIs7+JN84FMoG4JL6Ecp7ad9vgR9/8jpqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK7VWKZJ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK7VWKZJ"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e50c5d14cso254847685a.2
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 04:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029905; x=1784634705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zzvk+OtxgX2+/Xe80MvgZXwO6U2S4TROVRo8PLXigpg=;
        b=fK7VWKZJAmq41EYuW0FErPL2mQyKth8bRAaRz+fZlG/18nj3TwaX9JtRnqNOahAn0F
         nNiLuaTCCvgGgX6j6t+FqfcrkDUFBSedrh02tVDVJ2sMbP6kqQBr/szhTaKTAFbkfVkE
         aFsFLmHDqd6grEy5MLS1cv3tWpztuirxGy06cF17Xq0K9c7Ub+LpGAVhhCUoNWrk8Tph
         lw5rkyzVZQqf6YX+ip0P006YE9BuQHe9QzpCCYYQpa//BeUZNKwIGAXlPzst58rPgsxz
         +6I0nFWo0SQZDkOzkHPfgZWZm3QQVLCiDFAPj8gNGZTFGKptkblOu+DQLfPFHoPz+IRA
         O1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029905; x=1784634705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zzvk+OtxgX2+/Xe80MvgZXwO6U2S4TROVRo8PLXigpg=;
        b=N4U9W2E7Z0Uf8FvtrHOa0hOi1c4FxYWhQ8SUi+e4w4ALbIq7OpJphsH8HrB/r2fMEc
         Q7H1ev4omQIFjeBaYLQCdjHUYlgf53s0Ks3hhoh48qV/SnFuVhYwR9ORBUX9ED/Bnpp9
         51sc+gFz6HIxQ1eRDsp9S4/YK7ZGzK++aefpmpkkeH3gRNBE99CmJJFYONmaSQmpwTrz
         1sRVE1y8zk2+BsfHPCDzECU0MzHQaZbcGHueO6mZDgOf/i2jg+NP9ip11qqCBuAwQimK
         3devjJuZtt9kMIbKwo2IJIQQ2xK5Oi24cgBDwb/xUhWs+AeChg0YJ3tGE5gPje6bWMdl
         Xrhg==
X-Forwarded-Encrypted: i=1; AHgh+RqF9fYMjwePxFQPTQftc4YUf+b9vV7Zg+MyUUtpBQ7jZ9M/MwUWZ7jMzYwdVXtTz2rOZFQF05U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwubTyijKWnjXw00yurdKOtsWyGQDDfw4xMURwjeYwO4DheDx1J
	4cqV6VvD2VGiomUbs5/kdplYMZninLBupCfESaodITA2WX78zi3cgZYM
X-Gm-Gg: AfdE7cm1kUhdTy68tXoSqff5pcWXiBVcbRWrkx53wNiS7Ch2RLymdm7EWxvtSnfuVtG
	AS7bHPIuc92uMR6kmUkY1TWB/o680CHXfJn5PGbsOT3CLMFE/SFcomIIKu2oNiCrxWO+Ksooy78
	cDMyTfKLt22jJBajTZ1yQL9DgXfzp9ijYFu+KXtZhLY1zi+IIF08kG8yD6EhNneJ11XGyV1JnER
	70EWG9XANYT1+Ul+wLULclbsAsJ4XTT9NvBChmELpawFVbWRuKJXfXQk7t57lkFFJG7kO9hLO9O
	j1u9iYVQAnfVTgX22TXCo/4AprmVCHcClUB7w7kOeGzbgvNI0/AjwPHoJQmjmisF8kC1Fyg5u5f
	9vCAxZu7PLmtKuGhx/PDTL0cClTdXCOgRNQxkQwNgfu56y9sewcOcpNsT7yzc781y2fanorZ5/j
	UPfTO1RpwzNHI+b1XAXXAuaNazO3GSoKIl0pN20vaNQFQL5h5xitRn4X3mrYWPf8/VipEfO1tTA
	zVqqF/0ZBTvmDfJjQxp
X-Received: by 2002:a05:620a:11aa:b0:92e:745c:6c5a with SMTP id af79cd13be357-93083c2788cmr204459085a.14.1784029904930;
        Tue, 14 Jul 2026 04:51:44 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d6c28bsm1479415585a.46.2026.07.14.04.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:51:44 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] libceph: validate OSD sparse-read extent maps (+KUnit)
Date: Tue, 14 Jul 2026 07:51:38 -0400
Message-ID: <20260714115141.3768034-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Patch 1 is the fix from v1 (unchanged), now carrying Viacheslav Dubeyko's
Reviewed-by. Patch 2 adds the KUnit coverage he asked for.

osd_sparse_read() checks that the sparse-read data length matches the summed
extent lengths but never checks that each OSD-supplied extent is monotonic
and stays inside the original request range, so a malformed authenticated
OSD reply can advance the message-data cursor past the request buffer and
hit the BUG_ON(!*length) in ceph_msg_data_next(). Patch 1 rejects such maps
before advancing the cursor.

The KUnit suite in patch 2 drives the real osd_sparse_read() state machine
over a synthesized reply (no OSD, no network). Confirmed before/after on
v7.2-rc3: without patch 1 the out-of-range case faults in
ceph_msg_data_next() while the in-range control passes (1 pass, 1 fail);
with patch 1 both pass.

v1: https://lore.kernel.org/ceph-devel/20260710022837.libceph-sparse-v1@bommarito/

Michael Bommarito (2):
  libceph: validate OSD extent maps before cursor advance
  libceph: add KUnit coverage for OSD sparse-read extent validation

 net/ceph/Kconfig            |  12 +++
 net/ceph/osd_client-kunit.c | 146 ++++++++++++++++++++++++++++++++++++
 net/ceph/osd_client.c       |  34 +++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 net/ceph/osd_client-kunit.c

-- 
2.53.0

