Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010023.outbound.protection.outlook.com [52.103.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94D531AEB;
	Tue,  8 Sep 2026 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869858; cv=fail; b=YxZs4uXbJN8iOZyiabwQxuVHO+49vtU4vowlmMJMuEJNzJHeyTG0I1V4z6Bv71mtUlvzeH1LyWLXqMUwEAd1rFZQYrr4t98eynyhk+hEYtAmYq18F298xXJ2zx+LTvcGeNwd3Azt1LcPeaXpz9nohEYSWG0molQ+wZElSiTMbU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869858; c=relaxed/simple;
	bh=aHVqaJ67mucfqbz+m05efTZm6Ual4GrzGQcSx6E0FaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SgmxyK/f8yonTXoK8HBfHVg8rzwSHxu/vuZCNz6qNoNMTA/qbhyYB96BKOwtauYulHpKgvmOLhyBqhxeXdi8AB5YMpx31hmjVZZa2ZneMvE827pLg5zJKftQIS6P5DI7LN1Bs0LPXMNUtYcqDeQcRGGNX85h+BNWzvzdvwMekZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.kr; spf=pass smtp.mailfrom=outlook.kr; dkim=pass (2048-bit key) header.d=OUTLOOK.KR header.i=@OUTLOOK.KR header.b=CLOFKWkA; arc=fail smtp.client-ip=52.103.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.KR header.i=@OUTLOOK.KR header.b="CLOFKWkA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilDTZ9BDzYg5j81h6CGSc8uyjZxImuAEPaAoex0WtI9DiYNzO05Jg6qWah5iFfG42JeePzD8Zeki7mBgraXsGdSgznTKnPM9TuS2n99RkpBduIVxZDVnywfGTw8zuVPuP4ccTKDjzOxs/wi70nkmkcyv7G1wNSlN8q6oYKFGGECzp/RHxJTxkKnn5/rNLFfElIMJK0WODbFkA3dhJjqmkhJK/ifnyYcW7izP3W41UpoJ7ZNLClZnVyy2Tkst3RPrj3bBHXOrXoc3mhPlBA+uZT1ygcb96XwQXBP9u14vlRBS7Sy2923rn2quizMoGDI57ksp+E5JKQCCippxmHaOiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHVqaJ67mucfqbz+m05efTZm6Ual4GrzGQcSx6E0FaU=;
 b=hnxxfq6/sZ/mW0EmXJQ8/fAaKtE6h4eM0SliMXUJ4brmZIWgJzWm+41xWlJRyrfRMaEtqCc91WHn0dsrTOwsU0imOVYV4MTA92iexg8slCwqkguQiQNgfak8TyI1us/JL/qkBKTXyvBAy+c3b/2z9mPHGRA7ISsimOSNrwBsRmLnO19DRjtjRcGhnptVGyQYilWpLR1M+7sbuxBy60Eafdeqr1a+Cdsc2R1FW6r1j1CVaQHlHJM8S11JY/NKBTfWPzfLeZN81LPYxyM0JCPqT6e/kkwi8/WgiwEaeeb4QevBWME6JxEi4FGQhl8cWHoeJPZA7IVaQ50VLeCgtLNX7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.KR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHVqaJ67mucfqbz+m05efTZm6Ual4GrzGQcSx6E0FaU=;
 b=CLOFKWkAvFPurT94jZkXSrRJkC/PR4Iubp8t6BQL3wJMzOX74C5tHCcHzXV72gt1n3gPEny63XLYcVE+ti2PrueqpObS+qgq96Prt75TLRfpuluCEjEKuDQLVo40Nh+nQi/RLO51R86P0nio8zJveQmvA+4ILf4bh3ghIA+1XyzjnzZjl80XU1tVT4nEwXUB2d2oLTAvHt1myGg5/AR49csPJCygCQRiUre5tHetFstxwWZErE1dvVUNTFvZ7xgZpQpu/o+hRNWIPuVLwic4cYPTbbJEwoZHDHOVY6smUvi6x11tglNbSAE054NgJ7d38iE2VJwU1vvd8YmXjfLFPQ==
Received: from OS7PR01MB13914.jpnprd01.prod.outlook.com
 (2603:1096:604:36b::13) by TYCPR01MB9749.jpnprd01.prod.outlook.com
 (2603:1096:400:20b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 12:17:27 +0000
Received: from OS7PR01MB13914.jpnprd01.prod.outlook.com
 ([fe80::641e:83cf:743b:85bc]) by OS7PR01MB13914.jpnprd01.prod.outlook.com
 ([fe80::641e:83cf:743b:85bc%5]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 12:17:26 +0000
From: Eric Kim <seohyun.kim@outlook.kr>
To: seohyun.kim@outlook.kr
Cc: juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	qlsdnjs236@chungbuk.ac.kr,
	stable@vger.kernel.org,
	vincent.guittot@linaro.org
Subject: Re: [PATCH v3] sched/fair: Reset NUMA fault locality after scan period update
Date: Tue,  8 Sep 2026 21:17:08 +0900
Message-ID:
 <OS7PR01MB13914D8D53A4FB3EDB973473796B12@OS7PR01MB13914.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <OS7PR01MB13914CB69D682A599970F258C96A62@OS7PR01MB13914.jpnprd01.prod.outlook.com>
References: <OS7PR01MB13914CB69D682A599970F258C96A62@OS7PR01MB13914.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0107.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::12) To OS7PR01MB13914.jpnprd01.prod.outlook.com
 (2603:1096:604:36b::13)
X-Microsoft-Original-Message-ID:
 <20260908121708.6310-1-seohyun.kim@outlook.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13914:EE_|TYCPR01MB9749:EE_
X-MS-Office365-Filtering-Correlation-Id: d26ad6e6-077a-4ab5-a622-08df0da32418
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|21061999006|15080799012|23021999003|5072599009|8022599003|25031999004|8060799015|19110799012|25010399006|2607281247196008|3071699003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IdtxmeRyrni2djdYyy9t0KVXsDloGxmIw74SarpcmmH9zlh/2K3E9bMh3R+b?=
 =?us-ascii?Q?8hDyjJWuRShFE303+eKkCN5QK6B68AI0krvlNoB4/sstGtIKdfDxaOwFQCbs?=
 =?us-ascii?Q?4UYkdZGRnIEWZ0Ss4PsUrJieKvpvIsz803Ctzlr8j7Jnfmd7PoBFjkkFAoiM?=
 =?us-ascii?Q?zlEYKKRmnRN22WQhqr1yDKz85YXcEIEhPjyR6xFn+lUfLh9ntJI+3uDjODws?=
 =?us-ascii?Q?onOsLhVMHbl4zQHtzlodQi6G8bNjRk6AlspzPiGV8EU7x+RWh9GEzpviiBxc?=
 =?us-ascii?Q?/Fsrq9ai/cGnOL+bGACUxy67QrHBnj3WEidMiJu7akWJVO2mtGZ3uwri1KkO?=
 =?us-ascii?Q?nMsdrMQzJ+nr/SZg5/EaFI1HRjcvI+sZcoK+2wj2AYUfiCXuB5aYYpTCFHui?=
 =?us-ascii?Q?7YWKyFtbq/o2cCnEMiPwEZckmMD9vD5zehh57l2qmMojsbjh98zatHbyfFu2?=
 =?us-ascii?Q?/aHVdbvJv+vJ0HhN5ZRfsyF6BtKLrNvEu22jUCIOM50NTyvuxTaH3V2iCLen?=
 =?us-ascii?Q?W5Dd4r1vktEht2eHszVWdw1TfS/CVGJLpdG5QzYK7A5ki28Fh03TR5t2TmSP?=
 =?us-ascii?Q?Ci7FqbIsjNKkoE8/DYVz9UYFoV9cm/2u4ghbgPDaxNybaXFSQUCLCS3OrV8a?=
 =?us-ascii?Q?cBBICYNcjkSc6ibqWOw7eJfQmgaHYzrnanayKba05TLlzOFDBTcqdv3lo6PE?=
 =?us-ascii?Q?LWpeNeLbsCoEA4NYCuPDtcp4TDX1SOdJ50SbeUR+e7R2kFyZEWfBQVCsfyy/?=
 =?us-ascii?Q?J148yZk7RAVlljDBOZMFldjwbIVUUaBbBk0nLHbZOI8vHpvsIvuvNuV2hkdi?=
 =?us-ascii?Q?XlsfcOmdyRjFy/72bT5KHkQ2eTzVSgEIKJnNif+mbbQDHpxtUgxKI/GYWECX?=
 =?us-ascii?Q?utYxyc6IV9AcMpZa1vE5+oFo+SlT1SmBbxCdGRgKWaOFnMoROO8uFDcjis+e?=
 =?us-ascii?Q?MCVtfsKQPz1yHmfO4uErZQyO+swjGn2vkm4DY3my5orXZ5EeH+35nQhVpLLv?=
 =?us-ascii?Q?dPBacU92ShIiDEFCmsviCgtVLA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AWTlZQjfYUNLJZcAtEJc03mR8u3xmC5NWtIN4CgexMvhUaONPpy3hnUv2kfe?=
 =?us-ascii?Q?3RmVv2UHEmOQFgjo03gfH8hItUZwqRvFkVp5v9EzLVXt9tLY+/fIh5uGMX+L?=
 =?us-ascii?Q?Apt3yvHWpP6/CxWjQVELFgDsl7hSzKVy3R3pPU8pPs7c5Jo45dx63aaTHgzq?=
 =?us-ascii?Q?VPC6kTF6/8LI2JsalD3MILapAOi5OGDsUASD0Qw3QcsqFzXks1I5rSfA6Y8B?=
 =?us-ascii?Q?Juxp4f6Axm58MkvhcdDwN9b8r9ehxTlNUPd39k4vEV8XajFkqOze1AJP4iLc?=
 =?us-ascii?Q?ne9dmDLYJaHoaVRuuVYHoYTplAMkMpgOPxr1LalhCfkiafG9YqMbWI901zt7?=
 =?us-ascii?Q?3H4C1KZorZO4QPi14L40nhefNYLhwfipg3slPz7G49M4ZQlpzgQY/GayEJBn?=
 =?us-ascii?Q?xGaVJAkVolde4uJDQLZxw5HvPGo41RAfga59SBkLFj6Gq+oiqF1+nXe5d7Cj?=
 =?us-ascii?Q?8hjTNq30qk1zVQeZReXJDZQTylPb2nAma9T4ytzddPSt2maOmb90wldLeNgK?=
 =?us-ascii?Q?eirFTKVJOLPiQcpX0DmKr9sZoBeQA6xCG0ezkzod6jST0WMvEaEKticjwF5N?=
 =?us-ascii?Q?hcjapN3mhzeBQqSJjXwbeHNiAhR4ot0vc0D9mjmGqmGRkOOlqKY0KzvorjLd?=
 =?us-ascii?Q?ZmASpjxsxqvlXz41w4HD7sOAjkxT3sSbW0Bz/qXvv4SrQWEDxpvW8TbxfeGg?=
 =?us-ascii?Q?zfNfdud1cO66F0NuvyXHdTLiSdc33UPMzxFwHskvgJlHoawhdXMmI3SfVlrU?=
 =?us-ascii?Q?Eba1Dr7marxyCcwiQG9jl+DmA4Sc0GNiJRcvTzBCcKGH/i/e7ifKThPwLkJE?=
 =?us-ascii?Q?UzDuScmQlIown3b8eqAcEzo1XWJl8sDZS9RQhOlAXhOyKAGGqX5EEF9RccXK?=
 =?us-ascii?Q?Hl1A2qiHbALmM7f6IOMdlcIZ7jgBXVQfUaNCo8ILNZhx8ZiOwlOlT+/3okiU?=
 =?us-ascii?Q?OJdO2zaeZi7O/NCQtJ32rQMubW+2flSyH+r+kaWuVqmGieRBDcO5bGXIb+H3?=
 =?us-ascii?Q?VgwcNVLFbUOVswasK8VO+pTKbnge7wwmec//jUhaZuqadwtW1Hb26jjCXcr+?=
 =?us-ascii?Q?qe2PsjpKSXQPvfN5HL8zfqDj8F44hvMTcYdim4C92YB/k/FuEmmPo+e7wikR?=
 =?us-ascii?Q?jGewrbmSABkOgKStni463PxzIG/w2pSXa+Y+8VY3DhJuJ8zlMjYd+++yb43f?=
 =?us-ascii?Q?r4PNTgIsBK330CYl7cOzE8t3Zp5pFtszugs9c5ThBgsBBjY3FVh5RbyOfkK1?=
 =?us-ascii?Q?YqWo8/wMkrse7OwQ9a+jkHnJJpuvLseQGvgflv6LaZgCvv9ymEB7Dv3pm9iS?=
 =?us-ascii?Q?uzNBr+fPAM0RW3ugUSZVJr7TYcKtZFXGSORSR/ScKMfyIUrSfPEFONfLrvBA?=
 =?us-ascii?Q?tz3urHZgjV/aD6JRzH7Y/l86TtmN?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d26ad6e6-077a-4ab5-a622-08df0da32418
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 12:17:26.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9749

Hi Peter,

gentle ping on v3 of this patch.

--
Kind regards,
Eric
