Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119041;
	b=5QsFWWpRjNDra8Pmyn0b/LFFIpddFZerRKkowkNaWDAavuWJuDVOO5KMEDmPI1BDhNKb
	 DorS+6IC1Ia+BBDS6cL1Y9iga3r4a+utkuBIu/Z+8cMX3NjKVCTcEJiM4Dz6fqyhdfxmu
	 rK+iWZGEv8UjabvDow1qlwQ/cgX7s6qRyWqbm3eRO+rGvK2KpfHSuhOB8qUTYW+ja22JA
	 /MjPkT26tCte3ByZMXEaSyYjAiONvH5WrpzfHIxI5MXFzPkx7kggoKp35HHj6CnaAjLbC
	 wAackZ0r9PH/NJUOPcksQmeLlmizRS8KtzTDPf8Ggs68M78xvOjt7RCa6vNQ6nLcr8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119041;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WUbRWxHa4nNr1uTBKayVBagYCdC/mmrTOL9xLLUPSFQ=;
	b=le7hmR2ngrkoI6f1GeLcwFoS0WOq+fid49RGgDFaXG8QcIM7fd7+0EwXapoSHhVOnkdl
	 Na69T+59F7KZ6zocqBO2eHGUi1xJ8k3TPcfTfZPySOzl3o378Hue4xLu/FFUG2dc/mnRe
	 Okz6YaGUtT+nzk7Sc4gIi6EAoBNZWdU4HL7dhniM9pnLsdz9drcw0ydu5FVaHhWo3bvlB
	 a+jUqFdfLBvqz8TPqCjnrBTQSeHTWrbyEHgz/JxWc102LQZJ6MQqvRDmG+hE8eEwpdMum
	 XLg+hd+8sV9G9ccEQiQEpPixJX3QNIOogIOU79dyjYAT49rq7pF+q/LvyGevEzmD/eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T7zYMpqb;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DA9606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73DA9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T7zYMpqb
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69REERxY1519297;
	Tue, 27 Oct 2026 16:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WUbRWxHa4nNr1uTBK
	ayVBagYCdC/mmrTOL9xLLUPSFQ=; b=T7zYMpqbkyZLAKa9/LCbnvEwigLIVPoc7
	EMLba5xjgUf1M8OjjzXWS3nfUb0gEdo0UT2OcvvkvRBF87EV2DcnDadqaUmzf7kO
	G7nIDU+PadtxLOA2HJcNo1EcLac9UUJciln/ZEfwPBtgxfZn/K+asGlCUB+s7IhK
	iQerv9LbnwZ3svU0zRNXp2dc93Lay8oncqSl5v9cilIiahDKILb7yHw6/z7/fpoy
	Xvc8zB5itaPMb108hGk5UF5bI1z6DWMZgsZ2voaYSIBF4tCTiEGGJXefnHnc7osI
	RwxyxVD1xp++ibRJdIeBp51NsR5lWHECiKnwHU0XDYron/g6+pQxg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3g0e9w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 16:37:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDoQrt3057798;
	Tue, 27 Oct 2026 16:37:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh97gugm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 16:37:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69RGb95b17695008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 16:37:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BCA320043;
	Tue, 27 Oct 2026 16:37:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0ED412004B;
	Tue, 27 Oct 2026 16:37:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 27 Oct 2026 16:37:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id EA7091612ED; Tue, 27 Oct 2026 17:37:08 +0100 (CET)
From: Alexandra Winter <wintera@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y v2] net/iucv: fix the recvmsg window update
Date: Tue, 27 Oct 2026 17:36:55 +0100
Message-ID: <20261027163655.1403341-1-wintera@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae0d339 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=oIMCRTnLk8HH-e69WRcA:9 a=O8hF6Hzn-FEA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 8x2idxDJj-qAbRZCD5dsn1D0-Q3MviJC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2NCBTYWx0ZWRfX0n4dV9facCYl
 0oE47wX9XHvyuEcPCYSdKxkw9R5rJfUZs4u5SZ/pp3CeBDnOwAPKu/WGaMQMj5MpwXBtdacZ6ST
 quwHJNZMtY5AY904fr8tHkJMJDTNHZdggWn2e21fg64W48h5yXkuqyNbkShH8SNfbwFko4uq3y+
 RdswLtStSplzgEHs7W3oncZyHiYSJJdO+nLaB2eO+vkFVZdbEprNP1c1N/WrVyjRIYcHWkGL3b6
 CuhP33hUuz2070u72wTgPoROK0H7Hy8iZ6IOkTYf4jDA7tyPKYd9xAPb0NSpPzfT1IttF6rEHIg
 1d0ZkcKtXCsaqXPbuZUe5reBEtbbwXeSUGdE3++7q3u8SNS86VNzCyJb5AjcJDnAJ0ZigCf/P0s
 iZDiD2NjhN/TELRQ38g0D581ppv3b4Rd+DOPdvMEfihYwVuOMwdCe+d8u6BkcCLiPWQ8nCZIJnd
 UKhF75HpGpuu/dhTz8Q==
X-Proofpoint-GUID: 8x2idxDJj-qAbRZCD5dsn1D0-Q3MviJC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2NCBTYWx0ZWRfX3k++h3hX0rp0
 V2GMHdowGz3AbgeDXA9un0eVsUUBIJSHc+gx5kJhfc4dUnkr1ieU//BMSi5DzcTBuZ+kpMLaIll
 M8G9a7TeGhcX9qtCqcgmacChAF7MkzY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270064

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
index d37e8f4ad472..034c4c79b898 100644
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
@@ -261,21 +255,29 @@ static int afiucv_hs_send(struct iucv_message *imsg=
, struct sock *sock,
 	}
 	skb->protocol =3D cpu_to_be16(ETH_P_AF_IUCV);
=20
+	/* Claim the receive credit here, not while building the header:
+	 * to minimize the time the window is zeroed.
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
 		err =3D -ENOMEM;
+		atomic_add(confirm_recv, &iucv->msg_recv);
 		goto err_free;
 	}
=20
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

