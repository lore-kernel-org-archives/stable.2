Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795371590;
	b=Ot6565WehjjS/7/k0t3vLNGCmfIAzPvE2gZZxvv57tNYBbhXhWTMVngRvpNwyHnMFff7
	 HnUZj674ddjdNkX/wlkyvEgrAOxXQ50nrfWKv8ZunE47J80SrrbfIzIMhuDqex00E3dfN
	 Tmj62SNVZ/P9pp1xBRjET2kQ8Bc6/YJY2ZedDodjcGBv1lbTWPAiCqhkZjDEX7WfbOQjP
	 AyWSOK1CKEuP7Lms9cXd3VE4s6Tk26gtAsncvz1ujcToSNUpPkL9e7i2CeDuIR02Fz3u6
	 Fe7Enc2NfjAYqMZM1iTm5zBa0FH+jgda79OvJOT6X3Tff4GvOp74eokOCiP2izmQhzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371590;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7XzCl99XSt0jQeYSzp9DDMkSNqpxrpMBcV0n58ptXLg=;
	b=saH6Oyi4ffw9jaeYqBFaJbzpJ5QzWtEJn/mtZ7hsyNiKosmTUnB8y1vk8o5VxgpqmFHR
	 LHz9kwDtaNfFvxIeyUFtm+aJjnmpT+FWHpEnKE0fJcsKke/q5Mt0wQmzOJ9/tqtomOFy2
	 e1N9loPpaFyuodJa1/p6kw3xY2vXDYALWxv85hs3BhYI0PtHflF4lBaj9tr9xYbfCv6ep
	 SulNa3HGLSOmBL/baevuQVw2VDwev5XtmIBgVUDA9sNY/5xB3ywLDmJx3ITw4gfSE60X/
	 q66BpSiExattafbxeZKMYhyyucCAG8/MnXiI7U3EB1EWbcmAq1YfD/bLc3t7kYw1C8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bH1t+tj7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC111606A681;
	Sun, 22 Nov 2026 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bH1t+tj7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795371590;
	b=utjwlqkYHKzIUVqloITEPjk03w3aHbIhSRnUivoPjvu3Z6QwswHBMxCI9FwEmEiXa1Gl
	 koChkucSPHtP7qXCrfY0qHIOJaDzoOcjBTj6xFMkaWb43LGdvE6G6usZt6hHBizSd7FMS
	 x/Bq4guHuahxULVGxsamGk0qCm/nkayMcvSnYbNGciFilSAetpGElJZtii51EOGoSaNuV
	 +TjIo5x+/BsL0w3WKJ04ng1KzZizMiFgP/ZTuhFBtdGhCwhlguMqQByanJlCSTx6d3qYV
	 7O1MxV+SAijmFD8duzg95GCSLbtOCo736xzazqNRur3wDpbQM2GshKoNggDH6RzgkSw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795371590;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7XzCl99XSt0jQeYSzp9DDMkSNqpxrpMBcV0n58ptXLg=;
	b=O4fpinc99coP29vFNvyQljQwbsJEQ8z58r3aLfi73WsD5LQStjMbHXCyUrEuMRVKv+Tv
	 eqJ4MLZkU+mlbBIL8hflhKAkeaQQ5VNa8I+UQ8h76qcXpwcfeFcWyH8vWMhhVXC3lSmI/
	 VJfB+rHUAFVPJD4e0yRVqXn2o8kQvWAL9KiTtirKss1gAJmnnvs5WWQkRpwX0BqBh0M3e
	 RlUP9dLBqwUN8OwoAFsCitHENEq1UOW4HuVpzOZqy4xdOom9kYZ2dwWsFtyz6jF0Kfs9Q
	 TfZ34INuhsJ0DmxhwZEHssJ/AFMiWw0jIwBFR5OZjl/C5uA5qikVEwh2ei9tTp9uL3A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 44BF81F000D0;
	Sun, 22 Nov 2026 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795371590;
	bh=7XzCl99XSt0jQeYSzp9DDMkSNqpxrpMBcV0n58ptXLg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bH1t+tj7cTnygUVy1Om0x5gAmcOK+W001/1WpoTWOqUTPcbQ7vAEjEnI+cMhBUC/N
	 FcPdVQBsm4DLypQuCfA83HM1nF1sVF4lZOVi52sgIyw6ep6x2M3MHCxx0YfHhFgmsd
	 GQRciYGoYzKgSBJCfWbZAowMOEGLFDN0nW+n2UrEQ+3cm939zTvw9dnJJlTrhYisK4
	 UxvlFhgB/b1EUOwWdcsq2s4OF9Gqyu/9QVEtmZ7UG0PxwhbN99s86Gv+CGwIzbkxqo
	 7m5qK0qq6PCwoYimOwlm4LWN1Qhzbg1uPIWhAdNC/H5zzAyaUdVKYxtSLgAWnTfU/u
	 21DSE25oM5VNw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C5F514C180;
	Sun, 22 Nov 2026 18:19:38 +0000 (UTC)
