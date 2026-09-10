Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204694B4892
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056354; cv=pass; b=QjeaC2e/3wbtZXtHeZNL+fLyegmP8cH2f+HU1PulKbxMZyVcSTKFVxEN6IsP/gxxXLKEoPeQcUBFCI28Z5duEvAd+SWQdVJ8H1dYzgDCE1o24oNW+Vs7l5quIko4ACIpIHFWfX2/ML0gojdwXQA7rJiDtTF03sbeDLDTJxxm3MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056354; c=relaxed/simple;
	bh=Q4uhx4UzUQra1vjR/trzB6RCmVA5xxZuwzkYyHRjWlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pi603A6rX48lcpJ4kObQZshIYYWDTA7i0T8IXlhOGRpuzfIs2hfcYL7ehPsqEe0YMx+6kcja4o75t/SqUPQ5frmD8Ziksb/KpuUDULzxfilBGs7WHg7JbHbHkB/lbkeYk5pqMX+qVO9q/Te1AwId1ptHYCRcRyyZBZYRLV+xd3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nzZeJjsh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VoGzRjnD; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nzZeJjsh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VoGzRjnD"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF4MQ21494261
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OJUaJsREfJ4f8VkOUx2mPECCsS/3Z5pmGh8xL/RsWKw=; b=nzZeJjshZKPCnAEh
	nYHKYLcgjkVW46dvdsGX9u3bcTgB7RupQO0UbcSUxguHOkRF/KOhUDv3TxcvPCRp
	7Kn1KoGb5jLzuOakFwiMgxo35ttj4F/eEoqtSiYC3ayF3rD6ZU8j5PUF0cVV3SU1
	D3fdp/9r/S8nHax/fU1pcbWmkbEnHlvBptog2N5Fv9NYFKlPW27H7xx6ISMO7u9p
	xPgVaYGRSjWBlqGYoCstUi8Rre8WsolZ+AZHn7u7znsgDjCXSpZ7V6yZ2A31X8o9
	/DRKrK5bqCSBThw/ZilgmD0H43/VuVH7ApwXfURX8SwS3MQI7Uzsx1A0TGJrkXbp
	tOF/YQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwx9rueb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:05:51 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-85415923c8fso3143664b3a.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 09:05:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789056351; cv=none;
        d=google.com; s=arc-20260327;
        b=DP/MNJoLCzqWpAV32GCJ6FBsk6v9bL/HFSRRYVFNo9tZ0P8hIASoS3vhJkDPJtn3Ru
         jIRzPw6s84W5XyWOkqxSdhEFwBEeXPJu1pHZCj7pjELM1kYc5/pyN+Nml3t8iLpgQAOe
         6beQNmTTtFTaCfS15l9lloRLnP33vsKkPj0jmBG+ZFMuKWxGve6ewQDRQvFTgA5zmJJq
         5meKTpsuLJfiVdPQCKhXuQb45OtQWqoDhAOPtYL+bJK/pbEc865F7jGHGUsho4za+EA7
         Qvq55vA1p5d/kgtoGeB+v+Hrhn7ECeP4af2EbQYPFJ+2Txaw8vsQ1BPNyLE0FeNVuIE5
         NacA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OJUaJsREfJ4f8VkOUx2mPECCsS/3Z5pmGh8xL/RsWKw=;
        fh=c3etqd3cF5iKBr8PZBMp6zFpwgDH/nz/yZm684atFSw=;
        b=Z9oDT5bhx38eA9I502jsdCKUAnJlSi29fRV1KFVwRT9kZGWT12QxyHOtErHan8ZSkg
         qWK4ZiKJA+k+yOXsdgkvA/qhyB3lg29JTuqhE0A+ElXAt7cIyTm/WEav6i6QfaZKDIGf
         jK0BrYcGeUYi07O55B8Gbek5fav0JZtiPmogK4n6Xy3q6l2xs3cVRktJWw1u1NQA65h8
         nrfzrwGPyEhn6NxYaPABr9qT3sUSVhYMaZ47kr3EuGj1sX0KimiTt9KmzYGyAXH/5f3R
         VdR+8ii9HeVvELSoMq6dx6qS9Dm9akZQBr1LQKUHDoGPqTmYUZuP17NvsFbeEv78w2Fy
         wmXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789056351; x=1789661151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OJUaJsREfJ4f8VkOUx2mPECCsS/3Z5pmGh8xL/RsWKw=;
        b=VoGzRjnDuL89O88gpdSFxeZ6/mPehhrDIhjSme7vkDk1tN6K4xxt/cCJfeUS+C4T5I
         1adZbcW8zRdHzDj8lrlmsEi2sHlUpTQXEWhlofwNQvMEqtZjR+GKsD3NaqvrxzRjJAnR
         P3ZPBXZyvbEOvrJU2jdEe6CGeVNu7FVbrdkLUojkHnzNHa7Kub9IiqyNu9howfivISpg
         WAiEOIlJU2eH/5lrIWgTT/r0xkmEdlIek67kUo5VenhB0pvJjTvzW2/wgXatlC+o4eka
         8MVwy+kCySXO4qy52M0I+4XrbyqWB7vv62SIU5qEZ2aRM5xjy/eJGsZTgR+qefsAg/Fv
         D6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789056351; x=1789661151;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OJUaJsREfJ4f8VkOUx2mPECCsS/3Z5pmGh8xL/RsWKw=;
        b=UzMSkTtI2yALgUZThqoooxgdCIVtPNCH8XFTM7VM1WZjszHhUz/H3wLKwdWVLm1iQg
         MyB40g86Yw+Lcch5UyPqkEFUaGRzmo7KX5eL9EjRwg7k9mypu55hy6ohDaewa38yO3h1
         iUdblP3zXLUHgkS8KvXagkfUk8Wrhfd4ANIJh2dCXST3HegSflbKldKAsRUo1nPuIdkp
         724IvTr2oaSSoxL2vP12G5Uz+0dcvHYNe0ZMslg4iC7+mnP8Njs3jb3M/Wlb9rYuBx6O
         MO6RKWlX8XgnqRKs3mHrP+f4j3vIe3QiXkkuXrgto/4ZBmtSCuLkdVq1iIGVGygfZzam
         uKqA==
