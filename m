Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818298;
	b=PIcFXruFAkPlbYYgnKlH82J1/gqz2ROJwXHOSubs9/wLorC1d1h3HiXD2fplcGnjVl7M
	 NkSii/L/Buhmwj6I5rAS8eiwShJoipTehXSwjcoFlqqOGs66XumerphzCaGGYTjh3l8/w
	 eZmhtvKmb83t4V/AR1PGjTDn3h98ibKEWZcn3zynOvZ7VZ2XKCfG+v8LLYz8iGal2+hJe
	 bTdvCayUWjQYu2tlGXKP+z/pLM1zILibJtTBK6eM/a6M2tjBMc6ZjeWPODJwer9Z44ZiE
	 bCYanXCWXY4qkioc/29ywbVzsPW5ZYhtpUVfqmStLrykWLEavvp4VWm71/B1umv/h6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ixIf/O1rej4xwPAfsSS4PrVvK2W+4h7d7LIQubDg2yQ=;
	b=5tXotH008jZKY2u39/0wKFri+g2IzBm8LWWazBWdNMVn65HeiO1hMYn7eRUH7s3HRwDG
	 ady3Bk6qfJQG8bpARi+JSrRF2KuUvcyYLokG0r40j2+rtDoQjT0D+rFNC1G1LyLUMM5bI
	 dHRmDI59VuGkHPv2zIQvT436CL7m8NI7GE0K6bZpi4TV4pfRPGMu1d+s6SFe+dq63bPxF
	 iufSavmsuCKN9jMJQ1bLoMwRgdFLEPStvMLLrUN+8SCTV/kCuaanHpNMla3PzDxJVhpQb
	 jxp1HIOzo326R90Vg+wFKMVEZhrfvrnpaNpYovV5ZBa+jtrwB5iWvE0mrTbRcdmJFQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tb+Z0H5f;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F9606D801
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D6F9606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tb+Z0H5f
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e0d885929so862345f8f.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818296; x=1794423096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ixIf/O1rej4xwPAfsSS4PrVvK2W+4h7d7LIQubDg2yQ=;
        b=Tb+Z0H5f8Ujn95lpcrYX6Sd9IlolZJlKwRalnmZAREtJXke2ariHsWPEgRaS+cZuo3
         sW89k6nQgSNEh6VqH7HS1Gdr0P6V/MdS1A9/iIEjXB5yts4D7/MM8bdjyCjOdHV28k5i
         zIw4+2t3iD8gS88Z1sE4zKtiBnXaBdbNVbAS7zy2F5qq+pSEb9RlJdmk/8h2ZNYfcV4d
         JBdqN8ketxfyxbKUxxAFEt5Mmvkxbdi2z32JQv3POYjR2kjJJbw8qtlPO/LfoD8kc0OK
         FNjq3P1vPa7u+qdJQIAlRBtmX9997KWTXNCUNEFuB2m2UURwzWnQtHjYKfvdFINoRBjt
         lbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818296; x=1794423096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ixIf/O1rej4xwPAfsSS4PrVvK2W+4h7d7LIQubDg2yQ=;
        b=eXj5EfsNOZY1cuZJQp4wt2WdOssC01tynIYolYwM9qMgP2UpGC45WA8S+grCUVhFmY
         7+vr5G3B/pPXy9QWkZkpfMAPBSX4RM653oFzWkgJmIqWLhg4b9IiVdSor//9YSpwK2lq
         bsPs+I9RFOzJFVw5k/Yk8vP2eGVh5+jK7hqVjurZpx/RiZOBUTwS6Em2697XSV6a87Bd
         Ux6FiGgw/eme7GqE93V5VGjikhz0ZRgMa7I26fqg+5dpaTQbTcivsoSb/pvWcJQ4V5XP
         aFAp0XmxOyf3rHzCS/F9hNPAUiXAzE4X46S704w1/GifNuoNLV2zG4f37XYt0Xabn55+
         RLoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAtc5OOtSGUPhPY8+GPlJw73A4fRkadGOrhoyANXEaDUpVpM22uIDs1p0hC/kePMkl7QciWpQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8t4Pc66WhueUkh1HQzmWNLXmxCvFTD0iyBDOsVqwnt8PeBwJdJ
	Fcoq+DTBAKbI7Z7KxcBuGSro1xEEsdh3RcuhX1OtjrzVe9aw8mZvDdgD
