Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013091.outbound.protection.outlook.com [52.103.20.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E03282F34;
	Fri, 16 Oct 2026 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131581; cv=fail; b=BbG3kYQd2l5tCqunLy0Id3o5le8lSEqc1RLv9OEewrOj4+ko7p0dWpO1rQqyaNTo05TuA0EcKGok2fQNuvvKarS/pWxLq5ohWx/TYfS4WcBTOOWWwSYGb/4raJ5l1y60V5k/pEW8JB+OYgbS/o57x9qGoiTjIoIZAv4l7vHj2dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131581; c=relaxed/simple;
	bh=vSFBVbnNIBKXhVIMkWmtjMlkEUyRh2DdKbkO7WLK088=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T7bURhyDvXzEbvGXJlr8TnLePOVUhpxhrpeBsj33Zt6x0sJDPtGwSmOuUN+fd3n95KpvKvsUpdWJcJ+lEgnG+yycqVn5vmfSr2geAESZFEgUn43K/lqrgYoFz4OywhLiIcIbL5I8388OAgqwB2MGrp4Z+ES1B4FpwuK+BaSWwts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BR+vCsVh; arc=fail smtp.client-ip=52.103.20.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BR+vCsVh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y657XBFuOoUgDWfxFqECQsKHoNRjty9ADDogN0+//na9o2A387/S+aXtGY000JBnzHPVk6vYxrNWizVKLlyU49glt3XhCRlS46OYBQcVZJ6B20R7v9TTPyT65mCFZidMccvqTIEsmr5isJYEnamu/bTeQ0OwVR5oBhzVWC+nkDKVbVqc9GrW3A7PDmoOWoNOvUffs1+Xo33+7gSmCn+/OdGt6JuTbkZ1FXPL3RaQ56w3RSWaVK4b3ShGXhTwoxM14wAfpacSeIuFC4zWcRjOzRIsK8PUQU+aGqc7yGXVzBO0Wc2EAwAh6nOWsyk5SOb5gRGbQAJ3xR37v7hRNO41bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=vSFBVbnNIBKXhVIMkWmtjMlkEUyRh2DdKbkO7WLK088=;
 b=UUlPY3esoBzl1vv5SmsAT2FDmdYvBzi9kDfjO0/QPz/kOxnWCUskdBIakZcP9wtkNJXTacJ2TDZ7/e8dGzIUwc87OY5D2K99im4Todi1IQYLws2x8vWAbJl0VlvQvR/2Slc2lvnM6BF1egkAaG/rlLWfPX0Jr859Wrq0pCHgZQWTkr8f8Zo/nqS4Y+HsPv7Da0CCPJEpUMzQL8Uykrw448vLEdJX+rcmtVbHtd7km2GDCBXJzyJxHkvxE1B0137dgQOQrdLCOfNGOv/OeNhBJSAv3v0ESST5jaW5m6yCggWK69VPpwBI3p0w/wyUnIltrNT62wqI8eNefGC5AHupOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSFBVbnNIBKXhVIMkWmtjMlkEUyRh2DdKbkO7WLK088=;
 b=BR+vCsVhyytkLASbgxJl7VUoQmPnHpm6PGFUX5DgalZrOIkS/nswPiLqxbvVCKYC5XoTo4cO0U/S122QAxBNKqyDiLNZz5jDshGaoj5xbHzJu3N2Z7jN08HLTdYWbW3YCachtgASbH01SRGDRIP4L+5VnHrXr7fPtljcq2IQKuxDaoC5tICLgVjd1lNit7w2bSKMcLIVqoJfW2j9NaywGyPU8GAA45Ve8u6KcCZehjm6TiaSgNK8ZErt4MNUVjnUBRql4dvnglbXxSs8Ul20EhYKDEUS0sV0LOfNFLn/un7tyUVkB8El0vMTpYSiytcFbp7ElSv+RR9dqogrmPryAA==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by LVUPR05MB998776.namprd05.prod.outlook.com
 (2603:10b6:408:39c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 06:19:37 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 06:19:37 +0000
From: =?utf-8?B?546LIOmiluadsA==?= <x-professor@outlook.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 4/4] nvme: harden local IOPOLL user copyback
Thread-Topic: [PATCH 4/4] nvme: harden local IOPOLL user copyback
Thread-Index: AQHdXTZRt+vZ0iuJOUS2T0EkcJW68w==
Date: Fri, 16 Oct 2026 06:19:37 +0000
Message-ID:
 <c8989c0d71a640349f4dc483aff0a3de6731aba7.1792118770.git.x-professor@outlook.com>
References: <cover.1792118770.git.x-professor@outlook.com>
In-Reply-To: <cover.1792118770.git.x-professor@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|LVUPR05MB998776:EE_
x-ms-office365-filtering-correlation-id: 829b217d-7acb-4e61-2e57-08df2b4d743d
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|24071999003|22091999003|39105399006|8060799015|31061999003|8062599012|19110799012|24121999003|12121999013|24021099003|4140399003|6050399003|38102599003|20031999006|41001999006|102099032|3412199025|440099028|12091999003|26121999007|3430499035|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?SVcxdmc2V3FzTHZ0dE9hcjNnZDBDN0JLUXhHQlliVExSR1hxa01vMEhDcmdJ?=
 =?utf-8?B?VVQ2ZkdXTWoxaDUzQjdrc3BUVEJZdDFCWXlKWVF3NFhvbDg5RzE1eDFoL01X?=
 =?utf-8?B?NXJNeTV2QWNwWHBtTUJteWVFcmdnNG5Ua2tySm1lbzZYaW5DNm1EcFBaekRi?=
 =?utf-8?B?dDFYS2gxUGtuRlRHMnkyM1BUYkY3Vy9hc1J5bHErelFUTVRUOFFoQ2w0eWs3?=
 =?utf-8?B?UHdPOFd2bHl0VDZaV0hqWjZFb3pvbUFQREphTVVYQUxBUWJlSGlDVWZkaWNm?=
 =?utf-8?B?VFJZLzl5dFV5NW1DUWVwQUdLNHNtYU1Ib3Z4SVJQcENSYzJ2WHpNWDh5NjVY?=
 =?utf-8?B?MDdNczZqNzNUMVpyZXlqd29lVGkrWVJwa1ltL3hGTzNML3l4dHU1VnpGNkM5?=
 =?utf-8?B?b2JMSFovb08yNkdSdG43dmphM2JuT2ZabkR4cTQ0aElUcUpOMndpWlRUenVr?=
 =?utf-8?B?Y0pwSmJER2pOZ1NybG5mUG0xWDhYRVlBeU5aWDBXZC9vWnJqbWZyWENHUTAy?=
 =?utf-8?B?WVl4OCszWThEa2VlNTNMK0wvRCtBcmNMOC9DSWJJdDR4akJvVjJIUmtUTzkx?=
 =?utf-8?B?NjducDc4UnVYN0VjYm9KYUVyWjI5Q1lPak0zaWRMV0hvS2JVM3ZsaUVFNjJa?=
 =?utf-8?B?RFpYQmp6TjlOWUdPWThpRXByNEFmTFlEOUxEYzg5SVBrQU52Q2Z0UktzM2xq?=
 =?utf-8?B?T3d2NzQrYi95YnFQN2lDL25wa0lROWFML09iUWt2N0hObkZBbWl4UlFYbWFz?=
 =?utf-8?B?S3FLQzZYVHdxUEo0SUVHK2YzZEdqdWxDK211VzlrNzFLVXZ0Q0JGMlRXcGR4?=
 =?utf-8?B?Um15QTVYa2pmMkhOU2ovemc5Q1UxVDFYRGkwSXFTSjA3Y3hMTndkVlJvTm0w?=
 =?utf-8?B?WEU1SVJ5R3dmRUlnMEFoNUdCQlplSFUwQXNJQ1hVTkZGL3NOcTZVWXFPa1Vk?=
 =?utf-8?B?aDlvaWNsam4rWWE5czhwMFBJc0VMaHJtQ01vMXMrYk1xN25hVGxaOUxsUnpn?=
 =?utf-8?B?dEtKclhldDZaL2tHekdnNU1JZSt0Q2xoZWhxRkp6bS9NUnJRYVhueVdsV08v?=
 =?utf-8?B?WjBkVWdXaGVyRWlxT01DVEQ5Q2RKeUJhZnZYckUyWVBPeDVYLzcwKzRGYXRZ?=
 =?utf-8?B?Nk5YOXUwVFdpRXlVWVkrK3RoUFhWYlhzbG5wekFSU2MvZ25aRFFkTTBydGhY?=
 =?utf-8?B?RWVZdXlHd3p2SjBEN2JBQS9PTnFiSDBVTEpQSlhpMGcvTU8vZG56SklOMmN2?=
 =?utf-8?B?SWZPQk14T2xnYUxQWGRoM1FQUnVZR0NiNjhVaXhOV0dZTTFsNjNoc3RaekNP?=
 =?utf-8?B?UUMyaFBLdDdsaFNVR1I3Y3hYb2ZZMFh4SGx1N2ZMUTZKWTE5aUpKcHBNV0lO?=
 =?utf-8?B?Mk5Fd2wzbXR4U1VjN1REMGVsWEwzL1IyWGgwMzJZcmdxbjhRMXVQNVVxOWU1?=
 =?utf-8?B?a3dEbDcvNkUvTjJmSXVvVWZ2WEtrZFNZQWlQK0poejJXd1FqWHdER3krZ3ds?=
 =?utf-8?B?aG05d1hlNU9ublZXN0RkMEE2eVNIczRaNmMwMC84LzBGcU5zRGZzRUhOWGpv?=
 =?utf-8?B?YjQ1NncydXBFLy9uR3BLWlBmUEVlYjRsSHJtMWltWE5WdVpOTnpxWC9McDht?=
 =?utf-8?B?Z2dSVHlNQ1RtRTBXdExHTHhQVEtOcmc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K005L2tRdTFWNzZvU3pRVlN0TXk5cnk0eXI3NjEzcnFZdmFDcGQxc2greVhD?=
 =?utf-8?B?RTQraGNraG5PVWZ2QWtRc0JBQldTbTU0QWo2OEFlZGhqOTEzTjlBUUEzdGZM?=
 =?utf-8?B?ZVJRclZHTXdJWlpweGx4Yk8ybWozYUxVc1M5QWY0YXNWQm9sSXZraHp1aHFY?=
 =?utf-8?B?Yml4WTlKcFk1bXdFakpLSEZITmxadno2ZlNNcFBLRlB5OTdScHdtdERzSzVm?=
 =?utf-8?B?V2R3RmtCaU5nNHZRdDZTVjBWbHRtT0gzaEN4MEtrOW9EODh6Q3U1VGEzd1BR?=
 =?utf-8?B?dlNUL1NMdGM1WUhrcjZyZjFYMU1SWVNjLzVvaWMrSWg1Z1c5MXVaWGhmcVBO?=
 =?utf-8?B?QlJ5SW9MOXk3KytPb2lqWWRYaU50bTNjM251KzlTU3FkMUFRaDdCM2Z2cllz?=
 =?utf-8?B?WmxjcndBeVY5Yk1WOUkxd0JpR0NOT1JwOGZRVWxMTGI3WWhoYXVxOUE1cjdO?=
 =?utf-8?B?cXhtVEg0eUo3dUhBWFduMXI0dlpnZ2hyZVROZ0hwN25lRHJqb1BadkNhZ0pk?=
 =?utf-8?B?UW1zUG5sWWIvSmFQVDVvdzN1blZZemJXbjZrWGoxMmtidDRZOE1VNXJkSFBy?=
 =?utf-8?B?ckNTZk9RY3Z2MTJMcXYySkFYeW9NMU9MN2JCM1FxbFMyYmw4L0VxQXA3WUNO?=
 =?utf-8?B?RU45bzVtY2xhb2dQbHphNnRPKzR4Y0RvSk9RRVEwT29tVGNVMWJSYkRoT2ZW?=
 =?utf-8?B?RjRRYUR5Mm4wZVBVS0JVc3ZBWW1URTV3VVZWZVNIblhkZDFTZE1CQitWeHFM?=
 =?utf-8?B?WnpEc21rRmYrSlE3QnJOOTJPUVVtZERRVjBMMGRqdjRHcS9aM204bkJ1Ly9o?=
 =?utf-8?B?a203cWJ5aWxXWUpTQTZmb1NvdTJkQUFpV3gzcVErT3JENy9VL2s4bkpZbHpr?=
 =?utf-8?B?ZlVxMVlveldWUVNic2p0L2Jpb2NNR2IvZ0w2NTlrTDh5ZStvY0xhN1NwV2lD?=
 =?utf-8?B?VHY5WjZwZHp2RE1TZzJLUVJTZ1dKcHhTdmxkYjhwSmwwQlh2bFNvcTBoUHlw?=
 =?utf-8?B?WE1qNVlBQzBHa0dBWjIxZWdSaUQyVWFWNDZweHBJMnZIRWZCOFFNaFFEZ1BO?=
 =?utf-8?B?QWRYL2hYSXFvTlFVaTF5S1A1R25IQ1pza1NFQlM5dlFqNlE4VjQ2Vk4wbUFy?=
 =?utf-8?B?VjJkZC9jNEVyWGpMcmtUZmxnaGpZeGFEQVRtelRGMWw1dWdtZG9LQkloMi9E?=
 =?utf-8?B?bjFGblp5Wm1sOFBpZWUvdDI4TGlpSXF0MU8xZlJWcVhzSGp0M1FWWk1RTHlM?=
 =?utf-8?B?M0czbFM4YVFwT3M1dTExem5EN0hETVVDY1ZWcVFmTzljNmU0QUtpc202YkhN?=
 =?utf-8?B?MUxlQjdqaTdFQklOWkw5L2ZTN1ZhM3FBcXgvb2JpenMybTVpNGFsckE5b1Z0?=
 =?utf-8?B?aUY3cHN6Q0xabVU2TkFFcjFZZWRkeUZVVGxxSVNqMWhWcUV2cWV0b1piMS9k?=
 =?utf-8?B?MU1NVnpmemFPeHZ6Snl4TFdsMERYMDIwdE5UcWFyUGRYdkFLeUVzS24vaVB5?=
 =?utf-8?B?bmZYMmorTjQ1TUdpYzhrZlpYSlgwZE02SklFdVNLUmpKWEhwOGFjSWRPYXhi?=
 =?utf-8?B?RnhxYkVJRC9XOWR3RG1VcExHcFdoVDhYTDZXSnF5VGI2bUpFRTZ0UFpKWXEx?=
 =?utf-8?B?ZDJwOGJsWUl6cWV6eGxyUElsbGJkMEFQSHpSY2x6U3V1NjF2aEJBQUI0VGVw?=
 =?utf-8?B?a1lhYjA2WlVrdjZqNC9ycE55ZUhpUHFRQ1cxbTRJSHN0ZXNCVVgzNEJsNmp4?=
 =?utf-8?B?MitPTktIempVN3o0TWYvQnNrVnpZVUtWK1VJMERVM2lyNHVTVmhtZzR2YUVK?=
 =?utf-8?B?WEFiV2pTcUNZbHlYUEZXbEFtdHN6QkYwZ1g3cG55WDkwRkc4ZEpWdFpnUzZV?=
 =?utf-8?Q?9f1ZYaEg8D4w7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 829b217d-7acb-4e61-2e57-08df2b4d743d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 06:19:37.1967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR05MB998776

VGhlIGxvY2FsIE5WTWUgSU9QT0xMIGNvbXBsZXRpb24gcGF0aCBwZXJmb3JtcyBibGtfcnFfdW5t
YXBfdXNlcigpCmlubGluZSwgaWdub3JlcyBhIHBvc3NpYmxlIGNvcHliYWNrIGZhaWx1cmUsIGFu
ZCByZWxpZXMgb24gdGhlIGJsb2NrCmxheWVyIHRvIGZyZWUgdGhlIHJlcXVlc3Qgb25seSBhZnRl
ciB0aGUgY2FsbGJhY2sgcmV0dXJucy4KCkZyZWUgdGhlIGNvbXBsZXRlZCByZXF1ZXN0IGV4cGxp
Y2l0bHkgYmVmb3JlIHRvdWNoaW5nIHVzZXJzcGFjZSwgcmV0dXJuClJRX0VORF9JT19OT05FIHRv
IHRyYW5zZmVyIHRoYXQgb3duZXJzaGlwLCBhbmQgcmVwb3J0IGFuIHVubWFwIGVycm9yCndoZW4g
bm8gZWFybGllciBjb21tYW5kIGVycm9yIGV4aXN0cy4gIFRoaXMga2VlcHMgdGhlIGlubGluZSBw
YXRoCmNvbnNpc3RlbnQgd2l0aCB0YXNrLXdvcmsgY29tcGxldGlvbiB3aXRob3V0IGFkZGluZyB0
YXNrLXdvcmsgb3ZlcmhlYWQuCgpUaGUgY29tcGxldGlvbiBQRFUgaXMgc3RvcmVkIGluIGlvX3Vy
aW5nX2NtZCByYXRoZXIgdGhhbiB0aGUgcmVxdWVzdCwKc28gaXRzIHNhdmVkIGJpbywgc3RhdHVz
LCBhbmQgcmVzdWx0IHJlbWFpbiB2YWxpZCBhZnRlcgpibGtfbXFfZnJlZV9yZXF1ZXN0KCkuCgpX
aXRoIGEgcmVhbCBOVk1lIHBvbGwgcXVldWUgYW5kIHRoZSB0YXNrLXdvcmsgcGF0aCBhbHJlYWR5
IGZpeGVkLAoxLDI4MC8xLDI4MCBjb21tYW5kcyBpbnRvIGFuIHVuYWxpZ25lZCBQUk9UX05PTkUg
ZGVzdGluYXRpb24gc3RpbGwKcG9zdGVkIHN1Y2Nlc3MgYmVmb3JlIHRoaXMgY2hhbmdlLiAgQWxs
IDEsMjgwIHBvc3RlZCAtRUZBVUxUIGFmdGVyd2FyZCwKd2hpbGUgd3JpdGFibGUgY29udHJvbHMg
cmVtYWluZWQgc3VjY2Vzc2Z1bC4KCkZpeGVzOiBmN2JjMjJjYTBkNTUgKCJudm1lL2lvX3VyaW5n
OiBvcHRpbWl6ZSBJT1BPTEwgY29tcGxldGlvbnMgZm9yIGxvY2FsIHJpbmcgY29udGV4dCIpCkNj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkFzc2lzdGVkLWJ5OiBMTE0KU2lnbmVkLW9mZi1ieTog
WWluZ2ppZSBXYW5nIDx4LXByb2Zlc3NvckBvdXRsb29rLmNvbT4KLS0tCiBkcml2ZXJzL252bWUv
aG9zdC9pb2N0bC5jIHwgMTIgKysrKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2lv
Y3RsLmMgYi9kcml2ZXJzL252bWUvaG9zdC9pb2N0bC5jCmluZGV4IDA2YzNmMzIzMmJhLi5lNGVh
MzBlOTEyOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvaW9jdGwuYworKysgYi9kcml2
ZXJzL252bWUvaG9zdC9pb2N0bC5jCkBAIC00NzQsMTIgKzQ3NCwxOCBAQCBzdGF0aWMgZW51bSBy
cV9lbmRfaW9fcmV0IG52bWVfdXJpbmdfY21kX2VuZF9pbyhzdHJ1Y3QgcmVxdWVzdCAqcmVxLAog
CSAqLwogCWlmIChibGtfcnFfaXNfcG9sbChyZXEpICYmIGlvYiAmJgogCSAgICBpb2ItPnBvbGxf
Y3R4ID09IGlvX3VyaW5nX2NtZF9jdHhfaGFuZGxlKGlvdWNtZCkpIHsKKwkJaW50IHJldCA9IDA7
CisKKwkJYmxrX21xX2ZyZWVfcmVxdWVzdChyZXEpOwogCQlpZiAocGR1LT5iaW8pCi0JCQlibGtf
cnFfdW5tYXBfdXNlcihwZHUtPmJpbyk7CisJCQlyZXQgPSBibGtfcnFfdW5tYXBfdXNlcihwZHUt
PmJpbyk7CisJCWlmICghcGR1LT5zdGF0dXMpCisJCQlwZHUtPnN0YXR1cyA9IHJldDsKIAkJaW9f
dXJpbmdfY21kX2RvbmUzMihpb3VjbWQsIHBkdS0+c3RhdHVzLCBwZHUtPnJlc3VsdCwgMCk7Ci0J
fSBlbHNlIHsKLQkJaW9fdXJpbmdfY21kX2RvX2luX3Rhc2tfbGF6eShpb3VjbWQsIG52bWVfdXJp
bmdfdGFza19jYik7CisJCXJldHVybiBSUV9FTkRfSU9fTk9ORTsKIAl9CisKKwlpb191cmluZ19j
bWRfZG9faW5fdGFza19sYXp5KGlvdWNtZCwgbnZtZV91cmluZ190YXNrX2NiKTsKIAlyZXR1cm4g
UlFfRU5EX0lPX0ZSRUU7CiB9CiAKLS0gCjIuNDMuMAoK
