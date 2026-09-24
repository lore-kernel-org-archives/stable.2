Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3E247DD50
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255457; cv=none; b=WnMI930b29n/xI4kNamxvDN0nptKhKgeesKq+dHC2QiGMdik4q74H8DJf1lMPZWlerljhir5wuyzdEkHr9nVoc8kBpOmEbjYsyqK1LFYNarIx+nVqGYVWSMwgMnKq0DkDhIA+dSwlt6eGQcOocOpRTuMj2x/0uk7jjOUft06ltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255457; c=relaxed/simple;
	bh=LEbGtS8WmyppljlUHIFZla0GOEs+0aoAt5wsCaKPPSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly1YsE4BSv5pEsbwxckyDEiEy7KCEAeYH7prqEzGlNTjthTpQOjcKEUtRi6LgEinWpxcqPUwKmOJtVT3jLCj0Fql5ROKIT4iRuUZDOTkRneJUrEAsWWPNNlo6VuWen/GM306pAc6xO4FgFfQ6/pjslNuwbEcDv5mm/pNqhhJYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jwUievlG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IwEMbTUA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jwUievlG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IwEMbTUA"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC4dkn1437086
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 13:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=arsILVgrBpwLtL9SX7rYgMeh
	d4uTdc54DY2C8hwmI+8=; b=jwUievlGRJPT2B4zZGab/WCKi2OT7Vehn+3TYe93
	/tCcrjNO3mf+qBgO6UZB8lExboU8y+akqZJYQAIvnYGYJ//fPQy6+E5oMb1i+6sk
	ExIESb5mzM7nt1QvBfTmDkKzhE9GHQDgTEje79BXwnr/9R2pc7I3aC0+m7/KhQYm
	OHFBx0WNijI7NsTr4ucNfNtVWQAUQUitGvQQCmFHlmsCbqTFkhLd6A+bVdZv2XLE
	TPnny9J+SdZZ9NYk+ATorfEijLsdrKGtS65RPrgHo6etrH+dorWVXlKIYfMXyGVe
	fkIbLSnVjiev+XTmR4azzeL+F4ICEct0onh+aMC10bEnDw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1t7rp60-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 13:10:54 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98066bba118so289579241.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790255453; x=1790860253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=arsILVgrBpwLtL9SX7rYgMehd4uTdc54DY2C8hwmI+8=;
        b=IwEMbTUAbGYjh5CkZqFnOiPmNsC6K0RrfRL7/ANJvCKOVsayqQCIwWHup5N3MbtOci
         cHHDk8GYBXY+LvpNrRycE/cQyO9sCfc+o8xF1ARSSaVPyj5/eZBUggU3y1HQjlS4xP8h
         KRP3oTf+Ydw7OKH5XJeExA7u5BFeea1IAVv5dzFBqtJHOEGQgh8ZmpxuBRHcKqb1etLC
         +Tk8y2UmzayA/pUPSviQ/E3c7Z+C6HGovChohJrKblf0n9JmpQXkIqepmiPcFE0r4Qdv
         dM4y76g5o9+zj+2tB7vE9KTx/VIj8O++Yi1OGhMvXQjwPBa43mQ8VUWFcAp0am5TD7p3
         vetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790255453; x=1790860253;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=arsILVgrBpwLtL9SX7rYgMehd4uTdc54DY2C8hwmI+8=;
        b=1KZugkrkO1r/FLuL+XjTymb4YrQhPGSF/sJu4OTqJWN163T/4K5Yaj5WD0Eg0zT4E0
         bKfr96DHDLJi6gouLBFm+OWqyhDDQR4lon71Y54C6ERuJudVkbUjb2hRoiWWbQ0+eHAT
         Qt+Keae4W9u5usEKYC+PHuuS5E/2Wtrn4+qb+q1miGCJMtHiFwR+D4LxkkK5R7M2BtF5
         UIlKRJkfgyld8DeJjhGcQJ7ZlROZ9j5UJlfXyaWxZltOvLRt/wyo2bWmh4o0P87dn99n
         oqOFqHB5aroy1tiym/iOHqxK4nwwpdkxnflDyFA5j+CllmDu8d5nJP/RerSlO1Yyfnrp
         ctdA==
X-Forwarded-Encrypted: i=1; AKwUvBz1HZyoBu/6R99RkRWKFKfPsTLsMb083h7h2V+CaAJV7BQ2F15EkP4eVWYixyklp5PvYVKv+Ec=@vger.kernel.org
X-Gm-Message-State: AFuF++k3dYQjTMtO3h2gNKbVjrcRU2rdSaBQYOsyt8XZ60BnDtZ/Jwpi
	5Rk6osmWhB6t67f9YMrhsK8QkXtM6q8eIgEqBRqk8eHsKSG+RFVGEiSm9xW11YuuzWUURFQths7
	I41n6701UgSthrTHmt2bXuM1DYkZBJLP2kIZKrLnouR4meDsuKhGaPsjaIg0=
X-Gm-Gg: AYBFou39o//iOlGSzyYZL64Sy5ac8cI2AWAOFJrR9BuHeZpLDcyCgR+VlzC0vATnzdS
	tUBz5bN1mCSZcKNeUkS7zixDTUsvNsnfztENnfam0zQwlNrwvPPl83rFHjJS5l1hF2csBtYZ/ZR
	Mvy3QKC3qtpws/qXzybi0Taa22UjHwsrWC4kX3V9VEnu5g4X/4COdsc709aAow0Vpd9fc60wvi2
	1yiUDAOPtsmqsjQlo/e1X5uz4qj2XaP2rOl1EP10+fTiQF9HrqKLbnRriptWrsSWELvacmPpftV
	PbJpYyZhsZPiEL9TZGx3KsPWnluI/GlkTSNS8SJ9jywZW7uuGYXTMJlBEmGUGx5+gl88N1ocl/M
	bEFxvPsAkwf6RdA==
