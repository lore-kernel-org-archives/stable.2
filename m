Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CEA4B1D1A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819875; cv=none; b=RdwCMwZh57uUNSJceYbY0xfNMPJG5Je+00sXzJ+veck92Q0raggxoEGgL2+kKF8tHpsod1E/nCQqanRfAXVoFoUXFgJuC1IDMXnJ/EPzpfga5n9M4QO6p0CZjRkRYn+CcRRucQ1pEAXM/xO5yDK7v7ptyD4iR/4oWUQViLfA0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819875; c=relaxed/simple;
	bh=pGglhdJSaESqGAS87RsaMHsYgo0Zd89aL96WTdTzj50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8U1crmq4kTIUDDPAlt4qFQBkDHkgTyWMqmVNHGz9CG4O18YBXahj1gj4JBaRV7MVFNAH69gcaA3tXq8TSFlS3/enjgLd/56qKPZxIbRS9ZAs0So6Z4I+aE1mkWI2JwQ2yMyHGFci6IF9+XfublE4CfFDzP8qc1MWmyAz6PGqZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D8kcPhp9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D8kcPhp9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFiUdb664649
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VaDo+a
	tTiYz38o89CQhCjZWh1i6c0cAAikdonto0lmw=; b=D8kcPhp9WISBuMt1c3HAKt
	F+U83lqmtDfl8GEBnN6bCq70W4O0IJhmCoJ6PeWPnnYfq0DDYGybQHB4473PbCgQ
	9DSu3iNrUqp6Ol+YGEYJgGs6QF8cJ9Eo2GGlykhGrY3mLrjcKgMIeo1DuzFi7WUi
	7IVlcKwFDGn/QIw2xzAVFSfjNlF9hp2ZSvuP7/wYTG0EQAbsu7xcHDolBvsvmkM1
	TXu9MbBFQfbbKXgWAl7miPJsHQE4xGiNru10az6dYM4UmRzn6sW7t+Q8rWcph2rO
	TM2DypAp9XDdGCKIdjxgdrcIbonvZwBP87rkoiG9ZEt/b7Bav1/Zy+N8S+b+V1QA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w1b4a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC554d1238612
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:29 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppnywu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CFiSuq21365252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:44:28 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3DFC5804E;
	Mon, 12 Oct 2026 15:44:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4062A5803F;
	Mon, 12 Oct 2026 15:44:27 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.159.45])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 15:44:27 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: mjrosato@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v10 1/6] s390/vfio-ap: Fix leaks of pinned NIB and registered GISC
Date: Mon, 12 Oct 2026 11:44:20 -0400
Message-ID: <20261012154425.2860783-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012154425.2860783-1-akrowiak@linux.ibm.com>
References: <20261012154425.2860783-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfX88UBdOjT2zKa
 rLPAp+xvR8JF3YakHn5pNlvSkIqKmyO8cG9RgV1vZwl5GbWbOJrCHIlLXz8LdZylVEP9IRTFS5r
 Me8wXpZUER3mkiS3pAVV2j8sYnDRXnw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfX7cMnbCfcq/CL
 wrbhFsOElSp5BIqOJGgFbYa9zKhFkI5/zgK6XJhzM37aYSBk5c5f+3VOsEic0G96R4EHchR6aTD
 XMR5Wmsh54HwCjQL+v9eUlPTrnbWPMF09PlKHjSWw0JZ784OSDGm7MKuFkxtrQqQbt5kSsw2Ad2
 hdxfktzqHnDcF/lFcRZnitKWB3+cuJUhsJInwh2zEz0our4uWMCvnfkB+CTscXsvAMSZXxmOkuR
 57ZkzynFslRGvBhVdr3Gr+JfGmfiLg6jFRA+hXnZdVYDDn/gDR8B7zDNPxz+2fqRMFvc1qW4cWo
 xx0KukwftNE5es4BNaf8wkfmc1J6kdRF8FbpSDtRtszvqlPJgNXyDGstU0Sh3wNM6HWAKW5UMBK
 GlH7Ng2rEU5CM3gbqVgz2QCjFOffKS3Z03k/DpTrydbAf80kfkXoLq/9DafXGIxWIgV4P+AfXTf
 cAv52Gf+a1qSIhAkOQg==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acd005e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=G-9xJRpVmZiDjs5lg3EA:9 a=gc4DA4po1stYe9zU:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3rbrspdm-u0-k2QX2_A1LHdgnDkETc21
X-Proofpoint-GUID: 3rbrspdm-u0-k2QX2_A1LHdgnDkETc21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120062

Several code paths in the vfio_ap driver failed to free the AQIC
resources — the pinned guest NIB page and the registered guest
ISC used to enable interrupts for a queue — when a queue became
unavailable or when unexpected response codes were returned. This
could cause memory exhaustion and depletion of KVM interrupt
subclass registrations over time with repeated dynamic AP
reconfiguration. On the other hand, there are situations whereby
these resources must be intentionally leaked. If the page were
unpinned and returned to the allocator, a subsequent wild
DMA-write to that physical address would corrupt memory belonging
to the new owner and could crash or compromise the host kernel.

