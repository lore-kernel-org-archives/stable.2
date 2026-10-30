Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349213;
	b=mHAv/UJblyVJJKxWIbTavt7UIwW/mfF7+9y/Jl+6bPndnbS2H9qlWLpBEpB181xsYQo5
	 oI3v8bA5AEE5P1Kla0E5lUWIfQQ+xu6Kar/dg3u+pvfhMnlao/r3+B9VZ7+VA6Fr7FxZZ
	 yowf2CMdICgvWH4LdzFFuPwhzkHdIarYZYhNUXGM23q0yKBhUrP+CaV0CnvAx2tuMp/au
	 VMYQ6vlbZKOjfTNs8vFoFsE1YswN8fqbWN6v27cYABuCFEw4epYboOi5A+BOVin0zkjCS
	 jLwLFOUmvmGRhKO9Urx6zIzmzVbXfKJVvki+40m58KRZypRRFKQtnWjANttnDvvu4Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349213;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:
	 Content-Type:X-Sendblock-Type:CMS-TYPE:X-CPGSPASS:cpgsPolicy:
	 X-CFilter-Loop:X-CMS-RootMailID:References;
	bh=hi2uvnC9ir/wNrY70ZqEhA8kUNmKSoQFaTg1fenGlGc=;
	b=oyVWtd/hkU22RhknjPdiADE7e9wjyxJFLM48wA0lPb5BnDqyZnHj1DtdNYbgft0ECGGj
	 yhWehd/aJGGFH/o4fpHdy0DfHadkUFB5dQL2EpDO3oVw3FEofCp+6zSazBlgBdQgDlMBe
	 JL4lBm+PlQWAAo8SZVGsUFlCymmoVJ70hbl4aKKsv/E2gYMMxC2OWxF/jTLFoaIRg9XPM
	 UqjTnO2kJE0dq62ffDuTkJyTRseKaKaBAVN/F2CtqgGSWLURsTmpoHKFZ4yuy1avclsdN
	 dLt99wTvw32uhzQnxEAdugdFGu/BKkGaepvU32A3MlM5Yhz0IfCy3KED25aUAeFyKtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=BAi16SBa;
	arc=none smtp.remote-ip=203.254.224.34
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057F1606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 057F1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=BAi16SBa
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20261030083323epoutp04ea568098dd814b764a93959840e016dc~jQZlCb2wt2383323833epoutp04M
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:33:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20261030083323epoutp04ea568098dd814b764a93959840e016dc~jQZlCb2wt2383323833epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793349203;
	bh=hi2uvnC9ir/wNrY70ZqEhA8kUNmKSoQFaTg1fenGlGc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=BAi16SBab+l4Tr5b70eKFlsCKC0v//ZRQXaH+6m+TgADr2GH71vFMmdMnno4L0p/+
	 f15ej1BVuh1g+YLyYho6QF0cIfXCLYHYxue1jO4iWXhc5SUgeYsNFk5LaeeptYvc6x
	 csffMSmH014mLYyIcWyl9oKR2G2iyJ3NSlPLYMbM=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20261030083322epcas2p206deb9d297d77c50a36b79514eb0258a~jQZkjmIaL1248812488epcas2p2n;
	Fri, 30 Oct 2026 08:33:22 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.201]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4jGDrf1tMSz6B9mG; Fri, 30 Oct
	2026 08:33:22 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20261030083321epcas2p2872d81c94fed72e685d580c0fc5d4bb6~jQZjrapus1765017650epcas2p2g;
	Fri, 30 Oct 2026 08:33:21 +0000 (GMT)
