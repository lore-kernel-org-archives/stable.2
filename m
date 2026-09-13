Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB226FD9B
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335937; cv=none; b=pvvN7D/83gBc1gjw3WCvmHSEQJEqIdTGffbGDlUQt7IXF8v1y7yXfi47yE/WU0S+MUYUrwaRLaNJzcbv+9FegqLir1c7089FC4xNbTXu3zxszxEH4nRSEjdSFn7QPC8ZGA483ZH0QP3bLy2nKzSfqTWUYgaxKQlmC9dqEljwCFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335937; c=relaxed/simple;
	bh=Sj36XIv5xMRsbs/wOZ+6qit3KbIBL5gKeu9FcM1KgZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNZ/cMGbKw8HhkhmcTKnnMHrdZJNrIma+nok2zHjs0/G2OSbEnZyFn6/b4FsgZXxsvL5VHzO8xyE0bvHL6Pkrxb4DlLikFMuezqkLC7/uJwfsz8S7KUgJSgWsTbaXwT7uiF2qNh8thvGEMze2jb5VpWIdghqzLCBtOqhJQSIzoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WfCc3BNc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m8tcJdpK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfCc3BNc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m8tcJdpK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789335935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWuq6vDDxC9a57mHhVLz+GoF6OV48cjZqu3A8mCuPWU=;
	b=WfCc3BNcqjh2Dmm7IB07uva6GJolDRggoIrc9UPIYcQBwH7L5+KFiJ9y09i1JnlBsRTQnP
	QFg2/G2v0xIoGyd/h4flBfWAXa9Mwm2JKkDkhlS7kW0/RpVR1KbvQZ9AqLj3HtFtuIAgIN
	5u+eEJC3+B8KKCexvOSwMWwdCdAoqT0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-EKDd2JJrM0yU5TzT9j_RgA-1; Sun, 13 Sep 2026 17:45:34 -0400
X-MC-Unique: EKDd2JJrM0yU5TzT9j_RgA-1
X-Mimecast-MFC-AGG-ID: EKDd2JJrM0yU5TzT9j_RgA_1789335933
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91213a1aa68so36262466d6.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 14:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789335933; x=1789940733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZWuq6vDDxC9a57mHhVLz+GoF6OV48cjZqu3A8mCuPWU=;
        b=m8tcJdpKOloXXB80jxqnv1dOPwQljVC9tarIqRNvJBbGK+K1Kc8wLh+dRtyzr2EDST
         FoAzdCb7v3llFaIB4I+7M9xSQToHDvWJa4Zjqvo/EeBVZ7yE9lYl0HZN/kv6J8kHmCyn
         GKOvirEhXd3A3at2Ffc8huVe+SzWtNNhlZxBRLmcudNq7M4FQovUwCjKdoB7ZbppNuAd
         IHIL0qG8vUFYLMAIqRPqzUO53C7nJzAa9fPFgil7OhlEPJiUROE20vp+onzZ+k08cfKM
         Ckd7HqKieQ7qkoxmOkFi68qwFN5xhZmyrG55F/wOc68OMCCjE8emEIjSxXEfR5Pd0MyG
         w9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789335933; x=1789940733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZWuq6vDDxC9a57mHhVLz+GoF6OV48cjZqu3A8mCuPWU=;
        b=eE50UYee4FjcsH4h6zpQT41GYY30CbCxlzUM8kIV013wMKySC9X4ZbXnKmoR0NlNlT
         5lF0WFOlnYMm+yHz1uZ2Sno02VEeitq0nnzreiFziHjJOA0QwqLDBguwxBHx/WUWFRQa
         HWMCiSFFkvbxrFhbtHXr2sO3EJrRKGdz0b1i+jHh5nQxSdLkFcTA1m6B2OLsKdXxC6Tf
         2+tG6QxEu1vHcmzMAcFpZ90QFH8upEtlzQV4ptDevWhPhtx+oZawMZLm5xOB8/gqI3S3
         hpOh4UDlhmXLZ2rO+G73WAJsicCI7lsbrzeJG/pBORgv3ERchMbaCgLva+SHu2zWdBjF
         d4jw==
