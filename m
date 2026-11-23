Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415098;
	b=yOYLUmWdwpub4hkxqdGaYt9PdveRopOetz6JDgIxjbikFcKLlhNiFRqJ85wm/mQidwFG
	 yU9ReM1IRy0ZpuNfOFKN+ckUOOnaHr26g75+AtfGvbNagL1buPrMghVptXITz2nYmjFvG
	 F/LGXEf+1xVQsfxaZgxuPMLve0jhq5/NDKc69jB1vCqQhD+KeQrbwmPU2wSVLTFFGQFCa
	 3FRpgINtbcrrAtqH9ILpSudklRUoDoV6ZUNwFRq0UTX2kLntLA8/Bw6PduvasKbVnyknR
	 DmzujqQf24Dw6xFpPjwGqZMVWl8GC80535bTCzdVNU6+E1SN7CjCmZH/tMD2X/nRWCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dFdEqFiacjVlyhuruK5DmKXl2N1tqCNj7wsKhuFYg58=;
	b=SLBahdT5juXx3Nj1x6xe775NfDltyIHzPw8f3LAmfQyxJnDxnNDKhCN8TbqE9clwPsEC
	 Dj8dpHTALcI+Vkksa3YlcNWFvDCESZrWC5l2x8sQe47nD+cC1CCE9F/mrM/HroKFSI+l2
	 Pwvz/B4MRrJRSyYDILKI1IeyyZpFDGszkvbhfLCXIyHK/D6pN0pslsuqKf7GEb+/yxkdR
	 nq7Zco0Mpz9j4mK0cvk3KTQTMlvxTP5W+gbXfiWg3JpMePkY/YnG2pCRFOO4gPOM4ilDL
	 041/pYqSPsQ/fEmslFl3jOWrshlQ+xaCRrDJ/awXlbAFkxA38KW41YujW8vY0yGFHlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kksPxDBi;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F222606A339
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F222606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kksPxDBi
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-386ab9ab619so1556190eec.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 22:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795415097; x=1796019897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dFdEqFiacjVlyhuruK5DmKXl2N1tqCNj7wsKhuFYg58=;
        b=kksPxDBi+60aFba/GVGkbKoJN+BgFq9Pr8CxCZ/hZl8TA/LSo7BXAUdz9fyoiffaUu
         eCqULUQ9WT3ewKO72r/ilWpnchOrnN1Fov0O8spI3teFCKHroOmUzmqixFfW5bIgmS/q
         8P0Xhqdp1KlI+SRjSXRsujFbglZtjcIG3JfCz7sqAC77e10+YNs/VXlzgAgr42iaGlcx
         iRFeBHYkNCU7z5J0SDTTQTRfgy3TLOOY9EQxFzwNtbqWEH/UgoIU4yryYGiyf+iwBfGI
         XpXOzHMuG/TYXSx6gXXNtUyLhG4iXujQcPnoaMPFJ6iGazaZnEnRBgXnxXm/9wSdk7La
         ZOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795415097; x=1796019897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dFdEqFiacjVlyhuruK5DmKXl2N1tqCNj7wsKhuFYg58=;
        b=bR/U4trFwjmXB2hSZMELb/lvLC3JseFeV51EMdolH7j/Xk0P2wGbsGkUNSPsBVxBHr
         ynEDbadrPLlBBmx0fDaJAw4KRSFr2/4Tcp7Oe5JeGWkErF1a+Ct9s0c3oU8wTs15N6py
         ezd8XilQK9WU5z6KgvIdICx2EEy0kE7x5zUXZkk+Alqc0ptveTxaHss8Lib9XTDRAWEq
         OPfIxJ3IJlF3cmd5dOhE4PNLHwu0GN+PBsM+WbgsecplbJxQccfM8Ou/6z7IopbZLYcD
         sflt/Z2H8RdVtk5/cD47RppPbadiK4VBilwwVkbsmHU2pdfo5C6EPlC1UebvsusjJrSQ
         9ynQ==
X-Forwarded-Encrypted: i=1; AL+hErHgCVeKvWzeGnShY0G5IMBOOKimpvWKixE6GwHV+3XoVBNTejvIAkmUF7HxGllaeoltmedODFA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9GvdQ/4mw1id2/O8VCKzDd8mhJ4wabhdywjm40UCGSNA7exAV
	pwKpLViArE4m159fwuRw6//MrCH9FqrG1NN1v8Sje32Z0nC9XyhmdtPT
