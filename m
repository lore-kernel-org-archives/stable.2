Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237822;
	b=m/YClht0UhiMc+tHZojvzhMvHdZ0arbpp2IkWU3vo/m1I01h9EdgfNmayt+FHlPFqS3o
	 Vs1H0QEc4jjPVfhTpCx4VEzZs8eAppIMUA6eg9TikUQSNlPziV3yVQkX6aspSShQ3i0SX
	 vvd+q0BGZ3UK+3RH604HnGMj+otvlAoKnqB96zbVQFAPY50Fohx6S6RTFjyWyvKqNrVsK
	 t1L9sp3lV3P425z1aFrNjhjtGS9C82lWps7j4oIJDiPLyP3lzR0+v/9biXEDZMUw9hhrd
	 HbCfQpcfMqWcbcRs2QV3aA6M0ZTu++JB6SOrr3kvUT7QORRtRmeAq6LkbK3my2JGYPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ua8SQNKQwB97ZvUclO9jwABs5jUpf1CScj/ICI+TFtE=;
	b=jwT0esX4cnLQqU389pOONzzI7M6ZqJIaVqLT+xmhD+Z81X0wmpjUgFV3yxrF8vL87n4E
	 04nPkbA46vW1y4cNhB7gGGk6Xv73YrJc3GTOij01Ed69pHhU3X+cCtM2IUKTAZMd3APeW
	 CO5q4hY3zI9bsLpLKHUQ2v47IRmV+XI/iV38jg0R+NFYeFjjk35U+hsuV42G3BeH7kBeO
	 QjjDyhMb4LuqlydIqHPMrv+v4a4r1kC1qSwum1OApnKPuFY3GD4yW98TNCkOux/neSYaP
	 xWKupP+VZE6Bf+PSO8eoZvHN11mJAPu5vFn+nlAj2NJthuvVOWywt875PlJusFgzSiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ljxymD1y;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06546606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 01:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06546606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ljxymD1y
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36758ba1f01so669358eec.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793237821; x=1793842621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ua8SQNKQwB97ZvUclO9jwABs5jUpf1CScj/ICI+TFtE=;
        b=ljxymD1yStlqh6UJL44Vm0LIUAMqUQpeczGCuSfhhUREG/090EFtuULUqgQiIdCFuu
         ToXBRnPYvGky+gOlk5Tal9qXHxc2c5UqR1KadnWFLM8wDtF+h0JrvmIy5Si9OHBB0rrl
         /nkw4c17Ev85zYKOCFzG1zb11MEEGSWHYI2AS97XieBeQGh1GyYtgnf3x4L5iW4r2odG
         vgPdbUhBdKVqthVCAj/Xh1l3Z8EJnwFBsYHXR5ztEDYDfl19SGNxmYUtvQNHM9MkBKlV
         3IaiHtu8nNUaAacdik4p/w04P2JPhnI1hhmq974BDKcZ7qx2OvOaNrQS3Ce37KPbp2/K
         eDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793237821; x=1793842621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ua8SQNKQwB97ZvUclO9jwABs5jUpf1CScj/ICI+TFtE=;
        b=RJwKjgaY2ka/KE+xnPT0YK0mofk9b16UvXYIRB1e6M6pyA1yKLMPtXXJqGr+r1Mgx+
         nZJELWBIImBKM0JlYdjzVc6G9D+8hjQoVeRnoJ2kpmebCmTa9xc2Hn5zVaF9+nPCLfsN
         RTioSf2Y2R3EpP/nkkHie5bYATJ/Z9az83tspBohSH3CahuCafGE/Hk6arkn4JbFDTuR
         q5Zg8ZR9wxpk3BU0q0dc2+y20Rw6CvwCPMMlmf/bBoKNqS4UeOOLT+Y5ZcoNY47TbH33
         m3qAbqf98uXWwle9NUIIjk9eiYa6DREjBqCT5Z3QtUqbZGxsc8Tk0aLMOkE4OFsXHjYm
         v/5g==
