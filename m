Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BADC3FF8BA;
	Tue, 25 Aug 2026 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664734; cv=fail; b=nbYWU0ajzvczz4Jm8H3XBHLE/jnLgnOot+2vkiAiGFqsRb1wiXvGaqstubdcSW7n2RdazG58idja6MDXi61slXhIhu4e737PlGF5HFP1hASNWhciAcdnlMH9LwiCN0n5eXNCWJy78/v+EPwG04X4y+0ubnjMQJYotOEwTnPKnq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664734; c=relaxed/simple;
	bh=750gw9PQ32Pl1ZlkPTl2Rg4H9js3XzPzAZs4FFEwDdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JWjRn6G+N+JfMl/onvugW7oSHKfawXHg8jxS8Hx7dl1jqZgw7Jfuab71W/BOyRjSyR1nw8XtBDJUX1QBhYMrQH4d6uHyvyghbCb++kxNXjyfroBAt6o1PR/1eY+g+zBoB7S0bO0YDtCszOZaU28YsETXsZJneaPS4+/CUyn4Pis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=jAnjg2X6; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="jAnjg2X6"
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PB36fo1055113;
	Tue, 25 Aug 2026 13:31:51 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010044.outbound.protection.outlook.com [52.101.169.44])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4g73xrtgxj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 13:31:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSBpcc3kYI0pTzoO2ZdIhcftE6l+ccClEY1irviU5TWdRn4u/NEZp8CPIdQ4L0OY6qVUbIylcOGrcjsLZlFz6N4+3miLy/5nPv8V2Y/gZt3CXQqLfwo3pdrVk/tmt+RqJ1EzvdTJih6gmFm1AogIGnjCNW9huSCUySPb0CYDtcWRJiB3zhJQ6o8ftlZBkfuumdplZcVD+feywa0WtAQ1jVtIuy74eNtbjpHbcUSmcRFQsKcU1cy1xGs1y2tuk+yUcQIF8dppye4MByv9oNzILXvr6n2+3aELrM43AAMycuDPu9n36YtYg4plbncfUFZXW7NLTcLMK77mP8h+Yz2xFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=750gw9PQ32Pl1ZlkPTl2Rg4H9js3XzPzAZs4FFEwDdw=;
 b=XmOitHxJ6/pGMPXi/yM1ugakXwHtas81QzBgvnSJkNTQDGgzf1/aejf85Nohvs2zb8XoeolmAk2rTyJQx3IvAsWoPVy5oISZRKuqPVwBL6OS8Yw/OxWf4fTLMFVTpHQiiSbrekY8M5UfOmIpMvUHR8PqPudyTk5GqToH5gquDUukykyGcnRVzIscj78MRH8rwIH4wgkCELLsSeyiqrW4a01dQuoE6Kt+EF4aSOWEsnKjqHhHKzOhBCQDIXZC2CYRrXZ6q/qxb9V0lHiYWyGDG5sz3A8FXBVMX8YAe3egWBU4Y9P/rk4+gnMyYlif93q6e81318GrCqFHwsWbncCTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=750gw9PQ32Pl1ZlkPTl2Rg4H9js3XzPzAZs4FFEwDdw=;
 b=jAnjg2X6/Wc/+jAudOKKevy2oFMQe0u6ZmsM3ieCgxX0oPnSyuuenIsshoQI80N03g8vltGeZazRYc+0KO6GACg7THLP07RvM+f8crFsBKkKKCqyAoxiEPniXUShQYxuBklRyezOP3PDf9nhUcpoY3JkO7pj9wOj3Q4LCJ3Ed5kuQVz+dTUOCg/o3uaEhos2vWGXHLV2i9T7jH/im6D9X7S63qO7ncQcn1Xf/VJI/LTCnx9IV3jTr8VH+I7ba3zP3dUZ56aAw33LEIJ3TO8YGp4QptS8rAUHjaiq49gFHavEBppUHaq2JLbolxPhI4tfRLUqE+gLmASok8bTJ7FNAg==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by FR5P281MB5178.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:191::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 13:31:38 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:31:38 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] iio: inv_sensors: fix estimated value larger than
 interrupt timestamp
Thread-Topic: [PATCH] iio: inv_sensors: fix estimated value larger than
 interrupt timestamp
Thread-Index: AQHdM9unSFAH7ltw1k+xWi6WyFwuZbatU+6AgAFtJes=
Date: Tue, 25 Aug 2026 13:31:38 +0000
Message-ID:
 <BE1P281MB142668824B5EB8067F8E1034CEAF2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References:
 <20260824-iio-common-inv-sensors-fix-estimated-use-v1-1-6e93506e7e93@tdk.com>
 <aoxkI3SV4IGumncy@ashevche-desk.local>
