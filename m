Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785775;
	b=RJxPqHP5nVtX72BK9I+H5bnWSynkTJ21hnM35SzfHPuuXfy2bntmPeGV1mywsc+Ln3pz
	 DixZIJjuJ4V9Jm/dOfIsvGJjcyjbC8XfDzBaZOS1zegVojEIOJ1Aexy2LURi+jMDiZ4lB
	 unYpHPi8cnQSaumS0uRUSOdcMidmt+peTFu0RG3TBuPTXIXVr2VW5DY3EL9ddCs/ZBe50
	 MM/ZYhNS4btAgF1ftIliivtHgiiFBxmbZw9vi4jg6iIGuTWWfLC9bInJRtI7m/14ZbbYo
	 RCRF/LGer4PmZuulMBhO/9UTaPSryOPlqZ/9sMboZCLXULYzYu0UBlT7AzH4f+3YotQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785775;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:
	 X-Msg-Generator:Content-Type:X-Sendblock-Type:CMS-TYPE:X-CPGSPASS:
	 cpgsPolicy:X-CFilter-Loop:X-CMS-RootMailID:References;
	bh=YizUKSZomut51qhv45bLuQBmO4JbaEiPfKxr7sOmo9k=;
	b=IayKHy54oxI675ZYHCku6dkvstVMlt6s98LXqd3SrWbaO+Djm4nt5g72op1LilJcEGOV
	 SnFDxylnNQFg5M8iyyFg3b7RqFDzUaZRPEhZ5LLwDhltgSa02KN+I71l7h55Z9/ONUsSW
	 oeGaKp8sBbF1xQckv/rTcY++p/4jnMWH0lm0vZLNyzAqo8jwqeHtYEusYvKRmKC3rc9ow
	 Cen0JZA9KjsWTohLnRBhoXiA8TsTyyymX3vC48TayfpElBkPN2cqHLxcQjT9xJF2UmF5b
	 A0h7Us0ajdCFr8HE5UG1iLwGn2kitHBGN9CZ0OahkJJ28Z85pYVusrWs/EQCyfQojvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=ZiQFmtoc;
	arc=none smtp.remote-ip=203.254.224.25
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7341D606A33A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 09:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7341D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=ZiQFmtoc
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20261104094927epoutp02017597f7b176bc402abc0f17f0bbb6d7~kzqbHX3x_2018820188epoutp02Y
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 09:49:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20261104094927epoutp02017597f7b176bc402abc0f17f0bbb6d7~kzqbHX3x_2018820188epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793785767;
	bh=YizUKSZomut51qhv45bLuQBmO4JbaEiPfKxr7sOmo9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZiQFmtocw40VaTyDEpkzebs/eV+fKJIIYzlkfYTNkXrQMyZjh5FRMr71UskutFpYG
	 2uMvLVFP41086ESc84FSjDLo3+fZvJrl/JdvIkhe5Pr/Ns38lLzw4/SRaj5v09QEub
	 dd4VLgvF8t550r1rRg+mgD6SYrUtV3U+iEqhtsgM=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20261104094926epcas2p2e312fe717dc4185cbfae59229af4ada1~kzqaicL3B0604706047epcas2p2d;
	Wed,  4 Nov 2026 09:49:26 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.210]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4jKLJ62Dcyz6B9m7; Wed,  4 Nov
	2026 09:49:26 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20261104094925epcas2p1f25905de00c2548e1e1349fba5f18551~kzqZg4LHj2536525365epcas2p1-;
	Wed,  4 Nov 2026 09:49:25 +0000 (GMT)