X-Forwarded-Encrypted: i=1; AKwUvBwwECMluOtZwb4gVUPX5DkiHBsHrZXncFnd2wnsdDEPxvfc7/5nuSq74xoe+L8TxAqLpPipjmk=@vger.kernel.org
X-Gm-Message-State: AFuF++nUSHRIOEI/TDKK3kjVMp5F37IaD0pFRhuT5TkbZfzcoEOexf8S
	Wl0I3ntp9S+czsAYRtP1cUWUTfWDn+p2TubOcWY9JEGRnsCEf/KheDhXICwbGOmCPY0bguyPtEl
	cElabKQjSQOk41f7UcnojhtzhQ40UjFoeG8Y4r4QJozj+hNKhW0FWCd8KMR8pz+m7Lt291PTEpA
	SwMeY9S4mTu5keqFGMjMbuUyPSqTMmzbSLAQ==
X-Gm-Gg: AYBFou2q2fLBy24iv1ytYUYfken4iM8Q+BzwtVGIbmPuQRgoYR9Um1ADsednowo6OsT
	TwODVTRHykrGqO5yBQIXUQMVDED/AHzHNaqyLl8Sv2Vb9BJM/qDK/+AJ13a98vPvQC3WxthkfQZ
	yW50h9okboIsNVd/FgHgUIznKl8eUagEMCeE7ZfrkxvrB6LrcfqKDxFipOsw==
X-Received: by 2002:a05:6a00:6d43:b0:869:201b:7386 with SMTP id d2e1a72fcca58-869201b7831mr9247512b3a.1.1789056350336;
        Thu, 10 Sep 2026 09:05:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:6d43:b0:869:201b:7386 with SMTP id
 d2e1a72fcca58-869201b7831mr9247402b3a.1.1789056349581; Thu, 10 Sep 2026
 09:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_CAA125B50CDEC8BA29F4B982356549608D07@qq.com>
