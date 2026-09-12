Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82262DAFDE
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176736; cv=none; b=h43JhyzA/a5O9k0Fcxky4sHPUVRS7MZr5CbqraFv+yV96YefniEyM7e5JcZ7aDzAXqAbkDvgDVpN9HAt7gUG77mbNnpuiUtjkBVJhw3sZluEPiU+9UYHsGK3GcEQNp9TlLb2katLRSpZwgmi58wTrKlWYVi8GCPlKjrYkKBBIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176736; c=relaxed/simple;
	bh=JWEw4uMyzPB/+sy2oWhmuUsQVC/7vExpxy2551vSjjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKmGZRVyPnm1CS/u1br9ooyGLD5u6gebS4xS8iYO3Cwhx2ETCjALXD+9xM0alOHn5EjV+nR8h6m87nHI6a3Rap8AhBA/41ry0uzyeyUt4RdAwZCXr+ZAn/Ucer/aJYwRnpxLvtThJExul9WfSKQgkWNV51Yk3kxYa5Qay0aKYE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPMC6xAD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPMC6xAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64F91F00893;
	Sat, 12 Sep 2026 01:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176734;
	bh=QGUvyWLN6NNg8v8F5E3xCvp0+q9s/bD68f9UnMhCGyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HPMC6xADaJVtSVqDOMT7MZuBkIBCBdppPfen6BRCjW58oUwo1C+DDkOloOD8QZ0R2
	 YniVKPRmci51k+5SOlupjMBrFYy/M6g24N5N7spMZWKcMf+sUZpU0fwCf0zZOJIN6c
	 qwZvPxx3w8MhI99U2JIoWP2X3syxq2QIJDzvQ28tSWaAflFp7n3dUNGRAMaN1LS9dM
	 O2OJ5L0wprpnwQLDxoYgFOWhLj6Ea628TqbXN8EFEfPcniJyrCXj+klpKUh60fC1he
	 zcIUGV9E6xFXFa9RbgGCjE0fU2552S861Iz1zvuNjJ0mRMvJoZuFxDVoRjA/SivTRD
	 QoMhtafAsH+Ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <niklas.cassel@wdc.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] scsi: block: ioprio: Clean up interface definition
Date: Fri, 11 Sep 2026 21:32:09 -0400
Message-ID: <20260912013211.1760018-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912013211.1760018-1-sashal@kernel.org>
References: <2026090930-ricotta-unpledged-5906@gregkh>
 <20260912013211.1760018-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit eca2040972b411ec27483bf75dc8b84e730e88ff ]

The I/O priority user interface defines the 16-bits ioprio values as the
combination of the upper 3-bits for an I/O priority class and the lower
13-bits as priority data. However, the kernel only uses the lower 3-bits of
the priority data to define priority levels for the RT and BE priority
classes. The data part of an ioprio value is completely ignored for the
IDLE and NONE classes. This is enforced by checks done in
ioprio_check_cap(), which is called for all paths that allow defining an
I/O priority for I/Os: the per-context ioprio_set() system call, aio
interface and io_uring interface.

Clarify this fact in the uapi ioprio.h header file and introduce the
IOPRIO_PRIO_LEVEL_MASK and IOPRIO_PRIO_LEVEL() macros for users to define
and get priority levels in an ioprio value. The coarser macro
IOPRIO_PRIO_DATA() is retained for backward compatibility with old
applications already using it. There is no functional change introduced
with this.

In-kernel users of the IOPRIO_PRIO_DATA() macro which are explicitly
handling I/O priority data as a priority level are modified to use the new
IOPRIO_PRIO_LEVEL() macro without any functional change. Since f2fs is the
only user of this macro not explicitly using that value as a priority
level, it is left unchanged.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Link: https://lore.kernel.org/r/20230511011356.227789-2-nks@flawful.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 5cb33b00c8fb ("f2fs: avoid NULL checkpoint thread access in sysfs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-iosched.c         |  8 ++++----
 block/ioprio.c              |  6 +++---
 include/uapi/linux/ioprio.h | 19 ++++++++++++++-----
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d1c62a4e8c357..e9fee4d9d08a8 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5496,16 +5496,16 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 		bfqq->new_ioprio_class = task_nice_ioclass(tsk);
 		break;
 	case IOPRIO_CLASS_RT:
