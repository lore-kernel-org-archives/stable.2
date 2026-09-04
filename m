Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876CA4477E4
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514901; cv=pass; b=oUfGQ+PSmzK1+wVtk5jm7RyF8PCyIbUwjQ6hcXsTfkO2bZGzDMl6jvcAFI3Z6XWCgGg16zD/hDnW2fhNv5o+fgbY+frSBJfiZ/G+19PqbP91lExT5VuOVqcSbHDtqTCM4T+mlR4Mo21IiUmSdAhx6C5/JPZiC5bjWoe+Hb8oWcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514901; c=relaxed/simple;
	bh=cmWCjbwsq2ET01BaCE28jZNCemmzGOUg3FeSLqfMmVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Weg/DC4frc/wrWnYU1o4WsYFRGFnsV9+29Qs9B8AW0T0t78VKjeOPHxDWY1zG1PXDE4+Wog8hx6RuDiBuOFsuQgRyT8qQCsbbnnm7Vbr4vsL6feHwA1u+ecx6/TI52GLxsfupLH4PoD2wyTnI97GpSHQJxetaFmTZ8cl9yxiLFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AgQR2y+M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BUBUOb8h; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AgQR2y+M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BUBUOb8h"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847nKuW3454628
	for <stable@vger.kernel.org>; Fri, 4 Sep 2026 09:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EAlCtZvrO7quQeT5Neq3cVBP1CBq7rFsygu26TBie0c=; b=AgQR2y+MYMI3ZRvQ
	ibjeYKSuQF4IH60L37co+MfDsZcUBqyi8P58KUzp+pqS2NJN8H4hkMn7OaB/ecve
	wXdNlkqvGqsFNaG2f5LQn2+0qUeyR0z/4C3swTQ1PvIWyI9qkN3VdRSXNBakg+Cr
	xKBupDQErkojbJlY9Z0AkYc2wb6IuQ7l3XvVIdOA3afAstGMU6ey37j3sNSPBZjd
	WPjpEREuCzWWO6C7GkUMqKLkJczBKE16O3+5g2lCxux902Ac8pBlH0KACL0ko/vr
	NNYMdFJ+WdynuJ542qI1lltrJ3b9LCVm7U9f8o/barMD/EnZmtf1ye1k9nh2MDxd
	2r4eRA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfhc9t2ht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 04 Sep 2026 09:41:38 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc39363cc88so1054355a12.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514897; cv=none;
        d=google.com; s=arc-20260327;
        b=mTKCmYmAF2zWT8eIUeF55Ymy7QCjh9WasaTXUcSruJIyWHLSlyjXthmjDdR8GINlb+
         /DCcN59RaxzpfJVZDjEoPhVGwjWJ3u06QMazkd/WlbALOCSIJAuB6oCpr2qumfm0Z3WY
         jv6u+qf5eWPTOftG9sIBcWpgrG7AJWWnx933G+3GylPNYrtdtsjSSiURJJ09RS0q29yb
         QqOywIikDHDjpku4U+wzFX8lUKnLhA00CLLHT1QT41O4D4lgSMr44mtXHEqS5THZNhAg
         19z3THFIHJOVQ1ezOPaKBwbclcotziR8V/EOw3I7kD5w+FrvSP+GKGQB/beJAHvJtnnw
         2WNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EAlCtZvrO7quQeT5Neq3cVBP1CBq7rFsygu26TBie0c=;
        fh=e0r3HYkoF6UdIn7GFQHrwK73t1RBR8V3N2HUw+Wrdl8=;
        b=hFlo+6GvzGFbeJu2/t3h7jEl3RioqquB9K2rqO/TU8j6+tSYEkm+TVCTKs5OYg+LM6
         YOIKAKWm6qo+ABstLRbnGd9bjDpA6VF4wtsLEX9MV8pvBJ2k/MwfCt7OQYp0hBM22dvd
         livQx40ya4BHHLOpg1HE6tyhYKkQhGHN95t/aEP/ZbiKtSs5sxXY8D9HCO0+a3DY4bXM
         FUCzJ2MCiJmNYxq4DVLg8pQ8KmdpNddRmDBJvcO7WuQoDF0x4pS9cIx6lSgpfTbQLXb/
         9P4J4UZCQZNypdcms2vSULCx6Wc/9CGowWiSyZNvnjLTAG2IH75PfAUsSYlaxl1X22Up
         rQuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788514897; x=1789119697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EAlCtZvrO7quQeT5Neq3cVBP1CBq7rFsygu26TBie0c=;
        b=BUBUOb8hw/s8jdDzhID/zV7kzY5m+cc/7Ln0Up04m8hWkUB4Li/M4T4QsmyWlovKWI
         jU3BGVXJmjsiTc2vp4JRCLvDHSplFQC2SV1kDMXn9dAzhwCdcggiIhh7/zKvs/j8QGKa
         UB7hch+cLfOr9bSkENOn/EKAW7E3jzZrtjgMp7+gPdk7yo3pBEkEKlSvZESUTKEn4N7E
         FH0zcnLUcm8hFhLOfRebd1zsEeGC+hFMOKkz24mki/1kDY9N0aHEDaDjKV0vFYFW2UZR
         MpOMOLXRgAlHKi/SdAI3W6pmDGXrd/1a/ZVslsieo2okcoxq03q/dn3teKLuy9LXbfnJ
         SJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514897; x=1789119697;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EAlCtZvrO7quQeT5Neq3cVBP1CBq7rFsygu26TBie0c=;
        b=GTKaNapSHkO2d1oYsYysDHtoq1WxBab+iSorE0wfQhdur7u9QAnpyOZcAOOj5EoWxx
         7pFjl+/54hoNmUVjMsnSKtX8SsAzW+vQcVmLlIGG4oxSnwt+ZO/ACAbvtpxx70NWc6eQ
         XpgUbHVUe8o9kWNstwEXaQDTOAXq9d53TePoM6eq/rHZ3nwiM7++3X2H3IsE4gEaVoJu
         yBlxoVDiwuzDRcKbi+21jNzp+7dC2mJdBHNcgeehl5i895uHLdAH/EJcXjPGnb/KUPo8
         tr3xQL3Sz64gMQQO33OjwHv32papEtMh+HSWxWkGkSgwd/RVRubY7YcangTVpmtsQHTp
         TejQ==
