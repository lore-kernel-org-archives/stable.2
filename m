Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658634;
	b=pnTf3ifm4SqBYZDLLIH3P/qklmGZUsoNucVaVdbZHKeqF+KoE4+rMAAhBAlGPVnklqiX
	 2gWaFpzz3zQTIHPCeVWcByERCOYoVD6CpW9sHuiPeZnCcrphgIuQlznYNKWhQscnbAE4t
	 W/+xaESWFUFyblCBp8/ZhOQBs41jIndVSQw6j9CZaRMMK1mvYeK/xjbarUB0Y585a5V71
	 SF+7LTvawdT9eyZBdR0JzIlNcpgh+7/7b+tYdz3kVjbgbop0e8rHjfYl0VtiV7pviZPdE
	 Os0jWTUfLeRjxZ//5z4vFyw6LdqN9VvQG3YybzXrBd8LnG/kGIkDZcojiquCqNKvOkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658634;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DyEev/aWlQn2szVmKc4tJ+Kkvwl6qNqDpy9bLe4H3OE=;
	b=P+q6lKrjEe3wxovHbJPKmg+7lKj2yCb+mlBLBtzjSJ0Ggbu0d5eQfMivwoZWZkgiduZu
	 EnCvMeiBqguPn9PiSCRAAbrvWnxQDzNusCBb60+OdWP6n+UdwFzy3yPLMNn0Tpcvjgnst
	 3SAyP5zvGCDE5Gc6obd1m6bspJ1GWwhiiV1wnSuLs6KCWyIQ9Mjj0iY2QXLWW9SChM+Tr
	 X5NF9se/h8CI+IX7SJBL89cdsrIDwOhGup890FTdKjC4KUlxY356GUlKSXzxYXQUx08LL
	 TMQ+gXjEhs1G0/jU9UfK7lVnD9DT3tU4P4oR5176U7idku2Gwr5WbCHILZdsllZdwRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJDMOiZ5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CB1606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJDMOiZ5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2421F000C0;
	Thu, 26 Nov 2026 02:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658634;
	bh=DyEev/aWlQn2szVmKc4tJ+Kkvwl6qNqDpy9bLe4H3OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cJDMOiZ5rYJ7evEnZ5AheiHXvXJVXODTTDmSLwjpSEpWivDmEPY+3NWCqm5j/JR/A
	 ZFnPUGOnBsL7kk5hW9aeUDm9TiCqw8dVoWS/0Lc+8jQK9wK7n0hiqq3DqbfyWa5RNy
	 1NJNC7yQdofjwqXSmu824U+DFmo8lLKsQ8hcLv1GFvd/bWGPpXQ+HdX09OySxjaR0h
	 ckhINqGGWNmXEknDeLECRExadPqOnNalF6WJIf3VWa/wXAu7xCbn68JXErKh7SMDva
	 c4GtPZchJqoCzxyrLs3etSOqWZvIUAtITLWJ/JTbqUhiTdrDUSVCPy6IFVkgI98nwf
	 fn6RJG8ETd3TA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/6] ovl: add ovl_override_creator_creds cred guard
Date: Wed, 25 Nov 2026 21:03:47 -0500
Message-ID: <20261126020308.1696715-3-sashal@kernel.org>
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

[ Upstream commit f37b334728814b14745e15d46f9eab73750b67ec ]

The current code to override credentials for creation operations is
pretty difficult to understand. We effectively override the credentials
twice:

(1) override with the mounter's credentials
(2) copy the mounts credentials and override the fs{g,u}id with the inode {u,g}id

And then we elide the revert because it would be an idempotent revert.
That elision doesn't buy us anything anymore though because I've made it
all work without any reference counting anyway. All it does is mix the
two credential overrides together.

We can use a cleanup guard to clarify the creation codepaths and make
them easier to understand.

This just introduces the cleanup guard keeping the patch reviewable.
We'll convert the caller in follow-up patches and then drop the
duplicated code.

Link: https://patch.msgid.link/20251117-work-ovl-cred-guard-prepare-v2-1-bd1c97a36d7b@kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 86e2facd8630 ("ovl: bump the impure dir version when linking a file with origin")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/dir.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 935dc2187e6e2..058e18331dd47 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -580,6 +580,42 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	goto out_dput;
 }
 
+static const struct cred *ovl_override_creator_creds(struct dentry *dentry, struct inode *inode, umode_t mode)
+{
+	int err;
+
+	if (WARN_ON_ONCE(current->cred != ovl_creds(dentry->d_sb)))
+		return ERR_PTR(-EINVAL);
+
+	CLASS(prepare_creds, override_cred)();
+	if (!override_cred)
+		return ERR_PTR(-ENOMEM);
+
+	override_cred->fsuid = inode->i_uid;
+	override_cred->fsgid = inode->i_gid;
+
+	err = security_dentry_create_files_as(dentry, mode, &dentry->d_name,
+					      current->cred, override_cred);
+	if (err)
+		return ERR_PTR(err);
+
+	return override_creds(no_free_ptr(override_cred));
+}
+
+static void ovl_revert_creator_creds(const struct cred *old_cred)
+{
+	const struct cred *override_cred;
+
+	override_cred = revert_creds(old_cred);
+	put_cred(override_cred);
+}
+
+DEFINE_CLASS(ovl_override_creator_creds,
+	     const struct cred *,
+	     if (!IS_ERR_OR_NULL(_T)) ovl_revert_creator_creds(_T),
+	     ovl_override_creator_creds(dentry, inode, mode),
+	     struct dentry *dentry, struct inode *inode, umode_t mode)
+
 static const struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
 						    struct inode *inode,
 						    umode_t mode,
-- 
2.53.0

