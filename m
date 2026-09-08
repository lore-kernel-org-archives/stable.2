Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013075.outbound.protection.outlook.com [52.103.35.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C2D236453;
	Tue,  8 Sep 2026 00:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788827862; cv=fail; b=tkZBuKmhoutQStfQb18bNDlt99p29q7sHGH9Ok19y+6m1I4HntOnR18DCCMERv821/k7/7Y3NpvQkUa/bPPHqtyR++OjlHukg4hLiSvmmMoypJkOk4+AnlCKtAk/fCrTq1tzMuYAmv4eyQW7Yd2Cqp7K9bJQwfqmC21wQpb0D4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788827862; c=relaxed/simple;
	bh=3vEsyMQ7eGOndikDoNWrz6HVuEPrBtEDkJX6Ka44HAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gbPceMoUjRgN1hD6brYCSKldO4N72yKaKnppz7qSw1hEbZY75smsF1ohXtRcdmFFQu1FKfKu1miMQbAZh3jj8nOdhC5LzV0s5aN1IDiqQkqyYlRng+NASO1A4Yydx+DF6l/1s26Y+ROy88gHFOIppHsWje/v877cODHOAz9RGiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=bkL712nm; arc=fail smtp.client-ip=52.103.35.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="bkL712nm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSRK5svPsTXVBIYDvjra00i0twOCvtb7LX8ZU84R1r0/G3HoqTwitmjIp06vNTyDnqaB2XpFwV+W9U90xQzA574gK0ZgNgd3C2dlmZf4u0Bj3bS7BWMsVljj1ZHsjrYKf1EH+qAh0alhlG9jl/+91gLe8O5H01PVJUqMTitWoQz16pyP/uvJhCmkxHTiMd52YdDqxF160vijkyI4guahNCnmr5J4NDwq31JLRP4GfZaewGVBbJfnV5qJKuYJk06tbSASWZYGaQ07C3qEJp73C4L7fXBFZv8H9+li0EDqJ3ENB901rXUBhmHJYKw5Rk/wfkzCJC8ItXeKmZXvNBN1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Tbepygo9CWY3z0r0gwqjqA5yxr5A2XSXl4aqwWNin8=;
 b=LG2heLhVwNhkIZHfaZfs/sOv7VjMTQEGqU6ZWHTtjWm8Tn3vk32syCKq6bqLqF+bmCM/71trZAFvx4+OpmaQfOXMHxkWwrmYO+q5xWRjub59Y+o4w+GnA0m5BqRRRzOEHOfQ02WU6ayY5ZQZepFPtU8yIdtX3MECZiso4ol+UP1npuxEc1SiK4jwi5oVx5mA15uUexwmT8OCSDUOME/V5vIR3qXBDTrtnqN/UdsHRBHa6d8dvq7fq/5/pjZCyJ9AylMGDSRIzYPwSEHl6kZhfZRCv7k0R4sJheMMpEhU/+E2uQUUu8/x/1U6PxJ9cbbvoCXpjSUG0uoAD6NADONSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Tbepygo9CWY3z0r0gwqjqA5yxr5A2XSXl4aqwWNin8=;
 b=bkL712nmf7x6TfhVsLK0Cxl/3cvydDY/NOf9hTpYpVk8Y9ZeQO+qOin1wDnM1Gw0cP65HEP2kqtun3KbluLAHAAoC12s/ZVZdFfg63i6/BO/m0XkVxEolyo9sNvKCJouPPdEfUZi6uv7hNWKROSdiT/jsgh/8QSk1Hg5qKRgzConOyJRCrTaEHr8VrWLLPPRDyNkIvIdIYIG4HDyHC/kj/0QL/IrDCFXDsf8jSuZF0g6HzHx9hABUjIeYVeibFbSoexWrk4WHo7cdoAohbneqdGsHhpH9Mz3ellmG7URl4rCS/c/QiAj44U7b9HhjC1t7TGHLm1k8PigsmgumVq7mQ==
Received: from PAXP251MB0010.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:1d9::15)
 by AS8P251MB0036.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:34b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 00:37:37 +0000
