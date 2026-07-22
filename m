Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2221A6810
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720978; cv=none; b=sxqFXAkkY5pubFmaNCW0rQ+Hgekd8qisRylIjEP4MuHm+uQIBlfbfQm0Np+2pcDCgT/eEt44bSXSZ/WmlSlX38SxKcKNNWiNigFYVZkzP8WuuVnOQrl84i3WjHiu+fOg44z0qFAy7tggsMZVywkxWSkJ6iK+A3PfWLTH8P7w/OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720978; c=relaxed/simple;
	bh=+XDFmOkPEzlJtKktx5wuL9JV6AFHisnnK0NmMTtC1VU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OX3L8RV0QXnfYFR4m5CKpezxCxkdfXe+NTkqzYLufGZY29lwg6Nk4jEiYE+uATddvXnjSCSxpZSYKSLQlwMma0Vx6jreBOr2LqBweXoaDXQu19qzrnCaoxtvO3cuhMSffWoHBYjAf+jAOzNTAyNXpvm285lJw8vhyNCSgWsVAXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dAImpa7L; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dAImpa7L"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f703a9d05so2375328f8f.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 04:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1784720974; x=1785325774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CK3HSXUL/NSEp0MJpgE4zEb+gkyu2Vmxsop6Xyf02c8=;
        b=dAImpa7Lx8+vjqKtfwqZhVBXhDHMQfz8fuqjDb0DpKr8WEHTe+xvfvmfJf57sZzQqo
         1fUAvPJsJ+YQe1NAchi0UTV++6OFF8gTDpfzIugChJYcvMMgN4RDkfH2EglHtAe5ACW6
         9Sv2U5uiBoBiKMM6eYrhE8ciqYdYUDA5S8gma5tBA7bxAj6njyeBxliSkHMmq/AJMRm9
         z2uSH8QWXTUOMKKvKgCX7HlOlvmULBYg/iO2XKuihrrg+mDBLLqvViBzEJjSn7v6EVum
         9RcsBsvYUGNJpOQ/vf3vuljUXQbS/5zQV82GStwJ34lhFjTMO24msf5mJk1E3oKT56Kn
         2DtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784720974; x=1785325774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CK3HSXUL/NSEp0MJpgE4zEb+gkyu2Vmxsop6Xyf02c8=;
        b=E5XVuXLsUbHR19RvLszqy5uwIwUij4DLAmEckoa3HnzcQleZRtNrSQgtCmUeYMi0dp
         sY4ERmgs5Z3rPtLsqOit0wtq+tYYz60SI12EgGvP4iqqQA87Uk6RBAqeGknqEGDCkSTx
         t0QF+Ko+PABf/CIsSgg2rbj1NqrwN3G7nXfBdsJhFynHvwhw3HrcWxJ9xu+8Gu4oGpxv
         91WERxktqZypV545jCWAmMoOrB1CvIJ+NOAUQ8wtYtGjKGpUAPxHHxtpiO4pF6ihNWw+
         Af9lZSQM0CKxtszPSaSI92GqDx/QP3cUVa1vNsru68uVi6a28AdNb+K+VLCcVBAS5dOO
         +9jg==
X-Forwarded-Encrypted: i=1; AHgh+RpXVsF4MTaxF5AMUtUQCT8B5tY5wMmKC3DQdGfzwGyCAPWYFYn378WXh6ZuiJebimIARzP/pmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJnig2x7mln5LnplpkU+m89PPQTz6goasrlXiu7SIOta0knrZ6
	5hUMsK/Kjsts1iDr3rlwK/ckpf/AInlRzj0eGgdb6uFyTWG0QVKX8mu7C3kxE6JmgY4=
X-Gm-Gg: AR+sD12gG6ZAVxCskcvBmoW4kueaTABIy9J3EftAmN7ZLNjnPJUmDkvqhdARnJ5wob+
	7e0Dma9762fZhGas0b7YKLiq2EQ7QH4Sb4UMfDT6iEFPx/3TErrTD0lywukdiNjqobYB5k/KByj
	SoX3XmLdO4PoErwSBrA2PxnVqwFQTcc14+TAsjCapvkt8LKTSkIoGtuy0+SHWCDjBjENpNbw2pL
	iY5x4tVZRcPx/V5pEcf7zrgdJV3EcHI8mTGobKgNH+uqm+LLAkFPqBGsGiR66VDQTu7vvL8Vh8V
	jw5KNty6pFDqmBzFGnRNgtomSqYLbCChCRe2lLzep0+KoQX61JA0XyaT2i8di2Kq/DTYMPkS1M7
	+Ghoqq82IYBXs7p2PNgu2FL3g6VsOgGG+OjPeU/qmhLhgLGkJatCDPeRtzovl8EbIQmLouK4EvG
	/XqvWkN2W2FUFnHSOJ8rUVNwx5ovm23XuGcZAKKn3o3Ats/R4linSWxPph23V0KBCTqvXcjy8Zy
	LviUNUr8z08XKGG
