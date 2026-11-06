Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964486;
	b=ZM1ramDpdzM8m0D8WCKF7/SgGLRuUfAVe1DVVdx7jNRqVAZcJi2KAI+2es5w1wCeVNEZ
	 W52uTeD+OcNt34nhZJAMmj3GX+C12rPFrSRc2tjoxFvRsEAI0GXAJKwwvbEdvqGaat7Ux
	 +2cl6B2ZcDo+0V/QXk1XAq4m3p44riQAHtQ+nTiCm/V8doVf8Nq8zP/ngEAUUQSW7ZU2o
	 8x3GrJYJPqGJn+l0gEGYUdewzcwyLWiarolc7V8xq3CVBQcb/WL14NpEtmpfnTPvtNsA5
	 UCVlHuu+SmWKUB914hx2FLMHBfyRQE4hl88xp7c76/C32DKUX9KSp/x/TLvECSBB2Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r0oGiXSXqPWt2ut4NcPnn3BOhuEor59O/W/UHXN5XZI=;
	b=0k0MKUXrUkwmb8GxGXrTdIB065SMnKlNE/vLasu35jMClWkbAOy984V2jFJdGihYpsqC
	 oqGhyjihK7P9OWyCdxOOeXdq3wY+3w8DgDVwWIuTAKDu9Cr8hWPvp4WQ71EwyGRPxOtgE
	 Hd9BPbCEaqsdD08kim2R8Q/J9eEX+kTHtdEv4qxnQ15zzgMpxltH95AIgpR60j/rvxZh1
	 Aamj9ANZ/ZbltwLDhD4axmkuOKJrD2Dpu9S79YvkRzcj8n0BpuSl6NDKjxjwdpV0T4Sdi
	 lHtpmzMOyDiSV9YPiA4tmGavkcMFB4BKjLO5X0OqLuKi7/Pbz69BrTqoED25jSSdxUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yYrmpEaU;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B2606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 11:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D6B2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yYrmpEaU
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-37071c0f42aso19137eec.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 03:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793964485; x=1794569285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r0oGiXSXqPWt2ut4NcPnn3BOhuEor59O/W/UHXN5XZI=;
        b=yYrmpEaUTpqnUwnwHY2dg/7LWr5quEGHTcAHtu+t0+dKBO2ED3lkqX2Ji5fGVogG2H
         02utr/jvturPRR4egvfNpGfo+0wHmSxRbihnbQsE6CWlvs3m+MqRJEEL891fqFjDsEjP
         rs9H/PG+8DCmcrE6rS6G1DdmzlNsFnD81vt4A+zAXeGL6JklYk4BewC4h7u+RaBArwvL
         wc8Timc7qPxRzZ9v35ZRW6aulnwMuf9XyC0nsG4KtSTPs+dT/zScMH5iADKMEMZYceL9
         ee6jB/ZX62j/NErthqK5j2Ni8WBpWq363LNWSJmZTeaWwf74v4Ow1x1JuiVTBAqgNWn8
         8Cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793964485; x=1794569285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r0oGiXSXqPWt2ut4NcPnn3BOhuEor59O/W/UHXN5XZI=;
        b=BojW5q4EiGJ2XL4x8M8f1wK1dayXuPj5VxFJ5mWbs7Q//8UENNQb7AdJ2XBrWJYYqN
         VBnA97OMsAdzlq5EEIsJVgrUGnEnvh1y15MNNU7MPEjWmj0iykZVaqVzNlznwvTiC8MF
         vtVBJL0nMC5I4rK5PW9kIUr1IhecVd17bptYjakUoFGqv6OxTIeQrykq7TbE68srGB26
         +Pqutpu4pXWM5erBb3OQv74k4d9gMZ0C3GLDrvXwknkbRsl+qE4iIaquJ/TZBLby9Jt1
         w6N9d0xVgKIPL45eAqhd197KEsmLOQmtXOZtbBzFOpgR/zPQfNbKTkWmrK+k89urulg+
         AOZw==
X-Forwarded-Encrypted: i=1; AL+hErE2U9YnLs2xylBkfxvHHE3q0ayU0EEALZQq2DwJmQWpHFvNpoCZGxJyIU760EzDLnPr/kqGoY4=@vger.kernel.org
X-Gm-Message-State: APuU4Z89uYzlUBcxlBa2qTwrdtEpMgNAmu0HKqyobSHUpMpM9KlAz32v
	tJZSL5Lva6jeDmz4XLwVxjh0ASqTHFzObCOZQluJshjUh+tbZC1VNpXS
