Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE0C3BBFB3
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787337684; cv=none; b=WA+jlom5n0jM0ChiNkQ5AY66o/x+5arKu2zpjglbEfL8aQFSMZRPpbfFs/mD2/tgvqnpqlOOwFQyhflf0zmq4CsCMHE7q0ZYNGAC54tAFAigYxO6olZjU1RxXacKixqvSH/fsMq6ivdn9YU8Sdad2xCx+T6uTD1W3UStvuJgaes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787337684; c=relaxed/simple;
	bh=VcNJNK//mkpsY1vMPo45uqDEB2rBm3fkoabhapZVXOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKsPAZcXVq8M9wTl6GpcBnnfcM4SChHKDNwM5U3PPtHEKW2inU5x8oZCkcVUt8Car2q0AiE3GiWl7sa0n1Pf+XtSN2DCsHCI8IdvohM0/hAf2qzfGTb6Jxls6tHxXqrkclC8/Of7C3388T5PPBJSLPn5Nv6mvPguPe8TbGGnYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWY2WgA/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=REBHykph; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWY2WgA/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="REBHykph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787337679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nxW/9v8xImR1zQYOkQ8lRE7EKN7I4YapIqOEEMSl+Rc=;
	b=MWY2WgA/XXopkbbM6xjnQY82RQtehL0ZZw6Ida0wKmGg5xkCW213+CdsvovbcxAqLvKqpf
	UMelMsXaHkewHmh3pitHnTKqwv3Q0BP/TtVdBJkihhmhaKrVb+53MBteYpUVo+qGhhzBti
	wDH0TEIFLrM9nPBTrFfqOJnVqhujDvA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-jQiJqqAwOtabMxHz3VVxNQ-1; Fri, 21 Aug 2026 14:41:17 -0400
X-MC-Unique: jQiJqqAwOtabMxHz3VVxNQ-1
X-Mimecast-MFC-AGG-ID: jQiJqqAwOtabMxHz3VVxNQ_1787337676
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-836cfb589a3so47675887b3.1
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787337676; x=1787942476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nxW/9v8xImR1zQYOkQ8lRE7EKN7I4YapIqOEEMSl+Rc=;
        b=REBHykph/Zx5sVUaiJQZYMdORfh62x5ZidZdRETDGJsHtF1AWDcvQ4zAGzcmuVtrUf
         XtKubBosLfiWCofSdkFoihi741j25XsjthoBG9Y1g+X/n5u+GmrXPzv+ypULbRfOp+AT
         o+LguC5/X3dzcqcBG9jc+mzqTJMp37y81auE2ZWeoJjkCPbPouvhtdQ/YX60V9t2PGYp
         +HtfyOhUV4mnqFQ+Xjw2m8eUB7Ovlm3FqlGsgvS60otim3ANj8VPBjX+Eudzb6ijzZik
         zkm85gxfTe1agjo+i+/kpY0LvCOFFeHPkqOCKtdna/Wg5ULiviXnyFVHR1k816AIdPyo
         FGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787337676; x=1787942476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nxW/9v8xImR1zQYOkQ8lRE7EKN7I4YapIqOEEMSl+Rc=;
        b=INJR1t6EUq6YICxy7bqDBhGra9sqlCvDamnfS9+tavl4FpFmfqljD1CezV4iTa2ui7
         WLOxsqpP46BBYciFt1dJBEpolmMaXbO80cqSI50PdOSYE8ImZoCZAmqtCJf202Bs+EGl
         p/HPwzvc/qhdgralWqxIDlnVyrRUiUxlYNFn87NGlyrxI75p0nV66wHGwQTwtFSz595R
         l2lWSoBysvIXPx3yiDNlvh5HK3K3eWNaLrbIbaRUE1SNWS8jPQ12wPja8kUM1mte66nk
         Hq+2ijEXLGaiJLCpN9sszsvqQbSmvkSKDeA7v0qxwSODgk5sc37W3+RqA5B7YGS6UYoy
         SdaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpd1q7HuX3uYDpfLmPbXMM7Tn8o04KVroz+LvPWExuqWlM035gmPilEEI7L2wa3ZZfSMhHD+UA=@vger.kernel.org
