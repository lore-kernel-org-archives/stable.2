Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798373;
	b=pTnRw971KtEDbAaSHweVNLuTbBxZmT+zr9//QWu50WQQXy2H19kjsm49z2aarpFygbSI
	 2iL8dSW6qltMnTyjml0j61i8Jr9vqK1ZkL45UYN898u/8W4kvCnL741zAI7rZ9YJml/Ym
	 9J9D+mk4xn0Kx4p4kI/rz2gvSTZkndkM5Z6OTBiCk2sntUo2/pFLCRmB0DUAd3lsW6Zj5
	 QdulFIuzyrrh8nAC1TYr5sxA8tZO+wgCDdW8F02xLsRGjKPrUATjUARgvvJsR5SOzCAZp
	 sceKJP0RZsj+OHtu6niZBRvshLRBtU/SHN/Sje9R3okEVKOrmzUFgFLaQgRy2xodh7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798373;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4+D72ZGnOYeg3JgvyKRWjG246AMTaMP3Wh33QlUCGLc=;
	b=0OdYpzP3sVy2JZfEcOsFciH8tYm7xyPMGKYQDvsjqM+YytbZWMbf9X6jM4BPRtS6zmxY
	 QKP0bGrBT58KyxDPf0pgKzw5zB+owH3+VBHDTXK1oQ+FIsKbHTLDwBR++VzNAcaqPQeyF
	 9umdSocriPg7i2LMlqIkD7EKPp7Z3s8l8nsx/GsnzBrjzu4cvqsPp7WGZQQKYnSMa3H3E
	 WYa5bHASYvykqwBtBilj9qt3qUrR+Lq+rpoQbgJpVITke8Ma4tAlVHYoBhWFo+84EVIcQ
	 wAj+uXCeooHooNyAMwk9pafxXOYPNGUDSHOi4BvSKyzkUJhMlmJp5jN3xJR6whVVy3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i33jluZm;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B99606A328;
	Wed,  4 Nov 2026 13:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54B99606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i33jluZm
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BiAQD387941;
	Wed, 4 Nov 2026 13:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4+D72Z
	GnOYeg3JgvyKRWjG246AMTaMP3Wh33QlUCGLc=; b=i33jluZmtwJp8XECYN6lRQ
	2zS9E9taWmUtBs5nUmNz/XrEKY68DPgqkcvxTkbBjj/FXkvfUaikq/fxK7UBt+NN
	6KnY1jFP4F155GPBJ1vXaiAwrwlsXZgV+xh1zuDkYvzw57s9OknzcAaGDsK44OiN
	5ItPbe1mPJPnBBqk4MKrm4WWQok7SM+bAflsdsOnIZNGenYfQdVp36wQxo/xXitQ
	2Ut6TdPHro6HN+eDB2x4WsjgFDX8FQE8sAHEDvrHlnc8dBpxKQ30EeTlurLyzP2C
	Ha2RHi005HFzpikfxLjiXZOTq3C0Xj3fV31YmjE8L46IY8EKH1lQdYsoi2/kh3UA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rhuv7j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 13:19:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Balm84062157;
	Wed, 4 Nov 2026 13:19:21 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqbqkefy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 13:19:21 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A4DJL3s21889762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 13:19:21 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 404AE58062;
	Wed,  4 Nov 2026 13:19:21 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 644ED58059;
	Wed,  4 Nov 2026 13:19:17 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Nov 2026 13:19:17 +0000 (GMT)
Message-ID: <b7d03393-79a1-4457-8ddf-e0d141e4b3e9@linux.ibm.com>
Date: Wed, 4 Nov 2026 18:49:15 +0530
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
Subject: Re: [PATCH] blk-mq: take quiesce_lock when removing a queue from the
 tag set
To: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
        Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tz2294@columbia.edu,
        stable@vger.kernel.org
References: <20261103-blk-mq-del-quiesce-lock-v1-1-04aa29a481f6@columbia.edu>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261103-blk-mq-del-quiesce-lock-v1-1-04aa29a481f6@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: yHopyXxG2KnqN6PjutsKsE1_p2on7WHV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MiBTYWx0ZWRfXx2fpEmoNN6xp
 1qdrW7KCZA7vcH9Zkk1fZy5meBlUD/o9ogSbTIKauInuBzHHoZoleN6GOf4VT0JE+kstOaQOt87
 Z9H6JE1fatrYpShmUXyQH99LxP1FRBM=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6aeb30da cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=FgAr1SJcMogouSPLcIcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MiBTYWx0ZWRfX91SMM+KJLtSN
 krkm9/h6fySwsNIzJkPdki/YeAkmQFb37Hn/m799UenZxx5A7/xaPYTN+9DDJdAnBWcSxN2izw9
 67OlIIadb0IUFAcnTu9PJt3RVzGaXiCVVdJZR+WPqOHz+k7j/PP5TiC2+BH9eSB3G8BAXYt3LA8
 l0PEp5zs5cw1bA620V3sWqoDaQDAySJKWiwlEoBrdDT3koB4Je3Xpc5pJtxK+xIU+hYdaz6YteE
 lWVIFYFQRDuMduCKQ9XnqzBiuvh7FkdA44VKMF3YNgflfBSYLoLX6iy+10VLWtNpZmU7NNlP7oz
 1fS8pjrSco10GJsdWMdYueuwWKW9ziWCT7megbTtif50uplIKly2sjW1JmjntoW+ylFq+dD/sVy
 0xoy7dEyDYBDpanhdDo3ESAZFF5KalsIsxhhlyaqbQGvucRTZvPTTFZsJ+JoCID7h4oGrRqPey4
 LIyC94HWm3ZnuQta7zw==
X-Proofpoint-GUID: UmIB34rF3dfuLEJNp3TqAXQpd7ra9AZz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040052

On 11/4/26 12:34 AM, Mani Tofigh via B4 Relay wrote:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5ae22d556540..54ccfc43c27c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4354,7 +4354,10 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>   
>   	lockdep_assert_held(&set->tag_list_lock);
>   
> +	/* blk_mq_unquiesce_tagset() runs the hctxs, which are not RCU freed */
> +	spin_lock(&set->quiesce_lock);
>   	list_del_rcu(&q->tag_set_list);
> +	spin_unlock(&set->quiesce_lock);
>   	if (list_is_singular(&set->tag_list)) {
>   		/* just transitioned to unshared */
>   		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;

Now that set->quiesce_lock serializes both traversal of set->tag_list
in blk_mq_[un]quiesce_tagset() as well as modifications in
blk_mq_[add|del]_queue_tag_set(), do we still need RCU protection for
this list?

Assuming there are no other lockless readers of set->tag_list, could we
use regular list operations in blk_mq_[add|del]_queue_tag_set() and remove
the RCU read-side critical sections from blk_mq_[un]quiesce_tagset()?

Thanks,
--Nilay
