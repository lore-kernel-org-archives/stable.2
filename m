Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAD332AAC5
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942621; cv=none; b=afPk9A114z1nrBm7aY7hiHmnkdnTEGqerovu5ZDVNqmg7YXYf+wpwN+RgAByKUMi1sM92a8dZmh7UQApYOW04av4KD9boLH19k36tuD1EqNv6TQaOHQHdvW1HaTPfJ3ojimLCkWS1d2BMO6a/eMi8bXibGkdsvfZJFEvF/yU3kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942621; c=relaxed/simple;
	bh=lk7/Y+nm7z34zfFgSYQFyUyrsADSieyP2/VHG5hv3gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h+rg0R55JEM408Dy9rOXWnbi9IAtF5XEDFuuOehZ1QB0yQQ6Ejo0tQJFOUVgCK7nk7VkKrFXfU0wzaz5lH2A/tD1Lt2Zvlox/lNqB/GBiS5dLPHfvZCoT6/bPmDP/sDBNdLl/wVzw3LvQH37BGGGdZCdEXseYhdvzqfjHr2o+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw1p6vmp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw1p6vmp"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c7cfa17fedso10791815ad.3
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 14:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782942619; x=1783547419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SQhTVa27wtWpKyZPBbV+jcAA8vWumq0NV6yrixuYH/k=;
        b=Hw1p6vmpHT+GjRt1tnZJjLParWVsefkVtaN9RYOv1GKzmHLBu6wTpK71d2yvZ5DYIq
         2f+MRtMt7E6uuaH3UPgghv0OzLoawz11pC8CHcQbx4qQ0gxHrhNhnY032SmUobBpxVB+
         iAHoQ7NXbfIDGnpvWQgEv38U9YWXbcUf6MwaiEWmd7C769X6i6v25pV4dzrwb1JQ/aBW
         JvYmn49rgI9IOXrLpMfaNq+ESQueFb3WAxG6laINTSPLNHaRyEi8WYTHZA7F3yISzrRY
         2yCy3dEhB8mki/iRyRmXUzXoeE7P4BcV7b8VFgvnbjs8h8B7i2UcRlQOINYzysKSKjl+
         LI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942619; x=1783547419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQhTVa27wtWpKyZPBbV+jcAA8vWumq0NV6yrixuYH/k=;
        b=ND0mhrBidwNRgfCHyy0Dls+5FGM2lXQgG6IoJY4uFfnhm/GbkRxvkpJBj2cm9xY9Fx
         fVcfsrn7ABzt11k0bh+/D/vWGZjxO7z8zaX+GrqpWOK/wc0mfeYOg4iq5qBrwcCoZL5g
         ZH0E75SRyA6283vyxvmp3x/sHQB7nOGpUFaagIqVYQRpdYg4Y4Iseu8zbrehGG0g0Bfo
         fYlTcE0HjdIu9oY0Zs4QLSkvqd0CKYVX4z6CtA0t17hNLif9oeEiLm/Hk+R4YUDhowGU
         fJOp7hNauJquhuxkF0hBfkmMKWStjRqGOKcYqQeDhIU5Irm6TIx98AmzBoMC4pI8Cv9T
         8gYQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPw1iJave9TO1pPL4BSg1nu/ByCxCZ9dqk2yvBReQV3Kr4O792rO3LLnGC5KBE51HYCutxmkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnTRiTdvGqfJ1UUPXVjk7ykAc6mvq/bNgBsEmchhqaNg3ugYHL
	Zq/LN8X1fWrAHq5YfM6p89zAXefBE8kGEXLDS0/SNY9u/liSXa3q1UKr
X-Gm-Gg: AfdE7cn4CYNoAOtpH4rWf8kxq/qQvH3dlUCCafBQNX3UVsP0FXdWNkwj+vMBloD/HGk
	nMpxhdSiTeNtFJdvItzjq8sKti/0o+QQeM9gr1YAuE0OeR4hxdR4IP/Tg5BlZuohpTTl67JzRpg
	U7Xjdxhs5S0IvjIjAUZFXYNDOxpTlg//S9NpMMB7Bz8H3TKsvqVE7+tSXI3Ho3Q6ebvae7V6z3l
	/7BYLmG9ZZL+P15QMh7kO6y43T1sPDVaZINqlJLksb7HxnUNAagx1bix9Sk5rU5xO4zFSbA95IO
	pUMoKU86UllwU8fy6iH/07Zy3FmpTfDFx2qdo5sU+GBGLLn8IBf+3yrZ2nxPRl6WMuADh40lvx0
	WHHdEDetjQtV/g+F/kY7HpPM+4DG0uz9fck+cBGlCJ7IDO8oF03D7p2b+TH7RIyJiCaOJ+3qHpO
	D08I70BIQIYBZu2bfNaVsdBIt7dAiJ72g6fyRuJMnzSL1ag4zomiLAn35F2xJ5c58=
