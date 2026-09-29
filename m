Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E86E529414
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688886; cv=pass; b=eacp5qH80SyXNWHSzMnjey3F9cbSEH1ZoI+usI8onnct6/d1EvtjMy8RBQjdsxgMgUQzDp2DqO5N5JD/k8MmPIQAqvpVcfdb3CTdhuEE7o1NVsvLM01NEuFjR0K9/NtKpXaUqOoVpZ19OxeSR93GAS41faexT0dhLfXGiVY1ISk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688886; c=relaxed/simple;
	bh=TqAhkiRrKND4/cRslNapHF64pDqhWGTExdZ5pdPADI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=seKlUOdPbfyIhjhemF3VD2gbaeJuetmtkfivUSasNg19FRBBTTQ5C4jffvukl/iIL254mK0RyYGKS89kyJHfBfAN7UBlj3F2DwL82EEyTRd+8PjNqZ1v0vFtxAq+ng3X+pGAd2VzK5D6dfTWJDqNEButxyNYuiSi4RkJ15xE3LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hTyP8eSl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FGlb/88f; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hTyP8eSl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FGlb/88f"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqhap613444
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h6hMFw5ia2G/hTScfLWqNqOkXEUjQE/tTxXoScUVfU4=; b=hTyP8eSlVJPd0Bsd
	qHagFRVk3X3XciZ8GdXV9RHg1RDzMOd1oUkdQ5kN3edY0zsYIcvZiZ7MkdeDzPr8
	rJP7nAL+oxA7xllDnwzpc2ziVW8Q5sDJrSHtYYRzYIN1SbrejAI7ipEBc4ZZqtmY
	QkBVT4i33C3FV3FsJ3xQxjvPjXGdNHslth6pi+PP5HFg9wyQt64tGpOasBQY5WEi
	4JVrzLcQT/YjtVtYZnZv9BlvMohYfI3o+pRqOzbaT4MQYRwXGF2Q46zFTE/kmBj4
	tXM1kIK1azb/UbRzUfyZfbyNUSMsE96RuHYzue+wr077ANurJCizXjGO1eD6cVrF
	0AhpfQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h03ew2qdk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:34:43 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-880ed9b2e60so952266b3a.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790688882; cv=none;
        d=google.com; s=arc-20260327;
        b=GrEFFcbpVuaGIObSu/5iDA5UoZoSk3zcTwZly/hwWW2AjfNdweHTTqJ3bB3YCAOxwN
         W3RN8EgapKOD7gl9OkDoH6Xn8oTGE/wRVnaa5l3xaLNcbDBUJPVmn0qqB1jiHA3GxulE
         jS2KwtKXI4Qyz9R+eqLDuqmnSECmHh8ZV+eHrfI3+RCtiQIauSp9vscmc9Fq8Y+Rdy/c
         MnytZfxbG1OLOlDtrg4F2yHPRfaARQySJM528Hs58dCN4L8j84f66LWVknyXi6+oGvHg
         KETYszYGLNfEawBPezUDPRhtF2ICMkW39SC/MTqs2cVroj/ikd4Hc8KhDY/Sff83zoh2
         4x2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h6hMFw5ia2G/hTScfLWqNqOkXEUjQE/tTxXoScUVfU4=;
        fh=cH2vjZOpL5lBRBiLZV68dRTUFunux+sJP6NmQgLegOg=;
        b=SxTUY/LuzPHcpm1kVS5EqPviZto6G/d2MCDAERj1eOy3mYGzyiudH6NkAUXDlJN/v4
         nb88+JK0m4X+F4A+8DooaemK6zWsap7FoOzAdgcIR/2+L7Fhz+XVDRF3JSPX0uatuu+t
         x0aKPO1cfjSQ50PbY9XacyLB2Buw7rA5Dqji3ScmBvyl8pj9xwzqXfVbdw2hNq9u80k4
         CB4FDBlu/Tno8eLLLfzVSD11E2GLl0mdWFnmmwIKXGoMZcYsKzocqlmU6XY/gQourHs2
         7dI6/KgDtnzYXwD3F9h5C2qCuttKE0b4wHhB1jN9fcIp4gNWZhdtIG2wEYWP+CTnAT3h
         B9YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790688882; x=1791293682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h6hMFw5ia2G/hTScfLWqNqOkXEUjQE/tTxXoScUVfU4=;
        b=FGlb/88fS/f9HtUuH1fZM33kT2wSeuwH+5chOfnQ5zP/CBVCaAWR13M5El4gdBawph
         VEGISYNo/RJ7mmxhg460c1ZZFy7fHMyTnUwVA1j8GYUbYwF9L36b9P6HZ1CcMAvYbvTS
         FCnLLfzo5GXB1dz3ARx8nLzOUUzucZR7CiwW/7acbyvAvN4QeIndy5zBENHOkrFuNS8s
         A8yOIJxn8yCMNX27ohZODPqLw7gpx5jNKUxnWC20ko06VTubfsrzFdRBZcnGxh7//GeB
         yeEHWEOVIp/7qecrhWdPOBKnXJvwhJFIIcVk6cVFqzx5kdP9vA25aH1sge1WqzcvCm7L
         TMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688882; x=1791293682;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h6hMFw5ia2G/hTScfLWqNqOkXEUjQE/tTxXoScUVfU4=;
        b=Q+Ztzb1pI+9CEyzMcXKUlH1H42Hp9BnfpaD1PADGX0O/G+3zeKsFEQsuvjzFjxcYxe
         jY4pdZB7GHobYO38W2HaJ01r8t/iQIGegixwzNx4tnkQTR8y4u7B5JJkjFwROJq6Jjm9
         8uyp6gD8apyu+xQ36nGapgVfnlxzCYmFwVHkmpD09lMMeOozoQTWj8DZkGG2icWF7xQ4
         8B4407TBxLcCN56ibjfBEOkxqx5hEHENxUtDVH2olPb6mm2G75lyRXXQsl6xFusrmy/H
         yrO8PAub+8DBKEullq5ws+3/9GiuKTlpJc7ci7MJHAl+cu1RzmAyLg83a/UIz4G+oeD3
         84jQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFIZ767mWLDzmDLAKp3q8+minLeBSQkwmHbf2PHayysaMB4Q4Qf38/wUr1741y3HvlA5SDt3Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mhz75wsqh9TukJQN7YeB0zUyu7gh7PEkU/ETQyV3VkmMDe2Wy9
	PEwrtQZdjwpYrRYbuhD4DZZfvnmFCMoTbr3mH8mieGLcDogmZNe1AQkKQR5XGpnzowxoAfCociA
	Kh9wnDkCdXn0Q0P/RmvxBn4gnVx4Egin0dk/sfcZCs2/OohpPSr+YC+GiQZACtq9iXj34l8dZbX
	YN26lSxwjTR3zRufH5zriJgddvmc3HylwYrk/xuhuPTg==
