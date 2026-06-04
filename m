Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F65397E8B;
	Thu,  4 Jun 2026 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540222; cv=fail; b=C/Uh3WfhahRsquPKZKuJqY7JVbv+dUXEgDm1T6V8VdSTfYTkU5tPg76mCYyWLm79NTfyrp4oXcN5P2Iey8MrHjvRGT06LWCGb5tL/SKGCfFJhfYMqxJHEqMOLEtPUtRQCJAwx0yNVozJn605EN/3GKBcRHSDekTMxjMC20UXHQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540222; c=relaxed/simple;
	bh=wTtTWSX6X+vxFL8l8m5YLyJPuwNPmpSgDaOdIcLK88c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hMkqTCuIae1joMmu3sw1vC6l5vTQ7KTf6jFSGFwPjOBwPdXS7tVjp+COIsjIw4A8hp7AVhVMZ2FidLIkY3JCFPpi9QGe9BclyH5iyps92QCTAICp9eXD2CjbmOqf0EfMjkTw6PPY6O9iE3KAwdaRzO4HtoNo/+uapdTA4BqQsdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QlUiIBjn; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QlUiIBjn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbVJC6s2bA7HkTR1/AvN4RJACradv3EKGjpEYqdClpiifPZBciIGLxhqf/vFuQMpG2paGjcM3Eudqa2Dg33IaQ5sfYfJBBvNnphuq8h+a/PY3NAxd+e8mccPWoImIB9/v5b6ksRFaJESj73ZfBQxNIl8vV/k8A7EjCoyfYFFHs720V9H5IYdjHfySqL9JlaSQKybdGn1pF4RIRn1/rosYmeTenQeZGGK/M+fHWuHuMWNQc9tK+iTgeJaIOqLBOeac7jALhhTWaEWBfHgE2LBe4TGWU72QOEwSuD4i9eRetb8yAIaCq4z/okz+BBRTUu8TagQGc144fgutSeHeUYwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExxS0FoyvocqrnUQofHlTjTHKC5V5nqzO3stBqjmAi4=;
 b=rXNjzrMLLlnN6dQLIZ27ibs6ZHuBYN6mHNaGr42aGwI5YxAFA4M4qZW6/EvMPLRr1Xx9BCUepfNKFF/WHor6TXuAqZ+wV8uj6aYpjk2adqK83FrMBPwcdV7WN3HHNG1n6WF3JYRdNee6tru75tzyX/vkJLA6S3dCIYu45W0Chk2rWxL8GL2ncDb6gmU+H3DZQk2dCgcovzHr6LydKDXjsCKXyyGwj7DnTeviKKjZCiFraETXy726qdpXx0OjDQQvZyUbjd4hT6aROC6WK0fr1+l2fHOpkE6R9EvJsuv0uw0KaHc3x6vY+IFrkLBAbmuLXDs6ZehMLqSxbheRlM1D5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExxS0FoyvocqrnUQofHlTjTHKC5V5nqzO3stBqjmAi4=;
 b=QlUiIBjnjryiwQPDER8yF8+ote9KF63zVeATJ6a+vpV0Kt01/JyjPY/sAR5/vVhGYWAFd0/3Fv62Udzrw9TNC+JnuK1vJFEuv/XSGZDRxy/wJeuYSHGZ6/NKVsFdbMW7umqQJac5p3ujrDVNtNX4JBVH1nFDktCHa9KucL4t0exxe/DTNWhEIWtexvUXBcLQUKIz6Cxte+SQ37SzLm1NIJ6hTtH36IwroKoDIIOmv0UrY+6Yo0+UDkLNHxheoG4ySyGT42L46sm4GERyHwI7geHNAojb+cnnzD/jrlCn/2B3aJ9xiSY2gLoGaJqGnGCPwPD05NnbUbFjRy+ibgDmRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by AS5PR04MB11466.eurprd04.prod.outlook.com (2603:10a6:20b:6c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 02:30:18 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 02:30:18 +0000
Date: Thu, 4 Jun 2026 10:29:16 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Jun Li <jun.li@nxp.com>, 
	linux-phy@lists.infradead.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>, stable@vger.kernel.org, 
	Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH v3 1/5] phy: fsl-imx8mq-usb: fix typec switch leak on
 probe error path
