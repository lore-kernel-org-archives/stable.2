Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594270;
	b=nn9DA47F3Mg7s/LMP6VQwLWpgtvlJva1Lljy6ZtTMkFhGRWTgrHkMlHuwNsoU5Tk2iAi
	 iU0jhlVq8EUo3ZsvlYXKlYo+uZKehxseOGKkAeWQr4ADu+jo11QW8uKNz/IXhJcibjQAu
	 bBTrIUFRnIviJnkkJh44RgnJwgq5eJaaGhrmXPhZyQZjdg+OASv6iJWkqjr/uWMBeQoff
	 oRvux6YsDQDh4EaY+J1o6rwHHSdlrnk8/wNmLM+smaNBWbq4SIm6dGruHWAz32gqToKhg
	 Ln/Z2UnvD1A5vl2BmY7i3oHVYw1jome4muK9Ujw04OqMqEGSbHCcwkbVUwFEH8fjihg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594270;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oF2xz7N/lXxCU4d+6NsjYLOcLNiEACCoriSZaiavIoU=;
	b=syq2le8bPTDg0BnddtM2vwaevSm8LNbG+vmFYGMh2ba0Z7RcEzh0ytJ8ABxTs4h5sQsf
	 IYNO+JfBXPKgdSi3QKZsLRfvN6aew3dMNAB68VWqjpdMnUwmPIFBwa79bdz0isztzFJ0F
	 x9jOeU+fesN0aGofl9WEAu1lSBNttVUczDNq/ecsgq/ufsxvm2AMKV/otc5ZIU4s1Tcw3
	 lcOwUWgZwvYem+KuT+vS5I/VwmFmifaQC6kxtgsz2MVB6WKOFvWj/axSgEF63conVWkLD
	 //wK1OSMNH2DZQ9jgCuw1BhEkRz74xX5P3Xg6Io+W/5bqVr8OKzrSilrqm1CCOJUIgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xvjViZzv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FB6606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xvjViZzv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9286C1F000C1;
	Wed, 21 Oct 2026 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594270;
	bh=oF2xz7N/lXxCU4d+6NsjYLOcLNiEACCoriSZaiavIoU=;
	h=Subject:To:Cc:From:Date;
	b=xvjViZzviFnSnVBjgarJQVEwtduSL4oO8BlIvGTpPQpEo71fjWI/eXIY8+7NMZEmL
	 jZJG2zaLtO/32/28BTnkjHFwkosoo2WYpg9Mazr6vVZP6TN3uISn4ej5qQQ8hMg9Qg
	 PW5r10XPIvHGMPb/FY71MHmXt7dQsJh2rB3lqxRU=
Subject: FAILED: patch "[PATCH] scsi: bsg: Pass reply_len to bsg_setup_queue() to fit UFS" failed to apply to 6.6-stable tree
To: stanleyjhu@google.com,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:44:08 +0200
Message-ID: <2026102108-porous-stalling-71fc@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ec6b083915e8146e147314a5f4f1285d07b57bfc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102108-porous-stalling-71fc@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ec6b083915e8146e147314a5f4f1285d07b57bfc Mon Sep 17 00:00:00 2001
From: Stanley Jhu <stanleyjhu@google.com>
Date: Tue, 13 Oct 2026 21:27:08 +0800
Subject: [PATCH] scsi: bsg: Pass reply_len to bsg_setup_queue() to fit UFS
 ARPMB replies

bsg-lib allocates a 96-byte (SCSI_SENSE_BUFFERSIZE) reply buffer per
job, but struct ufs_rpmb_reply is 104 bytes: a 40-byte struct
ufs_bsg_reply followed by a 64-byte EHS. When an Advanced RPMB command
returns an EHS, ufshcd_advanced_rpmb_req_handler() copies it right after
the 40-byte header and writes 8 bytes past the end of the buffer.

Let each BSG transport pass its reply buffer size to bsg_setup_queue()
and have ufs_bsg request sizeof(struct ufs_rpmb_reply), so the full
reply reaches user space. Other transports keep SCSI_SENSE_BUFFERSIZE.

