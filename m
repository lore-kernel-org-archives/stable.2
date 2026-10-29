Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270367;
	b=B/cWZ297vEF2mn1uySAiklq6kPiGxdjQKFGpC98f5FJ28o7vjmoMG2k+RF5ZQB9wy6cI
	 QqkJgZQuSCrcvzIhq3m6I02+StWSrFIH5ppzV7mTk3D+zQ5scXbw1DQ6gqyOIhnKq1fMn
	 +vQkpYdUB/16nab8xposbzYHqjmhTcRdLmXGIuoXrgDtwq47eAX92fLYyr0bxOg6jqo3V
	 h5ZNumqzKdjWU5UkAjCElx0QmFVfa0QhfB0rdJYm8VwMT0gGVRAceyUsFuqlalcuCeAdA
	 xquCzIel1VWw2VbycybjWDSANje0AjFbLmP+PF9E0bspmbjvvjiTftme93zOMlHzZsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gWikJcHMy/FGJ+Cip1xhfQi9ECC0Fi/XHUzFD+d9ZqY=;
	b=ZWsPVDBIjzNTmyFX+WciVuRV65SBQOYK2bmxyvv3aPlBlgaf17KHHgwP3Go/9VLMeQbn
	 iUNh6kzRwnf1NkcNcrIEf2G1SP01nFJTlC4Rxa/U+V+743fPMff9m6KjYG247CFtIQ6rt
	 1Qr0iwDPo+Wc9LPL80Aa7BviJl4C03pi70UHiNhFABDVWLLREE2Svs6BRXhPJ5HU0c1D+
	 Yr/N4grTGpTVO4aaMjfkCt+KDOJOh1/EbTVSuzaUrPup6yZ9QNL60p5TgGZRc1kbej3xx
	 PkZXWaqdTqLG88VY+00AL7xk7/CbflBOEH5RoGYSAc0i0zGsBMBjMCO1xzJov82zGDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bZ0w/NtB";
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE889606A33C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE889606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZ0w/NtB
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c498fa2f365so252208466b.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270365; x=1793875165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gWikJcHMy/FGJ+Cip1xhfQi9ECC0Fi/XHUzFD+d9ZqY=;
        b=bZ0w/NtBO1ZzNLjjNaLIkKRzCia1nz8IsPEYwvQoziTJw9T7LeTs3MtV8kiRJP7gSB
         OURibTMjZIDguMBcps6byDm57+Kr5kC6RXCeGNw5Ey6LnrZNwU+XzFh2ERdcEtSHLAJn
         3TouxcRwdk6vxRv1Hzkg6b27ZHDk4gvq+1g+8dFCPlV6oy51ti9sb5ondZ/eI2GIh1c4
         tuHSA1/5SqRBUJqe+aM62Cuj1bhSxNWh1VAHibHRhtH8dzZEMxCu9XClawK3iRb3BjCV
         40ZrRduc4p6Q4BPwJmcg1mlb9Xa1NF6CzfsCNwkFjBGs9I0GPX8d9SEMJPpTS74Xwh/H
         IZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270365; x=1793875165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gWikJcHMy/FGJ+Cip1xhfQi9ECC0Fi/XHUzFD+d9ZqY=;
        b=Y8hDDLnulH8PdcO2x6LHu51TU1jJHLvAdJpqIDdb4E8H1/JYshqDvOH7mRivGTc9YO
         p+hwtTLN027rq8JHwbFCY7Q5z2gZOkpMPDr0ufYlSqeEyR5tMTRPOZm27YpfZ8RCFTW0
         mR2o/oTeDgOEJJd5QjbG2TlBQ2AeCLt7ws/5Ik/zQU2l4CW1eYbzBGJ0a6JavzmjE6a5
         Hx2GiYX94O2NOgojT6h80uXGMRQXx77gosFsWeT7aAHScZMN+ZxrL6Q4TI4Bl79XSw+/
         efjbkjK9A9sHG126oTwxenJHW1dzMysAO6hDixjWwToUe092xH6OXHy8L7PGc+Pu8g2F
         JU5A==
X-Forwarded-Encrypted: i=1; AKwUvBwX1ZLzcqgIFypTGDYGj272xZYxzMD8k+BvL8fEe0UAR1uEJrfeO2cgLfJYK8MrQxF0JFCYI7A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJsz/BRCU/noM6KAzqvLKVRftoeeOlsLOomaKkKa60f8FCHKy8
	DGJtWz6WBhDoNl2fUsIHBMLPUl9gBVF2AsO37JOUActOdY9mqwg5Sk9I
