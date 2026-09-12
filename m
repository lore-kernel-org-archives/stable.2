Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B655C361DD0
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789204789; cv=none; b=f2e3LN4ipQyt9kqcJucj4wt07xvJNE21rAKoKEy+SOMikkgiMpD/RbMI4TkIee1fK/XtyJ/DVUfWetOhpRH4XjEUYzhjb9LSvSxjgRw9u9B1HoMWcf22ajXqF+ttUIt6jjkIvtkjGE5US6yGQvdyguNBv25Mw1eZvU2pmNSA6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789204789; c=relaxed/simple;
	bh=iofOTXYS/bZXZ/2qBa9da7ho8/2GhtalFO00MODtkb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+TfxZ9g6jMyrP8iHt/jAUCkXw70lS3inSVvo83S5Zbjl73j2zX7YE02lypArEFBv7Sar+PNdDzHbzO+f0j93Lla5sn7YHqBzSUW2NbptsUslChOOBrbSxpbvvjHo1k7SRv57pbw3nazmIXtRxsqaLbikmQO1oW3vKSfAIFbqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BGFupaJx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XN2G9PPa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BGFupaJx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XN2G9PPa"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68C85BxR2443846
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 09:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/33vb3qfO68qBBPyyf3BMf9vXtG4LUI2mzvFC7b6Ls4=; b=BGFupaJxsCp5Ahs+
	68qLTg/6wTbeLOGtIp0K/hgIDt2VlrkNoNpZVWP8g3v1YaU2GFYI+Whcz/Qxq3pm
	lIE73ZUFRwkK4ItPiGl93YsomUcKszTDx4uzwBFnLAzEl9tm4scTPzpZZLtxQZlM
	Js8aqyGz4LsMn5J50cWVx57moU8R4JIlv2Hi9eQ9jfYXSW6rxgIyBIbIDGHaM2yn
	VvIruPB4o+KYtcpIjE+2OCxEulyQwOeXN3XgfIHItCtLyzyLvdPm+iYVOM8dOkMU
	A+E0WG1v0Ttg+N9+BnEnPaUnPXmNk64rTBy5IijJlB7yNHMyzfsCtGhZASjLeirK
	kxiWoQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c0k7p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 09:19:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfc52ddc55so24437845ad.3
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 02:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789204785; x=1789809585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/33vb3qfO68qBBPyyf3BMf9vXtG4LUI2mzvFC7b6Ls4=;
        b=XN2G9PPaHg0WzARB29b89jUiz2+ka44gETZH9dUrz9h8eMl1PFosvI9loMR1W++HC3
         tZGC4KQelTCDxK70ac2lIhDpzmZo675pltnLljxzjaNzP8MEhaolVnNTbqHO1HWtgPXb
         +siW434bNnABeUJbWod7b+oLZ4AjLbw5bIR9wPcXjQGLZPjT+urE4z/tPlMMRmyStEaY
         ov9Q1TU6u6rcT/VN9D7cXAGnRBvQwioMK78+2GOLwp8njYi+VZmiSUrVWz5ViZQUWx/d
         J9kzg4e7RaNIYMur/ZH1jNTXSA8Jpx6xFimdru7omM2YVvvcCPfX3WtxCu5HR/53sTvI
         7ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789204785; x=1789809585;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/33vb3qfO68qBBPyyf3BMf9vXtG4LUI2mzvFC7b6Ls4=;
        b=Qjen0/2oH6nV3sIw1Kx5jC4Vnyic/Qr0ubZIbJaaTkv3itV6neXfBN/mFi6BYlAcee
         i6y4OS0oi/S7T9Db1/+hJjLzBD/fErb+N4AwKWdHkRDINkXrGYS9ACkjCj3H4m8/picq
         bhUs9mzeS8gjoTcHZxGaYpmx18LkHOV2Nrpgornw69WM+RNsdTIQV7yFWawUNnryNo9b
         vnF3RGxrJqv7tJG1dKascTVRhci3gM3PBVwEXtY8XvM/EF00gr4R82tU5XroHsvJu/H4
         Kg8neHi8p/o+DAqc1OjDslYT3yPsXRqLL6TXJ27wFqYECv5TDryQRzxBglS1GU1LoFm2
         BEFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbtVwPjGYYQtPTDH/oj5ZpX0Ms3jIhpoVNpQJ86MVjEKHZBWq7a0Lio59sMir5C1PTsiTdc4s=@vger.kernel.org
