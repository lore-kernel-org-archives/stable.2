Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046494;
	b=ak4NGMJe9Kmo+rGgse3W0k+vyI05zOwFJabiet8cGhcxwVnAIDWGrPhwFEY/sI556+sj
	 r3wtmOvZv05r0G8UgozfM3wmBLdD2+w3NNhkL6Pfgdc4+oerwK9kqXTCxFwiiKMRJuFHX
	 5A5hMgbOaDKmjjwR5wbElxtk7uzgQmRqds3BZ1+MB1y8/oiBETFLp87oosqFkrHK3N7Xk
	 6DE5bxr+J/uEX7ypxzxVKEMGw7vlARWer32MLyAqE8zD7k2be+rh1bGfaUWameEvrH56/
	 Xji5N5qRmabxEVc78dHk735jFWli9DfkW5bMiXvf494bKR3sBa+Mg1EypiGBh7EFNew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046494;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CRxo9eTTjz5dCh1CZEeGlk3wNJTuD2A+pvpG6nuNWeI=;
	b=m+c82lLThl62l1SIHDKaKGaNzBjK9yc0JvFsKcq5oEe4NFq+85AYc+z6GEGMaFEKKhfp
	 RRvbCAjv5lcPua+1ZrXV0ctC6E1bapSe+5by/i9r2vY3rtnPWNDJbXQeLopnWwmubuRX0
	 MGH2phc2RSshoXV8PeW6iDlwJKxNGRH00pI2BqZF2JnQI2a4bb61ASKIqeKxBacoJR5A1
	 UlKaQt3zqAaJEZq4Bfgdi6M6HpelzhXVRGE4A2X7ZtoRzQykJQwoinLaATqqWezVyL8jf
	 wvY8XpFelGC3Kg72aamN9xmFuCg4oL0QGkL3qErPLkRro/iNJYjbEuV+myNj2zy6X6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fxzOLT//";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C87606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxzOLT//
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385191F0089F;
	Sat,  7 Nov 2026 10:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046493;
	bh=CRxo9eTTjz5dCh1CZEeGlk3wNJTuD2A+pvpG6nuNWeI=;
	h=From:To:Cc:Subject:Date;
	b=fxzOLT//l80DEXk2WU3SlluBhSExV+9j0TiZ/OJdAr+Ix16qbsZBPWJrUy6rf6oox
	 07CRBx/eKTcQoUMug60UTCUyiSQT5WC47TqIeMvmx6qU8nh2ddiE8K8LS2vk7VdpSm
	 fPmpPqVx5BNm6B1igjHgQHoq+EXppwvPNNSpmQ1/RIOkL84tjjKzqy+cIZiutoj89u
	 hlkYCxX1xWAWD5+PQ3OU5DQdn5Lsg8rNDg30FcaU+qxXobnU7jfqyAk7ziqt5/V75l
	 VbWEZ76W/94+8iJAqd5+p5beoIk5xybRTndXfAKMyQqgEyvAGH5upHsG4N2EO+Bj/b
	 Txfh21uYczcRA==
From: Sasha Levin <sashal@kernel.org>
To: yijiangshan@kylinos.cn,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ceph: fix longname buffer overflow in ceph_fname_to_usr()" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:14:52 -0500
Message-ID: <20261107051452-failed-6.18-71975d6e0db1@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 71975d6e0db17646102488cf54480fda9de0f7a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051452-failed-6.18-71975d6e0db1@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




