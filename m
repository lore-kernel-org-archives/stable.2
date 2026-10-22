Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674597;
	b=mFCW7ny38txtSl+5o8dhbxrsrj0SvTc3Y4DRaHBnV8bykrIPktoZ9yFMwSJD41Mwjwfb
	 sPps5cSFklobGV+73A7EC1tNSoZ5NQLgFd6/ONiDNj6qfQkeNWx40P/hLWLnfzHtvZ/3C
	 ES9zYLxDyaKKsO4kadzQ3rv5J3mSgQ/2A8x3nJGFAOkkq7leKyeS4ddnlE/xl32Ix1+a3
	 ue+Pn1hDq0tBWULKbg8eRhl/L9xj/vb291DNCJtxSj0Xeh2reZ/QSLe9g3xd7c19dgmtw
	 gshb5T/MTNwMgM3acwhKm7ZjMtJE/tV748NvjERdIaOjql4B61CfS/eiRih8ng8ebFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674597;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hkrJR5qNcPLX5yOJcXE790VXhUxSZW/Gr6kYn/2PuGI=;
	b=KMXaYf1xqivtU9ld+RIXEnYMOPmlAz1tTfwoFX+zUhhDhSMy6yTt9oq4FQVh7GhxW0rv
	 TB17PXls7b2qc29Y+B5Tevx61+ilY7WZbiEV4X9abbvPrZea3aIzNwJ01WpeFX5r8H0md
	 X2vTT5uqzlnYQ1cM333xX8xS6+j3P9Lbd8Zc8UniEtD/CiLFHM8mlrkpFDSv3CpGqZfcz
	 pkJUYTSeCOUdsglJguueg2GpZt0qc5qwBlKDGydItTaiv2gUb3K3cDB/Qn4+ml2c10H43
	 jRlUQhMYLF1XznkVnqnCLLAr5ZZs0rcMozn/4FLaXjJf370fdWBmawnUmCCZcrP8a6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UkuMERLJ;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA66606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EA66606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UkuMERLJ
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MAEAnp3739273;
	Thu, 22 Oct 2026 13:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hkrJR5qNcPLX5yOJc
	XE790VXhUxSZW/Gr6kYn/2PuGI=; b=UkuMERLJBf0EhX3UJ5yGIEKmCY6162OT2
	n+YOjtYFq8fcqRXFk0tSuyB4JGpn5Xijh8HIJcIVu9dj1OzjoiSGM+5JsZaMpyan
	J1CHsHnMLkDJUwbqb9DizOp33r71qQGZj9dAxSjMKFF4zeLKAWXZscX+TUi8oNvQ
	1RcRqLZ0KeTjtLIjVNpEzXM6bcHhBYfcbdScHY2+w/pd+j5O2ZFPShf5+BUzfqSB
	9BnXpAA+xA562Jjb1ZqH+IdZkM6jgqb6WIy4E1usAeICP/ZgBaNW5/cTPusGTw2J
	QXNEzz9FSsgOWqdYIBlD75gVsummRg2IzlqTjMs6tEoMxBjJQSq/Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5axtxx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 13:09:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA4sXQ380935;
	Thu, 22 Oct 2026 13:09:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfgck0kj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 13:09:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MD9ebA48890158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 13:09:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B298120040;
	Thu, 22 Oct 2026 13:09:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B1A12004B;
	Thu, 22 Oct 2026 13:09:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 22 Oct 2026 13:09:40 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 85DBD1612ED; Thu, 22 Oct 2026 15:09:40 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y] net/iucv: fix the recvmsg window update
Date: Thu, 22 Oct 2026 15:09:35 +0200
Message-ID: <20261022130935.1228149-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102105-deuce-amnesty-4222@gregkh>
References: <2026102105-deuce-amnesty-4222@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6ada0b19 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=oIMCRTnLk8HH-e69WRcA:9 a=O8hF6Hzn-FEA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: MiXZ2mbPPJvSfIcCKv-NPM2mX4UkBHqC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1MCBTYWx0ZWRfX9k6GDJwA1e9r
 tOVTJaV8qecQfE3EFt649HaCqku67P8oFeOufkuTaUh546JOe9eHlUupr1ZKslBl+W49+3GwZ42
 isqGqpE2QcZwP0Sx9VT7wof0ucdrN9y5ydQkAlHu67Q+R2KAxQ7D2OyJ5ekUVEo20Ql+DKrpMt6
 aG4IROetj7yPcmNgRn2f9xp5q6xsaDK46xYIj/m950HuLjWfwrJw3oi0RIPzeKyCwG9vEoGFBRn
 403CLBunsAm9hamxAngvNu8orEYF7Qfoaeph07YcODMRVGhaV5gckW82gzAv//7OxGX/5rUNIKG
 VMTp/nw0JVq+dsQCgi/VaoNZRWQtjpuhhHvm8P9y0xMcWp0MFBapMM+wFkzVSoyQWh1MCFvn5+x
 nH6LVweBfPvxPQqGp1mSLFDTxTxWmRHgBa2A3SIL1XufwaMYV/HPR445mXSkeak0PQep7O7d4P4
 MCkrFXBoSq4ABnUUtIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1MCBTYWx0ZWRfX/CPAsWQiJ6uN
 x96fFDij2kWzo62QB2y9VuRiT0oC95VDBPD38Gpj4r345L1gNH2DK8GAMRQ5Heda+n2tUa6aJXM
 YNKPuTpRnFT1zwgQPk59JchUYtmOWEs=
X-Proofpoint-GUID: MiXZ2mbPPJvSfIcCKv-NPM2mX4UkBHqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220050

