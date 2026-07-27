Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2DC424641
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169525; cv=pass; b=LfLXWRQQCYpD7AAVyK0ojef14A5vcINE0T5cx8Lx6qOMQUVOCBt3lpClAIgNk8YkfU4g+6v3JvjrUmswPtWDkROuaoW2gRQcq7eEqcqs3KpiVWp+aomuSBZaPA1SR8FTcsd1iEivG47jkENrjUBfZsvrX/L9A7KrieX3voowCe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169525; c=relaxed/simple;
	bh=VlaBBO9h9FesyS1TajLvpgzVwPPhMLDTrikepsWT7BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORp855exTOKl4jhSzsyDddOHkjZ80ijN+e7Qr1QuqG3FcCwqtx0asuiYjyYbgLI3zFD31jZAgd6PaZNz7hyJo5UaVgklX/GijiUQYWw/2q9g/Utt3zy7dSp/3B67Vj8XH7Q/fsj7FtRef9J3cJYI9JtR5KxeM+m1cmAIt3mItfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SwmTgsCx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WcoeZ5Ir; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SwmTgsCx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WcoeZ5Ir"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RFu610179510
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 16:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Al6aPyhnaYR+2eup67Udj9VVo/xO3BVXR+NRtIAdkuw=; b=SwmTgsCxDwvLXP3S
	WVMV1njNKxKT01+zY/sz3HhcH0YOTKif544vZWoJu2jDQ9WVQSypnYhH/44WoAf8
	y/Pe/cA9V7drYrGQZTu2UhgspbjPbJDtsbHwlAmdTs9EhOmBOiB0nBp5qdCqf/3B
	P8/y5m4pqPgwlyy04VyYWhoBn9R4GjLe+IGDV0ujSitc7xpHN3ffI/q/sTZfbJ/D
	2LFgcWUF4fqvrfnDQsvRWS8Eo69iiHG0uAvWbO6VdfkfNrM3lrCn9QO57FiviGr9
	Vnau2cJxsISL2giOWPY1uYgFuP6yO/LxewW1ahPT9ff+GQXAHqEyUUnhR8IfA+qJ
	geDmug==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkg553-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 16:25:23 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ec3314f65fso37283176d6.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 09:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785169523; cv=none;
        d=google.com; s=arc-20260327;
        b=XHYecs62jBV+IfJH+nvBN7WfczT03qN2PDbMQDzA54KJVddma3cRG0hzhbysK089Zc
         fz3UeXp9FomV1NoGQjNlk2P3NxbI3RD0Fc1t6+YBAAS6nxz68nXIFNhR/TQuhz80Vuql
         Oj4l8gby9v9d+DOjFrLxrJP4KePKneGpoC8vuSrgIJhu0sghZ5FYVRKp9OXbb0jMBKF/
         MYbDk9VlpjSxHy9IycYKg8yR6Z+FlrEQ98pvxMaR/YCD9HfnY2EiIShRLnBIdUefNE7G
         JuVTcxWp39oGccaobZPGnbvroFYX3bfWv44VrC7Cz88JAbuog5+CtBdqKkaxRlJRDwUQ
         6cBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Al6aPyhnaYR+2eup67Udj9VVo/xO3BVXR+NRtIAdkuw=;
        fh=MURGJp3zoP0YqIvQbIOtxDzNqLSaSiyVI6RY0MWjlIs=;
        b=l/QYP2fdbLtKnvIgdR/OX1/hUBHshDa7WlRjPirHRNKSSHZ7+ynP7zjNk0bMX79DZe
         bO4Q4cBoafETcuHj4m+qj0BfxRrj6bm3/qYMidMJ4j0xjhtj6aMpHa3hj6dmR9AK1Eow
         msZs+bLcVL+gbO7zwe9M4ZSxB+JffRYeJ1eNJ0gftIJlyppXSb5QTpyAIUVQ+dyDrJ0b
         yFRacoc5clBKuKQrBAQGAQVxblAZp9Dy44kM4vjeFzr6raUkJVHJJQ6cFuWnKXoHze96
         Qt/dlOU9AmeUrppCmM5+rw+/oa4Tx1Eaq00A7I8DkqZjOVIhWsbkKgdHrry3hNKoVn8x
         5sXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785169523; x=1785774323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Al6aPyhnaYR+2eup67Udj9VVo/xO3BVXR+NRtIAdkuw=;
        b=WcoeZ5IrJ76BxQ+6kDaQ63cq1LzbITAIob3qqBM43/KN7sHaJBpY/de7RXQzvLEAav
         EXLrMp+QcVBzLYfV//qSpb0qfwGkj1y/eRrjhoTlhE07NfB9vAkQJLqvBZxHs4wxUzSo
         WK5AFpiUbhEPaRtDTpVhAdiU0rffKw1pVPMLlgkTfv/4mPzJ2Dpp+w9gWM6Dkd8JK0fT
         T/tY1PAy/Ltxfrkq6pk+mxMiRuOI14KxP/x5p0w9824DOhdczVcThxjSvMvnt1mZTNZ8
         8DqQYdQkGz46dxp67H5pPPQMy6wcTDX8226PBBcAgxUwQE7K0Uno/23RK3EE5hkhwrrT
         P6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169523; x=1785774323;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Al6aPyhnaYR+2eup67Udj9VVo/xO3BVXR+NRtIAdkuw=;
        b=NY3jCT1JJ4juloeBX1ceveq08SZyRKYFReda2ubxNTLrN3KHTP/9badNaJCHXZyM8j
         uvPdJewXcPRNK9ZCZlPpiXP2/pfTw75TM86wuT8mFnbiR0uKDZANvFgBTjO7LagYcy57
         fJ8B4S30E2Jwb7Qgk5vZvaRitUag3gsMLyCPPvwY2Fsxrd8C+krroBbSnLOyuIHjdmAE
         zqmY8IQ+z1nIUDeIwJAAydB3ZtmnHw960nV4sk5bRrklJt/PPMZMOAX03nfJawH4N6JW
         utNMkqzG+UJ0VGN37Uwu1rfWpiOpx8mKhacWp9Tkv/q7U+mXDU4H10dCpRdUr9F9Q7Fa
         6Now==
