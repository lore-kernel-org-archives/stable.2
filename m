Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33261272803
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650626; cv=none; b=Qt+Rc9BUwbyivOFyPo5Chn5bv7Ez9UvdZxWJ1EETwufvAIwOEOOeIbNCC0aQFKvUAXG8rhQsG5IJzwrYi67P6mZALiEd8NImav0iSe20iKS2lLMhC65zlxgUVFArQvNtc/iCKnB4TfbpDbOWJktMySwOahelSvsed7PgLPCeqls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650626; c=relaxed/simple;
	bh=C3alcSBjrUVozN+9IQM4PUHMmXGEWaomuPn0A1LETyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFkJbEcWhTfmSCmXqyI3iWPca7BzVsc5G7VhGR8sA9P1abiSxNE5kbcEYm+3SxYPHxzVnykjDwIFi2UrUmZiSP4pkeQIE+YMdtRlhiJc1Jyy0ZyQXMyiSJMEoHdOno3sMY6B6RZwkyMissQyAouWAKEn6sNoDo7VvXRQo8JwZd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMoUhj16; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMoUhj16"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-920f33347f5so19862885a.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 19:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650624; x=1784255424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gt0/g7zZyJ9oxGVfpXChoCA6Z2B5Mn4pHu0Aa2usY6s=;
        b=fMoUhj165Vjja3pGXSrZeDlegv7DY5SypxrQXUd27uyo4LDBQml3MuDGBt/PpVzn8J
         qVFJGbmSoxygsrir10hYefTTEKX9jaAUb7lcFO4Ssh0jl7zsEY1K7d7X0DZ3nSO7HrZN
         W6R6czx61nXod6AZ0jRxNot3aUHctRUxw53pWfej9cHC43jdsrVjvVqnlVa9BdXPTW+I
         kzuDnfvMSYX3mwIKyfVjeE8Y4cocIQlU5uK4nZVyI4Ya3fD6HNlbeT+bE/jT6RiQJISk
         Z5Ex75PFZovE4v0liTo5+Dr1uJeHLt0ZDOe31sBq0qBCVUayR/ZmGy2aUi5tlxctmH3Z
         1/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650624; x=1784255424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gt0/g7zZyJ9oxGVfpXChoCA6Z2B5Mn4pHu0Aa2usY6s=;
        b=ga/tgz7D+J+D7SqEZcn1tyPJWFbJJjc6xtuAjtOa1AQ82P2Db1REJ6q2iyKrxhN7U0
         EuY+Dys0u5E1idYeIcsEVDJsq324ffw6frLIpmK3ZzybazPhAbDKEIPN2iqblMyOgu/W
         ZUDPzZhUtOaj9tILS1pNEE+flRnTaEzTDM/ICOfebvCf7lK8NqVU8mhWO6NS2RxA9KqV
         uarYKuxIJN5CbZOn7LmXkIXLoJ2uGTzNJ6mO20Kl4kzIxuIfvAFmHF3bbPXh3lx/ilGP
         fpS/RwSBr29abT3ENOm7ZFAxPJPr97c+caE6xa7eWI6KcvpBRwCDJkgsWcIrXCuoA7VT
         fjzQ==
X-Forwarded-Encrypted: i=1; AHgh+RruFISow6jGWPlKKN0L4iaPM4AxbpcPr0/BrzoG7OePykyuFlXhgcX5kXqwXU8Ud6VkUB58rp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwinFnLHymcjjYhp37kWj8r268qoOAktNtZVQxLhcsbOKpDriH6
	MXWCRzX2G+vMxdrv5MJcn6ic2uFnQRwM901NIDlE//hWrN25q8R+hWbcUS61JFVFU4Q=
X-Gm-Gg: AfdE7cm7itbfdYPm2hndX42UcLXpNPpjBbnuxfpYNHAUBfBeGu8qUQiouBYZEeFxqUY
	Fy2V8hsY4JmC2BgCDr0LEts2I0RTAun63pHX5wTEcrpfLEyi5VKeaa+vjp+5AizI+MRFC4kwy4j
	BGKsxpmVP4hHhAz1A9BVHQe/BaUuQT3kbHdEkKo4Po8LugUbObb4TvwRbmPzZgdMCVHUgfDd/w6
	3qeKWRudJY0FkzVzaa+NV3mcMShWZqqOgzC+qy28fUk32Q62f31yCcfALu9ZC94CkIc2xqdb3Cy
	Z5c0+R3669DBjwAmNsIveuRcs80oRz/UZB5f4Fq2vmUdX0+9QiGFRKhVcXe0fUrAAO6Ut8NgfOL
	V37pD5oy0kSaRw1tkFEwg9CxifzT34/cwqa6NJwbXyxQ+IkxKykIrJNbvHnjKA6WxZff/Nt91xX
	tk1AZuPodaBJjyONbxREFV9xwRTLAvNkDgx0tli/PwjMczWyT1WHhzQUeNnRRVYzorx1WbTiNBx
	vWjv7BIGQwZ6LIvX5etdMYwv8KVA6CU
