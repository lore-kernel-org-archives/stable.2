Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789207;
	b=2JglywoeWXpQ3sVaS+8wM+grRqmIgDuGdYuNG0eEzlJgC/mimF2r+IkdHVnY7oQVZxFQ
	 uge81oVYYCuNrFnv0VfwBmiRqClHVMrs3wyHGeX0xTMSHr/0QR4bAUVMZVnAU3J0kZnBG
	 jfSt/YBKHHkqPRDtFaIEsFOJ8BngAelKmejaRd4pNakmcXvxmMvClleFWFH2320Ksmdi+
	 ArFI96foor+42/P2k4R1I7HP9LDnMSa4Paj+TEcsmgaUcxMWo0yRGq8RowWxUyEWKG4Iw
	 zh2gSnfwt6NzlrDj9gMjXdij5iFCr3KpMOKVkNqXwjU1SHFeQyBtfPBDHSrcFzSdaAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HLh1868bM3xI6tmCVDDotZeFZNzZ5VuBhrB/LMUfaUQ=;
	b=yqLwJZvsgLHnZXfu70OZtZDrwPQZhuPtN7S/cdO855gPxiIKF1QysvGCWAfG+bAnTtGH
	 3jKFtV0Ivt5lvZ8epBEmYzdyuWv913R2DDI0WiT5xTdeJByqNdGfqd7ONPm0mM7nN1QR3
	 yTkuvLFcMtqmVsYpGwIhHGcVGLTbb3v3rQsTs8HHNt3GTIxhR3WX0osHwQrELDeffvEds
	 ysa/dovm89GnhMzihNKcsRFxMSotUQTNnmkRtyI0Bb4gdWqvwG0eqQaT5P+4BADUr/QNO
	 P9MkK44Vs7pxe+PY+sM+d5N/ldJXCbWs1UNEvU1oc8zfgpm8ne14y4h7ko4l2RBSOxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XBmu7vWG;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C59606A337
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 10:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27C59606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XBmu7vWG
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-143255db95bso16371c88.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 02:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793789206; x=1794394006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HLh1868bM3xI6tmCVDDotZeFZNzZ5VuBhrB/LMUfaUQ=;
        b=XBmu7vWGfccTPCZSJN6LJ1LcmTTbH2lkdS3TuZX0tBvcqvUZL/zfrqQDumoIisWL9a
         h1mSlQVMzAWwEw4Ul9Zpm6Go5YT6Eex48aDLDKrDo8npS3V/5W1MBA0MArp0Dry1R3GB
         jnZQyHyYf3XOVByhWUGYfEs8aolp7Xg2q1GCuw3ROcv1RkgeXlJCWtUjZsBaxBQ7uid6
         WIeEUsFtzohb+9SP1024P35VZEn5ckk3n3wSlVlTOMXfijU9YYIeQedKBUNJASHBxCe+
         cUISp6p7wjpjoCQHU+pXxSsEgIjjBOmdCNh8AhdUqpYMg9yM22juUXHjblDI5PX/EIYl
         B/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793789206; x=1794394006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HLh1868bM3xI6tmCVDDotZeFZNzZ5VuBhrB/LMUfaUQ=;
        b=L7KOkVqnoLo4vm+VieeLetbRfuwfM2Z76O1IwAmAl2klgPQlk5fOmerW0YNpfpxFiL
         dAi7J38Q7KADy8TlPh1Rs9NCcvtjQW5qdq1srr71avMWINp72SaOyIwYwYOdVQ4jce4S
         UroAi3/eYjRP02Y13CzU54YNkwWl8Nyot6VXUSZZT4Kj5qMDntiBkgvXsvZ0U/4mjNBZ
         ENvXkTMPa6LdyEl75GBFOjWh0IfF4tQlVpXoEL4RNOlmiQzD2c7iP15hx2PoB1SDG4wO
         ZhvBQws1xjh5N7mzgG6Z/aUdwK9yr/1C2j/E+m05WN97HzRqUQsqqtc5o8uNvS3whizL
         UvkQ==
X-Forwarded-Encrypted: i=1; AKwUvBy6sZYG/3pZtdrPSWYEp5o5RvpVRDf1IrhTGPjSBwlKDqYmEHIskk/EXO4s0KQFL/ezwrNJe8U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Aj+8nxi2LK5VPSTWY0vG9T7++mfpANTKxuEEglQCS5EJyyBOE
	c8Ktji1hrchEUDzSt5YxNhjXanM10r47kb7FR2P8enEsRsJQpzeImqba
