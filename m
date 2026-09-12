Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9125B098
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789177427; cv=none; b=hVuB6q2xnEEOPbOwTZt3jjcDISyvSbPYYf7Cba8Lx37DjBa5PKueaDEVgFmJFAB3TPsyRxMn4T0LW15ILXMPQMpE3MLHY3+qQRrC6FqFcawsELj7MDbnyLsZrWevInXw7vOtSDGVlV05P6qfgkl8485mSteJ6p25x5S7A8AVCCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789177427; c=relaxed/simple;
	bh=DgJtrInPvF4y3WWuZC+BsEqes4XJ68S4RSJsRH8XsDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OD1zSbs8qACy3MOukEimISLaS6+5c0R8cYP3jB21yx7jnT7MAkvgW7YGuPA7FopOVCeQQ7/81CxunFPr0fF7h65/TfKk14XjIPKS3Kqg629lqBD+A+zkyuXSiQPD4+mo9+FY6/tYQKj8WsTJyVlw36pRMWfVmvfiN154So2A3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUYEYOAt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUYEYOAt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4834A1F00898;
	Sat, 12 Sep 2026 01:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789177426;
	bh=9RTytEjafJooxfj76VTbfc3vFlMz3R46hoJ72E7sXSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bUYEYOAtOFMhYL5N+nnZYr7VjvudUq3aGfefAzEzYDxmt68TjyB0i2tmqxpFxh7cB
	 ZY6A2XIOvAckK3MGkl5cJmMYU+mugymwVUZomrih5JeGsJga9eAeFzk7kFmifSDJr+
	 StrFfSo8KDam5dTi42rPyymEDf79IM/Qcxaiy8EANCScqEfc17oaitufI0JqWF++P7
	 4QdbC9AIHI2fR7xbEOZ9U1Mkn4dbpsieaj8D4OQPjqLnoxuv1N+W1yYDpZfExoDwim
	 w2CYnUzl5MvtrtPPbnQTKciGRvtzW5PBNNYKarGEDUR6mEcDbrQg/ADftR/ix3d3OP
	 xoamQrGigurPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <niklas.cassel@wdc.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] scsi: block: ioprio: Clean up interface definition
Date: Fri, 11 Sep 2026 21:43:41 -0400
Message-ID: <20260912014343.1817848-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912014343.1817848-1-sashal@kernel.org>
References: <2026090930-appease-drainpipe-8027@gregkh>
 <20260912014343.1817848-1-sashal@kernel.org>
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
index d830ed169e65c..c69e25e697120 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5314,16 +5314,16 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
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
 
@@ -5607,7 +5607,7 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 				       struct bfq_io_cq *bic,
 				       bool respawn)
 {
-	const int ioprio = IOPRIO_PRIO_DATA(bic->ioprio);
+	const int ioprio = IOPRIO_PRIO_LEVEL(bic->ioprio);
 	const int ioprio_class = IOPRIO_PRIO_CLASS(bic->ioprio);
 	struct bfq_queue **async_bfqq = NULL;
 	struct bfq_queue *bfqq;
diff --git a/block/ioprio.c b/block/ioprio.c
index 6c830154856fc..d2165f61e9c30 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -65,7 +65,7 @@ EXPORT_SYMBOL_GPL(set_task_ioprio);
 int ioprio_check_cap(int ioprio)
 {
 	int class = IOPRIO_PRIO_CLASS(ioprio);
-	int data = IOPRIO_PRIO_DATA(ioprio);
+	int level = IOPRIO_PRIO_LEVEL(ioprio);
 
 	switch (class) {
 		case IOPRIO_CLASS_RT:
@@ -81,13 +81,13 @@ int ioprio_check_cap(int ioprio)
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

