Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818540;
	b=BK5vAvjKzA9Rj0PGKKLKTX6tMD8T6elu/YOTEovtPc/AXZe/qYpbdFsJzXAV1Tg6SmML
	 o65aLJ8etUsPbhv9Dsjtfm5BCqK3jG5KDjSL7mfi2Bcd/RvyJw4lNf5Dm4qqsts5xusGA
	 uzPTw9ZKPFutD1urnoV/luBLXXCkZOXhhBgGhADYgn45usWr3ux4yycrSZDCu0OuoXijQ
	 5H316c1EeubR8YKORHDNWOvnqhjM1LRsMB3T/J6RQrDipXUQ1pYZuLvB38SBMYY3H6y6Y
	 VQjx04OXzpX+v6JJYD3lVe4RhEz31q1lXFiKeO3XtolZW56z80KzMtZSwxumEdDW6gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lJ9oFY2f4SSxHAugcTyJowGx3KfjwtaAECBMXqE4R2o=;
	b=Y5xKyHoyqlMLrLutQBDjICS0bb/abC5golLCE633PgdMa+5pzz5fDQUUGxexY2fMbclB
	 1a5V2TVGFZ0q9u5Xud+s8IoU4YSik0QGTFsazqAFKUM6d7jJTXnDfhTt9UBUdlu+UEFyC
	 AEcSsuFGRnetOug6giwmLKL1F1fkzZkrzz8WRw/q2Un8fr6LNWLE6/J6yb8e7Pt3BDrET
	 My1Oz04GO54xAvgg7QuM9atKsChhjspBgw/3Y31AZDhu9VwsVoLk5qQG8Iz7UStjYdAZQ
	 MHAeHc8HLKkHrVum4B1IukLiQqik04c/dvaHR27bKt1vyhs8Z+denQr32h9+UEfKCkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m8BXgpez;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A089A606A32F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A089A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m8BXgpez
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a215e64962so10256545e9.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818538; x=1794423338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lJ9oFY2f4SSxHAugcTyJowGx3KfjwtaAECBMXqE4R2o=;
        b=m8BXgpezTv3Wd1N0PQZlR95qtaN6nSFi4sYXFhljOYLto4MiT5wuHpPnUHdxtUYYp2
         n9Ob1kQsyslCDkr1MonzSRLtMVd3SuaTGdBe9lK/AAz5czYcI0Vl/OAbmBK8kx/To8ZN
         j0hrpFSMeY/u4azd5DkFs7U35AXXwM1bSsI1CWKrowIaezSc0E+RmEpw4F5WlM4YEEkG
         SpWxbLGZvee8KrcH/ZRyM7qPIIIJpshy5H2+boSxIJeV2dyju20tvlUz+MWCS59fxkNE
         UgbXfS4FUAHS8C+NtrS/iLvC/yH3CRyiqnrvt9dEa0xpyL0pg+D/zL/cqwAn4dzB4F9l
         LrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818538; x=1794423338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lJ9oFY2f4SSxHAugcTyJowGx3KfjwtaAECBMXqE4R2o=;
        b=Qctcp63kk8LlTw3OBGkcaK+xG1LP6Ttv06zOuKaTgh+O9/QxRWTaHDBUNk639aHZLo
         vgrA7sb13L0z3vPnKeRmC0XFqSswbH028PtyDaU/4B2KREZjxHwod7DGd8yA79uFYxqt
         BmVu3htEh/CDIIGo7Pr1PFjhqoD+v8T60zH3Eou0hCoqVnnPoNI3oGxvQDI7lAyGgDap
         yH9fApWF0pPmFJF9SLfOVKVq/ST5ZYK6rqV5erCyu9r5xYNUr4mQQuIAPYxlijPN9P6X
         UpipZARrbVjKIFeCnHLZV0TQzlpVAJf6kyzwM2swIAv49uOT3nsvkMdVqoNl6Qq49xJw
         HKvg==
X-Forwarded-Encrypted: i=1; AKwUvBzjXz7dl14GdmBAzi7YNRGcpoFjmr9AJ52POw48qr6Ht3KqSk1pkAzLGJ2RpQJZ3uKfUOWsIp0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NsueCiMJ3iIsMLckAOu4y5ODJ90dw9ssKf0RLz7VSDGGjGE51
	XzQUwQSj9s3OJgtE9iBVS2SI0n2jeonUKtzSdT5SOiDT5YR4TtEynsmKZdBoiScr
