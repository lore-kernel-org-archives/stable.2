Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ADF447805;
	Fri, 16 Oct 2026 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187757; cv=none; b=nTwHUKdo+G+GD5SIAy2vSDJNK0/vOTWNJWHHfQrm5M7LxyYQSQ2AcUwFibh1uIWWfsfBbepzR2vOgP4KJ2ww15AfAlIHf2qoirqW6uRERvoRuQU9OQZ4bw2oPWcMkrLTNRewXlB5JPXTfW5cCCs7lNgQOUYCow2F9ltQxR8wUww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187757; c=relaxed/simple;
	bh=VOu6W9Kebb8d6sC/awAZMDagwJeVdQXL2KG1GZRFWuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WN4raAGbgCbCzXiIyFbciWPzMbrYyvCChVgWOWCQpNKPa5djlX7YvPTWmi2rpd+TRABn9V6Xii42AAYSMBODeQqlYYtC1TNSj0IcGXB57Yt0vj4XJZ/6WNDLtcxJXpdQ0axs/Bf038jI8fdgiMs4lDv5RBZKIxy7U28nar6UgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JtwqICHl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JtwqICHl"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GJiVwm490437;
	Fri, 16 Oct 2026 21:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0BADyP
	uttV1npo1QJ/U5gqBi08d6l31PT4PbdQjqd1U=; b=JtwqICHlaB7B/VfYkd8oBQ
	MuCmOOkU71MNmo+grW8DzYRVKYCmvDaZQ89e7sJiPfbWFIGLZsSFXVfMRGPuSCx9
	oZaH7+5QjRDlaiYiDTG3505DJrQhRaydSIKjnCOGwJMasDQJoSY1Q7X7nZyTzoF+
	lo3GvI5Npoc+bn3hMZhlTIPIwZleaHsLDhLT/idvFC6Jj7fV2kzX6KsoeGiC4HEX
	SPoo/K1Cqq5ukrAcOgLMiQK+gTGPbrhhBCKibRt1p8SJBwDqELRHdk54Bsgi5t8k
	CY4z7fXQIxu0RgnSq3J9Nbzmu6JkS9e7y9KcOhnplAqQoGDOdQdMVe/Z9jUHEzwA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv41nne-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 21:55:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69GJnv5S022322;
	Fri, 16 Oct 2026 21:55:29 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hawqwxqth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 21:55:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69GLtRK96161298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 21:55:28 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCDED58063;
	Fri, 16 Oct 2026 21:55:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19AA558059;
	Fri, 16 Oct 2026 21:55:25 +0000 (GMT)
Received: from [9.67.103.235] (unknown [9.67.103.235])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Oct 2026 21:55:24 +0000 (GMT)
Message-ID: <3ae9b5c4-424f-4048-b78b-5f9bd36fef48@linux.ibm.com>
Date: Fri, 16 Oct 2026 14:55:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ibmvnic: defer close from reset allocation
 failure
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Haren Myneni <haren@linux.ibm.com>,
        Rick Lindsley <ricklind@linux.ibm.com>,
        Nick Child <nnac123@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20261004103131.1205618-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20261004103131.1205618-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: iqUmtBv8nkL_E4y1V0qYb60OLHwY1X3j
X-Proofpoint-ORIG-GUID: qI2N-qs_PpX8yC6_fbPQnY7MKWLLxEqX
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6ad29d53 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=ELaMOE5r3NirCJLtdPEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA4NiBTYWx0ZWRfX97FDx2fshrwb
 ywbBh28/Z85Tg5UZXAtx/FV5zdU2ee0EvxInTOv5MrcxuRjbt8K6TijFV5Mgo9BoEnrPM2nqQqK
 ZqMhqQKP+j7hb0VqUoQUtttMdrQLjFs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA4NiBTYWx0ZWRfX/6gU/g8cLloY
 bFLluykvjATMODFwhhRyuP1vzKH3B54SuKeTjVSARVemBJxG10FC+zTQ0dD37OkBeuyPDN9hk2r
 R7R9vmfiHYDxwTwCGfMLO1Ei6O3NmrCbwKrintppSr+gDgnxD5HOEFZZIITd9KZDwD9D2SsoFXi
 dUZn6NTSlec22D7cqObRhZmP70/MCboqngj9vO5BKGgi/E/30+IytXPnzRNG1iC1ACIq3dHMO1d
 mbTYUWwY8AxKuFmgvmzEATfBAjKoveoHDC3xQn5lqNdB2/qhnCA2w5uSZQgh7D88ldiN6lxz6te
 hVAMALgApN+sHEKsInN7IzpRoeWEia7CxvK7+aKHOUmCqPeMany65xWc7VuDX0Y48dCx4K/7yzt
 GHos50eRJ89+uAkWsMOKgH97O70UmXPLRbMc2xNOvGkAUu3r+fRfC+/cC3EbN+BJdKWvneufBR9
 ZsUCQ8xjEp3wuXauUew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160086


