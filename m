Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D2D3E834C;
	Tue,  9 Jun 2026 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992653; cv=fail; b=mefFMCr33BVFoFQ+PEoUyd03vKiLQUqqXF9rH5n2R85mZ6cxLvrfXI+pXIBoBTydUft4n81QsH3AMWcKHOuKqrb6EmBydIefflTlEeb+sCO4sZRr5w/4JsWTYl0futeNOEFnYZ6VpfjOA8tnra6FTNxlZNCw2jjLlP7xWY4Agcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992653; c=relaxed/simple;
	bh=mR4/hCVlmzZrtAAqqi5WW9cqD3FwU1WVEf3t7GkvYWk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ecWV2rTa/S3OA009VGH8S8IoTs3fNY47GMGiQOn7N+0kQsT2gkQlEYsKRLSit2ACzC8tfFUCoqCgT/NVOBqGb3PmDHEeLlB2Yrv3bgFV9VOaobRTrupvlRs6O2hGO6uIY2+5VTFMahTvFv3mRKCdd63xCLnqCQMSihQUizAWMfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=M/lQF1pX; arc=fail smtp.client-ip=40.107.130.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="M/lQF1pX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ypkkas6gJXlY7ESi8+hd+IAm0ZLwXCnw982nBfGIwGILVpDFi0UWqPO5Uc8MleE4YE+C+qBLWjvBeLN7qJgUSePT92fmlCAH/oHLD0CkdREpmSRzWV9AG5BCN2f7FlFYj1YvUywHrNmfCOi0HaKyss4gnKPn/TVMvgR127msOM1PcY16LDLj9CQ08WS3SGw75Bog8QI7D0oYpM5nFq1y6gEgZMr1Cctf1gqRXrGxaGKv5A8nRciWmaZ5MFlUTARwso3z/VjL2x/mLhYuFIcIlJonKVxPCDeXs5+ZyFgQSbtuvXJTHTrFXBXNW17unzIU6EN6lnzP2NGk0zenvdxD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2AN5xDfdsWzJq+CjH5/M8AenLvEs/+Az/xsZtRLFI8=;
 b=nHG2MeHrWLZYBrG4AJynyAGkbdr/l1mwzEB3T2XZ0Ptv/vg64mh6FcMbdzDfZ01fmUJ7KM2ta9HgDt8bLD7A3n0soiXMjCCSIwECeJtf5sxSovABswGjizZWHI5LDcV7w2BdP/bgg4DUbzCicBWsqYWKfUBb86BDM9N+x3CoRNZbgWwsj1sqy0jZHZXu00cTWdzXPnYKTHWa5cK+RtWxjMRk7Sip9QuHWlI56sxYp2kmTaatIgD9Pg8b1NeqrcWGXZxjoPspiSBB2lifTksYB/Ii2ofvBNv0SdpAIC+eq9NYhtgaTiHF0GylIA9T6M8UvA1grCdrIVTnftjc3RoVSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2AN5xDfdsWzJq+CjH5/M8AenLvEs/+Az/xsZtRLFI8=;
 b=M/lQF1pXavU+jhk3LsZUFhLlpHePFGff72Ko9cUObUOXJ2kjj0FH3nWeRAyD/ZxpmlzYQO+x8hckB3ad8P8lYbsP4hrnDa78NAE0m3KlA+LI4huu7WWWwdJ7VL0HYI+YnIJhpNiu2tawZkehCsUZRPT35lE44kgpbjfBDy8eK60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12016.eurprd04.prod.outlook.com (2603:10a6:150:335::6)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 08:10:43 +0000
