Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082C537649A;
	Mon,  8 Jun 2026 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941201; cv=fail; b=byCegjPmJCO7jzcxHux/4M/19Nq20UmTKbS7fq/+nTxeQIiD6nhUKlKzHXfK1tDV7Z+GugyCiCybyrG6fTEnytmQJElfBW8bl79kUZPWl7QvQzDAWwP+mf+hwc3aKb7vHS3nrjziDfVSunYU/w/UgpfePIYtAYKSnolNZv8fo4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941201; c=relaxed/simple;
	bh=V/EOLM8DGAdkmEJPTulLAlpEfiu1zdVJ/mHgCMwYqj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ehp5Az9ADI5ZYXs27HHrlCsh+XeMBv3UgpmbCRfjiLThktkJVyAlkCxEf/xRB0Yv7JhsMmXLN1ILML7Dz1qiN89mLg+vSJjbc9z1drEeZTR1iMz8usphDJkBBG9J7xfvf/lTF6lrJ2mImnsMRhb6DAiEvpFHoPvZBh9s+UoS1ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VGSh4Clo; arc=fail smtp.client-ip=52.101.61.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VGSh4Clo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGoRZAahaq2BV+CE9JACFR8m65qwbIRat75jwVb7gOfUGDAtcjmTWe8u6xcIp8R9xTaD/oLFNHwgzX1BT5/Wxrosly07LDKuwwpc0GsMwYmxs/lZZfQp0sJ6uQl+jIpsfV2ukXBLRhvG8K1hXUNqcbjvaOKgtvGqarZeJdaLSBKjB+8znTI33SJDX68MB2uTA/iEuMdn/OC7wgFDt50I2uh1RaWGrITocJ/O6qC2+QFpk3nJvHsDOkut2JQOWqJsScEEHPaHTiLNJMpPHE04IGA7IrgxL+w3Jj586ajdxj+mIXA78nLhuyoDNeAPY696xeH3ZO7oDx027KA9PAhWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/EOLM8DGAdkmEJPTulLAlpEfiu1zdVJ/mHgCMwYqj8=;
 b=f72Ayi+vVihv3FOPqJLcJp96rELn8tLUDD3u9W5zyEMBuEBCckAcCFJ54FHKLgtL6BFK82p4K8XKF2acNLqpbsZh+HrHzo20+SwwScOOSGl5lHIVZDdnRYkNEDf9YLhnlm9yMuxuYTzuxMWya/55LIEpuGPpsBQVYxTVJxORLA37uYfS3qlIUvJ3MA2u9W5SfdkQkbWL9SPOlz0m0rHBfW9Aift/w9plDWc4lwFmpUQQb1K1V7JMG92F/YIxcYV4h6YLphhLvB5tX75aW/VHRbDmtotMQQcEyAmBKTzx4ljK58eE7F0YdWjAi5QWMFllGHc5fzsFmupMl2VeRrXLUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/EOLM8DGAdkmEJPTulLAlpEfiu1zdVJ/mHgCMwYqj8=;
 b=VGSh4Clo02ieD9m0Rx7g0P74CBmunCGk3GZBLs3NVki62NXa1fEbeYQl6rtc/QaqWBAbaVU4el9ZQGjCep1EWtnqfeUV6xA0JCBQK9Db2S5Rb6xmEB4ubfBY3pfJGqQgBjI9ZfGKPqU8TBhuzGMHchd1mGjLzJ21Hayl9qzKxIT4aglpwsoiHg4waTQzKOXNGPxjV/rumXCWfYuDBvujvWTOVMFReXH59znO2dw3UPzc+nTa6wc/7/QSxe3TCzttjJB5hFNWb9evPopk57QkJtS/X42q+/q6SG6AaqUR0wpFxnv4KJ3kr1M/7LrbSMoeKv29kQBJsQMvZwBZEiJy3w==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 17:53:14 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 17:53:14 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "dawei.feng@seu.edu.cn" <dawei.feng@seu.edu.cn>