X-Received: by 2002:a05:6000:1869:b0:47f:7030:bfbd with SMTP id ffacd0b85a97d-47f817fa7ddmr7823949f8f.48.1784720974278;
        Wed, 22 Jul 2026 04:49:34 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f484700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f48:4700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a659sm5699475f8f.6.2026.07.22.04.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:49:33 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: avoid fs reclaim while using `current->journal_info`
Date: Wed, 22 Jul 2026 13:49:31 +0200
Message-ID: <20260722114931.3557110-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_reply() stores a `ceph_mds_request` pointer in
`current->journal_info` while filling the inode and dentry cache from
an MDS reply.

An allocation in this section can enter direct reclaim and prune
dentries from another filesystem.  If this dirties an ext4 inode, ext4
starts a JBD2 transaction.  JBD2 interprets the Ceph request in
`current->journal_info` as a journal handle and dereferences the
request's `r_tid` as `h_transaction`, causing a kernel crash, e.g.:

 Unable to handle kernel paging request at virtual address 00000000077b4818
 [...]
 Internal error: Oops: 0000000096000004 [#1]  SMP
 Modules linked in:
 CPU: 6 UID: 0 PID: 2699135 Comm: kworker/6:3 Tainted: G        W           6.18.38-i3 #1113 NONE
 [...]
 Workqueue: ceph-msgr ceph_con_workfn
 pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : jbd2__journal_start+0x2c/0x208
 lr : __ext4_journal_start_sb+0x100/0x178
 [...]
 Call trace:
  jbd2__journal_start+0x2c/0x208 (P)
  __ext4_journal_start_sb+0x100/0x178
  ext4_dirty_inode+0x3c/0x90
  __mark_inode_dirty+0x58/0x400
  iput.part.0+0x2b0/0x370
  iput+0x18/0x30
  dentry_unlink_inode+0xc0/0x158
  __dentry_kill+0x80/0x250
  shrink_dentry_list+0x90/0x130
  prune_dcache_sb+0x60/0x98
  super_cache_scan+0xe8/0x190
  do_shrink_slab+0x174/0x388
  shrink_slab+0xd8/0x4c0
  shrink_node+0x31c/0x908
  do_try_to_free_pages+0xd0/0x508
  try_to_free_pages+0x11c/0x238
  __alloc_frozen_pages_noprof+0x4d0/0xdd0
  __folio_alloc_noprof+0x18/0x70
  __filemap_get_folio+0x248/0x440
  ceph_readdir_prepopulate+0x570/0x9e8
  mds_dispatch+0x1424/0x1ba0
  ceph_con_process_message+0x74/0xa0
  ceph_con_v1_try_read+0x3a0/0x1510
  ceph_con_workfn+0x260/0x460

Enter a scoped NOFS allocation context and leave it after clearing
`journal_info`.  This prevents filesystem reclaim from recursing into
another filesystem while the field contains Ceph-private data.

Fixes: 315f24088048 ("ceph: fix security xattr deadlock")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 853bf698b356..3c692ad02c85 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/delay.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
@@ -4015,6 +4016,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	struct ceph_mds_reply_head *head = msg->front.iov_base;
 	struct ceph_mds_reply_info_parsed *rinfo;  /* parsed reply info */
 	struct ceph_snap_realm *realm;
+	unsigned int nofs_flags;
 	u64 tid;
 	int err, result;
 	int mds = session->s_mds;
@@ -4158,6 +4160,14 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 
 	/* insert trace into our cache */
 	mutex_lock(&req->r_fill_mutex);
+
+	/* disable fs reclaim while we are using current->journal_info
+	 * for our own purposes, or else shrinkers of other
+	 * filesystems might dereference this pointer as a different
+	 * type
+	 */
+	nofs_flags = memalloc_nofs_save();
+
 	current->journal_info = req;
 	err = ceph_fill_trace(mdsc->fsc->sb, req);
 	if (err == 0) {
@@ -4166,6 +4176,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			err = ceph_readdir_prepopulate(req, req->r_session);
 	}
 	current->journal_info = NULL;
+	memalloc_nofs_restore(nofs_flags);
 	mutex_unlock(&req->r_fill_mutex);
 
 	up_read(&mdsc->snap_rwsem);
-- 
2.47.3

