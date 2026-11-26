Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795673414;
	b=AkpRUPSajp6BHnHt0OIN5L27E2hyUv2MDJajjauMKzzC7pVJwBfPekg/tNWgnOJK9J2L
	 wxgfG99IhpuhIA39ixLhvdWbqLjTpiqA+xM3qvfbZfPGmNoDS/skA8o4fJRRE7HicahyW
	 U/LrT7p5P19F/ZrKkUQgYZZZlKZ9qWA5wS66mETXZsLPMzCNBsLW931tyjVN+5O2I3Ij7
	 UxEu2iFNq0tRgg1bHEWaLMGIquTXL65K0sY623WbuP9YdZm/enn8dqV8ql+Vla5mRPyhC
	 o0KozBSNx89t0vyx4B1MyxX3DubOdP+lW8cVt0VwEH35rDV1v3cCGKXmSbV+82DJtHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673414;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YIG1/rKhXSPMbIK13QM/tJn4G5wq5DBeH12jyQAkIYk=;
	b=tQdkXOXF6KNZOIvjfDQnkj6PRpNWGNorN3S9vVlQyTxdQSbkNAxTb9oUhyxwWK3JShlj
	 f7hUFI2dIzlikYgwZR4mQUsP0n2CvtSI4jSz77U1jXnt35N/YF+rtvzFrs3wL2WUy4uMa
	 SmmiXSG/+hUtESbTJPsuigcWexP6zzxMiycBtnwL0Iz2r2AWuVAUrn0mF2qmNq46A5ZPn
	 mtoLSrK69HrJUSajDbeyPTSQx8m1vFft2+RnlwZb4OoW0XzD3RZe8elzdCMlgdPnuiLSE
	 bIPMfP9rL3q5NsV+B/Xvj1++N6cNXflseGTTdP9R5qX6+vo5+/og4sehVGJkyzs2KYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LjgfZVm1;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74732606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74732606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LjgfZVm1
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ34lSO3087158;
	Thu, 26 Nov 2026 06:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YIG1/r
	KhXSPMbIK13QM/tJn4G5wq5DBeH12jyQAkIYk=; b=LjgfZVm1tx3rmc7nKUwjxU
	3yJXo8hug/2CCV/YU7lyp6JoQtDOgaFC13325ORGO8B9IyeaR8PW3CuRRrIc90KX
	w2RBn/EEE9Ow2jXc+OnSgQhTY5yrHnUYPUIkigEVpW6ejGlS8zr45M9IwYx7p+Gb
	tha7Z6tgJQ+LN/03uFwmTV93OuRPH3TaJ1cVZj2MrAhosJsi7IwPanvdy0GGHawn
	u8IV45tKs16EIcNFcQ+IoCUIWU6Sw2P61spWRYOdIShfJr0ntRf0aiYj9ftV8GTj
	wpmiZaqFrPN63RftNjE7kTRZCwzuXenZykQS4S8AbJWOYnHrH4GUlwiLWX9+f4nA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvfe5p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 06:10:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ34QQC3117283;
	Thu, 26 Nov 2026 06:10:06 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5a4170ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 06:10:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQ6A63Z26083882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 06:10:06 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D27758067;
	Thu, 26 Nov 2026 06:10:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4EB458052;
	Thu, 26 Nov 2026 06:10:04 +0000 (GMT)
Received: from [9.123.8.233] (unknown [9.123.8.233])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Nov 2026 06:10:04 +0000 (GMT)
Message-ID: <68c40eed-4236-484c-8c27-6b402591f434@linux.ibm.com>
Date: Thu, 26 Nov 2026 11:40:03 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] net/smc: fix link group ownership in
 handshake abort" failed to apply to 5.10-stable tree
