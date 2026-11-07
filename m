Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080727;
	b=1/UU3pSKBdgEmHSujpdYkNCo81ayAx9zVP7/TKyjK6gBGUT+xFG19QG6ETf3CH0iJjSf
	 SYojd++in03qWcR0JSy12kdyPIdOmrwzXQvWwFKDt+PtONN2gNSct79JstkZ+ShmK3qXx
	 6EWcPnaJ17lw40qM7n5faNvzLjjU7OExs7KLmTaE3KZeAPVUgt7QZlB7JHeRhWGaxTMT/
	 Hb90U1s2p7eVqq819f3/ZSaVXIsObDHrYO4S7flUokT7V5ClX6rQGneHMVZAIA1/bdBvF
	 f8nzbQ4/Tq3CePdFqepTV92X6+RYqADl8woayYozFMSgSJ/pa3dEpi6WrS7lFngRfXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080727;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kUDBLA6HWvDZrEEmzk/nlIhBvwFlldmV+Ko2ed2kvvc=;
	b=CcpG+AfjCdRI8Bxip3HzOUI4BIGYBzrZ0D0n3jw5lFnuzZeNntCKdVLS21/9EPB0g3Cn
	 kP94Q3gxLpSjM0V562Tx9F68mx7dWgznd6MBkHVElOJxWxu4TLaqciPlU3j81D5brDgAb
	 Dwp32Pip4J8UoKEPUcQdP8tuUMMlp4wHtiezrae1IoV+arg+/LMFK2PRO9Shjl3Mua4DM
	 WEiu7FBLxB6cMGcGgm/Z2ijgPbcFPnYdoCbseO6bPVRKu8NsWBeu1W6+gFDpJXZiFqg/Z
	 VyVJAjdCpPJsYDC5QB/XzXgBc6lYpgkVhBRY8TQ84GWeaTyHYp+2Hyzk976r1hJHEBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBwypzTS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC25D606A32D;
	Sat,  7 Nov 2026 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBwypzTS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749BA1F008A2;
	Sat,  7 Nov 2026 19:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794080726;
	bh=kUDBLA6HWvDZrEEmzk/nlIhBvwFlldmV+Ko2ed2kvvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fBwypzTS7PGE392uMznlQF6PtB2Yl5gzR4KCYvnpbBZ6D0pfJUfMhTzYvSyHULLMN
	 00SVKG2ph8OKZwaTZle/hx8eveRQARIxOzGMu0JIm4ixhmWvkMWWuN+RgdQvcN9wfM
	 TGKbKowCiwgHWMk1L990fOn0tZqZI5eRRbdgo+pCqf6IajnnZB3piS5QZ3uj71ESIO
	 TkNyqmhJzbxEDOy1d5Optc5o+zSPSiJ4GhUoC0nLo6M7F2WDaaeNytlr37RGKf/GPR
	 fw033626IWpT0/wm8QwCbgAxAwD8gAhPQBbgsRN3DaXkXdZYGuT+Js3DVQx6iShndr
	 r+mV1ebFhbwgA==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 5.10 2/2] fsverity: Be more careful with return value of ->get_verity_descriptor()
Date: Sat,  7 Nov 2026 11:44:45 -0800
Message-ID: <20261107194445.55959-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107194445.55959-1-ebiggers@kernel.org>
References: <20261107194445.55959-1-ebiggers@kernel.org>
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

commit 8f8faec82aa902b1997ae578c46bcc84afbad811 upstream.

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
index 804bd717c4d32..7a786126a1340 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -221,12 +221,6 @@ static bool validate_fsverity_descriptor(struct inode *inode,
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
@@ -266,31 +260,37 @@ int fsverity_get_descriptor(struct inode *inode,
 			    struct fsverity_descriptor **desc_ret,
 			    size_t *desc_size_ret)
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
2.56.0