X-Forwarded-Encrypted: i=1; AKwUvBwobTrLHaZzfmtidU+Qwz6HCpt/EtUU8nDllWXqTN7ziJTa0Hzux0tFHASfrMj/9mwPWPk0MHc=@vger.kernel.org
X-Gm-Message-State: AFuF++lLaeITw3+dJ/t22w/4kYG35KgdMaNP9NqIZtx+VY4wkmUF/Vl1
	gLQx1rjyFP+DuvOMtWHOkpLrEEY0XUqIO7vw8Ojf5vG7es3k1iCWrqZdrOs0hMVFHOz63P90ED/
	O8XsLStjnc8mv5Yp1c6ZyjfPSUoOi7fNbfFEOSeit+3ysyzzC+jp3rFfBZvLnatmpfT5PBWOhRI
	p+bT7aswxdud22NlUMeLO9bLo65jej9UnMiA==
X-Gm-Gg: AYBFou2kSdpbYqnNXn4prIQq6zeoI0J5/i4EfmuC6aQLi9OKw1vtwohPyc9kY9S3Ahf
	a7yOPA8/XoGe6CPw1sOGS4yh1eLL5/vRFpmfYjI49SJF6kfIy3qbYGA/kTPDy2du9m/VTnfBS6Q
	puD4pQ2AbsX0ilkgAVy3Qgpo2S9wcvnTux5pcQo5P5jy92Ypl9+0N+2+UIzg==
X-Received: by 2002:a05:6a20:4311:b0:3be:b0b3:3962 with SMTP id adf61e73a8af0-3da39d147ebmr6525013637.9.1788514897298;
        Fri, 04 Sep 2026 02:41:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:4311:b0:3be:b0b3:3962 with SMTP id
 adf61e73a8af0-3da39d147ebmr6524946637.9.1788514896803; Fri, 04 Sep 2026
 02:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804213458.3408662-1-gyf161023@gmail.com>
In-Reply-To: <20260804213458.3408662-1-gyf161023@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:41:25 +0200
X-Gm-Features: AcwNN1UvWasE7E98pHGU25bWRYr3p6g2RUecF_Sa-ooQkstSMtiJVdUTxpR1BPw
Message-ID: <CAPx+jO_Ov6r3+9K1ks-WojourapQcDHnxTgDjW1sg-RMPRmnRA@mail.gmail.com>
Subject: Re: [PATCH] memstick: ms_block: destroy io_queue workqueue on removal
To: Yifei Gao <gyf161023@gmail.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=afdRWxot c=1 sm=1 tr=0 ts=6a9a9252 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=Plh-MFd_Tk850DHwDTYA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX8Osbkgn7W53Q
 ku++aMBFtNHhdnD0uvrjDB4j8XL2RWLgJMgKb2ZvovGzogNZendwW0AmdaDtNG/1Hz+WDCThzDs
 u1PPS7eQnS857rIDBPihlLaE6f79nzwaAwuK7Wj3Vx0HCWHkOKZudpMNMnXNmvK1vV6UUCBYTGK
 9RyhOkYp8+vb0N+RUVPSOAdoccTH/VIqjKWPYX6Hl1ge/gdkUq7gbuB1t61rB5D1rzylc0NREzp
 lejMglMaXzqCOXEI9dkB2pjANcIf6oCSQ+BgYNT8q5dhOUUM82YING8wKB+WbH+sf8/ge1+tJUY
 T7iGdIFV3xZiVdML3mLSteG6xWV9cb8VhEZQupPU17OSOcNzoSROtc5RNpnnuVRRzUaF0nyjzXW
 hNe7l6mgevkkWeZBBP2hwPseY2EPkMyBvOQ8wbmgHh7YRJWWPcvDA6PNBcUeJr8uyR5FNKRv7u2
 uCceTrm06quuG+QNP/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX9nw8hkRT9xnc
 xRd8g2hPXcWQuZlXheSVSw40E6BSPB8an3iJ+j3m4rI9qbP9bjqKKdPyAhzzokKzgWtyV+mxCMF
 xVKbE5Q0OyXo3tIyYqfZj5YhaIfxwgI=
X-Proofpoint-ORIG-GUID: unFne7fs3YSMb77xvFWhSBkQNJPBzqhF
X-Proofpoint-GUID: unFne7fs3YSMb77xvFWhSBkQNJPBzqhF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040088

On Tue, Aug 4, 2026 at 11:35=E2=80=AFPM Yifei Gao <gyf161023@gmail.com> wro=
te:
>
> msb_init_disk() creates the per-card ordered workqueue msb->io_queue with
> alloc_ordered_workqueue(). It is torn down with destroy_workqueue() only
> on the init error path; msb_remove() never destroys it. msb_stop() merely
> flushes the queue, and neither msb_data_clear() nor put_disk() free it. A=
s
> a result every card insert/remove cycle leaks the workqueue and its
> kworker, exhausting kernel memory over repeated cycles.
>
> Destroy the workqueue in msb_remove() after the disk has been removed and
> the queue drained.
>
> Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Yifei Gao <gyf161023@gmail.com>

Applied for fixes, thanks!

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
