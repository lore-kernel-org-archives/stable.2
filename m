Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CBB38B7D6;
	Thu,  2 Jul 2026 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974902; cv=fail; b=LxuSxAzWA1DdtV4qmI7rlZdn8WcTjvYTVGGqrgBlWJjhtCoyt9QM4Jp2pSM3D4sUYG0OemdAHUA/KE9cLf8ydeZ4KGvDVo4J5TleWo/HkrobvQOiN4sPvnXj2YW59rD6tRbggYq2XWWVXbb5jW+M28ryF5E5/EKxNtGQw4OM9UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974902; c=relaxed/simple;
	bh=CHkprptK9+0iCBrunEcaSA0uEzvNVQfThEsX3Aayv+8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=j6pEk9qsg/a2rv5PwSOOKsIbwwl3udXj0R2Zrhzqm4Qfcsmwk6Lq7J7oFHMl1xAF/nIhAtqyI/uNMQ057VbCe/f6HteSx//eYfM1EJXpNgCHra5pEk0Q4BRCq9jiWfx5uSyfRbLkCal0GPSeZ9LeQCIoeOJb3YHKTnatgLj/RWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JsRHgTfD; arc=fail smtp.client-ip=40.93.196.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JsRHgTfD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZJtwp5M2M4z9sUJY/DYaFjOJiJGJnZ+kGIdgFVwqNDxtag9sg+7nhNI2g0Ok5h4+h4BN4kqVkLe/Fy0RQrVkI/VO7Tvoq93UfWtQ2kJAVwLmjhOWZaaot6Nl+CvBV2UWTMIjNUH2ka/SGrI5L8hfp4l06ZT1Lxkr4Vgt8YnrMDlw5KsIfCeXHRueYgCLswC589FKygWGm/1w8fxhFLZclcnlxE7jyKoImFBcF4DAyGxuE4bppWS/RxbWqkRWfk9daJxc7f83CJiqDRVuCO0IYGuyXJCvnDiYVZ0Xe8fdVEw/+IoHfJJgxeIMn/XnsiQDYIuwhv6bH79lSSdPn163Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHkprptK9+0iCBrunEcaSA0uEzvNVQfThEsX3Aayv+8=;
 b=d/8lMXSyClh257yiA7C2GOgky+5aO73Kq1FkEh2nUm3ddC1cLIMjojPnzyjZ7ygubZhaYnpvs+Y5fbYeE6zDCryLTKVvtFAqrprDaUngLs2jSHp0ISbku5+hgInO822dYmhLrJYidRBgIpVw3VDY5LFDpwGYnVFnPhrCFqfWpmv6caoS2gAD3BTK4BOIb+cgfkwhgc9ihyY8UZuLs8QO3G1DSqa+fM5pFTGrUA6gIyk0bvq3ql3WtK7yNFHM264DD8P6XOVup53SlWWxUCouNaiysEUnyPchkqdWh5LD93nBXLmauExbK+WIe9uIjQTTY1ZHIYFuk2Zh72rtojvmSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHkprptK9+0iCBrunEcaSA0uEzvNVQfThEsX3Aayv+8=;
 b=JsRHgTfDQ1zmbEFUIfKvRt2bGLB13kWbmQyJkOL2N8ROtBV331nZnUlFDedzKwLkoMDXCsPeKpKVpBOBYGmXR4/NwivxRqYZt3TCF09q+lBwIR9Y10ZnMjPMWCcsLO97UMMAA0EE0bHzqv6z8t1bEriXt4wAf0p1dpaceNeTCKbjeKMrqtVVytE6EhyRNgeTMdR8k3gqwzyCYNDlLQbWJZZj8+aASsWtF/BsAZTJ6KypLJyZzlmnarbltfanyL85uGRV8EQLZrbh9YpNeADEOAlOjAV7hEjaxkbBssPgQDviTcni5jaIHIIp0qhYG9oFwxn2UfschW1iXNExsEQEgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 06:48:16 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 06:48:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 15:48:09 +0900
