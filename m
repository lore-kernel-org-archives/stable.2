Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2694E36F1
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.66
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774120; cv=fail; b=EFqhCLZMXj5CyMOKeXAeBq/UvHf/oiPkNncqssJZMF0oL17zkzaDs66kqMQMtN5h6Or+I1pYj9HuPS4Fj7lOWzA9SixO4HSB2kLH2DowGVAiS3KxuETzJv9LbQL+junAV6JE7Y6RBccXBcdzsYDmYsVe32Gn42uP7Z5Zuttdqoo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774120; c=relaxed/simple;
	bh=Nb+9jGfnOqohGWsSYuFNYhuYiWvwecf9tNl+L8LHFfw=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fz7ShtE4a/x82mJMVLwhMEFQbKmbpwux2Tcnp9w6B2IRSj23bvGOJ9aC7aG7gmsO1hNvAwZdpVl84hp1Kh6V2Eh25sGsf516SNb/nP2xixd+OqYqtJ3sDpAkhkfZoKCjZpXxC7w5hshmsPC7SnIvrrE91tYdbupIhvaWyeL0Ppw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Q4oF2boA; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Q4oF2boA; arc=fail smtp.client-ip=40.107.162.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Q4oF2boA";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Q4oF2boA"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VPriK0ibWqcRUT/jDnX3UI7ORoZ+avZCiHnj9e8KMoK38QeD5Tkhf1UtHiqs5Tawh4OdG4odzZSI5zUFHf+ePQgUmF8pLHBOOqQzOet2Ist6/OIqEFojipU1Ubjz+2xtocX7uwpIR3O/zqkpmFu/yVWoYiuUN0/nrtnQyPiWNRAfbp+xQyr8+mvEkp2jnct57L+0bjiu0VNN3IObDPnetAtp6sKcfIvmAN52I9Z0ESUb0ZmSR3Dxw9p4yDzU4UaCZdqOp0Q8DibKG6jvnrhQ+zcHgVDV20mILnm3CpttAEXk2HhOFhcfz+67R/uhdeFDdimErd+batY1Z2EZsCgmZw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LP6iTai3xW5rv2lIsmmPD1A7oNJaKiYb6bf19354+E=;
 b=J4PKg1jKerAHJVj/Vo/Nub/IqSLZyFrW4erXZBcpZHSKodrc/FL4XTdHmjdoZYkBJ1aKDbhIDls9WsWjb1w1D5U46bimHId3Y8lmW25pZ5FcSF+tvI3eaoFkG6xKtgiplMOe36diiOO5Pi0PQO15FlRu89Wo1sqdwFOylW5cDp2YoD5l6Qd4yiiOzo3D0X4IY7VBt1c+9ENJnFodzfVnrSVk1SGjVnet7hguN56YlRHU0X70aRyTimuSmMvmijaTm3EKULm96PIHKqQij2LEECklLDVeqvFmFsQqFVdh9ubo8vp2Lj24cFLCxu62pUDLILYL3JfImTIGcx0SrX/GoQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LP6iTai3xW5rv2lIsmmPD1A7oNJaKiYb6bf19354+E=;
 b=Q4oF2boA4MZjOaK/nOR72gIEAqY/WiPNECIQOLO4/aSZsR4xny4PejG9y5T0wCKlAimEH/xDOp1WGxZPEScVLZonGw357v5QHoaTZZ6Yt0HPvgLr5Py2sxVOs/X4lwc2LVsucOjmMgJFhmS3ly9QvmxQeXiTgwxeCi3HINGPi0o=
