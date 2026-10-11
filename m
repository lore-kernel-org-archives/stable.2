Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B7A7E792
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791719572; cv=none; b=jx2F/i9mE9P4GoG8tmKYubKK57z9dVbjJZ7S0xCb2i/cXht7Me5qvFltCRDFlSHuc6iq9Wnld4096xl5awx/cc0n7BMTtkUXGdzKj/W3MuLWw4Ab/4hKTet/QeQr/DlbZoQuUgVApRd7Djp6LYEFWHC3YAg7D3NDsCv6cKSW60E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791719572; c=relaxed/simple;
	bh=Txb6AsOdVG79wrsPuDvm+J8b3Wm3fGT457wjT3wMNno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TguCtSESL+aEWfhO9eqv+5FHJb2gXYI2ZQbBlciNSfjvDCbTpgilcpZvs9r/Zj2p2W3Uv9ZT3YU3XWPMLBHIldY10B5sQYfKgrRK7iLD97fFWKOcX1BCM0X8vsvBmUqc4eoKWQkT7N3Fu7EV9hNFPfe6SOmH4NJP3SWQE+Rx+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slFaiZf0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slFaiZf0"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-89a837bf00eso41859b3a.2
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 04:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791719569; x=1792324369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pAs3mUz94y3HVsc+n+czsUW1mDPHFsdfVlUTjRJnHPs=;
        b=slFaiZf0LeKmkOmDoWjoTEhB+2C/zHMdIOXNU9ZmXCzi9LSEOMMKa/DlIEhQCkLRvs
         gwaXogxwffG/nITOP9D2CbThbTSCH3HKKtyACIsTbfC39LomxG++4WF6li4njENKs1sD
         z8NLgn+VsXgSVDeoEZGWfpxQdDxjWS5766u2qCxRqA2jqBSU4hV7etm7pSdUVkFyWA2x
         jeHYvT64EHVoy2nP1kRApArVD7U6SNFL89+lgbucBfxnE5Z+24mJ3lhJskRjATsWsSWe
         SDBOWnwT+ZIxnSAyKIIv2hBSN+wjNtGXTI0swj49TnZwHBb11nDB7TMfM5K8ErPRym2j
         FUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791719569; x=1792324369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pAs3mUz94y3HVsc+n+czsUW1mDPHFsdfVlUTjRJnHPs=;
        b=avPYwgq24ur7az15dVUHigOj1uhiU1oxyaMXmZ5MRfW3OnbG6fdtaJ+gYsCjXaB5zi
         WvUV/mOi6eJ5Z5wmcJHIU3r/nqT7tob+6i66/LLv4WO6Hla5jKcyoHFzcbSsEFcxX3o5
         OBUN7W1sah8eWBCnH2SP6tAhWiYx7iUOEnynDVtgBvZ9B65aarTPob/PqBr9leUkElxr
         AQN2jsOUmbI7UPk5Jbd5zUOIvp4W7vMrRqk1lKAV5Azi6rpvhEYkpph6tnbitCHZpaui
         Y7fYTrT74nDpXplJLfK7FDaM2tVCMFdoi7inJhEhsv3XAwXnXrdtTmAkl2lyFrmBYb42
         NCsg==
X-Forwarded-Encrypted: i=1; AKwUvBwUmNnhbr9CoqGTXWYo60B6qwTyslGXz17X/zwhNrpVlpoMDLuyqnT88Cg4Um79DmvuA0fBhTY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/w3CWFNFVOXIfnFidbykwLRkwkUo2VTxcvantF2rx/3e7HMQR
	k5znyBPm+1MdBMKnB17YkLhxuR2+lt99ZbSyYlnGUgIC2TbQrBJQN13t
