Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253953;
	b=p1OM7DpEVisIrcls/Zgo/z/uOH2992O0t5ZL39kZpluwJmtpXzqMQSPHyFGVJh5nO11Y
	 AqHztAWqI0aIQ9Fa7KmHhHKjKIYCn78+bUbnaBMFcL8X2M7Y7qZQpsrIPxU2JhcNhz8YT
	 ZFivtUsgkzkqTf99bgRGOKdPsnicPPqk7DWgvSZC8l2dPhEKWXqnDq7i6vk320m2sqJeW
	 rrXKoqSqQ9w8DBWaZHwrAPJEgLq4wwHjvM0NryDJX9Ye7qDQJc5GqdinzOzb8tGxoCO2u
	 IfZOrc8dCzonnydhCiEjHp5zm0Y3RLV1yqBkfYRg/Z8Pgx3Dia1FWcvQ5y2safpsvKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ve4P/af0YMON2eW8s3CRyy2aQgdBXU6q9ZyvIcIdYyI=;
	b=KwmA1+8Ars4TXicRux8Ti/mgfov6Co7zK+CAkmsHcmX76ZiQv5qiEOIw1+bYmz1ZDFZg
	 O3yj9r3Wq2Swg0w3SCbPZPthxOPM6W+Ih8jNOaV6zDxruNWvFOEBgDnPkI5J4VPhZxZA9
	 JBWNdOg+5Bd8Nsh2XZwzoB5iYTMjwBmSQKQqXWCRDuHx1obPICj23Lgq8+VPzSn5pMHEs
	 UcgUL/5sJgyYZlJbBsDZiBZ7O+kBIvvIYcyDxqjBKBSbgnHWBNhnEp+6koNe+L+CJ/TyD
	 RhGEc4/0cXSD4lsINWWsh6afgZF5k8Eer14qcdHOA2bcj98YKTkMb4BIZ/eRiqKusnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z66VK0C0;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F04606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 06:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32F04606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z66VK0C0
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eadf48fb2dso658385e0c.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 23:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793253952; x=1793858752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ve4P/af0YMON2eW8s3CRyy2aQgdBXU6q9ZyvIcIdYyI=;
        b=z66VK0C0HWf264jDUwlCBYeaaFVfhK90ht+1E8fX2sss76ORC5RyQ6rFHWRKj01p4f
         6l/1dxN7WSjeytE3l9HzhYnxQ1Bghsxj9TZA/eLcO5fp5r9Xc5gvDsTPuSmTEyNT680S
         TaryncxCNquKE9+QYvCXUFX8WXho3DsElu3o9l3aIJvq6YkoC8kVrdBj1HqTsAgJ3W19
         DgKq14NgcAamdh2bwwI+RN97VmWFthn6a9I5hkF20FcnMhCgquqZU8xisfpEtEDL+YzW
         1ljaB+w1AjJQO5Je/9IOOuVUkFRlNnbSoUzQRGGaAcl1vbH1r0D4uNLUsAjkE1t0hGs5
         ECeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793253952; x=1793858752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ve4P/af0YMON2eW8s3CRyy2aQgdBXU6q9ZyvIcIdYyI=;
        b=NLMCjiyWHhOl65fdQYThbWhSEHtia8xI+R5YRKbPOQzy/+Zl2cxwAXxHXEXWnPg796
         0zoX9yw2Zh3UZNux01GMktyEdaa16xtg8rKjfMImPWywJQ7R+tlm0UahdzJt1a53PtQM
         Hw9spacreLXvFyWscKK5GBgPhjLG+bnjgslSblcUmVDf2l9/RM9xDP7Gh9af5LWoljhM
         40khEt9DDtwZ6qLGa5Or0GSABWeCrwjgRVChPlLjjifv2aI1ZKsJoMU/kF2ozU0H9ER6
         b8+//q1/SSCumUd9x4dDtlLq9NWkEB8brZESAsb08AFb0/lEBp2RVnL34cwj8+yeQ7jr
         Dm6g==
X-Forwarded-Encrypted: i=1; AKwUvBxCDXvGV9WG1RRpI4NTDYbd4e/4Z/0dttIzsfSMlPqYBrNoJpmidMU0U/+wYCuUsyM09ST4BnY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpO6JBNtSPi/8FlzMs3qq4ijnl0E/aEafrwo8EX51zokcWOGEN
	kuzUARCajGu90JMUdvaMa26xdCTdJcKYn6qtMe26/UeZTDxyKdpWRDJi
