Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABF8312807
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758352; cv=none; b=XvxWU1khBkjR4DkfCEzncXHUsB9owQwvwTR9JHf5rH84tG5Tn0R9rpZGbCZxMvj8u7PJVfiSYbFHYg9Eb+fqUmZ5Ec6/MBlPJgLSjoJp1ZURi2m0U1ZesYycYDtH+dWUuDlVhYEJxD+P3TIiD4j0xNWyv6OegXCJ8WLngAw5eOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758352; c=relaxed/simple;
	bh=Nhk1B4KT6xQJgxBOVM+nH1Tz88/S2L+BL2EbB5HvWXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDXyNOMWXwIBZmiONdT7qjb9VHInnVgiUZf/M1NFyGOBLVM9V2unt+etAupJZRutzW9QjhX+z40EM3lbIc13bK+V6CNw8UlUk7qAq7mJPkhH8x8iDyXTz0e6147YnHrivQMFnpsyFqJgPBu5y0L7LJ9X67QUCudJRKbvNumz66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSfAMEMa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rquDrTFe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSfAMEMa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rquDrTFe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787758347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4QAga8y8B/crqtjyLgFtXgIcP2IcPU8Wa1eVgvxjKTw=;
	b=TSfAMEMaCcIkAym58Gdglr7GVRQgv4yvvnjoWI7qUC5Q+mpM2iWwpYISduGmneO9rhVgDH
	cXnzzSPpPfvL/H7pnzvuOIRoK3TxyadooW2RNL81u0jRuEzH7NgNKvGsE71/VY3tnxeGxj
	4wY6T/YBGVTng+A3VuZ8lG0xmvnRzM0=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657--hYxpIuaNJmCmuMfgc3QVw-1; Wed, 26 Aug 2026 11:32:25 -0400
X-MC-Unique: -hYxpIuaNJmCmuMfgc3QVw-1
X-Mimecast-MFC-AGG-ID: -hYxpIuaNJmCmuMfgc3QVw_1787758345
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66d16ed0d0bso1221995d50.3
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787758345; x=1788363145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4QAga8y8B/crqtjyLgFtXgIcP2IcPU8Wa1eVgvxjKTw=;
        b=rquDrTFeuWsAJXjh3WF4aTtZKlIU36GNQtDV2Vg75l8jgaX3/4onGmglvsKrd9lbAk
         F/HN7gd7xYOhxx9BsEH2Zz8mjwjc9hmZTkn1CTvRtRD6c8bPJIomBTJ2m9OtX9jHjmUM
         BZWT8zPHGaPxg9udsgs0lr25+whAH8iWM3b1yVCiU7864rCU3mN7WRInEf8uqnWWV9mE
         f8V06eHz2kXBytTfV+CfUiwPo5ThDdVq9hhDlMW6hTsS9A69zS7APlZam6kmzBfMZPsa
         yzY1JlWJZu5xU/lMRchhtRRpwbnrw7z/AIJov5FKJBeN2OKI11jjIzq0XKveVe+IwzAG
         25ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787758345; x=1788363145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4QAga8y8B/crqtjyLgFtXgIcP2IcPU8Wa1eVgvxjKTw=;
        b=lZTRE2pdVwubYsVp5UsGQVlYkWHiHna/nY6FqVeMvPX0YpmhR+BXJbufWDBHCuFMWH
         w9NRDhg17lD9f1GcCRZRkoUvqSCLGLlPHqPq+smu5mqTIQy1MCxcC3JpR9XxC3XfgDQ7
         N9AdwDd3ip8MIWWW3BbxwBxuHsBOcSZcn6WGnixpTsoh/UNjaCmZVpsnILMF22xKIUir
         4ubmAloyJy6CujT2QtTk1gJibH32ORatah/zs8D4TdDaowVjKc31/4xunMU6Cdj7OrQm
         QzlunTqn2Z/6X+jjylr6+mXUVonLTAyXgaGuNmEp8sXgk3AjTcl8QhKc+jiwgozSGqU4
         a+ZQ==
X-Forwarded-Encrypted: i=1; AHgh+RrLRw+x3LHfU+YNbGj+t5T9/+FPLB5CmI1rqgTFmxokbEJeMyC0/TRdA3PVfTMCYHfjM0DQkw8=@vger.kernel.org
X-Gm-Message-State: AFuF++lzZpy6WpLbkE/y6bOJQiLj+kOWKlUtlsHkmyz91oXiNCtjB/dJ
	d4deqGlC3ssJB6X81puQbUekm/PoqiIPukpwd1W2R5jyyDTIISh3YvLYDiCEUtf5PNAIPhTPv4I
	2da668NdXowFpJrPhpzk61M+zoWDqW3re0ezuHnU2NtMhujnSAzFRFJPS4w==
X-Gm-Gg: AR+sD127Ix/2/AfgRIBeutuCl3dm+ywKY987Jbk7njtRy2Tf/qhVxFMKe9kH8hpd/7N
	dYrSeD48rrZve2rka+O8qdmhxwmEHsgqW2mTrkJN2YoATIh0etLhHxHMJZC+Gbd5wsEd5vRqh3n
	T2gEyKWHQ7ng8NWHpeDaUem3jRSUF0AYvPFSBBui4Owjq+b3EZ3scBRfp78EdMkwtf+umc1bEk7
	nof7M4G7uFCzLr8KfO1/KJWmFFtYPeqPQMksZHdAA9QCCwfGfbu12vHBkwhurIFyzSNQS8O+IM2
	GLR8ZyVYa2Grbw243I4lsHDn9VDjSBHPlYGeIwfDhBAe5X99MGzc1XtLZXycJZKSy8YA1nhXVVs
	PgCvgBaPXztWbQ2S3yayZjn7bHZYGKFCYnFGsGeVvdEjAafwCvhc5qs/Bel/M8aB+5A==
X-Received: by 2002:a53:a812:0:b0:66d:2276:bea with SMTP id 956f58d0204a3-66d25785d0dmr2053962d50.35.1787758345185;
        Wed, 26 Aug 2026 08:32:25 -0700 (PDT)
X-Received: by 2002:a53:a812:0:b0:66d:2276:bea with SMTP id 956f58d0204a3-66d25785d0dmr2053932d50.35.1787758344739;
        Wed, 26 Aug 2026 08:32:24 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d24592f24sm1598209d50.6.2026.08.26.08.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 08:32:24 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 09/11] smb: client: fix potential OOB read in smb3_enum_snapshots()
Date: Wed, 26 Aug 2026 10:31:45 -0500
Message-ID: <20260826153147.4112943-10-sorenson@redhat.com>
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

When snapshot_array_size < GMT_TOKEN_SIZE, smb3_enum_snapshots()
unconditionally sets ret_data_len = sizeof(struct smb_snapshot_array),
silently inflating it beyond the actual server response size if the
server returned fewer bytes.  The subsequent copy_to_user() then reads
past the end of retbuf.

Reject responses shorter than sizeof(struct smb_snapshot_array) with -EIO.

Fixes: dcbf1c8af18a ("smb3: add ioctl to get a list of snapshots for volume or share")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2ops.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index efc68c7aef8a..c866d7c8c7dd 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2382,8 +2382,14 @@ smb3_enum_snapshots(const unsigned int xid, struct cifs_tcon *tcon,
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