X-Received: by 2002:a05:620a:4693:b0:92e:c116:bf10 with SMTP id af79cd13be357-92ecf95ea9emr984970385a.89.1783650624113;
        Thu, 09 Jul 2026 19:30:24 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf9d9bsm88854685a.28.2026.07.09.19.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:30:23 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: kwilczynski@kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] nvmet-pci: validate queue IDs against endpoint queues
Date: Thu,  9 Jul 2026 22:30:14 -0400
Message-ID: <20260710023015.3744082-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710023015.3744082-1-michael.bommarito@gmail.com>
References: <20260710023015.3744082-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The NVMe PCI endpoint transport allocates SQ/CQ arrays using
ctrl->nr_queues, which is capped by endpoint interrupt capacity. Common
target admin validation only checks queue IDs against subsys->max_qid, so
a root-complex host can submit Create/Delete SQ/CQ commands with qids that
pass the common checks but index past the smaller endpoint transport
arrays.

Impact: A PCI root-complex host can crash an NVMe PCI endpoint target with
malformed queue IDs.

Reject queue IDs that are outside ctrl->nr_queues before indexing the
endpoint SQ/CQ arrays.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---

I reproduced this with a same-translation-unit KUnit/KASAN test. The stock
Create CQ path faults in nvmet_pci_epf_create_cq() after
nvmet_check_io_cqid() accepts qid 2 with max_qid 8 and nr_queues 2. The
patched checks reject malformed Create/Delete SQ/CQ cases while the benign
control still passes.
 drivers/nvme/target/pci-epf.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4e9db96ebfecd..5bddda09c0538 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1267,10 +1267,15 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 		u16 cqid, u16 flags, u16 qsize, u64 pci_addr, u16 vector)
 {
 	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
-	struct nvmet_pci_epf_queue *cq = &ctrl->cq[cqid];
+	struct nvmet_pci_epf_queue *cq;
 	u16 status;
 	int ret;
 
+	if (cqid >= ctrl->nr_queues)
+		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+
+	cq = &ctrl->cq[cqid];
+
 	if (test_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags))
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
 
@@ -1348,7 +1353,12 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 static u16 nvmet_pci_epf_delete_cq(struct nvmet_ctrl *tctrl, u16 cqid)
 {
 	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
-	struct nvmet_pci_epf_queue *cq = &ctrl->cq[cqid];
+	struct nvmet_pci_epf_queue *cq;
+
+	if (cqid >= ctrl->nr_queues)
+		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+
+	cq = &ctrl->cq[cqid];
 
 	if (!test_and_clear_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags))
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
@@ -1367,10 +1377,16 @@ static u16 nvmet_pci_epf_create_sq(struct nvmet_ctrl *tctrl,
 		u16 sqid, u16 cqid, u16 flags, u16 qsize, u64 pci_addr)
 {
 	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
-	struct nvmet_pci_epf_queue *sq = &ctrl->sq[sqid];
-	struct nvmet_pci_epf_queue *cq = &ctrl->cq[cqid];
+	struct nvmet_pci_epf_queue *sq;
+	struct nvmet_pci_epf_queue *cq;
 	u16 status;
 
+	if (sqid >= ctrl->nr_queues || cqid >= ctrl->nr_queues)
+		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+
+	sq = &ctrl->sq[sqid];
+	cq = &ctrl->cq[cqid];
+
 	if (test_bit(NVMET_PCI_EPF_Q_LIVE, &sq->flags))
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
 
@@ -1419,7 +1435,12 @@ static u16 nvmet_pci_epf_create_sq(struct nvmet_ctrl *tctrl,
 static u16 nvmet_pci_epf_delete_sq(struct nvmet_ctrl *tctrl, u16 sqid)
 {
 	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
-	struct nvmet_pci_epf_queue *sq = &ctrl->sq[sqid];
+	struct nvmet_pci_epf_queue *sq;
+
+	if (sqid >= ctrl->nr_queues)
+		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+
+	sq = &ctrl->sq[sqid];
 
 	if (!test_and_clear_bit(NVMET_PCI_EPF_Q_LIVE, &sq->flags))
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
-- 
2.53.0