vfio_ap_mdev_reset_queue()
~~~~~~~~~~~~~~~~~~~~~~~~~~
AP_RESPONSE_BUSY is not a valid response code for a PQAP(ZAPQ)
instruction, so it is removed. This contradicts what is stated
in the following:

  commit 411b0109daa52 ("s390/vfio-ap: wait for response code
  05 to clear on queue reset")

The AP architecture limits PQAP(ZAPQ) response codes to 01, 02,
03, 04, and 0x0A; 05 is not valid for ZAPQ. As a consequence,
AP_RESPONSE_BUSY can never appear in q->reset_status (which
holds the ZAPQ result), so the corresponding check in
apq_reset_check() is also removed as dead code.

apq_status_check() / apq_reset_check()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The handling of PQAP(TAPQ) response codes in apq_status_check()
and the ZAPQ re-issue logic in apq_reset_check() are reworked
to correctly distinguish between cases that require waiting and
cases that require re-issuing the ZAPQ.

AP_RESPONSE_BUSY (05) is valid for TAPQ. TAPQ returning BUSY
says only that the queue is busy — it says nothing about whether
our ZAPQ was accepted or is currently zeroizing. Re-issuing the
ZAPQ on TAPQ BUSY could interrupt a zeroization already in
progress. AP_RESPONSE_BUSY in apq_status_check() is therefore
changed from -EAGAIN (which triggered a ZAPQ re-issue) to
-EBUSY (keep waiting).

AP_RESPONSE_RESET_IN_PROGRESS (02) from TAPQ means a reset is
in progress. It may be our ZAPQ or a prior reset (e.g. a RAPQ
from the AP bus or guest). In either case, keep waiting: if it
is our ZAPQ it will zeroize the queue; if it is a prior reset,
q->reset_status will hold RESET_IN_PROGRESS (our ZAPQ was
rejected) and the re-issue condition below will fire a new ZAPQ
once TAPQ reports clean.

The re-issue condition in apq_reset_check() covers three cases
where a new ZAPQ is genuinely required:
  - q->reset_status holds AP_RESPONSE_RESET_IN_PROGRESS: our
    initial ZAPQ was rejected because a prior reset was already
    running. That reset does not zeroize the queue; re-issue
    once it clears.
  - q->reset_status holds AP_RESPONSE_STATE_CHANGE_IN_PROGRESS:
    our initial ZAPQ was rejected because the queue was
    mid-transition; re-issue once TAPQ reports clean.
  - apq_status_check() returns -EAGAIN: TAPQ returned an ASSOC
    error code (0x35 or 0x36). These asynchronous codes are
    returned for every AP instruction until the queue is
    explicitly reset via ZAPQ; re-issuing is necessary to
    terminate the loop.

vfio_ap_mdev_remove_queue()
~~~~~~~~~~~~~~~~~~~~~~~~~~~
When the AP bus scan detects a queue is no longer in the host
AP configuration, vfio_ap_mdev_remove_queue() skips the ZAPQ
since issuing it would fail anyway. A comment is added to the
existing else branch to document that
vfio_ap_free_aqic_resources() is safe to call here because the
hardware is gone and can no longer DMA-write to the NIB.

apq_reset_check()
~~~~~~~~~~~~~~~~~
When apq_reset_check() returns from the -EIO path (TAPQ returned
an invalid response code), the TAPQ status is now copied to
q->reset_status. This ensures the queue is marked not-passable
— _queue_passable() checks for AP_RESPONSE_NORMAL — so the
queue is not passed through to a guest.

vfio_ap_irq_disable()
~~~~~~~~~~~~~~~~~~~~~
The valid response codes for PQAP(AQIC) include
AP_RESPONSE_STATE_CHANGE_IN_PROGRESS (0x0a),
AP_RESPONSE_INVALID_GISA (0x08),
AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE (0x35), and
AP_RESPONSE_ASSOC_FAILED (0x36), none of which were explicitly
handled. All four fell through to the default case which freed
the AQIC resources. These each should be handled differently:

* AP_RESPONSE_STATE_CHANGE_IN_PROGRESS indicates a transient
  condition, analogous to AP_RESPONSE_RESET_IN_PROGRESS and
  AP_RESPONSE_BUSY. It is added to the same case as
  RESET_IN_PROGRESS and RESPONSE_BUSY whereby the process
  sleeps for 20ms and the AQIC gets re-executed.

* AP_RESPONSE_INVALID_GISA indicates the AQIC instruction was
  rejected due to an invalid GISA address. The disable did not
  take effect and the hardware still holds the NIB page address.
  The AQIC resources must therefore be intentionally leaked.

* AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE and
  AP_RESPONSE_ASSOC_FAILED are asynchronous response codes from
  a previously executed association instruction. All subsequent
  AQIC calls will end with the asynchronous response code until
  the queue is reset; therefore the AQIC disable was not
  executed and the hardware still holds the NIB address. The
  AQIC resources must therefore be intentionally leaked.

vfio_ap_wait_for_irqclear() is called after AQIC returns
NORMAL or OTHERWISE_CHANGED to confirm that the asynchronous
disablement has completed (IR=0) before the AQIC resources are
freed. The function returns one of:
 * 0:          IR=0 confirmed; safe to free AQIC resources
 * -ENODEV:    queue is non-operational; safe to free
 * -ETIMEDOUT: IR=0 could not be confirmed within the polling
               window, or TAPQ returned an async association
               response code (0x35/0x36) which also prevents
               confirmation
 * -EIO:       TAPQ returned an unexpected response code

When IR=0 cannot be confirmed, the AQIC resources are
intentionally retained to prevent a wild DMA-write to a freed
NIB page. The original AQIC status (NORMAL or
OTHERWISE_CHANGED) is returned to the guest unchanged; the
host's responsibility is to execute the AQIC instruction on
the guest's behalf and return the hardware status. The guest
can act on that status as it sees fit.

vfio_ap_free_aqic_resources()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The function used q->matrix_mdev->kvm and &q->matrix_mdev->vdev
when releasing the registered guest ISC and pinned NIB page
respectively. This is correct on the normal teardown path, but
becomes wrong when a queue reset fails and AQIC resources are
intentionally retained across a guest lifecycle. If the mdev is
subsequently opened by a new guest (new KVM, new IOMMU
container), a later call to vfio_ap_free_aqic_resources() would
release the old resources against the new guest's KVM and
vfio_device. This produces two bugs:

* vfio_unpin_pages(new_vdev, old_iova) unpins from the wrong
  IOMMU container. The iommufd backend hits WARN_ON(!access);
  the type1 backend may silently unpin the wrong page or warn.
  The original pin in the old container is never dropped,
  causing vfio to warn about a non-empty pfn_list at container
  teardown.

* kvm_s390_gisc_unregister() could fire against the wrong KVM
  if the old struct kvm is freed and a new one allocated at the
  same address (struct kvm is kzalloc'd and the slab allocator
  can reuse addresses), silently dropping an ISC registration
  the new guest still needs.

Fix this by introducing struct vfio_ap_aqic_resources, which
groups the ISC, NIB IOVA, and the owning vfio_device and KVM
together, replacing the standalone saved_isc and saved_iova
fields in struct vfio_ap_queue. vfio_ap_irq_enable() snapshots
the owning vdev and kvm at acquire time, taking a KVM reference
via kvm_get_kvm() to guarantee the pointer remains valid.
vfio_ap_free_aqic_resources() then always releases each
resource against its original owner, dropping the KVM reference
with kvm_put_kvm() after unregistering the ISC.

vfio_ap_mdev_unset_kvm() and vfio_ap_unlink_mdev_fr_queue()
clear vdev, kvm (dropping the reference), and isc from
aqic_resources when the mdev-queue association is severed,
since the IOMMU container and KVM of the closing session are
no longer valid targets for resource release. The iova is
intentionally kept: the physical page remains pinned to prevent
a wild DMA-write to a reallocated page.

However, close_device() must not return with any page still
pinned. After close_device() returns, vfio core removes the
device from iommu->device_list; a subsequent
VFIO_IOMMU_UNMAP_DMA will find the pin in dma->pfn_list,
receive no response from the empty device list, retry 10
times, and hit BUG_ON(++retries > 10). To prevent this,
vfio_ap_mdev_unset_kvm() force-unpins any NIB pages that
survive the close-time reset, logging pr_crit. This carries
the same theoretical wild-DMA risk as the force-unpin in
unmap_iova(), and is chosen for the same reason: a guaranteed
host panic is worse than a theoretical risk from
already-misbehaving hardware.

The same force-unpin loop also covers the case where userspace
closes the container fd without calling VFIO_IOMMU_UNMAP_DMA
first. vfio_remove_dma() runs during container teardown and
hits WARN_ON(!RB_EMPTY_ROOT(&dma->pfn_list)) for any pin that
was not released. Because the force-unpin loop runs after
flush_work() has drained all reset workers, iova is zero for
every queue before close_device() returns, so pfn_list is
already empty when vfio_remove_dma() runs.

Note: it is not known whether hardware also writes to the GISA
on interrupt delivery (in addition to the NIB). If it does,
keeping only the NIB pinned is insufficient since the GISA is
freed with the VM in kvm_arch_destroy_vm() regardless of
vfio_ap state. The current code assumes the NIB is the sole
DMA target.

unmap_iova()
~~~~~~~~~~~~
Calls vfio_ap_irq_disable() to disable interrupts for the
queue, but does not check the result. If the IRQ disable failed
or could not be confirmed, vfio_ap_irq_disable() leaks the NIB
to prevent a wild DMA-write; however, the vfio core requires
that the NIB page be unpinned before dma_unmap returns, or it
will BUG_ON after 10 re-notification rounds.

The fix is to fall back to a bounded queue reset via ZAPQ,
which zeroizes the NIB pointer in the hardware, eliminating
the DMA risk that justified the leak. If the reset completes,
the worker frees the AQIC resources. If the reset times out
or fails, the NIB is force-unpinned with pr_crit — the same
trade-off accepted in the close_device() path above.

Fixes: ec89b55e3bce7 ("s390: ap: implement PAPQ AQIC interception in kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 506 ++++++++++++++++++++++----
 drivers/s390/crypto/vfio_ap_private.h |  51 ++-
 2 files changed, 463 insertions(+), 94 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 4db878c18f41..084a687762eb 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -31,6 +31,7 @@
 #define AP_QUEUE_IN_USE "in use"
 
 #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
+#define AP_RESET_MAX_WAIT		2000	/* Maximum wait for reset (2000ms)	*/
 
 static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
 static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
@@ -226,27 +227,48 @@ static struct vfio_ap_queue *vfio_ap_mdev_get_queue(
 }
 
 /**
- * vfio_ap_wait_for_irqclear - clears the IR bit or gives up after 5 tries
- * @apqn: The AP Queue number
- *
- * Checks the IRQ bit for the status of this APQN using ap_tapq.
- * Returns if the ap_tapq function succeeded and the bit is clear.
- * Returns if ap_tapq function failed with invalid, deconfigured or
- * checkstopped AP.
- * Otherwise retries up to 5 times after waiting 20ms.
+ * vfio_ap_wait_for_irqclear - wait for the IR bit to clear after a disable
+ *
+ * @q:			the vfio_ap_queue
+ * @tapq_status:	used to return the TAPQ status to the caller
+ *
+ * Repeatedly polls the AP queue status via PQAP(TAPQ) every 20ms until the IR
+ * bit is clear, the queue becomes non-operational, or 6 retries are exhausted.
+ *
+ * Because PQAP(AQIC) disable initiates an asynchronous process, a
+ * condition-code 0 completion does not guarantee the IR bit has been cleared.
+ * The host must confirm IR=0 before unpinning the NIB page to avoid a wild
+ * DMA write to a freed page.
+ *
+ * Return:
+ * 0		if the IR bit is clear (i.e., interrupts are disabled).
+ *
+ * -ENODEV	if the PQAP-TAPQ response code indicates the queue is not available,
+ *		is deconfigured, or is checkstopped (i.e., not operational).
+ *
+ * -ETIMEDOUT	the function timed out before the IR bit was cleared, or TAPQ
+ *		returned AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE or
+ *		AP_RESPONSE_ASSOC_FAILED, which mean the instruction was not
+ *		executed and will continue to be returned for all subsequent
+ *		instructions except ZAPQ until the queue is reset. Since IR=0
+ *		cannot be confirmed, the NIB must be treated as a potential DMA
+ *		target and leaked rather than freed.
+ *
+ * -EIO		PQAP-TAPQ returned an invalid response code
  */
-static void vfio_ap_wait_for_irqclear(int apqn)
+static int vfio_ap_wait_for_irqclear(int apqn, struct ap_queue_status *tapq_status)
 {
 	struct ap_queue_status status;
 	int retry = 5;
 
 	do {
 		status = ap_tapq(apqn, NULL);
+		memcpy(tapq_status, &status, sizeof(status));
 		switch (status.response_code) {
 		case AP_RESPONSE_NORMAL:
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 			if (!status.irq_enabled)
-				return;
+				return 0;
 			fallthrough;
 		case AP_RESPONSE_BUSY:
 			msleep(20);
@@ -254,90 +276,213 @@ static void vfio_ap_wait_for_irqclear(int apqn)
 		case AP_RESPONSE_Q_NOT_AVAIL:
 		case AP_RESPONSE_DECONFIGURED:
 		case AP_RESPONSE_CHECKSTOPPED:
+			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
+				  status.response_code, apqn);
+			return -ENODEV;
+		case AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE:
+		case AP_RESPONSE_ASSOC_FAILED:
+			/*
+			 * The TAPQ instruction was not executed. Executing TAPQ
+			 * again will result in the same error until the queue
+			 * is reset. We shouldn't, however, reset the queue in
+			 * this context, so log a warning and return -ETIMEDOUT
+			 * since that would happen anyway if we continued to
+			 * execute the TAPQ.
+			 */
+			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
+				  status.response_code, apqn);
+			return -ETIMEDOUT;
 		default:
 			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
 				  status.response_code, apqn);
-			return;
+			return -EIO;
 		}
 	} while (--retry);
 
