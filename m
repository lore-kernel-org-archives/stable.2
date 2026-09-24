Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8D9410D3D
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236641; cv=none; b=q7WhJAMOcnE4eZNIK4O4pnDfI6hxizJuiPGQ4Xo5nFdfPpZPtHMy/0GJRnzCJqcLwa4IzXxNkns1a2kVcmMpRDhibA+d9A2NqIlIUHHZRJZxfUTS2YSoHjomNQbJm8xWHHdiFopmQHItPCJBmU+Oa/9ZGB0xu1o1lGp0nEnIUDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236641; c=relaxed/simple;
	bh=HcXaDz5KCiX2wRs6pF4PPkcCP1k1shxEJGxo93Vesck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvEAiiZDpRe91uh+WqJcx8g7cwj+KMyajdb8JjZhvANqJUqsj1CjvfWlGPu+NxSGRHGPGTgNDDJ1hQcLQyCLP3Sg9CzkDQwMVwCqyIN8E0AxemtT3WqDTkjdrLzNusY1QrlVYv5fqk/n8dxzWYycJpirQgZK7uHOL/T9pPh0Ea0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oo1VqYwB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FioFyE2H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oo1VqYwB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FioFyE2H"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5eGx62277223
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=B1KraGaFrLufIKtIo+iDUvbQ
	2uJXNY7+zBo1hgqcENs=; b=Oo1VqYwBPFQ3domiq5wFNAbS80Pr4QJt0FKuaRJ6
	lJjtc0bJQSlO1pvn9TqdO6onCUIfw8AgSdJ+xetIjY7F4PVdSjWaP1DXuu4fNj4p
	aVuWI21NdNbkNXgfIIB604sz5ApHhHOx2g7Gif3/pyqMote+wi0X7P8gEnWi/uJB
	dDA9yED9e/0g1UScS4GelwgNkngf8pybupmf+9lGuhqJMBmu2W4lHRjBzCe/D7Of
	FFOYaUIcIHw3vax4tj0+yhz7HLuwSGPN1ElKQ6oJUf6LHgGNEAdZidSAqPHaBAKh
	NTVQK7T42mp+Getc7cYCBk2O6MmUAtkbfvVtMqYnfLAuKg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjxv099-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:57:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9308eafb465so407158385a.2
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790236639; x=1790841439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B1KraGaFrLufIKtIo+iDUvbQ2uJXNY7+zBo1hgqcENs=;
        b=FioFyE2H81d4wkmD2D0e+CVzQ/ZG8Zf6cQV5Zfi7l6Ph10OSJSJMxBkgaFg+vhtlV0
         nhfAM5BkWDTG5CNgEr/CfHGgzed3aZPHgRDhgtBZJzOJXAAzy9fRR0GILcxbhwPgyG10
         4KXJ8mPMEWp6uNysCy6hJP2V8lHGpH4UutnMuc/RwggNRnj2LSzFs78B+3/OO7VSmW2W
         929IrbifhsO1wljTrEXMYawYLRHN1V6si0mNt7xF0x5ISulkuECIHKpH1ZfElQyOnCJE
         PNSK64Zn4D2AV18OZyAheU06NHkd0govxfoxu4siKOgqXCUO3+74qLEb+IR+6SpXBYgQ
         CFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790236639; x=1790841439;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B1KraGaFrLufIKtIo+iDUvbQ2uJXNY7+zBo1hgqcENs=;
        b=nnGijUC75vbbSGjSQFpy0noIKtOZ/Im+ExsaOoXUdGW4osKE2zVKOnmyzaU2PamNZQ
         Qu1GYw2Hmma7BLeF8tiqLrImYHKwtu6A+hjfdm8nfoukUI7VB3emV8Y9EfmvtRAKzB0F
         VC3LqzKzR0BDtk7m08H2n5BwVk338WiCHflKUXH4KmrYM02IF44r3f7f55HVU7/An9i3
         ytymrK+crhG2jy31cDMksjA0JFsflnF4k6PyQ3J+MQ6UQ7IGWb9rIH7zyImScyuTPhDJ
         oLcJz2CV22dCjvc/VIjFauifKpiuqWllGZuKfAuIlibusG58qt1ITJsRUIexgMLl64Sb
         Uaqw==
X-Forwarded-Encrypted: i=1; AKwUvBy80TGw8qnUuOYvZPJPxAlhVnypHBjJzaIx11HMgUo/eL+wDcWcTRXnSZTWvxdK+VThIck0kEY=@vger.kernel.org
X-Gm-Message-State: AFuF++nVy18nXy9K/tJS3Q4dojoaSamsdXvFOYsfKkAKMB1Z7cFaqxTD
	GG2pubZcfgW2+V4ovBdvws3ZqWF+nY1/SpRgK5BTNWT/LCUmp/bkQcuS59dZDPkx57L+9bLY1zQ
	dc4/+RZJIjBmuhGEQTVpHKeOm4sVpP9OmafcOTv9oifMWYqoL4F32UgFIPnY=