Message-Id: <DJNVUKOX0FW1.1KD99NL4NTW6I@nvidia.com>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <stable@vger.kernel.org>, <sashiko-bot@kernel.org>
Subject: Re: [PATCH v5 16/19] drm: fix race between partial
 drm_dev_register() failure and ioctl
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-17-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-17-dakr@kernel.org>
X-ClientProxiedBy: TY4PR01CA0006.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e26de3e-b9d8-42a8-26ad-08ded805e31d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|23010399003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	o3ZjDwo251JN4lVOtoFaOo/sZOmGILBVzijmGmXod9yW+2LuweSML/7j7xmq60I6m7r6RbrN+Pg6iJg4hsJl80ANezrD2XEKC7yeBN5wwo0YfohNqx3sr7I1BDMQTrf4q4yNBno2hkdpo3Qt7w5WIZ+Slxrjh+rog0u/HN3XYaahR+Fg8Q7ZEvEmnr6Q5uwvMJ55CQeJR1bQsiaOFviGxuIkB3JXmijgYuJEVcY8wsl0Pi6r9M8Vo0LqPREkLGtbKJk9RUeBODRf0MjYXqa8wJOuG6pGTpFD3UFbsqXGndUQuqT6cI5i4hXkTWF+sMTb63qSWWczqPpoTOu7JyX7vD9zUM3BrZYs+TjzlaSc0h2COKj1y4/gNKZN/HS+HROgtB741wWQ2TV4f7i8Yn9urHIMi1xD1iBvAoTkeT2+7uwmAxGytSc8ENobzmmEFvWq6aBTtLBc/mqnOfSsiiqBfLcoaqZCwKFWzWTvTeIXFBRtFcUsEKcuxCEmy10del2GersWHjfk/roQ0e/GU7+Wi4YS7gS4NkGi2XiNRUVaBa9WaldbQ1xrzvNx/3K2Elufq/Np7pYCoxENX+WUrwOPc8c5/tiSxAvLrsCPtTBH7ab6SICArEtb9NYbPMCt+f54sHY7f0VZqfkEdBE83PRLC8riFSxk5Ac5zWagtbTODFA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk9jMEs0ZHFBQ2w3VlpwR2JMNHFMVTR4Q2pjVUxLTFk0cTI3WHJrUHhCYVc4?=
 =?utf-8?B?dFVVL2hMMlZoWFdSYmptWDNoeTcvV1NUck5mUHc3OGdnS2pLZytMeGpHMEYy?=
 =?utf-8?B?Tyt2Tk5hdFUrelpxUkh4cmpoYVFlejdEK29sakhFM3ZGWjlMWUk5eTJHVnor?=
 =?utf-8?B?RnI1bW8xclRFUmVWQlcvWW1BTXoweW1RSThndmlWcmcyR0wwbjRHdXFBVWFZ?=
 =?utf-8?B?Q3BtTW8weERZLzF3TlZHaWtzNTQ2ZTROQzZnajl3WXEzRjlUQlZXYlA0Zlln?=
 =?utf-8?B?cGlEc2oyY1lhTngzYWNYaTJyeHlvMlNMQzdlZnQxNzRCS2lDazdGaExJcjhW?=
 =?utf-8?B?QUppdXNNdWJBaVhnNUNUR1B5OElRQzFWdzBmYWF0SUdFWStTOUU4dktiMVNQ?=
 =?utf-8?B?cWVyNFdXMmVtcTFhcmkrZTlWcmJrR3FKOW1VOGFqUDNzU20wOUhFOVd2bE5C?=
 =?utf-8?B?VVBnU2E1OEg4Zk5iQWpyYmQ5SmhLaGhrQ0NPOW0vWXFoWFhxY1lRcUFFaERG?=
 =?utf-8?B?TXRieUR1NmZNWm1RcFJrNEs5MjdxWlUwUUhlQlBDQnVuVTdESlZRUzhkTDBn?=
 =?utf-8?B?VGtQM1BBWjQzM3ZsSGk0L21IVVVtQkJzQWRSSEdTQVBJRjRMY1VLRHgyQkxu?=
 =?utf-8?B?Rk13czRrOFhVRWY4TWgxMzFOT3l0U0xhSVBRQStlem1zTVU3dGF4T21XVUY0?=
 =?utf-8?B?RVFRWHpxWC9RWmdldDc4N21sc2pqZG5zWWhrbForbVQvRWVURzMzaURhdnZM?=
 =?utf-8?B?RnRQVVBZTkozTE0ycUN4aVFmczJwemtjR2xmOXFndVNuTHY5S2tmdXJTV2d6?=
 =?utf-8?B?cmNlZStSc21ZczE0bnQ4UDBGdFU0RmJTbnk0NSt1djJBdUFFMnJWeHpZdUFq?=
 =?utf-8?B?VlVuSWJwRTR4N1ZNV3M5OWJzOHB2TE9uU3g1UjNGbzIvNjk4dmRINnFOczRq?=
 =?utf-8?B?UGRsWDNrb0ZwUkk1WGZSQWlscnBLQmliTjJLMGo5TFVhNGIxd3cyQWxSMjg5?=
 =?utf-8?B?U1JkMC9EM0k2R0NBRlJKQTgrV0NTbnh0TnJGZlRqUXFWTGNrY1lhWE96YVNO?=
 =?utf-8?B?TThPT2xJSEI1ZnU5TTNYQVIyWTFJbHBJL0xMOUkxOFFZWTVEK3ZvakYxZEZT?=
 =?utf-8?B?U080bnRNY3FheVVhMjdCdUNYRk4vY1BESk0vZlFiRU5oNVRnTW05TU4vR0xT?=
 =?utf-8?B?RFZwOHRGTTdnQlBERU5Qc0RpVEhGc3llM3NoM0pYYk5TaGlvUlNvZkNOZGZi?=
 =?utf-8?B?a1F0VVdnVHM5VEZmVU5TSXZHMFBQQzQ3eWZMcWtyQXloc3cxb0FQMkFyRzBx?=
 =?utf-8?B?THBnMkx5QjhpWjNGTzdWQjNJbkJnNzd5WHRYdmpBVlhVQ202WEdYQTQ1QjM3?=
 =?utf-8?B?MzV4aGliekUzelZUdkxUV3JTUWl2bUdWOExHdit4NCttR1N0ZzNONFFid3I1?=
 =?utf-8?B?QW8xeElGUGpBWDgwcWtla21QdGVFV1JMWHRmSFZocThVVzcxN08rTUhTUjdY?=
 =?utf-8?B?VkVEUDJHVmhHTFdLYjh2dHFyNmh5SWJZWmxBbVVZaHhiNXpDUDF1QzlvZks3?=
 =?utf-8?B?Y3lMWDNWZTQrRjlQdVYzcGsvYy9NUzB4ZzZGN1hsOU8xdjg4SEo1Q04yeUlV?=
 =?utf-8?B?SUlBaStLOEFWeWhUUHgyQ256V1BPVEFYbDJ6SGxiWW4wQjBQQVJmd2JvY0dO?=
 =?utf-8?B?dHhHTnhqM0dnQXpHYmtJV3YzdDJ5SStiT1RuMzZlREVqcUxXdVV5S29LZ0hB?=
 =?utf-8?B?bzhIcitJZ3QvV1FERG02L0ZxQ0xzT3d1aEg3dkdwSjVZMVV5V0xsWmpHamNP?=
 =?utf-8?B?RVFMazJZb1ZaOW1ac0RKektYTFE1RE4wcVo3R1ltTWNXVFpLSHJ0dks4K0cr?=
 =?utf-8?B?cnJMT3RvZ2NNQUZPN2lVZ2tneUx6UEcrcVNaVCs5WGZUWFdqcUE1SEUrV2pt?=
 =?utf-8?B?cWd5YWk3eHZCTFgyKzB5THZWd0dhZnVnbWJsYVMwUGFUL3VyMXlPY2hBcWtx?=
 =?utf-8?B?Y1JlVW9ZM0JqazZCamZ3Q1NFS0lPSkJKc1dKbFMrYnBHekFma045amhJTmJR?=
 =?utf-8?B?ZVEwR1NiSTFFL05jLzd0TXcrTHBlbVdxZXVHcG0vNU9ySEdmdHpkZWN0Z21I?=
 =?utf-8?B?ZTFOZ3UwYzgvK3piODJSWUZ3YlllREF2RFVmTFBKTWUrQ0R1ZW1qa0lwY0pQ?=
 =?utf-8?B?dGcvME8vR1libVNtdXYxZ0cwL3JYS25PNVI3NlpOK1I4NnhUc2VTQWdkV0Zj?=
 =?utf-8?B?NURBQXh4bDlDM3hXamROOXlXZnBqblBKdmxETnlPZVorVkdYQXBmaHNJQTRs?=
 =?utf-8?B?WmE3ODhPR0ZHQ3NRc1ZsajlkR0ltWG5LT3dKejZGTllYSjB2bE5TY0dubnRD?=
 =?utf-8?Q?k0uRLZVK/4XzKT/51jYpMcQzdhpY6Gs2tFdJurlcNTcSR?=
X-MS-Exchange-AntiSpam-MessageData-1: 8TCvInc/8YdRFw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e26de3e-b9d8-42a8-26ad-08ded805e31d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 06:48:13.8205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3aRr8GSRVJlDmPYnCxfsnjMOIoVNYOuasYI0rW2zsytaxdmS6pnf9SAYnaRIqySmYMxdwAVPymwzq9MCf91Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039

On Sun Jun 28, 2026 at 11:53 PM JST, Danilo Krummrich wrote:
> If drm_dev_register() fails after registering a minor (e.g. render minor
> registered, primary minor fails), userspace could have opened the first
> minor and entered a drm_dev_enter() critical section. Since the
> unplugged flag was never set, the ioctl proceeds while the error path
> tears down device resources.
>
> Fix this by introducing drm_dev_synchronize_unplug(), which sets the
> unplugged flag and waits for the SRCU barrier, ensuring all in-flight
> drm_dev_enter() critical sections complete before cleanup proceeds; call
> it on the error path of drm_dev_register().
>
> Fixes: bee330f3d672 ("drm: Use srcu to protect drm_device.unplugged")
> Cc: stable@vger.kernel.org
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260620190648.2E9F61F000E9@smtp.kern=
el.org/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
