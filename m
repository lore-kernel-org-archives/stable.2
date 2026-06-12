Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C3A35CBD7
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250913; cv=none; b=nDKjI/q5nlOlj9w2IyI8k40uRbn61Lvpzld5zehfd1DIH/pkUifb91PSI6ub8SdJJhoyapY9TwLAnM6QUu9EnZX0vPNlUQ51mTVWK1+O/HnoZ6rQr8Knnuuxe0rSP2wUlQmT8iK/AAAkF/IMmfRob9yzxzQ0wrCwZIIShlFQYDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250913; c=relaxed/simple;
	bh=l1rOtVRyTqLn4QszsoJsms/RTMt3MUgzAUQG3AKzPYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSH0IG3CA2RzR5AAuIZtdgVQlqeSHnaBX0SajCrTnEuPEM7+vRyDHNJJ/MoEgNhKXYFm983s+04afVRel+DNuPA5xF5U6zz+jBXvp+fVufUdwDkZDw/vLn3EQkWfZ32zjZhd2owL+FoRxl2owm4ZNSBSRUtT2+wPmx1zN2c6gwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRBjeGrL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRBjeGrL"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c40397e746so2659945ad.3
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781250911; x=1781855711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/+FvjQjgSa3gZ/Hjg+q7qHpqloMKqAn67NuYYjqhas=;
        b=MRBjeGrLJ1FbyxuDhvz3cP0dWxLO9NOMMuaizutxHltzkh2fDgIX7z1+XAYuiADSJl
         FYk9WKdFXqNT/13uG+xBTpEMOjXak3BgCLPkfoaxbeSaf5EaqxM5g3VIo7xmx1kSTG1g
         ABP/9UDgN/SjwJgOkYRL14aU8WZbodbrVdqKlm0y66XDQlNx/XXGZucDrnNCyl7DgKI4
         tHbH73zHOLPyEiL4+fi4n9el5bnn47yQd/VQ1hClPNAoD+sUweO/8SyxUgSPpXujBFkC
         Yo1DyhZkTCN71UW9L/YWcW8sqHIOqEVdhWMAsZQQfrm22xwB0Zaxu9RJ9sTBXZELYnrP
         zN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250911; x=1781855711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D/+FvjQjgSa3gZ/Hjg+q7qHpqloMKqAn67NuYYjqhas=;
        b=RVF68NVWlpzCUYffwpTLBtp1Nv1jKOKpLwGWXOn4PXovjfJ5ujaLcOSeNxarFBcyw4
         58NyF1u4wljV56svEeGsbZ+2XyPFO7IzbtlOWfFm6gQN8HL7BUCv9WsGHcuzWGfkh98r
         rXjToObyLB922SO4JAyx97sIji1sxCJRBELxLp8DyYIjvbr91Y975MaEydmp9bgeheUD
         ioEUq78Ukj/52k1Y84qAsUSjMdRrfyCcasMlup2vIm1pFmCQDSEQPD+AP8Ay99VVXrfk
         /QtbmsUHHaM4BI8/ZRyhN3td7l/Rt+SGzeKXYUb6jE5sA+kGGpmyNKQYPLt9LjxCQPNp
         Bpxw==
X-Forwarded-Encrypted: i=1; AFNElJ+ysbU2zfiJQ53BCB1vbaZ8a5sSTFithHuaRUH9m50whglyqpVbg0PB15NVzazVSMbeVjWRCxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKpK4Y50O/U+cVDR5ZEO9cIROCHxSjRLe8x9ovbe02HVG7Qv79
	GflxGh4DCz/t4oZWaaxmPluenhWcUTs7wqlL46RABXTc8TKSUVRtxLw6
