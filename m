Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938295;
	b=FidCscUJElsCraZFSdSUVxvM0ItWd4USEuLOTua5pEfN5YuoD+h8T9Qc2Vav95N04WIz
	 rs+Ferebpj+4t/l9xm2RfTD40ixNL9aD8MkAjyD7s3iXoINXMGtAE21uDd7us0UTdJcEh
	 w4U4QXgPj/2TLNBG9JaR6qKYCwXikv10fIgNuMLhEOknHSTlM7T+ogkcVZMPmKazUHkpz
	 xH7sbgK9nOeq9hCPkHXW+S5AEz0hi7KHIOxUROdN83WOFZVsdNXhuv+eSXe0OdfPv+/Bb
	 rbS8tMokQcoX5++iXOILDsxAzxVMr4g8N5OXFmCrUAT/qWfYu4eREKIrTzm8GY2bQxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hSfKSUTEhkehT1w6qMT0dqkDpoRv4wdMYRmkyLePlrQ=;
	b=xYenWl1Qh9g3PxxWvj0CG7nouuQzeBPjHuZ64SSPtWePfcG5cXZRLmhWHPyZGzW2c45o
	 S5iiwU3n3E3lTlP9fJnnt1KPxPYAP00xRR2n0dzh6r9bQ1oU7hA8SosxwdWTIrpgpguRu
	 4lBHU9JnEWfPaNb2kGiTmMxsEAB6ginK2SW2joU/cVB4wB+lmXl1zpM+2DRvPadw/d5bn
	 1ABrFR5uMBcEizUGArsDI7ROk5SLAhgOtqsxOJBVgNXil3d7/N9L4fW6pYzQaAiYBw5v/
	 SrZgQ3h0S1APdnkn46XzMwWNHSRFEIyKfLcHArTiCCaVH8rYZX0dyP4R2C1/O/7Xbcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y8MMJ9A+;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DB9606A328
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 04:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2DB9606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y8MMJ9A+
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso283150a12.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 20:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793938293; x=1794543093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hSfKSUTEhkehT1w6qMT0dqkDpoRv4wdMYRmkyLePlrQ=;
        b=Y8MMJ9A+mSZAq21XHxB/XgLVQCPFbdDn8x16YpklAzHAYcqbEju+AN9eamYtrL3d+Z
         9/1yYRBC3oz+qOk/VPVjZa0q62Zd2rk75ARXiDOsYmpTGyCDWuNM6RvC4ta7z17IuX7g
         4AgwVysEzgMJ9z+htEv30bB8H0XwAspMN298VTol8Vjh4O4Wf5393bSyu31lQhpEk8qx
         8LlnEUnbWvi/Tyz4A98A1vpRrEk9c/gotWVwoemfEYZaxspikg6oy4jHRgRIwxKf6WTT
         gdJCXQZaKnIqLDaapHa9m0OMAC+huzakn8Mj5ePpzFhYJ2XC/bBPktlAtbF7rJR4mRhL
         HJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793938293; x=1794543093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hSfKSUTEhkehT1w6qMT0dqkDpoRv4wdMYRmkyLePlrQ=;
        b=XZ36Qyt9TFRZCaaabF/cX6VwfSqE92398KKCe6d0wHHu0HhUXO66UGAFtMHSyzirTM
         S3CcV2GogcpA3k2s36O0MOGIRjPBwGTqczVr+bXnMnH39hmlrjw37aYzmZ6mzGauPSBA
         m9UbhjlXXvh9GMCz3YEAG92cGVS45OffCqanmLIYeiPoQQm7Afar1IQaoEWjemINfmFN
         goVoDcgP24HBqGBgumiHCvN01Cocfn20M5ByVr8F1RRq+S7GBFlcUi7P+nwkHnlJTWfD
         wd/o+1pHJ8r/tsOQhCqpqi59mxAZgu0kO3M84Epq52xVhdTJJul5cz4DdqcrW/sFaDNP
         N27w==
X-Forwarded-Encrypted: i=1; AKwUvByEhXnslYFFPjlz9JY5385Xj+4EzvYCCxue0zzzzz3jek1KosLzPiwlXejtIn0XecUwcgReoFM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8QZeHteEy7qiFl+Isy9E/npfYcmP5omMy7bboC/gj/CGE/PZWG
	rehJ1zweO6I7AAUMleF7nq7Cd4Pm2sAC+dpnMz26bfm9CPeU4mSxijsG
X-Gm-Gg: AYBFou27Ho3YWV47+TzoH+QxGzJ+Wb6CI6alrHMfNIC7bS7MxQ+yMWFKQ90cUJLwUzs
	QDXtk0AH/KcmQNxXnVXOhxE3yg+l+ZPyp7nYpJMVlGi3jzQzGjLTM4r3PiTssp8Wno2ypQK2F4R
	5Q/VAWCe2Qva8XY7iil+OecjL1P9D7k7lt+1GTlHMEUTYF5NUmbdSh54QigY/csDUBjuIfjNDmi
	DMmCDjYyPwf40bviJyFiB2PCiu+rl4bBat8vrjzGi68TyWUv9XoWYUgILTSXAxq5Wp2Ia8zt+oL
	LFTgMb9AsGYiwOLdnAKbCk/wu2eY8+TTDDXGJiI2H41I5kqw+thRvvJSk6qr/WjVtVOhsFKSEQY
	qcUO2F7BN6AKyc0Ux/s1Xs++d3VxpENfyB9D3m+Lp3kgeYL5aMgFPy2TMgK5HLYegqhm1hSPy3M
	pNszfxK0fSBCJlhvXNfdB23zyjaT+fpYQrREUDBLcmOJAEZAXmRUhRJC4BN4w5sAlIeT/HZTN9x
	Q/G5Uih4TWPGkYVEAEOWB638D1U2rXWwvljMfLGgh5OamodzTXhETIWMS4r3XgIs02RKGHwopIq
	NwvUw0m/cQcfiPa2CyLl5Ys8Uv0nwROkkGRssE4c7txG8r9ezLjgyRkzA9R2bEkeB8HBWMxWT79
	FFk3fgP/wwmKQ
X-Received: by 2002:a05:6402:2b93:b0:6b2:2331:3ea9 with SMTP id 4fb4d7f45d1cf-6b5977d09ccmr876675a12.17.1793938293380;
        Thu, 05 Nov 2026 20:11:33 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b669c4c08csm223808a12.37.2026.11.05.20.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:11:32 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 6.12 1/3] ovl: check that the parents of volatile/dirty are dirs
Date: Fri,  6 Nov 2026 05:11:23 +0100
Message-ID: <20261106041128.3797453-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106041128.3797453-1-amir73il@gmail.com>
References: <20261106041128.3797453-1-amir73il@gmail.com>
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
@@ -592,18 +592,25 @@
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
 
@@ -624,7 +631,7 @@
 	const char *const *name = volatile_path;
 
 	for (ctr = ARRAY_SIZE(volatile_path); ctr; ctr--, name++) {
-		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1 ? S_IFDIR : S_IFREG);
+		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1);
 		if (IS_ERR(d))
 			return PTR_ERR(d);
 	}
-- 
backport