X-Gm-Message-State: AFuF++k/C8j08hxy5Vwx+jRviFZBFgprhXQeVTSSOxO6Ge0Z8SVTEz07
	864IHlqkywvx8+ZEi/vfFGpGjDrVtjo4my1hfdm1wkSPBXzUhXGyFtLbiqCetZnxBoKfJm2hmSV
	EwH9a/izRHbuOlaDmVg2vNsS4oX3/JI+pce22z5/4sIq4lgiCwXZubJvlMQ==
X-Gm-Gg: AR+sD112eQ/1/A76o08c9Z6oZRn2YPH+aoAyBCcI3RjE+zYw/sb3eqt7jBrzwkRy9ma
	hIV+JSgeU9V1vbrnBwouImwDS2jfnZ+J5Sm7PsHMdVasV5tyVGrM1l+9niuMhu8U94dRSU3rK1b
	dzkxZB2BPUrFtiJ/8Yu+yMQQ/dA3mvanJjVOQ724CQ1mrVBh9+MjpafNHfPswDo3N1Hwd+a7xUC
	GcuJV7nfaYUkYDsvEP64KuUHQBHHJKUjuUCbXo4qc/JQI/oJaj5M83R6auufZFnAYyx+IgDtlt6
	ekucEyZJg/+UA4pevg852gmLuyns0uD94tRdyunN3FCbcvqOTdWm+vF4YSzgMwG+zbsQ+BeNu4y
	puIFD3BWU+6TXmvH7SyPQmYOBcr560zy/QvF48kOp2WbaqjAcL9kWWphkhhhFuJGMKw==
X-Received: by 2002:a05:690c:e68f:20b0:836:dbfe:40cc with SMTP id 00721157ae682-849f562d153mr26008927b3.20.1787337676399;
        Fri, 21 Aug 2026 11:41:16 -0700 (PDT)
X-Received: by 2002:a05:690c:e68f:20b0:836:dbfe:40cc with SMTP id 00721157ae682-849f562d153mr26008627b3.20.1787337675769;
        Fri, 21 Aug 2026 11:41:15 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cabd2861esm539707b3.37.2026.08.21.11.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 11:41:14 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 2/2] cifs: fix loff_t underflow in cifs_remap_file_range() when len == 0
Date: Fri, 21 Aug 2026 13:41:09 -0500
Message-ID: <20260821184109.1834871-3-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821184109.1834871-1-sorenson@redhat.com>
References: <20260821184109.1834871-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With len == 0 (clone to EOF), the effective length is computed as:

    len = src_inode->i_size - off;

If off > src_inode->i_size, the result is a negative loff_t, sending a
corrupted ByteCount in the FSCTL_DUPLICATE_EXTENTS_TO_FILE request and
wrapping the filemap_write_and_wait_range() range.  An off >= i_size
check exists but fires only after the ioctl has already been sent.

Snapshot i_size_read(src_inode) once and use it for both the bounds
check and the length calculation, eliminating the TOCTOU and 32-bit
torn-read risk of direct ->i_size access.  Use strict inequality
(off > src_size) so that off exactly at EOF is not rejected.

Fixes: 04b38d601239 ("vfs: pull btrfs clone API to vfs layer")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/cifsfs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index e9e5ba4fa865..d2a0a9ed4bf3 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1415,8 +1415,15 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	 */
 	lock_two_nondirectories(target_inode, src_inode);
 
-	if (len == 0)
-		len = src_inode->i_size - off;
+	if (len == 0) {
+		loff_t src_size = i_size_read(src_inode);
+
+		if (off > src_size) {
+			rc = -EINVAL;
+			goto unlock;
+		}
+		len = src_size - off;
+	}
 
 	cifs_dbg(FYI, "clone range\n");
 
-- 
2.55.0

