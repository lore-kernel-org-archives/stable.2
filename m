Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794123381;
	b=q2nL2J3mJpY8ai0O0s3SG4b4kGfQ0p1PveITIOiRGhJK8bRB/a82oPXQxG9QT3g+moOC
	 kP/1WJD+sgzjvgWdF/nJK3PcP76ap8LdVmI/0ggfGzOClESggXJPclYF7qlboy94KbycG
	 x8GGkKjCCZXa8/crohP6l5y2iLSR2mzPfLTgsVs3N8LCyFXoZCIA0LLES37h31ZZ6DgZK
	 TMliDESVP21x8CbqZP60oGhbIB1n6KDpHWGsSikysi+zbbcSIqgLdxix43/r0WnU75c+C
	 XfBhkh8bdGzxQZDr3gtHg/p9HvsSGdBwNaOVjE8SsuvSk0zDjsqyhGkyIICJbuC8wsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794123381;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:Thread-Index:
	 Content-Language:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2n+UGKuuNYXc6rxjwiFZUbX5+lAllqeXmuw10kG/+ks=;
	b=G/S6qGJyZRRGcnDUmt13nnu5wjOCbgSxKzlJ0qFvx2sq6DpE0g1h4Cryb9OVCQAe/uHx
	 YEM8p2ZhzN0WRdaliLjDrhafwX7qAtfN/wtQpa9n3e3Pk4O8oA2FqdiGIPbAZq05QGkZt
	 BpY9DgjSoDV1FdPsSphR97NXqKLLJ0T7V42J7MPyU0q3IdI9mqMFlQXqe2vyg2TnmF5hw
	 dF+F8HWQo16aeh4iY6UTD2vEgO3hEDcHdCbrmsRNl4w0QAOopWcpOzTVFAunMXV8d1Xzw
	 wfI5a4pBabtcBN/JxSXTAE0A0x4ESB4/uEt7tgp+sSdoTtpvgKH2eKsWWiwjZsy9V7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ekQHlie4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="HE/hHY8w";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABD8606A321
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 07:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ABD8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ekQHlie4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HE/hHY8w
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A84K5I31520944
	for <stable@vger.kernel.org>; Sun, 8 Nov 2026 07:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2n+UGKuuNYXc6rxjwiFZUbX5+lAllqeXmuw10kG/+ks=; b=ekQHlie45SBXLwQ4
	Tzm2HcRuAecMksHtkmMyocRQ4VhTa6Opsw0ziH/ZKyQ9Gq71nUB9FZrgFhVqGAm2
	CLu2+PqogaM6Ah6rwawi/kQtKWwEJsXuK90MdD7ICEGxRztiBzu1vQwg86x+Ve+s
	ws1xpIxbtHz/XG9nwc74SWUZUtLJRtPbIw79RGvGdSbvamvM7wUQrvUcsqxSLv35
	JDKe6v0mUwkh+eCodXW3TRtQmTWNdnuSrPT43I7ZELi+9iompXOXL836sA9iP9nn
	ymhYhvG0ycyN3b6Sr6Ygfd8WkkAj+1E/TkFGt58AzSFn06OIcRb8J7uFznZGeEws
	JQXNAQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hstxsanf8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 08 Nov 2026 07:36:20 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1ac19c6bc71so166327c88.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 23:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794123380; x=1794728180; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2n+UGKuuNYXc6rxjwiFZUbX5+lAllqeXmuw10kG/+ks=;
        b=HE/hHY8wGSKO2v+U+g53wlt/V4DnD5fz1JfwFu0FyRDN/1gNSsNXFFWzCg3Syz53dE
         8InQBI6T/AbUJ6FxfY6Zw5hcwIOqwmr50L9OZEblFVoTat6E5V/vONOLxzYoxIv/dRSK
         Qi1IgqBxGUplwCeZsklEK5NzJlyo1P54oZObvqjG+N9dG5rjLdg01mBBcqdRsiB08+ch
         CBr3fH2zHUHgOHE6yge8pILmFoTme4t18CI97JZWKgkfX3fW3FFOSuFJWqAF2Y8otYMF
         hUef4HCUR1z/w/2S+Z23dJ4vt2gTHAhhGLSXRs3KRWhjtrszw3DtHEvwcO3mHkZmcTLc
         cfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794123380; x=1794728180;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2n+UGKuuNYXc6rxjwiFZUbX5+lAllqeXmuw10kG/+ks=;
        b=ZU0Zwh1nh5O2E+lo16J3w3A4Qq/bMKKD63tF1IOTOz/uKc5wJjhE/pG0ZEDbmuXHAy
         2hT0rSpVKMg3YiWmo/7w0RYawYAMMAwumGz1CNz6LHSX2wg62atzCYvwPOoxVPFxSz0z
         y4soE/KEZ6ZX+L/q/Vc4CZ9ZHVhUG0H0k9TxI3OE2Ts6oKRDRE6phs2G4/Fl+bVZ8XC/
         yie8nHbSik4M2ExnsfFqMFogwWmbm5BB+dN1J2jfc25VIQVLga6FvU6S1eyta8H6kPTQ
         9zm+0uF8FEfs0A2R8MDyQE+WcwylWtdixrGT4Jj0U/XXpMMbTzrSO6POHR7ZrF56waNI
         Vt5Q==
