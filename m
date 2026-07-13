Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325E635E1BC
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783976192; cv=none; b=edgZ2ePp2lKFUo2XQ6pHSg/P4ovWSGKrNJkAzG93ZeKQDvh8sFgz16TlAPL6ijk77EWRdGigA1vEtEaUtKYl1/zAMr9uA7Cz7a5KkxNZWz5Yp7YI/pEFEkMuGivLHXP6t/DoyuJbV50CypjlNMIruUxRX+Yc/PHLKi/JFT9FP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783976192; c=relaxed/simple;
	bh=bMq0yg6e87SIljIP3KX8iDIAp9Uo8hI0a45j+UnWgKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hZT4EY6jHLbcEp69Yw2EDt4vjcS2Vxg3m4JpLx7rFT1ghk0n4RZUGXpUIexcn/7z4N8MVnmpJg+uvuXhGsSF84pXR6FubbzAQ4ndHSgDZqi+IfWDZYsA2yzxVeDOjyrbN3/Es+8TOtoZLea6nvwfPCQ/sOwW6g4U9FfzsAFRApw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=DxbMLCHq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="DxbMLCHq"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c733f15aso33531385e9.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783976188; x=1784580988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u+xKnuTI1B6k0A1NfDaxq70Pipp+wChxPKxkTyBDJp8=;
        b=DxbMLCHqb+UkQ5PJMNbIN8R10vLv51Ss+F75Pzd5w97IxwcL+GQhyeOUOVAtIstqfC
         WECI5GyGcsU8/Eecap1WaqlH3jZwoU+h9yOHtlaFzbteVw5+Iej5lUHDuvJOQrZP9dHV
         ybz+CIDCC9fwGi7lHp3leVrL5uqBKD55m20HN5sTR0P/YJFw+ciJlBl3p0ZAKyaCYzDC
         OuAX/mVO2jjA1FCPDrXnpq70dwu3eGQCEkX1aDQ9Fb0MmWJj9Bv6Ei7ve4UPottIU12o
         N79JL/LefTopyJQ67EELmKygLeHMYV4RTxuUIVudoIHbcj/CODGX38DBiQxxUH6bWUM9
         s7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783976188; x=1784580988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u+xKnuTI1B6k0A1NfDaxq70Pipp+wChxPKxkTyBDJp8=;
        b=ioNoq12Ay5cMydFkZITegmiHn9UPPQmRrdZ4q6zpY9r6CP00n7yOMijwVJSo0doxc5
         ggBkJtLUz+jiZwFbS89glIl0622Oogtal/Et5a5bQ0zzXuUUI9pImdy/r0feNIGufmfw
         oTPyQ1ratLnfueb+Dx3uNd6V7G2ZKvucG6P0ETrk7vGTU0O8AdusZLJp8+bLEyv4jKIH
         cUMBno9HxI2P7s25tcqgvEEbMOy5zYx6L1faJOE9HgIau3xNVYAXq0SEe++w0jfYMoKK
         /B9gc/VWYhacH0W4oklqJ2DIVQEZEFJDdmDgfGhSI3hZDNOkdz2662ES5C2PpL9uhu/k
         xz+A==
X-Forwarded-Encrypted: i=1; AHgh+RqyvjgAThOKlRe2kDzMsJjHGAo3pnUSdfzp+rTFg6hac/fJJxzZJl0pksOeEHqjSTWZrEDCVJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIJODmM074aGZ6plrtISX2d9JdkRmBu++UzIrrQcD4Q9dFFXla
	SOcRiDAt6cNqvR7MuNFGWCITGPv2fpmFkiKYzkxoRLNPmsxJtqFdtmPjBr285fYxsKcx
X-Gm-Gg: AfdE7ck31K/PgK5oq1JjyZqfNW9ubW3QPtlHJSUvzYQpa3bcwwc8kVYmoK4UAurJ6rv
	6Sdu2oLJ0Aqm1O3cIRjs8YWdAra5xsq0kO6P4/j+2AplR/mgKbZMcEAEOO8R7eEqhmCH2h0EHV7
	L7LoVAgB3AAjnOglO1caes/IjyCbzj5v2BgTSCUpY5jAH1y4FhGNY+J33jgCMiOQmWkl7HKMJVx
	N/iZpcOTONqQ7c1B6foEJ3vMWlkPFbCen3k/JOH4U4X8kN+Hbv7w1vRnF8qSN9nYK5FgBJLbM01
	B/Dm0zqBuxUSDDbw2oVpCr7D+jgz22x59bhKuAWjTHriIS/59cqp6tAEFpw72zv/qEDAopZFrjq
	07vFdgHkK0+7QldrRU7QZKlVDqOBn0lywTvlweGBXld6xSivTSsfxewb0GcFboKDRCDQ7HBKPm8
	ZqdvAekVzAZuG4knH2fIc1myoFHIo/8aBLrwpL228eYEoYP/t+wdijDN9Y37bzGp2lAvjk0ci0g
	KaIeqb2MVNK427UExOrJQ0XZSgXp5HcRIU=
X-Received: by 2002:a05:600c:4e41:b0:492:4a50:41fe with SMTP id 5b1f17b1804b1-493f881f9d6mr106303585e9.22.1783976187973;
        Mon, 13 Jul 2026 13:56:27 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950871d1bdsm21661155e9.1.2026.07.13.13.56.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 13:56:27 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>
