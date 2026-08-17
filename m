Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25AB3290B9
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987025; cv=none; b=hGH8bIoS6RtJ+4hvhGO3khuj0oEGr0pwK0EQ7AfQaft1JwaTd/AbF2Fon/Pr7hi0K+z8Jz+haHaNoqE30vAno5q0JLT631UiXLUSlzNIjd4lQqaOJGPV4tWhD75jSOXULg2ug1pjhvJxvCposMIUWsrpbv+zdTARPMsvIkU/3ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987025; c=relaxed/simple;
	bh=VOYBcWp6KT9RjVqAljI/2F80dW9AyMNG+ttnL2o0FGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKLC1GtfwjUOrkZyQ3szjnNMYOiJxm81yIG2qzXS6Ih8rOSuzUQRBztPALbPT317gfLpG4RPSBqgTzzFs4llN88Y3fwyvqej2dNeZHNVHztFL293RX67e+aOTDn5IFud9RH+9qHCxQnbTEPO11Pb1jqJXv/AUuuysQbsGHLcRfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cj0sw41l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSxa4Xx+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cj0sw41l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSxa4Xx+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786987021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4T7mX9cnhbGB7nWaJdtialUlOAZYcjHgRRlL56OYGnk=;
	b=Cj0sw41low06d2e+OS/rs1KpSVoJZt+N9CByxrykuaHdicc7RCAHPyepvCxQW3ITPdRmgZ
	oQQ25SwMrrdIbXCPCfyBfbVBYWLOKTgX64RnVcSegMQM3gJ99fzmePQ4Ia9rtUtWu8grGi
	TozNXU6VbUeErCRfLVF3BzD/5jaotQ4=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-zYElkY40PmeqHEIH8yQWCg-1; Mon, 17 Aug 2026 13:17:00 -0400
X-MC-Unique: zYElkY40PmeqHEIH8yQWCg-1
X-Mimecast-MFC-AGG-ID: zYElkY40PmeqHEIH8yQWCg_1786987019
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7ec5495f105so3458130a34.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786987019; x=1787591819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4T7mX9cnhbGB7nWaJdtialUlOAZYcjHgRRlL56OYGnk=;
        b=aSxa4Xx+jv8h4cOwjMBszlWiOtl/h8nZyMbfRQeOqzA9kz1OUDz+Zw6xmXS3bfhutk
         n8MmcNJcUwzeDmnIYfDo9aYom94yo7za91exxfs3t3YFGWhVWZQNlSgBRlg2nzTu1/NC
         XeHVMS/HkmFaoM2tgKZrloGNwm58MikWP4w7mjItmMuoW5HuuiCSnRt3l+4RB2nkCj73
         oEjtObZxvV3zhgvZKOFlM3lCg3O7Bvr4G0OIDUaOSODFZ+ZJYBkmS3llQPzIk5q7lLti
         LGGOWFk0DfA4ZGI4InZUac4zOfJ4VdetIuEn6uPfxjEjWVCAz3a8YV1hCTCCFqzpRj1p
         j78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786987019; x=1787591819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4T7mX9cnhbGB7nWaJdtialUlOAZYcjHgRRlL56OYGnk=;
        b=NWDABtLaQdfIVNp9UBJtUK95J7iWbK6OvJqa2HRKY5F9/aUKSB0qdUamezL0147zlj
         bGFk9o4kyUEqDMQO+l2a4DElO2LTex6MUKpImhgNwBSRSBOlBAtRamMr18bfPek8kvOi
         ElLFNp/ce3dHugKm+PIPg0N6oFCACSc1HeCtUBJkElnJcyM49ASqnT5gyLJKlUcyfND/
         I4UL5lu9y6NBcUXOSj3z9FsbgfYZ0rTpBRL5YIo9h4BcEjT9MskyulqpNjMJGPpUQ1gh
         tNjecFrlxtvsTHJsmJhVVtnCZEUA4+FP1KpggJkki1hWvcsQPkq7Nd3yj/94sbAyQFsG
         S1Fw==
