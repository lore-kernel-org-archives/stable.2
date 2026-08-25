Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEB13CEB9A
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695987; cv=none; b=edDCcAReKgcbZ3lMsxWzhzaC10Mp8pSzT0S48Ux5Kxrw4EPelC0ba34KzOt/3ZQUcanbLc392n1YaLiFtp+3Kkm04mK2xEkLkLJqpJtqkzaKx1n2jvUU1gb7ma1hP/ev3/ZBVHuYWXRCmHntbui9efiDwPwcRyWv0JAD1y89IXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695987; c=relaxed/simple;
	bh=gm26qQiiwKEYhHZMZb8w7wMtSk6o3tA87DkPepM1DIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HN+QGhnd9ASgQJniQhzi0i7AGhqu1OsKUwAIjGYzYNOZEXeCcbHviscs703/4XfjyVizs6Qmo0eCOvhNInUkQn+gdwmoezagWEZt7oigy5QZKN0vcVsIQ2djloWIW639SPCGaoZtT6mckMwOcc9QbEMoGAjgU5ZpKR0YMTfdujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KWHJLt3e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y4l98uqC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWHJLt3e";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4l98uqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787695984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHn5uWyTj2Tgmniq47Pv+Rn61JDZfNSE6Z8AvHiyjIQ=;
	b=KWHJLt3e4JMTM1a2C2W7JuslJxDODHdSIczoINZgDmb2F2CfXka5ZGqXXh5uh1lTDFInNa
	kpmWjK50hdpWaJLKWVO/NAduQYg7CHzKoJZMaQ03Ir0VpALH2D3gTk4OYWLWaEUPWcLccp
	n2ie1M0WY1c0WIXQ0UfPqesmrfSiuMQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-VgleVgJvMeiuulXoWVXEiQ-1; Tue, 25 Aug 2026 18:13:03 -0400
X-MC-Unique: VgleVgJvMeiuulXoWVXEiQ-1
X-Mimecast-MFC-AGG-ID: VgleVgJvMeiuulXoWVXEiQ_1787695983
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52e2d1bdce2so3958431cf.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 15:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787695983; x=1788300783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xHn5uWyTj2Tgmniq47Pv+Rn61JDZfNSE6Z8AvHiyjIQ=;
        b=Y4l98uqCMiFyjZopsME6j5ty6F6mo2VotlzmAEotDoalBa6EfTyUuly6eikBhSlDrP
         x+hK3qoO941yGB60FxfJlc0HmbKfZX+cig3omt2ag0e0A43zX2VcyNSbbN7WOr/2AsJq
         9gLz7nLK4SV/tIpGIJmvV9PtL13RVn9JITs75VAe/W0y6fVnhCNULYYVKwMGNbxQ1aK+
         8jY7EiQmZKIBXCO1g4uuyA4Y2Xr6qS9rzS4lN3zYAJ+HnZ8wluz2xw3doGaVN1RAxPMU
         YIFUQzWQjGD3kzMj0WKrUZBia2CxLPmEw0drgMPGKgMUZHvSG2g0bQXbzq8y5HikMUiz
         iEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695983; x=1788300783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xHn5uWyTj2Tgmniq47Pv+Rn61JDZfNSE6Z8AvHiyjIQ=;
        b=AaIhvI74eFchq4DkGiliElFxwIZpZg4yLKquD/Q95DBBA4FnQxjWB26ke1tshwWWbO
         T5ECLIBPcqHUrlk24oW0MPBDcFYtcIzeL2ulSGsouUhHOourf1gb5vTpLAau/ohE5xnB
         SFk/Wg98ayWGDGyZV/eoZIUGxE3Qesbwu8aM8K+6qC15yMCbR+JHMT6X5drq5eSOff2U
         M1DX75ePHOZkNpg8tO8ET5cpH4wApFw6NHdjd9whUx2vBycONfjOjHMjZXt+AqSSs5Uq
         kpcwZGkffRUXiJVdb5numrjrMHrCTbkSM6DDMTMaO/DDXImZ/++L6XoPX0fsOI6yoXAh
         JB9Q==
X-Forwarded-Encrypted: i=1; AHgh+RqxgDVltdCZ1c1gL1iuPOoOZvdJM1HPckcFLsJSk56dRzE9fJxDCZorudrhO8GJk++zhbGWEQ0=@vger.kernel.org
X-Gm-Message-State: AFuF++n6FzP7j2rPpH2eoRt81BngGRCScm0Ag+mkpy/49h1i4thGeoz2
	gqtzwD2BHXz6QYOI6giJFjUckaFrfIzBPjdq4xvDv1r2ltFaf/jLYNFtbSnvzAqxw50IShf9vv3
	WvP8i4NxUPff6+BAfEkblsywbUVKmsM1VSTSLEtOrBGmSXQASdXxZwFsbEABOPNP6OQ==
X-Gm-Gg: AR+sD13IuXaNTo3r2ID61ZduAvg5ObJ4tsWfVRoBCsHZIw9oo/j276rLFqvMxkhKa2B
	Jf2hxTDqyPaGMexzWxHQvFtqHmcjF3d5X2GEgfBNW+ErsAuhZBtANJiSK9KBLo8Vb5+mIKrr7q7
	4Iw3M1WiSieGT0Nr+6oRoBBgbrhW2Hp2q/w6nQgaT27AEZ0MDK2r9NvO2EK1UfsbtOEK1n3ynJW
	3ZZcqEJJWbWR4X7Xu00E/M3qRgsxOSo77NvzYANw1F6Xy+WrvEIS5p9G8UFruRRne+wm3N2a9/j
	JDrNBwmrKYE7BmewkVeu2sFoztigZ6aecQlYmqtxsJc2zA++8dylo6Icw6992nCbx/QWblaWW1k
	kebJiq1sfwoxh6tDTQvlDau8YGJ8AgNQePpiVaHBGLFD/6hbrZGtICgnwqvIu
X-Received: by 2002:ac8:5dc7:0:b0:52d:6c36:db32 with SMTP id d75a77b69052e-52e423f7e4fmr18394311cf.41.1787695983208;
        Tue, 25 Aug 2026 15:13:03 -0700 (PDT)
X-Received: by 2002:ac8:5dc7:0:b0:52d:6c36:db32 with SMTP id d75a77b69052e-52e423f7e4fmr18393941cf.41.1787695982767;
        Tue, 25 Aug 2026 15:13:02 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e4270a6ecsm4998291cf.17.2026.08.25.15.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:13:02 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] smb: client: fix OOB struct field reads in move_smb2_ea_to_cifs()
Date: Tue, 25 Aug 2026 17:13:00 -0500
Message-ID: <20260825221300.3860212-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823185807.3115901-7-sorenson@redhat.com>
References: <20260823185807.3115901-7-sorenson@redhat.com>
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
v2 changes:
 -  reject next_entry_offset values that leave fewer than
    sizeof(*src) bytes remainint after advancing.

 fs/smb/client/smb2ops.c | 25 +++++++++++++++++--------
 fs/smb/client/trace.h   |  1 +
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 4dd9dd55ab4d..c866d7c8c7dd 100644
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

