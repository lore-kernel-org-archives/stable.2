Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768864E1C84;
	Fri, 25 Sep 2026 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363323; cv=none; b=Hv1cYYeuFviiZHCRn8LXIZHjENwkR3nOQWYNrNnV1r+QVriHpzbM/JcYW0+rSRX5z5i3bi2E4iaEabeoDmkPlDOwT3GAK1hr83FzLCLxwjs6VBZvNsKahzdRWgt7hS/7o0yNmxPydggq6Pw8f4cu8l1U2r0YWCKaPm7REtbaR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363323; c=relaxed/simple;
	bh=TmXlnKrSadOWLVaTkqMs6pDpQbnowESq4WOEmlHOznw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pfFBLVKzy3BaIaBVg+tztSX7bQB58xsEuYW3EGH8yFjWfjZ/q99fAgmxZ1wJtM84yW18DpSO2H7IW3Xn7yKQyXtg33ALXfQWe3vJEPGG0GemVgWexSDqI/c04Kmzjv8Fry7dTtE1y9GQIlHsjnlDMaLVRZH7KeqODzp2rYs3r1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q0P+p4ZB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q0P+p4ZB"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PJ5TlF711728;
	Fri, 25 Sep 2026 19:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MA6UEwiYd5ogH0sMx09PLSV5wmVjs8
	c/eNl8l425zHQ=; b=q0P+p4ZBcrjsvXn4yEiJq3cCGvrsMDtiumiOwss6P12CyZ
	cBkbNzmA9SXYDQIFopkNTgD9SkD/7gCQZju37ZxVoVrOXlVD3V9V2JYzSaZlFmD8
	7pnvHN5p15LlCirRc99vOh7e32uc4rVtERNua0NbR6cQqiTZY+uDxy0nXdfG+0Lp
	QZQTazRuhyz+4ukFIDeYH7SwW0iq9hp2DGTxrgMDeJgLHRkjYmTeT9tG9G1dJLfi
	5IoaGeLCoNyQRfXHVGhDX/N4qqJw59No0ee5yYmkrhDHAVwwHvGlRLzme7hnmXBN
	sGspDYllufsnfnT398cMRKO3J1gCF3d8GuFIhMhw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqypn9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 19:08:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PImR0h130658;
	Fri, 25 Sep 2026 19:08:11 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu93k7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 19:08:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PJ89Uc30081758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 19:08:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 773FB58054;
	Fri, 25 Sep 2026 19:08:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B686A58045;
	Fri, 25 Sep 2026 19:08:08 +0000 (GMT)
Received: from d (unknown [9.16.59.154])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 25 Sep 2026 19:08:08 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] ibmveth: fix TX LTB and filter unwind on open-fail
In-Reply-To: <d14314c2b10f125f5e578782484ba3cc50564d53.1790357373.git.mmc@linux.ibm.com>
	(Mingming Cao's message of "Fri, 25 Sep 2026 11:05:30 -0700")
References: <cover.1790357373.git.mmc@linux.ibm.com>
	<d14314c2b10f125f5e578782484ba3cc50564d53.1790357373.git.mmc@linux.ibm.com>
Date: Fri, 25 Sep 2026 14:08:08 -0500
Message-ID: <87fqyx1753.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab6c69c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=7IaaROpGTpDGSeW4PiYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NiBTYWx0ZWRfX8wu0hJAnPWnn
 kjmJUcbgtpObQ3NWiqF1cPlU3ChXuK3KE+y2pH1+USZQJENLi5N3cbqzJENPATFrlvyKfhcFce8
 Hejq7L8Kg8kFcdJCJYhgkH3MbSULYMCLPRnHZakYxEg2+6coB+QX4hFxCEWFXf15kzCMHnb8OMi
 4CzhdCSfZkAjsecYl5bRHOwYNQFVsgQM93T+qsBhy4XqDQUOdTeXCAZwbewsckv1tfvBH3GIYE6
 jAGCB12aEPNNMiv6rigZRyiRfU0M8XNnGJjIjZjnw8SCM9GomEpeDYP0ROrq45AR27A1gfZvgnN
 KZil0P41KqKwCVQAngi0mE0GqxBfW6TK16pc9AlZFqNBlGVJQ0bpC7rdHX5Fxo1Ts9L+I0nb7kv
 vBvPNU+b/564/GfIXeM7PUCSY4AzZA0MLBE2H1GAievA54zYUuS8tr1ri2fGUv7gOxLen1cQ1W2
 LoWU4jeGn9rbUSLholQ==
X-Proofpoint-ORIG-GUID: fvNnSfnAC9mp_V-dVAMU5fDwGNFKrfC3
X-Proofpoint-GUID: SWoglV9uMmL2toe3TsugYA7LprriscG8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NiBTYWx0ZWRfX0QBFfQL2jtUS
 JsxObfYTvJD26y44tjdenXeof9QcYc0K3Qh5sTQ2XFmRVPBBXALLKbPXBqxrxur20adTdmgttqz
 ArBbDSwbx4/zWQOWonZZ5aA0urG0ZKQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250076

Mingming Cao <mmc@linux.ibm.com> writes:

> out_free_buffer_pools reuses open()'s loop index for the TX LTB
> walk. After the pool unwind i is -1, so the TX buffers allocated
> earlier are leaked. request_irq() failure has the same leak.
>
> The TX-fail goto on that walk also skips dma_unmap of the filter
> list (pre-existing since the LTB was added). Rewrite the TX walk
> to real_num_tx_queues with a pointer check, and unmap the filter
> list before those frees.
>
> Fixes: d926793c1de9 ("ibmveth: Implement multi queue on xmit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmveth.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 3e44f6b714d4..abebdb1fc262 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -553,10 +553,15 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
>  
>  static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
>  {
> +	void *ptr = adapter->tx_ltb_ptr[idx];
> +
> +	if (!ptr)
> +		return;
> +
> +	adapter->tx_ltb_ptr[idx] = NULL;
>  	dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
>  			 adapter->tx_ltb_size, DMA_TO_DEVICE);
> -	kfree(adapter->tx_ltb_ptr[idx]);
> -	adapter->tx_ltb_ptr[idx] = NULL;
> +	kfree(ptr);
>  }
>  
>  static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
> @@ -667,7 +672,7 @@ static int ibmveth_open(struct net_device *netdev)
>  
>  	for (i = 0; i < netdev->real_num_tx_queues; i++) {
>  		if (ibmveth_allocate_tx_ltb(adapter, i))
> -			goto out_free_tx_ltb;
> +			goto out_unmap_filter_list;
>  	}
>  
>  	adapter->rx_queue.index = 0;
> @@ -745,10 +750,8 @@ static int ibmveth_open(struct net_device *netdev)
>  	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
>  			 DMA_BIDIRECTIONAL);
>  
> -out_free_tx_ltb:
> -	while (--i >= 0) {
> +	for (i = netdev->real_num_tx_queues - 1; i >= 0; i--)
>  		ibmveth_free_tx_ltb(adapter, i);
> -	}
>  
>  out_unmap_buffer_list:
>  	dma_unmap_single(dev, adapter->buffer_list_dma, 4096,

Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
