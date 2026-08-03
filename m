Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A131309F00
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767461; cv=none; b=GE7UEglcXkSbuMZqWaYCu/VgkKrAdROj8VkZUxXhBVr2sxyh+Q6xDaf/yUR2nAwHuDWIl2ov0erI8Msodh+iFV88K2aJmgH7W2rI6VtJV/Jp2WVXGVXzz2WRr1RJ/SGv5Epj5uXfS4Pv7y1UVd6weKMLXlkSx3C4W+0onQYd4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767461; c=relaxed/simple;
	bh=GXnVaGcOYcGeGF51vfhkksxSxm5iT6MduRJD27H8KxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiOzrXqnNhgsVR8QMLNJnr3YiinlE7wOShNLTuWTkTU2Ep8fKN7kxd5mpcTjf2ecv1mjkHGYBI3z9Fgq21ATsrlrik7hcA/kGx3NdG8gx6xAJBpAVnILSSDl8q1Eo3r4Pb6FsLlOKAt0nmBm/mJmNf7X3v0IfAwX7WscJRn/O08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMgunFXV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMgunFXV"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4956869750eso13720535e9.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785767455; x=1786372255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jRznYyon0XGUdVgbipyEvsqHsHiyM4eqeCRczfbwZQQ=;
        b=cMgunFXVWhAQ0qA/a8BWNqAE4aMvnXbCv+t2appMzu75LJ6iLzHYzH4FrpXyv6xGvu
         3lyZWCK1VE0nU6bVgCsWufB5ElqeEzSEU4s3ZO2gFDWkAPNYfMh/eldeTQO40U3Nv1By
         ut0WeWBmoWOeod3dBUQWsbu9AGV9Smfe1GZfsdu/3jXYzk+cDRzO2pJEKNs4tD+MIcFL
         zxL4ZOoX+1ZYpsMXJhwaR3c6xhVJ3Z/nFgotwoQLlkAh1v/t2yoFn7auBmbDDWaagifI
         6nywVuzr4zB4QNzezEq7c12+c8H/OBPYEfyposjxzs70p1xySaFcKffkBnGqoANG/LnG
         /Xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767455; x=1786372255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jRznYyon0XGUdVgbipyEvsqHsHiyM4eqeCRczfbwZQQ=;
        b=oww06doD5GrsCX2s/Y03/lDsrTBqW6MhN/PWZtY2ZXMqo29+xaOrfChfRoR5XhJ28j
         hwp0Yq0NnHU6L1wUGr3lzcihDcysZfNxwUpFYyn1CJYQOiMBbxZ8yjpfj1gPzc8KY2TG
         8aHZXrWAZU//c+6GleFsK/M+CB5NXTLolfadkAyz9e6Xm4f/AhH0McLhBvn+4QLjwWZA
         YsiXXMm2sBRjyt/2x7GXPzWU2B8cBkkwf1eRNWIM/g06SQCwgYsP/UVQZ8h0jqWvqIYV
         7KQFl0EmhLTXnaSHOo3rMrDwEtXdqMfl9818boU4x2ZAAw0alXrhB4gYVfxCbiRRQlPL
         PPNQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPeGgQVq+H6cYwJNSuXbMgN1maS9bsJw0m4DAkLmw1OEDgs6PQg5/2BQUdfThAdJfcDInGYdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLpIoRQ2KaaKJWxPGtJuU3f3FrNNOr9HL3gCIecA0iuGLdgI6y
	v+dr0OyXWITv1CNtJdaDApG71o0iSCKqRdjN+3/+ZZZBAYgTqQ2HI0CY
