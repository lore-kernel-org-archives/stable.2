Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518A135C181
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784973523; cv=none; b=NS6yz6GtWGgLRx3ayMIwtGRbr5sysFVyQ/Ub8OylHhIcYOy7cK1gBpU/qxQm9Ti4xY5OotFuPL1TxrSdaFsjAWRoa5pgNTQVO4Z0KGOVhhuMK9oL5wRnEaDbHOjB7pQp8ZVGebAeHClUY+ZiS4F6fU3j31ayDgh9u/iRVaCP4gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784973523; c=relaxed/simple;
	bh=u7XQd2TfJpmUZ4/0INvX1YpM88/6PuaaQnnv2Z3v1+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QlYWPYfqqbJKPJlsR5dYCB5WSFaKHC1FbG0MJitczU/BtQORp2GYjdJcR2gS1IQfUUvfn/5TlxW4/60sHER2AuScZt1spUyMkPORsuhX06yfeLFNV9RalatiDVKN98vJa3zC886iOKQ3oK3s7J7uuXlO8YHNn+LE8CQSqj1hbHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0AFxKqv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0AFxKqv"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ccf2360620so11905815ad.3
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 02:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784973520; x=1785578320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=10/FtAKu/P+lQSPQnjuP1JGyinhYTQiEXMNlosaGt6Y=;
        b=K0AFxKqvSpwT3mCcclPMgCtPrIj9Z6c6bFTv5j4TCVNWh+8uh26He+oGwXfy0yNXNi
         oHlQIZdHp2AuisWWpkzClE4Ny7jeMeG6sKzpM0uHBlNb1oN8nKhcv8Sx1wtIXm/AMuoL
         SKA/a/iNZkQ8MzDuK1gSJuo71bwHKF5WmNJxPUUxb29iWvxb7cqLAN/49gk/olA7ADrU
         JaviUtgrYqXD3LyqIIkNVP26NQuF7Y8v23JSO92UDA32S3LaL4wmbRxkN22DAKRAUWjD
         MrL/atqlZvD9GvN7vHouRE+zQJg0YjUmWaj68aMNr1RCfgkk/AOXOniMsWTAvcxAenJO
         kfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784973520; x=1785578320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=10/FtAKu/P+lQSPQnjuP1JGyinhYTQiEXMNlosaGt6Y=;
        b=RMb13y4zyORlQmr0HM0kDuqA4XNc2Gm/o1D1+Jn8OrkAvhLmvTZIT9AC9xx3Ykvasb
         5hiSkxrHrcMqgBh93BQ2RAp3SI2L2sAnRPXI7ffFeHkLfJ+/RRcNXRyZ05n0Pf/4NCJA
         bFBX4M60w8Lbrohw2ggcLdda3HkuXWektqSAY0ygdbcT2rfdPYfgoTDxCoIk7VEtBOIx
         YPraGMRr4OMoRjpJvpxBVfA7pZBC3o5oxiEc6exWQCokMZTYA0tK+ECUvGI00BBqsfY3
         DpmDqfMsDereGwMWGnbqseJX1UTx788kntDIF3lRA1ar2tvumedZ2omBty7OqYaososr
         NMiw==
X-Gm-Message-State: AOJu0YwyUryjvcwt48TVmNWWIgNqsleQgmPtMpQgTaH8dMpGl1j7c3Xa
	zLPbNPhJRe5WcIU8E/+pXptXyj20+3dKiTHSV0STDjp/FJVBxo0ocPOYMsHj6r8U
X-Gm-Gg: AR+sD10kNm5igiNlXmBPGpiYHbiT0W044kp3bzNYkps3LvjI/3EPW1Q3zKraIxKXFdD
	sDyTEY4NosfYvgzcV8nbEIiumgQoJ43oo8uPkxGWB8hCdA6LcAMa0dt58xhhpG0NIDOaXFPyXmi
	EXDqHlXDTtQitXf86e/0v9wj7Ssw+xromLJHHrX3jJT30A4v7vuHsmbQXHmE5HCewUeZY6MwYnW
	d5Pe31s94d/YpAzzCOx6J82s7yP3mEY7fiTbBKGSDgChFWUnb1kHLniQWf7zWgJsJtVUbHb3+Y9
	mVTTV3m2aAmNvOe6gozrEoBihKg3o7wZCnv8BYe+Zzk/7P+3r8fl1kSoFrQIHtBhOqEb9zpbguw
	EjWyNB4LvdYkkzGaq5rY08OxTzgEEyLVMim0eeSh5kl7uSFYmmlkqM4x/R9aG5GEx7PqgE1KnG6
	QmbWuCghPuK9BzauED4wybZN5K8DTl
X-Received: by 2002:a17:903:384d:b0:2c9:97a7:f548 with SMTP id d9443c01a7336-2cfde8a42d7mr15862485ad.46.1784973520074;
        Sat, 25 Jul 2026 02:58:40 -0700 (PDT)
Received: from localhost.localdomain ([14.218.53.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7d978esm7851925ad.59.2026.07.25.02.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 02:58:39 -0700 (PDT)
From: Junxi Qian <qjx1298677004@gmail.com>
To: stable@vger.kernel.org
Cc: brauner@kernel.org,
	joannelkoong@gmail.com,
	mszeredi@redhat.com
Subject: [PATCH 7.0.y] fuse: fix writeback array overflow when max_pages is one
Date: Sat, 25 Jul 2026 17:58:35 +0800
Message-Id: <20260725095835.62290-1-qjx1298677004@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026052020-doing-champion-3502@gregkh>
References: <2026052020-doing-champion-3502@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_iomap_writeback_range() appends one folio pointer and one
fuse_folio_desc for every dirty range that is merged into the current
writeback request.  The merge decision checks the byte budget against
fc->max_pages and fc->max_write, but it does not check whether the folio
and descriptor arrays still have another free slot.

This is not sufficient for fuseblk, where the filesystem block size can
be smaller than PAGE_SIZE.  With writeback cache enabled and max_pages
negotiated as one, contiguous sub-page dirty ranges can fit within the
byte budget while spanning more than one folio.  The next append can then
write past the one-slot folios and descs arrays.

Split the request when the number of already attached folios has reached
fc->max_pages.  This keeps the folio/descriptor slot accounting in sync
with the send decision.

Fixes: ef7e7cbb323f ("fuse: use iomap for writeback")
Cc: stable@vger.kernel.org
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
Link: https://patch.msgid.link/20260506122415.205340-1-qjx1298677004@gmail.com
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
(cherry picked from commit c3880a7b10e487e033dc6f388bda118436566f7a)
---
 fs/fuse/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index acd2667f30..e94cce2915 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2177,7 +2177,10 @@ static bool fuse_folios_need_send(struct fuse_conn *fc, loff_t pos,
 
 	WARN_ON(!ap->num_folios);
 
-	/* Reached max pages */
+	/* Reached max pages or max folio slots */
+	if (ap->num_folios >= fc->max_pages)
+		return true;
+
 	if ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT > fc->max_pages)
 		return true;
 
-- 
2.34.1

