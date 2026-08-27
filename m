Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACE53815C3
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 02:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787796823; cv=none; b=FGwVa2JFgBcBT3sjhjdZZ7hMrtTtPD8UjrEmX4+0FekWLtRZ9Db9hkjPru6iBAsuvtjUJIcTBT0TaJ+PJYiJJrDDGtAjEQvbZ1ZaLFb03S4SvBh1WFkxx0D4twpLgfDhl/sKvLjzJJgQ75tv7cXcmbbqv/Vp3RhRViKGMsZGxAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787796823; c=relaxed/simple;
	bh=r5WyFxlK3Amcgl3/tAI4LEiiX0RhsYvq4LAbGIQ/hS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkIqoJfHEGIvJSLoGUFhzrC6Gooh6/5GSh6enetn5Xi+SSo7emgHegHvoH9erPx0iL+kKzGTY5lBexujBlrAhNXmYzmX6X6AUEa3m4WglFsHt223RxNU5t1QIdNeldjHAVO5RR5cQ7lkH6CXDQUQf4TKYQXx7qXMLvdvCuYTLF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSxh6L+F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tXfc2a4u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSxh6L+F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tXfc2a4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787796820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JbehUP7qomYIbQiqGXFb55EKFYCc8LKqBzMD3RPWKM=;
	b=eSxh6L+F2Lt1qXQv+uVqLICM6MzGQ3uWL7Q9k8cI9Tdgl3ExfMBzPQ5xV7D7x5bU6v6LBS
	TxllE8YoIUhqkPRMMv5R5SURVB5HhgN0/i3dIg1dqPsBJg4pGek6CxOC+SOUa+58zaIKno
	nRlh/+7NCFVkkjQubMf0+2+fJjQOMzc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-LsoLE3EGORy-UNU5Auo4gQ-1; Wed, 26 Aug 2026 22:13:39 -0400
X-MC-Unique: LsoLE3EGORy-UNU5Auo4gQ-1
X-Mimecast-MFC-AGG-ID: LsoLE3EGORy-UNU5Auo4gQ_1787796819
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92efd2ca21aso290002385a.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 19:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787796819; x=1788401619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2JbehUP7qomYIbQiqGXFb55EKFYCc8LKqBzMD3RPWKM=;
        b=tXfc2a4uhle16h2IM3fTRY1t7EdReewjOUdEt22LYSrTtQ9jXe9WaNHsdCJ7QB4jBq
         d4GoKayJoobrhJFmWLthyUlxdByUEi5GPY8bmpyb7IW1+HV6rTxlZSHWQV8iVrsnVUSV
         Uc5AaIO/QOadeTF1oHU1psEGTUDhl1kQdBujj3b7tRIkmK2FM4mN2/olfAtFm8zDQ1Ca
         3MyMwXDtk2NKm/Ga/2bh/tzouEHISQaYxHGUqRcV7BspHH89RYay8yCZOms3UK2UztHY
         3b2RaLfLvpLS/kaOQZt0H6l1fYzZKdi9TuAn40rUfvbEClo0reFCedzF+fzuKF9YKcEP
         NDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787796819; x=1788401619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2JbehUP7qomYIbQiqGXFb55EKFYCc8LKqBzMD3RPWKM=;
        b=ZUFeuTVpFYoSkS94nPQfr42iCZXOAY8Eo+KWISIFiWhJ+COS99RniYIPef0t2cyha3
         JX+7Sw5fC4bMidnMoFNropynzDiIwvIihgPdFBSygBABLSp9N+4JSxVqwoLOFPbkPaju
         N2GgG1GXFy5b59brLSAoCuNOaZsN23U2ybpvOTFiFhTztO66jbffqk3O5plPQ2wBREmc
         Piceugq9PFideu7DMJJlRX5bLehI2fKbG6qLmfKxwcF6ULT5E84mqgcB02Gc3N2nonsO
         H9dJbooFe87uDO6P+4bu0/FSMVe4JoAnO/vUTY7vI8TW54peT+eDps/Yj2WDuT+tRLbt
         SH4A==
X-Forwarded-Encrypted: i=1; AHgh+Rq58svZmq3osgLoW8TYUVe8iBJc2BkD12SYwBEG7mMelSaKkhcrrFtk8Eagv0YC7L6s0wX9IpA=@vger.kernel.org
X-Gm-Message-State: AFuF++nsEvAMlptYycnstBlcojqC+HYn2S4+4ESM28ePtp+br0UnEdBh
	KttLyLNAt/kFSMCIbgaaK1JYhfLy3PsQJY8+gb5KP6NMcX2zQcsw+RcQk1tiCZBpV5HuQaEWoDx
	WjbNybeaTfYQNXaR9Iy//deB8ibqxpgLHA4o0m1dMM2SRN7xUIfhx7tycGg==
X-Gm-Gg: AR+sD11sfAxX9NCcgPXbKkmdrbe6gvEiOvZPol+r7UnQDVR2gDdo77WECa/hwmIGw4o
	Eq23DBTSneHZbOIK31TR1xke2yCEQEiO6nq1uQxQQhxElJsBwzCOiTiEjfHwEfVzqZ/lk4CUL5y
	GnuzuqIo2wRTU/LPHS+3cO5jOe4ZG9RfTewDkvNbIxmR09AylGT70NAqeBQygfUMTf1q7tDAmr2
	yEsPyPNX1NXot7PZ26W7kxYSWy+6wUQB/aNEi+01nfFrfgkISykBx16rRSFafeFhbo2gPYdJvS8
	tylRIJuSuFFT1LI3h9qCk77Kp/3zR357tlzUOAyVeyL0puaWnQ4fbcrJNrNdgxmggkBK6TUHigj
	NzcmT7hgbU6Zo+WSrhjuxAL6aP3gwnzPayFr3xYomreim4cVEG7BLL/spBSVV
X-Received: by 2002:a05:620a:4f3:b0:936:dbd7:fcb3 with SMTP id af79cd13be357-9378019b06cmr895173485a.21.1787796818972;
        Wed, 26 Aug 2026 19:13:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4f3:b0:936:dbd7:fcb3 with SMTP id af79cd13be357-9378019b06cmr895171385a.21.1787796818570;
        Wed, 26 Aug 2026 19:13:38 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377f1d1419sm338623785a.12.2026.08.26.19.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 19:13:38 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] smb: client: fix heap overflow in cifs_do_set_acl()
Date: Wed, 26 Aug 2026 21:13:36 -0500
Message-ID: <20260827021336.82730-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <4475a3bab754e633b20f78a6827cbc75@manguebit.org>
References: <4475a3bab754e633b20f78a6827cbc75@manguebit.org>
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
reproducer script which sets 1800 named user ACEs will overflow,
throwing KASAN error or silently corrupting heap

v3/4 changes:
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

