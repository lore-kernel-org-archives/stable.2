Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601189;
	b=viOHRaW1CXfk6oxFurMqdIcIk2rBMlylcfdyEncyqo8RN/rLOsI/EHNNRzVbZWkKHrQ/
	 VA14nKpqME+45YpGFoLPnV8mCbiRLUlmYXnE7ymOm7ux0a5glvyRDWiDeSYh0p1mN5b0c
	 EYLHpqwzAhk5+PHoLcXeMOekvVNwukRIUt93HH+aR06c67ehPLLeRDZEuHIk32uF2eMe2
	 ctaRDkMJ8ZRwOFTJcbBcs232cRRjPtiAvplnixMDmGwajPVZBvkB1UkUVy7aEG7QHnG5T
	 kpsrle6RqFNjCK+6d19cYPuC/ZO2aJMGCAtGxHXGA0d0/igieC3RSQJ+EskyW+hprXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601189;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mfUZlUZeVw3LMZNOge3AuFvaChcZHK3e0pmOOCr/JXw=;
	b=4uV+OoPncraeBka/9VAGma5RVMVobm6H4JBsTYK2Wdyrvheqzb7iKx2E3692ojsNYF91
	 0QoDTiHG2t1TlpF7z9xIcpmYzlLAPaa2PMNHgki5alO8PoDvbebW8i4bABdqvdmxHHat2
	 w30l75q1EjklQmHbXBX9vxQoSHiCQhKXKqdjt4L97VMQnuwWNk/UX0j6h8gdewZvtxABN
	 Z9+BBoIG+4NuYEDZkcn4PcQ52dvpQznlIv9nf4lY8fe8eo0aoRqQGEtvZtRxVFQ1b9qNq
	 jI5wqFjn1jiwI5VONeisixuIxPFjZxdRS4Sdt1Ysy8B6zhcs1+hYSHudaWlVpdY/vTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZxjUxWYy;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23778606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23778606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZxjUxWYy
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APA4mGe973560;
	Wed, 25 Nov 2026 10:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mfUZlU
	ZeVw3LMZNOge3AuFvaChcZHK3e0pmOOCr/JXw=; b=ZxjUxWYypFgothVTC4wqYd
	ANzc5VzYCe2fz7dPoI0HmT45M0k51yxDFP9JjlQFyhRz7TklgRR3g/lZzW75VwCJ
	lBOQWp3o3HxZq2eCEmeyHQzsEaILAwvhE0R9cIEHwgLanxHIi0Rm7XLqJL2kCbaF
	8VZEOX9ltbR6EthNypR+hxaK/6bmi40knR4qpEoIhqZRNR+jJP4wJvzT23pMR2MO
	gGv5kHqkSzDHNLm5+au1oBQ3BmIXntyvbvOXcFiQEB9gV24H4IdDdZSckDeDBJ8o
	GpQw9RTBry4KISlwOAQSTo49fMtIg9ZuzZ2X+q+yU4DvGCfmaPhP8tSFMkTlNDYQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvbd7e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 10:06:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9nFBK4073005;
	Wed, 25 Nov 2026 10:06:10 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx09r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 10:06:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APA69Zr32178718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 10:06:10 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A57F058051;
	Wed, 25 Nov 2026 10:06:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 599C358060;
	Wed, 25 Nov 2026 10:06:08 +0000 (GMT)
