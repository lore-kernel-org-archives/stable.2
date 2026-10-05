Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3B5207E00
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 05:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791179213; cv=none; b=PgYRb9ru7My6NgSlirB57BSje/B/GnMDBdEYr8eOCx2aUy34GslE2NeDyQRMWM99MhK7EpOoZw/aghv/4LsvnF6YkGvHacFOus9wK5shT9raHRspWm4oyKdz23CZvrrKwGCpgBpshBYKS3Y6m4JzhHcYYwLmDr7hK16Buq/3cvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791179213; c=relaxed/simple;
	bh=iODhbM8nj9frQ077TmvTm5XGAMOmcJO3Ic6B9mRTG1A=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=bvPD7gUD+WNRe+/BnVj8EmwvCPQbPfz6ZWDGcOKJRs/KAJn4p9DRf0OCOdbRXWYZI8pUsZDB0Ro9IFBaNGWixgNutiLa+Czo/IllNIV2KtfWu23GAE0XDK8/cSpp3oe1+TJMT04vs1QDp63zL66gG1nqVWknagDqpKzlpAtqf/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MmpHgHq6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DOD23aWy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MmpHgHq6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DOD23aWy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695104FA3838476
	for <stable@vger.kernel.org>; Mon, 5 Oct 2026 05:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IQkqDDZQn6LUNMvxtUceN59vYwoJfsLnxi8dfPO0+Nk=; b=MmpHgHq6SjX0u5cN
	0lyvl77wylPw2mgEvMkfoXzrkgXGX0qphBGP4C7cKES7DYsVsR9e1QiAWYDeeHT1
	uWl+uoWIJ3loSEjndBb09rvaJiqgrChEGTjoSDQoaIqO0nj8ROVsQb1niB+zGKW8
	ZPC6aXZHjmJencwAYOoQujPycZLNmlAwDY0UWqky/68fKQmTH12fcur4HnVwDwN8
	2pqWn2kSrJbju04x5ScviXdyPjdsLuRLEvGE6dxWqqikt2YT8gGX0uxszvgbGweb
	ucxJrc20oOxsKMbT7zFSCBORzLJC//q9WOg4QAYcNUF9fz9IfBHS2TuQN+EBO05F
	DquaMQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2u08mgg2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 05 Oct 2026 05:46:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3965ba1ba3eso1239303a91.2
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 22:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791179211; x=1791784011; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IQkqDDZQn6LUNMvxtUceN59vYwoJfsLnxi8dfPO0+Nk=;
        b=DOD23aWyjQiwyOIEoe810U111Jqmd+0qGm8k9P7zDREoTPnWkCDQSunXn7HD+ktU+u
         vt0qnyfuTmdNF3U6wZeOP4UioZOSvTzWUdkpQlY7RdfmezrFP1ksCn18lNwx7xtPSvoB
         BtDck6DETBVP0Z6i9uQBvtNbAzR3iCCU0d6eEESxL0KzWuml1pYsDXTst5PpszMoruaT
         nnHblTtLsRSfUQ5RcXf0pbQ332fkRhBoGt+LcZVzFB9UUz4dXFJ3tXxwUTmdECm4SBW6
         UkmQ4WbqgZBZRqS8w5OxfopueHNXKrrfoGMG23UES16HRnruq5F5amhUheRGGSOXJ8ZK
         1u0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791179211; x=1791784011;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IQkqDDZQn6LUNMvxtUceN59vYwoJfsLnxi8dfPO0+Nk=;
        b=Ah1HBrpgdXa/RPq39Fh/sSQA5rBoW5UuQuvinTovV6zTGuhK4QXAx5Uf//nToNEZJl
         GApihrCM2U5+5+3MIjYlPOWHSHb+rD8lo6mmvk5Kwr+8+6TrH/WgzdzbjiKnV+Xo6cT5
         t7sFFIjDkcu9nQldIYNgH6pDn144Ku6Vcd0okWURhAkSKK39KFBNQmvzr/HQo1qvdR+Z
         cmzluwocuMonXM2aP9Fs7CE3Q+4LTt9YQmb53JCLOXIPVjZkkUc/nLmRE8Nq5C4+URUT
         1/pF2BFZjd7uTMewGpSk6D8ZLotNbZY7MzJGaYHZ+V/RVf51VPw+8pbnxDnykPttHurs
         fXvw==
