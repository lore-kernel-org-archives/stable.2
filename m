Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023742;
	b=DH9Gy7uNQa10AymfAEY8KJ+wUmE2n3pidH/np3K02/sDFLJeA8ADmCm5KkFDHbL3HkPx
	 qI7ETAsLHoN7qSKgfeSaQShoqUkapMdrlDUAwpumbjAzLK8W5/wK7JzdugzZRhYF7XZAz
	 mF/E0hS3UxS5zRxPS0/NAKPKzzM6Axx85oOC8NrPDzxCxleIQyCyjAQFqFZyvIy7BHo2g
	 65isaNL/hiPY66Mt61b4RXD1ptNTWl9GGS3xnhpFCQVLn3SzFaNB7Lz/3z/qyAcg+5Geb
	 qFGZdZ4eF33nRw60d97llxAkvO3+ThEOXg1J8E9vWroiLPVJYDsdN3PAD95Zd3nRHVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023742;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7J5TEpmoE5beJcy8Otv5EIPRsPOSaQ/2UrXxHqm/wYU=;
	b=1lYFgexiVkee4CwvWo8UrVqHYqo/FsNRXWTr7+C5f5u56tlQpbztXVjGoPQ3Ivdfp9rV
	 WVgC9C7lGJLc0l9EiKu740r6+9eksCNr8Uz7c4Q946eyudkI5+nUT6rLJa1aCDg//proY
	 /Cj20Oy1W1k+62p/mQMwrKBCzbZIe6yhlxO54HJ+0hYD7+DNkie8vGyr59FRiuQKrWUr9
	 61X0XGZ0MP6GhTKnxklyO38PiwY9l3pg3C1Qb9c9smaXocnI+bPutl3/Q53FkuyDoQWWb
	 ejp32f4imN3mjrQHJzkA4TEkEXkYQN+BLPRu0lFISNcnhi2ddfz0OjJTDM6r1PtOuWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ch2mYdtQ;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C5D606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 14:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9C5D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ch2mYdtQ
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QBEv0T3337325;
	Mon, 26 Oct 2026 14:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7J5TEp
	moE5beJcy8Otv5EIPRsPOSaQ/2UrXxHqm/wYU=; b=ch2mYdtQ0t2t1o2mUd/7g0
	S4vKGJJkJrDHRggSA5hYYM5z7Sb6C1aUSo6YRoA5BkqwwyMU4qzmRrr6SDP9szNT
	Sxq5vHuoI9rSu/OMpbtXh8GeTuHPubqWGgJKKE2mMeqnwiVwp/r4bjgO2Lwat641
	bErfnFJq73J53ytT+p5gp0OeP7eiV/X8kPE8cjzjMvNil9zMuxne2IAReMxPC+l+
	YpXwrNLJWninJnb120uSW/pTs8oSDIW9EOcXPadTXI3nRqRbJ9rF9XNVYzqbF8rF
	RGp0AL2gEjfWRYUo33OMg4VH2+CaZE0VVTpGLbjPxEptfp+Qump0QLyQRCK6iFcg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd6tbw5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 14:08:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QB53wQ2397608;
	Mon, 26 Oct 2026 14:08:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh80je8a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 14:08:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69QE8lGv40698270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 14:08:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 863DA20043;
	Mon, 26 Oct 2026 14:08:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6696220040;
	Mon, 26 Oct 2026 14:08:47 +0000 (GMT)
Received: from [9.68.0.195] (unknown [9.68.0.195])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 14:08:47 +0000 (GMT)
Message-ID: <56443275-eb42-4d91-86b3-6c44ef09ab39@linux.ibm.com>
Date: Mon, 26 Oct 2026 15:08:47 +0100
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
Subject: Re: [PATCH 5.10.y] net/iucv: fix the recvmsg window update
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <20261022130935.1228149-1-wintera@linux.ibm.com>
 <2026-10-23-1-daily-reply-0014-iucv-recvmsg-window-5-10-bounce@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <2026-10-23-1-daily-reply-0014-iucv-recvmsg-window-5-10-bounce@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6adf5ef2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=xOCi0-leiLJ98guqT6YA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfXxKstHTmP0WiS
 PGyDcnm1swmipCBX0djtGIEVL58bsqUPFbShPIWpH8klGGsO+mBhLB+MwuulbHilhREfGHUErTX
 /jn3T8IJRulWVg5Jus7z+gf2ttNAzI4QdEhaeuKeleNWDuK30I8ls6/4zJ7NfCZR3pV4HhNbr89
 4LFEqz8NTKdy2hxloko+5zehVvipwDTLOziywzi6nqcdivulb4mUyEdwfA28CJoFqpUBgWgzjdv
 d5ELw5sktty8G3irAgqW9EGU86szFGD7Ywhg7nWtWEVoULbIz9XUwfhvhCU4fFIlHB5vgX0B4lY
 F5re49Lc7iM7Bb6q9LferHxnxTl97Yge8IS2QXtSVZqd1tsIdu36jLKqrb9Yx8FKTElx8o7k90w
 Q9cq2fR4jOvHRNjZL+O10McVs9vG490dPE+rZP2KbcezhEEwi2I1FSMe13UmKKBygjDjOFm6/U+
 oi8UspAv7Jm5Zj/gECg==
