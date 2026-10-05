Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612A447207D
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194654; cv=pass; b=cbhAl/Py9Gq5ymBx9Z1eEVPl9r+GtJI1b83ybTUok+e/YGqXoTUNXoR7g6x7ZzwFtBTulQMiIiMLyOKRA6r9a3bzGTQ7PV9JW/wtHaQmynNYtmL/eys8eez0djJK7EWoHo1nCV5mmACkEFaFsf0Eqf1/aVeC6mipSNmKPnIu/VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194654; c=relaxed/simple;
	bh=k2spEhPKKDs1hsoa0+BsiKrY1mHQ2Y7FvSFpHY4YUxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQ2ZrHTiD9h9nwKONKczgCx9Wx3k1G3bDa+ChTxo5yFs+AthgA9fVz2tsEpY8nyRfiePO7f2fO/tehE3IvrLY5xyb3JPtzLPUxqUYM2P02SYFyg3lOSoaDirCTz6X580XeSnZC7/mIIb/e8RA/h8IMzZWjy8s463DxReUr5t1qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XkX5UsVy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SHHL/Th1; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XkX5UsVy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SHHL/Th1"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6958xRml1502310
	for <stable@vger.kernel.org>; Mon, 5 Oct 2026 10:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dqR2VsOJHxm1rWLbQhiJEicrbZzmNLQLjY+Jd8gYyV4=; b=XkX5UsVyg1u3Q0GZ
	KYC0Jwvkvw7s8pazgeqorwlp/VselmEAkfKgWvnWkLPezyLE2Kqr0/xmwc2P/mC8
	Cc+k9tgI/m56FIVgPauEGISOam4c7WOJF/njkInawNRxsCD3A2rcKXonm9r8yV6h
	PFuFwcMKS1CPxe5vsQk9K4Dpyd3Tpd0jQNDvV7gCrdFeU55xbiP1YMgdK3BbP5Ko
	8b0+t+NjBy1T9iLZHEbycfK3GF51lFlhB4Fy/CxpwBJnp0Oq+PLKofgV7juxTzKZ
	e1YrwottOZOGhmd96nDWHLdkr0g35ZKQOIoSoRZ77dIn2oXzk+OkGqAvKFm8jpJL
	VCQTXQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xgysmr7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 05 Oct 2026 10:04:09 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-895241d7405so17709287b3.2
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 03:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791194649; cv=none;
        d=google.com; s=arc-20260327;
        b=pP/t+AptexbSXXv39+HwLCX2Hg1P2P/I2/bzRkgS4Jd3IbJAXKkz44DM7g33DWsj7x
         d9gQDV41qnuiknsGi6J6Rc5UZud8XNHO/7a2kGGKDtdwgcQgocS8opndgt/KDjHsczAp
         RTzF+cjsTsoQQGy9BVobvU2e2cZRHtH7AvASvE+DA2SxqV4ok4+2zk1LnRhXHgTbJEvU
         bVFpMdeNGXv0Uw5nq24PXJBplRDTzGtjLbi68lFr7CxBZvowqrt8uLgJH8KPXW9clID4
         qtrEA8wo6Pbf5JDxO4RfnbC01fCT8QuKachS+KCPJ+gTikBZQRfpOt3hf2E8sXGZzwAx
         SOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dqR2VsOJHxm1rWLbQhiJEicrbZzmNLQLjY+Jd8gYyV4=;
        fh=wPco6QbSoZ2pU+M7qxBOChRWvwDdozoklqfWvq/pvVY=;
        b=edcsdK5RUba7fcNBgosUsgWGdMWAM6D15RbnpmkYZmcWIXVD4HWwR3pZ9cnnxajqSq
         Yib49dIQQPuNOTy/7paJR2gEezzemTQAZnd50tukIs2ItO3iV1UBsbfAo0JHk9SYBzqy
         DgmaY5aNTsQn8S8Q71cnLrw5Y1touthBJQztIYd2coa5Mlv2xQcpuIeIxWKyJ0zxMLok
         jdJK5KxHGHCGd+WwbsziYW4SdZU/KzE8b8IB3zAwAU1yMGti+5K4MBnxDYqDXMAwmd22
         H1EcEwSO4y6On9Ca4EhaOM/NzU6BwY6S7RWKDMLgTJXJ40vj0z/6Z849/0HlOOobeMAG
         Ojeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791194649; x=1791799449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dqR2VsOJHxm1rWLbQhiJEicrbZzmNLQLjY+Jd8gYyV4=;
        b=SHHL/Th1VwxGCqYvg5m4lEwQPab1n7yG93x3r+e8toSNy+udiN1BCZwDJwSNP1tAhV
         dma0eNfCzYjEIxw8csc08dnPhmsOIgw8CplT1ZJA7GBH1Vz7R/OAeFxuHV30qizUh9BY
         dUb1vbA9eno+n5i5T5hAul549V30pBeqB63P+qnq227kCldXCTdVa/pi6TyCGr9H2wO5
         ttM2ASNj/tbUene8gbXYinwZIXPNCpqiz6vX4iSN1lBdOzJFZE7rdTPoAVq//ESg4G1g
         BszMaFp9Tae2wqbR0y5dj4TQ+Uxr2dPI82/0mq6KhqCsB2EoG2SKW+Waspa7hi2ZKbHK
         VW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791194649; x=1791799449;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dqR2VsOJHxm1rWLbQhiJEicrbZzmNLQLjY+Jd8gYyV4=;
        b=UeAahrCttJNUvi/KEFTUi12sdZAESOoRHDrESu5bLZBfGgwiEBWZBabNZkcTxhcApv
         fDY98qY9VhHEY9uAm+lh2AowEfLgFdjLWbpEIm719jTKFIRDuIjYGFD2oPrbTpA70YQX
         9JP0BQCAFT4K74CJvw7CYr3E8+z2ERCDMCoRLHhNXzyu757VNvJprtcTVrV1ThSPgPaQ
         ZU/wXPNyhj6RMZxI1jK3Zp8kgB7yy/MOIo11LbStEM5Udv1ljVxnIUDGtezcXYAS4IIP
         ixUM4mWht21ZI+LdR//vx4y3vAwMOqmUEFwXrD6JJTgoOmm4hhpyE6YFZQKiuBqhdqI3
         IEmA==