X-Gm-Message-State: AFuF++nZjCjkdhY3gUIsXILtQ0sU084JQMhpdOfx1V2MP6d0PYuA0fRv
	dXQZVVcDC8+/uvIoOvkVGKvaZOxk6ZhMjhvrk8KD+CldQC9Kb+AMg9jkSMc8pNVoyqM7QPim9a2
	sLGYrVAGJjgFD365A5fPlk9dVAeYQkm1kY7YMeV1yd/ZrMe84QYn0Jcb86kE=
X-Gm-Gg: AYBFou3uGiVPgvApKV5RMIz3IW899f57+gvKc1np7dh72k77lHFqg3IvX+KJraPnL0w
	B7KCeCxJwcZzG89qdXZzQiLcIH/zERX+6GpPBHDv0qSk3ruYlYmtOvkIBhmxtfq4Xx8ZISzh3FB
	IGhTgQF2DWfpj6R7bzB3JQ5h9oV0IWTxJcQ4BTWoOatsRSKE+qKcx7YDAgfYoHQTZAf0Z9JQg73
	83aefkexN8hoK5S/vwPhbaXLfIoXAJPwIn781nDL8oMWxla90u1hFLVttfCsllVCwYBuXNxGXT5
	QKaAElPI7jKSe77n9MEq6C/81rm/F4mKsaotdHvTyguocNGsb5eulp9nj2P6zipPbxUlsxcGTyM
	tdoOI05npQsIAVr0hMq6aJefCVRiQDGDI2jnMpB8mXuSUQVvq0ybK0sxGDGu9GP8hy6jI
X-Received: by 2002:a17:902:f685:b0:2dd:3ddf:b895 with SMTP id d9443c01a7336-2dd3ddfbaa5mr83347535ad.3.1789204785433;
        Sat, 12 Sep 2026 02:19:45 -0700 (PDT)
X-Received: by 2002:a17:902:f685:b0:2dd:3ddf:b895 with SMTP id d9443c01a7336-2dd3ddfbaa5mr83347155ad.3.1789204784987;
        Sat, 12 Sep 2026 02:19:44 -0700 (PDT)
Received: from [10.249.16.182] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cca268csm22228795ad.1.2026.09.12.02.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 02:19:44 -0700 (PDT)
Message-ID: <06aa40f1-9a47-46e0-88f5-43ece4e3160c@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 17:19:40 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LHua9o5NZ112zdprY4xqL73wWlDfbvP1
X-Proofpoint-GUID: LHua9o5NZ112zdprY4xqL73wWlDfbvP1
X-Authority-Analysis: v=2.4 cv=c5Y+0h9l c=1 sm=1 tr=0 ts=6aa51932 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tUvm9EZT49aG8J7fJHcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDEzMyBTYWx0ZWRfXzJV7oCkogpGx
 ozBoSPpZt71QfB4rSQ6TPPYV6+MQxGQdyIAKJBlP9ijQwbpt6d6Amskalll8/owYvaQSCbe5tH7
 XLCnZf1Cb+2BZHmgqxggJC1CJxw2B1X0qPNz+XlEAWG35jaCnKP/WPzRgESI/NR6XU5m6Bzxzj6
 L7z6SPTG0jAlCyMa59LqUx1g5Br0WReBztHgNinDfdy2VcJ/7HB2vn+7lkA08E29Tg3oNN1UcNR
 ZkZVm3uiPr24w6KB63hC5h+SXxY/cApHCW9aM0mKYx72VOEl236Uo+wiKdNqJ9Uhk8+rzO1Pv13
 Vxbf/j/mNyEeGvRZAfIGS/sKqXk+TQMefytL87RFtKSCCCJyJfPYJI2Uef96+cKUdqsfVe4Lusm
 kTbRz1T+Z7tz/yNzdqwaFfFVYcPPb0xIcw3YCsctDT9JKzpCVhfzi3EIFgFc0uqpX2AWBw2gD0j
 t4JJSvTKMXuIQM0JfsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDEzMyBTYWx0ZWRfX0Bljrrc5eZJI
 9+Ih/VmJ2F/pnZRrSRuhgdmNZhznrJqlJIDFh4FnTH5ZN77RsuhN1dn2mPwMhFrqB/9qJW4oOic
 n8BnR+z5Cj1fWk0N0iSkrH7zf4d71i4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_03,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120133

On 9/12/2026 4:52 PM, Cong Zhang wrote:
> Replace blk_mq_quiesce_queue_nowait() with blk_mq_quiesce_queue() in
> virtblk_freeze_priv().
> 
> Keep the existing freeze and unfreeze order. The synchronous call waits
> for dispatch code that was already running. The queue remains quiesced
> until virtblk_restore_priv() calls blk_mq_unquiesce_queue().
> 
> Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system suspend")
> 
> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
>
Just noticed that I forget to add the ack tag, sorry about that.
>
> ---
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
> ---
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