X-Forwarded-Encrypted: i=1; AL+hErEnmpsYB/tBw4tlPoOpF8LDKmyg/7YMCbqyPZoGlwlqJrUwSLVXRZgUyIAUhPWi41fVk63rIsA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TvSfPYOC9J76CvlE6MLG9Em9sR+DRcceUJLaU9bUdm2RQ0Gb2
	We105APdygPrWbptunNsEBMxNN4mvS7/+5lbR9Ena0M1i6oWZHo4kCpw9Ig64QicMgyyA/gKFVy
	CaBhJ7WEN+kT0Fczf8XT41a4smIQRwQMBMDzIV/NBmcPMcBSNpFK2GLPjCCA=
X-Gm-Gg: AYBFou0PDwymh5cH0fxLz6BBSfxFN7mhYXfAfuZjt91kwsOZRubxskyxEz21z+p0/JS
	5kp+Bin/q2qpQZV3Qh+nrGbKCrtBM4nQ1Ic2MSEli6wGoA/pEnyewiDriwyaGAMzsGn7L88uUBw
	SZgE1WmOs+9Ar/6WWJrLaVZv1T0gnyc6cPOkorYzvhtgRLTAETx42PwvLq+DCZ96tbJKqUFtOH+
	1ipTnFFVwg1MMU86xLjv8wH9spuONUjKUij8Y+BUqyEVxTWZRXp2l1n6fjbbUTyiu+FOXWGRRRe
	V7YMxr6YDaDiyOMQHTfdlgjm6hASQZNZHmvG/H/EwltgdDSBkXXvHehvA265wF96SLyCo818aTf
	r9sqlcUD13aFOPn4qusXMK8wOHU2V1EbrlhYhfa2eaoSB6jH+hnqfDRWsl2Hc2+dkikePNUR4Lw
	+v6LePmnrxETVHHbY6wo9tU8EmF39pkPeIOk5upBotwBLr8+cBFuYZqrWW
X-Received: by 2002:a05:701b:2903:b0:16c:ff3a:d72e with SMTP id a92af1059eb24-1b39fe987b6mr1231208c88.20.1794123379670;
        Sat, 07 Nov 2026 23:36:19 -0800 (PST)
X-Received: by 2002:a05:701b:2903:b0:16c:ff3a:d72e with SMTP id a92af1059eb24-1b39fe987b6mr1231170c88.20.1794123378880;
        Sat, 07 Nov 2026 23:36:18 -0800 (PST)