X-Forwarded-Encrypted: i=1; AKwUvBwrTnfocMrMHMvMIrX8gZHUxXhZP3zCIDVgomkkDIvV3cW2Zvp/865rXfXYC1K/OGJUJrTY9tU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJD8jHS7zgNwTi0MkogleiXBMszoLeBAVnxOTZpeOm7kNZUDDYW
	Zy5iINXVGZoW2sVg5b4NL5tUdMnDokPXFQaGwbiaw+vRi8OQoI4o/Y2a5f8wVHunQ2qwNmgq7WT
	KNuLgDsDlOGr1qo8Mh9h1tFuIVAuasJ/hw1tDGCmRf9QvW78JMARoKp+YG327ggKPsQHmdE5vCp
	iOn+g03m17ksd4MdOkrIZmZxUtxBr/mjhJZA==
X-Gm-Gg: AYBFou0w0dlDhyI2vXptjLfLAOVTebNjiv6x3cGm7HtdaEJyH+wPFbw2dAzL9ERoA7y
	cMfWLfNCQwP9vIS/b64ojI+3CHcMxuxuOU6O0qqEKxUdgQZRJgKaBhOVvzfd4pLbOVBQbzbDBGw
	geazOsqLLPNUU8uCnlE8KN9rzRjbVF3qEREWnbYAfdzML+y6EqdEAMAH1c7ZI=
X-Received: by 2002:a05:690e:4808:b0:674:1cc0:3523 with SMTP id 956f58d0204a3-677abe3a67cmr2176023d50.10.1791194648655;
        Mon, 05 Oct 2026 03:04:08 -0700 (PDT)
X-Received: by 2002:a05:690e:4808:b0:674:1cc0:3523 with SMTP id
 956f58d0204a3-677abe3a67cmr2176015d50.10.1791194648059; Mon, 05 Oct 2026
 03:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929092939.1806907-1-uttkarsh.aggarwal@oss.qualcomm.com> <arzNOP4jBd9uqnGv@hu-petche-lv.qualcomm.com>
In-Reply-To: <arzNOP4jBd9uqnGv@hu-petche-lv.qualcomm.com>
From: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 15:33:57 +0530
X-Gm-Features: AclHuK9oHSdFJXWHB3qCGwtJHa-TWOaryqpxlOsBriiYH30mtE2nCh7iseTF7SA
Message-ID: <CAHBxaDc+pZ3+04iZsQwABrTEnbcFVi8oD7H5LP1ecyyOqQrziA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: ucsi: Set ucsi->connector before enabling notifications
To: Peter Chen <peter.chen@oss.qualcomm.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: InVdV7mawLMwoB2ilNk-sS-ViliKhbii
X-Proofpoint-ORIG-GUID: InVdV7mawLMwoB2ilNk-sS-ViliKhbii
X-Authority-Analysis: v=2.4 cv=A6b5rKWG c=1 sm=1 tr=0 ts=6ac37619 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Xu-oKv-mTIZ1_Gn-t1YA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzOSBTYWx0ZWRfX6k1GlNAZJl/s
 6Xe9cHzF0qK/wbhL0mbHCB/Agr7pNReSMQYpxAzBwjBOJL3Z1NV3bMuUkneDHTYGbWKRWKoCBWl
 foli6GveLmkBvPdqvPPm3IXTrPCOSIMCeN5CHsYCIrRfNk7DBiHMA84P4RjD8sme29Rhp6XuyzV
 ZRIDztfLCXsNLReNElnpQs/MwfgahJIbyla8Fq6uOPXUbdgYtLKcAGZXTK3MRatE27IhR67XRjK
 xxtv5pTpB3wVG70HkkaJAX9EF+Edaoho8RP3L8Sswm3oPlW4gafGDbQdODU03wX+fECb8klS1Fe
 Ki/KbWksRcIagAKd7wKDWHB3eDgxlcwA4/PR43DL8mwnhiivtSfhEq7elBuXyU+HKYPKPVlsFJt
 k28FIZXkU1SIqijk7g6VhZno1POlJWWE+7/38kqRUD+oBJTiBf4Ib6Hv7IpEByw8Sranv/zNroc
 0EaVZ25VZotleOPxB/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzOSBTYWx0ZWRfX0zUDtsUwKt1i
 RKEeClE4k3uwkzGvr5+8X/4Czw6ZtJgEbRfupaZaIU/oIF9RvgwkxYTplDAFT3ezV9LsTgCukE3
 kgCZ5MSODCidzfo+BzGVKviKhPoe1/o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050039

