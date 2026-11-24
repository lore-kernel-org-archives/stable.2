Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795490936;
	b=BZg/I5uTyQ64AetQu+dglS1idzzhOxiWkHFD9H6D0rt6uPzyN2S9Dv0YWYlipFVasGP+
	 DE3FY/VAwq5gSFrdNEdMyeovxuWEoLpWHmc1i43hQqBZg+6tf7r8qDpJDzTp7eRsuuG+7
	 ZysBpExX4JOAkRm0E6NsBhgx0ajSSPRzebvn5hNle9cCu3hFoqTStHvDCBZ9Q6anPNap6
	 f6owMDyewvMiLHCPQ9U8D2YNyytJzGEKkJSjhe8E/BAdAniUj4dNxFxXD5o9vcp3n5T9f
	 3lIzIMc7pGTFKUqpN9jiiO8xzblW5A0MoqDbtpD8WEvXQlouoHksZqItdhhwdDIy7Ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490936;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=JoPbedAyc1PugLj6beZG+rft5KDyqU0AHU8dUGfft8o=;
	b=krns0+Iqih+etmzprRK9tfOmETFa7X24knsNpABHxImH7bdIBQ38uLtF8rERd2QDOxiI
	 f0JMZZV7FQvjO27gZnw2jJDZhuSd1KrDi4oIQKoIoXP/PW7e2Ok2H35FGeYD+L4jteJF9
	 fFtaQqy7pUZvLr3JrgzlLRXnJ06wUJLCJBEq/oIZPWPUZMJkCV/CVxu9DvnF+fdIfktH1
	 VruYrHv0Co30LIIPr/OaEK9iAdReNzxCImLDDUoy+5tq4kJ+3IoxE1CqvIIWM8v9ck2hF
	 sVmHlmY/LNVQuizSTUuUzqLiM9zQU8TXesHdWBb+pEpf0HFGrHDQRdcVZgCVEt5q3EQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YsmCe1jJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.32
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05409606A31E;
	Tue, 24 Nov 2026 03:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05409606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YsmCe1jJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGuwF8BaM9AZaYGW5vjBeUP6dnBeA4+9H0o9ydbExxG0YsUbF2Cc25eH1pm7gV3EpvQDUvPGA+YT+UiVlRvff3H4EBhHsgO/VjKJUnYGlU+kSGgQGLAHfb7v962XrnPxQnSKmzI0ZY0OkhmAiX/rlI9DHTDqs7ZtFYVLoVOi/ujwUYXT3B+88qm8Tm8VZIYTgGnfwBon9T8H28Xb4xBGzW48ShI2W9a5fpfboN1cS3xLswJaQaQJzFkEPaGt4jmzSNO0ODRmTni/PWWWV0aNQGzxcjpLRVA50RDPX/kw5cssd9vonnq5e3womOfBURVZjMTonn2kda1mXCJAQP9JLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoPbedAyc1PugLj6beZG+rft5KDyqU0AHU8dUGfft8o=;
 b=wX5NpVOFfNrezS/7XS82bVeL2+SAHjbWy6r6ijwvkaLkfFjY0Ei+KZsbftp70Hcu01xXus+/57zT5kXkjPoQ1rJYeRTSwVL4iyUkbMdH+VJpkfyceN9bLzplqJBK6rGS070Qo5qHkWxq2X0ktC1+4jYEih19ohZB2xty6TQFXap1tkReWBm3ExdzWv+9YzymCnvVNBdpwKIjK8vPofX7xsAaw7ftypEQeovgKB6ERcm7lU4nN3+axyZvUt1/YoNezxBtw0n5bIepAamCHOGrRggf+WYXExENiZVrOeIbrSgtJome6miuDGBgxfxiR8hof/r5i8jkP2XA8QiMUn6Clg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoPbedAyc1PugLj6beZG+rft5KDyqU0AHU8dUGfft8o=;
 b=YsmCe1jJOaJdzoKKqyQVQm/JtAwRaPvcqXPWwV6rd3oU+7Wj3yOZWzsgUUGqlQq8L5ypw0elcTohbeLi4qqrMMn9kPCdhJmCSWui5zasxAprELoQwSZPVlAMZNUGb/uya9RlTB5oGagjD1t5tC4mIpEpvH6pEL8KGlyuqrpFnCyfZE4kXWUorX6+2u4yfxFTLj5LkyefOThkJzswl/cZj8Wc8Z5922lcRod17rMW4g1mwumzLKA9hNIozViQKGjlcezC3GVahcqT+dhMoNlFBWSzthbM9GfOiTa5YAUTTP0PiHAX9oqmu2tH6wjpZVVqf+qw2jg/GgFJXv/ich4eEA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB9PR04MB8393.eurprd04.prod.outlook.com (2603:10a6:10:25f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 03:28:53 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 03:28:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: Peng Fan <peng.fan@oss.nxp.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	linux-remoteproc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 09/10] remoteproc: imx_dsp_rproc: Fix pointer stride in imx_dsp_rproc_memset()