In-Reply-To: <tencent_CAA125B50CDEC8BA29F4B982356549608D07@qq.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 18:05:38 +0200
X-Gm-Features: AcwNN1WvimKFb8VJFOX40v762E_cTADJwrFab3f6eIRNPA32Bu6Jw3cM_hL4OQM
Message-ID: <CAPx+jO8XTB40rAwzbtAfP9D-GvGhjnSWEcBpzjXjjNhZA0SKrw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix OF node reference leak on card add failure
To: Zhu Ling <zhuling0805@qq.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Hans de Goede <hansg@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX/3jC/sN96tK+
 4MVX7HP4aDohx0pNP0pBZgMGKZYgDFheMEKVX4l7lh3UU8rqddUCkCQzSjAujIKNakMgSU8i0Fc
 Cq3hSGcjslxjh1USsE3v1QK9EX47GVXkxMTyftPJyekBEp3gxqgL9IIqHhka8nRSCWNzC1DRXuQ
 HPiKMdXAWctYfffZcWMKyyM51ICd76IzPIg7H2nPKT0/4PQn7tn3eW5i1tlWCFov3gEoya6bv+P
 JHnI6gt4uQLimkczHpbwvrLrPqEq9wI9wdQ3/TQA2CtVKVfoksHci45A1v/LSoJuLeh06DG2r1v
 vzx3f7P7/GAh19KnO0D7W4hZv7UXhbCo7UbgnbmvGWOwdwXNT6DJh7EyxLST4+TLc513cyKQPu4
 guYNg5CupaX7lpJCiPtGgrWNzk9/V7va/cR7mhr2wH1+KSRcN9Mk9XjG4ID/6R0lgFTrt/OpJME
 ZBim9rp+3iUlS+r9tIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX/5ugsvNkY+01
 /IRx+aKYsoQjPKAPEDkFC21mCQvmhB0TCrQbGxClhpzzrGFVsqGpB0/h69kV/B3576mZYZO60CR
 P0+iGv+OX+hRpX/bfH8j+PhdCrzzuzs=
X-Proofpoint-GUID: RqJx4UXcqjIOS9ULgJOEkbO-DUd2HK0I
X-Authority-Analysis: v=2.4 cv=TupzFzXh c=1 sm=1 tr=0 ts=6aa2d55f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=dZbOZ2KzAAAA:8 a=VwQbUJbxAAAA:8
 a=bVVfCyBLFoj7s5xtQnoA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: RqJx4UXcqjIOS9ULgJOEkbO-DUd2HK0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100195

On Fri, Sep 4, 2026 at 11:08=E2=80=AFAM Zhu Ling <zhuling0805@qq.com> wrote=
:
>
> mmc_of_find_child_device() returns a device node with its reference count
> incremented. mmc_add_card() stores the reference before calling
> device_add(), while the card is marked present only after device_add()
> succeeds.
>
> If device_add() fails, the callers release the card through
> mmc_remove_card(). However, mmc_remove_card() only drops the OF node
> reference for a present card, leaking the reference on this error path.
>
> Move of_node_put() outside the present-card conditional so the reference
> is released for both registered cards and card-add failures.
>
> Fixes: 25185f3f31c9 ("mmc: Add SDIO function devicetree subnode parsing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhu Ling <zhuling0805@qq.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index be5cf338bdeb..92ad39c0cabc 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -417,8 +417,8 @@ void mmc_remove_card(struct mmc_card *card)
>                                 mmc_hostname(card->host), card->rca);
>                 }
>                 device_del(&card->dev);
> -               of_node_put(card->dev.of_node);
>         }
> +       of_node_put(card->dev.of_node);
>
>         if (host->cqe_enabled) {
>                 host->cqe_ops->cqe_disable(host);
>
