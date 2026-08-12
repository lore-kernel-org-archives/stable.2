Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4BA38399A
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786502502; cv=none; b=mD0T74LGtHntDo7uOP0J5EYsYXLn8AGTAqkvG1MIiNxGjRcpUTn6SLqREeEVBz5h6+EQPky10Lzp67zVT2NXxxx8Oco77lbZZgJj5PHyaM2UOmrW75MEBEgLiUgHbECqceJF2FmZT17V9GX6SrhFSH0S317cMEYeB5j5o1R1uv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786502502; c=relaxed/simple;
	bh=184+wo2MmPfVVSEIrO0XZr+LFjQaZHymk+ewrVt8Dxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1e3QYgZX41JIcUl/QToCXaQS9aB72Lac2dEs3Ne2rOeS5pcBUPnD9FBuoS7qRvNvhypGTO+/IX93T+g4UPwJz5LwYf2nXLo2TZuR+QnC8ZED5FUYuS4A0F+Mk8sn+PTo1RuW/VNRV0b0/kUgoqUTUVvsIAPN7QgaiP5bigHrcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DFcOJ9fQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSNfzun5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFcOJ9fQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSNfzun5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786502499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fkG++BzIFbGGoiUpCqb/8lmKeOjMyVwnECKfoty2BCg=;
	b=DFcOJ9fQZ0GFoRKMG/mVTASoFBxGRNaVUCP0+qNY/Jr+umlN0C+MxjcaZuyl6UJRhRhEwc
	UcPrA1hGRUdpTWY7+rHcREuhAoQR/eKMYfKImbtOsddo9xRc2UXaouEokLcIyJHgVMGQnK
	BYtIC0HSyYv2llrI+BeKfx8q3pHMw4o=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-3mECBF25Mzqo5byQaTdqRQ-1; Tue, 11 Aug 2026 22:41:33 -0400
X-MC-Unique: 3mECBF25Mzqo5byQaTdqRQ-1
X-Mimecast-MFC-AGG-ID: 3mECBF25Mzqo5byQaTdqRQ_1786502491
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4a485034d01so898051b6e.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 19:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786502491; x=1787107291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fkG++BzIFbGGoiUpCqb/8lmKeOjMyVwnECKfoty2BCg=;
        b=fSNfzun5CqInc8O50aFPndPeLMK60i3wzKGe+mZ9q/7Yjr/0+mfjN/i757w7a0CCNa
         5CBElxvvWt7JIS/UthsQwaNTRU0SYmbmx93WsK/GI7wRQtuqWZEyQchHmqF/UOwp6Fsj
         ZVeJHRLUfu6e4q/l7PFP12db/Vj5Et9jSfmaOBpwZSiP5hq2Xw4rmmB35xPwC+VX4/Kq
         gQuZcEEwdyyvg2cqd/x+fmTFyRVMVIH7OMBKmGcbL10UGnv8YTDUJbehtiNoBp9lQZ3a
         9C6mpK2Oj+ek18RPHqmNzzqqz0fkiCmcvf2ihmpDc5/7U/2bkEPUUuFFBodu5AbohqMl
         7rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786502491; x=1787107291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fkG++BzIFbGGoiUpCqb/8lmKeOjMyVwnECKfoty2BCg=;
        b=ECJ1hBSXtaa29FgLCuNhJcRyHbSYYX7wC8XQMYFVGJmW5mSUduGPzgKrKRwQA7+EmO
         22asLKzTYK/73TKT+VZoXoNo/tECAxJUhwzvq4j0tAlYXY8yWA6sp/NrynESWKtTY7qo
         s+APwqI1tyg2ELLtuLRFsmmPCf7rCMhctbGi2QSYlt6LUpltl9XGYSk1MMZPpJXX1hyt
         MO+NII6QXbSkS8s3QYCgDljBVWSeI73wdGyvTW7PNJaIG5Qa1o0/DCpdC37UGRknxwdG
         dbJQ7+7uGWL/IsuQ9z0c4ZK8ZLAYb9pkG1iWYviFh0L9Q+W3eHrXe00rBOEpDBYunlFW
         eXzQ==
X-Gm-Message-State: AOJu0YwyiIRbsfp2reB3YzBu/HQ0A+QFMObdaPCs8VIl0JKWtqtoOG0k
	gNJc+H0kINepDg0oFR3zh/AD43SFEBgGdkJUajvjBha1y8DmpobGMTlckQLqy1FtxGZGko4a/hy
	ANRbyAAfwVr1juOdNBOAK5/7/hqYH73lJh/I2oYRGDs5GVMwmau5QULtlvA==