X-Received: by 2002:a17:903:1245:b0:2c9:fd62:a709 with SMTP id d9443c01a7336-2ca7e6838d3mr37439515ad.10.1782942619076;
        Wed, 01 Jul 2026 14:50:19 -0700 (PDT)
Received: from DESKTOP-L3Q0GIV.localdomain ([203.230.195.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9e94d5sm4089575ad.57.2026.07.01.14.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 14:50:18 -0700 (PDT)
From: =?UTF-8?q?=EC=9D=B4=EC=83=81=ED=98=B8?= <kudo3228@gmail.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: =?UTF-8?q?=EC=9D=B4=EC=83=81=ED=98=B8?= <kudo3228@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] hpfs: reject oversized indirect extended attributes
Date: Thu,  2 Jul 2026 06:50:14 +0900
Message-ID: <20260701215014.821667-1-kudo3228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

HPFS stores the length of an indirect extended attribute as an unsigned
32-bit on-disk value.  hpfs_get_ea() exposes the selected EA length
through an int-sized output parameter, and get_indirect_ea() currently
also receives the length as an int.

That conversion is unsafe for malformed metadata.  If a crafted fnode
describes an indirect EA with length 0xffffffff, hpfs_get_ea() assigns
that value to *size as -1 and passes it to get_indirect_ea().  The
allocation then uses size + 1, which wraps to zero, while hpfs_ea_read()
receives the same negative value through an unsigned length parameter and
attempts to copy sector data into the zero-sized allocation.

Keep the indirect EA length unsigned until it has been validated.  Reject
values that cannot be represented by the existing int output parameter or
cannot be allocated together with the trailing NUL byte.  Also store the
output size only after hpfs_ea_read() succeeds, so callers never observe a
length for data that was not read.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: 이상호 <kudo3228@gmail.com>
---
 fs/hpfs/ea.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/hpfs/ea.c b/fs/hpfs/ea.c
index 4664f9ab06ee..d23de4f9e2f5 100644
--- a/fs/hpfs/ea.c
+++ b/fs/hpfs/ea.c
@@ -7,6 +7,8 @@
  *  handling extended attributes
  */
 
+#include <linux/limits.h>
+
 #include "hpfs_fn.h"
 
 /* Remove external extended attributes. ano specifies whether a is a 
@@ -48,9 +50,14 @@ void hpfs_ea_ext_remove(struct super_block *s, secno a, int ano, unsigned len)
 	}
 }
 
-static char *get_indirect_ea(struct super_block *s, int ano, secno a, int size)
+static char *get_indirect_ea(struct super_block *s, int ano, secno a,
+			     unsigned int size, int *out_size)
 {
 	char *ret;
+	if (size > S32_MAX || (size_t)size + 1 > KMALLOC_MAX_SIZE) {
+		hpfs_error(s, "indirect EA is too large: %u", size);
+		return NULL;
+	}
 	if (!(ret = kmalloc(size + 1, GFP_NOFS))) {
 		pr_err("out of memory for EA\n");
 		return NULL;
@@ -60,6 +67,7 @@ static char *get_indirect_ea(struct super_block *s, int ano, secno a, int size)
 		return NULL;
 	}
 	ret[size] = 0;
+	*out_size = size;
 	return ret;
 }
 
@@ -138,7 +146,9 @@ char *hpfs_get_ea(struct super_block *s, struct fnode *fnode, char *key, int *si
 	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
 		if (!strcmp(ea->name, key)) {
 			if (ea_indirect(ea))
-				return get_indirect_ea(s, ea_in_anode(ea), ea_sec(ea), *size = ea_len(ea));
+				return get_indirect_ea(s, ea_in_anode(ea),
+						       ea_sec(ea), ea_len(ea),
+						       size);
 			if (!(ret = kmalloc((*size = ea_valuelen(ea)) + 1, GFP_NOFS))) {
 				pr_err("out of memory for EA\n");
 				return NULL;
@@ -164,7 +174,9 @@ char *hpfs_get_ea(struct super_block *s, struct fnode *fnode, char *key, int *si
 			return NULL;
 		if (!strcmp(ea->name, key)) {
 			if (ea_indirect(ea))
-				return get_indirect_ea(s, ea_in_anode(ea), ea_sec(ea), *size = ea_len(ea));
+				return get_indirect_ea(s, ea_in_anode(ea),
+						       ea_sec(ea), ea_len(ea),
+						       size);
 			if (!(ret = kmalloc((*size = ea_valuelen(ea)) + 1, GFP_NOFS))) {
 				pr_err("out of memory for EA\n");
 				return NULL;
-- 
2.43.0