Received: from PA7P264CA0349.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37c::13)
 by DU0PR08MB7613.eurprd08.prod.outlook.com (2603:10a6:10:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Wed, 30 Sep
 2026 13:15:02 +0000
Received: from ZR1PEPF0000E6B7.eurprd07.prod.outlook.com
 (2603:10a6:102:37c:cafe::16) by PA7P264CA0349.outlook.office365.com
 (2603:10a6:102:37c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 13:15:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6B7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Wed, 30 Sep 2026 13:15:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cu2gyo08qKm1P8+IO9NAvsnu1pXbtowitn7qvPLkAUZ7gfwYJ6CjjOPp5NI3BJTxxSBpzzkk71C3kHWin3fFwYJzDsgVmQJayREb4IRBgNNez5X1SoLIhH03GDnJuFGsQA6+Ds5tSDU0KFWy2G41s0bidIUIkIopSt+LmadroI/r58OZmqlMcorAy6WRpMFB5ZTKKe4PxEYba3TTlZ7JqR6ujQfyIpYxuic9eQsaqLpLXk0mIVIqUGu+Ym9d6oHtM1P8xhXqYL+OIVQpNbNncFcuXEc2Q/A4sJ134ciEUilU4l9KQwQVjRh7kpMGgAZdvlUi4IEcri86CrQkMoQsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LP6iTai3xW5rv2lIsmmPD1A7oNJaKiYb6bf19354+E=;
 b=IRoWxQRb/t5mzEOCwl64v4tp/rittsQCHPUfm3/wthbPC13Oywh1uAJ42u5oseVUrHOy02p8EekARRWQpcdvSIuZeVCxlTZUgx1j7J6zQ49C915HpMYnm1ZYnjqR05XZKZ2jSsJFd6mIR2p1PntX+R7ULSvrtwSNnl6tbTHjK/78+gsvSRtf0FxS0ZA7AfOXaw+IQiuOp5yL66SSC0fKXOeORTPFiW3Cnq/ofxarEW1kRH80o6CH+vsGsPKeO7kA7ilJdlpORUkhsioZfHYsqnBBIAuS0hgJy0Ex7m7qn0DDL9hw63Nw/qKj/NPPab0nZ8C6kxm4yJNdsM+ynCUSmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LP6iTai3xW5rv2lIsmmPD1A7oNJaKiYb6bf19354+E=;
 b=Q4oF2boA4MZjOaK/nOR72gIEAqY/WiPNECIQOLO4/aSZsR4xny4PejG9y5T0wCKlAimEH/xDOp1WGxZPEScVLZonGw357v5QHoaTZZ6Yt0HPvgLr5Py2sxVOs/X4lwc2LVsucOjmMgJFhmS3ly9QvmxQeXiTgwxeCi3HINGPi0o=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by AS8PR08MB10364.eurprd08.prod.outlook.com (2603:10a6:20b:56a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Wed, 30 Sep
 2026 13:14:24 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 13:14:24 +0000
Message-ID: <28978498-348e-4cfd-af72-1146a106e96b@arm.com>
Date: Wed, 30 Sep 2026 14:14:22 +0100
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, Will Deacon <will@kernel.org>,
 ada.coupriediaz@arm.com, ardb@kernel.org, cl@gentwo.org, david@kernel.org,
 david.laight.linux@gmail.com, james.morse@arm.com, ljs@kernel.org,
 maz@kernel.org, peterz@infradead.org, ruanjinjie@huawei.com,
 ryan.roberts@arm.com, stable@vger.kernel.org, vladimir.murzin@arm.com,
 yang@os.amperecomputing.com
Subject: Re: (subset) [PATCH v4 00/21] Preemptible this_cpu_*() operations
To: Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20260908151741.394589-1-mark.rutland@arm.com>
 <179026582920.3572476.8424936957104740430.b4-ty@b4>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <179026582920.3572476.8424936957104740430.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0660.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::13) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|AS8PR08MB10364:EE_|ZR1PEPF0000E6B7:EE_|DU0PR08MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 09aa66b9-6361-4648-86bf-08df1ef4d582
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|366016|23010399003|376014|1800799024|22082099003|18002099003|6133799003|10067099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info-Original:
 Naxte+H+1F5vJ3AHrEamMY5HCRp158DolgT4e/YYYSvOOVypvrsCeDUFy38iYcpoAqraUk6ICwHa/uXRKEjBv/jEzdK8WZcsjFmLWDgiBYmjq7kQ4KJR/GmUIM88RjMtPemcsmCC47mFjGwcGHz8S7qGxez/R6bWznFJHad6HTVx8dKz50aRJEN15/rYXTfuSj14NCfcuHT6YNfRHALD26LhRsF/WO/xpJe5P103AdBH8ta25R0B1lJ5mJKnJRnSxZ7z1Dc0DO8d4YOqwaU3uZEupltUjXZ0FasxLuskhKqSSKJ6LQd1j9ar5XrWA9UnWaQxEKiNxTx+7dJMrwbhqNr8uAtrAjMqKGkVwWknppewB72AFxtKSs2MdNE6iNzC08DTJXrOY5xH8QP2yZ3orhhOIYKVLb6utjQCta5wRF7L9SHIVSqf2Lyu5ihkPs1BTvt8uR8z9vdV5yOCFjIfOGJQIYhdJc9bgSNIFIJoOlxoBxYUKbUDsXdoKxsPGjScvnrN8jFXcd9kBdIii7c0RRpAEoie3awkJ1r7Wop9pcQrc7/+c4OqVyDrIRyybz86GV5TBsGrV72pd9UTOq86zdyN+8E4mmm5FIqN3Pztdoel4nyTF5uqJdsl3RIZOAoq4k/8t5jafs60u2NvgnB61pUaGukVRH6ht7IPfLMvTqw=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 AYz5RHjQvf3UHp+vlanVHuHcVm099ukpIs9Oq8Q4iMkjO1w3zQOp1KlU4juJDZOoTeccdIw4BmfuQapLPrDMI9Loeh/lFzqWIh5kAPsPm1MfJ4DrV6yxPYsULJ/1rSM/39mGT2BR57GQBO5gW7jlBe2U/DSxySO5pWDBivo4o2tzEFFUP0YtWqbktDNrSVicswxJrEMxZUpywJs0lx75z5XsN9vKfR2X6ShgQgX5gA+H/XUECobtn+IrM4+Tra04hc/PsiY7r+ImVrNUR8ryi016sDzgsmaB4FMa4G5MWZ3iIp9xErT2tBqB/AOPD+Msul6n8z64y2uM1OY4AJ9KLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10364
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 ZR1PEPF0000E6B7.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8217b62e-66a5-41a7-0e6e-08df1ef4bf62
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|36860700016|7416014|376014|82310400026|1800799024|23010399003|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	pbxBKjlGxOA+VvGO4HVHE0dztYx3Mn0aJpJAr2uckSJHm36bxa3qsRu1dsi6zttPhYBuSR9hD7GgT5bw0afoKp/2gRyszwLumZyQk+jzIiyimXXHpDjcyDQTalFcww5mZgUxGrqGJKLVXC4XAWgbXGLEqJrsOyWdDNqL6b+wHsEjs159pEHue229Vbgdc9vK80ar5ECsCpyVqKtmi2RWIzPH3VgEnAq8iZcTdzDXvuEq1T1dPHx7P5StV1VnnbLyv1v1l4kwyQ7iNCBsSBrAU3rSURbN95wgWvfs+eLyIlG1QTqtgu/UHNut6BesvggDNR/eJo9bgQZIHerT7k9r67Kf6C5/05d1FTL7QHJFFDDhSWTyLrTkn5mnB17fyud3pQBY2Z8yxUpTQOPEZkq+YXfGX3pwYguJaYmR8SGIlnvW3IoZDoEGI8rqRzsQ9LCtmELlCzeebgSVfE5FoGnZOESv6GzGeAbG01R4LyVUr+Y3ieY4AGvBRus1C5hRB782l+j5IS0Bw2oOWxexgvV/c6ZvRSLG2P8YWln1tApiuZS/S5j+xpcwoh1rHgHu3pPIshoXaARJkR5IL834Dc3vZYfAI6xGpjEMQLvqLQKPbPjsD9Qw7GNVYwnpn1YDMR7UbhmSRohOyyR9dU3JsAgSoLYJph/ppCXCJyyf/htZBIkPY0/AWcY8x8T6aW400hqDKSDdA9WkH80/VNQ0VRU4Jw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(36860700016)(7416014)(376014)(82310400026)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JaQ8kLXaUGvt7jmWTgwm1oRaUnbZ9r31HlnKAE8Rjw2M+N+KbUNDfC6L5Vyf+seLiUzfPF1f0dmjj4QPUYCR9gBTrokLflSnMhlv+/x1oDOHzo5yFP9VhGJbXvJ9EuNq6zlzDTTwN2VX2+vODrorv4edjxlj1vI0fiUh34DD880O/L6uQz+Mef4WlrLglYqNOa8ADoYOIKqxC8Qn/qROAIZ+/gVQ+0LVimV7HdJD3II8yNE/elCBL8f7HuogKb8LRTz77fQdCiLN8nA022hvC0A+nDgzAqiVoJCbNcLvyL53zqtLRoW2pYaRSfPNSw2VUdI2za9lmn2Zk9qmPwA75Jj/wfULrjUNeLjn3itcHn1fsmeY04NQknYly+93LwXwBiNcgSDVLGTqTX7rRY04r2uniQdF3aqmIcHg4ZhAp42xy+lnBf4dQGUugNexlha7
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 13:15:01.1101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09aa66b9-6361-4648-86bf-08df1ef4d582
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6B7.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7613

On 24/09/2026 5:03 pm, Catalin Marinas wrote:
> On Tue, 08 Sep 2026 16:17:20 +0100, Mark Rutland wrote:
>> This series reworks arm64's this_cpu_*() operations such that they do
>> not need to disable preemption. The scheme is described in detail in patch 13,
>> and is similar to the approach Heiko Carstens applied to s390 [1], which
>> inspired this series.
>>
>> This scheme should build and function in all kernel configurations (e.g.
>> regardless of KPTI, SW PAN, CNP, VA BITS), and has no dependency on new
>> architectural features. The fixup logic should "just work" with kprobes,
>> etc, and I don't expect that this will need to become more complicated.
>>
>> [...]
> 
> Applied to arm64 (for-next/preemptible-this-cpu), thanks!
> 
> Patches 1-3 are already upstream as fixes (in -rc4, used as a base for
> for-next/core). I fixed some minor comment typos in a couple of patches,
> I haven't touched the code.
> 
> On v2, Usama reported performance regression in perf/sched and
> perf/futex benchmarks that have not been addressed yet. It would be good
> to run the tests again on this version, in case they were just noise. I
> don't see why these would regress, maybe because of pt_regs being larger
> and we get some more cache misses? 

I've just performed testing on arm64 for-next/core as it is and
by reverting this entire series:

aws-m7g.metal: 
21 improvements
1  regression

AmpereOne:
35 improvements
2  regression

Results for SUT Class aws-m7g.metal:
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| Benchmark               | Result Class                                             |   arm64-core-no-mark21-20260929-m7g (base) |   arm64-core-mark21-20260929-m7g |
+=========================+==========================================================+============================================+==================================+
| lmbench/lat-mem-rd      | size:4MB P:1 stride:128B rnd_read_lat (ns)               |                                      25.36 |                           -3.89% |
|                         | size:4MB P:1 stride:128B seq_read_lat (ns)               |                                       3.00 |                            0.61% |
|                         | size:16MB P:1 stride:128B rnd_read_lat (ns)              |                                      28.17 |                           -4.00% |
|                         | size:16MB P:1 stride:128B seq_read_lat (ns)              |                                       2.89 |                           -1.95% |
|                         | size:64MB P:1 stride:128B rnd_read_lat (ns)              |                                     102.19 |                            0.29% |
|                         | size:64MB P:1 stride:128B seq_read_lat (ns)              |                                       5.42 |                           -1.17% |
|                         | size:256MB P:1 stride:128B rnd_read_lat (ns)             |                                     113.45 |                           -0.66% |
|                         | size:256MB P:1 stride:128B seq_read_lat (ns)             |                                       5.56 |                           -0.59% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| micromm/fork            | fork: p:1, d:10 (seconds)                                |                                     0.0076 |                           -2.29% |
|                         | fork: p:512, d:10 (seconds)                              |                                     0.0055 |                            0.32% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| micromm/munmap          | munmap: p:1, d:10 (seconds)                              |                                      0.061 |                       (I) 40.50% |
|                         | munmap: p:512, d:10 (seconds)                            |                                     0.0046 |                        (I) 2.64% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| micromm/vmalloc         | fix_align_alloc_test: p:1, h:0, l:500000 (usec)          |                                  635669.17 |                        (I) 8.06% |
|                         | fix_size_alloc_test: p:1, h:0, l:500000 (usec)           |                                  374395.50 |                        (I) 4.24% |
|                         | fix_size_alloc_test: p:4, h:0, l:500000 (usec)           |                                  454288.83 |                        (I) 7.98% |
|                         | fix_size_alloc_test: p:16, h:0, l:500000 (usec)          |                                  870184.17 |                       (I) 19.28% |
|                         | fix_size_alloc_test: p:16, h:1, l:500000 (usec)          |                                  813688.83 |                       (I) 15.82% |
|                         | fix_size_alloc_test: p:64, h:0, l:100000 (usec)          |                                  500721.33 |                       (I) 28.32% |
|                         | fix_size_alloc_test: p:64, h:1, l:100000 (usec)          |                                  465855.33 |                       (I) 22.94% |
|                         | fix_size_alloc_test: p:256, h:0, l:100000 (usec)         |                                 1820499.17 |                       (I) 31.59% |
|                         | fix_size_alloc_test: p:256, h:1, l:100000 (usec)         |                                 1706893.17 |                       (I) 25.98% |
|                         | fix_size_alloc_test: p:512, h:0, l:100000 (usec)         |                                 3566528.17 |                       (I) 32.81% |
|                         | fix_size_alloc_test: p:512, h:1, l:100000 (usec)         |                                 2626046.67 |                       (I) 36.14% |
|                         | full_fit_alloc_test: p:1, h:0, l:500000 (usec)           |                                  558588.00 |                           -0.07% |
|                         | kvfree_rcu_1_arg_vmalloc_test: p:1, h:0, l:500000 (usec) |                                  359429.83 |                            0.20% |
|                         | kvfree_rcu_2_arg_vmalloc_test: p:1, h:0, l:500000 (usec) |                                  359256.33 |                            1.15% |
|                         | long_busy_list_alloc_test: p:1, h:0, l:500000 (usec)     |                                 4388243.50 |                       (I) 25.27% |
|                         | pcpu_alloc_test: p:1, h:0, l:500000 (usec)               |                                  197834.17 |                            0.40% |
|                         | random_size_align_alloc_test: p:1, h:0, l:500000 (usec)  |                                  758328.83 |                        (I) 8.63% |
|                         | random_size_alloc_test: p:1, h:0, l:500000 (usec)        |                                 2306188.50 |                       (I) 24.32% |
|                         | vm_map_ram_test: p:1, h:0, l:500000 (usec)               |                                   81248.50 |                            0.80% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| mmtests/hackbench       | hackbench-process-pipes-1 (seconds)                      |                                       0.15 |                           -1.56% |
|                         | hackbench-process-pipes-4 (seconds)                      |                                       0.39 |                            1.85% |
|                         | hackbench-process-pipes-7 (seconds)                      |                                       0.66 |                           -3.13% |
|                         | hackbench-process-pipes-12 (seconds)                     |                                       1.11 |                           -0.37% |
|                         | hackbench-process-pipes-21 (seconds)                     |                                       1.48 |                           -0.28% |
|                         | hackbench-process-pipes-30 (seconds)                     |                                       1.87 |                            0.62% |
|                         | hackbench-process-pipes-48 (seconds)                     |                                       2.57 |                            0.81% |
|                         | hackbench-process-pipes-79 (seconds)                     |                                       3.62 |                            1.44% |
|                         | hackbench-process-pipes-110 (seconds)                    |                                       4.70 |                            1.42% |
|                         | hackbench-process-pipes-141 (seconds)                    |                                       5.81 |                            1.59% |
|                         | hackbench-process-pipes-172 (seconds)                    |                                       6.97 |                            1.65% |
|                         | hackbench-process-pipes-203 (seconds)                    |                                       8.14 |                            1.63% |
|                         | hackbench-process-pipes-234 (seconds)                    |                                       9.34 |                            1.85% |
|                         | hackbench-process-pipes-256 (seconds)                    |                                      10.16 |                            1.88% |
|                         | hackbench-process-sockets-1 (seconds)                    |                                       0.28 |                            1.02% |
|                         | hackbench-process-sockets-4 (seconds)                    |                                       0.62 |                            0.05% |
|                         | hackbench-process-sockets-7 (seconds)                    |                                       0.99 |                            0.32% |
|                         | hackbench-process-sockets-12 (seconds)                   |                                       1.60 |                            0.46% |
|                         | hackbench-process-sockets-21 (seconds)                   |                                       2.76 |                            0.47% |
|                         | hackbench-process-sockets-30 (seconds)                   |                                       3.94 |                            0.67% |
|                         | hackbench-process-sockets-48 (seconds)                   |                                       6.29 |                            0.65% |
|                         | hackbench-process-sockets-79 (seconds)                   |                                       9.78 |                            0.26% |
|                         | hackbench-process-sockets-110 (seconds)                  |                                      13.60 |                           -0.33% |
|                         | hackbench-process-sockets-141 (seconds)                  |                                      17.53 |                           -0.59% |
|                         | hackbench-process-sockets-172 (seconds)                  |                                      21.74 |                           -0.84% |
|                         | hackbench-process-sockets-203 (seconds)                  |                                      25.95 |                           -1.06% |
|                         | hackbench-process-sockets-234 (seconds)                  |                                      30.33 |                           -1.22% |
|                         | hackbench-process-sockets-256 (seconds)                  |                                      33.43 |                           -1.23% |
|                         | hackbench-thread-pipes-1 (seconds)                       |                                       0.18 |                            0.28% |
|                         | hackbench-thread-pipes-4 (seconds)                       |                                       0.39 |                           -0.50% |
|                         | hackbench-thread-pipes-7 (seconds)                       |                                       0.68 |                            0.00% |
|                         | hackbench-thread-pipes-12 (seconds)                      |                                       1.14 |                           -0.88% |
|                         | hackbench-thread-pipes-21 (seconds)                      |                                       1.52 |                           -0.28% |
|                         | hackbench-thread-pipes-30 (seconds)                      |                                       1.94 |                           -0.08% |
|                         | hackbench-thread-pipes-48 (seconds)                      |                                       2.68 |                           -0.33% |
|                         | hackbench-thread-pipes-79 (seconds)                      |                                       3.68 |                            0.01% |
|                         | hackbench-thread-pipes-110 (seconds)                     |                                       4.82 |                            0.41% |
|                         | hackbench-thread-pipes-141 (seconds)                     |                                       5.94 |                           -0.26% |
|                         | hackbench-thread-pipes-172 (seconds)                     |                                       7.17 |                            0.01% |
|                         | hackbench-thread-pipes-203 (seconds)                     |                                       8.39 |                            0.06% |
|                         | hackbench-thread-pipes-234 (seconds)                     |                                       9.64 |                            0.09% |
|                         | hackbench-thread-pipes-256 (seconds)                     |                                      10.51 |                           -0.11% |
|                         | hackbench-thread-sockets-1 (seconds)                     |                                       0.30 |                            1.57% |
|                         | hackbench-thread-sockets-4 (seconds)                     |                                       0.64 |                            0.68% |
|                         | hackbench-thread-sockets-7 (seconds)                     |                                       1.00 |                            1.13% |
|                         | hackbench-thread-sockets-12 (seconds)                    |                                       1.60 |                            0.69% |
|                         | hackbench-thread-sockets-21 (seconds)                    |                                       2.72 |                            0.44% |
|                         | hackbench-thread-sockets-30 (seconds)                    |                                       3.86 |                            0.37% |
|                         | hackbench-thread-sockets-48 (seconds)                    |                                       6.13 |                            0.26% |
|                         | hackbench-thread-sockets-79 (seconds)                    |                                       9.51 |                           -0.17% |
|                         | hackbench-thread-sockets-110 (seconds)                   |                                      13.22 |                            0.04% |
|                         | hackbench-thread-sockets-141 (seconds)                   |                                      17.02 |                           -0.13% |
|                         | hackbench-thread-sockets-172 (seconds)                   |                                      21.15 |                           -0.13% |
|                         | hackbench-thread-sockets-203 (seconds)                   |                                      25.32 |                           -0.16% |
|                         | hackbench-thread-sockets-234 (seconds)                   |                                      29.59 |                           -0.08% |
|                         | hackbench-thread-sockets-256 (seconds)                   |                                      32.62 |                           -0.15% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| mmtests/kernbench       | kernbench-elsp-64 (seconds)                              |                                     359.85 |                            0.24% |
|                         | kernbench-syst-64 (seconds)                              |                                    1130.19 |                        (I) 4.44% |
|                         | kernbench-user-64 (seconds)                              |                                   19739.56 |                            0.10% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| mmtests/sysbench-cpu    | sysbenchcpu-1 (ops/second)                               |                                     834.34 |                           -0.01% |
|                         | sysbenchcpu-4 (ops/second)                               |                                    3337.18 |                           -0.01% |
|                         | sysbenchcpu-7 (ops/second)                               |                                    5839.81 |                           -0.01% |
|                         | sysbenchcpu-12 (ops/second)                              |                                   10010.66 |                           -0.01% |
|                         | sysbenchcpu-21 (ops/second)                              |                                   17517.47 |                           -0.01% |
|                         | sysbenchcpu-30 (ops/second)                              |                                   25023.23 |                           -0.01% |
|                         | sysbenchcpu-48 (ops/second)                              |                                   40032.51 |                           -0.01% |
|                         | sysbenchcpu-79 (ops/second)                              |                                   53376.78 |                           -0.02% |
|                         | sysbenchcpu-110 (ops/second)                             |                                   53377.41 |                           -0.02% |
|                         | sysbenchcpu-128 (ops/second)                             |                                   53379.94 |                           -0.03% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| mmtests/sysbench-mutex  | sysbenchmutex-1 (usec)                                   |                                     194.30 |                           -0.01% |
|                         | sysbenchmutex-4 (usec)                                   |                                     200.58 |                            0.01% |
|                         | sysbenchmutex-7 (usec)                                   |                                     200.95 |                           -0.14% |
|                         | sysbenchmutex-12 (usec)                                  |                                     201.54 |                           -0.18% |
|                         | sysbenchmutex-21 (usec)                                  |                                     202.49 |                            0.22% |
|                         | sysbenchmutex-30 (usec)                                  |                                     203.24 |                            0.22% |
|                         | sysbenchmutex-48 (usec)                                  |                                     242.40 |                            3.64% |
|                         | sysbenchmutex-79 (usec)                                  |                                     360.42 |                            0.84% |
|                         | sysbenchmutex-110 (usec)                                 |                                     509.17 |                            0.52% |
|                         | sysbenchmutex-128 (usec)                                 |                                     582.54 |                            0.44% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| mmtests/sysbench-thread | sysbenchthread-1 (usec)                                  |                                       0.37 |                        (I) 6.16% |
|                         | sysbenchthread-4 (usec)                                  |                                       0.55 |                        (I) 7.19% |
|                         | sysbenchthread-7 (usec)                                  |                                       2.68 |                          -19.77% |
|                         | sysbenchthread-12 (usec)                                 |                                       5.89 |                           11.27% |
|                         | sysbenchthread-21 (usec)                                 |                                      11.84 |                           -0.66% |
|                         | sysbenchthread-30 (usec)                                 |                                      19.81 |                           24.87% |
|                         | sysbenchthread-48 (usec)                                 |                                      33.30 |                           21.51% |
|                         | sysbenchthread-79 (usec)                                 |                                      57.47 |                           -7.01% |
|                         | sysbenchthread-110 (usec)                                |                                      92.38 |                           -3.64% |
|                         | sysbenchthread-128 (usec)                                |                                     115.79 |                            7.20% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| perf/futex              | hash (ops/sec)                                           |                                 2655172.83 |                        (I) 2.83% |
|                         | lock-pi (ops/sec)                                        |                                     281.00 |                            0.00% |
|                         | requeue (ms)                                             |                                      0.027 |                            3.30% |
|                         | wake (ms)                                                |                                      0.071 |                           -2.87% |
|                         | wake-parallel (ms)                                       |                                     0.0042 |                            0.08% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| perf/mem                | memset -k 1GB -f default -s 16GB (bytes/sec)             |                             65213616658.81 |                           -0.28% |
|                         | mmap -p 1GB -f demand -s 32GB -l 5 (bytes/sec)           |                             64303069991.32 |                           -0.35% |
|                         | mmap -p 4KB -f demand -s 32GB -l 5 (bytes/sec)           |                             49764611027.28 |                            0.10% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| perf/sched              | messaging -l 10000 (sec)                                 |                                       1.32 |                            0.67% |
|                         | pipe (ops/sec)                                           |                                  543170.30 |                            7.68% |
|                         | seccomp-notify (ops/sec)                                 |                                  243035.63 |                       (R) -4.65% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| perf/syscall            | basic (ops/sec)                                          |                                 5162993.33 |                            0.47% |
|                         | execve (ops/sec)                                         |                                    2329.13 |                            1.72% |
|                         | fork (ops/sec)                                           |                                    4050.90 |                            1.43% |
|                         | getpgid (ops/sec)                                        |                                 5174345.87 |                        (I) 2.15% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| sockperf/echo-lat-tcp   | ping-pong m:64B t:10s, avg_latency (usec)                |                                       4.86 |                           -0.10% |
|                         | ping-pong m:64B t:10s, latency_p99 (usec)                |                                       5.14 |                           -0.20% |
|                         | ping-pong m:256B t:10s, avg_latency (usec)               |                                       4.97 |                           -0.37% |
|                         | ping-pong m:256B t:10s, latency_p99 (usec)               |                                       5.31 |                           -0.15% |
|                         | ping-pong m:1024B t:10s, avg_latency (usec)              |                                       5.09 |                            0.00% |
|                         | ping-pong m:1024B t:10s, latency_p99 (usec)              |                                       5.40 |                           -0.16% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| sockperf/echo-lat-udp   | ping-pong m:64B t:10s, avg_latency (usec)                |                                       4.27 |                            0.77% |
|                         | ping-pong m:64B t:10s, latency_p99 (usec)                |                                       5.03 |                           -0.74% |
|                         | ping-pong m:256B t:10s, avg_latency (usec)               |                                       4.34 |                            0.99% |
|                         | ping-pong m:256B t:10s, latency_p99 (usec)               |                                       5.10 |                            0.77% |
|                         | ping-pong m:1024B t:10s, avg_latency (usec)              |                                       4.43 |                           -0.16% |
|                         | ping-pong m:1024B t:10s, latency_p99 (usec)              |                                       5.26 |                            0.66% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| sockperf/packet-tp-tcp  | throughput m:64B t:10s, msg_rate (msg/sec)               |                                 1339599.17 |                            2.00% |
|                         | throughput m:64B t:10s, throughput_mbps (Mbps)           |                                     654.10 |                            2.00% |
|                         | throughput m:256B t:10s, msg_rate (msg/sec)              |                                 2248084.00 |                            0.76% |
|                         | throughput m:256B t:10s, throughput_mbps (Mbps)          |                                    4390.79 |                            0.76% |
|                         | throughput m:1024B t:10s, msg_rate (msg/sec)             |                                 1587001.83 |                           -1.56% |
|                         | throughput m:1024B t:10s, throughput_mbps (Mbps)         |                                   12398.45 |                           -1.56% |
|                         | throughput m:1472B t:10s, msg_rate (msg/sec)             |                                 1398038.00 |                           -0.50% |
|                         | throughput m:1472B t:10s, throughput_mbps (Mbps)         |                                   15700.62 |                           -0.50% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| sockperf/packet-tp-udp  | throughput m:64B t:10s, msg_rate (msg/sec)               |                                  401108.00 |                           -0.79% |
|                         | throughput m:64B t:10s, throughput_mbps (Mbps)           |                                     195.85 |                           -0.79% |
|                         | throughput m:256B t:10s, msg_rate (msg/sec)              |                                  403048.17 |                           -2.33% |
|                         | throughput m:256B t:10s, throughput_mbps (Mbps)          |                                     787.20 |                           -2.33% |
|                         | throughput m:1024B t:10s, msg_rate (msg/sec)             |                                  390376.50 |                           -2.26% |
|                         | throughput m:1024B t:10s, throughput_mbps (Mbps)         |                                    3049.82 |                           -2.26% |
|                         | throughput m:1472B t:10s, msg_rate (msg/sec)             |                                  387575.83 |                           -1.26% |
|                         | throughput m:1472B t:10s, throughput_mbps (Mbps)         |                                    4352.66 |                           -1.26% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| speedometer/v2.0        | score (runs/min)                                         |                                     158.00 |                            0.00% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| speedometer/v2.1        | score (runs/min)                                         |                                     165.00 |                            0.91% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| syscall/getpid          | mean (ns)                                                |                                     195.17 |                            1.04% |
|                         | p99 (ns)                                                 |                                     199.67 |                           -1.16% |
|                         | p99.9 (ns)                                               |                                     201.00 |                           -1.47% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| syscall/getppid         | mean (ns)                                                |                                     197.00 |                            1.37% |
|                         | p99 (ns)                                                 |                                     203.67 |                            2.60% |
|                         | p99.9 (ns)                                               |                                     206.50 |                            3.08% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+
| syscall/invalid         | mean (ns)                                                |                                     187.33 |                            0.81% |
|                         | p99 (ns)                                                 |                                     191.00 |                            0.26% |
|                         | p99.9 (ns)                                               |                                     191.50 |                            0.00% |
+-------------------------+----------------------------------------------------------+--------------------------------------------+----------------------------------+

Results for SUT Class cesw-aarch64-ampereone-1s-a192-32x:
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| Benchmark               | Result Class                                             |   arm64-core-no-mark21-20260929-ampereone (base) |   arm64-core-mark21-20260929-ampereone |
+=========================+==========================================================+==================================================+========================================+
| lmbench/lat-mem-rd      | size:4MB P:1 stride:128B rnd_read_lat (ns)               |                                            41.64 |                                  0.85% |
|                         | size:4MB P:1 stride:128B seq_read_lat (ns)               |                                             4.77 |                                 11.97% |
|                         | size:16MB P:1 stride:128B rnd_read_lat (ns)              |                                            42.74 |                                  1.73% |
|                         | size:16MB P:1 stride:128B seq_read_lat (ns)              |                                             2.95 |                                 -0.42% |
|                         | size:64MB P:1 stride:128B rnd_read_lat (ns)              |                                            54.51 |                                  5.85% |
|                         | size:64MB P:1 stride:128B seq_read_lat (ns)              |                                             3.29 |                                 -4.91% |
|                         | size:256MB P:1 stride:128B rnd_read_lat (ns)             |                                           150.17 |                                 -0.30% |
|                         | size:256MB P:1 stride:128B seq_read_lat (ns)             |                                             6.21 |                                 -0.58% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| micromm/fork            | fork: p:1, d:10 (seconds)                                |                                           0.0084 |                                  1.11% |
|                         | fork: p:512, d:10 (seconds)                              |                                           0.0048 |                                  0.88% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| micromm/munmap          | munmap: p:1, d:10 (seconds)                              |                                            0.077 |                             (I) 30.07% |
|                         | munmap: p:512, d:10 (seconds)                            |                                            0.022 |                                  0.68% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| micromm/vmalloc         | fix_align_alloc_test: p:1, h:0, l:500000 (usec)          |                                        725723.67 |                             (I) 18.02% |
|                         | fix_size_alloc_test: p:1, h:0, l:500000 (usec)           |                                        393933.50 |                              (I) 9.95% |
|                         | fix_size_alloc_test: p:4, h:0, l:500000 (usec)           |                                        516939.50 |                             (I) 23.67% |
|                         | fix_size_alloc_test: p:16, h:0, l:500000 (usec)          |                                        971323.17 |                             (I) 30.43% |
|                         | fix_size_alloc_test: p:16, h:1, l:500000 (usec)          |                                        915152.17 |                             (I) 25.96% |
|                         | fix_size_alloc_test: p:64, h:0, l:100000 (usec)          |                                        591172.17 |                             (I) 41.62% |
|                         | fix_size_alloc_test: p:64, h:1, l:100000 (usec)          |                                        544844.17 |                             (I) 34.58% |
|                         | fix_size_alloc_test: p:256, h:0, l:100000 (usec)         |                                       2166037.67 |                             (I) 46.80% |
|                         | fix_size_alloc_test: p:256, h:1, l:100000 (usec)         |                                       1994903.83 |                             (I) 43.54% |
|                         | fix_size_alloc_test: p:512, h:0, l:100000 (usec)         |                                       4203198.00 |                             (I) 48.54% |
|                         | fix_size_alloc_test: p:512, h:1, l:100000 (usec)         |                                       3003280.00 |                             (I) 66.11% |
|                         | full_fit_alloc_test: p:1, h:0, l:500000 (usec)           |                                        610786.67 |                             (I) 10.06% |
|                         | kvfree_rcu_1_arg_vmalloc_test: p:1, h:0, l:500000 (usec) |                                        539508.33 |                              (I) 5.40% |
|                         | kvfree_rcu_2_arg_vmalloc_test: p:1, h:0, l:500000 (usec) |                                        516781.83 |                                  4.94% |
|                         | long_busy_list_alloc_test: p:1, h:0, l:500000 (usec)     |                                       4941369.00 |                             (I) 39.67% |
|                         | pcpu_alloc_test: p:1, h:0, l:500000 (usec)               |                                        480082.17 |                                  0.12% |
|                         | random_size_align_alloc_test: p:1, h:0, l:500000 (usec)  |                                        887208.00 |                              (I) 8.63% |
|                         | random_size_alloc_test: p:1, h:0, l:500000 (usec)        |                                       2626017.00 |                             (I) 37.28% |
|                         | vm_map_ram_test: p:1, h:0, l:500000 (usec)               |                                        106035.00 |                                  2.38% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| mmtests/hackbench       | hackbench-process-pipes-1 (seconds)                      |                                             0.26 |                                  0.20% |
|                         | hackbench-process-pipes-4 (seconds)                      |                                             0.44 |                                 -2.97% |
|                         | hackbench-process-pipes-7 (seconds)                      |                                             0.53 |                                 -0.47% |
|                         | hackbench-process-pipes-12 (seconds)                     |                                             0.73 |                                  0.75% |
|                         | hackbench-process-pipes-21 (seconds)                     |                                             1.12 |                                 -0.82% |
|                         | hackbench-process-pipes-30 (seconds)                     |                                             1.58 |                                 -1.54% |
|                         | hackbench-process-pipes-48 (seconds)                     |                                             2.81 |                                 -0.05% |
|                         | hackbench-process-pipes-79 (seconds)                     |                                             3.67 |                                  2.64% |
|                         | hackbench-process-pipes-110 (seconds)                    |                                             3.53 |                                 -1.03% |
|                         | hackbench-process-pipes-141 (seconds)                    |                                             3.68 |                                  1.43% |
|                         | hackbench-process-pipes-172 (seconds)                    |                                             4.00 |                                  0.44% |
|                         | hackbench-process-pipes-203 (seconds)                    |                                             4.34 |                                 -0.27% |
|                         | hackbench-process-pipes-234 (seconds)                    |                                             4.65 |                                  0.83% |
|                         | hackbench-process-pipes-265 (seconds)                    |                                             5.04 |                                 -0.27% |
|                         | hackbench-process-pipes-296 (seconds)                    |                                             5.37 |                                  0.54% |
|                         | hackbench-process-sockets-1 (seconds)                    |                                             0.56 |                                  5.32% |
|                         | hackbench-process-sockets-4 (seconds)                    |                                             0.66 |                                  3.91% |
|                         | hackbench-process-sockets-7 (seconds)                    |                                             0.79 |                                 -0.15% |
|                         | hackbench-process-sockets-12 (seconds)                   |                                             1.22 |                                 -0.79% |
|                         | hackbench-process-sockets-21 (seconds)                   |                                             2.03 |                                 -1.28% |
|                         | hackbench-process-sockets-30 (seconds)                   |                                             2.88 |                                 -1.69% |
|                         | hackbench-process-sockets-48 (seconds)                   |                                             4.55 |                                 -1.84% |
|                         | hackbench-process-sockets-79 (seconds)                   |                                             7.62 |                                 -1.81% |
|                         | hackbench-process-sockets-110 (seconds)                  |                                            10.72 |                                 -1.84% |
|                         | hackbench-process-sockets-141 (seconds)                  |                                            13.88 |                                 -1.87% |
|                         | hackbench-process-sockets-172 (seconds)                  |                                            17.07 |                                 -1.78% |
|                         | hackbench-process-sockets-203 (seconds)                  |                                            20.28 |                                 -1.63% |
|                         | hackbench-process-sockets-234 (seconds)                  |                                            23.49 |                                 -1.68% |
|                         | hackbench-process-sockets-265 (seconds)                  |                                            26.77 |                                 -1.66% |
|                         | hackbench-process-sockets-296 (seconds)                  |                                            30.07 |                                 -1.70% |
|                         | hackbench-thread-pipes-1 (seconds)                       |                                             0.28 |                                  1.26% |
|                         | hackbench-thread-pipes-4 (seconds)                       |                                             0.54 |                                 -0.40% |
|                         | hackbench-thread-pipes-7 (seconds)                       |                                             0.65 |                                  1.73% |
|                         | hackbench-thread-pipes-12 (seconds)                      |                                             0.82 |                                 -0.37% |
|                         | hackbench-thread-pipes-21 (seconds)                      |                                             1.12 |                                  0.75% |
|                         | hackbench-thread-pipes-30 (seconds)                      |                                             1.60 |                                  0.64% |
|                         | hackbench-thread-pipes-48 (seconds)                      |                                             2.75 |                                  0.33% |
|                         | hackbench-thread-pipes-79 (seconds)                      |                                             3.94 |                                 -0.39% |
|                         | hackbench-thread-pipes-110 (seconds)                     |                                             3.88 |                                 -2.09% |
|                         | hackbench-thread-pipes-141 (seconds)                     |                                             4.00 |                                 -0.31% |
|                         | hackbench-thread-pipes-172 (seconds)                     |                                             4.31 |                                 -0.52% |
|                         | hackbench-thread-pipes-203 (seconds)                     |                                             4.72 |                                  0.20% |
|                         | hackbench-thread-pipes-234 (seconds)                     |                                             5.13 |                                  1.08% |
|                         | hackbench-thread-pipes-265 (seconds)                     |                                             5.48 |                                 -2.56% |
|                         | hackbench-thread-pipes-296 (seconds)                     |                                             5.87 |                                 -0.40% |
|                         | hackbench-thread-sockets-1 (seconds)                     |                                             0.57 |                                  1.12% |
|                         | hackbench-thread-sockets-4 (seconds)                     |                                             0.73 |                                  2.84% |
|                         | hackbench-thread-sockets-7 (seconds)                     |                                             0.84 |                                 -0.96% |
|                         | hackbench-thread-sockets-12 (seconds)                    |                                             1.27 |                                 -0.08% |
|                         | hackbench-thread-sockets-21 (seconds)                    |                                             2.07 |                                 -1.10% |
|                         | hackbench-thread-sockets-30 (seconds)                    |                                             2.91 |                                 -1.53% |
|                         | hackbench-thread-sockets-48 (seconds)                    |                                             4.59 |                                 -1.42% |
|                         | hackbench-thread-sockets-79 (seconds)                    |                                             7.66 |                                 -1.45% |
|                         | hackbench-thread-sockets-110 (seconds)                   |                                            10.73 |                                 -1.92% |
|                         | hackbench-thread-sockets-141 (seconds)                   |                                            13.89 |                                 -1.81% |
|                         | hackbench-thread-sockets-172 (seconds)                   |                                            17.07 |                                 -1.67% |
|                         | hackbench-thread-sockets-203 (seconds)                   |                                            20.24 |                                 -1.70% |
|                         | hackbench-thread-sockets-234 (seconds)                   |                                            23.43 |                                 -1.77% |
|                         | hackbench-thread-sockets-265 (seconds)                   |                                            26.63 |                                 -1.87% |
|                         | hackbench-thread-sockets-296 (seconds)                   |                                            29.91 |                                 -1.82% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| mmtests/kernbench       | kernbench-elsp-192 (seconds)                             |                                           172.18 |                                  0.44% |
|                         | kernbench-syst-192 (seconds)                             |                                          1755.36 |                              (I) 6.41% |
|                         | kernbench-user-192 (seconds)                             |                                         22994.12 |                                  0.05% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| mmtests/sysbench-cpu    | sysbenchcpu-1 (ops/second)                               |                                           232.13 |                                 -0.01% |
|                         | sysbenchcpu-4 (ops/second)                               |                                           929.37 |                                  0.06% |
|                         | sysbenchcpu-7 (ops/second)                               |                                          1628.48 |                                 -0.09% |
|                         | sysbenchcpu-12 (ops/second)                              |                                          2791.82 |                                 -0.63% |
|                         | sysbenchcpu-21 (ops/second)                              |                                          4884.10 |                                  0.02% |
|                         | sysbenchcpu-30 (ops/second)                              |                                          6976.07 |                                 -0.02% |
|                         | sysbenchcpu-48 (ops/second)                              |                                         11160.90 |                                 -0.06% |
|                         | sysbenchcpu-79 (ops/second)                              |                                         18354.35 |                                 -0.14% |
|                         | sysbenchcpu-110 (ops/second)                             |                                         25531.52 |                                 -0.16% |
|                         | sysbenchcpu-141 (ops/second)                             |                                         32597.33 |                                  0.00% |
|                         | sysbenchcpu-172 (ops/second)                             |                                         39486.52 |                                 -0.10% |
|                         | sysbenchcpu-203 (ops/second)                             |                                         43977.55 |                                 -0.43% |
|                         | sysbenchcpu-234 (ops/second)                             |                                         44051.35 |                                 -0.60% |
|                         | sysbenchcpu-265 (ops/second)                             |                                         44152.90 |                                 -0.36% |
|                         | sysbenchcpu-296 (ops/second)                             |                                         44255.55 |                                 -0.19% |
|                         | sysbenchcpu-327 (ops/second)                             |                                         44225.89 |                                 -0.42% |
|                         | sysbenchcpu-358 (ops/second)                             |                                         44301.57 |                                 -0.27% |
|                         | sysbenchcpu-384 (ops/second)                             |                                         44171.27 |                                 -0.04% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| mmtests/sysbench-mutex  | sysbenchmutex-1 (usec)                                   |                                           167.90 |                                 -0.27% |
|                         | sysbenchmutex-4 (usec)                                   |                                           176.95 |                                  0.12% |
|                         | sysbenchmutex-7 (usec)                                   |                                           178.62 |                                 -0.08% |
|                         | sysbenchmutex-12 (usec)                                  |                                           179.43 |                                 -0.24% |
|                         | sysbenchmutex-21 (usec)                                  |                                           183.11 |                                 -0.14% |
|                         | sysbenchmutex-30 (usec)                                  |                                           199.32 |                                 -4.26% |
|                         | sysbenchmutex-48 (usec)                                  |                                           328.61 |                                 -1.71% |
|                         | sysbenchmutex-79 (usec)                                  |                                           531.33 |                                 -1.75% |
|                         | sysbenchmutex-110 (usec)                                 |                                           651.77 |                                  3.22% |
|                         | sysbenchmutex-141 (usec)                                 |                                           817.90 |                                 -2.82% |
|                         | sysbenchmutex-172 (usec)                                 |                                           993.03 |                                  1.08% |
|                         | sysbenchmutex-203 (usec)                                 |                                          1140.15 |                                 -1.22% |
|                         | sysbenchmutex-234 (usec)                                 |                                          1261.51 |                                 -1.21% |
|                         | sysbenchmutex-265 (usec)                                 |                                          1458.96 |                                 -2.62% |
|                         | sysbenchmutex-296 (usec)                                 |                                          1643.47 |                                  0.26% |
|                         | sysbenchmutex-327 (usec)                                 |                                          1770.20 |                                 -0.67% |
|                         | sysbenchmutex-358 (usec)                                 |                                          1930.64 |                                 -5.61% |
|                         | sysbenchmutex-384 (usec)                                 |                                          2135.30 |                                 -2.11% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| mmtests/sysbench-thread | sysbenchthread-1 (usec)                                  |                                             0.34 |                              (I) 6.77% |
|                         | sysbenchthread-4 (usec)                                  |                                             0.49 |                                  7.30% |
|                         | sysbenchthread-7 (usec)                                  |                                             3.89 |                                 12.19% |
|                         | sysbenchthread-12 (usec)                                 |                                             6.70 |                                -15.50% |
|                         | sysbenchthread-21 (usec)                                 |                                            18.05 |                                 -9.78% |
|                         | sysbenchthread-30 (usec)                                 |                                            29.92 |                                  5.75% |
|                         | sysbenchthread-48 (usec)                                 |                                            48.52 |                                  5.21% |
|                         | sysbenchthread-79 (usec)                                 |                                            80.01 |                                  3.30% |
|                         | sysbenchthread-110 (usec)                                |                                           115.83 |                                  5.85% |
|                         | sysbenchthread-141 (usec)                                |                                           142.43 |                                 -1.78% |
|                         | sysbenchthread-172 (usec)                                |                                           171.79 |                                  2.44% |
|                         | sysbenchthread-203 (usec)                                |                                           269.94 |                                 -0.28% |
|                         | sysbenchthread-234 (usec)                                |                                           294.78 |                                 -7.66% |
|                         | sysbenchthread-265 (usec)                                |                                           345.62 |                                 -1.59% |
|                         | sysbenchthread-296 (usec)                                |                                           419.84 |                                  7.43% |
|                         | sysbenchthread-327 (usec)                                |                                           452.17 |                                 18.71% |
|                         | sysbenchthread-358 (usec)                                |                                           515.08 |                                 12.55% |
|                         | sysbenchthread-384 (usec)                                |                                           497.78 |                                  6.22% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| perf/futex              | hash (ops/sec)                                           |                                       2653557.20 |                                  7.63% |
|                         | lock-pi (ops/sec)                                        |                                            78.53 |                                  0.59% |
|                         | requeue (ms)                                             |                                             0.12 |                              (I) 2.94% |
|                         | wake (ms)                                                |                                             0.29 |                                 -0.72% |
|                         | wake-parallel (ms)                                       |                                           0.0027 |                            (R) -10.60% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| perf/mem                | memset -k 1GB -f default -s 16GB (bytes/sec)             |                                   33861254728.37 |                                  0.04% |
|                         | mmap -p 1GB -f demand -s 32GB -l 5 (bytes/sec)           |                                   33677436964.25 |                                  0.44% |
|                         | mmap -p 4KB -f demand -s 32GB -l 5 (bytes/sec)           |                                   25464266889.26 |                                 -0.94% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| perf/sched              | messaging -l 10000 (sec)                                 |                                             0.99 |                                 -0.55% |
|                         | pipe (ops/sec)                                           |                                        319346.30 |                                 -0.83% |
|                         | seccomp-notify (ops/sec)                                 |                                        130238.67 |                             (R) -2.86% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| perf/syscall            | basic (ops/sec)                                          |                                       7377677.90 |                                  1.14% |
|                         | execve (ops/sec)                                         |                                          1526.50 |                              (I) 4.25% |
|                         | fork (ops/sec)                                           |                                          2393.27 |                              (I) 4.30% |
|                         | getpgid (ops/sec)                                        |                                       7699746.87 |                                 -0.93% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| sockperf/echo-lat-tcp   | ping-pong m:64B t:10s, avg_latency (usec)                |                                             8.09 |                                  1.82% |
|                         | ping-pong m:64B t:10s, latency_p99 (usec)                |                                             9.20 |                                  1.92% |
|                         | ping-pong m:256B t:10s, avg_latency (usec)               |                                             8.15 |                                  1.93% |
|                         | ping-pong m:256B t:10s, latency_p99 (usec)               |                                             9.21 |                                  1.95% |
|                         | ping-pong m:1024B t:10s, avg_latency (usec)              |                                             8.35 |                                  1.75% |
|                         | ping-pong m:1024B t:10s, latency_p99 (usec)              |                                             9.39 |                                  1.79% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| sockperf/echo-lat-udp   | ping-pong m:64B t:10s, avg_latency (usec)                |                                             6.98 |                              (I) 4.78% |
|                         | ping-pong m:64B t:10s, latency_p99 (usec)                |                                             9.15 |                              (I) 3.76% |
|                         | ping-pong m:256B t:10s, avg_latency (usec)               |                                             7.04 |                              (I) 4.08% |
|                         | ping-pong m:256B t:10s, latency_p99 (usec)               |                                             9.20 |                              (I) 3.37% |
|                         | ping-pong m:1024B t:10s, avg_latency (usec)              |                                             7.29 |                              (I) 4.28% |
|                         | ping-pong m:1024B t:10s, latency_p99 (usec)              |                                             9.47 |                                  3.08% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| sockperf/packet-tp-tcp  | throughput m:64B t:10s, msg_rate (msg/sec)               |                                       2741038.17 |                                 -0.59% |
|                         | throughput m:64B t:10s, throughput_mbps (Mbps)           |                                          1338.40 |                                 -0.59% |
|                         | throughput m:256B t:10s, msg_rate (msg/sec)              |                                       2287435.17 |                                  0.08% |
|                         | throughput m:256B t:10s, throughput_mbps (Mbps)          |                                          4467.65 |                                  0.08% |
|                         | throughput m:1024B t:10s, msg_rate (msg/sec)             |                                       1681400.50 |                                 -0.11% |
|                         | throughput m:1024B t:10s, throughput_mbps (Mbps)         |                                         13135.94 |                                 -0.11% |
|                         | throughput m:1472B t:10s, msg_rate (msg/sec)             |                                       1527520.00 |                                  0.14% |
|                         | throughput m:1472B t:10s, throughput_mbps (Mbps)         |                                         17154.77 |                                  0.14% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| sockperf/packet-tp-udp  | throughput m:64B t:10s, msg_rate (msg/sec)               |                                        428854.17 |                              (I) 4.13% |
|                         | throughput m:64B t:10s, throughput_mbps (Mbps)           |                                           209.40 |                              (I) 4.13% |
|                         | throughput m:256B t:10s, msg_rate (msg/sec)              |                                        424411.50 |                              (I) 3.17% |
|                         | throughput m:256B t:10s, throughput_mbps (Mbps)          |                                           828.93 |                              (I) 3.17% |
|                         | throughput m:1024B t:10s, msg_rate (msg/sec)             |                                        399098.33 |                              (I) 5.30% |
|                         | throughput m:1024B t:10s, throughput_mbps (Mbps)         |                                          3117.96 |                              (I) 5.30% |
|                         | throughput m:1472B t:10s, msg_rate (msg/sec)             |                                        399116.00 |                              (I) 4.98% |
|                         | throughput m:1472B t:10s, throughput_mbps (Mbps)         |                                          4482.26 |                              (I) 4.98% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| speedometer/v2.0        | score (runs/min)                                         |                                           181.33 |                                 -0.09% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| speedometer/v2.1        | score (runs/min)                                         |                                           189.67 |                                 -0.09% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| syscall/getpid          | mean (ns)                                                |                                           145.83 |                                  0.11% |
|                         | p99 (ns)                                                 |                                           160.00 |                                  0.00% |
|                         | p99.9 (ns)                                               |                                           180.00 |                                  0.00% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| syscall/getppid         | mean (ns)                                                |                                           146.67 |                                 -0.68% |
|                         | p99 (ns)                                                 |                                           160.00 |                                  0.00% |
|                         | p99.9 (ns)                                               |                                           180.00 |                                 -1.82% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+
| syscall/invalid         | mean (ns)                                                |                                           136.00 |                                 -0.49% |
|                         | p99 (ns)                                                 |                                           143.33 |                                 -6.52% |
|                         | p99.9 (ns)                                               |                                           180.00 |                                  0.00% |
+-------------------------+----------------------------------------------------------+--------------------------------------------------+----------------------------------------+

-- 
Thanks,
Usama