Date: Tue, 24 Nov 2026 11:25:56 +0800
Message-ID: <20261124032557.5358-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261123172140.3547896-10-lee@kernel.org>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0076.apcprd01.prod.exchangelabs.com
 (2603:1096:990:55::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB9PR04MB8393:EE_
X-MS-Office365-Filtering-Correlation-Id: 244f2eb8-6bf3-4c84-f98b-08df49db1072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|7416014|366016|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|10067099003|11063799006|56012099006|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	munmyW4AUR5QUROm97TBT+BAOaWSrIr0yzE9250j2e4Rj3zXgwSk/BTa2wG0ZbVRQfgvju0/gTEl03u0nBhwVHQTjxcF9T3nyzMchKT6yY8Jx6i6P+WLozZmUhoQAEVdjk1iy6mFBKGqws4Hv/T0J1FbNk/O//E5Kx4uw3kRnwZQQcAf0KCpVKF92h6RPzUGBBUPyv7Kx9XZno0bUweBO6D4JrttkYpUI/by0+zNtdG4H/pU0dDVaebrR6EC+vjNIOKuH2yeiD63JqZaXPJIr0l0TC2yG9di5CgmO/jn6ze2ooBqtG+AlUAb1AKibiTpQxOWRmH6rzMFW7PFvCP4bL27AOPKVaWnJPtdjCOzV01HbKjCX3uDXLQxv037KmLENKWAesybRh29FFgWeWL+2MuEzUOcdJETd0Ac9v2RwzlCuuNhNCtfoLQ9xQbgpkhyKYIGLrzl+GLwZ0fMDsVKIeE2AxOFR/Hg68DEJovvRK3aMOOlfnF8IUfFx6DHKKqx0Qr9YqjJW1FSB/LngxuBq+trRVNePuyxzeJ3fdu+zojHBhRKaVWKDEgZD7/Aty+vfE/U2UCJnQsfxd6a2M0rQAMm5/QCdvgVC45P+PyFZPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(7416014)(366016)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KoM3Rk+Tu1s6vaHPkCpxVv+sdgbmC+77nZBt80sMT9TfLKlBdn1TOI4g8SiG?=
 =?us-ascii?Q?uIndsuK3XRZV0+vO8O7xGV+l4RXlaX/LlRQVAUuc9GGkBav6HVgzYkS8dJeI?=
 =?us-ascii?Q?Zn02iz9SWN0plX5iVRCK1Qp0lMyPtI2Onr/1+e3oM20itZLw/khwCKuN8yu6?=
 =?us-ascii?Q?EzEfKN3ve1+/uztV033lbpO0oAcHj+G81940AFiuZxPwR2dZC9X/g6LjY9Eu?=
 =?us-ascii?Q?pLGQbQbpuCjmTVnSvQAFoJ4jOOCKgeq4AwD24S7FPhWyWJy+CrxaoPQV6D6l?=
 =?us-ascii?Q?vdCR5Cti1wt271iV3Pkq3tB3w353M4//uwjPWqSW74lF3/eeOTGk5ByJIRue?=
 =?us-ascii?Q?QSHofA6i5b/SVABzU/72rgGXzkXDui/NEGBoohuv9i7uD1yb1VSwt/VLWIoe?=
 =?us-ascii?Q?AQEkXn+oAH4SZqF0R4fY33YDga2+Og7JYgoGWBQ73Xj0hAMLWhDsuX3XIE9C?=
 =?us-ascii?Q?kSjtwAURcFSVRYX848ap7m8G9oEZ6wtLoiLRA8ecGv8lZo8qSWOZ63Scbz4p?=
 =?us-ascii?Q?LtDPgThno5y2ANx2rq3KK1kMLp7NR/441RaU6XKfsqmVFbFThCedFOAkERP5?=
 =?us-ascii?Q?CSqRkZJubQqL7R6YybJltAmzjzAUIFh+/yTM7YtjWTVobgK6ps//NllntSMY?=
 =?us-ascii?Q?JWkjsdjNMSkmQnB1GRnaBD9myojYIPJbCrVroPGkwIUkZblRmioz2kud8u6r?=
 =?us-ascii?Q?axRe1kE/IzMVoaZ/sEGV0Sg1Z6Bn9gZ7TQCc4OEG//sfskSSjdXXaWzfk4/4?=
 =?us-ascii?Q?Af4FGExakNxNMIc9I2k7wMoWpZWxiAtic4Cp06StGjhUYFpV8gsh8Ir+QxBd?=
 =?us-ascii?Q?iDWjFjQy12SMsDq96ZlX2PYpt5xYcunwBaSOkSqW8C2K9EPv4QwkcIBLPEOd?=
 =?us-ascii?Q?TDewS764UNbNsmDoBBifCJkD7g4rbg6x1wn1utdWTalK+jZ3ZeaTQKfVVPI9?=
 =?us-ascii?Q?k99/wPGbn9IpE+Y97/+g+tYN5IyVwKvVlSsqA72YRLCIi/g+DcLlPBceDhTe?=
 =?us-ascii?Q?q9fQpAW6kRrDgU1xXP8x/JtX5/0rRnLLKpjGpaRkIXxlzkaPTMn6q2oFDsIG?=
 =?us-ascii?Q?GAvHsOMX4mdJNgWdU4bPuERwKBZw4TTFrA/hC09yfz13U/vPVPNRuzNZkRpX?=
 =?us-ascii?Q?PHIPmk/cNof+jvZ+bx51wPLb9D8bdEWjllWV4eW1512wn6uJyIXSJNSv1xoT?=
 =?us-ascii?Q?eHPaxu75klpKBPr1oda7samoWXcHD2vDll2wYYu40RWCvsyBaaLvDI82AVzK?=
 =?us-ascii?Q?R+39b0Ig5n5AEuN6soATirunyEFOyqhRmEh822spT85tXBGOWjvMljXbgl89?=
 =?us-ascii?Q?r2sVUuRc91KyarWVCcNgA35iTNXp2UD6vKJxDmf42RZr3c5FhWYvz1EDOYay?=
 =?us-ascii?Q?JJ1msAaYD+tFeStTUqmHhrh+eYiQsz2vTDv4BFwurANDrtuaisfEe2HX1c26?=
 =?us-ascii?Q?/GSJCE9XsHd9jwOnlVO2/odADAXD7PxSDGcUonOzbhKrzaagxvosy43vmsAp?=
 =?us-ascii?Q?L4EgOI5QCeeGYOokH8nMSKfKLsgHp6fheh5o6v9i4J3EmbGtTb80ifxE0POJ?=
 =?us-ascii?Q?TePKDS9zlwsee0MH+hBzyvY1stpSCyHPXUKL4aPNSGgFaznrbH8EOUPeCcfs?=
 =?us-ascii?Q?GIZYu2mM8YrsjAuv1LQ3zd8tRhC7x9Zc2e8nOuAOWMDi0aRyJi1xM1sfn5wR?=
 =?us-ascii?Q?5HspT39yQamFL7EtKjJcJbr2rZTeQFUO3C7cnafpI/ZVFiqzm27J+BOdYLCE?=
 =?us-ascii?Q?x2ahPimJsbRMhGCGp9bPJkbbP2Ij2ILDOo05AU4BxVbL9rp518cm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244f2eb8-6bf3-4c84-f98b-08df49db1072
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 03:28:53.4705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLPkjcCWZhFEy72EfGBIqnyWElCLA/XhPPxvKW3M3TTJ7AzdDYYC42E5XUQ5cJvMjOZm+YCTz4N8OXJWWEWHMBMVjjaXwYqwyOLOB9tyMfHjUPXGaM47Q0chXxLHkiIn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8393

On Mon, 23 Nov 2026 17:20:53 +0000 Lee Jones <lee@kernel.org> wrote:

> Commit 3c497f624d40 ("remoteproc: imx_dsp_rproc: Fix kernel test robot
> sparse warning") changed tmp_dst from u32 * to void __iomem *.  In GNU
> C, incrementing a void pointer advances it by 1 byte rather than 4
> bytes.  Consequently, the word-fill loop in imx_dsp_rproc_memset()
> steps by 1 byte per 32-bit writel(), triggering unaligned 32-bit MMIO
> accesses on Device-mapped DSP IRAM, mispositioning tmp_dst for the
> trailing-byte read-modify-write, and leaving roughly three quarters of
> the target region uninitialised.
> 
> Advance tmp_dst by 4 bytes per 32-bit word write.
> 
> Fixes: 3c497f624d40 ("remoteproc: imx_dsp_rproc: Fix kernel test robot sparse warning")
> Closes: https://sashiko.dev/#/bug/linux-720f943f-eefd-4df7-806e-0b50cad1abbe
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