CC: "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>, "zilin@seu.edu.cn"
	<zilin@seu.edu.cn>, "namcao@linutronix.de" <namcao@linutronix.de>,
	"lyude@redhat.com" <lyude@redhat.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	"dakr@kernel.org" <dakr@kernel.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH] nouveau/firmware: fix memory leak on BL load failure
Thread-Topic: [PATCH] nouveau/firmware: fix memory leak on BL load failure
Thread-Index: AQHc9QhQDYV/oMN/d02/Uz0YAF01qbYwRoUAgARrdACAAENQgA==
Date: Mon, 8 Jun 2026 17:53:14 +0000
Message-ID: <0045b3583272df0b82f146fd96dee13d03377b4a.camel@nvidia.com>
References: <aa2e39a828634f20852d066f593f26510fbdc2d9.camel@nvidia.com>
	 <20260608135218.3413471-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260608135218.3413471-1-dawei.feng@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|DM4PR12MB5937:EE_
x-ms-office365-filtering-correlation-id: 8e7a961b-d991-4e25-ca89-08dec586d030
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 lGcxvCokIm31Fyyd9n36o3g20kPced5JBW6Rz/yGVD+NVxQtuSZeO4FUTZv5cBCSB6qL1s3i+tET1JCEBURDiwUvwQFtissNyqBMvi9BbSgNVhHFoDlbsy3x42s8WXvo7gCZdAXr11nWCMHcQ73yiX7oabDkkpcgec54xtzAGI/r+KEIKb9LPw4Gh0+ExnzssM3CF9oXJ3g7ERgF87m3hjvGiJs2009Y+bqU7Uii0882tOGfAu6hvPtnOJ4fmBI7wNXTzu3S/C59Oiv1FzwUjRWHX7m5duBYdrTMe51xunLg/PZE3ocX3E45mddKKzZcpM+GjpEiaxxEEJg5Xq/tnXC7iXkrhd75BiloQsk7REIVHEdMmYqkMT9E18RWZoKGzQ/54J8jhDu9Bwtv5/xLfF1rZjmcozvBK9RCpPgZsp+4NHBjmaIEdW2rBQNdhZPY7Vf+KvIrR3HAmm2Rcy/UQmHfl1mIp0djZyydLZemgeG6x0bSTllYdc6Fv1aUERS5xY+OrA9NfPhZ+aHzR0MXHSav+d8EceobE9HLfHfN9ccozljRHbwUhuiQJimH3akqL+uQb4B5ESg4TluGOWmLjR4vfEzt1tTyhbtfDn4YKjcdgTYAwF8EOQllc1ObpPoT0lyJXxyVfPzHhPvnUwqnWqyLkWzw4PDVCjslGMDlrKRnOjHiCgaHSMIN/rQtH9NImcvijEWLi9Xq5+lru2wTZNrrkNB/OAq/wWVElXVBu0YNXsySiOPakLcBTsvfBfb7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8412.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDRGSlJsNkZXbCtGL0ZDSlJ6M2lRRGc4TGdKM2NHYnF5VE1Jc1RDS0FmQlFk?=
 =?utf-8?B?cy9jd3FNSFFCL0t5TkIwaWUwOTQzTGJBMHRMMFBxMGQzU05CS2ZZaDlxaEQ3?=
 =?utf-8?B?azZBZlU4eWk2SHJqSVJ4VUtWUFYwbjZsb0tob2xxazU0TGpHOG9JWG1WWVVu?=
 =?utf-8?B?QzIraHJ3RkErMW5WZnZ4U2k5TDBEYnZjalFYTjY3ZHBBQzgreFczSElQTjdP?=
 =?utf-8?B?MFF4cGNIMU1HblE2ZFIyVWYyM1UyU1lCbE02aEt5clk3WkpqekZUYlFhOGxv?=
 =?utf-8?B?U0Y0UDI0a016Q21ON3I3ck9hdGhwcytKUGNmMThNRk16NzJwV0lPRGhoK2xx?=
 =?utf-8?B?NnFhUXdkQWJXMEJUSlpnaDNiWlRuaVZtakpxaklxZWZlUFE1NGdoTHNIR1Y0?=
 =?utf-8?B?SitTL1JJRExFN0lORkp5a210UmoxUFo0NUJrNkJESytXS0NMejMxN2ZCaGZq?=
 =?utf-8?B?WHg5UFpCVTh4VWNkVzNvSkFKUzU1Q3pHZlAydGRBa2hobjRhdElSa1hKd2NS?=
 =?utf-8?B?UmRZaGVxem5XcXRsR0ZKKzU1RjU1Q1VaOU50d1p0ZlhwQXVOa3N2cXBpOU8z?=
 =?utf-8?B?Q0hOM2dJaW5Vdk14djNsZVhuSDBSc0hkNnMzZE02VWdoL3VUVm5oQUpRSlMw?=
 =?utf-8?B?c1FSbkxKT2d5Y1NScDBPZW1iZzJFVVRCTWdWbitwRWszWnlPZmFqSEtUNnA4?=
 =?utf-8?B?RytCUFRFclRLZzBOUlYrL0NENXkxanFMZjl0c1ZSQXJjcG5OWkozUUx0RU1i?=
 =?utf-8?B?T1VpT3lYNE00aW5reVZGL09nejJEVi95VEx4RFg1dDlLMnZXUkFBaFUyV2Jk?=
 =?utf-8?B?dnRkU2pWck1iTE8wb2lWdFlyaTFtS0k3QXJpdXU2TCsvNkhzU0N0RmlJYjY3?=
 =?utf-8?B?MVNzdlNPMXNSY1dqYTkvdzh4SnRSZWlWU0FvUVFqU2szQkoxR3AxQXBpa2Z0?=
 =?utf-8?B?Um12ZEtKYjNncitWakZIQVB3QzNHamRjL1RsOTdLTWRtM3BuSzVwWHhUbWR4?=
 =?utf-8?B?dXUrY2YzSlNCeVlpNndmVjRkV2VGWktpS1lSV1EvU0NIRWM3ZXhCdmd2Q3dv?=
 =?utf-8?B?ZDlmODhLNlk1NUR3cGVSKyt1ZVdyU1QrakJCaVRJS0ZtVHZjVzJ4TjlaSjhh?=
 =?utf-8?B?QnMzaEZFQWZvRFB6RWxTTUkrNkRFZXdRVlFIZ3lqYnAvd3RsUk1DZDZWdS9x?=
 =?utf-8?B?cThsUFlrM29Vd2xaUEJVVHdVcExDTXBJcldsZFkwd2NQZk9JdmhpTWIvRWhk?=
 =?utf-8?B?dU1Wa0x4TzEzeVlGNnVWRzl2ZWRDQUIyUFBiWG1ZYmVrWHc0Qkt0TmVHWEN1?=
 =?utf-8?B?NmIrMllmaWpwbmRZQWM2eUN4dmNCN3pHd3RDb2VFUm1LcTQ3ZlR2Wk5pQVhJ?=
 =?utf-8?B?cDJqR3RON3BWSzV4VU11Y0hGV2dTOUZtNmxBM3hteVJKWWJYZUN5NzZqSW01?=
 =?utf-8?B?YXd0YlgzVElmY1VyRW5ycFpXNnEvQTRESjJzdVQ2eHlxQ2ducUJEQ3RPR3lz?=
 =?utf-8?B?UFZHMmJwZmRkenF2cDg3ZGsrcHhpcUtQMktTdzI1eVhuVjZmVkhRU0VpTjhl?=
 =?utf-8?B?TGwrbkhkNEhwVDF3Nld6cURaZ3BsalgzWHNhZjN5d0tPU3grK3RxMys4dmpj?=
 =?utf-8?B?QzZaTDJjNnZtRjVyQWtQc05xR2tXeHAvRlB6b2ROR0VjR1BHRVo3dENiZlFO?=
 =?utf-8?B?bVVRTDBvc3RCanVTSXdRSXJIZUdFd3RFVVVJdjl4Mm05WFN5ekRGVmNvRTE5?=
 =?utf-8?B?WHVuNVQ0SHI2TEtVTkhHaGFYUDU1LzFRdzgvaHZCYWxtNkdlK2hXUCtYYTJn?=
 =?utf-8?B?akxzVlFMcDFJWTFoWWozZlRKdFRLNzhWYnVKaithdU13Mi9maWlYclgxb3V2?=
 =?utf-8?B?bnI3ZXlTR0lCM0lUUmIraHlDaGlxaVIxNEVwcisybTAya3prcmdJUFphVGdl?=
 =?utf-8?B?NHFjNFJ6c1ZJbFFjM2JpSnBLUWtubVJEWmlMb0Q1ZW9lY3Y0VWJ2eVNvemQ4?=
 =?utf-8?B?YkpYYW53Q1BpVmhnMW1FT1VhYktodmdFWDdjNCt0N3R6THd3bGJzL00wc0ox?=
 =?utf-8?B?QmpkQ0RsMXJSeVRyRG8rc1JQcVcyYnpjMjR2L0w3b0Q3NVNDMGlTWktFNVM2?=
 =?utf-8?B?SE9SR2N4WG04dThiaElDLzB1K1g1Wk5zQ3k5anRIVWFnalRDWmpSSy9JQXJ2?=
 =?utf-8?B?cS9xeEhWZUVwRVZZbElMQjg1b091VWJIcGkxZm1IbTBGUnByajNEUHlHeXQy?=
 =?utf-8?B?SGZoTUMyY3dRTkxSVlk2LzN4Q244NW03dGo0dWtsNUdJU3VjUXZuL3VYa3F5?=
 =?utf-8?B?eGxwQmo5R0IrRERpaTlXeHoyZHBDRlEwTkRteTFQYmxlVWVFVVM1QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54F2A99A7D57A740BCBA8BE0C97DF6BC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7a961b-d991-4e25-ca89-08dec586d030
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 17:53:14.1962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: unUwAshXvkxXEGp12PWognjud5yVuvfLkEajp/h63FMf/uQTzxl/quy40n9OBbWH8HajGhFHAUZmyb8Fb1rfzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937