-	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
-		  __func__, status.response_code, apqn);
+	WARN_ONCE(1, "%s: tapq rc %02x: timed out waiting for interrupts disabled for %02x.%04x\n",
+		  __func__, status.response_code,
+		  AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+	return -ETIMEDOUT;
 }
 
 /**
- * vfio_ap_free_aqic_resources - free vfio_ap_queue resources
+ * vfio_ap_free_aqic_resources - free vfio_ap_queue AQIC resources
  * @q: The vfio_ap_queue
  *
- * Unregisters the ISC in the GIB when the saved ISC not invalid.
- * Unpins the guest's page holding the NIB when it exists.
- * Resets the saved_iova and saved_isc to invalid values.
+ * Unregisters the ISC from the GIB and unpins the NIB page, using the KVM
+ * instance and vfio_device snapshotted at enable time in q->aqic_resources.
+ *
+ * For the ISC: always call kvm_s390_gisc_unregister() on the KVM that was
+ * passed to kvm_s390_gisc_register() at enable time (q->aqic_resources.kvm).
+ * A reference is held on that KVM (via kvm_get_kvm() at enable time) so the
+ * pointer is always valid here. The reference is dropped after unregistering.
+ *
+ * For the NIB: always use q->aqic_resources.vdev — the vfio_device that owns
+ * the IOMMU container in which the page was pinned — regardless of what
+ * q->matrix_mdev currently points to.
  */
 static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
 {
 	if (!q)
 		return;
-	if (q->saved_isc != VFIO_AP_ISC_INVALID) {
-		if (!WARN_ON(!q->matrix_mdev) && q->matrix_mdev->kvm)
-			kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->saved_isc);
-		q->saved_isc = VFIO_AP_ISC_INVALID;
+
+	if (q->aqic_resources.isc != VFIO_AP_ISC_INVALID) {
+		if (q->aqic_resources.kvm) {
+			kvm_s390_gisc_unregister(q->aqic_resources.kvm, q->aqic_resources.isc);
+			kvm_put_kvm(q->aqic_resources.kvm);
+		}
+		q->aqic_resources.isc = VFIO_AP_ISC_INVALID;
+		q->aqic_resources.kvm = NULL;
 	}
-	if (q->saved_iova && !WARN_ON(!q->matrix_mdev)) {
-		vfio_unpin_pages(&q->matrix_mdev->vdev, q->saved_iova, 1);
-		q->saved_iova = 0;
+
+	if (q->aqic_resources.iova) {
+		if (q->aqic_resources.vdev)
+			vfio_unpin_pages(q->aqic_resources.vdev, q->aqic_resources.iova, 1);
+		else
+			pr_warn_ratelimited("APQN %02x.%04x: Failed to unpin NIB page at %pad\n",
+					    AP_QID_CARD(q->apqn),
+					    AP_QID_QUEUE(q->apqn),
+					    &q->aqic_resources.iova);
+		q->aqic_resources.iova = 0;
+		q->aqic_resources.vdev = NULL;
 	}
 }
 
 /**
- * vfio_ap_irq_disable - disables and clears an ap_queue interrupt
- * @q: The vfio_ap_queue
+ * vfio_ap_irq_disable - disable interrupts for an AP queue
+ * @q: the vfio_ap_queue
+ *
+ * Issues PQAP(AQIC) to disable interrupts for the AP queue. On success
+ * (AP_RESPONSE_NORMAL or AP_RESPONSE_OTHERWISE_CHANGED), polls via
+ * vfio_ap_wait_for_irqclear() until the IR bit is confirmed clear before
+ * freeing the pinned NIB page and unregistering the guest ISC. This wait is
+ * necessary because AQIC disable is asynchronous: freeing the NIB before IR=0
+ * is confirmed risks a wild DMA write to a freed host page.
  *
- * Uses ap_aqic to disable the interruption and in case of success, reset
- * in progress or IRQ disable command already proceeded: calls
- * vfio_ap_wait_for_irqclear() to check for the IRQ bit to be clear
- * and calls vfio_ap_free_aqic_resources() to free the resources associated
- * with the AP interrupt handling.
+ * Retries up to 5 times (with 20ms sleep) if the queue is busy or a reset is
+ * in progress.
  *
- * In the case the AP is busy, or a reset is in progress,
- * retries after 20ms, up to 5 times.
+ * If the IR bit cannot be confirmed clear (timeout), the NIB page and guest
+ * ISC are intentionally leaked. If the page were unpinned and returned to the
+ * allocator, a subsequent hardware DMA write to that physical address would
+ * corrupt memory belonging to a new owner — a wild DMA write that could crash
+ * or compromise the host kernel.
  *
- * Returns if ap_aqic function failed with invalid, deconfigured or
- * checkstopped AP.
+ * If the queue is non-operational (deconfigured, checkstopped, not available),
+ * resources are freed immediately since the hardware can no longer write to
+ * the NIB.
  *
  * Return: &struct ap_queue_status
  */
 static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 {
 	union ap_qirq_ctrl aqic_gisa = { .value = 0 };
-	struct ap_queue_status status;
-	int retries = 5;
+	struct ap_queue_status status, tapq_status;
+	int retries = 5, ret;
 
 	do {
 		status = ap_aqic(q->apqn, aqic_gisa, 0);
 		switch (status.response_code) {
 		case AP_RESPONSE_OTHERWISE_CHANGED:
 		case AP_RESPONSE_NORMAL:
-			vfio_ap_wait_for_irqclear(q->apqn);
-			goto end_free;
+			/*
+			 * AQIC disable was accepted (NORMAL), or the queue was
+			 * already disabled or a prior async request is still
+			 * completing (OTHERWISE_CHANGED).  In both cases, we must
+			 * wait until interrupt processing has been disabled
+			 * before proceeding.
+			 */
+			ret = vfio_ap_wait_for_irqclear(q->apqn, &tapq_status);
+			if (ret == 0 || ret == -ENODEV)
+				goto end_free;
+
+			if (ret == -EIO) {
+				/*
+				 * An unknown TAPQ response code was returned which
+				 * indicates a bug or some type of hardware I/O issue.
+				 * Since we don't know whether queue interrupts were
+				 * disabled or not, the AQIC resources must be leaked.
+				 */
+				memcpy(&status, &tapq_status, sizeof(status));
+				goto end_fail;
+			}
+
+			/* Timed out waiting to confirm interrupts are disabled */
+			if (tapq_status.response_code == AP_RESPONSE_NORMAL ||
+			    tapq_status.response_code == AP_RESPONSE_BUSY) {
+				/*
+				 * If AQIC returned NORMAL, the guest would incorrectly
+				 * interpret that as a successful disable and may free or
+				 * reuse the NIB while hardware can still write to it.
+				 * AP_RESPONSE_BUSY is not valid for PQAP-AQIC.
+				 *
+				 * Return OTHERWISE_CHANGED to signal to the guest that
+				 * the disable interrupts operation did not complete.
+				 */
+				memset(&status, 0, sizeof(status));
+				status.response_code = AP_RESPONSE_OTHERWISE_CHANGED;
+			} else {
+				/*
+				 * For all other TAPQ response codes,
+				 * return the TAPQ status directly since those
+				 * codes are also valid for AQIC.
+				 */
+				memcpy(&status, &tapq_status, sizeof(status));
+			}
+			goto end_fail;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
+		case AP_RESPONSE_STATE_CHANGE_IN_PROGRESS:
 			msleep(20);
 			break;
 		case AP_RESPONSE_Q_NOT_AVAIL:
 		case AP_RESPONSE_DECONFIGURED:
 		case AP_RESPONSE_CHECKSTOPPED:
+			/* AP not operational; no further interrupts possible */
+			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
+				  status.response_code);
+			goto end_free;
 		case AP_RESPONSE_INVALID_ADDRESS:
+		case AP_RESPONSE_INVALID_GISA:
+		case AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE:
+		case AP_RESPONSE_ASSOC_FAILED:
 		default:
-			/* All cases in default means AP not operational */
+			/*
+			 * The AQIC disable was rejected; IRQ is still enabled
+			 * and the hardware still holds the NIB address. Do not
+			 * free resources.
+			 */
 			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
 				  status.response_code);
-			goto end_free;
+			goto end_fail;
 		}
 	} while (retries--);
 
 	WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
 		  status.response_code);
