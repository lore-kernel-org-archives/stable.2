Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B36539B94F
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252846; cv=none; b=qKLhXyf2hxkx9DdqQ92rdid7vr0ohlr74F/PUFXwH3lM2OzrnP6JvfmBTIjoHYYQwJ/v1oHzS3JGImkzSdQ/nzgOO3J9eiTZWoW0zNhcjk7B2QD0gHf3D15oMPu5rAfefrk2toLpY/8igvs8/JXnsRS6xV+cTAapTTqAC+zn1vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252846; c=relaxed/simple;
	bh=UO5kRI9gaVVRfGzqNdDRrX1886a60IbaK2fX2j+yrlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwohCkIN3Exybxf8dTyrDshRiAl4beUNEVDuLnqNA4aWKdZBxQaXvdOu2yUd7codtWjOBuRZICHqNcA3EbsnInK2JbGkeqTmS8kZ4/YNkpieMMX5uGH07zvjOGxdWs/oc7rNV4AnG/Vne/xehkWcZHlTgIqMtoZysmDSE0abMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qXqEle7g; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qXqEle7g"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KIVvOB3370449
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gEnJhDNwb/MJrwckE
	18no0h3PbMjRYMfgXtUEbJZ0fk=; b=qXqEle7gXyRGZuC7IvN+guQjtZJv6t4lC
	kF4yNHFQ8MO1ZlelXHjRJCoPKehGhs++GMLBjMNTmkEdaOfDdK+qKwRpJ2whQIKV
	DNd5dpflqO8cpPW2KeFjcvMu8I4ieFokyWPpZJHlPRA01ijTTfKwF5gqOiSfMfGV
	cy91w2YDjzQz5JSLaNvSRjgPrB06hbVseYq665LIMbg04YyP+JZ3FGX1vEPUSwYL
	aCHTtOf5MTNC+HFNbMr8uSM9hRbKADtstdGy+EWnpYWpFY9XcnvP+cRWPd0DuTy4
	VWs6ZyRHkKQ/pe4Axa2pdCbdBC0C5EdQk054dq/yPlRztkQUzEbDg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4capu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:07:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KIuJY4002124
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:07:19 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqghsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:07:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KJ7IBL27787994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 19:07:18 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6413E5805A;
	Thu, 20 Aug 2026 19:07:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E124F58052;
	Thu, 20 Aug 2026 19:07:17 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown [9.61.78.161])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 19:07:17 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 6.6.y] s390/vfio_ccw: Implement a crw lock
Date: Thu, 20 Aug 2026 15:07:09 -0400
Message-ID: <20260820190709.2690605-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082010-pliable-disparity-1208@gregkh>
References: <2026082010-pliable-disparity-1208@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a875068 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5HEjZEaU-qRc82GsN3sA:9
X-Proofpoint-ORIG-GUID: deoCZvU7HSGXwkEXXJjaQ8fn5vQzHlAG
X-Proofpoint-GUID: deoCZvU7HSGXwkEXXJjaQ8fn5vQzHlAG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MyBTYWx0ZWRfX4Iw5sokMwu+J
 M0OKMvV5YOpZyoPw5zUneWegRoy2CtEcg5GQ5A8igXFwa8ouDY/3qrH1aQa/FrinnxrTz8hYmUR
 Xo/K2zk7piRe2yW68yZQxnOy+iDh7ns=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MyBTYWx0ZWRfXwYvL/3Ewxb63
 RfIoGiQP4wWISsmY3MB+nqrOGUwT34sJacX7JvaeTYN+Nk0FE952ERrPEgRayLGe4W/D2A4XODz
 2t3A+x/KF2Ucvxqx0iAGM3YvEa96vF7IbvHVwt04+azUoPdO2TYOCxD/KLmAH8vooJwjTUskoGF
 +WKxmogPonQzCDc3f/WwC6mb91rBjXAMnL5Y8AvXr6baM5pLjPRqOKR/ybH76q+9DxA+3YnrBbO
 alWDVEuGhFVE1UEUw9QXLRvwCQDhYSjoWZJMGKu2jtPlHMmiYHY5BdQr6hNYgOPh6sCJ38QuI/O
 gHXjAo4zHZFpWbV1jQ/aLsclemU5qu6WQa63hueu5iirwVTJ5tzOQV1RTkjgsT0KL09sSvaCQZI
 NdwAJlnjO98VRR2Qx93muCjTJyYpupzotbKdaq0SKA+5IrY9pAM8Noqh6tj98CfPWy2u8jvbGr4
 GMXTgS7tiy8lFX2rRmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200143

Unlike the channel_program struct, which covers synchronous I/O
submissions and asynchronous interrupts, the CRW region relies
exclusively on asynchronous events coming from hardware.