In-Reply-To: <aoxkI3SV4IGumncy@ashevche-desk.local>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|FR5P281MB5178:EE_
x-ms-office365-filtering-correlation-id: a6ca1ab1-0b46-425c-2234-08df02ad30ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|23010399003|18002099003|22082099003|11063799006|56012099006|38070700021|3613699012|6133799003|4143699003|10067099003;
x-microsoft-antispam-message-info:
 xqkyUUvAUxzElmg4sSDDMJtWMep2X3aX4lVTJASHmYFG1j8zfjQ9E5BcLukSX/hN+Iv3bwBu9Oud44tOu4dxheGo/je2FiwuoxdF0XTr2Z5quOBy1SfiUdrW1uGHhufu52ZD9HmqQoBFOJK++GsO2xpqvZLUEvrApSCtIsPbHL5TXMojZfZ9/3TIcz8YF2kr6lX6EI+/TlVwoOxAq2mNJP2M/Y3LQ4mam0GRpb8wQ9YybkB/m+ZFtNPXWtQOvtXhwhxrDtyWoHnA7FTFeWIIplRdj2PPIpPO8hH++D7vXlktAD6zhuoLn2KpBlHloNvEEDCWrhOnOp8f5dioc4EJPeNZToV6y5XYJZKWG/9Sf2mYPrx3wumZq1ezCB1xfNHxJPQXKQY8IVWlXJRUtzrXxACHTQw6C4dZt9YT1pjfZgcTYhemJUAag8p2U3QPoXWDAJuDYa2U5DIaVZv2aAHdlRQfPtl2MazRmLZnKvI8DE3OKeFYo0d0Wdvz+VHin7sq/u2SaneCuf/eWwatrmfhY2MXT3V23wxGFrUbrvKSmK65/9kCxAJZyweEhQoiqmXGpfEACFVP4nfe8FIizvT/Q1aWVEEi3K/WszTn3MnzmU97IhAN0kLiihTSJ6YZqXy0PSECd2jktl+b4Ya1skNJDa3IgpgF9n3EVZZLNNTTdK+8UPStFEp/sEs/VPmDBCKxf/c7hX0rItao6NQ4j9ld9TUEo38sVmae2zAy8MHjDOX5xG5wtHu9c6tsRE1b+dXo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021)(3613699012)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MG9ESUo3Qld6VXlsSUFYZzdmdkxLaHpickdtY3h5eWFpR2pyM3RVRXBySlBI?=
 =?utf-8?B?Y09HVEVZSUxBeGd5THFUTlN2L1VROWs5OTR4YlFtdkExbDFhRFdTUE5CVzhI?=
 =?utf-8?B?QzJBRS9YOTMvMUxldXZabWNVWGhreXhKSGQrcG5MZytQZ2NmYVFLNXZoVWFE?=
 =?utf-8?B?cTdVMEc5QmsxbTdnemFTclMydmFlQmdXT29Lc0pYNEdaYWdNZzNuZjJVbmM0?=
 =?utf-8?B?Q0pSL1FlSGNFU1N2S0t1WWtOTFgrQXhqUXhtWE41cC9idmQrWHRKeTUyNFlN?=
 =?utf-8?B?bnJlbE15NGpUYml4ZzlxVkdQRFpjYkZoTDhvaEplTGlqclF0TGdES1VPaThs?=
 =?utf-8?B?OHVGQ0x4UFc0cU04dGVSbk5MWUw0SnZFS0R5MDVlNnJvOE9keGVOenRrS1pX?=
 =?utf-8?B?M1VFTER4M0RuZDhzNVpYUTRqZXpkRUxsczNVZ3BOMmU0eCtadDdoK2pibS9K?=
 =?utf-8?B?ZGFmc0JqN2VTcVBnaHBMRmJUYlpuYkVOdVZPMkFUNHV5cWJrUXE0bkZnekNS?=
 =?utf-8?B?MHJYcGNqMzlHNC82bE9xQkMrcFdKd21CcEwzcXNyc3UrWjAyY0xwdnBFbG5m?=
 =?utf-8?B?TEtSMGh2bU5NZDVaOWlkQmovb3ViV1dDNGtNcFV2akxRRTNKUUFCRm1HNVZB?=
 =?utf-8?B?YzNqeUV6dEhBWUdDUldTVDY3emo0LzJjeUk1a0h3WUx3VW5ESjRXTkpYbnN2?=
 =?utf-8?B?RmIySm1TMlVrb2t3N05sRlphN1RnYTBNTzI2bzh4MnJkUFRDM21Sc3o2eUxn?=
 =?utf-8?B?amRYMDNRdGs1OWgzdGREcXRtdFZyYjhZb2k2dkVSQU12bEMrdU9ma09LdlJx?=
 =?utf-8?B?VnlraHZTamViUWhCVlB0dmY5UUpOVmU5RGZGY20xb2xKdnVCdURzUmRTUlZL?=
 =?utf-8?B?T3dqbmlzTUZmNjJSTXdiODZhVElMRVcyVjFUbWJnNkhDejZBOGU4c2RlYktD?=
 =?utf-8?B?dGJZa2RnOHNCSG9vaUFzSjkwVzBGVXczS0VGdTR3WGZESmVUWnRmV3BxdDdN?=
 =?utf-8?B?TFZmbGprMFhnalA4eUVRUG1EdEV6MXdYNStWQW1QSGxJclE4dFVScXRZQm16?=
 =?utf-8?B?VGZ0VGxvd3VRblBMdHJ1YTF1K0FacGkzU28zNGtKWHV4ekdRVjNXcTBYdTdj?=
 =?utf-8?B?QkNrZlh0aHU5aExPdDFVZHV6RmxoQ2ROZ0FuSkw2anNLd3VTSDREVG10eG5H?=
 =?utf-8?B?UXp5Vng2UUI1V1lwcGhnQStHZ3FlV3lSRjlQY3A5MnpVS2dmcWJQSjN6Y3dw?=
 =?utf-8?B?K2k5NG9ydGErVElHR0dPSkVrSXJEdXBNTy9HTlZ2ZCtlcmZoMFVRWFdDRE1q?=
 =?utf-8?B?cms3SFZnOE9FT2xqKzMvOElnMDFUU2d0K1BYeElZOTh5U3RJUktnQ3lKQ3hS?=
 =?utf-8?B?aElURUkxYXluVDNQSHdvdlNzblcwZkNRVENGbEk0bUIzV25kSXZ2ckdnRXl2?=
 =?utf-8?B?V1ZsUzRhbTJDNXBzYjdSek5TV0RGclgvcyt5MmRQVlh0Y25tUDhuZ0dYS3pp?=
 =?utf-8?B?NW5YTWNVVklsZWRZYndhTmU0NFUzaDJnMnZRMjhYaVdPa0lOeExVUVpPK2RW?=
 =?utf-8?B?ZkxIdEZpbXQ1VlJFeFFieDc1ZzFEeDJYZHlINW11bHZpTUcxSlhOTFhpRkFv?=
 =?utf-8?B?Y0ZWN1NudUkxc3orWlQ4QXNiT1lENGxBWGNhZ1pWRXFxeTdZakxBSzM2WXp2?=
 =?utf-8?B?RGNicnFkdGhhbHZibDdhbTBHM0I0c3hKVlIxT2ZGQXA4RkVhTEZoR2FkUFox?=
 =?utf-8?B?c3A4Q0xVd0VLWG1NRDBSdWNDanlad0x5RTZTNFBncm5ObkoxMldlUjduUXlQ?=
 =?utf-8?B?M0VyZFF2WDVsRmV2Vml4cHZHRnBMdEtGRUROSTVwMisyeDZXQmFIakd1NVBE?=
 =?utf-8?B?dDdCOER0R1cxOGh2djNudUZ5MGF5a3J0KzVEWkhkbEZPcy81eUdZNzJ0bmY3?=
 =?utf-8?B?dnpNWXVDMGY2VjVuZUZtdFlUZkxkZW5jTDUzOTlpNlJLT240VmduQTllVDgv?=
 =?utf-8?B?Ukc5aHZKdkVnVU9KS2VhUFNWMDE0TkhVZXlBQzZTc1p0R09jZG13bG91NVVq?=
 =?utf-8?B?Uk9kYUcxYzIvZGwvaUtRNEREaGFZRzF4dUpZZkMrL3I3MGVQU0FveVM4RFV1?=
 =?utf-8?B?N2lKY1lnVHNvclB3OEEyeWl4VngyZDU4dU0xUGZid1JjdURuZzdaRy94NFdW?=
 =?utf-8?B?dFdBcHlJZWQ2UE1taDNGeExUbnBHZE5yRnJncUVWY2lSSGRWTURic0pLbk14?=
 =?utf-8?B?ZFBORDd2RGwvZVdxYi8zUFJTb1NEc01qUjJoTjdJTEE5ZXVPUUIvS0tPOEVk?=
 =?utf-8?B?eXhTSXh6M0FlT0FHZm1BTHorU0lWNHIyRW1Yd200TkxtZFNTUm0wR2xxVG9K?=
 =?utf-8?Q?cFGT7LdowK2X8op0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	trPtD7hin9dFcW97W5TRiu1NvRcyNnPK6bDiW7ZmdVM5+HteuWuOfTddbpIlGidpEFgVtatHY69k7Ee1u4by+WbIXQwIVcvIjmA2N27p9jkYLf8xH3fCWCy1iT+1Q7Z4TAhVNWe8ZIOH97XbHSGh7W0C8MFKTNf18C0U/WiLSK8PmgLfr58T8GU0SBNMh4RBw5ZUkyais66wbFhadSRBHVXaRWHRR7jO5K3+BXos5GJp1La8XptepRGuRM+cdCYJxLhVOyJUv/uJOWyD/Khb7ST/wtiu5vet0hOccxghdgQnXFCeFuOc4D7ozF4CBGmWbSaImHBtTCgooQWhdgezbw==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ca1ab1-0b46-425c-2234-08df02ad30ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 13:31:38.3040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YEP8foQDPxAw5YMd1Gr3G3yA73py7qXDSPUcFbvwcsFr3iIyEAWCzIZQsRiWAm8op9s5XXuT4+9sFgjBJKNs3EN6iAxECvXyNPK2NyoNiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB5178
