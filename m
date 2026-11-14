Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794630943;
	b=Omx8eE2hK9AA/BqxzcM1f+7oJMZSih0TqgAxeEMecUppowqsodTHFSaLGaWZrnAEV/Mg
	 ck0Ed4MMcq53GXrTAL1Ox2kGkDmrtVjl4j+MsdsnRPvp4V5pVUkO3NrKpnfbEa4lJ+nvD
	 i28Z8kwjVqmsCe0D2zG2UyAZrxMoOj9k7ZewiGIGks6LLcUWsMgZH4H7xeGRhBc9OAdEN
	 0xTXOR5Q7xxGOfGwx/VK0Yyo+o4Yk1uAxg3+/kqi5XlKTQn+lGSMDFHdG4296HUkJrhnj
	 ToLtE3XhHI6kmFKlJBuFTZnHVxk0dWZkEez/1UGIhyY6VqeARk6ZTRiiyGhVQnj80hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794630943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UU1PVy+t0ft+3E+0Qc94jUs2EjiskHrBXbsDGPqWZls=;
	b=v6lrQVA4C47qex7gbTLxFiVqhn/LQ67Nn29PrmBnR3CFbxAzm9tq4Xtqo9JcRnuAp07m
	 aRJPDeE2Uhs1LddLQ5QJupXcIWhPaWrf+kmNXLo2aUfzG8ixxJgt/Xi6TJo1VSEq7yJ8C
	 E1cykYHXX6lm5XFGy58D5Kcc4Zhl9Ov/8wuuNaecd0JZLefFOUpbAKGfbtfBmbwQ7mDQG
	 /YZBPa/MXvo77OJLbozjKWr+xXaB4bO1A+jY5honjmPRQRu0HYw0KFdW81O8+AdO1FEFI
	 qvYsxmM5rjlDITKqC50UCBu7fd0lC04+H0/l0Q7ET9L6EJgiTFN38X4WeNgoae3SIrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcUKM2dJ;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6819A606A339
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6819A606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcUKM2dJ
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15ea896ddc8so2343386c88.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794630942; x=1795235742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UU1PVy+t0ft+3E+0Qc94jUs2EjiskHrBXbsDGPqWZls=;
        b=qcUKM2dJY+hVn7ZYZN8ifpz+9VYU7Z/gJE7VN33MuMkDOFME7v//gFnu/X7cmdXxOL
         m3bsuQnBFNmE+8narU/7oX0ZQY3zT/67SXywHGW7HG/896aSHHarSAz/wTfzkcRvYgE4
         iUhQxMZVbcrJVebkID0ctja/eL2+ZuKhmcLNEpEBI593uCtMkn5d3c/0l+yO3FflPq0X
         FcIaTrg3gk1mkr2EVoQDrkh6yM6tfTQM/4HGtp6Qe162xbf71j053I5gLPG7Wo1iNYOd
         oANEuyhbhbctujjPuaDNMp4bcq/WXuJ8d3RhQ5FC7oFenBegwmmqMOKFBMEXDM9smEIu
         XI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794630942; x=1795235742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UU1PVy+t0ft+3E+0Qc94jUs2EjiskHrBXbsDGPqWZls=;
        b=21xXvVXFWPuJ47k6SXgIcW6dzcr3zA6DSLUbjUnrtEC+LgYTPVqvwF4CfJgPJlX3if
         XIA4ZFy+rFjYUNicRaRicwb8r7c8eqyYFwgbsHgQVY3LN71qWAPhqhx7OoU7yahQ6jgy
         sl5M7m64tBCntQ5uhSdWYJBUThMorj/zQLHRmdvIsKn4RWsKFOPMNF8f0v8907zUcCDp
         wKJCx4iLCKk4VOoQcmrFeQBkbxQiaPXl4igogGFqpzua7GIJtFiJ3mnEaKEBl204ba7t
         N3rvfMPEh+L6M47b92lGMC7G2XomBfx3TjLm9dCTTyu14HR9cJtlN7wrRgMMdStN/ooi
         fK1g==
