Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359928;
	b=Noeh7Lqf8TBPaBQGpFpvpYTZ6eoUhGhL3l9aEfA1C0ILdwr3rM0sax8o1E1Hrd6dJdOX
	 PA372aE2XqFcsP2EhHSiA3K/zfb3HIkELTvJL1xQ8GME4qQuy+EtEKQoW1pGjx2gZlQ8G
	 ez7v4W6zR/ISQ7Y8eCJtGeH5w3wT5kRri3HXuAcW4L2zkPd6RHmtEXZdrbT4PBB8PVb5C
	 i8JDj7ZQ78L2jt1fRvmSNs/W2qJSu5nJPT5/UxlHteUHv+tKWTMl5Tdi+BGH5EFKeeDaF
	 CVNFhar5SEYgMFC3quGCJH1mWD/bHBjCi3uyJqNStOLAQk6NKV6MgVIv09/IUjv9+RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cnrRz73SYKEZ4qoaWJL9gqpOklZcWfVKHKWX7WhjJh4=;
	b=upaVx4B/zxI60q+R0NIvo3FHcghizPG7jmlemKumgJQ0izM3kVoxCmYV0TsuHuQeFsFR
	 NL9vtFHoHYlQyB5mt7frUdDQ4tuKQCDW1soDkcgEheTtpa0VwyyfX2nQuj4yf2+SvP4hX
	 DcGsb2eKOg8a18poPhMeqTXCwAWKQj+jjYAmqXG2iwVJRy5rXA29Q3hJbnXhWca9MxU8Y
	 I9JzAnWg9V5beFluJmq2T18W7mcXWNwAavIsOTUA3sVFJW2SZ8GkayDorqC4+BewbrCGI
	 ZyLCj3J6zaAqk+KIa5PJMp10QJeIsXYy/Ek4kupmJlG6w+cHkNk3I//YN1BhOavJ5UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="I/N8n4zJ";
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC3A606A327
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EC3A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I/N8n4zJ
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e09aa5264so284025f8f.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 04:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793359926; x=1793964726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cnrRz73SYKEZ4qoaWJL9gqpOklZcWfVKHKWX7WhjJh4=;
        b=I/N8n4zJ0pVbzD40Z94Q2ezmntxchgRlk4DXCua+1wNeZIVA04dhL8D5347VPjCzDC
         9/ken7Rvq+kD491Mg9zZOGL5RCh5Ry/G33EV52jr3ZdDcMP/Sm2UVhH79gqawm56GS9v
         jvECGs3fqgIWpUrSVNEJXWC1/oc9cfxGtd3FTvLYWJjinx1uF7dlzqUa4/2har6i+whg
         1M76PaPA6ywJVXV3SkU7XoD/fqZjsfkJwMpTIJ5J+5DEUVzAW3EN2Tox6hx4IwlQcNmU
         7pdfOGnFi2ceQJJ3E+EdR3qWd0SUivOykTNcpRsqqIwsUCn5vJCjX7f9CKQaVe7tdyqC
         wkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793359926; x=1793964726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cnrRz73SYKEZ4qoaWJL9gqpOklZcWfVKHKWX7WhjJh4=;
        b=Ap7smLNnub94AvtLLtmpPJEBXuUMHK3qSz1vBuQqlx/O4gsHkU7GCJ9ZeiZXx7yWW1
         utHrGnekrEJqgdOEB3B+dyc2f0gIyCwLQmodTJShSTOYM+YED+oVxvbjAPBtrIi+RwE9
         T6H9o5bXO6dob8MAnuerlN0NoYuJxthzdGAmh/+XppqK1YCCFtyi5uSBXjvkNtPeXlIO
         lApEy87o4yfsJXEeqqAjdguRDRFG48Y67KcLw9wJ2MSbJzkHGVvF77ixaX4KiePVs24z
         BwrfVG0YItljpB4mdrsY1AWKOyTIYcnokFf5NXTduwCnG/BHs9lXBfFHbiKwG1Saddir
         VTcQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwEjAcEiu45+RRzK03+UaXK7NsK+hrO0BNBiAfj4WMoOGIhomaGwTWLry36ORNo+n0UNTxrKg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWPdXvdlrwKEGrJp47spsAkeqpLB22lr+IyakUcid0dfO9nKvD
	CR+DvCIEVvGhfN/b3gvcnyKACtRhm3yhynEL9q4R7xuUVAkQn+a2nA/S
