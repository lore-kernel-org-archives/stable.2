Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7AF53F685
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077234; cv=none; b=Kbu5JeVlO4h0w265KWpHUcYaSmIW+FkzNhdiQTEKZ3G53GDO1x15iXmCz/qAg9UNDp0xz39PNvU9zxsljp03cJzemcsUJ/Fb99plOxV/g4/XTwgm/3UaMilq1ChULbmo0fbfGNVXe68JEPzAnAo0q+sMrrpgUkzagrHQ0rKNg+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077234; c=relaxed/simple;
	bh=tlzCI060j6L6IgPt6ESM1jcNU3DreN2TbG88T7MTW/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pqEr/EcE+o8Kq7p6oCOB7sj5d+tdpbBPQWPbh05DfBLprft8wOl618RHAbM9eOk16frLmBWMCRGN9JgFQve5UxfCU2lFoL4W3KKhByVscyo3BUaTotj5iC6ivF3M3TQZNdxvz+8BF3jMSp2q7VQjOjjgIsScYchAvrT0bSUAP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=b8LPbl4j; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="b8LPbl4j"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369d18so30153965e9.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790077223; x=1790682023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hHRXa6eMg2Bs2shmzct4QOAwZZW+bRsX/lrRsgr4gI8=;
        b=b8LPbl4jJtfMIsBdeo8tILRSRsyXTCFj88lrz2Gvfa1v6T6XOaE/5mWteBw6z91vgI
         P6hO58jBN0H5l0v6vLdyAmwjtR+8t1ZkEaxUR/W4BZcCVeer82ghGAW/0GGU1vxUij7a
         LdTTbt8adHXfhpmBk07YIZjDuBx6nCY1pu/cn5WE/K99fl/jGclpOWrlDMz2qTOFjSsz
         WNVl63SrYzooRt2g+tD0hM5/z91yzwMhIcqbMGQKvsGTU8Pt+LuR6qgzRoblNGPHH21q
         KowZNNXpk5IOFCz0tjRa+lcWyFY1UZQyj10AtyGFtfquGLXyjpyX+BSyUy3nsY9pUw/W
         2G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790077223; x=1790682023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hHRXa6eMg2Bs2shmzct4QOAwZZW+bRsX/lrRsgr4gI8=;
        b=KCxVp/2O4e29ZYVMZXYMcKA+KBKOGCQ+zomYdsV6v/vzzTx1wQfQHwI8niydpepyLh
         xo0PQpsYB/DdJITT4g9H+CUD60pvz1WDoCEqJTiYUkthdygB7I/o/tz31RR76BwVvUvi
         X4LkUqj+6RZdxVifb84BKaKY3eafEMEZuxIwkHv7ygCy4GmmjM0891po0khL4HGgawYL
         NskEL9m5PY5BabfUUe6Ob0lBvN5loN7YRDv6aWxCfxGt5Gt0tVqH7uIQe/n3nNBOSygu
         c2P5XaAUb+AHbEUt0iMUaBQwxjPBNZfMsiuy7hz43h07CFSwk3Sb2Lgr2mGXJD6ID+E4
         gPlg==
X-Forwarded-Encrypted: i=1; AKwUvBysmAsKrWZjCWyIAm2ZT1nAuE2jeZZF6KOPwZDV4SR3ZpdXiM4agfPaku45gtkV/ohYW9NKrS8=@vger.kernel.org
X-Gm-Message-State: AFuF++mX2iHI2LbD5hYuydBhma064ehqNPgCHfzPkx6FACo6s10Q/aU0
	Lu2isHc3A00tajvhp/qG0LXRU212FjBnLfjgqO+/ztRkru4OSToZ+5G0W/fJsWaKzCQ=
X-Gm-Gg: AYBFou38QwJaHLxKeqioa+pTSpqZpeikOz9f/wtiKswckK7rbRJ9ND3uaQafIW4JXYG
	deKiv+36UrapKXtgXZ3rE9nKAJwM5Fc/v6iYHB/39wSSZDGKxcLUELVdXFq38Z/ADpF7cog1Rvz
	pKdyyRQSoMS2KXfWZYxORJ25DRfeUQayuA3N8vj/WqcDOMuQHKbYcE/WapFoT+fFaK5GTiVMRmg
	zv42JhZ5/ZkxBkcR20fuuY0kE9L3p7VAL6mnJ0fBijGxs7WsznrT7FDjN2yGvmBtZwnY4ICSgHY
	bEgt8lYz/4fWJZ0oMmhXZ/u7h2Z/OopKQ8Mp7L1rozqnd/L9UyuvqAiPjbn6fX4dvkdmwmV3OHD
	w+Fwayyxhzfpwa6mw+8Yk+r7ApCmOSQnoKz4YD5L3hy//wIoE7tp5wy/Y0+GMxJYf9DQ7tva2Ib
	Y8WzWD8C7Nff0fmO9oocl+R1yui4UTDMmdG6GRH76zLlIMzRMFvoD8xiQlt9VIfkIceJFH/+PHD
	VV+AGPBWg==
X-Received: by 2002:a05:600c:310d:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49fc5721b9dmr206467155e9.10.1790077223229;
        Tue, 22 Sep 2026 04:40:23 -0700 (PDT)
Received: from localhost ([2a02:168:9d56:1:84ba:d001:a11c:487b])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49fd8ce2646sm77863515e9.14.2026.09.22.04.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 04:40:22 -0700 (PDT)
From: Bruno Produit <bruno.produit@trailofbits.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	Kyle Zeng <kylebot@openai.com>,
	linux-kernel@vger.kernel.org,
	Dominik Czarnota <dominik.czarnota@trailofbits.com>,
	stable@vger.kernel.org,
	Bruno Produit <bruno.produit@trailofbits.com>
Subject: [PATCH] fs/ntfs3: Fix out-of-bounds write in resident insert range
Date: Tue, 22 Sep 2026 13:40:18 +0200
Message-ID: <20260922114018.1829807-1-bruno.produit@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

attr_insert_range() grows a resident value before shifting data at and
after the insertion offset.  The current copy instead moves @bytes bytes
from the start of the value, so both its source offset and length are
wrong.

For example, inserting 2048 bytes at offset 512 in a 513-byte resident
value copies 2048 bytes to data + 2048 even though the tail is only one
byte long.  The resulting destination can extend beyond the MFT record
allocation.

Move the original tail from the insertion offset to its new location,
then clear the inserted range.

Fixes: aa30eccb24e5 ("fs/ntfs3: Fallocate (FALLOC_FL_INSERT_RANGE) implementation")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
---
 fs/ntfs3/attrib.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index b1c315206..4bd758133 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2610,8 +2610,9 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 			char *data = Add2Ptr(attr_b,
 					     le16_to_cpu(attr_b->res.data_off));
 
-			memmove(data + bytes, data, bytes);
-			memset(data, 0, bytes);
+			memmove(data + vbo + bytes, data + vbo,
+				data_size - vbo);
+			memset(data + vbo, 0, bytes);
 			goto done;
 		}
 
-- 
2.53.0

