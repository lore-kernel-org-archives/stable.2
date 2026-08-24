Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E6392C2F
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787613051; cv=none; b=QV7eO8ABiRpiMCc13i7K0kWZZCbmEbfQ16dyPJSb3r/3WY0qP/RO6qGUBarN+/L0atAccVooIABpX3W+dAnHhG6h3zvlf6uS6uMvFX7yHeASbjOYcbJ3VVPsdOLMhACs0I018YRlhZTKk8EQJxL0CgqbQ09g505H9InzzPIFr0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787613051; c=relaxed/simple;
	bh=5t9dsbuq+qgw2KojziM1Prs8cfgeS4CA+6RiDPFBoyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uw9lCIJ8CV7eZMlz1/srzliDBimObgPAMut9QmoyrTAnPYhTsv+dLdxQnZqWyfD/Zo8NJVyOuVThmq+WJzh+JZGqt7bqvJmPjgTMzb4b96/PzNPtlLjcesL/8S1tdWqH18aujYhFPt2gKld8L8c/zg1J6DSavZICdA/iwPP20xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XT/iciMN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYksmtZq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XT/iciMN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYksmtZq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787613049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RobU9rx3TEhmPVjz5f/pqmdAablkN1GTEF/dACTQJoY=;
	b=XT/iciMNLbwnKocLiDkG3EcaBpYI0Ia++OePmuFHxTQi0EyueV9YktNl4E5qyyZAez1Jeq
	SFNUjebJHShPLbP0gpj5tDuAg55KQtSJOoCMkOiOdHlgOa09DhwidC0Xe9xbXKIe0rlkyP
	lJE3HjYVaIdzPywirhrPkKwJpcyXruU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-HMnE1JKWP9uFbiQjX8jQBQ-1; Mon, 24 Aug 2026 19:10:47 -0400
X-MC-Unique: HMnE1JKWP9uFbiQjX8jQBQ-1
X-Mimecast-MFC-AGG-ID: HMnE1JKWP9uFbiQjX8jQBQ_1787613047
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so10077013a91.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 16:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787613047; x=1788217847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RobU9rx3TEhmPVjz5f/pqmdAablkN1GTEF/dACTQJoY=;
        b=BYksmtZq9bfTkxelhj0R6aXnqGDc6D0qHMp5Gg+cQuhPt4914tDGhrBIQ4xw79qsZK
         KKEeh+cMEKuVxoeBzhMmXJG+qius/KLTK1L/OEM337BqOotHPrATbFcpudPd9KY35leD
         k4olJD6BLSlMJkHDDIwXbXL53I4Fvbu117zvWiK+6tjAjIbt0ta0bD72slfKpTW1isQS
         DgZDDY2QvVNbIzeGKllv2aAnjxSun+6jf6josAEBltvml3fj6KYIPJWJJw4QIDpKB4o9
         DDjS11v6vDIlnAYR+sP4O+wqzf5OmoxghEUKq59c94qnQpZAiKjkvCn5endaqlL6BJaU
         iq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787613047; x=1788217847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RobU9rx3TEhmPVjz5f/pqmdAablkN1GTEF/dACTQJoY=;
        b=e7YMO6OdWpMlI+LcdnqEx764gakYgnXxgIPz4EYSJf8Cq5+tA3bSvPmUs1toYiTfGA
         C3VnA+D7FFTUdRMkwkRpRnIRH2NVdKuV3R3Xg1ke5S58s8u6I+ahegrCaZqLlvC1j9lS
         JgZ0KBn7j/C9LPwKsiAX3r6BfyZYkI8tzB22PiQdtWU3MfYjUXflByj8dPnzRMMnFy5F
         7dzJwgVnAvTecfBUS8B8wA6dFG9SKe+Xq9EPXohIwSb2YpaxE4uS3iHbIYBkdPIgvmMX
         RPBiV/KMF9KiDELY/0yXG3e8aGJL2pE8hbjRdU6Zivh3nvW/HOS/iTF+V6En1/816ge/
         2Cfw==