Message-ID: <trqxvn6tr2nyaphqc2qmnhgv3gmgl45nqfwjundw7xkd65ljp7@t2fyv5ty55gc>
References: <20260603-imx8mp-usb-phy-improvement-v3-0-7afb8f89abc6@nxp.com>
 <20260603-imx8mp-usb-phy-improvement-v3-1-7afb8f89abc6@nxp.com>
 <aiBxqjm5lsPDXEtW@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiBxqjm5lsPDXEtW@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: AS4P189CA0048.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::12) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|AS5PR04MB11466:EE_
X-MS-Office365-Filtering-Correlation-Id: d5434af5-bedd-4f9d-5041-08dec1e137ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BmfqyrOyJeVla8HacxqRQzw/OfsEpdIyo/5/nC2z4LxZuVEEGusnRbKCCFK3KLquhnutIQ9PWsi8Ll6THVoEdT3xG4usKa7WjPqDlC50UCV6k8pCF98olgHgRvTWVR8YyJ+yYvbRW494FydKn2OxSMkGpxlavac4GxDGRalmVvqRI0RYWzXg57LELpm5mI2wmdi9tYki6+d1HIjVmPOIzNSJCS4ZhU9eJ8/RWw6MxvTrhiXM5B8xTs3utH21l5KbD+lf7YRAOtkZT5BHujdmHb8gjaIr2p2AMYUEfp1iCvskLmniQ0S6UNF2tjJsYxSirbX4s1BxEolLlESlrdit/bSFJ3nN4v931Cv0mio8v4pi08AlgECizcjegMyv62CdNxQQgMzov5isVA7wXkTAiSL6wCGqHSo4rtuI8HblXtc8zlHVluuK4abgYVZx0NqZubqhMpoTzRICugv8e6WsglogBCqudUMpxsJYvrukM4Lv8wcM3dg3NWO9Te8y2eB3uE9ugBwcgM3VqUQ8ZAErEyjkDjZ8Wb6ZVxLMzzApcmN44IVdpkZMlfIHrL8ihbvXs5wFAUSZC0XKzd6N9AhxLFO3DC9D30+f6TMvQgDBAcxpMmCELVHg4dy+55PTFeOBXF4ntujR801Aqe2lfa0dhHPts3DCW/i/mLrR7x0PwEpwSPWKWvzuMniEe5bj83fA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VEWEfd1CqRyEBzz7p4huGEynP8roioMBoqmhI47yIBZP/tBxtHxy4rea9tk+?=
 =?us-ascii?Q?U2qMPVZ2iwpbBJoBJO96bOCH93oAbkRk8CKWoaZACf9ATthE3Hlc4zmy7Yhg?=
 =?us-ascii?Q?qVwFXDgWYzftLYs0hplOvXcN4oJQ9qfOSPBLH55NN+QelcAAjzyLM4AJkU3J?=
 =?us-ascii?Q?lCZhPGE+QkU0gcJRe6azZJCSsciC/CveMB1/P2tNepUVN1TaR4tueL7Tr6ny?=
 =?us-ascii?Q?KY69n8u/XZH3+Hq3jd9wI5acih4YkN6NUmzG3N1IuGlAbtZLuw7TtX6oo/g/?=
 =?us-ascii?Q?P920X7Tg5IXNUVn5x5gnPdJfFe0ZODzC0GeqYSOgB73Ia18U5Al5G5z+jEyq?=
 =?us-ascii?Q?4obWuI2ah6HoLXFcAVlsb327UkoMfT/Orb06UlvByIVt9J6Rx5B6Nv2Dvnlf?=
 =?us-ascii?Q?d/XmK7AHZZGEreg5GBj7YAme94jt4/xBtuAuYwqcw2T37d9uXVX2yALKiRbn?=
 =?us-ascii?Q?i/riHCFzqk1koS+mo82OCzuX/VuY6y7cKc65Ppg/s+wnZ+bbjvcOjza+x9Tn?=
 =?us-ascii?Q?PeMd9wm6owchhQzeCS1TkEOHVFj/DrAD5M+X/cUx9jyZXhTe2tZ83VXbDlvj?=
 =?us-ascii?Q?zGwft4oVvzDOZf69d36k259ev1wpZ0Syu8ElGlVJ2Vvp3f2g+8Wnb7Ktlqpi?=
 =?us-ascii?Q?DFpD1DHlexJBaCPan0CBpKn2i3I5DPl4YklNBgqlu7ddBtJw6ZxpLkGaDyPQ?=
 =?us-ascii?Q?9AzqfBNxu9ojGM5PTEIlHeNS5h2nl87xC1dKtUrAPXMKutlSwMtbg0alfeo/?=
 =?us-ascii?Q?Fr8yK1/F2b5wvYbzjv2TSawfsmXJtSfhhYVP5jag95QFhXD9kN5jfUSwye1Q?=
 =?us-ascii?Q?ewEpLqVHvHPBH7JhI21DICKLk7eBGHVEQkPNuhAWf5jgz0G5SEMZ4vCFote4?=
 =?us-ascii?Q?JtHpu+BApJETC7GMd+27Ma5RsGQMg/JAdHhOR7ps8ZzcFuYbUGvMkEIO3jJF?=
 =?us-ascii?Q?7MWW7eVHarTlG6flMIrOa1tzdCYW65F1/RaF2p7maq06CyEHtJWiuHERI2YN?=
 =?us-ascii?Q?Ch6c5QA3cO//BlEjMSGruru+YYzFjW1FtjTpn4jo3uJcTWP+nvDWLGeHai1N?=
 =?us-ascii?Q?pNrjK4IOnNHFNHX7Uk7257wssRT6HA5l1R92MQ3uPWgMXqzHzMuvEvhL1W5B?=
 =?us-ascii?Q?EbKOaAXBONxj2sf389KicnCyr62wG8IItgNm4sUA/6YE0LoN23p/mh0ovTIH?=
 =?us-ascii?Q?Iqd3xlCDMcKsFLRVbjhy9NJp4a7jdZgLtyAgcyYtjMQBCrReTuBqxYsfznPx?=
 =?us-ascii?Q?qyvx0zlNzWl2snlvZj/RWQOSV6IK6q52hSQ1B8QntzQtpYi1CPY+cK5skrb0?=
 =?us-ascii?Q?YqKg1MHy/qCaPpealnO5YHg3y+vPw6xFBcVB51BtimnSaE7BEkc3W8OYWsMs?=
 =?us-ascii?Q?KzjltszzHRX+m20X4zRY3xhJanZ2Y1gJZ37fYvexB+6gEo/UCf9pABe2Oxom?=
 =?us-ascii?Q?MhvspjGXNCr0BcDQP5XraGHl5DLHhGgr86I0g4bfwBLE3qv/IqkmOadd6ODZ?=
 =?us-ascii?Q?vtJpSI4rlqHd8kFW9ejqJOzig63gIQ/8hmV7MpZZfAE2TmDNKLyXoS1ie5oM?=
 =?us-ascii?Q?evAXf4xpx8y5xrC+HTCn0LmlaJhdfF/jUONSeUhl5BllI9q4z1BqKiSVXtHg?=
 =?us-ascii?Q?7o643V58HbLNPSLhP4k14zBqHOal6jL8HOWIbNb/vNTc+WzgncBJEL7KGt6Q?=
 =?us-ascii?Q?JrZyQIrnamLpt+eBY/LUYxUeVzdVtCds5UA0WKrUEYlYPMJUhCpucIgyv0XU?=
 =?us-ascii?Q?sT4ByCcDZ8U6E7yVUQSHQQEJQ9MgFzR3loTgLw/ceQRSPlb5zue7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5434af5-bedd-4f9d-5041-08dec1e137ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 02:30:18.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/c6tO8SMbLXE2i6Fmu+d8LhGs1qwtjDHfmQonrE2rNMJbC5c+uqjawU51NOOD7s84vpHhLAToe64TXmaF/Y5bwbFywA4Uy7Mc4nTblDoxz9bn+2RoppQaWSOvMehSis
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11466

On Wed, Jun 03, 2026 at 02:25:46PM -0400, Frank Li wrote:
> On Wed, Jun 03, 2026 at 01:37:14PM +0800, Xu Yang wrote:
> > From: Felix Gu <ustc.gu@gmail.com>
> >
> > If probe fails after imx95_usb_phy_get_tca() succeeds, the typec
> > switch leaks because the only cleanup path was in .remove, which
> > never runs on probe failure.
> >
> > Use devm_add_action_or_reset() so the switch is cleaned up on both
> > probe failure and driver removal.  The .remove callback and
> > imx95_usb_phy_put_tca() are no longer needed.
> >
> > Fixes: b58f0f86fd61 ("phy: fsl-imx8mq-usb: add tca function driver for imx95")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> 
> Xu yang, if you send out patch, need your s-o-b tag

OK. Will add it in v2.

Thanks,
Xu Yang