X-Gm-Gg: AYBFou3/KRjw6TY8BoOyu9gpzaT6TTYg2tnFJR4p/lsMIC5RXSm8LDlBLNxwtR6xEB4
	JlKPmabpwiVULLxJlShv+lFgI3pbKF4hcJM1ouNNve6/jhV0C8Zcy9KT8Oqt/sa3LUdTgRcpF7N
	0s5veyDdU3JoSdmzYf9KMOMDplX9N/J7LCJLiXvGX75W53ffQXovIoa4dcTWHbhJPCLbyClLbd6
	R1EnRlOeliELmCEt8ir3GqnOKECCAlPQQKee1S6O84gQAHdP6WO3ud+euPQWYgaeL/xrB0QyHHg
	jAYVZIFv/aTYX9pGv0pRZErb/Dxr+CDKAWox3A0oPNuNEuDnh552eQ0g9DsKMJpJW6R1IQO1sff
	yNrX9QMCicVIfILKU0UmsZ0w1M/7YLeuUDtapB0rSyEG29YE+ctUP2nJiNmthl+B5KG5Nx3yNdk
	Iju4rEB0eWO5rBA4jcl3RuO7IJ0iRyRANT4SPgxTcFJYD99STok+0oHRRmzGV6/zk=
X-Received: by 2002:a17:90b:3145:b0:3a6:f7be:fee6 with SMTP id 98e67ed59e1d1-3ab3a346e9dmr9175847a91.1.1791719569417;
        Sun, 11 Oct 2026 04:52:49 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd5dadd0986sm2096472a12.18.2026.10.11.04.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 04:52:48 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH] ksmbd: truncate files before allocating space below EOF
Date: Sun, 11 Oct 2026 20:52:39 +0900
Message-ID: <20261011115239.1588419-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_file_allocation_info() compares the requested allocation with
stat.blocks to decide whether to fallocate or truncate. A file with
holes can have fewer allocated blocks than requested even when its EOF
is beyond the requested allocation size. In that case, ksmbd fallocates
with FALLOC_FL_KEEP_SIZE and returns success without shrinking the file.

For example, a file with one byte at offset 1 MiB has an EOF of
1 MiB + 1 but only one allocated page. Setting AllocationSize to 512 KiB
leaves the EOF and the byte unchanged, including after reopening the
file. [MS-FSA] section 2.1.5.15.1 requires EOF to be reduced when the
new allocation size is smaller than the file size.

Check EOF before comparing allocated blocks. Truncate first when the
requested allocation falls below EOF, and skip fallocate in that case.
This avoids allocating holes immediately before discarding them and
allows a shrink request to succeed when space is exhausted. Preserve
the existing behavior for allocation changes that do not shorten EOF.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/smb/server/smb2pdu.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 12a43efdb53f..b155a27eaeac 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8533,23 +8533,15 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 	alloc_blks = (alloc_size + 511) >> 9;
 	inode = file_inode(fp->filp);
 
-	if (alloc_blks > stat.blocks) {
-		smb_break_all_levII_oplock(work, fp, 1);
-		rc = vfs_fallocate(fp->filp, FALLOC_FL_KEEP_SIZE, 0,
-				   alloc_blks * 512);
-		if (rc && rc != -EOPNOTSUPP) {
-			pr_err("vfs_fallocate is failed : %d\n", rc);
-			return rc;
-		}
-	} else if (alloc_blks < stat.blocks) {
+	if (alloc_blks * 512 < i_size_read(inode) ||
+	    alloc_blks < stat.blocks) {
 		loff_t size;
 
 		/*
-		 * Allocation size could be smaller than original one
-		 * which means allocated blocks in file should be
-		 * deallocated. use truncate to cut out it, but inode
-		 * size is also updated with truncate offset.
-		 * inode size is retained by backup inode size.
+		 * Truncate before considering allocation when the new size is below
+		 * EOF. This avoids allocating holes in a sparse file just before
+		 * shrinking it. Also release excess blocks if EOF is already
+		 * smaller than the requested allocation size.
 		 */
 		size = i_size_read(inode);
 		rc = ksmbd_vfs_truncate(work, fp, alloc_blks * 512);
@@ -8559,6 +8551,14 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 		}
 		if (size < alloc_blks * 512)
 			i_size_write(inode, size);
+	} else if (alloc_blks > stat.blocks) {
+		smb_break_all_levII_oplock(work, fp, 1);
+		rc = vfs_fallocate(fp->filp, FALLOC_FL_KEEP_SIZE, 0,
+				   alloc_blks * 512);
+		if (rc && rc != -EOPNOTSUPP) {
+			pr_err("vfs_fallocate is failed : %d\n", rc);
+			return rc;
+		}
 	}
 
 	fp->allocation_size = le64_to_cpu(file_alloc_info->AllocationSize);
-- 
2.43.0

