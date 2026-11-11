Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408471;
	b=qwsH8+l0Eew4QIri2csybkEHNfSmRHlcfIxMVmBUDJk1P1ERfDfbDXTnJuTIQYX3x/8I
	 1/Q6oVvcIkYnt6NnJTC5SJrbid4rrpxK8jJoNJXVUg+lVjG7q7ra8VFPOkEnVkSpsRWRy
	 vgPfBOyDI5Xs0TU0c+MlfYciozHjGRlJfcabVUsJoPSUQM0NxkoJxd1GwViXIPoWMkYlA
	 tcuTLC3FMRgags/BFlw9wgRF/52xzqZdafvQybTfXPaFqqEVHFlwKsZpFhnaX4gdfM5Cf
	 jHh9kclkUxEjpODtiw8JS7Erukp6tqLrMCV5T4+/Nuj+wQiiyN9xWwTPpAYe+WleR8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408471;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dVo3UWfNLm5MzcGJrPPxngDCYnmUZLpnuJzO84ZDdCw=;
	b=ESnuEiAOAYZZiee9QOOnFyZC4W+C3gHXDcvevrCl1VIpv1C4Ql+dxvbUQ9tF4dsat0m3
	 nBCyXYGHdP76s5g/2GLWEOp7ONBgTm2yEZEihZAJuAStaTrFbQe6GyTIqBBAA4pgml7sE
	 loL0wh5Thf2mDbx7RM3KCcd7J8RMYP/tHD4vrGcz95xGjMVoVYryqFWFwX1uXpZ0Etyw7
	 CP2tCMu9JYIBvxtMwSXON+AM8HBlP0k8/yiJaM2EbSDutJALDKvfixAuBenXTL7/+qC5e
	 syVgGPdCc+URmO6h5FefL1R+mTW8NUsUbCB4Vr3UQWn1IZfB4/ES3qaaBHXlBFmg06g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X1xsscS/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C23D606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1xsscS/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD7A1F00A05;
	Wed, 11 Nov 2026 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794408471;
	bh=dVo3UWfNLm5MzcGJrPPxngDCYnmUZLpnuJzO84ZDdCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X1xsscS/x70Qmd4/UGHBsSmQ9DLxRUuQWIoYOHCVxJ+0YDkmYy7AKRvG1VDWNIbjA
	 hQw7PQPLGd9kaLvyk09V79vZ5kWSpqkkEIgAvLdCNqtZ4cwaPaaDLGg/k1NlWBDx/H
	 nPWj+Xn3Uy6FwJX4A/W1JRG3IUbAV3J4LmxIMK5J17VtFq71CEi7zZWvSgxJSk5gKF
	 6yvA9LTUm9Ax2IKlLEp16vIP4WK9RM6IyF4hydQPSK3q1fMsC9EF8uagpCEfswS7Z3
	 f9erKTnHI4kR4/k4WzS0IvWvHqu0+i4AZBCTrKHO47OCKKP93pM0S50VB/Zygm+xzt
	 bfET41u9PRwYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ceph: fix longname buffer overflow in ceph_fname_to_usr()
Date: Wed, 11 Nov 2026 09:47:48 -0500
Message-ID: <20261111144626.2448202-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052640-failed-6.12-71975d6e0db1@kernel.org>
References: <20261107052640-failed-6.12-71975d6e0db1@kernel.org>
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

From: Jiangshan Yi <yijiangshan@kylinos.cn>

[ Upstream commit 71975d6e0db17646102488cf54480fda9de0f7a7 ]

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
[ sashal: adjusted context for the struct fscrypt_str temporary buffer and %ld inode formatting ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/crypto.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index f955a37d6b17d..97fa6b821d5e8 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -389,6 +389,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 	struct fscrypt_str iname;
 	char *name = fname->name;
 	int name_len = fname->name_len;
+	int dst_len;
 	int ret;
 
 	if (WARN_ON_ONCE(tname && is_vmalloc_addr(tname->name)))
@@ -464,6 +465,9 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 		iname.len = fname->ctext_len;
 	}
 
+	/* oname->len is overwritten by the decryption below */
+	dst_len = oname->len;
+
 	_oname.name = unlikely(is_vmalloc_addr(oname->name)) ?
 			tname->name : oname->name;
 	_oname.len = oname->len;
@@ -481,6 +485,10 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 
 		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
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

