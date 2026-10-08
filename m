Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FA64A8FC0;
	Thu,  8 Oct 2026 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468876; cv=fail; b=ajOY86QF5mUQIAe3U3I+CfpmA8spyMuz+3+JctlLBw9Z+7dMSlnLeJYycvbnmyXRoKRWzDtsiveUrZAPHOMTEJTR67gbtUwGbSaBp/MYok4vNx94qauaLPm03WxZ/0hFIfG3LTJkm/a71BMZpwWGFIA+29yU1KwiGFdjTK0Bh8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468876; c=relaxed/simple;
	bh=RSJQbEWsgXdgtAtpQMrpEN9itQtva3qIfNL4wR53dAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nL7dATsy3apSYnNyxs+aeXwBFWWc8d+8SL0D3jI/rScWZmqraPvRwkKdrXH7ufxonNtX2/XDxSZrknVyS6PPAGbx05TPWp3Kd07rXZ+azW9Uy77ik5XzwUuZ8p5H8QRhkT175UIF7jvw9lCov8BX8mfJK4ko34cTFlZhnGJ87cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fX4X7Iny; arc=fail smtp.client-ip=52.101.48.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fX4X7Iny"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAjzeamokMovyO+Ec6/iAZkGP3Tlw2HnQWls2sjgbTfDG+c7rAjkUAysj1TmY/3qPKGS4vkjDYb4bi+6ZwGp4SGrwlRKepZSsVyGEUv/jyHhkefdL8p7yW5qyjr3OrRgRhrbeqYB2HgtysIXiaB3j6jZwIkX5aLY4MlZNPxip0zlSFd8M2om9LAyNyq+Prb4g/Q6iLpl64wxLGzle+f/uOxkW5NuC1Zq1hTgz476ZBA6y87Ynyp82uFvQG6iwDMdgeNShrWQd/OKpUaoKQ4L4huKdSrr8DQiRoHXRR47lbBTjMztRF92TXuGmJGTCRvtonXqGsNx/VO5D14QoUGcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Mdny6lkM1aOQymP1Kvv0SEoK1EBRrQUJ3RQXA4A/QA=;
 b=Rc10YUYNGwxHWK3NO/UbYtlgXDtthKvIyoILXXn7m9avEOIFoNr+0YRqCMuNqZqkyqRNGAvXu7JaMx9vSxChg2DnpYct9+Or+XzyU3ksn2UkGmKrfKzretJFT7m5zIRbKmUoiSLlKFvNPZorr9+tQhJgMavFcLhVw1xiaIySDpxsCkqm5epmKH4pfMfQ8XDDiso+KhvCecRh1Z2Qh4Vz4kw/LNr0iSMbqybeTF2PhT8qEscko1QMR4vntoH2gJaCmsJSVeH9P//UKayxECGv0sxlP9w28Lxjz+XNO3b66K43vJfzqBvPfWO2gtvHB6Qrr5YdTufDkWm3DT/8eFGh7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Mdny6lkM1aOQymP1Kvv0SEoK1EBRrQUJ3RQXA4A/QA=;
 b=fX4X7InyPh8kOy/n3Ja5CHTxKinNtU+5GSVnAVqXZA3TDe6sDJqcJA/qXeAbg7mS2C5Or41JjNJiHvPqbB4/9gyKXtGX4xdMNEMtsADZHIob4HcQmQJPCjIgk7qVeFwTu8Q4BGS+zmhvI3HO2+7OrbT4eCQ3hydrFe5Y/4ALjgoYA1QMpbXxEUNi73ox79Yk4a8e9xUZBQAsp/41n1dl+2RXGYIpV6O0t96SWr//K6ExdehbCY5O1NSnyzweGxeG9Umij9YMRacEeMxKvstoi1YDVSvtHp+YvYJ/oaixXjzV72nyjgk1YDudO4a+44UNl/HiFDfchavweTDpkl8zJg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 8 Oct
 2026 14:14:29 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 14:14:29 +0000
Date: Thu, 8 Oct 2026 17:14:20 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, William Tu <u9012063@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] ip6_gre: let collect_md ip6gretap send from the
 unspecified address
