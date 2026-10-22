Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662934;
	b=2DKMhD2UUHmTURUbZoJPIvocEw8rI+TQhJD6/wgHGpM2Y+SbVhaQwx6l4CeTODfhGcDN
	 lXEznp/ShQwwkir3yVu2dCj/t7Fod49ar3A0Gsz5bWVFZQ/OVOMzx8uTzgRBRMVlToHK5
	 tW4yK0t2zx8CyOmz38GI4yT32GRk/gKyYFoWOl1Kq23QaQBqx4IHUCMt0wzulw5iqqkUU
	 jMWp3XigbBtzg30GSqZ0NLkfrZDwhjvgqAe9HaQ9nyc6g6RfmC0OGWO9hsKbu8ZeALQLg
	 FPADqPPPzFsC8LrKnDSb/3nDw5ehqIHQnf2EBVb4JTmHMPSlJs2P+aBlH6HpJpqNu5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ADNfvEfUAy3VqrghvrDeJq01T2uWMuvSDrh74f4EyQo=;
	b=gYuvbWdsLuHCyfz0brlmkILMTLMHZXsGchZB4crkvKNaHfs7ckwtP21AnG6lswGCLAoy
	 w8L84r/5uIViSfmNLolh092oOPZGqNh7qq8f4jZND/Wg2uJ6PVSUqs6nQpiiXjjtITTr8
	 daCKbFvuXsFKUWFCDbX8adnaqkL8emFKMYK9nc30aSXhZu+vogoy40MuCkN/eqJ2BGkUk
	 2uRBDdhWJR+SYG0mR5cyA689sXRdgfJDoRbHlO5uk5OrT+XPXJRiGKX07Np66kmFLMmMp
	 cIByGVJy8JwE+9wa6L6updMwMzBuf4ScsulX5WSMNLr07AAOJsScfPPouE+CSNlaXJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=phea+XLA;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CFC606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90CFC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=phea+XLA
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-354ba08cfd1so2854678eec.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792662933; x=1793267733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ADNfvEfUAy3VqrghvrDeJq01T2uWMuvSDrh74f4EyQo=;
        b=phea+XLAzXkdyM3bnFuvS59LbUUZoJ69K5CjUYm6xR4qIHVz1SIts52rSiDUlwJk7S
         VY+xaiF0PWZmi2qLrsC9aKMadIZ+tCPgKIuzRVzxTNWnWPoOn+yoPejMmA6Bn6OjmyBG
         rk6r3LdZclhp/pYRyFRzjtCxhxch8P+8ufKd4m3+BrD0hb1iYkOVBP4OZwiLRrGVXOyV
         IeedCqSCJiuOnG/yK1CA+BZrahzK1l9/Mhy/Wdhym1m7hwDiue0e00GJHzPC4nKX6k4I
         QcJMLdQNdBpe1czQ+o2UE34U7pyAC2BQuMG5QADiwk7kUamzbb7pGPRCHcg1JYik7R1A
         Y49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792662933; x=1793267733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ADNfvEfUAy3VqrghvrDeJq01T2uWMuvSDrh74f4EyQo=;
        b=CtOnvZNwsAybR2UbBZ4B2WkfLWkWaxesuEpm5juznA0QFUSbRlyezWTfBic7nE9dJH
         RXeskRE3GrGHav8+B3Yoskhw2r4fP0NJjem57kQX5h6IyHmuAXVoO8Z+cKnGTcTVNdw+
         wiSYR7w54bXlb5UGKa5wgSAtc7OjjbPmbfsIchLqaRI6o37HSNJs6vMEI7FpV8zuDo1y
         s7Tzv/HwNaqWHyX9QeIrJ8r5kx9aEHta1pj1rdoF5PbVhULCXV4IzfBPc4/HT6h13alK
         0NjQztJWEJYaK9YY6sEOuBt11l+Z6ZV4wGoTt280jNCUjkm0rHdn90nGxIgf/q85id2L
         wDcQ==
X-Gm-Message-State: AFq9FYL3at9glngvBLkGmZ+8VJ1/dFwR4ArVruT8sqaqc8URd3TiziTx
	YIJwvgXiGvbmvHKWkY2WAXJ3sQyvcrk0ekOfIUuy1JBYUKnc9NrGHvU9m1hGa/WoRBY=
