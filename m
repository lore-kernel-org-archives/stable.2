Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C51842F707
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424982; cv=none; b=XacIAfLhv4GejroahvOJlS7R5GX+tDClZ1qA3FuhXOIQ63/Fm67Ds4pnB0ids81jfjgVjo4ZDYSgdXzcKQ1XpQXK25roYHazpBqiqK/jgjI9gj38HLYpfBdB3emgbEiZHfVZlP2dDQjSajN6t8hltWBw8Y3nAJlnex7PbF1teu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424982; c=relaxed/simple;
	bh=fu02ZqAH6lSLwaynlijzUGde2pYIBnjWQknKytijo4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t24Z4scu5G+a9QuDxdic4WfpSw5721v6SIE3cP4LNCuWgeRJhaCI3e40jgSjTQ5JpOlGeNi8uWbc3hbgLiDvX9gdQWKFpj6vfGSL4MH4k7JnVKzC9vfsv71axUJr02jG9b5Dwa4oYEO6QQttldyjJdnL+jE5QiRGYRO8fKvtDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=WXtjm171; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="WXtjm171"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d032846c95so10678605ad.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1785424976; x=1786029776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q9N/xBNRfsFXsnatt+u3psflJJ1kQifwOoTJGMZ+3bY=;
        b=WXtjm171OcS0QguRCyobzkc60CmQE+2dLtqr8zP0fgXCBCg+1Ert0YyTAGpyETLPni
         bWcGfVNzc9aKA6gpxkl1a23zCQ73Xh8H9DzSMdWX5qG2RYgvZQ3G0HRYGKlgStBzdXTe
         4SD8c6FGL+iIHgHcw01RDL7JgWNQZOsn+bmYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785424976; x=1786029776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q9N/xBNRfsFXsnatt+u3psflJJ1kQifwOoTJGMZ+3bY=;
        b=Ydbvj1r6XIu7EdoHKNgoV0b+KhioUFof9EyM9v/Fy180e/OJ18iHBBMI8JO48RpxpA
         jCGR9RH2kzsWXzqhV7LutWKBxoJGMS7V7bgk5bt07J+pr9Zfy08yihEkBOywnzqMxeXV
         7jAu3ia8LutWvlfy16KcRj0BHRFDYAPjm+X+Mim7CvCTT2GV5mF2cGB6uYt/ITgu25DP
         LK1LMD6cX/S8RYiifcFg9mAkRXnRWC6JBHsdR+C0J0fTi6o5UV5lql6DHXSuzAI9N13I
         BClM7pcgPHRQm0BGD/zQ6GKSHNsbpuMCmFTEQCS7x9bCJRB5x4j3cJ2I4IYF9Lwr5v3Q
         3BGw==
X-Forwarded-Encrypted: i=1; AHgh+Rru1c+n47Br7VNoIf7BO/KrSYHkt5a6YIPv017GbrFcO+fd5mGZkdqkx3fbySB2muavgJwASO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7h6JTuzoYnvtwzIPHohw53JMLruKpnxLTOT+arSDZalsQnDuS
	CbCB40Iatu7f+ILsp6PJjZcmnARb7tpIkcDQ+WSLtXm7QWaplB/zRgciEAknp2W/hBM=
X-Gm-Gg: AR+sD12S6byjLD4BH+D7n0ja3bo+9I7d6vuZLNa31MSDAYZLy6IO2yQmacHs6rAv/rs
	0Byz3kOBDHuvzvoVYIkM1X2h92NGgm7h+iYQHPUFY++qF6sOhJNw/gJZgGdOCciT8p4pxxQCB6Z
	1IWj5pTdCb0fta4HCbmQ3uQWZ5KH8FP2bUxOO9tslsre34LGwLldNrNttWgXRlN/nskxEv0p+J5
	BFB0u8vGcCJS9oXPd7i7v937TV/ZMyKsxnFEuVAR22D3lJnw8GhhEdM5LKAOE3rj8GAh/5QBEZJ
	+CF7kykVY34Za7VNmqEcYRE8bA1qSR/YPVrXbHGa0OqzLCJfXziq5gbONWfIDTWPUWyo2oyznL6
	jHiqJQSrZM8ddNS12EjABQ6QA1L1rZuq7bjIr3+97ZJXv9mZ70vBmZNBZ1dR3JCLHW6NPc0LUM0
	lTdbHLJy9M6L7taOvL7XQ4ulczYwSQPcmRfmWD7QP7/SVfVL/TK4JeOlQKUCk1i6NLGmMNzA/p0
	yKH7pUmgBg=