X-Forwarded-Encrypted: i=1; AL+hErFFGDK5vhYupAk25XZ5uXcEGtoru1OFZpHgEmAHcBr28DejSuBColy6x6PQpid8F8zqKqde7bE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9onbq7dWFDmuaZXX1Vy2iEXBYQnpUiRKRGXUKIo92NQgyP7xCc
	as3WY82YCdW8HZ5jkjH4563UlNgFkb3tMmIc9NPYUJY5g/G95etmMZfb
X-Gm-Gg: AYBFou2duSxk7k/kGX8ugWrfkRAAZWBzEbxXZ+QFcFMh89XABeNKNiRRKtfIiko8Yji
	ykGiG3ZF2rFPBJUQBfloeDhy3OG+2lQZfJHAV/rTo1B08AqczkS25/vyIsYSIoPoSHTB1jof22v
	HiUehv4idSAFBXs0eLScRwfZN28mpyw2HRhyJ+EgfTPYe9EQZLUyFGIHvly9c9z9MF4R8dJNJSu
	Eb9DIgEq9r8r5T3CmEPSrnJ+t+TqIbomXPHYViZQQaBUUFxTLQ+R2in6FDoIIpbRqLU8HxvL3Tn
	Pgrjho2stgdLszyWkQuEwZ2BeFtLZsCWU2B1s6wjJsnAdeeWptPvA9annp99AkZqDpvtY4bG41Q
	SF8MjShaWsET2MKaxPOmUfuqxWq36c9RYAlMncS++hfDJ67tVoqD+9w3b0HdRs3iclLX8tbZ+wi
	Fj0Hlky0Kjio4EcAUER0p5iphTwKqV45WCBCr1zW8ctjlBBPUpBrC0RIFoNwlb8Qnb+SKIax0Gc
	KsZSKsLn6HyKGUD2+glQWRnYPLt1DAJI7esgIG4qoF5sZIYuhoYzKA9uroab6GX7A/9LWJrvtye
	3GgZDWd1JzPIW45SKQFE2WVfHQ+jKDfeixGRPE4YxjDRnC41EMyQlLRInLJXuJVZBeGxwTTako9
	eQQzDoQzWFXYAf7LWUo1E80RBs5U=
X-Received: by 2002:a05:7301:4604:b0:36a:532e:4abe with SMTP id 5a478bee46e88-379681c9ee0mr4421901eec.35.1794630942458;
        Fri, 13 Nov 2026 20:35:42 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:796f:2855:533:1bb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955f02ff0sm11744106eec.16.2026.11.13.20.35.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 20:35:42 -0800 (PST)
From: ozgun kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	ozgun kultekin <ozgunkultekin@gmail.com>,
	Guikun Yang <yangguikun19@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] hfs: bound btree keys by the tree's max_key_len in hfs_bnode_read_key()
Date: Fri, 13 Nov 2026 20:35:22 -0800
Message-ID: <20261114043522.48764-2-ozgunkultekin@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114043522.48764-1-ozgunkultekin@gmail.com>
References: <20261114043522.48764-1-ozgunkultekin@gmail.com>
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

The classic HFS variant of the same bug: hfs_bnode_read_key() accepts
an on-disk key length up to sizeof(hfs_btree_key), while the key buffers
from hfs_find_init() hold tree->max_key_len + 2 bytes (18 bytes in total
for the extents tree). Bound the length by the tree's maximum and clear
only the buffer's own size on error.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: bb5e07cb9277 ("hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key")
Reported-by: Guikun Yang <yangguikun19@qq.com>
Closes: https://lore.kernel.org/all/tencent_F85118A9AFDF9B230D4E8FA672510A3E2F08@qq.com/
Cc: stable@vger.kernel.org
Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
---
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index fcb5b9c..f678eed 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -83,8 +83,9 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
 	else
 		key_len = tree->max_key_len + 1;
 
-	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
-		memset(key, 0, sizeof(hfs_btree_key));
+	/* hfs_find_init() sizes each key buffer as tree->max_key_len + 2 */
+	if (key_len > tree->max_key_len + 1 || key_len < 1) {
+		memset(key, 0, tree->max_key_len + 2);
 		pr_err("hfs: Invalid key length: %u\n", key_len);
 		return;
 	}
--
2.47.0