X-Gm-Gg: AYBFou30h1SNWUIuxbrZxKRJzcEOahanJOUCBdPHYYs3NOqvKl2dtJdC0mDThIRL1Sv
	MDFrAfik/yVHru47CpHIAtkpE5TUumiRarNcclrzcczgH1P4LP3Ubx1kDUbkP6IQLdnQlWIR7He
	0PIBgfUlLMWfu61G+MLwd7kzYASKEU3LxT613JO2ESSedenkw2mB441E+tgAPCWA7ChO7Mc9d2W
	0QTPFbnH5/V34XQBXsJAGLdR17u888jg1bxgzZPgLciYWh8Ku3q9a00tAmW9t25Loe9pvwgFXpn
	1MnHdCVeHaHrppiBFXx0aWKyC2QVWWaCT5ecmbQqgGC1plLQYKCNv9vX9zbjtZc76lPg2tCq0Xh
	lsElkdN/bGKW0YXtd3H4l1pf4f4Wx90kW+VbgrgpQnQaqH9IxLTBhkwnqGVnS6wLEKMYtO2lgsj
	XEAG4ldUR4dCcE64WY3JKzUWF2u09vBk7V18dXFi/d6mEHDB2uBBJLztJhFEKU3PJKBAQS+tzQF
	Vdpi9VXWetFipKJKR3zWawcoYeIcYgeb2XUGeWUKQ7/f0TwnlEnjNQ92fUhDpSvuWBa62IGkr5l
	j9j+puIKWrGFDWpzckm1sCFuvZWKshsyx1h5U2k=
X-Received: by 2002:a05:6122:4286:b0:5e9:6d96:aa38 with SMTP id 71dfb90a1353d-5ec4cbfd1c0mr2200118e0c.9.1793253952022;
        Wed, 28 Oct 2026 23:05:52 -0700 (PDT)
Received: from bridge.. ([2804:14d:ba6b:8339:8b5e:397a:cdcb:e1d9])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec57d219f0sm2276999e0c.4.2026.10.28.23.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:05:50 -0700 (PDT)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	sgogte@purestorage.com,
	hare@kernel.org,
	nilay@linux.ibm.com,
	wagi@kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-rdma: fix NULL queue->ctrl dereference on reconnect
Date: Thu, 29 Oct 2026 03:05:21 -0300
Message-ID: <20261029060521.1690223-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation
and startup"), a reconnect that gets more I/O queues than before grows
the tag set before the new queues are set up. queue->ctrl is only set
by nvme_rdma_setup_io_queues(), so I/O submitted in between reaches
nvme_rdma_queue_rq() on a queue that was never allocated and
dereferences a NULL queue->ctrl:

  BUG: kernel NULL pointer dereference, address: 000000000000034c
  RIP: 0010:nvme_rdma_queue_rq+0x52/0xb90

Add nvme_rdma_init_queue() for the queue fields that do not depend on
the connection and call it for every queue when allocating the
controller. Such requests are then requeued like on any other queue
that is not live. queue_lock moves there as well, and
nvme_rdma_exit_queue() destroys it when the controller is freed.

Fixes: 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation and startup")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---
Based on nvme-7.4 (89480d137bf0), also applies to mainline and v7.3.
Same approach as "nvme-tcp: fix NULL queue->ctrl dereference on
reconnect" in nvme-7.4.

pi_support, cmnd_capsule_len, queue_size and cm_done are still set on
each connect, as they depend on the RDMA device or on the connect.

Reproduced in QEMU with nvmet-rdma over rxe and
CONFIG_NVME_MULTIPATH=n: connect with attr_qid_max=2, keep direct reads
running on the CPUs that map to the new hw queues, then raise
attr_qid_max to 4. The window is short, so the readers run at
SCHED_FIFO with nvme-wq pinned to their CPUs. Without the patch the
host oopses within two tries in all six boots. With it, 64 of 64 tries
go live and 30 resets under I/O pass, with and without lockdep.

 drivers/nvme/host/rdma.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 07216890f75c..79ef8927d3f0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -90,6 +90,9 @@ enum nvme_rdma_queue_flags {
 	NVME_RDMA_Q_TR_READY		= 2,
 };
 
