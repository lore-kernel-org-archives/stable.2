Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600660;
	b=XnK/mUcweZhDfntKlIAOO5AedHg8vRlOjacTzlfph1mD6/Yh8teAdXBjqaNjyAOhzaDu
	 i98z8daHJIGxlK02QP4FTyLibKRGE5iCPx1MeWxtRFm9xPYs8ZtB8SxVpp+S4hV3AgR1M
	 UHHTHr//XU3OYdCBquV7UJJhRluNzoStMM8JMxeaAccuEC50df080bOhvE1iujdGhsfsh
	 kQKrcjdxKjHkDG3fxhLnMP05PXa0nziG/N69m80edDSv/qU1TQUZmSOsgYSpGtgtYqy6u
	 qcLvSkZgws198Hliikc9SBPYoxMAU/QH31u1mSiClf0mygUNRzJpvmSWPvKcyYxpnEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600660;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=lMBV2xRewcpdEBcqoNnTp5cKFvZVvRtCD/DUCTMsO+I=;
	b=fTayxPwBN1Iv/ArY7gqvReuCA0K578xJQ0CkhgXwSAchk7dvKH+GQ1jHQUSvW8PIH9XO
	 Vyn/dnzKioXNfUH46A1xW/f8Ov1ndS/EkqOwAyJ55rqKW4hiawLQe6xtEuaoGhP4VD6lF
	 K/22VFA8jxT3PshUTkkstmaQAcehHpPhYB5aRGJk3kU+09JqbOaagfaP1lW7VTO+V76EU
	 VJBtoMfWjLSrlMpYTunzv3Xw4cO9uRi+ihcZqboU62rgyzymBfsxK9Umd/rwg3EM2wGDN
	 CUI8FvGsToDCRQKVf7V7szvHTG5lcReSK7LS6cz46K4JLCePVQA8oYaSyHvTVoRtcqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KWnzD+dm;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DF6606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2DF6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KWnzD+dm
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP6YoVn3109893;
	Wed, 25 Nov 2026 09:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lMBV2x
	RewcpdEBcqoNnTp5cKFvZVvRtCD/DUCTMsO+I=; b=KWnzD+dmHC0A1V+0ijgG3R
	cvEes9Si0SncSqfueYH895sPcy7Ykb0asITtzsEegAWcKsw0AJfPXwimY0RigfzR
	rIatBWhGnFcwKqPEOdZsT3bL0UW4Vunj4sY39nG4Kx4kgmGWFsxy96HSk2FCq7fd
	ixguceuKFo8vb2fjkED5m5SDznZsiViwSUCvvpgOdQUuGRR4ciwib1ZGZ/O6mgNr
	xBALVj2+J5x8JZVYSIZ9XD3J93uUtm3vvSbmfiFqy44zk7sHyAAP/dt44RJJawkN
	ztMayCLuZbmFyRaAa/70gBq/8N+FcV/Zxgk+NLRASF5U8/gveEcQ56P//IWpYS3Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3bt6v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 09:57:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9nTld522113;
	Wed, 25 Nov 2026 09:57:29 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5axkuewc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 09:57:29 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AP9vSX71901100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 09:57:28 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01B0B5805A;
	Wed, 25 Nov 2026 09:57:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B10E65805E;
	Wed, 25 Nov 2026 09:57:26 +0000 (GMT)
Received: from [9.123.5.224] (unknown [9.123.5.224])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 09:57:26 +0000 (GMT)
Message-ID: <4d5ba9a8-9126-4f12-aed7-1953f0aab947@linux.ibm.com>
Date: Wed, 25 Nov 2026 15:27:25 +0530
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
Subject: Re: [PATCH 6.1.y] net/smc: fix link group ownership in handshake
 abort
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>
References: <2026112436-imaging-irritably-0e3f@gregkh>
 <20261124235721.3383543-1-sashal@kernel.org>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20261124235721.3383543-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b06b109 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=bC-a23v3AAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=B8UU_-utOAR4HDf9suUA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzOCBTYWx0ZWRfXwYupDFV5+N7r
 jkq9c/sPe51A4ioqvIEkzZyB+AYQMsx6gjonJKNy7J54EmlnIjpPn1+n1IetnJtY14WoVLE+qfs
 LOaN5hl01vPID3YI6JC2ucxP2+14B5s=
X-Proofpoint-ORIG-GUID: yUFToMchR-2fZDlmZwpusK2xSykanJpw
X-Proofpoint-GUID: yUFToMchR-2fZDlmZwpusK2xSykanJpw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzOCBTYWx0ZWRfXz4hw7ehPhGUr
 dX8t+Gez2s88UedMge3QlTup9/cJ0LEg9xLw8aUtU93fLxaQn9ROjQ3ryL/9sNAINxJikXTCq/a
 PKNuubvcncl277zTOuQFJusGk9ayUolXsheI6UEYNkSgbPLJCjBVRZFeHbNfcKm7FQwYw1iUOU+
 W2VbnbuWdQADmwO2F+rTD9k2j1vooRsenbPwvIaJpnLSGvodlzPqH29FZorNjMWdweD3wSQHhrd
 VH7p6JwuJo0QRAVqbR4SVahP0Uh0oqFIJzuc+B1Q5fMlcY5OvMeMKnkCOvOba6PQn5IQppctkHA
 oj+9jYpcX68Ih8bs1hRVySwfnO0RQJOlYHIeJXP6r64oS+VjuQ1JpH15KXtDcvi/44IIhb0uX17
 YH6TyWiN5c8C6hx9Vsl/ZveiflCXYJ1UIVMYJYreUhnbDOw0BmRs9Qr4QaRktv6VBkC2U9VQM4S
 lpBwgnCojNY9+j6aK+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250038

Thanks, Sasha.  The 6.1 branch has the link-group refcount, conn->freed
and smc_conn_lgr_valid() that this fix relies on, so nothing had to be
dropped; apart from the workqueue name it is the upstream change
verbatim.

Acked-by: Mahanta Jambigi <mjambigi@linux.ibm.com>


On 25/11/26 5:28 am, Sasha Levin wrote:
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
> index 4c158cde1f504..a335502e4c3ae 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -971,14 +971,15 @@ static void smc_conn_abort(struct smc_sock *smc, int local_first)
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
> index 5d188222807a8..a20ff53698950 100644
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
> @@ -629,19 +634,34 @@ int smcd_nl_get_lgr(struct sk_buff *skb, struct netlink_callback *cb)
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
> @@ -1176,10 +1196,12 @@ void smc_conn_free(struct smc_connection *conn)
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
> @@ -1414,6 +1436,15 @@ static void smc_conn_kill(struct smc_connection *conn, bool soft)
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
> @@ -1457,12 +1488,20 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
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
> @@ -1473,7 +1512,11 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
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
> @@ -1487,17 +1530,8 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
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
> index 6051d92270130..1ce0fd9480d5b 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -260,9 +260,9 @@ struct smc_link_group {
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