Received: from QCOMk1gASIiYhG (66-33-8-210.colorado.intrepidfiber.us. [66.33.8.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3773ea50asm3556452c88.23.2026.11.07.23.36.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2026 23:36:18 -0800 (PST)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: =?utf-8?Q?'J=C3=A9r=C3=A9my_Jean'?= <Jeremy.Jean@oss.cyber.gouv.fr>,
        "'Sean Tranchetti'" <sean.tranchetti@oss.qualcomm.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20261031221052.1642262-1-Jeremy.Jean@oss.cyber.gouv.fr> <20261031221052.1642262-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261031221052.1642262-2-Jeremy.Jean@oss.cyber.gouv.fr>
Subject: RE: [PATCH net] net: qualcomm: rmnet: bound TX aggregates on byte-limit update
Date: Sun, 8 Nov 2026 00:36:17 -0700
Message-ID: <000301dd6f53$d7b931f0$872b95d0$@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIan9Ym6wgfeJXkm0ec/mIILiLtiwLTqZcCtpLKmjA=
Content-Language: en-us
X-Proofpoint-ORIG-GUID: Y9IVtMfIV2jlBpjUU58__O_bRR1cI2hE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAzMCBTYWx0ZWRfX87Lsbx5iIcN3
 /QBUuIXt3IM9EcWpZTv/M5sV3x88lDw62vAGTnx1TjqxOsGSnVUZZIpe7fJ26Wokv51p9LraJmk
 CT70cfw9iLq2z7Jrngyf9FJPmrFUE9o=
X-Authority-Analysis: v=2.4 cv=dZMVTnXe c=1 sm=1 tr=0 ts=6af02674 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=OltkOWFNRHEXGe+8VJKHzA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=fZt6mqSA75pAf0XC2eMA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzMCBTYWx0ZWRfXzrKLc2Fxl9Kk
 CIBmbe8hGsBee4IENs0AV3pjC1KZh9Ftb7TQvDNudTVcixR4MFb48KugGb8QX2nxipSyeqs3R4m
 n29+9jydauMeUFC0hs2bjyGdRWnbVO89vYxspeYboupw1B053gjrsKKyIeoBwG+tKKEhL95aaX3
 81jVxhLUXd9tEF+BgFU+lBryx9wiIpKlx07BPYAyN5GXi6LwNGZIvazQWlP/PxBF/UONmQxtNrI
 y8irgQDozS+vdObADnhdGzIu2gl+UwKcIf9RcL5NFOGsqQ+Y7zfJuq+IlJQK1/hvilTlJIw5OMQ
 6m42MsRsNZgJeOBMDq4LonSdIxQgo9NwipGe9Jk1tGO64pO3YiEfw1RQqqHnfRxTdYRAprrV6YY
 ntcv85Rd5cEjWAwyLIkfsJ35NQQgCOv3KUQgVpIEH9HsvjFHmlBlO2UUxLOHV65T2K0fgqaezFV
 CIUYaKJQlPIIXGCywmg==
X-Proofpoint-GUID: Y9IVtMfIV2jlBpjUU58__O_bRR1cI2hE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080030

> -----Original Message-----
> From: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> Sent: Saturday, October 31, 2026 4:11 PM
> To: Subash Abhinov Kasiviswanathan
> <subash.a.kasiviswanathan@oss.qualcomm.com>; Sean Tranchetti
> <sean.tranchetti@oss.qualcomm.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; =
J=C3=A9r=C3=A9my Jean
> <Jeremy.Jean@oss.cyber.gouv.fr>; stable@vger.kernel.org
> Subject: [PATCH net] net: qualcomm: rmnet: bound TX aggregates on =
byte-
> limit update
>=20
> If userspace reduces the TX aggregation byte limit while a buffered =
skb is
> pending, subtracting the skb length from the new limit underflows.
> The later comparison with unsigned skb->len then lets the buffered skb =
grow
> past the limit.
>=20
> Check lengths before subtracting. Flush a buffered skb if it is =
already at or
> above the new byte limit.
>=20
> Fixes: 64b5d1f8f2d1 ("net: qualcomm: rmnet: add tx packets =
aggregation")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c | 12 ++++++-----
> -
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index e6f48dc9fe64..205ac81f2c82 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> @@ -594,7 +594,7 @@ unsigned int rmnet_map_tx_aggregate(struct sk_buff
> *skb, struct rmnet_port *port
>  	struct timespec64 diff, last;
>  	unsigned int len =3D skb->len;
>  	struct sk_buff *agg_skb;
> -	int size;
> +	unsigned int size;
>=20
>  	spin_lock_bh(&port->agg_lock);
>  	memcpy(&last, &port->agg_last, sizeof(struct timespec64)); @@ -
> 606,13 +606,14 @@ unsigned int rmnet_map_tx_aggregate(struct sk_buff
> *skb, struct rmnet_port *port
>  		 */
>  new_packet:
>  		diff =3D timespec64_sub(port->agg_last, last);
> -		size =3D port->egress_agg_params.bytes - skb->len;
> +		size =3D port->egress_agg_params.bytes;
>=20
> -		if (size < 0) {
> +		if (skb->len > size) {
>  			/* dropped */
>  			spin_unlock_bh(&port->agg_lock);
>  			return 0;
>  		}
> +		size -=3D skb->len;
>=20
>  		if (diff.tv_sec > 0 || diff.tv_nsec >
> RMNET_AGG_BYPASS_TIME_NSEC ||
>  		    size =3D=3D 0)
> @@ -630,9 +631,8 @@ unsigned int rmnet_map_tx_aggregate(struct sk_buff
> *skb, struct rmnet_port *port
>  		goto schedule;
>  	}
>  	diff =3D timespec64_sub(port->agg_last, port->agg_time);
> -	size =3D port->egress_agg_params.bytes - port->skbagg_head->len;
> -
> -	if (skb->len > size) {
> +	if (port->skbagg_head->len >=3D port->egress_agg_params.bytes ||
> +	    skb->len > port->egress_agg_params.bytes - port->skbagg_head-
> >len)
> +{
>  		agg_skb =3D port->skbagg_head;
>  		reset_aggr_params(port);
>  		spin_unlock_bh(&port->agg_lock);
> --
> 2.47.3

Reviewed-by: Subash Abhinov Kasiviswanathan =
<subash.a.kasiviswanathan@oss.qualcomm.com>

