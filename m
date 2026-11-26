Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795679005;
	b=KMx8qI+Nm8N+tVCkkjmuNkG3sJlAI3MypQ5FNnN49J02gIjaj8nYMls4Dj7hwS1HRBty
	 Wa3iJmjTJ/K6bcDU+IhuwuY/531ReLhZZixlqbcNsYReF3MlHlq4Qcdqeu4CqIeocGUkS
	 Q5sV67QAg8iQjSq1qbrgXRttmUYp+iNmJlhmobqnOWonH+uH3p1JAeAKkehN+DMEdnTAL
	 T2/JUCLam8O6XTvraIRmnuTsSlKoE8Ok2p02tYeAOzdyC2y1pOfxa/uVuyy5yJhBh/uVq
	 q5SEh1MFmYlLOFFF2PRgBLfhfx6t7sg3yUq5wZb3dnfaf6wrxR/FVbAUVc1ZolUPkKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679005;
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
	bh=O+0uQTlfiIrikzYkB8SexRYhfwlzKkFlaIFx+Qqmz2o=;
	b=myucLyho+ABoNENWwg2sxjjcjlfo2aV6q/K90urlNJ6n2Egf6u0p7x+9RxYdMKGAjSYP
	 lrK4Nx1x2RYtvl4Oy83NUOnYzjcP3zqYlXiV/DVAI6Y3yHfAaS+P1YVF878LjGMvQHaSv
	 nN+H3cGgEVQSzEGGiTO3Xn2L0p4LrVCw5QCpY2+OmfmFLcGqtx8pfEXNGQN/9u4Ao6h2y
	 pXdWD8bdn2ZSAxyf+zWBiG/htIDpHYrKs+od3/GyA7pGkwvrw55rJiCr6FCJdHf2qydq1
	 G4HC3WEnv2/nvnlPkoOPzYVxf0xbQ4pyW5zABPTFx0XZKeL2tHHDNeA83eurQ0/LpXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uuDySnWP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.21
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6F606A31C;
	Thu, 26 Nov 2026 07:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD6F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uuDySnWP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoMgHiewmWFfuOIBwnacBBDRQUco1PrCb/0ipkUggyqWBJhwOMPvVUBJeaIV4do1U9j3GA8zUo/wBmXZyf0/mMS/3pAM+y59q1n1K2z7NLc97BvlUOtWsYmhYB/Ft5QIr7iWAghbeYhU6gv1jYeUjDNevNSENl2GMOyVZ5ffKWhzXXwtItxLbPGKSUKkUjAzNGWlJEr882dCdTfIyx2OiUh6ty2jJk9uaNTb7crfXGPSxuYafeF0yHs53LEJgf0BL7pkfyGxAYDAMfRoe/TVBG2EaIzqR1PYZwdg94oCoWqV72OldrwGRoqvoRiJ9CzRYj8MOs29XCPe7sRzIqcRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+0uQTlfiIrikzYkB8SexRYhfwlzKkFlaIFx+Qqmz2o=;
 b=m0i0HlSXt/yNilY0366O7evEI0E5TJvUrccv6Apitu/sgYmEgZkLkvhjfideB8JjOUSjC+BvJ8SvftTdXgzZy9oJvPtsegNIUNne4YzlADvSL05/MH1zMhTSjJHdvxYgBEKgdpnYYFal3eH4QYTuStFgDkVNsRCtvPY4vYzfJweRDautzlGmrqgq9+oC4YK73nzH1FZJAtTzGJh+YJCm0Gexk4Q+ys2JJVWMlM/Oo5jjXJSsvJTWb8rVyOYmGrD4UGV26qGkkqmiTWrIUPS5U9c8OndZ93fNe8YtTgSiVVyTMf53KOtuXs41IAZu/jXSf8HK1a1u2tF5Fu/xa2sJGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+0uQTlfiIrikzYkB8SexRYhfwlzKkFlaIFx+Qqmz2o=;
 b=uuDySnWPdeglmOkwyICXtUrtd0D12fDbZ4LrnRwIod2GuWyMTWjfjzXVvNScqqFgqATG8AfEi1fWgFxSyeN81QepHRdu1NglAVFvc9KE6n99FpoTqghkoq4bD9q6ehH8K9TcFZ5siCj0hG8Hm4CUnBcq2BJ6UaxZ9lXlEKdF0l6KuV+nsno0pFbKF5+5TzvQ4dfCEXVWxHl8U8nT/Z3dRindbgkdV4AG1NrKaBKKTO8Ur8bEVk7jK+8jocXfW507g+DhQU1rkkdcKiWtvXaBKPoeb3Esu9e/zegWawEZnU+w6frrD+Klwt4N0iCM1cY5ytc/I1sYe+fXDD2sYqa3Iw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 07:43:10 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0639.012; Thu, 26 Nov 2026
 07:43:10 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Laxman Dewangan <ldewangan@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org
