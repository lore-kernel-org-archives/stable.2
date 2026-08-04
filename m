Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7823921C8
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871289; cv=none; b=JAbhDtZ+kw3ewmzYaMAydLHBrqvYWd7qqDgQkP9UAlpzXHbdrGMZH1UDb4ympwQ/Xi6DttIDcR+tM9XyIfn6Gu+SIvElmgNEOSAbioEraQidSshs9nw7uJEiwf47xR2S18szMV9kfVGOUrQkRiAWF2xGpcF/QE50YXVp1sPAZMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871289; c=relaxed/simple;
	bh=NAzTpwSqrGpCQPuWNjokmmllPe+lMe+hNa5w2ijq8V0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MwQcb4yRAk3e8PLiBWWnGRXc4E8ZxdXYialQRjBWRzf/gAF7+CTbenuwFBP/i4uGsXvg0Nk5CrGZuPDF9fWzfT2mYVKMEIZlbnFltVGQ1OQR+o8O7Hi1jXKVYv4Q5yTpN/V+FTZR3SC74C6thig4ZFnywl5iYQgZnEe2rowcNcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ihxqh2ek; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8XOB0pl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ihxqh2ek";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8XOB0pl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785871287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9ijcBhV5239C2iW6W0yDyeKrdEK4oyUib6zir7BdDdA=;
	b=Ihxqh2ekXlzh1tnVtJwgBon5fvAUT3fV5FH20Nd0HbCVql+T3NNtVQMDBhIXcH4JDq6fAr
	TRui/pwkfTpUK0Iz9Dm5EJGHZHY746+Gms9kv87IK1P3A3gZg7zJhQrh2NVqRu92FkpZlh
	1ti+83nPxQHk3yll6zBKSSxWqgWuTaE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-iCrCAdWkPu2lcMWkgj-a5w-1; Tue, 04 Aug 2026 15:21:16 -0400
X-MC-Unique: iCrCAdWkPu2lcMWkgj-a5w-1
X-Mimecast-MFC-AGG-ID: iCrCAdWkPu2lcMWkgj-a5w_1785871275
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92ac0a54110so25885585a.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785871275; x=1786476075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ijcBhV5239C2iW6W0yDyeKrdEK4oyUib6zir7BdDdA=;
        b=a8XOB0plitOfzRm3PMxjvB+ZOZq+MCP2FdTNx+eV++M1FjXYmu0HL14aD5nbDZv7nM
         qTAlPnL9rfvtzui+zNJ+TFcWeRL9EdjZo/KioAqX/sGCNiCm1i9HD64wWds09ja3vQ6l
         UFSpMt5PulIEN6rJnJWrtosUjYsFDSQ6c7M4wvDNgadtsu/o+ZU4qNGXNt6XFCKIqLzg
         yw0A0m6XvwOBlzTRECBQncyyyUpW8mxf/IYRdZLE607SwcHclj5mGZk2ENoOvCmgshSh
         R1iO/wUDhXMKWHSNTbJk3U+g7jSHTzGhULctph4QcjIyKWZR8TO8ZYwE/rGuEDE+BnHt
         e8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785871275; x=1786476075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ijcBhV5239C2iW6W0yDyeKrdEK4oyUib6zir7BdDdA=;
        b=epz6km7qPhj5y5j6/pdhZkDyYb4bhjI/bQLNIs0Csc84asGoxAsdoBs2Kc2Gey4IFu
         IbrqybjEymVvMdJW/6YjD26B+Kutq+A3xICvIe18wqY4ayjB19Rqph6P8k6JrVF3Y11e
         Yr58/naigrfIewj8tu7If9Li7/FL7TkN4Y34AQpsfFtJK0SsxfmAQvKuklLQOiHcAVwZ
         aAHcw2p+SksCHqbT+7SjDdENvQpilE7YvGnFbRsrV0ytzAUezq9K1vcBMjEXdNSmJ6Xc
         7Yt/AQ2ersLLa9qqi9z+3O6vrEKqVbgODzCjTjNTQzm9ttl8Q0Hfe0Zigy61Yr3ULB0r
         5n9A==
X-Gm-Message-State: AOJu0YylvFy3Ae/vcElrnDorHTRpTBksu4qANQJIeblHkzrO3i3WmgJn
	J/4kJbAbyN+HyLVNty58CdEGaajX0bFEdJg40mUftciXa2+WfXdEmeBaf5cdOsbvp209L8DHjfT
	d23cKruyOgW3X7d6D7FTZjiHGCGgs2wjd62lMhYVxQ3Udif2y6ntW5DVvrVCHFR5dIQ==
