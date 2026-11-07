Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047968;
	b=RCulTPWqg7s9KR9cQ/9mIxrhLQtAaQMChJWOGlNzDZfE5/pKPjdFsYZWwdIddTpI+WZC
	 X7C3vkvrZ8cQYM10ACASeOm3chpHkc6m+ZTbM6oaEUMbOa3U3IQeIVuAqnU8T2ia134Gg
	 MxP1k20u10vW253j9BIM14/Mx76ekhv4tOmgggdWL4jSL6PhxiEB2mVHprpIB+J7MySFN
	 QOkmBLqmBKMZmLV3rj+0N+wBSz8OpTibglE/Hb+JaZxYgkeA/EYcSTCTvjBAgos+UcQSc
	 HIWo4E72VfnZr5cLhlpLoTkEKjybl0JXuHjCSKlIdC7a6ZoLrS3X9UGJnePOLkb/r1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047968;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tKO17cbImWVdNFCJdN/J4ySObTMmXnlVtwsO02uMBXE=;
	b=Nd93EVscK9Jx7vKB9uMqt3SaMtZD3hOnGD4MCqdviOjC2xJwOpC1jel2xWcIL30D5KdL
	 CUNbrQhjREw6EOJFU4TvsKnCBI6sF4qlTdfKQGSvuyeng76rMMcdPuWtF9Nxe2WSKUZvw
	 2jrph4UAaPx4+o/tAmb9S3IuHMIicrzT3jhpXpeoOWwGVTFZS6W3rchWOMpJKvm3PTw3e
	 7OAMICbBrkqLgHWrvLfxpHdv7lam7T7q24960Qk0sAroEjssomXGQjmoICF+iDhl5JAJM
	 6tbkiNwDl4WUNNQ3NiiBLlGG3gYWCc8mWQmo0i2tdRHVGnaioVlUaBBlRexl44GLgwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RF4WXpVD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A388B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RF4WXpVD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099EF1F0089F;
	Sat,  7 Nov 2026 10:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047968;
	bh=tKO17cbImWVdNFCJdN/J4ySObTMmXnlVtwsO02uMBXE=;
	h=From:To:Cc:Subject:Date;
	b=RF4WXpVD/viarhENA0GRc7j9VqSiYQn/c4ObpW92lLXqzchqXXaQ/b51JRQ2jwSTs
	 r+67PiVrmpCbEUKbJHZikrNx8DhiTgJ534e0KldMESR+8LRdnTU0cMk2NIrcEimFLS
	 KHZKjB57vUa6bJDj4DaeUhgFcG7ZNJaky2uxsz/KniXSLPS26jRqu1o82/MoAvgG4F
	 Pv+vp1SRgQFirXiI5uZTnIycDrf3ZRtpKHa1B1CLEjj+nCOaEcz8gWyXQULR9SzA8+
	 0yV7fGK051eGLLwJY7QQ+SMlG91zetDM/+QtxTAVcmvn4oG6Ugg0aqL3nok0kQPMsf
	 a+RK3K2xOAFqw==
From: Sasha Levin <sashal@kernel.org>
To: yijiangshan@kylinos.cn,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ceph: fix longname buffer overflow in ceph_fname_to_usr()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:39:26 -0500
Message-ID: <20261107053926-failed-6.6-71975d6e0db1@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 71975d6e0db17646102488cf54480fda9de0f7a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053926-failed-6.6-71975d6e0db1@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