X-Gm-Gg: AR+sD10t15qZKbKWxv62EGxnch/7RhQkMWkcz7jU11f0Hro009hr9meVKIc8cbyNlLD
	92xOwKdzQvTFf1KmsTzA035D99BIRp4+UO9807g9i2mGecUftFZMELkt6Z8QOEUJ6bN7HILl2LK
	NuqU5DHyk83uJTNMPqy4o31m/djp4Q6JvFltlNs1edIqEazoLgY/6qYko1IxrsoMbZPVn880nEb
	oTsji7H+rj+U9mjsfrNdhN9LriCWVKxDo7GFtHsj/lK15Ofp/YhtLJZUwV0jjSFPQ8e04dvACDh
	B6Gst83KUB/Dk6oSFd8B0Fcbvy2vjtQfRH00mTFvFATF5Q499ZmT2VjHF1nKnq0CwCcSDLptv1N
	Cf5BH4ufnRS2Nc5AQ09KWwl4b0cxUwZqp8pJ+yKT6MK2S05sZgNKckbk+qyiqo69EqQ==
X-Received: by 2002:a05:6808:1a10:b0:4a4:934:b316 with SMTP id 5614622812f47-4b210c77ff6mr1716101b6e.21.1786502490722;
        Tue, 11 Aug 2026 19:41:30 -0700 (PDT)
X-Received: by 2002:a05:6808:1a10:b0:4a4:934:b316 with SMTP id 5614622812f47-4b210c77ff6mr1716067b6e.21.1786502490265;
        Tue, 11 Aug 2026 19:41:30 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1fff5e900sm2220088b6e.7.2026.08.11.19.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 19:41:29 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: stable@vger.kernel.org,
	smfrench@gmail.com,
	Shen Yongchao <grayhat@foxmail.com>
Subject: [PATCH v2] smb: client: fix OOB read/write from unvalidated DataOffset in coalesce_t2()
Date: Tue, 11 Aug 2026 21:41:26 -0500
Message-ID: <20260812024126.1368971-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

coalesce_t2() computes data pointers directly from server-supplied
DataOffset fields with no validation against buffer bounds:

  data_area_of_tgt = (char *)&pSMBt->hdr.Protocol +
                     get_unaligned_le16(&pSMBt->t2_rsp.DataOffset);
  data_area_of_src = (char *)&pSMBs->hdr.Protocol +
                     get_unaligned_le16(&pSMBs->t2_rsp.DataOffset);
  data_area_of_tgt += total_in_tgt;
  ...
  memcpy(data_area_of_tgt, data_area_of_src, total_in_src);

A small DataOffset can push a pointer below the actual byte area,
overwriting header fields; a large one can push it past the buffer
end, causing out-of-bounds heap reads (source) or writes (target).
The BCC overflow guard does not prevent this: BCC reflects how much
data is present, while DataOffset controls where in the buffer it
starts.

The "validate target area" comment present since the function was
first written in 2005 was a placeholder that was never implemented.

Add lower- and upper-bound checks for both data pointers before the
memcpy, and before any target header fields are modified.

Fixes: e4eb295d38b5 ("[PATCH] cifs: Handle multiple response transact2 part 1 of 2")
Cc: stable@vger.kernel.org
Reported-by: Shen Yongchao <grayhat@foxmail.com>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---

 fs/smb/client/smb1transport.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb1transport.c b/fs/smb/client/smb1transport.c
index 966f2cf83a51..66daa5a37e4a 100644
--- a/fs/smb/client/smb1transport.c
+++ b/fs/smb/client/smb1transport.c
@@ -375,12 +375,31 @@ coalesce_t2(char *second_buf, struct smb_hdr *target_hdr, unsigned int *pdu_len)
 	data_area_of_tgt = (char *)&pSMBt->hdr.Protocol +
 				get_unaligned_le16(&pSMBt->t2_rsp.DataOffset);
 
-	/* validate target area */
 	data_area_of_src = (char *)&pSMBs->hdr.Protocol +
 				get_unaligned_le16(&pSMBs->t2_rsp.DataOffset);
 
 	data_area_of_tgt += total_in_tgt;
 
+	/*
+	 * DataOffset fields are server-supplied and not validated against
+	 * buffer bounds; check both data pointers before mutating the
+	 * target header.
+	 */
+	if (data_area_of_tgt < (char *)target_hdr +
+				sizeof(struct smb_t2_rsp) + sizeof(__le16) ||
+	    data_area_of_tgt + total_in_src >
+	    (char *)target_hdr + CIFSMaxBufSize + MAX_CIFS_HDR_SIZE) {
+		cifs_dbg(VFS, "%s: target data area out of bounds\n", __func__);
+		return -EPROTO;
+	}
+	if (data_area_of_src < second_buf +
+				sizeof(struct smb_t2_rsp) + sizeof(__le16) ||
+	    data_area_of_src + total_in_src >
+	    second_buf + smbCalcSize((struct smb_hdr *)second_buf)) {
+		cifs_dbg(VFS, "%s: secondary data area out of bounds\n", __func__);
+		return -EPROTO;
+	}
+
 	total_in_tgt += total_in_src;
 	/* is the result too big for the field? */
 	if (total_in_tgt > USHRT_MAX) {
-- 
2.55.0

