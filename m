Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012046.outbound.protection.outlook.com [52.101.66.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FC54657FD;
	Wed,  3 Jun 2026 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780476102; cv=fail; b=shAts9My9QmwoFHmuPWYRk6KV8A/s1Q9NRbH39p61xBBFZfXIN50VY8KSHW/e33cb7E+/qSkNPsPeNyiL6yQeAoh4xNU2LHM6qMSXR6SKG9b7qB+1rXItwrVbtjEgMCSf9N0TVE+HBnE3pVFxKi+9OdJ8+YfLMGLKRS69NiGK2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780476102; c=relaxed/simple;
	bh=Tcw2OotuFVcHvhQa/X6+36qR1gZEkpH5yNMliBXuCYk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rYG9XC2w5ZEpM8w15lfrYgF0l0wT+JsLqQxyTv75lExGNy+skhaPtZYFLz+8gwyTc18D3MAtOeBeP7rpOLctR+xv4MJYrqcbBTUgeZ31tpoZDoIkMqCiRQfDPT8fWFmXaN8Ddhv/J64jZvn/wM1IktEn5VGeaYsBJHJNSTzGD+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cwTDVXYJ; arc=fail smtp.client-ip=52.101.66.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cwTDVXYJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qv3GnprB2r3b7EqzYR5X7ZpzFfNFeauhfjhM/7fNN33Xboan7QHbNF3M177NwpjuDUGlZMHc3lKT5m5r7DBzJrrBCvcaIrle87IfrOTggp6opu59v1PVM2jY+bZkrfmpwtn1jKh4rXcdBYaLKq3PPnDt/zN/oINc+lCVmZyh6rZ5kSQQ2FTvOMh+PtjEegwOZn7eL/saQJ/R0k2NnmKwgvlhrCbClPHN5rkO7PVDJ3m55Jy/QDwW2oeQjkY199unubf3axNxLYLV55RYIm9UI13HR511bBQ+kY1z4J1GjEU85/a9650A5w6OLkT1uleHZWEBwLo+KLaI4lQPV+uSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18+lHutZ7D3sVaNc8fEFutZEZPsl9KKH36SAMc8apRM=;
 b=jLZfHOpACmpmVkYLx3MDiBG9beoShpTT7UV3im9/+K8hwB2YbNQneSb8vHvBVS8y26l4yPNWOm7q+qZyfnusWHOfhnN0/cBAYTwjYr4mIMC7ZQkVnbIAqfQyhnElw/3vjQ871eQduG6uqRxNoODkCCSx9v4bClQbAdwSrT2/O0NhqkILP0tpnhvfhEVu7MXo1iUqqO7/qJMJ502oTDpN7q2WOmsGU9QUjew/q7zsMhDipZcwMBzBnTB0iQofqgRISIz+aot8/soDrxqo/fUHbP6Hk01vQx+LbyAhkyyCOzDKB7+eHAEtCeF9rVErIM9lnj7hhEQo8wZBrr/GTP0pQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18+lHutZ7D3sVaNc8fEFutZEZPsl9KKH36SAMc8apRM=;
 b=cwTDVXYJvlArBoM/45frDl/pjIXSrdkB5dVP9OVKjBugbYAIU9JjogqHwXtg3UhvSVBYk5M4QNWe+zDRMtBTNAMymQOgLo9CqBbe84gWt/50vy2IpDUfFu+fyHMLu+sIzLMdkoDHDlKsFmiU8d4Yr7IXSJth+UmCUU+xnRuMg1x9pOQrv+dAQn18hFGK+9XFauSH+csx9XjFXSIjREeMNqWDbxsHZ0TeoXMAgaah7860iHtxohBMHkyB/T4bLJxfpTQHOiMKKttQQNAV+qHya2sd5M45uN6hCQdVu4tUwmHVNGmfCFj8pYfrUrjFN0kZ1TV/mOIzcGngQVY46zorwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by AS5PR04MB11465.eurprd04.prod.outlook.com (2603:10a6:20b:6c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 08:41:38 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0071.015; Wed, 3 Jun 2026
 08:41:37 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Date: Wed, 03 Jun 2026 16:44:32 +0800
Subject: [PATCH v2 2/2] device property: fix infinite loop in
 fwnode_for_each_child_node()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260603-fixes_fwnode_iteration-v2-2-0ae381f8b7b9@nxp.com>
References: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
In-Reply-To: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780476273; l=3079;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=2i2kKcYDU3UUn10CnufyCGwuLdj5Hqtsn3VGeQET1RY=;
 b=8qRfkuTT7qb49+90PzN2U6Axz1DPAps6IeNztIUSmUgOw1fFwBJHPVKdu80kh5TA0L6DirNz/
 XTk0x2IqHj+BJAPefp1dsS9lGSJccAejC24VG+1A8pAon0ONpT5i65b
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG2PR01CA0184.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::9) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|AS5PR04MB11465:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c2c328f-cf7b-460b-7aaf-08dec14becf9
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 g834mwCbLRlySX33oy+Y3d0p1PidtuDElxmVosPDan4DRnecMYiVgO1FAWso2oEhJ52MhBF5J/WR7O9IlpQDKt2cGRh6y/MUOnIJhSJUCRKhWFI1udzp4qHAkMM4aW3TnMNnUXeQ+msnIW6DeNHBR6y2O/G/4FEp7e4s5m05jWTc6k9E+nwSGrQRQBfWmC0aiKdf0yxEUS2aYfYYoUckbhFXo1yW5XyptjoovkDF7HyD31j/bDlCEUe78R9vTyH7B96FpkwQ1ik3z7E74BPLoklACSTymTkdi1fKDsTmsYoigKuzSVPVFt5VsQnN/tiBLkmucloK5WOBs+uDxe29qiFQUQlkA2C2F0kruv+5RUFZ3inqK5tNv/3Fh6u3at5hQIdd/m8IeH6Om3NzXRs2OAMnk+RZ0/TOuKJo23gseekHnDtuw3uXOSzKzDyPZVset6FQcK6qToF7I1OWO+xlxtIIxLLKppOLg9eSSnhGwSDllwisalSbccMsPi0WqRCKnse9tcgtTxkm7dJK/2dCT7yOf+L10Ma0HrBMmEvB4d9J49+Bv/bNYVRit256WI0K6fw1i6ljL5COHaxVB9LQ9uZy6kdf0uRfUrGVBAYjUYlwYHwyuc6jgSEfpewV2Cp7Snj3ne5eJ5EBGA0T3BMrAflbQvfVmyEbY2v6/ZLuDxgC/Wr/n0ml43N2hVaqTqQj
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VEpnS2tsdXhYTGJvby9idUpHSmRvbXdqeUY0QUdYSzN2QkpGK0Q2UklweFM2?=
 =?utf-8?B?UC9vUXJkSlpUaUhlOG1VQi9PVGFMcHc1T1Nwc3VpbExWb1FkQ1djaXlFWTBJ?=
 =?utf-8?B?aUxZVnJOVGhueTRjNjM4RkQwSzFwQnZyWlJsY0s2aitwN3ZkdFdNNEx5RHZO?=
 =?utf-8?B?Nm94aXAwbS9TeUtTWTZJYVllaHEydWw1L1VkdzRNVndSRVpVYUh4dWxIVlNq?=
 =?utf-8?B?T0hMdlBXY0VROWU2YVFzVzl0QmpMd01LZEZSSEJDdngrOE16Zm02enBQblBq?=
 =?utf-8?B?OUNRb2ZCQ3VkZDBzSHlIeG9UWlQ2K3ZQQm5QWHJhdXpsRkZQQUdER0grYUJG?=
 =?utf-8?B?aEcrNHNaYWQ4S2tYUVNZU010eFdjS0NWeDlMT3VYaTk4Um1uVEtQMFUzcUMz?=
 =?utf-8?B?cDBJeS8wQlNJM0JSQTQ4bzUzcGJtaVE4YXpyUjFCT3BVaFRpWGNycW1pcFRs?=
 =?utf-8?B?NU16QlZoM0puNE9KVUViR2JWaGhLRkdiZWRNTFB6TUlxK1NDZlNFbTFLOEJl?=
 =?utf-8?B?VnFzYkpGcStMMC9GMkJiVFh5Ym03OU00OStMYllrRWoweVUyS0VmU09USVg0?=
 =?utf-8?B?OE96ZDdkbGRzYmdSWi9zckV4dTdZRXdHQ3RyeXpsc0RwNU9RNzliaGdqUzZs?=
 =?utf-8?B?NnJXMDB2M05MbnRBRS9RYmg4Tk9CNXJwUkdoK1dVT3RXUlVwWFpSL01mTkcr?=
 =?utf-8?B?Y29NREJRNlFkcVlzbzZRUDMwQXlCYk1sR2tWOFdFMVJhMEV4bFpEdnJUVm5i?=
 =?utf-8?B?VlQvZ1dLQWlLcVI4YkkwdjBLVTE4V0tFYWJHMzhHY09KajBaSk5HMG1JNXBD?=
 =?utf-8?B?TlpOUGdzQmphREVodnN1V1VVS2sycEdJRjF3NUpBNUVkOGcyVm5ES2JVRjYz?=
 =?utf-8?B?a3EwaHNLbXBJMGRNYXV5SlMwemsxdGc0NlV4c3JtVUNxZVZKOGkvYWVZZGJp?=
 =?utf-8?B?NlkzN3BrMkJ5cGV1UFc3QlBWcElUV3RPbUQ1dk42ZWIxYUZuNmJJWUhVVHEz?=
 =?utf-8?B?WXZzbFhtL3VMMXAyTUVVSFZSbVE4RzBMTnhyclFwM0NHM1hNRmlXamNqcHJX?=
 =?utf-8?B?U0pwUDFvWW4rZ0FSZFkwSW9kMm9JOFMrekc0S1k1bjVLVnh2N2ZZWGw0aHYr?=
 =?utf-8?B?RkNhZUl5cXluSldpTG53WFBSVUVLRitoUFRHZDdZMnk1TUJUbnVJVXdCWUQy?=
 =?utf-8?B?UVIwL0l2alc2UW1MUDJJTXdFc2tXdmYxdDNqcWNwZWJlandDQ3Z0V203ZGNO?=
 =?utf-8?B?UTFSN1crNmw2d3lBMjRoMHE2OEZZQUlmZG00Vk5vdmJycXo2TllHdkFTTy9o?=
 =?utf-8?B?d0dzZzYxc3JRNWpwZHVLZk9tNzFzakFWNnBmbnRiTXk0OVFVVmhmRDVVa3lV?=
 =?utf-8?B?UU9EM2M1UTcxNGJUSytVRTY4ZTFVTmRZb1g3UitJUExxMzJsUEhXNjY4NmZK?=
 =?utf-8?B?bGtjem95WVNzdlByOW1Gb05RYkk5cktuL1FISmo0Q0crays2dHdsa0ZJTE1X?=
 =?utf-8?B?RlZ6OGtBbXFyMUw5SzFHV0dielFXM01RQ1htZ2x6dnlIblQ0cTBSMGR1TTJk?=
 =?utf-8?B?U0l6ODd6TUdoYmJUbVovWnpCM2dJWnl5MThCYnlMRWlBQU9nMGxERnJWRkVo?=
 =?utf-8?B?Tml2VzRHRHljeW85MmpNUUkwY1hHS0NudUd0bFZRaEJoMlJSL0NaQlZKQ21h?=
 =?utf-8?B?b3JPQ1UxUmk5c1M3UjVCZDNpU0pGN2dlRXp1OW9tNjVlcXdZcjk3eUMweU8v?=
 =?utf-8?B?SHpjcGVKYWJiTjI4eXROYmZBTVpvcGFBQm5zQ0hoQnJndGNxb2trVmRwVmdR?=
 =?utf-8?B?andDYUJzc2ZuK3MxMkRFOHh2YkszRlRGRjNUZDVIU3VvT2xXb3MwYnIwTHAz?=
 =?utf-8?B?bWZNTnVSaEZDUkQrWENENDI2VEdYaUFYQzFuTlVPWTlPUEJzdFBjQjVpVUxT?=
 =?utf-8?B?bjJJaW1HVEN5ZlhrV2VYeDBJdXZkNjE3NjlTNUptRC8zdTRKZkY3cHI0c0hx?=
 =?utf-8?B?Q0xWV2ZSMXNBNFdWdUUwNmd3T21hRDViMVdEZWZpdXlyYU40WDlSWVFNcUhp?=
 =?utf-8?B?Q0M4bzlwR0ZXQ2RDeFRqamgrTzVjbG9tdm5UYnNXVTJzRXZoRHFnbit0TzBa?=
 =?utf-8?B?YTFDeTBudEJBa0ZKOEZOYm9RVFRBbzc0YTZDbXNlWFo1YjJ2ek8wdHFFTElL?=
 =?utf-8?B?MURySTErUnZJMGUxS0pqU29GTzd1eXlhdktzdWZUR2p1K0I1dE16ZGwwUFNh?=
 =?utf-8?B?Y2NJUjVyUXdISnBVSkNBUTF3QXkvZ3RzREpmN0trbWVDdGZ3ZEl2Yi85STkr?=
 =?utf-8?B?LzhIbitYR1U4Ykp6VTZQU1orSDhIRStTM2N6cCtMUFFqdlVFWUIrU2pqREY5?=
 =?utf-8?Q?oO1MRwGs8RH8S2NemnXIenmho4Dui7Mxp9eVE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2c328f-cf7b-460b-7aaf-08dec14becf9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 08:41:37.8536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8HyMO6mMj2LwiGBDkhY6SvupSHGrYlsOItRsKiVZhreVAU240Yr7DfSI6fUFcaarpGeVSluggSy+1zf9tKHMIoNNnv+nYcOk4RHhBMVpklhOYws3DHbd7f6yH6hbMJk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11465

From: Xu Yang <xu.yang_2@nxp.com>

When iterate over children of a fwnode that has a secondary fwnode,
fwnode_get_next_child_node() can enter an infinite loop if the secondary
fwnode has more than one child.

                       Parent        Child
      (Primary fwnode)   FWa:   {FWa1, FWa2, FWa3}
    (Secondary fwnode)   FWb:   {FWb1, FWb2}

In this case:

 ┌─> fwnode_get_next_child_node(FWa, FWa1)
 │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa1) returns FWa2
 │
 │   ...
 │
 │   fwnode_get_next_child_node(FWa, FWa3)
 │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa3) returns NULL
 │    - fwnode_call_ptr_op(FWb, get_next_child_node, FWa3) returns FWb1
 │
 │   fwnode_get_next_child_node(FWa, FWb1)
 │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWb1) returns FWa1
 └────┘

