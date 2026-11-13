Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579060;
	b=fQoBKNhD/ITIfLbkzyA6dOhyD6ZOi364A9auc5Hnu77Ig0o42jatxtrLydcocUMwTo5U
	 bDOzLyY/OaXNJbpiG0Pezpgbx6QjVeMxWJ6npibK4kWZM7iD4Xp46m5xcsD19YDWK0/ou
	 BbHhJ1bCV1qIAGIqUhlE1ZuT07I0UCLLnIgGKu5nlSSDw7S1AAYUsc2m8N84Dw3FvjsV/
	 jKazWdswjc4fWUYcYXhO/z860u8p6wn8T2KNMdODOpdoNagl6rtCQrq7lrPVazqTalayg
	 0VLVCW4v40Uq0RawPIkd9sPVgkJBXIyGiVFDtcDjpdy3poHlHDjQG0ZdMm6+n34fpzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579060;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mC4fMBWKV0Oje3y3GDCm0lAvhhLJQq6XB7p3R3kavjY=;
	b=m0xJ8RBt4W4Yx8qltkd6VtbzD5p2di1dz2Vayoc1Id8DzsMOxSfs4B2aTIba78rkHWYi
	 UFlY7FZEtdSffVx72nEa3NRS8soLxJl7yhwJ1ZYAPtpR0dQMgcCRjckknTnl6UsnfxCyQ
	 H3Q3JcuumkJFzC0P/NOrLBZj1sHFOXLuo/AUVyoG87Hq7fct+3QWIg82z33AaqvLKMFMg
	 u0pQ7B5O+gwMX/vaVk4M6Xzp4ZKkOUdlqNxvQafukS7xseqrNA+UnUaIbkW5PC14CIiKR
	 Q0iKN9z1+JtWfr9x8yJgdJA9Rj6Y8NSJGR1BJ8kQEcQ+2Pw2qJLvvL2mSfWYRCyj6Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JSIXcmzg;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D7C606A89F
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06D7C606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JSIXcmzg
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCEBDa1248478
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mC4fMBWKV0Oje3y3G
	DCm0lAvhhLJQq6XB7p3R3kavjY=; b=JSIXcmzgJKBY6p1IGgDrIWD3TbKvubRdY
	Nk9CewLpJtSGxsenOA7dB2xLL1BRp8Fu2aoxuERJNP506esbNnwJ9vajMqm87Fx4
	kFj4bzC7dUsgA0WaKtsBXfxT01FGlrrop3IPmZE2uC0Y1zxE9KdNpvZTVM2QdAje
	eirxEp/jKAIiLQzNG9IStYREPzMUMFaPKCeci+tpYe097YgfUQqE2gwd6XW6fxxG
	GMeIBHFnNA6oO3Ys5Api9jDRX/3LeOeFnxkeqFN5UjnhFnYr7CA8evm/DntiQcIf
	FZW5vIxfmEl1uWY9elO+lgpXroAlXWfREAAWwFRuPTXpdpeM5DFCA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntm1uj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5FZN2213387
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:58 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwegfc3t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADEAuXZ31719986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:10:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6D515805D;
	Fri, 13 Nov 2026 14:10:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82B2258057;
	Fri, 13 Nov 2026 14:10:56 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.92.80])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:10:56 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH 16/20] s390/vfio-ap: do not pass through a queue not confirmed zeroized
Date: Fri, 13 Nov 2026 09:10:38 -0500
Message-ID: <20261113141049.3747719-17-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113141049.3747719-1-akrowiak@linux.ibm.com>
References: <20261113141049.3747719-1-akrowiak@linux.ibm.com>
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
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX21gjphHKbFmo
 OYnUB55TyPPebURmYWIK2JRqtj1RHghBZuuDsACuacuatZHc1syZ7zCorbkBeiR4RtGXrlcRTOI
 R2BAyM2yVfadYRRkP2wo27RrENY8cRa2D4ElUHiMNjyImvKAryWByDXm5aw5ZWIUwh9jdDMu9xm
 nQPjIhyPQJ70QVsH3u4j9CzLgjVXEFIgV8PgqjNci3gk3bS6imWz30VD1dxa/ngb53sCaEPYxnM
 17N2Nk5hLnzzpnZv2X5oX2Xz4TwdJU9xO6fkJRZqY4DalAy397GBVneGbBy0rXVo4ANrpAVwvKt
 hooZlogMDcxz0ULO+kvONOeeKDDjTaKNIJUX5Mdwvq1NvvHrbQBKkbWPe89EfxOPAixtCwZpQww
 T0GboFjgDtHSsGGO4PtTUUAYlsj3I564Qa+R3ZTfZ+ioObzKYMFc44zd27e+k7iB1MXY6GLnq0n
 MqLZGL4GJCahXK5QLJw==
X-Proofpoint-ORIG-GUID: h4xLpp3qOzVLaloZKUae0fR4B9I-MrhW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfXzPom75KMhb4H
 +RyyBPtTCxZT7cnkqGVZVMQjolhFXtyktYhy1wlAOEaVxO+IJrd2UNbrLq4LqEUTdKESgwbS3j6
 bfH3AsnFyXV5aZsgf/meimV8ko3lPtM=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af71a73 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=n519WHjwvXCBqBGV3oQA:9
