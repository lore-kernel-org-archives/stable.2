Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795673152;
	b=NJMxRWdxW+ovUXzs3BR0xJiisEZ7m+MaRhDxA1Gm2pLY7WPgMV9mjHU5R7NWzCJ11UGs
	 mAjsva9NdG3QJZR9XJRXKBfbqT3rarMOttFbl5lNhz+zGESGgNEeVcsZ9zcEnONRSVt5f
	 ENPFeGPiDwQEakCLjRh10eMz6Ap5as8sp9Wv8J3yoFD+C3XMl3M+xlRP5CHBrbHfHlSej
	 AK4wHlpubVtc0ekTi72ENS5IB3PkYVpdq8Wpe3QMoxckJElFel3gEXSW/ZjMCQHT3L0IU
	 /6mZDLEuDQogHUhEU7XLfvhUvv9/vUZ8Z+9Wc15KKd0APA8FLGFxoqW0TzeWknxklHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673152;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UdCntxprCybTaCMVMWOZM/tiE4sZACx2t1LvS3AjEP0=;
	b=nAGEsny66/P6MiqWWK8OurvwGLgHHJauqZkjapK0rTrlAPU3qSQ/P/AMTS5KKPV6K/x9
	 fdw9coydOEKXWk+1f3hYWvkiwRAxWMa6ZndzTS6oGd0m3ztM9HwsFx6ak7LOVSsdLyUIm
	 tvvyJoit3A3PgZYRtMgshSs7+iE1Gl06B+b6/5xhYViaxb8RVh6h5MCTNnpC2KNjouG8j
	 RGWU6pOBPUFNrj5eqX4ldBMgUStjzCMdSAwtyG0TrhFxlLvc0EKrQvtfanigXCyA730Rb
	 5woAKfiDIluVWDGlpnVB7/AeTHZWSrkLyd1P8j9sanvzuIxOMQParaUVmbd8XrSwubg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W6PA8etY;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FB5606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59FB5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W6PA8etY
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ35WVI3136005;
	Thu, 26 Nov 2026 06:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UdCntxprCybTaCMVM
	WOZM/tiE4sZACx2t1LvS3AjEP0=; b=W6PA8etYIK3J63XZ9uqnPHOAHKez9R8qH
	iEwxCUXUbv6nHs7Ef1uaKueLKa9Su3UoM8FrSg/AY0qsmRYYBzGuv6MUI2D20/Ss
	pR1vmNgu4fxPCHgAUfBjQMIdPV8seE6A60WC+TVyZpxFbHrF2fb4pc3ypXFN5iF2
	mYncgqYSVyuq/vDbMDP2SQLZxmNtJl7Xg1fZhIC6p4Mg4SHmlyfkbK9xcRzceHBn
	kyxlChLKL/v7z7nJZbqm66tr8eDYcuDtd7K6fdt4zYfz/MOYuoZ5BwZtYDq7rpd7
	C+B4eFC11IDloX+sWTxIffHBqZV5WqMfxF0OnuDZ5T24cqbUQSSAQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g1fceb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 06:05:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ34LpC1743264;
	Thu, 26 Nov 2026 06:05:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5dcuxah7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 06:05:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQ65dq151970524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 06:05:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65C522004B;
	Thu, 26 Nov 2026 06:05:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4573620043;
	Thu, 26 Nov 2026 06:05:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 26 Nov 2026 06:05:39 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56341)
	id 2DF6A16176A; Thu, 26 Nov 2026 07:05:39 +0100 (CET)
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
To: stable@vger.kernel.org
Cc: kuba@kernel.org, Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: [PATCH 5.15.y] net/smc: fix link group ownership in handshake abort
Date: Thu, 26 Nov 2026 07:05:36 +0100
Message-ID: <20261126060536.642851-1-mjambigi@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112437-serpent-backtrack-b978@gregkh>
References: <2026112437-serpent-backtrack-b978@gregkh>
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
X-Proofpoint-ORIG-GUID: LJzLKpLVOXT7gDybeSVu_YGJ20Nvb6zK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyMyBTYWx0ZWRfX318fHEam1Ale
 QhIZvOeZLctwY/QhEOfn/qz5GR6HNMUrRCrAANGjJr7dKHO+CuhMr9RWQnnbU12jd9vx/KQJXbw
 a3hTNyi+TUPzUxPf9UNpoX64zfwiGFA=
X-Proofpoint-GUID: LJzLKpLVOXT7gDybeSVu_YGJ20Nvb6zK
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b07cc38 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Zu8GI1LdFLB4ec2fxy8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyMyBTYWx0ZWRfXxPWQRAl1UOZ6
 ZyQnO97hI2Ez+jKgkhIsE8bZtlFOeIGg2NhFsPIZC78sKW2cYziXkWGMWMhHrjqSWTAoi1nUMi0
 6gykoKdb8k05M/WP71ZWralC3yYx8ys7KvX5uOO5JrYPRakOePL/pCAh2javauTgEB5wU5JSAkT
 p26/aIbu2NsaIGiApFYGhFNh/Kepq1SUADnM77YwrE3PqjnIDtDvfsRUqrDnEu12VmBXVObSdt1
 b/J2Ni5ovT/k/TjydDRpp447/8/2Hfcatz/LqLNZWcGw/gmo85pphpXRWrvZLy8ZR1GY/esZ8Og
 +e9Ba3/ffl+TAWPUkW85iD5umonJfrWVU0B0VpeWk0kqf+bnGCAm4/PZX1KI7ReCgonVxILvY2l
 mWByaqLV1ndJyZ0vRU9+XBxW7f4gY8uljL/yR4lIFgfbDReJ1S2BcBsLI/vASLirWgpSF0mX4S6
 kheCFewJMXL2tLE51xA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260023

