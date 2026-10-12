Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4980446C00;
	Mon, 12 Oct 2026 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793587; cv=none; b=VSiSo7vYFjHtBWdiwPD1H3vOnw635QPIIJg3yUf1XxuT6A9MJOS2HY/TV/Q7tOsa0aXZ13zuGmptRtGpOxIYZFcg7MGP/1gec9krA7BwPTX65idnbbrXe1E1kh79NU3UmhxwS9HYf6jiD1pJi1jJU7CBAsmT3OOXA/P80Gf66fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793587; c=relaxed/simple;
	bh=uTGExs3kULdIbyMdWoKvXjVNc5Hw27I3W5SvGXJSCBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcIi4OEl1S/RjfIZ/h7y0zihInHmcZk7jcYiNUWVGV9n/YKucjQluBDr9svLfhq6Htcylk0MeaL1HsVVnC98XfUxA8g5IiMuhDFqyMYVZhsSkiKFrQ9A8pTRYTx+wOzGshv6LMxbcEujdsX6kbfb5QIwRFNO2X9qDPhZ8LHAO/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HRZ7ic2k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HRZ7ic2k"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5EtSo3566222;
	Mon, 12 Oct 2026 08:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/CsAHV
	V7wIz75xaHKMcYPMKlWO5lfc8tcMIl3MXOIzU=; b=HRZ7ic2kVtXfGhTSNxhE8j
	lACuXBkp8A7sDH2HOu77UVtAPrFbP1QYQjaW12lp1y3hR29UiM8lYrR2F3VH5ppt
	go3TISjPokxvr/jHqIgJ14nQzSQ8wAabUhcHVfQUYxACuUURuAJa5JJiSbHhCwwb
	DhmshzqxShrEUouZC8r1dDhiPY5xlvF8qEOcWqUbqCdPl0DQ95kG20oDt56pQl88
	WEZI3YA3rkosmyMUdxTr+1/I33We70jJAw8cmILdDG39Q1teBlfIaVZQ+A8+jTqH
	JTk8x9YPEP/EMhnMxMvvKE+B7sN//+TlqSAKW1eLr/QILx98hWEnvliOyLfrjcqQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug7x1p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:26:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8JxsR964540;
	Mon, 12 Oct 2026 08:26:18 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppmg3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:26:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C8QI1818416134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 08:26:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DCB45805B;
	Mon, 12 Oct 2026 08:26:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3FCA58059;
	Mon, 12 Oct 2026 08:26:15 +0000 (GMT)
Received: from [9.61.185.118] (unknown [9.61.185.118])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 08:26:15 +0000 (GMT)
Message-ID: <0c3a6b07-b6ca-4ef2-abcd-6b4e5a5c3fbe@linux.ibm.com>
Date: Mon, 12 Oct 2026 13:56:14 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't quiesce the queue when setting the default
 elevator
To: Qiliang Yuan <odys.yuan@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20261001-bug-block-elevator-init-quiesce-v1-1-5c85fa0ec59b@gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261001-bug-block-elevator-init-quiesce-v1-1-5c85fa0ec59b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acc99ac cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=6xKE9iGDAtwx3dwle_cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fEyHqStj6MB8fjQoHm2POadY9GYtVjze
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX6AZDXQACvPLo
 MJ0ywzl2TxiKrVW4A7AsiFzjwhMKcoGpwi8DqggFF2/ypiv8Jx45DckQhoJkBptVNN5wHD8uRzh
 aECANETmpLqDrP7tSWMmHCbeO2NcPUPq8jtsOX4B5B7Zw/QHNKd8BUeAzMhJXq0wckn03Zwah24
 qIl03D7WZLxJ0AJkCUqaBqUKy4Qi7j6eXHrZLI5rP0qrw6hkMbez/nR+5jusEiZnoi6ehzM5paW
 Haby63HpAW7sx4c3vjXcTdmemi4+SxdJvyQjBPFOCDiEtZJvIpFsXxtlVEOLl5CsxjEqDxPRvHz
 4ma97wXfS9OxkqcRhrnnzfzBGaiWRyKKL50cSEmKtNJ9cha54lSIEpUM+I5nkaH8drzo0xhJBff
 iXET2XGyKpLpq1+ZMRKQ8uNL706ZzeHy/qgtPx5gLs/AyDtK4PYtNimxw42w7HNYRYCk1xcfG1Z
 0kVQ6aY/YSin7vUF+4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfXwYZZD5Yy7K0x
 U3MKznYxv28g5HiseYsmhCBeqPdMHIjyEHAJgZPmnnYDhwSxpKX8oWVPELSPNMO6ugrOSgnDGsV
 1pebeBwNjysFjk+KrjBzN9vxmOT7Yno=
X-Proofpoint-ORIG-GUID: iNNUSd_VMQtGntdRwn789mpakV0IsmA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120032

On 10/1/26 8:40 AM, Qiliang Yuan wrote:
> elevator_set_default() runs from blk_register_queue() while the disk is
> still being added: the block device is not visible yet and uevents are
> suppressed, so no file system I/O can be issued. elevator_change()
> freezes the queue and cancels the dispatch work before switching, which
> is enough to drain dispatch activity from passthrough requests, as the
> comment in elevator_change() already states.
> 
> elevator_switch() still quiesces the queue unconditionally, though, so
> every disk added with a default elevator waits for an RCU grace period.
> Commit 245a489e81e1 ("block: avoid to quiesce queue in
> elevator_init_mq") had removed this wait from the default elevator
> setup, and it came back when that setup was folded into
> elevator_change().
> 
> The wait is paid in full by callers that add disks one at a time. ublk
> adds the disk of a single-queue device from START_DEV, which takes 7.7ms
> at p50 in a 16 vCPU KVM guest, most of it in blk_mq_quiesce_queue()
> called from elevator_set_default().
> 
> Skip quiescing in elevator_switch() when setting the default elevator.
> 
> ublk null target, 1000 single-queue devices created one by one:
> 
>                       before      after
>    START_DEV p50      7.74ms     0.68ms
>    START_DEV p99     14.61ms     1.32ms
>    devices/s             114        971
> 
> Fixes: 1e44bedbc921 ("block: unifying elevator change")
> Cc:stable@vger.kernel.org
> Signed-off-by: Qiliang Yuan<odys.yuan@gmail.com>
> ---
>   block/elevator.c | 7 +++++--
>   block/elevator.h | 2 ++
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 2161b6eea680c..da9ba70ac9321 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -573,7 +573,8 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
>   			return -EINVAL;
>   	}
>   
> -	blk_mq_quiesce_queue(q);
> +	if (!ctx->no_quiesce)
> +		blk_mq_quiesce_queue(q);
>   
>   	if (q->elevator) {
>   		ctx->old = q->elevator;
> @@ -594,7 +595,8 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
>   	blk_add_trace_msg(q, "elv switch: %s", ctx->name);
>   
>   out_unfreeze:
> -	blk_mq_unquiesce_queue(q);
> +	if (!ctx->no_quiesce)
> +		blk_mq_unquiesce_queue(q);
>   
One minor nit: Since we only unquiesce the queue at the out_unfreeze label,
could you rename it to out_unquiesce while you're at it? I realize this label
predates your change, but the new name would better reflect what happens there.

Otherwise, this change looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


