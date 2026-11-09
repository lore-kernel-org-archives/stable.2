Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794222368;
	b=WslDM2mPGPnCQVckkFIyh/kc7bclcHUQHvkS6MfHSCFykjCEw1Zr7qtACZ5GVQ1zdbon
	 VkHVe0Nblt5Rjqf9+cRavzJreG5CwV3CQXqtRSdQzFAmNGIFhktbQ6NeelKUri/SdWc25
	 HqICkyAcbvvRBN1uw4Q+Q2bDrgcm47Ycf9H1qATO5k2NIHjwnTHGwQpUUVUVxZS9xMTSP
	 3txOR4/jpYRV+RkKz1JtYi8Yp+AH82qhYnHG0OmAETG5kvofbDdZvCbQe0iHj6p+h5sq6
	 Oq4ppyBnMsQYe3LAMBZt2zOfPqvsbKN1aTPxfT4v8YqYWOiZP/UUA6LSkdD0DjybfiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794222368;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xxg0UqRxYEUrKq/Q8BY+QBId1hBHt/fyVMnZzjc96lI=;
	b=Xn4POvaw+6Yqdr6cODdvgDGXFBJJYKKY6o7vwdVSVoQ0eviyKob/oziqYtPREptryCK7
	 1CVSZHnH/AS75bDUY+4II219ERHPEOI8hoKO5SuTjqM9T0l55RHfshwLz9MRF9PlEh+I3
	 5ozTE/rUqXBJwHr1i3nRvAZGcm6P+TILlR6Yyf4R2kTHO10lSiwtEztg8wK9fZBMk2xqY
	 xhSu6yd2lRf6O8P8pj8rfTMpoPZkC6XpgsvjN1af/p8PfrLnxj8/OfI/P7bFNBrOzk7re
	 Rojetw3lK0LlZaCcu0xmjV9yeJcmKVnL8lPOfe3Gb41HP8TI5txQ/XglDJhqHTy4V6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HH6ZqzdG;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE79606A31C;
	Mon,  9 Nov 2026 11:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADE79606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HH6ZqzdG
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9AE6n03322054;
	Mon, 9 Nov 2026 11:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xxg0Uq
	RxYEUrKq/Q8BY+QBId1hBHt/fyVMnZzjc96lI=; b=HH6ZqzdGOij0KkpSjUG5ud
	1SUNetgDFBKny0B1XE6nHLMEDduwB7fKwN2XrXrF/0eCPakp9S/in2BsvtX1/FR+
	xIDLnCNpmaH7XpiOqCTJ2F05fooxdqeT8uiGobHMTWq5O4gVZJSRPWEjhqLAueXj
	l6QwlfNalYhoO9B48SbrGrPkFIsoQQusGKj4TJnvf3dBsdw69mMuApdwHARn8ssz
	RoXzvIy5uldqC3jaRRZQiIHJN5DAbQ+IpJs8XDUDVBDu0V4gz/YI1UVLpa2wb9v2
	jHvMVvs/jftf3iZn6z6/q6dzC10MOnFtuMx6S45U+RNR1HxKx23ZrdCFG3MGqYTw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug5vn61-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 11:05:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9AJogF4093682;
	Mon, 9 Nov 2026 11:05:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htepvqgm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 11:05:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9B5rop40370818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 11:05:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B3AD58059;
	Mon,  9 Nov 2026 11:05:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0364C58058;
	Mon,  9 Nov 2026 11:05:49 +0000 (GMT)
Received: from [9.61.101.130] (unknown [9.61.101.130])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 11:05:48 +0000 (GMT)
Message-ID: <e562995a-dbde-4c6b-9373-1d47b789adef@linux.ibm.com>
Date: Mon, 9 Nov 2026 16:35:47 +0530
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
Subject: Re: [PATCH v2] blk-mq: take quiesce_lock when removing a queue from
 the tag set
To: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
        Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tz2294@columbia.edu,
        stable@vger.kernel.org
References: <20261106-blk-mq-del-quiesce-lock-v2-1-cd4f72a6eb03@columbia.edu>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261106-blk-mq-del-quiesce-lock-v2-1-cd4f72a6eb03@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: q4ZXlQ6vjS07HfIoR1c6Huw6xN7545dt
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af1a913 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=WTJdmG3rAAAA:8 a=VnNF1IyMAAAA:8 a=npNqatxc2sd5QBqGfiMA:9 a=QEXdDO2ut3YA:10
 a=q3NGepEMMmKWaCv8Sx90:22