X-Proofpoint-GUID: h4xLpp3qOzVLaloZKUae0fR4B9I-MrhW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130054

_queue_passable() accepted AP_RESPONSE_DECONFIGURED and
AP_RESPONSE_CHECKSTOPPED as passable states in addition to
AP_RESPONSE_NORMAL. Neither DECONFIGURED nor CHECKSTOPPED
confirms that the queue was zeroized; only AP_RESPONSE_NORMAL
(0) does. A queue not confirmed zeroized must not be passed
through to a guest, as it may contain key material from a
previous guest or host operation.

_queue_passable() is therefore changed to a two-step check.
First, reset_status.response_code is verified to be
AP_RESPONSE_NORMAL; if not, the queue is not passable
regardless of its current hardware state. Second, a live
PQAP(TAPQ) is issued to detect state changes that occurred
after the last reset - such as a subsequent deconfigure or
checkstop - without requiring a callback from the AP bus.
If TAPQ returns AP_RESPONSE_BUSY or AP_RESPONSE_RESET_IN_PROGRESS,
the queue state cannot yet be determined, so the TAPQ is retried
after a 10 ms sleep for up to 5 attempts. This avoids filtering a
queue that is only transiently busy. If the queue is still busy
after the last attempt, it is treated as not passable; since
reset_status was NORMAL this is expected to be transient and the
queue will be re-evaluated on the next filter_matrix call.

Fixes: a681226c675c ("s390/vfio-ap: handle hardware checkstop state on queue reset operation")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 60 +++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 4c252e19304e..86eb48df27f1 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -32,6 +32,8 @@
 
 #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
 #define AP_RESET_MAX_WAIT		2000	/* Maximum wait for reset (2000ms)	*/
+#define AP_TAPQ_RETRIES			5	/* Max TAPQ attempts when busy		*/
+#define AP_TAPQ_RETRY_INTERVAL		10	/* TAPQ retry sleep interval (10ms)	*/
 
 static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
 static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
@@ -891,19 +893,57 @@ static bool vfio_ap_mdev_filter_cdoms(struct ap_matrix_mdev *matrix_mdev)
 			     AP_DOMAINS);
 }
 
+/**
+ * _queue_passable:
+ *
+ * In order to prevent leaking of sensitive data to a guest, a queue must have
+ * been reset before passing it through. If the status stored for the most
+ * recent reset operation is anything other than AP_RESPONSE_NORMAL, then the
+ * queue can not be passed through. On the other hand, the status of the queue
+ * could have changed since the last reset; for example, the queue could have been
+ * deconfigured via the HMC/SE or the sysfs config interface for a crypto card,
+ * or something could have occurred - e.g., a hardware failure - that moved the
+ * queue status to check stop state. To verify the queue is still passable,
+ * the PQAP-TAPQ instruction will be executed to determine the current state
+ * of the queue. If TAPQ returns AP_RESPONSE_BUSY or
+ * AP_RESPONSE_RESET_IN_PROGRESS, the current state of the queue can not be
+ * determined, so the instruction is re-executed after sleeping for
+ * AP_TAPQ_RETRY_INTERVAL milliseconds, up to AP_TAPQ_RETRIES times. If the
+ * queue is still busy after the last attempt, it is treated as not passable.
+ *
+ * @q:	the object containing the data associated with a queue bound to the
+ *	vfio_ap device driver
+ *
+ * Returns:	true if the queue can be safely passed through to a guest;
+ *		otherwise,returns false
+ */
 static bool _queue_passable(struct vfio_ap_queue *q)
 {
+	struct ap_queue_status status;
+	int retries = AP_TAPQ_RETRIES;
+
 	if (!q)
 		return false;
 
-	switch (q->reset_status.response_code) {
-	case AP_RESPONSE_NORMAL:
-	case AP_RESPONSE_DECONFIGURED:
-	case AP_RESPONSE_CHECKSTOPPED:
-		return true;
-	default:
+	if (q->reset_status.response_code != AP_RESPONSE_NORMAL)
 		return false;
-	}
+
+	do {
+		status = ap_tapq(q->apqn, NULL);
+
+		switch (status.response_code) {
+		case AP_RESPONSE_NORMAL:
+			return true;
+		case AP_RESPONSE_BUSY:
+		case AP_RESPONSE_RESET_IN_PROGRESS:
+			msleep(AP_TAPQ_RETRY_INTERVAL);
+			break;
+		default:
+			return false;
+		}
+	} while (--retries);
+
+	return false;
 }
 
 /*
@@ -2400,9 +2440,9 @@ static void apq_reset_check(struct work_struct *reset_work)
 				 * the host kernel.
 				 *
 				 * Record the TAPQ status so the queue is marked
-				 * not-passable - _queue_passable() checks
-				 * reset_status.response_code == AP_RESPONSE_NORMAL -
-				 * and the queue is not passed through to a guest.
+				 * not-passable: _queue_passable() first checks
+				 * reset_status.response_code == AP_RESPONSE_NORMAL,
+				 * and the queue will not be passed through to a guest.
 				 */
 				memcpy(&q->reset_status, &status, sizeof(status));
 				return;
-- 
2.53.0

