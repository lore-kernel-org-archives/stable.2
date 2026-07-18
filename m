Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC71330B32
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784377834; cv=none; b=XWVRID9YuJ/hWl/AuAngIrXtxM7xGR0EzLqrILQzHi7+K1u5Rvq2cuzfJi7CclW8sgfWrZXEVL+M4993pdz2Aaj0sRbbYaGe8NOM8XW5bCVEmDS5f1cwAul7dW0pW8zMxOs9ZMmWghTUwtKKGd2UKISk+xG77pTlIhHcSEUNn+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784377834; c=relaxed/simple;
	bh=cTNNqPSMnj1fCXtyk8ADvbsWRf7ftV4Zdu1T7jGTpZo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Qn9CiqhPiZFwu/pDLM5qsY62Z6qd30LGmGCT+AxtE0hSDgoO6mZag0gEae4AUpIdQOOQrtMG2hQasso3Ah6DUtZ1vgkivZ9TnuMgdtNBBufZCr/yA1Z3Iuen8Eemc9utJS0l7F1OmDcXKEPtBjyoKHe6KSlCm/fmJOLjPC2/ouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=NH4yEA65; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="NH4yEA65"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1784377828; x=1784637028;
	bh=9RK8bTsHhBxhaLjwQz/IzdDTZqrfUA9p7MIwWqMXP9w=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NH4yEA65EEMkBMgNqM5BMYf6FN7lXL2/L8dDVMp9yeGG+3UfcJyCZ+tnn6ie+90n5
	 tYsxzJq/kepAdBX5MVWDJUrIWKR/VOpUiJmOikHEX7wUh0mWYtlqjVNCvJIoeYND0w
	 F9cDvDrFaXboNJyJB2x4ZtQQW2b+WHfzgRtDbqPdCXC7fLeg26HTqo8ONuJqb86gvo
	 4OlewTa59zmI05C9TwaFb31saQ362vBUfGIfTAEYxqqCRQ6BH0S5AE0E+xEReRiMFv
	 Z4yQh1lqUb3/nGj2Is7tSUQxs8rsvuyozK4NpQ9gv3KFrAN+EODvTX9QrMBw8oBCfA
	 eXon0BEyjCOfg==
Date: Sat, 18 Jul 2026 12:30:22 +0000
To: Dave Kleikamp <shaggy@kernel.org>
From: YANXIN LI <fadouse@pm.me>
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, security@kernel.org, stable@vger.kernel.org
Subject: [PATCH] jfs: reject negative symlink sizes in jfs_iget
Message-ID: <20260718123017.197132-1-fadouse@pm.me>
Feedback-ID: 173252840:user:proton
X-Pm-Message-ID: 6aea521049a926d39e6039fc3a769453001ff721
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------66a0211ac4d0852063a7bc4eacc4490913d46e17cdcca0e69fd9aad2981d8e5d"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------66a0211ac4d0852063a7bc4eacc4490913d46e17cdcca0e69fd9aad2981d8e5d
Content-Type: multipart/mixed;
 boundary=a4ba49734eaa22fc02c7a245b1d2de2f58004e975412022b43298a37c5ae
From: YANXIN LI <fadouse@pm.me>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] jfs: reject negative symlink sizes in jfs_iget
Date: Sat, 18 Jul 2026 20:30:17 +0800
Message-ID: <20260718123017.197132-1-fadouse@pm.me>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0

--a4ba49734eaa22fc02c7a245b1d2de2f58004e975412022b43298a37c5ae
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

copy_from_dinode() copies the untrusted on-disk di_size into i_size
without validating its signed lower bound. A negative size on a symlink
bypasses the existing IDATASIZE upper-bound test, after which jfs_iget()
uses it as an index and writes a NUL byte before i_inline.

A crafted JFS image therefore causes a one-byte slab-out-of-bounds write
while the root inode is read during mount. Generic KASAN reports:

  BUG: KASAN: slab-out-of-bounds in jfs_iget+0x44a/0x4a0
  Write of size 1 ... by task busybox
  ...
  jfs_iget
  jfs_fill_super
  get_tree_bdev_flags
  path_mount
  __x64_sys_mount

JFS requires a privileged mount path, so a relevant boundary is a
privileged automounter processing an attacker-supplied block image.

Reject negative symlink sizes before selecting the inline or page-backed
symlink operations. The same image is rejected with EIO after this
change, with no KASAN report during the test.

Source inspection confirms the same unchecked write in the
 released
v7.1.3 stable kernel and the v6.18.38 and v6.12.95 longterm kernels. It
is also present in v7.2-rc3 and upstream master at 1229e2e57a5c. The
affected upstream range starts with the commit named by the Fixes tag
below and extends through that master revision when JFS is enabled,
unless a downstream fix is present.

The issue was dynamically reproduced in an x86-64 QEMU guest running
v7.2-rc3 with generic KASAN. The fix was also built and tested with the
same image on upstream master at 1229e2e57a5c; the image was rejected
with EIO and no KASAN report.

