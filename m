Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EF0314A73
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758346; cv=none; b=mdfJEACboYYxozgrj5A7Uwj/CpgnZh9LmfGp13SPFKQPpsoxzIidfpfXwmksi4Y2FPmq1vVrtNyR2JycXVhnRKhoN55A4G0xiiFvn+TVAgjnzBOZBN3LFegUNbuabpfzVCfgULBojB4KtlN2OvKagaKdFIQdVKM4dP/zUJjbgAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758346; c=relaxed/simple;
	bh=EQdNja3K/YL4RoIsEKUiS6czgsqG0oVGhh2PuRzS0NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3oh/7ME2qibRo5Xge6VWb5KjawlENbqjhUOsJ8qSAZODcAg3cEqxY9Yk5Nf68rU1+6yQn60rPD4TsPhNDoQ39Met99JJ+YtuHFqT0goM20y1TzwMytH2nKidXRHyaODxsd2G4vMT8m7zfbzEvqbotp6cO7yn3nKzZfCWE38HVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CmhN2eD3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rBCQRPHt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmhN2eD3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rBCQRPHt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787758341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9u1saGAdplFrmdEhSzZgWCpGlCV0QqNHCriRLqgre8=;
	b=CmhN2eD3caXMMlP1BwL6eZuvCudOH6cpnNBesNCVku8Z1Ytm1goix1NkEmcIvoy9QmT254
	73k44MtNXolL8oTtORYCd3+4mInUP+UmmpNzGRekMEj9xLzWr7LHREsUrTC6Pci5cfRbNt
	tUfNE6wjBJCQhV/uva4kRaZ+nwROMR4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-_XN07PG6NtaUhN1UksAb7w-1; Wed, 26 Aug 2026 11:32:20 -0400
X-MC-Unique: _XN07PG6NtaUhN1UksAb7w-1
X-Mimecast-MFC-AGG-ID: _XN07PG6NtaUhN1UksAb7w_1787758340
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-836c89e6ab0so19021207b3.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787758340; x=1788363140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/9u1saGAdplFrmdEhSzZgWCpGlCV0QqNHCriRLqgre8=;
        b=rBCQRPHt+mX09qvVZiw2l6ljOOJ8akv+d2zuIGisWSliGGwp6u1tTyh44yb/oywj38
         UwssZKbrk3dqvct6bGHFEuvbE9M8JPcBC23eA3OKP0Nh+MwLfOy305uiJ1qdkaUnGFxb
         KEjLDKjWg9KDMUdspvmRSske4ALaSi7h6FJ3tkuvEeKBmE7VEsLF7kwDK9VPdeWPbV9Z
         Xd2xlDE3HY2RHJe1vcYoVCrlnTtvTFzjqVEGOx2zNZ33XzcFGzJRQ/p3IIwHxkZGSclr
         SXfS3gsVzEpWHT3CSJSbmRN5Z4RwM4T4TXW4Zh1KRh94Ozb+7xxJtJkzhkcfkBb3C3Va
         OiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787758340; x=1788363140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/9u1saGAdplFrmdEhSzZgWCpGlCV0QqNHCriRLqgre8=;
        b=azyhIbKzeroAoPMzVeNNuQHJe3hAgB2XJb4EktzphAI6bCLgtel80lTD4hg1LPrFwG
         fdkEaH+XWCa5qEicxhbx2zbWrp0Om5pyTvCLlTPUzR6oHY64SCi/KeYpKVxe3PwzIcnC
         4RlWpSlJvb6q7plmTnbbTHSKm6I6A+7VUpVgMXATkBhXHZOwTTaoxbvEM8wTAUk6HIoo
         G1rxCLKPWYmLMYHpcE4Iru3V4qU2W1HNYcA+Jm7gYXb1ZBNm5+K61FlKdFzFIxAKsWNP
         uhGYbK/izhwJxBlHjzUymSy1h2OOqrMHS1WJKiLtttzRjOhogvWem9cVu0dQVQcSjx/z
         0YbQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPeUJI3yqO6HloZ/7d+AHlyHYt3nivljBfnk/NP0niMcc+l2rEcONiyuWIRZrp6tz1m+q3h24=@vger.kernel.org
X-Gm-Message-State: AFuF++kirmZE3nkmAHCHaEy4LEJMaEnFEP4krpITpLveZU5C6jq2nJK5
	l6XCWttjfS4XVAt0rEuP2+ffXbNCjcyvDBn+PdPZ//zg+d2z/catvZ5ei5EIMvA7V9gEq1aa37N
	rpn5PHyyG8nhwpnfidlCL4yiJlOSJpLiIgk83N0DWbX0N9lkLpqUQTpacIg==
X-Gm-Gg: AR+sD12FWvLZJV6AfPp1Uoz6b0C49XPjJ2nhtIH+10HMYpxIeHCi1acmYd1ub2dLtaD
	bs2KHeJdef6Px4Q5Y5u9rR5Ohqt8rZwdavxzu8lB4hzROXInoR8/9MKQ5Z4KDCyMaRklnmSKGa8
	7KX7ALED9O35UP3bfg36fgWvIJWohxzzlPfOcCuiJI69b8CwLRQWHpVvCvZNJL9qjmRrfcoRhlp
	qszVGYPwTlGz/W3GBjQtMERUQ9LY8vA7Ao+KIdQ/itUGEPB31niQJZmDKUbtkvNCE2W9BzFzkKa
	55C6Q859iDcek7uB8kxsyNTuGbAkZCHVvsymT0YuKpkqnWAQayjKyhLIffLAWhfMiqRZ7H0WJLk
	tsWKvvWyKk641SGJZaAy6/ULUh6dObMVOnzyYpfUIkvFb/DVa48G0M0CCkD+i4TbiTg==
X-Received: by 2002:a05:690e:140d:b0:66c:a3e8:be00 with SMTP id 956f58d0204a3-66d257ca593mr2111680d50.45.1787758339454;
        Wed, 26 Aug 2026 08:32:19 -0700 (PDT)
X-Received: by 2002:a05:690e:140d:b0:66c:a3e8:be00 with SMTP id 956f58d0204a3-66d257ca593mr2111660d50.45.1787758338829;
        Wed, 26 Aug 2026 08:32:18 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d24592f24sm1598209d50.6.2026.08.26.08.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 08:32:18 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 06/11] smb: client: fix OOB struct field reads in move_smb2_ea_to_cifs()
Date: Wed, 26 Aug 2026 10:31:42 -0500
Message-ID: <20260826153147.4112943-7-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826153147.4112943-1-sorenson@redhat.com>
References: <20260826153147.4112943-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The while (src_size > 0) loop guard allows iteration after
next_entry_offset advances src past the point where a full struct fits
in src_size.  Reads of ea_name_length and ea_value_length on the next
iteration are then out-of-bounds.

Require src_size >= sizeof(*src) before reading any struct field,
and reject next_entry_offset values that are smaller than
sizeof(*src) or that leave fewer than sizeof(*src) bytes remaining
after advancing.

For calls where the server returns an EA list with an invalid
next_entry_offset, the error returned to userspace changes from
-ENODATA (getxattr) or -ERANGE (listxattr) to -EIO, correctly
signalling a server protocol error rather than "attribute not present"
or "output buffer too small".

Fixes: 95907fea4fd8 ("cifs: Add support for reading attributes on SMB2+")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2ops.c | 25 +++++++++++++++++--------
 fs/smb/client/trace.h   |  1 +
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 9065c94e5ec6..efc68c7aef8a 100644
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
index 12241abb8e2e..6da395abae14 100644
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