Message-ID: <20261008141420.GA1454005@shredder>
References: <20261005191227.894665-1-littlesmilingcloud@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005191227.894665-1-littlesmilingcloud@gmail.com>
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 23dfe05a-320e-4293-24f9-08df2546777a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QN8pfAvKzjD1wQiVTlakcEw2L0ukmuAOt03DCkbXwtATnHm/B1TYie+qFWELLxv1r9R9a4e5Ik8OObUfDUQqUACm3SkhiZZ1GR3AM+xvkH7b3hxC4CDJsycHdTLLp4HgO9JtZH00tC+6yTDYltv+PdfhuBJr3uy+HgXQ1arHeU5aigWdJ3AMfJGUmz4rH2ErzPb2JIlRZIgwrgvk4lF+F03ol+0TUE5uBYVTBRSLIJPOO271XIQDuCD8vAQJKfxNY640rrIIGy8XVquhBFIgmLHt3EJUKpzG+LgyylHVLcCwMA6UEUC22d5GXG7IMTuapPdqdlp6yDW0KMp47irU/swJER3O04DdAOhlGXwqD3R+WyPHQcIMHEAwhFGG8u69ZlaFxrHxatYsJvTCUHB3KqERlQ/eLcrQEs3uFMoBKHxMKefy1OJ2V2z/pbYotDnXfUO5GFGaSWDI1rBLK4QAKC2hsKiGZQ3mGpKccKNj9teRMv/ACbUdgCiQtbQNniD+uds4I0K560X3NkGUDanGVawmEZXRd1qG+W4/yxObz4Jq1wwuoWHzydu/4GGrdspwbLMI1KvegqqSMlvQ7xGliqN5WtOVvLiJ8So/+rJ9AeMXnGjQiol/beUxaJ0N3rAT1EsL09o2qaHWfJkkwGAoV6Pp6vLsxQ1xH2p6PS244v0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xFB1DGY38nC19W6Ynn1gfp+cPUGl9UxIpxNifnJ5025qyR4uWktMLXljZo1L?=
 =?us-ascii?Q?e19k0oGvtf3nBqB3R1QOmtheYOZaw7/gmCm74EdILBiPuc2DXaxdIBHidF70?=
 =?us-ascii?Q?4g4+PWtX7IomHHj2jb04NkF1WHReadcb0PmcEEjuBvQOV3w9txspALr+T9tn?=
 =?us-ascii?Q?BRwkEpoDSZ5FLqaaORioutheKCV70lqI0xBjfMFFyArOPhr5uC5spGDDBS/N?=
 =?us-ascii?Q?Mrj5NytK4RrTKufuR+HTUDTHWd8ZXi6yDVXAHPEQaPBr0pVkHMSMKCuHOryS?=
 =?us-ascii?Q?PZPbnv8duIHQ4AeSU0qWvbADLQb42cLMDEjvL01LJM5BbPeJxZ1hPZP0q0/v?=
 =?us-ascii?Q?ECLyDmqoJ65tU70rTtQhHpNlmhpgSRfXk9QI+NnpIjXlXDULumdsjx1K0HTZ?=
 =?us-ascii?Q?C8tmdNeQpHiTEuWWlGODqbMF5kyflzjv9wS/Yqpgh4+YS76tDfJIw5v7FT6M?=
 =?us-ascii?Q?Zw/Sbp8unAaeIOnjyIiLbSFyX0TCFrl5UMjLIK3liaQ1f6QWScgiRzeNAQOn?=
 =?us-ascii?Q?IEPY0J2+RvzoqsiKe80iDhzqfSsMneJ3/U3wEzgtxYyJC9T6tkxl6v/oBygC?=
 =?us-ascii?Q?d3xy/T5S4nGsm5uX6Qe4wilgj6ZCehsLyD9VYlgEQYh6sX5MaLT9w8tslva4?=
 =?us-ascii?Q?lm+DPbM7UNRN8Xtmg81N29iO9keg6IiTWO2foiX8wbVBsdtD85CXS9Fph7rv?=
 =?us-ascii?Q?TJ+AAhR2whEFBTdNnCvjknGIdNb3BhRa446XzNbfLpP/Blud3EM+ruCtoMxy?=
 =?us-ascii?Q?IbbrfgPVNMTjtw3O1n+6DMhnW/LR/T8/EumFh2+HEhBN52PW4JtOXQa3iwMe?=
 =?us-ascii?Q?UHlwMKxC+3FzJUjsBqLdYBBlOnmdZ5Hun/xypvfkPYQNNOfARHD69eRoW1lU?=
 =?us-ascii?Q?CqC4eCIXZ6ldagfL5edOWzbkr1nEQ23gVKzZbJXLfTejvegkElFC/sLGn32D?=
 =?us-ascii?Q?xz59wmk/iWTqqDPbcZCpyjd1LnE9A1fVXDkjebG8vJpy/9qY4klzPrEU/eE4?=
 =?us-ascii?Q?6oiACsfkNBbpkDwP3gppWwgt/5DSxTNHEQXfIm+iwipsrhBzvorLYtqubW2P?=
 =?us-ascii?Q?Wth0Yxs48UzimE7dWMpcKHZ7CbcecnOaHCZoKXvs7gQWAgaqtL1v4YuScDsy?=
 =?us-ascii?Q?cSXSHnG7INYEMzLD/rm3ilNf2BpgDuG1Sy06zdjjQV9MfjTNcAHNGZBqo+OR?=
 =?us-ascii?Q?+5loWFkFwAODXoJH5/1UatWGWrvGLTOaFcKnztbugRvOflXAu2d2JU7iY5Zw?=
 =?us-ascii?Q?f3cV65ceSLg+O5Q5CffpqK2j3kaJW1Zi9fIwKWSuTmDMmqV0xGhnQ56BJaTZ?=
 =?us-ascii?Q?AeNUGDAmVD0VBN7JeB8e23XgCjwJPyniXrKLJaZdocr0nzbwxuOFv/76vhe6?=
 =?us-ascii?Q?maZURfihd1zoGwckTyK+U2ajctJEK8OwcLTVoLSo29xXTHO1WsOjuo86bucI?=
 =?us-ascii?Q?hrkgWaxLx4PshCuCx4Dc611gvV4K21EtrT5sepoTZzcD4Gfl5fBbTAcgKYjN?=
 =?us-ascii?Q?FR/2qPi4EQc3sHRDASgkANSpwxU27LLipFw7VIAHU+yva/anXa1yqXtWKMaj?=
 =?us-ascii?Q?IvnOFJDPg/+g1qmut+ogf2d/gGSRnpR90PfCJx22f6Z5DG97YRKuXzKOUTF5?=
 =?us-ascii?Q?tueOUGIB40H0E3HpB2EbijGZnh6xlmof38p6uQC/zOM0+KVVF/Vp1E9ZlpAK?=
 =?us-ascii?Q?D0bI9kq+tTRx8bonR21Z9mDvwsqsSJnzVA99HJOZJmAYsSn2sby+5sxc/NG4?=
 =?us-ascii?Q?/X23pCjpsg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23dfe05a-320e-4293-24f9-08df2546777a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 14:14:29.3471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Otco0y183CSXsXcpb7hjrbUosKO594lmImiGcNb8VLfTzIe/K7AffqNTHpkFePdk2tCC+bGX02VUjUNW0hWDpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720

