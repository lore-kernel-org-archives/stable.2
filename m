Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794639275;
	b=jDW4zNLbRLRL8TjM9qZQ6ixbTJwKFfdP36kd14iJnPuFM+UtlQTDjRjeDdyuxeXi106a
	 3bXG1IQCjcw2CjNh1xtV/gDfSlz2z1Fvs8YA6K7l14noXbi+v7ovYgTwIBq3hnvF3++u7
	 aPusVHewk7Wcj/4FOa4AQrdhHgdsy+LVAhPBA2wSq9JVqjnyCN7tFmXEVea1lAumThB57
	 gow8Tn+ek0eleemKl4kAijR57sBQFTzdvTgspopgFJ1WjV3fvCbeUgRIz0LZU6UZy5fUO
	 Dcq3hBHkzi5p1SAQetOcGQSSs0AyJuJLilfDs9ng31mbis33g3FYI3cKC8rqm8xQWog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794639275;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ycHCcdUHWrn+GaE0uYs82yaSGynjsNWlDW3ZbB+W3jE=;
	b=cSMEKTALY0PwIi/MQvTqP77VFiYiJcIacfdN7pd970uuQKkR7l/dAfe4ePkBpkklx3+z
	 m0AsJmGSMPpM16busMVFMCVS5xJHEHszYt9YoyE5nrm8fNsuq0AqtmloxGgtXsNkO3+3N
	 ukHu9+etgYrQzPdVngq4S0WaLwId9y95Hgex3iiw5Wa2g4ZtwL/wSFLN1nZzoK77z7Z4k
	 x9cWgSfVizS9FOjpKiXyyM8yP1qmAgWvwXEpYH5ssrrXwf4HRdwllQXB6JrQlfgjI1p7H
	 I2xd6nNUMgT53wrPxtM7UMdnSulrvntEi2wjMA0oGb/SYgN+R+cOPLxvKh2oR7Ehv4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvsBZaul;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BAC606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvsBZaul
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F5A1F000C4;
	Sat, 14 Nov 2026 06:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794639275;
	bh=ycHCcdUHWrn+GaE0uYs82yaSGynjsNWlDW3ZbB+W3jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mvsBZaul0hMxXOOysmbepQD7Jtb4PutF1LxadSaivExZLqnLVckjDnT+bX+I/90Pk
	 5xdrjQ8Dk4ANFdnUUXD+j9vbzcp5RMYf+eX8NXS4wUAAYDHO9pVDpMVd2ZuO7C3uHv
	 61x3CT3yVt14KjL3hh+V3q1ut4OjTLV0w/+2Np4RQ1A4qW7rgZxF0y3DCfjM84Bjkz
	 1lhttjUMYNYs9X696hw0k19t3thPNX5ge7sQtj6lkpbSN+2SSAwPrI2WEIW2qak/hK
	 VDPQjj/tU9PiW10EBUZltrX4aGN+n2FI5AvtAUku7kIIFkUWPfoBEQ8A/YZtBR/cP5
	 ciRzde5j0uQBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heming Zhao <heming.zhao@suse.com>,
	Anderson Ferneda <anderson.ferneda@braza.com.br>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] ocfs2: use the stored hash when checking xattr bucket collision
Date: Sat, 14 Nov 2026 01:54:31 -0500
Message-ID: <20261114065240.3232541-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202227-failed-5.15-e8de099f2958@kernel.org>
References: <20261109202227-failed-5.15-e8de099f2958@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joseph Qi <joseph.qi@linux.alibaba.com>

[ Upstream commit e39baff18b85cf8956aee138d7944b6581e8ba36 ]

ocfs2_check_xattr_bucket_collision() decides whether splitting a full
bucket can make room for the entry being set by recomputing the hash of
the name:

	u32 name_hash = ocfs2_xattr_name_hash(inode, name, strlen(name));

	if (name_hash != le32_to_cpu(xh->xh_entries[0].xe_name_hash))
		return 0;

For a new entry that is the hash it will be stored under, so comparing it
is correct.  An existing entry keeps the hash it already has: an update
never rewrites xe_name_hash, since ocfs2_xa_add_entry() is the only
writer of that field for a real entry and ocfs2_xa_prepare_entry() calls
it only when loc->xl_entry is NULL.

