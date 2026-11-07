Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047203;
	b=AS6uSDrn3HOvI3aJQry5gsw+RVGQ37R8apU+YphNuH3P2cxDhkN0xD3a9/NDdSRhyjUU
	 1r54hfsSsv1FnZVcDSZUKbL0GAn+xJf+0Cnp8yBCY67SbyJqOhd49yzRadeoR3GVgHGHO
	 +cMPq+62vZgiVwESJiIWw2ZMnUjUvUANLPj0t85F2C52/6DuHHw0MbCWRX5y25Q0g/g3d
	 etoRwS5be76pXwMs7IRnt6FwRbfKrO7gDSVPKHp54p2wAWhNNSsxORc8/o4QiKIITOfVH
	 ptuX/QT1ooiJEbZstQBbxIwiAa/rpahfD67ondL+mDpadTRWDB9WDRshzqynBEcoQ7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047203;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lzvOS5gIDEQTGroZlc7K452UfMMu2bd5kauJLjCJLYE=;
	b=s56ymXcnvQuBAzpAcQaIKvah8dtijyCb2PCc/r4iFzIL9FuvuEeeeavU5VT6s83SnjLC
	 /gL6lpa+ghDTHRsgzc7WW83wTLTmnLwyhvjWQkdzOvErydiRR0mV8RCzVdH/jvB2Ja81C
	 PTD5DODaTHa82+/0gLN2WRnuTtZMq0H98LSypOySl0m4Rd+BKdqfGheNjnzl1jE6wWOvq
	 Bt3FwAlMpRTwy67m4QkNS5TSEEMdYhhpQCWIdcBKyBcQNh3JrG9fvTVyvK6rc4E2qGHV4
	 58QWHaBm4CZCVZOc512vjy7f1gEflb9Ijxmt8CK6jWm6pNck1a9klljDpv7LZso2gpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASp1rw1g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASp1rw1g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6532F1F0089F;
	Sat,  7 Nov 2026 10:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047202;
	bh=lzvOS5gIDEQTGroZlc7K452UfMMu2bd5kauJLjCJLYE=;
	h=From:To:Cc:Subject:Date;
	b=ASp1rw1g1HD4PabgmWzZ29rUwztP9XccqKkc1avA16Drmlcn2lbOvXJTFLVOWwE95
	 gzy1zUnFTlc3XI8xbMdNNNpyjw7WtzzIgFJLsZthok14iG5f1xDfFRC4YJFXDUaEUr
	 9ZPV2AU72z8/U6LH+w3DlucaL4r9pDOn+vCZve3B8vzT9X+UX7mq5AmNomBookZTsO
	 KuUZ/6lyIwyKkH5a79UojtySzRevjZyB+lp0NKATzKal6OGyMrQCYAhDcOGC7ltOU6
	 Qg+XKmfM/uv6NXSOZuxYQnowt5AIM95925fKaT+TLl2r+vB18fYatchV7Ysbsr8/31
	 pP2nD4zl0dCeA==
From: Sasha Levin <sashal@kernel.org>
To: yijiangshan@kylinos.cn,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ceph: fix longname buffer overflow in ceph_fname_to_usr()" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:26:40 -0500
Message-ID: <20261107052640-failed-6.12-71975d6e0db1@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 71975d6e0db17646102488cf54480fda9de0f7a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052640-failed-6.12-71975d6e0db1@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 71975d6e0db17646102488cf54480fda9de0f7a7 Mon Sep 17 00:00:00 2001
From: Jiangshan Yi <yijiangshan@kylinos.cn>
Date: Tue, 8 Sep 2026 11:18:23 +0800
Subject: [PATCH] ceph: fix longname buffer overflow in ceph_fname_to_usr()

Snapshot longname reconstruction formats "_<name>_<inode>" via snprintf()
and memcpy()s the result into oname->name.  Checking the length against
NAME_MAX only protects the LOOKUPNAME/export callers, whose buffer is
allocated with fscrypt_fname_alloc_buffer(NAME_MAX).  The readdir path
points oname->name straight at the altname in the MDS reply, whose
capacity is altname_len; the reconstructed name can exceed that while
still fitting under NAME_MAX, overflowing the in-place destination.

Save the actual oname->len before the decryption overwrites it, and fail
with -ENAMETOOLONG when the reconstructed name would not fit.

Cc: stable@vger.kernel.org
Fixes: dd66df0053ef ("ceph: add support for encrypted snapshot names")
Suggested-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/crypto.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index bc0a097a4cea9..845b69ba890c3 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -313,6 +313,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 	struct fscrypt_str iname;
 	char *name = fname->name;
 	int name_len = fname->name_len;
+	int dst_len;
 	int ret;
 
 	if (WARN_ON_ONCE(tname && is_vmalloc_addr(tname)))
@@ -387,6 +388,9 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 		iname.len = fname->ctext_len;
 	}
 
+	/* oname->len is overwritten by the decryption below */
+	dst_len = oname->len;
+
 	_oname.name = unlikely(is_vmalloc_addr(oname->name)) ? tname : oname->name;
 	_oname.len = oname->len;
 
@@ -403,6 +407,10 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 
 		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%llu",
 				    oname->len, oname->name, dir->i_ino);
+		if (name_len > dst_len) {
+			ret = -ENAMETOOLONG;
+			goto out;
+		}
 		memcpy(oname->name, tmp_buf, name_len);
 		oname->len = name_len;
 	}
-- 
2.53.0




