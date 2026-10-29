Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283630;
	b=Cf87Z38BXyAyXN3c5X/WAdcVJWWcOQO0vN8GLmy3/0WvlzmXy48EQ2NryaE+Fv22QLom
	 pTSPqs1pviLwfVMUakMgLKwFY4LmgK9EVHArK74t6iamfEx+18Zat/T30P6xL1mtUyqkZ
	 5yTMXIJdNHf3MieuCK5W//0AWHyvumlLzvH9za4L54LHnhgrTZ+SMSfbMSwzM14AD77eJ
	 QY7AOxUzPyI34Dut+sKg2AUmMubePF+1xyAcvnnIN2OqoAQU+jZE5jjcoLWqF7YjqEJkA
	 Ze4itO4wCevXxcV+LCrNlJxuI8Pe7SoZPZE/kzMtA+o23hBOpEoNKYvjkLjwJwJUFvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CEJgZSOIdMAj6jpTCSnhUIhLpKEk9BtwYmYBUge0rqk=;
	b=Zo8/FITBF0ChEWxKPld9hKn23i0JE0hGG0nZ3tZaSt8KZGSXVtMMsgEAEOeALk2b9jjp
	 EQTkWHskRZr5mJU6aoiqTKCRpMp1PGYA0aJQEKhNRQCDzoGShtU63W2ssGv/IbUOzOjp4
	 9x6JIw0GGGS28nWnhmjbRP3GGTHdqvTuqXTSdvVkBGLennYuZx8y9BuIbrBsBmg81jivv
	 MCIgcQcYz3P7Xk4MJZwa5rlCTHjEJiAlHozWcBxv/+FHIF7mtjkVhTQibf5wScifDfyJo
	 cmP0UUr6dVmNwUmJl+a8TqVIvrlnpJzanOse2cRir9FteO9hV2KNTKTh/LubTrL3s7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AvEAmzU9;
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76B6606A333
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C76B6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AvEAmzU9
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-990a39ba4fbso576247241.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283629; x=1793888429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CEJgZSOIdMAj6jpTCSnhUIhLpKEk9BtwYmYBUge0rqk=;
        b=AvEAmzU9PZa9XvzOFEy1iP/VQZQU8MWIeGOIozABscZyaoQ3Ady4FpocZUkHEyAjF5
         a5UPDnaszexmuN+0ozyTgWu6mQxWrre8q5mQdIX7TqtjfYAH2NJT03zg6n2U4m8qXEcy
         8ALf+tfUkG5zW7h1MlfNkhtZB6OYURePrV/fTrUUjAHRagPcflpmx/la9+CQ9WIbhvA/
         GWdyLbnfmsP41O6VqIowi0PhIcKiosNCVxo88kG8sfi9T1gN7DHvLfP6IZhltgfv4X+8
         9JZzy5rOOGWR2jfGI19ZaoDhiMxAYTmiNTBpw/EyXiknxLoc26yk9gtgFIrfk6o4VsPf
         SyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283629; x=1793888429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CEJgZSOIdMAj6jpTCSnhUIhLpKEk9BtwYmYBUge0rqk=;
        b=OsniOOB8fgwX3s3Q7ilpLS7/Lp3ArxLMskPFMm9t0mPmeDEqc0TINfQfl9a8hmZJpr
         0NQ5LyZ/Yf6RYx12hV4XezfztmpMxUnxfIJrkYiSv3yZC8Tob8ip0jlzQCR+atM48JFq
         /mmRzdpIhIXSmC2VXmVwwJ/vcw9HC8ZboGIESYV4M0Pc5bfvSeMyPqNjP27k3iRKe02y
         pVjiHY2yLY75NWbX7be69/Nv4Atb8HSBcVJIR439gGQbj+j/3Patf5oJG75i+xTed8oM
         L3/Bp4KXGZSgYzKskKFvqEzFZfB0L6+d8sd0G5KCUGhyidpoGXBCObg/gTnvTOT9BPQu
         sOCA==
X-Forwarded-Encrypted: i=1; AKwUvBzrAjP+P6jIvwdI5P6O1nxfeFeEPwS3/YXPHdFWrhHIpFDvXEj8YyPMgRbdufZBsGVMm4OA0PQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1RopyjeeI3qknvsOOYRe5DuReO6+s+WmSD8fIF/eNe0ZS0gkH
	9IThyORaiahyd350CgyZ1azYs+q4x4jK8D0/CrQhkKV9ubh5ALdFAYCr
