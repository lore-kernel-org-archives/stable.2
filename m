Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC30446079
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515019; cv=fail; b=l0cN5IoAWMmyo3xLUC7uArky1WjJGgzXMajBlC/K0zgCl6bSSwBs96R+PgLX7/ZI7tEdG8ApuF4lLS00uqsJQH9/7Ep7NrlSivxYSwU++tyeHMjvYrDo6cAIWcFjS9PI7KtPxqINKDp7vlDelku5ohSXSpi1NMHAIdYFCjlIJos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515019; c=relaxed/simple;
	bh=Ewf2tr1rdwzUCSOV6VWVp4y6tIbMm9e0nu/P7MDS1p8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ssFvBU6dx/38QJS7x16kANGDY3Hb+4scznQSSPq76tHmlP6fjZhkFlH46rrJRTIdiNvI6teOy0IXzEcTR+HE271mz4+pQkhObNzGP/J+Rxp3vMdcMjE1uRd3tV9g+WmbnNC99veKMhj4F22vy16qqss0nKk+OfPoTpAFYL0HTRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BBwp/YEB; arc=fail smtp.client-ip=40.93.195.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BBwp/YEB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4wUmiLJ4DQRar0yv402J36QKtWgWKSh/IEGIKvw81rIsZGX5yvBS3QBU1NXWbjkPg6tyjTtBYg8XlnFFHbc2tiikzqYs+g9mTuoNzS1jVjtBR9gUFLJXNa4/H54nZkWDLw9UurCVn0wyWLhzI6WXji03aLz7vQ80++79S41VlGTOd5xYkCyemJqX87opqiACbNVmqV7HuE6tUGRR8ZvOcIv/bjN5qH6zB68G0/lGMIDPQahEHdXtsxK/eKe5Df9EW0UwvRc880jSd26Vj8zsLYU8jcETMQrywMB3i+cZmmm9CcDzOlhuxAoGEah+K3pjqgu5JugnTEham5/4kKZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wat3d0r2GCc9mXMqQ6bzOzdMQzEvO5fLmUXFTKYn3vI=;
 b=nbaZ5QGlTKZ46atJZMrgJOnVELwngM3P3c3BafJM3fp6cV53G6oRt4yTAXf0uQKDIuSeNjqSX9YJkfzIKpG5UH0wOF0Ida1pcG9qeMzT5ajl+oO9kjy1G83gyAZART1QXd9S7XX7dI976PAUI/tTz0Ri7YYrO6LC4QC8wlEtVVv04NlcLlJomijUyTvNQC5Wfowd3F2oHqREo8bYRtcdJqT7EVGz0WeGq18/biHRf4Cn4FKNOncrANCrHhQwMAcb6bvyojjMITqdmP0RA4nWfwmA+TICDJ22GjlAAxqR8st8yJ6258lsnKJIJh2EyWUjiUKDH6xJzJY8cGJPe1ZH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wat3d0r2GCc9mXMqQ6bzOzdMQzEvO5fLmUXFTKYn3vI=;
 b=BBwp/YEBSbOnf+45bgQvqi3w+YCZyE7AVF2K/6+gwAcjTchzUTZeyzR56+E02LGWLHP83yl1RcOaJFQouEhNSBDCmxrNO2M93fBfZpL4lmxMChFNa99rUTTiaCCtmD5PCweUE37zkDLNR7/ZKQjuT20l0AoDqqz31eFIld+61GU=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by CHAPR12MB999247.namprd12.prod.outlook.com (2603:10b6:610:2ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 16:23:33 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 16:23:33 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Sasha Levin
	<sashal@kernel.org>
Subject: RE: drm/amdgpu: validate CP_GFX_SHADOW chunk size in CS pass1
Thread-Topic: drm/amdgpu: validate CP_GFX_SHADOW chunk size in CS pass1
Thread-Index: Ad0gcSLzKOXSCMEYSXqwSh24qdpzzwAQRjSAABVs1iA=
Date: Fri, 31 Jul 2026 16:23:33 +0000
Message-ID:
 <BN9PR12MB5146800829D29BF285AB18F0F7C82@BN9PR12MB5146.namprd12.prod.outlook.com>
References:
 <BN9PR12MB5146DD3D2AA3DFEF175A7948F7C92@BN9PR12MB5146.namprd12.prod.outlook.com>
 <2026073157-demystify-frolic-d787@gregkh>
In-Reply-To: <2026073157-demystify-frolic-d787@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-07-31T16:16:30.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|CHAPR12MB999247:EE_
x-ms-office365-filtering-correlation-id: 70d984b6-f35b-4a84-441b-08deef2010ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 2qKIM08FZp7aVeWy9mNBdIeeTAiVMstj6gP0FrstTaiiyneTM72689Q7XpWxyEvR/lAEfoSU6OLQqoGQvL2veqDsolbk+ta98LBViFiqrsN8nVJzXIeuaihLvbhsW8Tn0TrmBHEZjt3a3kAq99fiXzbJ9As+O0FIMnMoWGbOpkab1oMn0VMi1wl4pCnX8xzNTaMuJF6Szp11uOgujhzpQagVAiDwrXaDnq725RMHZhQflbwqSQJ8+ho7Cn7YUt56vtlezGxmN2p7s03x6Yv6jLVkNZbYB40DZu4ZaaDzr2njDFx1mlgEM/iXONFyzMbydgeNvAzoRxiV/AAyUwkNaMZR/aykY/3KwwSOJZt3Rn3qmnVQ+YhXzDob89WnRVmlQH/bzKHUP3Dp9xuxmrWvLMnIIwXyzy1+G6572kTwKf1wnvpBnFnr4vTfuaq4KqkQEOzVSSt0Rb1Fgv1rRqKx1xs1htyXYSot2Rkv/mFZx+1MDSywpdB1kVdix3jkEeuLBvM3WzdmsazeIkp1vhcklbZUiFHln9KxeedCiApkFtYoM7mxpsUMKMgsdXdrESFOsrbCa1gx7/iGQ7YwIE5GxKRAxv1Cs6dcQi25RCx5exqtesMF3ykhqjC//GSOl4BBtxPBKwuLqnNRY9o3TK15NsG7/JND85LitZ+8smq5La0YKrp8GB7zaeOWYbQQXkaB0JbSwptMkPLamAQDUKJXs4byt6rG7z+AT/HrmZd37VQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wupMULIVFcRUJ2cVr6labi6OAxb8fzk6ljm0Aj9P6ggYJtEOKpV6IlpsYbYM?=
 =?us-ascii?Q?jMeSd+wGSwpS+VJJ1IW2R82kK2Fnj2T/wBFJLXpHlrVUjCDJPiMqmM5ntp68?=
 =?us-ascii?Q?wXcRuq0yzgvh2CHQsMtUt75uO2XMIAvJHwgt0qnLXRiUsl3OKWyGp11amP8Z?=
 =?us-ascii?Q?ciov5juJuASGRoTOEWkTeAzuWz2cVUte4UeglAd4SagmESjlKHE6XUOweUHL?=
 =?us-ascii?Q?RoGJEF9gR7y+sgf8QATbR3/N5pC3ih+BAV32qYhhRdfP2XpI/iPZg/mjySNr?=
 =?us-ascii?Q?2gVrj8iHA9zPzIQoM5BZcxWw/LtPJn87DuB7tUuEz64/vV3gEv7+gcvVaN2J?=
 =?us-ascii?Q?9MiwrL+aIruMIS9txwIBk8ulCncnQxLuqTaVJ+EezBNAKWoeJUZf62B20Sgn?=
 =?us-ascii?Q?6eHsbCvIYQ2CWjcJoqnAa00OvZdAO6cOIm4EmVvL0Vw/H3CSSbi9INm7ZP00?=
 =?us-ascii?Q?uH9ELM5qb9hjzB59QxjjTww5N8jgHAKOHrqoYKtPsPAYYaJtfPkCT3v5qY6d?=
 =?us-ascii?Q?cAPQ2wjJmfBZJyyCIvb4SwcbY8d5iRl0L90J4WrcqyWxFm+ZgclJHjJVq3FE?=
 =?us-ascii?Q?OP/H3cCZL1ZoJT31o8W6Zt1mbncXTKQ7SBo/k4N6h7XMvmlHb0oaHk3Owf9U?=
 =?us-ascii?Q?VbmHY69UGl/fBvIyzBJAkMfY3f62z7sJzlXFtAS3jbkGJznKxZjB4T6rBhp3?=
 =?us-ascii?Q?Jk9RqC3hicOWn5L6t9CYfcU53XIQxv7BMlcHvjgbnje/HxAbZxLHdXgvPWNi?=
 =?us-ascii?Q?0Ax4a7LKKBLWhFEWTWIVQiLZAYvdTRO3sm3ApwHbdZH1me6WsT1DLOIxXSnP?=
 =?us-ascii?Q?IKDSgVRGFzQBV7RsobOeHqUnFzeQRQVHiARRkm5edsMxRm7/hL2GJRjm5atS?=
 =?us-ascii?Q?KJJJkGK/ax/JNP0zXwAABj8XGZ5o2pL2OXWqoudjLCflJWbXjym+aq7WzaCa?=
 =?us-ascii?Q?9CNiVl3RSv5qJ8KkBxcsC7uDk9D1IVn58dZwsN2GLV6i7UdI3Y4vn/8CnW1g?=
 =?us-ascii?Q?lLO98IigOPleDd3tFFnkNgwPp5vNNp3T79qmdahSj7SlRjHTk2iyka5dv3LK?=
 =?us-ascii?Q?9+seS9PZ8LH1LvRLzhIkM0w4CiRIRfkQz2k2tt2dqR7oY8jRgR57gCHwaEPJ?=
 =?us-ascii?Q?uileI3/sz9UCzn3tlgvyNJbuWvQlni5XRth1otiL74LgQ9ZZxBaU1kDNvKK7?=
 =?us-ascii?Q?wqsv3UeQ/qsUeoMk45TkPgj0Wyq82KOvId7X1OKTu7kzdTA8Ox/OMXaJ813L?=
 =?us-ascii?Q?INhVUZkMiBPGF/JkywGJAHKh0ql6liCEcMpGqZ03J/PjTZJIR9WkFul7cO+a?=
 =?us-ascii?Q?Qs/CqGRnSnHrDuhgadfOr9MjWzCXCr9Dhmw6GOK99TokwPZ+KKILMCvC2b5T?=
 =?us-ascii?Q?dgjG+lnH65cdDb47eD/hoQ8d3Ylv2KrbfYOv3KJb2NZea8LcbpvDjAPGJrtq?=
 =?us-ascii?Q?y3OI3gLkNSL5U8qNm/2MIAEFGZRt6jaqwNchRKMDM3WrhMDgnG8+uA0BulZ+?=
 =?us-ascii?Q?vYYqSirvq0JKSmSqWS+dpNA4lcxTC3DX4V23dGg9hMTXpP4YbXwPde52er+0?=
 =?us-ascii?Q?1Bq2vPVBurk7G5y6j3TVFCsWLYrXi4A08hf9Yoqa8m+AmNQp68rdtlPpX7+8?=
 =?us-ascii?Q?1D8oyczCul3xFhT8uBYVpu4bJpmeQ6Vm0fNjbb1U8SLVzB0h3MoWImh53ryh?=
 =?us-ascii?Q?154qE3FoAU5nUiKN6WY6bOv031gKRicI9BttBHCHMoJ+NfqF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d984b6-f35b-4a84-441b-08deef2010ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 16:23:33.5894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 66ymcWVq6CF/LOVhD9y2ljDb+g7kP91h60VfbfnZBvkfyCqoY4lYqZgymMPA/7gQj/AIHC6mfoXtgAmOgAFoCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999247

Public

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Friday, July 31, 2026 2:03 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: stable@vger.kernel.org; Sasha Levin <sashal@kernel.org>
> Subject: Re: drm/amdgpu: validate CP_GFX_SHADOW chunk size in CS pass1
>
> On Thu, Jul 30, 2026 at 10:19:11PM +0000, Deucher, Alexander wrote:
> > AMD General
> >
> > Please cherry-pick commit 84c4c36acd5c ("drm/amdgpu: validate
> CP_GFX_SHADOW chunk size in CS pass1").  The commit had a cc for stable,
> but it has not landed in the stable trees yet.
>
> It's been queued up and in the -rc releases that went out yesterday, is t=
he
> version there somehow incorrect?
>

That's perfect.  I must have just missed the update when I checked.  We are=
 starting to get security tickets from researchers for issues that are fixe=
d in Linus' tree, but not yet stable (even if it's only been a week or two)=
.  I assumed it would be on it's way, but I just called it out to double ch=
eck just in case it got missed.

Thanks!

Alex


