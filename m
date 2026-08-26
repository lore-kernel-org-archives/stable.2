Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCFF40B6E2
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756832; cv=none; b=XK7rnDYW3tQ2MshE0Tt2pLJXq4zahhUsugu5XbdRiCOgaj30bZQdyvbT611vL2/dEXXHRus3TFTb+kB0nG2KKC8BurA9vCZf7Xj3XLbF9hU0BGOFllUOdi1tmsDdwMbMHzIz+m6BKGj4fgPv58kgkpCa8CEnhDUlyqJBFR00NkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756832; c=relaxed/simple;
	bh=hEY2HRreamE/YA2RX0wgyIgP1LV/LrBrlpnazREm/jU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIuty89fPy65t95+KNscxkoSFRelHnXJ6lMhq1RvrsqASjIBgjPdf2ew72Z4Uu8D4Opdgp0e6AfehDa9KA8trwIdEHIXAD7pOACgXsouFvEkdjhfgHbf6WmoOIn2VeQO5OmjEogRW4cGRE8C7xh3R/lyB8+3Vak748+/JTkW/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtQnzige; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2hk8Zr1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtQnzige";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2hk8Zr1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787756829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M9X3mqmMZZCgAFI5YZpLmbFBmE4E/5EF49kLTlE8ThQ=;
	b=ZtQnzige/9BVNvIYNJ1xa6p2j9hpZ5afMNHtxo/20zmunOszR4HFQPSWrVyWqIKH7IPT3u
	T4LmiCKP6t/IdUTGjV2gJejHzxmb+uZzbd/ms2M+GvEWMSW8C0nEnXDFLmo0GxYbBPEswv
	9lbPDYMSPH51/18/vTqmSgpeSvbxlfc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-g_9rhEyKNgeLjaI4zIEOwQ-1; Wed, 26 Aug 2026 11:07:08 -0400
X-MC-Unique: g_9rhEyKNgeLjaI4zIEOwQ-1
X-Mimecast-MFC-AGG-ID: g_9rhEyKNgeLjaI4zIEOwQ_1787756827
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-836caf085e0so26371877b3.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787756827; x=1788361627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M9X3mqmMZZCgAFI5YZpLmbFBmE4E/5EF49kLTlE8ThQ=;
        b=R2hk8Zr1OSUsNYj/8NXgp4xBu+pmdXy4fpbJH9mo9cZxOPojFvFv8rdkIUiMxr4bPm
         /dP8a2gVtC6KkLnvdChlCrOJmQSNNMTHfYmomMkJvUmhVpzwvQ93m78TUlApR72F6eNB
         BAnqeYWRYK1YrxBqsH7GXuV6vnMXyWpcW5ARzf8in+niWjMVVJcKnkAFiovowzOkq4NX
         qAfFVFQHWEFmsfi3RXTwoCZHzMohNIYGUsqH+h/8jFzPKs2DArT7sEQ76WOGvmQYvQZP
         K58Q9//kLUGs/fCaI6epbLh1UwQlt1VxnmigeU3OXzO1Yapt7jCoeLLwAeb4MKpn7/JW
         Jj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787756827; x=1788361627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M9X3mqmMZZCgAFI5YZpLmbFBmE4E/5EF49kLTlE8ThQ=;
        b=JIpvs0SmGQroQ7EW9Xt0wun7mCcUTWfdahZODauGVxUXEnqx1bnBeagG7YMaaPWx0K
         WuW93u4TN3kk6vXkstiFm4Hf4k8Lpxqua9gUkpJXEc48vlWDg9ZqfWYKkPKm2DZWtoJz
         a0w+GJxMHogzHYjJEPavZvFLLWvZGEL6WXqpEN0OzgA3PN0WB9c+vpI5IgdA1tFpCZwy
         tAVmSDkPU5F+mrOlQ1D1JVFqtfIhCwAi22RARL3pLLiS7h3HJg4g19zSF1Aj//Es+xqd
         ElTpJGIHdGW/WZZzY6Go2G5IHtr9nKOVL6LAK5XQG3BQAbLVhtTnGZPmqkziCPeD69zV
         OYcw==
X-Forwarded-Encrypted: i=1; AHgh+Ro+rGrFP9r/xVl5FQsp71Hfs9PILq9RIHi28eO30YHGF79hIoBprn0+kpn01CkdZ9TpC1H2z48=@vger.kernel.org
X-Gm-Message-State: AFuF++kZN9M9FiZqMp4eWmkOHJFNPNMZfeDxAQgOsERtxE0PQQ/7qKo6
	KSB/axJaCBLE5nNscoMX4FwTdIMKn3LMYhmF2VofU3MQBPZd2St9q3lPh005+/tpoNjAuFJPOMg
	chwAuGGYGki9Ip083Cf1+5+FWye/EhQiZqFPGpd32qxmmUVFEvwIiIWQ5Iw==