To: gregkh@linuxfoundation.org, kuba@kernel.org
Cc: stable@vger.kernel.org
References: <2026112437-choice-divinity-df23@gregkh>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <2026112437-choice-divinity-df23@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b07cd3f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=bC-a23v3AAAA:8 a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=catjiPnosn0LcQ0sTyoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyMyBTYWx0ZWRfXyzLdjIhdzqMu
 CH6dl81XQ2AzXrJgsK13fWH9ARW//wpWjX1jlxcXerzd50h00i6BU+gQ1XrzfotxAv0WcdhBuS1
 7stroNk7zI9yumi3YcNI+FEYw87uRo0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyMyBTYWx0ZWRfX8GaLCeFTzKSQ
 bx6Dl8EN4EK9LdOTll1Guq6r6y0ld7IdFlauNie+2IwDxO4jFcsjyCXn6QP59LlhnLQWeeUgBkf
 nw5T+nVDlHZWYP/S73XQkOZJlhjvUiZFjaqQekeNwTihthD8kolUC59hMECaFgic2usXAJwGn6h
 s5dD4eJAATNhfbyYGN3z3E8HPP4VEHTgGm05Va9m02XC4+bC2tyv2sif04nqVI9O8VVJ4Z/SHMh
 AvpT9Sd1066ae+QPiL19AI2edtoWte08uIBCCoFAlIDbikgtdIqJ4q/vuubdsCRY8XAsqNa8iTW
 D/WgFcyNjAFJTgB7RVAkZqIjXMzbu6jO/Zc0KmIiBiqUVIcAyYx5KXLiim6OyTbAVQmXk4+qZwz
 ySwCW0d6JZRsvgY2Ud6icl5tHpug2r8wADoVGf+qa9RyAbBi92pC7LluThUiokzCeLTHQrICTxj
 /0eBFgtjkxsTv2M4Iww==
X-Proofpoint-ORIG-GUID: RPMEduPNs0odhs_jQhFNT1s7JDqWg2R7
X-Proofpoint-GUID: RPMEduPNs0odhs_jQhFNT1s7JDqWg2R7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260023

Thanks, Greg.

Please skip 5.10 for this one. It needs the link group refcount,
conn->freed and smc_conn_lgr_valid() from 5.17; 5.15 lacks them too, but
there the backport keeps every function's shape and only drops the
lifetime hold.  In 5.10 there is no smc_conn_abort(), and
smc_lgr_cleanup_early() frees the connection itself, so the patch would
have to restructure that function — not something I want to carry on a
tree this close to EOL. The 6.x backports Sasha sent are complete, and
I've sent the 5.15 one separately.