X-Gm-Message-State: AOJu0Yxr7fK8iPHK3HWOXzoJkK7b+yt9mnZs3Vaj+X8OocF++f2GBEV/
	69TJ4kkWFmos7BN5hxt+7j751aWg8UnH+v8D5Rp6864flK0U9l9lsjgdLJd/XS7KKmbLrT6uFkH
	5k45PDj6ZpZBH91gEyS09LtW4Rz6a+ttn+eP5wGTLUZmFdCXghV7EZaK2Qg==
X-Gm-Gg: AR+sD11QFqCIkbxN34+3MxndFgZZH/qmqp5i17fzGfggQhrP1TpXxn7oAuyZT+/u9ce
	c3kgEobLET7MULN+zeefWMUhWWK9phq2upMFgpn9qAG8vTvrjT9uaCEO33a0TpxgDRuIyEfXP76
	thdNOt4pemCymgqcYVLCtDsBErNVbXxSA4HTgB52bzj0eI64a/m+NHibudEYXatJjN29KWfAYtD
	4MP8wIk16nkRxnf59lL03jtzKrh2wxIHDXeeX+QdrdXQ1nUWtHFDa83Xd98x5oCDpuvkwGuNF2c
	7CTdCR7kCq6yZI7caI+362NhzXN/PuP/H+2Nd3wxj9RT2L8DC23SipHr4zYcZyFjnVZrMpwC8Wg
	JwWclBr4X4qs7PMyjDKJ3UzoWh8GZhEQaB6BxfDREntuRhtQxpyATKczmMiQBWoZGBA==
X-Received: by 2002:a05:6830:2b09:b0:7e9:e8ae:7049 with SMTP id 46e09a7af769-7f3de3de1b1mr26667570a34.7.1786987019605;
        Mon, 17 Aug 2026 10:16:59 -0700 (PDT)
X-Received: by 2002:a05:6830:2b09:b0:7e9:e8ae:7049 with SMTP id 46e09a7af769-7f3de3de1b1mr26667500a34.7.1786987019136;
        Mon, 17 Aug 2026 10:16:59 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41c0b93b3sm1891451a34.13.2026.08.17.10.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:16:58 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	stfrench@microsoft.com
Cc: stable@vger.kernel.org
Subject: [PATCH] smb: client: fix use-before-check of ReparseDataLength in reparse_buf_ptr()
Date: Mon, 17 Aug 2026 12:16:57 -0500
Message-ID: <20260817171657.212776-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reparse_buf_ptr() reads buf->ReparseDataLength before checking that
count covers the full fixed header:

    buf = (struct reparse_data_buffer *)((u8 *)io + off);
    len = sizeof(*buf);                          /* 8 bytes */
    rdlen = le16_to_cpu(buf->ReparseDataLength); /* offset 4, 2 bytes */

    if (count < len || count < rdlen + len)      /* check comes after */

struct reparse_data_buffer has ReparseDataLength at offset 4.  If a
server returns OutputCount < 6, the read at offset 4-5 reaches past
the end of the received data.  The off+count bounds against iov_len
were already validated, but that does not protect against count being
smaller than sizeof(*buf).

Split the check: verify count >= sizeof(*buf) before reading
ReparseDataLength, then verify count covers the data region.

Fixes: a158bb66b137 ("smb: client: optimise reparse point querying")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 213bc298cdf2..2946391bb992 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -40,9 +40,11 @@ static struct reparse_data_buffer *reparse_buf_ptr(struct kvec *iov)
 
 	buf = (struct reparse_data_buffer *)((u8 *)io + off);
 	len = sizeof(*buf);
-	rdlen = le16_to_cpu(buf->ReparseDataLength);
+	if (count < len)
+		return ERR_PTR(smb_EIO2(smb_eio_trace_reparse_rdlen, count, 0));
 
-	if (count < len || count < rdlen + len)
+	rdlen = le16_to_cpu(buf->ReparseDataLength);
+	if (count < rdlen + len)
 		return ERR_PTR(smb_EIO2(smb_eio_trace_reparse_rdlen, count, rdlen));
 	return buf;
 }
-- 
2.55.0

