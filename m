Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013085.outbound.protection.outlook.com [52.103.14.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD04F3815D2;
	Fri, 16 Oct 2026 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119666; cv=fail; b=g7f4HfjMPyYGEWlW5wWS3X7JiPWZE5UzbhWS/DSIm1lLYHIhS1gRLwXeiuOs95wEh1kKwVwl4DApfuZIyVh5ScCIeR4DuJCZTs4CpBlGwDqf8P57MX1PALCA4Tt8DJLIyQKb/zISX4Do6kIkVGMqOXE+P8ltReGgQSl085AScgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119666; c=relaxed/simple;
	bh=uzcPdH1Z4NsVlLOQGt/gSuIguEZognBFlmDW80NyDRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q9uU7CddpN7yF9uUZv4O5ZiJNXj3vYz6v6PYMUlqlWsB8cOnnIERHmqahfrA55uOI4iAo5cXKtugHXkgKylQzyxZOrDj8yPem9peweDo6Ch9u3FDC5QbhFvcAs6ZXCauOL/aZtC7+MupMhsCqeu0zsB470ONflxf7TR5/A8CATk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jMUOsCd6; arc=fail smtp.client-ip=52.103.14.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jMUOsCd6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isyMlMG3QubiR9gXVkaL8KfKkAk8B2EwMValy/tAd4m7ULQdtLVI6jSnczRirT9Q/HvZ5k2J7hNbvB55s0VcwZ9XT6X666qclBb5Ohq0HGoYg8OM9huQK+MaOHNmjhF7jwhcMqIeZjk8S5FkWr3mep0OjUocBYM3kzg/0IDhteurh4sql+o2kBeYxSbxq9czQQcrV0nAmY9BRvIrCTFe6gqXHYRCzIEvigWXoiFTKcaOGkiFzVsOLtpJvflkIcr9OwsxEh8ZCXHpO/wyPFWeP2igNDt0vlrAW1xTXNuv5pxNVT3jmfUa3DGR7/w7FB/HGWbS6Rb7LLC8a3MwCmZChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=uzcPdH1Z4NsVlLOQGt/gSuIguEZognBFlmDW80NyDRE=;
 b=WnKdxPasEfFXzuRLU7Y9zRLUc+1UsiD1DVq2s5P7kgzZuAp7zox1VTgDvGzdMnXMK8gOoW3esO95auRXSGNEpjJItA2iHxYEulm15Ayu8hXEYWBIpdoS1zmKjfpdL09lkM3PJW2JAaEnE41SJSthSKhXawSOh+sl4cS3mlrRNYGL0Vz5zNsaFRUOeusb27Qp+SpzpCEr0sW4ytSoxhQOodz49+4N+PS8vWJE27OpCV6lkqEEKKHmsdbjRrcs+XBW5cT9aynjjz7WXcFVcqKqaonLu6IqlAqOLyXE5M4slItI1h0N9yXgdGcn056++MmIyZj2058is6ayNFoVr4WxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzcPdH1Z4NsVlLOQGt/gSuIguEZognBFlmDW80NyDRE=;
 b=jMUOsCd6Lz5oL8ZpXGxuh79OmJbF6VLu620DzfZZUHlymrueQ+zfC7m3I3FROxkr9VftTVPk3bfZlqeWMdaR/AkG3hxC5NcyzvAz60/ejlJXYT6IScei9M5/VAulAPZ/499tp5MZTXISaAwZ9tmOttSHK/s6SA/0EkQ/3pkNYT/n01peC3c8v/1dO/Qme3NnrpvodJtY5/5INWj0NMbTFuQbE5Pee2T5dXFmmuyt+CgFkjeE+lv11v/djAYi2UMvYBYFGvp4S+bueoQXD7YrjTT7c96dj6+kk/bRdyHTaAWsqWTBZOHlnwThwNYlnTyUMH8zcGHsbfmZAB79HbfR1A==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by PH0PR05MB8573.namprd05.prod.outlook.com
 (2603:10b6:510:a7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 03:01:02 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 03:01:02 +0000
From: =?utf-8?B?546LIOmiluadsA==?= <x-professor@outlook.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?546LIOmiluadsA==?= <x-professor@outlook.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 3/4] nvme: report io_uring task-work copyback failures
Thread-Topic: [PATCH 3/4] nvme: report io_uring task-work copyback failures
Thread-Index: AQHdXRqUyiUxj7AwPUa3Rym8fWfcOg==
Date: Fri, 16 Oct 2026 03:01:02 +0000
Message-ID:
 <4f896744665ecf7034e4c52fa310f4de7fe1566b.1792118770.git.x-professor@outlook.com>
References: <cover.1792118770.git.x-professor@outlook.com>
In-Reply-To: <cover.1792118770.git.x-professor@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|PH0PR05MB8573:EE_
x-ms-office365-filtering-correlation-id: 30f8951a-f109-49d4-8391-08df2b31b6a6
x-ms-exchange-slblob-mailprops:
 Peh/bd4fmjIRb+BXv+oaWLlId1hFRLcZVyeuNBa06/Fo53TY4HrKQ5PrJf5lb7VNBqLfZdV/UlGaDGMawXXRp6jj9nUvTltz+1Vqee0yaF99tgTqMu4DfcLb7KzxvKOWLIptEB+TtYetIDVlhttQfVMvYsIMoz3nbT4omwmnw4mCOjNQvVGEWGe7g/NGmSmYje3FiB2R5poah5NCluV61fzUA1LbDbQNT/o36ssbw+1AYF3uSOn+6Ejl4+zkQ3zLPbknBHu+r66VFI5kOteiRoMRrypFkhdV/joSY9+YoZZOfrDoEyD+C6oeIn4f/kFLelYONh0WIburAUIiV5bjwfy4RaV2r3i3VXx+WV7Q3nR3075v0MYq7EBNs1gfhhq/e7Vqu8C3HqTiyAZpkF//h5CKO1P6EopTCuUR1nyRv3ikuG6cGqvMm0E688i6eThIndDIPRItWmHtXu92jFUf4QVA9ogxp2TIp2AZemTe1f3OA+I0Th1YFTN8Moz1l28hQB4DzWrckbV0K1pVkV4uQrlX9HStIl/1U4DNFwqT9Tzp/aOnGtz062cWkq55DXL4mlHW+NqwTW42A5oJqgtf9NmszftVAl8tJ9812dkyMpW2iwngmyZljRElu5tI87HIne3M4HaURx9UOf2PSZdhUhxjwL/8EI8XaZ+pzFsHKOFDX6QrLOiH/rgkayR9RrggltrTenSXaYo=
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|8060799015|12121999013|19110799012|31061999003|6050399003|41001999006|8062599012|38102599003|51005399006|15080799012|40105399003|3430499035|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDNDUXpFLzljdERWdmN5TUZHTTBzaU11UUtVTDdUR1R6RzFRM3R4d0EwRDhF?=
 =?utf-8?B?Qysvdk5yMytjUXlkbXlVNHRHZXVQZmI2aEpxY3NnRmJ3Z0t1aHZJeXVJbjlT?=
 =?utf-8?B?RDJHLzMxNXIwVituSnM0MmQ3bERQOGc2ZDZjbUFjN2JaVTVYaUgxeEplMHVq?=
 =?utf-8?B?MUVmTExBc2pXd0duRmJHYW9xUEZyZTIzcjE1YnBaQkhUQnYxTDlub3J6UkxP?=
 =?utf-8?B?cTRYcTU0NlBlazZDS1I3TDgwazBQWWc3cXJzeTF1bERielJUb3k1eHFqZ3dW?=
 =?utf-8?B?NENqRUwvSzBKck5QL2hWVER0ZHIwdUErUlFHM201TG5jdy92aEVzTWNtZTE5?=
 =?utf-8?B?bG9wMUFPYno2cWRSSUc3RDA3VzVBY2ZLdEM5RmNrSTNqL1VoMGpSajE1bnpi?=
 =?utf-8?B?a3FjVzZBeDJEUEcvaU1Jd1ZzeWwyZXBEU3l2eXBNVlJiU0x6OVh0TFg4RGVE?=
 =?utf-8?B?a0g3NHA4d3N2RkdBNlVMRWNYQVNHcEdhK3E3NTJRdjlLQnpyQ3ZwRkV1K2dv?=
 =?utf-8?B?c0pLOE5GSDZtdUE2SlhlR0s5dTFHWlVwaGNzTEpIblhTRGswUTRSZWRndGpm?=
 =?utf-8?B?a1Yxc1lJRHZMY1N5WDNmeWduZGNNSjZvMDlTSXdldXJDU3lhcUZuTzBHSWEr?=
 =?utf-8?B?d29FODc4M1c5YWtxMnlqdHRhajdsOGtZWEMxemI0VTBCUGMyNU05bEpVSUZD?=
 =?utf-8?B?MTBqaW1aMmNYYWhCRXVXZVRSMnYyQm9DQUZkZFZIUThUM1BVVmlIWnpoYzQ3?=
 =?utf-8?B?Y2hXcTZxVlRQY2lZQjhjUDIwOEJpdVl6b1BjYUordVJPcWZvL3JBTWg0TlRy?=
 =?utf-8?B?ZGFkSWl5NFhVMUowaXBSYVBmNlF4eHpLVEg0THhvY3o0eXp0Wm1CUENUc2k2?=
 =?utf-8?B?UEtKUEpoR2tuMW9OUEtER1BvOEhObjVCQ1lXN2tINEJ2b0luK2JYRFJiRnlT?=
 =?utf-8?B?REZGd0RZVDVzWWJTZmFHZ2p6QXFqWDVYWGxqeVR1V3FRMGY5YkNJemVvU0h4?=
 =?utf-8?B?cGJQSE5acHJjZDdmTkZKV2FRUklzSlIxVDhTOUVSLzVzUnk0ekxISFRaV3hD?=
 =?utf-8?B?Sm5sSWdxamxhRVV3WkFvREdpQ216aStaclUydzFCZUZtQ0dNSFFQRWJ0dUY2?=
 =?utf-8?B?b2MrdEFyYkd2UGNFRytPSHFTMS8xSU9qSmRXRENtdUtqR3ZBUzlYVjRiYXBj?=
 =?utf-8?B?QWZEdnExWkszYnNZUjZQcUZFMXVtQmxtVzNKWmt1aUg1Nm5hNmRlVEEzL0hF?=
 =?utf-8?B?enJreHJ1Zkt1ejBaUExKcUtrcFdSaUs3Qk1xTlEyRGlBY2VHTXptTE02QXY1?=
 =?utf-8?B?enY5cUFlYVcwNFl4bklnQnV2dTROZ25NamIvSCt0OG5oNjRFL0JHTStGS0NY?=
 =?utf-8?B?R0Y2bWlLTWVnbi9CZ01GTUhvczloT2lJTmY2N21vblhiRDdRaWIybi9nS0Iw?=
 =?utf-8?Q?MKl4DY+x?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFcxVnp0QlM5WUg0YUliQWU0Z3VHTzA5NmpXQW00R1hLbjJZK0liU1FTU0xw?=
 =?utf-8?B?VkpBa1B6WWNoZDI0RWFEKzcvN3BnUFQxYWZEMEl5cUdXTG5VZC9WSUx0Z25I?=
 =?utf-8?B?M0J6NUsvZERwRzA3N0R3WS9JTFRiZXFjVG1jK0s3NElyakUrTWFKSEhvSVho?=
 =?utf-8?B?MlUyZG95U3oveVhOdkVoTVpkaWtMVW5sZGQvS0lDRXR1RnVLU2FZcmUyTkR3?=
 =?utf-8?B?T3B2R1VReFF4THlNRnNqbjVJdW9TUDlpV2x1L3BaQy9hcEIzU3JaQUFvZS8z?=
 =?utf-8?B?NmM1RDFaSE1HcDNNVWszalpoZkNPbVF1T2ZUL2N4YUVINXMybnVYYm1abDBN?=
 =?utf-8?B?c3RYZGlEOUlRTUptSUZ6ZFNhYVJzbEJJclE5aGYxclpkLythbmtLQlpwRTNZ?=
 =?utf-8?B?S0xhRzRMR2loNytzWC9ocVk0TVFYbHhxY3E4L2Q5VHgxYndKZGtLNmwrWVhK?=
 =?utf-8?B?a29GNXoyWVA5VGphQjlxRW9XSE5taTIrQkx4b1FlQVB6ZlZ2eGVXTy9oVGFt?=
 =?utf-8?B?MzFqbDhkTElQVmtpSDJkTWpXZzlqeFplNE05Wm5DbVhuTmh4Y2prUVM3aTRQ?=
 =?utf-8?B?V0w3T1hHZy9vVk40QUY4cC94cEM2bVR4RDFxZlRVNzhaWEhaSTRZT1hnZUhI?=
 =?utf-8?B?UmprbXNCSThzSFNXc1dBdjA2UERxbFhHVjByVFdKbEN4Mk92SzVlNHc5RzV1?=
 =?utf-8?B?VE5WR3MxZ1IrNU1kWGhYbXRhVW8zU2czdEFwbENTd2VzS3VhMGo1MFF0ZkRG?=
 =?utf-8?B?amxmMDlQVnI1eCtuMWRpa0VNcGZONVh6aUF3dkkrT0wyYlU1VWl6TzVHZlht?=
 =?utf-8?B?VmRjcEJMNDhIRnl6eGhlNk9GOUszdkNkV1lERzB1ZjdnM3A0bWs4bWMvMzZP?=
 =?utf-8?B?VExKb2tCY2xpVVNzSWE5cUU2MnRwYzVIMlNTUFlzSVlEajc3bWkzc1JCZWI0?=
 =?utf-8?B?dEJPTVpLVzg0cG0zbm1DaVFxcUtaaks1eXE0c3RyaUJobU9VRzBJSXhZRmd6?=
 =?utf-8?B?WWZhb3htbEVER2lmNkwxYWNkWFc0dkhtVnNNOEVSRWVtMmVLWHpGYWliNFB1?=
 =?utf-8?B?bjVNVjNKZUd4a0JYV2U3NlJCRytvZ1V0ZXdZazBYSUY4L3F0cXB6RElMWFdv?=
 =?utf-8?B?OGhTWDEvaXBwTDF1eVpFcnpocWx4aDVQNkx3UzFTK2IrWnk4VkJybEpiTEVw?=
 =?utf-8?B?S1BTZkZQOEFKN1Bxd1pNd011Wm5hQVd5NVZPL3ZVZnZOVFZWWkU3M2RGZFQr?=
 =?utf-8?B?VTE2QlJ5bVRoYW5XbGsvb3R5US9ST1VmUnJhU203a29NQVFxeGdQVHNrdis4?=
 =?utf-8?B?eGxUekd0aFpPWUJpRG5EYnlYckxyK1VKNTdTVFZzRzVCTWxNSjlYcjk0NUha?=
 =?utf-8?B?NkRBQUFtdG1tSGdGOVVMYTJOOEYxWW5EZUJ6M3hSblduZlQ4a0ZMNVN2UUxy?=
 =?utf-8?B?bElOclNVMVNyc1dqMWcvUjkwV3pTODBNT3hGbDEyWXZTdzlER0p0Rm5UNTdy?=
 =?utf-8?B?LytQbVRhbTFvWVpEbS91MkVud0JDNnhyWkhIRHNwbzRQeDNNcUFHdllEY3RH?=
 =?utf-8?B?Y01wZ0Q1OU9UTmNWZ0I2N0lQWjlMWWVlSnpNcGdTNEJjMEFIZWRSdlk4ZmdZ?=
 =?utf-8?B?ZTg3eHRHVngvMGdDQjhOb0tHd2lHekhHT0xyVzRuT0Z3c3p6aGlpamJyUkM2?=
 =?utf-8?B?bXJkTEdNVE1rQXhXYWk1UVJUb213QzRWS2pWVFBWVWFXUzh0QWIyd1ZLc1hW?=
 =?utf-8?B?ZEt6K0xYS1VjdGRUNFNDQ3NpV3dTUkNyblI4YU84QlRseFJyamE1RHlBVzIy?=
 =?utf-8?B?cEphcjF3QlpoOXF4dEhrS0JZUE1uRngzc0xqZGFlbGl2d3ZvOEdaQ2JvRXpj?=
 =?utf-8?Q?VrqO7RuWqgk1Y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR05MB10385.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f8951a-f109-49d4-8391-08df2b31b6a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 03:01:02.7605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8573

bnZtZV91cmluZ190YXNrX2NiKCkgZGlzY2FyZHMgdGhlIHJldHVybiBmcm9tIGJsa19ycV91bm1h
cF91c2VyKCkuICBBCnN1Y2Nlc3NmdWwgZGF0YS1pbiBjb21tYW5kIGNhbiB0aGVyZWZvcmUgcG9z
dCBDUUUgMCBldmVuIHdoZW4gYm91bmNlCmRhdGEgd2FzIG5vdCBjb3BpZWQgdG8gdGhlIHJlcXVl
c3RlZCB1c2Vyc3BhY2UgZGVzdGluYXRpb24uCgpQcmVzZXJ2ZSBhbiBlYXJsaWVyIE5WTWUgb3Ig
YmxvY2sgZXJyb3IgYW5kIG90aGVyd2lzZSByZXBvcnQgdGhlIHVubWFwCmVycm9yIGluIHRoZSBD
UUUuCgpBIHJlYWwgTlZNZSBSRUFEIGludG8gYW4gdW5hbGlnbmVkIFBST1RfTk9ORSBtYXBwaW5n
IHBvc3RlZCBmYWxzZQpzdWNjZXNzIGluIDIwLzIwIHJ1bnMgYmVmb3JlIHRoaXMgY2hhbmdlIGFu
ZCAtRUZBVUxUIGluIDIwLzIwIHJ1bnMKYWZ0ZXJ3YXJkLiAgV3JpdGFibGUgY29udHJvbHMgY29u
dGludWVkIHRvIHN1Y2NlZWQuCgpGaXhlczogNDU2Y2JhMzg2ZTk0ICgibnZtZTogd2lyZS11cCB1
cmluZy1jbWQgc3VwcG9ydCBmb3IgaW8tcGFzc3RocnUgb24gY2hhci1kZXZpY2UuIikKQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcKQXNzaXN0ZWQtYnk6IExMTQpTaWduZWQtb2ZmLWJ5OiBZaW5n
amllIFdhbmcgPHgtcHJvZmVzc29yQG91dGxvb2suY29tPgotLS0KIGRyaXZlcnMvbnZtZS9ob3N0
L2lvY3RsLmMgfCA1ICsrKystCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvaW9jdGwuYyBiL2RyaXZl
cnMvbnZtZS9ob3N0L2lvY3RsLmMKaW5kZXggOWI4MzA2NDFhNWIuLjA2YzNmMzIzMmJhIDEwMDY0
NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9pb2N0bC5jCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0
L2lvY3RsLmMKQEAgLTQzOSw5ICs0MzksMTIgQEAgc3RhdGljIHZvaWQgbnZtZV91cmluZ190YXNr
X2NiKHN0cnVjdCBpb190d19yZXEgdHdfcmVxLCBpb190d190b2tlbl90IHR3KQogewogCXN0cnVj
dCBpb191cmluZ19jbWQgKmlvdWNtZCA9IGlvX3VyaW5nX2NtZF9mcm9tX3R3KHR3X3JlcSk7CiAJ
c3RydWN0IG52bWVfdXJpbmdfY21kX3BkdSAqcGR1ID0gbnZtZV91cmluZ19jbWRfcGR1KGlvdWNt
ZCk7CisJaW50IHJldCA9IDA7CiAKIAlpZiAocGR1LT5iaW8pCi0JCWJsa19ycV91bm1hcF91c2Vy
KHBkdS0+YmlvKTsKKwkJcmV0ID0gYmxrX3JxX3VubWFwX3VzZXIocGR1LT5iaW8pOworCWlmICgh
cGR1LT5zdGF0dXMpCisJCXBkdS0+c3RhdHVzID0gcmV0OwogCWlvX3VyaW5nX2NtZF9kb25lMzIo
aW91Y21kLCBwZHUtPnN0YXR1cywgcGR1LT5yZXN1bHQsCiAJCQkgICAgSU9fVVJJTkdfQ01EX1RB
U0tfV09SS19JU1NVRV9GTEFHUyk7CiB9Ci0tIAoyLjQzLjAKCg==
