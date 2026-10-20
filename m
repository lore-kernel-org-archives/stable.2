Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792496584;
	b=XvOZk6QXdgImDJny83Vd4HBgZl8mQU8wBVdmEQSxQq8jQKNbaLBPnYaDhVvebY7nJwmI
	 KAbhrIgK29wSp4dbUHnD+Cj2YZ8WoSOUiXAIl7rmsXKRlz7RWyfWwG+EUZEEFLeY0emy2
	 RnAdo0GIGwPH9l5OFdLC1kei3DiTrmfsxf7iFc1JQlC8pFzhVLiQtu/h+0nhMhePqGrDa
	 ebGAEDt+qD3V7Bww5Lc/sWoyoRlwBAiP0lu7slcAceSZ805jvBcWamEulGcWRDu0cfRDc
	 wJX53Rklyc5i/wWYuT6u4zxKnpU8bTViEfRGg4OF2Hk+NYoTI/u2WJNq2CoZ1blMC+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496584;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=R0z0X7rWSX7hGljFOOUTHJ3FuqKHQLBWO6RR8SAZGBQ=;
	b=qh8+3cwviZwgxf0bwk45vmSWe71mj/KCFfQtvh44surex0xVIL6L4FUiJzjv96K2TMvg
	 BDcuadmSpXGGytqPJXZ8IrCS3BOijtsOse2hXKsETAc9JoVCobyKMahE8cW4Ra69+IANm
	 zD6WpCsPT39I3Z8XaAMZFkVncT3o7fnflYSQlAsoje2dCjHHUpeKX3koCr3/LCvjy2BGa
	 aadlRmZ82Kxcugpo2Ma14kCitOUBSEjlgTvCMrWU2UduwxaXS2puNYAjcYfros91wL+Ia
	 nH9NpvVLUM0Jf4MZiP1gZXwHaC/QxA4mZNM0McfyXDBH3FBppzEDtz3EE2U1fuF9YYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k9PKX0RI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WKcKA9hU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201FB606A31F
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 11:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 201FB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k9PKX0RI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WKcKA9hU
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KAxW3I2525089
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 11:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R0z0X7rWSX7hGljFOOUTHJ3FuqKHQLBWO6RR8SAZGBQ=; b=k9PKX0RIS1XqcBpu
	qa8Yj1xfUwMHMkwx6UGmrUKVIFrpZSBmCsgxlyls2gW4q3j2+fgLzQAV6R5OoAFr
	/1vddzq+CbUHecPgU85Zmz2XN0LC3O2x/n8wmK89eqIDqGCG7w38HUfLj3Gwjzjt
	5hqGTf7DDpK+eI8MwCRzId0GXyAZD7+HuA5hyMe6OJm0O1r3n2fsZ52/9cSBk+27
	27qdk5xYbXmkFrWHm7BlZYmezMLBPGB3AFyj6xZTmdjAKRbdEICJXyScr4h6HGFD
	XJFphIhQ29tiIreRYTyLqv4GYVaGBnbQdumMQfz9Za27zVZDZiR86g8AxZydws0v
	LbUePA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5p29ws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 11:43:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f2c0e6653so558895385a.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 04:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792496582; cv=none;
        d=google.com; s=arc-20260327;
        b=jPM9SIWq38KOnEB6kii34e+s+URG4AAO/hz5W87EHaxogowLd2Jf3RfDv3WjR2ndzd
         bHruDstfoF7LwCUl9s8l8cb5BBqZLzbtpZRRModo9ydMBC3Aua6Hc4iP1UjGzbktdai3
         ce0C9/zD8W1MoMWxQuZ+Xf/12DYzWXOhvhVS0ayKJmNayimMIvZ44X4gI87k4yUuZZdt
         6kgPehSleDP0clb67V+wOKDo7WWVD+CEJlskJZ9ldvalNijHvpOG+lzKW1Y1tWn41ScL
         iWckfkWf9JP4a5dY083sluVokgQFf32cPo3/Ugi2oDGHY5BkYdzpwWsNcPWfISvHYkEH
         goEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R0z0X7rWSX7hGljFOOUTHJ3FuqKHQLBWO6RR8SAZGBQ=;
        fh=tPjpOHSxOPzTVwM38QvT7CMQieXTY60zc1R/E8ECZyI=;
        b=gh4kAot1bESzgz5XvETFq2bFCvTwZ5xYpZxD5PJvlBQK9/Hd5XRxrklF4HgECUmCw0
         azW8/xivx86l9w/lFW/lAVnbDhOP4GQk8cJ7OgVsoa9zD2eBvc5Nw/TvekmVHmCUBWP0
         nbVqAwkcqTTzpBfF23Qv51kaBNfsCZAeYoOUJHBdVR2lNKKS3j5JhpfNcYawkWBs6KuW
         SrSlcniM8PUvcwhHFz0bigRUduxos8Bemit+52SQ8gAqY0nwyRZQzcH+Su3wf25JAOJ/
         4rKOr4wZb9odM2HmQeACLBIK+HVag6/UiHR9T+sKLkEqHr43mNPojEtP/wlfWjpOnqJC
         XB0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792496582; x=1793101382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R0z0X7rWSX7hGljFOOUTHJ3FuqKHQLBWO6RR8SAZGBQ=;
        b=WKcKA9hU9oHBpj/2Mj9p5SA4pn8JQ3H148t8bOHq7J1mc+TdPOItWTSnvvdgT1u2/3
         gxSEI5JxUvfVKEvR5RauLPGBbFyS4GjY2S4WlHsuHWnZSaXH88g32/saBqtHHeyz6iX5
         LH/j18YaYvuFOo36OqxS+50LDI+5mR1aUVstxrsVZL5ue7hycCj8fbBoepxi8UQbcCKM
         L3dZRXlUe6LP98vibo8cUEnh2hivgMkD16V3BAdf5w90oE1+53gznCZSAPjwW2oe+smq
         h3rAriOfYnVvMk58rZR3EZbKgixLJBIM1q+dBJNIxQbsINiLsPlN4Nu+DQzSSeNbsL3j
         0Szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792496582; x=1793101382;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R0z0X7rWSX7hGljFOOUTHJ3FuqKHQLBWO6RR8SAZGBQ=;
        b=jf2qgQLbOK8ybPQBb4uUJbvuygyf1F+BJ+MlUsI7Jh7Y3PSh1Gznvj7vxzPFN0skmU
         IOga1KEOU5LrPLkXLBrEtosmnCyMWiE0icQvUEpIP4Rx1R5tD86BtR6RnxLhDQbwBzNA
         mHdCt35I7YZTLXG6k/bH6fHBqvTWoVn9hNXLaS2/Xm8QIITGpAgXyzdlcn1i6gInAjaH
         oy1xS05dsrByk65rm/ufB49WjzA1g6bOqqZVXnrNJiq/L95m7wHXvFQx9mxEWhFl+w2N
         ZWc1ak6ntrHuNzfDgBnUck6Y4iT0rlGdvfBK2TuoipYaJHTjee7kWb44Iv1/zPvNTxvy
         maTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxM8MKiL7VkScdHiBd9Kv8t+Tzb6dJuDGVJmS304a71DTaZZzN/OQBrVUVjEuYizDic/jsrv18=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIU/DcUyODjYBBagtFqJ7kz/Yv0YdCi3lJ9nE9oxs1SPUnKKoU
	lN12xaAKxDFZuTNf/C61FcI/UnlnziqC3mJvGQ0+zp1bGqHn+4tRL5IKFIo4ChBWySaonnConht
	/T4H6LBgLodAz/u8PaRGOQyawxy5pZqrAgAYsIGvGKfvBEiikyY9RRDEW03yhdD3dCTKpVhZyUZ
	dXXQFcGOyHHGparARJ3C6nOwA4nbsQTXLSYAmfC8U7gw==