X-Forwarded-Encrypted: i=1; AHgh+Rqv95YjuxT/8MwGE4PFa1q9GJ+GQx+unAAGgaidHbPhpWTw64YWt38I9kW1mbg+5BgmikJTiDU=@vger.kernel.org
X-Gm-Message-State: AFuF++kO6H5S8JjWwcJfnfO3y7rsezu9OlLp640rjjmETqKQwbHdHJxY
	7e5dyhWkC6jMkX+YsgOhoV8iZj9lImhPQFEnbJn8dI74B1GmTE6bF+S57RbPEjz+52jmgWGMCzo
	VvsqyjIZkJ8AODNgzZ9Wcm04TLCvMVyWr/eS1IaUIBvmI4QG6iP7NQi0bB2AGrvtoFA==
X-Gm-Gg: AR+sD11p3oW7K/06ZgtaFKbMitSGda0zGc0/rO7IzuasTfBoQaP0Z3xtXaTNLJXfR+I
	deFNyqDVPTPcue701mQqKmYoBEcEDhNVn/DrzpN6b/bYedXTYUgxBecJrSXy3aFZBOc7uvHDXZY
	KAvydP8NdAWVegYlUYOIxCoXdqdQ2ky8h6mGIJp4GKJ/02NzlD7oWeZGdOmyFqSVXM6mnguhfZG
	RGjunud59Cpz63M/KugC4q+OnhXvs6a+n9CXBISvb5gUlKc8tapvrmvZU/ur2+ZjEp3z6P5cQ4T
	NoctIkoFOlzKcPii+KVnAtNL9+eIfBtcbGqSPgUygSLlxOTyUAjR8S+cxsuPc+EA+w73c1eB0Bc
	MNqSshpDs+iveAPWpWIGay5mklmlUYwH1i2k9Bw5j7ByqFppeZK5TF1hdwDrS
X-Received: by 2002:a17:90a:d603:b0:38f:5801:cd76 with SMTP id 98e67ed59e1d1-396463062dfmr4753088a91.3.1787613046750;
        Mon, 24 Aug 2026 16:10:46 -0700 (PDT)
X-Received: by 2002:a17:90a:d603:b0:38f:5801:cd76 with SMTP id 98e67ed59e1d1-396463062dfmr4752994a91.3.1787613046247;
        Mon, 24 Aug 2026 16:10:46 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32827662702sm1308530eec.10.2026.08.24.16.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 16:10:45 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	brauner@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: fix OOB pointer arithmetic in cifs_to_posix_acl()
Date: Mon, 24 Aug 2026 18:10:30 -0500
Message-ID: <20260824231030.3502884-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the ACL_TYPE_DEFAULT branch, cifs_to_posix_acl() forms a pointer
from the server-supplied access_entry_count before the size check that
bounds it:

        pACE = &cifs_acl->ace_array[count];     /* count = access_entry_count */
        count = le16_to_cpu(cifs_acl->default_entry_count);
        size += sizeof(struct cifs_posix_ace) * count;
        if (size_of_data_area < size)           /* too late */
                return -EINVAL;

The pointer arithmetic is undefined behaviour before any bounds check.

Add an access-ACE size check before the pointer computation, matching
the existing guard in the ACL_TYPE_ACCESS path.

Fixes: bd9684b042dc ("cifs: implement get acl method")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/cifssmb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index f5aad5f61dce..fdcdebba8b69 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3345,6 +3345,9 @@ static int cifs_to_posix_acl(struct posix_acl **acl, char *src,
 		count = le16_to_cpu(cifs_acl->access_entry_count);
 		size = sizeof(struct cifs_posix_acl);
 		size += sizeof(struct cifs_posix_ace) * count;
+		/* validate access ACE count before pointer arithmetic */
+		if (size_of_data_area < size)
+			return -EINVAL;
 		/* skip past access ACEs to get to default ACEs */
 		pACE = &cifs_acl->ace_array[count];
 		count = le16_to_cpu(cifs_acl->default_entry_count);
-- 
2.55.0

