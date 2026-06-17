Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022088.outbound.protection.outlook.com [52.101.126.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FD22E739F;
	Wed, 17 Jun 2026 04:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781669181; cv=fail; b=SwJBBODtHU45eQx9UQ7u3RAckxM5+7ynZmvxbsNkckLNDFL6tyREKxCJ3Qr2k3Vm4X+iSnP45oYS4xV20ipX3LFBtU+HVbQXNjvZ7jMHFvmC6heMH4x0vIDSZNAD9wXA7095Ch2mNcXf+BbTOWHfhGjgAcpW3DHP8WHzuuFrTVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781669181; c=relaxed/simple;
	bh=oAu8idLoqJmBDE/7QtaNS+dYUL0+Ph9WWd9M0gL37Og=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bywgzDTOvXF7MwTjOTEcMjF4x4SbK9GnYVPJxiPgHcI/99PcdmDR7VpU8dQ7qT/UsCvi9Mltyuk7vQ6f0OGFDpgPTtvctXl3jDNZwyTcvKMPHJBQrCW1RX+jE5xbcd9JJ0esbUtTpRUpeer6b65K6JtNlMmC3jugrFAcUiTtAf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=YYjaqgdc; arc=fail smtp.client-ip=52.101.126.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="YYjaqgdc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/viGR7g5CVUssfTydYPuTLx/cWj2Z5RzjKxyxJGG5GkNIM9vD1R9vmqQ33MkojTmqqPN7ziZd4CdNuoCP5i2CIvdbJxsQ9PCghigYKEayj8VWlDS089x8XUfNMIvm2g5SGo3mTR1iMO5aNv7+MSmBYHNqfmP6rT4dF44Kke1ZXDqlylFBm9elBwvAnNV9JMszasQUf5+5B1M7kqSQHCzwtIoYAZfxI6+fA3N4dcvRq6b8pwyDkIgSwl2RSunUugmP79TfQJNUcMqrZrNPXlM+GB903LdudFyQaZZnhyLkMu7OG2lWkW6zaN5zLF7U/uyFeS2bNvaMtzNEY0fVVKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAu8idLoqJmBDE/7QtaNS+dYUL0+Ph9WWd9M0gL37Og=;
 b=Yi11cMJ3CSWrA0yCMYrG5UAs1Z2rWO+KBCngeiIQbKEOiPjBeEx9iSGhzrA6pUTvc1PPjRZdbuDpCvudNPUI6AM7DQEtblzGjiV894/a9H9CeXXKORHmHWbhip6KuZ5q1f49eUGYnqaOWr1PNAnqmLa6aVmPCr/rKTxchUw2U03TTU86ioZOtMwyz3OJ2A7O/h71GsiWaLB7l5osmIst4DTTH+9dLnfMS57xrFkmvBC3zuIqE0YmSFSBwl154gsiSK5UFoCWKqLBgUwIc6IDkNWyCesz4rGYcsYq133YOuBknPuXozQmPMo8X15lMkUZ/97nGt4o++jXnI0zQqOaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAu8idLoqJmBDE/7QtaNS+dYUL0+Ph9WWd9M0gL37Og=;
 b=YYjaqgdcuDgbqTcoC4/bVP/2J3tGrCRSCeLm40I6oWOVcp1D5HGaN3Kn7BNymF5rsvhzL+xrkk3XxjB8edpjjoYNBOC3SzLSSd7zu9Vt/6rncL9ZYM5T8aQm+Y1Ee7A50Eq6rq6PQh9gd3+VztH+TAVZHdrfVKfsrXTWOnhlPFM=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by SE3PR04MB9315.apcprd04.prod.outlook.com
 (2603:1096:101:32a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 04:06:17 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 04:06:17 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"christian.loehle@arm.com" <christian.loehle@arm.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: schedutil: Fix uncleared need_freq_update on the
 adjust_perf path
Thread-Topic: [PATCH] cpufreq: schedutil: Fix uncleared need_freq_update on
 the adjust_perf path
Thread-Index: AQHc/gzOHebBbthWX0KSjOkNR96TabZCIRUA
Date: Wed, 17 Jun 2026 04:06:16 +0000
Message-ID: <8d3ddc27-5024-4b9f-ac84-f3d92f35246a@transsion.com>
References: <20260616154733.2405236-1-zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260616154733.2405236-1-zhongqiu.han@oss.qualcomm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|SE3PR04MB9315:EE_
x-ms-office365-filtering-correlation-id: 85b1a1ec-e2fc-461a-6dd4-08decc25c7c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|921020|56012099006|11063799006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 MZvnramkGufmuxKowIW5khvlgy7/dpU5Stg5EjQzIMkuf4oXfyqCSncsh19OsaZitljsWGAcu7yoYBJMpNm5HGo0iL0Xf8jVutE7FgAo0XNsQJKZYns75wcODGRpWaOoROcj8+2oB0rUyKyNCQuuNa0J09G12Z/dRUE1htX87aRDorOWqypib5+UTePbTG6u3/9zJV1nB4FkAr3JC0m5mFAL1ssPHTQLZOZX5jzXzaNDcUhCDEPcMcaJZATnoeRv1hPVaMme2KwMRRQrEVUpb0B8+fyGG+/CKLwOWeCEAj24Saq58PvP/WY6ddViYbn9YJn42ReDgfoJIK2aClPI/4vrVwZROj4fVUNYURGrhCq24RtvT5pTxOpDIv7dshmyVI/rvxCnbbvt0j/FavmePJ+OPENInQigjFcpSNVJHl3YqTX4T2fQCFfSiPOSQrwZedRHBvjD81Z8eNJgUXlnLHS1261c2emn+isPfePbwpENwbOlbdPvksZhGBtER6eoQq08DokSLV/Bzk63kXqgDNFcfnQtqfENXyTyeQRFtZcvvvPSA7o9LcuqceAKi12whM33AwkUknsOlMS1gPsmwbh/Rp9Tqi2BcAJ/BVNb+Mzjudci4XwaAp3xTkaRXw5ZarpKNulVAEKMIRzKDhrtiSNarU8UAbjpyGPlnzffNziJwYUjnlzRgcwt0Y5+ZK31x738YjjZvXvi5Savtxzuc8Htx5tbbRQVmYhLLPzFRA16LxhPSdCH80FkEPoQpcuC0BHptRdbAUlfOCogKp8c+A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(921020)(56012099006)(11063799006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0hqTGxramVjWEJWV3RvY0JEZzN1R0J4eGFlNVJpMkhwOTJXd2EvNlFrM2Fs?=
 =?utf-8?B?VWpNQzlsd2lmS2hKNENZcFYyTGNkcG5nZXE1aHo4VHJtd1pKaTd3am1udStV?=
 =?utf-8?B?cEoweFdBL21FNlFzc2lHci8vNHVOWms1ekhjR2VtcldXamc1cmNsRG1mUGh0?=
 =?utf-8?B?R3RGb1RZYmhVNVdUUHMyK2YxMEZVOEpKeDJBYlRZbGxEM2VYcmhkYllhaEZs?=
 =?utf-8?B?dnEwNWhaTzFzTFl2aGFZY0lNZGhqM0ZNOTVsZnlscERzT0hBaGVJYUtLdklO?=
 =?utf-8?B?QVBNRGFpcmdTYldxNGtIdVZhN29zOU0wUHE2bzdtNDFDZmU0RStCNEVlYzJP?=
 =?utf-8?B?RDNwSS95aWVpRlU5S1FUMnptbkh0dklKYWxrbkNSb3lBaEY0ZlJ6K3IwYmVx?=
 =?utf-8?B?a002WUoxTW1qMXE5VFVzNWFoQnNTTVQxZmZ5cS9BbExrc2EwRVpZMmQ5ZDYy?=
 =?utf-8?B?ZmxYZnovSUFXeitML2hnNWhOR3dwM09TY2RHVTBrTTluWjVxc2hCTTBUZm92?=
 =?utf-8?B?WDV5MHc1RGk0YTNwYjQvSzNEeGgrTk1sRll3elRWYXNGRUZmdDhTUEUvNHVD?=
 =?utf-8?B?UkxIcS80NWFmMWR0cTh2Umw2NTR0Nmpob29VZzU3eTVqS20rM1FwNzlwYjU1?=
 =?utf-8?B?NmF5NW0rbHhVQ3o4M3hma2V4WjRHZ1h4bEtvRWtMd1hpek1YTVI0TWhaWWVB?=
 =?utf-8?B?MDE2QkZsY1FrUmtRTzFIMkRPNVg2aUw2MkpKdnVLQUhNRGVoU3pKYVlCTmkr?=
 =?utf-8?B?dHZsWHlZT3J4K1BscFJkMVRRVHEzQ0pLVmNFZGxQSkV4TDZoQ01Jb2U4NWhx?=
 =?utf-8?B?eVhZWTZXUXc0NzQvK1Q3NXdmUk5yd0VWdFVHc2xBOVF4L1BFcGV6Uk04ZjhJ?=
 =?utf-8?B?MmhoOHpuWjZTWVowcDQvM1kxcDdkaHlXVTZQUjJ4cEVyT0tWY1AyQ1BtQ1JK?=
 =?utf-8?B?dzZmYkZkdTRIWmdjZDc5UUgzTVE2WHk5QU4yUEdGdWVNaCtLeGJQVVp4V3J0?=
 =?utf-8?B?K1dXKzZXZitheWhsNUE3ZzFKQ0VRSjhOMmQ5Y29KN0pYMkIveDNvWGFFVWpS?=
 =?utf-8?B?bnIxcnY0Q1piZm9CcmZ1emdvTDdiUjlXem85dElxa2FXOFRmTm9jNWtDeTkr?=
 =?utf-8?B?UTExRjJGeU1iRzVDcXlzTTRsOVU2U214VEtnNldFMllJN3lYYXRnYnRkRC8z?=
 =?utf-8?B?OGcrbng2YUxORWQ3eHVmNE5qZjM1Q3R4dDdNa3hWbnM5VWQ4dnVkRUN4alFt?=
 =?utf-8?B?S2xUWURxUDdxbkk1a0hkSzJFQVcvcU5XUlF4UnBFaU51dTBjUmt6aXlHM3d0?=
 =?utf-8?B?ak1YL3NlMWwwQmNETlRScDlXdXF0b1poRk5kb0E5YkFqdXFHbXN2WDYwT29X?=
 =?utf-8?B?UzlpNXJmZE9JVnNjcTZSdnlybnlPMG5VVFhEQ0o0QkpPdXRoRmVZSUgvNW12?=
 =?utf-8?B?b3JKK0JyaUR1cjhhQWJjbXRPME9oN3NvaTVQeXZxMUhJa3NHcTB2RlE2OGc2?=
 =?utf-8?B?T2NLaFZ1RTQrbElOWjhYNDlMYnozM050VDY1N0tMdTNWWndOYm9YU05ydDBq?=
 =?utf-8?B?ODFxOHNZL21OYWNvekoyREpnMmI5TmM0bk9KVVl3T3RlTm5wWVhJUjBKR0x5?=
 =?utf-8?B?MkpMOEpJaDRjVEV3c2YyZml2S2F2azR6WW43cmU2eTJqbHV0ekMvS21JeW1t?=
 =?utf-8?B?endvM3JUNzNic3UxVlN6YUk1eFZWdHdTaUtqN3IvV21oaTJIbmVHNDZtblJF?=
 =?utf-8?B?Nm5GRFpPajlGc3NJb3FsMVQ3WmpPV0NPOFBLUFkralJBMTBpakYwOFJqWnd3?=
 =?utf-8?B?RXRWdzZNNzJVcy8xc2NZZ0pLdmFtZXd1N1k3RjJzb1M0M3kybmp3RFgvUHlK?=
 =?utf-8?B?NVlPTHdxKzNEK1AzbUVMcTkyMjB0cVpyQ1RMM25LMTF2YytaR29DVWt5TjJ6?=
 =?utf-8?B?TE9mNkZrTmdHRHJyMHVRSVVsSklhNDhrVVhNOHFCZDNkZWdWekduL2lGbVlE?=
 =?utf-8?B?VFdCa2FwVjhuNnc1WnJLWG1wVTExUnJ4Sit0ZFVBTXZXV2tHdk50bkJoMlJV?=
 =?utf-8?B?dGpLc1Z2N09xQ2JTUTkyaGtzNFE0VkV0bmpiS2kxK3dSWmVjNmI3Vm56cW9J?=
 =?utf-8?B?TFBaVEEzSHlocnFRTnBwZm4zYUtnc2RENXlORkIyNXVvS0J5dDhXWm9HTlpT?=
 =?utf-8?B?aVlzbU91NGZGZ0RVVk9oQ09RTmRZK3JvYTdqaG95bGlVSlFLQllzOG9LS051?=
 =?utf-8?B?Vm0vcVJVRDc4VVE4YUNjNEJoVHN6bmQ0SENhV0ZsdFQ1TFZ6YXc4c2xxb243?=
 =?utf-8?B?bmxONUh6dDJDa0kxdEhOdElMTjM2RTU1c2pxOEErc1hObFNWMUk5Z1dmd3RD?=
 =?utf-8?Q?ChifKtrKH7+fURuk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1D82606E212AA439BFD477F0DEADAA2@apcprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6196.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b1a1ec-e2fc-461a-6dd4-08decc25c7c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 04:06:16.9791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icPSeXdhmNtMS781JqigxXcMz/Xj2wGvaJ7i2zvFvxR8t+hBi/zwTDWoZEDGKcq63b5oWOCR6DmLtXz85HdmVE/F/sygxPq/Aqg0IVPUTg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR04MB9315

T24gNi8xNi8yMDI2IDExOjQ3IFBNLCBaaG9uZ3FpdSBIYW4gd3JvdGU6DQo+IFRoZSBuZWVkX2Zy
ZXFfdXBkYXRlIGZsYWcgbWFrZXMgc3Vnb3Zfc2hvdWxkX3VwZGF0ZV9mcmVxKCkgcmV0dXJuIHRy
dWUNCj4gcmVnYXJkbGVzcyBvZiB0aGUgcmF0ZV9saW1pdF91cyB0aHJvdHRsaW5nLCBhbmQgaXMg
Y2xlYXJlZCBpbg0KPiBzdWdvdl91cGRhdGVfbmV4dF9mcmVxKCkuIHN1Z292X3VwZGF0ZV9zaW5n
bGVfZnJlcSgpIGFuZA0KPiBzdWdvdl91cGRhdGVfc2hhcmVkKCkgZ28gdGhyb3VnaCB0aGF0IGhl
bHBlciwgc28gdGhlIGZsYWcgZG9lcyBub3QNCj4gcGVyc2lzdCB0aGVyZS4NCj4gDQo+IEhvd2V2
ZXIsIHN1Z292X3VwZGF0ZV9zaW5nbGVfcGVyZigpICh1c2VkIGJ5IGRyaXZlcnMgaW1wbGVtZW50
aW5nIHRoZQ0KPiAtPmFkanVzdF9wZXJmKCkgY2FsbGJhY2ssIGUuZy4gaW50ZWxfcHN0YXRlIG9y
IGFtZC1wc3RhdGUgaW4gcGFzc2l2ZSBtb2RlKQ0KPiBjYWxscyBjcHVmcmVxX2RyaXZlcl9hZGp1
c3RfcGVyZigpIGRpcmVjdGx5IGFuZCBuZXZlciBnb2VzIHRocm91Z2gNCj4gc3Vnb3ZfdXBkYXRl
X25leHRfZnJlcSgpLCBzbyB0aGUgbmVlZF9mcmVxX3VwZGF0ZSBmbGFnIGlzIG5vdCBjbGVhcmVk
IGluDQo+IHRoYXQgcGF0aC4NCj4gDQo+IEJlZm9yZSBjb21taXQgNzVkYTA0M2Q4Zjg4ICgiY3B1
ZnJlcS9zY2hlZDogU2V0IG5lZWRfZnJlcV91cGRhdGUgaW4NCj4gaWdub3JlX2RsX3JhdGVfbGlt
aXQoKSIpLCB0aGlzIHdhcyBlZmZlY3RpdmVseSBoYXJtbGVzcyBiZWNhdXNlDQo+IHN1Z292X3No
b3VsZF91cGRhdGVfZnJlcSgpIHN0aWxsIGhvbm91cmVkIHRoZSByYXRlIGxpbWl0IGV2ZW4gd2hl
bg0KPiBuZWVkX2ZyZXFfdXBkYXRlIHdhcyBzZXQuIEFmdGVyIHRoYXQgY2hhbmdlLCB0aGUgZmxh
ZyBmb3JjZXMNCj4gc3Vnb3Zfc2hvdWxkX3VwZGF0ZV9mcmVxKCkgdG8gYWx3YXlzIHJldHVybiB0
cnVlLCBzbyBvbmNlIHNldCwgaXQgc3RheXMNCj4gZWZmZWN0aXZlIGluZGVmaW5pdGVseSBvbiB0
aGUgYWRqdXN0X3BlcmYgcGF0aC4NCj4gDQo+IEFzIGEgcmVzdWx0LCBjcHVmcmVxX2RyaXZlcl9h
ZGp1c3RfcGVyZigpIGdldHMgY2FsbGVkIG9uIGV2ZXJ5IHNjaGVkdWxlcg0KPiB1dGlsaXphdGlv
biB1cGRhdGUgKHdpdGggdGhlIHJ1bnF1ZXVlIGxvY2sgaGVsZCkgcmF0aGVyIHRoYW4gYmVpbmcN
Cj4gdGhyb3R0bGVkIGJ5IHJhdGVfbGltaXRfdXMsIGV2ZW4gaWYgdGhlIGRyaXZlciBpdHNlbGYg
bWF5IHNraXAgcmVkdW5kYW50DQo+IGhhcmR3YXJlIHVwZGF0ZXMuDQo+IA0KPiBDbGVhciBuZWVk
X2ZyZXFfdXBkYXRlIGF0IHRoZSBlbmQgb2YgdGhlIGFkanVzdF9wZXJmIHBhdGggYXMgd2VsbC4N
Cj4gDQo+IEZpeGVzOiA3NWRhMDQzZDhmODggKCJjcHVmcmVxL3NjaGVkOiBTZXQgbmVlZF9mcmVx
X3VwZGF0ZSBpbiBpZ25vcmVfZGxfcmF0ZV9saW1pdCgpIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogWmhvbmdxaXUgSGFuIDx6aG9uZ3FpdS5oYW5Ab3Nz
LnF1YWxjb21tLmNvbT4NCj4gLS0tDQo+ICAga2VybmVsL3NjaGVkL2NwdWZyZXFfc2NoZWR1dGls
LmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9rZXJuZWwvc2NoZWQvY3B1ZnJlcV9zY2hlZHV0aWwuYyBiL2tlcm5lbC9zY2hlZC9j
cHVmcmVxX3NjaGVkdXRpbC5jDQo+IGluZGV4IGFlOWZkMjExY2VjMS4uYTRlNjg5ZWVmZGZiIDEw
MDY0NA0KPiAtLS0gYS9rZXJuZWwvc2NoZWQvY3B1ZnJlcV9zY2hlZHV0aWwuYw0KPiArKysgYi9r
ZXJuZWwvc2NoZWQvY3B1ZnJlcV9zY2hlZHV0aWwuYw0KPiBAQCAtNDg2LDYgKzQ4Niw3IEBAIHN0
YXRpYyB2b2lkIHN1Z292X3VwZGF0ZV9zaW5nbGVfcGVyZihzdHJ1Y3QgdXBkYXRlX3V0aWxfZGF0
YSAqaG9vaywgdTY0IHRpbWUsDQo+ICAgCWNwdWZyZXFfZHJpdmVyX2FkanVzdF9wZXJmKHNnX3Bv
bGljeS0+cG9saWN5LCBzZ19jcHUtPmJ3X21pbiwNCj4gICAJCQkJICAgc2dfY3B1LT51dGlsLCBt
YXhfY2FwKTsNCj4gICANCj4gKwlzZ19wb2xpY3ktPm5lZWRfZnJlcV91cGRhdGUgPSBmYWxzZTsN
Cj4gICAJc2dfcG9saWN5LT5sYXN0X2ZyZXFfdXBkYXRlX3RpbWUgPSB0aW1lOw0KDQpOaWNlIGNh
dGNoLiBUaGFua3MuDQoNCkl0IGRvZXMgc2VlbSB0byBtZSB0aGF0IHNldHRpbmcgbGFzdF9mcmVx
X3VwZGF0ZV90aW1lIHNob3VsZCB0aGVuIGFzc2VydCANCiFuZWVkX2ZyZXFfdXBkYXRlLCBvdGhl
cndpc2UgaXQgZG9lc24ndCBtYWtlIHNlbnNlLCBidXQgdGhhdCdzIGEgDQpkaWZmZXJlbnQgdG9w
aWMuDQoNCj4gICB9DQo+ICAgDQoNClJldmlld2VkLWJ5OiBIb25neWFuIFhpYSA8aG9uZ3lhbi54
aWFAdHJhbnNzaW9uLmNvbT4NCg==
