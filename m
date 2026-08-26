Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CF230C637
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758356; cv=none; b=bwN08lNIMAE+573O5fMXOFPD0Kj+Wd+97ZFYA/1ig2JRja4/7Fun118/ONxvRZkJrkzl5AzjhqlCckYIjS/w6tck2kFlRTv93d1phlcQYytsBzeqOvSzCA6McNKwdDjknKWNxhhAsvldU85lOI40hLs7bJ9jgFD2WuuvnMKXZmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758356; c=relaxed/simple;
	bh=X46Y9UPqaWEp+RoT8wQkeUmW9xAe3RHJI41PgATF2Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s645Eou8i34+B+uNPcWIEO/uqre/R3kybcyVLNIGu0ZLZGQ9BAqElSPWVGoLc2QBDKK2RIDLdPQsj1bWlU4BQaSqD0xl5y/2b11jVVOh6eayTvHQQuZwagNwA3AHRALEGfEGpzAExK4Q1Md3BkyjBADPqjzA5/aatt8PLAidyvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NkjipSt7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bNYYkybR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkjipSt7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNYYkybR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787758350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Dyg+7DU0ehSVNy9gSlT1aHAOzEStc2HXXCnV8WDG4E=;
	b=NkjipSt7JppJi9dN0kyhii7cegJiIpOH1ncsOlM1bEtxFIk6Ikj93z2KHsrfnmHoVpifD9
	N0e7XdIow3q66Ckx7VKjWoRW/d1wXf4q6OANt3/OD0u0paVX8RW4ml2Zy1VqHHYNsQOCHn
	Xf2TeaS4j3k8UtOaCoCZfGOY6yrVeuU=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-lpG4CvCuNqe6zZg3GB2ICA-1; Wed, 26 Aug 2026 11:32:29 -0400
X-MC-Unique: lpG4CvCuNqe6zZg3GB2ICA-1
X-Mimecast-MFC-AGG-ID: lpG4CvCuNqe6zZg3GB2ICA_1787758349
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66d13b52185so2404178d50.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787758349; x=1788363149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Dyg+7DU0ehSVNy9gSlT1aHAOzEStc2HXXCnV8WDG4E=;
        b=bNYYkybRg5e9rZSWJjdDVb62lvN8imjAbi6pF4PmTASyaGDYuxNbho3FsRB37WVmIW
         V6grwziaMAs09pNt+QLLgOJ43o/ei2McKiy4+dcQRKS2vY679iI+XNJYcwDir6VDfyfh
         sHCWMmIP9ZYe/0UmHHk9ofFCUaclE1+SgRYUYo0r1NPB7pUdOQRfbi7Z0l7pqqf8fhqC
         Mt3bh6Di79/r+dtDkerGbmis554ClD97RAgMI2/miZoQnUi+cz4hy8QL782n2o/p15xL
         53950p3LHXrDTTEz3rwHQVr0O3UUrKTr5KuqQfsVpha+Q3Tiiit86UM0G2zq1CIy+2qy
         sQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787758349; x=1788363149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Dyg+7DU0ehSVNy9gSlT1aHAOzEStc2HXXCnV8WDG4E=;
        b=T6/SsMkCIK6QkzfLr9bWtLIm3Qr+q2fOdBIn2DiNX054ZdDeLb7oSRk8M+ZXPKzp6k
         rZNoV2JcSdN+4da4nLU1lEpBJWakMKNojK/u/wjZAAJL8G36V9w3Dns/1lBUcOhttc4l
         xG5wxnYd4rrJe+hzouEDKY8yWobfSZqQJkt1zgT01dbZIKH9gSH26rzWhE42D7rx5B1u
         TPozsBOUIvpwt0ZE5YPyJqKe5Iq9KR/+Vxn5uoXJQF2dyuG3CoXnjSsZJdo0FQVWRdiR
         k+9LzWUi68Mpdi+eZkqA+C8LWCUepFY38spoCCvRNvDINfidVofdU4pew/O3SKrE8Ksg
         cM0Q==
X-Forwarded-Encrypted: i=1; AHgh+RqK9bM1vuHQ5qgv0uisGlbai+CVhSPsO+HocTyU4qeqIotyCw7yCcQd24seaacFeAMY3fF9h/c=@vger.kernel.org
X-Gm-Message-State: AFuF++ko6JJe+iuNCVHoR0JDBlEs+OiVxvEoRVTuA+Zzl6TkljYUM/j0
	92d6ZATLkgvYgpZFOKl7RA35SoKJaJeKnnu+wwUsCQD5H23zDeRHp0EoUEBQLOvuyEPb60R6EoN
	1Ss4fBD2b5tHuEWs7aJ2SZxoHzItFLirv5wYqbJUop1X+U/1OZLHODotIdt1+NDEYVg==