-		bfqq->new_ioprio = IOPRIO_PRIO_DATA(bic->ioprio);
+		bfqq->new_ioprio = IOPRIO_PRIO_LEVEL(bic->ioprio);
 		bfqq->new_ioprio_class = IOPRIO_CLASS_RT;
 		break;
 	case IOPRIO_CLASS_BE:
-		bfqq->new_ioprio = IOPRIO_PRIO_DATA(bic->ioprio);
+		bfqq->new_ioprio = IOPRIO_PRIO_LEVEL(bic->ioprio);
 		bfqq->new_ioprio_class = IOPRIO_CLASS_BE;
 		break;
 	case IOPRIO_CLASS_IDLE:
 		bfqq->new_ioprio_class = IOPRIO_CLASS_IDLE;
-		bfqq->new_ioprio = 7;
+		bfqq->new_ioprio = IOPRIO_NR_LEVELS - 1;
 		break;
 	}
 
@@ -5791,7 +5791,7 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 				       struct bfq_io_cq *bic,
 				       bool respawn)
 {
-	const int ioprio = IOPRIO_PRIO_DATA(bic->ioprio);
+	const int ioprio = IOPRIO_PRIO_LEVEL(bic->ioprio);
 	const int ioprio_class = IOPRIO_PRIO_CLASS(bic->ioprio);
 	struct bfq_queue **async_bfqq = NULL;
 	struct bfq_queue *bfqq;
diff --git a/block/ioprio.c b/block/ioprio.c
index 32a456b458049..f0d9e818abc53 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -33,7 +33,7 @@
 int ioprio_check_cap(int ioprio)
 {
 	int class = IOPRIO_PRIO_CLASS(ioprio);
-	int data = IOPRIO_PRIO_DATA(ioprio);
+	int level = IOPRIO_PRIO_LEVEL(ioprio);
 
 	switch (class) {
 		case IOPRIO_CLASS_RT:
@@ -49,13 +49,13 @@ int ioprio_check_cap(int ioprio)
 			fallthrough;
 			/* rt has prio field too */
 		case IOPRIO_CLASS_BE:
-			if (data >= IOPRIO_NR_LEVELS || data < 0)
+			if (level >= IOPRIO_NR_LEVELS)
 				return -EINVAL;
 			break;
 		case IOPRIO_CLASS_IDLE:
 			break;
 		case IOPRIO_CLASS_NONE:
-			if (data)
+			if (level)
 				return -EINVAL;
 			break;
 		default:
diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index f70f2596a6bf7..4444b4e4fdad9 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -17,7 +17,7 @@
 	 ((data) & IOPRIO_PRIO_MASK))
 
 /*
- * These are the io priority groups as implemented by the BFQ and mq-deadline
+ * These are the io priority classes as implemented by the BFQ and mq-deadline
  * schedulers. RT is the realtime class, it always gets premium service. For
  * ATA disks supporting NCQ IO priority, RT class IOs will be processed using
  * high priority NCQ commands. BE is the best-effort scheduling class, the
@@ -32,11 +32,20 @@ enum {
 };
 
 /*
- * The RT and BE priority classes both support up to 8 priority levels.
+ * The RT and BE priority classes both support up to 8 priority levels that
+ * can be specified using the lower 3-bits of the priority data.
  */
-#define IOPRIO_NR_LEVELS	8
-#define IOPRIO_BE_NR		IOPRIO_NR_LEVELS
+#define IOPRIO_LEVEL_NR_BITS		3
+#define IOPRIO_NR_LEVELS		(1 << IOPRIO_LEVEL_NR_BITS)
+#define IOPRIO_LEVEL_MASK		(IOPRIO_NR_LEVELS - 1)
+#define IOPRIO_PRIO_LEVEL(ioprio)	((ioprio) & IOPRIO_LEVEL_MASK)
 
+#define IOPRIO_BE_NR			IOPRIO_NR_LEVELS
+
+/*
+ * Possible values for the "which" argument of the ioprio_get() and
+ * ioprio_set() system calls (see "man ioprio_set").
+ */
 enum {
 	IOPRIO_WHO_PROCESS = 1,
 	IOPRIO_WHO_PGRP,
@@ -44,7 +53,7 @@ enum {
 };
 
 /*
- * Fallback BE priority level.
+ * Fallback BE class priority level.
  */
 #define IOPRIO_NORM	4
 #define IOPRIO_BE_NORM	IOPRIO_NORM
-- 
2.53.0