On 24/11/26 10:37 pm, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x e227b511582828c5a6513f70fc6a71211e5efbf0
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112437-choice-divinity-df23@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From e227b511582828c5a6513f70fc6a71211e5efbf0 Mon Sep 17 00:00:00 2001
> From: Mahanta Jambigi <mjambigi@linux.ibm.com>
> Date: Fri, 6 Nov 2026 14:04:57 +0100
> Subject: [PATCH] net/smc: fix link group ownership in handshake abort
> 
> An aborted first-contact handshake can hang the handshake worker on the
> socket lock it already holds, reset the clcsock of a socket that has
> fallen back to TCP, or corrupt the alert-node lookup when the handshake
> retries with the same connection.
> 
> The abort leaves a connection registered in a link group that another
> context has already unlinked for termination: smc_conn_free() skips the
> unregister when lgr->list is empty, so the alert token and alert node
> stay in lgr->conns_all. If the handshake retries another device or SMC
> version, smc_conn_create() creates a second link group and
> smc_lgr_register_conn() inserts the same alert node into it: the token
> loop is skipped, rb_link_node() links a node that is still in the old
> tree into the new one, and a second sock_hold() is taken where only one
> sock_put() will follow. The old group's terminator then keeps returning
> that node from rb_first() and can kill a connection that now belongs to
> the new group.
> 
> smc_lgr_cleanup_early() also starts a second termination of the link
> group that is already being terminated, which takes lock_sock() on the
> socket the handshake worker holds; if the termination work wins the race
> instead, it later kills the freed connection and aborts the clcsock of a
> socket that has fallen back to TCP. Making the unregister unconditional
> also lets smc_conn_free() reach the delayed free work on a claimed link
> group, where the lockless freeing check can arm it after the owner has
> cancelled it.
> 
> Always unregister the connection, claim a link group for termination
> once under lgr_lock, keep the link group alive across the abort, and arm
> the delayed free work only under the same lock and cancel it
> synchronously before the teardown. Drop an already freed connection in
> smc_conn_kill() without running the connection and socket teardown.
> 
> Fixes: 2a0674fffb6b ("net/smc: improve abnormal termination of link groups")
> Fixes: f9aab6f2ce57 ("net/smc: immediate freeing in smc_lgr_cleanup_early()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
> Link: https://patch.msgid.link/20261106130457.1092203-1-mjambigi@linux.ibm.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index ec5980add7a9..bfc0c7e71a12 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1013,14 +1013,15 @@ static void smc_conn_abort(struct smc_sock *smc, int local_first)
>  {
>  	struct smc_connection *conn = &smc->conn;
>  	struct smc_link_group *lgr = conn->lgr;
> -	bool lgr_valid = false;
> -
> -	if (smc_conn_lgr_valid(conn))
> -		lgr_valid = true;
> +	bool lgr_valid = local_first && smc_conn_lgr_valid(conn);
>  
> +	if (lgr_valid)
> +		smc_lgr_hold(lgr);	/* lgr_put below */
>  	smc_conn_free(conn);
> -	if (local_first && lgr_valid)
> +	if (lgr_valid) {
>  		smc_lgr_cleanup_early(lgr);
> +		smc_lgr_put(lgr);
> +	}
>  }
>  
>  /* check if there is a rdma device available for this connection. */
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 0a9f5418329a..a3164201c142 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -80,16 +80,21 @@ static void smc_ibdev_cnt_dec(struct smc_link *lnk)
>  
>  static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
>  {
> +	spinlock_t *lgr_lock;
> +
>  	/* client link group creation always follows the server link group
>  	 * creation. For client use a somewhat higher removal delay time,
>  	 * otherwise there is a risk of out-of-sync link groups.
>  	 */
> +	smc_lgr_list_head(lgr, &lgr_lock);
> +	spin_lock_bh(lgr_lock);
>  	if (!lgr->freeing) {
>  		mod_delayed_work(system_percpu_wq, &lgr->free_work,
>  				 (!lgr->is_smcd && lgr->role == SMC_CLNT) ?
>  						SMC_LGR_FREE_DELAY_CLNT :
>  						SMC_LGR_FREE_DELAY_SERV);
>  	}
> +	spin_unlock_bh(lgr_lock);
>  }
>  
>  /* Register connection's alert token in our lookup structure.
> @@ -679,19 +684,34 @@ int smcd_nl_get_lgr(struct sk_buff *skb, struct netlink_callback *cb)
>  	return skb->len;
>  }
>  
> -void smc_lgr_cleanup_early(struct smc_link_group *lgr)
> +/* Claim a link group for termination. Only one context can succeed: the
> + * lgr is removed from its list and marked freeing under lgr_lock.
> + * Returns false if @lgr is NULL or another context owns it.
> + */
> +static bool smc_lgr_claim(struct smc_link_group *lgr)
>  {
>  	spinlock_t *lgr_lock;
>  
>  	if (!lgr)
> -		return;
> -
> +		return false;
>  	smc_lgr_list_head(lgr, &lgr_lock);
>  	spin_lock_bh(lgr_lock);
> +	if (lgr->freeing || lgr->terminating || list_empty(&lgr->list)) {
> +		spin_unlock_bh(lgr_lock);
> +		return false;
> +	}
>  	/* do not use this link group for new connections */
> -	if (!list_empty(&lgr->list))
> -		list_del_init(&lgr->list);
> +	list_del_init(&lgr->list);
> +	lgr->freeing = 1;
>  	spin_unlock_bh(lgr_lock);
> +	return true;
> +}
> +
> +/* The caller must keep @lgr alive for the duration of the call. */
> +void smc_lgr_cleanup_early(struct smc_link_group *lgr)
> +{
> +	if (!smc_lgr_claim(lgr))
> +		return;	/* another context owns the termination */
>  	__smc_lgr_terminate(lgr, true);
>  }
>  
> @@ -1281,10 +1301,12 @@ void smc_conn_free(struct smc_connection *conn)
>  		if (current_work() != &conn->abort_work)
>  			cancel_work_sync(&conn->abort_work);
>  	}
> -	if (!list_empty(&lgr->list)) {
> +	/* The handshake can retry another device or SMC version with this
> +	 * connection, so it must never stay registered in an lgr it left.
> +	 */
> +	if (!list_empty(&lgr->list))
>  		smc_buf_unuse(conn, lgr); /* allow buffer reuse */
> -		smc_lgr_unregister_conn(conn);
> -	}
> +	smc_lgr_unregister_conn(conn);
>  
>  	if (!lgr->conns_num)
>  		smc_lgr_schedule_free_work(lgr);
> @@ -1519,6 +1541,15 @@ static void smc_conn_kill(struct smc_connection *conn, bool soft)
>  {
>  	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
>  
> +	if (conn->freed) {
> +		/* The connection was already freed, e.g. by a close or
> +		 * a handshake that fell back to TCP. Do not abort a socket
> +		 * that is no longer part of this link group.
> +		 */
> +		smc_lgr_unregister_conn(conn);
> +		return;
> +	}
> +
>  	if (conn->lgr->is_smcd && conn->lgr->peer_shutdown)
>  		conn->local_tx_ctrl.conn_state_flags.peer_conn_abort = 1;
>  	else
> @@ -1566,12 +1597,20 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
>  	struct smc_connection *conn;
>  	struct smc_sock *smc;
>  	struct rb_node *node;
> +	spinlock_t *lgr_lock;
>  
> -	if (lgr->terminating)
> +	smc_lgr_list_head(lgr, &lgr_lock);
> +	spin_lock_bh(lgr_lock);
> +	if (lgr->terminating) {
> +		spin_unlock_bh(lgr_lock);
>  		return;	/* lgr already terminating */
> -	/* cancel free_work sync, will terminate when lgr->freeing is set */
> -	cancel_delayed_work(&lgr->free_work);
> +	}
>  	lgr->terminating = 1;
> +	spin_unlock_bh(lgr_lock);
> +	/* The lgr is claimed, so no new free_work can be armed; wait for
> +	 * one that is already queued or running.
> +	 */
> +	cancel_delayed_work_sync(&lgr->free_work);
>  
>  	/* kill remaining link group connections */
>  	read_lock_bh(&lgr->conns_lock);
> @@ -1582,7 +1621,11 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
>  		sock_hold(&smc->sk); /* sock_put below */
>  		read_unlock_bh(&lgr->conns_lock);
>  		lock_sock(&smc->sk);
> -		smc_conn_kill(conn, soft);
> +		/* The connection may have been re-registered in another
> +		 * link group by a retried handshake in the meantime.
> +		 */
> +		if (conn->lgr == lgr)
> +			smc_conn_kill(conn, soft);
>  		release_sock(&smc->sk);
>  		sock_put(&smc->sk); /* sock_hold above */
>  		read_lock_bh(&lgr->conns_lock);
> @@ -1596,17 +1639,8 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
>  /* unlink link group and schedule termination */
>  void smc_lgr_terminate_sched(struct smc_link_group *lgr)
>  {
> -	spinlock_t *lgr_lock;
> -
> -	smc_lgr_list_head(lgr, &lgr_lock);
> -	spin_lock_bh(lgr_lock);
> -	if (list_empty(&lgr->list) || lgr->terminating || lgr->freeing) {
> -		spin_unlock_bh(lgr_lock);
> +	if (!smc_lgr_claim(lgr))
>  		return;	/* lgr already terminating */
> -	}
> -	list_del_init(&lgr->list);
> -	lgr->freeing = 1;
> -	spin_unlock_bh(lgr_lock);
>  	schedule_work(&lgr->terminate_work);
>  }
>  
> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
> index 5c18f08a4c8a..bff4c9e17792 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -301,9 +301,9 @@ struct smc_link_group {
>  	struct delayed_work	free_work;	/* delayed freeing of an lgr */
>  	struct work_struct	terminate_work;	/* abnormal lgr termination */
>  	struct workqueue_struct	*tx_wq;		/* wq for conn. tx workers */
> -	u8			sync_err : 1;	/* lgr no longer fits to peer */
> -	u8			terminating : 1;/* lgr is terminating */
> -	u8			freeing : 1;	/* lgr is being freed */
> +	u8			sync_err;	/* lgr no longer fits to peer */
> +	u8			terminating;	/* lgr is terminating */
> +	u8			freeing;	/* lgr is being freed */
>  
>  	refcount_t		refcnt;		/* lgr reference count */
>  	bool			is_smcd;	/* SMC-R or SMC-D */
> 