X-Forwarded-Encrypted: i=1; AHgh+RqEbduTk22Rl9bS6Taq7UC6XJv5869CNzcrnwoXBT4YMlZhQ4bDrSbWvKHd9clc3Z/tNANrQuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxZKOKDEeRIllLSRj5Egs9mc7PJiYODw0IYBymJv4Ulpe4wT7H
	7KEl7NWk3b7OE0nRg6+56w45K187BAbEEA/ANSuTkCAt6lbm5OmDx4P5E6IT38oStYrLTw0yltF
	JQkdPTzjqOc8pn8BZwjfI6IvJ+4KdbU7F6XUbq+pv0p0l2t7VD2GDxRxhYIgxXRUoG7OMoavADi
	vYBpNnO7cOT5G5pxXb+Eg38nfbmTj8NZFjMUaW2rERRQ==
X-Gm-Gg: AR+sD137rDr1sEO2CarkK9Bqmnew1rpj6havrMFzrwMqd5pA6wgl/tFbpKAfiHon+ZQ
	CquCIEESaDpu96j3RDrcHxaadqW1Wq3V18ydHDdBN9tjJxkvxWhDZMmZBisGmCnJAR4R5J/zcLD
	nM4df+/oK2pfB1YRT2NOSSncs/BWKphb08oH7FGeEcn1dZ1Q/G3ArSqFVHHQ==
X-Received: by 2002:a05:6214:33ca:b0:8e9:f5de:d5be with SMTP id 6a1803df08f44-907ec850b57mr106760286d6.53.1785169522546;
        Mon, 27 Jul 2026 09:25:22 -0700 (PDT)
