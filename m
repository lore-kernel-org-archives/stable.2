Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F4D499F37
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594480; cv=none; b=qyya0O9NE20+ydI2WA6DIbA8hcZl4rjUXSatHkszz3Njb5iyp8PqPzoHmxqqGMDPCMOWDUAIb/FR3LLk571H5MQA/VRdEu+UEON7JXqqqx4B/SwKBtdsdCVNGxkf/3674CLFtu6weZZ+qau3pr7o6JFoWsKL+zO8LHi9l1UpiTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594480; c=relaxed/simple;
	bh=nqfoL6Sp1nIQ19/slQDnpcHsImhTyPT0s8L8U0rdTI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdzTHbNaVxLtCiUa4aa4qK/yM0s/nqhfkSNz5nRs5ijmWhujKiuU9Rn/TejC4jz7qndzDYOWgSnImj7wNaUZP+duSjMuZoQQo1lbh5D4dmNPIsDRPYt2+Ocz0yZN3xklhIsHyzuJvq1P0D5AAVXIdVbaY/ktCXRAUCyaeuVd2zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WziT30g4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9KLW3eH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WziT30g4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9KLW3eH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789594461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABM2woyIBHuSZR/C0pNttPA7KR8KLBv44FjWRfwZWUU=;
	b=WziT30g4vzLcLgYhyYp/Z72xTNSFlpbflim7zDFxImISre0yOsAQFzUUYXy9QdYFmktgJW
	ZTCQRBCvZMi8v8c8xVmZl3J/2g5wNIVLxOCUdWlXQY9r9cAcr1EboM6qu39Ot0c3rjYytx
	nzIOQ27YwFaM3D6EKZ8SaK+IYrKupOQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-82A9SEfJM6-ZATGy4XZ0Ww-1; Wed, 16 Sep 2026 17:34:19 -0400
X-MC-Unique: 82A9SEfJM6-ZATGy4XZ0Ww-1
X-Mimecast-MFC-AGG-ID: 82A9SEfJM6-ZATGy4XZ0Ww_1789594459
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-530256c61b4so1633831cf.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789594459; x=1790199259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ABM2woyIBHuSZR/C0pNttPA7KR8KLBv44FjWRfwZWUU=;
        b=f9KLW3eH22J34clq06grgOcshS7N+qoY4Y1roPOhyiEVWGsf8R/gcnJHSy1pxDiC/F
         +djJa3ezyVHZVAxC0Y1s+hPIXpvOCO5qTPs6yCsPFVXkDS8Ku1zVKOx5t1TLbrL2Xjj+
         MxCINbtaFvQIkPYNLN7953RwkbMD5B4K13zBBr4lMXw9yuzQHo/jvsW9YKX4vYkH/Z0K
         f/4sTIw4B7T3ZLiZdgJvhQuqL1h8sEaSNBjvR9y31NouGksEzpcLJNq/zadJ7FgeOv4s
         awutUfVmuI7BxnLFUN8FcYrJCC30ypOLHO37/FX0tdloEXfY7IGtty0/ZL9tTBWg3H0j
         fMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594459; x=1790199259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ABM2woyIBHuSZR/C0pNttPA7KR8KLBv44FjWRfwZWUU=;
        b=1oKJsvwkXDszMJ6NeeV6q9hj1Yin3kA+siZokX4blL6t1a+HpWjT020/WPAtmsS881
         RBD7/4flyA96zzNn6Mj6QDue9s56bsl9V3NinjrfudOV2L8BZWwh8zCP1NLsNOm1Br3e
         rBMqtZ6IAKY6rduhwN05jorkU8dw3rlqqP0Fu39ceN/uaFk0+z0h0T3odARsUTJ9/upM
         LLtptEj95mXZO7mwbn2IMkKrDFEp33gJ8j1lDRcGtR6Om1XGIuH6RChezzjuvEreANGk
         5wn4pDb6ajPRFBNatptEPlVrKb3sU+L/cYL91X6k+frhoyxJXnNambTUofy71dJT6NNH
         ScDg==
X-Forwarded-Encrypted: i=1; AKwUvBy6Jr+Z3kg5f8+EkPB2WWFrfZymJMQnZmhHo4EP2fViLWwITHvHaArL8N0UvWCQs/LYaq6Vhz8=@vger.kernel.org
X-Gm-Message-State: AFuF++nb7z2q6G5Z4cawh3iv4InadYO4bYDfOZql9G8vQ53oTlfJHZKS
	JVA3E+VLD6rT24Z2epycZA9+uJvvT1VR0AMqHqwKWaPpmLwAV6nN8K2lvXRFPMBskvmq7IF7sIp
	Ib8BiDlmIetSjOfGhlOqeyuImSfmIWbtzLS4God+J5nKnn0Kp4CknPCeiwA==