X-Forwarded-Encrypted: i=1; AKwUvBwXcPafCO7zXiC3K7XDApYCzYB3KEn46h/itu/GCnCLH2rQNEkNo0+5RepwEDiKOv5FMsdxxlE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtwg2JIlUIztu3uXL218KqyeOCtVHSTZv72y0va3SZVwL/eZhg
	m5DQnPKoy5ov1gQ6Ps3hrjHr8Wj3/4Ah24HwDfuVnuxAriiAFYBTALHZxE5cliRme1LH9ZG1WkE
	FCORuRCAQzbMcKIPbb6AD8BXxEfzQkWnvT4LAL7fUttQimODB3V5sjkraehYNi1ehUeY=
X-Gm-Gg: AYBFou3clcgtN1CsBUWjwJJjQupgufBzpXl9le7e7QK2ZEjz1EZUZymx48WvJ8/iOFn
	FhwryGhJoJj80tRppzl+NzaQ+2YTf4rGlEa4jJoY3t9MHCJOn1JbmRdz3+DoGc1Abeqw2tsmY+h
	2rSgMW6Hl/m3WJ3zLooeETLUBeTAA+w0gGwB9Y5WhCIVVeam7TSynpPpjw4h/1/xpvdpeg/fk72
	Hs2z6KNBmtiC9vcQx2ubsz1mgrM0grnPfx6iiSDz0vN7qyaf9E7CnaRw/eHTLxbCnWxqGphfx6D
	0f72QsBfvsrhCXQjdNszhQnOOJR4OFC60fr7GlVjIra1aOdSCxBzmQx/poTCTA+e6wsLqI+9zOL
	wXO6nqW0BmTe7aSD+vSX5+DdhGjoY+eAwAdlIwy5DPeHnqHrVBmTTzUK6daTViWm2WShFSkswhA
	c7aKROkV3S
X-Received: by 2002:a17:90a:dfc5:b0:3a0:e243:28fc with SMTP id 98e67ed59e1d1-3a6ce7c58f3mr3422946a91.35.1791179210548;
        Sun, 04 Oct 2026 22:46:50 -0700 (PDT)
X-Received: by 2002:a17:90a:dfc5:b0:3a0:e243:28fc with SMTP id 98e67ed59e1d1-3a6ce7c58f3mr3422939a91.35.1791179210018;
        Sun, 04 Oct 2026 22:46:50 -0700 (PDT)
