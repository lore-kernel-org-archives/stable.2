Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91D26FD9B
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335936; cv=none; b=KKOFYBNxkoW0oxFZTmpIgR1hZK1qOQ93yNP4/yfIF4JRttxUP+4a4W/dQJRRPVN/LZ/nPkyLhHbnBsEPsQWHOji0M+hCYuieKPs6Z1Rf0PYravXgNzo7pjRFizJodvJZfOW4ao6AgGawSBciWngLqIhLf6xu/hxA3azndZs1CdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335936; c=relaxed/simple;
	bh=nuQpQA8faMLzi+ViEILyU/7P32ImMw0Svlm3CB3LCuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gApHM7M8qfNm4k0vHyEKSXPMByMziyKqPsk2gUuLIXakl0bfB9QocPvW+2fWbPhyVWnPIVtVU8gMm9xOSZlrwR5R3g/lROSdZRr9HCrn1EUAfVTN1FqEeE7dMgBO5OORz4MCaJ+8I8LfTSMs03Z7Qkdb+1L93ABYKsGg7h3ZhQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ht2//hkX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4EZRUl+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ht2//hkX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4EZRUl+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789335933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h4wqcB7c2XOoCW8tei1Iz+P2VvDk2BP5ymqe1eDpV3Y=;
	b=ht2//hkXkIYrJCkgCpLYN/roFxC4OuhRJ3gpekbI6M1GL6z5oV2EAHkBnYa6/RrERH/jsI
	sI7lYiqcqg7X7Cmebm/8x+IqJJfaiQCWjh9S5XP+zZrb16tzcg8GdEYKFN+z/rioQO80To
	b+De8iYr81aZb3uu+zQ0oLBLtSgMTLQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-iZggO22pPrufGB1-2kvDJg-1; Sun, 13 Sep 2026 17:45:32 -0400
X-MC-Unique: iZggO22pPrufGB1-2kvDJg-1
X-Mimecast-MFC-AGG-ID: iZggO22pPrufGB1-2kvDJg_1789335932
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-530ef845909so26884101cf.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 14:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789335932; x=1789940732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h4wqcB7c2XOoCW8tei1Iz+P2VvDk2BP5ymqe1eDpV3Y=;
        b=F4EZRUl+t+bFDBCTejJmmnlWb80cKnCZNSL+Ur5NkfaK2mwlFHF9P0akvtL4rvmWY/
         im3e+08BFqyNvwBNAB9sICyMQ3vug7Tn2TtxFEqxpNS5Yx5kajKFITfIO4kKWCZiQFqs
         hzwvo784a+NLp6V0kI8CUkVRVDJHeG1DzPLlQK8HHFjcY1RdDM3ORnmNA4jdYmHlVUdf
         3KKZ8kKVJSBSw+dOhtPaTyts6l/jtxcV74ErFOFgIT0WS0Iuyu6O/gyVSc9JCA/0t3Io
         L/YqoCP4y7r9vgFK/W+QCj/DlMdinnA7hcGbasbwXO0uWsQWvnoLvn7qsEpYstLSUTgj
         fcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789335932; x=1789940732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h4wqcB7c2XOoCW8tei1Iz+P2VvDk2BP5ymqe1eDpV3Y=;
        b=Lh77rIe9VJy+WKZ/g6nvQKrLHPIUwYWJ8LcnQE1xGoaSAPgIzd0d8IFpOgzfYI7lE3
         jnD67bbQq2a1w3GzZdccnGeSN0EfbuPwWU0wOYI3WNhYfoP6B0DuihCZAYzYmgByncRv
         DegFzhY9kB+MRzgqchC80F5zw88RCJ8nurivZObNQqEiDexByIUAhuwfi6Q1gJvtQX+d
         MBZdIBwmVPdZY65UPsffpi1Ki5uCS5D2Ttq6TVJ9s00jA5nsKNVXT7KFP+/jt38kMVuJ
         Szv0VJt8gZ7wS3u39399kOfSZeFFbzGT/lgiSOLH955mOuj9G5919XDgs9Fwrmaw52lw
         U+XA==
