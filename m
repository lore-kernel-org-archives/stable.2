Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382238;
	b=A48MD6Dzco68ZfMco/j8J7ZDjf53ErH95+h6qRZWNgIvMHcg9lqTTyX6yuuzZZToAIfR
	 qtJzYdJZISWDwG3TgoOc+3X2RLPdW+fE2YWStFg2R/VyfoDe9uwntSYyTtXwHct8b0rFb
	 azjAf9MRqpyunE7BMJQX3eHYDjGc1nzI0L8AAIs8HoXIYGBr2R4tdd5uKI9+1gdHh/D3H
	 f5zBgXrsaPm2S923C8nTKFOlyMs108Sxz3xaE3aE2aAQaGNs10bmVRnTzj/K8U8NE3NJB
	 ansfr8+iYb3tIyGWqJgHmyQVYWamGtBBd8idxIJ+jy04yorOG6QIzBoaEY+ZmJ/+F6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382238;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dmCogxK77f9L99Jbim+9FwtzvMEbyM9QKgF4tLZQJMg=;
	b=RsYE5DUaCJTqTCyxrwcy4qTKpcaFCGNDH5bT1TC97xjv7yQyEKPqC4s5ey9RlK161WS2
	 k+si6tIQHzoJhvLH6ob/Uz39lL1zDHhG9LKaono1EnsvzlclcJOSEnH56MzqhkcYEsken
	 YVdgazkRFUOSSmd4c3xdcENq6fjIzP1avnJrwEOASVbw3HAS7XVSJTA+kRoV0Y2UUiwfR
	 Bsj0maotIxs9S+nPjFXY0+ZT3Td+7fVH2oTteYyV/ludU7y9fV2fIoPxCGIS5zqhK74Vq
	 CPHHAZ1lsnztgDii67Twu8/Pe8OS7J9ClcV2JL/qcT7A6zXUmavxuh9mQ8MUEnLCHPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="dAep/+yC";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E8606A31A;
	Fri, 30 Oct 2026 17:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E24E8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dAep/+yC
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UEi5uY1563939;
	Fri, 30 Oct 2026 17:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dmCogx
	K77f9L99Jbim+9FwtzvMEbyM9QKgF4tLZQJMg=; b=dAep/+yC1vt1r9dWxQ4Uhu
	WwTd2/Q0pcqdTkoMHVBuptXoVV44W1i1TRNx+8XJ0xCSIEitWfKsHlyVw7iEMt52
	E+svu+W4W7dIHB7dsw79p2v28GayTgPZLSHlUmK6C3l/M6OI+oPW+VqeFII29r9/
	iaaMNYS6w1zbOBY5abpY3fyfa9rlZbmzzg/TjELhIyCuWp9fyMsUJeDbbhUgvNK6
	eqRtAVIQ/LUsQsNJRaN5rb2n2gCldExCrZid+g+D++2dnc9gn/SjSGkkBr4f6lQz
	+s75CaAwofc2yN6qBGj1+ywVMS5ZDyf51yiThrLu/kXY1tJyJKPwRsOqTOB4XU+A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hmeay40k2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 17:43:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69UEZ6vq649977;
	Fri, 30 Oct 2026 17:43:42 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hm69e5jyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 17:43:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69UHhgLN32637692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Oct 2026 17:43:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D88A5805F;
	Fri, 30 Oct 2026 17:43:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFA4D58043;
	Fri, 30 Oct 2026 17:43:38 +0000 (GMT)
Received: from [9.61.35.48] (unknown [9.61.35.48])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Oct 2026 17:43:38 +0000 (GMT)
Message-ID: <9574eb9f-050c-4148-a785-11782ada856c@linux.ibm.com>
Date: Fri, 30 Oct 2026 23:13:37 +0530
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
Subject: Re: [PATCH] nvme-tcp: fix use-after-free in nvme_tcp_free_ctrl()
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
        linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@kernel.org, wagi@kernel.org, kanie@linux.alibaba.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261030170151.49844-1-christian.aurichzm@gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261030170151.49844-1-christian.aurichzm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: giY5zcBIL79cCB5buaIlIzQCqJ6eyoQ6
X-Proofpoint-GUID: EnmkZ-YXCTJk_MOYnOkq82nA2_Uz5YST
X-Authority-Analysis: v=2.4 cv=eZyo7LEH c=1 sm=1 tr=0 ts=6ae4d74f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=vwH2LiGPTe3qxVmh5OkA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfXy0WVDTX59TB9
 GgeUx4BBLWPwZt5mB0WO66d9jzvp4nRe+hNN9y+BeSp/ODw5pwzdrJU/fTa8bv0eniFh+H1UtJ/
 9JMzjvBXGW9gWCg72mtHToiiJi44SEA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX+iHEHKvduLgt
 Dnfn+Bd88H4lAhzgeA5vcvaJiPoXRMazyPQoOYwVN56KGK7b8LBpyd1E0cpUVzeyZ018qzNoTxQ
 vg6Igi/aArvlCtw8QtMfa4IXLo5VYMUQCdvTbQmD76lpqVRSQbleDkgQbZG7EIEzSvAjb7Evsux
 aLLugUZ/I1WQnUUd6+NMxpWvxufyWlR1ujGtPV4B++8PxgpeJ5xfEwSxtyysPp2HD2mqZqXZOwA
 kg/rw4bARgfjeqPFgtEI3yzLis92QDeUYL3KgJl2GXHVPqKkDyBhhLLGWIPx4b8JGdOCoQ72wYE
 YEWnxeD5b8vPMS+r0Ik4ZlxmX4YR85A8uxNhBlF3rCzv954MjPnngASf6F9yD7sSMN3ikE7N+Fr
 0zB2XP4vclvuHxe8Kthst1T/AENV/x1iA/TSv/OiLl4HhGTwjp/FdGnQDzLCAaIqkzoBz5CVlSc
 kmVe/4Y0ZoH/PjASeXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300068

On 10/30/26 10:31 PM, Christian Aurich Zanettini Martins wrote:
> nvme_tcp_free_ctrl() reads ctrl->ctrl.opts to know how many queue
> mutexes to destroy. When creating the controller fails,
> nvmf_create_ctrl() frees opts as soon as nvme_tcp_create_ctrl()
> returns, but a concurrent open of the character device can hold the
> last reference to the controller. With CONFIG_DEBUG_KOBJECT_RELEASE,
> which delays the release, every failed connect reads freed memory:
> 
>    BUG: KASAN: slab-use-after-free in nvme_tcp_free_ctrl+0x38b/0x430
>    Read of size 4 at addr ffff888005b93740 by task kworker/2:1/51
> 
> Keep the size of the queue array in the controller and use it instead.
> 
> Fixes: 2eeeaa9c1ff0 ("nvme-tcp: Validate the queue state under the queue lock in the address attribute")
> Cc:stable@vger.kernel.org
> Signed-off-by: Christian Aurich Zanettini Martins<christian.aurichzm@gmail.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
