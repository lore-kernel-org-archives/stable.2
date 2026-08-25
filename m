Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F5031DD97
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787624971; cv=none; b=fipdMEzidbxJ9EG1tTOjkuuWwxBHWI8D70aXy7VuW/ukaFlYPGGuLNNC8A5anr18hPjZ2BKNgYmwwfEW1sVYjsMS4W3KTiEwDiq4AuhjNztJNZB2DBVK3/BQHzYEga+6T4d+y36Kd1ZztM+qTNtcJz56GaqQw1WbsBiCMW5l+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787624971; c=relaxed/simple;
	bh=M/IWYj4ph7EluD8ZT1bKyDgrsuAffstCmPuVSD/R550=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nySWikFG3edD4Jq8DMFzUtmAMYjxHm/WkrT9YdAbNN+QfJbpSVoiJqpLfX4q0sYaubFQtx18gI7KYSY3o2ZW4k/Q6QADDgAypJYhDxTrWNRcumwFOetP2Amx61Qdx4f+4VYs+QKmlE2Uzf+9hJXStSuZJ7nxfyCC0AfmjY6v8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TV3xdFag; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6nz5Scu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TV3xdFag";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6nz5Scu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787624968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gLL7o/ycwkHw6o3JwRvUs/3GQV4+FfgW/bU13Rc2JF8=;
	b=TV3xdFag7b943ju91GDzQ4bhauHxxBagtkvQ1ku12F2OtqWtmQo0GXdyfrk4tJxOFJp27G
	rztd77XXvVbFuDFYXDRF1VemyOthuCOGir0X+mqaJmTqqZ4LZbWm60PJAWpVuDKEMXlpKk
	f+jd5SYk9+v2y8SqywMC0C6Rau7/Uls=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-kT0r3nVqPgKurxdJto0Bdg-1; Mon, 24 Aug 2026 22:29:26 -0400
X-MC-Unique: kT0r3nVqPgKurxdJto0Bdg-1
X-Mimecast-MFC-AGG-ID: kT0r3nVqPgKurxdJto0Bdg_1787624966
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f5ac7354dso6237126a91.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 19:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787624966; x=1788229766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gLL7o/ycwkHw6o3JwRvUs/3GQV4+FfgW/bU13Rc2JF8=;
        b=B6nz5Scu144fUKybKMwZ6Fp3lfvbnLlZD4Mt2wc69tu5mp8V2aP1ijmi85sSJXK4aC
         TkQ2UltjmuUlc4ua3TeR7tYOEDrK62GB70tbUGguS67425YJlOPHw0BJXzjNwAkKff22
         wsIHRiyKUUgQl+2TDr2TCF1HLydpz+186nRgbKjky00VzNvWIKSyKQ9v0sI4g1ZtEmt2
         BI7v3prKXPIkwjenJmXSok3rq7ymX+5ISd5vzZ1GKcE9urLs0IE2plkhZP8p0asf/0ck
         caT3n10dAiTI7j5qU28tjUFwtdYc2sru00K1U1aG6vt0gMK7+YYJ4fyuAGqPr+47tahN
         HyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787624966; x=1788229766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gLL7o/ycwkHw6o3JwRvUs/3GQV4+FfgW/bU13Rc2JF8=;
        b=R+sGVMNylkf5W7c19gNAHVuSEB+qzRSEv1Y+d5jr+v20BAkvRr7OpNvSNGLIvdY7th
         yCsY8W+3+uTM+XWl34AITb8mt1wD3PqP/Nk37DFHeWW0X4FreJlarmttHp6TGK3aZHrW
         HSYCXVKuk1h5XBvbkKmzB9wwz3ps4Hqg4KJbglIbF4zK2EcRefppX+xdJgCerduzSQpS
         Oo/hyU+hTlpldvYKj1gOtXQ7TPrnhpg0EjGzYZa8qvCKo13x0+9aZO50bWdk6Cf8RQXj
         IjpCzMKkMqc23vUrvfX+5CHk9mmsOIyAKhQT86F5YOaySq6b8DAJ8uE3yHLyGXVqUDLG
         m72g==
X-Forwarded-Encrypted: i=1; AHgh+RogoicXq4F9rw4AoxSrmKSxOgiBELPw/Mm8MrGWCPnQmTvndm/6M2p2Nre1C4Jhpo7cL1dUe7A=@vger.kernel.org
X-Gm-Message-State: AFuF++lW+N+3RHtRJcvzm4ikqN2krtt27hN3kZLue02gwXEjQdsBLwC7
	6j+ZATOt7a2mPqY8toIExvpw5Q1DOrqnbBszDhHx6l5qsDYFnlQxWrgE56h5k+KTzITD+jJVTZX
	9s+Axr6RyZeY8rVpuKUXkUKLD1NUMh9Qu+3ULkChQG5rIxPr/eeIn1MntzenbCXZCmg==
