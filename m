Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658636;
	b=FS9Ntqq/0bv7JQB28wn19ZNqrm14rAmfyZwP09/GQFz2IKwuP4lGJUCLm0F8fQeXWZSA
	 7tDN6LolVuOy3o7yolno0gJzi5r7ARAtTnxqJaRp0jEti2S9j1TuaPRsClytlZyuIMVeO
	 mlzNqhDLFsqLiDdQO91+GttJpoiXpqMSMtanJ0wTvWd7+7p/tzzuMDJlmzOpJ/wf7W6tZ
	 ef1DOGnYYWoK6oNhVXAf83d9hqeg8/FzI2rO6AM1SGpIbpQf89lPGfq75ht6fM496+SeX
	 sSpSk2ziL9ZCkZCevwN9pRuLZ73c3empk/ON2T6BINFdqlBjSMkj3PG3OJvL9oCQApw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658636;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KhP+0jO+lhnukY6rkjGjO9FYK5RxlDLbmF9OKFy+ep4=;
	b=NeLymPW/B+TiplqETk029Z6+IVgRH6hDRrftHef7fevpoXgsVaZ9gFTVaFmiAGjho3Mj
	 NufPcZkhVEt24xNa7C+qkpjFIiD4QMTonUqd508N+/P6ppy/XrdYs0Jr9Z0hhsSUusPEa
	 qPBIQbpZyNIr1jwCISl9TaaXzQee4keLWBdsY+/sozp2w6PbXyw0zSrOLrqy7W8OQDSUv
	 RxtdEObjhgixsjZNWcrQXvNXzQK51Z92xJohp/iSVOf/swXJUrjLkjulIJ+olSI14cVi1
	 krFuz5RCqVG7X3q98XhHQkt4AMAhHTbDbXaFROBQRtZixuNlJN/aNNZQzQjZSCyz4Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZ3jd3nf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE621606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZ3jd3nf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500E91F000C6;
	Thu, 26 Nov 2026 02:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658635;
	bh=KhP+0jO+lhnukY6rkjGjO9FYK5RxlDLbmF9OKFy+ep4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VZ3jd3nfImXQEWcgxYMk8tHvq7It0c4jc7ZGxb7k/lNSk8ihg78k3bKQlYHMN7U7z
	 gGQgY6BT4Tfwii7GcR8Wlgq5p+Di6wePoHhnJJ7xwNZJZAMGIVTmrnEmTrnFipLl7O
	 wR+uACkbm64XCsdKcTINShWTNqSOPr0W6k51I8lUck4t8q7V1cv2JeBuKLA2Q4QXj3
	 ItBpNGDiqaC9x2JmoHqCY3erXeHY4vNFhAIG1h2jLeWNowlTry0auKq8fV8C2c4eNH
	 HkQSlloLA0bVOa3nWTfKgMLAtW7bGMMjaFRD/k8cPkD2Frt176SkOMB0mV+7SeEdHV
	 vGoW5PFDPtBTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/6] ovl: port ovl_create_or_link() to new ovl_override_creator_creds cleanup guard
Date: Wed, 25 Nov 2026 21:03:49 -0500
Message-ID: <20261126020308.1696715-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126020308.1696715-1-sashal@kernel.org>
References: <2026112548-vowed-carded-1ef2@gregkh>
 <20261126020308.1696715-1-sashal@kernel.org>
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

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit e566bff963220ba0f740da42d46dd55c34ef745e ]

This clearly indicates the double-credential override and makes the code
a lot easier to grasp with one glance.

Link: https://patch.msgid.link/20251117-work-ovl-cred-guard-prepare-v2-5-bd1c97a36d7b@kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 86e2facd8630 ("ovl: bump the impure dir version when linking a file with origin")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/dir.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index c9871c111a84e..43a9866428b38 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -663,10 +663,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			      struct ovl_cattr *attr, bool origin)
 {
 	int err;
-	const struct cred *new_cred __free(put_cred) = NULL;
 	struct dentry *parent = dentry->d_parent;
 
-	scoped_class(override_creds_ovl, old_cred, dentry->d_sb) {
+	with_ovl_creds(dentry->d_sb) {
 		/*
 		 * When linking a file with copy up origin into a new parent, mark the
 		 * new parent dir "impure".
@@ -694,11 +693,11 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		if (attr->hardlink)
 			return ovl_create_handle_whiteouts(dentry, inode, attr);
 
-		new_cred = ovl_setup_cred_for_create(dentry, inode, attr->mode, old_cred);
-		if (IS_ERR(new_cred))
-			return PTR_ERR(new_cred);
-
-		return ovl_create_handle_whiteouts(dentry, inode, attr);
+		scoped_class(ovl_override_creator_creds, cred, dentry, inode, attr->mode) {
+			if (IS_ERR(cred))
+				return PTR_ERR(cred);
+			return ovl_create_handle_whiteouts(dentry, inode, attr);
+		}
 	}
 	return err;
 }
-- 
2.53.0

