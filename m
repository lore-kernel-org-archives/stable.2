Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614893;
	b=pRGYnWtZhiu7tTZUljdWfoAoC0GKd/cDxLK9nQ3Q0/IXAu2wBxjJGGTqbXliU3PT2G1S
	 wSJghu3GhqDPNwc/EOLuxA2vGY7BVJHdjPMcHT9RgQ8PNy13PL0ZF3hwamoxEsNkMQgT0
	 pBSr7T7TWUHWyZnvTi7Ed5Dft8CwGegmTmT8MDQI5sgPNn6JHM/D5TltaZTVtXYFK69Cw
	 tv/zOOEVsBbKKPV0VTgTBVLKZVbbb7tlw8hg2AsxvfK5vcPyOxgqgXfSGnnG1Vrbcz6X9
	 4fB4HYXxbS0jGRXsumCJqCUaMuGqrMbMu1/2sg4c33hsw55g/POUQr7pwh0LoMTUlLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614893;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID;
	bh=oSGEGpwkaqCzWUy7fcDzNk0cyKiueFIlvJUyWO3cu7s=;
	b=3qKDtzuBtKrGU4qaVA2C8TsCccVqbQaysDH6KCaQQs42H4XwO0CrEfeNVEHEjBl9C1jU
	 5W5qtTPOsf9sPnFHCeq2t8dqFHjeh6CMGA9kqm5011tKRWkf9Zxcoj8073qNcAYno41g/
	 hcGxSbguVHIlS9NjMrAkNAvNOA5xptxvaVef7etyuYtc4YHp69vYZQTRBzRU95CL1Jnwr
	 Ua5/riTASPycXYaAGVzHXU3PcpeOtg7S/IMx9ovXm/E9W5BYNwI2srA/jEDDI5LoxlSHi
	 rDRYH9iFSt/xMcQktfyZMu415Pq8L3wJB0H6YWcOlX1fJXiqPBc34XeHl6V+XE9QXFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=DpbIihi0;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD09C606A330
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD09C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=DpbIihi0
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A20axAF1922556;
	Mon, 2 Nov 2026 10:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=oSGEG
	pwkaqCzWUy7fcDzNk0cyKiueFIlvJUyWO3cu7s=; b=DpbIihi0U1CbFTitfuClt
	O0gzLppWlvOBN2//132xxhWofrlEfc6Ts8FaLAQ9akb+p+I3DMlg4dKMRJ/9eC3z
	nHGtLQi8IG582OZyVGPg0HQTESjEFs79qX7h5kpHK9/Igze7xmctLFBbbaz5E6my
	wm3Yyw/6LwidvLQ7B5rY6zDYWHX03LWAIHfKzsEmMins+GVwkskr/fFIx0a3R28N
	SVjmTGFSmwayiw4XP3ngsj83sYqTps1Xsv1pqiUrogVoN95i8Qi8wC1UYmHsG5rD
	cFN8HS2t7xxSElvyYCH33N4juMYhT786ueUz4hajZbnVwvxg96foS6ZJV2VvdyCU
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn78a9mh4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:21:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29CwPG1424197;
	Mon, 2 Nov 2026 10:21:26 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4hpqhua27a-10;
	Mon, 02 Nov 2026 10:21:26 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Koichiro Den <den@valinux.co.jp>, Jakub Kicinski <kuba@kernel.org>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y 9/9] net: sched: avoid qdisc_reset_all_tx_gt() vs dequeue race for lockless qdiscs
Date: Mon,  2 Nov 2026 02:21:04 -0800
Message-ID: <20261102102104.1558500-10-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102102104.1558500-1-harshit.m.mogalapalli@oracle.com>
References: <20261102102104.1558500-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610300000 definitions=main-2611020040
X-Proofpoint-GUID: -PO83JcdEWqs_n9A_K-GDBYQc_q3wl_t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX7IsYcumk3Yeq
 tLlUG84xnQv0pEGHoMaqNV97eyF+/qY0MUDpUQYfe/7fZQ1s83fcYflYXwcRG1uP+YyNyzq0Qmo
 o8K8xWgtlvtd2szuo2N78N6epzpfvumCIeSoMQhlyyDUGT0iid4l