X-Proofpoint-GUID: jEaq0M2rO7FPtIYS8bgGuG88Iao1FqLq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0MiBTYWx0ZWRfX3Hkkski1muN8
 kzXY+XPtCyZ8kWHiFOaDaqs2zC0308SvqoiotyXnrEsRxCWA+38Zxbfe4mKgrje/HWTK0gMjXgV
 JA/0KPINRE26VCCkZXZY/6+iflQ+uodCYlbS5NUM0xcPtelpg9hqXQp5gDeOPeNGxZc1O0dxy4p
 gAfU4zOMh6jdlPae/b35BkfKHQqM+FxodbQhEUxjXJYvn819BIgkiWh2+1V2XAOX36GwzjG53GB
 DYxKrqZ+o+4x+O3YjQMq7JdgX8dRIeobd4tK2gnn+db3+kTSOtqMrSCdkJo4PU47yw1FSxjUXTe
 ilFv+N4OcDwnnPPtgdvZivcopYuXvz9NMyK8IsJA54icXGTTP7VaAst/iR0F87wyNT8MouMTCag
 UQTNzaFiawqE38LF5Vq/eXtwO7vFy9y8KLXCUE87jWuY5w8P9eyJtzlg8qgdQ5iDNhb1+bbprd9
 rmobPnRzaOP+02QHEhw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0MiBTYWx0ZWRfXz/GmBHuoY8oW
 Ap73ExYvU9VMwkgBUkLxk+uOZtZmZISPuj9l9pKBnW3uNIrIUDP4NdAToH149fhULd1bDBeIMyk
 uMsQZAEWjkDmRiQMlQAa1ZXOAVTC7BY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090042

On 11/6/26 10:23 PM, Mani Tofigh via B4 Relay wrote:
> From: Mani Tofigh<mt4022@columbia.edu>
> 
> Unquiescing a tag set can run the hw queues of a queue whose hctxs were
> already freed.  blk_mq_unquiesce_tagset() walks the tag set's queues
> under quiesce_lock and rcu_read_lock().  Commit 71ec3c7d6db8 ("blk-mq:
> quiesce a queue that joins a quiesced tag set") added quiesce_lock to
> the walks and to adding a queue, but blk_mq_del_queue_tag_set() still
> removes a queue without it.  The hctxs are then freed right away since
> RCU only keeps the request_queue itself alive:
> 
>    Task A (controller reset)            Task B (namespace removal)
>    blk_mq_unquiesce_tagset()
>      /* finds q */
>                                         blk_mq_del_queue_tag_set(q)
>                                         blk_mq_release(q)
>                                           /* frees the hctxs */
>      blk_mq_run_hw_queues(q)
>        /* reads freed hctxs */
> 
> The window is short.  On PREEMPT_RT quiesce_lock is a sleeping lock and
> the walk can be preempted inside it, which is how it's hit here:
> 
>    [  399.851277] BUG: KASAN: slab-use-after-free in blk_mq_run_hw_queues+0x4bd/0x550
>    [  399.851328] Read of size 8 at addr ff11000003014148 by task kworker/u9:2/116
>    [  399.851352] CPU: 1 UID: 0 PID: 116 Comm: kworker/u9:2 Not tainted 7.3.0-16299-g81cb9aa43246 #1 PREEMPT_RT
>    [  399.851425] Workqueue: nvme-reset-wq nvme_loop_reset_ctrl_work
>    [  399.851441] Call Trace:
>    [  399.851457]  <TASK>
>    [  399.851551]  blk_mq_run_hw_queues+0x4bd/0x550
>    [  399.851564]  blk_mq_unquiesce_tagset+0x128/0x210
>    [  399.851576]  nvme_loop_reset_ctrl_work+0x78/0x4c0
>    [  399.851600]  process_one_work+0x92b/0x16d0
>    [  399.851660]  worker_thread+0x4e6/0xd60
>    [  399.851707]  kthread+0x300/0x3e0
>    [  399.851727]  ret_from_fork+0x4f0/0x6f0
>    [  399.851776]  ret_from_fork_asm+0x1a/0x30
>    [  399.851793]  </TASK>
>    ...
>    [  399.851988] Freed by task 111:
>    [  399.852040]  kfree+0x1b3/0x4b0
>    [  399.852050]  blk_mq_release+0x400/0x550
>    [  399.852060]  blk_put_queue+0x94/0x120
>    [  399.852068]  disk_release+0x1bd/0x3f0
>    [  399.852102]  nvme_free_ns+0x39/0x270
>    [  399.852113]  nvme_remove_nsid_range+0x2d1/0x4a0
>    [  399.852123]  nvme_scan_ns_list+0x2cc/0x390
>    [  399.852134]  nvme_scan_work+0x421/0x9f0
>    ...
> 
> With BLK_CGROUP the disk's root blkg holds the queue until a grace
> period later, which hides this for NVMe namespaces.  It's still open
> without BLK_CGROUP, and from reading the code also for queues freed
> without a disk (e.g., SCSI device queues on a UFS host).
> 
> Take quiesce_lock around the list_del_rcu() as well so that the walk
> either finishes with a queue before it leaves the list or never sees
> it, and say so in the comment of quiesce_lock.  With the fix, KASAN
> doesn't report the use-after-free anymore.
> 
> This bug was identified and confirmed with the help of a deterministic
> hypervisor currently under development.  The C reproducer below however
> hits it about once every 20 minutes on a PREEMPT_RT kernel.
> 
> Fixes: 59e25ef2b413 ("block: Use RCU in blk_mq_[un]quiesce_tagset() instead of set->tag_list_lock")
> Cc:stable@vger.kernel.org
> Reviewed-by: Mohamed Khalfella<mkhalfella@purestorage.com>
> Signed-off-by: Mani Tofigh<mt4022@columbia.edu>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
