Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B734ED183
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784083; cv=pass; b=XhEeaMlwbaSPeH9rw0VPENgKq9vPsybH9GyDZKq++CvuGITU8yXEXycqnjNeOhzELsWgP2D7sjfIzO3Cgihu9Um2zxfgprCvRijPWWNHfRVOhpAZ32r9EYGxyIMyaJomivzVjvtzeRkbHRue7D7bsru0tCZ4bh+/8yy/jQxmO1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784083; c=relaxed/simple;
	bh=C9Jpcl4hk2nflrSgR/CERYh3R1ZRq3nmrUq5WwdvYXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgZyKagK/IHeBsRs9utEPVH9ilwxFwqvvOa1hJyyk0CpBS/DSF6PsBIi/F+j2jogNC7Yl0e1GwSyczJv7sehbWhIyX3HLXUMD8wWVQKLJH4T9pb03nvYvt7CGSmlU+AMzcIj0vWH7OLFgsJD5aaRYs0J6p1pBr4XHYLWf3HSajQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VUqEiD4d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aX9D8cVR; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VUqEiD4d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aX9D8cVR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UDxuBV704740
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 16:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C/+/jDwGHy2o/OP2F0MWdjczwuGzPVCHwR05xkgVhWE=; b=VUqEiD4dfcVZsbem
	5GZX8RCHmJyFb3qjkdcQwNLzqNju6aF0K9VSnDL+U1q3wnemt8BVqCFApxTj3oFG
	08J35SR8OMmF0t+xG1GMOtsS7wHQzsdk3J+h+cBwGcAK1dRe3OaBsozt85g3yro+
	bprJG/uWAAGUIpdIICKxzunOfuZ5pKiDiQAYJ9dAsNfX0KQ+46EaczysJTn1fJt6
	HDp6fq1Nyh9SfPoVPM7fZ6CvThCNBDFpgNCbUw07XVU4KUZOK0SrzBQI6Fn+vpgD
	DHeYBE5RlwJZUxUVAGFxz1ZheUO/Ld0dB+6MBpjV4j2V4zfw91lzqD3nUN1mw+hm
	9NLyUg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136tgq5h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 16:01:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-398dc3d8f0fso1778229a91.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 09:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790784074; cv=none;
        d=google.com; s=arc-20260327;
        b=d47FlsqeZ5DT/f8eMaePJB+CwO52OTGKjCX+Mf33QLIXWhTI8T8EvnEeRhzhgRP2d7
         8sBU2yqKTDCccwPNSeE1rqPcZyLVitqyvkDnks4sxoNnn+743ZyJob7RnppBkZQljWEc
         xqqu3c6KA6+VBVUHpWA2j4IyDUUoTTfyFHBpJubKs8LXWtUKn1Vgr0mPO6T/paN1GCLg
         3ldrzOumN5Yxtg+xTRLuNArIL2LXXh3jzIx3s/oHZe0ATt/jgn2JbaTZobVgTByxiPNp
         EOIfVWKjJEo1C8djVWJuyeZwpVF51vh3z9PWvzSZ9gV0PB39+HIo5Pq5gbPOB5WgE/2q
         lZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C/+/jDwGHy2o/OP2F0MWdjczwuGzPVCHwR05xkgVhWE=;
        fh=XXgwvBsG2zd5lpHajhjr9pmmcMDzdUM6Nch7kTu7qJ8=;
        b=mpTPd2RDr0T1WQ1KWua2lAp+aPhDA/EtjtmhYpylYgFW7+fnH+DO+xpM/asVn9b88H
         M1s0MMR4LYR/f6FMJP+W7nkCefv5SZfbKT07ZWRPSwBFrnMLIbGb6QFE4OsHDE3+amlV
         8zOyLeZu75fgenbYLTflhQavoxGyTQ6yOLm9HWKVfxWw9awNdYU/3okwCHrNXKe96YrX
         ZoL1qm95KYxo+XvToB6u2FMTX6jz7SBMgYaYmVm1mEYci2dtANM01TMdpBkSQooAmrB0
         iJX6NyuZQHWnMdpjQSb2iV/vtC37c8EZkTrEcdG3zNQTd6jugZPUrze3gSNhji6X+vyS
         Av5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790784074; x=1791388874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C/+/jDwGHy2o/OP2F0MWdjczwuGzPVCHwR05xkgVhWE=;
        b=aX9D8cVRczpi+8aKMJtkS+J5rOzHQzybOk0HKs+g70BAKxQXcHqIid/1XnxRewPifK
         8E+gEj0CFeQuDgoyrqExHOmHJZ+tLXvOBdT7rf8cqslda9gQ/Lp5kphMXnIcGTr/CR9n
         9tD5pLis95K1+Xa9ezIx31NaATqPz02do54lFopaZcRtHoXQE0mqNQB++N5LLRSe62tJ
         K0Xd2y7JojEv4Rr/sHKxcm8HUAyIw3sMfMGmYOfU/UHl0RlV4FH9OoiWt6sjl193qW5N
         sQkK5QQvzHRQJCuDP/OmDE9zm7jOMgFuumXDh3MyIgTDkAxHCDpZRGsH2IWAIARgF7rw
         h2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790784074; x=1791388874;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/+/jDwGHy2o/OP2F0MWdjczwuGzPVCHwR05xkgVhWE=;
        b=Gv/4OoxkXBtQRXatB4pRflwJppl0pk7aTIguFPLR9YVjW7pD+71vFr+25YkMj5IMm0
         uhnCVkt2UPoxSXGZuRi3cLBm7Jxfrq3RewFii+SUmTJDSxQXzcySydofWXfURshYprIH
         TMyQFectt+rfg5DcsDk9tQGCPRCeD6dWKT8IIAVlE/3AESNyMh7+TdygsvDjpSkvfNns
         9MicamXkqWzJr04NzUkKVxjVtweSsT9gG3y6168kXHF/yWcSWJKsh6OOzzdKz08YP+DG
         u/rySakTLklrVDLUEIJBXZObAbFFUOw2SJst2rWmoPX9xu4uOsEJEZlcN40kgrN2QQ4S
         CH6g==