[ Upstream commit e227b511582828c5a6513f70fc6a71211e5efbf0 ]

An aborted first-contact handshake can hang the handshake worker on the
socket lock it already holds, reset the clcsock of a socket that has
fallen back to TCP, or corrupt the alert-node lookup when the handshake
retries with the same connection.

The abort leaves a connection registered in a link group that another
context has already unlinked for termination: smc_conn_free() skips the
unregister when lgr->list is empty, so the alert token and alert node
stay in lgr->conns_all. If the handshake retries another device or SMC
version, smc_conn_create() creates a second link group and
smc_lgr_register_conn() inserts the same alert node into it: the token
loop is skipped, rb_link_node() links a node that is still in the old
tree into the new one, and a second sock_hold() is taken where only one
sock_put() will follow. The old group's terminator then keeps returning
that node from rb_first() and can kill a connection that now belongs to
the new group.

smc_lgr_cleanup_early() also starts a second termination of the link
group that is already being terminated, which takes lock_sock() on the
socket the handshake worker holds; if the termination work wins the race
instead, it later kills the freed connection and aborts the clcsock of a
socket that has fallen back to TCP. Making the unregister unconditional
also lets smc_conn_free() reach the delayed free work on a claimed link
group, where the lockless freeing check can arm it after the owner has
cancelled it.

Always unregister the connection and claim a link group for termination
once under lgr_lock, so that a second termination cannot start; arm the
delayed free work only under the same lock and cancel it synchronously
before the teardown.