X-Gm-Gg: AYBFou2k8sRLZdWo312Vm58dXqVGQBNtCO66OZ2Qkfw7LDQutlqjpbgAdYp+9cBqAOg
	u00h4ZhmGAztt4TLBvMFpL1kt7Hwms40U7bwAERTBwtIwua+BragmGxPkl0NRh1MHq6ONWsyFqk
	MtEB9iYcWOR7W40PiYlbrNnvo8gHRDl+Rwy0R3e5k233rxBee7C24Jl627u9lZM7+IkKOv4ccbo
	7fMlCEiS4UKn+OX6Dp4bN+7uh3Q9p3HKQ/Ibs3JoQVH3wq8oqS34pFLfPc0Nt3BgGiJQkbfbRVR
	LBHOJ4jso8PbmWZhDGGriI4iP2Ux37Ee5H3aSB0XDmTtBDg46oeXseLPzkx55LcgRj7oZgHTsg9
	OH5J3K8UrtSpp4576j8y3D2TykFPjXyBzwx2XYTGD55JKFFnb2nhKLn9HdYAeS2rPuA==
X-Received: by 2002:a05:622a:e19a:10b0:532:8c34:2e3c with SMTP id d75a77b69052e-5328c342fabmr21013541cf.40.1789594459199;
        Wed, 16 Sep 2026 14:34:19 -0700 (PDT)
X-Received: by 2002:a05:622a:e19a:10b0:532:8c34:2e3c with SMTP id d75a77b69052e-5328c342fabmr21013201cf.40.1789594458689;
        Wed, 16 Sep 2026 14:34:18 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532620d4cbbsm32447431cf.28.2026.09.16.14.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:34:17 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v5 6/9] smb: client: fix OOB struct field reads in move_smb2_ea_to_cifs()
Date: Wed, 16 Sep 2026 16:33:57 -0500
Message-ID: <20260916213406.1496960-7-sorenson@redhat.com>
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

In move_smb2_ea_to_cifs(), the while (src_size > 0) loop condition is
insufficient. It allows iteration to continue even if the remaining
src_size is too small to contain a complete smb2_ea_info structure.
Consequently, reads of ea_name_length and ea_value_length can occur
out-of-bounds.

Fix this by ensuring src_size >= sizeof(*src) before attempting to read
any structure fields. Additionally, reject any next_entry_offset that is
smaller than sizeof(*src) or that would advance the pointer beyond the
available buffer.

Note that for calls where the server returns a malformed EA list, the
error returned to userspace changes from -ENODATA (getxattr) or
-ERANGE (listxattr) to -EIO. This correctly signals a server protocol
error rather than misleadingly indicating "attribute not present" or
"output buffer too small".

Fixes: 95907fea4fd8 ("cifs: Add support for reading attributes on SMB2+")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2ops.c | 25 +++++++++++++++++--------
 fs/smb/client/trace.h   |  1 +
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index bda940cb3784..ee3c98e3f316 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1053,8 +1053,9 @@ move_smb2_ea_to_cifs(char *dst, size_t dst_size,
 	char *name, *value;
 	size_t buf_size = dst_size;
 	size_t name_len, value_len, user_name_len;
+	u32 next_off;
 
-	while (src_size > 0) {
+	while (src_size >= sizeof(*src)) {
 		name_len = (size_t)src->ea_name_length;
 		value_len = (size_t)le16_to_cpu(src->ea_value_length);
 
@@ -1110,14 +1111,22 @@ move_smb2_ea_to_cifs(char *dst, size_t dst_size,
 		if (!src->next_entry_offset)
 			break;
 
-		if (src_size < le32_to_cpu(src->next_entry_offset)) {
-			/* stop before overrun buffer */
-			rc = -ERANGE;
-			break;
+		next_off = le32_to_cpu(src->next_entry_offset);
+		if (next_off < sizeof(*src) || src_size < next_off) {
+			cifs_dbg(FYI, "EA next_entry_offset %u out of range [%zu, %zu]\n",
+				 next_off, sizeof(*src), src_size);
+			rc = smb_EIO2(smb_eio_trace_ea_next_offset,
+				      next_off, src_size);
+			goto out;
+		}
+		src_size -= next_off;
+		src = (void *)((char *)src + next_off);
+		if (src_size > 0 && src_size < sizeof(*src)) {
+			cifs_dbg(FYI, "EA next_entry_offset %u left truncated entry (%zu bytes)\n",
+				 next_off, src_size);
+			rc = smb_EIO2(smb_eio_trace_ea_next_offset, next_off, src_size);
+			goto out;
 		}
-		src_size -= le32_to_cpu(src->next_entry_offset);
-		src = (void *)((char *)src +
-			       le32_to_cpu(src->next_entry_offset));
 	}
 
 	/* didn't find the named attribute */
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index b442cccd1530..bb8d0197cb54 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -27,6 +27,7 @@
 	EM(smb_eio_trace_copychunk_overcopy_c,		"copychunk_overcopy_c") \
 	EM(smb_eio_trace_create_rsp_too_small,		"create_rsp_too_small") \
 	EM(smb_eio_trace_dfsref_no_rsp,			"dfsref_no_rsp") \
+	EM(smb_eio_trace_ea_next_offset,		"ea_next_offset") \
 	EM(smb_eio_trace_ea_overrun,			"ea_overrun") \
 	EM(smb_eio_trace_extract_will_pin,		"extract_will_pin") \
 	EM(smb_eio_trace_forced_shutdown,		"forced_shutdown") \
-- 
2.55.0

