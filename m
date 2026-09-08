Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010017.outbound.protection.outlook.com [52.103.33.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07B3403FF;
	Tue,  8 Sep 2026 03:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788838594; cv=fail; b=lvdQy5yEsoc8EmsA6cGy4R/TKpuvIhRqvN2sIfnx5obvvLGhTYEl4h9664kC4sHuSCB7+wUAL4lwuZU1FtsmS+iMVH1IcqkSbMFFzD7Z33ljbXhrOHzXCQ7ZlC2RtWhjuWjoTjfrU2cbVJ/9rqOPiZMEhHYHLsK4GDXRo0nCuZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788838594; c=relaxed/simple;
	bh=BPUdt2S5/u1tMNwhFX/H9yz42UTEiUATQh7yPkaJesQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1JakpoxB08fBobA91ezIdB24H+HZZVzi0QUuIIzgW1AXg74X+oyMQFuYfqFYvZ0NgzAZT6IGgDS4FEG6QXJ6a1WDfkjw5RF/uhJbBGyo12Z1WU5aUjaCysnjQAWqoXyP1RUBPbJH9v7jfsOWRF5dw2Uxjh3Z2ignBz/2DPmKno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=b+LbJ2F9; arc=fail smtp.client-ip=52.103.33.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="b+LbJ2F9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOAIzvEq3vb9bSx2HL32NReWxUSr/vz3ZpxsGOycSC8FGy2Ni8pu6ZgmpMQJ2Xy5+ZtJrb/SySCiCboQl2Ib2QXgBEZzIjKqafBK6v/1v+My1pr3LHrgIqwD7dA/c8qsiu9WwO4rvUJ8P2sF79z66ebweQWkBrgoCYiVN/5F6Xf83GyB7Z51KePdsA9igeO33BWhgO00wcbt2qFvqF9dDB3Vgzh/uFhxkMqXzVFOXNmuJ56P9X2/JwiyOWkWYd7wi5kn5aOeEg/ItcOmgY0ULLsJ7+6QDugYFxLf/YFYe3bdE+1MzDpoJJYC4e2/WwJ8lQyJAv7r2SlLSnTQiKdUXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOkaGA6q0syuhWwpbHcZA3LgreHGQfyjmEwRqqA2cqk=;
 b=KU0n47RI7Ts3uumLnx9OgjQ+6lt4dAWRWxZjHhRLvGEec8vsGJcO2YE/jYviE77dIY4UWF81hcqtboEA3JkWX9FI2OH1iY5CPu2CAYME+XvKyr9EZR+JkygcvRgcpsTalMeQ3Y06GXRCwpMicxud7vuM+5SXNMwGfmmlc1E0EoV6AUOGp1Hk1ZBOZuVsOy3BCB3WbMZXjkmjmhpIKOlCFl8keGojiGklTWl7Clk4ZTRZa3CZZWT559lmJUG8MdVa3VjClU8hEHdnOXo9ntqNm0D/bCSRM604dOAlHqs8V86Vd/s5/mnweZqivVUZwAfEOk0bhb8UmSIdU4RhwZlm1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOkaGA6q0syuhWwpbHcZA3LgreHGQfyjmEwRqqA2cqk=;
 b=b+LbJ2F967OuyN365bEdL+HKEWxpjnDdVAEqnmqjX0EYpiaApyimTqUW/hNTtOdTk+y+jz5BtSNeKGyeAnoqntJu4rO6l1z5W3gA7+Y3Mhi4C5SAhXdTpLeBTb+t4+oAO7b542j6V9eNLQTiR2emhdLr6WlLxW0RJElDx+gnbYGX0jxr1TJLsBc0+eDOVLrDg6oSYNon8JMN0StIoPQw5ul40oTKoUkCcr2dLSf5KrI2HkXoifyLV/7tzbLYGZTM69riyxRg8e7z7o6AKZ+wsv0BcdZaK3+zJbACTDc0f5gTaqujPmWpWTx/Gt900RkbMV3S0th7gaF7Oyb3JoWoHg==
Received: from PAXP251MB0010.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:1d9::15)
 by DB9P251MB0016.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:2ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 03:35:12 +0000
