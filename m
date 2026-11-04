Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817923;
	b=w5Tm+DdKLbTpsb0bU2gqsmO+3eOWjHPMkgXUyw44CFA7Mi0wthzXEvG6OhSL/oxa8f4d
	 9mYJqlEN++GJKcTZXd1yYp8WLbr4bddJesr5LWD6gnnWnqj01hHfMUGvmKhmGvtl4Bihm
	 cjLe8M+aFP/U3FSH9ijHc/aOomp8vGKfhW87txCS8g0r/sfpwxWXi7NP4bpACiTs8X7yl
	 Aet5qlVr4o295KViqvT1UGrDbFzP/qYKbY88AFqZFkstuRsM5HFM5At5gvEh9Y0p2Tm+w
	 5X+V6r6eNhearzcJiD5lNefgQeUYFGSvPpPHYoaR4YmoAC0BU4UlTy3M5UxxaDkjsFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7yYOLqYN6DkdjgfCk6HvsFoCg1+tvjoIOvaqudKYChY=;
	b=rpaWXvzJIyycuG92OGYqblJn0eXWSFElujhnNSli7ngUKjt8GBsowS1g5uT245jhvCRu
	 n3ga2AYyuYCmUE9HfrCKbuH5KikLEbxTKPSCEFGOmVLgau38lXfgo3zP4qWpmNOv99FhZ
	 0GPGYeFdeUPC9SDO4hso/ECMhUmrZtg4x2/COARgjKE63gugaEfIL2qiGJgreaI19z2NZ
	 iJ6BGMhw0RDTdS28T2y05zDEJKZlFHiUmJFafvtk0E0I3/RDWEIQvzEeiuY5JW5iB4CeG
	 oX8HxoyQ5lPihrFqL0Xmw/ztYNxhMxgX0KAy8uIv/9pBZaxx9rB0VdJpoD0yVI3CjpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VE2aSb3W;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE71B606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE71B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VE2aSb3W
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so9971715e9.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817921; x=1794422721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7yYOLqYN6DkdjgfCk6HvsFoCg1+tvjoIOvaqudKYChY=;
        b=VE2aSb3Ws1kRKaJMzMPJLgGS906H4ucRvf4ajxmcusUuZsY7eupgwLOdwmxjAq78uL
         WFPRY/65Vdkp2iKhkwg76Ddtu+qlnm0LGVamsO2yrLGlSXO8ruoVY+tYj+eFeJmgMNVR
         sWTcoOXYX3m1CXAtMki928x0Eu9KY6e1ZHgQ7bJ/XQfcImPawkDrIITIji9GLQoLRpY7
         QUKLEUhI+L9ziFJgHrFsZnkzIZq7tqvBJQ62aNojNHHl+G9KXLUEq7L+1tfdSUzmWGTz
         j6zNHoOUA70gZZfp4tDK+62cw0yWiAtkmxHHw7Yhr80AsAO570fh7yOxeguWdOGce2AS
         3YoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817921; x=1794422721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7yYOLqYN6DkdjgfCk6HvsFoCg1+tvjoIOvaqudKYChY=;
        b=w/PiaQ7od4YC6+wecvJo5F24sOD1pFfSAhO+GoX/ad8nw1fEd7ig1KTD4LK/CrtLFr
         ze2Ckqdi00M0gV5mp2empg+yWOgnQEWcTWLN2VSCvSfO64sOybrtCfBpIhBYlqouJz6U
         1QrsdNmjU3ApbhiaQ06c6nK5Y+oGmyQpybJi7IjZD/MovPeiXKhrpI2yLruzZsFBQiYo
         hS4OJnnWebyZDrfywr3ZqRl7HnSWpHOvq4RbgwkMThYQaQHrxqZqK171Or2mCmJc0U02
         r1p4VDgVBMQDdQLzO/ZVYtAH/gkfSxCf6qZMxfLSKnGz8TfDL2yB6jBEFu2EnmY4bFaN
         Tqcw==
