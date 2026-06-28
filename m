Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E8330337
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782640122; cv=none; b=Mj/MV+ASufo0dcji32kkV6qdaA7rbeq91axh2dVIR53MOYTQTxwBveKIFNPnxab3nPPHjefnNdx415teE49V2NinwN2HrEe26hJJQjS7zaDXmORWtXCSub1k03oNgt/WGrvIwTEM+z6vmv8UKBrbSTTpyK0E9SWwJif4kL/O9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782640122; c=relaxed/simple;
	bh=WQcQ7QnDNpj6b+N54Y8A71HMVtVxhAxt2cuaVLwotzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3dWSBlY7DKBkUwgC3ebjTvmw1gOsCUtLJmzHuVsXy20nrppZ6HB4RXrYFwgn3Ed77hxSfD0FvcJ9W2t5xIuFWP6BJrYWnikirvwCLMYp/gxb6IP+snsNNh/NeTOwbKyhMz4XenvJS4P+UJa74SLNkACWS8QYY+oxNClW6xX3Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjRe0WOa; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjRe0WOa"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-80d33d13a23so5371867b3.1
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782640120; x=1783244920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BSJ5wyzaVD0AAbYArY5bvFALJrFls1U2rKAskILea1s=;
        b=jjRe0WOaiPoAW5lpM9LhyziJECRmQCk/Q/n15gN4aweH2esiZweNP2FGwv4bQa0O5d
         cMQm4CrAlLKN2idt68P5skze6G1RtSaD/uvVllMq67+is7ipFketd0iJZcSeivrzvl6C
         uG5VAni+1ij27pqmK8FYb+mj3OKDL2vEV8XZXc+SnzsSguCwT9sOKoYfns3Oa9ijhiuu
         WzucI/DEXUK60X7MBEO6iNvj83m+8m61SYu9wUANNj5ftEspXH0wYs/PkcVD5nbbcNAr
         uJM6RBpTkMEmvuAx6Wb4l/hQaBJxlCvr9FNnO6BPIXtc/gyimV6RAve6H6d+F9Y5rAG7
         zDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782640120; x=1783244920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSJ5wyzaVD0AAbYArY5bvFALJrFls1U2rKAskILea1s=;
        b=m5i4Sp1RMi9dfIWya9T0HmozKmAahvelVkDQrZ4O3onf6L8TQfphS+0IH9Pa8t+qOX
         qrYb2xmmfxYf1XrrYF8ecyNkOcZJVMndnqdyhqmOUtfGVT8hbp6O8W7dmStGHGvwSfQx
         kUusOOYr58etLy9wjgk8OehfKZDQDw6Txf4hvs8SwLrmoXLkZknytlMpfv76jsaxI8vg
         LsZwTBUpr7S8UL6TWIFo9klQ3fBx2PTr4NKacrwdC2V/maCtJiiHS2h6SyM6rYDT+GAV
         1MlJ6+8hi4ZRBLpN2E4wbFe0zP0IB1EYqWfHmx/67fi3Dt2in07UOLq1QtLBrGRNizRL
         18AA==
X-Forwarded-Encrypted: i=1; AHgh+RqdLxdffzXnDHeIrm8fjc5VPX3/trk+MC9cSrwTdXid5LY3wBu+KkNZyig3c5gqAZecUKN6t1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK4dlJQuiLabC/GMGpluJ8OvhPQQMV1LNYMaaJX9HH3Nq7zNUs
	jVz+KpqmZOJNk3jzLH5Iz8Rn5O68uCbiWKLORfbuJI6XMwi5iBIvro77
X-Gm-Gg: AfdE7ck69rnURAD08q9gNg976WqZQE5PPuyLE4gc8xhYahtIRoX+redbU8fiGQ4Bp+V
	NSozGVgv+BqDG1nMx7IYzezBNOv9NyCHis85Cy+MAnNtnQcQW2PBcyDmb6YNOOhGIJkSN2Gs0d/
	uJZc3ur0U5+VO0mdSybJjGES4ulXlWsdhDsq5rsjWkjiArlDx7pU5gn2YsMNgG10x3adk46kPlQ
	duIJdj1dm+ZM8G3TZz5qdVp7ua86msghw1uayCHpOsicHEd/SPTud0IO34gxMTuD8qtuTIYxUxz
	0KACyRR+69xWx4YVdCxMk6Xn9LZxeZZJh4goDQNm0barVn02097cpaKMWmGS3kBB9Q4K1Ri5hqk
	Ff6egiiu9rcKqWm4CnaHkNzWXF554nh99nwVrUyHnc0XeXQEuc/kIqju6O1Q6BL62qPJxSfnM02
	Qz9BTZGwZb7qdb+PXopvp6othGfQ==
X-Received: by 2002:a05:690c:c6c7:b0:80a:a034:17c5 with SMTP id 00721157ae682-80aa0343466mr102014457b3.53.1782640120184;
        Sun, 28 Jun 2026 02:48:40 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80c211137bdsm24277057b3.12.2026.06.28.02.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 02:48:39 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Carlos Maiolino <cem@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+97f2c05378c5d68dcb8c@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] xfs: zero newly allocated btree root space
Date: Sun, 28 Jun 2026 11:47:48 +0200
Message-ID: <20260628094748.46578-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfs_broot_realloc() preserves the existing in-inode btree root while
growing its allocation, but leaves the added bytes uninitialized. The
inode log formatter copies if_broot_bytes bytes into the journal, so those
bytes reach the log record and its CRC calculation before every location
has necessarily been overwritten by btree updates.

Clear the newly allocated tail immediately after a successful growth to
keep stale heap contents out of the filesystem log.

Fixes: 6c1c55ac3c05 ("xfs: refactor the inode fork memory allocation functions")
Reported-by: syzbot+97f2c05378c5d68dcb8c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97f2c05378c5d68dcb8c
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 fs/xfs/libxfs/xfs_inode_fork.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_inode_fork.c b/fs/xfs/libxfs/xfs_inode_fork.c
index 606a36526ce2..0d81c78f5afe 100644
--- a/fs/xfs/libxfs/xfs_inode_fork.c
+++ b/fs/xfs/libxfs/xfs_inode_fork.c
@@ -398,6 +398,8 @@ xfs_broot_realloc(
 	struct xfs_ifork	*ifp,
 	size_t			new_size)
 {
+	size_t			old_size = ifp->if_broot_bytes;
+
 	/* No size change?  No action needed. */
 	if (new_size == ifp->if_broot_bytes)
 		return ifp->if_broot;
@@ -430,6 +432,7 @@ xfs_broot_realloc(
 	 */
 	ifp->if_broot = krealloc(ifp->if_broot, new_size,
 			GFP_KERNEL | __GFP_NOFAIL);
+	memset((char *)ifp->if_broot + old_size, 0, new_size - old_size);
 	ifp->if_broot_bytes = new_size;
 	return ifp->if_broot;
 }
-- 
2.54.0