X-Gm-Gg: AYBFou3lL49b8U3Vu1aEkG/MdOoZDw7WxS2Qo6PtZIrtyLcYyvq0Q/kPv3l/VvaHFek
	v+/4lDZHdTlv35rDUNNQ3wwd3CMF/sew4pR4q/evS7e3O2URu9Hv2LHqCoQ12RpkfbJvwdzGwBm
	SDDhRVGLAFYksyu7+9wmOFTicnkcVTfXM3fTVYUO8a/Emrg+0ZIiAT061oseEfJVzbHZfy3kB/1
	F/H6KPN5do7H/rukbZrLHKm74wLyMReJ/+uxP0/VGrKWDbaux+vrgp0Oc6fSrgFiE8Rmj68fr4=
X-Received: by 2002:a05:620a:294e:b0:93f:24d4:ecf0 with SMTP id af79cd13be357-93f29d6f5fdmr1786551185a.47.1792496582388;
        Tue, 20 Oct 2026 04:43:02 -0700 (PDT)
X-Received: by 2002:a05:620a:294e:b0:93f:24d4:ecf0 with SMTP id
 af79cd13be357-93f29d6f5fdmr1786547285a.47.1792496581916; Tue, 20 Oct 2026
 04:43:01 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019055109.49922-1-slark_xiao@163.com> <CAFEp6-2XUE4AQPm5hinnRGyrrsHok2ftsFXragiHgDSKKtKWow@mail.gmail.com>
 <70714501.3175.1a157532149.Coremail.slark_xiao@163.com> <CAFEp6-3o6gCb61hCQTJydiH2aD6CBVRa947tpmLe4L9j85Jg5w@mail.gmail.com>
 <65d8a1b5.8e5b.1a158ddc4de.Coremail.slark_xiao@163.com>