On 10/4/26 3:31 AM, Runyu Xiao wrote:
> ibmvnic_reset() can be called by the CRQ tasklet. If allocating the
> reset work item fails, it currently calls ibmvnic_close() after
> dropping rwi_lock, but ibmvnic_close() reaches napi_disable() and
> other sleepable teardown paths.
>
> Defer the close to a work item and keep the work within the adapter
> lifetime. Track removal separately from the visible adapter state so
> ibmvnic_close() cannot make removal look active again after remove()
> has begun. Check that monotonic flag while scheduling reset and
> delayed reset work, and drain all work before releasing the adapter.
>
> Use complete_all() for probe_done because the reset and close workers
> may wait for probe completion concurrently.
>
> The issue was identified by code inspection. No runtime reproduction or
> real hardware testing is available.
>
> Fixes: ed651a10875f ("ibmvnic: Updated reset handling")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>   drivers/net/ethernet/ibm/ibmvnic.c | 54 ++++++++++++++++++++++++------
>   drivers/net/ethernet/ibm/ibmvnic.h |  2 ++
>   2 files changed, 45 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 5a510eed33..4da3fd7ce0 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -2152,6 +2152,26 @@ static int ibmvnic_close(struct net_device *netdev)
>   	return rc;
>   }
>   
> +static void ibmvnic_close_work(struct work_struct *work)
> +{
> +	struct ibmvnic_adapter *adapter = container_of(work,
> +							struct ibmvnic_adapter,
> +							ibmvnic_close_work);
> +	unsigned long flags;
> +	bool removing;
> +
> +	/* The close path can sleep, so run it outside the CRQ tasklet. */
> +	wait_for_completion(&adapter->probe_done);
> +	rtnl_lock();
> +	spin_lock_irqsave(&adapter->rwi_lock, flags);
> +	removing = adapter->removing;
> +	spin_unlock_irqrestore(&adapter->rwi_lock, flags);
> +
> +	if (!removing)
> +		ibmvnic_close(adapter->netdev);
> +	rtnl_unlock();
> +}
> +
>   /**
>    * get_hdr_lens - fills list of L2/L3/L4 hdr lens
>    * @hdr_field: bitfield determining needed headers
> @@ -3229,9 +3249,12 @@ static void __ibmvnic_reset(struct work_struct *work)
>   	if (adapter->state == VNIC_PROBING &&
>   	    !wait_for_completion_timeout(&adapter->probe_done, timeout)) {
>   		dev_err(dev, "Reset thread timed out on probe");
> -		queue_delayed_work(system_long_wq,
> -				   &adapter->ibmvnic_delayed_reset,
> -				   IBMVNIC_RESET_DELAY);
> +		spin_lock_irqsave(&adapter->rwi_lock, flags);
> +		if (!adapter->removing)
> +			queue_delayed_work(system_long_wq,
> +					   &adapter->ibmvnic_delayed_reset,
> +					   IBMVNIC_RESET_DELAY);
> +		spin_unlock_irqrestore(&adapter->rwi_lock, flags);
>   		return;
>   	}
>   
> @@ -3265,7 +3288,7 @@ static void __ibmvnic_reset(struct work_struct *work)
>   	 */
>   	need_reset = false;
>   	spin_lock(&adapter->rwi_lock);
> -	if (!list_empty(&adapter->rwi_list)) {
> +	if (!adapter->removing && !list_empty(&adapter->rwi_list)) {
>   		if (test_and_set_bit_lock(0, &adapter->resetting)) {
>   			queue_delayed_work(system_long_wq,
>   					   &adapter->ibmvnic_delayed_reset,
> @@ -3422,7 +3445,8 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
>   	 * a failover reset scheduled, we will detect and drop the
>   	 * duplicate reset when walking the ->rwi_list below.
>   	 */
> -	if (adapter->state == VNIC_REMOVING ||
> +	if (adapter->removing ||
> +	    adapter->state == VNIC_REMOVING ||
>   	    adapter->state == VNIC_REMOVED ||
>   	    (adapter->failover_pending && reason != VNIC_RESET_FAILOVER)) {
>   		ret = EBUSY;
> @@ -3458,11 +3482,11 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
>   
>   	ret = 0;
>   err:
> -	/* ibmvnic_close() below can block, so drop the lock first */
> -	spin_unlock_irqrestore(&adapter->rwi_lock, flags);
> -
>   	if (ret == ENOMEM)
> -		ibmvnic_close(netdev);
> +		queue_work(system_long_wq, &adapter->ibmvnic_close_work);
> +
> +	/* ibmvnic_close() can block, so defer it out of atomic context. */
> +	spin_unlock_irqrestore(&adapter->rwi_lock, flags);
>   
>   	return -ret;
>   }
> @@ -6466,6 +6490,7 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
>   	SET_NETDEV_DEV(netdev, &dev->dev);
>   
>   	INIT_WORK(&adapter->ibmvnic_reset, __ibmvnic_reset);
> +	INIT_WORK(&adapter->ibmvnic_close_work, ibmvnic_close_work);
>   	INIT_DELAYED_WORK(&adapter->ibmvnic_delayed_reset,
>   			  __ibmvnic_delayed_reset);
>   	INIT_LIST_HEAD(&adapter->rwi_list);
> @@ -6568,7 +6593,8 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
>   		goto cpu_notif_add_failed;
>   	}
>   
> -	complete(&adapter->probe_done);
> +	complete_all(&adapter->probe_done);
> +	flush_work(&adapter->ibmvnic_close_work);
>   
>   	return 0;
>   
> @@ -6591,10 +6617,14 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
>   	/* cleanup worker thread after releasing CRQ so we don't get
>   	 * transport events (i.e new work items for the worker thread).
>   	 */
> +	spin_lock_irqsave(&adapter->rwi_lock, flags);
> +	adapter->removing = true;
>   	adapter->state = VNIC_REMOVING;
> -	complete(&adapter->probe_done);
> +	spin_unlock_irqrestore(&adapter->rwi_lock, flags);
> +	complete_all(&adapter->probe_done);
>   	flush_work(&adapter->ibmvnic_reset);
>   	flush_delayed_work(&adapter->ibmvnic_delayed_reset);
> +	flush_work(&adapter->ibmvnic_close_work);
>   
>   	flush_reset_queue(adapter);
>   
> @@ -6620,6 +6650,7 @@ static void ibmvnic_remove(struct vio_dev *dev)
>   	 * from the flush_work() below, can make progress.
>   	 */
>   	spin_lock(&adapter->rwi_lock);
> +	adapter->removing = true;
>   	adapter->state = VNIC_REMOVING;
>   	spin_unlock(&adapter->rwi_lock);
>   
> @@ -6629,6 +6660,7 @@ static void ibmvnic_remove(struct vio_dev *dev)
>   
>   	flush_work(&adapter->ibmvnic_reset);
>   	flush_delayed_work(&adapter->ibmvnic_delayed_reset);
> +	flush_work(&adapter->ibmvnic_close_work);
>   
>   	rtnl_lock();
>   	unregister_netdevice(netdev);
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
> index 480dc58707..d8c8a6d230 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.h
> +++ b/drivers/net/ethernet/ibm/ibmvnic.h
> @@ -1045,6 +1045,7 @@ struct ibmvnic_adapter {
>   
>   	struct tasklet_struct tasklet;
>   	enum vnic_state state;
> +	bool removing;
>   	/* Used for serialization of state field. When taking both state
>   	 * and rwi locks, take state lock first.
>   	 */
> @@ -1056,6 +1057,7 @@ struct ibmvnic_adapter {
>   	 */
>   	spinlock_t rwi_lock;
>   	struct work_struct ibmvnic_reset;
> +	struct work_struct ibmvnic_close_work;
>   	struct delayed_work ibmvnic_delayed_reset;
>   	unsigned long resetting;
>   	/* last device reset time */

Thanks for looking at this. The bug is real — deferring close out of
the CRQ tasklet is the right direction.

I walked ibmvnic_close_work() against the probe success path. Can a
probe-time ENOMEM leave the adapter in VNIC_CLOSED with no
init_resources()?

ibmvnic_reset() does not reject VNIC_PROBING, and the CRQ tasklet can
reach it during probe (e.g. CRQ_INIT -> VNIC_RESET_FAILOVER when state
is not VNIC_DOWN, or an XPORT_EVENT -> FATAL/MOBILITY). On GFP_ATOMIC
failure your worker waits on probe_done, then:

probe sets VNIC_PROBED / VNIC_DOWN, register_netdev()
   -> complete_all() + flush_work(close_work)
   -> ibmvnic_close() sets VNIC_CLOSED
next open sees state == VNIC_CLOSED, skips login/init_resources()
   -> ibmvnic_napi_enable() uses adapter->napi[i] while napi is
      still NULL (allocated only in init_napi() via init_resources())

Previously the inline close ran under VNIC_PROBING and probe overwrote
the final state afterwards. flush_work() after complete_all() reverses
that.

Should the worker only close when the iface was actually running
(netif_running() / state == VNIC_OPEN)?

While you are here: would dev_close() be better than calling
ibmvnic_close() directly? A bare ndo_stop leaves IFF_UP set when the
device was up (same as the old inline ENOMEM path). Keep rtnl_lock() in
the worker — dev_close() only takes the ops lock; __dev_close_many()
still expects rtnl. And netif_close() is a no-op when !(flags & IFF_UP),
which also avoids this post-probe VNIC_CLOSED case.

Minor on adapter->removing: the commit message is a bit stronger than
what a snapshot under rwi_lock can guarantee vs ibmvnic_remove(). Fine
to simplify in v2 if you prefer guarding VNIC_REMOVING in
__ibmvnic_close() instead of a new bool.

Happy to look at v2.

Thanks,

Mingming

