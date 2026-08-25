Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C35122D785
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787682757; cv=none; b=ryYLpwbWeAeRU2rdOnWlzTljEOxem6HBU/OAqxb3DvqhB+FjFOq6UNz8t1nRyQENASKcDsuEyE8d0squNL2khj0wcwJYpKmqy5azsSubVW5J0Y3nBQCnX7eNvGlUCairAYA97KPfBlx2n5WE3LyWy2d2YeFEJEe62aRLNjgS5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787682757; c=relaxed/simple;
	bh=PEUh5RLGTVidTbS/TJT9PVJi1gQFkodyRDfs9AfH9W0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kwlaOXxN3BAN3fhLzlVTE9qMeddTFzJHyG/5Wk0C/f1mUU9518GqdMPtJMi/awy6zHFKX3+JpCVPclPJrN+2vfnU6+6RV/c3I3jN5Zrh39Q5AEy3fHD/V5ILKPfwuSmu5TVvTgZnt6y56LP/1JIUUz6BNk95ysNWAdtWmcDcak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dal9Q50D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1cC7LUa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dal9Q50D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1cC7LUa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787682755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w+YMnu6id4V5XvUuXw+f6RGrlFEPCBCMRJX1CXIFo/0=;
	b=dal9Q50Du6F8VNqgG/2BBs57FNIZW+dLj4jq1gRV1NnVW3fiH7VQ4o2HTF3OdVY9w6Ien9
	mjJ7GYRXHEvOYNiTL5GV+BYE3+wR0dEnL3cJyilxcJf40OcMNzk0Jin1xqWyPfkjW4hiWF
	SRb3wZ3AVFEsOXu9jTnYPkD0SRzHlwI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-buLVv2RVMxSlJVCJP8XxZQ-1; Tue, 25 Aug 2026 14:32:33 -0400
X-MC-Unique: buLVv2RVMxSlJVCJP8XxZQ-1
X-Mimecast-MFC-AGG-ID: buLVv2RVMxSlJVCJP8XxZQ_1787682753
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-907c59bd73bso2220506d6.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787682753; x=1788287553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w+YMnu6id4V5XvUuXw+f6RGrlFEPCBCMRJX1CXIFo/0=;
        b=P1cC7LUaBMS/bemdbt8p0lP9ItP8vkiZnrrvyqKby+G6k0rwMWBM1wrtLxbTmHglYS
         vnHT/h0FKoU6phXpa3zShHDOp1zEM93vziiz1ud/wwPe4pPcB05VkElUS3jucSZmmwdC
         W+A6nRb6eYtvxj1cQTnEBcckde8TTGjS6e+U2fE80+jo/DGEcMfNpSLgBwqK/x/k/aXk
         4mC5yqrgvhZXbmaV+bt3XWDQ+O9j9WUNXCxQtZuzOpaJvI+zTTLrnMg7ss2Dl2T9ZMrr
         Auj/1VGcwB/RlMA86VmhPqMEFkw6QyLRsWdAUt+UFu6BSPh3CAttEgH7VQXYRezACYdZ
         /ugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787682753; x=1788287553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w+YMnu6id4V5XvUuXw+f6RGrlFEPCBCMRJX1CXIFo/0=;
        b=s8mCXJNonCU077Llc54dM3lkiZjWf5JV/C8x8lp3Bf0wn/m/hpdS8wLoB9G0nNYfYj
         /c5aXHVW3H/6TDDeWGkDl18e/ZWi7T6yByhhSsicXVXEjsXvFgnbmdD3JhIjI18ez+pp
         3eCYOxLPnz/0pD+7hLqldmh524LfpJ6j4G4fWr3qXETxsAKoQPjjQ9mxFue3g+CJFQ3e
         6zwbzGIPQ4ULraQP+E3ROK04KTCd3sF2yuu9/DEDZ8pp94OLAFOEdICENMDu5Xinl4Ba
         iIUwdnO+pn7qEpxPDJrL+Fvl1t7pmgtIuKut2yTxnrtrPNVvRWSYRZhDzMTKfOW75mhp
         Hw+A==
X-Forwarded-Encrypted: i=1; AHgh+Rrj+nlEWtY03lTilMe/d8Mk0LDRpqt5PZzc/wgOelmngJM3JcH59Msg6gsgMnbGmaOGmaJ5Pnw=@vger.kernel.org
X-Gm-Message-State: AFuF++lo5HjQXP6VTuVLImVKFfU9LKe+XjG/YV6AZf9ENkA0OOpxwqFF
	5FUBXN/o9/LUYR34Gzj6Ocn6sUeL6/+O6zoqr3PbrV1HWT+BWwYI+SKVLi40gRMV0qvlZ9qJm5q
	zJb8IUoUQGapXHuYeOxi1mkVpONvXZzbtu/1fuTfltH05GV+M0xl/S6YCCg==