+
+end_fail:
+	/*
+	 * We are here either because the AQIC instruction failed to disable
+	 * interrupts, or because IR=0 could not be confirmed. In either case
+	 * the NIB page and guest ISC cannot be freed: hardware may still write
+	 * to the NIB, and unpinning the page would allow it to be reallocated
+	 * to a new owner. A subsequent hardware DMA write to that physical
+	 * address would corrupt the new owner's memory — a wild DMA write that
+	 * could crash or compromise the host kernel. The resources are
+	 * therefore intentionally leaked.
+	 */
+	return status;
+
 end_free:
+	/*
+	 * This label is reached because the queue was successfully disabled,
+	 * or because the queue is not operational or not available, in which case
+	 * interrupts can not be processed, so free the AQIC resources - the pinned NIB
+	 * page and the registered guest ISC - used to enable interrupts so they will
+	 * not be leaked.
+	 */
 	vfio_ap_free_aqic_resources(q);
 	return status;
 }
@@ -401,22 +546,29 @@ static int ensure_nib_shared(unsigned long addr)
 }
 
 /**
- * vfio_ap_irq_enable - Enable Interruption for a APQN
+ * vfio_ap_irq_enable - enable interrupts for an AP queue on behalf of a guest
  *
- * @q:	 the vfio_ap_queue holding AQIC parameters
+ * @q:	 the vfio_ap_queue for which interrupts are to be enabled
  * @isc: the guest ISC to register with the GIB interface
- * @vcpu: the vcpu object containing the registers specifying the parameters
- *	  passed to the PQAP(AQIC) instruction.
+ * @vcpu: the vcpu whose registers contain the PQAP(AQIC) parameters
+ *
+ * Pins the guest NIB page, registers the guest ISC with the GIB to obtain a
+ * host ISC, and reissues PQAP(AQIC) with the translated host-absolute NIB
+ * address and host ISC on behalf of the guest.
  *
- * Pin the NIB saved in *q
- * Register the guest ISC to GIB interface and retrieve the
- * host ISC to issue the host side PQAP/AQIC
+ * The condition code and AP-queue status word returned by PQAP(AQIC) are
+ * reflected back to the guest as-is. IRQ state verification (polling until
+ * IR=1) is the responsibility of the guest AP bus, not the host.
  *
- * status.response_code may be set to AP_RESPONSE_INVALID_ADDRESS in case the
- * vfio_pin_pages or kvm_s390_gisc_register failed.
+ * Resource management is based solely on whether hardware accepted the new NIB:
+ * - AP_RESPONSE_NORMAL (CC=0): hardware accepted the new NIB; the old pinned
+ *   NIB page and registered guest ISC are freed and the new ones saved.
+ * - All other responses: hardware did not accept the new NIB; the newly pinned
+ *   page and registered ISC are freed and the previously saved resources are
+ *   left intact.
  *
- * Otherwise return the ap_queue_status returned by the ap_aqic(),
- * all retry handling will be done by the guest.
+ * AP_RESPONSE_INVALID_ADDRESS is returned if vfio_pin_pages() or
+ * kvm_s390_gisc_register() fails before the AQIC instruction is issued.
  *
  * Return: &struct ap_queue_status
  */