X-Received: by 2002:a17:902:d483:b0:2ca:53e1:b915 with SMTP id d9443c01a7336-2d035c20259mr29160795ad.14.1785424975781;
        Thu, 30 Jul 2026 08:22:55 -0700 (PDT)
Received: from ziggs ([147.46.121.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a468f7sm28711745ad.28.2026.07.30.08.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:22:55 -0700 (PDT)
From: Youngjae Kwon <yjkwon0026@snu.ac.kr>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Youngjae Kwon <yjkwon0026@snu.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] fsnotify: Fix stale object mask after concurrent mark updates
Date: Fri, 31 Jul 2026 00:22:41 +0900
Message-ID: <20260730152241.444632-1-yjkwon0026@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CACwKKmCZdiZDoFuYm6LZhQ=XvHPk0fNKH=X3LmoXMqakYqJaNw@mail.gmail.com>
References: <CACwKKmCZdiZDoFuYm6LZhQ=XvHPk0fNKH=X3LmoXMqakYqJaNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a mark gets a new event bit, fanotify and inotify avoid recalculating
the object mask if the cached aggregate already contains that bit. This is
racy with a recalculation triggered by a concurrent update to another mark
on the same connector.

The concurrent scan can read the mark before the new bit is added, while
the updater reads the old aggregate before that scan publishes its result.
The updater then skips recalculation and the scan publishes a mask without
the bit, leaving the object mask stale after both updates complete.

This can be reproduced with two fanotify groups watching the same inode:
one thread removes FAN_MODIFY from one existing mark while another thread
adds FAN_MODIFY to the other mark. After both fanotify_mark() calls return,
writes can fail to produce FAN_MODIFY for the group whose mark now contains
the bit. This was reproduced on an unmodified v6.12.95 kernel. The
equivalent inotify interleaving loses IN_MODIFY events.

Always request recalculation when an existing mark's calculated mask
actually changes. For fanotify, compare fsnotify_calc_mask() before and
after normal-mask, ignore-mask, and flag updates. Keep the cached aggregate
check for unchanged updates, and keep the flag helper's inode-reference
handling.

Link: https://lore.kernel.org/all/CACwKKmCZdiZDoFuYm6LZhQ=XvHPk0fNKH=X3LmoXMqakYqJaNw@mail.gmail.com/
Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
Fixes: 912ee3946c5e ("fanotify: do not call fanotify_update_object_mask in fanotify_add_mark")
Cc: stable@vger.kernel.org # needs adjustments for <= 7.0
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
---
I will send backports for stable kernels through 7.0.y after this lands.

 fs/notify/fanotify/fanotify_user.c | 10 ++++++----
 fs/notify/inotify/inotify_user.c   | 13 ++-----------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9ee373ff5..f7080fd61 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1321,18 +1321,20 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 				      __u32 mask, unsigned int fan_flags)
 {
+	__u32 old_mask, new_mask;
 	bool recalc;
 
 	spin_lock(&fsn_mark->lock);
+	old_mask = fsnotify_calc_mask(fsn_mark);
 	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS))
 		fsn_mark->mask |= mask;
 	else
 		fsn_mark->ignore_mask |= mask;
 
-	recalc = fsnotify_calc_mask(fsn_mark) &
-		~fsnotify_conn_mask(fsn_mark->connector);
-
-	recalc |= fanotify_mark_update_flags(fsn_mark, fan_flags);
+	recalc = fanotify_mark_update_flags(fsn_mark, fan_flags);
+	new_mask = fsnotify_calc_mask(fsn_mark);
+	recalc |= old_mask != new_mask;
+	recalc |= new_mask & ~fsnotify_conn_mask(fsn_mark->connector);
 	spin_unlock(&fsn_mark->lock);
 
 	return recalc;
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index ed37491c1..c44f2daa1 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -565,17 +565,8 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 	new_mask = fsn_mark->mask;
 	spin_unlock(&fsn_mark->lock);
 
-	if (old_mask != new_mask) {
-		/* more bits in old than in new? */
-		int dropped = (old_mask & ~new_mask);
-		/* more bits in this fsn_mark than the inode's mask? */
-		int do_inode = (new_mask & ~READ_ONCE(inode->i_fsnotify_mask));
-
-		/* update the inode with this new fsn_mark */
-		if (dropped || do_inode)
-			fsnotify_recalc_mask(fsn_mark->connector);
-
-	}
+	if (old_mask != new_mask)
+		fsnotify_recalc_mask(fsn_mark->connector);
 
 	/* return the wd */
 	ret = i_mark->wd;
-- 
2.50.1
