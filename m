Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354769;
	b=IVeJoTFM17955B4tpw8UqkE+AIkIZ4NxuDgNQbTaDd6cw5/T5zBMJS8C9ggARmMLck4e
	 aYBKW0PpjaO2FxtFUf12HwvOea3DYGQNpHOlHR+CHs7yR8xsaY2zmU0xClh6D+ncxJ9p9
	 e1eTP5AXYZ1POvlaaULV3EfzO3QUGOD/lEwNQczqgr1Cczc4Tz2NmuowBvayIBbZ7JkQb
	 tsn5Go6QoQg2QTqYGGeAEogHPA3hV/34syIztSCG1TvCSDmsxNxKGkQEqEJ5J/6RE/ADD
	 iTvMdFAoTai4EdRkTzVY83PYF0tt7GfyKshtaC5AMbVFG79ArEPkxBOvOzCf+dGS1sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354769;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KJvd9X7CGBBAYwdJxi1ObIT0ORbV+sgmz6LZHvUCBOY=;
	b=rM0J7mZ8vRB2ffI+2T+CGhGtkWH94txt+lq5ltYVmv6TYFxeUroI0zvHEBEIPAHMbecp
	 hmXWponhfGGy1jpHno0wa47y3UAuXPpcQ4HBOIwfJyw6Q2HQ4bxsnAc3KtzPVrUXw7Fcf
	 cbzrls5FjpanAkl1dhd1ef41bnXuOP97RWe0TAnoWFYHnFdPlMBah4Bmxe/6eARFNUY0p
	 ZbGyIHgQ44OmnpuGhI0wDQyJyu7l5DiSCjQW8ZHZ9sV7ryuN3yqH1avu24KrSwmL79GfF
	 Hb5yI5+yvqPinEF7yVFkxKzIzNq5XUmEPyOY3TdbGhtll04HuaCjpigZju895fvSKMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ud7qH3Mc;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E1E606A31A;
	Fri, 30 Oct 2026 10:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E1E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ud7qH3Mc
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8EQXv2593967;
	Fri, 30 Oct 2026 10:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KJvd9X
	7CGBBAYwdJxi1ObIT0ORbV+sgmz6LZHvUCBOY=; b=Ud7qH3McojpWetJtKt/CHr
	QySbdD+6mTMgpgn6h7CGoLItuCmjGijxSF8rQPaT591K/RU4aYEIa7Pieqbg3iVU
	IvNzNMWBiahZoaLdjLVVXE1wBofKp0imKZmOaYgSM5ivXCj3l61Qw1IJLxzmcuOM
	Yj54C2NhZf2joiDSRDH+fJhFoBPPd8dFMv5W6d6KbULrocbXwTZWED7m0jKJUDn2
	IJ4I8J3SVDT9s676nu7IuyW20tHFS548w2gONv//gZTOxhAt5oLw+WNGqyHt9aIw
	mhMtX8cwRC4ZtIp04sHa/DxsaTjBlYpMFK4Y+U8UBhDJBfL3GEBSLy6u6in6EBYw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hmeay254t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 10:05:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8JwfS173818;
	Fri, 30 Oct 2026 10:05:56 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hm8qpbcgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 10:05:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69UA5uZO19858082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Oct 2026 10:05:56 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20B8C5805F;
	Fri, 30 Oct 2026 10:05:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BC7858043;
	Fri, 30 Oct 2026 10:05:53 +0000 (GMT)
Received: from [9.61.35.48] (unknown [9.61.35.48])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Oct 2026 10:05:52 +0000 (GMT)
Message-ID: <6a7fc1f1-18eb-44e6-ba19-5e9f047ec0ae@linux.ibm.com>
Date: Fri, 30 Oct 2026 15:35:50 +0530
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
Subject: Re: [PATCH v2] nvme-rdma: fix NULL queue->ctrl dereference on
 reconnect
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
        linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        sgogte@purestorage.com, hare@kernel.org, wagi@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261029141957.2068907-1-christian.aurichzm@gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261029141957.2068907-1-christian.aurichzm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzOCBTYWx0ZWRfX72TIqzX+7eDV
 9wmtan1BP2x5Itxra9ezD2UbEuFO2WB4vQId4Tu4yV23cxM2/m6RSmrnJ9aWS9UiSXTxHKSqD6Q
 DTE70y+jukp1Hgvl+JwOnmGFafjBSrFyNQobVku+VTOwAkcawvLmIV9IMUpNUD36htJNl1AQOmW
 +6GvCR/GD/QH+VzG2iiM+2GomKW4hkvV0ZKIEWyfGltyPWObGeEKABeEqN/HmIZLInl3XLLhA+C
 ahx1JU6bAHUo/3yLfAXYOTYNU8RpBMvNmP/CazaEDGBahq8WKDP2XTXzmSZ/XaGMMMlzyuJxpcY
 2YO8BR/qOwqjwMGrwZcUyV4WUnVP5NsZjOnTworgJc+lrocCUCYTFmxY/YPLv+5idqGiqHKTChn
 MeloBQ0qeMHk6DWh4njPFtG2mT/yJ/u3uLRIrIVZTIK1bR7XM/cfsDADnqhUunwQHKYbeaiY25h
 zKizVbhYRMgnL+jifdg==
X-Authority-Analysis: v=2.4 cv=WJHqzXsR c=1 sm=1 tr=0 ts=6ae46c06 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=9rIU1ZvYCPAAgNib5K8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: L1YOsaCs9DcJJ0aiZVSNFhRe0C38QNwO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzOCBTYWx0ZWRfXy+S9FvW1IDFC
 M1x0XXAlsQaGqi/Izhv1Q8Ag86/46l/KNLAk7qv9kl8aaF9JaGr99kx7YoSU0431btMyQPPpBgk
 NFp8xLOmlp7tn96J091tf4lGGI+w8zU=
X-Proofpoint-GUID: IJm7ybWfH7Y_s-lapEvvbXpZhg7i15Qx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300038

On 10/29/26 7:49 PM, Christian Aurich Zanettini Martins wrote:
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
> Set queue->ctrl for every queue when allocating the controller. Such
> requests are then requeued like on any other queue that is not live.
> 
> Fixes: 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation and startup")
> Cc:stable@vger.kernel.org
> Signed-off-by: Christian Aurich Zanettini Martins<christian.aurichzm@gmail.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