Fixes: 6ff265fc5ef6 ("scsi: ufs: core: bsg: Add advanced RPMB support in ufs_bsg")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Link: https://patch.msgid.link/20261013132708.1669415-1-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 895db30a7033..536cee4430a7 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -23,11 +23,14 @@ struct bsg_set {
 	struct bsg_device	*bd;
 	bsg_job_fn		*job_fn;
 	bsg_timeout_fn		*timeout_fn;
+	unsigned int		reply_len;
 };
 
 static int bsg_transport_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
 		bool open_for_write, unsigned int timeout)
 {
+	struct bsg_set *bset =
+		container_of(q->tag_set, struct bsg_set, tag_set);
 	struct bsg_job *job;
 	struct request *rq;
 	struct bio *bio;
@@ -50,7 +53,7 @@ static int bsg_transport_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
 	reply = job->reply;
 	memset(job, 0, sizeof(*job));
 	job->reply = reply;
-	job->reply_len = SCSI_SENSE_BUFFERSIZE;
+	job->reply_len = bset->reply_len;
 	job->dd_data = job + 1;
 
 	job->request_len = hdr->request_len;
@@ -301,9 +304,10 @@ static blk_status_t bsg_queue_rq(struct blk_mq_hw_ctx *hctx,
 static int bsg_init_rq(struct blk_mq_tag_set *set, struct request *req,
 		       unsigned int hctx_idx, int numa_node)
 {
+	struct bsg_set *bset = container_of(set, struct bsg_set, tag_set);
 	struct bsg_job *job = blk_mq_rq_to_pdu(req);
 
-	job->reply = kzalloc(SCSI_SENSE_BUFFERSIZE, GFP_KERNEL);
+	job->reply = kzalloc(bset->reply_len, GFP_KERNEL);
 	if (!job->reply)
 		return -ENOMEM;
 	return 0;
@@ -358,10 +362,12 @@ static const struct blk_mq_ops bsg_mq_ops = {
  * @job_fn: bsg job handler
  * @timeout: timeout handler function pointer
  * @dd_job_size: size of LLD data needed for each job
+ * @reply_len: size of the reply buffer needed for each job
  */
 struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 		struct queue_limits *lim, bsg_job_fn *job_fn,
-		bsg_timeout_fn *timeout, int dd_job_size)
+		bsg_timeout_fn *timeout, int dd_job_size,
+		unsigned int reply_len)
 {
 	struct bsg_set *bset;
 	struct blk_mq_tag_set *set;
@@ -374,6 +380,7 @@ struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 
 	bset->job_fn = job_fn;
 	bset->timeout_fn = timeout;
+	bset->reply_len = reply_len;
 
 	set = &bset->tag_set;
 	set->ops = &bsg_mq_ops;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 1353a8ff9c85..094490713d69 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -3053,7 +3053,7 @@ void mpi3mr_bsg_init(struct mpi3mr_ioc *mrioc)
 	}
 
 	q = bsg_setup_queue(bsg_dev, dev_name(bsg_dev), &lim,
-			mpi3mr_bsg_request, NULL, 0);
+			mpi3mr_bsg_request, NULL, 0, SCSI_SENSE_BUFFERSIZE);
 	if (IS_ERR(q)) {
 		ioc_err(mrioc, "%s: bsg registration failed\n",
 		    dev_name(bsg_dev));
diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index 173ed6373f04..b66365a382c7 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -4345,7 +4345,8 @@ fc_bsg_hostadd(struct Scsi_Host *shost, struct fc_host_attrs *fc_host)
 	scsi_init_limits(shost, &lim);
 	lim.max_segments = min_not_zero(lim.max_segments, i->f->max_bsg_segments);
 	q = bsg_setup_queue(dev, bsg_name, &lim, fc_bsg_dispatch,
-			fc_bsg_job_timeout, i->f->dd_bsg_size);
+			fc_bsg_job_timeout, i->f->dd_bsg_size,
+			SCSI_SENSE_BUFFERSIZE);
 	if (IS_ERR(q)) {
 		dev_err(dev,
 			"fc_host%d: bsg interface failed to initialize - setup queue\n",
@@ -4378,7 +4379,8 @@ fc_bsg_rportadd(struct Scsi_Host *shost, struct fc_rport *rport)
 	scsi_init_limits(shost, &lim);
 	lim.max_segments = min_not_zero(lim.max_segments, i->f->max_bsg_segments);
 	q = bsg_setup_queue(dev, dev_name(dev), &lim, fc_bsg_dispatch_prep,
-				fc_bsg_job_timeout, i->f->dd_bsg_size);
+				fc_bsg_job_timeout, i->f->dd_bsg_size,
+				SCSI_SENSE_BUFFERSIZE);
 	if (IS_ERR(q)) {
 		dev_err(dev, "failed to setup bsg queue\n");
 		return PTR_ERR(q);
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 8aa76f813bcd..b50ff8a1d0a9 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -1545,7 +1545,7 @@ iscsi_bsg_host_add(struct Scsi_Host *shost, struct iscsi_cls_host *ihost)
 	snprintf(bsg_name, sizeof(bsg_name), "iscsi_host%d", shost->host_no);
 	scsi_init_limits(shost, &lim);
 	q = bsg_setup_queue(dev, bsg_name, &lim, iscsi_bsg_host_dispatch, NULL,
-			0);
+			0, SCSI_SENSE_BUFFERSIZE);
 	if (IS_ERR(q)) {
 		shost_printk(KERN_ERR, shost, "bsg interface failed to "
 			     "initialize - no request queue\n");
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index d689b9ed08a6..a825966f60e5 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -199,7 +199,8 @@ static int sas_bsg_initialize(struct Scsi_Host *shost, struct sas_rphy *rphy)
 
 	if (rphy) {
 		q = bsg_setup_queue(&rphy->dev, dev_name(&rphy->dev), NULL,
-				sas_smp_dispatch, NULL, 0);
+				sas_smp_dispatch, NULL, 0,
+				SCSI_SENSE_BUFFERSIZE);
 		if (IS_ERR(q))
 			return PTR_ERR(q);
 		rphy->q = q;
@@ -208,7 +209,8 @@ static int sas_bsg_initialize(struct Scsi_Host *shost, struct sas_rphy *rphy)
 
 		snprintf(name, sizeof(name), "sas_host%d", shost->host_no);
 		q = bsg_setup_queue(&shost->shost_gendev, name, NULL,
-				sas_smp_dispatch, NULL, 0);
+				sas_smp_dispatch, NULL, 0,
+				SCSI_SENSE_BUFFERSIZE);
 		if (IS_ERR(q))
 			return PTR_ERR(q);
 		to_sas_host_attrs(shost)->q = q;
diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 7a66917b3fc0..156637dd76c8 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -258,7 +258,7 @@ int ufs_bsg_probe(struct ufs_hba *hba)
 		goto out;
 
 	q = bsg_setup_queue(bsg_dev, dev_name(bsg_dev), NULL, ufs_bsg_request,
-			NULL, 0);
+			NULL, 0, sizeof(struct ufs_rpmb_reply));
 	if (IS_ERR(q)) {
 		ret = PTR_ERR(q);
 		device_del(bsg_dev);
diff --git a/include/linux/bsg-lib.h b/include/linux/bsg-lib.h
index 14fa93268630..a697246feeac 100644
--- a/include/linux/bsg-lib.h
+++ b/include/linux/bsg-lib.h
@@ -66,7 +66,8 @@ void bsg_job_done(struct bsg_job *job, int result,
 		  unsigned int reply_payload_rcv_len);
 struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 		struct queue_limits *lim, bsg_job_fn *job_fn,
-		bsg_timeout_fn *timeout, int dd_job_size);
+		bsg_timeout_fn *timeout, int dd_job_size,
+		unsigned int reply_len);
 void bsg_remove_queue(struct request_queue *q);
 void bsg_job_put(struct bsg_job *job);
 int __must_check bsg_job_get(struct bsg_job *job);

