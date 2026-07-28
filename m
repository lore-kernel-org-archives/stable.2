Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751F23BB670
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 22:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277330; cv=fail; b=AiVh2YW7q9eRDcHxGzKObqWOV0irQmmNyplpGe9SWvpFVaolG0Vj6v6+2nX1xiykcIdsR4YlZgyvU/hW5/OBWUabp5gwDj1vMoKmWeOv74QCwQkN3Es7fh/iJYQLUcEBH81tFBGYV5MazxQioGkMNjuQUUSerirmLpZ1SST/fyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277330; c=relaxed/simple;
	bh=UA3H6I8TbnkVNEANLp5UUuEx8u9rQt4ALBhOU+0+IS4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d049vEzX5zNaxpBcO08frRXkgzuZwDQ1YzAFxEyJODC6qAYaK70s06DEihSSYCorFikKqe6ym2iimFEzGf8DAeMpnOfRKCyvVqBmeSLWePty9yO2jlo+EmvOr0N21wVpyakeJm632R8xExinUV2ocJ06evEvhh4oPNyJMPzuwTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B8KvXjdB; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B8KvXjdB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HllIyP28FYmeS1jalVoxvjuuq1n1ztZZTgmF+5it5QOfgDXjSHTYP5Xz1h7DxxIhN917n2EnM+NKr156f/8skwxnVFdDTx00UjZbvHFKaSeBeDQnjLGr6QTRIc67ULkwLMh9EQ0bCLRxtVKadURK8IAushkafy7h7Rq86rQN8ycnI6VQINJJbbBQKPps7LJib9Soqt3edK6YmU0YJR/uyGDeIckC/mMWO54nq143SMaoi+kInFwYyqTuPG2OL7UeXrlsvl33JtRGMXoakiZtyt2EsIZrh8VQHRyscCF5sqzH0+oWntrsDLEhx+M/Fr1MATw/baX8F6Gkdne9MxNkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=carAhxuxFVUhuelWNgadnlzGvbKQIG5zyrk9r4Xm1L4=;
 b=NsQfPcXjA63DHXgeqFzQAF+vS1hU+M479y+gWaeGRzqKymJ9/WOjxaHzNp+uIelyH7S8SfVsTiHlFfmJt1ROGETEXe/M8sgqnfPMITIsekhKka6VsBUtYbrom98CfyhcOTkDQRk20tqNT3C/qXjbA//ScoxHYbzbLTst1xNzCTaEyqyYyzcmJFHkj/CWlNigJJ7unJ9HmovLGw9NVcHstVit5hyHPTQrOZysb+sGArjY9oolMUkGJ6jU2h64fzwIg8/IzPUTrMoU3LgFG73DqtqHoWjSM2JyKvL4jWMSAwwJvKFXVi+3vlnt/a6y7PLrGB8CV5cGlJfFhC/KYGOuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=carAhxuxFVUhuelWNgadnlzGvbKQIG5zyrk9r4Xm1L4=;
 b=B8KvXjdBJbhTItPzSNyVLWgewIrbh3cucyA5HNsAQKWd6M0Pb5cuIq7bwcPiuXbHMf+IihCjlywZsoGD1utwxbrGQtvOn7jL6z9RKsyZWonqJCuqKS9NGkSfPAksh1EpmRZxiRpXF19PeZn1lAPzmmCcAizSxxDOhqEhkzff8UM=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by SAWPR12MB999140.namprd12.prod.outlook.com (2603:10b6:806:4e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 22:22:05 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 22:22:05 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Subject: drm/amdgpu: fix check in amdgpu_hmm_invalidate_gfx
Thread-Topic: drm/amdgpu: fix check in amdgpu_hmm_invalidate_gfx
Thread-Index: Ad0e3uWrK6NKamNyT8uvxmu85UuF8Q==
Date: Tue, 28 Jul 2026 22:22:05 +0000
Message-ID:
 <BN9PR12MB5146BCCFFA60933C8B99D677F7CB2@BN9PR12MB5146.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-07-28T22:16:44.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|SAWPR12MB999140:EE_
x-ms-office365-filtering-correlation-id: e054680d-fdb8-4524-2282-08deecf6a806
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 yaVxoo3H6AzUDqhDX4xb/eVRgTnN80HLz++iLoVZ8Hc2m+CFJrtsF/DLs5s74ChcoZwa4G17mUsocWXPyRku5yAzvJslqEGP+LVVbchQKLCIjlPXV9c3K/lOdIz/0TV5O68ARq4CtU3WE7Xtv5nnvpXigu9K0dVfoVJIVoL2xwdS1zuuUp2aaxQa8PHScc8H6V5YQMLNu/X5Yl31qkelvcxH7KxflkFETEqM1xUDYCLUvDinuGpTcpkzPcPwQ31MGXeCxWRBUPpcWkl9qcPleMZOKoovcBeTwPTg1l+QEdSRzHff2DIU/TIoF5e7mXieIbDrEzxY8oNYAr5Wd8Si8Oqyu2/ixP6oO293EHOdgwvq21aeDSiuwajoWrjj6lLXnwRr1fD0pGAcZVkErQFtM+WPnrHUy8AsEte8OlLS0sINU61gTX1L3exf0n5Pp3DCi5LTu8jVGPvs0HuofcTNAZnrm7l6bR9VbpiWqIMW2rPwNmDOH+e6jasPVZi0ByDSMLbWaTaq1ew6Isk+hI6rKjkeQExUtKMrX+ysj36Yd8YLDMx8BpeSLv3Zifm82ZLkOVuyjABi+zBbfyb2GFfUo/++KZ/WH6L2lqXTHpe2aO7ZxAqj+hnemW9AsXXtcoko0BnvTB9F3ScCCuDsCLKAFe/EzjkH37u+dponDCha4Aj9+ecSGpHq70/+AbPG1IHS7EzwnMPCTyc/zcVQ/KpYyH5i1/TMMaFreZEUbDMIcV8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FQVRyMtHL9dyo6LE0voWvf848u52MIeWrFaFNQtGFJ6w7KZTL/1saBNTltHD?=
 =?us-ascii?Q?bmonmlM2N/pu4o6PT6Gb52IwC3F2eVrrEFyWNx291EQXMmGoR39MnzdctA8k?=
 =?us-ascii?Q?7km7lTRbaxdmJlp5aGI67OEmk593spfuHLRT8vEpCBHr+N5SWDLjr5hQeXI5?=
 =?us-ascii?Q?dpXsF/UXBdEh1cdQOhoVBhhL0crYd1Rl/phvjfzLCXgS8eOfDOuF1E7O+qQD?=
 =?us-ascii?Q?yD1plDQNH2EvKKXo2Lf/B+nue/qQIVV2BI+Ftbl0K/ABczn3fMEaThaqcLkH?=
 =?us-ascii?Q?tgSjkWedPEEXKZjaS5uhWpffRcOtMUOMZdoJfCPTGgFmzoN9+R30WEu2ICjk?=
 =?us-ascii?Q?DwhYdv+LXvXfy0JdNjlAKXyqHTBpBBDU/GEVg8JOt6I4bHGjCDrAROtPI3pm?=
 =?us-ascii?Q?c0nUyJtgLWYWdIi/D8Qz2Z6b9w7KPnCHn9fCnWbNv3aqLBGhPito3mMbpxyK?=
 =?us-ascii?Q?OocJZUNgc9YU4zS7bqqHtVsoB3INM7drmn0QBzFnqk5doc/tf2yFIpvpIvTD?=
 =?us-ascii?Q?sv/yyFe8Ks+l+qU8lQs4yvFyt1ixzFAlldgC81hQhgKeu89LqhZa3ihMiqQm?=
 =?us-ascii?Q?mnWof0ES6rt3H6Xpv+BExmoq/cHtBkQ9qmn6UqUTqfZ6deqbh7ih8peUyyB6?=
 =?us-ascii?Q?c5tFeZNcMzSvjuGKqxrigmckpG2OpBtRB3QhkJb1o77zYtWU2Lns2UvtqLhb?=
 =?us-ascii?Q?v0oHzC3iqa+jDxTIbPmBi9dxmK2NzowoWzxPrndldxwLWSMumZPUzzqEwQxJ?=
 =?us-ascii?Q?6V6l+cXZmTk/4s6AHZKG4RVxR9SMOSPvONaPcCM0fD2AqFyQtgu8RXbUKpJb?=
 =?us-ascii?Q?wZNaCpJeFll+a9yheQMZPYPWacEEMIEbHPmvS+RgQe9Lt8VG7zfD4Cf1TDXR?=
 =?us-ascii?Q?cDf1EB33YXqAJdn8UfCFGsQebDsnD6Pk6r2t83fWeYN4zroDziNKWcpgt5si?=
 =?us-ascii?Q?7XjRsE+KpWsw0/Pezc9KOFN6uumKYOyE+iIf0YHaBYFGLH9eEnB/G5x0NLMF?=
 =?us-ascii?Q?fGkA78/P86WDhQytfBjDgvsIy6ObshNEHqf4EtCcNOK4ugS0tgS9zbcGDNn1?=
 =?us-ascii?Q?NSZs+7t2tKhjSzI0rdsxLfeqPZqjAyB2gJevNvbzNUoZyhW57C+Fuk9oJicN?=
 =?us-ascii?Q?C1vQAQ4inpy8QO/M+0bHGR47Rp0s+bsPYi1W+uBwvuzppOtmKLHwTdMn0VFK?=
 =?us-ascii?Q?yEdMhHVUpfnzzZZXPAJTmINE2aYlUU7/qHfTht4qOl7jIvgYgYeSxVVxAuT8?=
 =?us-ascii?Q?pW1eK47nnTwZsl7Las05ucTh+6hV9T7sqVBxIV8Y86DAtkG1Z2Mp7X9yM/rC?=
 =?us-ascii?Q?ilwEtZQo9czUhiRmRHv1hePtMrsgtYq6R3uRyCEwTgmUDwSciTVrU2vx4M0X?=
 =?us-ascii?Q?YsNj2LOaVsPPsmoPR40vmvI5X4PSo67yY6dKYrnUazp3gSLlwW6tTIPpMJbj?=
 =?us-ascii?Q?NgEJHvcJSVO+NjNYim1rtZHyBQz+yj/vO2lo8Xw3SCVuFdEyjvaUszJijtEL?=
 =?us-ascii?Q?RJ7N0dw6v7sbmzEksAv8l5IowSKWpt5hczQls8p3XJVMUpUW0u0WyP9G7mVv?=
 =?us-ascii?Q?uInMmkr+n+FpO1u4JUGb95AfCjeJd9T4MFteuvhzk+Jled8B9h6mnyfj4h0q?=
 =?us-ascii?Q?DXNFJuG4DupVOB1oIokKK6OrD4OPHyYlLvNWqxIPFa2qVjeq4BdntsmKstPN?=
 =?us-ascii?Q?MiYmvV45HcDpAtl5Vh1J+OXRby6lBaCshphqEOFWYnrIPRpv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e054680d-fdb8-4524-2282-08deecf6a806
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 22:22:05.7660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptKe9gn1r3siavUj0nrVUU16Iu8E9ET2mll6+8wOsWLOoyddemvs4iSal9AOdKHaJ5XUmBBiP+dfaZ2WtyMizA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999140

Public

Please cherry-pick commit 52f650963d88 ("drm/amdgpu: fix check in amdgpu_hm=
m_invalidate_gfx") to stable trees.  The patch already has stable cc'ed and=
 applies cleanly, but does not seem to have been applied yet.

Thanks,

Alex