X-Gm-Gg: AYBFou30stK9kZ32JsQVN45q5hfNp69/oazWMBKbZLifTjA3i5mxUIlvNxVpsZ1ysjI
	hw42gJpEbPID1sxMHbiSwPMEXlMm0RW+lxu+wVEbAoS/LLBK3KDN3Lw18T1Vcn5QoB4aHJRdL7s
	W8r/RIWPVLwq7mR3v4Deo/gSvIhZH1GHCTuX+ehnjOOEuy2niKqTo0HOe7tlObpZBSqCgNt98Vi
	2nO0EIzEfNWoMBC2YVyaJjjpUapdF0f+EhQyMVbCL6IzmAkKcWuoap2Mjs8pad4Fg+ZvXu0rZR6
	14MxhAG5ijaPBpngWphh1qVQ335E/Tdy8xa++kVdxDTNEtsEWSaRMrkeFy3djp6FFZhlutxFdsh
	lzXYXenfLAG/0o2A+ixghIBl+Wvva1Ysb5PLyhRpqmmI2mfOsxIXTfjwkmITGUFvBihNrnAkx0G
	K3cUY92yf6FSJ/WlOEk3vkoxqh9HpZ17kD0qgx4NUhPqn9r9uK8kGPE1rqsGIEaVlR1fKAMeQHJ
	xXA59NzRO7dhqIPmlij3Al8Bss/BK04oL6ZeojqU+OPFLH7+ISMpzbctSr2khfQTBoOx+8vqlGL
	ECxi
X-Received: by 2002:a05:7023:a4c:b0:17f:ed8f:d0e7 with SMTP id a92af1059eb24-190a632ef26mr5712904c88.27.1792662933495;
        Thu, 22 Oct 2026 02:55:33 -0700 (PDT)
Received: from HP-Pro-Tower.mioffice.cn ([43.224.245.243])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm12395962c88.3.2026.10.22.02.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:55:33 -0700 (PDT)
From: lizhijun3 <zhijunli.leo@gmail.com>
X-Google-Original-From: lizhijun3 <lizhijun3@xiaomi.com>
To: lizhijun3@xiaomi.com
Cc: stable@vger.kernel.org
Subject: [PATCH] f2fs: fix to roll back SIT update on segment allocation failure
Date: Thu, 22 Oct 2026 17:55:26 +0800
Message-ID: <20261022095526.1632980-1-lizhijun3@xiaomi.com>
X-Mailer: git-send-email 2.43.0
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

In f2fs_allocate_data_block(), SIT is updated before segment rotation
since SSR needs the latest valid block information:

	update_sit_entry(sbi, *new_blkaddr, 1);
	update_sit_entry(sbi, old_blkaddr, -1);

If the subsequent segment rotation (new_curseg(), change_curseg() or
get_atssr_segment()) fails, it jumps to out_err and clears *new_blkaddr,
however, it does not roll back the two SIT updates, so that SIT may
record that:

- the new block is valid even if no data was written to it;
- the old block is free even if a node still refers to it.

Not every failure stops the checkpoint. For example, change_curseg()
returns PTR_ERR() if f2fs_get_sum_folio() fails (e.g. -ENOMEM), and this
path does not call f2fs_stop_checkpoint(), so the filesystem keeps
running. A later checkpoint can then persist the inconsistent SIT, and
the old block may be reallocated while being referenced, causing data
corruption. The same stale SIT state can also be exposed when pinned
allocation returns -EAGAIN and the caller retries the allocation.

Fix it by tracking whether SIT was updated and rolling back the two
update_sit_entry() calls in the error path.

Fixes: 7d009e048d7c ("f2fs: fix to handle segment allocation failure correctly")
Cc: stable@vger.kernel.org
Signed-off-by: lizhijun3 <lizhijun3@xiaomi.com>
---
 fs/f2fs/segment.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 63b712d3d599..033a3b8bf426 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3908,6 +3908,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct folio *folio,
 	bool from_gc = (type == CURSEG_ALL_DATA_ATGC);
 	struct seg_entry *se = NULL;
 	bool segment_full = false;
+	bool sit_updated = false;
 	int ret = 0;
 
 	f2fs_down_read(&SM_I(sbi)->curseg_lock);
@@ -3958,6 +3959,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct folio *folio,
 	 */
 	update_sit_entry(sbi, *new_blkaddr, 1);
 	update_sit_entry(sbi, old_blkaddr, -1);
+	sit_updated = true;
 
 	/*
 	 * If the current segment is full, flush it out and replace it with a
@@ -4027,6 +4029,14 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct folio *folio,
 	return 0;
 
 out_err:
+	/*
+	 * SIT is updated before segment rotation for SSR. Roll it back if
+	 * segment rotation fails.
+	 */
+	if (sit_updated) {
+		update_sit_entry(sbi, *new_blkaddr, -1);
+		update_sit_entry(sbi, old_blkaddr, 1);
+	}
 	*new_blkaddr = NULL_ADDR;
 	up_write(&sit_i->sentry_lock);
 	mutex_unlock(&curseg->curseg_mutex);