Received: from QCOMk1gASIiYhG (66-33-8-210.colorado.intrepidfiber.us. [66.33.8.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78daef465sm10022451a91.1.2026.10.04.22.46.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2026 22:46:49 -0700 (PDT)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: =?utf-8?Q?'J=C3=A9r=C3=A9my_Jean'?= <Jeremy.Jean@oss.cyber.gouv.fr>,
        "'Sean Tranchetti'" <sean.tranchetti@oss.qualcomm.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20261004203149.3042491-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261004203149.3042491-2-Jeremy.Jean@oss.cyber.gouv.fr>
Subject: RE: [PATCH net v2] net: qualcomm: rmnet: require real-netns admin for bridging
Date: Sun, 4 Oct 2026 23:46:47 -0600
Message-ID: <000a01dd548c$ea3417a0$be9c46e0$@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGOEhXtUTbF+SS34JnqmCUEU5IcWLeM9VDA
Content-Language: en-us
X-Proofpoint-ORIG-GUID: IwST4lPHJDpRZ6s0cnxNGdCwJf_rx0KH
X-Proofpoint-GUID: IwST4lPHJDpRZ6s0cnxNGdCwJf_rx0KH
X-Authority-Analysis: v=2.4 cv=JqlkP84C c=1 sm=1 tr=0 ts=6ac339cb cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=OltkOWFNRHEXGe+8VJKHzA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=AD6CraKjvDkRJrihdKEA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyMiBTYWx0ZWRfX9+JwnQc0xD/d
 UWmxMpGou5S3Zd5kdO5QuX7W54/yHE3epEUJEK8Pbxo0TRk3aTfpiVPVasJYc33A6gIXEN5sG+b
 MUk6enziZDXxZuTR1L5FmaNlD1s2lH0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyMiBTYWx0ZWRfX663Q723sRzU/
 JLxEIvJVguRckHqb+sZ2AVMxlUgyCrGDmiLHBBxB2Xycx6IGXLktdH4y+m72IVXnmnefAggcbB7
 YdZw7szk/CkM5F3pse0hzQznRKXBcrHMEgXvOj3fXBAojY0o6ppMRxXR10vsrlo99quBGMHuARL
 A8bAxSCesgc4SS0tNoYiivlCN09vTTlsb0Q3S0HkKbNjXQn2ou27pxa8Ald1rFZ7L6zlShZTThK
 2GhnxVSlMY6ptjVpY1iNSpOAgdYmZRuCjWL7vadYCQ4CBQa3cfP5i++UJ3Byyp31LYyourvQjUy
 H2xDavyPCs4hrep8qZ5W3WwTOq1BTlcTPmSqqeDUbIvMUbBurZdWS1WBaKxjNycsNo/8ztkjayO
 Xq4BenuiSjJbLawpqoUOqwKFs5vSJXaECIOQefoGxnPPACfjbA3qyyrqUm8veXNx9aYvpkamN2a
 lX6OLYglTjNM0Wcvvlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050022

> -----Original Message-----
> From: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> Sent: Sunday, October 4, 2026 2:32 PM
> To: Subash Abhinov Kasiviswanathan
> <subash.a.kasiviswanathan@oss.qualcomm.com>; Sean Tranchetti
> <sean.tranchetti@oss.qualcomm.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; =
J=C3=A9r=C3=A9my Jean
> <Jeremy.Jean@oss.cyber.gouv.fr>; stable@vger.kernel.org
> Subject: [PATCH net v2] net: qualcomm: rmnet: require real-netns admin =
for
> bridging
>=20
> An rmnet device keeps its link to the real device when moved to =
another
> network namespace. The bridge callbacks change the real port, but =
rtnetlink
> only checks CAP_NET_ADMIN in the slave device's namespace.
>=20
> Require CAP_NET_ADMIN in the real device's namespace before adding or
> removing a bridge. Use the slave device's namespace for the =
comparison, since
> that is the namespace rtnetlink authorized.
>=20
> Fixes: 60d58f971c10 ("net: qualcomm: rmnet: Implement bridge mode")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>=20
> Changes in v2, after Subash Abhinov's review:
> - Add the teardown check and use slave_dev for both capability checks.
>=20
> v1: https://lore.kernel.org/all/20260821202845.4053530-2-
> Jeremy.Jean@oss.cyber.gouv.fr/
>=20
>  .../ethernet/qualcomm/rmnet/rmnet_config.c    | 20
> ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index bed6f63facf2..62d7acb13e0c 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -441,6 +441,13 @@ int rmnet_add_bridge(struct net_device
> *rmnet_dev,
>  	struct rmnet_port *port, *slave_port;
>  	int err;
>=20
> +	/* The rtnl path only checks CAP_NET_ADMIN against
> dev_net(slave_dev),
> +	 * but bridge mode below controls real_dev, which may live in =
another
> +	 * netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev)))
> +		return -EPERM;
> +
>  	port =3D rmnet_get_port_rtnl(real_dev);
>=20
>  	/* If there is more than one rmnet dev attached, its probably being
> @@ -489,7 +496,18 @@ int rmnet_add_bridge(struct net_device
> *rmnet_dev,  int rmnet_del_bridge(struct net_device *rmnet_dev,
>  		     struct net_device *slave_dev)
>  {
> -	struct rmnet_port *port =3D rmnet_get_port_rtnl(slave_dev);
> +	struct rmnet_priv *priv =3D netdev_priv(rmnet_dev);
> +	struct net_device *real_dev =3D priv->real_dev;
> +	struct rmnet_port *port;
> +
> +	/* The rtnl path only checks CAP_NET_ADMIN against
> dev_net(slave_dev),
> +	 * but bridge teardown also updates real_dev, which may live in
> another
> +	 * netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev)))
> +		return -EPERM;
> +
> +	port =3D rmnet_get_port_rtnl(slave_dev);
>=20
>  	rmnet_unregister_bridge(port);
>=20

A similar patch was committed recently in net-next. Please refer to =
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commi=
t/?id=3D26ee8cd69d46a14b37ba5e512084fe80d730127a