T24gTW9uLCAyMDI2LTA2LTA4IGF0IDIxOjUyICswODAwLCBEYXdlaSBGZW5nIHdyb3RlOg0KPiBI
aSBUaW11ciwNCj4gDQo+IE9uIEZyaSwgSnVuIDA1LCAyMDI2IGF0IDA2OjIyOjQxUE0gKzAwMDAs
IFRpbXVyIFRhYmkgd3JvdGU6DQo+ID4gSSB0aGluayBpdCB3b3VsZCBiZSBjbGVhbmVyIHRvIGlu
c3RlYWQgZGVsZXRlIHRoaXMNCj4gPiBudmttX2Zpcm13YXJlX3B1dChibG9iKSBjYWxsIGhlcmUs
IGFuZCBqdXN0IHJlbHkgb24gdGhlIGNhbGwgdG8NCj4gPiBudmttX2Zpcm13YXJlX3B1dCgpIGF0
IHRoZSBlbmQgb2YgbnZrbV9mYWxjb25fZndfY3Rvcl9ocygpLiBUaGVuIHlvdQ0KPiA+IHdvbid0
IG5lZWQgImJsb2IgPSBOVUxMIi4NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQo+IA0K
PiBJIGRvbid0IHRoaW5rIHdlIGNhbiBkcm9wIHRoZSBudmttX2Zpcm13YXJlX3B1dChibG9iKSBo
ZXJlLiBBdCB0aGlzDQo+IHBvaW50LCBibG9iIHN0aWxsIHBvaW50cyB0byB0aGUgaW1hZ2UgZmly
bXdhcmUgbG9hZGVkIGF0IHRoZSBiZWdpbm5pbmcgb2YNCj4gbnZrbV9mYWxjb25fZndfY3Rvcl9o
cygpLiBUaGUgbGF0ZXIgbnZrbV9maXJtd2FyZV9sb2FkX25hbWUoLi4uLCAmYmxvYikNCj4gY2Fs
bCBvdmVyd3JpdGVzIGJsb2Igd2l0aCB0aGUgYm9vdGxvYWRlciBmaXJtd2FyZSBwb2ludGVyIG9u
IHN1Y2Nlc3MuDQo+IA0KPiBJZiB3ZSBvbmx5IHJlbHkgb24gdGhlIGZpbmFsIG52a21fZmlybXdh
cmVfcHV0KGJsb2IpLCB0aGUgc3VjY2VzcyBwYXRoDQo+IHdvdWxkIHJlbGVhc2UgdGhlIGJvb3Rs
b2FkZXIgZmlybXdhcmUsIGJ1dCB0aGUgb3JpZ2luYWwgaW1hZ2UgZmlybXdhcmUNCj4gcG9pbnRl
ciB3b3VsZCBiZSBsb3N0IGFuZCBsZWFrZWQuDQoNCkFoIHllcywgeW91J3JlIHJpZ2h0LiAgDQoN
ClNvIG5vdyBJIHRoaW5rIGEgYmV0dGVyIGZpeCBtaWdodCBiZSB0byBoYXZlIHR3byBkaWZmZXJl
bnQgYGJsb2JgIHZhcmlhYmxlcywgc28gdGhhdCB0aGVyZSBpcyBubw0KbG9uZ2VyIGFueSBjb25m
dXNpb24uICBCZWNhdXNlIHJpZ2h0IG5vdywgdGhlIG52a21fZmlybXdhcmVfcHV0KCkgY2FsbCBh
dCB0aGUgZW5kIG9mIHRoZSBmdW5jdGlvbg0KcmVsZWFzZXMgYSBkaWZmZXJlbnQgYGJsb2JgIGRl
cGVuZGluZyBvbiB3aGV0aGVyIGBibGAgaXMgTlVMTCBvciBub3QuDQoNCldoYXQgZG8geW91IHRo
aW5rIGFib3V0IHRoaXM6DQoNCgludmttX2Zpcm13YXJlX3B1dChibG9iKTsNCglpZiAoYmwpIHsN
CgkJY29uc3Qgc3RydWN0IGZpcm13YXJlICpibG9iX2JsOw0KDQoJCXJldCA9IG52a21fZmlybXdh
cmVfbG9hZF9uYW1lKHN1YmRldiwgYmwsICIiLCB2ZXIsICZibG9iX2JsKTsNCgkJaWYgKHJldCkN
CgkJCWdvdG8gZG9uZTsNCgkJLi4uDQoJCW52a21fZmlybXdhcmVfcHV0KGJsb2JfYmwpOw0KCQlp
ZiAoIWZ3LT5ib290KQ0KCQkJcmV0ID0gLUVOT01FTTsNCgl9IGVsc2Ugew0KCQlmdy0+Ym9vdF9h
ZGRyID0gZnctPm5tZW1fYmFzZTsNCgl9DQoNCmRvbmU6DQoJaWYgKHJldCkNCgkJbnZrbV9mYWxj
b25fZndfZHRvcihmdyk7DQoNCglyZXR1cm4gcmV0Ow0KDQpUaGlzIHdheSwgdGhlcmUgaXMgbm8g
Y29uZnVzaW9uIGJldHdlZW4gdGhlIHR3byBibG9icywgYW5kIHRoZSBib290bG9hZGVyIGJsb2Ig
ZXhpc3RzIG9ubHkgaW5zaWRlDQp0aGUgaWYtYmxvY2sgdGhhdCBuZWVkcyBpdC4NCg0K