X-Gm-Gg: AYBFou1srkZSd77mDYU4iV/5ajqm1Q9SBWaQFTKw76wlQWFh5RaBKIuu6E0+2uJ76B7
	UnpoG0G/6qlnYuLAL3QOd6WY35tnUdUbKl6Rm2ljz6JIqxoTdOD5n6dOo4x/oAHNdpdqLNp9uDf
	XZGfN9Roue7tkuZrxO9eyk7Y3kEt+VECuFblNbDRJndeevcqqIledxdC6D1KUuINH4XBSP4y+w0
	32Dd6wITu0uHowfhzshjB2xSp3QY7lNW4EQTgXMCGA79CfN/KOlUXN0RpEMBOql3f4qwDqLHRR4
	ls056wlw7jCQolopsAT9IChZYpTgmkMNe5aKMbKSx68W1LaxmyWCqS+xf0iADsnI96ePGBC91ep
	p6tJLUxdQ/1yXTnSChOjYsB04wJQdDMWZpSnGfPJJ15zn32v5rGjGldx+aNwZj0T9ybqOy5Ar7M
	L1gCXiVu5n8hhnFdl3hK/B7TXCVDgvwYXsTeM+dXWoue/nTFrhdTlWwlKd0CNz0b/tgiXEWzGYU
	55aBEaB1MJN3ro145JUpewCA44SeV+py7AwSDRJr8fEOL1KHRpoMhLgv1DSdfkfcN+KlN8xXhKu
	hYKyIIYKXM3PczYAai0LyW48kwhBPsxIXvHqx9wggn18iGmqVRoy4NU2IW4GU8JmkOi30jrRXOb
	SNKNrjqA84njxMudrRTDwT/YKDeOso0xgcaM1wg==
X-Received: by 2002:a05:701b:4248:20b0:191:3c:aae7 with SMTP id a92af1059eb24-1ac5c64cb0emr24775668c88.26.1793789205904;
        Wed, 04 Nov 2026 02:46:45 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c6f0dcsm8266549c88.21.2026.11.04.02.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:46:45 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: dsterba@suse.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] affs: honor copied length in OFS write_end
Date: Wed,  4 Nov 2026 10:37:02 +0000
Message-ID: <20261104103702.79093-1-dennylin0707@gmail.com>
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

affs_write_end_ofs() uses the requested length instead of the number of
bytes copied into the folio. It can therefore write data that was not
copied and report more bytes than the source iterator consumed.

generic_perform_write() then advances the file position without making
the corresponding progress through the source iterator. A one-byte
pwrite() from an unreadable buffer at EOF can repeatedly grow the file
instead of failing with EFAULT. Partial copies are overreported as well.

Limit the range written to the copied bytes. When nothing was copied,
unlock and put the folio without modifying block metadata or reporting
progress. Remove the obsolete comment: an uptodate destination folio does
not guarantee that the copy from the source succeeded.

Fixes: f2b6a16eb8f5 ("fs: affs convert to new aops")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/affs/file.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index 23e088a7ed4f..84f53ece87d6 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -700,15 +700,13 @@ static int affs_write_end_ofs(const struct kiocb *iocb,
 	u32 bidx, boff, bsize;
 	unsigned from, to;
 	u32 tmp;
-	int written;
+	int written = 0;
+
+	if (!copied)
+		goto err_first_bh;
 
 	from = pos & (PAGE_SIZE - 1);
-	to = from + len;
-	/*
-	 * XXX: not sure if this can handle short copies (len < copied), but
-	 * we don't have to, because the folio should always be uptodate here,
-	 * due to write_begin.
-	 */
+	to = from + copied;
 
 	pr_debug("%s(%llu, %llu, %llu)\n", __func__, inode->i_ino, pos,
 		 pos + len);
@@ -716,7 +714,6 @@ static int affs_write_end_ofs(const struct kiocb *iocb,
 	data = folio_address(folio);
 
 	bh = NULL;
-	written = 0;
 	tmp = (folio->index << PAGE_SHIFT) + from;
 	bidx = tmp / bsize;
 	boff = tmp % bsize;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

