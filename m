Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517A3793B4
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612030; cv=pass; b=QCRTcbpukAsYI3beZhBirzOVwm6imycFiTw00ZDIkv+pjFONDund3DeJR5myaigdkS/UwrKkjnr4b8a7g98XVtA1VtYeLNgMtJeoFVyQr4bEAvJpvJ1/2qtIHBrRuduD5wb+Os4Dn4WAD/yU+PDjFmMmMFFcfIeEILmnSUa8fco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612030; c=relaxed/simple;
	bh=C2R1jzLyRMLNPTcwZKMSBnFNoKFMwMYrYL44Nwq9JSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPmGjqlGL/dbSYIuoTPbH6NeKI9CVaDwwkj6hGxjh3l43iQcMGq67onmXTugTcIm6MwZ9qN4pWXDmmh2LbBi6h44MJjs02vHYih8+vxPiW4FyRj4wxhrAGy30rfsIlE/RmN0m+XvJanij2/VKvvIfbBet3LIBdBpsKQv4n/FuKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RrMxEnQZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gm772tgt; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RrMxEnQZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gm772tgt"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEeADZ1244057
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KC/lCZJ7qlaSJwHrLxlOH5edVvtPTLCFOdsNX7ze6Ac=; b=RrMxEnQZYFTlNz0D
	bc+sNQNzBMjkfgEjq3T7iOJr9bGHBXN70z/6LPSW51N5yVqX7WVSPDQbT1dByWPQ
	MqVBIcSqpsrTG3In+0+Z7xTvj/RxEFfK9W30ETjPTvshMESN3m4YnIcCVhVI/La1
	FgJn1umNj0XxpJFJt8gWnNUWgkWOCCf5VadtjWwkOtHtMwGLBwRgLsLq01KLsTSp
	LD488CC0M3Mf5LEpCbKyzaEmsxFpLSb/1+/aao9iBb9g6HsC32Q7ciBsvCqmenJ9
	XzqjkmqhvSOfPXewETDcctg55dhDh/5dR15dPiBmGNP3cCVhFR0UHVUmWEkcnX9c
	NwviwA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyav4be4w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:13:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1b6f65dacso2080984a12.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:13:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612024; cv=none;
        d=google.com; s=arc-20260327;
        b=bY0zFeZohrMUY4x1HIu+YP44K03ngBxtSQfNR9Ewzu7GzCE3tGFZNZU59S1zyUmyvG
         JsFrXTBgHN70wIO46q8oXSEGUJKOU3KI9Zmi2GmaBAzo26L9eLVlKNBfX7BnD5flvNZl
         9/1XN8i7BqdEfGoAr9NnAgIIf2Y2zpoSOL9FND4xvnITpOqXvBxfj0+0kPC1V/bkutJF
         0DVPwQt8pu3YxKykmKfTzDszwMNWAk3G8P/VUaprTdrDvWliNp0BOw550Pd0cHKcvGxc
         b9HIGuCDq5mMGPkBw06ve373R5e/X6BwAmolmzSjOS5vYEJxNgPXDlyoTl4CA0wlltsC
         hAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KC/lCZJ7qlaSJwHrLxlOH5edVvtPTLCFOdsNX7ze6Ac=;
        fh=KNPJHQQliT1bFcT7GRB0dXa7gru6ZrrXGL8J9/BtuHw=;
        b=LVHtAX8iAMloYIB3cHQrfQ3o0WHd4wEG3nFkvunhju1fgP1Ost3+IKrayuLsXd4Wx0
         WZEUNcbTumV/rhZEvs+eJSwON0wocxxxTFbHP4/PWqb1/K5k01M9yuUBnFaxt00WpyF5
         u0EahxaMDrKezjR+GWJLUD11WbbVVcafWy7JR22B8CXSsvmd4+T50QEZqxaLw9+4GDxt
         reA7raEX5LlVTfkFFKoYrdayeO0Ftrfv2JHCIzcv6JZf8cPoKpc6kkwZxzKn3xyQI+Br
         CC0IRmSwu+MpdYUDosGzhldqGcXvtKJvrEbvKzSstqLyDBEMw/aT/Iff+JdjWV9Fx0XR
         6qkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790612024; x=1791216824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KC/lCZJ7qlaSJwHrLxlOH5edVvtPTLCFOdsNX7ze6Ac=;
        b=Gm772tgtPTlEGsbHoFf1v3dN71CN9hgGIlxArfmoIyiGOd0ibPOaxKIzLMs0hbCQCS
         CEqtiUg0IL1Rbuz/vcB0PrQMYZ4qcRZRe/MXk2qYYkZO5aaq/2k1Vq6SW0psx/kdXVoR
         TLpLdShg62NXa0jG7TMP1sepoblbxQ4tPMpzp5HWlbS2tXkU8WdDGCD1axw30y+APtup
         RmsX09Pk3LNUSt6HOTuiNdRZbflLno2Zd10vwbZCmqV/n+GJUzxHj4VX4Gyt8VmNfexa
         I3e0VTQrh9wWo5pMi3wZJpC+nUu2yttkPqp334LoNmuGiicXrXIJCEawT4pGozvdt6+F
         B0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612024; x=1791216824;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KC/lCZJ7qlaSJwHrLxlOH5edVvtPTLCFOdsNX7ze6Ac=;
        b=kkfFnxu6mjJ4WGHn0pBivDRsUN624G9iw34dikfddcYVWbmXq0yrSt5324DiT+r6ja
         PNsSi2uLfXg8XGTPcFeh9KMaPG4HHUUM+peFw8VYiU/eWuT5WXJnAg5RRcdcXiz5vR1R
         tdV2x04AIFPExk90+07KJO8PUBkqRVT6sbM//l/tKI/1RH5nk1ldbG5Qnsv94gimtb1X
         7FzmuDtQZ0bOaeqTWIwZ5Fluo2Lo+KnrKQ+Zeb3GInQ0burfXQRuiLsNxt2vduXtAO22
         m/wNlu7lvp4cTbeUGpCpb8A06dVHNsTJrJb1W/Pf5k1zBiyOH1J6y6Sc5245ot4I089A
         e/9A==
