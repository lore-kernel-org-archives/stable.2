Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A9E434994
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788959454; cv=pass; b=ZD1GxlAF1uB3AYOwARD1G1X7QhRjXXPdheYTZ3okA6iuY2BaPp9ofVeUE+pJtN7DyOtLDtyR46+3e6UVT65tfY0ytxPltIJ4ZpNzVX21NSRuxKSDOBcNd4s+0/z5SEQ+uo5Scs14VWcKc6OwHlTDAqWLU2TSB3X69o/NcG3l2Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788959454; c=relaxed/simple;
	bh=USoy+/1sjsE8gM7fL1ZzAANxBJA3GIi2oiUUyXweKmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nneov6ZsM4D64RmzPIGlN/QBKqO8NViDycE/eI+aIQrY4O+bQM8iMk8ZTaEbmUfq6Et77FIxNUn3swTiO+9NtkJKpMshRz60MdwrrKk96FD7FGl20k6zpMA4fF/HXm2yJ5HBtQNCUBXKRcMijSP0+Tj5WvPrVKwZqIH4ErHdq5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W+6uoT1W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hUkRFlsA; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W+6uoT1W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hUkRFlsA"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BUFAP1183852
	for <stable@vger.kernel.org>; Wed, 9 Sep 2026 13:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e18YgiYDcY3A71+s9t6tnvZG6iOI2p470IJGpWf+I9Q=; b=W+6uoT1WlKKJVmm6
	jBFUof9ktWt86eS+f0SztMAYfbEm1jpajPKOOEG47A1dnbqWamS8WJ1bGOrBVd9l
	2sLqg+iirSIIFwzCjnOeEMp6o9ZUmg4oZHbsquZhFbPw9HAkWu7v5gUtfIZAcHJ3
	CZTaKI9AtVZ2+4iDIY+8p+Q/JVBnuHnnGTaSBI1ynpvynT53D5IfdATiX6QYNjF+
	wujvbVBDOr0SVnoOmi0QiJL0JeU1k+nbnYR2WUhLwbUKd35I/P2vvITs9bVbs8ks
	guuL2/Pc8lAXQzLTPu1IyfAUUgCitjzdxddOusL2++iUQGOftvJ04tLjs+aJt/0P
	PNtjCw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk559rqyn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 09 Sep 2026 13:10:51 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90e80ce3597so104782306d6.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 06:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788959451; cv=none;
        d=google.com; s=arc-20260327;
        b=Ou4/DIkfe4mgydkglraiJjI7G9TR8I0iuxnPbahImRkccIRDDtd+w0lNMtvbAOB/mQ
         /t588UR2CdyRphETgXT0zlwKZihyXe+Dtpj3rmfQ3uIlStULDT47jwsP0KgGwkmsxCa3
         hqc8AifXIGXsoyuB2Wu1Q9iD+NHB6hRU4yhBfW0v2FQ9zWeluWT6O1ZSlJe3IHIl7ovq
         8wBb2Xyuf6E0i6ur2fAHVOyclsYfIBfZR+Z9qsSTLjGSkGEr3MG9IzTXyK1+q5mgBbXl
         EeeUz46C9G/VOhGCZWfzDClxainvY8L6lPFsmGisFCBTjN5C7BuAZS1xS1OU93M+mYRB
         /ZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e18YgiYDcY3A71+s9t6tnvZG6iOI2p470IJGpWf+I9Q=;
        fh=cLhkxi7ouBi/ClWgC4nJNn8Kb+AhsTJw5Q3axh+6QFo=;
        b=iKtn9qVrFne+8TO93FMkv42Y5mD91XD3x0uFN6iIMeK20EvFZttHDy2szy/x7LcJGF
         kAyAggP73oBQmcT3fZOAsbteo4NXgl98Y+T/L+j+6GNkQ2i0nv96DlKbdunpRxVI6Zir
         1MG2UHuHWj/66scXHKrskYvyZZjRK740h7ghzwInHvt+DnwllHV7FpxIerkaI9seOMFF
         VcUIAl5ZSsFqNtlSIe0KeK+5XBDbfJsiOJ2HEdzpdMzUuDtor8r0sIKaqr0wlTJw01I9
         WztV01iV1U+GLL/EYLfidwn9dn951JTUYP14THhBjmKZv+m8kvCucbnB0tEKcDVQ19cb
         YF9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788959451; x=1789564251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e18YgiYDcY3A71+s9t6tnvZG6iOI2p470IJGpWf+I9Q=;
        b=hUkRFlsAozcU5jMUt2n3tKSMsPMgcWyt3sBf4i5Nec89h6tvg8oW5f5R8N17b9Piz8
         OtSLy/zkDFKsohLlwwaaTyadaR6hTd52GaIZHiJcd8jQTHkGEfrVbAXGYZ3yUafP+bC2
         /TIJLklurWNhJkD83ywFsFdUXy/M9w3pnn39Qd3s/bDkvCa/1Kk39kOE/8E7QgdECUs9
         WIAK6p74lp/jRQKzE2kEY9MkrxjTVjzCLCN8dP1oIBoRaHy8IN3NYe36zuo0T36Au7uC
         0jAOinBR3NZVbv4N4B0TNtMLFl3LPSAslfKzrFrstiJ36UjkZU4VWqZBkFxIGO4sRSyV
         f4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788959451; x=1789564251;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e18YgiYDcY3A71+s9t6tnvZG6iOI2p470IJGpWf+I9Q=;
        b=VTzjcFCbVMkgXMbj/2JlemqDYeS4G8gq8Bnvg6y5iLp+4dQFbca5SmkVieL1rzBdKW
         OrsqQ56JBn8tactwG1NDxgN7ZXQrAicTFHGfHtb+rUALL2GaA5yvVxMANQHs22lAyxje
         sKj7sqKGfCpnetfaOlVVTv7oG/Tz7WI4LwPzyj2R7TCICj6HVLsZf9Zb1jINCcTlaI/F
         woLA/zBNd7oQix9Fgcp2h7RJfF3+aOpF77+kzE/XMzG6Ykc5s1DxNEdktYUNYEzGDBxd
         yOe/VSkz6xDCrlnX6u831Mogx+Hc17g8bC2U5zOZkuD+g+oZiub638y1qpkAzbTImuRh
         yV4A==