X-Gm-Gg: AYBFou2xc13eTZWdX34H1ELQHSsP8VcwtmfMssPphsVg7MalW1XYVoaTeYOsugcQ3p3
	afTAr3UA74WyA5sgtiDA5KWYZ5fyW59PPOMNW4gwvl+HwJINxR3K7yAikbMCxV1nzQQX/kv5B6i
	faEKUVs56uIF7WWkXiSgkqkA7vmKNMWQavVN/USE9bGoToVVz61x/JmAejy2MOApcO4dah/O43U
	CrQkbXhj0zDUDurVwcHBZPyumxwCIinaqqQlXWoPuWo3uTbwzd7sVKdmgnfPmoRhCJa4w+UxfHL
	G4xoWTMCl0I9cpzPUfr8KPuPu+mjX7zYZ481zW3Zi38un6Vl4NmDGPpbV6QrVZXI0hD1pGSsSZx
	+iyEFgjzYenoAVX3gXxXQAGRLB1q75HJuv7JbW6cBkUluYUMu8BIMVeEwQEcLIeeMCv06Cm1mLd
	J1SpeuA1AHR/Zb+QyTFctttvBHJ7ZqT1bd4hkiGAHvl4VSEFJFiaM1rWvLxI8NSC8CAZ5Ydm4Kt
	t5U1ADrMF1axJmNG2+zsdvu7rjMiODzSwZnAknXxJ2ultZ+Bsf86hdmVpKs5BiU2gQjwTq9unao
	hBeAjvFLz0sTPdwD70GWn+Ul/eii+5u59JoyoF3mW58a+OT+JJc03U1FvZTz5XZhqmEu/W/WEI8
	dlBlLrdZFU/g=
X-Received: by 2002:a5d:4c8e:0:b0:48e:1c2:55a1 with SMTP id ffacd0b85a97d-48e6e500505mr3857722f8f.52.1793359925697;
        Fri, 30 Oct 2026 04:32:05 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8c6e9sm2708834f8f.43.2026.10.30.04.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:32:05 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] ovl: fail the mount if the casefold flag has changed
Date: Fri, 30 Oct 2026 12:31:59 +0100
Message-ID: <20261030113201.2921633-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030113201.2921633-1-amir73il@gmail.com>
References: <20261030113201.2921633-1-amir73il@gmail.com>
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

An unprivileged user in a user namespace can repeatedly trigger a kernel
warning with their own overlay mounts. They do so by changing the
casefold flag of the topmost layer's empty root, the top directory of
that layer, after the layers are set and before the mount is created.

The casefold flag of a directory makes name lookups in that directory
case-insensitive. All layers of an overlay must agree on casefolding.

ovl_mount_dir_check() reads the casefold flag of a layer root when
fsconfig() sets that layer, and saves the result in ofs->casefold. The
mount is created later, by another fsconfig() call with
FSCONFIG_CMD_CREATE.

The casefold flag of an empty directory can be changed.

The casefold flag of the overlay root must match ofs->casefold.
ovl_get_root() copies the flag from the topmost layer root, as it is
when the mount is created. On a mismatch, ovl_get_root() only does a
WARN_ON(), and the mount continues. The check is not a WARN_ON_ONCE(),
so each such mount warns again.

An unprivileged user needs CONFIG_UNICODE, and a tmpfs mounted with the
casefold option in their namespace.

Reproduced by changing the casefold flag of the empty upper directory
after the layers were set and before FSCONFIG_CMD_CREATE, with tmpfs and
ext4 layers, and as uid 1000 in a user namespace.

Fix this by replacing the WARN_ON() with a check that fails the mount
with -EINVAL.

Fixes: f9377faaeae0 ("ovl: Add S_CASEFOLD as part of the inode flag to be copied")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/super.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index b452b8c5f6417..af13585709cfc 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1372,7 +1372,6 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	ovl_dentry_set_flag(OVL_E_CONNECTED, root);
 	ovl_set_upperdata(d_inode(root));
 	ovl_inode_init(d_inode(root), &oip, ino, fsid);
-	WARN_ON(!!IS_CASEFOLDED(d_inode(root)) != ofs->casefold);
 	ovl_dentry_init_flags(root, upperdentry, oe, DCACHE_OP_WEAK_REVALIDATE);
 	/* root keeps a reference of upperdentry */
 	dget(upperdentry);
@@ -1556,6 +1555,17 @@ static int ovl_fill_super_creds(struct fs_context *fc, struct super_block *sb)
 	if (!sb->s_root)
 		goto out_free_oe;
 
+	/*
+	 * The casefold flag of an empty layer root may have changed since the
+	 * mount options were parsed.  The root inode owns oe by now.
+	 */
+	if (!!IS_CASEFOLDED(d_inode(sb->s_root)) != ofs->casefold) {
+		pr_err("casefold flag of the root directory has changed\n");
+		dput(sb->s_root);
+		sb->s_root = NULL;
+		return -EINVAL;
+	}
+
 	return 0;
 
 out_free_oe:
-- 
2.55.0

