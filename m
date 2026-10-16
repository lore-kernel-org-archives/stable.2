Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9558946A5E2
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792147514; cv=none; b=h8Dn/A5e3jQN+VB2LBmxRAUBBhi8aNKzor3lU7Zndjz8nQVOUbywLIW8AYiHZtJ0LsmGKnP5YSpjU0iUYuBZwTD5prtqlYS+LsvSabFNKJ902E5d+ATOUwTXM/Mqu4ZtTLR4lBlydQIUSVPxN7H7SaBFVCyV7mJeTTvSkLPtTeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792147514; c=relaxed/simple;
	bh=za3xPCzkeb/HbtLkfxowaJK9cwklSa6k6bFi2PQWCX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohaJxU10I3fgVDf9kDsDUm5gSO45K3f25+leeDO9Z+l79NlH8cgoAvcCDL72SOJKbuhYOUccImN3Ft7pHwEMybO2rIJYPWF+pKckRmFHJZdT5QV7f6G+EIDuXzvtHFoAl/DmZvnZly541a+DGqlCG5fpD8zv9JWZGJS3XCpimlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cqjC5hWj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JvoiwgQO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cqjC5hWj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JvoiwgQO"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAA2PH942606
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 10:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kXyFb2bWpRvXjn7PnLKNSg4kUzQ9j0D6sJu6sZHfQlA=; b=cqjC5hWjjuUoAN2r
	fUvmguEvQmzjUOru8VPNLlR0Zj/In6bXgvtGRAZaZE8XZUkxH62CRIAs0qVj5Nqy
	dYYzuzBg+munPZgSSPpYXfLVtoOxGrYsAUcUWCDd2AQHE1K3PL7ij4pv/if9XXDx
	pmRslDDUIVc38faPIZEiXeDJK/l5Fwae+R2t5PsDB+bHLPyIyOwBN3BZlCYMUF38
	mhyFamLnXVq7RGzqaxQkYRnz93kxqjtgXcMcjE2DFuoRkES+ndsTN+s8ZJBI1gO4
	dm0R6/cAcRdlsi+2gliSOOK9iX5+InZNJXU725jeoQIsN1PHnBAlk69+Bq0fP4yO
	qvFn7g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhur04ms-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 10:45:12 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-898fe16133eso2315169b3a.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 03:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792147511; x=1792752311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kXyFb2bWpRvXjn7PnLKNSg4kUzQ9j0D6sJu6sZHfQlA=;
        b=JvoiwgQOB3hgsT/JnwYXPvjOW1rmGNrYeO83Nja4qhtyH077p1jPhzZwlDq+T43ykc
         L2X0Tk75+kbjZIwGaUyymbxRqFjkB7kMXSxGoWzxiwNlF6husk8HIX3MX63CKXDPdD4D
         RuB8fNPdiZQtNYP5IpuEmRTkLwNC10qEY/cT01tmiv+QwO95npRz7tHsy4IioTOiXPv1
         CTGFxQ31C9Owo3GSIvwsSlH6JaxRWVJjYa2pNHygKgsvkumHBmm0uP2X137ZvfEFBu/J
         OmGDezasUU2u/mroeGYZGn0fuG9/S8anzt6vZh56lf5mMfm1ywEMi2YmSBW9lLZSxHnZ
         naLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792147511; x=1792752311;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kXyFb2bWpRvXjn7PnLKNSg4kUzQ9j0D6sJu6sZHfQlA=;
        b=QmF3Qb2eH+IpsHXdW6gyxeWfgdhFHC0ObmvOBZfhr60t5DAgdVt2ZsfSJMdFYjW261
         xfPKgvo987IYlrzAfAf8Ep5vtZMrV8TO/MWCb/DIphiAGFtJtYc8CuLtqvlDZjFMfHvn
         cGwK3+IIquBlzE+5AOXNQDF53w/wldwLxXPF3X4I17M1V5RnWkMMBvdT0fLDEQvMV3bM
         mpcEPX6uu4x4LKYJ+QTY7U3LOyHZ4gKVtFskNoRiAnbiR+swUMWsaSQ9phvWU0GC182W
         Ss6Rvpz1Iw5Ne2E90kfJEVrvpHRTorNfTb2TnNx9H3llvPKD5bL17k9GNn33LTkWeYW7
         YRKQ==
X-Forwarded-Encrypted: i=1; AKwUvByC62KdqNItsFT221Q9HCJyVIUqCGVbKeF/g4JNixcnSLgb5UBLuTj9UyChDlpccWXwKfI4RlE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdv028I8Dh9ZGdKOVIIX9i+WlUE5V5CZOr17Kdokq6XdhGiXyt
	+/S+2EvZsusSK8rZImUX4hwejMZXVVkE1M9v3fHCg3EM1cwbzt/S9v6a0gOMnG7cPNO80aQfTTo
	F0m6wkpUkC52kJ+gfuxkS6dJP3w9EfttYiOUCZeNVU2DHehbsPRlPaM/UHDU=
