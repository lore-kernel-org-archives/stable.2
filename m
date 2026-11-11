Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408114;
	b=hskTDgXhIMOkHH3Qa7etJGIijQWQuPHjl9bs4H6bDpmIGphhQzKS+FDUCx+79AQVxf5I
	 hlDnwEduBsSjmhpfUrSfTSijE40iPR/4o3tn8AfRZTFFpnujUA6hH+cJGCfZKtWW0IkED
	 dywxDEhQuOrs9dM1thCZPC+t/2yEPdjDbP9ASyUgfwL6NWZje30f00CRN4zWQ0WGdQBc5
	 Ng/f1uTQLBkTBRSL+fRkBlbo4qqX67Q5m6fzpqweGrxOphKlMP6nqfAzdmp9D3CZymQya
	 EhS64foLfRIA6Q8NZ5qVQI8XCJFGHzqCOxu4t+fnvo/buW8ZjN/h/G3goFh9+fpWudQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408114;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UtAUrPqHaMf9zmdSv7TWWIcCkuTXhb096ATFz2cp67I=;
	b=VUd1Evz5FBzrn4SOE3kAYcIn7mhSLVvMRrV3mhp90ISGNSQV9PfwS3J78MjrfTbIoN1a
	 3Go1WcClYJE2/XbdOaKbTfcTlVF5TRMk/JGpIDhnm+mIueP0bghww+6xQ/fO9wfAal6uU
	 PBFSBTA/BWaRQdIxraw1pGReB2DEvdcSZjqCfIhDRImiHpi+dfx2fdUQRTz64emijZcRA
	 UNSzml5GTdgmWFhzZ1AMjhKORcz1mBDfy3GiYqjZ/HxG3obPxCAnWVdZckFD8Zx6CTqww
	 9dQ1935Wt8gTUFQvpYEnVozDICPMuWTl1mNA3jlo3pyBv16jVeDW8CwtlaU75E0m1jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iv539h57;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D365D606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iv539h57
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FF11F00A07;
	Wed, 11 Nov 2026 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794408114;
	bh=UtAUrPqHaMf9zmdSv7TWWIcCkuTXhb096ATFz2cp67I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iv539h57o0xUVPS6im9ax+uvXFm6GyQoHYM3q9DY5M/GWIvWhLF8B5CV9mL1x4IT2
	 0+sKHVHp0abumKURSXzQWqpZDM44egbngLi0rn6MO0YtTlIHLubz9w1GYUivOauXb7
	 fau25iJ/BjmzmjzZbO5MTbn/hbiOEUwhW2tGvRoGCkepsZcC9zZYrL5chDnrqYQvT7
	 aTt5E1av+3M0Up5z7h+DuVBbwG3ZSgw/E98d61doiWQkWUGtwpeBj7Y/fc2IuRvckW
	 XggdDqJ94MzxoyGRbIaP8r/miLNNhSkZNR8K59JuZZ4/gfRNcLP6wYpAfzwFiqq19w
	 alxMNmeYNQaMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ceph: fix longname buffer overflow in ceph_fname_to_usr()
Date: Wed, 11 Nov 2026 09:41:52 -0500
Message-ID: <20261111144120.2371463-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051452-failed-6.18-71975d6e0db1@kernel.org>
References: <20261107051452-failed-6.18-71975d6e0db1@kernel.org>
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
[ sashal: adjusted context to preserve tname->name access because tname is a struct fscrypt_str pointer rather than an unsigned char pointer ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/crypto.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index f23ba5c148780..eaf12c9c86ee5 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -370,6 +370,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 	struct fscrypt_str iname;
 	char *name = fname->name;
 	int name_len = fname->name_len;
+	int dst_len;
 	int ret;
 
 	if (WARN_ON_ONCE(tname && is_vmalloc_addr(tname->name)))
@@ -445,6 +446,9 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 		iname.len = fname->ctext_len;
 	}
 
+	/* oname->len is overwritten by the decryption below */
+	dst_len = oname->len;
+
 	_oname.name = unlikely(is_vmalloc_addr(oname->name)) ?
 			tname->name : oname->name;
 	_oname.len = oname->len;
@@ -462,6 +466,10 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 
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

