Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9464D48A8C2
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594513; cv=none; b=TTgtGgNJ56TYgf4UHJOGKkXeLkEEAnPI9gwddoAYRY28RQKZ4f4JZdrcQvt4vfvi0PfqlHVOnDOfSzfJEG1ItQ28TBBh87vhfmitj65jUghHYlXsGJjjOaiSSvowpSe+yLyikbU630OkDwuWgNTrQFILXelyIuk7QjJsghXTJ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594513; c=relaxed/simple;
	bh=Sj36XIv5xMRsbs/wOZ+6qit3KbIBL5gKeu9FcM1KgZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYAnOsS52XKdbYhME9mxsJrpg80ozXQi2b9O63CSW2b6ah+OHfIhuRhz0LiNMc1vAe6lMazFUpEIv+l1xbzOjl7usJortHfpEnoogOpUBCXrLSkKq7xj+WNYti/Rc3dFuhunBOPrU229y0jKYKy+SXuJvS5471DR7V7d5vIZ9Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VCMj0XYv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AOFHv1O9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCMj0XYv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOFHv1O9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789594468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWuq6vDDxC9a57mHhVLz+GoF6OV48cjZqu3A8mCuPWU=;
	b=VCMj0XYv4+o0VRiSyxYQ8oie1P/uWIcdgz1q4Sa0qFIFBZqw4gtJYU5QuOYso5pYpl1KDw
	N4nMz4GeRGMLmK8el4odtkEbI8jdGp0hCoJSnbDHuUpxHvrzjX46KAQ602uW4/Ozjwt/9D
	p87Yt2mCKxCutzF1V06CICpzDaTihGc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-s8vRlHMuN2G1BWWi-iR37g-1; Wed, 16 Sep 2026 17:34:27 -0400
X-MC-Unique: s8vRlHMuN2G1BWWi-iR37g-1
X-Mimecast-MFC-AGG-ID: s8vRlHMuN2G1BWWi-iR37g_1789594466
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-530e89b584cso1329071cf.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789594466; x=1790199266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZWuq6vDDxC9a57mHhVLz+GoF6OV48cjZqu3A8mCuPWU=;
        b=AOFHv1O99acR78ioweWCdpNcVQf87yKqTPpsULQFgfx5fsCsrzk8/i7Yy8mfcaC02J
         wNyM1JePFTCS2XAVEh1gDJRcFP4vE+3ivny8BIqkAJZ4tkSJmIyKQ7pKPMffPr8nAgpr
         6j9LwRqmFkDOZzXsxItqCBJGkKAisyl+8CAroxhlYURfOkQrMK8ELWdrIR8Y6m3TMpnL
         ZJw/N12V2y4wg/5B9Megpc94FBhOOVniXcrS6F8EPoAiii5J2Ou/YR+6CwEPb6poH5AM
         FXDFVZAX8eAUq3HSxk8c8h3Kji/MA4v5vOFtHRiOU+iXAILAkke1H8SYyi5HIHlKg4+3
         Y6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594466; x=1790199266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZWuq6vDDxC9a57mHhVLz+GoF6OV48cjZqu3A8mCuPWU=;
        b=cLbmrNBiJCH2p0fdgDduyYuSh+u3CHbnXcmmj7lOSI1pvTu7EPwwfZZ/xJtVnaCahz
         EHcIHaaKDafLuwBMm2Da2Q9epIhPOTNXKCIfKx92vqhFL4OKC9uKw6qQnQ73upukxGIv
         rUc7FdPEb5kqYNroKaWZ2Hd3wWnyLg278snyUH9f0rMfmj9O3yAXBP8N/XocQkOP5gT7
         XvJ9ZYSMjlQ7tOoS6MiNbXw4+YHNjp9/0gHHrNxHhX19ZL47ewsXEeFYc9cuhSPbNn13
         +D+coDUMawp9k39amK/Zf7VUnV2TXda7gSJ8omkfXE93MdcWRmbvNEcqqmSnO6YWHfRa
         el4A==
X-Forwarded-Encrypted: i=1; AKwUvByL/gPNxpDnRjygKvFG6mH12mRG8PtBUeOZPC7o5hXLEo7HUgJI7N0O03L0J3kl1hWiksDtssM=@vger.kernel.org
X-Gm-Message-State: AFuF++nCjIPmD3cfR3TO8ZsPfwVetWwiRrW/BAQIMlngIx81pcjc9UDL
	ek22A/aH4sEbiIrOkLYD/slxl9jKiA21I4o+s+ZvY0GrHDb5+CT+hWG9blO2Qohx/hSzYT8brkj
	n1DK3Fk0L0EBG6lbOIqdJGjaT7GMJwGJ3yrUKiXTRCeQU9ecacksHAbtpog==
X-Gm-Gg: AYBFou3mgnXjjDEFrQjFlYw/0BZAovOSqvApzcmGjUpaBS9oJ44T8LPVHOoP2pdKxR0
	PS7wY47X4yndk6hqxdAkLksANNefd/5x6HsNdSVpDNioXqG0e9RiBa//iJ+Nn0IoAMrsEHrgZok
	EpkOUi/IFTbLQFE4XSCZiHaGKfze8UP2tlHsK0ACGXMRBP1AuLV8QtR9HXNeIWS30TWutwlSQmN
	J/MM6R0//SPOkti8X2/bz38uSynAiuLvNsayVmuTBZ2G9i6WjRdziVCJlDc6aXJI4OjbqlqLNZu
	SZ7QKF3V+yeT4wn+ZnbJV86/STcdGLeZtkoDxcuLeOHH/EMS7doMWQ8IYSjzjrCyyParOxeCqHC
	60EuCAgdk3xDQ/9RZ8tkKdBZBscHInilBQKHfV2V1N5w62BHbQIQC1rQrZ1JyeqffgA==
X-Received: by 2002:ac8:5dce:0:b0:532:7ea5:f35f with SMTP id d75a77b69052e-5327f260c84mr75271261cf.24.1789594466553;
        Wed, 16 Sep 2026 14:34:26 -0700 (PDT)
X-Received: by 2002:ac8:5dce:0:b0:532:7ea5:f35f with SMTP id d75a77b69052e-5327f260c84mr75270711cf.24.1789594466160;
        Wed, 16 Sep 2026 14:34:26 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532620d4cbbsm32447431cf.28.2026.09.16.14.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:34:22 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v5 9/9] smb: client: fix reparse buffer bounds in cifs_query_reparse_point()
Date: Wed, 16 Sep 2026 16:34:00 -0500
Message-ID: <20260916213406.1496960-10-sorenson@redhat.com>
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