X-Gm-Gg: AYBFou3bpL45I9DvVdKVG+ezfW68b1O8xsIndv+PTVu0viyRetK6IGPzvs1uuP+uq52
	WL4zHg7/BGZuNOXYL5mgOw1xPccyUCiEbgTLPVf+wSCfbf3t8fb7ZsGVqXtNblvs+6IJSbY+/eA
	xjfySnErtgx+u1E986P6xgsQVhtH1Keg29i9p0bPGWTLJX+JOineB3SotG2sP0xS4R4bcjz8yPT
	oWqgO6igPeYF3qvHDJUfYcNmHdmpgclZ+LJuiCS0p33XdtoFM5J7rbjY4iXKsRitDsQdgqbD/+e
	Tr7Z26H/NY/ABoZhvWZhkH124LYEJgyBQIoL42DmYQXjP01eX1HD+4CgYy/V8KbyWUBlfg+xVEp
	v0qCVl6+Ga/XEmI6qsvkrHtoMC78=
X-Received: by 2002:a05:6a00:ac89:b0:89f:3f60:cd81 with SMTP id d2e1a72fcca58-89f3f60dd06mr2297211b3a.51.1792147511385;
        Fri, 16 Oct 2026 03:45:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:ac89:b0:89f:3f60:cd81 with SMTP id d2e1a72fcca58-89f3f60dd06mr2297188b3a.51.1792147510877;
        Fri, 16 Oct 2026 03:45:10 -0700 (PDT)
Received: from [10.239.132.237] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57947fb2sm911384b3a.37.2026.10.16.03.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 03:45:10 -0700 (PDT)
Message-ID: <c02ffaa1-88ad-4fc7-9171-f8eef64f9ea9@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 18:45:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        Eugenio Perez <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260928-virtblk_sync_quiesce-v3-1-a037e6e2fdf5@oss.qualcomm.com>
Content-Language: en-US
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
In-Reply-To: <20260928-virtblk_sync_quiesce-v3-1-a037e6e2fdf5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfXzy5qaTG7uArf
 DxS0lV42s/keK42a5AEGd0zAe/qIzxwGqfk1ar2KjARb+zL/q6P0g7j/NMZsXj+CZLBlvn4Trl/
 i1u1f5TfZv448o4LOn/ve/aUME3yghP/LRxbovzFk0+C16TqpvAnYqN40eC3WnKaRz0z3YWw9zI
 mfvoy2P4qc5QwF9AVXX740z5eJ96fBvM1yetG4qxukfvPiUKsaq/QyDHtFyzO/8XmqtpR7k23Oy
 ulpaQ6WNqZoIcRC9M9vsCCbvi0XtJzohNoctH9HKmt7NYMwqbnQlX3ExPxZwUClBewX36yT3R3s
 aK+KmHrJ028WYCZaaSCcAgaUnxsl0QNMpzFUb2Sd1pwEgt/h4YbFqvhdsST4GatTtI8XdTUKc2Y
 sBEtkrpCT20yLoFVDkndd1Bl/irYFjK43pOgouYhTZhgPFGVwEcao87vDKzKaFQQdPBexnMj/7J
 8gTB0cOOsw4gGGQehMw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX7dzuzQkfpehT
 YJEai8gdRu9FeSeYYs6TR1oUnHACKzkP1UNEuo1mIXfrGZFHtAGCP1Ua9DXofzmb4JmF/Dq18Ap
 pT2wgWgBaqsfec4tHEHxMEYyrtVjXAw=
X-Authority-Analysis: v=2.4 cv=PqsG/AM3 c=1 sm=1 tr=0 ts=6ad20038 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=BM0rjV1Hin7eb0uZrgEA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: bzx8UFPBdW3j2hsb4GsHaqfhPdaWamvv
X-Proofpoint-GUID: bzx8UFPBdW3j2hsb4GsHaqfhPdaWamvv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160042


Gentle reminder on this patch. Any feedback would be appreciated.

On 9/28/2026 7:58 PM, Cong Zhang wrote:
> blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
> blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
> while the flag is clear. It can then be preempted before it gets a
> request. At that time, it has no queue usage reference, so
> blk_mq_freeze_queue() does not wait for it.
> 
> virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
> blk_mq_unfreeze_queue(). A new request can enter the queue. The old
> dispatcher can run again, use its old flag check, get the new request,
> and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
> reset the device, delete the virtqueues, and free vblk->vqs. The old
> dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
> kernel can crash.
> 
> Fix this by using blk_mq_quiesce_queue(), which waits for dispatch code
> that was already running. Keep the existing freeze and unfreeze order.
> The queue remains quiesced until virtblk_restore_priv() calls
> blk_mq_unquiesce_queue().
> 
> Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system suspend")
> Cc: stable@vger.kernel.org
> Acked-by: Jason Wang <jasowangio@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> ---
> Changes in v3:
> - Move the race description into the commit log.
> - Remove the blank line between tags.
> - Add Cc: stable@vger.kernel.org to the commit trailers.
> - Link to v2: https://lore.kernel.org/20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com
> 
> Changes in v2:
> - Cc stable@vger.kernel.org.
> - Link to v1: https://lore.kernel.org/20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..7a570591e040 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1595,7 +1595,7 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
>  
>  	/* Ensure no requests in virtqueues before deleting vqs. */
>  	memflags = blk_mq_freeze_queue(q);
> -	blk_mq_quiesce_queue_nowait(q);
> +	blk_mq_quiesce_queue(q);
>  	blk_mq_unfreeze_queue(q, memflags);
>  
>  	/* Ensure we don't receive any more interrupts */
> 
> ---
> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
> change-id: 20260910-virtblk_sync_quiesce-9b2c88d45416
> 
> Best regards,
> --  
> Cong Zhang <cong.zhang@oss.qualcomm.com>
> 

