Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8382139E6FD;
	Fri, 25 Sep 2026 19:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362899; cv=none; b=AvTpxVCHwErnKpFX91DGikGXcBgE52JmOJtS1svDquZ2z360m8P6QHUT11zP45zGaOQrPUi06nbAKwQ2l4Aizepmhd3zAU6UpyXeuRTT2S4tDVJFMJZIRavfez73LJ0Gp8a5BqjtaK74qSkwgHyX1QMW0pjouOyBm0ykc7ROos0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362899; c=relaxed/simple;
	bh=sqU0iif12XiM62ixih9RBc/XbwgVQ/Zdec13s0MDkaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t8Ix6T80WZEdCfNnj+1/hkVE3v8prbHAdRI8kyA37TbFl2YCiBwkRp5YdocQscBm5t8pUhef8ekO49mOIMvelQqm7ghBcrBto+96BG4wEUjnSv4wcvUdxoKF4Z/qmo5+ZmeTRGMxAD/mx+W2zAXUsxq7Dr4F2ahB2eWwsk/Fn6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DYa2SgL/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DYa2SgL/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG6EWv1530717;
	Fri, 25 Sep 2026 19:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hTaIxdftBS9s0aKtIe/SSscDfRnX/q
	76Myl7Mmq25ss=; b=DYa2SgL/eOXaft9FS8tWNxhcCZhx/ykZHGjqcRJxmDipfF
	308MfT3b5Q4m3lCmDYWC97SAPRZT9mrR0tiUmGMT2VyaiM1GTigy3vB6EryyH7Cg
	2of4Ec0q1RP7pCfxBRLhPe9WKsEajk8Q+WZQZClEE2DdB3cVOZLcbgM6ArDjkxU8
	CtusPfPoTDYRxSe30LsA1QraGg+XAoOhzwsD/zqDVamZ3CJA+c+344lV0n7vWxhB
	JaJuccviAUPMJOC2E8bQ59x1P2PeSp2QJ6cIwp2jeBrQw1BXCR3spjA/xvTXt/Ge
	VlNvfDgw/90IPRI8VoGa5TwcYcWwO4Cmb51d9G0g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg30v3t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 19:01:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PIm0ee3043817;
	Fri, 25 Sep 2026 19:01:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7efva0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 19:01:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PJ153g14811792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 19:01:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE0DA5805D;
	Fri, 25 Sep 2026 19:01:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00F445805F;
	Fri, 25 Sep 2026 19:01:05 +0000 (GMT)
Received: from d (unknown [9.16.59.154])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 25 Sep 2026 19:01:04 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] ibmveth: h_free logical LAN on open-fail after
 register
In-Reply-To: <7a56fbfb9e0674f011f4e310fbd7dfd8e67c30aa.1790357373.git.mmc@linux.ibm.com>
	(Mingming Cao's message of "Fri, 25 Sep 2026 11:05:29 -0700")
References: <cover.1790357373.git.mmc@linux.ibm.com>
	<7a56fbfb9e0674f011f4e310fbd7dfd8e67c30aa.1790357373.git.mmc@linux.ibm.com>
Date: Fri, 25 Sep 2026 14:01:04 -0500
Message-ID: <87jyo917gv.fsf@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: IoX1rp9zmChx61FOk3tzdZ8-hN9d_gfH
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab6c4f5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=Upk1lBxnHq3MJdZ7FDEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfXywonysU5zfCl
 0sykjRxg7qtMqIiYwklJKwSB/MpbN3jYfpMgms8Y9O46lfmVAzd9AvQOX7Qi5hvzb8rtobPB3ES
 W2x+Oa0XoeaXspujRvYlAEgGiCOXlgFLCQS3uAMEB/WDHfupxkUToiO9Wbz4N05OBEaLV3svru5
 uzwSzgcG5oyNw3JlwS7mSUv/0WYmSJYjkuxNYfbCls5YDOflHacMnqbxi9n6/3fKfVwX6AQSZ/H
 sYUorrPZdgyQgkV3brzpXQxLyOwxKClgr9t2HYERLtlEnq7a408PEeortIQAcCLCpDICp08USMD
 17UzD5QhcVxViMTlP8dq7x5hMmG47TkZKYTyatOSRcIuCnSJYbYBeEFbBufiOj9dQeB63tfjfbT
 01yzuMOKKRvIS5mXhNVELm+/dt7yGccsXLsgv5XZ105XDxGNHR+kb+ckYfvmrkrS3L56LxHs10j
 bPP9yJ03ph/lCG+1YBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX7mB07K0ioE+s
 sLP3T0Mg8xAn+oCArh1x3YiyFYzUSgBXQY8DFL8Px0KCsn7IEFY/RCCKpVbWQdlbvxMXXA8vxFu
 yA3BbCvE/GL/yAbEu80yD/nuDTgqCy4=
X-Proofpoint-GUID: qHkBE4jgKkgIzDOukAyAkToDtDL2AHj0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250074

Mingming Cao <mmc@linux.ibm.com> writes:

> ibmveth_open() registers the logical LAN, then allocates the RX
> buffer pools. A pool failure jumps to out_free_buffer_pools without
> h_free_logical_lan(), so PHYP still owns the buffer-list page when
> it is unmapped. request_irq() failure already issued the hypercall
> before taking the same label.
>
> Move that h_free to the shared post-register unwind so both paths
> deregister before the buffer list is unmapped.
>
> Fixes: d43732ce021f ("ibmveth: properly unwind on init errors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmveth.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 73e051d26b9d..3e44f6b714d4 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -718,10 +718,6 @@ static int ibmveth_open(struct net_device *netdev)
>  	if (rc != 0) {
>  		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
>  			   netdev->irq, rc);
> -		do {
> -			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> -		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> -
>  		goto out_free_buffer_pools;
>  	}

This code change is good. But I noticed another thing that's a pretty
minor bug of useless code just after this:

	rc = -ENOMEM;

rc isn't used in that code path after it is set. Is there some reason I
do not understand to have this here?

> @@ -737,6 +733,9 @@ static int ibmveth_open(struct net_device *netdev)
>  	return 0;
>  
>  out_free_buffer_pools:
> +	do {
> +		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> +	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>  	while (--i >= 0) {
>  		if (adapter->rx_buff_pool[i].active)
>  			ibmveth_free_buffer_pool(adapter,

Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
