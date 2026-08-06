Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5CD477E51
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018903; cv=none; b=j8ALZyCdOWbVBBL7tWgZczg/+h+8JJStLkwwiRaF7ReuqMwzT2HM7EeYK5ZcKPk6syPGTMJmsih1pr4Slod6Ge7x3wj+12AySGF6lJUyq4Lo7IKGnEY1FvSnxwfp4LySGOgdQkvxvekOPUY9PcqrR1XS2tayxU2eRa4MnCEB2b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018903; c=relaxed/simple;
	bh=PN2WzJemERPS4iPxoVMtpcEMd1yZCcCbbbQBtJYQ0vM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F4I58V15+1hw5atk7ExLGcJK7dnAO/EOuTl98hWzXANo++RkWXkX9b2dcXujDI0TljrWbfHutwWhoaMKr39jepEyG2ELygwIuPq6AC82PfFlO6K28zjYSNWfms/sSIuQs+HnLoQSq5UEHeao6qybSFRh/lQ5kZC5UHgb8p4JpmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn5tagi2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn5tagi2"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf52d15d88so20184905ad.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 05:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786018901; x=1786623701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ekdV8BchbmbJWa6PZjnzaWfvyI9TuAOg7wpTh12WMck=;
        b=Yn5tagi2HUolHQuse+SA4OK5LPRevSaoqzA5ZVz1u6XkgzRc5CD7yYBBDoARwnrGwi
         tXZnldmj2pOnVruc/5sf3V6N2oYFi7GHilghmyEOe5Dwu33QklOS8nP7w7oG4Nruyl2K
         s2zekx4xARU/qEGJ3DAdeT/RbiPshB+pd2eZ0Gb7NnDXP7zKp8+cKEt3Fptq+yx5t0Zd
         +nWnunWqVqrFvVaEeqiZKW+aC0pO7GQnrF96ePpjC7LHVJnVURw7r0zkuu9B/JvxYMsh
         BQ3hzXjyvadZVyz/1RKMGHI9sZR0Z1+j5xWY1dDGNKWEsC6bmYlwgstvcYnSAa3i5T8n
         DtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786018901; x=1786623701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ekdV8BchbmbJWa6PZjnzaWfvyI9TuAOg7wpTh12WMck=;
        b=eU6KmcgToVOdD+KlCBqWgT5F3oJmOD2ujMo4S9rptiZtg0uN9PA1d5o+MCq07JMM1p
         Wqmukcxai40rT4+5HdFUUSLsy7pxxawRURPTCfy7UNrbNaWTVorOBBl7qXyS5dQXvDb6
         0XR7RWQTGqR5EW3MCqcov4nlXdh5Gs28vKjjyA2qPUd+5Izj4POMK9tegnFKsCNbpzIy
         89hIM13kDbATnFn8NOvpRpXRL3nTvrYW8SSVHpYXdHOVWwYe4tx/3fAz5W9hIWCcrWVS
         9FzdLwPXeTg7aMwuqN9jFPhIHNTUhRVdy+4wj+xDMg4u+4oXuAJgnhioIUY7yAeewbxt
         aurA==
X-Forwarded-Encrypted: i=1; AHgh+RrTcGGcDIYfhX17w8YeEKdzNU+x60joF1rW1OgvJnv8gz9P9pSgezFv0+oM2B5iuYbn4V3r/8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG935mPJNc7LZPrc2amNRMLP0AAVAT6mfaz8OxCMf6FES8wBUI
	gsHScgq7lJItGmrGg3g1MyD9hNrkTMyHY5H0Ry4wpuFZxm8NjL8aqUuGvAnxbg==
X-Gm-Gg: AR+sD125kG8EMsUqwkKZO8luhA0BDvDzVsQ/VjLgVYcNfMHLOe9xyv0e8PyoNVXjy3g
	NLQyDKP7mPTDh2f9lP+fT18zf+tateEwHvbA5Li/Zr12lHpaXd5TYPsLE/HfbPkNEWVkjcjP3cw
	cmtLt5dE7bLlb4sRIfM9PxB6N70D7GcR/tiYCCRXwiJEyuENGAErL4Z6JMVg8UQ0abHM+qCghhH
	curjkImRVWCHUk2RneUo5TXYTzIGMBa+oKrZb1EemtiHgjmXIrGfAIP2wqOCfMgznnUiDKTwSaF
	PQzPVNYbDCFThQaUdrvW7bhj0siZlzmAJpNRgmXgPqTRhvxbj6/zmZSimSu0H6agJnFmE/ttgxe
	gJlGbQ9u7HksHadWGiE+ugKx1gcN1Kyrg9ojdm4IMhGr6am72wInL1a1f6wIEIuIM5cdhMK+dc1
	+e2/0d4SN6uUp8f+yf0C2DLdmlGZrNZqChuiHMPTkqO24x4kxVAIffAAumqXXv7GPe14uN247Q
X-Received: by 2002:a17:903:1b46:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2d0ca7fa860mr175702675ad.9.1786018901279;
        Thu, 06 Aug 2026 05:21:41 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa49325bsm30970765ad.40.2026.08.06.05.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 05:21:40 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH] ocfs2: bound-check dir entries in the readdir re-validation scan
Date: Thu,  6 Aug 2026 20:21:33 +0800
Message-ID: <20260806122133.956847-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the inode version changed since the last readdir(),
ocfs2_dir_foreach_blk_el() re-scans the directory block from its start to
relocate the current position:

	for (i = 0; i < sb->s_blocksize && i < offset; ) {
		de = (struct ocfs2_dir_entry *)(bh->b_data + i);
		if (le16_to_cpu(de->rec_len) < OCFS2_DIR_REC_LEN(1))
			break;
		i += le16_to_cpu(de->rec_len);
	}

The loop dereferences de->rec_len (at byte offset 8 within the entry)
guarded only by i < sb->s_blocksize.  `offset` is derived from ctx->pos,
which userspace controls via lseek() on the directory fd, so i can reach
the last bytes of the block; reading de->rec_len then reads a few bytes
past the s_blocksize-sized block buffer (an out-of-bounds read).

The main emit loop below already guards this via ocfs2_check_dir_entry(),
which rejects entries too close to the buffer end before touching de.
Apply the same lower bound to the re-validation scan so that a full
minimal directory entry is known to fit before de is dereferenced.  For a
consistent directory this changes nothing: entries are at least
OCFS2_DIR_REC_LEN(1) bytes, so no valid entry starts in the excluded tail.

Found by the sashiko review tool; fix approach suggested by Joseph Qi.

Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Fixes: ccd979bdbce9 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260806022044.167962-1-zhanxusheng@xiaomi.com
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/ocfs2/dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index d7fc3cccf2f4..3b606b4c04dd 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -1903,7 +1903,8 @@ static int ocfs2_dir_foreach_blk_el(struct inode *inode,
 		 * dirent right now.  Scan from the start of the block
 		 * to make sure. */
 		if (!inode_eq_iversion(inode, *f_version)) {
-			for (i = 0; i < sb->s_blocksize && i < offset; ) {
+			for (i = 0; i + OCFS2_DIR_REC_LEN(1) <= sb->s_blocksize &&
+			     i < offset;) {
 				de = (struct ocfs2_dir_entry *) (bh->b_data + i);
 				/* It's too expensive to do a full
 				 * dirent test each time round this
-- 
2.43.0