X-Gm-Gg: AR+sD10LsTJHkrALawd8Di9rzXTqqwp2Vl5GXO9lOiOztxhRQPKpwPpHJzzpmh6l/8K
	uf1Beb+3L3qLeLqibzsUEnN4JkneY3ggmG9lACnOQQtnYkyzO+Af373XsdujJ8iWDhYPhhho5kN
	fsgo+j2SmGYN4t/DTVBwId7LTCwosl5YOfFOQ4VllJj3gIWLW54oq0/VoPKbyp79Vgi89A6i6MN
	d1N325ElhfVbxOnKKuxn6zqY2BTfQ7Kepus8JxX/lh0dCBZMcOV1z+TVjNY0Fr9gboTVaza6JY4
	M0glPHksfN2AOiER+6qcEn9CvHaMo7oQeNZzJNNIw0sjSdyPegOdFat0bETwn3Ti+U306uH/wXL
	gH4cdWbfC7tgazxLODkoteOQAv3os+VxcaJ4lXnC/S4uA35ChL8qt+1jXoo3gySGuC+CiyKTWuv
	FGfdwUX+/7JLVNwM6y1JSldWXfM964MFCEx6lp6dNkKM9gPvMEZsOBiaDSRQncc2ckrxRt8I6ef
	IaEU3kvjzDwqhZhJ5nvIEjpWRotdcHwZX8HbHEweA==
X-Received: by 2002:a05:600c:840f:b0:493:b6ee:fcb7 with SMTP id 5b1f17b1804b1-4980c6507e7mr211322355e9.14.1785767454564;
        Mon, 03 Aug 2026 07:30:54 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b98284sm236575295e9.12.2026.08.03.07.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:30:54 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	meatuni001@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 02/13] platform/x86: hp-bioscfg: fix heap OOB read in sk_store and kek_store
Date: Mon,  3 Aug 2026 19:30:25 +0500
Message-ID: <20260803143037.93105-3-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803143037.93105-1-meatuni001@gmail.com>
References: <20260803143037.93105-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk_store() and kek_store() strip a trailing newline from the sysfs
write before allocating the key buffer:

	length = count;
	if (buf[length - 1] == '\n')
		length--;
	bioscfg_drv.spm_data.signing_key = kmemdup(buf, length, GFP_KERNEL);

but then pass the original "count" (not "length") as the copy size to
hp_wmi_perform_query(), which memcpy()s that many bytes out of the
"length"-sized allocation, reading one byte past it whenever the write
ends in a newline, the normal case for a shell "echo" into sysfs.

KASAN confirms this directly:

  BUG: KASAN: slab-out-of-bounds in hp_wmi_perform_query+0x1e9/0x460 [hp_bioscfg]
  Read of size 28 at addr ffff88813c8e2b80 by task python3/16022
  ...
  sk_store+0xa7/0x240 [hp_bioscfg]
  kernfs_fop_write_iter+0x3e1/0x5d0
  ...
  The buggy address is located 0 bytes inside of
  allocated 27-byte region [ffff88813c8e2b80, ffff88813c8e2b9b)

Reproduced identically for kek_store, and at multiple write sizes
(28, 57, 201 bytes), each time reading exactly one byte past a
kmemdup() allocation one byte smaller than the write.

Fix by passing "length" instead of "count" to hp_wmi_perform_query()
in both functions.

Fixes: b2715aa2e135 ("platform/x86: hp-bioscfg: spmobj-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
index 2b00a14792e9..4d94e48c1a4c 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
@@ -238,7 +238,7 @@ static ssize_t sk_store(struct kobject *kobj,
 	ret = hp_wmi_perform_query(HPWMI_SECUREPLATFORM_SET_SK,
 				   HPWMI_SECUREPLATFORM,
 				   (void *)bioscfg_drv.spm_data.signing_key,
-				   count, 0);
+				   length, 0);
 
 	if (!ret) {
 		bioscfg_drv.spm_data.mechanism = SIGNING_KEY;
@@ -274,7 +274,7 @@ static ssize_t kek_store(struct kobject *kobj,
 	ret = hp_wmi_perform_query(HPWMI_SECUREPLATFORM_SET_KEK,
 				   HPWMI_SECUREPLATFORM,
 				   (void *)bioscfg_drv.spm_data.endorsement_key,
-				   count, 0);
+				   length, 0);
 
 	if (!ret) {
 		bioscfg_drv.spm_data.mechanism = ENDORSEMENT_KEY;
-- 
2.55.0