X-Forwarded-Encrypted: i=1; AKwUvBzvQRZzfgCNmnf6iLF5Cv+58tKwsZi8MSWXK7PDLGiNplfCLB+YWPLxoNXVrdleFBImX0WNqVU=@vger.kernel.org
X-Gm-Message-State: AFuF++mDMx80GUSBzXn+nxhPiDT8rqhPIiwP7DQimQMnf3WiE+D7I1Av
	BMT4Yv7Slk1SLREH5j0hi6BTHYhW9G4qnOUjCE0iNc6pnS90SYWrtGen5k1FtogkTnWgrgcchiH
	Nbc8WWm+NbGBNLpl3/MjJNOMLfqMmBOKLuBcSYuDsgUrRaFIwt5eDlODDQq/UPbkETvF6xlmRU4
	QtWvRu1ki7LSCq59uP2wivXBtZ2CaZEPQFXw==
X-Gm-Gg: AYBFou2YP22dkcANo4mm5YsRZXuk5SaHUFztIsGQW1Ya7QjYsBYOjC598bYd9I/8Mc0
	4xliC07JZOYfDoPXMKPECW0JUTaqFf5dl3tKn5bwYdZsuKCiTcbQRJmK1tNrJpxPhHnk8uLD38l
	nB0T2QHPT73X6ekCe4lVaCrUEZQMiG8M5u/jmjWED3feQP4lPg3iM5rbe+hWByoFQzWL8TUU1aG
	a1twYu2hCXhvYefR0kfLmT9pq7RsC49hY/hk4Wy5idg1aMatQFYWqXek0TWj/RczTviJ1HIWtE=
X-Received: by 2002:a05:620a:3186:b0:939:c9e9:81a3 with SMTP id af79cd13be357-939c9e9e6d3mr648184485a.30.1788959450554;
        Wed, 09 Sep 2026 06:10:50 -0700 (PDT)
X-Received: by 2002:a05:620a:3186:b0:939:c9e9:81a3 with SMTP id
 af79cd13be357-939c9e9e6d3mr648177885a.30.1788959450098; Wed, 09 Sep 2026
 06:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909054401.718959-1-zhugl3@xiaopeng.com>
In-Reply-To: <20260909054401.718959-1-zhugl3@xiaopeng.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 15:10:38 +0200
X-Gm-Features: AcwNN1XRBsJQUp_8Vo3_MALJlQYTHzC-PLbfBluaOY_sDn4qJVdQudxsA1DY1GQ
Message-ID: <CAFEp6-2xNNJ_uNV+fuY8hxcURW0+zoiKgCV92+10PR7oZn_UEQ@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: t7xx: validate the HS2 message data length
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=KP1qylFo c=1 sm=1 tr=0 ts=6aa15adb cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EgahoUkMAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=jOW7-oFJvRO1IEPcfKUA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=D2SkTF70-_n5gOfERQdM:22
X-Proofpoint-ORIG-GUID: inEhfHPXK-2SjBenCqOQ4I8_DQ2zJ1lS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE0NyBTYWx0ZWRfXxki5SmTNx1J2
 /lt5+MbNaY/PO0fAlOhpveY5yKimipi5vPs33zRNFCCQOteeQokeRGNfmbbHvBo35jZFvbszPtX
 4Sk+Y6bIq46cbcV5Uaq0VV07mIEEQV0=
