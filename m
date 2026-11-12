Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488385;
	b=oCpaN0RUpofN0P2RaMd+VJfS8oH9/FYXd8oJlimzsFlYUOno9APSvp74EF1mK2H3v87B
	 WImf92wStfwVVXvF6EYk8fsdt6OZNt5RnACUVYOMqkfN7xmCVVhdQxfkNkasOIlefK7Ft
	 cFp6Yiw6TQQT0GCQShBPy/XriE5gnefnlNc03p48fHMZ0Q0AyixDQEa6BIDd7xgJUIiuZ
	 jmgEKMUOtd5NzmnbcJ7Gy/8dd8in+845jHKZJrJWTO8b8xEQBRlmtnfBpn7g49hZwDVu/
	 L6HltFqD6d2aj4EBoqjGhX1zLi9VHYRgYh8afjiWB7UegwWoTjyAo2DbPJ04M80PnVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488385;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=rbC0uj/R8RYCcgLSwNbabTGaNUN1wHB6/zypxowFP00=;
	b=mAsC2kkrl4z/nF5UH/RImvuPlSemBjBH6jlThJuAI/mULn+bqrbGhe9tV2rshAz4aEo5
	 AcXK8nD7Bk7mrmiqtl2LyGZISPY7Ini/gu1qBmkDEhT8lCx8X/OxDMmwGtTOu9RTGnV9F
	 xhL4YWCTyBnkFDryaJjgYBb3EJiRcd4gUdNfoYFH/LukkvKTDtNLYtnkq+7udqutDZQpf
	 U9eSeIv5lh09umcXOq3TaSPxDWUgXRtDjIYZ593YsCLp0qiRfbO9O2jVK48qfsU+ehDf4
	 nb4YaLJ7OBK/yBsCSOxeVSM7Y1cxIMBNka8NbOyPuNtO4YlqZC3Sp9jijI/2+rD5YZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=gO3ugjsX;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C104606A331;
	Thu, 12 Nov 2026 12:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C104606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=gO3ugjsX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794488296;
	bh=rbC0uj/R8RYCcgLSwNbabTGaNUN1wHB6/zypxowFP00=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=gO3ugjsXniZ/tEryKQaEOBVlWvjA7hrmmWv1m8E7ilw1Wdhm1Hfh2TH2ABtIHrW/+
	 woUBEIgDMAjq4+MiFg0SCAbQzPcNdV6ryXuixmAmoO7fkz8D/dA3Y8QOqTUuZ3UFMt
	 AY2FF9neskpJ1ghdSiZlX84VtD1TrjuLgrIr/+fc=
X-QQ-mid: esmtpgz12t1794488279t300c38f2
X-QQ-Originating-IP: s7p3bODy86hHuRD0EFL2gaO4sA38kEXvjptkNaYVRMM=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Nov 2026 20:57:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12316763866459756711
EX-QQ-RecipientCnt: 11
From: raoxu <raoxu@uniontech.com>
To: david@ixit.cz
Cc: luiz.von.dentz@intel.com,
	pmenzel@molgen.mpg.de,
	pengpeng@iscas.ac.cn,
	brgl@kernel.org,
	raoxu@uniontech.com,
	sameo@linux.intel.com,
	christophe.ricard@gmail.com,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] nfc: st-nci: Free received NDLC supervisor frames