X-Authority-Analysis: v=2.4 cv=Mo3HeGae c=1 sm=1 tr=0 ts=6ae86427 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=j-PN0GCQJCEiRUQ5rfQA:9 a=FO4_E8m0qiDe52t0p3_H:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX7Dst90BvBhn2
 DClPxHnEvZ1XkAVktyJRhGuDCVejm3ml6YLeTh2Bd5lPsiMpEifgGUXCz1PrMHsy0Txb/ffDdUF
 Q1EMYL+t/X5RvttEhrnBo5j5PJRLv+R4V7gImL88PNGZRvxv+Ebv1r5PgHHuicrH0E8w6SekHtr
 hHaVjoD3KQyjecVfJdRVGJ4cCtOTyg+JVb4QAKgJ8e0AHjySEwypbQjItzS9vzIPdZ9Adw9lp8r
 IcL7DmSaGFp4WbImxcLc0GeZ8n47JaD9edK0K+Y42Q0SQcaZ1FGb/JLPs3M5CVSaxLIl+Sl+YKJ
 SYWycaELPnIrXcHzfbMQYtua12vKf0EMxt01flzJcyhDozHlpPNxaYl6DUNIxJqoAKyWcec2AOD
 08oc0l8I/Tb9YBKNY6kIs4t88TBQ3wk33h5soHkTOoJ8NVphDPp9ZNbtZiCdFBmtRc04WxzExNg
 3Omk01C3+dNG3RXtSAP4/73fqYBnkkSGOBTcrCY0=
X-Proofpoint-ORIG-GUID: -PO83JcdEWqs_n9A_K-GDBYQc_q3wl_t

From: Koichiro Den <den@valinux.co.jp>

[ Upstream commit 7f083faf59d14c04e01ec05a7507f036c965acf8 ]

When shrinking the number of real tx queues,
netif_set_real_num_tx_queues() calls qdisc_reset_all_tx_gt() to flush
qdiscs for queues which will no longer be used.

qdisc_reset_all_tx_gt() currently serializes qdisc_reset() with
qdisc_lock(). However, for lockless qdiscs, the dequeue path is
serialized by qdisc_run_begin/end() using qdisc->seqlock instead, so
qdisc_reset() can run concurrently with __qdisc_run() and free skbs
while they are still being dequeued, leading to UAF.

Serialize qdisc_reset_all_tx_gt() against the lockless dequeue path by
taking qdisc->seqlock for TCQ_F_NOLOCK qdiscs, matching the
serialization model already used by dev_reset_queue().

Additionally clear QDISC_STATE_NON_EMPTY after reset so the qdisc state
reflects an empty queue, avoiding needless re-scheduling.

Fixes: 6b3ba9146fe6 ("net: sched: allow qdiscs to handle locking")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Link: https://patch.msgid.link/20260228145307.3955532-1-den@valinux.co.jp
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 7f083faf59d14c04e01ec05a7507f036c965acf8)

Conflicts:
 - include/net/sch_generic.h: retain the older qdisc state model. It has
   no __QDISC_STATE_DRAINING or QDISC_STATE_NON_EMPTY, so serialize reset
   with seqlock and clear __QDISC_STATE_MISSED, matching dev_reset_queue().

Assisted-by: Codex:gpt-6
Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 include/net/sch_generic.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index fa5c253770e1..0c55a129fac9 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -745,13 +745,22 @@ static inline bool skb_skip_tc_classify(struct sk_buff *skb)
 static inline void qdisc_reset_all_tx_gt(struct net_device *dev, unsigned int i)
 {
 	struct Qdisc *qdisc;
+	bool nolock;
 
 	for (; i < dev->num_tx_queues; i++) {
 		qdisc = rtnl_dereference(netdev_get_tx_queue(dev, i)->qdisc);
 		if (qdisc) {
+			nolock = qdisc->flags & TCQ_F_NOLOCK;
+
+			if (nolock)
+				spin_lock_bh(&qdisc->seqlock);
 			spin_lock_bh(qdisc_lock(qdisc));
 			qdisc_reset(qdisc);
 			spin_unlock_bh(qdisc_lock(qdisc));
+			if (nolock) {
+				clear_bit(__QDISC_STATE_MISSED, &qdisc->state);
+				spin_unlock_bh(&qdisc->seqlock);
+			}
 		}
 	}
 }
-- 
2.55.0

