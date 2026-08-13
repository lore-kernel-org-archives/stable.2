Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com [209.85.128.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D2F48125E
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629521; cv=none; b=PsUvHnZw2rPzwcrT1WpdsGu0XQpxlTA7aRY8s1pl+XeSRCTu5aWMO8UxkGzHl1vt1bOdBkfRQm4FeWm5TIVQBDCcTFPdpmgF7+zDYpW7HDUmn6etzBJqVbnRMY0gjoO0aFxqTFS2Pj1WBdz7/8X0Xl/ZjwLPJ5GSUeyM3Fxf9e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629521; c=relaxed/simple;
	bh=InMdX+pdiDloclCPV/zVlqIYNtiNdrfnmA7sVFiIrcI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e313u1Ul1l2UKe1Gn2klhIwJVv+SNFVmDiVGbFqqDPlbTGA9O9iA9SY5hYsa9tkZrrbz2EQ+P61OiiTDMJp476v5RHu0oZ+EpmBuYyniP/28+U6u1g2MhUprjolzjdmNoHDHfiqJsRK/Bl6afGrfNXqlVWpBH4Va/3Pi/R5bZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cmWI6tF2; arc=none smtp.client-ip=209.85.128.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cmWI6tF2"
Received: by mail-wm1-f99.google.com with SMTP id 5b1f17b1804b1-4957eefd361so16245745e9.1
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 06:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1786629517; x=1787234317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1y55hehoVssabJRQyQs56fbqkSj+SkZHKxYRNj9+z/c=;
        b=cmWI6tF21dwV/iUgOrxoAzzNeJQ0MhQhcm24ta+wNT2Z/ousus62heoPP4kijyQQ4D
         Drgqkz0lR1YQl4Qyw/FS9evELGW2FOlDtDwndaLcBThcH3T5Tt5zcBJblKjAWU7g/ycV
         nsQ77PeNTOdcdWVbEhL9xv0As9oNeXovAqI5hSUzB0Zt6T91V5CBejzTJppFjolWRjjB
         /AgPTsSH8574IEmTOjfEFyuUHnAGUraB18MXeyhW6327FaNmCkQkN5PYQegitAuIBrR2
         HVlLkwCqpyNTSi2sI2vB0m9G+mDvoD3tSocAAFyz7VKit7Jkhy0J/PRcitOtRggev4v0
         rJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786629517; x=1787234317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1y55hehoVssabJRQyQs56fbqkSj+SkZHKxYRNj9+z/c=;
        b=dcmY0CjvfuWfvAVCtWyfSChCag/Sb6Eyz4IyaPCg6AjLPnSby69dILCeZV/An6sS73
         jqg13Tm8zCx9E9KKve7FpdkJuzLtScykOIRkSzrXdNfdqQntW4fPu7Amh+q5Rvps3yCU
         iAhR0IlImGcy64h7Q6gobaemOTls2zqm55drafnVDdGEOLX0LVVA/+/3TE8T6RNHZQAJ
         Bg5gJBUfliH+CFC9XQvsPGJda/lwTL9FcjZ2lS/BA1sqgUO2/7gTrIeNbC7UBWAlesuZ
         ovzmMOlsB5MXmDJXKbEXYLSO2+gpCPGf8IGc3n39bE3HRZfhrbBimhTJtJrUI3soZxtR
         x0Og==
X-Forwarded-Encrypted: i=1; AHgh+RqDbb1IFsrGCIj2YXTvQnZlHscsTCq/WGyXk51STYDD2IxjgtQSwnrtLQxUeRJ0MI1X3a7lYso=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKSPweU0wGhhNu9mb61KGZhKwnzDJaOpwrNnGNV5SJL4JIPi9X
	4mNTTNUkFOK1NR27Qp71fEH1MdnaG2fHzGjhztduDEJjdloBpGCfDE/xb1p8pQjOhBny9/tNeXs
	n8GwgT3x//wvxpUWfVbaYLlmuU5Wl0YnPMJOZRRfDrC3rUnAjK1ae
X-Gm-Gg: AR+sD13HmCpUtU2MtXWKCSeKCSIrwqz5OAJfamrg3CF3cGJu6TYpr68P9hqgOCMqJSr
	crkKUWxSMSemAvWT2tF7hU6kQlQ/uPom2E/welAGNmouguDtvs0Ax6EzChCjHI81EVU8sqoUIcH
	LyQE7Do/7Lpgg/8Pu4AyzrYwCM3hHtNptKAopRjOUsrEK/hq1qSHM5Sgldh8oSV98aBHijmE4Ne
	A4UYYGOJ1POCoJK3z39JPIHyf8vDiT3e21IbI57zTylxIITT0v2yc6Bxv/gQ0VCIl4eI+9SIhGM
	g0x1wuZWok59Q9+4EEFhaT0p04jHTKkfSIb868ckPhU8v/8u8rylEgC8SXrXVwmaT6DWQ+4SZPW
	qxSI8+ngW9l0cqNCfzCs76bb6TfOv
X-Received: by 2002:a05:600c:1385:b0:495:5fdf:2075 with SMTP id 5b1f17b1804b1-49982109cc1mr75225985e9.0.1786629517600;
        Thu, 13 Aug 2026 06:58:37 -0700 (PDT)
Received: from c14-smtp-2023.dev.purestorage.com ([2620:125:9008:8012:36:131:5:0])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-49981b16dd0sm9042585e9.7.2026.08.13.06.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 06:58:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id 3A43634029C;
	Thu, 13 Aug 2026 06:58:36 -0700 (PDT)
From: tmenninger@purestorage.com
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Menninger <tmenninger@purestorage.com>,
	stable@vger.kernel.org
Subject: [PATCH] pNFS: Check lseg validity before marking a layout for return
Date: Thu, 13 Aug 2026 13:58:34 +0000
Message-Id: <20260813135834.22278-1-tmenninger@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tim Menninger <tmenninger@purestorage.com>

pnfs_error_mark_layout_for_return() receives the lseg associated with
the failed I/O but previously used only its I/O mode, operating on the
inode's current layout header regardless of whether the lseg itself was
still valid.

A layout stateid can be invalidated while RPCs still hold references to
its lsegs. pnfs_mark_layout_stateid_invalid() clears NFS_LSEG_VALID on
those lsegs through pnfs_clear_lseg_state(). A subsequent LAYOUTGET can
install a replacement stateid in the same pnfs_layout_hdr. If an RPC
using one of the old lsegs later reports an error, the current code can
therefore mark the replacement layout for return.

Once NFS_LSEG_VALID has been cleared, the lseg is no longer eligible for
selection for new I/O and must not initiate another error-driven return
of the inode's current layout. Fold pnfs_mark_layout_for_return() into
pnfs_error_mark_layout_for_return() and check pnfs_is_valid_lseg()
alongside pnfs_layout_is_valid() before setting return info, so a stale
lseg cannot drive an error return of the current layout.

This was reproduced by restarting a FlexFiles data server during a
high-throughput read workload. Stale lsegs repeatedly caused the
replacement layout to be marked for return, triggering I/O cancellation,
RPC/RDMA transport reconnects, and sustained contention on
inode->i_lock. The client did not recover on its own and consumed about
94 CPU cores on a 96-CPU system. With this change, I/O recovered within
about 20 seconds and recovery load peaked at about 15 CPU cores.

Cc: stable@vger.kernel.org
Signed-off-by: Tim Menninger <tmenninger@purestorage.com>
---
 fs/nfs/pnfs.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 7715e2bd5871..9f32dd7c4c63 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2708,26 +2708,30 @@ pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
 	return -ENOENT;
 }
 
