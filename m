Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EF130F543
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786847196; cv=none; b=Den3/b4ks+1bO8c5UmpkEwm8IQ5GMhWrGe50WYpfROHG4BZ0Wyi8TsE9O3c2wg1OYvoJIfFeu9ck6Nyh4k7tEqn+NVbzcDVmo4ynimTSxcm7usXS6EzqVPArv4dFHVbps8ArgaQquR1lcr4zr1Iug/Nyn9geKC6FVlaiXNGxhjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786847196; c=relaxed/simple;
	bh=pis0kTjcjwtXLktyJ0SMWtk1i2ffUG1YYWwDE5g8zV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZhLJQu+C+dhxNMLLlDKTwZcHomcc1ksFYQosiPVtksqSCP6R9jFwkJW3M6Si1Kvp168X6JFpjXroCjscygP/r8Dnu9uKFTa9FYp7RhU1GwgRCDDhXBIXTwDGJyBNHw7YHeD43Rz1KqsmqprsZ08koZDdmhe6RG15/doiAaLwXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6yKdvkH; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6yKdvkH"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-9034b6b7674so13633946d6.0
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 19:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786847194; x=1787451994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oXHBCMGnZB0X0bTy2l3XtoU3OG3/4+XfTiH2lDtrhfs=;
        b=S6yKdvkHAmjS56QPh2hlZBBCqr4z1B952I/To89eri4sdNUmefb9kBt8Rl6sSwFWul
         /8Af8xqBujfX5gmL6uNpSRxPLwibmpMp5i+90+37JOQyIdgb4bzdlcD5sFIMbgUMTjmY
         9m8+BBvkgXh++vIkjTl4XqcYz1OGOiEh9EmgGHSWdXysTArodw2fY+rkwDHZ1lzURAyb
         0EIGQkSHQojAbMBXf/svrK6QkaQecl+NrVAoygb3ubIo3TeUUjllH1sAk1LMNYflyXPX
         cZt6AvlxE/KZzcEZHzUn1foelOj0nCkpR8B/KOfqAjGnn3CMRah2bFAziB+Em7afW1/U
         OzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786847194; x=1787451994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oXHBCMGnZB0X0bTy2l3XtoU3OG3/4+XfTiH2lDtrhfs=;
        b=i9N5JbLMzly1sI7HgB4LhklBc7A68CbosdS7JFjpNgszfOrW3u0n9k8XhHvlTBa2AP
         e88BfOhbul0R8BKzmJnobT+8Zf3ohd4dz2iDNiM4E3eCKFaYQzaW2I/j6nD0AfmJXWmt
         VTYGELH0rJjrosDSbS3Mz+ZmzY5jN3Q0pukOxlJkNRG+7tGTpek69FdVF4rqQExjprZ8
         FVu2OcIa+rbGrQF6UAMlFJ9OD/E6rNK9k70y7VjscvK2QmEuE94heRjHFEt8OYZgBF3r
         d9RpeUrU7KsjEDt2oUWKr3wrxOQEkxaQMYu2hN29+1aGzGOwmWsslNC5lHV3cowo/m4V
         tEbw==
X-Forwarded-Encrypted: i=1; AHgh+RqmBabv+AtsUWt09dhk79OmOVW3uZO4ujJDnAlA48Q7DGkdu372vSDCtnt5BwMkRUdQuzVr0G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQIjahLtU5qjiaGb1Pj/cnm3khluh9Ga/cqNQQ4X8zaqAi84Mh
	oll6KETf1Zm7WqO7roIGi0NnykIyU1GK/DwO7nNzZn9auNqm0KRiCuey
X-Gm-Gg: AR+sD12NFoUfSGGMrsPKnGaY6bgkD8KQWFnLk9O4nwJTCWz5OU1GOUd9XeFlSolEFB1
	7/5LI/0e3Ule7miVab/WyM5N9o5qv/PLRNT26xYOOfF6n6m6rC9fWzOLTHHrSAmqdqsDx8/StL/
	Cx4m0BU/pKGrO0WYLo7+YBxn2pqHZUEbkW41q38QlxcNTJVMYgbGgbDItd79wr6V1J1oL/sWMcY
	/v5J2059N0pCu/3Y4LH9Jyq6TU8V0hMzS/UvzDbYM/8N2CYz3/g45xBzrIGhj9BAEpWbr45hrZ6
	pMKiRBY7JLVYIO0+Kdp5yn3zWn3HXXzic8rnBViwkASnPQ7CtrHPC7LRuWxLq+Ha8E2GXFrAIZo
	2WVDzD8lrF/sYtBkfbGhb8z0GT121EaKUnmyzsEfKDIIrS4DzgOyJc7GTSdFLV0RJNlymb+ufPp
	wP8H+RMYzilz+nVuHh0ibP+Nx2zbWtGZurFzXCNY8FUzEi1KpIYjrKQkVNEv+ZFs2qtUTjla4Wp
	XRzU5VdklHSK1MWJg==
X-Received: by 2002:a05:6214:27ca:b0:90a:6016:deab with SMTP id 6a1803df08f44-90a91d06fafmr191287646d6.8.1786847193628;
        Sat, 15 Aug 2026 19:26:33 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a921e54e2sm54192436d6.3.2026.08.15.19.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 19:26:33 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: bernard.metzler@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH] RDMA/siw: Fix CEP use-after-free in siw_connect()
Date: Sat, 15 Aug 2026 22:26:19 -0400
Message-ID: <20260816022619.3629422-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

siw_connect() publishes a newly allocated CEP through qp->cep and gives
the QP an association reference.

If connection setup fails while the QP is being destroyed, QP teardown
can clear qp->cep and drop that reference first. The error path
nevertheless drops what it assumes is the association reference. This
consumes the local allocation reference and frees the CEP before the
error path updates cep->state and releases cep->in_use, causing a
use-after-free.

Serialize CEP association and error-side detachment with qp->state_lock.
Only drop the association reference when qp->cep still points to the CEP
being cleaned up, leaving the local reference valid until cleanup is
complete.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/infiniband/sw/siw/siw_cm.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 87c79527ac09..7b32158ea49f 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1467,11 +1467,13 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	siw_cep_set_inuse(cep);
 
 	/* Associate QP with CEP */
+	down_write(&qp->state_lock);
 	siw_cep_get(cep);
 	qp->cep = cep;
 
 	/* siw_qp_get(qp) already done by QP lookup */
 	cep->qp = qp;
+	up_write(&qp->state_lock);
 
 	id->add_ref(id);
 	cep->cm_id = id;
@@ -1564,16 +1566,19 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		siw_socket_disassoc(s);
 		sock_release(s);
 
-		cep->qp = NULL;
-
 		cep->cm_id = NULL;
 		id->rem_ref(id);
 
-		qp->cep = NULL;
-		siw_cep_put(cep);
-
 		cep->state = SIW_EPSTATE_CLOSED;
 
+		down_write(&qp->state_lock);
+		cep->qp = NULL;
+		if (qp->cep == cep) {
+			qp->cep = NULL;
+			siw_cep_put(cep);
+		}
+		up_write(&qp->state_lock);
+
 		siw_cep_set_free_and_put(cep);
 
 	} else if (s) {
-- 
2.43.0