In-Reply-To: <65d8a1b5.8e5b.1a158ddc4de.Coremail.slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 13:42:50 +0200
X-Gm-Features: AclHuK8BuO4jl__rRfhaUS7jXOaRUiW_m7JFZ3VPSObwRmR_MtAJEM7HTIQLf14
Message-ID: <CAFEp6-2LSJaKHwZdgdHUzJpPF0H+jGXpHgy3YEPzJR4oAFUTgQ@mail.gmail.com>
Subject: Re: Re: Re: [PATCH] bus: mhi: host: pci_generic: Update the default
 autosuspend_delay_ms as 5000ms
To: Slark Xiao <slark_xiao@163.com>
Cc: mani@kernel.org, jeff.hugo@oss.qualcomm.com,
        krishna.chundru@oss.qualcomm.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: KoVlLDYfNc1X0YKXEkZvPkQr4IL6WjH9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA0NiBTYWx0ZWRfXzQrcvSjFlX17
 8+EqULKmJOLnwC2Ue5sBwCb4LNQXP7zE4pBqgcn+JNWlblEySZZICMVfy7FI8UR7/ruZIda1aw0
 NN/FwQGuWtXuOQ17tArgVNx2tTnGgto=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA0NiBTYWx0ZWRfXxUI5biz+yPEy
 wwI7DdnViTzvKhAiiQeH6/fBAVxOSXGqRfjjJW4+hngvP1aPQqeNCT0di4sLKawnWHiOxoQlxTd
 DUmlCc8xGyQ+AsiSdJn/nCTvOg9uR59gvEkrvbl1Ym4PAo9yTGSD4cOHXOHdHnjcS6k1rbsBMQH
 CX1dQMVJ3+nfjgwN6xOatJk3f62IIFYdbJwjFcLFZK38dkLPK+j+cCgBQXqddFbAoy9YCgOnNuk
 X8qztpiLUmgYi59RQWyICeHVPZusUXjAUHyKXy2kQWPFo3ZD2610+wCzHsLF0mSNJVtlDX/zXJ4
 li1m16LMtAfi68PoPZ0QdGXqxsz+a1GHs8mrH37PoaYxE6YXTPktPr70W0Sff3cFnQV76wFg5Kj
 xIjd97dAfWkSEqqejZh+4sSbFiuXpTgy7/j9Zg3l3jCPiyE2H3Jb2jf9UyuVMigh84oseutomIU
 VxUzCO2XcdvjLa3HR9g==
X-Proofpoint-GUID: KoVlLDYfNc1X0YKXEkZvPkQr4IL6WjH9
X-Authority-Analysis: v=2.4 cv=crUOAF4i c=1 sm=1 tr=0 ts=6ad753c7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8
 a=aMfntx_4cxk6xlV4G7oA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200046

