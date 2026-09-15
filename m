Received: from mail-vs2-f24.google.com (mail-vs2-f24.google.com [74.125.227.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD23DC85B
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488039; cv=none; b=hpL8IJZYzR+rkaDU3P9sLoy9SPItRDhiIqA5aA2TGU5nQsSlDuiRnAbuU6zXueXx9/Ny69wtEGhi8Yzx7hZTxAvuK0Fcz2f82w2SwP3E35eXsVSi5BKQf6PAibLl2R0kPFl87UwcxAdjx4rbJYcPgxIgPoqVymHol8JWz1XFTAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488039; c=relaxed/simple;
	bh=yfFk5AxqlgLH6I0x387ApOK8n1uXyoBrfJ8SxXsFVWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8cXJ6560xDxx5nsBlUsofT9TnR4bOLKeeR/hldSkfK4VcLMhStnoqIi5d0uQPiXvsMYekUKTVrMVXYj3ZSH3d5BVx680w/lgr0GDq2GsNZkyocYPXt6CYoCe0ZS2UqkmCUwLjkyQchnlWqm+CRd/3ZTebWBwxTVTHI4U91uKZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V778B1OD; arc=none smtp.client-ip=74.125.227.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V778B1OD"
Received: by mail-vs2-f24.google.com with SMTP id 71dfb90a1353d-5c97b28165bso415574e0c.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488035; x=1790092835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GUDKgi5BjwUlGqTDW5BhogeZ2whULHpHZjtGCCfq9RU=;
        b=V778B1ODwI61E6aMAqmTiLs8Ib1DHBkTN+zCMxc2VH0ukbB8PxBIMjF6I5UX3Hv8iP
         +T3mMtZO/6Su/iXOaAGRYor7RhusIWSNFgCm8jRnYJ+qE0O0UWpCfMVOHNwxj5VBdt/0
         sQxyQdfLJVsXwD3wGVxb7XalIjMwmO29npEmmwkh8TGfbQyFSs8+V4b/9L6UmdLLgGLu
         EP4R9pwGEe+vk/cL04CSNkBwWDxETr/cS0bOMt1Tql23kTOZ8M7iC5rQFQuUP45+Fb4H
         IxYwFvZJcDsUnin/x8uuv2O7C1djgMsI/sRaNwsazQ5lvRiKIKgG25C7vhNy8yUg3pzH
         dutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488035; x=1790092835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GUDKgi5BjwUlGqTDW5BhogeZ2whULHpHZjtGCCfq9RU=;
        b=ptzO0+1ylTAlYi8a0puCXtJ2S99stB6ie4NPcnHx9M89+FQBvN+5T+451+4TPpxO3w
         /UP2oMQtx0o06I+mGBl5gkFVbfNa5BOSLu1C7FWtxgNmIPYlNkCo3/6qRyt144luWCnh
         sjuBl53rhqCCOrkcjomBYxC9ttyDH2fXhHrQWoe9rY4TwlRKQHjn5fqRIAPAbUsi0JmQ
         PNtHoV+UQNJcKRPckqT8yzFiXank0OgtFJkI1uZ1QflJN1Z1fd7oGpq2SeuAeYESal1g
         43K9ijzx5AD9g0/+Oyh1kqP31m19zAPgE5zdIHr3mI/S+Ldg9QWKRZalDCZr15cDA64W
         NBew==
X-Forwarded-Encrypted: i=1; AKwUvByBw8U9n6sfZEU7Nzm49dc5lVNAFEZ0xL0GQV9qRHHR9XrdOn7KfjFXwYBBRZL6M3ZvUHKgtHo=@vger.kernel.org
X-Gm-Message-State: AFuF++mRaNyyI902dwoXY1G98il/fKOhQfnTrXbbJKFzAWw/Dm0zwrFJ
	DWXtoAqOf8PHN+D8V5CZS30dn3aGgbNwk3V6dfnkObFu6Mcsjg93P9A8
X-Gm-Gg: AYBFou2uxI9vpaMaRUxVqm6cQ9Pd+t0P01B/7J5M5f6EtelNAtxS3gz3zjbxg3qhbbh
	mcsRnCAIoSMl269qV4F1G66g6obo/Sq/AH/qN9fi/7BifsU4PWyPTuhVZYJEKPvC/dJIPdaQyQb
	8DCObikjO0XbOWRbg87hTP3YJgY7PzrQXg9fmvOcYJqkqJShQGNbSmwP3Ir9WlBlmVf2bJ+Q11b
	FSY6tXCZGhFggW+IGXeLKp4PwOpNV2NjltT0KfcPI9VZp+nIQv07TnKkoCxOeAeQWzv6NC+rgQb
	cbnL3TZBommqPU837O1dMqrsV1xSH0yXYoVk2uWI9xpme1iNSXgbAYa4UW39XsaRTpgfmp/7GT4
	D/FPrSWgjZ9LQm4NB0ZpCJUkDwasDqLCf5+VotjJykdYOdfSncVen63ob46SYEca6xo2I/pxmI6
	uMI43Y5KJ9M7A5dhgvuv9vmzZPvBPreyCrS9dhDJ1ZqHVQFs2PudO/DOVxKoB6np7vN874dIh7n
	2y+
X-Received: by 2002:a05:6122:488c:b0:5c7:d204:db7b with SMTP id 71dfb90a1353d-5c993c0c81dmr3441065e0c.3.1789488035334;
        Tue, 15 Sep 2026 09:00:35 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-982ba1789b8sm14883192241.13.2026.09.15.09.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:00:35 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] NFSD: copy SETXATTR data from all XDR buffer segments
Date: Tue, 15 Sep 2026 13:00:22 -0300
Message-ID: <20260915160022.3105295-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfsd4_vbuf_from_vector() manually copies the head followed by whole
pages starting at offset zero. This assumes that all remaining data
starts at the beginning of the page array and that no data is stored
in the tail.

However, nfsd4_decode_setxattr() passes an xdr_buf returned by
xdr_stream_subsegment(). Such a sub-buffer can have a nonzero
page_base and can span its page and tail segments. Ignoring that
layout can copy the wrong bytes into the value passed to
vfs_setxattr().

Use read_bytes_from_xdr_buf(), which observes the complete xdr_buf
layout.

Fixes: c1346a1216ab ("NFSD: Replace the internals of the READ_BUF() macro")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 fs/nfsd/nfs4xdr.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e17488a911..0f9f926cbd 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2288,10 +2288,8 @@ static __be32
 nfsd4_vbuf_from_vector(struct nfsd4_compoundargs *argp, struct xdr_buf *xdr,
 		       char **bufp, size_t buflen)
 {
-	struct page **pages = xdr->pages;
 	struct kvec *head = xdr->head;
-	char *tmp, *dp;
-	u32 len;
+	char *tmp;
 
 	if (buflen <= head->iov_len) {
 		/*
@@ -2306,19 +2304,8 @@ nfsd4_vbuf_from_vector(struct nfsd4_compoundargs *argp, struct xdr_buf *xdr,
 	if (tmp == NULL)
 		return nfserr_jukebox;
 
-	dp = tmp;
-	memcpy(dp, head->iov_base, head->iov_len);
-	buflen -= head->iov_len;
-	dp += head->iov_len;
-
-	while (buflen > 0) {
-		len = min_t(u32, buflen, PAGE_SIZE);
-		memcpy(dp, page_address(*pages), len);
-
-		buflen -= len;
-		dp += len;
-		pages++;
-	}
+	if (read_bytes_from_xdr_buf(xdr, 0, tmp, buflen))
+		return nfserr_bad_xdr;
 
 	*bufp = tmp;
 	return 0;
-- 
2.43.0