X-Gm-Gg: AYBFou0NRQJx9gTq0162jZfoaliWPWX11er+wfjZ7tfPlrbLaJgTZJR0Ly14jG8mDKw
	lNhlJqU56Fj6CZ+7Gc/x3hDkQsC9edzebc6nW/9INMBa01j/d0NxOLbkUuCanEsRB2FLBsu5l1q
	4+gTjOSUS5Z1xwMdix8tfnqCVQCuHh9rHhj7gAUXb4gf5QyolagMd/q3lMy20c9IHu/gChAIIJ2
	VUh40ba45XK5B17mv4MLOVKUXMiS6lAJ43ScdtZkjbW1FTisgGOk8/dW3pY5IQyX59AzLjFH2P1
	h86ZMk2eavx2zmWEZSsv9xepiXqi3JDcDXDn8K8B5KSFXJGbzlEdUPahy7WduucDA7JmH+m59vI
	gU/Bi/MwhUMu9QjC97I3yzmrFGRXXkPyTUdCMmdaOMWwAsXk26OwPFcUSpkJajEuRMwOgw1WDya
	2XHxARWj6l/P5S+08q6GwdWgam7+g2D0KVmSKJWs1srFkKl/8f0hjS32GXbVArcR10gVo8ms+WP
	EEOEa2VOtypxt10r+qlNy6vMK3p33Aw6zkPvVZuTpQKxGgs8N+l0jBOSaQrsOWt1PhgTF1/ATlU
	JuFnHNCUTN/hKVHD+rs+vv8jkG39fwQ6VO4Xtng=
X-Received: by 2002:a05:6102:6f07:b0:7c3:1d7:f234 with SMTP id ada2fe7eead31-7d03a294a6dmr2037964137.2.1793283628442;
        Thu, 29 Oct 2026 07:20:28 -0700 (PDT)
Received: from bridge.. ([2804:14d:ba6b:8339:e751:b7f8:a4ea:bd70])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-991eaee2e66sm11457241.2.2026.10.29.07.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:20:26 -0700 (PDT)
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
Subject: [PATCH v2] nvme-rdma: fix NULL queue->ctrl dereference on reconnect
Date: Thu, 29 Oct 2026 11:19:57 -0300
Message-ID: <20261029141957.2068907-1-christian.aurichzm@gmail.com>
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

Set queue->ctrl for every queue when allocating the controller. Such
requests are then requeued like on any other queue that is not live.

Fixes: 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation and startup")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---
v2:
- Only move queue->ctrl. v1 also moved queue_lock, which needs the
  queue count in nvme_rdma_free_ctrl(), but opts can already be freed
  there when creating the controller fails (KASAN use-after-free on a
  failed connect with CONFIG_DEBUG_KOBJECT_RELEASE).
- Not carrying the Reviewed-by tags from Nilay and Christoph, as most
  of the patch changed

v1: https://lore.kernel.org/linux-nvme/20261029060521.1690223-1-christian.aurichzm@gmail.com/

Based on nvme-7.4 (89480d137bf0), also applies to mainline and v7.3.

Reproduced in QEMU with nvmet-rdma over rxe and
CONFIG_NVME_MULTIPATH=n: connect with attr_qid_max=2, keep direct reads
running on the CPUs that map to the new hw queues, then raise
attr_qid_max to 4. The window is short, so the readers run at
SCHED_FIFO with nvme-wq pinned to their CPUs. Without the patch the
host oopses within two tries in all six boots. With v2, 24 of 24 tries
go live and 30 resets under I/O pass, with and without lockdep, and
failed connects are clean under KASAN.

 drivers/nvme/host/rdma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 07216890f75c..32189fdfc0f5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -735,7 +735,6 @@ static int nvme_rdma_setup_io_queues(struct nvme_rdma_ctrl *ctrl,
 	for (i = 0; i < nr_queues; i++) {
 		struct nvme_rdma_queue *queue = &ctrl->queues[first + i];
 
-		queue->ctrl = ctrl;
 		queue->queue_size = queue_size;
 
 		ctxs[i].queue = queue;
@@ -798,7 +797,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	bool pi_capable = false;
 	int error;
 
-	ctrl->queues[0].ctrl = ctrl;
 	ctrl->queues[0].queue_size = NVME_AQ_DEPTH;
 	error = nvme_rdma_alloc_queue(&ctrl->queues[0]);
 	if (error)
@@ -2284,7 +2282,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
 	struct nvme_rdma_ctrl *ctrl;
-	int ret;
+	int ret, i;
 
 	ctrl = kzalloc_obj(*ctrl);
 	if (!ctrl)
@@ -2343,6 +2341,9 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 	if (!ctrl->queues)
 		goto out_free_ctrl;
 
+	for (i = 0; i < ctrl->ctrl.queue_count; i++)
+		ctrl->queues[i].ctrl = ctrl;
+
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
 				0 /* no quirks, we're perfect! */);
 	if (ret)

base-commit: 89480d137bf0d943a82c64f86ae2407a15276b5e
-- 
2.43.0

