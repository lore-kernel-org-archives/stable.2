Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795680830;
	b=hnDb3J2FefXd1xb08bCvsFEjmjM2gmrmWEy+BcUgOJko/ocRDqEuaT1TEQbGlwAen/oc
	 vLzgpGl3ITyA1Au8mLl6H+1fNmJpspsgoo2jKuk4tKHYocZFEHKjBt3CJtvoixjfdmrKe
	 /Yzrdj5FfuIVldqHAi5VTyLtzO6iyFAYNU2FNeysrad+FydXhdUe5I7lle5AyFKf1fti+
	 TNQqOAtTwjSkzQl0DYqqx2MgI1/vIoguZKFo2dzpE+I5C2OXPGO0JMKSQSovFpRjZ2qKn
	 LWSXXlmxT+4Mjul5MuCtjfV9NH4gJGglharypS1dmSlP169RGRQgZrxgu+gRyvhMG2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680830;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=SH1v40jZDuAYiYznoFzAks5dcCde4UNXBob2PYPBeTE=;
	b=RKAKDk3DeiZKerdz7khADBUmngOKtHF6awUg/vL3MRfbWsAcW+qzA1yAy5+AfltrYMQp
	 S8yFwbXN+mo7qu6040vn2+m7s6AfxbBR2QgLs1lbcqOlIoF/RLruJ6ctmX7nkgmNNxDh/
	 XypVpb500cYpiUpAKjCcaY3Pbm4R/EaOr9PtisUSeJJJwKgfxtl80l8GyLYFYzMWAuyYx
	 llK21ZFKvvTXJ4cLG4Z6Jc8Wig0mMsnat+4vRMnhVMNKI0zFxUGUZRnyHUuehLahsWvPF
	 YkTUGfeY7nVg7hlhuyNS67X1859LyEgYLewOABna9lA084WUtVo4zcy9oYutOuUfClQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XZRtVQHm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.39
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C468E606A31C;
	Thu, 26 Nov 2026 08:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C468E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XZRtVQHm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8Z0J3bBqJbQbawe7YAtrya7Zd+axzddE9TS4ksm0Anf4GzOwAveajNo4EpYSUgHd1JS8H9HmBXVsbtYc03BjymlsMYM/m3SczIMlgGRU2+vDD02OyR+t/iuhBQH6+4ErvvjZs44GTeFVLyAhnyhMaEkyldqDo2BZcYAIk3KED6SjFSM1Lc3rzLxaGLcEP53MDyBAYl3aXg2xNG0FM661R6E/GrZCKqdE0UTbGIRpoi+n7ALtNZvD1+qyfZNhhk3p8RgVqRP30U0k455tuxeicaVEQs3SPOLvA9srSJJlfGOjbfzZI/E5pId7cQZ9X8OlLPWtHEA5x96rpqZ/SS87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SH1v40jZDuAYiYznoFzAks5dcCde4UNXBob2PYPBeTE=;
 b=kR28H2Icr2ctm+grysmLs8dVw5igUApT9f0er6qz2Q4993kX5pZPZ8Qnp/kaNxey/Nus7iYzErPHK4uG0XlSYq4XHOcGzOIPmQZUisYFCdAxd1r+f7JgFh4SNyFl+KsW2+sPHq6A3iAwxgJn0Qf1iQK78J6HqWu1eFQm26WAuASskTURYqjlzt1bRMXHjdZEjvk7IQ+LzlUIdECfhibEUCorPLZ/HyE/adFXitogvxYc8XUu4lrXqHOSQexdxwrK1k+na9DVS6gilv+iPhzYlt2HXAS1HDH30Qf8ByGLXzZE6SNNERHSIqrHUY+DcAgtP7EDON+vRq8sOM/MRMlL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SH1v40jZDuAYiYznoFzAks5dcCde4UNXBob2PYPBeTE=;
 b=XZRtVQHmG+3BzKBwtBJYvRFYJ9TncN+gazXp/MgPw9EU7j5mP15aQxcfLQHx0xDUnbUKsRR3PrywaE1CFVW4c60z1K0/HPWQ28qANXRp50hqNfGFDbB72sGBMwglTjQjMySircNCZYCECUS70hkBrTEj5/1BhBL4Mww5KNkdxRXC7mr2lAU7SM9frgfxaJMp5PxUa49jztNNprVWLLjUiJ16/NYhtpKc+LFlTkve1ZUEWu+yAzkR0bmMW5Fgo2mIZqYXlYAl8KA6HJ2Nt9RyS/2OD6waGsMomwQuLhpfPm6uufBrIK7LfBlrRnXet7iVhJfFyzY+0C+7mYQHJLSDkw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 08:13:45 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0639.012; Thu, 26 Nov 2026
 08:13:45 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, linux-pm@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>,
 admin@tsv-stahl-riesa.de