+#define NVME_RDMA_OPT_NR_QUEUES(opts) ((opts)->nr_io_queues + \
+	(opts)->nr_write_queues + (opts)->nr_poll_queues + 1)
+
 struct nvme_rdma_queue {
 	struct nvme_rdma_qe	*rsp_ring;
 	int			queue_size;
@@ -576,6 +579,19 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	return ret;
 }
 
+static void nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl, int idx)
+{
+	struct nvme_rdma_queue *queue = &ctrl->queues[idx];
+
+	queue->ctrl = ctrl;
+	mutex_init(&queue->queue_lock);
+}
+
+static void nvme_rdma_exit_queue(struct nvme_rdma_ctrl *ctrl, int idx)
+{
+	mutex_destroy(&ctrl->queues[idx].queue_lock);
+}
+
 static int nvme_rdma_alloc_queue(struct nvme_rdma_queue *queue)
 {
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
@@ -583,7 +599,6 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_queue *queue)
 	struct sockaddr *src_addr = NULL;
 	int ret;
 
-	mutex_init(&queue->queue_lock);
 	if (idx && ctrl->ctrl.max_integrity_segments)
 		queue->pi_support = true;
 	else
@@ -600,8 +615,7 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_queue *queue)
 	if (IS_ERR(queue->cm_id)) {
 		dev_info(ctrl->ctrl.device,
 			"failed to create CM ID: %ld\n", PTR_ERR(queue->cm_id));
-		ret = PTR_ERR(queue->cm_id);
-		goto out_destroy_mutex;
+		return PTR_ERR(queue->cm_id);
 	}
 
 	if (ctrl->ctrl.opts->mask & NVMF_OPT_HOST_TRADDR)
@@ -631,8 +645,6 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_queue *queue)
 out_destroy_cm_id:
 	rdma_destroy_id(queue->cm_id);
 	nvme_rdma_destroy_queue_ib(queue);
-out_destroy_mutex:
-	mutex_destroy(&queue->queue_lock);
 	return ret;
 }
 
@@ -660,7 +672,6 @@ static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
 
 	rdma_destroy_id(queue->cm_id);
 	nvme_rdma_destroy_queue_ib(queue);
-	mutex_destroy(&queue->queue_lock);
 }
 
 static void nvme_rdma_free_io_queues(struct nvme_rdma_ctrl *ctrl)
@@ -735,7 +746,6 @@ static int nvme_rdma_setup_io_queues(struct nvme_rdma_ctrl *ctrl,
 	for (i = 0; i < nr_queues; i++) {
 		struct nvme_rdma_queue *queue = &ctrl->queues[first + i];
 
-		queue->ctrl = ctrl;
 		queue->queue_size = queue_size;
 
 		ctxs[i].queue = queue;
@@ -798,7 +808,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	bool pi_capable = false;
 	int error;
 
-	ctrl->queues[0].ctrl = ctrl;
 	ctrl->queues[0].queue_size = NVME_AQ_DEPTH;
 	error = nvme_rdma_alloc_queue(&ctrl->queues[0]);
 	if (error)
@@ -1001,6 +1010,7 @@ static void nvme_rdma_stop_ctrl(struct nvme_ctrl *nctrl)
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	int i, nr_queues = NVME_RDMA_OPT_NR_QUEUES(nctrl->opts);
 
 	if (list_empty_careful(&ctrl->list))
 		goto free_ctrl;
@@ -1011,6 +1021,8 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 
 	nvmf_free_options(nctrl->opts);
 free_ctrl:
+	for (i = 0; i < nr_queues; i++)
+		nvme_rdma_exit_queue(ctrl, i);
 	kfree(ctrl->queues);
 	kfree(ctrl);
 }
@@ -2284,7 +2296,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
 	struct nvme_rdma_ctrl *ctrl;
-	int ret;
+	int ret, i;
 
 	ctrl = kzalloc_obj(*ctrl);
 	if (!ctrl)
@@ -2333,8 +2345,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
-				opts->nr_poll_queues + 1;
+	ctrl->ctrl.queue_count = NVME_RDMA_OPT_NR_QUEUES(opts);
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
@@ -2343,6 +2354,9 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 	if (!ctrl->queues)
 		goto out_free_ctrl;
 
+	for (i = 0; i < ctrl->ctrl.queue_count; i++)
+		nvme_rdma_init_queue(ctrl, i);
+
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
 				0 /* no quirks, we're perfect! */);
 	if (ret)

base-commit: 89480d137bf0d943a82c64f86ae2407a15276b5e
-- 
2.43.0

