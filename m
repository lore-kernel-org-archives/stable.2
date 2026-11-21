Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795263866;
	b=WymCSCpviDlAUjiadOfcxEsVL0YbV0oial44NdWlb50mft3lRYxYye4UM9f1usZHBH44
	 Qz2Y7h2u+GE41IgZTlNcCh1mEUow3vZPycoFTO/aUn/mw1NH3iWuH/GqnncACf90EpFSU
	 TWkqZf0iwz/T4nMRfxKt+L277r627meSj6Tb5I4eZOU3Xq2FvJ57a6KqCBqdkcMpGDjcT
	 knJo3AQQ/6u2lcbPVvQOCeL7fi27RApufdJyhHMK8sqnI4wesjkbYrfFaPIsSCZsoS+JB
	 dmfOOA7pZM8PsRgn99c5tTCX5aMZsy9k+Cek/XsZQPzerdKgJbupqD9oyJroBnVLpeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795263866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i6Qv8wZdxu9JFYsmpOYL26yXLDHBJkV6sn6Hsg9cqy8=;
	b=MrYrUHmdvrpOIecTTp8UQ9N4tF0ECA1FW9je6mzsdmuLcQ8R6qXP9nX4XdROQS0QU1e+
	 R5KJvw+buinlRDEj81NM0Nl5SCdm2f4lvckJ4cWMCgKb6zvrxRPVPiyuLg65vNpIKJ1YE
	 Zgp1keDxxTD7iup1wMzcrHGYOT05XIwVEKpKY7lHAfYGVn45YOO7A0BUO/x/bJxje4rm1
	 /35r2PkNeHhlYehGB0Wa0Caah8ZnIOS4hxU+V+QRg5+OiJtwW8CyMtiezA92pfAiI3Phm
	 xHGyip0LUijmj9AyYviPmUC1AZZizdUusGI+dLGvJp0R/D1nuFWXYlCW4gS4eTVdCNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mlj210yX;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CC6606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 12:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9CC6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mlj210yX
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1a2761c69fbso3788340c88.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 04:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795263865; x=1795868665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i6Qv8wZdxu9JFYsmpOYL26yXLDHBJkV6sn6Hsg9cqy8=;
        b=mlj210yXvSRbMgy2A3+qsQtbS/9BHBbYy4xOJF2/2eM9BGeuKpAzbkgrTPUjujlrPP
         dpRkqcgJzQg+t4LF7B2kmYjvIaLovHwkQ3bULS/Hj9RI2S89U4sFsmU0FkAEFcVjMMkz
         cNJ3ua6u8jRyy7XCgWNi2yi17LIcmGROZaIU9t/L+P9DQ4BFOaoXS4Zx3fORoWKVfXjS
         8xTDLlVVJhMsj1xCRVzMJB9jtQTBG8Aul0xDuGGTewttQCCRvUrw7uXyl0qgzMFNRsDl
         zkLd8rzc3HSCATYRsuBgd/iHFW6lw7W/xMIrY+vD3wjjhj0nRFEkuSrP6W3uw5ozRNq7
         +KuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795263865; x=1795868665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i6Qv8wZdxu9JFYsmpOYL26yXLDHBJkV6sn6Hsg9cqy8=;
        b=OLXKVv/ZdIL9Ejn16YjZLzuJZX41wWTHkBsXIxqSeP1cO+Dxb35h1nn5kmEnw8AOJH
         yFQ7wJtLuxg8SQvqoxxNcIHr7ltGJ3HImPQatcrfL4jA0HPVQhI/GGD/0E4n/4xlEM7Z
         geOVSBWMGZQalwe5fGzdiM0j0MdBbORqd1GTsf/1cnJzzGpyEn0XbNVCtL2Bw2ecpM0T
         TxxgiiposHjWkhb3kbTZGZJO1E0TFEke6TxwA8Vvbg2VYsUaZx4kBPZ3LQ7sPKJZI8w7
         gv0+o6nrbNwYuUAkxippp7ubRoWn4mt1H1yTRwZdDWxE2l07ssdGciNOSNYQfaLW1uM6
         fQ2w==
X-Forwarded-Encrypted: i=1; AL+hErHyHnGYzAqaxB8N68FNEsXrsAERCci/vjgO2SvNDRhM84ql74fGIEzFgids4qjCq59zHvrpsOM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rtqBEUb1C/fga4LS7nYi+jFNqv9KP5/LItg4AjF97oBze0UU6
	G0l2Yq9oolIMB9VHnZekERr+CAD2DpfVVRWc/VYEHQtfcLBbwVwQQUEM
X-Gm-Gg: AZFdTZcRN+F/CexoVCzIHct4MQANQWqv6qWMg2lN61gGd86hBkyLEyd5h4F1tBgVv5L
	0TFa03Efvwv+k3xwxfoBDcejeyb+93Er2sBliw1mVNuyZpB6jW+o6BYYXwALtgNjJez0pBRjNd+
	tzl6hTgMwzZMJ5f/tsa0puM/ZlnWpRyjrfJU0LMEnL5ezHKXxfXa1E9hDuJAByK36BegoyJzkoW
	fFs/gfxKpArQRjMolKo3eQQYDQxmG2nPJTn1/x/f8PJvWE4OR5NRwmwuly4SZuIkPl84poUTd1n
	rY32ORXgJnrrvi1ln5d1hT/DQdv4lQF0lZf/Lmhc1QhdUytbvG7lXtHQ/lVJre4S4VVQKOGWmU5
	62xab/FhWaUCjk6gcqKMlHKRy/MYL1trYdjN0kZ5X9yLeSZMu6ltIQbe6iNbgn92jVklalJNkC5
	pe2WCzgtz0oMd6+crCbIocvoKYWfG1O+fEt9xPkw1pGlochkqhw+eDDAetrze3wDu2xjvmmzfQb
	5b51ogDzse5ILy+UX+yF/3O3bxWzy/XLYTTsUp50OYd2257OKe1pRVgnzFxt9tAwjO/Mts9Mwh3
	9aB5wgXIDLe7SX+QX30wxHDPpIxktjgR06vRE6fpVLYjsTYvjmf6bAVdD1411pILyA3aj/0fom0
	3dMxJoCzLNam1SdA3lcftYrA1