X-Gm-Gg: AYBFou2K0GMdgE3qVJZJmI6anONYRaFr3I75d/ulBOxvwptDJW0nrKZEOgz4PFZ5rBX
	XSFVQHlBfHSu10JTZjPoq+jbhlqOG7zjH6Ti9jg7RobPlzQ/uiR0ujb2h1zd8MSpjG01uumV/Kn
	8flG11WSWAWN+LLuZtnfmiIspRjX2msmBhsS+DSdtoW4r4Rhw+QlZzN3bMfsVlXEtxST3RgXzGy
	BbslQYnBDQMZOsvUjUX5c5MdlMredCyoHgMhsKsoNhwXrO1FjrzRA6Xea67po7JxPUPUP2JMhgl
	iLf7FKShT3Xqoc+UdHBDAgbSz+pj9lwW0qkZ/zWTvCxqwJJq24OundpH6JirYcpyncf13KM2dfV
	u8NUUa+hzhQqIp3lrZh0wEt3NOEhl8X4pn2ap8NEdSZVfg3Rl5mmjvEm9h3NJKdwNNs++ywWYDf
	OeeIMNA9AmS0ihRNIuuQxOj4qa3HLC/HWY3mQZIoDNZVurLvsvy46z33z7z9s99IVc6Sr7iREnR
	nWBLOPH/6bx9u5yr+MJV/oHz17F9mQ7A9xP9iDGo1l9nQfZvVa8QLt7WrNC5zpUqbGzrU0mZNIB
	btFTJNdP0oy69l6YSic8wLKZs41L8dFuC3cR8JP3oqh8Qt4BhCPKAluoDClSZCmdWydQJ6Xkeqg
	x5/BXxTQVvI4=
X-Received: by 2002:a5d:6e88:0:b0:48d:ba3b:af36 with SMTP id ffacd0b85a97d-48e6e5016c5mr29006819f8f.37.1793818296326;
        Wed, 04 Nov 2026 10:51:36 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed551dc5sm5516390f8f.34.2026.11.04.10.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:51:35 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 6.12] ovl: set OVL_WHITEOUTS before publishing the upper dir
Date: Wed,  4 Nov 2026 19:51:32 +0100
Message-ID: <20261104185133.3630642-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104185133.3630642-1-amir73il@gmail.com>
References: <20261104185133.3630642-1-amir73il@gmail.com>
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

commit cbec8610ec5aaf35df50094ff639febc23f20773 upstream.

Listing a directory while it is copied up causes a use-after-free of
the readdir cache.

A merge directory must never be iterated as a real upper directory:
that mode frees the cache in OVL_I(inode)->cache without looking at
its refcount, while files opened in merged mode still use it.
ovl_copy_up_workdir() publishes the upper dentry before it sets
OVL_WHITEOUTS, and ovl_dir_open() samples both without a lock, so an
open between the two stores finds the upper directory and takes it
for a real one.

With a delay between the two stores, an unprivileged process that
listed a directory during its copy-up saw only "." and "..", and its
next getdents freed the readdir cache of another descriptor.

Fix this by setting OVL_WHITEOUTS before ovl_inode_update(), so that
ovl_dir_reset() agrees with ovl_dir_open(), and by testing
OVL_TYPE_MERGE() of the path type in ovl_dir_open(), so that an open
that observes the upper dentry never iterates a merge dir as a real
dir, regardless of the order in which it observes the flag.

Fixes: b79e05aaa166 ("ovl: no direct iteration for dir with origin xattr")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: test OVL_TYPE_MERGE() instead of smp_rmb() in ovl_dir_open()]
Link: https://lore.kernel.org/linux-unionfs/CAOQ4uxh-1J2OBjnDVbrrrjy1puSOW0kABvghN85ih6dtKUBTyA@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
[ backport: context: the store is followed by the unlock: label ]

 fs/overlayfs/copy_up.c | 2 +-
 fs/overlayfs/readdir.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -843,8 +843,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 
 	if (!c->metacopy)
 		ovl_set_upperdata(inode);
-	ovl_inode_update(inode, temp);
 	if (S_ISDIR(inode->i_mode))
 		ovl_set_flag(OVL_WHITEOUTS, inode);
+	ovl_inode_update(inode, temp);
 unlock:
 	unlock_rename(c->workdir, c->destdir);
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -961,7 +961,8 @@ static int ovl_dir_open(struct inode *inode, struct file *file)
 		return PTR_ERR(realfile);
 	}
 	od->realfile = realfile;
-	od->is_real = ovl_dir_is_real(inode);
+	od->is_real = !OVL_TYPE_MERGE(type) &&
+		      !ovl_test_flag(OVL_WHITEOUTS, inode);
 	od->is_upper = OVL_TYPE_UPPER(type);
 	file->private_data = od;
 
-- 
backport