From: Ernest Borowski via B4 Relay <devnull+ernest.borowski.git.proton.me@kernel.org>
Date: Sun, 22 Nov 2026 19:19:39 +0100
Subject: [PATCH 3/7] ntfs: release the delalloc reservations of an evicted
 inode
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-b4-ntfs-delalloc-fixes-v1-3-0726f0dce403@proton.me>
References: <20261122-b4-ntfs-delalloc-fixes-v1-0-0726f0dce403@proton.me>
In-Reply-To: <20261122-b4-ntfs-delalloc-fixes-v1-0-0726f0dce403@proton.me>
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
 Baolin Liu <liubaolin12138@163.com>
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Zhan Xusheng <zhanxusheng1024@gmail.com>, stable@vger.kernel.org, 
 Ernest Borowski <ernest.borowski.git@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4574;
 i=ernest.borowski.git@proton.me; s=default; h=from:subject:message-id;
 bh=jX0WnDWyu6iBmr0vTGV8OHp2dfN/AQIQZ7hTHKPYgG4=;
 b=owGbwMvMwCVWzJ65uCpJ5D/jabUkhmxmIwvP1qsrjRryHpuXyn80iY6b9tiGl/144ZQuT76A/
 x4HGad2lLIwiHExyIopsnT8vxHiE/Lt07I4rT6YOaxMIEMYuDgFYCIzFjP8D88N0rYVkoxob/sj
 UpdRJckVwDdv8gQJHx91pzOHthj+YPjvruGUzLP05SvGlU+5ZRhkfl4TFktssv8hIdXFcbhczo4
 fAA==
X-Developer-Key: i=ernest.borowski.git@proton.me; a=openpgp;
 fpr=88FFD8544C54F6F2A65E2A8E730769A37A6214FF
X-Endpoint-Received: by B4 Relay for ernest.borowski.git@proton.me/default
 with auth_id=1589
X-Original-From: Ernest Borowski <ernest.borowski.git@proton.me>
Reply-To: ernest.borowski.git@proton.me
Content-Transfer-Encoding: 7bit

From: Ernest Borowski <ernest.borowski.git@proton.me>

When an inode is evicted with LCN_DELALLOC runs left in its runlist,
truncate_inode_pages_final() drops their dirty folios and the clusters
reserved for them in vol->dirty_clusters are never given back.  Only the
deletion of a base inode released anything, using the per-inode
i_dealloc_clusters counter.  This leaks free space until unmount when a
named stream with delayed data is removed (ntfs_stream_finish_remove()
truncates the page cache and ntfs_attr_rm() frees only real clusters),
when a file is unlinked while one of its named streams has delayed data
(ntfs_cleanup_deleted_inode() drops the stream inode, whose reservation
is not covered by the base inode's counter), and when an inode that
keeps a delalloc run no dirty folio covers (see the next patches) is
evicted.

Reproducer: mount with streams_interface=windows, write 1 MiB to f:s,
rm f:s (or rm f), sync: statfs() reports 256 (4 KiB) clusters less free
space than after a remount.

Release the reservations of whatever delalloc runs are left in the
runlist when any ntfs inode is evicted, and drop the counter-based
release from the deletion path, which would release them twice.

Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
Cc: stable@vger.kernel.org
Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
---
 fs/ntfs/attrib.c | 12 +++++++-----
 fs/ntfs/attrib.h |  1 +
 fs/ntfs/inode.c  | 12 +++++++++++-
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index cdac846f37..39fa983cd8 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -4390,13 +4390,15 @@ static int ntfs_attr_make_resident(struct ntfs_inode *ni, struct ntfs_attr_searc
  *
  * Delayed allocation reserves vol->dirty_clusters for every LCN_DELALLOC
  * cluster when the buffered write is done and only gives it back when
- * writeback allocates the clusters.  Runs cut off by a truncate never reach
- * writeback (their dirty folios are dropped from the page cache), so their
- * reservation has to be released here or it is lost until unmount.
+ * writeback allocates the clusters.  Runs cut off by a truncate, or left in
+ * the runlist of an inode that is evicted, never reach writeback (their dirty
+ * folios are dropped from the page cache), so their reservation has to be
+ * released here or it is lost until unmount.
  *
- * The runlist must be mapped completely and locked for writing.
+ * The runlist must be locked for writing.  It need not be mapped completely:
+ * delalloc runs only exist in fragments of the runlist that are mapped.
  */
-static void ntfs_release_delalloc_from(struct ntfs_inode *ni, s64 start_vcn)
+void ntfs_release_delalloc_from(struct ntfs_inode *ni, s64 start_vcn)
 {
 	struct runlist_element *rl = ni->runlist.rl;
 	s64 nr = 0;
diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
index 9d6bf03202..faa2dfba3a 100644
--- a/fs/ntfs/attrib.h
+++ b/fs/ntfs/attrib.h
@@ -109,6 +109,7 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s64 len);
 int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn, s64 len);
 int ntfs_non_resident_attr_punch_hole(struct ntfs_inode *ni, s64 start_vcn, s64 len);
+void ntfs_release_delalloc_from(struct ntfs_inode *ni, s64 start_vcn);
 int __ntfs_attr_truncate_vfs(struct ntfs_inode *ni, const s64 newsize,
 		const s64 i_size);
 int ntfs_attr_expand(struct ntfs_inode *ni, const s64 newsize, const s64 prealloc_size);
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 4fbdcd4596..911e68fa91 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -430,7 +430,6 @@ static int ntfs_non_resident_dealloc_clusters(struct ntfs_inode *ni)
 		}
 	}
 
-	ntfs_release_dirty_clusters(ni->vol, ni->i_dealloc_clusters);
 	ntfs_attr_put_search_ctx(actx);
 	return err;
 }
@@ -2459,6 +2458,17 @@ void ntfs_evict_big_inode(struct inode *vi)
 
 	truncate_inode_pages_final(&vi->i_data);
 
+	/*
+	 * The dirty folios dropped above never reach writeback.  Give back
+	 * the reservations of the delalloc runs they had, for named streams
+	 * and attribute inodes as well as for base inodes.
+	 */
+	if (NInoNonResident(ni) && ni->runlist.rl) {
+		down_write(&ni->runlist.lock);
+		ntfs_release_delalloc_from(ni, 0);
+		up_write(&ni->runlist.lock);
+	}
+
 	if (!vi->i_nlink) {
 		if (!NInoAttr(ni)) {
 			/* Never called with extent inodes */

-- 
2.56.1


