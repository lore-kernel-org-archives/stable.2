Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21C42D77B
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694217; cv=none; b=lWRzp5kbk4iedFhMU9rmElMtAmNLjUvqCs9v6Dq4jLUOtc8lLTY7upwpwHHwKqut9BdUPnV7LmC9wvakHTpbtUZ9mgRjxW+Uhg+zwDT+ahfY5Znu6m2cHE9RwO1cLpiYsZVm1sPnwZlYo8CkFNj/8otCdKAoiOd5B5OS9Ap5frI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694217; c=relaxed/simple;
	bh=wjNucUp39n3xq8EAzxorvaJGmmTgMK02D5HVAfhjQVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrII+BY/uuUGK6T+hzsesQGDB2m7f19MS2tKkb2s9PN8ZpFGQwgpYNvev6Bdr3zdfXQc9Dq9I0e42sZkY3PGde6UgS9b5Xr5y4mt2I9kUJ2jUnAC9RNCd5v7rADj4I5rPRpWIPQjVmBI0u+gpANXaIWU+RykYAsTnJvMKJLVbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKaSS5Pu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbYcUmz+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKaSS5Pu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbYcUmz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787694215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbvycVzqf4hPEetyb1QBcOfC1HYJJLq/kySscNL5C24=;
	b=eKaSS5Pu+nYqd1IChehFFNZvCoK3SwPLmnv7pDpWghQxGUuv+dlduLG2pf0tuLgChmSX+m
	n/Qj/2a/YC7hAeuS9NCBBXjOaQf7hBoB6kCsoq1Y+eQkUariXYpYvCUWigRXHrT63+D1YT
	z/wHEcT47dlefcUpm7L21louh2mxUs0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-NX-8_LC5NxGu4AmG6e2AAA-1; Tue, 25 Aug 2026 17:43:31 -0400
X-MC-Unique: NX-8_LC5NxGu4AmG6e2AAA-1
X-Mimecast-MFC-AGG-ID: NX-8_LC5NxGu4AmG6e2AAA_1787694211
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934956beec8so38597585a.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 14:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787694211; x=1788299011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PbvycVzqf4hPEetyb1QBcOfC1HYJJLq/kySscNL5C24=;
        b=LbYcUmz+/GXBuCLdrt6wROabzkYmsoMOttzY+0J3x/diPctYlQS+gKSZSkHjmpagOL
         /8LRTzr+iwY1JxF6hJVRD2knw1yiUlXAket8KiWaXWfQoyOKeAfeffU5GmdoIEGf/HnZ
         flT/R5KJkLD83or+c+2g4Lz0Qd1wcBCN3n7k4p561SVtz2tBYQlhB49VYEAe5Lm/1JSD
         Y7nQyKNAlZf/LeM6wlItXjv4i4qQjMaRfSDBnsWtp3kZcg8NRM5db24i6YSO3E+AhSK7
         kCbJ2rMvaahPv4+jw3zTnkGVnx8zGG9fgcDYJVnRUDJGyQySRxm/EezA8IgukamNAqfE
         rwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787694211; x=1788299011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PbvycVzqf4hPEetyb1QBcOfC1HYJJLq/kySscNL5C24=;
        b=T/2w12N+fsmOQ6QU+YkIiclfRqfjvJAmhjsjhIfLf+xOhliWpKRwi0JCtq7PwnQh4P
         PIdI1QapmiM8Wr/DLS/POwn4V4VRjlCX4m9RVpCBvMNvf80TgI5zehTKIbeErUtwZk/9
         1MIhtHvUoGpeHdErxO3Op/uI8FUm+mrHLOVjaRfWG9p50dLHpjWVORCToOaeLW6kWWIF
         weso4k9PgacBimizAhY0/P/It8I+n/PDfqfxPNbF9mm0tJ2YsxIMlDmfQpDoTGGuDHE5
         L2l47nGJUNBZtvPJd2z24w1OAIn/44EVxwQHcLkO/lvXGIoFvixi64LFGrOn7ThILUCv
         4MPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGNY10aJkeepeUe/lbKh0GRZppIuFxpMboGyIcMXEllyFNpbg9iyR+zXNBzBMQakJpLPD4f2M=@vger.kernel.org
X-Gm-Message-State: AFuF++nt8ZgRhSfZHLEy1ss7O2WsYTxd6gNAfWKYpkwOIKyW9K0LO44a
	iKOvHIUaq5WzV85CmCTEGuxTx4GH1O7yrxj1QGt/OdZVTEstqqHyLYGtJgZU5Ja9DzGzun/naFm
	EeXNpv3ckTWoNu15I+miNDBL1R2XClRApU2EJxOKtOi90r1Pb9NTA4BFzKjd+mZGbcQ==
X-Gm-Gg: AR+sD13khI5dODiH3FD77u2HSIrIIgket0BNmpmy2nW8xAen8Nvn6dayUQXDxBsYtjp
	e3j3/zT49y1YJGRTI5a9xpP5V9RnRnFrPllDm4SHmzUHKHigb2YG7npT1t6zUoIvoF5sMhBIs3w
	my+l2L9xXeRCbx44pSzPTM4uPuOw1S+ShwV0DMWS4nL5pl+7DM5izxxftD2DfPrIiXEL2joth67
	hnw/gm9g1OfGBUovXo7kSNRW8EnAoztQKRhMxjGzK+DbGVHzFVyEYFdXzz2uSHUmHxDmEf4jDjA
	TN5kICSIJWAc6gkOZUaFKYy2bFW4gT2a1d208AQgCLPzRj0udVhV1aWulJe+H97zq/T/1psJYJR
	s+BTUFdO2yMWonmLiu80H5rphFXf3yaDRKwEGpMOovXIxijkIOQ6yfdCilQpH
X-Received: by 2002:a05:620a:f12:b0:937:19d3:3fda with SMTP id af79cd13be357-93780490ecemr158851985a.28.1787694211088;
        Tue, 25 Aug 2026 14:43:31 -0700 (PDT)
X-Received: by 2002:a05:620a:f12:b0:937:19d3:3fda with SMTP id af79cd13be357-93780490ecemr158847585a.28.1787694210602;
        Tue, 25 Aug 2026 14:43:30 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377f217c5asm59929785a.15.2026.08.25.14.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:43:30 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] smb: client: fix heap overflow in cifs_do_set_acl()
Date: Tue, 25 Aug 2026 16:43:27 -0500
Message-ID: <20260825214328.3852168-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825183229.3799705-1-sorenson@redhat.com>
References: <20260825183229.3799705-1-sorenson@redhat.com>
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
v2 changes:
 - Add USHRT_MAX bound to prevent u16 truncation of data_count for ACLs
   with more than 6553 entries, which would cause a partial ACL to be
   silently applied on the server
 - limit MaxDataCount to min(CIFSMaxBufSize, USHRT_MAX)

 fs/smb/client/cifssmb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index f5aad5f61dce..621aca5d3b75 100644
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
+	bytes_available = (CIFSMaxBufSize + MAX_SMB2_HDR_SIZE) - offset;
+	if (cifs_acl_size > bytes_available || cifs_acl_size > USHRT_MAX) {
+		rc = -E2BIG;
+		goto setACLerrorExit;
+	}
+
 	/* convert to on the wire format for POSIX ACL */
 	data_count = posix_acl_to_cifs(parm_data, acl, acl_type);
 
-- 
2.55.0