X-Gm-Gg: AR+sD11Ll6jkWXrlytwf+WcL+DL6jddIStATwVrpS3ce6hQPBEfd52dzpn/yOMr5pDW
	ipq+lOJfMz8B0ELWGeJONoL0qM5VRp8ts6h8nAhRYcRZTYvt9Sgebjtq0sJ7ca8A54g6il1aaeI
	YoxxWhCsnWDqJoPIJuEMhAniJPxxQC0yheQROScHUJhJnvs4WrCGXrOKVORtEeo90b9J3EkZ18D
	kJvD917lHRI6E52axWYIjO/DQPRWC8OCltMSONfS4guNA/tvryozCnFqdZY7CgWhf/lZrcBnkRM
	k3KZc6z2Ag0DfwWByFn+NRsm3SY7CmQ5X1Qkvz+PlVNh0NMA2RTIF9nA14zKyJ3SYmH7tFgP6t3
	TGzB4hZEMAGeiYsQFX4iZZmYokd+HkkG6e5ZmyQ9YhvOXMy4ijypmONfKWkCk
X-Received: by 2002:a17:90a:e7c5:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-395c34f47cbmr51855913a91.8.1787624965592;
        Mon, 24 Aug 2026 19:29:25 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c5:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-395c34f47cbmr51855834a91.8.1787624965153;
        Mon, 24 Aug 2026 19:29:25 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f9209fafsm52113590eec.23.2026.08.24.19.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 19:29:24 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	brauner@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: fix OOB reads in cifs_to_posix_acl()
Date: Mon, 24 Aug 2026 21:29:07 -0500
Message-ID: <20260825022907.3567228-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cifs_to_posix_acl() reads the 6-byte fixed header (version,
access_entry_count, default_entry_count) before validating
size_of_data_area, causing an OOB read from truncated responses.

The ACL_TYPE_DEFAULT path then forms a pointer from access_entry_count
before checking bounds:

        pACE = &cifs_acl->ace_array[count];
        count = le16_to_cpu(cifs_acl->default_entry_count);
        size += sizeof(struct cifs_posix_ace) * count;
        if (size_of_data_area < size)
                return -EINVAL;

Validate the header before any field access, validate access ACE count
before pointer arithmetic in both branches, and validate default ACE
count before use.

Fixes: bd9684b042dc ("cifs: implement get acl method")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/cifssmb.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index d445fbd2a0ca..522e01973fd4 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3326,31 +3326,27 @@ static void cifs_init_posix_acl(struct posix_acl_entry *ace,
 static int cifs_to_posix_acl(struct posix_acl **acl, char *src,
 			     const int acl_type, const int size_of_data_area)
 {
-	int size =  0;
+	int size =  sizeof(struct cifs_posix_acl);
 	__u16 count;
 	struct cifs_posix_ace *pACE;
 	struct cifs_posix_acl *cifs_acl = (struct cifs_posix_acl *)src;
 	struct posix_acl *kacl = NULL;
 	struct posix_acl_entry *pa, *pe;
 
+	if (size_of_data_area < size) /* validate acl header */
+		return -EINVAL;
+
 	if (le16_to_cpu(cifs_acl->version) != CIFS_ACL_VERSION)
 		return -EOPNOTSUPP;
 
+	count = le16_to_cpu(cifs_acl->access_entry_count);
+	size += sizeof(struct cifs_posix_ace) * count;
+	if (size_of_data_area < size) /* validate access ACEs */
+		return -EINVAL;
+
 	if (acl_type == ACL_TYPE_ACCESS) {
-		count = le16_to_cpu(cifs_acl->access_entry_count);
 		pACE = &cifs_acl->ace_array[0];
-		size = sizeof(struct cifs_posix_acl);
-		size += sizeof(struct cifs_posix_ace) * count;
-		/* check if we would go beyond end of SMB */
-		if (size_of_data_area < size) {
-			cifs_dbg(FYI, "bad CIFS POSIX ACL size %d vs. %d\n",
-				 size_of_data_area, size);
-			return -EINVAL;
-		}
 	} else if (acl_type == ACL_TYPE_DEFAULT) {
-		count = le16_to_cpu(cifs_acl->access_entry_count);
-		size = sizeof(struct cifs_posix_acl);
-		size += sizeof(struct cifs_posix_ace) * count;
 		/* skip past access ACEs to get to default ACEs */
 		pACE = &cifs_acl->ace_array[count];
 		count = le16_to_cpu(cifs_acl->default_entry_count);
-- 
2.55.0