From: Bryam Vargas <hexlabsecurity@proton.me>

iucv_sock_recvmsg() sends the HiperSockets-only AF_IUCV_FLAG_WIN without
testing the transport, so on a classic z/VM socket iucv_send_ctrl() sizes
the skb through a NULL iucv->hs_dev. SO_MSGLIMIT accepts 1, so msglimit /=
 2
is zero and one recvmsg() on its own socket is enough for an unprivileged
process to take a spurious disconnect.

It also calls iucv_send_ctrl() under spin_lock_bh(&message_q.lock), which
allocates GFP_KERNEL inside a section the code treats as atomic. Sending
outside that lock lets two recvmsg() reach afiucv_hs_send() at once, wher=
e
msg_recv is sampled for the advertised window and subtracted after
dev_queue_xmit() -- and sendmsg reaches that counter under lock_sock()
while recvmsg holds no socket lock, so both can subtract the same value,
the counter goes negative and the credit reaches the peer twice.

Test the transport, claim the credit with atomic_xchg() after the last
error exit and hand it back if the transmit fails, and send once the lock
is dropped.

Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Fixes: 238965b71b96 ("net/af_iucv: build proper skbs for HiperTransport")
Cc: stable@vger.kernel.org
Tested-by: Aswin Karuvally <aswin@linux.ibm.com>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Link: https://patch.msgid.link/20260828-b4-disp-33fac0ed-v3-1-e6d061880ee=
0@proton.me
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit fa5acd038ea657ad5033713d6916214cbd349151)
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 net/iucv/af_iucv.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index d37e8f4ad472..29a714a02d2c 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -223,12 +223,6 @@ static int afiucv_hs_send(struct iucv_message *imsg,=
 struct sock *sock,
 	phs_hdr->flags =3D flags;
 	if (flags =3D=3D AF_IUCV_FLAG_SYN)
 		phs_hdr->window =3D iucv->msglimit;
-	else if ((flags =3D=3D AF_IUCV_FLAG_WIN) || !flags) {
-		confirm_recv =3D atomic_read(&iucv->msg_recv);
-		phs_hdr->window =3D confirm_recv;
-		if (confirm_recv)
-			phs_hdr->flags =3D phs_hdr->flags | AF_IUCV_FLAG_WIN;
-	}
 	memcpy(phs_hdr->destUserID, iucv->dst_user_id, 8);
 	memcpy(phs_hdr->destAppName, iucv->dst_name, 8);
 	memcpy(phs_hdr->srcUserID, iucv->src_user_id, 8);
@@ -261,6 +255,16 @@ static int afiucv_hs_send(struct iucv_message *imsg,=
 struct sock *sock,
 	}
 	skb->protocol =3D cpu_to_be16(ETH_P_AF_IUCV);
=20
+	/* Claim the receive credit here, not while building the header: every
+	 * way this frame can be dropped has now been ruled out, so the window
+	 * is zeroed only for as long as the transmit itself takes.
+	 */
+	if (flags =3D=3D AF_IUCV_FLAG_WIN || !flags) {
+		confirm_recv =3D atomic_xchg(&iucv->msg_recv, 0);
+		phs_hdr->window =3D confirm_recv;
+		if (confirm_recv)
+			phs_hdr->flags =3D phs_hdr->flags | AF_IUCV_FLAG_WIN;
+	}
 	__skb_header_release(skb);
 	nskb =3D skb_clone(skb, GFP_ATOMIC);
 	if (!nskb) {
@@ -271,11 +275,9 @@ static int afiucv_hs_send(struct iucv_message *imsg,=
 struct sock *sock,
 	skb_queue_tail(&iucv->send_skb_q, nskb);
 	err =3D dev_queue_xmit(skb);
 	if (net_xmit_eval(err)) {
+		atomic_add(confirm_recv, &iucv->msg_recv);
 		skb_unlink(nskb, &iucv->send_skb_q);
 		kfree_skb(nskb);
-	} else {
-		atomic_sub(confirm_recv, &iucv->msg_recv);
-		WARN_ON(atomic_read(&iucv->msg_recv) < 0);
 	}
 	return net_xmit_eval(err);
=20
@@ -1258,6 +1260,7 @@ static int iucv_sock_recvmsg(struct socket *sock, s=
truct msghdr *msg,
 	struct iucv_sock *iucv =3D iucv_sk(sk);
 	unsigned int copied, rlen;
 	struct sk_buff *skb, *rskb, *cskb;
+	bool send_win =3D false;
 	int err =3D 0;
 	u32 offset;
=20
@@ -1350,16 +1353,20 @@ static int iucv_sock_recvmsg(struct socket *sock,=
 struct msghdr *msg,
 		if (skb_queue_empty(&iucv->backlog_skb_q)) {
 			if (!list_empty(&iucv->message_q.list))
 				iucv_process_message_q(sk);
-			if (atomic_read(&iucv->msg_recv) >=3D
-							iucv->msglimit / 2) {
-				err =3D iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
-				if (err) {
-					sk->sk_state =3D IUCV_DISCONN;
-					sk->sk_state_change(sk);
-				}
-			}
+			if (iucv->transport =3D=3D AF_IUCV_TRANS_HIPER &&
+			    atomic_read(&iucv->msg_recv) >=3D
+							iucv->msglimit / 2)
+				send_win =3D true;
 		}
 		spin_unlock_bh(&iucv->message_q.lock);
+
+		if (send_win) {
+			err =3D iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
+			if (err) {
+				sk->sk_state =3D IUCV_DISCONN;
+				sk->sk_state_change(sk);
+			}
+		}
 	}
=20
 done:
--=20
2.53.0