Fixes: d69e83d99cf8 ("jfs: ensure symlinks are NUL-terminated")
Cc: stable@vger.kernel.org
Signed-off-by: YANXIN LI <fadouse@pm.me>
---
 fs/jfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index c7914dbc9..c53985ee2 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -46,6 +46,10 @@ struct inode *jfs_iget(struct super_block *sb, unsigned long ino)
 		inod
e->i_op = &jfs_dir_inode_operations;
 		inode->i_fop = &jfs_dir_operations;
 	} else if (S_ISLNK(inode->i_mode)) {
+		if (inode->i_size < 0) {
+			iget_failed(inode);
+			return ERR_PTR(-EIO);
+		}
 		if (inode->i_size >= IDATASIZE) {
 			inode->i_op = &page_symlink_inode_operations;
 			inode_nohighmem(inode);

base-commit: 1229e2e57a5c2980ccd457b9b53ea0eed5a22ab3
-- 
2.54.0


--a4ba49734eaa22fc02c7a245b1d2de2f58004e975412022b43298a37c5ae
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - fadouse@pm.me -
 0x99485AA3.asc"; name="publickey - fadouse@pm.me - 0x99485AA3.asc"
Content-Type: application/pgp-keys; filename="publickey - fadouse@pm.me -
 0x99485AA3.asc"; name="publickey - fadouse@pm.me - 0x99485AA3.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuOS4wCgp4ak1FYVV1T01SWUpLd1lCQkFIYVJ3
OEJBUWRBdG5ZbFN6SFRMSEEySXp1TkUxQXk4SnJLVUN4NmhQKy90YzRMCkRYQ25yZXpOSFdaaFpH
OTFjMlZBY0cwdWJXVWdQR1poWkc5MWMyVkFjRzB1YldVK3dzQVJCQk1XQ2dDREJZSnAKUzQ0eEF3
c0pCd2tRdVoxZ3QrWG0yWFJGRkFBQUFBQUFIQUFnYzJGc2RFQnViM1JoZEdsdmJuTXViM0JsYm5C
bgpjR3B6TG05eVp6bTBCcDNlRVhSV2tuSWdDbFd3dmR4Wm1vMVhuVmI2RmthalhUVk0xQi9qQXhV
S0NBUVdBQUlCCkFoa0JBcHNEQWg0QkZpRUVtVWhhbzNaL0FuQkk0TEJZdVoxZ3QrWG0yWFFBQUxx
MkFRRDc4SzZwZWRTWDNsZE4KeXFkM09IMXVNak8zdjdMWU1oTytsN2NuU0xXckVBRCtPQ1NxMTFT
ZWFLb2JzVkdyTGVqVE1zbU1zUEI4am54ZgppZDNoQ04rcGV3VE9PQVJwUzQ0eEVnb3JCZ0VFQVpk
VkFRVUJBUWRBd1hkelZJcUVIL3g4SFpqUi9QT3QyQWlGCmJFbTZZcVhYMmoydjJpS0RzUU1EQVFn
SHdyNEVHQllLQUhBRmdtbExqakVKRUxtZFlMZmw1dGwwUlJRQUFBQUEKQUJ3QUlITmhiSFJBYm05
MFlYUnBiMjV6TG05d1pXNXdaM0JxY3k1dmNtZGRLTlFZREZXY0VWZDN4T0hlUXA2cwp5bjc5TkZw
TnFrSHoraXpwSUxCblVnS2JEQlloQkpsSVdxTjJmd0p3U09Dd1dMbWRZTGZsNXRsMEFBRHpRZ0Qv
CmNJSjA4OUprbm9nVHM2dnZRWitKM0xSSURhSTkrUW0rVDVxT21OazR5WEVCQUxQSWxKQ1M4YWg1
ZEJZWmE5TCsKSHFqYkRtZVNnRG81OHVTeCtpV3crNlVMCj1NdXNUCi0tLS0tRU5EIFBHUCBQVUJM
SUMgS0VZIEJMT0NLLS0tLS0=
--a4ba49734eaa22fc02c7a245b1d2de2f58004e975412022b43298a37c5ae--

--------66a0211ac4d0852063a7bc4eacc4490913d46e17cdcca0e69fd9aad2981d8e5d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgmpbcd4JELmdYLfl5tl0NRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfUp7LmZETrw4CX/A7ABwW9FiEEmUhao3Z/AnBI
4LBYuZ1gt+Xm2XQAAINiAQCCJpJUV284CpdgVkRI+soZDkaEN0+gmNBTCg8H
CyoGDQD/XSpAr3aQSLZXIQQ2O1DXIuN53vAFXKpbIPR3VeLBPwE=
=JCy5
-----END PGP SIGNATURE-----


--------66a0211ac4d0852063a7bc4eacc4490913d46e17cdcca0e69fd9aad2981d8e5d--

