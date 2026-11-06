Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938292;
	b=x6awJgZj28ljb0tlwWSDTkYeDqJV5wFU1ynQSr/bqmumJtCY2QulBhcPKmIH05urKcF+
	 UzKOYpOr4kbFnedLA4fg/Ihnsx7PSJbxxN8BilW8Sl1ouyQ4E4KOcH/T8qcDkcleCQzjs
	 cYe4phGQT9c2vqyqGNGhZ9q8ZIJL8D/PuzuNZ+qMDSfE7FcebXOXki+fSQz0qU3yOxJxs
	 jayYp+FKDpo4CsERnHCvzsb65HIQL+bKihLd6uIuNTwGC6+BChhhAjsiokGlNlgvcnENT
	 gYKcz3sTfNep/i7OQEAwTRFqwVaFiGim8nc9gvuSBLURE8phHtYLU7ZuSWpvT2UJjxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z92dFtGsD7f/QDD5XfJXZq8nkBYV8QMmfDZuVo5drRg=;
	b=zInM0KbP21vNxUIIDevR76OZwWYCkDR0uxR7tbQ9FfcjXKQqJCuauhuXUq71PA/9DMm9
	 XdhrXWt/hJ9nh7ZLhQ0IAfqQClMIVL5ova2k5JSrRXFDHMpfywnpaqHicPUKnrsRBnct0
	 PVma1LcSr/scgqJlvQB50F1Fkg2m7H6hOXSOIP0DBHOzb5zPjqjr9mKpvnRkOcdJ646dd
	 JxTW4iaTWY4e7PRQP5F9SoIRvWcUht1sqenzRIRK4QD8qUmzN5Kikk8sBfevy0m4dV7BM
	 FBWfgLiNei51drAHLlPoBGKmFCTw7QZVmEqZ3HmqC2JcC59e6TFiTochQc/aUp8QEiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H2gKWQjv;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51A9606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 04:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A51A9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H2gKWQjv
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so299974a12.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 20:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793938290; x=1794543090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z92dFtGsD7f/QDD5XfJXZq8nkBYV8QMmfDZuVo5drRg=;
        b=H2gKWQjvKa0FHrPs7frV8FiyVDSOYWusKMVgtbEnOYuAIDxQZlFxdeWRvtfDUp+mHQ
         iVnIpElA/XQDTsllJFBiuA5Y8qc6Xv7pK8Px8T3vzmsavqY2VrQGfrAzGzpOL9ntsBaG
         wRcwzwKL7A38PqQ0zKwVUYPv0qnQNsfoFQi3whiKZ2It4Cm5S+ZakPMilzHHZUqqgCuM
         QC4gHGwADFYhVTJGZqS6t87321lCFnFJklGhh0vfxHs5H6LJrlN/mQekMwzpIrrSWKBN
         WKvucCASwiyhKTqAvQnpdr3UeQ3TUsMd/C8nbHSjUTG6T+P689SnmZTK8nglqa71DdVQ
         xvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793938290; x=1794543090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z92dFtGsD7f/QDD5XfJXZq8nkBYV8QMmfDZuVo5drRg=;
        b=KX730P0KHNnjsHkyzSP1halwlloFIFCMliFPA08dYSPMmw5NQWc0szSL9HuBYqZoaM
         hD4eg4yU0KK5QyhBS+l3+ymNo3b654WOcSSEOP7EthVIZn/9oNQi+JDhprFuRYSW6kQh
         W2l+oKbnRbUaD9TO8QYbkTPVzFUwtfGHGuCdwtlSWFIPvgpr86gogymlZxFUGSZucUna
         Y/929T7EDIERYCldoqjXhWefD404KrbtROVZwC7XmG6vghlVLDJEHXXqbgIJkNrKC6hK
         x/rDEXwaMVmE+cSmah1L2Hi/IYGAtQ/HhCF+WibikBSVtUGrftw8XtQc/jmgCn/7IOkn
         qGew==
X-Forwarded-Encrypted: i=1; AKwUvByrvXSe4nQPBq7J3NtXjJ2NaJd1a4R1g81rDEhMbIjPRxMV3R+q1tKJx7OSJmrKea/WuPHnRsk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fQiciQVcRMLaow1rXgLqT2ofKJXDgQhs/huNA3WYO4bI22gmS
	o75kMKUi+bqdwfrgFq3Wz+XNFRrDWeIWWiP1FJkWCJnA2cHPfJ87JgRd
