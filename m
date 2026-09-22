Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6314FC8C3
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075084; cv=none; b=VHKvEiNPL/sf96kwYenzWQQ0Pm9n45FZAf+x48uyGNxBEC/XIq6ggZk10ZmFVKZmgbIY5OgBZLsNQzAIGx29M84IvxLeMtLVFD2WfuPT0/2kfjJyHVGCtG71Ibby+Jk3+7zj4KxQ5/AOaYr1QPMajtIKDb/rPTQnF241i5zWCIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075084; c=relaxed/simple;
	bh=PYzSkL852hcLeUFxSoaRxJXgoEzcGLF5FAIMBv4Ogww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q80iGQvib7Lbmk9FlCP1w1tSTmxmQlbnRZnxkt6A/orqEHVSTF0tYHnE7jKKKgu8hZuxwLSoLr6TUdD4RBtQyRokgGggE7GCpqWGRd6q7eOck5Wy0DR+0zmTrqmc/gQCRWtxGnKtvXVZxLeGA7TlVdYmrwX+GnwtwWB0hqO9yi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxW9+puZ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxW9+puZ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso11174125e9.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075081; x=1790679881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2NUp+T7FsL1k/tkMnskFv7wW1SlQORDRxaD0LCyU9b0=;
        b=cxW9+puZOaCXIx0+MAwecAu459B5efUFPBoxLJlj7FQ53ZTRu0HB274oUBcFpcPzQ0
         ts3chpkfEXHF8zNbfQeElvhkQs7jl8hBVq9erNNXbFavSvTqFNhTGlTBrw4RYqsoKFD0
         clmEz7/w1nEZ/+rLSHU5ekDufTmWzhQ85VZncFoIiJsJIPfqsMojC9Cy+WZCREKM3pSF
         LfbBGhRd12Bux/BomObnVeoUlbVbAMoOg2xGgPkZ15meaLO/3HdSggtaRfHKKw5hPcwQ
         5egVzgv7W9ZzbCfzEfRNCHGKFRM/OePcv+hOt06ChOI1PwBlfodmGpyA3IePe0PMnDSA
         /0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075081; x=1790679881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2NUp+T7FsL1k/tkMnskFv7wW1SlQORDRxaD0LCyU9b0=;
        b=Kxf4IfU6AtSD8M5KbZp41D37/RZWsQ2xMZDgMitz/KT6f63Pu0FCUBIT9LHszbEExx
         TllQ96yFVFl8LBSVWkWzPFBkzOfUeXANd6TXh+Af4O1ms1Yj8iuLtKQqnaDu/ewtDTUv
         tYxycEJb5LeYGbPyr+Qt9FLXK6i12EpsAHW8bPPn/vFmMvURJ8XN7pfhtJ9fRtUvp71x
         0VUFnglYwNifyR7vCYl1tp0ead5epPA1IP9t3pB6yTU07z8dqAVR6Nm2JiHJoVZXHx5+
         IVEUK2qQIQdqJnf2NTWbMWjxutBgbTGS2a1Ikqs3pQ4mCeXE55Zhxalho9gG+JXLAubc
         LAbg==
X-Forwarded-Encrypted: i=1; AKwUvBzZtDyoN4FtXW0lbGueFsk2pflGl4oUbN/HQzaW1C3X3ETbO8OpoP62b1FQfUGw7eIVc+XGRcI=@vger.kernel.org
X-Gm-Message-State: AFuF++m8pTC7JxwQiaZYRAK6r5oQ89TFTxLmJjrmuW9/TbkqexQQgEX7
	/nioEc6rRxkrE1cOG9IwixV0r+8aJM5TXsZ4WpefOlbjfAJRQufjOVqb
X-Gm-Gg: AYBFou2yIXCJ5N0skXBTrUWw7hJ0zvQUBrybn+d0EqU5N50yN7Fy1z5Kkcyj5HMk13y
	JvW48vqvA2+M6RGsb86aQLU6F79rvJqMnm0bxqxsJnxvjMzqHpERr5+FlJG25eh8V9gMLAQDqdc
	sDm99CiN4LVNYt6mQq8q/4JjHHzDDTSO9hciWsQ0x+trO/Mbj4LOhdy5uqAu9d5Ds/HbrrVXMmT
	HtFB22gACMrnVvkH6niGxAqFaMjEhagOdFmnJolr2eM9L3kRJ97/n4S/H/4QHmVg7ENrI6Z5uFz
	jSJLuV2Fmb75y6eqBYtjBKJddy/TLsJ7OhlSvv3oGAYlbZs2AALn7Gz0N6XLXtETZg7f8v8s+RF
	PDG1q35tuzTukTPJVBzdVOhCKfc4+2BP4PmK0TbFqXw/Asyg/+s8z8uwnceoSX5P/flJjGMYNab
	oziBHjUhl3fMh1xlK79ABbpHHIX8nn6a8NVdLySyeV+n2r2SHC97irSi1I5TW4FORhWnShcdQ90
	LCitqsWTSO2d52GkqwgpA==
X-Received: by 2002:a05:600c:8b38:b0:49e:63cc:6324 with SMTP id 5b1f17b1804b1-49fd8860a5amr39629505e9.6.1790075081018;
        Tue, 22 Sep 2026 04:04:41 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:40 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 17/26] xfs: call xfs_dquot_set_prealloc_limits if we installed default rtb limits
Date: Tue, 22 Sep 2026 13:02:12 +0200
Message-ID: <20260922110221.1431-17-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922110221.1431-1-hackerowskiy@gmail.com>
References: <20260922110221.1431-1-hackerowskiy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

Now that we have quotas for the realtime volume, we also have
precomputed watermark limits for the realtime block counts.  These
precomputations should be done any time we change the rtb limits, which
means that xfs_qm_adjust_dqlimits needs to ensure that if we installed
a default rtb limit.

Cc: stable@vger.kernel.org # v6.13
Fixes: 5dd70852b03901 ("xfs: create quota preallocation watermarks for realtime quota")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_dquot.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index b4f6c594808c..e696ee36c2e8 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -139,10 +139,14 @@ xfs_qm_adjust_dqlimits(
 		dq->q_ino.softlimit = defq->ino.soft;
 	if (!dq->q_ino.hardlimit)
 		dq->q_ino.hardlimit = defq->ino.hard;
-	if (!dq->q_rtb.softlimit)
+	if (!dq->q_rtb.softlimit) {
 		dq->q_rtb.softlimit = defq->rtb.soft;
-	if (!dq->q_rtb.hardlimit)
+		prealloc = 1;
+	}
+	if (!dq->q_rtb.hardlimit) {
 		dq->q_rtb.hardlimit = defq->rtb.hard;
+		prealloc = 1;
+	}
 
 	if (prealloc)
 		xfs_dquot_set_prealloc_limits(dq);
-- 
2.55.0