Received: from PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
 ([fe80::fb91:30d8:e31d:1f35]) by PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
 ([fe80::fb91:30d8:e31d:1f35%4]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 00:37:37 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Aamir Ahmed <elb12345@hotmail.co.uk>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: wwan: mhi_wwan_mbim: validate datagram bounds before copy
Date: Tue,  8 Sep 2026 01:37:32 +0100
Message-ID:
 <PAXP251MB001088904166C3D6EB0025C1C8B12@PAXP251MB0010.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <CAFEp6-1QNj2a1av6inPPD-Kpg_c8cxzNgEf+rq8Q-GhyS-+Krg@mail.gmail.com>
References: <CAFEp6-1QNj2a1av6inPPD-Kpg_c8cxzNgEf+rq8Q-GhyS-+Krg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0023.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::15) To PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:1d9::15)
X-Microsoft-Original-Message-ID:
 <20260908003733.114695-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP251MB0010:EE_|AS8P251MB0036:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b845428-7f40-4a5c-073d-08df0d416117
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|41001999006|25010399006|5072599009|15080799012|2604032031799003|12121999013|37011999003|25031999004|8060799015|19110799012|23021999003|24021099003|55001999006|40105399003|2607281247196008|12091999003|440099028|26104999009|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g3GfgiLfRQPsqBXPgsqcxm9RMsFJfRl0XTsMWjIoWbhewbawBWtbRAth8JJ/?=
 =?us-ascii?Q?y5HFst4/jBYIq1kvIS1TGo+zN6YH3CqR8IUhLR4HiOIqf5aeuiry8eIDfwXz?=
 =?us-ascii?Q?LdrzqEWDUU+RVNFp28F1HOayzyL/2fdqPiuUUdYrMTn66pOtHvVPnIrYgpR6?=
 =?us-ascii?Q?c4DopYyX5z3U4ThdVSqppDZt4gMOl0ZndbPjThPrdYQq+B4wXZd7N4Anu9ea?=
 =?us-ascii?Q?OrFSFVG+T4gw0zCJnA9b3Q+7MJxlzDKp9Ba7Zx9mPwIFUgJMYrUlNdz4JkGg?=
 =?us-ascii?Q?l+So6/i+2tqfbVQtIBA0NCB4eZTfvTWyCDnGVS/yvYflQLp+HgLu+bO5CLHN?=
 =?us-ascii?Q?Ed0N68MCBhj7N8pRH5opPOZyVEOfSqK/jU/gDWj3E0MLV/03OZ2mO46gFKzm?=
 =?us-ascii?Q?2K7B7Qz3ddY9zPVEGxRF/dQsb6gbTYpyjJU8+iUS41bswiiOLvYXZ+ACf3hR?=
 =?us-ascii?Q?sQvrs7GgWcU6NTeUvGZKjJwt6fFA9U6sREvh0oTzpaW59Khm6HotXFSF6Uv7?=
 =?us-ascii?Q?c2Vf+yyZ6nIMSrLRMQvcAZVSA9hJnSf42RoawLeB53iyNJFqTZCK9ool+ijy?=
 =?us-ascii?Q?6W3L3uayCeOfZiF2dKnAFyZUPdXIsI9kzpbRB/v0fEl/EMR3v2Tsc9iOd1Zp?=
 =?us-ascii?Q?wQPckob6jWJ/GT8iUxCSjtyvPUPlt9NeteCSMvSGHZVuU/RKfHMaK36gj6Ed?=
 =?us-ascii?Q?dcZoc8x9r+uc/bBCVMLSWxPiW8NLBXDDYf8sdOzsAH6RlQgg647tt4lgZYSv?=
 =?us-ascii?Q?IbDHsfKqcMhau6Ns5woPnu4J3QFdYR2JIcVUprN4a/9OaXKJT9hMElPSnAHX?=
 =?us-ascii?Q?pnFuQL7Oajw6ZbxI0/UrgrpGAxmaoQY4PZug7g3GgSUhgfd11ZYYv95x/dFc?=
 =?us-ascii?Q?2Tqo3slfTSDQgN8S3NwbyKehEVzZIWPVhNDAbi9G7CFMxyRMukLdsBJMUTJ9?=
 =?us-ascii?Q?rXMOhOsN9fYbsyJKSZYHwm5sDbkGCeIstIp2tcpGPhxJc/sH/y1Or7VrjQ1I?=
 =?us-ascii?Q?aUjG58X1c5IRqX8EkpOkfw4gffwWYKLaw0vktfJ8CigKkWKOZivLGBpuurKd?=
 =?us-ascii?Q?ngS2KoeyTFaBUWNM+px0ZpDKUMaG149h0pXh8WzK5xbfOlZjAY5OqyoX3Qd8?=
 =?us-ascii?Q?XxLMiwqR+9D1p4upFoX3q3xDcNnnJ8YNmSGG3Y0qedAZlrLZGKbwfjXJM7S8?=
 =?us-ascii?Q?GM13T7nK2keOUPiqocFhjZ8VodQMLcAv35ugQw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?43Xm8aJXNVAHPV7hsQqsl76JioTt++uh5Xj6LRBxweLZZ9J6KOyp4QhawXkJ?=
 =?us-ascii?Q?qBmlvrQLXld+oJFwBPewpLf90aalG1YLqSZ+jfnMW+tleMqy1Be/w/RMh5pv?=
 =?us-ascii?Q?ecFU+VGkTBTbdl/K/R69wiZL3tvZjFRJc9ObEF7a3/JJ5pcq6BftW39z81ng?=
 =?us-ascii?Q?UFKXO7W0hiH/HVLV7M/pqy/7VeKPYLEB4TfG+KhjLuHgDFVJSBeTbPRCgGiD?=
 =?us-ascii?Q?Dvu4Bg9Oakg7GowF3xRVr+id17iY32K7g9nGVQO75z1K1x3ZxmBpDBSYleNx?=
 =?us-ascii?Q?reUDLIeXsKBdWbcEBkvplNrffJsKrnsnPxpvYaqEzrreMhQ0/mH4+fnxAaBt?=
 =?us-ascii?Q?Nwg8JkZry2o6naw/V72Myn037bTvpBgHGcgPn1hf+Xmt1sskRFmzetOZgyPj?=
 =?us-ascii?Q?+JPxdacK9XmE/hnQ6iqok+P4deyccYb8aTU9EjjoLvqXhfe2Zj9+avBTps+3?=
 =?us-ascii?Q?d5B9uhlaxWIv6iYWsV0YjiRA/HdRIpb4knr8NNiaBabHjooPVqTaodS7b1lh?=
 =?us-ascii?Q?MfZDDVPeDYkD4XXEKBdLdmulMLsYM6Ncmcr4O37C+Epxe7Yfbs/8RsX+5GLP?=
 =?us-ascii?Q?qil9fQdAqhd7s4/CT5AfYlFW/Cl3XbX5f4i8hRiEjJW5O8LHinQ3S98WlRhc?=
 =?us-ascii?Q?VZeTa+iWpE4At0oKz/CY/S5PDT9zAfU+B4GT9adfjVZJPQRnnEssGOXOOR5B?=
 =?us-ascii?Q?Sm9VAmd8vjlITS/7Q9EPkIXsOqRXy/v1M7Hup4YlbHmJbiYtf/b0nVS3fEkv?=
 =?us-ascii?Q?F/AV/q5RwcCMbSoip/LfA+NDwfYNaiY1FOUviKwkD2Fnq7C+GuUHOYDyPjUk?=
 =?us-ascii?Q?/+tXQV/P/kVB6+zGwVI3hwa5BIXk3vd2PodajbI1KNRnDsGUxCsETaI6sFtR?=
 =?us-ascii?Q?kwVy/VMtqLRxa54TabSY+E5YUnLGcekiHlGhGsWjzBEJQpK9I9zdXXu6mkD3?=
 =?us-ascii?Q?tHXkVjPnOc8bnf/NLAl4pMsHV3wYJG7EUuTF/daZBGnio1jGkYBn9r/E7ITQ?=
 =?us-ascii?Q?7SB2rmnu5wNbFuQCbwYDMqy3+bmNaGQARKfP3OSeCz4JhpAMK1qOrDnHEoid?=
 =?us-ascii?Q?e+9L0bB1RU0kKjbUBeaIrg58qU9Z6nfuY2b4O6wbMGczEl5NQ22sEfSBuhX0?=
 =?us-ascii?Q?BDqT/3cfIZRx8gHVGZVckwMQ4GNFXID4gmfARaqWVls+TWi7yr+dFoNaSXHV?=
 =?us-ascii?Q?82Jcn4JmmaJEWTbAieLlVmL7DINyQaxkhJMbJgVGd3znJKYkQPJbnxQPRR3X?=
 =?us-ascii?Q?4OWUYZC28Qxl+Xlz+7LtSaXljHyPE42fMrckKt2wnHkKFe6vNEjnK04QOtse?=
 =?us-ascii?Q?s0Ix0ljaANRKYyE7kDVT31Nq1EJC61Num3weWKOec3bmhTdvZfHxvybt6Zgc?=
 =?us-ascii?Q?/w6LNTwjmRoudPAYqBfV76UMRSxnshRXGGGk9wyDs8jeo9MA6VV6Kz2/fN2M?=
 =?us-ascii?Q?J1u+kUa4DXfGpVjNU9CnwxU3+H5eNYD3?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b845428-7f40-4a5c-073d-08df0d416117
X-MS-Exchange-CrossTenant-AuthSource: PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 00:37:37.4744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P251MB0036

On Mon, Sep 07, 2026 at 09:57:09AM +0200, Loic Poulain wrote:
> This seems redundant with the existing check in skb_copy_bits().
> What would make more sense, however, is to check the return value of
> skb_copy_bits().

Yes, this makes more sense than having to create a new guard - the
check already exists, the driver just ignores the return value.
Nothing is copied on failure, so the skb is delivered entirely
uninitialised, not partially as I first thought.

I will prepare v2 to check the return, free skbn, count an rx error
and break, as the copies above and the unknown-protocol path already
do. Will also drop the cdc_mbim rationale, which does not apply here.

> That hash doesn't exist.

Tag will be corrected in v2, thank you:

  Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")

> Please review AI-generated fixes carefully before submitting them, it
> will save reviewers time...

Yes, many apologies for this! This was a clear mistake on my part. For
the future I will be more selective and thorough in my patch
submission process.

Kind Regards

Aamir A.