X-Gm-Gg: AYBFou2eBEBVPEgqSDGyurLOZ3T1a9xYIyFXnpH2dUIXAIxeGDkvA1bENPks5ystGm/
	V9NzZdqRmOqZyEXRdSShGf4PFLDsHAa/SHk8hWrsO63Ijmh5Qp84L8YqtB9dxQBhq+MWlWo0iz4
	UBFH31RORvW4o51fllN2XxxdoUMA1IvVKeL4M7YslXcsP8t0sNa7AZLZsd61V6TCrQBFWHaH8Bj
	MEwIk9cwA9cWQ6zTx9ElOnbnSoTpzPVhQY0+PukMEXdhr7yvTw16/zntZJzt240ZrPJop6IwlRt
	lACIb2LuP9+3GFQbh4YpERZ+pYivT0WSD/UUypEUs6M7NS823jKqkDcRAySdLXCNRXAFsWzXyXD
	zC3yCcHs/jDRK3MpDppC8K+gMEOJMXgkjYypc70gOUGHQNineMcXSGrw8NKqiOzB+/WmSohjkZZ
	SAmCdo9XrxrPHR4AZbgoyLQzs50jbomtXLpVs/+mxrEpInWp208/EVKZYJHCU+AF5LtLV8iVcif
	NxA+JNhEL3mWZcznXmcYt1oXsATHnZie6eRxPgFty1mA2us+xZ9bnfxTDgpBxMJQjLgm0cuiGLq
	G9yWiJhJZ8FQGD3Dw6cWUNJeSeGMqAwRlE/lfZcQ/Qk0nuBtmGFxw0R5SIlX9i/Ols7lerFySPR
	eBezXxtqFoLoYhtmDs79KNqmGUCUN1xL/
X-Received: by 2002:a17:906:eec8:b0:c46:8c2b:8f7e with SMTP id a640c23a62f3a-c49bd9e322amr444578866b.0.1793270365070;
        Thu, 29 Oct 2026 03:39:25 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a530f520sm391847266b.23.2026.10.29.03.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:39:24 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Chris Mason <mason@kernel.org>,
	stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 09/16] ovl: use the pinned upper dir in ovl_fix_origin()
Date: Thu, 29 Oct 2026 11:39:13 +0100
Message-ID: <20261029103913.2785828-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029103913.2785828-1-amir73il@gmail.com>
References: <20261029103913.2785828-1-amir73il@gmail.com>
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

Renames made directly on the upper filesystem during a lookup crash the
kernel.

A dentry that is passed to vfs_setxattr() must be pinned.
ovl_fix_origin() passes upper->d_parent to ovl_set_impure() without a
reference, and the lookup holds no lock of the upper directory. A
rename on the upper filesystem changes d_parent, and only the child
pins the new parent, so a second rename and an rmdir free it.

With delays in ovl_fix_origin() and ovl_set_impure(), renaming the upper
directory twice and removing the intermediate parent during the lookup
of a merge directory without an origin xattr gave a KASAN
use-after-free in vfs_setxattr().

Fix this by passing the upper dentry that the overlay parent holds.

Fixes: 9678e6303057 ("ovl: fix inconsistent d_ino for legacy merge dir")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: add helper ovl_set_impure_dir()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/namei.c     | 6 ++++--
 fs/overlayfs/overlayfs.h | 6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index ca899fdfaafd2..cf7908a39f614 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -942,8 +942,10 @@ static int ovl_fix_origin(struct ovl_fs *ofs, struct dentry *dentry,
 		goto out;
 
 	err = ovl_set_origin_fh(ofs, fh, upper);
-	if (!err)
-		err = ovl_set_impure(dentry->d_parent, upper->d_parent);
+	if (!err) {
+		/* upper->d_parent is not stable, use the overlay parent */
+		err = ovl_set_impure_dir(dentry->d_parent);
+	}
 
 	ovl_drop_write(dentry);
 out:
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 7f3558372c599..c89739e5338b4 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -572,6 +572,12 @@ int ovl_check_setxattr(struct ovl_fs *ofs, struct dentry *upperdentry,
 		       enum ovl_xattr ox, const void *value, size_t size,
 		       int xerr);
 int ovl_set_impure(struct dentry *dentry, struct dentry *upperdentry);
+
+static inline int ovl_set_impure_dir(struct dentry *dentry)
+{
+	return ovl_set_impure(dentry, ovl_dentry_upper(dentry));
+}
+
 bool ovl_inuse_trylock(struct dentry *dentry);
 void ovl_inuse_unlock(struct dentry *dentry);
 bool ovl_is_inuse(struct dentry *dentry);
-- 
2.55.0