X-Received: by 2002:a05:7022:e80e:b0:1b5:3b6e:e1ed with SMTP id a92af1059eb24-1b55690bcf3mr6730337c88.32.1795263864702;
        Sat, 21 Nov 2026 04:24:24 -0800 (PST)
Received: from ip-192-168-31-150.ap-south-1.compute.internal ([2409:40d2:10d7:e30e:302e:83a2:5a33:afcc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm14733690c88.6.2026.11.21.04.24.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Nov 2026 04:24:24 -0800 (PST)
From: Tanuj Sharma <ertanuj96@gmail.com>
To: ntfs3@lists.linux.dev
Cc: almaz.alexandrovich@paragon-software.com,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Tanuj Sharma <ertanuj96@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] ntfs3: fix out-of-bounds write in do_action() bitmap operations
Date: Sat, 21 Nov 2026 17:54:17 +0530
Message-ID: <20261121122417.72854-1-ertanuj96@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <2026112132-spending-smoking-5e7d@gregkh>
References: <2026112132-spending-smoking-5e7d@gregkh>
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

In do_action(), when replaying log records for ATTR_ALLOC attributes,
the buffer is allocated based on bytes_per_index (typically 4096 bytes,
kmalloc-4k) but bitmap operation bounds checking uses lco -- a larger
value derived from lcns_follow << cluster_bits (typically 8192).

This allows SetBitsInNonresidentBitMap and ClearBitsInNonresidentBitMap
opcodes to write past the allocated buffer into the adjacent slab object
when processing crafted NTFS images with malicious $LogFile records.

The bounds check compares against lco (the full LCN extent size) but
should compare against the actual buffer capacity. For ATTR_ALLOC, the
buffer is only bytes_per_index bytes, allocated here:

  if (attr->type == ATTR_ALLOC) {
      t32 = le32_to_cpu(oe->bytes_per_index);
      if (bytes < t32)
          bytes = t32;
  }
  buffer_le = kmalloc(bytes, GFP_NOFS);

But the bounds check uses the larger lco:

  if (cbo + (off + 7) / 8 > lco || ...)

With bytes_per_index=4096 and lco=8192, any bitmap_off >= 32768
(byte offset 4096) passes the lco check but writes past the buffer.

Fix this by computing the bounds limit as the minimum of the buffer
extent (cbo + bytes_per_index) and the LCN extent (lco). This ensures
bitmap operations cannot exceed either the allocated buffer or the
on-disk extent, and also prevents a crafted bytes_per_index larger
than lco from weakening the existing check.

Found by code audit and confirmed with a crafted NTFS image that
triggers the OOB write on mount.

Cc: stable@vger.kernel.org
Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Signed-off-by: Tanuj Sharma <ertanuj96@gmail.com>
---
Changes in v3:
- Fix coding style: move bmp_limit declaration to function scope,
  remove bare blocks

Changes in v2:
- Resend with proper formatting (git send-email)

 fs/ntfs3/fslog.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 1879d04e3cd05..373d84545a8fe 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3125,6 +3125,7 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 	u16 roff = le16_to_cpu(lrh->record_off);
 	u16 aoff = le16_to_cpu(lrh->attr_off);
 	u64 lco = 0;
+	u64 bmp_limit;
 	u64 cbo = (u64)le16_to_cpu(lrh->cluster_off) << SECTOR_SHIFT;
 	u64 tvo = le64_to_cpu(lrh->target_vcn) << sbi->cluster_bits;
 	u64 vbo = cbo + tvo;
@@ -3751,8 +3752,12 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 		off = le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
 		bits = le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);
 
-		if (cbo + (off + 7) / 8 > lco ||
-		    cbo + ((off + bits + 7) / 8) > lco) {
+		bmp_limit = attr->type == ATTR_ALLOC ?
+			min(cbo + (u64)le32_to_cpu(oe->bytes_per_index), lco) :
+			lco;
+
+		if (cbo + (off + 7) / 8 > bmp_limit ||
+		    cbo + ((off + bits + 7) / 8) > bmp_limit) {
 			goto dirty_vol;
 		}
 
@@ -3764,8 +3769,12 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 		off = le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
 		bits = le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);
 
-		if (cbo + (off + 7) / 8 > lco ||
-		    cbo + ((off + bits + 7) / 8) > lco) {
+		bmp_limit = attr->type == ATTR_ALLOC ?
+			min(cbo + (u64)le32_to_cpu(oe->bytes_per_index), lco) :
+			lco;
+
+		if (cbo + (off + 7) / 8 > bmp_limit ||
+		    cbo + ((off + bits + 7) / 8) > bmp_limit) {
 			goto dirty_vol;
 		}
 
-- 
2.43.0