X-Proofpoint-ORIG-GUID: F6eNrA0jOs1TCRga1nRHHa_JlT2HbUuW
X-Proofpoint-GUID: F6eNrA0jOs1TCRga1nRHHa_JlT2HbUuW
X-Authority-Analysis: v=2.4 cv=QvRuG1yd c=1 sm=1 tr=0 ts=6a8d9947 cx=c_pps
 a=aHdhKcOANwzZ53GNjwmXag==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=vGRfEVypjB2sPmOVjkt7:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=_JewvpNWk5r3aqh6wC4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNCBTYWx0ZWRfXyEfu6e3oLPnF
 j/142XHvWtyw7uZbkWDQl9EKOq8QppTR+zcc9Psbz4QBrJNiWgcqFLjWq7p4kNAkmhYD/ZR0dpo
 frBNOHj1hLrvgOl04TnzAVWCU/3zhCJsI2mb85glRbr8Q3M2PrGt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNCBTYWx0ZWRfX6ciOYtkYmfMT
 TKmPZTPh7+kiSdGOIhhtOQgJydmHID0DkxCRB+AZMEMKs7BBZcpwyk4t6we64tEt38GxV910lYe
 RrGy/dozaJ6EpfDkthQLn58uFi5IR0MVvV97jyrLq4jK7P3r5jlCDhACKkO798y7cXyGuGcQEq5
 8KjVMuK+Q+IgEYLGIKP/repnu1bJ+Zsa+RqRl4Rb7VqcfJxaCAsDHUExh25ZzFfrKak9wCY6Pr1
 Tf4qdiB6ihsvFbSGy/v+oX70/ZnKYLWsNA6nitYYi/JcA95C6iIYvfM2cnI4mvxMXsu0tDDu3VO
 7LJnL5RzrfhgaEY9fM9rHPEi6US3MKV8xajnOc/1SLfR/gSWg/JUCmhArFcUSrCvm+ZeXlzhWci
 Fv3i61Cw90RVga8rtkBBmfX91fdzEq3T5e7+NnF1Onpd7wd45wp01gEZVfBBQdG4+FSVoF5M8Pr
 uST2fzv3whNz3aOYocQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250114

