Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D5A539762
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075088; cv=none; b=RKIuQcmvjXnccKK9ckrMBocl7T1RgtxFUQy7P3BmjjszgVjyl/CFl5NcByoFXFaPnUyzlS/KyJT7alRNCnR+fWIuSnQ4PpdB2kAOUGT/SR/SF7bOitmEWAiVDgv5H15zqr5E3W9SPgzmW0wcGao9yH/gIUbLkAV1o+e/wZxVT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075088; c=relaxed/simple;
	bh=few1FIotmFcZp7B7jW8YwyLeKsebdxspzLy2dci/bgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpEzKlqi7NZVAUMQbJVCW3E2bkXtkhrPKqxM4vaG78e+sPJXNf8WPA15m5t5mBGLYd8UWmAlRo0y1w3zLYLGb/GE6ktEJ5VcMv3wGtaBHKWqmFigYmdaceqMcr2FNApZwt/GA9Q/ESgDjiKgdDgij7r+Q1r2PTiLie1UHatBey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvFdD2UM; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvFdD2UM"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d097b4939so21347515e9.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075085; x=1790679885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y8Sb3UtahVWC9VP0VB0+g/Yg6mjEycNdlcZLI//7IWQ=;
        b=lvFdD2UMvQe6S8FBjt+UGO+TQgmq33BLH5ugS6GkOIGQbjbYjEH9d+UH91xjem4JVr
         ppe78ZrAVUkKz8ewbTtbWq5pxh4IvJD1aFwbfqn6VpXeCgpqE252PIo7yBXrgeVA87/G
         SX0/M63jxniZc1YxTwPnzXfdQ8oMXLilDqvcSTPEz1XT5zWqcCjgaYmiW+kXQuuolPuu
         6JtFaVP8U2cxxI0VFjLrh5XUB38k98Mttxu4qLgGUdAQCi+hoRB2RPSxTB3o1AJTsCKX
         StoMqJ+Nt8d3WAipjpFf4pECGA+5hN36a/YthGYcxlOJQPSm45JiMZlWcn0ZYt+GxfNg
         NO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075085; x=1790679885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y8Sb3UtahVWC9VP0VB0+g/Yg6mjEycNdlcZLI//7IWQ=;
        b=bVV68JPmq5oPSQBDBcpcjmEiJz0c8hp67YybUEribJ7AB5LPEaeOYQ766CjQ+snJUz
         iLRrulcMB7EeusfVs+eyvkAEoUgnbKhCL1JyYaMkAsuy9RZ2Kpd98E3ZQax3JikpDLq/
         U+DAsioEYBdLMXLTGn9ya+1q6dnmtFJTH0pb8dVB7fGMJf0tPiVUpBIpz6W5U5D0xOPK
         IXc+PHU3JbtW4UvtwtcLFI/mlynQ8BChz/SlkxjBatQfdvQAbX717o5kc3umkKnH192G
         /zM97gxZStSt/C6hvMDSR/OrUsbbENh6mBYaIImqs30sjZKiYJoxuNrabCzWReqq88BT
         PJ/Q==
X-Forwarded-Encrypted: i=1; AKwUvBy9cLJ7WW6gPUh0Gx4KMfN9XXX2Ifx/e6xnZ7UrUALKfCHT6Ng91VR7g9VuFKwvp07z9BLx7vU=@vger.kernel.org
X-Gm-Message-State: AFuF++m6tNdSSQ9t2Z0xN22h5rm+6irSOUjhGeGEWadFCF0QpoD6x3S7
	gJ86Q2+/yBj/f0URH/O3hw5y9EHumC0m1xTxM7MaQmjKmgkPIcIriNeL
X-Gm-Gg: AYBFou1+5Ea7Q7KCmTJub7TnRT7qscNVjyQLz6acLmygS+Uojb9AHSEZ3tVjCq6lpkb
	QWUg4U1NlzyzkDZ0Dx5UAx5U3A2xRt6ukfCa0r1hwEe7hXuzTZrxFDfae5FsvcSx+cIEc9/s9LO
	W1ZHe2Brqxsr8pg5FBYvZZ4EfaIezcb8qtogcDbsH1PxmYPV2GkrbkplcIBpMYqB9jTAOxTdMwr
	3i4SrdGQUfJY89xocjk/JIOs4VcKk1MoeiNfe616eVUBNDOWr4u76DqimILodGPoesFf4GUYb68
	2XX9r5vPNqI5VVncz5h5T3/qpsg1nR5HdEwFNY3wwouAmIFlIV2iXITYaN6oZENmRqk7xSUqcF4
	mtOsJCvjR1/BlO1As0QPeqN+KpwBbOY24CTxg630diRwgw2NijoqQ5eIFl7CPQJoQTc5kOi+15B
	sT8+o3UHf/tNMJpeBXHnw9i77PF/yc+q3qV5PdhdYHV+GiX1656LLCpbG1y3mPQtpa9gMpLHT0a
	PVzbTn9f+Y=
X-Received: by 2002:a05:600c:1d16:b0:49f:bc8a:b103 with SMTP id 5b1f17b1804b1-49fc55c5361mr217584895e9.0.1790075085107;
        Tue, 22 Sep 2026 04:04:45 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:44 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 19/26] xfs: don't cross reference rmapbt with bitmaps if they're incomplete
Date: Tue, 22 Sep 2026 13:02:14 +0200
Message-ID: <20260922110221.1431-19-hackerowskiy@gmail.com>
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

LOLLM points out that runtime errors (e.g. ENOMEM) when we're trying to
compute space usag bitmaps are silently dropped by the rmapbt scrubber.
We ought to flag that as an incomplete scrub instead of reporting
cross-referencing errors based on faulty data.

Cc: stable@vger.kernel.org # v6.4
Fixes: fed050f3452da0 ("xfs: cross-reference rmap records with ag btrees")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/scrub/rmap.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/scrub/rmap.c b/fs/xfs/scrub/rmap.c
index 0cd3eecd2ca5..68e2847c962b 100644
--- a/fs/xfs/scrub/rmap.c
+++ b/fs/xfs/scrub/rmap.c
@@ -493,11 +493,18 @@ xchk_rmapbt_walk_ag_metadata(
 	 * If there's an error, set XFAIL and disable the bitmap
 	 * cross-referencing checks, but proceed with the scrub anyway.
 	 */
-	if (error)
-		xchk_btree_xref_process_error(sc, sc->sa.rmap_cur,
-				sc->sa.rmap_cur->bc_nlevels - 1, &error);
-	else
-		cr->bitmaps_complete = true;
+	if (error) {
+		if (!xchk_btree_xref_process_error(sc, sc->sa.rmap_cur,
+				sc->sa.rmap_cur->bc_nlevels - 1, &error)) {
+			/* only set incomplete if we didn't set xfail */
+			if (error)
+				xchk_set_incomplete(sc);
+		}
+
+		return 0;
+	}
+
+	cr->bitmaps_complete = true;
 	return 0;
 }
 
@@ -567,7 +574,8 @@ xchk_rmapbt(
 	if (error)
 		goto out;
 
-	xchk_rmapbt_check_bitmaps(sc, cr);
+	if (cr->bitmaps_complete)
+		xchk_rmapbt_check_bitmaps(sc, cr);
 
 out:
 	xagb_bitmap_destroy(&cr->refcbt_owned);
-- 
2.55.0