This cause fwnode_for_each_child_node() to loop indefinitely, reapeatedly
output {FWa1, FWa2, FWa3, FWb1, FWa1, ...}.

The root cause is that when the current child (FWb1) belongs to the
secondary fwnode, calling get_next_child_node() on the parimary fwnode
incorrectly returns the first child (FWa1) again instead of NULL.

Fix this by dynamically checking the parent fwnode of the current child
before calling get_next_child_node(). This approach follows the pattern
established in commit b5b41ab6b0c1 ("device property: Check
fwnode->secondary in fwnode_graph_get_next_endpoint()").

Fixes: 2692c614f8f0 ("device property: Allow secondary lookup in fwnode_get_next_child_node()")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - use __free() to put parent fwnode
---
 drivers/base/property.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index e08eadd66f4f..f51087065bf6 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -808,17 +808,29 @@ fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 			   struct fwnode_handle *child)
 {
 	struct fwnode_handle *next;
+	const struct fwnode_handle *parent;
+	struct fwnode_handle *child_parent __free(fwnode_handle) = NULL;
 
 	if (IS_ERR_OR_NULL(fwnode))
 		return NULL;
+	/*
+	 * If this function is in a loop and the previous iteration returned
+	 * an child from fwnode->secondary, then we need to use the secondary
+	 * as parent rather than @fwnode.
+	 */
+	if (child) {
+		child_parent = fwnode_get_parent(child);
+		parent = child_parent;
+	} else {
+		parent = fwnode;
+	}
 
-	/* Try to find a child in primary fwnode */
-	next = fwnode_call_ptr_op(fwnode, get_next_child_node, child);
+	next = fwnode_call_ptr_op(parent, get_next_child_node, child);
 	if (next)
 		return next;
 
 	/* When no more children in primary, continue with secondary */
-	return fwnode_call_ptr_op(fwnode->secondary, get_next_child_node, child);
+	return fwnode_call_ptr_op(parent->secondary, get_next_child_node, NULL);
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
 

-- 
2.34.1

