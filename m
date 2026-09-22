Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EFB538D98
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075055; cv=none; b=AnMaU8JXUd0YxzKtJ4e9gVnOPyuwdD7mlJQRJusiIsprCx5yUNkMHYPcY0+Iz59BbGiuL60o7HULS7AfQv1rlUshR6psFYL3jSCwIHwpyYBnUAOl0R9hCqyl452gbdR8LpIa5LFKoQ/nVtZYm8cVPaNFCTvgpPWEWa47KB4EdTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075055; c=relaxed/simple;
	bh=MQ07qdZwRJN5TPrVgC9wQn1B0ig5i7NbbgRdAMmKEQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjnrT5g5w8Mp0rzOdXh2JzPVdQkEboinOjpTuA9RVxdj50icuucJyMgT87Yh2LTAdW5nIjFi6P/NThbPy1WB+1gcJcGZzusRAmr51n4JRvHid/xUtIKdcgh4epteBfMiZl/NJ/trJXr74RYd+qtOGocSqcGSqiJN3+VbaInwzE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XltmB4kU; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XltmB4kU"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so22443495e9.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075052; x=1790679852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HHlJUDZkTBPV5xFbs75F2S0PhK46oENSM0ezl5ZCvGA=;
        b=XltmB4kUcTX05O6nOH1MVkjm1u9p9W6WGIqA53QROQU4k8AF5lslofLfwY37xIguSx
         7pEhj4hMf6HFVXmvJkg3D0t+qZiF6no9lTXXXY4j+12XYTwUlfAMs+cEPRY0VIRkS2g0
         nkLPAghaQqi6XtcSSfdlS2nUxwb1gbMC2HU1WMmwepzLvjQCh8wF/1ZULFlMRNNacmRA
         1G32oYgmpGO7z81JSIsluZCZBWgE7AzO9jXH9+1XbjNK2x3Mf2PTGEKc2mAn9fvBHwsZ
         uhnB39XGuMObaBqxNHI3sK385n6GoL+ChPOkzHPAuzudz4++5z59qW4q4n72wvM11T83
         Dnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075052; x=1790679852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HHlJUDZkTBPV5xFbs75F2S0PhK46oENSM0ezl5ZCvGA=;
        b=motReQnQRVqGlDIvAPwwW2q4u1FLLaSihD1KKiEA+T5j5E+J5ewRUrwJ6Y13ntF1XF
         BHgns4tuMBaJAUFh9HHvqkfXVaE/bQTXjn72/+mxIf8vht2qcCR68HedlCzuxhjhtGOt
         AUYL1lZs7SIY/ZthKGNn/gW230ZZxQIA0WmlOYQJ4SUEURcMXkbxipWKzz0QRQ5wrwDX
         WbqSWcRLTqevTtqpKSvfF3Ih5g3UPavI+PMneaWlrKUb6qgB/yGeUrpsxS0gqd7VBntK
         2ZkpoJR3iJMiY1uhFLcFKZpljEU5H0BttMvitaJkQ1QnEs/X5SZI2gm/hEaLFSV7uAqj
         gNlA==
X-Forwarded-Encrypted: i=1; AKwUvBycCYc6G784RlQyBn/g9rdXUsSxx8q9yKF8BdN2nW5XJbKkeljAsFSVM0cnvoKFfaRO7L8ScjA=@vger.kernel.org
X-Gm-Message-State: AFuF++nBa6UUY1Fo3D03ziTX9Lk4NKtJYMEUihimcEMDk2eMOmc6yLGx
	2yRi/YK3f30fLBHvVKIErQCmSH0J+kt2OtNp12ApRqrExISDlbpm0k2uCmKS/y0ngYbwVg==
X-Gm-Gg: AYBFou0jRbDxcdj091YzOFDwTvg7mb59NJHq8z84YCt8bWH34OPbV/BiL5kYG/8nKGp
	cKjBg4rYwh6wiiPWJoPzvt/JtjUcFE9EWPKj5bxolaeI15MieoFCgrYkQf5xVFZw88SUMwY/wC9
	FZZ6MWcTagPdXrFW3vGEKn8FXY4Uxk0xCob/wZtlEFEsk0+XSmvKAGRN3elg6eG8n/5PV4FIBh2
	yKlTq/Seu8nQOdl5kPdbnlVfizVGOXpT5DLkxUCXwsth7KsYL8ZrqHFcq8FWfn0cdj/G3Pu5MX7
	mRMOImJgdCa9dR8ND9o+HaMEVCSodhiM592WEZk6SknQGFtuG2bo0j+F703cHOtJ4s2078cTebO
	kO13hDFNwpkbihIiSZAWX77dajw+pINfprygnXWRMgFkkKq/eCk09HPAk0eMtR2XVmTSMEV/Vr+
	J+/NvQ498b4FJxxv4M4g/TC45/IMPrVF2pt0b1hxFV0yiAXR3TrEX1yFw+Wh4+6qCCTGQNMFrtq
	YpCNBSrBlqRcouCec+NT10=
X-Received: by 2002:a05:600c:4e90:b0:49f:ce78:356f with SMTP id 5b1f17b1804b1-49fce7836a5mr146194475e9.32.1790075051550;
        Tue, 22 Sep 2026 04:04:11 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:11 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 04/26] xfs: release orphanage dir inode if chown fails
Date: Tue, 22 Sep 2026 13:01:59 +0200
Message-ID: <20260922110221.1431-4-hackerowskiy@gmail.com>
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

LOLLM points out that we leak the igrab'd reference to the orphanage
directory inode if chowning it fails.  Fix that.

Cc: stable@vger.kernel.org # v6.10
Fixes: 1e58a8ccf2597c ("xfs: move orphan files to the orphanage")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/scrub/orphanage.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
index 3aca66869b80..21e31eeaa042 100644
--- a/fs/xfs/scrub/orphanage.c
+++ b/fs/xfs/scrub/orphanage.c
@@ -192,12 +192,16 @@ xrep_orphanage_create(
 	/* Make sure the orphanage is owned by root. */
 	error = xrep_chown_orphanage(sc, XFS_I(orphanage_inode));
 	if (error)
-		goto out_dput_orphanage;
+		goto out_rele_orphanage;
 
 	/* Stash the reference for later and bail out. */
 	sc->orphanage = XFS_I(orphanage_inode);
 	sc->orphanage_ilock_flags = 0;
+	orphanage_inode = NULL;
 
+out_rele_orphanage:
+	if (orphanage_inode)
+		xchk_irele(sc, XFS_I(orphanage_inode));
 out_dput_orphanage:
 	end_creating(orphanage_dentry);
 out_dput_root:
-- 
2.55.0

