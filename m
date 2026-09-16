Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010060.outbound.protection.outlook.com [52.101.229.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB4B4457DF;
	Wed, 16 Sep 2026 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603151; cv=fail; b=AEIUeAfOtRmIpfQZHtkwoadJ5NiwcdoW/sjb7kPX7Dt7Xjj9N5ufP+T36bO7/saMjyET5EowvKY+Tpl4rpii4bGzU552w1/Uy8iKO3//gDOjdpsoO9xbIhXOpfvq+mMRDaGHe8eLLxcnBn++7/9CmnZP2bxo6v0Rpcf8R2yv4Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603151; c=relaxed/simple;
	bh=UknYgK3+eitZyZkVK+HR+FI8FWE81VjdWBjxiYbAR5w=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=o7/6N1I7p9H6VFApMxMaeP+boX7ng6hRk3Gz692nXGo/0/rC4B2KWnlHbR2zkukEVSg/7NrerN3mv1umCqHHmboCs4StBtX6hSa4IskC3Jc8g28n7KFIgFxLb6m7vNZaDFq6hWjDD+xPlRM5j11WOK2tKeSxqYANVWet9uzZocc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=UOySMT8+; arc=fail smtp.client-ip=52.101.229.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="UOySMT8+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eojx+A33rowovGYO+UuMtRphcWEjEZJnwlvBiTmyaAl8Xlsa03z+ITD+R3atawMLGf6q9Qdh7gRMZ4Dep1JnccPYVK7eChIw+eTyoXweuQTWZ9rLsqTyQQYpXAStFicWZn/TyMea3ivG4xVvwNh0QaaPMm6SrTAZK1yvWDar3pbK8zZc6wjeDSujIfJ8qkT5lcLn11zkDqj3NrVAArYULpZzPYRWi8q+KsP9Ih1mvbck89xW4SMDcnki939DfrAtOvia/3u7fCb0d1G1YUhMa4iC8bOpxZNdNoRZRhMxuCx+vnQnxkeVGV0aXAOiKwebdSt0BfutS0p0aUNax+bQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWxVxOo2SGwl2ResFwz+O3479wsd7r0m7mKSfK7aWxk=;
 b=RBjRD7CJ0M0fqxkyFTWMFa9JTReLpX4tU4j9/Ddt6ZRYCdElcqrrBzZ09y0liWkx1hb6qnEB6A7VZC0zg0nt9bz7/KksNh5hbnSvFR6uUftOenJa3wiSmxVp2sc0Borui8rNmUwB8H+4HbGttft21ULgQHT9+KyfluYINv66LhkoF4s5Gjf0GVDDFjC61krIpq0j5W9R6u8OjFVvLH6puK46Ut33sbACMCm6bGeFEfIxkGB72UXLBvZinwqWdV/zcwa1QZ8hkASzFWthUykTYXo3ikzVpCf92vOn1YKlC2PkWSrRRSTHsi7Tn7xUNApvuunNnFmjWlSvIoVbLa/NnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWxVxOo2SGwl2ResFwz+O3479wsd7r0m7mKSfK7aWxk=;
 b=UOySMT8+n2M2VoB0nHJ8B0mFBwnKh/rpJm46Qc+0FlaOBAaktMm30f3isbKNnBpvPXpPqryGpm0Rm63KnnQAHVyynLHJwL3fMUWb5ugsMiPzp1XZX5G0ViQzJ70GsaSNWryuwNct3fSiQHDXPLgm3RKbB4waLgpph6ZazR5iWE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS9PR01MB14121.jpnprd01.prod.outlook.com (2603:1096:604:367::5)
 by OSZPR01MB8035.jpnprd01.prod.outlook.com (2603:1096:604:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 23:59:05 +0000
Received: from OS9PR01MB14121.jpnprd01.prod.outlook.com
 ([fe80::e5f:713b:1ac1:961c]) by OS9PR01MB14121.jpnprd01.prod.outlook.com
 ([fe80::e5f:713b:1ac1:961c%4]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 23:59:04 +0000
Message-ID: <87fqz8zr22.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: broonie@kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 08/20] ASoC: audio-graph-card2: Fix device node leaks in graph_count_c2c()
In-Reply-To: <20260916071631.1966635-1-vulab@iscas.ac.cn>
References: <20260916071631.1966635-1-vulab@iscas.ac.cn>
User-Agent: Wanderlust/2.15.9 Emacs/30.2 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 16 Sep 2026 23:59:03 +0000
X-ClientProxiedBy: OS3PR01CA0064.jpnprd01.prod.outlook.com
 (2603:1096:604:de::15) To OS9PR01MB14121.jpnprd01.prod.outlook.com
 (2603:1096:604:367::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB14121:EE_|OSZPR01MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: fe679055-98c4-4b4c-42ed-08df144e7c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|366016|376014|1800799024|38350700014|10067099003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	15VCT1Ej469RQ4HLB/kiaWJb3amY+15FA1Df4hT4ePxkz9RVgw8To0gIBdCHwmCk0b2cxZp302mJCxqhJAV/7ATZaegiCt55b30kxejlbVS2u1D5WM+PVk8ELx30nvXUDQA3f1wzFRUeAr9wh1xhslU2fRpFHjeWpJOppmGcxgzDoeSam8E+elmjHmg6IhGWbIABeoNE+s09lN5t2tekoctZuOUrlAOYlEM+wMNN2H15FUF9KRGytOFNW66XD6gPvfiYRU1oZQK7es+oEo4mpdNj/+KhypwFCr8uLyzUtacNQAXgHU6aXBKJLk9Bkka9dZTsz6laUl65pwcslZ4r8hcFZv1KMekDdhdOC3qZM2QhQtZAw5gsnfB9i1fwK35Ope7cJeaLO+zSMzmA12Q2MDTSlwIDD3sLUPuHKU+QdI+8m7qE99mrzJxFCxGG2TRtwvGLHtDDQMDNbtrGQywNJ5UZLutjnQ6cefDSxMgM/lABfqPRIyD2XKcz3hMzgQsIecYWKdBiMb/jpbBZg7jiLG0EPuWY/KJm915lU3Qb9gRtifEx4by/gOz9aV1TfU5oAKFx7hJ3qHhkszC/qAkH5Oftnp/JIhdFWljendKykM6nKMt1b+5l7VMo/D5jo8Um5KfSTB60hu4CEuoBjD1pnUhmqHJXnrp9fDcE/Y8N+rL4CLTpREjZb1ZJaI8NvSx83OVW1uD+8iqhlMGVX3g/8vyvA8k4BQXce5JkKGythxw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB14121.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(366016)(376014)(1800799024)(38350700014)(10067099003)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D2vZCpzhWmbzu1/iE1AOOgQEO/vcn1tUVBJwXKOG3YEBRQWQTBdKQlDJ9zfg?=
 =?us-ascii?Q?CjLM4gAKCq2ZUj+0iM60xnsuA96VFkuczyRJtrvZ5D5A6MKHtl5tw14lExiQ?=
 =?us-ascii?Q?tXfugkJpwyu1u7NmSi8vKjVxVyX70uO+n1OCIA9iH03rzJWhjOsDvKpI20SQ?=
 =?us-ascii?Q?/hM8Q8m2eBXDYpcOl2WYVZL9G47jyBgjWFE4ckD+oTMYBfDBNQ8eFuJs22gz?=
 =?us-ascii?Q?mhiSUJS+UXgcPcsxwSnjD9h8BvZbvtZw9/9aEzy9kcmmY1Ui2Ymb8p0Ktwdz?=
 =?us-ascii?Q?9tV4kdIdlUhy3N6brkPVkFDo7149S075TF9qv2i+YR4PZ2RpMw3/Dwl0jiX7?=
 =?us-ascii?Q?XnuKGvJ2WnmdgNywhJeFfJQnDwPGAiBWVTwY6oKRnKYoncCQUlUHSd4v2UhO?=
 =?us-ascii?Q?BaI2kCGHG9cp5ghqHk3QsCaJAhuh3SOR01ZEUY5WEzrI342XZYlAdnIyMkKG?=
 =?us-ascii?Q?x2N0QB+z1pjy6IoN2Nyqnw5O5LNQN50je8s627K5XF8zAOIzalbM9b3DUdIr?=
 =?us-ascii?Q?Wuh6+v8aqRCSPhQ6VvZ7erBc74HY4f2r5Fe9wLfrGHTsin8V6tZTFIhL7Mvp?=
 =?us-ascii?Q?vPiwdIAvhJFTkYY67UfSuWDDw1igO5q6+3twWSHrbPXtD/IVuNpLWIIoJx+3?=
 =?us-ascii?Q?XEIFG6xXtjTx9sMJTQPc41+kP2PLZOeSVeJTnR5/F2emHesrxdOUSIJNLNQ4?=
 =?us-ascii?Q?hGce38e8EX/4o6RaRAhmTEY5RRTBaQJWw1kUL1sB5kwE0IGfp9prIjog7Ocr?=
 =?us-ascii?Q?EvOQ+WDOVJiLwO9I/Sftromu8lJDSs3nesQ+Ai8KvZ0F0z++T/zcQxD6SnN/?=
 =?us-ascii?Q?R4JItbE5GHK99EKfA7kpJg5VgAJIXrV5IyFqD0RueHTOhNcW9lDDdn5b0u/H?=
 =?us-ascii?Q?RhASXlK6xwN9XA5HWDaHnYdtOc4+EIbF3eVihvkD9G4XUAR8xRvGsdaRuz0g?=
 =?us-ascii?Q?yI7FDwU79/0+a5EHzkoUXtr8XgLP5x3MfyF75hCxVvup8YKvT5kR0afP6Kqf?=
 =?us-ascii?Q?COc4tQQPP2/iqBXGYNklfPol5C1Ir6rzC9NczWxvK/yJ0rrGzJnJW8L3IcVh?=
 =?us-ascii?Q?9opt3Nl2npz9XXrHT54f4xVttMS2gmPPsrei36Xh72Vf+2n//G8EISdTqimv?=
 =?us-ascii?Q?UJu7bCmTooxKyOAvF6TQLEHQJsJoDmDkcW6hnBhISJObqzrU1MIP4dppHRpD?=
 =?us-ascii?Q?UVcrR9KUbicJCbCWwB/aSOz+hO91tZauwgGpa4/9nt8p3sptGv/Pd2EYFnm+?=
 =?us-ascii?Q?TIgzXNAeNbxX8FW2Nn215DbYXreIvOCe5KJi8js51j7RkAwuyn0Mw7kH072w?=
 =?us-ascii?Q?MP4d1AxRAZzCbeHM/DiGWaLo4nGtChw3d9IpDMuAOuI/aQIVo6ZRQPHBn6Xf?=
 =?us-ascii?Q?+7bwTOlDYozBSn2U54HRZ7yhSbYmZLk+vK6WgdMVW608HlXRRi0WhwVLgTGC?=
 =?us-ascii?Q?toM35xrJPMB+rE7IKKIQ9MLFUQ6cN2H+WTCeXLcUw/uROmfmv6AbAa9Mdv+V?=
 =?us-ascii?Q?Bp9nLBBfsKLeKSlb4lY8DHLyk1hAui04wLxzayLFdgiIOr6SbzpJp90pKmQj?=
 =?us-ascii?Q?+5jH7LwW1Sfw2uKXilsiqc4DYc1XAPl9yeDl3PSO7ui6InF0nknjptDV4uk5?=
 =?us-ascii?Q?AoGTDSCW3rtoLgxR4fjuHKQrCgTfSR9VCP90cPc0x6ywYbddr1yKv5HiimfB?=
 =?us-ascii?Q?pV/28P7pPcy/4WbrsMAe5V+Rlt8B7JkEJTJfkTSMBenqw5ZNs/HDfIu6CopS?=
 =?us-ascii?Q?oe9h7Ja3kw5NQC5/XkkbUeKfdFiS2rblyfDqKb8jeNz45auqbFEP?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe679055-98c4-4b4c-42ed-08df144e7c56
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB14121.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 23:59:03.8976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8t0HWaa61hHf02+/nEIeAviB2HeU5hQHyZshTgB3QQ3fwgfpal3xXDkFQ7/FF6kAmjlkRnwEHIJ21f1RH0dPsu3E0A3Ui7O34d6WrRsBseWc2VIkrgtkV4yuVK0Feou
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8035


Hi Wentao

Thank you for your patch

>  	struct device_node *ports	__free(device_node) = port_to_ports(lnk);
> -	struct device_node *port0	= of_node_get(lnk);
> -	struct device_node *port1	= of_node_get(of_graph_get_next_port(ports, of_node_get(port0)));
> +	struct device_node *port0	__free(device_node) = of_node_get(lnk);
> +	struct device_node *port1	__free(device_node) =
> +		of_graph_get_next_port(ports, of_node_get(port0));
>  	struct device_node *ep0		__free(device_node) = of_graph_get_next_port_endpoint(port0, NULL);
>  	struct device_node *ep1		__free(device_node) = of_graph_get_next_port_endpoint(port1, NULL);

Ah, it is confusale part, indeed.
I have confirmed that your code seems correct.

My personally, I like 1 line code for port1

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thank you for your help !!

Best regards
---
Kuninori Morimoto