Received: from apsw.samsungds.net (unknown [12.80.211.160]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261030083321epsmtip12db131c232ba584937d545724dcd1de0~jQZjl7HTF0314303143epsmtip1N;
	Fri, 30 Oct 2026 08:33:21 +0000 (GMT)
From: Kiwoong Kim <kwmad.kim@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, bvanassche@acm.org, kwangwon.min@samsung.com,
	kwmad.kim@samsung.com, cpgs@samsung.com, h10.kim@samsung.com
Cc: stable@vger.kernel.org, stanleyjhu@google.com
Subject: [PATCH v1] ufs: mcq: fix dev cmd abort path and add OCS poll after
 sq cleanup
Date: Fri, 30 Oct 2026 17:33:11 +0900
Message-ID: <20261030083311.602909-1-kwmad.kim@samsung.com>
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
X-CMS-MailID: 20261030083321epcas2p2872d81c94fed72e685d580c0fc5d4bb6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261030083321epcas2p2872d81c94fed72e685d580c0fc5d4bb6
References: <CGME20261030083321epcas2p2872d81c94fed72e685d580c0fc5d4bb6@epcas2p2.samsung.com>

In MCQ mode, ufshcd_mcq_abort() falls through to ufshcd_try_to_abort_task()
for all timed-out commands. However, device management commands (query, NOP)
use reserved requests and are not SCSI I/O commands. The ABORT TASK task
management function is designed for SCSI I/O UPIUs and is not applicable to
device management UPIUs.

Fix this by checking ufshcd_is_scsi_cmd() in ufshcd_try_to_abort_task(). When
the request is a reserved (device management) command, skip the TM path and
call ufshcd_clear_cmd() directly instead.

Additionally, extend ufshcd_mcq_sq_cleanup() to poll the OCS field in the
UTRD after a successful SQ_CUS poll. UFSHCI does not specify the order between
the OCS update and the SQ_CUS update, so OCS may still be stale when cleanup
returns. Without this poll, a late response to a timed-out query can arrive
while a retry is already in flight, leaving the host with two query contexts
and raising IS.UTPES.

The poll waits until OCS is no longer OCS_INVALID_COMMAND_STATUS or
MCQ_POLL_US elapses. Any non-zero OCS after the poll is reported as
-ETIMEDOUT.

--
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

5. The driver retried the query again, but the device didn't return anything,
so the query was also timed-out.

[ 7385.660108] [3:  kworker/u40:5:10671] exynos-ufs 38300000.ufs: ufshcd_query_flag: Sending flag query for idn 14 failed, err = -11

6. A few seconds later, the device returned the response of the 1st query,
but since the host was holding two query contexts and couldn't handle it,
it raised IS.UTPES.
---
 drivers/ufs/core/ufs-mcq.c | 24 +++++++++++++++++++++++-
 drivers/ufs/core/ufshcd.c  |  4 ++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 8106d55f4041..091ae67d1dde 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -603,12 +603,34 @@ int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag)
 	if (err)
 		dev_err(hba->dev, "%s: failed. hwq=%d, tag=%d err=%d\n",
 			__func__, id, task_tag, err);
-	else
+	else {
+		enum utp_ocs ocs;
+		ktime_t start = ktime_get();
+
 		dev_info(hba->dev,
 			 "%s, hwq %d: cleanup return code (RTC) %ld\n",
 			 __func__, id,
 			 FIELD_GET(SQ_ICU_ERR_CODE_MASK, readl(reg)));
 
+		/*
+		 * There is no order guaranteed between OCS update and CUS update,
+		 * which is why we need to wait here.
+		 */
+		do {
+			unsigned long flags;
+
+			spin_lock_irqsave(&hwq->cq_lock, flags);
+			ocs = READ_ONCE(lrbp->utr_descriptor_ptr->header.ocs);
+			spin_unlock_irqrestore(&hwq->cq_lock, flags);
+			if (ocs != OCS_INVALID_COMMAND_STATUS)
+				break;
+			usleep_range(20, 50);
+		} while (ktime_us_delta(ktime_get(), start) < MCQ_POLL_US);
+
+		if (ocs)
+			err = -ETIMEDOUT;
+	}
+
 	if (ufshcd_mcq_sq_start(hba, hwq))
 		err = -ETIMEDOUT;
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index bcc2512bf34b..7fc80926eeec 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8046,6 +8046,9 @@ int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 
 	lrbp = scsi_cmd_priv(cmd);
 
+	if (!ufshcd_is_scsi_cmd(cmd))
+		goto clear_cmd;
+
 	for (poll_cnt = 100; poll_cnt; poll_cnt--) {
 		err = ufshcd_issue_tm_cmd(hba, lrbp->lun, tag, UFS_QUERY_TASK,
 					  &resp);
@@ -8091,6 +8094,7 @@ int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 		return err;
 	}
 
+clear_cmd:
 	err = ufshcd_clear_cmd(hba, tag);
 	if (err)
 		dev_err(hba->dev, "%s: Failed clearing cmd at tag %d, err %d\n",
-- 
2.43.0