X-Gm-Gg: AYBFou030SWZav8sw3fTzGY4LEr8bvzVuITZiOeeFtkmbdUUthK40z5mJmWRGT2giEj
	9eh9QqH/VYYFxZI38fEfPNuFRm/7lXJayYHgaEKRh32D3abRjrDLBIOBM3+1pJgrGinDjLz7ADD
	US8VtjcMy6IG+6ETPfuhb2yZODMQBo65iLTZRCv+UPquTBjZdB6891Y/BfngAMTiS2vb6zDMbP8
	6I35KnpJNS9zJqEFRMsldeaXoPwP8zr8fOrOg3SsXUiYr/IpA84TgHUURvBV7LAp38PpGOLUqLW
	RGb7ZG2bAi6xcpZsTmIEVcSG+vg9VsaybjHPc7JzQQJ6VFPmEaeT1iMzV9+y8WtdIxmFZxIEHqt
	8qD0ZObtGwKPpKxdveqqwsTdsOemZo7SGCkQJ0vg/pmqFJLwYVOIIGHttIYc1CtAUaVm0E4GvZu
	4G6aT12jeXbILp4Yn45I1spnIwtP2erMub6lRLc8dGMbfIgzfR6VSPKSapUFVFHzxJxrupMfj9b
	QjvJyrvMM8SSUxxRXBJrR+H428RlZ9NNjGm0NGI8cVurHGPvwEt8tM+hsDTySATb0CAqmLOINOC
	2h3rsXtBNsP5Wrh2ZVmCDMLJClgBFTkqZHxNhtKP2dwmMehTfoWqwS+kMlM3rL4Zk8ge9nVaFHH
	o/tMlPS+L1Sw7
X-Received: by 2002:a05:6402:3808:b0:6b4:5d8c:95e2 with SMTP id 4fb4d7f45d1cf-6b597553644mr863309a12.4.1793938289842;
        Thu, 05 Nov 2026 20:11:29 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664ae54edsm251088a12.15.2026.11.05.20.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:11:29 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 6.1 1/3] ovl: check that the parents of volatile/dirty are dirs
Date: Fri,  6 Nov 2026 05:11:20 +0100
Message-ID: <20261106041128.3797453-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Chris Mason <mason@kernel.org>

commit e34d2ef818e4c7676d8d8e1bf43e6a1ed39efb2a upstream.

An unprivileged user crashes the kernel by mounting overlayfs with the
volatile option.

A dentry that serves as the parent of a lookup must be a directory.
ovl_create_volatile_dirty() walks work/incompat/volatile/dirty by name,
and ovl_lookup_or_create() returns an existing entry whatever its type.
A file or a symlink that another task creates during the mount becomes
the parent of the next lookup, which calls a NULL ->lookup.

An unprivileged user mounted overlayfs with "volatile" in a user
namespace while a second process created a symlink named work/incompat,
and the mount task oopsed on a NULL ->lookup call.

Fix this by returning -ENOTDIR from ovl_lookup_or_create() when the
caller asked for a directory and the existing entry is a non-dir.

Fixes: c86243b090bc ("ovl: provide a mount option "volatile"")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[backport: no ovl_start_creating_upper(), check the child of
 ovl_lookup_upper() in ovl_lookup_or_create() instead]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/super.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1331,18 +1331,25 @@
 	return err;
 }
 
 static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
 					   struct dentry *parent,
-					   const char *name, umode_t mode)
+					   const char *name, bool is_dir)
 {
 	size_t len = strlen(name);
 	struct dentry *child;
 
 	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
 	child = ovl_lookup_upper(ofs, name, parent, len);
-	if (!IS_ERR(child) && !child->d_inode)
-		child = ovl_create_real(ofs, parent->d_inode, child,
-					OVL_CATTR(mode));
+	if (!IS_ERR(child)) {
+		if (!child->d_inode) {
+			child = ovl_create_real(ofs, parent->d_inode, child,
+						OVL_CATTR(is_dir ? S_IFDIR :
+								   S_IFREG));
+		} else if (is_dir && !d_can_lookup(child)) {
+			dput(child);
+			child = ERR_PTR(-ENOTDIR);
+		}
+	}
 	inode_unlock(parent->d_inode);
 	dput(parent);
 
@@ -1363,7 +1370,7 @@
 	const char *const *name = volatile_path;
 
 	for (ctr = ARRAY_SIZE(volatile_path); ctr; ctr--, name++) {
-		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1 ? S_IFDIR : S_IFREG);
+		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1);
 		if (IS_ERR(d))
 			return PTR_ERR(d);
 	}
-- 
backport

