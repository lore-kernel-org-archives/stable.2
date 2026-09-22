Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB149423786
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075094; cv=none; b=d8hZd3ozekFA8QADOI2ZoXfYzISypVqIiHbKgod/WlUXtIj6oLSL3rzohmibD/YBKaHFs1Cl6bFea/BrrnUhiuxQ1zlYhX6SDJLv/4Ta6/1MfwzZARTs4lFRHn/V2pItwxFpAy8tLgEpwBFoBis+ZtVxQXJ+asqLfuu7O4Kukfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075094; c=relaxed/simple;
	bh=oHJhqZKjusj+lQb30WTpZrX0EwtZKLelruVb3djpsao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iosA/ZfXTpNSmfhGg5SpZRtgAGtzSwMrd0OJB3iJItCC05cnWo9KmXp1qDxSv9vFceuACi7+x3xqIaN4jppdjuzCwQdatnI5KBtmfuEJaI4L8chpouYNu2n/KMgmk7nxBIcanwJdP3YBFyYFAYmM4JV92coj0e9d6ad0QqaRLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qSB0UmJK; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSB0UmJK"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so53646395e9.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075091; x=1790679891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jzz0K8zNN7ZLPek6o/Yler3vVjJkWVf8pnM2oEZ8RVE=;
        b=qSB0UmJKM/gOcDOOF/1HRkUynKYzr4nqHnCmQiqOse9kNNpYFI2g086zWMo1M3q4VK
         xERxRwAYI/XlfzAbhNhebi9GDyveDCf9b1zhEuIsP2EGe1vvD+n79bMaRg7oaExhTaLg
         MgnXh+/7znnFluYSwN+08ZUa1l2YSSeSqdRiTBDQwdPHN9dd/grh8m8IFW2E8iVAEFl2
         rAnd5uX37JxHVKJdKbUuLRagzqDFYYzvHOX9QpHlqtauGhm5qezlS0DlrowHkmRChvGY
         C+g8it7gXOKPh8svolanPXgH9bMY+ALoQnlxjjeQyznsb5GZ6syR3SyTd/3Q+85ot2EC
         8SlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075091; x=1790679891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jzz0K8zNN7ZLPek6o/Yler3vVjJkWVf8pnM2oEZ8RVE=;
        b=VBdnuKQEHVWb3SRAPhOUsxsYWXs5SOTRhDSTMzo1xT5BpYUB/NWcXb9k8duGserJ1y
         4O9yXyQ04kwdkv7QHiQOvB4uPFPQwS6J9voWRsqx37L3I65o0VTFmIodLzJhYISBeioU
         kxGzJlHz8//vRd/W+RXiIK2MKwi4MVXLkmcwn05eGssTg2qrDIghMoPCHGPfNzB9DA/m
         VXf6apYeD0wv/XwPrxhavsyD+fJM1y2SzjGqTf6QfAaaHoigaQcE2ZZXB7j/zxDXkWjf
         SE2jf8uW2lZb6gSMZ575eD9Tt3+VECGzZY5L+qKCWLGVGGOecAP1vvfobWYxChY+ROGr
         ug7w==
X-Forwarded-Encrypted: i=1; AKwUvBw8yP1GyjSMXKF+v8TTbNhJvFVr8YVPiPDlB53bmFHouxzuKuTEqCcpLM8ft0AzuGTD2Wg8lnQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mXhmudG1glTWpeB1LtRhTr8cuKpX2KcBDgHr4r4RbuVkdWxhh2
	jADvAJNYZyg5jmbITO5Fxz8F2EY8yNwrZ/nojisKmDsKCPdoJWTi1XpI/LUmPW0f3sw=
X-Gm-Gg: AYBFou1DGDTiiV9h61wS1ojrY+Q6uy3/JTN2MmVPM8lB4wcjd1uyTjKDMYpAE4Vt2Cf
	dEwJZjC8O2VMk9kBPYXGSZbQDoo9Ww/mqBKZJ4Egcy8xzPRjhx6FWEawTCmelF7Yr0ZCutB3Qp/
	dLbKMrTVq21Th4LMRul8G9S1JTUFb64TMeaPgdt/SGQBZiHGEREL+B8WE7IlwesG4PSJ9Sao5rZ
	swJX3/vDSHL8r+w+YSdw3+FyCSN8Qb75ucI4EOMKOFHE9jdMBhkLQraFnuerxqme/Fn4jjqP5FN
	cdNNfP8HIWTRyIrFXje7MrLOR3lWJcSk3Lj4k2iOicL8uY9nvId7xJ8uLYYcTvtCJd2pZEWMYTB
	o4hMkrngiB40g+6JvQ5RHGC5GlkgHXKwSoQOBi+Uk5VTKlZ969Oa6eUuik5rjRrZ+OldA0zdALz
	2G9/4R/VA2npEekqV/I9g0kmPO0kbCXwAVmn0jjvnkfrcMeK7GHT2tQ7DPxnsUiGg/ZTfKJzst1
	STHmeh5b7kNCzSwbAm46w==
X-Received: by 2002:a05:600c:6214:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-49fc568129emr185563965e9.6.1790075091041;
        Tue, 22 Sep 2026 04:04:51 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:50 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 22/26] xfs: fix blockgc group quota scanning when usrquota isn't enforced
Date: Tue, 22 Sep 2026 13:02:17 +0200
Message-ID: <20260922110221.1431-22-hackerowskiy@gmail.com>
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

LOLLM noticed the copy-paste error here -- if user quotas aren't
enforced but we're near the group quota limit, we fail to set FLAG_GID
and hence we might not actually free any preallocations, causing
unnecessary EDQUOT.  Fix that.

Cc: stable@vger.kernel.org # v5.12
Fixes: c237dd7c709432 ("xfs: flush eof/cowblocks if we can't reserve quota for inode creation")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_icache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 82dac88e3c4c..de8be344e987 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1653,7 +1653,7 @@ xfs_blockgc_free_dquots(
 		do_work = true;
 	}
 
-	if (XFS_IS_UQUOTA_ENFORCED(mp) && gdqp && xfs_dquot_lowsp(gdqp)) {
+	if (XFS_IS_GQUOTA_ENFORCED(mp) && gdqp && xfs_dquot_lowsp(gdqp)) {
 		icw.icw_gid = make_kgid(mp->m_super->s_user_ns, gdqp->q_id);
 		icw.icw_flags |= XFS_ICWALK_FLAG_GID;
 		do_work = true;
-- 
2.55.0