Cc: Shardar Shariff Md <smohammed@nvidia.com>,
 Krishna Yarlagadda <kyarlagadda@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>,
 admin@tsv-stahl-riesa.de
Subject:
 Re: [PATCH 2/2] serial: tegra: Fix overflow in tegra_check_rate_in_range()
Date: Thu, 26 Nov 2026 16:43:06 +0900
Message-ID: <YDSh2MmmQ2C0PnN_a_1gKg@nvidia.com>
In-Reply-To:
 <20261025-upstream-serial-tegra-overflow-v1-2-267b5b7a79ee@tsv-stahl-riesa.de>
References:
 <20261025-upstream-serial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de>
 <20261025-upstream-serial-tegra-overflow-v1-2-267b5b7a79ee@tsv-stahl-riesa.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P286CA0089.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::11) To SJ2PR12MB9161.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c35166-34b5-4dc2-91b2-08df4b90eb17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|10070799003|1800799024|376014|10067099003|56012099006|11063799006|5023799004|261026121527099003|261021123027099003|261021121427099003|261102123227099003|261009221227099003|261009223027099003|22082099003|18002099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	GjXN1GbFNI2BYQ5gdHKw4MyLYiD0Bh9aDymE0sftVGlM3ux/KSZeI2Prr+Sr2/C4FHSMptVARbDVzsMWGCZ2wGCu395zCQWR4/I7w0Pvg4fCmyjc15GQh84n+MBxw+xmLwALf1gInI27J0U5wOav8grPbLfNFpt+0XBXgvJNs13UOZU2gHvK6CzY6OtKpjC2R23yT1sb9T62lxuJhNMmpWHa8+BvbgXXg3RCccO+S9cXTdJAWByh1NOHbC/mpqOg1uow/24wqw6RFPSpFmVGtHP1d9slv4a0qDP3EnyubPCvgxki+5X1UpX000JeLV3o2mSzTwH6W5SNy7DW2zqE9MS+ZC6ThrRu+5yHDwc9uFwlgP/PVc2prYyo/AZDFhvEYDhbVqkbdldqT09OXSYo5nvQLEOBXR5JX+8VEksJ42USxBokxYPqJ7J2ZXxVVN8oH2uJFntjZRnJLknJYqVdAAKcrYLmiZPGUHBOLFxarYcbpxg6qvtLKJp5+idhDMKetOt8DatjOUkS/nJQrfbZjxsUlTQximd5Ntq4+1YkbVslw0PvLxOr0CY7HFvpc9ceUZn11Fu153zwrGlvI4ihmrRAzrxADZ15v1MrLnw27n92aRmZkrByr48xsEnYbjYQZFLu+7aDS8EgAZM51rpRpVQnsjUHJgHETxnsR4VcRz0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(5023799004)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009221227099003)(261009223027099003)(22082099003)(18002099003)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmswYlpqRWl6QXFJRjFPSEFXRXBCSTRZU1VhdnlHM3dXcWRvb1lCS3ZwNXhT?=
 =?utf-8?B?SnFDTDFNUXFzUDJhdW55S05zd3ZlRE9XOWJDeHJ3dG5jNlVlMTNwNjhhYXRX?=
 =?utf-8?B?S1Y5Mlk3RFhVM2NQM09mUjhEcXZTVFpuSG9yT0twMktFMkZ0UHRFVGRaZlFQ?=
 =?utf-8?B?WklNeXZQcnlxWHVWVHRaOU9BSC9WZjNRMmlPL3RMQmR2SERsN0txTGJhdGUx?=
 =?utf-8?B?MGtMM1JuVkZVb1dXSk5DWWQ4VTVKREMwcDg2cGl2UVc3MzBVMEhTa1ArRzVG?=
 =?utf-8?B?K3lySUNQZFdaRkx0aDFZNVFxQW9TeXdjSHhORmZUc3psMlcrakMxNHB0aHN4?=
 =?utf-8?B?VXpvb1hOTkQ3dS8vaVpFOWhycTNpWE0wSVNFTHk5bWJUeE9HNFZUK1k0T25y?=
 =?utf-8?B?UWU3Zko3Wkc2U3JRY3hMSFdhd055THJ1K3JucEFIeXJlUXVTbSt1amxrZ3kr?=
 =?utf-8?B?Tk9iRFFSeTByTG1YYmV2RjA2QnZaSHFEWm9Hb1dVRS9nRmxHb2JDNEJCQ3kw?=
 =?utf-8?B?eXFKQmVqaG40RHNZcHBZR0NET1VlTi8ya3hDb0VpRy9QdnhEaTNBUmdYU2Ez?=
 =?utf-8?B?UG1zUWQyZGg2WVZwTlp6ODVpRFQ1OGE5T3NQRE1NaDdaM1IzYU01TGFhNzBP?=
 =?utf-8?B?Y1R6RngyTkVtcDVsQnZML2J3NWl0aFRYQ2lEcXlWbWRtWFE4ZWhrSzVPWWdC?=
 =?utf-8?B?TzVwNlpWamZpOUVCMXo3TC9HZ2F4RHFNNGtPVGlMTW5kYzhXRE9EMTVNbEpw?=
 =?utf-8?B?UVZqOGtnTmgzR243Ylp1bkZlbUR2dy9JZU50aW8vS1o4ZmdKaVFkRDNGdDQr?=
 =?utf-8?B?cjNSSFZkbXY3ZkNBcE1xYURIc1JERkl5UlNjUU5wQzFkV09aYzM2UEYzWEVi?=
 =?utf-8?B?YXJueG83cS9yaGpneVdkTVlVdFkra3ZiMTVVVGdIdEk5ZFpFREdXdmRVSFZx?=
 =?utf-8?B?YW9MdStjek14K0RZaXFkS1ZXSm9LenVqVXFpQlV6anR0Q01Yc2tLam1jVkFF?=
 =?utf-8?B?VWFic0hTNUExTm5lSmFVVE92cG5hS2NEUWZPZEFWZDlLbGJDWlRZTUR4QWh3?=
 =?utf-8?B?VmpvaUNzb2o2WGFEaFpTdWh6cFFLaVB2N3BKZXpDR2pRQWZib0VDcHZrTkRF?=
 =?utf-8?B?aUpNRHlTM1F5UERjSit1Nk15L29OUmM0RFpUVVl4VlBGZGF6Z0xOeWhLaTd6?=
 =?utf-8?B?YW5MbUhuREFkZ1JVKzNieWpxM1pQbjZyeHZwNFFyWUczWWFGODVQU25oeVpD?=
 =?utf-8?B?UVV0T096cDBkVkROaEh0Y2VsZUF0TnBiamZ5VG5KVmZDQkFhclk0Ni91bTAz?=
 =?utf-8?B?UENuVVBkWnhvdC9HaFhKbW9UVVhTWDFrN1BxaDVWQW1rMFRISThDMmR0ZGp1?=
 =?utf-8?B?QUlsdmZKWlhCWGFoY3FEZWEyU1krU1pORlFOWWhUNUYvTWlyM3BheHhsRDJQ?=
 =?utf-8?B?R281N01sd1lNQlNNcW1KU3R2WmtFQmJnR0lGQ0ZrZVAveUc1UTByM0l2aFI2?=
 =?utf-8?B?a042MzBjSXJuVVdaUGZxZmtEOHRVNWN6eUM4QzQ4Ynp6amZzNVF6QWVlclZ3?=
 =?utf-8?B?NENQZzZZWllDZ3hHTFpuWDZObWNCbWFZNDhDTDhlMEFjRFBzME5hWXRCSkt1?=
 =?utf-8?B?TjlqbVFpWkp6VHJnRkIzQ1dNM0laL01JaVFCUUQ2THFHSXdGUUF2ZWNLbElU?=
 =?utf-8?B?MmtZYkRmUG5vYkZWYm5TTkN1V2pMM0p2UDI1QWxNTUJUc1NoYzZVWWRLc0t6?=
 =?utf-8?B?UnZkcFpCd0tWanR3TU40dlJtTldaTDkyU25IQk9CM3VlbVFXWjRSUTNPampK?=
 =?utf-8?B?dXovajVxWVJheXdsRUNnb0M5M0ZQMjdINUNIa3QrN0lvWTVLV2VRYWNPSnli?=
 =?utf-8?B?RngvVlNGUVYxaXBka3pBamRVbXdTbWNzQjZTeThRVnZoZTJ0ZDdaRFFpWXJx?=
 =?utf-8?B?RHppS051d2pRam9Bc0l2akJoUk1YYmVsRWMzVmN4Q2MzbGt0TVlETUUzK0tC?=
 =?utf-8?B?eDR3ays0MDVHbGNXYVg1eU1MS3EwWGYvaUs0MG56NzNHLzBob0w5cDVNYlRs?=
 =?utf-8?B?VXh3UytUcUorUFZNMUV3YklWZzhGQkwrcncvN2R0emxJMGd0cnBkTGFoRVMx?=
 =?utf-8?B?ZjFSUVhxSlhKZlIrNXQ1clU4N0hIOTgzRmpPK09ld0tYd20yWWViUzg1Smln?=
 =?utf-8?B?TSswMWZUNnJEVFpZQk42WGlEOFBBM1psOXpua2FTeUJnMEJweDUweVN0ZXJN?=
 =?utf-8?B?ZDROMldKdUdlN0o5cUJMZnNlZ08yRVowY2FOa3htUGt0RTZYMnQ2WXZFcGU3?=
 =?utf-8?B?bWQwb2pPN091dGVpTzZuc1Q5VndSbU5kMjdjVGFVZXdqL0o2QjhSWVgwZFpO?=
 =?utf-8?Q?nWUmGNY8IXq1PorblKrJJm1hqaNZ3KJrt+XzCZMn1uNcc?=