Subject:
 Re: [PATCH 1/2] thermal: tegra: soctherm-fuse: Fix shifted_cp extension
Date: Thu, 26 Nov 2026 17:13:41 +0900
Message-ID: <JfN0BOneRLm5hD336qlZ3Q@nvidia.com>
In-Reply-To:
 <20261106-upstream-soctherm-t114-v1-1-c875d1921084@tsv-stahl-riesa.de>
References:
 <20261106-upstream-soctherm-t114-v1-0-c875d1921084@tsv-stahl-riesa.de>
 <20261106-upstream-soctherm-t114-v1-1-c875d1921084@tsv-stahl-riesa.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0203.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::16) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
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
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c24923-6027-439f-3952-08df4b9530cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|366016|376014|1800799024|23010399003|4143699003|6133799003|261009223027099003|22082099003|18002099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	DwqHAkaIEJgzxEzdjM4Su9NCz2EAL8LP8L++ksuAWVkQ2lU57eGaKvn8lW3vHFPmvZro0BqN8Xc2V8IWvinQQssxQ+Ev7Hi/dqplUCHhsbvJgnItIVrWpWH3ryI3vpfBwKKBL75SWtHcDFQ47UieylDwtEBvw2gCNzZPd/4Gix2qO7bIiL9JnzIBUJrjT7mSjCzYq51bmqPsM6xAJ4/ab3strMxMwKg+kObsENYWk1x2AHf8+fi9z+wsF8tlvU6luEBxsb143Yo/JQCgv65sqmSBcBDAZColjguI3KMtDCQotwHUaHOo/oj6XLYxVdvL3fe8DWaiMdMuAbOBOPDRvSy27+vvKZvRCJg21z/PM5vuNADVwltkEzodHmr9lPhVya9BpkjILpQw8U1jVAzMzf0Gz6P6MYXVDoJSwb8Hid3kUKVo8CbG6/dKnkqzFcvH2rVuKIHVa3wgC4WCSliQwhDsdszDrSLl15cHPLyVJwpciGw1ZCjVIl9VkKUYbeankw6CIZz7nsGbUN6st449gdM5j41Q4PuKfxepUo3zC36Zsimz7oXAcjeWzKtfbRAzbUrsiCZrhXWCfZgT/BFIwAIWfNo/ieScupTVb1jYwJHZi93lo4FBx4duqd3H5kpTnPspa6muC14DGHnPTPdhim7WQcz9tKZdtLYMYLO4oK0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(366016)(376014)(1800799024)(23010399003)(4143699003)(6133799003)(261009223027099003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXdHZmZvVFRlc29iVk9Sd1VLS1JMQzR0M2k4L0RPWXVDVnpLUnFxVGVxOWRn?=
 =?utf-8?B?UVdheUJYd0Nac1I4S0dVQ2tEUFVld0E1U3JZTGRYdWh2bFNBaUhqNmpCekli?=
 =?utf-8?B?aDBLam5aU3c0azc2YTArR2hCSmJqdzZrTkJBNnE4RFVZSDc1aHFRUDl3RFdz?=
 =?utf-8?B?TWV3WjVIM2Vma2hRMFBJczN0dEdvRFZ3WHJaeGFOcU0yVjluZ3RacjAvNDl4?=
 =?utf-8?B?RXM4SVNVdFNYZHA1OVNhZW80VmgxcmNJcWtXbHgxbnJXV2JXaE0rR3F4YWlP?=
 =?utf-8?B?ZHc2OEY4dmJGNFh3TUlPdytONU5aYWxYL003b21EOGVYRzlna1BEVmlhSlFi?=
 =?utf-8?B?azZBMDh5R3ViZFJSb0tyaFB2VDBtM0xMb0xaUkoyTHdBNlJVMlVZeEx1T09J?=
 =?utf-8?B?VGREam14T0ZZVkpqOHJvT3Z1eEJ5ZXZrR0hjN3dJVWp3L1o0WkJ0Tm9tMlRs?=
 =?utf-8?B?UDA3ODRCOXgwd2hDUzRvQkdVZEpiV3R1MWxsMmlvZzdhRkF1bG0vSWttV0Rk?=
 =?utf-8?B?VTBSS21Kb25VTDExM2dsRzdTYlQ4aFRZNGIvUzBYT3lhSzgwOVBnRGNaajRv?=
 =?utf-8?B?eXdOZjF3VDB6WC8rdmhUcUU3eTNaN0dWay9FTFlMZnNoWXYvSVBiY3I2SERE?=
 =?utf-8?B?WE11b0pVcnh6VStLS0lPaVFlZEVvQUhDVGE5M04wTmVhUVlzWUNIQkxILzdw?=
 =?utf-8?B?NEs5WFNoQ1pzVlQrUGFuRmNzcTJPQklMMWJiTnRsOHVtc0VGNXhjbkRIMUJN?=
 =?utf-8?B?MDNhc3B6L3JldnI0QTdFb1l5RWVENkRNTk1XcGtPZFpEZWhxWFpnTVEranln?=
 =?utf-8?B?R3MrakgwSUtuVXZDOGFxbVp6cHBvcm44QnM5S2F5ZE1pbXd1MzhjbHhGWVF4?=
 =?utf-8?B?L0cwVVIvQXpCdzIxa09TZzRudmtjLzdRMHkvLzZzdEZJalMyb1c1ajIwTjg5?=
 =?utf-8?B?bEZMajhwbGMySFlXdVI4eEVSbW5RcmlzS1VKNWxKVWUyQzJUNGd4S3o5SHEv?=
 =?utf-8?B?MUdvdXlpbld2enErbFdES1l4M0RnemtWMm5OTHpkT2NWRVBRUHVVWG94S3dG?=
 =?utf-8?B?bk1maDJENVlEditBak1MbDZLek8wZ0MyaS9LRHZ6ZlhERm4veitWeUovYkdW?=
 =?utf-8?B?WFYvVUtKZ3FiNUNaWkMydGgwSWF0Y0lta3ZHcytoTHNvOFF1d1dPNVVGSUVI?=
 =?utf-8?B?ZVZSQWVMaFhXVzJtK3lFb3RiU1ptMEFGS2dWRGFMa1c2UlBnb2NwQ3dQV2x5?=
 =?utf-8?B?OVczMFlxWlY3NTZSdDBjaWVPdFlBNVpVdDRpRm9Xa21sTHhkTnVJcTJkOS81?=
 =?utf-8?B?UmNnN3FQUHordlNoMXZiMjFvNmk0YjJuMk03TzRnZkZ1MmpLcE1ORmJpc3h0?=
 =?utf-8?B?WGtNdUhqV1U3OWo4aHBjVEVqWVdQTnZNNDB2aysrSXZJNGNDRWRyK0oySmtS?=
 =?utf-8?B?eU5DdVpveTQxRFY1VUdPS0VHRlNIbTNCM0xWUWNDdWgzeWJjUHdDUVl2Q2VR?=
 =?utf-8?B?ZlhDY1o2Vm9jTHZ2b3Q4VTdoOFJ2bU9NSWs5V3NhNWg0TGw2VFllUllWbVRa?=
 =?utf-8?B?eHB0Si9nUksvdzlBa0c0YVhwTGJVSTl6Wit4RUg2R1d3Rnk2NXRDR2oxTXdU?=
 =?utf-8?B?QWxWQ1l4L1NPc2Q1aVdRZTR3WFU3cHJDY0dweThIYUc4R2VyQmJ3SVdwaXFt?=
 =?utf-8?B?T0VrRzJFNVFNUU01bmE3Q3BSSjBXL2FkMGtuUUNITzZBNGIyTk8zS2ZpRVpY?=
 =?utf-8?B?aXA4ZXZyUnNRdWNONkdDcStNUXpmcWNoeHBneXhycmdDd2M1S1FwcnBLM0E1?=
 =?utf-8?B?Rm9VWUU4RVR6N1FTZ3VDRWwvVHg2MTNldlR6RE0wU3lqSDdRNGZ0SVlUVC96?=
 =?utf-8?B?NEJlQkQ1bVVWQlpnZkJ1dEJOS0J1MnZBajhkcE5VWGptVWMvZUxHTlNDd1dY?=
 =?utf-8?B?NTJDb3AwZjM3WnRpcWJWZFFTS0NEMWl3akNoakZkVUdtRTlwbk96WDY5QktO?=
 =?utf-8?B?R00wUGkyOVkydWZ2bDNjVTlNc0xNZmVQSjVoZ3JyR29VaU96VlFjNWxlSVd3?=
 =?utf-8?B?WThDY3gxZnY0VmY0aHlUOHRFWHNDOGd0UXUzNlZEaHY2blZNZ3pXT0I0dVNZ?=
 =?utf-8?B?OUdvZUNYV09Ma0ZkRXJYWGNhQUtXWWNwSU1pczhRQTc2WTNVbXRhMDJxRmFY?=
 =?utf-8?B?VHg5YWUrdk15SVNSSGRYSVdvS2M4L0NTQWw1UnlvbzlXZkIrRFJXd21GVUcz?=
 =?utf-8?B?TDVTMHlueGNlZmZrNkNEalc2TmJqeXpZSlZFK2J1RlJUVkM1R3dQdGhGTVRU?=
 =?utf-8?B?UTdPVm51Q1RRRG5NdDlNK3hyN0N4NS9KVitVTmo5UzBxVWExYTgzR0RVVWRj?=
 =?utf-8?Q?vG1EvwH1v99n25YovxPyHp6eZnT16L4DCOMkIdA6plcQs?=
X-MS-Exchange-AntiSpam-MessageData-1: mqIMwwit/yD5sQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c24923-6027-439f-3952-08df4b9530cb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:13:45.3098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgLpXgcQ3q1Efc1AoBXLSSzJ0GZ6DjVbJkC5aGLl+8eeaX6v8hZB1lrJppLdo6rbOCwYppeqrERIQnA+RTIqzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825

On Saturday, November 7, 2026 5:31=E2=80=AFAM Patrick Fischer via B4 Relay =
wrote:
> From: Svyatoslav Ryhel <clamor95@gmail.com>
>=20
> The shifted_cp value in tegra_calc_shared_calib() should be passed to
> sign_extend32() similarly to how shifted_ft is handled. This omission
> caused malfunctions in the GPU and memory thermal zones, which was
> observed on the Tegratab.
>=20
> Tegra124, Tegra132 and Tegra210 are not affected: SHIFT_CP is in the
> low six bits of their fuse word, so sign-extending the whole word gives
> the same result. Only Tegra114 has SHIFT_CP in bits [15:10].
>=20
> Fixes: 48fc33b95159 ("thermal/drivers/tegra/soctherm-fuse: Prepare calibr=
ation for Tegra114 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  drivers/thermal/tegra/soctherm-fuse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/tegra/soctherm-fuse.c b/drivers/thermal/tegr=
a/soctherm-fuse.c
> index 8d37cd8c9122..2de1d0cb676e 100644
> --- a/drivers/thermal/tegra/soctherm-fuse.c
> +++ b/drivers/thermal/tegra/soctherm-fuse.c
> @@ -102,7 +102,7 @@ int tegra_calc_shared_calib(const struct tegra_socthe=
rm_fuse *tfuse,
> =20
>  	shifted_cp =3D (val & tfuse->fuse_shift_cp_mask) >>
>  		     tfuse->fuse_shift_cp_shift;
> -	shifted_cp =3D sign_extend32(val, 5);
> +	shifted_cp =3D sign_extend32(shifted_cp, 5);
> =20
>  	shared->actual_temp_cp =3D 2 * NOMINAL_CALIB_CP + shifted_cp;
>  	shared->actual_temp_ft =3D 2 * tfuse->nominal_calib_ft + shifted_ft;
>=20
> --=20
> 2.56.0
>=20
>=20
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>