Received: from PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
 ([fe80::fb91:30d8:e31d:1f35]) by PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
 ([fe80::fb91:30d8:e31d:1f35%4]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 03:35:12 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Aamir Ahmed <elb12345@hotmail.co.uk>,
	Peter Korsgaard <peter@korsgaard.com>,
	Dean Jenkins <Dean_Jenkins@mentor.com>,
	John Stultz <jstultz@google.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: asix: fix off-by-one in rx_fixup bounds check
Date: Tue,  8 Sep 2026 04:35:08 +0100
Message-ID:
 <PAXP251MB0010B79D228ED25E09D83C8CC8B12@PAXP251MB0010.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <AS8P251MB00014BB4591CE6011152DB4FC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
References: <AS8P251MB00014BB4591CE6011152DB4FC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::19) To PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:1d9::15)
X-Microsoft-Original-Message-ID:
 <20260908033508.125132-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP251MB0010:EE_|DB9P251MB0016:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d77f7a7-8d56-4006-09ca-08df0d5a308e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|51005399006|25010399006|15080799012|19110799012|8060799015|2604032031799003|12121999013|37011999003|25031999004|55001999006|6090799003|24021099003|5072599009|40105399003|2607281247196008|440099028|3412199025|26104999009|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVA2WjdPak9pOXZXQW9LT1REWmZYU3ZiWk5vWUdtTWZyL25NNmlKbHNkTGpP?=
 =?utf-8?B?eDgzMldmMHAzcDlwclVKb25PbUZxRjVuMEpLM2RLUkhjRG9YNjV2bmpJUVdi?=
 =?utf-8?B?aFhBaVVGTlNYZzMvUVVTYW1ySy9LNkcxOW9ZS21YNEEyTFBDcE45MjFHZkVs?=
 =?utf-8?B?TE41dmgxSWJjaEhBUjBTbGliOXVhNkIvRWRsVUhPR2NiRlBranAybVZXM3h3?=
 =?utf-8?B?NWRkek1reldwTGFNYjcxd1ZjRUR2cktXZGFQUU1PUVJOWGhQU1ZUSUpkb245?=
 =?utf-8?B?N1NlL3NJTGs4SVlMTEhrOWR5VjJEa3lOQmc2NDFMTzljVzhQWU5xNmRhVzA1?=
 =?utf-8?B?N0s5a25wV0dXcmdiV0NBeFg0enNrZXVVbEhDMDVZK2dTQkRqeCtHOVlyQWZ5?=
 =?utf-8?B?eUZIdXRNUndaUUxQaXRUNm5RN0xhTmVUL3hLejFyQ2MyOEpFL2RHaHRaQmxO?=
 =?utf-8?B?a2twYiszZDFVTVBmd2pPOUZ5dy8ySjJla1Vuak9xc2Q4VGd6VHBtOXA0RGpS?=
 =?utf-8?B?MjB5RFNDalJjcnB4cWNEVDdBdGNxVUZoaUFMRGc3QnErOCtHejFqd0lVZEc2?=
 =?utf-8?B?em4zTXpUcVBZTENvb1cxSDBIVzZSYXdsdDN3Y0pTalQ5ZFFNWk8zNjhsZk4w?=
 =?utf-8?B?dmVvNWVwa292d0dxeWtzbGpLLzdBbXV0UFhZK2REVyt2ZzNnUE9ZQ1lFMXRU?=
 =?utf-8?B?NGhpS0J0S3U0VVVlNE5wNEY0RU1jWHpkTThVZVVSdGRPSWFTOXZ3N0ZQOTFq?=
 =?utf-8?B?Umlqci9wOEFzcHgzT1IwQnhxb2F1cEx4V21DVlFoRFZpdklQRnR0OUM4c0p6?=
 =?utf-8?B?Q2N2bnpZVWNRT1ozRHc2ZDFUTVVUVlhud3Y2cWlRSkMwZUdJMkdKbXZZRVBs?=
 =?utf-8?B?Qk1ldnkxOWN2aEZGOURaUkZaekg4Y1dyY00ybURkNjNETXdhQm8rK25YcExv?=
 =?utf-8?B?d3ZCUmhTb0dRVHFTNy81N3JPMjF6Y0k2SUQ0RmV2MHFaMEFyZVh6b1ZEN3Mr?=
 =?utf-8?B?cTA5a0FsV1lQWlVnbk1NS2ZlVzMrZXFRR0hXeW0xeFUwWUEvSGJZQ0sramxU?=
 =?utf-8?B?b0I3Z0t0S3ROY3pZT2RlSmk5OFJXQk1GaGVGVVN5Z3dUbGZmcTh6OUd3YTIw?=
 =?utf-8?B?bmQrWm5oM09QQ2NZenRTNVlLelQ3R3UzcFVLWjNoWHJhcjkycFJxWkVHOWda?=
 =?utf-8?B?cUkvY3JjeVNwZ2k1UitEcy9zZ2MwZnpDY1JRQ2kwcnJsTitySWU1OWRhcEt0?=
 =?utf-8?B?V2dLeld0SERscHpJU2p4QWgyNkkwT01vT2dBSzlHbVAxWmwrcitGWnpWMjVp?=
 =?utf-8?B?RXZFNkI2aWxzTjVxQi83NTlqcVNyTWc3WUd0a2s2ekNiaEJXTkRsbzFiczZ1?=
 =?utf-8?B?WVhjdE5nMEFZV1Q3V2xqVzN0VU83VjRzN3UwWUdWTVY4WkxkZ3dVTU1DcWsx?=
 =?utf-8?B?TC9EMXFlb2dvUnRnTzkweTNFMjJvMGt2TzgwS1g5YzNtVnYyZTFSdUZLSDVm?=
 =?utf-8?B?clRPSE93bWRFbkRKRytNTWVEYnpYSDdjR3VnTnpyQkNSTFFGQTJhaXd6Z1Jp?=
 =?utf-8?Q?UCr3jvVKkW62CLPcdL4gC/VqU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW0yTXVCa09tSkNPVSs1NzZVc3I0V0gxSmZ3ajZSWVhueG5KQUdMVWZ3MWxv?=
 =?utf-8?B?OGpiTHhuUWpWQmxQa0xMSExHQXplZmpON0pYQVVZb0ZDUGJLb20wZ0lwN2lK?=
 =?utf-8?B?VTArWXhneGNucG5NV1hWS1NYQ2ZqM2xSelJTVndvZ01FM3VxaXc3d2dEbnBj?=
 =?utf-8?B?bEJZME02cTFlbjhEMUplaTFFb3c2SncvNXA4US9jZWkzOTljQWcrWi9vcjVv?=
 =?utf-8?B?aTcxQ2dVUzQ2K0FHNjRCenlXYUN0RmRVTGxvNU8vMlNrVWRhMjhlM1VaMVE3?=
 =?utf-8?B?WTFmRjVTZkJPUklnVlRKQWR3RlMvN1cvN1pXdTVCOWdUbUdhRWw4cUNBVnZm?=
 =?utf-8?B?VHdiMnE1VGdhYi9MZVJyanpMTDVZY3VjSEM2VlhIeTVqRWRGRGpKZFNIRGkz?=
 =?utf-8?B?ZFlMSlY3UVBJYmdJSzZFT0JUSk90SFhUMk42UlF6NTh2K0tCZkJJajdxeUFT?=
 =?utf-8?B?TDdSY3ZwMDNWUEV0eVZzc2U4VkNrTGVEQ3FNMHBRRmxwNzM2YUZNVlA2aUhh?=
 =?utf-8?B?SnZTalh4NnNDbk5DNmo2K3pJWlhubU9aeWpPZDJsUXFscFhzZUttZExqZld0?=
 =?utf-8?B?ZU96NkwvMTJFYTZ0Z1ZqZk1EeHdoV3FZejhTbEg4dTQ0UStOR29tM3BmWWZu?=
 =?utf-8?B?UkUwSFFlUlFpRUpnQTN0aGtoRkt3UVNZVnFNR0p6V2piS05rYlliQ2NnSmNr?=
 =?utf-8?B?NjBSTDRTbUc3Tys0b1RKakRXcFFhTmFzellPRUtqQ3Z1NmgvNGN6RVFzYXh4?=
 =?utf-8?B?dUlmcnRPT1F2VmZkZVcrU1hnRXNPeWlOQ3hGcEliMlBFK043aXYrQ1YwVHpU?=
 =?utf-8?B?ZFRPYmJTVEpVbzFlYW9EaEd0Z3FaWUV5MEs1MXRXZVlZdHFPbU5yeEFXWGRq?=
 =?utf-8?B?cVUvejdXRjMvbE5BQkcyYVZ2SW9UOXdCelBWem5oYm0veWs3MU5oaHZPbUlS?=
 =?utf-8?B?M0VmVG9VV0l0L1liWG8xQlJKRDdocFRxelZrdEdIVHYrNURDUVdHRUtGNnpw?=
 =?utf-8?B?am10ZjY5aVZZSWhEUXhPdjdpaEtDV0VLVUVGWlZXa1Z1M2xZdXVnS3FwaEpV?=
 =?utf-8?B?a2kyWWpoT1U5bENHQnRiSlN1UTRwbmgrSkV4d0diZVUzc21mK1dYT1diemtT?=
 =?utf-8?B?WlM5NHBXT2cyR2NlOXFvdmhYZU40M3c5UW93ODdMcW4xcGFDS3UySlBiWG9n?=
 =?utf-8?B?Y3o0R0VyQlVqNkNDK0hzRkRKZ3hyUUtzM2pyN045bWRJRDBMdllnR2FZS2hT?=
 =?utf-8?B?Qk1FQzJubFZTcGRrQSt6RllVbkIzZEZtZmY3RHNEamEvWmMrK2JYMEdVWUNR?=
 =?utf-8?B?N0ZVZGp0STZzSnlBRGpkdTN6YzZ0cVVNY2U0c09od09TMDVUM0ZzMGJ4K2Jw?=
 =?utf-8?B?M3Fpb0Z4aUNyTmlBUTJ5LzZxbTV6djBSQ2l1TXI2OTk3amVZcHdFc2VPZGVn?=
 =?utf-8?B?cnAxTnhhWnYrSDgwT2t6Z21PK29WbU5QdTFuOG8xWGoyOVZDSjB4RmtyRDNl?=
 =?utf-8?B?T0o0d2hJWFp3QjdFK2lRS2lIQmFkM2FITlpON3pwQnNzUnlKQkhoMTAydXl0?=
 =?utf-8?B?aTk3L2M1QW1NQ1lzSkw3WkVrTzRJSXlDc3N3ZXMvQm5mdUgvZG9zRXhZUEdR?=
 =?utf-8?B?cjZMOGszdDl6SVNoYlFqSWE4L0w3bzdmNlZqZjVrUFlueFdtTXhaTERkMlZG?=
 =?utf-8?B?TXgvUkx1R0ZuNThzdFh0Y2IzL1IyUHBjbWpWNkhvRXVKU3BXS3Vtb1dXZ3hL?=
 =?utf-8?B?RzhJQlJZUHJSSjN2N08raG0zWnZWcTZPK3dDU2RBTmFhNTNIN0ZsOE1xRzRn?=
 =?utf-8?B?VGErbldXdS91SE84TVRFcUk1Tk1MQyt2NThqWnRKS05WNmtydXpCck1BajRT?=
 =?utf-8?B?QjlMU2t5QXRENnpUVXFYck9ibExlNWFwRzNTeVNTTU5mRkNHbUNqUC9mSzly?=
 =?utf-8?Q?80UsKOja1u1ah4JdSbuLM0nfBZQQ0C4i?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d77f7a7-8d56-4006-09ca-08df0d5a308e
X-MS-Exchange-CrossTenant-AuthSource: PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 03:35:12.5906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P251MB0016

Further revision is needed - the check is in the wrong place.

With rx->remaining = 3 and skb->len = 7 the new check does skip the
sync peek, but the loop below then reaches the same byte:

	while (offset + sizeof(u16) <= skb->len) {
		if (!rx->remaining) {
			...
			rx->header = get_unaligned_le32(skb->data + offset);

It copies the 3 remaining bytes, advances offset to 4, re-enters with
3 bytes left and reads 4 there. The guard only requires 2 bytes while
that branch reads 4; there is a case for exactly 2 bytes (split_head)
and none for 3.

I will send a v2 that guards that read instead.

Reaching 3 bytes left also needs an odd skb->len, which a conforming
device does not produce, so the v2 will drop the Fixes and stable
tags.

pw-bot: changes-requested

Regards,
Aamir Ahmed
