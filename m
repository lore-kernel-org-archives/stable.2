Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793265127;
	b=pcJrMDxK7+z+FclaMWWcxvWu7R8ENKuOhYlHLCtnQfxTyCWyLZkT/XaUmFNvrcccPIYs
	 CqwEZ8m1cwrav/Vb4XWmdDUF3Ycy4Mop4UPIF1AFtGTn4nUwAR3HcUlXejHhXKGPbzJwu
	 Brb7rD7nJdmue/5EvnHnmQ3xrpgJbcyd7cjCBa3m8CWU2j9AGjt+be4cUxJiQqrUH4BYV
	 +qaoepy54SnMNPze8eJaaXgbYA/uLRiC/kSzjmqQd1/bRcOT+GB61hCjY1iJAgF9O69s+
	 6lsATBJkO4UGRYvaQdfs+It5ItUFPIujOpKngIuULnYeezUSL8J61c13reVzXqNWvsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265127;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mOi7L/CJj98RrNYlgqG1dcReZ2khEV26UPujjk7eeF0=;
	b=I/S0ytQqObeXP+/4C6V8kZAiVzZys7d6RNCQNIhiIpgR0+wMHZEVcXZC2SsbLIDBsorp
	 ZvH951R4dI98faGHeVy+4EdQErNDuFbHr3aCCR2K3iI/m3/jGqU16iuoVXfAz4TIa9Lr3
	 638G77MZkfPdgLeotZsBpqONu0ZK0vofrjAAnJ3DzusCoAcv3IM4YGDZy0a26UNSv1YVg
	 quzV1X9P/+FuxVEIb4zcBAo2XyFROPK9EvxH8YTzG2KZ207a/ZWaGMa86igYvvMYV2Zrk
	 pBD8lusAzndHvUR4G+UxGjVR6ncN15HhExUtBfVXoedCOmKl+7+7dRWqPty/IQiWb5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=D4otUWAY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.34
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B4606A31C;
	Thu, 29 Oct 2026 09:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 480B4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=D4otUWAY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezblIPAAr75cEgWoGnoidUFMFyBuo4m880nK5YGn7y0NdST0BlV2jWJdMf1OnErBgPet/CHZ1hZh0t0TSvCqNtEPNoqPMDwXnFDl7TjoW3Xzc3InoDmEQJxbmL3S7yz9wKBiyBAMT1QWRNv1vby+CpH5tqGIpubhmnHT8S80h8tI+N0Ze7ag5tW31cvB9D1sSt9XFHTX0suIHaGp8QuI0BnJeJntz3H3bWHAd56fWTJc630PVce7+frimgLg10sQxuOAVhvxr4LbVgYRF/0PC8GzJ9j0WNKHyQ94lpTPZqQSYfXRYTC/hO2iuzrWIfMSU9VQtNAsy2fFEcrxORHLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOi7L/CJj98RrNYlgqG1dcReZ2khEV26UPujjk7eeF0=;
 b=CzDMv7PZQ5ALBNF5Ne28GRxmAzv7+0h/MywX9fb1Vmg0+09EIeeHjFEwMVtTGEP+VjRwwlk3xBDLvrqXsdLAr6m9eZ86/Lxy4PFaidO7whaMxyLT3gqZ1/hEWYd8UPRItoIkDMPxXS+gsv7gI5/NxH9jhOFmsLjFpFeZ+6YYxQYDq9SrlstG3gaK3zRSj+vUB/2r3bf4MO0qzThg91/wWhfMAJxIRVhvO3jIghD+I99S0OfU9aj0eeGW8sj0GvT1Q1E6RS6jikFYjCCRFbUr3n+1Z9s3Gr3NlMJa4Sg/EYO2YxZn8cQwiE0/InKfLWGlw5EZqsK7Y3aOzsSGeNCxKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOi7L/CJj98RrNYlgqG1dcReZ2khEV26UPujjk7eeF0=;
 b=D4otUWAY2iVz61OlTEhHOZwvC7Qko4pUW83q2l16p9GMYdD77Uaw+A+hrTI0VqPDUbuXBn9ieRAGfgXb3LtNiyJ1CTje9OVs4PCBu5iRL9jteNmY4xM7A+Uba9Mlx9RLP6KbQZkER6JPThoaIvBtbjlLtvhQiB5NDbJ0q6sCd3XXig1Xx8Wpl9SBHsn/P8O+hxAXvtxgRGCzvKtVDytBtMEYWcwrfewS+ciTUy/zzRFpbcu6xkVy1ac8aR6diVSLpLKgLxb8cVhEKg0uGRy5KOUMfduuDDxZdFP57qVGMCON3IR5nqV5eSfc0m3SZlCnnu5Kn93Ce2+j9Wrpg62kLw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 09:12:01 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 09:12:00 +0000