On Tue, Oct 20, 2026 at 12:31=E2=80=AFPM Slark Xiao <slark_xiao@163.com> wr=
ote:
>
>
>
> At 2026-10-20 15:27:43, "Loic Poulain" <loic.poulain@oss.qualcomm.com> wr=
ote:
> >Hi Slark,
> >
> >On Tue, Oct 20, 2026 at 5:20=E2=80=AFAM Slark Xiao <slark_xiao@163.com> =
wrote:
> >>
> >>
> >> At 2026-10-19 15:41:27, "Loic Poulain" <loic.poulain@oss.qualcomm.com>=
 wrote:
> >> >On Mon, Oct 19, 2026 at 7:52=E2=80=AFAM Slark Xiao <slark_xiao@163.co=
m> wrote:
> >> >>
> >> >> For some MHI devices in some specific scenario, the default value
> >> >> of autosuspend_delay_ms may not enough to handle last wake event.
> >> >> This may lead to some unexpected problems.
> >> >>
> >> >> Refer to the Qualcomm's Windows settings and we checked this with
> >> >> Quaclomm over case, Qualcomm recommend us to set this as 5000ms.
> >> >
> >> >Qualcomm
> >> >
> >> >> Qualcomm also suggests us to update this for all MHI devices.
> >> >> Since this setting has affected some existed kernel versions, it's
> >> >> better to be applied to stable version.
> >> >
> >> >This looks more like a workaround than a proper fix. It would be
> >> >helpful to describe the underlying issue, including the timing and
> >> >sequence of events that make this necessary. In principle, either the
> >> >device can be suspended at that point or it cannot. Relying on a
> >> >delayed suspend feels fragile and may end up masking the real problem=
.
> >> >
> >> Hi Loic,
> >> Honestly, Qualcomm has been analyzing for over 2 months and still hasn=
't
> >> identified the root cause.
> >>
> >> Actually I have explained the reasons behind the events to Mani in ano=
ther
> >> thread, you can refer to https://lore.kernel.org/mhi/20260919095506.95=
70-1-slark_xiao@163.com/
> >>
> >> From Qualcomm's perspective, 2 seconds is not enough for their default=
 design.
> >> They recommended us to update this value to 5 seconds and Mani checked=
 this
> >> internally as well. So we decided to update this 5 seconds setting to =
all MHI devices.
> >
> >Thanks. I'm really surprised we still don't have a more precise
> >understanding or description of the underlying issue. That said, I
> >think it's reasonable to proceed with this as an initial workaround.
> >
> >Could you please send a v2 that introduces a define for the 5000 ms
> >timeout? It would also be helpful to add a comment explaining that
> >this value is required to accommodate the 'late wake-event issue'.
> >
> >Regards,
> >Loic
>
> Do you mean something like below?
>
> /* Add define of  initial autosuspend_delay_ms to accommodate a potential=
 'late wake-event' issue */
> #define MHI_AUTOSUSPEND_DELAY_MS 5000
> ......
>  -               pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
>  +               pm_runtime_set_autosuspend_delay(&pdev->dev, MHI_AUTOSUS=
PEND_DELAY_MS);

Yes.

>
> Thanks
>
> >>
> >> Thanks
> >> >>
> >> >> Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtim=
e PM")
> >> >> Cc: stable@vger.kernel.org
> >> >> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> >> >> ---
> >> >>  drivers/bus/mhi/host/pci_generic.c | 2 +-
> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/h=
ost/pci_generic.c
> >> >> index 7193a384cca4..40735beb46cb 100644
> >> >> --- a/drivers/bus/mhi/host/pci_generic.c
> >> >> +++ b/drivers/bus/mhi/host/pci_generic.c
> >> >> @@ -1483,7 +1483,7 @@ static int mhi_pci_probe(struct pci_dev *pdev=
, const struct pci_device_id *id)
> >> >>
> >> >>         /* Allow runtime suspend only if both PME from D3Hot and M3=
 are supported */
> >> >>         if (pci_pme_capable(pdev, PCI_D3hot) && !(info->no_m3)) {
> >> >> -               pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
> >> >> +               pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
> >> >>                 pm_runtime_use_autosuspend(&pdev->dev);
> >> >>                 pm_runtime_mark_last_busy(&pdev->dev);
> >> >>                 pm_runtime_put_noidle(&pdev->dev);
> >> >> --
> >> >> 2.53.0
> >> >>