Date: Thu, 12 Nov 2026 20:57:40 +0800
Message-ID: <09A2C9754909428F+20261112125740.1483464-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NPJBszHJHFtbfsl72xuoAyKKyZq2pqHHQ6gARaUWDBW5VSEn8oixxbq3
	OhG5NKAa9ujzsx15VM+SeH/yBgamAvz6YZFdglTXpELEGLx7ikGNTtcLiSQiNvF6gvKGMRJ
	J0tRWrqFXctCs62C45NSyRLWcf1GSIoQduruD1LpIKQOYWN1G+z+k/bs3RzEGaTuYfh/MAW
	gggMXO05C2qKw5VyeSxbYNEQ6TZtWniPYqJdhDehCuB5TbbKjOM9fhnI34U/itbatdc8IvN
	MMcueHqh5G7E3RqEjG7a6LpFrWEKvmC3vUMfACi1YJGxdTqHAbA62LFMUPoWwVgA1N7i1EE
	umNlEIS1eaLcD6aLFafzAXM3O7Apo2SHmOLdXX49ydjMdUUc44HhNFFjGWUoovoeBozFu2W
	4Al6SxAbD2peuUQhmnXPf4UMgtqEtRnU8lpU0MX7UjyBotxISeRZ8CwBJ6P0z7CRfkrmnpC
	D4qjWYf/pLaJq2btg1vOJ0wrtSvp5/sQdOLUkOeb/9uVLCyxBDVWr0rtxMTT+R7m78LTkit
	7ctxxNcQvaS1IQZjExiDYmQow3vpZlKOR/Cqt3V/ksKKfr+m6No0jnpqKvVXAQNrxr94xxr
	EmecE9Ez6Ltot+JodfxF4xUb9KP1pr1Gu0VDezgXhxqU0f+d5TeMfgLrM05nuuYk60xLPLQ
	Rjle75ainSIr5o/ora2PNvfzrOkesEtKSno8V2U1dnXQUKxzL0G+0TtnwXmsmpw4RdbChPG
	UXvX9rKxIYxPGBbqHNYsllRL9KBM6t4dKhW0FKGuOKVjW/Nl2OAHC5q8DA5IEfhrF6MqiAE
	gOWMU2/HGbbZpps/QGF00epLIKsJs5Av+hM2GOZ2KCV4je/xnuF47WItHrwhPl8RyeWZ07D
	aXxrz6j2Ujbid5Q+vZsKY7n7N2GvtCZ2WDzqRgEnD7+Xq0t9E2qJzpH2gFJzICJtKki2zHj
	anH73KHHTM/D1mngq3rlvy3Qdq0v5378J2CF7aM4+ASyHv02ulZ/YSBpcacS0x09s+fUV/A
	xYUPGfVg4yeJeSTbiN0krDE8fqwsCKwY063tYcm8nViWhfVLntbhh6UHoThUk=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

llt_ndlc_rcv_queue() dequeues each received skb and handles supervisor
frames locally. The ACK, NACK and WAIT cases neither release that RX skb
nor transfer ownership to another queue. ACK also overwrites the RX skb
pointer with the TX skb dequeued from ack_pending_q and frees only the
latter.

Consequently, normal acknowledged traffic leaks one received skb per ACK,
and NACK or WAIT responses leak their receive buffers as well. The leaked
buffers are no longer on rcv_q, so device removal cannot reclaim them.
Unknown supervisor codes already release their RX skb, and data frames
transfer ownership to the NCI core.

Use a separate pointer for the acknowledged TX skb and free the RX skb
after the supervisor switch. Move the existing default-case free to this
common path so every supervisor frame is released exactly once, without
changing acknowledgment, retransmission or timer handling.

Fixes: 35630df68d60 ("NFC: st21nfcb: Add driver for STMicroelectronics ST21NFCB NFC chip")
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Cc: stable@vger.kernel.org
---
 drivers/nfc/st-nci/ndlc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nfc/st-nci/ndlc.c b/drivers/nfc/st-nci/ndlc.c
index be4808859cfa..7164e7c3aabd 100644
--- a/drivers/nfc/st-nci/ndlc.c
+++ b/drivers/nfc/st-nci/ndlc.c
@@ -146,7 +146,7 @@ static void llt_ndlc_requeue_data_pending(struct llt_ndlc *ndlc)

 static void llt_ndlc_rcv_queue(struct llt_ndlc *ndlc)
 {
-	struct sk_buff *skb;
+	struct sk_buff *skb, *pending_skb;
 	u8 pcb;
 	unsigned long time_sent;

@@ -159,8 +159,8 @@ static void llt_ndlc_rcv_queue(struct llt_ndlc *ndlc)
 		if ((pcb & PCB_TYPE_MASK) == PCB_TYPE_SUPERVISOR) {
 			switch (pcb & PCB_SYNC_MASK) {
 			case PCB_SYNC_ACK:
-				skb = skb_dequeue(&ndlc->ack_pending_q);
-				kfree_skb(skb);
+				pending_skb = skb_dequeue(&ndlc->ack_pending_q);
+				kfree_skb(pending_skb);
 				timer_delete_sync(&ndlc->t1_timer);
 				timer_delete_sync(&ndlc->t2_timer);
 				ndlc->t2_active = false;
@@ -182,9 +182,9 @@ static void llt_ndlc_rcv_queue(struct llt_ndlc *ndlc)
 					  msecs_to_jiffies(NDLC_TIMER_T1_WAIT));
 				break;
 			default:
-				kfree_skb(skb);
 				break;
 			}
+			kfree_skb(skb);
 		} else if ((pcb & PCB_TYPE_MASK) == PCB_TYPE_DATAFRAME) {
 			nci_recv_frame(ndlc->ndev, skb);
 		} else {
--
2.50.1