X-Forwarded-Encrypted: i=1; AKwUvBzOoMtGTQK0KCRoq4jC0xoBcDGcWL/6g2werp8iGXyqwybZAnaDoUr+C2xbnjpoRLw/q1vNRqg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFKIpPLSb9fESU5Id0NNd6W0rWHYAwbH8iynM66KB81mzE85Dj
	w9GxmxbXBahUWZW88y3OwzbjdA5HSepKmjTxnwXaQMoAxZv8I1FRFp5m
X-Gm-Gg: AYBFou1NMX99MmxdBKh4g1E+V+IKkuiYWojO3AyKLypbCL5880usuVu+ATRyWFqSqoC
	UoKeUg89lCgokviWp06Eai7IkLraC69m+Asg3TUF39nWxdWNrDCRY7gWgq1JUdUuFBuv2TaRa6O
	Y0bIDb2U48zzmjiPXHF77B2U4bv6VYmw8eZzxtN9LCwDdgWtWk98FWfJ5888jx5jF9pbwYcMRtY
	4vmQC8CxvsacswEWIVzJTt8uKK/FPPF0ZrM5x8tCpux98D4zn6smkBUBSS64gmrCDEkXhFAAAo6
	XvOKvfRBD4SQf74YCLQPz76+WKI2lUTMw9DJK6JRe2n9B4YsA29Xut82+M1KXwXZ/dbIcZ7W/sl
	94h2NSRVM57g9SIdew8fAXgPPkIdYD8cx5EJgrewwMeWW2qaaniOhsgE+xXScDMtcF3z5WOBkSp
	F8IQ3BEMR6LJ13v7h+4I+07ZkUPE0m7BvKHzK0zdX3nnme84i5S6s9ThOeHFXN1bzC6axnBp/Vi
	l+uj6vne6tZTimJ6PQqSmHH9PyP4E/ezmz+aVfIzZiJ4Wvl5+5S5yxSsdYGltwfTDxWVIjtAuz2
	krAZ2WZIsFWsQhWObe2i/K/11QNZNbkeeNDuaRMhex6xA184UyO0NMa+
X-Received: by 2002:a05:7301:4d02:b0:369:a113:756f with SMTP id 5a478bee46e88-36a2046736emr5333281eec.34.1793237820781;
        Wed, 28 Oct 2026 18:37:00 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239198c9sm11307097eec.15.2026.10.28.18.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:37:00 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jack@suse.com
Cc: ritesh.list@gmail.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] ext2: preserve IOMAP_F_DIRTY for extending direct writes
Date: Thu, 29 Oct 2026 01:36:16 +0000
Message-ID: <20261029013616.97194-1-dennylin0707@gmail.com>
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

ext2_iomap_begin() sets IOMAP_F_DIRTY for writes that may extend i_size,
but clears the flag after ext2_get_blocks(). When the write uses an
existing mapped block, iomap can then use FUA and skip
generic_write_sync(), even though ext2_dio_write_end_io() updates the
inode size. An O_DSYNC write can therefore return without persisting
the new size.

For example, on a FUA-capable device, a 512-byte O_DIRECT|O_DSYNC write
at offset 512 into a fsynced one-byte file returns successfully and
extends the in-memory size to 1024, while an immediate read of the
on-disk inode still shows size 1. An explicit fsync persists the new
size.

Initialize iomap->flags before setting IOMAP_F_DIRTY so that the flag
survives and the required metadata synchronization takes place.

Fixes: fb5de4358e1a ("ext2: Move direct-io to use iomap")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/ext2/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 12ac4cfe1500..ba23cadb157b 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -805,6 +805,7 @@ static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	    (first_block << blkbits) < i_size_read(inode))
 		create = 0;
 
+	iomap->flags = 0;
 	/*
 	 * Writes that span EOF might trigger an IO size update on completion,
 	 * so consider them to be dirty for the purposes of O_DSYNC even if
@@ -818,7 +819,6 @@ static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (ret < 0)
 		return ret;
 
-	iomap->flags = 0;
 	iomap->offset = (u64)first_block << blkbits;
 	iomap->bdev = inode->i_sb->s_bdev;
 
-- 
2.43.0