X-Proofpoint-GUID: nMfkVIKBgCesyauwCqutBYeNGw7ICHe2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfXzZEBgVKMcGwQ
 o7ae4SLaPt0XW3oci9w8BTWjubSjfOvZEYAuZXq4ulwsjS6P5xrfLRG4Lr7O/j88nahauZmw7PQ
 9y+M/foTxuvZXWIZeCFhqMZPBr3BewY=
X-Proofpoint-ORIG-GUID: nMfkVIKBgCesyauwCqutBYeNGw7ICHe2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260054



On 23.10.26 22:02, Sasha Levin wrote:
>> +	/* Claim the receive credit here, not while building the header: every
>> +	 * way this frame can be dropped has now been ruled out, so the window
>> +	 * is zeroed only for as long as the transmit itself takes.
>> +	 */
>> +	if (flags == AF_IUCV_FLAG_WIN || !flags) {
>> +		confirm_recv = atomic_xchg(&iucv->msg_recv, 0);
>> +		phs_hdr->window = confirm_recv;
>> +		if (confirm_recv)
>> +			phs_hdr->flags = phs_hdr->flags | AF_IUCV_FLAG_WIN;
>> +	}
>>  	__skb_header_release(skb);
>>  	nskb = skb_clone(skb, GFP_ATOMIC);
>>  	if (!nskb) {
> 
> 5.10 still clones the skb in afiucv_hs_send() (it has no skbs_in_xmit
> rework), so this claim runs ahead of a remaining drop path. If
> skb_clone() fails we take err_free and the credit swapped out of msg_recv
> is never returned, so the peer's window credit is lost for good. This also
> hits the sendmsg path (flags == 0). Unpatched 5.10 loses nothing there,
> and the comment about every drop path being ruled out is not true on 5.10.
> 


Thank you Sasha, you are right, I overlooked the error exit.
I propose to change it to:

@@ -261,21 +255,29 @@ static int afiucv_hs_send(struct iucv_message
*imsg, struct sock *sock,
        }
        skb->protocol = cpu_to_be16(ETH_P_AF_IUCV);

+       /* Claim the receive credit here, not while building the header:
+        * to minimize the time the window is zeroed.
+        */
+       if (flags == AF_IUCV_FLAG_WIN || !flags) {
+               confirm_recv = atomic_xchg(&iucv->msg_recv, 0);
+               phs_hdr->window = confirm_recv;
+               if (confirm_recv)
+                       phs_hdr->flags = phs_hdr->flags | AF_IUCV_FLAG_WIN;
+       }
        __skb_header_release(skb);
        nskb = skb_clone(skb, GFP_ATOMIC);
        if (!nskb) {
                err = -ENOMEM;
+               atomic_add(confirm_recv, &iucv->msg_recv);
                goto err_free;
        }

        skb_queue_tail(&iucv->send_skb_q, nskb);
        err = dev_queue_xmit(skb);
        if (net_xmit_eval(err)) {
+               atomic_add(confirm_recv, &iucv->msg_recv);
                skb_unlink(nskb, &iucv->send_skb_q);
                kfree_skb(nskb);
-       } else {
-               atomic_sub(confirm_recv, &iucv->msg_recv);
-               WARN_ON(atomic_read(&iucv->msg_recv) < 0);
        }
        return net_xmit_eval(err);



Let me build and test it and then I will send a v2 to stable (I hope
that is the correct process)

Regards
Alexandra