X-Forwarded-Encrypted: i=1; AKwUvBwBiqsoEoKhv74/MaCFx3kqHSyR0EUO/NGHlxtY606fBAROE5N5jYsK7Qn9CJvkpOmfl8Hvm50=@vger.kernel.org
X-Gm-Message-State: AFuF++mbEJlH6LcwrUXKxmYwMbwDFoB3JZoaSBN1pzOtU1mj2wzFgIeD
	rbn0CgPo896QmTIh7lm2DkJPqk4adBAkOTuMwpBXhaS3occH/NJdhTStmh1h/XJDsy38JNPAs/R
	7GaL8BUvGJAxjhuOxEJqX6gOmgKdti8YTN4yguA6QgtUthV5CySPbnCVh4A==
X-Gm-Gg: AYBFou2eb+O3y/O+dnsaCpJh/MbZ59JHOImfmrSYA+VvphxnQZgle3U659rOxMbGvSi
	JJelwt/Af8VOTGviezsPmTKa0wJ2MlCmK45fMRhnSyBqKcilDqh5xVMCY6qV7QObRXrZ+udPmX2
	icdm/q5Qrn+wrIdmGQhO4GNwqvuMP99Dd0fmEpYPcCASOPGUMwU+yS2o3VmoKfU0qBN37eROnb3
	/H+oKwIZYWS1TXbC6dIrXCYOPX5oXm2Bkk0XRCu922v9zeXk3DUhlXeqUmTQ56U1tLqIrprQV7p
	yCYBNr4Ht214SqKdh3XQrqBTJsw9e8NFfX+E5wD4b8WmKSlQMWMXoKT9ZlvWaCKDi/IfHY7kw0f
	TzpfpTGyzn0O7NPfdOu9T/79NQ/9uHd9aPzP6TibkNx4TPu417HtXLp3WYbkguq9n3w==
X-Received: by 2002:a05:622a:c08:b0:530:e36d:1855 with SMTP id d75a77b69052e-530e36d205cmr152534051cf.42.1789335931869;
        Sun, 13 Sep 2026 14:45:31 -0700 (PDT)
X-Received: by 2002:a05:622a:c08:b0:530:e36d:1855 with SMTP id d75a77b69052e-530e36d205cmr152533651cf.42.1789335931258;
        Sun, 13 Sep 2026 14:45:31 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f49444bsm78581126d6.29.2026.09.13.14.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 14:45:30 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v4 09/10] smb: client: fix potential OOB read in smb3_enum_snapshots()
Date: Sun, 13 Sep 2026 16:45:07 -0500
Message-ID: <20260913214510.3071370-10-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913214510.3071370-1-sorenson@redhat.com>
References: <20260913214510.3071370-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If snapshot_array_size is smaller than GMT_TOKEN_SIZE, smb3_enum_snapshots()
sets ret_data_len to sizeof(struct smb_snapshot_array) without verifying
the actual length of the server's reply.

Because SMB2_ioctl() places no lower bound on the server-supplied OutputCount
and allocates retbuf to exactly that length, a short reply results in
ret_data_len exceeding the size of retbuf. The subsequent copy_to_user()
then reads past the end of retbuf, leaking adjacent slab memory to userspace.
The subsequent clamp check is ineffective as it only reduces ret_data_len.

Fix this by rejecting replies shorter than sizeof(struct smb_snapshot_array)
with -EIO. Note that the bound is set to the 12-byte struct size rather than
the 16-byte MIN_SNAPSHOT_ARRAY_SIZE defined in MS-SMB2 3.3.5.15.1, because
12 bytes is exactly what copy_to_user() attempts to read to ensure memory
safety.

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