X-Gm-Gg: AR+sD10I6/PbYI/7fJCoWjOAO3qBKYHfD7g1AUk926t6hspkReAb55qMJN+oZK/eFJF
	QkLTsAlhVIANy1IqvtwmCxq6kVIkKCYG9LazImVhEy+X739rz73P3JKR/tkces3D1+4uowXjZrD
	AE4sZySobIsvL0VHVASkuX2QsFQV9Pj98I2pt4LurkdmQF6MK4Ia0KWsc5FmLLDhuJ3EO8C+9RY
	Ewv5vuQ/ffwBLq+oGZbtZQSJtwZAipLEk4KiaWU3zfE0E6hPZPApWA/2n5B+awQ+e8E4fheKXyd
	gvLsBhSFJ2CZ20W0PHiNQRx2fuZPnt7DIxuL3XZ/nstb4RpFbYCxXVFBZ0gj6iI18FmpyMLVl6m
	mwKdhc3yXtygOt+9h524Oeza9mv+MlDs65G7h6tuW6GKdDW+G3PMuMrrOFz3x
X-Received: by 2002:a05:6214:4608:b0:907:c0e1:62e4 with SMTP id 6a1803df08f44-90cc792d3e7mr7220706d6.9.1787682752999;
        Tue, 25 Aug 2026 11:32:32 -0700 (PDT)
X-Received: by 2002:a05:6214:4608:b0:907:c0e1:62e4 with SMTP id 6a1803df08f44-90cc792d3e7mr7219776d6.9.1787682752382;
        Tue, 25 Aug 2026 11:32:32 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc641a940sm5250666d6.20.2026.08.25.11.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:32:31 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: fix heap overflow in cifs_do_set_acl() from mismatched ACL format sizes
Date: Tue, 25 Aug 2026 13:32:29 -0500
Message-ID: <20260825183229.3799705-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cifs_set_acl() validates ACL size using posix_acl_xattr_size(), which
computes the Linux xattr format size:

        4 + (count * 8)  // 4-byte header + 8 bytes per ACE

But cifs_do_set_acl() calls posix_acl_to_cifs() to write the CIFS
wire format into the same buffer:

        6 + (count * 10)  // 6-byte header + 10 bytes per ACE

For the same entry count, the CIFS format is ~25% larger.  An ACL
with a near-maximum count that passes the xattr-based size check in
cifs_set_acl() can overflow the heap allocation when written by
posix_acl_to_cifs().

Before converting, validate that the CIFS format size fits in the
remaining buffer space.  Replace the bogus hardcoded MaxDataCount
value (1000) with CIFSMaxBufSize.

Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/cifssmb.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index f5aad5f61dce..4ce22fe3cb2e 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3555,6 +3555,7 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 	int rc = 0;
 	int bytes_returned = 0;
 	__u16 params, byte_count, data_count, param_offset, offset;
+	size_t cifs_acl_size, bytes_available;
 
 	cifs_dbg(FYI, "In SetPosixACL (Unix) for path %s\n", fileName);
 setAclRetry:
@@ -3575,7 +3576,7 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 	params = 6 + name_len;
 	pSMB->MaxParameterCount = cpu_to_le16(2);
 	/* BB find max SMB size from sess */
-	pSMB->MaxDataCount = cpu_to_le16(1000);
+	pSMB->MaxDataCount = cpu_to_le16(CIFSMaxBufSize);
 	pSMB->MaxSetupCount = 0;
 	pSMB->Reserved = 0;
 	pSMB->Flags = 0;
@@ -3587,6 +3588,15 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 	parm_data = ((char *)pSMB) + offset;
 	pSMB->ParameterOffset = cpu_to_le16(param_offset);
 
+	/* make sure we can fit the larger cifs_posix_aces in the buffer */
+	cifs_acl_size = sizeof(struct cifs_posix_acl) +
+		       (acl->a_count * sizeof(struct cifs_posix_ace));
+	bytes_available = (CIFSMaxBufSize + MAX_SMB2_HDR_SIZE) - offset;
+	if (cifs_acl_size > bytes_available) {
+		rc = -E2BIG;
+		goto setACLerrorExit;
+	}
+
 	/* convert to on the wire format for POSIX ACL */
 	data_count = posix_acl_to_cifs(parm_data, acl, acl_type);
 
-- 
2.55.0

