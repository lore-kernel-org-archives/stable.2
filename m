Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5500A3382F9;
	Mon, 17 Aug 2026 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002333; cv=fail; b=YCpZEdpOjgLJjLPn8c3DXju4Y7O9VPJFCk9h0Sso7NoFm5r4NIge6oUG1XT5FEQdPspvWu6lfVVBZAau+EoDSEEdMNMX8G0NI93HVvZNbxGtP2zvC9zKbC2+QmcmajtiV+RzrdSctgEpfC6oQFy35242Uz3iBubMExNB5zWmCVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002333; c=relaxed/simple;
	bh=FYKtJe204XC4vEyVqFQmxA9ghjlQQcTgPMuXUuOJKSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XS+h6eRRq4zVAIuLarApfY8LZfatmsNMJQKTFaOFim//QYIE5PNYJzv13gN1VSDXAad95M/914giA6KdsrBNBfJJareRFtSGD4QYQSUX05JBRBWMV0mo3e85j3TxYi0Jz3pxoTZhnuH7DerWBm5fAddbixmghWS4etk6DJgAhA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fo27sdoM; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fo27sdoM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNsPJdQXe6xTqOC9m9rp2iu3ZXDP7iPEoNqjhFbpPwb8tO69jwXvYACPAiOR/Z0DDOfZqwT/S/6+oiBJt8cIF22K1j3tKY8fV2T/bw/7BwQ4zSK7ZmHEJf67BeQQpmk7Bl0xaCLiqHuDaB4e+elvSf79jjUqxKtyYYaj1Q8xL6qOcagz9kHNMWIdcS4SFbsO5xtFuO8J1lV+VdCVK2rqHuy+i/X9WX0F+tIaOVXSroMin0YA3t8zEHxWyPqR4U4i4suYfSh007xMSgDKXv+nNHv+9TeZaJqnuvobFcahcbhXx6bFGvmq/69xB3sFdpbpinlm1fBKIpy5Ss1WRNx66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2ivUyE5MdE9C6W9i9D+Fl+qE0x7gd/VnfTx9lEdaqE=;
 b=NDspz2wlLzh9NJZJ3yftfy+i7R4IFnYUoeZfMsNkaxDv4m1HAou8MFVe4WGAIQMAjmQ0yc4APLcEWdLgKbSKZdZAYalBV0kh9nGdTm/BXC/hs2I1HrhGwQh0WxAgUEA1fRQ+wR0LP/yn36av0iOkTFFtxxkLTqWp5xxb0gZFh7LEVKuYJ34ZoVX6Q/JYTUwA+WtCyDCMCJqOBncyHgf4VX6lXIZpVnW4nLo6wIKwYUVa2A2zdqZiDR36Qgl63uidLTnYv0A5qsF4L4EWDmMb2B/hExnKfXfHlayDZ46vSupKgwmugDy0/o2XONfjzjRHA8+NlF6OQBGstyz3aXbDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2ivUyE5MdE9C6W9i9D+Fl+qE0x7gd/VnfTx9lEdaqE=;
 b=fo27sdoM9CzPXbJd+g3G+FicRWFaUQ4lG0ds/ArP3nB3ErI1KVGdnGi9U2yldZHDLAXbsoUpHmGjIu3hrOfPFDbwjlvgIoBQ9muaD4N7BqUlvrNIu+b0csbv1XjRhH+kmXxOgEYVeJMjzae0cSANDHH0mxtrS46JbTinRrpDuNkNqDZW9IOqaB6TaH2EAaK/MUFsTq86f48cZBITdNiv1GNtUAFK5HgUstCZU+AI6+bqDvtgFCuLxOxm/q3qcWSk9AEaR3CRE9xtoNVl50wshTi0pplXRy6ieAgCaR/PmQbqQEDAzYObPGCHxe46g1c99rXIZlmiuz1tuUh78WqCUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8576.eurprd04.prod.outlook.com (2603:10a6:102:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 21:32:09 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 21:32:08 +0000
Date: Mon, 17 Aug 2026 16:31:58 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Yo'av Moshe <linux@yoavmoshe.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: imx: Fix suspend/resume crash with Clang CFI
Message-ID: <aoN9zjWByjoIsr6c@SMW015318>
References: <CABCJKufhvTxmVm8y7xr4RWWKsoZk0h8UGBnem+F5fknnimaqPA@mail.gmail.com>
 <7f273a08-b29c-4e15-b340-898b251efe57@yoavmoshe.com>
 <CABCJKud+GsBVv+XMTsi_4QAaTHo7jXD2Hyvi9wqKd7x3i2xyAg@mail.gmail.com>
 <415ffa24-a30b-43b2-aa6a-a1cde3bd4ef0@yoavmoshe.com>
 <CABCJKud9B8vB-J8f0HLHw6EgEKVWzy+Q1PrNxpO_6yCGtEyi8A@mail.gmail.com>
 <12a46993-82a5-4109-87fa-61b8fcf764aa@yoavmoshe.com>
 <CABCJKufoQ0fX797M01t7CkTgMEwNCELY1=ptZsxr=jWOR-KAyA@mail.gmail.com>
 <CAKwvOdnaOy-nyZ=8oLw4N-_hA9JZVdP2BhR8cweCAOhsy4VG6w@mail.gmail.com>
 <91cb0f21-e78a-4931-b123-937c6a01592c@yoavmoshe.com>
 <2056b473-4175-4383-926d-d15b566f0dd5@yoavmoshe.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2056b473-4175-4383-926d-d15b566f0dd5@yoavmoshe.com>
X-ClientProxiedBy: SA9PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:806:23::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e039703-076b-42f0-b01d-08defca6fdcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|19092799006|1800799024|366016|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	0oPaxd82D+XusONMz3WTqVWOoWAWSwaZ798W0hy1Mke6xFocjlSQPU9QCVJ8QaRIzU+oPk1KycZO/QbjryHiXq8c8ZpjRx1kjKRl2RdqJVReCZXXCzbJM8Nx1YBKkLe45VgWhWWPskqD9EJ1baIOVY0UhckNfxgnPrbbrbHJwgjsSn+vTyvOzx40BydH6B/r9qUbvu2ceO/yY2HowrYRNJBqeQrl4kHRbCYWS/KSr+k0Dov797E6ftEUj5+Or+kdwyEhgwIwTlUrTsoy0DO52aAOBefb3x8tRcdstKSwgkQ6rcUjSg8pJRjIYY8ZOGv+XY13U0S320a5RBfffRaWoSaxT8gWulgfP1uCuxKGq+0r5FirejSXMPnwbda0ooedkn5AdpiXKsjTOt/YRVKVVQzZHeks9RctLQlZMWTa97DTdXO/JVVRgphWzhbcIayc6UXBwBTzPimxILp1tiFq0I80b59gh7nlWjxYtyXOJt3b5gD8nFx3mwwQvMJ3ro7kpOfb1Zy5eHPw7frgyUmTjDdFKbkuwAZsGtL7Ow2oIULY1A3NbzEAZlsVztw+B/dVelh+G2OSihHwWDdy2pF8D6yGNgdhGjs5GTiJjMZeldPGQilOA8Qqw1pmaL+eDHy6UPSNxZ9tRFH68AeBATopfhfghIxb4Yts2G1stbprIfg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(19092799006)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W11UfF59o2dx78O84jMl6jUd+LJn9vJkGt3qAlXN9C+mZPcuIBSL8zKiiTlp?=
 =?us-ascii?Q?TcZbVYZ1XNZ8k0HjRxGgvcI7LY0SEjyISnybpiHV9uui4HLhmm4pjhZBMvxs?=
 =?us-ascii?Q?ziPcWPcDYSxSp5kjB4hxnDMD9t4io4t78fOjaj06coBhIkrzW/WySx/ngb8V?=
 =?us-ascii?Q?xGGnnqDpy6oJ3dP2NsYM/A6UZP0EnMuTa3gb+RfuCGO8IIFSrygrfXOd5nDQ?=
 =?us-ascii?Q?g8ddVgQsm4McL+ENsMdO/4S03ggNTHhQgHbCeJdW7gR2O2MlrGLUKbGbyjO2?=
 =?us-ascii?Q?25jE7yKUA18Z3gBl/wd2ECv/ZHMfS6JyYjyMcmLfx5gOR9qiI1C4hRaiFjaj?=
 =?us-ascii?Q?H/G0qgQdY3rwHd7OlerAN5aUGHhCYBKWj5v48b2q1CtKqGR8yrmcjHLTqlb2?=
 =?us-ascii?Q?j7XzpcXp9XC5Cws+uwDtSlevCUAVSw7OEBUSmUbTQQeQt1yeupe36Og8bmsQ?=
 =?us-ascii?Q?COlT9MXqh478Yjv14WEQO27g/MeWFbYdHmamOl94EFsOxrxN4Co1lswrBySz?=
 =?us-ascii?Q?5nhkoQpiVQ3HmudiGQMPQcnsFf1xMm1XNPzHzkslk0YPolMUBHiRjNJi8Iae?=
 =?us-ascii?Q?P1CUlVlTTU7a9ZzhqS1TVq2yM7ihMl1Vk1U5jMovpQVxyml1WraBSKBXU0Ls?=
 =?us-ascii?Q?Gf9M+3/WqD/hTmBjicCjesA5xLgsOVWIboveZzSeSmliLNRX4fC3scYQHvNQ?=
 =?us-ascii?Q?py7cS6eDRo6iPF+2iReAs/9Kvzsj3Tt+/T+6z26H52nIoaI/ZhT1sqcXBk+0?=
 =?us-ascii?Q?4opm6gQvxvZwEakpYOk8JvEQz9jPrJXu4nV6g+UUsvm0/8UzGSJBBMM5uruU?=
 =?us-ascii?Q?zXIfdVd4G3i3C93GGOUmdRyxtEQGAtsMqCdryDAmhg8mN1pvN9CKiiv7n0w7?=
 =?us-ascii?Q?BHm2JpMpib/gZrh0+rNH8S19Y2nohWsSJNbtxudKuSsTaBta3MXHUBqWBPDX?=
 =?us-ascii?Q?xinJ4U4SgJ586no2Wln2lrfhjKWoPPZ5m9wrnsKBc3B/G2uFtU/LSVnx6y1+?=
 =?us-ascii?Q?Du2N0Bl6PEFAcwQFUQzHKWkSH6EPU22rEoRKqdoL9dLRr2mmR0vyltqoBDwI?=
 =?us-ascii?Q?6YU+eWkxEevxXC00puJaSU/mJ1ljzn57OvAbcbBGTTUbtpzCVp7fMqTBypGn?=
 =?us-ascii?Q?qYb+VggnT3U6y0OcXI56XkHUAiPxuFfwPIUy4LHHJmalELfvt35z+X+MO9NL?=
 =?us-ascii?Q?jcD+/J4EjNOtz7C5YdcORgQQsHrU31NbsY7cME1gxPG/3zSzxVukGXbzROWW?=
 =?us-ascii?Q?m3tONnurubnfwfXm4vNBrVVRAjKz2rGseYNho5KXBZvoHeVK9O4CQj5pArmx?=
 =?us-ascii?Q?QaPeJfnMFN/vmVXE3M1AWmjap31qt4pYamP4KKlERrD3l3hsF6ioe7Vh7qC0?=
 =?us-ascii?Q?WKo5LGMEjjqs8E87gulAfm1nsz2jmN0n/zkC1Donmp9NSiEyRImx1SGdwHX3?=
 =?us-ascii?Q?c4XfPsoWdHX05PSS9JffWwzLjPjRI+9EdwoJ4g3wOvheoiqHSML0lxLNPxVt?=
 =?us-ascii?Q?N7p49RXuqIqdgIQPzGJgIxt9RkLozwbW0xLwYHf8FHjb2CHkkHaEd5/xO+wc?=
 =?us-ascii?Q?F311zJ4fuTz9VaxH99tnxsqJlRdAObp7NYddH2ah/YlHQibFkutzEBDrIDY0?=
 =?us-ascii?Q?pEzx0Akq6Z28NOMzya3nftRMEJDReswFEjbDBDl/eJBBTeGfgZkGldlWdTVw?=
 =?us-ascii?Q?9iefAQPME7Tv4gR6lEBQrcUbk0KO6SGB4ef1h6gWBGvqx9T5VykiHw8cXiOr?=
 =?us-ascii?Q?qhBTR6qX+MO1/aG1Mhgw+hVYuyz8/Rb7NpOUpvwb+oKX9V0HRzDx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e039703-076b-42f0-b01d-08defca6fdcb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 21:32:08.8023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJZ3bSOxv4gk4dmDtia996sm3slwO52EGmeqkx3T5DmU9Tj3N/g0EH3A6jM6RukMRgs8GA53hPI4JJdOUx8383MF7V6tvz3neAztjk7EtkRlqVi6YkukCmA2H5zwXmh4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8576

On Mon, Aug 17, 2026 at 07:45:18PM +0200, Yo'av Moshe wrote:
> On 2026-07-26 5:36 PM, Yo'av Moshe wrote:
> > Yes, I tried that as well and it unfortunately didn't work.
> >
> > I tested Nathan's change along with explicitly copying the 4-byte
> > prefix from before imx6_suspend into OCRAM right before calling fncpy().
> > However, when checking the compiled binary, "&imx6_suspend - 4" just
> > contained padding rather than the hash, so the copied 4-byte value
> > didn't match what the call site expected.
> Hi Sascha, Frank,
>
> Gentle ping on this patch. Is there anything else needed from my end?

There are long discussion on this thread.

Sami Tolvanen and Nick Desaulniers:

	Do you agree on Yo's implement?

Frank

>
> Best regards,
> Yo'av
>