X-Proofpoint-GUID: inEhfHPXK-2SjBenCqOQ4I8_DQ2zJ1lS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE0NyBTYWx0ZWRfX3JISsfsBBgYP
 Hu8+Zoob8TZOy+Xit04oZYooicS6lhM7wwMYAhnBI0jAiTDZpNuFMBZzT1JvNH57F5RrY0X/vDl
 qSxgw055/cLJ1FsOrnVmjaMjuLoLg8+5zSi79AQruI9eAyukYBm2+xT5suU/hEzLHjyuPWdwvrp
 TrG9gDIBgMRuDwnM1EMoKhxdUb/XsGXF78ScGIDbK7ObuZVAfAoL3pZq0HFNYNyLNydfn7Rr1Jv
 +o8OnPBVyQitMV0HHP4X4FpukSE4Qyq6n7P0usqpQAZvOb5w+4e8bFl6Qx0Ni7daHP22bNmqjmE
 n7LHJYTLtHsVEWaaFhxnV25fEwXK/gyLZB4fC5wzKvbi5+Y8biEUMt20VKjQuK1XJel3apxeRmV
 L+T1UpGI6C0A+qJnMr8XxSOEDauHJHmVKDrS+4859OPHUy/Sx7gdCwlRuyzNF6EzsOkVz6bP60F
 wUv8kuTrj8jzyoysjVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090147

On Wed, Sep 9, 2026 at 7:44=E2=80=AFAM Guanglei Zhu <zhugl3@xiaopeng.com> w=
rote:
>
> control_msg_handler() passes the modem-supplied data_length field of a
> CTL_ID_HS2_MSG message straight to t7xx_fsm_append_event(), which
> memcpy()s that many bytes out of the skb.  Nothing compares the field
> with the actual length of the message, so a modem reporting a larger
> data_length makes the driver read past the end of the skb and store
> kernel heap memory in the FSM event.
>
> 0e7c074cfcd9 ("net: wwan: t7xx: validate port_count against message
> length in t7xx_port_enum_msg_handler") added this kind of check for
> the port enumeration path but missed the handshake path.
>
> Reject the message when data_length does not fit into the skb.
>
> Fixes: da45d2566a1d ("net: wwan: t7xx: Add control port")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>
> Verified in a QEMU guest with a fault injector feeding the driver's
> control port thread a handshake message whose data_length exceeds the
> skb: the unpatched driver trips KASAN on a read of 8192 bytes past a
> 500-byte payload, and the extra bytes land in the FSM event.  With
> this check the message is rejected, and well-formed handshakes are
> unaffected.
>  drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwa=
n/t7xx/t7xx_port_ctrl_msg.c
> index f869e4ed9..0f2ead8a7 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> +++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> @@ -178,22 +178,32 @@ static int control_msg_handler(struct t7xx_port *po=
rt, struct sk_buff *skb)
>
>         ctrl_msg_h =3D (struct ctrl_msg_header *)skb->data;
>         switch (le32_to_cpu(ctrl_msg_h->ctrl_msg_id)) {
> -       case CTL_ID_HS2_MSG:
> +       case CTL_ID_HS2_MSG: {
> +               u32 data_length;
> +
>                 skb_pull(skb, sizeof(*ctrl_msg_h));
> +               data_length =3D le32_to_cpu(ctrl_msg_h->data_length);
>
>                 if (port_conf->rx_ch =3D=3D PORT_CH_CONTROL_RX ||
>                     port_conf->rx_ch =3D=3D PORT_CH_AP_CONTROL_RX) {
>                         int event =3D port_conf->rx_ch =3D=3D PORT_CH_CON=
TROL_RX ?
>                                     FSM_EVENT_MD_HS2 : FSM_EVENT_AP_HS2;
>
> -                       ret =3D t7xx_fsm_append_event(ctl, event, skb->da=
ta,
> -                                                   le32_to_cpu(ctrl_msg_=
h->data_length));
> -                       if (ret)
> -                               dev_err(port->dev, "Failed to append Hand=
shake 2 event");
> +                       if (data_length > skb->len) {
> +                               dev_err(port->dev, "Invalid HS2 message l=
ength %u\n",
> +                                       data_length);
> +                               ret =3D -EINVAL;
> +                       } else {
> +                               ret =3D t7xx_fsm_append_event(ctl, event,=
 skb->data,
> +                                                           data_length);
> +                               if (ret)
> +                                       dev_err(port->dev, "Failed to app=
end Handshake 2 event");
> +                       }
>                 }
>
>                 dev_kfree_skb_any(skb);
>                 break;
> +       }
>
>         case CTL_ID_MD_EX:
>         case CTL_ID_MD_EX_ACK:
> --
> 2.43.0
>