X-Gm-Gg: AYBFou0wp+hL3awooeDkyRpWno6phkdV/v3+qr0bF41gwD3eArYzxUuUKg58ND5C6m/
	CfzGYtiFH5Dn5lMFP9F3UQ6DJ6ySjkeQn+PBWHdRoNVfxUYaPNkEjPBXGF1EoX/DQVfXSEn6b/a
	wai6s09pt3lC7SxBOo6PSw/c6xTaLvIxVreKiiEIZn8/7T2hyA7F+JE9KGVA==
X-Received: by 2002:a05:6a00:997:b0:886:5b85:48a2 with SMTP id d2e1a72fcca58-8865b854accmr380485b3a.54.1790688881938;
        Tue, 29 Sep 2026 06:34:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:997:b0:886:5b85:48a2 with SMTP id
 d2e1a72fcca58-8865b854accmr380464b3a.54.1790688881445; Tue, 29 Sep 2026
 06:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924192955.1941-1-rajojha047@gmail.com>
In-Reply-To: <20260924192955.1941-1-rajojha047@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:34:29 +0200
X-Gm-Features: AclHuK-bovqRIjls7emdb02spwwhD6QCaXt-S_uCJFs3KYOu2v1SrBo8RyGp0aI
Message-ID: <CAPx+jO_6Caq9OM=AR00YR5qe=WGBoEUTiWmdmfCTNfn3tP6YSQ@mail.gmail.com>
Subject: Re: [PATCH] memstick: core: wait for request completion before
 freeing card
To: Raj Ojha <rajojha047@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot+ccffdf05833ebdaeae70@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX1z/o/LjGvXwt
 t8M1BWnMb2sZMyjiAz3u5vOE/1VpoyPO/wtVWE0OSj1cC6W6nScijsgn3D4O8yDClYgT3AW1suD
 3UU5PRBV/h7QyqJdZYGOGCB/RR2D8D4=
X-Authority-Analysis: v=2.4 cv=IIOXmQvG c=1 sm=1 tr=0 ts=6abbbe73 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=edf1wS77AAAA:8 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8
 a=VwQbUJbxAAAA:8 a=OJ4-CXQFXB3o4ZXaK7MA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfXwz6aAydCOFFa
 KNWbBjmOSZy1ivI2LGbkoUWxxrB8JPcVE/HpO7uHxbaMwESfK0xIBpOtF8KOzXbz9HoLTS77swa
 CxPTXyucsUn2J/Epx8bquQJGLTj8qfMthCQwdWmgS7czLJiN/CZgYgXdv37u2YD//5ybnv6uUgG
 5nvQcDpcvVutyAb8AKbdnjjhnrK7kLNOqlYqDmoWDgHKgGuZFJRXOZb++Sz+30gMhwO3Em6YHCn
 ptW3XPSd84dX6NcrpP6c7KQ2BBAjpiH6dkcgUTaxSEnI3bRLnHCYr3CP9pdmzwL2kaBglpInGwC
 hjmQDL2vBNIZKg1JeMN0AoC7Dtt/oz4b2FfU1dmkO2WUNDuEXUiKhTZOfxwWnkFJG7lwk3mJQjK
 9kZbjj40tkMzE7FKgeu1pyPjrYfbXLaGaVB88WAfWs7t1WNRodbh7NB1WKGsU9yFgZwIbpYb2LF
 r5tffTHuMzxM2Ep06Tg==
