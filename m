Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657576;
	b=tS/OoSjJlULRxJgqEqMTDYptOHTqQiwFmJpVbeK5PNaa8MKKpHLnWgtCoZ7Ufg/T7Y6L
	 zIp+a1IC363s9IS1Jqo8lXx6Zz9jYkDRbo6wol3aFVKXLVKNcsH0iy5N2J/hpBT2jF7O5
	 Lfn5PQFmU4DzZEEyzhKWn3+j+ty28bbh7znNyjK7rS4ZsygMeCizWMy+6BSOrVExxe41W
	 6XGlxV8GYNzefkuKh1gh30vXlKRsabkmTrk08/9uSfvwUUwezsEFVXwd7JPq0Mx2nqfWv
	 wTKs6w7rAD5ZWAUOLaFiXrxgtQLnC4LuozVV4BXMAOw3ZqDhOI3f7XEqBKtCpFD7QdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657576;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+RzEzM4UchiOi8hQfSO0+t44cqbPeOZ1/zMd5FDZBWI=;
	b=CN01NNhLCxmpjGTZotg5UHMdRuqAX7vC6MDEJu5MLMQKJxgdpMKUdu+9TrmjPD5y/ZMe
	 rxmhbxb+BXkT/ho2BE+T26A84Ku5NKjAetVAwv7KW+EJATFN2Py16mLw/umMuMcUyb06u
	 WMta9AlZf3Q91bdShbaDsi1T+k0KX3kcB0ShoDl5EbekW1hdxKsgmGURC3BRCFdqtKBxT
	 0Pi+Ak4yP3iPyr1K/R3t59cjMIAdr61WoZuZ1eTdLcFgNcQ/LBHyhgM7JwCitFWEMerEM
	 3/gvKG89Xf+lx8ZgfjKE18cuBNL2l265McpY3A21LzF85qEjzKDKXu86zmSCkqVdbMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSb10Ksr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1119606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSb10Ksr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4171F000EF;
	Thu, 26 Nov 2026 01:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795657576;
	bh=+RzEzM4UchiOi8hQfSO0+t44cqbPeOZ1/zMd5FDZBWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bSb10KsrN03InOarPdh+bEKcy6hLJ4IZXFqRxi4tsT/qUpr4JPOxIX4GHiB0T5jHV
	 Hk1dGgQjvFgYqvPURteH1ERaQdiNyGGMfPxcYc3EJEvW+HkBYQkOG0WoXxf8uBGsgF
	 nFEHUOI0neHmee0qwokjjb6Mf6l6n/NNT0rWvm1yjTG3C2piJMa3xND2jaiFPytjJ9
	 mCpaXKhHGbmDr1WMH9onu26OVTBtvxK+0UP7sGHWYmwXEbsjINapJOytDaiX9mOOeg
	 144iFQ8M0pD3netAHkRC2jjl5I6zSuu6DCF7BH0Bec5zbRa4lvmeF0BFdwQTlTDMeX
	 iXjp8PM1C2NWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ovl: reject different lower idmaps on the same fs
Date: Wed, 25 Nov 2026 20:46:14 -0500
Message-ID: <20261126014559.1700035-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112500-shrivel-harmony-7572@gregkh>
References: <2026112500-shrivel-harmony-7572@gregkh>
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

From: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>

[ Upstream commit 720f40c05b2785406121da0151543751204f2953 ]

Overayfs mounted with index=on or nfs_export=on require file handle
support from backing filesystems.

Overlay file handles identify a backing filesystem, but not the lower
mount used to decode it. If lower layers share a superblock and use
different idmaps, a handle can decode through the wrong layer.

Record the first idmap on a private lower clone for each backing
filesystem. Fail if another clone has a different idmap. Comparing
the private clones prevents mount_setattr() from changing the checked
state. Distinct idmap objects are treated as ambiguous.

Fixes: bc70682a497c ("ovl: support idmapped layers")
Suggested-by: Christian Brauner <brauner@kernel.org>
Link: Link: https://lore.kernel.org/all/20260925-server-hager-riskieren-06116eded213@brauner/
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/ovl_entry.h |  2 ++
 fs/overlayfs/super.c     | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index a479680a5ccd8..67a3b8f6c162e 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -25,6 +25,8 @@ struct ovl_config {
 struct ovl_sb {
 	struct super_block *sb;
 	dev_t pseudo_dev;
+	/* Idmap of the first lower layer on this fs */
+	const struct user_namespace *lower_idmap;
 	/* Unusable (conflicting) uuid */
 	bool bad_uuid;
 	/* Used as a lower layer (but maybe also as upper) */
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e8e7e1c59d95d..215ab87c4c2bf 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1769,6 +1769,28 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 			goto out;
 		}
 
+		/*
+		 * Lower file handles identify the lower fs, but not the layer,
+		 * so with different idmaps on the same lower fs, index and
+		 * nfs_export may decode a file handle through a layer with the
+		 * wrong idmap.  Following copy up origin without index is only
+		 * used for st_ino, which does not depend on the idmap.
+		 */
+		if (ofs->config.index || ofs->config.nfs_export) {
+			const struct user_namespace *idmap = mnt_user_ns(mnt);
+			struct ovl_sb *fs = &ofs->fs[fsid];
+
+			if (!fs->lower_idmap) {
+				fs->lower_idmap = idmap;
+			} else if (fs->lower_idmap != idmap) {
+				pr_err("lower layer '%pd2' conflicts with idmap of another lower layer on the same fs, mount with '-o index=off,nfs_export=off' to override.\n",
+				       stack[i].dentry);
+				iput(trap);
+				kern_unmount(mnt);
+				return -EINVAL;
+			}
+		}
+
 		/*
 		 * Make lower layers R/O.  That way fchmod/fchown on lower file
 		 * will fail instead of modifying lower fs.
-- 
2.53.0

