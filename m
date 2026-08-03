Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5319C54E
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 01:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785719297; cv=none; b=cQQfcy+ZBepNGqgg0wndRFdJ99NEj9jIlWyziu5OKkxpiNNBtjWmwShrY6SaRBk3uKovV8HMG9F/oDHCyck2+aWaONni1gfTS8LlBFWmbTa4jxqOGW7pHUsr4sLsLheNK22hwZYU/vtc0HG7s/6T+t1oUuq5nPMUJWNsLSZYbSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785719297; c=relaxed/simple;
	bh=+AFzDGrbgbHQLozO+hvwKZjMsyx+HPtIIlmA32AFNUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p+FomxfJDhZwgApZ7rjv8JBYrEjshwesFPujgkC85N65vBWBGB7jK6er+cFiGYGEaE5PsgL3OV1wGcsW6yglLPMPhY154DHG2hbStXSZ9C2wgsiu3vM+Q4mNFeV5R/G5CyDccOZQUk7NMhKtWa4QX4C/Wij6gi0uNVhkFHZrdHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGchWIBb; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGchWIBb"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e602d2c0fso208244685a.0
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 18:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785719295; x=1786324095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lYgwypkukQzkIFuPlBn7zL4zFMnuhc4d9HofrAew4R4=;
        b=JGchWIBbr29MfVoRdiSaBa8bnjA78uptQZILcXzUcQZJjQ2+C8yA2MhzbDvYtUcC72
         k+/a13EuD+Gndhowz6nYU+IRPBWk11OBFHz4Wss9P/anuQcTkbwaDKIiOUao9A612Fnx
         IwCVfS/yKrkEB0n35t2B6/cOnuHqRvZXAWHnIgA5RiAK4kXuFOgdOeH40ojovO/w9DNg
         iEK/zj6vUPg9bUMS4CKIDmK+KSq58C1PMkTyiT0CEE6+/mY6d6vYNnH3MSIwOP7mi/S2
         ITk3+w7S+WL+Zzsz1Ge0NMySNbv5O19Z1zZnRWG+MpxU80p90LVEvDcmcpGgkwH7Dacs
         gyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785719295; x=1786324095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lYgwypkukQzkIFuPlBn7zL4zFMnuhc4d9HofrAew4R4=;
        b=e7hp3ZHM2vMIuQLZW099xHovTHRZrQRxDRWAV/hhwMKaKv4zIuywocBqsxahwkTtv0
         cKz/UxcIGgG2lu2W1pB+C2Tn3dRC7KIyyvxti3L7IJPsIhFKvLAlSQr2YVtwJR+rfrA8
         bsbQb7kqg+jl+l1w46mnqyID4Wico4HMQejVqvZ3BIXrlu9EMOCw28Pv68BuC/vmtin5
         z2r3aD2nFUEW86WHkNIRZ4Pki4ra8OPUMIInLdgk995JA5T20pl46alXFfeXEpO1KgU6
         4jVOEnUQzq7GVRfKjecYX9oVFK2qvhSQLVoM3CsTY+byj7OAFfVB73iI1nPKpvPrpiJ+
         0awA==
X-Forwarded-Encrypted: i=1; AHgh+RqsH0pm1DxmSzDe78R9Sc+XuFIFSKrK4IVOv5EaQkGgChGrAsxZU11uf1XfXH8Oa3zbDJ7dmZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8wKZAe+BywFzEAmxajCeuhS9mgMxSdd3QDnMx1/HvrW4zjnyc
	U8VLf8NyNHldCRMLtloLTrm5ts3ejM9MsexEok7mIyK0tkiOgtw0F1dJ
X-Gm-Gg: AR+sD117DD7+fE8qQPa5fTFJ1Pus+Mfq3MTJghq+1xum8rc9KL4ypp2hroxp0CZQMQY
	zes0xF0HLJZQ//BzPxlwBo4ZQuxog/GidHc36medSSdXvvh2kGDFCqdNlYAknTkr+gVjYtBG9//
	Z6kMghaBdMBBjbkU6e6zmgXobZs0tlLmqImVzKHpGlkQt6FIDR28vcO6AYXSMatBNuy/sbXEBQb
	MMJQOcR4om76ke+29IthRIdjhzToZWicgsmBu2AGP0cgfX8wriLvSxfjk9Hwz+PgfhrBRCwBD+S
	pSziRr/8NYPg8wkOUBWRrhcC1JgAP+sQilxmK+krsIzmxEc8POT6u+Bvx67JYvNGG14iaQHufDX
	pJyQNR8Z+m/itvudjPOghwD5p/Aj5s+/ccg57jOf4Zgdk7yQzSuDkFdAeJ1LYb7GcL/B46BDq8q
	EqBXPGc+MYR9E5OaMbe9YcXkOYG9FunZ/gqVW0fE82gu1tz38ZBKW9O2uUXT6nyq7W/zXJpPEjD
	Pzq8ijRVZtizoC4BEvy3QXGrVMg7qJWzQojSZ4hUow=
X-Received: by 2002:a05:620a:2590:b0:92e:fed1:beba with SMTP id af79cd13be357-934a0fed2b1mr1245344985a.3.1785719294578;
        Sun, 02 Aug 2026 18:08:14 -0700 (PDT)
Received: from LAPTOP-DPAKMOI4.it.purdue.edu (pal-210-106-74.itap.purdue.edu. [128.210.106.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1e0e57sm552635385a.43.2026.08.02.18.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 18:08:14 -0700 (PDT)
From: Yifei Gao <gyf161023@gmail.com>
To: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>,
	devel@lists.orangefs.org,
	linux-kernel@vger.kernel.org,
	Yifei Gao <gyf161023@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] orangefs: fix double-free of trailer_buf on readdir copy failure
Date: Mon,  3 Aug 2026 01:07:55 +0000
Message-ID: <20260803010802.2415942-1-gyf161023@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a readdir downcall, orangefs_devreq_write_iter() frees
op->downcall.trailer_buf with vfree() when copy_from_iter_full() fails,
but does not clear the pointer before goto Efault. The waiter in
do_readdir() is then woken with a negative status and frees the same
pointer again on its r < 0 path, causing a deterministic double-free.
A client holding /dev/pvfs2-req triggers it by sending a readdir
downcall whose declared trailer_size exceeds the bytes it supplies.

Clear the pointer after freeing so the readdir-side vfree() becomes a
no-op.

Fixes: 382f4581e67f ("orangefs: rewrite readdir to fix several bugs")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
---
 fs/orangefs/devorangefs-req.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/orangefs/devorangefs-req.c b/fs/orangefs/devorangefs-req.c
index 33ee8cb32f83..e5c60da7e677 100644
--- a/fs/orangefs/devorangefs-req.c
+++ b/fs/orangefs/devorangefs-req.c
@@ -474,6 +474,7 @@ static ssize_t orangefs_devreq_write_iter(struct kiocb *iocb,
 			         op->downcall.trailer_size, iter)) {
 		gossip_err("%s: failed to copy trailer.\n", __func__);
 		vfree(op->downcall.trailer_buf);
+		op->downcall.trailer_buf = NULL;
 		goto Efault;
 	}
 
-- 
2.43.0