X-Received: by 2002:a05:6214:33ca:b0:8e9:f5de:d5be with SMTP id
 6a1803df08f44-907ec850b57mr106759856d6.53.1785169522056; Mon, 27 Jul 2026
 09:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723112842.3592137-1-fanwu01@zju.edu.cn> <20260723112842.3592137-2-fanwu01@zju.edu.cn>
In-Reply-To: <20260723112842.3592137-2-fanwu01@zju.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 18:25:11 +0200
X-Gm-Features: AUfX_myDub6kHy09HZfLTxdabgd69oggUKf72RUGUgnHq9Ic5V0FuDWDDr77tYA
Message-ID: <CAPx+jO_2G8o0QGywZNLNrtBoUroaWYJWk-HW4OAHu+qwJ=VbyQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: via-sdmmc: cancel card-detect work on remove
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: cA75BIFF4ScyGsC6sYzj_bzrXfdx4jh6
X-Proofpoint-GUID: cA75BIFF4ScyGsC6sYzj_bzrXfdx4jh6
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a678673 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=qW1FBTmRn0AbZ7jd4rwA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfXwJD1miXfgvv2
 qtP40Xrl/+6FyuXBffZU3navnOz22H78Gy6FfTZwS5t/o/YWScsLckNTXsCjRihvhvte+nlXA9n
 tAdRlNFjb7vLa6OqKrRRJCkqOZsN7bNyt1bfmq1qz8hexk94gfmDqcjRFIvw50+mTgAn7Cyo4s9
 WlQo3AizVDhGMkzy1cix5hWX6u29wZ0CMKMhm5TkoOZo4XaKh+CfAFHrk/FsL02/zifuHlPOd3R
 i7LmiDPpf024OI7eCiYNR46fER/6Y9YKq/RKQTChiAzRh7j8pM5fvyfTn5gs7J9YoWBNH0lmxWn
 61A3/9O7EYvjWmqhm8TzJjGrM0AunwjfAwasLJvtwESDqDbLceh6XETtK70iA7B/MYnkmbXwO71
 3GDXISgYLdzLhfjL86/8CT+r+rH7Tq+r78UO4P3BvIInmuKgJ+UZV9dsYfM3WpBkrRWtVm1u0x8
 vi4afbe4pKJPSzfGmww==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfX+7cmvitX2wo9
 LX+dY8WlAo/DhywIyuOuN9CdfHc30qDWHsaMp39hUP61fvLmZmNKuf+81Afw9PcvWeyVwmv5iwm
 FkYeuqtbw7OTmx5W+9PCx2ZDipeoR/E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270152

On Thu, Jul 23, 2026 at 1:28=E2=80=AFPM Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> Disabling the device interrupt and freeing the IRQ prevents new card-dete=
ct
> work from being queued, but carddet_work already queued by the handler ca=
n
> still run after via_sd_remove() returns. via_sdc_card_detect() recovers t=
he
> host through container_of() and dereferences its MMIO base; once remove()
> returns the host can be freed, so that work would touch freed memory.
>
> Cancel carddet_work after freeing the IRQ and before cancelling
> finish_bh_work, which the card-detect handler can also queue. carddet_wor=
k
> can re-enable the interrupt through via_reset_pcictrl(); mask it again
> afterwards.
>
> This issue was found by an in-house static analysis tool and confirmed by
> manual code review.
>
> Fixes: f0bf7f61b840 ("mmc: Add new via-sdmmc host controller driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/via-sdmmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index 5228a1fe0495..cf7b74835aa3 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -1206,6 +1206,10 @@ static void via_sd_remove(struct pci_dev *pcidev)
>
>         free_irq(pcidev->irq, sdhost);
>
> +       cancel_work_sync(&sdhost->carddet_work);
> +       /* carddet_work may re-enable the interrupt via via_reset_pcictrl=
(). */
> +       writeb(0x0, sdhost->pcictrl_mmiobase + VIA_CRDR_PCIINTCTRL);
> +
>         timer_delete_sync(&sdhost->timer);
>
>         cancel_work_sync(&sdhost->finish_bh_work);
> --
> 2.34.1