X-Proofpoint-GUID: qimBc1tA5i1iKb7Ejp-zOfEgy3xA_m6n
X-Proofpoint-ORIG-GUID: qimBc1tA5i1iKb7Ejp-zOfEgy3xA_m6n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290054

On Thu, Sep 24, 2026 at 9:29=E2=80=AFPM Raj Ojha <rajojha047@gmail.com> wro=
te:
>
> In memstick_alloc_card() and memstick_set_rw_addr(),
> wait_for_completion_timeout() is used to wait for device identification
> and address configuration requests to complete.
>
> The memstick subsystem does not provide an abort or cancellation
> callback in struct memstick_host for in-flight requests. If
> wait_for_completion_timeout() expires (for instance, when a USB transfer
> or command retry is delayed), memstick_alloc_card() returns an error and
> frees the memstick_dev structure via kfree(card).
>
> However, the host controller driver (such as rtsx_usb_ms) is still
> running the request asynchronously in worker context. When the transfer
> eventually finishes, the driver writes into host->req->data, which
> points to memory inside the already freed card structure. This leads to
> a KASAN slab-use-after-free write:
>
>   BUG: KASAN: slab-use-after-free in ms_read_bytes+0x8fe/0x990
>   Write of size 1 at addr ffff88813c188079 by task kworker/1:5/5239
>   Workqueue: events rtsx_usb_ms_handle_req
>   Call Trace:
>    ms_read_bytes+0x8fe/0x990 drivers/memstick/host/rtsx_usb_ms.c:450
>    rtsx_usb_ms_issue_cmd drivers/memstick/host/rtsx_usb_ms.c:477 [inline]
>    rtsx_usb_ms_handle_req+0x557/0x1a00 drivers/memstick/host/rtsx_usb_ms.=
c:531
>    process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
>    worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
>    kthread+0x373/0x450 kernel/kthread.c:436
>
>   Allocated by task 1662:
>    memstick_alloc_card drivers/memstick/core/memstick.c:383 [inline]
>    memstick_check+0x2c1/0x10d0 drivers/memstick/core/memstick.c:452
>    process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
>
>   Freed by task 1662:
>    kfree+0x20c/0x650 mm/slub.c:6792
>    memstick_alloc_card drivers/memstick/core/memstick.c:420 [inline]
>    memstick_check+0x72b/0x10d0 drivers/memstick/core/memstick.c:452
>    process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
>
> Host controller drivers (rtsx_usb_ms, jmb38x_ms, tifm_ms, r592) already
> implement their own hardware and bus timeouts, and callers in
> mspro_block and ms_block already rely on wait_for_completion()
> unconditionally.
>
> Replace wait_for_completion_timeout() with wait_for_completion() in
> memstick_set_rw_addr() and memstick_alloc_card() so that the card
> structure is never freed while an asynchronous request is in flight.
>
> Fixes: baf8532a147d ("memstick: initial commit for Sony MemoryStick suppo=
rt")
> Reported-by: syzbot+ccffdf05833ebdaeae70@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dccffdf05833ebdaeae70
> Cc: stable@vger.kernel.org
> Signed-off-by: Raj Ojha <rajojha047@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/memstick.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/mem=
stick.c
> index 7f3f47db4c98..1a2b3c4d5e6f 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -378,9 +378,7 @@ int memstick_set_rw_addr(struct memstick_dev *card)
>  {
>         card->next_request =3D h_memstick_set_rw_addr;
>         memstick_new_req(card->host);
> -       if (!wait_for_completion_timeout(&card->mrq_complete,
> -                       msecs_to_jiffies(500)))
> -               card->current_mrq.error =3D -ETIMEDOUT;
> +       wait_for_completion(&card->mrq_complete);
>
>         return card->current_mrq.error;
>  }
> @@ -413,9 +411,7 @@ static struct memstick_dev *memstick_alloc_card(struc=
t memstick_host *host)
>                         goto err_out;
>
>                 card->next_request =3D h_memstick_read_dev_id;
>                 memstick_new_req(host);
> -               if (!wait_for_completion_timeout(&card->mrq_complete,
> -                               msecs_to_jiffies(500)))
> -                       card->current_mrq.error =3D -ETIMEDOUT;
> +               wait_for_completion(&card->mrq_complete);
>
>                 if (card->current_mrq.error)
>                         goto err_out;
> --
> 2.47.0.windows.1
