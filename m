Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF27B37EFFE
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260408; cv=none; b=rQ+B0lpzP3ZTsBqtK+6KBuCmQuRq2sl8SsS3VpcbvbDmMms50B51IRstv+q9hYltDYeT4xCgiLjjrP0ox/Qw4aNnGCD+uh0ttgzPt6cjUrEBSAgBdTUi2S6JMz8KczZ0RCn7HixfoeVzfwrsykeZIZIsSxOPvWjAKc0y4pqObXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260408; c=relaxed/simple;
	bh=FBkoHbnBpCFZvPSFxK+guNXnNiRJjA4cBZij8IaL6/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Keglq4UNSMY1NhzkO7X1bjfr7hphbWoEVgsymWGgPLJHtqBTm4RIV2Qkkwo9cRsElZVraRO8rD6dw+EFqTfjy7vsjIsh3Qn7UNOQChWWiOsUu+bowArBa6eDEPEAm7yetXhbaWvL36IQDw3E9cTAMPjdYBFbHgVxF7UwKaJExFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGktlWfA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DsLiAFbc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGktlWfA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsLiAFbc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787260405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iALMLjNa5SNcOPSPrNeVDGsUnkRgdfi+5UonJPZ+nEo=;
	b=QGktlWfAgKW2Ziq4iaBz9SJC0bLPm9hA6piMhHtGHuQYokhR3Imwmqot6C9Fpgz9Bb2vPG
	kt5IX3TEqerwTECjhY8FDfFkK37vu4I7O4fIFOBLX434F618msqYs05kr5oI7+1oBLgjUj
	F2AUh1kJVG8+67xCOeaj5qFmEQSCvWY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-2PeYSJ_ZO3Cq_7MjS0QUeQ-1; Thu, 20 Aug 2026 17:13:14 -0400
X-MC-Unique: 2PeYSJ_ZO3Cq_7MjS0QUeQ-1
X-Mimecast-MFC-AGG-ID: 2PeYSJ_ZO3Cq_7MjS0QUeQ_1787260394
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4a7c64fbbc6so529905b6e.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787260394; x=1787865194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iALMLjNa5SNcOPSPrNeVDGsUnkRgdfi+5UonJPZ+nEo=;
        b=DsLiAFbc6mcDQBqfL3kpK0tNSykVxl4NfRjSgDNb0DuYq/KdbHyvcVQ5XqBJhEjBtE
         rhL4YdSKiLQQ9UnFPMy+FAf4SvZUW9CpjM2cPFNxVwSqtuVs9O11TPKG/BuUtCI7REsX
         xVWznpb/RfvSRrDbKN6SMWOGgNAWhbEqoiD577ZJEsmgAm6Tc29fs4/2zBxL+k3PCzRl
         cnzpUsmVREoUhBsnAnFSuwCUpZBKPOMYEV+Vz9tJWK+MhA1miJw1IOj6bD91EVe/0AER
         PlXFuyPdY2Wz/wZc6jUayexbtiIpIkJ4eKGna+lOIEXt3drFdC1OSOi1ahaYSS9+uN8N
         BMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787260394; x=1787865194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iALMLjNa5SNcOPSPrNeVDGsUnkRgdfi+5UonJPZ+nEo=;
        b=F3Pq9JNcClzaxOHjLLWbPCUNXwk8rOMiZf2+gNfBq+KaoZ1BOsvmLuzR45SIgV1G8Y
         nvWRY8rfMZsJaOmKLbVBA/jku9oXiJCJlSbgc8GdXPmMewlyfyjBBQNRFTKzAmRxjwjn
         NpGwc4HHb/rqfISD5JZAtJNm94cuQJ8HStV/lI3Lfc7YKWXu4N7Dp3IjGQi1sv/ckQYV
         nAT5tvtn1hLSuRSkOBNt8tONroHbU9ExSOoOPgIhf7di3Kv2dI5TEzANrQN0bQR1FScO
         WiVgoCL2sD1E6cxQzRcL32yj7B5HUbELp6zeO/dvdELr+yW02PAOpnHEA/My4EYtPBt/
         aR1w==
X-Forwarded-Encrypted: i=1; AHgh+Rq/SfLKba9+L8AIWQTLGsA8t9fDOvxoVVWxU1vQS3AGjm1zduoLqNDDymDJmwz/rMo3lxaz9a8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh6CXlKg/kSZAJYgbGj8T7SGiI+nZzomMCWij5HIVRGH+xaBGH
	icpSD5HzkoSnVXzfRHwTFNqsufrGwZD+UlhjNbF1cIu95mtH3gbRHc5XzSHMv2GHyXdsoyyjZRu
	yWfj592kzYWpa3UJ0p0GOxl9y13V8JNfzemr8YFd3jVUgtBm8cITSGCBA+w==
X-Gm-Gg: AR+sD13INDRig7cZ4DMwEEN1Y8aGKO5RtbjMO5IfyuCDGFM4q9Qv8OCHlwSEsDcH0vi
	eDa6xNUM11T0PvRdxpjDFZKzG07vRkdKmqj1pMcCC5McsMUfrrHlbkZZ9VLkJYa4EqsTA2NiVCR
	FHoabASkHUkvrBQpgadrKklu4esDFM3jT0b+lAjDiB0pkpwACM2myAkUwq4MNJs+bBEsfULgtRg
	FXLzpeoLulyTgrhuSI7Dh32QTz/TJiP2GV3KZmC2fGUQ0VtrcLN2szllOeOrzJz89kQmtnFRm9K
	vPUHwVs0S8Aj8oULTH4WclUSBf65rhmDuxkewSCltI2usRcr+hqtcDmoCDIcX8HXvNkdCF1e61D
	gH4weehk5VungKQOG62tFw4ZYFTGxwEYC9ovpoaQOEehBCSMfJ543ftS52GMp+SV4ew==
X-Received: by 2002:a05:6808:13c2:b0:4b2:6ca6:9cd8 with SMTP id 5614622812f47-4b2ef25db7bmr1099578b6e.1.1787260393745;
        Thu, 20 Aug 2026 14:13:13 -0700 (PDT)
X-Received: by 2002:a05:6808:13c2:b0:4b2:6ca6:9cd8 with SMTP id 5614622812f47-4b2ef25db7bmr1099547b6e.1.1787260393363;
        Thu, 20 Aug 2026 14:13:13 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d6711e15sm2957409b6e.1.2026.08.20.14.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:13:12 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH] cifs: call pagecache_isize_extended() in cifs_setsize() when extending
Date: Thu, 20 Aug 2026 16:13:10 -0500
Message-ID: <20260820211310.1471930-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cifs_setsize() calls truncate_pagecache() but skips
pagecache_isize_extended() on extension.  truncate_setsize() shows
the correct pattern:

  i_size_write(inode, newsize);
  if (newsize > oldsize)
      pagecache_isize_extended(inode, oldsize, newsize);
  truncate_pagecache(inode, newsize);

pagecache_isize_extended() zeroes the tail of the page straddling old
EOF.  Without it, dirty bytes in that region can be written back to
the server, exposing stale data in the newly extended range.

Cc: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index d459b6f602ca..a5aa1ae23c5f 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3059,6 +3059,8 @@ void cifs_setsize(struct inode *inode, loff_t offset)
 		inode->i_blocks = blocks;
 	spin_unlock(&inode->i_lock);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+	if (offset > old_size)
+		pagecache_isize_extended(inode, old_size, offset);
 	truncate_pagecache(inode, offset);
 	netfs_wait_for_outstanding_io(inode);
 }
-- 
2.55.0

