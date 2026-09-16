Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A444A014B
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594479; cv=none; b=CHjYp1Fb90pDwcuYAJT/a/7aH9XTIBybus5IDIeYYnFw2a7hUXCRnVbZL1786m2PYPI15oi++8qa3kZEXlLUctl6nvkmwZniqBsHWH0h+lUYnkG6KBtBeIYoxwcCO/PsLJGnaMHvigO3aCZsqrmO/YEytb+cYAj0eAQJvsOR/fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594479; c=relaxed/simple;
	bh=ZEjT9QkVDXjtiRVIOkOW+oLyN5Rera53gXA9EX2Z2QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqUOj8AQKAcISaPubKqy5oMiZKl/ecucCggex9Rn7U3LdFpD1fA9HZ0jQQgUMZeJMrKYWXA4R9f2PPJm4kmnUZUwrWpnQILc1yfUqsjnUTkqWj8gWPDuTkyVKxK/B4Xg9V/3mwAk3d/q+61Y4BZkPa2JOMZDAd279jbiALXrB/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSv4/SeE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tW4iLm1S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSv4/SeE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tW4iLm1S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789594464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPdJ72Rfzs/Tw7UY41TH5Szt4fBejZwkqr1D9WZOaks=;
	b=PSv4/SeEr7vb4pU/Z9BHdk7ebbGDeHJyoqDPpP5dnjm4DaKrM4hgjdMMgQ01TjUObGpIrS
	hMCMJZIWtEr+/eWnrciS4CX2aFu4m+h49Jqj5TOfxqfJNAKBUTq3jX9nS2F6GSt6KZN2ah
	IIuuObWzYjLpaXQUe6eNGcJ7/8hKGH4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-v2e4N5-uMFWwHDP6hOLhwQ-1; Wed, 16 Sep 2026 17:34:22 -0400
X-MC-Unique: v2e4N5-uMFWwHDP6hOLhwQ-1
X-Mimecast-MFC-AGG-ID: v2e4N5-uMFWwHDP6hOLhwQ_1789594462
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53018848232so1140791cf.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789594462; x=1790199262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MPdJ72Rfzs/Tw7UY41TH5Szt4fBejZwkqr1D9WZOaks=;
        b=tW4iLm1SdV/8THJuXX/yuss65R9esOBVURBo2AgxJs4GUqUl5yq2DzFUn2OX6cAlH+
         gdse1tjeNPoGIFWHQJmm8PnSRFrzGeroTzakcbxA6iGBPfcAwmZZeWdvawrHFLZnnw1p
         Q+bphkaDierxFkYwk/jLRoGHhenPMNUBNPUaWtOl5/RU/vD4Jb+pE+JPaXi3seABvcjV
         +4TZTr4fOWcAhzYpLLVSbCv6p0pSZZWrAIv/y2llAy+t7Crg3TIFmciZj7IL5VKeKv6V
         Hn1S6BIrTnTMUYu7FodT7LPibTv9nwb4eFYbNCjvU+B6KbtjQMqS2jZDx0PeU2rRX4IR
         PJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594462; x=1790199262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MPdJ72Rfzs/Tw7UY41TH5Szt4fBejZwkqr1D9WZOaks=;
        b=ygTXpJ5sGUCUiv3pMFa7gIIM80bEt+lFBBoFU604+OUYzKCl9l+9AwFhol86eoQMQ/
         /Jpo7bsUAn6FgQbx74vgt9HxNVe4wsJTmTHqJTgpqN8BMTvYFzDKvBM1ThYkwjrv+n3e
         /GMili213hSMtrLIciZW1ZBL32fevpNp9WBc+q8642NnEDSRiL9jJVU4MtypGTko4GJz
         j4+ZoizyPckQm+8lhQiPXcTyTwh1fWtN2bTZuW7vCL/1cxKic6wGgIExdM6KRMl8UgYD
         WCVjkcUScfPoE4DxS8eiVxTJhanKZvidOqpAcutwfmDVbLZ7jx8U//celYfEiBIVBv2q
         4rwg==