An entry stored by a kernel that sign-extended the name bytes when
hashing can still be updated, because ocfs2_xattr_find_entry() searches
a non-indexed xattr block by memcmp on the name and never looks at
xe_name_hash.  Growing it past the space left in the block converts the
block into a tree, ocfs2_cp_xattr_block_to_bucket() fills the bucket in
stored hash order, and the update runs out of room in the bucket too.
The collision check then compares the unsigned hash against the legacy
hashes in the bucket and reports no collision.

ocfs2_xattr_set_entry_index_block() goes on to allocate a bucket that
ocfs2_divide_xattr_bucket() cannot fill: a bucket whose entries all share
one hash has no divide position, so all it does is append an empty bucket
with a sentinel hash one above the last entry's.

The re-search that follows depends on where the unsigned hash sorts.
Below the legacy ones, it comes back to the full bucket and the set fails
with -ENOSPC, having grown the tree for nothing.  Above them, it lands on
the new empty bucket, which ocfs2_xattr_bucket_find() handles explicitly
and ocfs2_find_xe_in_bucket() scans zero times, so the set stores a second
copy of the entry under the unsigned hash and returns success.  The
original stays in the full bucket, listxattr reports the name twice and
getxattr returns the new copy.

Pass the hash the entry is stored under instead: the stored one for an
existing entry, the unsigned one for a new entry.  A tree whose entries
are all stored under the unsigned hash sees no change, since there the
two are the same value.

Link: https://lore.kernel.org/20261009083002.2621201-3-joseph.qi@linux.alibaba.com
Fixes: 3bc753c06dd0 ("kbuild: treat char as always unsigned")
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Heming Zhao <heming.zhao@suse.com>
Cc: Anderson Ferneda <anderson.ferneda@braza.com.br>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: <stable@vger.kernel.org> # 6.2+
Stable-dep-of: e8de099f2958 ("ocfs2: do not read the entry array of an empty xattr bucket")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/xattr.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 8d15b0e824cdf..fca9ed94ca17a 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -5601,16 +5601,14 @@ static int ocfs2_rm_xattr_cluster(struct inode *inode,
 
 /*
  * check whether the xattr bucket is filled up with the same hash value.
- * If we want to insert the xattr with the same hash, return -ENOSPC.
- * If we want to insert a xattr with different hash value, go ahead
- * and ocfs2_divide_xattr_bucket will handle this.
+ * If the entry being set carries that same hash, return -ENOSPC, since
+ * ocfs2_divide_xattr_bucket() has no divide position to work with.
+ * Otherwise go ahead and ocfs2_divide_xattr_bucket() will handle this.
  */
-static int ocfs2_check_xattr_bucket_collision(struct inode *inode,
-					      struct ocfs2_xattr_bucket *bucket,
-					      const char *name)
+static int ocfs2_check_xattr_bucket_collision(struct ocfs2_xattr_bucket *bucket,
+					      u32 name_hash)
 {
 	struct ocfs2_xattr_header *xh = bucket_xh(bucket);
-	u32 name_hash = ocfs2_xattr_name_hash(inode, name, strlen(name));
 
 	if (name_hash != le32_to_cpu(xh->xh_entries[0].xe_name_hash))
 		return 0;
@@ -5707,6 +5705,7 @@ static int ocfs2_xattr_set_entry_index_block(struct inode *inode,
 					     struct ocfs2_xattr_search *xs,
 					     struct ocfs2_xattr_set_ctxt *ctxt)
 {
+	u32 name_hash;
 	int ret;
 
 	trace_ocfs2_xattr_set_entry_index_block(xi->xi_name);
@@ -5726,10 +5725,18 @@ static int ocfs2_xattr_set_entry_index_block(struct inode *inode,
 	 * the maximum number of collisions we will allow for then is
 	 * one bucket's worth, so check it here whether we need to
 	 * add a new bucket for the insert.
+	 *
+	 * An existing entry keeps the hash it was stored under, and that is
+	 * the hash a split has to work with.  A new entry is stored under the
+	 * unsigned one, which is what ocfs2_xa_add_entry() will write.
 	 */
-	ret = ocfs2_check_xattr_bucket_collision(inode,
-						 xs->bucket,
-						 xi->xi_name);
+	if (xs->not_found)
+		name_hash = ocfs2_xattr_name_hash(inode, xi->xi_name,
+						  xi->xi_name_len);
+	else
+		name_hash = le32_to_cpu(xs->here->xe_name_hash);
+
+	ret = ocfs2_check_xattr_bucket_collision(xs->bucket, name_hash);
 	if (ret) {
 		mlog_errno(ret);
 		goto out;
-- 
2.53.0