Fixes: 2a0674fffb6b ("net/smc: improve abnormal termination of link group=
s")
Fixes: f9aab6f2ce57 ("net/smc: immediate freeing in smc_lgr_cleanup_early=
()")
Cc: stable@vger.kernel.org
Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>

[ 5.15 adaptation: there is no link group refcount here, so the lgr
  hold/put around the abort is omitted. smc_conn_lgr_valid() (v5.17) is
  open-coded as conn->lgr && conn->alert_token_local. The conn->freed
  check (v5.17) is not needed because smc_lgr_unregister_conn() clears
  conn->lgr and the terminate loop tests conn->lgr =3D=3D lgr. The delaye=
d
  work uses system_wq, which is what 5.15 has. ]
---
 net/smc/af_smc.c   |  3 +-
 net/smc/smc_core.c | 69 +++++++++++++++++++++++++++++++---------------
 net/smc/smc_core.h |  6 ++--
 3 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 1d642e0df..8cab7cabb 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -833,9 +833,10 @@ static void smc_conn_abort(struct smc_sock *smc, int=
 local_first)
 {
 	struct smc_connection *conn =3D &smc->conn;
 	struct smc_link_group *lgr =3D conn->lgr;
+	bool lgr_valid =3D local_first && conn->lgr && conn->alert_token_local;
=20
 	smc_conn_free(conn);
-	if (local_first)
+	if (lgr_valid)
 		smc_lgr_cleanup_early(lgr);
 }
=20
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 6da7d2145..bd170ffcf 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -79,16 +79,21 @@ static void smc_ibdev_cnt_dec(struct smc_link *lnk)
=20
 static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
 {
+	spinlock_t *lgr_lock;
+
 	/* client link group creation always follows the server link group
 	 * creation. For client use a somewhat higher removal delay time,
 	 * otherwise there is a risk of out-of-sync link groups.
 	 */
+	smc_lgr_list_head(lgr, &lgr_lock);
+	spin_lock_bh(lgr_lock);
 	if (!lgr->freeing) {
 		mod_delayed_work(system_wq, &lgr->free_work,
 				 (!lgr->is_smcd && lgr->role =3D=3D SMC_CLNT) ?
 						SMC_LGR_FREE_DELAY_CLNT :
 						SMC_LGR_FREE_DELAY_SERV);
 	}
+	spin_unlock_bh(lgr_lock);
 }
=20
 /* Register connection's alert token in our lookup structure.
@@ -581,19 +586,34 @@ int smcd_nl_get_lgr(struct sk_buff *skb, struct net=
link_callback *cb)
 	return skb->len;
 }
=20
-void smc_lgr_cleanup_early(struct smc_link_group *lgr)
+/* Claim a link group for termination. Only one context can succeed: the
+ * lgr is removed from its list and marked freeing under lgr_lock.
+ * Returns false if @lgr is NULL or another context owns it.
+ */
+static bool smc_lgr_claim(struct smc_link_group *lgr)
 {
 	spinlock_t *lgr_lock;
=20
 	if (!lgr)
-		return;
-
+		return false;
 	smc_lgr_list_head(lgr, &lgr_lock);
 	spin_lock_bh(lgr_lock);
+	if (lgr->freeing || lgr->terminating || list_empty(&lgr->list)) {
+		spin_unlock_bh(lgr_lock);
+		return false;
+	}
 	/* do not use this link group for new connections */
-	if (!list_empty(&lgr->list))
-		list_del_init(&lgr->list);
+	list_del_init(&lgr->list);
+	lgr->freeing =3D 1;
 	spin_unlock_bh(lgr_lock);
+	return true;
+}
+
+/* The caller must keep @lgr alive for the duration of the call. */
+void smc_lgr_cleanup_early(struct smc_link_group *lgr)
+{
+	if (!smc_lgr_claim(lgr))
+		return;	/* another context owns the termination */
 	__smc_lgr_terminate(lgr, true);
 }
=20
@@ -1060,10 +1080,12 @@ void smc_conn_free(struct smc_connection *conn)
 		if (current_work() !=3D &conn->abort_work)
 			cancel_work_sync(&conn->abort_work);
 	}
-	if (!list_empty(&lgr->list)) {
+	/* The handshake can retry another device or SMC version with this
+	 * connection, so it must never stay registered in an lgr it left.
+	 */
+	if (!list_empty(&lgr->list))
 		smc_buf_unuse(conn, lgr); /* allow buffer reuse */
-		smc_lgr_unregister_conn(conn);
-	}
+	smc_lgr_unregister_conn(conn);
=20
 	if (!lgr->conns_num)
 		smc_lgr_schedule_free_work(lgr);
@@ -1293,12 +1315,20 @@ static void __smc_lgr_terminate(struct smc_link_g=
roup *lgr, bool soft)
 	struct smc_connection *conn;
 	struct smc_sock *smc;
 	struct rb_node *node;
+	spinlock_t *lgr_lock;
=20
-	if (lgr->terminating)
+	smc_lgr_list_head(lgr, &lgr_lock);
+	spin_lock_bh(lgr_lock);
+	if (lgr->terminating) {
+		spin_unlock_bh(lgr_lock);
 		return;	/* lgr already terminating */
-	/* cancel free_work sync, will terminate when lgr->freeing is set */
-	cancel_delayed_work(&lgr->free_work);
+	}
 	lgr->terminating =3D 1;
+	spin_unlock_bh(lgr_lock);
+	/* The lgr is claimed, so no new free_work can be armed; wait for
+	 * one that is already queued or running.
+	 */
+	cancel_delayed_work_sync(&lgr->free_work);
=20
 	/* kill remaining link group connections */
 	read_lock_bh(&lgr->conns_lock);
@@ -1309,7 +1339,11 @@ static void __smc_lgr_terminate(struct smc_link_gr=
oup *lgr, bool soft)
 		sock_hold(&smc->sk); /* sock_put below */
 		read_unlock_bh(&lgr->conns_lock);
 		lock_sock(&smc->sk);
-		smc_conn_kill(conn, soft);
+		/* The connection may have been re-registered in another
+		 * link group by a retried handshake in the meantime.
+		 */
+		if (conn->lgr =3D=3D lgr)
+			smc_conn_kill(conn, soft);
 		release_sock(&smc->sk);
 		sock_put(&smc->sk); /* sock_hold above */
 		read_lock_bh(&lgr->conns_lock);
@@ -1323,17 +1357,8 @@ static void __smc_lgr_terminate(struct smc_link_gr=
oup *lgr, bool soft)
 /* unlink link group and schedule termination */
 void smc_lgr_terminate_sched(struct smc_link_group *lgr)
 {
-	spinlock_t *lgr_lock;
-
-	smc_lgr_list_head(lgr, &lgr_lock);
-	spin_lock_bh(lgr_lock);
-	if (list_empty(&lgr->list) || lgr->terminating || lgr->freeing) {
-		spin_unlock_bh(lgr_lock);
+	if (!smc_lgr_claim(lgr))
 		return;	/* lgr already terminating */
-	}
-	list_del_init(&lgr->list);
-	lgr->freeing =3D 1;
-	spin_unlock_bh(lgr_lock);
 	schedule_work(&lgr->terminate_work);
 }
=20
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 9a0523f4c..5c9653300 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -234,9 +234,9 @@ struct smc_link_group {
 	struct delayed_work	free_work;	/* delayed freeing of an lgr */
 	struct work_struct	terminate_work;	/* abnormal lgr termination */
 	struct workqueue_struct	*tx_wq;		/* wq for conn. tx workers */
-	u8			sync_err : 1;	/* lgr no longer fits to peer */
-	u8			terminating : 1;/* lgr is terminating */
-	u8			freeing : 1;	/* lgr is being freed */
+	u8			sync_err;	/* lgr no longer fits to peer */
+	u8			terminating;	/* lgr is terminating */
+	u8			freeing;	/* lgr is being freed */
=20
 	bool			is_smcd;	/* SMC-R or SMC-D */
 	u8			smc_version;
--=20
2.50.1 (Apple Git-155)