X-Gm-Gg: AR+sD13uv6mRNeQVAN/i9kxtZCe+cqXePI3yv8FG6I1slXU01DahWionMAQnoa6DMm4
	IhOtDsZkSx7MwWC1a3XhY8d2mQ22bliUEYHquh3T3SG+vd4Nxz9ooxZN2coakzg/CHMwelRg+Z7
	adehHPwvnnTSIS4y7EEYrfY/YQCZ7bOoOnwtJ0grylI9p3AeJqFMeVxT8xLuscWnm8x9TsF6VRP
	mazs1CMKUMpGrnETz0HcEqTKSdYDq64qitU3kjQAPwwc1cenCBxKRByT+tjiaYFdGiwMGOj1Y22
	NbRcjkrAptW+Ff+lY6YIe7r9vLHsWnrlKXtzdnm+8CLmlDUSj5Fal3DLGc2EUAXB7JRAYY6YshC
	/QlO7Iz4JL9HogFm9zLEZTT6zgn5HFcTeidUgmn15VD5tn/jxccmrAI6wnNekSrN0ag==
X-Received: by 2002:a05:690e:111:b0:66d:7b7:e36c with SMTP id 956f58d0204a3-66d257eba9amr1967068d50.48.1787758348569;
        Wed, 26 Aug 2026 08:32:28 -0700 (PDT)
X-Received: by 2002:a05:690e:111:b0:66d:7b7:e36c with SMTP id 956f58d0204a3-66d257eba9amr1967052d50.48.1787758348048;
        Wed, 26 Aug 2026 08:32:28 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d24592f24sm1598209d50.6.2026.08.26.08.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 08:32:26 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 11/11] smb: client: fix NameOffset and Next field validation in smb2_parse_contexts()
Date: Wed, 26 Aug 2026 10:31:47 -0500
Message-ID: <20260826153147.4112943-12-sorenson@redhat.com>
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

Three related bounds issues in smb2_parse_contexts():

NameOffset: the existing 'noff + nlen > doff' check doesn't prevent
the name from starting inside the context header or extending past rem.
Replace it with noff >= sizeof(*cc) and noff + nlen <= rem, keeping
the name-before-data guard only when DataLength is non-zero.

Next: a non-zero Next smaller than sizeof(*cc) passes the existing
upper-bound check but creates an overlapping context pointer.  Add
off < sizeof(*cc) to reject it.

Dispatch: when DataLength is zero, calling a handler that reads the
data area (parse_lease_buf, parse_query_id_ctxt, parse_posix_ctxt)
reads stale memory past the declared context.  A rogue server can
craft a zero-DataLength context whose name matches a known tag (e.g.
'RqLs') and bypass the name-vs-data-offset guard, causing
parse_lease_buf to record a lease key and state from uninitialized
kmalloc content.  Gate all three dispatch paths on dlen > 0.

Fixes: af1689a9b770 ("smb: client: fix potential OOBs in smb2_parse_contexts()")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2pdu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index dea05aeb53a1..dda7a1a88b44 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2459,22 +2459,23 @@ int smb2_parse_contexts(struct TCP_Server_Info *server,
 
 		noff = le16_to_cpu(cc->NameOffset);
 		nlen = le16_to_cpu(cc->NameLength);
-		if (noff + nlen > doff)
+		if (noff < sizeof(*cc) || noff + nlen > rem ||
+		    (dlen && noff + nlen > doff))
 			return -EINVAL;
 
 		name = (char *)cc + noff;
 		switch (nlen) {
 		case 4:
-			if (!strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4)) {
+			if (dlen && !strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4)) {
 				*oplock = server->ops->parse_lease_buf(cc, epoch,
 								       lease_key);
-			} else if (buf &&
+			} else if (dlen && buf &&
 				   !strncmp(name, SMB2_CREATE_QUERY_ON_DISK_ID, 4)) {
 				parse_query_id_ctxt(cc, buf);
 			}
 			break;
 		case 16:
-			if (posix && !memcmp(name, smb3_create_tag_posix, 16))
+			if (dlen && posix && !memcmp(name, smb3_create_tag_posix, 16))
 				parse_posix_ctxt(cc, buf, posix);
 			break;
 		default:
@@ -2488,7 +2489,7 @@ int smb2_parse_contexts(struct TCP_Server_Info *server,
 		off = le32_to_cpu(cc->Next);
 		if (!off)
 			break;
-		if (check_sub_overflow(rem, off, &rem))
+		if (off < sizeof(*cc) || check_sub_overflow(rem, off, &rem))
 			return -EINVAL;
 		cc = (struct create_context *)((u8 *)cc + off);
 	}
-- 
2.55.0