X-Forwarded-Encrypted: i=1; AKwUvBzGXASQHFbBNrx698jOImQ1qR7CcoB9+i7sIr8yjHAggC9BxDZmTQzU1kc9v4GaFmr5qCnamv4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMsiknkhDrHIbCco/O1DD79H7+PT6xMoGSLrJW1QjQkfB/G9gn
	aon3u9i27jqsy+L3CXLUcU0tBedWSAzvf8IkJK6vx/KmzlV+WEgLVm4mfnqOQJd7x3pGc4sz357
	fvVTWUfP1nyKjzQg4sc/W70aPql66Ube5U11QcugIylTFN7f0QuU1rtSlHyDM4cc8SdkKTlT2DS
	Q4BI5YGCYdX5uonqlG4dzn1Tjwrt6MVRu0ng==
X-Gm-Gg: AYBFou1lcDON0knt+3fGv74e94QSuRxyewiyXyRHbPAJZ11Rafvx4f5hCOYTj1ndweN
	8FW+qg10ok1RF5INti6kheKOtYoCj9stioVlR60ZidpstzRun7uZ6GjQFhBdAdm18d1zM16cPxq
	Y7UeJUb6Quyrq9/qYII88QGzRTxPnBt41W6Fnl27h1hejHLwNtrs2wm/qI9Q==
X-Received: by 2002:a17:90b:540b:b0:3a0:4384:adf6 with SMTP id 98e67ed59e1d1-3a09855cfa2mr10341120a91.0.1790612023330;
        Mon, 28 Sep 2026 09:13:43 -0700 (PDT)
X-Received: by 2002:a17:90b:540b:b0:3a0:4384:adf6 with SMTP id
 98e67ed59e1d1-3a09855cfa2mr10341096a91.0.1790612022801; Mon, 28 Sep 2026
 09:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150317.2444609-1-lgs201920130244@gmail.com>
In-Reply-To: <20260915150317.2444609-1-lgs201920130244@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:13:30 +0200
X-Gm-Features: AclHuK-X-BDgOMZUiT1godE1FfZ_R9GlZELj2HSpr6Kis3LC70X210-2yVnsAno
Message-ID: <CAPx+jO_ikSq=QFwuu20J2ryBigmmk_5QsUzNbp75RUddG0fH8A@mail.gmail.com>
Subject: Re: [PATCH] memstick: ms_block: destroy io_queue workqueue on removal
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulfh@kernel.org>, Kees Cook <kees@kernel.org>,
        Maoyi Xie <maoyixie.tju@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: LUM66OtJH0V798yLANXpLUmu948cuo_F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX6q7UtOnq8RWF
 ua/aJDftmlZhc1QlCW0Q43WQHx/djoBdKzK/zhtmNbugGIUlEL+8eh6Oq5XyfBxS69c2keDvEvo
 GLL/hpNWfOvwCVV5mzZ+ITlI2aJjWkrsFQQ5Y4yxZcOPa2gcXpEEMnogssdMW2Ioo/cD4+wvSw+
 R4zZrwXX9XTt5h2xckXmHSYw9fVrh35WUGrq01XkcJQiO9Vqi/ujgjDKqlpVgurRvuVWSSkR5k+
 1dt1h4A5Q4L6D0Q8FbL4eqdfObGggB0WNtxy26BgKizPKEPznZHMHQJNLv8WjDOqel8D8+WIK+G
 0LfkYWIjcb+zzjVvQxheLhziSsmMeDtzg1ziNJwbfQgZJi2FwKEiFDW+mhTGeslQc2NFlqP1rq6
 AhNWPLc0d7vxjX4gywGKRc/FoN63Rcj2sHa/FmBBWDBbelRgMn6PVQMvm6G7nZ+mRpOip0qUjfx
 iXo4RGQA+QM8/y9Cqlg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX/GbQvrwloPd9
 4aTxp3OJe5Q/jY1qdvTKU8sAptgXZdzcc3sqb5kCStDpfyf/ClkYbZdj/GK5I9vqi1FLWXBga7h
 LvqF2siKbymQZuUlokhYUMRT0kjT08M=
X-Proofpoint-ORIG-GUID: LUM66OtJH0V798yLANXpLUmu948cuo_F
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aba9239 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=Plh-MFd_Tk850DHwDTYA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280064

On Tue, Sep 15, 2026 at 5:19=E2=80=AFPM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> msb_init_disk() allocates msb->io_queue with alloc_ordered_workqueue(),
> while msb_remove() does not destroy the workqueue.
>
> The probe failure path releases the workqueue with destroy_workqueue(),
> but the normal removal path only flushes it through msb_stop(). Flushing
> a workqueue does not release the workqueue itself, so each card
> insert/remove cycle leaks the workqueue and its worker.
>
> Destroy io_queue during removal after the outstanding work has been
> drained.
>
> Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

I have already queued another fix for this, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/ms_block.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_=
block.c
> index ce33907bfc24..65154e569a9e 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -2204,6 +2204,8 @@ static void msb_remove(struct memstick_dev *card)
>         msb_data_clear(msb);
>         mutex_unlock(&msb_disk_lock);
>
> +       destroy_workqueue(msb->io_queue);
> +
>         put_disk(msb->disk);
>         memstick_set_drvdata(card, NULL);
>  }
> --
> 2.43.0
>