X-Gm-Gg: AZFdTZfeTeuRTespiyeKid/Gwbp1NGO9dtbPoIaELn141CYIB2AQkTty4/NZKuASCwv
	QqbBF3gXpj49h7bgVRoKfMBLDxCes6PxwgKj7CFMVm0szzyuYuDKlM022IXcmcx6QlqBIVwWfRP
	xILo8hfrm9WNDpPK7Fva5n5H8WuF7F6Ot2VfoqmqNXwBpRBekOcAfdPkKkmgRloZ3f+YlI8TLGc
	A1aKU2YsbTwB9PvPxhDV2YO35sOzSm/CH3LM+e8zc/NlLnHptHYCbK/f0Zk1PS88lB+MDp/4bsv
	Sn5MTI/9of5N+NDbXdUNHGAz7zcy1Qy2B1IvukGFT3dK0yLQEU+0CW+FUOQfUNfb3kZ5/JHLTuh
	OA9BBwsDHeBaStGjVwC9Uml7du8JV2VreKe1x7l5s+BJ67RYfTpJEykTfcin+A+SKHjc5IA+YRl
	C/WmXOolwa8RxtFGNnWQDrNMrEhVzVuFY7GZPxvPxyjDUveT9eFCitxRU5sXDQT7W+MoWSxL9IE
	oY/cofb4ZknYrPz64MUMr954YyoRcR8N9bzhWsNz+Sq4BPQKkNV4klja3UDa2zuXv72S08TC7/d
	6EOY+zXaW0p0b9ycZR6ID3+UOjwwjSPAORzaQdV2zXkZRntwlWzD13ppxgHW8n5m+voqyFnMzkI
	YMJ1ZVkEd+dJxQQXZQg==
X-Received: by 2002:a05:7301:6405:b0:381:a3bb:f945 with SMTP id 5a478bee46e88-38570254ec3mr12905314eec.22.1795415097415;
        Sun, 22 Nov 2026 22:24:57 -0800 (PST)
Received: from ip-192-168-31-150.ap-south-1.compute.internal ([2409:40d2:2009:6412:a5f6:d81:c3c7:7d8b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm55987369eec.3.2026.11.22.22.24.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 22:24:56 -0800 (PST)
From: Tanuj Sharma <ertanuj96@gmail.com>
To: ntfs3@lists.linux.dev
Cc: almaz.alexandrovich@paragon-software.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Tanuj Sharma <ertanuj96@gmail.com>
Subject: [PATCH v4] ntfs3: fix out-of-bounds write in do_action() bitmap operations
Date: Mon, 23 Nov 2026 11:54:50 +0530
Message-ID: <20261123062450.5153-1-ertanuj96@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <2026112152-delivery-synopsis-ada7@gregkh>
References: <2026112152-delivery-synopsis-ada7@gregkh>
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
Changes in v4:
  - Removed unnecessary braces around single goto statements
 fs/ntfs3/fslog.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 1879d04e3cd05..0f83e4e8dbb9d 100644
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
@@ -3751,10 +3752,13 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 		off = le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
 		bits = le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);
 
-		if (cbo + (off + 7) / 8 > lco ||
-		    cbo + ((off + bits + 7) / 8) > lco) {
+		bmp_limit = attr->type == ATTR_ALLOC ?
+			min(cbo + (u64)le32_to_cpu(oe->bytes_per_index), lco) :
+			lco;
+
+		if (cbo + (off + 7) / 8 > bmp_limit ||
+		    cbo + ((off + bits + 7) / 8) > bmp_limit)
 			goto dirty_vol;
-		}
 
 		ntfs_bitmap_set_le(Add2Ptr(buffer_le, roff), off, bits);
 		a_dirty = true;
@@ -3764,10 +3768,13 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 		off = le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
 		bits = le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);
 
-		if (cbo + (off + 7) / 8 > lco ||
-		    cbo + ((off + bits + 7) / 8) > lco) {
+		bmp_limit = attr->type == ATTR_ALLOC ?
+			min(cbo + (u64)le32_to_cpu(oe->bytes_per_index), lco) :
+			lco;
+
+		if (cbo + (off + 7) / 8 > bmp_limit ||
+		    cbo + ((off + bits + 7) / 8) > bmp_limit)
 			goto dirty_vol;
-		}
 
 		ntfs_bitmap_clear_le(Add2Ptr(buffer_le, roff), off, bits);
 		a_dirty = true;
-- 
2.43.0