X-Gm-Gg: AYBFou1RPKoKn84xMTvHWgzuFYi6pBEB2cGcqPISTKRb9PbS39XLJzF2vx3ZcY25ZNI
	bRCLu2w1aAw5yJWJAi90fZMY9SDhT9Xd1N3/nnFJ49CZxoX7mkPJhoYC8ko2VweKJCOmTNgw0f5
	SRhuiIpv03CQqvfCmQoW6ZCB5QWVWfFrBGorpW2FfQbeelM/a02l+dYwiOcvZdGJ1bOYRgl3r67
	e/BpN33m3hTkRDG6q6kPoZ4/TZI9Qz7lyUbH7WkdXe3C6FYd8nbaJupgvjKFMwh6MsLGLNPaFKH
	QM4W6Lg7MCTO/tqph8jHSFhDWvnyCk/aFWu/sELDBYB6UIXtwD53dLx7ZzJWfHMdqayif0llrxI
	g1miA9hRmOnwQAFR3jbwF9cCIPOnNDGFhffQCCZ950hj8lR4iQeOe271M3xuqo1CVQ1rpe3vwFm
	EUZtfhu08v2YMKr7gF1oMol1mHZx71GBRmNkF9YOTcs4TSFCxzzwUNwBeCnY3XHMH0J596GTjx2
	R+nCikXJHyCOXo3TK60V315PNQpbA0qaszJ3ttLppWmf0tIuXKOMqiT8WZAtS9dLRqQCTqs1zFD
	KLsoxD+2IP61dEN0Swukz7L23T3bdQnUtVS2OCxGVIxg5F0qQTaZX0CRLziW5NMuk5hsmRGfd3V
	lBoHLBivNapzm
X-Received: by 2002:a05:600c:8b5c:b0:4a1:fe55:88ef with SMTP id 5b1f17b1804b1-4ac1889c4b9mr405197805e9.20.1793818537981;
        Wed, 04 Nov 2026 10:55:37 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b57317cb8esm3831625e9.13.2026.11.04.10.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:55:37 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 6.1 2/3] ovl: skip copy up of empty security.capability
Date: Wed,  4 Nov 2026 19:55:35 +0100
Message-ID: <20261104185536.3631167-1-amir73il@gmail.com>
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

commit 50912a1715b8a7c614b654011a0db750e372b43e upstream.

ovl_copy_xattr() gives up if it can't read an attribute that
listxattr() has named.  An empty security.capability, which anybody has
been able to store on any file for a long time, is such a case: it is
listed, and getxattr() has nothing to return for it.  A file in a lower
layer that carries one can't be copied up: it can't be written to,
renamed or have its mode changed.

There is nothing to copy if there are no data.  Go on with the next
one.

Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: treat -EINVAL as no capability too, and do the same in
 ovl_copy_up_meta_inode_data()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
[ backport: context: no blank line before the ovl_getxattr_value() call;
  depends on e6b9117076fb ("ovl: fortify ovl_copy_xattr() against
  underlying layer modifications") ]

 fs/overlayfs/copy_up.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -47,6 +47,15 @@ static bool ovl_must_copy_xattr(const char *name)
 static ssize_t ovl_getxattr_value(const struct path *path, char *name,
 				  char **value, ssize_t *value_size);
 
+/*
+ * Any user can store an empty security.capability, which fails to read with
+ * -EINVAL.  It grants no capability, so treat it as none, like no xattr.
+ */
+static bool ovl_no_fscap(ssize_t err)
+{
+	return err == -ENODATA || err == -EOPNOTSUPP || err == -EINVAL;
+}
+
 int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct dentry *new)
 {
 	struct dentry *old = oldpath->dentry;
@@ -98,6 +107,10 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 		}
 		size = ovl_getxattr_value(oldpath, name, &value, &value_size);
 		if (size < 0) {
+			if (!strcmp(name, XATTR_NAME_CAPS) && ovl_no_fscap(size)) {
+				error = 0;
+				continue;
+			}
 			error = size;
 			break;
 		}
@@ -947,9 +960,9 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	if (c->stat.size) {
 		err = cap_size = ovl_getxattr_value(&upperpath, XATTR_NAME_CAPS,
 						    &capability, &cap_size);
-		if (cap_size == -ENODATA || cap_size == -EOPNOTSUPP)
+		if (ovl_no_fscap(cap_size))
 			cap_size = 0;
-		if (cap_size < 0)
+		else if (cap_size < 0)
 			goto out;
 	}
 
-- 
backport
