Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013079.outbound.protection.outlook.com [52.103.46.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5E2346E43;
	Mon,  7 Sep 2026 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788823766; cv=fail; b=Bn3O3EvHWdSO/Wwv8T8BeArB7bGxTZonMUoX9Lw50hLmt1cnndEp1C8jxT3//qrnzVQnQXIWW3SfsUqhV9zxjONZl53OiLWhIM84AOLptTgeqOTpLlE2MN3eORDlF4NNQpCbaPJdXst9wpGutDQ/0dlCdQ05VBSxtc+QVUR0lgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788823766; c=relaxed/simple;
	bh=g+g6VDLllkg0dynMatl/Am/3FhQ2e+dopcBKxQXAqgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t7rtMRfhxHvMDCyWgV7NAYUTQBqHGlqgbmjlC2HsiKzY4DPm9loFnDTMTdb5x0aYd9v+9yWxY9vOqeJBDTuW7DhHb6qA+K2aG2TFQWk5F/XZTCpjZFe1yZuRbll6JumbLzrZSZvK5rMD0+OLvQr+GnxXC/o9iZZMHqGxGa/O/Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=NxnAeGcT; arc=fail smtp.client-ip=52.103.46.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="NxnAeGcT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1YPlvtacC12u4/q4tXBRXM9PYp6O9J4aLO7A/MDnGSuCNahCf13iQakMUYXyfRvmIn+c+6ZzPYtPse8biCxdTV2o6tfhR3EwHqnuXJdHWmA+bg4CSl/YHfvlfSx8Nv4rw07hmG3UJyqv+7jUVt9AdJI7w82MYQk5FX4bxNuaZb2iKucXEAg3fF9XnF+mZHiHsg49MGYWQLPYNTpx0Gvr+X+2hM3gLFW5Of9s2oqtjjUYOwSyyFEw/lx6Xhp2+J4gIuCUh7gOhiObg+1w9ykb1viM6745dh5M9WKNKfLFllyLjHBimINfKmDEP4eVW/lUaMrOx1Si6BXXUzwI72Ofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Oub944lfy3Zt6i/neZSZYe+SMwC22YeC0wUzMr6xEg=;
 b=vE02mQ/sEipwFS8iB/+OQdKQJfMFzeeVum8ARGtGeEzNG+o4z9mbubgomYEnOrWQWr7xmEANRLD5kI0OBZSZo5lbY8B+169oglyII6yWIiBn02MyecfSU7CJiIggxSBceW7p9T2KHM96SLrJEP/6/dEa6y8DDYusRac2vDDDhHLXnGsGg7fWHCUMUdx5QzwUF6CYXkm9b4VjvAEf/IPg+gKGCvPfrA/Ew9wE5pT9KhKREn8Wup9cCD7lpMn0mQZM0lonEAq0FfTVb/16dykd6LvsobQ8dBk5nEobKUvOKhgN/VscjhW+ZaWGSEmL3/i1K2ebrECuQOr53Zoru4MuRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Oub944lfy3Zt6i/neZSZYe+SMwC22YeC0wUzMr6xEg=;
 b=NxnAeGcTf6a1ZYTVfFBg8kL/2y7DfqdSvd6M6iC7V8+r9D9albR6YGLHV2i7rhkZM5qU1zcUGjlrZCFDxuOO4+GK4I3SaiAyxgTnslb9Gp2GOtiAKcSbqv38sl3UoHyOpT3M9fhjF4kB5zo/BWbDhsaSpvXIuL4d+RQej0YK0sIiuNpuJEraxbl4FrFqE58VU01G74URDHTBNnsazG/444kU7AyQpnCjbWloRNtMQTndu67sxqyWju+3NPp2SO4xVlh8VjjWEiYwRpK9mKKLefG96BY02GpDdL4XIc4HBFvQXTPW4/sj9bSAoWs1q8nIOgpNjDlvioRqaJVVXL6+jQ==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by DB9P251MB0358.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:2cd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 23:29:20 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 23:29:20 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Aamir Ahmed <elb12345@hotmail.co.uk>,
	Xiang Mei <xmei5@asu.edu>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: net1080: fix out-of-bounds access in rx_fixup()
Date: Tue,  8 Sep 2026 00:29:17 +0100
Message-ID:
 <AS8P251MB00015BF44CA9B34835C7155CC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <AS8P251MB0001E8B611B22B19AA882542C8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
References: <AS8P251MB0001E8B611B22B19AA882542C8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0225.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::10) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260907232918.113793-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|DB9P251MB0358:EE_
X-MS-Office365-Filtering-Correlation-Id: b06fb913-a22c-4527-3fc7-08df0d37d77a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37011999003|25031999004|5072599009|25010399006|8060799015|19110799012|12121999013|15080799012|55001999006|24021099003|23021999003|2604032031799003|51005399006|3412199025|440099028|26104999009|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TiamTcOdKGqxaRVDume2oCDD/JSAFe9FwZG3OYjwWEPq//TWCctMEOG4JbP2?=
 =?us-ascii?Q?XO74VuSfiZpjossj2QBIYaWdb63djvr79tV61jnHDwmeA/lxV/TroImgOgNw?=
 =?us-ascii?Q?SnXMPdey/LYWQq1zmwlPo+xfMx2AkkSqCoxMC6FCg9Gcayo/ll0kW/G7fePt?=
 =?us-ascii?Q?Z08G/xta+99sz0nGp2pEL8VLRGW7sIA4cvkdLbkjI1j8FYPrjLDLJ4oabP2D?=
 =?us-ascii?Q?Dm7Zl1pWIpLf5A3prpe6j6TlcZ3RFRSc4Ss2wBSanxM1WT5z8uG5boTPqDMG?=
 =?us-ascii?Q?YyIhLHxi1cM6iTt1YC3UufxRTdItP9f94N0Rhh8BDFmTSPilZEXG2ULnPc6v?=
 =?us-ascii?Q?sYTfcSpPE/xBJeWvXswg54R19VUmTmGtjbhVZsALtYuQqyiVT/S0Jh1pZ3xK?=
 =?us-ascii?Q?DYWH4kO02QR3VO3xG/q08BuyhfuAfIUQTFjLWfqdb5MWpbANpFtyhu4MdheV?=
 =?us-ascii?Q?DF/IwplUtRBaz7IPG4jc/F3V6Ju1uLaww3GCLi6VuuLPlE8FwLGOZAZQrJWR?=
 =?us-ascii?Q?eb3q12hzkDOhzd6ItzDLRkg1/Ep/TuFKg+9dBPXziWbsuYIhYb+mW+P6r2gh?=
 =?us-ascii?Q?Y0NE3XFWuCuTyQqeniP+zW29KqVMxeV10VzY9VPuFirPHx4psQIt/GudUVcD?=
 =?us-ascii?Q?VPUnwFGNJT64Y95j1csGDxWL11QfDEwTZxG4zY5yJqS1sCDB4VK+kcpjIVdi?=
 =?us-ascii?Q?BSRSNQOvc2XRTOZ0fbdpc7Qip57xw9JyfYR13KBOt/C5MiOdwbwd8YstatNR?=
 =?us-ascii?Q?a4dfObKDPJbMZjg6OAkBXGN6xT9ej1N6nwnhke86mbK8MqIyRMK3skFahu3x?=
 =?us-ascii?Q?7yiqUHMYEjdrOX5fhsw6ngjDoV7No4S0k3qGsgk2A2711nJPRmfdvxGXFR8+?=
 =?us-ascii?Q?hJfFlUhJvKShpoihQuhpdO6b+Oo/lQt8aCFnaJfl3HCt3q673y9p3iyWpSPE?=
 =?us-ascii?Q?G6qWAkbagyYR3WTNd7AwS90UTiHo2+Gm4vclvTPuyYYvoe3SxNeNScbpVLfc?=
 =?us-ascii?Q?iqo5IMtgqCL5uhjshp4D70NGnsUhSGNVzAiFfuw5YvMTo2YjIp/IUa5+TXOb?=
 =?us-ascii?Q?HJUhxs5ofQZenrjFlj0VqHzTYpnO+K3ZzD8fHXhqsAYmt3pBUMG/dXqycstP?=
 =?us-ascii?Q?Wk2DVycH7jIhrCajj3HNDaxUy+oWCK5B/A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7P25uKYYSYWCsMMfUZk24+ohjdGNLK/vnw6SX6rpu1qKz0Cg5yTthWC5p+MW?=
 =?us-ascii?Q?jcSeVeWpVX9VVWKuC2Etvo/kyXUwFlLclPy++bWxPirCieY2Djv1hCAVETyW?=
 =?us-ascii?Q?X2qfyuKy7o5qfzFnxYnQL5RucKQL2K0R9xIehQLUxDz62XhYoeTEQpy9DjuM?=
 =?us-ascii?Q?Lm2XqS9+Bd4bj7W8SiiP83D6uDY7fy1I5XqUX1m/MwvFd3LBL+eqs4aLZ4jS?=
 =?us-ascii?Q?oiZDfyKm/IncSDcufaydLSpV/zFcq+xqutYl+ICJ9+0/4Jg1nLcSyM2P96Z+?=
 =?us-ascii?Q?bZ1VLYB3CRkW4Azr5hr3DNZx2Gb6n2fxwWuiPYKoaksz4k/zXHpz/LGfbZdp?=
 =?us-ascii?Q?zNx7oREagYDg8+Xi6rOfc0lovI9vz7LBXPQUDqb2eSsxym/5c5DgV1y1Xrb/?=
 =?us-ascii?Q?RTJa6tUaa8Ar+yFQT0ti8dazJNkO8uh1Z7nuuUVHbWNLod7RHHfpt0sKFvt5?=
 =?us-ascii?Q?75xScjTEGzjdKJZbDki2NqCcdE7dTNpvlBexJFEP85pWLf6SjD38W56cYGVe?=
 =?us-ascii?Q?RYQZaEi7n7ycM51WCDe744a/6rS8ZpiLmsPiWi/zBcSVRlilDr1+gE/9Bejs?=
 =?us-ascii?Q?2wfQWOMCX+wWrW+XmmTIl0J+4o7CGpoce6MpyXDujCxydv4QN4e5xOfGGKWS?=
 =?us-ascii?Q?/ZYeB9pMCj4Un6BAYys+EoXvm9uA3Qpk8uLo5du64OdTUIGsH3/m6sX9/lX8?=
 =?us-ascii?Q?Uj2PQcrZHpJOmEyDdlTCkqRG1h9QIXczXmwW9OzKzkOsohsHjLHWNQVK9de/?=
 =?us-ascii?Q?wIc/9NNFp66WEbZgmTtdIlu9pUTKab8WIZb3xgK0b7Axz+y/UKh3TF3IlMRv?=
 =?us-ascii?Q?cvC+vEoKjoxt88sEJ10Mfs1tzD5Axbc1AKL/EIfeIh26awicP0QeRGBcfldB?=
 =?us-ascii?Q?FZAZ1SwaqAKM8JQEiQe9rayD+2CpE4wHyHBAhJbXyiBOZrLlqCy445En6t09?=
 =?us-ascii?Q?0cuy17uEzQQgXJ669bdyJ7ZDJ+iLMchZgwtRlTLr2qXGoVVFeH1FFOTy5kcC?=
 =?us-ascii?Q?ndPMXXzX433vNSXsw9vZRnDx/lph3GcR+jGxt126U9OkhHl6qnrQpaYqtYfW?=
 =?us-ascii?Q?YxexBlo4HLIp70dxslJiszg9YZ4sx8yB73KsygdbDB7oTY18oiTvrs6VLmE3?=
 =?us-ascii?Q?c0e7K4hpyeTmXSM9Hfv0phfIT7NzOMkF4lEIQzyIeU7jGmRAZXfhGxZ1QQJj?=
 =?us-ascii?Q?j3y0pkvg+cOQjNKi3wzC/sG3RI/cDYltQ/VMzh1LGxX5jbg8BphrpWEdNDAC?=
 =?us-ascii?Q?nY1SdgFO9HATWryJtf+lvmQ5+cDKJu1SSBe618wMZdGDrim94e6jmdBWP2xC?=
 =?us-ascii?Q?vkKD881g/by30Elhf+rWu6GbNbqJMQvfTkJwQ5atXeK/OpT6/8RP3ko2n+lx?=
 =?us-ascii?Q?vic/oZVB6B/aBYyp7d4gKWphKXn9jcC16OJBY9iEzu2onR1OldJQ1GlVIStQ?=
 =?us-ascii?Q?vXc/DUypTvU0Kl76yvrMYfwalkHLE8pL?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b06fb913-a22c-4527-3fc7-08df0d37d77a
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 23:29:20.2562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P251MB0358

Please drop this patch.

I rechecked the code earlier and there is no out-of-bounds access to
fix here, so the commit message is wrong.

skb_pull() returns NULL without modifying the skb when hdr_len is
larger than skb->len, and when it does pull it leaves skb->data +
skb->len unchanged. Either way

  trailer = (struct nc_trailer *)(skb->data + skb->len - sizeof *trailer);

resolves to the last two bytes of the frame as received, which is in
bounds because of the earlier skb->len < hard_header_len check. The
read of skb->data[packet_len] is likewise already guarded by the
packet_len >= skb->len test above it.

Thank you.

pw-bot: changes-requested