X-Gm-Gg: AR+sD12R9rA+D3wpGh3B5FGx2EfIApA+4aovQQloI/Feo4fweg37FApyogOnb1hzHMl
	7/EjHPdReRnBxQP10M/+TTSK3b3vYP+8BLYc98qtjTpY1eLwTRtXRVKaQ3RBh3jXCe1KoGcVcG5
	+6hNh6p8i9DK0CMNBkFDkTBJ515VviDGfF++hmcxLChw9cCj6erqkZcCCtfCtLDY47dCILHDExy
	3eEN5KdnXjwmgEVnoKAX0GbQC0uqlIc3KgH3H9OlyEE7vyqfbN2AwNokSbhADKGDWbcXMq74CHL
	hWZprsvPW2f3SvZYUnoJ8hwT2MJ010IxzSe77mvnu9xD0R1UOAHe7wGM31++Za69Q4PJnXc4HhH
	HUwaW/1KriEb6y1OFajzcEPc+aT7cmWrogLTew+i3ESXVyNTtytI=
X-Received: by 2002:a05:620a:a2d4:20b0:934:81cb:14c1 with SMTP id af79cd13be357-936490c8e30mr66285285a.28.1785871275477;
        Tue, 04 Aug 2026 12:21:15 -0700 (PDT)
X-Received: by 2002:a05:620a:a2d4:20b0:934:81cb:14c1 with SMTP id af79cd13be357-936490c8e30mr66279885a.28.1785871274985;
        Tue, 04 Aug 2026 12:21:14 -0700 (PDT)
Received: from bearskin.tuxrocks.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93641732215sm154490785a.11.2026.08.04.12.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 12:21:14 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	stfrench@microsoft.com
Cc: stable@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH] smb: client: fix SMB1 TRANS2 multi-response truncation in SendReceive()
Date: Tue,  4 Aug 2026 14:21:12 -0500
Message-ID: <20260804192112.2734366-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a TRANS2 response is split across multiple secondary packets,
coalesce_t2() assembles the payload into the large response buffer.
Two bugs cause SendReceive() to copy only a small fraction of the
assembled buffer into the caller's output buffer.

This manifests when listing a large directory on an SMB1 share
(observed against Windows XP); the first getdents returns only
partial results, and subsequent getdents returns EINVAL.

Bug 1: coalesce_t2() computes the coalesced size as:

  *pdu_len += total_in_src;

cifs_demultiplex_thread() resets *pdu_len to each secondary's own
pdu_length before calling coalesce_t2(), so this accumulates from
the wrong baseline on every secondary after the first.

Bug 2: after reassembly, cifs_demultiplex_thread() sets
mid->resp_buf_size to the final secondary's raw packet size.  This
value is later used as the memcpy length, so only a portion of the
coalesced response is copied.

Fix both by replacing the stale *pdu_len arithmetic with
smbCalcSize(), which reads the BCC field that coalesce_t2()
maintains correctly throughout reassembly.

Fixes: 83bfbd0bb902 ("cifs: Remove the RFC1002 header from smb_hdr")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
---
 fs/smb/client/smb1transport.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/smb1transport.c b/fs/smb/client/smb1transport.c
index 53abb29fe71b..966f2cf83a51 100644
--- a/fs/smb/client/smb1transport.c
+++ b/fs/smb/client/smb1transport.c
@@ -260,9 +260,23 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 		goto out;
 
 	if (out_buf) {
-		*pbytes_returned = resp_iov.iov_len;
-		if (resp_iov.iov_len)
-			memcpy(out_buf, resp_iov.iov_base, resp_iov.iov_len);
+		/* Use smbCalcSize() for both single- and multi-part T2 responses,
+		 * both here and in coalesce_t2().
+		 */
+		unsigned int copy_len;
+		if (WARN_ON_ONCE(!resp_iov.iov_base)) {
+			rc = -EIO;
+			goto out;
+		}
+		copy_len = smbCalcSize(resp_iov.iov_base);
+		if (copy_len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE) {
+			cifs_dbg(VFS, "response size %u exceeds buffer\n",
+				 copy_len);
+			rc = -ENOBUFS;
+			goto out;
+		}
+		*pbytes_returned = copy_len;
+		memcpy(out_buf, resp_iov.iov_base, copy_len);
 	}
 
 out:
@@ -386,11 +400,13 @@ coalesce_t2(char *second_buf, struct smb_hdr *target_hdr, unsigned int *pdu_len)
 	}
 	put_bcc(byte_count, target_hdr);
 
-	byte_count = *pdu_len;
-	byte_count += total_in_src;
+	/* use smbCalcSize() rather than *pdu_len: the demux loop resets
+	 * *pdu_len to each secondary's pdu_length, making it unreliable.
+	 */
+	byte_count = smbCalcSize(target_hdr);
 	/* don't allow buffer to overflow */
 	if (byte_count > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE) {
-		cifs_dbg(FYI, "coalesced BCC exceeds buffer size (%u)\n",
+		cifs_dbg(FYI, "coalesced size exceeds buffer size (%u)\n",
 			 byte_count);
 		return -ENOBUFS;
 	}
-- 
2.55.0