@@ -428,11 +580,10 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 	struct ap_queue_status status = {};
 	struct kvm_s390_gisa *gisa;
 	struct page *h_page;
-	int nisc;
+	int nisc, ret;
 	struct kvm *kvm;
 	phys_addr_t h_nib;
 	dma_addr_t nib;
-	int ret;
 
 	/* Verify that the notification indicator byte address is valid */
 	if (vfio_ap_validate_nib(vcpu, &nib)) {
@@ -489,27 +640,49 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 	status = ap_aqic(q->apqn, aqic_gisa, h_nib);
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
-		/* See if we did clear older IRQ configuration */
+		/*
+		 * Hardware accepted the new NIB address (CC=0). The old NIB and
+		 * guest ISC are no longer used by hardware and can be freed.
+		 * The new resources are saved for tracking and future teardown.
+		 *
+		 * IRQ state verification (polling until IR=1) is the
+		 * responsibility of the guest AP bus, not the host. The
+		 * condition code and status word are reflected back to the
+		 * guest to respond to the PQAP-AQIC instruction.
+		 */
 		vfio_ap_free_aqic_resources(q);
-		q->saved_iova = nib;
-		q->saved_isc = isc;
+		q->aqic_resources.iova = nib;
+		q->aqic_resources.isc  = isc;
+		q->aqic_resources.vdev = &q->matrix_mdev->vdev;
+		kvm_get_kvm(q->matrix_mdev->kvm);
+		q->aqic_resources.kvm  = q->matrix_mdev->kvm;
 		break;
 	case AP_RESPONSE_OTHERWISE_CHANGED:
-		/* We could not modify IRQ settings: clear new configuration */
+		/*
+		 * Interrupts are already enabled or a prior async request is still
+		 * completing. Either way, the hardware's current NIB is the one
+		 * saved in q->aqic_res — not the newly prepared resources.
+		 * Release the newly pinned page and registered ISC;
+		 * leave aqic_res intact.
+		 */
+		fallthrough;
+	default:
+		/*
+		 * Hardware did not accept the new NIB (CC=3 or error). The
+		 * previously saved NIB and guest ISC remain active and must
+		 * not be freed. Release the newly pinned page and registered
+		 * ISC that were prepared for this (rejected) request.
+		 */
 		ret = kvm_s390_gisc_unregister(kvm, isc);
 		if (ret)
 			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n",
 					 __func__, ret, isc, q->apqn);
 		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
 		break;