Date: Thu, 29 Oct 2026 11:11:50 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Petr Machata <petrm@nvidia.com>,
	Ferruh Yigit <ferruh.yigit@amd.com>,
	Antoine Tenart <atenart@redhat.com>,
	Seungwon Bae <qotmddnjs@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v5 1/2] vxlan: reject adding a remote to a nexthop
 fdb entry
Message-ID: <20261029091150.GA1187348@shredder>
References: <20261028111626.3460759-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028111626.3460759-1-bsdhenrymartin@gmail.com>
X-ClientProxiedBy: FR3P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::15) To SN7PR12MB7954.namprd12.prod.outlook.com
 (2603:10b6:806:344::7)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 7020a409-c8a8-4f18-2b95-08df359cb01b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|261028144727099003|261026140227099003|11063799006|56012099006|261022105027099003|261009223027099003|10067099003|18002099003|261026121527099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2HOv5d/Y7qRpgBLDrYHgv4MVdefupVinSNtrJ449DawjQNhG3NhrmM0thJnxVwE001xMwhYwZBksJ4K3ZhUh6uKfp7w+pUFSDnr6zPmDey1rw7YqGfZO3l87x2/1OpnrOF2wGW+ntMK8zZJNS+HmyNGTzXuduxLYW0miSv5DC8+04i2O20B9UlYT3klHcWkbn2qJ5s3CXfCLhcnbppg5MzsiRY6+lk8A4IAGP+WN+d64SH2FuDRlUbYWSsqmMUIwED+ska9HvIymeWRx0lEE71pd2V9IMYADefIPGlat2zzqyGUhN/MGFoFyjKmiystPaNKE5JMeXNzEkppiK9jVS8dUg0Q2p5QKWGZpFt+d1gRsqYgXbjHhljCJugX69zGy/+Yd9CZ9BgGGO1ipDJ45ykx5wQ5f7oApDtosJocyIHMzj+UjUPbR1Y0iYDXN5x1xvGKG2t+kM/vmpJT7PExyJRuIfk5B76FTmPnRaRyErKXCGK5eELZ77II5RT6axKkGgjdjNHr1vqiDyApbGeysTZ/eY9eW2lkGYy1EHWEDlTIypF88wrqk50rqp+l3itqGZlEHZJBrNmbIkyvzMe7NQgRue/gnpGgwcxX2/p1NBzvwFD+OJEnepSl267qZmeG/tdMUSJ1ZmoHu/ExMVYWjwzBcJ6pQw2Qx95YOixsEcwo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(261028144727099003)(261026140227099003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(261026121527099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mMWbfJTtHXM4JjhRVIz84Dsuf3RMWu/RPE+sxqv2TCR0DSO2Co6QM3dIwYYk?=
 =?us-ascii?Q?kqff53IKUFtPBnY2Vc26ZTIPpyF15xu16pAWrQggxBvcpZ+TghENe98Kixv/?=
 =?us-ascii?Q?YWxLLteNzulwZ5New4hY+L1wHEVqn70XhAV4pmQAKbtrZecBajHhDINVm7gX?=
 =?us-ascii?Q?4y2Ud6SREwGs8pSpMU2sfkDXWSLcIRESX3Q4vTvbrOeRbqeIf1P5f12sPjx+?=
 =?us-ascii?Q?ur+uWEYM4V2ZU2vKVx6NTvwqhXO3NZ/aHKlByu2pEF8qrR2o8UgqVIDBM1LU?=
 =?us-ascii?Q?Hx1sYxkMwsy/l87/UkXqgeoTgfhBuouFhOwpCa9ill7cNL8gTFCxQzt/ANDi?=
 =?us-ascii?Q?crOrlLodlapGxGEhEEOJp7/wfZr1KBbBUQXJkeZO/8tNUIDOE1R17gWCTO+T?=
 =?us-ascii?Q?9tVXy/ql9AqJ94AYXV9Ow7ET5ie7xBJ938nDd3sLp4ruXSelhmEyGi4TW/Z6?=
 =?us-ascii?Q?ev540tE7EHIHD3DKaKKyBeShN5ISTUWEXOVLjei5ZxLAXqnSy1aS2TygJgFl?=
 =?us-ascii?Q?DWVssPdERDVuQ6z3Ytcj7YKQ3TLYF04G8zJpSD0OEo1pZblJLMAa5NJlwFHm?=
 =?us-ascii?Q?VQa4Mel2aeoW948IiuPiBEeanZY2vgLNIcT+MMm+U9cqnQdJ9Z4LOIiGoyx7?=
 =?us-ascii?Q?gWU1cdfp4uS+S8qEH2JsJ3kag/NBi8yErG4dxScrOnhDPIYAoHvHb0TnfG23?=
 =?us-ascii?Q?oKvKVo9n7VlvUBzi5fWiwSDF1ToasuSJ4UxoANaAZq2rym6vn9Nx6Q9/sTeI?=
 =?us-ascii?Q?f+j0AJLXfF/4ZD5gXNWthuVouPtEDrGBniN7CW0wMSpr1a/z5GMMMBdXs4JR?=
 =?us-ascii?Q?/z8Yj4wULL8aXe1aDUdju+hngKaCCPY1c/PgPorqGoVoqNZfQ1k6EBMwU3jb?=
 =?us-ascii?Q?u71NWjZFWFclbaMzN6h18+JK5udu8WBMsU+4OMSRSJVU54bQTv6X+IkLTMH+?=
 =?us-ascii?Q?iyi+SgvAlg/FiSpeYARBIBfUkD7IzetLTA5Khgdo7GvXtOrsx9yjRPoJOaaQ?=
 =?us-ascii?Q?iLHKvZActQFPL0u0OD1cclKf47eoR6t2o9ZtkR2UkVR1QTrzOiHT+8iOyPeO?=
 =?us-ascii?Q?LHZ3VOJPT7D/Ole5pXJV5Qv0WaXl0QyV9s9iv1TjxqpbEsEoGW3ii8v8tykG?=
 =?us-ascii?Q?30uWWvx86hqrFWEFYlfWCkbl9IK8FvkX2eGe9JAcnhz3jIWD4WzOzCTGRm1A?=
 =?us-ascii?Q?3UsaRaOimBlD2g4Xe2PBkFhfMl9csQOyat2DQ9RNurKeCLalk7kNHG/S7u9G?=
 =?us-ascii?Q?VjzIkhg5J5Z4GiDABg0enKF7JDC060slLVw1olymLBSDGxi5xbCcSKV7Ci5i?=
 =?us-ascii?Q?ZVDnbfMGkhFCb5M02B215VmOWlQsjmQDJNZqHdwlmW7ZWiu9/2xgx1TCy3Jr?=
 =?us-ascii?Q?OUAmH8xNOgvLFhMIoL+kjtRSqmtrHDyxCKU08XaJKja01Il8lzyQpnotsRQB?=
 =?us-ascii?Q?WlZU/4UF2Kk26cXa1f+5kh6P3IgPkhJXyB1laWsRIsPODqFQ4zCwJe8xcou0?=
 =?us-ascii?Q?j5UJdLXUqXq0GoiVEIeCxHp+d88Rp4L5Bh9zvjByB9tUF9756eSmvgQIARuy?=
 =?us-ascii?Q?grPEt5wHlw0AxWGX1FM897vvE4sqBnBzVyQC13beB7xgP/yWhftZo00k9KCd?=
 =?us-ascii?Q?Q8WukOnefZ7V38yeeLRwArSO185gbmy8dE9K0ikdNGIvpPiHEBg4l0CCJgv+?=
 =?us-ascii?Q?hnrYgqCDWhFBPhrH+Qo/Vx5EoLyq8yEJSg/Rpv3zFXs5HyKF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7020a409-c8a8-4f18-2b95-08df359cb01b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 09:12:00.3175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aO0kjkyv7lFZUe/OfqDWe66N8Bp2uUi7ymfS6UOhM7kf86bDf5+udRZttOcQoTvLApfhAKBIgSslhkEEUTUTLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652

Thank you for giving me two minutes to reply before posting a new
version [1][2].

[1] https://lore.kernel.org/netdev/CAEnQdOoQRuH8A=HnJqruN_kp5exzTwV7bK-LZUVo=LGuSMmgNA@mail.gmail.com/
[2] https://lore.kernel.org/netdev/20261027104713.328028-1-bsdhenrymartin@gmail.com/

On Wed, Oct 28, 2026 at 07:16:25PM +0800, Henry Martin wrote:
> FDB entries backed by a nexthop group must not carry a remote
> destination list.  vxlan_fdb_update_existing() currently appends a
> remote via vxlan_fdb_append() on an NLM_F_APPEND request with a
> multicast or zero MAC even when the entry is backed by a nexthop,
> breaking that invariant through three different callers:

BUM traffic should always be flooded. It makes no sense to load balance
it between different VTEPs. Simply forbid the creation of a multicast /
all-zeroes FDB that points to an FDB nexthop in
vxlan_fdb_update_create(). This is net-next material.