X-Forwarded-Encrypted: i=1; AKwUvBwC0gtWIqzx2M5WXfNqM7B7q6hC8GXM84sVbFs2QuGR+bhFfRAqJFOcqcLV8qwets5qz5EJKqk=@vger.kernel.org
X-Gm-Message-State: AFuF++nXvxZ+Q6tPBjIUWm8mh9USXd31HSsE/rDub0vOvlt5c3/ZH65z
	plWxKFp5NKBIM1LgJ1lPopWY3eLKvx7vYXeQhKpZGaYc2e7U00hHV0yjnYOA59MMEVreW5zTcPa
	/pact+TKC5jWJ+j2JMvlPCw5N50frrE01VVaxM4JVhNnVqhUjPi4ppeSTVg==
X-Gm-Gg: AYBFou0mKMMfyb1KD7dgu+XFyDerqftjSYQvnQanc1o+924YNHzsUQMke2clXB53MMZ
	23YHCEP7k3Cjo3Cs4ZlhgCgV4EAruvJa2mPq4ZR+3RwVdEPNo4ifEbCeQtW4uIPB+uFS830hwu7
	xRXuJgSlXtoX67uRPiIe3hEtNue0T88not5xU7lJF89YaUSFvT2G6B/cvXYVq5qSheHvP9xs5kD
	OjRBPQ3iyccfAYg9XPm+BOY2vScX2mZHfB5auRfMfH19HCHuCJ29sONa/EEtoJNIMbj9PAG8FGJ
	t8C2UEMQ0cBjBsA3gj6ph+qtFPqdIdigZbGdYqM/+uc8UdjHj0ukb54JDKbiwdN3Wlq/xRAn6nk
	i0YmU4sBNorpvGJnkA5o7gl2VGtd/Fd6tRKm4tYsxzYk4m4qkBnaAyp7mG/XJtb25Pw==
X-Received: by 2002:a05:6214:f64:b0:910:3452:d57f with SMTP id 6a1803df08f44-912120efc7fmr264356646d6.31.1789335933395;
        Sun, 13 Sep 2026 14:45:33 -0700 (PDT)
X-Received: by 2002:a05:6214:f64:b0:910:3452:d57f with SMTP id 6a1803df08f44-912120efc7fmr264356406d6.31.1789335933009;
        Sun, 13 Sep 2026 14:45:33 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f49444bsm78581126d6.29.2026.09.13.14.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 14:45:32 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v4 10/10] smb: client: fix reparse buffer bounds in cifs_query_reparse_point()
Date: Sun, 13 Sep 2026 16:45:08 -0500
Message-ID: <20260913214510.3071370-11-sorenson@redhat.com>
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

In cifs_query_reparse_point(), the start >= end check before casting to
struct reparse_data_buffer * only ensures the start pointer is within the
response. It fails to verify that there is enough space remaining for the
fixed 8-byte header of the structure.

If a server provides a DataOffset that leaves less than 8 bytes remaining,
the check passes, but subsequent reads of ReparseTag and ReparseDataLength
will occur out-of-bounds.

Fix this by ensuring the remaining space is at least the size of the
reparse_data_buffer structure before accessing its fields.

Fixes: c13b779d26b3 ("cifs: Fix validation of SMB1 query reparse point response")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/cifssmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index f9aff0712794..6dddbd84b93b 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3080,7 +3080,7 @@ int cifs_query_reparse_point(const unsigned int xid,
 
 	end = 2 + get_bcc(&io_rsp->hdr) + (__u8 *)&io_rsp->ByteCount;
 	start = (__u8 *)&io_rsp->hdr.Protocol + data_offset;
-	if (start >= end) {
+	if (start >= end || (size_t)(end - start) < sizeof(*buf)) {
 		rc = smb_EIO2(smb_eio_trace_qreparse_data_area,
 			      (unsigned long)start - (unsigned long)io_rsp,
 			      (unsigned long)end - (unsigned long)io_rsp);
-- 
2.55.0