Pgo+Cj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj5Gcm9tOiBBbmR5
IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT4KPlNlbnQ6IE1vbmRheSwg
QXVndXN0IDI0LCAyMDI2IDE3OjMyCj5UbzogSmVhbi1CYXB0aXN0ZSBNYW5leXJvbAo+Q2M6IEpv
bmF0aGFuIENhbWVyb247IERhdmlkIExlY2huZXI7IE51bm8gU8OhOyBBbmR5IFNoZXZjaGVua287
IEpvbmF0aGFuIENhbWVyb247IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPlN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGlpbzogaW52X3NlbnNvcnM6IGZpeCBlc3RpbWF0ZWQgdmFsdWUgbGFyZ2VyIHRoYW4g
aW50ZXJydXB0IHRpbWVzdGFtcAo+Cj5PbiBNb24sIEF1ZyAyNCwgMjAyNiBhdCAwNTrigIoxNjri
gIo1OFBNICswMjAwLCBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIHZpYSBCNCBSZWxheSB3cm90ZTog
PiBXaGVuIGludGVycnVwdCB0aW1lc3RhbXAgaW50ZXJ2YWwgaXMgbm90IHZhbGlkLCB3ZSB1c2Ug
YW4gZXN0aW1hdGVkIHZhbHVlID4gdGhhdCBjYW4gaW4gcmFyZSBjYXNlIGJlIGJpZ2dlciB0aGFu
IHRoZSBpbnRlcnJ1cHQgdGltZXN0YW1wLiBUaGlzIGlzID4KPlpqUWNtUVJZRnBmcHRCYW5uZXJT
dGFydAo+VGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyCj5UaGlzIG1lc3Nh
Z2UgY2FtZSBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRpb24uCj4KPlpqUWNtUVJZRnBmcHRC
YW5uZXJFbmQKPgo+T24gTW9uLCBBdWcgMjQsIDIwMjYgYXQgMDU6MTY6NThQTSArMDIwMCwgSmVh
bi1CYXB0aXN0ZSBNYW5leXJvbCB2aWEgQjQgUmVsYXkgd3JvdGU6Cj4KPj4gV2hlbiBpbnRlcnJ1
cHQgdGltZXN0YW1wIGludGVydmFsIGlzIG5vdCB2YWxpZCwgd2UgdXNlIGFuIGVzdGltYXRlZCB2
YWx1ZQo+PiB0aGF0IGNhbiBpbiByYXJlIGNhc2UgYmUgYmlnZ2VyIHRoYW4gdGhlIGludGVycnVw
dCB0aW1lc3RhbXAuIFRoaXMgaXMKPj4gb2J2aW91c2x5IHdyb25nLCBzbyBiZXR0ZXIgdXNlIGlu
dGVycnVwdCB0aW1lc3RhbXAgaW4gdGhpcyBjYXNlLgo+Cj4uLi4KPgo+PiAtICAgICAgICAgICAg
IHRzLT5wZXJpb2QgPSB0cy0+bXVsdCAqIHRzLT5jaGlwX3BlcmlvZC52YWw7Cj4+ICsgICAgICAg
ICAgICAgdHMtPnBlcmlvZCA9IG1pbih0cy0+bXVsdCAqIHRzLT5jaGlwX3BlcmlvZC52YWwsIHBl
cmlvZCk7Cj4KPkl0J3MgdTMyICogdTMyLCBob3cgaXMgdGhpcyBndWFyYW50ZWVkIHRvIGJlIGFs
d2F5cyB1bmRlciB0aGUgdTMyIHJlc3VsdD8KCkhlbGxvIEFuZHksCgoodHMtPm11bHQgKiB0cy0+
Y2hpcF9wZXJpb2QudmFsKSBpcyBhbiBlc3RpbWF0aW9uIG9mIHRoZSBzYW1wbGluZyBwZXJpb2Qg
b2YKdGhlIGNoaXAgaW4gbnMuIEl0IGlzIGxpbWl0ZWQgYnkgbWF4aW11bSBzZXR0aW5nIDhrSHog
KDEyNTAwMCkgYW5kIG1pbmltdW0Kc2V0dGluZyAxLjU2MjVIeiAoNjQwMDAwMDAwKSwgd2l0aCBh
IDIlIG1hcmdpbi4gTWVhbmluZyBtYXhpbXVtIHZhbHVlIGlzCjY1MjgwMDAwMCwgd2hpY2ggaXMg
YmVsb3cgdGhlIDMyIGJpdHMgbGltaXQuCgp0cy0+Y2hpcF9wZXJpb2QudmFsIGlzIGFuIGVzdGlt
YXRpb24gb2YgdGhlIGludGVybmFsIGZyZXF1ZW5jeSB3aGljaCBpcyA4a0h6LgpJdCdzIHZhbHVl
IHdpbGwgYWx3YXlzIGJlIGFyb3VuZCAxMjUwMDAsIHdpdGggYSAyJSBtYXJnaW4uIE1heGltdW0g
dmFsdWUKYmVpbmcgMTI3NTAwLgoKdHMtPm11bHQgd2lsbCBjaGFuZ2UgZnJvbSA4a0h6IHNldHRp
bmcgKDEpIHRvIDEuNTYyNUh6IHNldHRpbmcgKDUxMjApLgoKVGhhbmtzLApKQgoKPgo+LS0KPldp
dGggQmVzdCBSZWdhcmRzLAo+QW5keSBTaGV2Y2hlbmtvCj4KPgo+Cj4=