X-Gm-Gg: AYBFou0++KtGNYI86ksjbo2GpLvd7FhmFFFBhOnyKxqPdaSQJX9iPaE1ysS2JJ22b19
	nbjppE021HpMiM0B1UVBnkjeLZBRKK6H8UrO2S9SKtn1Go5d2Gk4JYtLbfILIc4prCayjs9Nx6h
	9xVUJV5RfpnwaYcvXd1axAuB4izCS4h4RPPwR/NTD/N1LH6kZDd0aZ2fPQ4niguAi9VAHQJzq5+
	PinumkTclcEM+fznXGdjwC39FJuJMiQHK54VXBccIwGpKrPGn6rI0jjtVNKFatrta/FVS9RIcK9
	bIq3u/48y7Q12n8eBvv4xjG1pMWDrWDXfaVL3vX7Diw5mon2TH67jNVbthAsf3OmVEdXm7r3E9Y
	UVl3EKCdHrbcamRnFE93aA85etWha9Rx7RhQbkPNmKlqVYKj0rlxuVwmeuTA7e4+HaPc0dC2adB
	MdwXkEfK6C4IVXNgYSAKm7XzbQZGFxOOoPOaTEpKfQOUtX8G6YrKykr8RAmNC6bncZGLC98POEj
	ptiNuImvmXFLM5SdS+KbqlD5FyomOiAWvsGFiUane5DxBvpRZ3dGe2sIQ2LIhCljUWpdgFtqRHm
	nra+Hv9gHimo5NWl1s8dt0XwqenvZ36nXIFlMY6OdtOU7MAW0OkWQBMunW9op5oHHw==
X-Received: by 2002:a05:7301:4d08:b0:36c:a154:db1d with SMTP id 5a478bee46e88-36f722eabcbmr2881866eec.4.1793964484814;
        Fri, 06 Nov 2026 03:28:04 -0800 (PST)
Received: from anon-laptop ([103.187.196.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa4b8aacsm6029179eec.23.2026.11.06.03.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:28:04 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: check the file name against the key length of an index entry
Date: Fri,  6 Nov 2026 16:57:52 +0530
Message-ID: <20261106112752.2552832-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
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

ntfs_index_entry_inconsistent() checks that the file name of a
$FILE_NAME key fits in the index entry. It does not check that the name
fits in the key, which is what key_length describes. Code that works on
the key alone relies on that.

ntfs_readdir() copies key_length bytes of the key of the next entry to
resume the enumeration, and later uses the copy to search the index. If
file_name_length is larger than the key holds, the name comparison reads
past the copy:

  BUG: KASAN: slab-out-of-bounds in ntfs_file_compare_values+0x2d1/0x4b0
  Read of size 2 at addr ffff88800a4ef2ce by task init/1
   ntfs_file_compare_values
   ntfs_collate
   ntfs_ie_lookup
   ntfs_index_lookup
   ntfs_readdir
   iterate_dir
  Allocated by task 1:
   kmemdup_noprof
   ntfs_readdir
  The buggy address is located 0 bytes to the right of
  allocated 78-byte region

Two bytes of an image from mkntfs are enough: in an entry whose name has
six characters (key_length 78), change file_name_length from 6 to 7, so
the key claims 80 bytes. The entry itself is 96 bytes, so the existing
check lets it pass. The next readdir of the directory reads the extra
bytes.

Check the name against key_length, and check that the key is large
enough to hold file_name_length in the first place.

Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
This is independent of the three-patch series I sent earlier today:
https://lore.kernel.org/all/20261106091420.2461683-1-wahidzk0091@gmail.com/

It touches the lines just above the "return -EIO" that
"[PATCH v5 19/31] ntfs: report index validation and block I/O errors"
changes to -EFSCORRUPTED, so one of the two needs a one-line rebase. I am
happy to do it on whichever lands first.

 fs/ntfs/index.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 322cb371d..1abca298a 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -43,9 +43,11 @@ static int ntfs_index_entry_inconsistent(const struct ntfs_volume *vol,
 
 	} else {
 		if (collation_rule == COLLATION_FILE_NAME) {
-			if ((offsetof(struct index_entry, key.file_name.file_name) +
-			     ie->key.file_name.file_name_length	* sizeof(__le16)) >
-					le16_to_cpu(ie->length)) {
+			if (le16_to_cpu(ie->key_length) <
+			    offsetof(struct file_name_attr, file_name) ||
+			    (offsetof(struct file_name_attr, file_name) +
+			     ie->key.file_name.file_name_length * sizeof(__le16)) >
+					le16_to_cpu(ie->key_length)) {
 				ntfs_error(vol->sb,
 					"File name overflow from index entry in inode %lld\n",
 					(long long)inum);
-- 
2.53.0