On Mon, Oct 05, 2026 at 10:12:27PM +0300, Anton Danilov wrote:
> ip6gre_xmit_ipv6() drops an IPv6 packet whose source address equals the
> tunnel remote, to avoid a trivial tunneling loop. On a collect_md
> ip6gretap device t->parms.raddr is not the exit point: the outer
> destination comes from the per-packet tunnel metadata. Such devices are
> normally created without a remote, so raddr is ::, and the check never
> matches a real tunnel endpoint. It matches every frame sent from the
> unspecified address instead.
> 
> On an L2 tunnel those frames are regular link traffic. Duplicate Address
> Detection sends its Neighbor Solicitations from :: (RFC 4862, section
> 5.4.2), and MLD reports are sent from :: while an interface has no
> link-local address yet (RFC 3590, section 4). Frames bridged into a
> collect_md ip6gretap device, e.g. with tc tunnel_key and mirred, are
> dropped even though they carry valid metadata, so DAD cannot detect a
> duplicate address on the other side of the tunnel.
> 
> Skip the check for collect_md devices of type ARPHRD_ETHER. It stays for
> L3 ip6gre, where sending a packet with an unspecified source means
> forwarding it (RFC 4291, section 2.5.2), and for ip6gretap without
> collect_md. ip6erspan does not run this check in collect_md mode either.
> 
> Fixes: 6712abc168eb ("ip6_gre: add ip6 gre and gretap collect_md mode")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>

AFAICT, this isn't a regression, so for net-next:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Jakub might agree to strip the tags before applying, so don't send v2
just yet. And if v2 is required, I would also drop the comment as it
simply repeats the commit message.
