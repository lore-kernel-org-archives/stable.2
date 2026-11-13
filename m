Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794600221;
	b=gfVJLN5OgkMelmb6zwr8tzI5rXs0OP+Jh+11319FFgQ5Nof2LYyjZzxNk3zMrFEgDkX8
	 rNjrOnHO0PW5yIQM38jE9Bq6pRWy50wPW49m8NKw1Zq1D2t/+F4zK/rfBGyoEb9g9gccn
	 RI7miBNX9SZq8qNz/muuFgbU34Drf4ePyTxDcTqFoFUj3q3ynrpmffrYsb5+J68+brl6t
	 /vArgsoz/fI0tPGwqZ4DPzzirx5kz0SSJyp0K1ORQOoBgML2DVsdzu23PI6l6dPnhDK5r
	 8xfMS5sKXxubtlB6W2j0kTQ7quw5UYPxrtzH5VTdhzo1RtJGe0dD9oEieTsMClV5B9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600221;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xjTlavLfGSkb19cYdSHKo8yZO1OR7r0Xz+e0QP7xHQ8=;
	b=jmAlyoOuTWtbVnAR8WI/rQ9zRwuAjirI7kVlFSvIj8OrFu60M+mm2Y8W1Qm5kXbLrUW2
	 VUh2Dw/33M7eL0dmFKO354GAk5vSLPJQtbaDYygg5l368BvMflGIA5T1PhcreLccuWUsg
	 wJKpw0+hi4gFm+mfw6+F60Ofg8EIBfzg7U8QD65ger0au+9xfZedX/VNYczwF7vSnYohx
	 8gHiRpydb1W61Etm2J8PvxnJvAvUqD5LAXWyFyhD/FGO5ZQ5hrg3ACvNP0BVAeqWNgrhA
	 Kfnu2y1nIpr3LGemMgNmLVX8jdBu0w2kBosopOMQzHoLaKiPrWEFTeVg79I3G5m7kTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wIi0Coim;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.55
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC51D606A88E;
	Fri, 13 Nov 2026 20:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC51D606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wIi0Coim
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4QqZLIKkbQCxh/GxKPKfWCgm8sJCij32PBy5HKZxv2q9B5sAjbvpRQXHC2ZPHGI/9CdO31iIA5bwsp36VIM4fv0H7FnLzlLHz0h5d8hnuHOnWYq8UAUIvt7zU7Z4APyvhZqkgyccL4aDMfkCSHcGJPfaTha5/+0LmGgD3wE+obZhcjPEV4ESxFJhJjlMbjCyjU0+SKO+eqRKAoDR5fYFLYpztNcIqqM6kgiaW2Dq8AwI3Hi4xsEblQURICAaFESK1HeQj17cE7XZx8ARbwtKc6gnJaMNRHXSr4BGAFOYam9fe2vmNfHCN23OohOeatYMyZa2CBi/QOigAcbzLRlTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjTlavLfGSkb19cYdSHKo8yZO1OR7r0Xz+e0QP7xHQ8=;
 b=ZTLZNBf6zLSR8Gqzis6r84sLIkYbFUwjSWN3+bkQ/M6sBaRv648qXOtS/AHgBoi24BwcelRq4fwYu2p6j7HTqWqWooaBUktWrv9VYGieiPueL9UcpUmD1MRD6F88++9wbYXGaRDK9RJiQm+8bqQL8UvEglwGLMXbDoF3vx+OFZiir5svrb3g527yJzAMgCxhwePpc5VkBvC7JNV2XRizuIY2EJf10aVX17McoJWkaVVXym8BsOj8NAiBIvslwDGcrw/Rf7hOQ08eh0RFCo/cgiHlR+DszLLXbsX9XLTh4PNW0sQqDmjDx3nXeQvgOCVPeVg6HEuCns4lczLYBHR6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjTlavLfGSkb19cYdSHKo8yZO1OR7r0Xz+e0QP7xHQ8=;
 b=wIi0CoimtMjVh/EGY3XN/dWC/glqfjc7MRxMGgYno+sFaq7pTZubSNJbv/tJBp+CAgmDb1wU9i9fNlbqBgA5fHjDiZMm3neFazogBGDpX/PoJSlVx40e+E2FrsUme6YZKijtjto65VHmkFxOd9NSSkeyCyD2+hsHhFZYLL0Ww9ruWBQM4zsjdyu32PEfX8XB6I147OsD0pQv7ZBHT55sG3nlHA1TctPzK1zjW+M/kCJ+r11xFcsi0HOYL41Drz1YPh+pBlTM0vyUJOiU5E0l2SiotqUaevJFqbSKOQBIy5UrpgID2wlOA2BJ5fr/QcyQOCjj96T6kQcWk8VqpObY8Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU4PR04MB11753.eurprd04.prod.outlook.com (2603:10a6:10:615::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 20:03:36 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 20:03:36 +0000
Date: Fri, 13 Nov 2026 15:03:28 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/4] dmaengine: loongson: loongson2-apb-cmc-dma: Program
 CNDTR when advancing sg