Received: from apsw.samsungds.net (unknown [12.80.211.160]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261104094925epsmtip128aee456909e23d6086195d36e01193c~kzqZbUgmM0125501255epsmtip1S;
	Wed,  4 Nov 2026 09:49:25 +0000 (GMT)
From: Kiwoong Kim <kwmad.kim@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	alim.akhtar@samsung.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
	bvanassche@acm.org, kwangwon.min@samsung.com, hy50.seo@samsung.com,
	cpgs@samsung.com, h10.kim@samsung.com
Cc: stable@vger.kernel.org, stanleyjhu@google.com, Kiwoong Kim
	<kwmad.kim@samsung.com>
Subject: [PATCH v5 2/2] ufs: mcq: poll OCS after sq cleanup for device
 management commands
Date: Wed,  4 Nov 2026 18:49:14 +0900
Message-ID: <20261104094914.180788-3-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104094914.180788-1-kwmad.kim@samsung.com>
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
X-CMS-MailID: 20261104094925epcas2p1f25905de00c2548e1e1349fba5f18551
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261104094925epcas2p1f25905de00c2548e1e1349fba5f18551
References: <20261104094914.180788-1-kwmad.kim@samsung.com>
	<CGME20261104094925epcas2p1f25905de00c2548e1e1349fba5f18551@epcas2p1.samsung.com>

Extend ufshcd_mcq_sq_cleanup() to poll the OCS field in the UTRD of a
device management command after a successful SQ_CUS poll. UFSHCI does not
specify the order between the OCS update and the SQ_CUS update, so OCS may
still be stale when cleanup returns. Without this poll, a late response to
a timed-out query can arrive while a retry is already in flight, leaving
the host with two query contexts and raising IS.UTPES.

The poll is limited to device management commands because
ufshcd_compl_one_cqe() copies the OCS from the CQE into the UTRD only for
them. For SCSI commands, the OCS in the UTRD stays
OCS_INVALID_COMMAND_STATUS, so polling it would always time out.

The poll waits until OCS is no longer OCS_INVALID_COMMAND_STATUS or
MCQ_POLL_US elapses. -ETIMEDOUT is returned only if OCS is still
OCS_INVALID_COMMAND_STATUS after the poll. Any other value, such as
OCS_ABORTED reported by the host controller for the cleaned-up request,
means the cleanup has completed.

Here is the timeline of an actual case for this that happened with kernel 6.18.
1. The host sent a query but the device didn't respond with it for a long time.

[ 7384.156142] [4:  kworker/u40:5:10671] exynos-ufs 38300000.ufs: ufshcd_mcq_sq_cleanup, hwq 0: cleanup return code (RTC) 0
[ 7384.156154] [4:  kworker/u40:5:10671] exynos-ufs 38300000.ufs: ufshcd_query_flag: Sending flag query for idn 14 failed, err = -11

2. So after the query was timed out, the driver did SQ cleanup.
Then the host updated CQ update and raised IS.CQES,
Unfortunately, complete() was called the driver's ISR afterward.

3. The driver started to retried the query. In the meantime, it set OCS to 0xF.
Then the driver didn't wait for completion due to the previous complete() call,
and just checked OCS.

[ 7384.156163] [4:  kworker/u40:5:10671] exynos-ufs 38300000.ufs: ufshcd_query_flag: Sending flag query for idn 14 failed, err = 15

4. The driver retried the query again, but the device didn't return anything,
so the query was also timed-out.

[ 7385.660108] [3:  kworker/u40:5:10671] exynos-ufs 38300000.ufs: ufshcd_query_flag: Sending flag query for idn 14 failed, err = -11

5. A few seconds later, the device returned the response of the 1st query,
but since the host was holding two query contexts and couldn't handle it,
it raised IS.UTPES.

Fixes: 8d7290348992 ("scsi: ufs: mcq: Add supporting functions for MCQ abort")
Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/ufs/core/ufs-mcq.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 8106d55f4041..100295d02c62 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -609,6 +609,24 @@ int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag)
 			 __func__, id,
 			 FIELD_GET(SQ_ICU_ERR_CODE_MASK, readl(reg)));
 
+	/*
+	 * For device management commands, there is no order guaranteed between
+	 * OCS update and CUS update, which is why we need to wait here. SCSI
+	 * commands are excluded because the OCS in their UTRD is not updated
+	 * from the CQE.
+	 */
+	if (!err && blk_mq_is_reserved_rq(rq)) {
+		enum utp_ocs ocs;
+
+		err = read_poll_timeout(READ_ONCE, ocs,
+					ocs != OCS_INVALID_COMMAND_STATUS, 20,
+					MCQ_POLL_US, false,
+					lrbp->utr_descriptor_ptr->header.ocs);
+		if (err)
+			dev_err(hba->dev, "%s: OCS not updated. hwq=%d, tag=%d err=%d\n",
+				__func__, id, task_tag, err);
+	}
+
 	if (ufshcd_mcq_sq_start(hba, hwq))
 		err = -ETIMEDOUT;
 
-- 
2.43.0

