Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798798;
	b=WddtrIDp1Sv07G1u/2zAtJz+lP6tzONXcJPClTllD2/STQqzl4TitNZnLJAmu1QMsfU+
	 +Oz0rFsJLvJxlNHdpx5DoJ/O0STpqr/7CrRZX8UUi1IqYEoBOilqyCAPxSzm6GLVX2Xep
	 pr5WMUTFoqAvNqYCNvxNen6UPzd8GRZr9HqiTSYOFvkG3uZiplDNAEDxsliHgY2ehalL5
	 Cb0kzoesMQtQYT/Gubzf2KOlGj4dz5wEQBybxlkVnyAom9P2pcGRf9menvSwvZsdpXJjp
	 xKm7l2FfZAECp97r4cK5jlE4aJNUVPq0ljwHSOQPdwzYtnajxhd0USqXnIrG8jqU7kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798798;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yjmwql2Q0/WWj7I5rUoCbaZQ81/0rY7QHc3z6oUDgjE=;
	b=cEPetTQvzuan5vv/yVjm5W8yARj79YeGLOx3aPJZkScARqvR+qqglUDxC5ne8AJmsjPt
	 Yt4f5gCzCL1QjpYJLNYmDb+8nbbuDnSuiMv4er1FllJmCej7EqBSpdMdThctvqjFd/mnW
	 61TU1aYKygjNJpu3KXhWgr6j+iXpOpfv6K6gqhyO72oIyZQVirG07woUrJccVSSSqMSvP
	 rzOE5prXQR0YnNEL0g1Bp5l1vxzGJmBnGOsx9jw38AtKC6ZeCOEh0rFR5WI3XTtwBCL0f
	 hkBJ4Ox/HefSrknKGgjuMFdvYzutIHYwwyES99bEcusQvRzudnSANQNQlbfH2p37Lyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JHY6z7vu;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902C3606A33A;
	Wed,  4 Nov 2026 13:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 902C3606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JHY6z7vu
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BiAgQ3026253;
	Wed, 4 Nov 2026 13:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yjmwql
	2Q0/WWj7I5rUoCbaZQ81/0rY7QHc3z6oUDgjE=; b=JHY6z7vuCDPfVgknKa7b8y
	Bx9eZ7LN23WYxB/7Hd+1hi+4+s1R61V2JYJE8WCqJ1pmN7+SZ/fRvWFUrt0sXzNb
	BR4bVKUXTeFUCrD8JrHS1tnwAWSASYdECHSSR2EhLIVod4+Dh1WKHo5EiRBVG7Rj
	edEE7CTcsIIo13GgtrAJ0yahYTQgE3yAwCD/jQODWHn6aJZE4ub4tOf0GOCiqNRw
	slQ3zbcextdUzlyyjoTKlN/CjDvcRjJVP27xfikiA+Fww0l12E+LSyMh9xMETuff
	sZTHcmtss8XB/xmeh6LrN259nSJ4KQils7ioMlBs15o1VcWE3YAUBtUccW0pF6nw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80sv0m8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 13:26:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Baj9w3997539;
	Wed, 4 Nov 2026 13:26:13 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqcrce8v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 13:26:13 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A4DQD0Q14942870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 13:26:13 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E42C558061;
	Wed,  4 Nov 2026 13:26:12 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12C1158057;
	Wed,  4 Nov 2026 13:26:09 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Nov 2026 13:26:08 +0000 (GMT)
Message-ID: <c172b7a8-bea1-4004-83be-af6dfe921df0@linux.ibm.com>
Date: Wed, 4 Nov 2026 18:56:07 +0530
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
To: Christoph Hellwig <hch@lst.de>, mt4022@columbia.edu
Cc: Jens Axboe <axboe@kernel.dk>,
        Mohamed Khalfella <mkhalfella@purestorage.com>,
        Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tz2294@columbia.edu,
        stable@vger.kernel.org
References: <20261103-blk-mq-del-quiesce-lock-v1-1-04aa29a481f6@columbia.edu>
 <20261104071926.GA29136@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261104071926.GA29136@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: OL6bJ6XdGfIfN-IE_2nKDKeceYmhD930
X-Proofpoint-ORIG-GUID: kjX0ct8-6NHIu3_iWyRCWMcwoDsr-7ZW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MiBTYWx0ZWRfXwKFBVFCEePT5
 rNCc8CexrDkmhuZK7SJRXcM5SUHKI8IS/QLv/GNZWkGrkpgK6GjzwFLeSu+eGaOiMAz0RDQOAXz
 lydGC02v0dE+dpONYcrH51O8K/N7zMYszUcWGfnUa3wFJKv7jRt2FpgyTJvnblXrj3mDj6sQHmB
 4IMG02DYwsP5v8gXlEf5UpOM4oGqYT5EpAw7PH9qMDN1oZRkSytUlojNbWzQUnftz697NyiTcQN
 e+Mev6zQ1u87scFqLGKfkNz5NZuJNn9PSEgVlDZc6HGW/tsRypf0H2vgXcxkrciqteRAr+4/DGw
 M/nSyuTyeqSdMFmDPh2i19ZEboF5vDIOdFb2pAwsf17iTgEg0uszuqyO3N1pzuWUCGDXXe+rTaO
 6ckxnRMjo2YWwKGLC88Q9WyyrqvLuT8S5xCzemyFqbyF50bcpmb9kDilTp53vh9c0lqqIDLVJqn
 GH5uLipbFU/Jhi++T/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MiBTYWx0ZWRfX/ccD5SVabaSY
 kTLhYnJYNUHqla6dpbi/r8suZKJaxfLjJ1MjA1bUijRJQD7fsPWs/A/81jG8CzSFEx0hgIQwgZq
 3awMjGIASlt6K01/6QjjkqNTOrMspfI=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6aeb3276 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=DfyN0UfllRvmPPNdMxQA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040052

On 11/4/26 12:49 PM, Christoph Hellwig wrote:
> Looks good, but the note from Mohamed should be taken into account.
> 
> Or even better add a guarded_by so that clang catches this (requires
> actualy compile testing with clang, though).
> 
Yeah agreed! I also recommend adding __guarded_by() annotation around
set->tag_list and set->quiesce_depth.

With this change, I have sorted following locking pattern:

1. Every set->tag_list mutation holds both set->tag_list_lock and set->quiesce_lock.
2. Every set->tag_list traversal holds at least one of set->tag_list_lock or set->quiesce_lock.
3. The set->tag_list_lock and set->quiesce_lock order is preserved.

So the above scheme fits really well in the context annotations.

We can define context annotation as follows:

struct blk_mq_tag_set {
     ...
     struct list_head    tag_list __guarded_by(&tag_list_lock, &quiesce_lock);
     unsigned int        quiesce_depth __guarded_by(&quiesce_lock);
     ...
}

Thanks,
--Nilay