Cc: ocfs2-devel@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH] ocfs2: validate directory-index entry counts when reading metadata
Date: Mon, 13 Jul 2026 22:56:25 +0200
Message-ID: <20260713205625.92391-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ocfs2_validate_dx_leaf() and ocfs2_validate_dx_root() check the ECC and
signature of an indexed-directory block before it reaches higher-level
callers, but neither validator bounds the ocfs2_dx_entry_list counts
against the capacity of the block that holds them.

ocfs2_dx_dir_search() then walks

	for (i = 0; i < le16_to_cpu(entry_list->de_num_used); i++)
		dx_entry = &entry_list->de_entries[i];

over de_num_used entries with no bounds check.  entry_list is either
dx_leaf->dl_list (from ocfs2_read_dx_leaf) or, for an inline root,
dx_root->dr_entries.  A crafted on-disk image can set de_num_used (and
de_count, which is the __counted_by_le() bound of de_entries) to 0xffff
and make the walk read far past the end of the 4KB metadata block, giving
a slab out-of-bounds read reachable from any path lookup, stat() or open()
on an indexed directory once the image is mounted.

Commit 775c17386a6f ("ocfs2: validate dx_root extent list fields during
block read") already bounds dr_list for the non-inline dx_root, but left
the inline dr_entries path and the dx_leaf dl_list unchecked.  Add the
same read-time validation for both entry lists: de_count must equal the
capacity of the block (ocfs2_dx_entries_per_leaf()/per_root()) and
de_num_used must not exceed de_count, rejecting corrupted metadata with
-EFSCORRUPTED before ocfs2_dx_dir_search() can walk an out-of-range entry
array.

de_count is always written as exactly the block capacity when a leaf or
inline root is formatted, so the equality check does not reject any
valid image.

Fixes: 9b7895efac90 ("ocfs2: Add a name indexed b-tree to directory inodes")
Fixes: 4ed8a6bb083b ("ocfs2: Store dir index records inline")
Cc: stable@vger.kernel.org
Found by 0sec automated security-research tooling (https://0sec.ai).
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 fs/ocfs2/dir.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index baf3eca7b4e4..fcc3721cbe34 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -624,6 +624,28 @@ static int ocfs2_validate_dx_root(struct super_block *sb,
 					  le16_to_cpu(el->l_count));
 			goto bail;
 		}
+	} else {
+		struct ocfs2_dx_entry_list *dl_list = &dx_root->dr_entries;
+
+		if (le16_to_cpu(dl_list->de_count) !=
+		    ocfs2_dx_entries_per_root(sb)) {
+			ret = ocfs2_error(sb,
+					  "Dir Index Root # %llu has invalid de_count %u (expected %u)\n",
+					  (unsigned long long)le64_to_cpu(dx_root->dr_blkno),
+					  le16_to_cpu(dl_list->de_count),
+					  ocfs2_dx_entries_per_root(sb));
+			goto bail;
+		}
+
+		if (le16_to_cpu(dl_list->de_num_used) >
+		    le16_to_cpu(dl_list->de_count)) {
+			ret = ocfs2_error(sb,
+					  "Dir Index Root # %llu has invalid de_num_used %u (de_count %u)\n",
+					  (unsigned long long)le64_to_cpu(dx_root->dr_blkno),
+					  le16_to_cpu(dl_list->de_num_used),
+					  le16_to_cpu(dl_list->de_count));
+			goto bail;
+		}
 	}
 
 bail:
@@ -663,10 +685,25 @@ static int ocfs2_validate_dx_leaf(struct super_block *sb,
 		return ret;
 	}
 
-	if (!OCFS2_IS_VALID_DX_LEAF(dx_leaf)) {
-		ret = ocfs2_error(sb, "Dir Index Leaf has bad signature %.*s\n",
-				  7, dx_leaf->dl_signature);
-	}
+	if (!OCFS2_IS_VALID_DX_LEAF(dx_leaf))
+		return ocfs2_error(sb, "Dir Index Leaf has bad signature %.*s\n",
+				   7, dx_leaf->dl_signature);
+
+	if (le16_to_cpu(dx_leaf->dl_list.de_count) !=
+	    ocfs2_dx_entries_per_leaf(sb))
+		return ocfs2_error(sb,
+				   "Dir Index Leaf # %llu has invalid de_count %u (expected %u)\n",
+				   (unsigned long long)le64_to_cpu(dx_leaf->dl_blkno),
+				   le16_to_cpu(dx_leaf->dl_list.de_count),
+				   ocfs2_dx_entries_per_leaf(sb));
+
+	if (le16_to_cpu(dx_leaf->dl_list.de_num_used) >
+	    le16_to_cpu(dx_leaf->dl_list.de_count))
+		return ocfs2_error(sb,
+				   "Dir Index Leaf # %llu has invalid de_num_used %u (de_count %u)\n",
+				   (unsigned long long)le64_to_cpu(dx_leaf->dl_blkno),
+				   le16_to_cpu(dx_leaf->dl_list.de_num_used),
+				   le16_to_cpu(dx_leaf->dl_list.de_count));
 
 	return ret;
 }
-- 
2.43.0