X-Received: by 2002:a05:6102:5801:b0:785:c39b:6a1 with SMTP id ada2fe7eead31-7af1c99cf51mr986821137.6.1790255450116;
        Thu, 24 Sep 2026 06:10:50 -0700 (PDT)
X-Received: by 2002:a05:6102:5801:b0:785:c39b:6a1 with SMTP id ada2fe7eead31-7af1c99cf51mr986806137.6.1790255449373;
        Thu, 24 Sep 2026 06:10:49 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf99df60sm107231235e9.1.2026.09.24.06.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:10:48 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:10:47 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, maxime.chevallier@bootlin.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH] net: stmmac: guard FCS stripping against runt frames
Message-ID: <arUhV90af6coj2IK@lore-desk>
References: <20260923162339.1375698-1-qwe.aldo@gmail.com>
 <arQ4dVkI9llhXCDx@lore-desk>
 <78724445-4c69-44fb-b82a-1f9275e37e9e@lunn.ch>
 <arTX2kNFGXLg7vdn@lore-desk>
 <8b3d8225-0d86-4e73-86c8-b7f644faef56@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xhGvZqQR+CkuDMS6"
Content-Disposition: inline
In-Reply-To: <8b3d8225-0d86-4e73-86c8-b7f644faef56@lunn.ch>
X-Proofpoint-GUID: Z9KyGZR3IjacNoE6npVtya9wn9B85WcS
X-Authority-Analysis: v=2.4 cv=U/MHnuru c=1 sm=1 tr=0 ts=6ab5215e cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=8V8mYWrpQfyZ0I-j8N8A:9
 a=CjuIK1q_8ugA:10 a=zS1Ju1pEN-1IdQOvjlkA:9 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfXwKpRJ/j3CHhH
 CcR6vt+s1dBbnT+hELvw8Ob0g1qwCFXMfJZWW7StKSnCFdL8ni+XnyxP5GJmyaqMZ8OEPfNBpk8
 9nG7KebSr8VGay2PJuwzomItoGZr/EMhpcpi8WFh3dLqGhfE3LKgG/ge8hhO/zqcxVvOJB8ugkY
 OuXd5VYRofTl2mEipAuO2Ly5//stNdudleYva+qxKGyUXGFRxfmJqmKB4BG04JMXpqCBurtkatT
 6qBASWtDa+4jSHVPA1iV+cRtIrIk6p9Y0tKzfTn88YYEZMK75kZ6RYKeoeun38CYuBU28pUscYZ
 YL4NWxbyg+foQTFWeGPfJlbrEgBWFz0dNJ3+IwR9mJKYjrIvrAcKRhUoCA/BDPphKHPI00GHfWJ
 sEOWFEt+h4kh2nmF5hrQgYaK/AtkEUlJ7w+9lHposQKhzBEKSOHo+YDIeTWrv+vOM/eHETm8BMo
 qaPe+SD2EV5bT/mQhrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfX7ZePxUuEQLLn
 m0xQLsqKHro9DM536wPgdjLb2RxMgTbABn7Px6KHvbvgThyssA9SgXJf55+NK1pwLmgaAl4xDqa
 YEjEYDencgIvGyYlysYtJhjLwKivpuk=
X-Proofpoint-ORIG-GUID: Z9KyGZR3IjacNoE6npVtya9wn9B85WcS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240054

--xhGvZqQR+CkuDMS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Sep 24, 2026 at 09:57:14AM +0200, Lorenzo Bianconi wrote:
> > > > > @@ -5808,10 +5809,10 @@ static int stmmac_rx(struct stmmac_priv *=
priv, int limit, u32 queue)
> > > > > =20
> > > > >  		/* ACS is disabled; strip manually. */
> > > > >  		if (likely(!(status & rx_not_ls))) {
> > > > > -			if (buf2_len) {
> > > > > +			if (buf2_len >=3D ETH_FCS_LEN) {
> > > >=20
> > > > I do not think this approach is correct since, at least theoretical=
ly, the FCS can be
> > > > splitted between buf1 and buf2.
> > >=20
> > > We are talking about runt frames here, so less than 64 bytes in
> > > size. Can such a frame be split over two buffers? What is the minimum
> > > size of the first buffer?
> >=20
> > Why are talking just about runt frames?  According to my understanding,
> > this codebase (at least the one in stmmac_rx()) is executed on all
> > 'last fragments'. Am I missing something?
>=20
> That the patch subject is wrong?
>=20
> [PATCH] net: stmmac: guard FCS stripping against runt frames

ack, I missed the subject, but I think it is wrong, the issue is not just on
runt frames.

Regards,
Lorenzo

>=20
> I suspect this is an AI generated bug report, a minimal fix has been
> proposed, but no actual thought applied to the situation, such as does
> the hardware even allow it to happen, does it apply to more complex
> situations, such as fragmentation etc. The usual AI problems....
>=20
> 	Andrew

--xhGvZqQR+CkuDMS6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarUhVwAKCRA6cBh0uS2t
rMCYAQCnZVdVYwp4BlPYl2ifvd+7xlnUC2ADvKHkMNQ/jXTGOQEAubiTI6IBnWJJ
sv5VixPu2WCzvQQZjYfHjmwu4kWZRQw=
=IjrR
-----END PGP SIGNATURE-----

--xhGvZqQR+CkuDMS6--
