Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270516;
	b=nihAacdSBBSnMuptrqQqKyv+EWHQNBwl8DZMRlAWNewm2TumySPqXfdqjj4RFRRhLNbB
	 atIEUkgqLEJKDgzBox5eQ9Um+nPL2/PHSxEaVn1psoeHdEDgvpRVIcpkUwMSGb+/K3uW3
	 n0b1AwbR5/vqYYSBbxvVf6KbBWcfRPIVxi6JHrdOxFEoVxiaqWi2xsX8Q7yuajtsZrWE4
	 c/2Mb9dU/e+quq5EQp2JasjEdYKL+9jGs++HT4TRD+ObpVOPGqaKdgm9euTJxEqW+OTyK
	 c/NPcnKxB1cJtoczuGUajNZShAjEogq0B3H6SYx2NxFqN9qlVk1+jDXUvkRCka5fgmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270516;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=d8x5uWHxtG/xXNuHXD0smUyEyyZkUS1PZfI9e9L/g9c=;
	b=UXidPMbtDLOag8kTWUb+QqDoAcBDJJy1Bw4ZBpfHTkIdjPuIKOlOVnRFC0iQ3SrZOeUI
	 DOqcVGvwNmK1RgRroCZuEazRx/G8x3EBBQhhxqKoYvEUoIvrEE6c9Xz0UJHGpa9ZQe+hq
	 bS3/TEGXoPYtDH+VVZr5rNlYnoM3dqEVfD5F97R15+y5Gg3fadA5oSBbHTzhxByJ3KN7S
	 jHb8+MeyveYYp5tVpLHynzO2WTkhRCT25aVblRoR+4SgPwGqerbZZZ3PGwf9iCG02jS//
	 ifzJqMOlcvPrkZ2XsRlDfVPyZKUjfJH++iJa4FONH0ADgo1n0YH66W0HXYb14xmCoGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZtBlPnJY;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50508606A31A;
	Thu, 29 Oct 2026 10:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50508606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZtBlPnJY
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T9EB713962747;
	Thu, 29 Oct 2026 10:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d8x5uW
	HxtG/xXNuHXD0smUyEyyZkUS1PZfI9e9L/g9c=; b=ZtBlPnJYdJThAQad3dOlR4
	VnN15Av5gIDm4YaCoEDpxx07GGc6m3+dX2ExU/C7uFWB/O/IdQd9M0vumoRGOhdf
	KggsKXnHS290SQVfB9atBh6fcQIQ6Rdc08/+624tVa3FDE0rSspmaVzWTI3Xngag
	Rc6kzujNoxuKM0HsQFT0Me6Pt1EyrPMOdIkL7XKYhVvTtFyZ5Z0FAYNdghv0Uw5L
	gwQvNd+kUZRp+bCFvcb/Y1eNPubJcFEAvDHfzb4plNWkI4k+ZpRsS3hdpvJy6WY1
	SlcMOxV/Jtt6Dlbzepc3zINVcuOst+i4HAGe71743qvdcNRzCHihGW5acJY4ahVw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm649jy7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 10:41:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69T952rO1711831;
	Thu, 29 Oct 2026 10:41:39 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hk010qkv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 10:41:39 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TAfcVc5177888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 10:41:38 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1221F58055;
	Thu, 29 Oct 2026 10:41:38 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6F8458043;
	Thu, 29 Oct 2026 10:41:34 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 10:41:34 +0000 (GMT)
Message-ID: <ef07a928-7f28-4fcd-a1d6-4b566d000374@linux.ibm.com>
Date: Thu, 29 Oct 2026 16:11:33 +0530
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
Subject: Re: [PATCH] nvme-rdma: fix NULL queue->ctrl dereference on reconnect
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
        linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        sgogte@purestorage.com, hare@kernel.org, wagi@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261029060521.1690223-1-christian.aurichzm@gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261029060521.1690223-1-christian.aurichzm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzOSBTYWx0ZWRfXwc9RbBdFEHUg
 YY+gUpbuxLyJinBYj3RIrrcInpKrpSamFqJ1j5pWhijUpybpgdr0JtG+4mVfi5ADqUGjTSuOtva
 AQwoZ+eColIvqmrJWYgQ2xbwHT5vQGc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzOSBTYWx0ZWRfX97KZH7TYjAHA
 NacqSrkaIw1c0mTpOI358FLU8zlAxZMBybhmW2dLcKnUyCY6uMQ/a6mCcFYEddaEghLrNbV0QYe
 VfQsChEf8OdK5stos46u+0M5jK/Gyubh0mdOOt7pMG1FmTl1jH2FK0vayKCOSJxQBWv2ScjUPx1
 u5dwbM97vQAPWFehdBTh8URmhwxbFEYXdmPZeSCBzD0bLdr9ZHIk2CQ2yQ+x9MFGgYDOXAmg/xH
 LC8Vi1XuFprrXqUcxZl6ZjUoh/P8FpyzS0IYO6sRRanSnIc3PtO3lXjAc7OO5DzdmOHpznPEq4A
 8cnSiDpYaumaa8tjLMahYpNRnhJZ34r2ncj4XL8trpTaEwut2Sd0uay2zYc/IVMf1LfgpXw/+Mi
 WR3u8OfBIN6UflmOpwGdvH23nv0s/lvQ4t6pMnx5LC3QPPMJDwhcDDEP7lNZtImnxsrM846PkEy
 bE8YvmUiBeB5LjqrtWQ==
X-Proofpoint-ORIG-GUID: _OirM0llKTWG2z9m8TdgZrBllCJp1yQo
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae322e4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=sM3CkMq7cFP6RC6SvF8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uzYT1M35y3EhHlzBttAm8xPKbDxE950W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290039

On 10/29/26 11:35 AM, Christian Aurich Zanettini Martins wrote:
> Since commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation
> and startup"), a reconnect that gets more I/O queues than before grows
> the tag set before the new queues are set up. queue->ctrl is only set
> by nvme_rdma_setup_io_queues(), so I/O submitted in between reaches
> nvme_rdma_queue_rq() on a queue that was never allocated and
> dereferences a NULL queue->ctrl:
> 
>    BUG: kernel NULL pointer dereference, address: 000000000000034c
>    RIP: 0010:nvme_rdma_queue_rq+0x52/0xb90
> 
> Add nvme_rdma_init_queue() for the queue fields that do not depend on
> the connection and call it for every queue when allocating the
> controller. Such requests are then requeued like on any other queue
> that is not live. queue_lock moves there as well, and
> nvme_rdma_exit_queue() destroys it when the controller is freed.
> 
> Fixes: 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation and startup")
> Cc:stable@vger.kernel.org
> Signed-off-by: Christian Aurich Zanettini Martins<christian.aurichzm@gmail.com>

Looks good to me.
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
