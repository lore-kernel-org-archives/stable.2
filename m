Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051033;
	b=ghfaKxDbzmyRd0gNa77tRyRsfyZSzWnpnmtV2SZHPJBCBS33NZ+WWKv1Bx+AQBatMiTZ
	 0BPBsnTlEPjbeE2CxtlffwKh7dzBZlc0LdN7KlMnlt+eWhqSZOkBVvcbbh3+p34fh6ovU
	 qgZo0FayX+LjUG8PQ4LEI1JpXf6b/3MaB52kH5A7xoqgIUrdslC4TRUQUgmLiBvcU9lin
	 QWEEajBBpzsf8+8r1Ca9RypuhKHKXmmHyY655iWaZ1WLQN21VcVVMDZmElsYSJw85itbr
	 KLqzEWu6SSX2yIlscec9TQKLN+PQMCJQ6yJuwQS5bYAOV2f99CwdWaF7Gn147tk1PRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051033;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Z3Q1kfYhFy+8NSY9ZJsS7eQMwFgSFT7FUBQYo8YR3IY=;
	b=rEgIBFImb5LY66obV6n6++aDddm32bys9E9wR8LRkc/n8q9Eas/y6nRdecrdOebfg5gK
	 tZUwmaRrmQnOtfZSPr0SsZkYXo8Rdq6XuH8qI5jqOYomoJ1jsnf1AXqICmCqA+2cJR4f1
	 IXwyjPlmshb0/RD0ACh6CU7PCZBSMS9n+mi7iHdX1fxoe+fj+qpCb9qmjiHNxlcP5Nbfr
	 2egbPz5CnKOotjSF3vKJacoo63r745h8xOUVdxjdpf3JTBTw5g9EojPyeAuW7qSM5ya17
	 XEbGfyuROjUgQQR05PXefa6bfXiyPl9C4k5ZCGHvdsiYWlizXldemaPFXdJrW6BjNIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEFww1Sf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E7606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEFww1Sf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F021F0089F;
	Sat,  7 Nov 2026 11:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794051033;
	bh=Z3Q1kfYhFy+8NSY9ZJsS7eQMwFgSFT7FUBQYo8YR3IY=;
	h=From:To:Cc:Subject:Date;
	b=QEFww1Sfd38udYNqNRLycYhiNakPnxBd3O6NqOVC+IXDLvKj5DWKdCsjFqznH/xIv
	 Of8QMfAsGtA2DUw2BcPkQZ9uzJCo6LlU0i644th6Znhb70wliPObzsiK/MkzIGYE73
	 fLIVSINOOPGwEGivkjZDPATda4WE76zTe0roaXNFjDeXBVGbvVC1WO4b+EjokWYb54
	 ITLXGxcLHrAm23VpRfiYAGA11A5stOsw2+xUS7ZAdiM/KqLq2QO4wAO+xWgIeKzeD4
	 ps6twS+LWpN0Eui2NAIR2NfmzRib7bKMZiEVx6flTK9AmDboqHjfu0LUCt/xsK26+1
	 UlvxjAqoPEicQ==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fsverity: Be more careful with return value of ->get_verity_descriptor()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:30:31 -0500
Message-ID: <20261107063031-failed-5.10-8f8faec82aa9@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8f8faec82aa902b1997ae578c46bcc84afbad811
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107063031-failed-5.10-8f8faec82aa9@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8f8faec82aa902b1997ae578c46bcc84afbad811 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Sun, 25 Oct 2026 13:38:31 -0700
Subject: [PATCH] fsverity: Be more careful with return value of
 ->get_verity_descriptor()

If fsverity_operations::get_verity_descriptor() returns that the verity
descriptor has 0 size, then a zero-size buffer is allocated to hold it,
and it's called again with bufsize=0.

But bufsize=0 is a special case that says to return the actual size.  If
in the meantime the filesystem has decided that the size is some
actually valid size, it will return that size, and then
validate_fsverity_descriptor() will read from ZERO_SIZE_PTR and crash.

Of course, for the filesystem to misbehave in that strange way, it
generally would require direct writes to the block device.

Regardless, fsverity_get_descriptor() might as well guard against it.
Make it do so.  Specifically, validate that the first call to
->get_verity_descriptor() returns at least the minimum descriptor size,
and validate that the second call returns the same size as the first.

Fixes: fd2d1acfcadf ("fs-verity: add the hook for file ->open()")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261025203831.120095-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/verity/open.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/verity/open.c b/fs/verity/open.c
index 6646290430380..78a65154b8957 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -270,12 +270,6 @@ static bool validate_fsverity_descriptor(struct inode *inode,
 					 const struct fsverity_descriptor *desc,
 					 size_t desc_size)
 {
-	if (desc_size < sizeof(*desc)) {
-		fsverity_err(inode, "Unrecognized descriptor size: %zu bytes",
-			     desc_size);
-		return false;
-	}
-
 	if (desc->version != 1) {
 		fsverity_err(inode, "Unrecognized descriptor version: %u",
 			     desc->version);
@@ -314,31 +308,37 @@ static bool validate_fsverity_descriptor(struct inode *inode,
 int fsverity_get_descriptor(struct inode *inode,
 			    struct fsverity_descriptor **desc_ret)
 {
-	int res;
+	int size, res;
 	struct fsverity_descriptor *desc;
 
-	res = inode->i_sb->s_vop->get_verity_descriptor(inode, NULL, 0);
-	if (res < 0) {
-		fsverity_err(inode,
-			     "Error %d getting verity descriptor size", res);
-		return res;
+	size = inode->i_sb->s_vop->get_verity_descriptor(inode, NULL, 0);
+	if (size < 0) {
+		fsverity_err(inode, "Error %d getting verity descriptor size",
+			     size);
+		return size;
 	}
-	if (res > FS_VERITY_MAX_DESCRIPTOR_SIZE) {
-		fsverity_err(inode, "Verity descriptor is too large (%d bytes)",
-			     res);
+	if (size < sizeof(*desc) || size > FS_VERITY_MAX_DESCRIPTOR_SIZE) {
+		fsverity_err(inode,
+			     "Verity descriptor has invalid size (%d bytes)",
+			     size);
 		return -EMSGSIZE;
 	}
-	desc = kmalloc(res, GFP_KERNEL);
+	desc = kmalloc(size, GFP_KERNEL);
 	if (!desc)
 		return -ENOMEM;
-	res = inode->i_sb->s_vop->get_verity_descriptor(inode, desc, res);
+	res = inode->i_sb->s_vop->get_verity_descriptor(inode, desc, size);
 	if (res < 0) {
 		fsverity_err(inode, "Error %d reading verity descriptor", res);
 		kfree(desc);
 		return res;
 	}
-
-	if (!validate_fsverity_descriptor(inode, desc, res)) {
+	if (res != size) {
+		fsverity_err(inode, "Verity descriptor size changed (%d => %d)",
+			     size, res);
+		kfree(desc);
+		return -EINVAL;
+	}
+	if (!validate_fsverity_descriptor(inode, desc, size)) {
 		kfree(desc);
 		return -EINVAL;
 	}
-- 
2.53.0