X-Forwarded-Encrypted: i=1; AKwUvBwmd97aPLikkVsKTArDAXh6IZo7hJMWuklHl9Z9oNyZXHic8EMA6sto3iSz/d1PLsoMbi4AlnI=@vger.kernel.org
X-Gm-Message-State: AFuF++n4A7Vzfwznku7JZ81mUcoICIufKNzWlRR146x02H70eR/+AHAa
	7VAzxdtlVCRN1HIQVrfeTiQdgQQv/aUeahWkTllXtDa7Uy0auMX1cJPWryw11+PBSa3tqLrRFtG
	5bA71ZXpktw5Z2BSwN600fX77ssuYIMsYInxzxoQccauZ0wchfpDYwJV2jNxxSHLJwg==
X-Gm-Gg: AYBFou0i1BCxMDgYw+IpalxZBSnhx6ffzPnTzuKSWRHLG4l3bc9CcK2JOzaiImk5SPk
	dAMnB6azidL4g8Y+4xEvquSq8vAc9Z5MsY8tSFAzeYUq1QJf2lGeeinFJa9rw+P3Rte63o9OzAn
	l2K1wxFWWEOkFiCuqY/fpIoaglJcHGqoiZ+UuerWZw8zr3NF+DjLGYuQzzTXFmk2DuPByy19pjx
	qtY0ENBK+CcTbTClFd3x3wkXWN5ONhN66Dqs1LFBoYWvjy8mhRChb6XCo981jHg8yMV4nRujLwz
	8LeGYfRkOWzslJ8LeGHywRrIzaqjFt6dFmqv+UzJ1y45oE+smDS3LMu1kMecNGen551sa7YraXp
	eXAcD/yXxjodR6vtaM2Kl2lo7D4mnxP+3TtflGiz/QWgqLRLjSJ0YATGUuQx1k0/xQQ==
X-Received: by 2002:ac8:59c4:0:b0:531:11ac:23d5 with SMTP id d75a77b69052e-5327ed7fca2mr70841441cf.7.1789594462243;
        Wed, 16 Sep 2026 14:34:22 -0700 (PDT)
X-Received: by 2002:ac8:59c4:0:b0:531:11ac:23d5 with SMTP id d75a77b69052e-5327ed7fca2mr70840791cf.7.1789594461708;
        Wed, 16 Sep 2026 14:34:21 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532620d4cbbsm32447431cf.28.2026.09.16.14.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:34:20 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v5 8/9] smb: client: fix potential OOB read in smb3_enum_snapshots()
Date: Wed, 16 Sep 2026 16:33:59 -0500
Message-ID: <20260916213406.1496960-9-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916213406.1496960-1-sorenson@redhat.com>
References: <20260916213406.1496960-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If snapshot_array_size is smaller than GMT_TOKEN_SIZE,
smb3_enum_snapshots() sets ret_data_len to
sizeof(struct smb_snapshot_array) without verifying the actual length
of the server's reply.

Because SMB2_ioctl() places no lower bound on the server-supplied
OutputCount and allocates retbuf to exactly that length, a short reply
results in ret_data_len exceeding the size of retbuf. The subsequent
copy_to_user() then reads past the end of retbuf, leaking adjacent slab
memory to userspace.  The subsequent clamp check is ineffective as it
only reduces ret_data_len.

Fix this by rejecting replies shorter than
sizeof(struct smb_snapshot_array) with -EIO. Note that the bound is set
to the 12-byte struct size rather than the 16-byte
MIN_SNAPSHOT_ARRAY_SIZE defined in MS-SMB2 3.3.5.15.1, because 12 bytes
is exactly what copy_to_user() attempts to read.

Fixes: e02789a53d71 ("smb3: enumerating snapshots was leaving part of the data off end")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2ops.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index ee3c98e3f316..3464470d3297 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2463,8 +2463,14 @@ smb3_enum_snapshots(const unsigned int xid, struct cifs_tcon *tcon,
 		 * and retry the ioctl again with larger array size sufficient
 		 * to hold all of the snapshot GMT tokens on the second try.
 		 */
-		if (snapshot_in.snapshot_array_size < GMT_TOKEN_SIZE)
+		if (snapshot_in.snapshot_array_size < GMT_TOKEN_SIZE) {
+			if (ret_data_len < sizeof(struct smb_snapshot_array)) {
+				rc = -EIO;
+				kfree(retbuf);
+				return rc;
+			}
 			ret_data_len = sizeof(struct smb_snapshot_array);
+		}
 
 		/*
 		 * We return struct SRV_SNAPSHOT_ARRAY, followed by
-- 
2.55.0