-	default:
-		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
-			status.response_code);
-		vfio_ap_irq_disable(q);
-		break;
 	}
 
-	if (status.response_code != AP_RESPONSE_NORMAL) {
+	if (status.response_code != AP_RESPONSE_NORMAL &&
+	    status.response_code != AP_RESPONSE_OTHERWISE_CHANGED) {
 		VFIO_AP_DBF_WARN("%s: PQAP(AQIC) failed with status=%#02x: "
 				 "zone=%#x, ir=%#x, gisc=%#x, f=%#x,"
 				 "gisa=%#x, isc=%#x, apqn=%#04x\n",
@@ -635,7 +808,6 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	}
 
 	status = vcpu->run->s.regs.gprs[1];
-
 	/* If IR bit(16) is set we enable the interrupt */
 	if ((status >> (63 - 16)) & 0x01)
 		qstatus = vfio_ap_irq_enable(q, status & 0x07, vcpu);
@@ -851,6 +1023,12 @@ static void vfio_ap_unlink_queue_fr_mdev(struct vfio_ap_queue *q)
 static void vfio_ap_unlink_mdev_fr_queue(struct vfio_ap_queue *q)
 {
 	q->matrix_mdev = NULL;
+	q->aqic_resources.vdev = NULL;
+	if (q->aqic_resources.kvm) {
+		kvm_put_kvm(q->aqic_resources.kvm);
+		q->aqic_resources.kvm = NULL;
+	}
+	q->aqic_resources.isc = VFIO_AP_ISC_INVALID;
 }
 
 static void vfio_ap_mdev_unlink_fr_queues(struct ap_matrix_mdev *matrix_mdev)
@@ -864,7 +1042,7 @@ static void vfio_ap_mdev_unlink_fr_queues(struct ap_matrix_mdev *matrix_mdev)
 			q = vfio_ap_mdev_get_queue(matrix_mdev,
 						   AP_MKQID(apid, apqi));
 			if (q)
-				q->matrix_mdev = NULL;
+				vfio_ap_unlink_mdev_fr_queue(q);
 		}
 	}
 }
@@ -1857,8 +2035,46 @@ static void unmap_iova(struct ap_matrix_mdev *matrix_mdev, u64 iova, u64 length)
 	int loop_cursor;
 
 	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
-		if (q->saved_iova >= iova && q->saved_iova < iova + length)
+		if (q->aqic_resources.iova >= iova && q->aqic_resources.iova < iova + length) {
 			vfio_ap_irq_disable(q);
+			/*
+			 * If AQIC disable was unable to confirm that interrupts were
+			 * disabled (IR=0), q->aqic_resources.iova remains non-zero.
+			 * VFIO core requires the mapped pages to be unpinned during
+			 * DMA unmap notifications (the type1 IOMMU backend will
+			 * BUG_ON after 10 re-notification retries if the pin is not
+			 * released).
+			 *
+			 * To satisfy VFIO core safely, fall back to a queue reset
+			 * via ZAPQ. ZAPQ wipes the queue state and clears the
+			 * hardware's internal NIB address register, neutralizing
+			 * pending DMA. Flush the reset worker so that we know
+			 * whether the NIB was released before returning.
+			 */
+			if (q->aqic_resources.iova) {
+				vfio_ap_mdev_reset_queue(q);
+				flush_work(&q->reset_work);
+			}
+
+			/*
+			 * If the NIB is still pinned after the reset (reset failed
+			 * or timed out), force-unpin it anyway. A host kernel panic
+			 * from the VFIO BUG_ON is worse than the theoretical risk of
+			 * a wild DMA write from already-misbehaving hardware, and a
+			 * pr_crit message records that the forced unpin occurred.
+			 */
+			if (q->aqic_resources.iova) {
+				pr_crit("APQN %02x.%04x: NIB page at %pad could not be safely unpinned after queue reset failure; force-unpinning to prevent kernel panic\n",
+					AP_QID_CARD(q->apqn),
+					AP_QID_QUEUE(q->apqn),
+					&q->aqic_resources.iova);
+				if (q->aqic_resources.vdev)
+					vfio_unpin_pages(q->aqic_resources.vdev,
+							 q->aqic_resources.iova, 1);
+				q->aqic_resources.iova = 0;
+				q->aqic_resources.vdev = NULL;
+			}
+		}
 	}
 }
 