Message-ID: <avdtEPKqoCqCiUvn@lizhi-Precision-Tower-5810>
References: <cover.1792988985.git.zhoubinbin@loongson.cn>
 <dcb49d67055cc41af3bd68cce01c05e73a7c2787.1792988985.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcb49d67055cc41af3bd68cce01c05e73a7c2787.1792988985.git.zhoubinbin@loongson.cn>
X-ClientProxiedBy: DS1P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:8:44e::18) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU4PR04MB11753:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a4d8bb-efda-4d78-42ab-08df41c13406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|19092799006|10067099003|11063799006|4143699003|56012099006|261026121527099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zGRXIPLWmUBDhOiSpZOiMtZ+WLYCsfWuXX7/fKz0dGwVhPOpWdXqzvZv7/FFBO/VbbgcitZiJ7XMBEWrmUX7qySS6TYe2B34ZUouNjoX7zfH+R/YvvXCjctR0Q71cLou7LV1l7Uv1vXLbBX8fbxRpctQinZOBk7YNMuYUZtXerVwpDf8nUKXHc5S2RJHBGwgCz0cFUJDXbzT5Bi/eGNRiXgjpaiRr0iJ7xMXytTCYpCyQnV3L/V8/vJX4yWcGJLwHlWb4jPX1ywvMav1RE5+V0vGTsxBQF9k7ztwOl3drZfss6Pun68JBNkdoUXhpxNErFsAXRYG2tCWUZ1xVLdCu5rf7QA7TZcasfguy3uc7cLIP2zeGNpXEiaPi+3NAo0ahu4vAAupRzznNZlnwBYJpPAZbMYpARlLnm0wG7Yuxr3ck+0hs8YVkJqiw+z5gtaBr/pEtMS4bCzNXDdlSUmvQTEnRecBkJnhfsuckkKIcsY8Xzum4ZBDdTvyfviByDfXTNu2WZGG3X+jhbFBSAkWUPn8VURIgeU/eSDwjs3VbCXUIQXOLz6E7dKW+wOPKAFt6MTHSaDfbnWXpvjUbO2vNwPo4lL0Kt9L4DJ014N43ZWUJnzipZfggYPduWeIZdnFsBMNZjsMpfl1DSuDQAKV7BI8Wh1wISbq4p/fNvv6G1Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(19092799006)(10067099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nFc9oZRSC+Hfn8AMY9q8n7XUwgw+g+vcai0Cd1XeAeu+/YtjgxGUIhDC0aWC?=
 =?us-ascii?Q?ZvtRl45+11Os5vNpV2wQqcM69+j015FfhEDVvb7A348113wzLRoabr0PHsmQ?=
 =?us-ascii?Q?PZlKs/gRCIu1lo9Dz2+sOpB5sLvIMB1S0shiyq/3Cl/wqW3P7Wb6HTd+ZGVU?=
 =?us-ascii?Q?209J5MFvqEYJD4LH1m3tGUkVOaahzItNDyNKBagTcEVLSzXjPf4TamDKryAf?=
 =?us-ascii?Q?7q9SU0nwFKGuUAnVKRpMawvx6lW9VSlkmPcHJi8fV//vCIAGS8Bai5/R7kYp?=
 =?us-ascii?Q?KqwP8ryMVtFQYnPMFbh3XWFihrL7m1ri4sRSZgoXbXXNk7vNvDF9HbbqTeHF?=
 =?us-ascii?Q?oOrRSsAN38XWkP85JmR2OXww0HfkvblNMsZcKhUwXVOC2ZRb6yIplgFqOIsI?=
 =?us-ascii?Q?FMk0XlYQj3y3lXFFrUB9Gfb+gYdFl+N6qoFQ5wg2L2mEWTAgtaV3LAOrpY5B?=
 =?us-ascii?Q?SI/iLdrmdEoYA1uCzM6JnSK/9xxeFAEq0tjVCJc4vCAFqma0NrAw/6dxtBUh?=
 =?us-ascii?Q?bqEPMxAeQ1hJSX1FU9ng6i8x4Q5FhQ1AwCfouR7XdNqGcA5W30f7jcUFl1r4?=
 =?us-ascii?Q?6Y2gAuFdr7XCFl3GuJglZezYiInzuWCRWg7jA8HRPiqimeZUpYIYJf21dqPB?=
 =?us-ascii?Q?CZeoXFemqPhCakC82C7NiBSxSXzHbcMX+PIUfnFwAgVjTgYeg7TUlPuxIuZE?=
 =?us-ascii?Q?2awmhYSeoGLOiK6OcJoY74wg5TYB7JdjGtJH2WPan+lJZPBZ0IbX82iMASXx?=
 =?us-ascii?Q?ni9rgQ2AxvN41zB2T7Zu/7yJ5Dv2JJow+/VmmexQZED8fkdc+wkVRnesQvUm?=
 =?us-ascii?Q?Hh4syFl5dM7a2eWeMvlceI9NzbPsIhPKDN+tWVtMMzAQqQM80F5KC/516Taa?=
 =?us-ascii?Q?GnsDB+sd8t2EFZmBr6tVsJl8D2+gbnnS+pgXSP4F7C9bS6B6jarmyuh2baaf?=
 =?us-ascii?Q?ixhuOnFwS+bSrkzQ32Q740yTMia34QePqDquIuXQ+rhzkXCBp5yNJygwIvry?=
 =?us-ascii?Q?KHLQlerezTiPYtviWax1d8nVpR9suWZfv6Om2LDVWkm5jOy3cRYo9+KuNArP?=
 =?us-ascii?Q?Ljz7s0LOofNzUD1hMZirjhBGwN1B+DgXzWLy62wXHdnmQhInqexzj0zADimR?=
 =?us-ascii?Q?M0Y6PtrNWdTO3AuwiOAyJRe+/4/2lC6MaUyfr2p2r9G9aVqtMt+WqxCGBsUm?=
 =?us-ascii?Q?braNuc0PFOTm5PsF1cUZQ9ezyRveFEI1nPSZK6ocVwLYozRAySKa4M+/jr0k?=
 =?us-ascii?Q?nCarsJL1Oo/xAxMfM7/0oh/5y4fHRiXfLVWhAde/jI04NQUqiIsmRCQgmY2r?=
 =?us-ascii?Q?cULdVyJJoTW9dVysBxVwSAeCxCvk2GXYDmeZlhLMknPXriyC9aLxl8almHgs?=
 =?us-ascii?Q?oPEAYYA+p8iLwIunNnEQNRMNot8xsHKVj8E3zFWuJP1ALCb31/VJ/xsbXJ1n?=
 =?us-ascii?Q?uUPOv/R1aG7SjWUlj8h5GqFZMCBABkhxTYhFzP/Oahwz/cztOSgtgjMio3wu?=
 =?us-ascii?Q?6zz1VlQmiYjXsM1Yh0y522EqUy5hWKT9+CqYUeGZMzpspcxmLT15f84J/vdi?=
 =?us-ascii?Q?Ep9DXNtUew4VyOyZYYEz1Z7oaYnjPxN6Sz/wjY2BGUdCEhef3muxXc29yps0?=
 =?us-ascii?Q?x0U9qlBPeBTh4ukmAjwHasXlUWqIj0jyfeHnMCq81ks0NaUHQt9tALkIawKd?=
 =?us-ascii?Q?v0e5RcK6kxkg/wGNoeAs3KJUAc2U7A9t+IwhK+BuFd6czZCM2pVtlSVQ2HOI?=
 =?us-ascii?Q?iqP857r0G/0SphZFDneOoGN5glN23fMg/5QjR8te3tRLF7rZoLOa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a4d8bb-efda-4d78-42ab-08df41c13406
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 20:03:36.7835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /N2I8cfW6rIV/mcXrquUljzd8Gcse0ONyUdkUTdGzFu5kgKhT77sVAEM2j4tn0D78e/GEzZoEc5rEyehFEMBaJEsfy0UpVbHAd1PV2hV7kVVSVTHdi4I6bqrsHvlTcfy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11753

On Mon, Oct 26, 2026 at 12:31:22PM +0800, Binbin Zhou wrote:
> When configure_next_sg() moves to the next scatterlist entry it updates
> CMAR but leaves CNDTR at the value left over from the previous entry.
> The controller therefore keeps using a stale transfer count, so the
> hardware does not move the amount of data the descriptor describes.
>
> Program CNDTR together with CMAR so software and hardware progress stay
> in sync.
>
> Cc: stable@vger.kernel.org
> Fixes: 1c0028e725f1 ("dmaengine: loongson: New driver for the Loongson Multi-Channel DMA controller")
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/loongson/loongson2-apb-cmc-dma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> index 8b8d530d60c3..c654e0572902 100644
> --- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> @@ -266,6 +266,7 @@ static void loongson2_cmc_dma_configure_next_sg(struct loongson2_cmc_dma_chan *l
>
>  	sg_req = &lchan->desc->sg_req[lchan->next_sg];
>  	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CMAR, id, sg_req->chan_reg.cmar);
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CNDTR, id, sg_req->chan_reg.cndtr);
>
>  	/* Start transition */
>  	ccr |= LOONGSON2_CMCDMA_CCR_EN;
> --
> 2.52.0
>