X-Gm-Gg: Acq92OFI6/DNJdl+17xztFvc3e4Qr++YrrYlWSeVyWhINR6gDrJRVfhD7h+CUctjmY7
	pQEky33wUcGhLx+hs5crZIEOugDNKr2yrUEoVomeO979R0dfkWm7Y9hfgAOhBi/uk79CffnQzfU
	z8Tnbnkebseq1UlOwAuCAx2OSgaLwKxdkZr/1lOk7cGiTjnHxFr9uDa9ShhGt8BbmkpBGtHDzv8
	1ySz+A3jSVRLfLL6mbzLdA+x6gylgGtfpOXpR7nkq3We2wgNuMcKRPqkgpl9Iq5pHOG66+uPMNX
	6N6X/9K0PVSeeOVhUaeBF7LnX5f5jn43nMHBbJOquzBFnbT2d9q4uMgGVi+0V517HGbyZ6j9W86
	uCTBlmpyDHcC8cz/kj+Y6lXOU+939SEMe5PFJ2xivt/VFnk7YEG1/X7JY+/NKACsFP6CAtjRkqv
	PblLCHcggYTQHPbzzNrJd1U56vgSTOviQDVDVSJRsQPYv8n7q9nSb7U0Y=
X-Received: by 2002:a17:903:284:b0:2b7:975c:dacc with SMTP id d9443c01a7336-2c4104117fbmr21994715ad.1.1781250911420;
        Fri, 12 Jun 2026 00:55:11 -0700 (PDT)
Received: from localhost.localdomain ([116.72.140.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432d8a039sm11197655ad.62.2026.06.12.00.55.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 00:55:11 -0700 (PDT)
From: Piyush Paliwal <piyushthepal@gmail.com>
To: u-boot@lists.denx.de
Cc: joaomarcos.costa@bootlin.com,
	richard.genoud@bootlin.com,
	miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com,
	trini@konsulko.com,
	eric.kilmer@trailofbits.com,
	Piyush Paliwal <piyushthepal@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] fs/squashfs: bound fragment offset/size in sqfs_read_nest()
Date: Fri, 12 Jun 2026 13:24:24 +0530
Message-ID: <20260612075424.83462-3-piyushthepal@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20260612075424.83462-1-piyushthepal@gmail.com>
References: <20260612075424.83462-1-piyushthepal@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading a fragment-backed file, sqfs_read_nest() copies the file
data out of the fragment block with:

  memcpy(buf + *actread, &fragment_block[finfo.offset],
         finfo.size - *actread);

finfo.offset (the fragment's byte offset) and finfo.size come straight
from the on-disk inode and are never validated against the fragment
block length. Unlike the data-block loop above it, this path does not
clamp the source span, so a crafted inode makes the memcpy read past the
fragment buffer -> out-of-bounds heap read. The leaked bytes are copied
into the user-visible load buffer (information disclosure) or fault.
This affects both the compressed (dest_len bytes) and the uncompressed
(table_size bytes) fragment cases.

Validate finfo.offset and the copy length against the available fragment
data before each memcpy and reject malformed inodes.

Found by fuzzing the sandbox (CONFIG_ASAN) sqfsload with mutated images:
before, SEGV in sqfs_read_nest() at the fragment memcpy; after, malformed
images are rejected and valid fragmented files still load correctly.

Fixes: 0008d8086649 ("fs/squashfs: fix reading of fragmented files")
Cc: stable@vger.kernel.org
Signed-off-by: Piyush Paliwal <piyushthepal@gmail.com>
---
 fs/squashfs/sqfs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 3548b5e07e2..6e7723669d4 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -1630,6 +1630,19 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 			goto out;
 		}
 
+		/*
+		 * finfo.offset and finfo.size come from the on-disk inode and
+		 * must not let the copy read past the decompressed fragment
+		 * block (dest_len bytes).
+		 */
+		if (finfo.size < (size_t)*actread ||
+		    finfo.offset > dest_len ||
+		    finfo.size - *actread > dest_len - finfo.offset) {
+			free(fragment_block);
+			ret = -EINVAL;
+			goto out;
+		}
+
 		memcpy(buf + *actread, &fragment_block[finfo.offset], finfo.size - *actread);
 		*actread = finfo.size;
 
@@ -1638,6 +1651,17 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 	} else if (finfo.frag && !finfo.comp) {
 		fragment_block = (void *)fragment + table_offset;
 
+		/*
+		 * Same check for the uncompressed fragment: the readable data
+		 * is table_size bytes starting at table_offset within fragment.
+		 */
+		if (finfo.size < (size_t)*actread ||
+		    finfo.offset > table_size ||
+		    finfo.size - *actread > table_size - finfo.offset) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		memcpy(buf + *actread, &fragment_block[finfo.offset], finfo.size - *actread);
 		*actread = finfo.size;
 	}
-- 
2.41.0