@@ -1884,6 +2100,8 @@ static void vfio_ap_mdev_dma_unmap(struct vfio_device *vdev, u64 iova,
 static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 {
 	struct kvm *kvm = matrix_mdev->kvm;
+	unsigned long apid, apqi;
+	struct vfio_ap_queue *q;
 
 	if (kvm && kvm->arch.crypto.crycbd) {
 		get_update_locks_for_kvm(kvm);
@@ -1896,6 +2114,50 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 		release_update_locks_for_kvm(kvm);
 		kvm_put_kvm(kvm);
 	}
+
+	/*
+	 * The reset above may not have been able to confirm that all queues
+	 * were zeroized (e.g. worker -EIO, unexpected ZAPQ rc). Any queue
+	 * that still has iova set holds a pin in the IOMMU container that is
+	 * about to go away. The vfio contract requires every pinned page to
+	 * be released before close_device() returns: vfio core removes the
+	 * device from iommu->device_list after close_device() returns, after
+	 * which vfio_notify_dma_unmap() becomes a no-op and a later
+	 * VFIO_IOMMU_UNMAP_DMA will hit BUG_ON(++retries > 10) in type1.
+	 *
+	 * Force-unpin any surviving NIB pages now, while vdev is still valid.
+	 * This carries the same theoretical wild-DMA risk as the force-unpin
+	 * in unmap_iova(), and is chosen for the same reason: a guaranteed
+	 * host panic is worse than a theoretical risk on already-misbehaving
+	 * hardware.
+	 */
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
+			q = vfio_ap_mdev_get_queue(matrix_mdev,
+						   AP_MKQID(apid, apqi));
+			if (!q)
+				continue;
+
+			if (q->aqic_resources.iova) {
+				pr_crit("APQN %02x.%04x: NIB page at %pad could not be safely unpinned after queue reset failure; force-unpinning to prevent kernel panic\n",
+					AP_QID_CARD(q->apqn),
+					AP_QID_QUEUE(q->apqn),
+					&q->aqic_resources.iova);
+				if (q->aqic_resources.vdev)
+					vfio_unpin_pages(q->aqic_resources.vdev,
+							 q->aqic_resources.iova,
+							 1);
+				q->aqic_resources.iova = 0;
+				q->aqic_resources.vdev = NULL;
+			}
+
+			if (q->aqic_resources.kvm) {
+				kvm_put_kvm(q->aqic_resources.kvm);
+				q->aqic_resources.kvm = NULL;
+			}
+			q->aqic_resources.isc = VFIO_AP_ISC_INVALID;
+		}
+	}
 }
 
 static struct vfio_ap_queue *vfio_ap_find_queue(int apqn)
@@ -1919,20 +2181,59 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 {
 	switch (status->response_code) {
 	case AP_RESPONSE_NORMAL:
+		/*
+		 * This response code only indicates that the PQAP(ZAPQ) has
+		 * been initiated. The following bit settings in the status
+		 * returned from TAPQ must be verified to confirm that the
+		 * asynchronous portion of the queue zeroization has completed.
+		 */
+		if (status->queue_empty && !status->replies_waiting &&
+		    !status->irq_enabled && !status->async)
+			return 0;
+
+		/* Async zeroization still in progress; keep waiting */
+		return -EBUSY;
+
 	case AP_RESPONSE_DECONFIGURED:
 	case AP_RESPONSE_CHECKSTOPPED:
-		return 0;
+		/*
+		 * The queue is non-operational: interrupts are not possible so
+		 * AQIC resources can be safely freed. However, zeroization
+		 * cannot be confirmed because all status bits are zeroed when
+		 * these response codes are returned — there is no way to
+		 * distinguish a zeroized queue from one that has not been
+		 * zeroized. Return -ENODEV to signal that AQIC resources should
+		 * be freed but that zeroization has not been confirmed.
+		 */
+		return -ENODEV;
+
 	case AP_RESPONSE_RESET_IN_PROGRESS:
+		/*
+		 * A reset is in progress. It may be our ZAPQ or a prior reset
+		 * (e.g. a RAPQ from the AP bus or guest). Keep waiting: if it
+		 * is our ZAPQ it will zeroize the queue; if it is a prior reset,
+		 * q->reset_status holds RESET_IN_PROGRESS (our ZAPQ was
+		 * rejected) and apq_reset_check() will re-issue the ZAPQ once
+		 * this reset clears.
+		 */
+		return -EBUSY;
+
 	case AP_RESPONSE_BUSY:
+		/*
+		 * TAPQ returned BUSY (rc 05). This says the queue is busy but
+		 * tells us nothing about whether our ZAPQ was accepted: the
+		 * zeroization may already be in progress. Treat it the same as
+		 * RESET_IN_PROGRESS — keep waiting without re-issuing the ZAPQ.
+		 */
 		return -EBUSY;
+
 	case AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE:
 	case AP_RESPONSE_ASSOC_FAILED:
 		/*
 		 * These asynchronous response codes indicate a PQAP(AAPQ)
 		 * instruction to associate a secret with the guest failed. All
 		 * subsequent AP instructions will end with the asynchronous
-		 * response code until the AP queue is reset; so, let's return
-		 * a value indicating a reset needs to be performed again.
+		 * response code until the AP queue is reset. Re-issue the ZAPQ.
 		 */
 		return -EAGAIN;
 	case AP_RESPONSE_Q_NOT_AVAIL:
@@ -1961,10 +2262,23 @@ static void apq_reset_check(struct work_struct *reset_work)
 		elapsed += AP_RESET_INTERVAL;
 		status = ap_tapq(q->apqn, NULL);
 		ret = apq_status_check(q->apqn, &status);
-		if (ret == -EIO)
-			return;
-		if (ret == -ENODEV) {
-			vfio_ap_free_aqic_resources(q);
+		if (ret == -EIO) {
+			/*
+			 * TAPQ returned an invalid response code indicating a
+			 * hardware or firmware bug. Since we cannot determine
+			 * whether the queue can still DMA-write to the NIB, the
+			 * AQIC resources are intentionally leaked lest the NIB
+			 * page is reallocated to a new owner. A subsequent
+			 * wild DMA-write to that physical address would corrupt
+			 * the new owner's memory which could crash or compromise
+			 * the host kernel.
+			 *
+			 * Record the TAPQ status so the queue is marked
+			 * not-passable - _queue_passable() checks
+			 * reset_status.response_code == AP_RESPONSE_NORMAL -
+			 * and the queue is not passed through to a guest.
+			 */
+			memcpy(&q->reset_status, &status, sizeof(status));
 			return;
 		}
 		if (ret == -EBUSY) {
@@ -1976,15 +2290,33 @@ static void apq_reset_check(struct work_struct *reset_work)
 					      status.irq_enabled);
 		} else {
 			if (q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
-			    q->reset_status.response_code == AP_RESPONSE_BUSY ||
 			    q->reset_status.response_code == AP_RESPONSE_STATE_CHANGE_IN_PROGRESS ||
 			    ret == -EAGAIN) {
+				/*
+				 * RESET_IN_PROGRESS in reset_status means the
+				 * initial ZAPQ was rejected because a prior reset
+				 * was already running. That reset does not zeroize
+				 * the queue; re-issue the ZAPQ once it clears.
+				 *
+				 * STATE_CHANGE_IN_PROGRESS in reset_status means
+				 * the initial ZAPQ was rejected because the queue
+				 * was mid-transition; re-issue once it clears.
+				 *
+				 * -EAGAIN means TAPQ returned an ASSOC error code
+				 * (0x35/0x36): the queue is stuck until reset.
+				 * Re-issue the ZAPQ to recover.
+				 */
 				status = ap_zapq(q->apqn, 0);
 				memcpy(&q->reset_status, &status, sizeof(status));
 				continue;
 			}
-			if (q->saved_isc != VFIO_AP_ISC_INVALID)
-				vfio_ap_free_aqic_resources(q);
+			/*
+			 * We end up here when the reset has completed (TAPQ
+			 * returned NORMAL with all status bits clear, or
+			 * DECONFIGURED/CHECKSTOPPED). The queue is zeroized or
+			 * non-operational; free the AQIC resources.
+			 */
+			vfio_ap_free_aqic_resources(q);
 			break;
 		}
 	}
@@ -2001,7 +2333,6 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
 	case AP_RESPONSE_RESET_IN_PROGRESS:
-	case AP_RESPONSE_BUSY:
 	case AP_RESPONSE_STATE_CHANGE_IN_PROGRESS:
 		/*
 		 * Let's verify whether the ZAPQ completed successfully on a work queue.
@@ -2014,6 +2345,15 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 		vfio_ap_free_aqic_resources(q);
 		break;
 	default:
+		/*
+		 * An invalid response code indicates a hardware or firmware bug.
+		 * Since we cannot determine whether the queue can still
+		 * DMA-write to the NIB, the AQIC resources are intentionally
+		 * leaked lest the NIB page is reallocated to a new owner. A
+		 * subsequent hardware wild DMA-write to that physical address
+		 * would corrupt the new owner's memory which could crash or
+		 * compromise the host kernel.
+		 */
 		WARN(true,
 		     "PQAP/ZAPQ for %02x.%04x failed with invalid rc=%u\n",
 		     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
@@ -2463,7 +2803,8 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 	}
 
 	q->apqn = apqn;
-	q->saved_isc = VFIO_AP_ISC_INVALID;
+	q->aqic_resources.isc = VFIO_AP_ISC_INVALID;
+	/* aqic_res.iova, .vdev, .kvm all zero-initialised by kzalloc_obj */
 	memset(&q->reset_status, 0, sizeof(q->reset_status));
 	INIT_WORK(&q->reset_work, apq_reset_check);
 
@@ -2543,6 +2884,13 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 		vfio_ap_mdev_reset_queue(q);
 		flush_work(&q->reset_work);
 	} else {
+		/*
+		 * The queue is no longer in the host's AP configuration.
+		 * The hardware cannot DMA-write to the NIB, so it is safe
+		 * to free the AQIC resources directly without issuing a
+		 * ZAPQ. If the queue is not assigned to an mdev,
+		 * vfio_ap_free_aqic_resources() is a no-op.
+		 */
 		vfio_ap_free_aqic_resources(q);
 	}
 
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 9bff666b0b35..d0d968d0ff9c 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -127,29 +127,50 @@ struct ap_matrix_mdev {
 	DECLARE_BITMAP(adm_add, AP_DOMAINS);
 };
 