Received: from [9.123.5.224] (unknown [9.123.5.224])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 10:06:07 +0000 (GMT)
Message-ID: <f34c7af0-7777-4f07-b0e1-e8fc85b05d54@linux.ibm.com>
Date: Wed, 25 Nov 2026 15:36:06 +0530
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
Subject: Re: [PATCH 6.6.y] net/smc: fix link group ownership in handshake
 abort
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>
References: <2026112436-tapered-rerun-023f@gregkh>
 <20261124235030.3375242-1-sashal@kernel.org>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20261124235030.3375242-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b06b312 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=bC-a23v3AAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=B8UU_-utOAR4HDf9suUA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfXxnSNqmCnRQHV
 P9Q93rXi2FzTM+NboysfJ6TZ5kkAf8Ripf09FW6AH/mJQueG1bTMOUrpdbkcKPVrLIFOQzitIud
 y7qphWv70Qe2ueRMr5+EoCxTO6EddDE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX1gpHYS3Q7ScM
 YTRBGeQ01sfSxSBcLaGYNP+H0Cn72lh0pbTg1AshhOcRV28PMJ8g2SShRArj0KsRZV3bGOG7fjN
 mKoioDvczBe9WPFg9pD8+Dygf8t0zAJCC6w6QzvwGyg52zb6p33nGsn5QaPIiCclCnqeOka52Ki
 yhxDrkLc+sHmHlrlQc+El+zRSgfmOT0oFLOA8PzdXJytGkhq3mftuCzAmrFxKsHle6XdNX+ZhmD
 FszxFqEL2AktJIVZLd0L7COXHhhPb4vKpweqsoFrT7wqgh4a7Gend6ILBBuSiMjyXPPQ5iTtf0Z
 Bw85bZrvcyp4lm9+VnauG/jnMzPDhy0m/xm2Fv36DiGbPYHeMqKs/I+BPmujdzTjwX1bgFIGlZC
 jd1SZ93SAMMhMRLmKQQBxQWE1mllC6zUo5cayj2sHpTA3N4er85vB5ZKKAt0k46xN9hHrgmwxu7
 Rg7z1NTIE7kMbRYacQA==
X-Proofpoint-ORIG-GUID: 5_GLGAp-lHGuLEQH2DZetLvVq-5nSGap
X-Proofpoint-GUID: 5_GLGAp-lHGuLEQH2DZetLvVq-5nSGap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250040

Thanks, Sasha.

The 6.6 branch has the link-group refcount, conn->freed and
smc_conn_lgr_valid() that this fix relies on, so nothing had to be
dropped; apart from the workqueue name (system_wq) it is the upstream
change.  I applied it against the current linux-6.6.y head (6.6.163) and
the diff matches the code there.

Acked-by: Mahanta Jambigi <mjambigi@linux.ibm.com>

On 25/11/26 5:21 am, Sasha Levin wrote:
> From: Mahanta Jambigi <mjambigi@linux.ibm.com>
> 
> [ Upstream commit e227b511582828c5a6513f70fc6a71211e5efbf0 ]
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
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/smc/af_smc.c   | 11 ++++---
>  net/smc/smc_core.c | 78 +++++++++++++++++++++++++++++++++-------------
>  net/smc/smc_core.h |  6 ++--
>  3 files changed, 65 insertions(+), 30 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 4ec0c999998f8..618c1a7b4c343 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -990,14 +990,15 @@ static void smc_conn_abort(struct smc_sock *smc, int local_first)
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
> index 1c98071e4d3d7..896cc174e40e1 100644
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
>  		mod_delayed_work(system_wq, &lgr->free_work,
>  				 (!lgr->is_smcd && lgr->role == SMC_CLNT) ?
>  						SMC_LGR_FREE_DELAY_CLNT :
>  						SMC_LGR_FREE_DELAY_SERV);
>  	}
> +	spin_unlock_bh(lgr_lock);
>  }
>  
>  /* Register connection's alert token in our lookup structure.
> @@ -636,19 +641,34 @@ int smcd_nl_get_lgr(struct sk_buff *skb, struct netlink_callback *cb)
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
> @@ -1209,10 +1229,12 @@ void smc_conn_free(struct smc_connection *conn)
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
> @@ -1447,6 +1469,15 @@ static void smc_conn_kill(struct smc_connection *conn, bool soft)
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
> @@ -1494,12 +1525,20 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
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
> @@ -1510,7 +1549,11 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
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
> @@ -1524,17 +1567,8 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
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
> index 3694949b243db..89eb7b52df317 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -286,9 +286,9 @@ struct smc_link_group {
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