-static void
-pnfs_mark_layout_for_return(struct inode *inode,
-			    const struct pnfs_layout_range *range)
+void pnfs_error_mark_layout_for_return(struct inode *inode,
+				       struct pnfs_layout_segment *lseg)
 {
 	struct pnfs_layout_hdr *lo;
 	bool return_now = false;
+	struct pnfs_layout_range range = {
+		.iomode = lseg->pls_range.iomode,
+		.offset = 0,
+		.length = NFS4_MAX_UINT64,
+	};
 
 	spin_lock(&inode->i_lock);
 	lo = NFS_I(inode)->layout;
-	if (!pnfs_layout_is_valid(lo)) {
+	if (!pnfs_layout_is_valid(lo) || !pnfs_is_valid_lseg(lseg)) {
 		spin_unlock(&inode->i_lock);
 		return;
 	}
-	pnfs_set_plh_return_info(lo, range->iomode, 0);
+	pnfs_set_plh_return_info(lo, range.iomode, 0);
 	/*
 	 * mark all matching lsegs so that we are sure to have no live
 	 * segments at hand when sending layoutreturn. See pnfs_put_lseg()
 	 * for how it works.
 	 */
-	if (pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs, range, 0) != -EBUSY) {
+	if (pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs, &range, 0) != -EBUSY) {
 		const struct cred *cred;
 		nfs4_stateid stateid;
 		enum pnfs_iomode iomode;
@@ -2742,18 +2746,6 @@ pnfs_mark_layout_for_return(struct inode *inode,
 		nfs_commit_inode(inode, 0);
 	}
 }
-
-void pnfs_error_mark_layout_for_return(struct inode *inode,
-				       struct pnfs_layout_segment *lseg)
-{
-	struct pnfs_layout_range range = {
-		.iomode = lseg->pls_range.iomode,
-		.offset = 0,
-		.length = NFS4_MAX_UINT64,
-	};
-
-	pnfs_mark_layout_for_return(inode, &range);
-}
 EXPORT_SYMBOL_GPL(pnfs_error_mark_layout_for_return);
 
 static bool
-- 
2.34.1