X-Forwarded-Encrypted: i=1; AKwUvBxNdXl7ddLDa8glatJCRyMb7ZLlfdueGhSStg6/hlpOw9DwJLGy9sjYnWvj3xiQn0h6bp+hlTI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFQeuUQd/yzNNjn+MYVkRcPAAQEN/P9o/QmMsakCt5wcaVKftT
	dOhRzOUgDIMYRPz2eDllKDWp6lp2/b3NdgnjVoMvn5AGBtM5DdbN1kZkAUyqH9Gki3z12VPJjBs
	vDIvEusT/pINBYswHcSBz6Q6HDOlOAd/026Qrwgje0dl98qlu8PRSmS9H1xNcA1H8NnQCEdVzdA
	S0oZsnfQ8Dq4N3syjDP4y/ZAFBNFh21SJYHg==
X-Gm-Gg: AYBFou1Lq8C+i+HVmkHXqvU0qJd/wA3R/Z0JBvCB/dF+RxmvzWNNHVh1MouHbhFtigA
	OEhZiv3bR5yIO9SbIm0sftmblXsvuHt2MkIFDF6cWPUM8bwKu06norHVE7Qstk4ouvGtEgs3uoR
	lNNU96f+kdEw8j6VS7bVLKXjWI1+Lgv09nI44aTSAcBf0tYTvuGYrIjgDeiQ==
X-Received: by 2002:a17:90a:d2d0:b0:39e:3d38:7ef1 with SMTP id 98e67ed59e1d1-3a4f2c2248cmr54947a91.10.1790784074142;
        Wed, 30 Sep 2026 09:01:14 -0700 (PDT)
X-Received: by 2002:a17:90a:d2d0:b0:39e:3d38:7ef1 with SMTP id
 98e67ed59e1d1-3a4f2c2248cmr54925a91.10.1790784073616; Wed, 30 Sep 2026
 09:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929124522.2141124-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260929124522.2141124-1-runyu.xiao@seu.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:01:02 +0200