Received: from GVXPR04MB12016.eurprd04.prod.outlook.com
 ([fe80::f2d4:9db8:9a4e:b0bd]) by GVXPR04MB12016.eurprd04.prod.outlook.com
 ([fe80::f2d4:9db8:9a4e:b0bd%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 08:10:43 +0000
Message-ID: <907fc663-6ccd-4bf7-906c-04f8603a692d@cherry.de>
Date: Tue, 9 Jun 2026 10:10:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: fix emmc reset polarity on
 px30-cobra
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: stable@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260512092225.34835-1-jakob.unterwurzacher@cherry.de>
 <3631825.d7IHhHJzqS@phil>
Content-Language: en-US
From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Autocrypt: addr=jakob.unterwurzacher@cherry.de; keydata=
 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
 ldPHIqbIwpfecQ==
In-Reply-To: <3631825.d7IHhHJzqS@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::6) To GVXPR04MB12016.eurprd04.prod.outlook.com
 (2603:10a6:150:335::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12016:EE_|DB9PR04MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3fbfce-b2e5-4d8b-3a02-08dec5fe99ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	XNKokM59vXiaZBXgBZye/fajqhuU0GDKKj+VUtN5hMmw4yCrS6ghWBSBnuyum7t977xkFfT1qdnGCAUQ5tt9utfNuA2HhAf/lrmoRT+DXkVIt4SYFZiO/blNQJfPTHDqZuUSNz/hX4lrtSopz5JSxsN/oBIl/2/5LaLc36QvSl6EKhZm8R/ISWqSy8vOQCAEtB+yXzltly2BvSAMJqVknJOri3j+wAxjNhS7j2PyovBUGg6J3fO6N9zPxn6qJcWdnoLPy+udvg65ARWAC5HM08GwDK0yhfQPl0EPo2zgouyEiLX5ZEN54Txj7S/UxibK03iPVXlk4B7i2FW4ryyeDgVAc6fxplSskFu3TIKavsqHd4mSfHmN/LaK43SDtchqk52vMfIx42Mz7zB+WfstRybLOKv7ipdLPQLlTkyCDPuF9/AFqym/IZ+ZSbKGepxPvQXtPud3yr+uuMGbXL5z7ruvkqr5LcXtwhPiL9Ts6aPlVcPl3jhHhxvP1tIPGnhUxrJnKoqXcGXv1seNKHtqyU7TV7JJhRZOaZhYDhoLRLOWJ4alyR86bMxk/NtdJYCoho4z/u4ejc8RPptoa42lMJGco5zPB/OaYSOMT/SArFVYRnVfV4WZo5AyOlngrS0Z3DyuDtw3V+PrEuio976kZ5n31ZC8TLYDNRsj8gvzlceqdi1lyjNo0Vljb7rD2HbW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUZBVkM2Z24zQTN1dFVhOXV1Ykk1bzVpK1g5Zm1PYXpTVlJ4cFVWZ2pDZ3lP?=
 =?utf-8?B?N1YwSGtBTFVXQW5EU3ZMclBDL0hZL2hLc1dpK01iOGtCSmpUU2xXRU5CVmZJ?=
 =?utf-8?B?M1BkZEV0SGorRW1XaHEvL25Hanh0bTFHZ2s3a3l3VFZtOEtodGhNRUJId2JF?=
 =?utf-8?B?TW5NUzBGM28ydGZXY2JJYUtKbDdSYnRNbWFBano5emZuQ1pqN1BGemV5QjVB?=
 =?utf-8?B?SHlUOUhTMU5IZk5Od3J5WFYwVjBwcU8vMEF1ZGYrTzErQy8rdVB1em9LMUNu?=
 =?utf-8?B?WjFzdlg1aktRY2x3eXN1UGNsdVZOZDVnK1BBTDY5NjhuUndyczRZZlZHak5I?=
 =?utf-8?B?aTVMU0FUN3NxaUJ6STdyM2ZsUGw2S1BSdUg0eEE1eXo4K3o4WnNYSitISlhE?=
 =?utf-8?B?YWhIQ2EwRjREUXFLcnJiZUs1dGFMMzhreE4vRWxoN1JVWlI0d25kdmRYUksz?=
 =?utf-8?B?VHNXZFc0cElTM3RhRzgvK05HYXpyK01qTm9reXV3RU1POWpleVRFWHhXRy9I?=
 =?utf-8?B?a3ZVN1hMeGRycnFFVGFTYUhZNFRZV1hGYkQvTFpQb1NIQzBNS3lvUjlYTE5P?=
 =?utf-8?B?TWpPOTlhdVRZZFFGc0pkN05jUmRWaXEwdWZ3clRSdjFUSUh3MHVUUE5SL2Ry?=
 =?utf-8?B?UmoyZTZyVEZKaVpPRlgwZkI3eDZTRTg5N0NqbC9BMXUrQ2x0Q3FaZ2tHbWg3?=
 =?utf-8?B?SDQ4dEt4Q1FyOG1VTjlRQThXaERDTlFSUUFtdGE5dEZXRG5yZWVpNk5pQksx?=
 =?utf-8?B?cmc2NXFnUE1VQjF4YnBYVWpZd1lxQzdESkpFYmdlY0lyRjhFaXR0ckMxd0RV?=
 =?utf-8?B?Z3FKL2hKOGgvZ2RQcG9Md3hxOFdZbkprUmNXWjlnUkpjYm1TTXJVaU1rRjcv?=
 =?utf-8?B?NDYyN0g4eGxSWk9teVNuUm1MNnNZcDhDQlUrS0VXQXkrK1dFL1lYY2dUZ0lj?=
 =?utf-8?B?dWFudDNKcXIyaEFURC90c3RNNzRSK1dGNFVFNGppYm9neFIzNHlmTDM5SUNn?=
 =?utf-8?B?V1BYMDlldGkyQjQ1YXN5NS9QTEhCSnlvVURXL01rMzM5b0pwK3MrTWx1NThp?=
 =?utf-8?B?TUJVS2tDZlNXWHJuTkZWR1IrNS9VVHBDMThzeDZnTkQ1aWgxSllwcjMzbitm?=
 =?utf-8?B?aU5TbU9hOXF5NHo1d2ZhYS9tQXQrN1haa3NVTHhlaFRaV014dE1YWDU1ZlF1?=
 =?utf-8?B?ZUlNQ2w1QWthVnkrUW5IRHdrQ2o5dWhuWEJLOUE3SE9PT0xSZ0txbjd5K1gz?=
 =?utf-8?B?SGJMSmxRNC9kb1cvMjZ2N2h6ZjJQOHU1RUo1SjZSMVdERlVTb1hZWVNDTmQr?=
 =?utf-8?B?dy9aVEk0MUsvNm5KaGZLb1djcmFEVk1FSno1QkpBS1JHQmZKZExzR2k0VGRs?=
 =?utf-8?B?OUtWVzdVTUxjWDZReGtoSkR2MmEzQ09DTTdPUTl1Rjl0ZU9vc3lLdG9SUGNx?=
 =?utf-8?B?VC9Xem1vR2hmb2RTQ1J5cGR2bWc4SFBtUGd0am5UbzAvWEwxSjRyOHpFYlk1?=
 =?utf-8?B?Y2pPVFZtQ2NNVEFxbElhdFBpM09IYTUzT0NTakluTEJVbDNURzBWSTlxdDcx?=
 =?utf-8?B?QWVkdDJjT2xIYXNndVZ4VEx3aVZCVzdGQUo2ZGNhT2ZBZ2MvRG0wb2s3RzRQ?=
 =?utf-8?B?Q3hzdWk5cHNjV05HOU5jNnBSaVM3UlN3eUcyVzRmVUU2MGNQV3EvMzRZWkp4?=
 =?utf-8?B?aE5OTTFxVTl2SzE5eEtJRktIUjIxUFlDdTdCNDUza1JDZW5VTVcyOEpqQVd0?=
 =?utf-8?B?anZFaU42RWdmazNZY2F5OElOcmpFMWN6K1dlNDZ0T2tnK2ZvRmFabG10OVl2?=
 =?utf-8?B?N2I2S0hhei9CNHVoN01XdkNkRXhUZUR1ZWpLb2l5L2dLNXUrT3J2NnVWSURE?=
 =?utf-8?B?Q2JCL25XbFc1a2p0cHRaUnp2eTczTDM5bUZsZHJXTHgwWEZJRVlXM2lYcEpn?=
 =?utf-8?B?SnN6L3RzNU9tZ0VWWmIxNG42ZzQ4WGJOVFFyc0xOS2tCYlc4dkNJMHhRZUlr?=
 =?utf-8?B?OVhRTC81NEk0SWJPNTdUT2FCQUEzMjN3eGVsK2I5VUtQaDV0Rk5VZ3VoOHVV?=
 =?utf-8?B?bHdUVXZ3ZVk4ZWVmbXljcUZGOUJrckNuMjU0Sy9zbXJoSjlZLzVQaExzdmZ2?=
 =?utf-8?B?WkpKVEVnMTBNVWMvN0dYK3JEWVFxblRON2ROb3lwL0xPVVVmbjZiMHhEbXFk?=
 =?utf-8?B?eHZLWEVOTktaRWF6R2srSkczTkozcS9aMEYvSDlGMzc2cDk2aFpYSVRwMkpu?=
 =?utf-8?B?Z2E4YW1VcENhVnhkNnBqZU1WNms4TmEyZDUwVUtOdzVQOVJoaGZibDVuYXJy?=
 =?utf-8?B?UDNjbWVqdzBhUStkOWttUkg3MGJ1TTM5cjZMZHhXVUk3M1J4ZUpnSEFUd2xR?=
 =?utf-8?Q?QykQUQeO7b/iYg3s=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3fbfce-b2e5-4d8b-3a02-08dec5fe99ff
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:10:43.0833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybxMaexcawJFSUBLe3IJDXt5pdG6imTqrGSGKz8ImsGwszmumZVMyRzKL4fCu43UIvG2yz+nWRWZxd3UNUZGW/qiGW2IetiLD8ovrBq/3bI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9451

On 6/2/26 23:08, Heiko Stuebner wrote:
> 
> as Quentin remarked, author (@gmail) and signed-off-by do not match.
> While I'm generally open to fixing things, when it touches the DCO this
> isn't the case.
> 
> So please resend this with the correct author.
> 
> In general "git send-email" will do the correct thing (that From: line),
> when patch author and email-id do not match.

For posterity:

What seems to be happening is that Gmail rewrites the "From: " header on 
the server side. git send-email does now know this, so doesn't add the 
extra "From: " line.

Making the final "From: " explicit in .gitconfig using

[sendemail]
	from = Jakob Unterwurzacher <jakobunt@gmail.com>

now makes git send-email add that extra "From: " line in the email body 
as expected.

I'll resend the patch now.

Thanks, Jakob
