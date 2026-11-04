Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818541;
	b=x6WFzdc7RAHR9WA/1BC/rXZLGLMCyF/hiAWAcOtL3RgfYPw+rCHgWUDjArgtBCGqMQDw
	 3Rku7hf752ImAPlhNLgc14ZgCUEyqpR6UKUzmmBvGaHYycx2hDgshurBfg+Y5Oetbl2QQ
	 g8WOjX1FLA9eK/qy1mgw/NGq9ep4MI/zspsC0ahD9sMeWQtmcGiGzDfJdcizOim0/WLIC
	 uPqfWVJwEcp5VnSU/scLFHwjpBLQtajim3FnBZQt9j9oqlftvXUIqGi8rbC6salPM+pDw
	 QQ33jxCqYZbNqMT4Uc1lsXBB4zjwW80efTJKTrHqBcLj1A7W7gVy1G+u3YjhipFtZBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Uw+ltulG0emNHhLXpUx5MHUqNAFvHB2/zMCw3FPX7pg=;
	b=UulT1seqGR/W56gQD+dXB4BtV6JSLoqPnstBqSNbE9k42L49epIRiCGMkOh4yj4ON/Wn
	 KRbU7x7afntx6hlr3Uz2Z+MpvghbllRFkjUPyEvit19ki3hInFghPVUMGWOp7UDqKhfT8
	 RQnV/lUhZxkIYvKL4EmMRARIQl+vA1ybJ8oQygLrZBGhmZQorBkOk2ylWnyqr0ITuPE1e
	 u1CMTshV2ZMFrgZom7gthjyp/2KGyGt1ddSDIh8BfQ09nwNe7hOUWe2wGNfc7uk21JYZh
	 TBgOdy/8o1nFqAHxif+1bLwME3aBX2bZmpX/DfpSMOWo72dSv4X8AsPAyTW6e4lIKGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LjOSIXSZ;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49126606A337
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49126606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LjOSIXSZ
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so8372315e9.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818540; x=1794423340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uw+ltulG0emNHhLXpUx5MHUqNAFvHB2/zMCw3FPX7pg=;
        b=LjOSIXSZvi1Co/ojQnJJS0/HHNEXdZQaaHqfkwIX5m5qvdHzjryvAMJhtcO37LEafD
         O37KMPZQVO5L2VTsjvxdvDs/sS5SKBM5Hsp3BoE3YKfsZsg58bLh5wI5HZJX79pv0DRT
         QZaMjSVY0L3CgHO3E4xCU5MFH9CFZ0/I0FQRIPzX/a+xXhGuBqihSFcC1KyKdFyjJKbl
         0i3E19JQFlh3td6BrF+68qgnQZ1WdTSWVadjoyMN5e14Hf1KhJRsAFe7zZ5oex4c+61l
         IxuEpUreEuX3yrgR7uKVEbWwH10QNFMppqVpD/fvdqKdLOfTYMfXWIAUDSPK00ODjwPo
         2iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818540; x=1794423340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uw+ltulG0emNHhLXpUx5MHUqNAFvHB2/zMCw3FPX7pg=;
        b=zk/+9HKzsPPSLcuob0rc4scjSzc52GylTy8pT6qj21cZLUeN63xwjvdvQDKQ2YCdxm
         UvjO+gxXvJQefCPgtUgONqUE+IdSYyPuPsXQOHJXB1RBMLRGcHDhx9P1ovvXtd95u4YM
         E27l+ykCBQMS5ZO5LWPcTjA55TNgeCtk0KrOPAXek2SzcONPnDqio6pL6aLJAXiaZXWL
         UWbfIGksjqe4BLnbQR1ZSLl8K2MmvnSCXAhWvIL0ozLroHK03B/w2jyBeyi8pxsnmi+G
         h6hi7TpmKIXtzlpsqKdtb8E7uwG89GOkNVKAW8szYfUIsl9FkqZiB03YkZi95gCFaGTc
         1qoA==
X-Forwarded-Encrypted: i=1; AKwUvBzSV9PMO2XTROnVZB6Y2M8Q/5P7x7Pl8fLnI2rDJTBpTdLZNcG26Zpo50Q+g+7HfVhzmbSVFEU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CD5QeyNVN92py2iGrL9XyE7Pdqgx+dzqslaj3agvZDvFRjIcK
	uPhEef1bnz7O2ZnmJ65lwHFMnQqpo7dsjrIRzoxC5VtpEp+f7YwSc6PX