Implement a lock to manage the list of those payloads, to ensure
they are read cohesively.

Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
(cherry picked from commit 16b0798024c0e9117e395829ddbbe70981c79d9c)
[farman@linux.ibm.com: resolved merge conflict]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_chp.c     | 26 ++++++++++++++++----------
 drivers/s390/cio/vfio_ccw_drv.c     |  6 ++++++
 drivers/s390/cio/vfio_ccw_ops.c     |  4 ++++
 drivers/s390/cio/vfio_ccw_private.h |  4 ++++
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
index 3284b6763347..a518234d0753 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -93,18 +93,13 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
 	struct ccw_crw_region *region;
 	struct vfio_ccw_crw *crw;
+	unsigned long flags;
 	int ret;
 
 	if (pos + count > sizeof(*region))
 		return -EINVAL;
 
 	mutex_lock(&private->io_mutex);
-	crw = list_first_entry_or_null(&private->crw,
-				       struct vfio_ccw_crw, next);
-
-	if (crw)
-		list_del(&crw->next);
-
 	if (i >= private->num_regions) {
 		ret = -EINVAL;
 		goto out;
@@ -113,6 +108,16 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 	i = array_index_nospec(i, private->num_regions);
 	region = private->region[i].data;
 
+	spin_lock_irqsave(&private->crw_lock, flags);
+	crw = list_first_entry_or_null(&private->crw,
+				       struct vfio_ccw_crw, next);
+
+	if (crw)
+		list_del(&crw->next);
+
+	/* Drop CRW lock while copying to userspace */
+	spin_unlock_irqrestore(&private->crw_lock, flags);
+
 	if (crw)
 		memcpy(&region->crw, &crw->crw, sizeof(region->crw));
 
@@ -122,15 +127,16 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 		ret = count;
 
 	region->crw = 0;
-
-out:
-	mutex_unlock(&private->io_mutex);
-
 	kfree(crw);
 
 	/* Notify the guest if more CRWs are on our queue */
+	spin_lock_irqsave(&private->crw_lock, flags);
 	if (!list_empty(&private->crw) && private->crw_trigger)
 		eventfd_signal(private->crw_trigger, 1);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
+
+out:
+	mutex_unlock(&private->io_mutex);
 
 	return ret;
 }
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 884e2e5e4104..e3e91aa10682 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -118,11 +118,14 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
 void vfio_ccw_crw_todo(struct work_struct *work)
 {
 	struct vfio_ccw_private *private;
+	unsigned long flags;
 
 	private = container_of(work, struct vfio_ccw_private, crw_work);
 
+	spin_lock_irqsave(&private->crw_lock, flags);
 	if (!list_empty(&private->crw) && private->crw_trigger)
 		eventfd_signal(private->crw_trigger, 1);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 }
 
 void vfio_ccw_notoper_todo(struct work_struct *work)
@@ -286,6 +289,7 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_private *private,
 			       unsigned int rsid)
 {
 	struct vfio_ccw_crw *crw;
+	unsigned long flags;
 
 	/*
 	 * If unable to allocate a CRW, just drop the event and
@@ -303,7 +307,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_private *private,
 	crw->crw.erc = erc;
 	crw->crw.rsid = rsid;
 
+	spin_lock_irqsave(&private->crw_lock, flags);
 	list_add_tail(&crw->next, &private->crw);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 	queue_work(vfio_ccw_work_q, &private->crw_work);
 }
 
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 67acfa2533ee..d1c17969cb98 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -55,6 +55,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *vdev)
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
 	INIT_WORK(&private->notoper_work, vfio_ccw_notoper_todo);
+	spin_lock_init(&private->crw_lock);
 
 	private->cp.guest_cp = kcalloc(CCWCHAIN_LEN_MAX, sizeof(struct ccw1),
 				       GFP_KERNEL);
@@ -132,6 +133,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
 	struct vfio_ccw_private *private =
 		container_of(vdev, struct vfio_ccw_private, vdev);
 	struct vfio_ccw_crw *crw, *temp;
+	unsigned long flags;
 
 	/*
 	 * Ensure these work items are fully drained, so none can
@@ -147,10 +149,12 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
 	cancel_work_sync(&private->crw_work);
 	flush_work(&private->notoper_work);
 
+	spin_lock_irqsave(&private->crw_lock, flags);
 	list_for_each_entry_safe(crw, temp, &private->crw, next) {
 		list_del(&crw->next);
 		kfree(crw);
 	}
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 
 	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
 	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 0e30497da600..7c16cd570043 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -98,6 +98,8 @@ struct vfio_ccw_parent {
  * @cp: channel program for the current I/O operation
  * @irb: irb info received from interrupt
  * @scsw: scsw info
+ * @crw_lock: serialization of CRW list information
+ * @crw: list of Channel Report Word elements
  * @io_trigger: eventfd ctx for signaling userspace I/O results
  * @crw_trigger: eventfd ctx for signaling userspace CRW information
  * @req_trigger: eventfd ctx for signaling userspace to return device
@@ -120,6 +122,8 @@ struct vfio_ccw_private {
 	struct channel_program	cp;
 	struct irb		irb;
 	union scsw		scsw;
+
+	spinlock_t		crw_lock;
 	struct list_head	crw;
 
 	struct eventfd_ctx	*io_trigger;
-- 
2.55.0