X-MS-Exchange-AntiSpam-MessageData-1: N/qvghpu3QQY6g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c35166-34b5-4dc2-91b2-08df4b90eb17
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 07:43:10.3941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRdXAAMHYeXk/DyJGy1IgHQMT0Vv9ZBjSFzm2wS/qaOQJbmkZFyoZlgj0jgbGCc4UYDbwn0QOGzBdHW05T52Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521

On Monday, October 26, 2026 7:50=E2=80=AFAM Patrick Fischer via B4 Relay wr=
ote:
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
> tegra_check_rate_in_range() calculates the deviation of the configured
> from the required clock rate as (configured_rate - required_rate) *
> 10000 in a long, which is only 32 bits wide on 32-bit ARM. This
> overflows as soon as the two rates differ by more than about 214.7 kHz,
> so the check lets through exactly the large deviations it is meant to
> catch.
>=20
> On the Tegra Note 7 (Tegra114) the Bluetooth UART ran at 45.33 MHz
> instead of 48 MHz at 3 Mbaud (-5.6 %, see the previous patch). The
> check calculated -0.18 % and let it pass, although the limit is 4 %.
>=20
> Do the multiplication in 64 bits.
>=20
> Tested on the Tegra Note 7 with a tolerance of -500 for 1 to 4 Mbaud,
> which gives 45.33 MHz at 3 Mbaud: the driver now logs
> "configured baud rate is out of range by -555" and does not apply the
> rate. With the tolerance of 136 (48.00 MHz) it logs nothing.
>=20
> 64-bit platforms are not affected.
>=20
> Fixes: d781ec21bae6 ("serial: tegra: report clk rate errors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  drivers/tty/serial/serial-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/seria=
l-tegra.c
> index cc09fbc3aad8..cb5ef8aac198 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -380,8 +380,8 @@ static int tegra_check_rate_in_range(struct tegra_uar=
t_port *tup)
>  {
>  	long diff;
> =20
> -	diff =3D ((long)(tup->configured_rate - tup->required_rate) * 10000)
> -		/ tup->required_rate;
> +	diff =3D div_s64((s64)(tup->configured_rate - tup->required_rate) * 100=
00,
> +		       tup->required_rate);
>  	if (diff < (tup->cdata->error_tolerance_low_range * 100) ||
>  	    diff > (tup->cdata->error_tolerance_high_range * 100)) {
>  		dev_err(tup->uport.dev,
>=20
> --=20
> 2.56.0
>=20
>=20
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>