X-Gm-Gg: AYBFou2kCLQyOQrIAsjpoTvGxSIUxkz/6EBkW07QBRGcwNjjUFfIV6lXGQF18aJrsVj
	6FMuOa+AXzIhdK3oskFzL1dSWzViVswLVjcknl+ZG3SK9LgM7OtL0swzMnWGcUshhzUyZh9OvV2
	grCOwAiD5nlRj0czrl4qDYElgAonOihp2BmwaCF8/4a4JBHMQGn+mvmagLNW7WP8OgvKpJPDNqH
	9j4aN/VWUfLLOtWKlJ6NK2lVnEnXd2QZ8X3I9El1gxllkB6qLsCO4jzZjYNmxhZjPq3LfPO69cD
	28iw8/YbUUHAJiDjq1ALdlIlDS/xLd72xCOrkI1hCKOsT6D+VqRpK7V0PpfS5rKeX4hhTJqS/8+
	WMHCw4/VamLy2mC2ii5+K2H8i0ZYdkOf3ddrUjvOuxsSzfCYEg9qdlfYuKODeJw6PVkHBy1089d
	QQAM6vWrLgIfn3A1vF1AI8FBlwZiiuXwll+FsQnjgbQYWXFmc0gIwnvCwpbtUlh2KqkQwSeMPwA
	aKNVuGsZCqXto0dpxywWfPC29eLMQPwYc3mZzewiiUlFR4eRhUI7cbOENgA4krEjg/IP2APWHis
	mb6ASN5AwRqIOob6NHR7G4v7Mv/nqKWWYyu4lsrRSQVkIS1ZYJv954uVgPdM583BP9Laq8tRDz5
	c+n608R6RJn8=
X-Received: by 2002:a05:600c:4fd4:b0:4a1:e250:b191 with SMTP id 5b1f17b1804b1-4ac180f2ff3mr377755925e9.17.1793818539533;
        Wed, 04 Nov 2026 10:55:39 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea180ee1sm6294308f8f.4.2026.11.04.10.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:55:39 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>
Subject: [PATCH 6.1 3/3] ovl: set the revalidate flags after d_instantiate()
Date: Wed,  4 Nov 2026 19:55:36 +0100
Message-ID: <20261104185536.3631167-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104185536.3631167-1-amir73il@gmail.com>
References: <20261104185536.3631167-1-amir73il@gmail.com>
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

commit 75e89c0055c1d7f7eeb462995f11253ca5864f79 upstream.

stat() of a file on an overlayfs mount triggers a kernel warning and
fails with ECHILD if another task is creating that file at the same
time. This happens on an overlay with a FUSE upper layer, which is the
layer where overlayfs creates new files. Write access to a directory on
such an overlay is all a user needs to run the two tasks.

The revalidate flags are DCACHE_OP_REVALIDATE and
DCACHE_OP_WEAK_REVALIDATE. They tell path walk to call ->d_revalidate()
or ->d_weak_revalidate() on a dentry, so that the filesystem can check
that the cached dentry is still valid. An overlay dentry only has one of
these flags if a dentry in one of its layers has it. FUSE dentries have
the first one.

When a flag is set on an overlay dentry, path walk calls
ovl_dentry_revalidate_common(). That function only expects a dentry
without an inode in RCU walk, while the dentry is being destroyed. For
such a dentry outside of RCU walk, it hits a WARN_ON() and
returns -ECHILD. So a negative overlay dentry must never have the flags
set.

ovl_instantiate() breaks this rule. When a task creates a file, the
overlay dentry for the new name is hashed but still negative.
ovl_instantiate() then works in this order:

- It copies the flags from the new upper dentry to the overlay dentry.
- It calls ovl_get_inode(), which can sleep in a getxattr request to the
  FUSE server.
- Only then does it call d_instantiate().

A second task that looks up the name between the first step and the last
finds a negative dentry with the flags set and revalidates it.

Reproduced with a FUSE server that delays its getxattr reply: stat() of
a name that was being created hit the WARN_ON() and failed with ECHILD.

Fix this by setting the flags after d_instantiate().

Fixes: bccece1ead36 ("ovl: allow remote upper")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[backport: no tmpfile case and a 2-arg ovl_dentry_init_reval(); no WARN_ON,
 but a negative dentry still fails with -ECHILD]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/dir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -269,7 +269,6 @@ static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
 
 	ovl_dir_modified(dentry->d_parent, false);
 	ovl_dentry_set_upper_alias(dentry);
-	ovl_dentry_init_reval(dentry, newdentry);
 
 	if (!hardlink) {
 		/*
@@ -296,6 +295,12 @@ static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
 	}
 
 	d_instantiate(dentry, inode);
+	/*
+	 * The dentry is hashed and a path walk can find it at any time.  Set
+	 * the revalidate flags only now, because ovl_dentry_revalidate_common()
+	 * does not expect them on a negative dentry.
+	 */
+	ovl_dentry_init_reval(dentry, ovl_dentry_upper(dentry));
 	if (inode != oip.newinode) {
 		pr_warn_ratelimited("newly created inode found in cache (%pd2)\n",
 				    dentry);
-- 
backport