+/**
+ * struct vfio_ap_aqic_resources - AQIC resources acquired when a guest enables
+ *				   interrupts for an AP queue.
+ *
+ * @iova: the guest DMA address of the notification indicator byte (NIB) page,
+ *	  pinned via @vdev at enable time.
+ * @isc:  the guest interruption sub-class registered with the GIB via @kvm at
+ *	  enable time.
+ * @vdev: the vfio_device whose IOMMU container owns the pin on @iova. Must be
+ *	  used for vfio_unpin_pages() to ensure the correct container is used,
+ *	  even if the queue is later re-assigned or the mdev is reopened.
+ * @kvm:  the KVM instance that owns the GISC registration for @isc. Must be
+ *	  used for kvm_s390_gisc_unregister() to ensure the correct guest's
+ *	  alert mask is updated, even if the queue is later re-assigned or the
+ *	  mdev is reopened with a different guest.
+ */
+struct vfio_ap_aqic_resources {
+	dma_addr_t			iova;
+#define VFIO_AP_ISC_INVALID	0xff
+	unsigned char			isc;
+	struct vfio_device		*vdev;
+	struct kvm			*kvm;
+};
+
 /**
  * struct vfio_ap_queue - contains the data associated with a queue bound to the
  *			  vfio_ap device driver
- * @matrix_mdev: the matrix mediated device
- * @saved_iova: the notification indicator byte (nib) address
- * @apqn: the APQN of the AP queue device
- * @saved_isc: the guest ISC registered with the GIB interface
- * @mdev_qnode: allows the vfio_ap_queue struct to be added to a hashtable
+ * @matrix_mdev:    the matrix mediated device
+ * @aqic_resources: the AQIC resources acquired when a guest enables AP interrupts
+ * @apqn:           the APQN of the AP queue device
+ * @mdev_qnode:  allows the vfio_ap_queue struct to be added to a hashtable
  * @reset_qnode: allows the vfio_ap_queue struct to be added to a list of queues
  *		 that need to be reset
  * @reset_status: the status from the last reset of the queue
- * @reset_work: work to wait for queue reset to complete
+ * @reset_work:  work to wait for queue reset to complete
  */
 struct vfio_ap_queue {
-	struct ap_matrix_mdev *matrix_mdev;
-	dma_addr_t saved_iova;
-	int	apqn;
-#define VFIO_AP_ISC_INVALID 0xff
-	unsigned char saved_isc;
-	struct hlist_node mdev_qnode;
-	struct list_head reset_qnode;
-	struct ap_queue_status reset_status;
-	struct work_struct reset_work;
+	struct ap_matrix_mdev		*matrix_mdev;
+	struct vfio_ap_aqic_resources	aqic_resources;
+	int				apqn;
+	struct hlist_node		mdev_qnode;
+	struct list_head		reset_qnode;
+	struct ap_queue_status		reset_status;
+	struct work_struct		reset_work;
 };
 
 int vfio_ap_mdev_register(void);
-- 
2.53.0