X-Gm-Gg: AYBFou2MBzCqE/ea5Wz1uiMIZh8ARhDPRgVhqcFFHIL6wCDHHWQ/tHThWdzhEduouh7
	DCopnj2vYxc5RtY7IkoKQz6LYGBcBTht5oNzu7ShLW+c4azbl4PCjC+8wPLRcUNXkZHcG89MxGB
	c3emUHQOslK6neWVHjjdIi/Eh+AvAT3C4nwGOS7BTV8sv1DrY5njvrsUMufJwwfUKE8j9KFi2wy
	nlbkaQB7iNzf6ycSQtAFCegm4uVCJt1vxNDRWPAj0v+sxWK/ozsuw6fIWOl0YYuAyXJ898MrZfb
	xW038qxMPihHQj/22bHHHro79EE4nCpQOmjWEMke6s+F2rxbYv+vh4xLDFEf6b8FUzCbIxEUkT2
	NetZPGGypH8imCQ==
X-Received: by 2002:a05:620a:29c8:b0:93b:d7a1:ba0b with SMTP id af79cd13be357-93c3640435cmr182046285a.54.1790236638585;
        Thu, 24 Sep 2026 00:57:18 -0700 (PDT)
X-Received: by 2002:a05:620a:29c8:b0:93b:d7a1:ba0b with SMTP id af79cd13be357-93c3640435cmr182037985a.54.1790236636558;
        Thu, 24 Sep 2026 00:57:16 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5bae53dsm49769305e9.4.2026.09.24.00.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:57:15 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:57:14 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, maxime.chevallier@bootlin.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH] net: stmmac: guard FCS stripping against runt frames
Message-ID: <arTX2kNFGXLg7vdn@lore-desk>
References: <20260923162339.1375698-1-qwe.aldo@gmail.com>
 <arQ4dVkI9llhXCDx@lore-desk>
 <78724445-4c69-44fb-b82a-1f9275e37e9e@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="35r0MCTMsnB7aZOv"
Content-Disposition: inline
In-Reply-To: <78724445-4c69-44fb-b82a-1f9275e37e9e@lunn.ch>
X-Proofpoint-ORIG-GUID: dVL40GWXgLQdjFuVKNLZVFiXTI9zfkwm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMyBTYWx0ZWRfXyZR7FPi4qk3N
 XO5mOJLzvcyu1/rt7B1qzQ+nxet3HE4a9qViddM9HlVSSQfXczsVlu4obVr1LJFPerzjL+VMAF/
 iOg4ouwezSvtdbtemPBur6Lg5Ptd6B9h0eCJENF+rUMZ1Bhq3Lvd2/EwCQSsNiWfNBNGEc65r91
 HiePL529LaKCQYQqks7vvw5OkqVQQRQ+s6G7pnRPzxfJdDwr/vujhFLuXU3CI0QSrFlWou1QJPw
 T+ZGTAEA2O7ziAUaNr1AaTA4N12v0zepAxRMpIttIX3Xvd7W4U2IE4eQJFpZTozqOQuMtTx8Whg
 Bz3rtNz2vikplHYFNCumNeZkvzh7GM96aEwnp8hBkCRga3o/qdo8basIjdKog5NKaVCcLGHsDhp
 FdvCKx0akxknGjNG/HmuSyNN5R5rHihAvc90x31d6gKbmVnn6KHZ7Y/KnNgGKKbSuIecjk2OVNW
 aXHIHZenIPH65hEDDrw==
X-Proofpoint-GUID: dVL40GWXgLQdjFuVKNLZVFiXTI9zfkwm
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ab4d7df cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KVXIDpKRKy7ce-yJhUkA:9
 a=CjuIK1q_8ugA:10 a=u9Tfa8qlk6M8Y1NLbVIA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMyBTYWx0ZWRfX+Mm84xD0pHUH
 BKh3f3ni1PG6F2W+3889Zqnjy57CQIAstb+RTo1591GXqxBydU/4EPI+GXiQv0hVzBNkWOjl9Ct
 PEVoE8mNQUxsY/5O5+1SuuKa1sitRcw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240033

--35r0MCTMsnB7aZOv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > @@ -5808,10 +5809,10 @@ static int stmmac_rx(struct stmmac_priv *priv=
, int limit, u32 queue)
> > > =20
> > >  		/* ACS is disabled; strip manually. */
> > >  		if (likely(!(status & rx_not_ls))) {
> > > -			if (buf2_len) {
> > > +			if (buf2_len >=3D ETH_FCS_LEN) {
> >=20
> > I do not think this approach is correct since, at least theoretically, =
the FCS can be
> > splitted between buf1 and buf2.
>=20
> We are talking about runt frames here, so less than 64 bytes in
> size. Can such a frame be split over two buffers? What is the minimum
> size of the first buffer?

Why are talking just about runt frames?  According to my understanding,
this codebase (at least the one in stmmac_rx()) is executed on all
'last fragments'. Am I missing something?

Regards,
Lorenzo

>=20
> 	Andrew

--35r0MCTMsnB7aZOv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarTX2gAKCRA6cBh0uS2t
rJBuAP4nU5clgQENSyBlnzWzn8AMHbSqn2jOuJvlgtlkekrq9wD9EZ3PQdweW0zF
We+ngFGarlY007Y9aBFBkMttXLF0Kgo=
=UxuT
-----END PGP SIGNATURE-----

--35r0MCTMsnB7aZOv--