On Wed, Sep 30, 2026 at 2:20=E2=80=AFPM Peter Chen <peter.chen@oss.qualcomm=
.com> wrote:
>
> On 26-09-29 14:59:39, Uttkarsh Aggarwal wrote:
> > In ucsi_init(), ucsi->connector is assigned only after the
> > UCSI_SET_NOTIFICATION_ENABLE command completes. But once that command
> > is sent, the PPM is free to raise a connector change notification at
> > any time, which is handled through:
> >
> >     ucsi_notify_common() -> ucsi_connector_change()
> >
> > ucsi_connector_change() indexes into ucsi->connector to get the
> > connector and schedule its work item. If this notification arrives
> > before ucsi_init() reaches the "ucsi->connector =3D connector;" line,
> > ucsi->connector is still NULL and the driver crashes dereferencing it.
> >
> > Fix this by setting ucsi->connector right after the connectors are
> > registered, before notifications are enabled, so it is always valid
> > by the time a connector change event can be delivered. Also clear
> > ucsi->connector in the err_unregister path so it isn't left pointing
> > at freed memory if a later step in ucsi_init() fails.
> >
> > Fixes: 0482c34ec6f8 ("usb: ucsi: Fix ucsi->connector race")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
>
> Reviewed-by: Peter Chen <peter.chen@oss.qualcomm.com>
>
> It is better cc the one who gave you the comment :)
>
> Peter
> > ---
> > Changes in v2:
> >  - Add Fixes tag pointing to 0482c34ec6f8 ("usb: ucsi: Fix ucsi->connec=
tor race").
> >  - Add Cc: stable@vger.kernel.org.
> >  - Link to v1: https://lore.kernel.org/all/20260923060434.2599545-1-utt=
karsh.aggarwal@oss.qualcomm.com/
> >
> >  drivers/usb/typec/ucsi/ucsi.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucs=
i.c
> > index bef3f9b71d71..8f7b73a9f4f4 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -2122,6 +2122,14 @@ static int ucsi_init(struct ucsi *ucsi)
> >                       goto err_unregister;
> >       }
> >
> > +     /*
> > +      * Set ucsi->connector before enabling notifications. A connector
> > +      * change event can be handled as soon as the notifications are
> > +      * enabled below, and ucsi_connector_change() indexes into
> > +      * ucsi->connector, so it must not be NULL at that point.
> > +      */
> > +     ucsi->connector =3D connector;
> > +
> >       /* Enable all supported notifications */
> >       ntfy =3D ucsi_get_supported_notifications(ucsi);
> >       command =3D UCSI_SET_NOTIFICATION_ENABLE | ntfy;
> > @@ -2129,7 +2137,6 @@ static int ucsi_init(struct ucsi *ucsi)
> >       if (ret < 0)
> >               goto err_unregister;
> >
> > -     ucsi->connector =3D connector;
> >       ucsi->ntfy =3D ntfy;
> >
> >       mutex_lock(&ucsi->ppm_lock);
> > @@ -2143,6 +2150,7 @@ static int ucsi_init(struct ucsi *ucsi)
> >       return 0;
> >
> >  err_unregister:
> > +     ucsi->connector =3D NULL;
> >       for (con =3D connector; con->port; con++)
> >               ucsi_unregister_port(con);
> >       for (i =3D 0; i < ucsi->cap.num_connectors; i++)
> > --
> > 2.34.1
> >
> >
>
> --
>
> Thanks,
> Peter Chen

Sure, Peter. I will take care of it. Thanks for the review.

Thanks,
Uttkarsh