X-Gm-Features: AclHuK-_MwI6oqPNb_CFHKP8OEa78Xrn6y9JHyCctq4WiB7Q3lgUKRsQJK161C4
Message-ID: <CAPx+jO8fr+Jkb9u8bx6a7cv0=oD0jUGqZpAamw4j+LVFnqSw-g@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap: synchronize clock timer before disabling fclk
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Ulf Hansson <ulfh@kernel.org>,
        linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MyBTYWx0ZWRfX9BUkip0JOJPu
 aOGgsq01yaXnyqdjDoZzxqlDZ1R1QXKGTDw+yP6eE0jVVMrxO11USL3nkI9Pyte3TRo3hZ3lc48
 +607V46SX+1LXSoRRKBo/sT0iLBtAqQ=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abd324a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=ywtp7fW4YtRplKC3Ii8A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: X1sKucPDyN-pQrfd7YEibNOJ1nRJZ_95
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MyBTYWx0ZWRfXynKFzB7dzv41
 cx/3vflmp5uJUfI8xS5P/IO+/zJ52oiPOHa/bt3pvf9YIsNrTud7eH11+TitXG2UsD3d9EPIF6W
 LkmLFQyV569BQq5T8lKaPRmRTOL9uAg+RclKL0RqDD+aahCG7LXF5BpXPWfNDPGefhR45rbUGN+
 OqJWpfLA7Gtav1ZR+kd3TJSmBFcubR2Uj5iATXXEXErGzRaRWMo+79xGFyuTBlVcIgJaD+ss0zy
 exdocPXGL9PoMrFFJ9hw5wYOfH7150FUVZOJsIFnTzjevpyCBzH2C3dX7rNUJvSxbrCkYjsB238
 bhRJPrT3jby20fcgYRhgMzGIS5X8bYRwLJwAo9+3PbxPqDoK2NCuHZ+1GS1dlI4oYvrNSVfsS1a
 Prmvy6VcGadFgnHUXFzryw+AvWdKNw==
X-Proofpoint-GUID: X1sKucPDyN-pQrfd7YEibNOJ1nRJZ_95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2609300063

On Tue, Sep 29, 2026 at 2:45=E2=80=AFPM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> mmc_omap_select_slot() removes clk_timer with timer_delete() before
> switching slots and changing the functional clock state.  timer_delete()
> only removes a pending timer and does not wait for a callback that is
> already running.
>
> If mmc_omap_clk_timer() is already running, it can therefore call
> mmc_omap_fclk_enable() while the request or slot-switch path changes the
> same clock state.  During host removal, the same window can overlap the
> final clock shutdown.
>
> Use timer_delete_sync() so the callback has completed before slot switchi=
ng
> or changing the functional clock state.  Keep the timer restartable for
> normal request handling.
>
> Fixes: 0807a9b5739a ("MMC: OMAP: Lazy clock shutdown")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/mmc/host/omap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 527b89a5e..02d288e4e 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -214,7 +214,7 @@ static void mmc_omap_select_slot(struct mmc_omap_slot=
 *slot, int claimed)
>         host->mmc =3D slot->mmc;
>         spin_unlock_irqrestore(&host->slot_lock, flags);
>  no_claim:
> -       timer_delete(&host->clk_timer);
> +       timer_delete_sync(&host->clk_timer);

At a first glance this looks fine, but I am slightly worried that this
could deadlock. Have you verified that?

>         if (host->current_slot !=3D slot || !claimed)
>                 mmc_omap_fclk_offdelay(host->current_slot);
>
> @@ -273,7 +273,7 @@ static void mmc_omap_release_slot(struct mmc_omap_slo=
t *slot, int clk_enabled)
>                 /* Keeps clock running for at least 8 cycles on valid fre=
q */
>                 mod_timer(&host->clk_timer, jiffies  + HZ/10);
>         else {
> -               timer_delete(&host->clk_timer);
> +               timer_delete_sync(&host->clk_timer);

Ditto.

>                 mmc_omap_fclk_offdelay(slot);
>                 mmc_omap_fclk_enable(host, 0);
>         }
> --
> 2.34.1

Kind regards
Uffe