X-Forwarded-Encrypted: i=1; AKwUvBwmpRNKdbulDBgLJSzYDKKHrqoVBpIiAU4LuTciAHRqoYfxzDCf11fjYTEcXnqKJVQuqyxT44o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BTdGxXnNrDhTr1TvO7pznXi1IITsWqINi3KU6HJ2gii8J53Cm
	YWLQOyW/amJecGbL5O7lQm7pH3WUL//wMovrM+h5NBZPzC4yYQkzKU1w
X-Gm-Gg: AYBFou2dvhThg/3avCWCH4QmKqstRWQ5JsHjfa+bIacdSOZ2DAyEPHDSFxWhGeHIWER
	ZfejpXG+uQrFaKHBDQJy32HsmsFIbvDNp6vWcTfrchvLd1Kk+UdBR53g/RZxJfMc4SR0W2w/0TA
	MZ+CpSdnCG7ZPlUszOjqaRj82Tldr6D2lbcW3YeqzHu4qCLyTQBlR9zTZurs4wvehoowm/dhWFs
	2KwKfczGI7bUSLFjPNtuGUsnm2tpIZzW6SFQltWKWMoz0B/112hpknwACeZObzqdoMSCPcrarmD
	kjaow7XA+opxvgs9CRIDpJyhgyWwvSs2HoXFedcyPIbboRE6pcbEe56BZUZxgR4J0WhCpAUv+xo
	kLNoj3CZT6HeMEdfhzi6dzQlD3nHaoP9vtn3p0v8Y+hWiTnEij7kVm5qVh5OrkNllgrJb+zVuv8
	C6MvoQV3ikKefynRyiklsmaWB3X0nmLJEFSU+UiltYKS660SlnaDPNZv4FMVmKXIdqep8Zdm28T
	/PS3H+DixzFvKY+QayojOc6GBtm8NjmnMxXEMVpIG+0lK0kQcalYtqgd1EDcZwqzKCy3+o8U7mC
	+UZBpp50vT3bnMM3Nx+EVIspbbSML6gwE7T+zoHu+uyYpA1mA4ccsuBWRYRSxjJkaJQbQpoMypd
	Us7xDtLO9W1U=
X-Received: by 2002:a05:600c:46c8:b0:4a2:1a:a120 with SMTP id 5b1f17b1804b1-4ac16acfde1mr398229935e9.6.1793817920931;
        Wed, 04 Nov 2026 10:45:20 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e2ae762sm3927915e9.2.2026.11.04.10.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:45:20 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 6.18 1/3] ovl: check that the parents of volatile/dirty are dirs
Date: Wed,  4 Nov 2026 19:45:14 +0100
Message-ID: <20261104184517.3630089-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104184517.3630089-1-amir73il@gmail.com>
References: <20261104184517.3630089-1-amir73il@gmail.com>
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
 fs/overlayfs/super.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -636,17 +636,25 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
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
-		child = ovl_create_real(ofs, parent, child, OVL_CATTR(mode));
+	if (!IS_ERR(child)) {
+		if (!child->d_inode) {
+			child = ovl_create_real(ofs, parent, child,
+						OVL_CATTR(is_dir ? S_IFDIR :
+								   S_IFREG));
+		} else if (is_dir && !d_can_lookup(child)) {
+			dput(child);
+			child = ERR_PTR(-ENOTDIR);
+		}
+	}
 	inode_unlock(parent->d_inode);
 	dput(parent);
 
@@ -667,7 +675,7 @@ static int ovl_create_volatile_dirty(struct ovl_fs *ofs)
 	const char *const *name = volatile_path;
 
 	for (ctr = ARRAY_SIZE(volatile_path); ctr; ctr--, name++) {
-		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1 ? S_IFDIR : S_IFREG);
+		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1);
 		if (IS_ERR(d))
 			return PTR_ERR(d);
 	}
-- 
backport

