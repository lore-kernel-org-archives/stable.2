Received: from h3cspam01-ex.h3c.com (smtp.h3c.com [60.191.123.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02611332610;
	Tue, 13 Oct 2026 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791869915; cv=none; b=Mk1hYDAftF2ZeyKi1bU3FUvk8ol2ZVQfP3h9OCFhWwnSX9cSY4dEkNwuIKndOwgzjSJM3rcv5AiWHkx8nMygN2rlmWIK7WceF9Xnn+InPyjLrgKsad+/4KjzNQwh5IM4wufRH3At2EVCrzBLp4CD40/SGyYzauf7ESdgm4Hs2hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791869915; c=relaxed/simple;
	bh=1vn/HPBCED6S2v630LIYVmcP4wwBglCpoYfL8Y37MKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYXOzie3YTh37W03h9cf/lSiKwDDbBXCmMmsQAUruxs8AnBB+X8rrpXq1lmVNW0Eh0UBy2XV4SxvKSD8cKfbj1zyrPSBHmlq1ueXMjDdxf+iXxZQhvqWe/Be7nEmiTaI4XdCn6MOKKG7ioQGQNMzdvhHD8SWaqMD26L+JOWm6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.155])
	by h3cspam01-ex.h3c.com with ESMTP id 69D5bt1B030486;
	Tue, 13 Oct 2026 13:37:55 +0800 (+08)
	(envelope-from lin.nan@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id DA74D2284EA2;
	Tue, 13 Oct 2026 13:40:45 +0800 (CST)
Received: from localhost.localdomain (10.142.164.48) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Tue, 13 Oct 2026 13:37:54 +0800
From: Nan Lin <lin.nan@h3c.com>
To: <richard@nod.at>
CC: <chengzhihao1@huawei.com>, <lin.nan@h3c.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <wangxiaoqing@h3c.com>, <zhou.kete@h3c.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] ubifs: fix host inode TNC offset when deleting an xattr
Date: Tue, 13 Oct 2026 13:29:53 +0800
Message-ID: <20261013052953.1401741-1-lin.nan@h3c.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <mv5oa6u2.f135b439-8d58-4f22-b346-3aacaa66e9e4@nod.at>
References: <mv5oa6u2.f135b439-8d58-4f22-b346-3aacaa66e9e4@nod.at>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam01-ex.h3c.com 69D5bt1B030486

ubifs_jnl_delete_xattr() writes a group of three nodes: the xent, the
xattr inode and the host inode. The host inode is packed at
xent_offs + aligned_xlen + UBIFS_INO_NODE_SZ, but its TNC position is
computed backwards as xent_offs + len - hlen. Since len includes the
group's tail padding, ALIGN(hlen, 8) - hlen, the two differ whenever
the host inode's inline data length is not a multiple of 8. This
affects symlinks and device nodes.

The unaligned offset ends up in the on-flash index and the next mount
rejects the index node, turning the filesystem read-only.

Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Cc: stable@vger.kernel.org
Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Nan Lin <lin.nan@h3c.com>

Changes since v1:
 - compute the host inode offset into a new host_offs variable instead
   of open-coding the offset (Richard Weinberger);
 - shorten the commit message.

---
 fs/ubifs/journal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 40a95a2fad50..0b2dae57e467 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1858,7 +1858,8 @@ int ubifs_jnl_delete_xattr(struct ubifs_info *c, const struct inode *host,
 			   const struct inode *inode,
 			   const struct fscrypt_name *nm)
 {
-	int err, xlen, hlen, len, lnum, xent_offs, aligned_xlen, write_len;
+	int err, xlen, hlen, len, lnum, xent_offs, host_offs, aligned_xlen,
+		write_len;
 	struct ubifs_dent_node *xent;
 	struct ubifs_ino_node *ino;
 	union ubifs_key xent_key, key1, key2;
@@ -1915,6 +1916,8 @@ int ubifs_jnl_delete_xattr(struct ubifs_info *c, const struct inode *host,
 		ubifs_wbuf_add_ino_nolock(&c->jheads[BASEHD].wbuf, host->i_ino);
 	release_head(c, BASEHD);
 
+	host_offs = xent_offs + aligned_xlen + UBIFS_INO_NODE_SZ;
+
 	ubifs_add_auth_dirt(c, lnum);
 	kfree(xent);
 	if (err)
@@ -1943,7 +1946,7 @@ int ubifs_jnl_delete_xattr(struct ubifs_info *c, const struct inode *host,
 
 	/* And update TNC with the new host inode position */
 	ino_key_init(c, &key1, host->i_ino);
-	err = ubifs_tnc_add(c, &key1, lnum, xent_offs + len - hlen, hlen, hash);
+	err = ubifs_tnc_add(c, &key1, lnum, host_offs, hlen, hash);
 	if (err)
 		goto out_ro;
 
-- 
2.33.0