X-Gm-Gg: AR+sD10l7YJpm5CRXmykZqH98lhni2UcN+EFsqLjMFyVd7oLHc6K4qN1Eebgsm3TiCR
	AVVgcA6Dni5RRzzfEhut8Xlr/6ux1tgDNGeOjeXQt2vYHVxuw3v4S4jeMgpA58EkC1QbwGqBdgT
	/nwWCljTrJuByiqqrxGszXIPwVgceXDmxnoo819YslXrHgGDTI3wFnXBvDKEwdn73MJHQfISl8M
	3yBnWLhmJmzRmC2wu5mxXkjWKSJYMBd0CgpqURP81jIfcuy5NL5V4LOzppMnQw0GNrOmpB+vuCJ
	R6k2IXEisuH4fbKzNR/d3zZu+GzShd/uHdZ3mffjojiNNg1tyq/BRn+5IAnL1FTsAV4qA2PnD8l
	h/GqznjLaM2EcSM8rc/mNbAR+nrn45q381rVZpq4nYljKnY+uhRvp12kWb3+ufc5wow==
X-Received: by 2002:a05:690c:4026:b0:836:ec9b:b468 with SMTP id 00721157ae682-85741d088damr27003607b3.34.1787756827126;
        Wed, 26 Aug 2026 08:07:07 -0700 (PDT)
X-Received: by 2002:a05:690c:4026:b0:836:ec9b:b468 with SMTP id 00721157ae682-85741d088damr27002427b3.34.1787756826196;
        Wed, 26 Aug 2026 08:07:06 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-857069009b3sm17968927b3.18.2026.08.26.08.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 08:07:05 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] smb: client: fix heap overflow in cifs_do_set_acl()
Date: Wed, 26 Aug 2026 10:06:43 -0500
Message-ID: <20260826150643.4106838-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cifs_set_acl() validates ACL size using posix_acl_xattr_size():

        4 + (count * 8)  // 4-byte header + 8 bytes per ACE

cifs_do_set_acl() then calls posix_acl_to_cifs() to write the CIFS
wire format into the same buffer:

        6 + (count * 10)  // 6-byte header + 10 bytes per ACE

An ACL that passes the xattr-based check in cifs_set_acl() can
overflow the heap when posix_acl_to_cifs() writes the larger CIFS
format.

Validate the CIFS format size against the remaining buffer space and
USHRT_MAX before converting--data_count is __u16, so sizes above
USHRT_MAX truncate the on-wire packet length, causing the server to
apply a partial ACL.  Replace MaxDataCount = 1000 with
min(CIFSMaxBufSize, USHRT_MAX).

Fixes: dc1af4c4b4721 ("cifs: implement set acl method")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
v3 changes:
 - change header size to use MAX_HEADER_SIZE helper

v2 changes:
 - Add USHRT_MAX bound to prevent u16 truncation of data_count for ACLs
   with more than 6553 entries, which would cause a partial ACL to be
   silently applied on the server
 - limit MaxDataCount to min(CIFSMaxBufSize, USHRT_MAX)

 fs/smb/client/cifssmb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index f5aad5f61dce..230af243247c 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3555,6 +3555,7 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 	int rc = 0;
 	int bytes_returned = 0;
 	__u16 params, byte_count, data_count, param_offset, offset;
+	size_t cifs_acl_size, bytes_available;
 
 	cifs_dbg(FYI, "In SetPosixACL (Unix) for path %s\n", fileName);
 setAclRetry:
@@ -3574,8 +3575,7 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 	params = 6 + name_len;
 	pSMB->MaxParameterCount = cpu_to_le16(2);
-	/* BB find max SMB size from sess */
-	pSMB->MaxDataCount = cpu_to_le16(1000);
+	pSMB->MaxDataCount = cpu_to_le16(min_t(unsigned int, CIFSMaxBufSize, USHRT_MAX));
 	pSMB->MaxSetupCount = 0;
 	pSMB->Reserved = 0;
 	pSMB->Flags = 0;
@@ -3587,6 +3587,15 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 	parm_data = ((char *)pSMB) + offset;
 	pSMB->ParameterOffset = cpu_to_le16(param_offset);
 
+	/* make sure we can fit the larger cifs_posix_aces in the buffer */
+	cifs_acl_size = sizeof(struct cifs_posix_acl) +
+		       (acl->a_count * sizeof(struct cifs_posix_ace));
+	bytes_available = (CIFSMaxBufSize + MAX_HEADER_SIZE(tcon->ses->server)) - offset;
+	if (cifs_acl_size > bytes_available || cifs_acl_size > USHRT_MAX) {
+		rc = -E2BIG;
+		goto setACLerrorExit;
+	}
+
 	/* convert to on the wire format for POSIX ACL */
 	data_count = posix_acl_to_cifs(parm_data, acl, acl_type);
 
-- 
2.55.0

