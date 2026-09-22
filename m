Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022080.outbound.protection.outlook.com [40.107.75.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA235DA40;
	Tue, 22 Sep 2026 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045614; cv=fail; b=Fa+NcTa2dt2Qx9Py5siJtcX9gfJqoClFVxE+Jld13DM3gKEYgPW0tmCRy6tLyZeT6NBC83+oXRB8mZdoqBoKtZyLSOiNpE60UNVNiNJeB5vzwUaVN7AYKDGURdq6USVQDd7d9ZI3b57G77PA1292EtsTVYADlk6IKls5yFKfrB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045614; c=relaxed/simple;
	bh=Be6F0gbDeFJ1rC3JdsB4bRQbewJmZatoibO1hTDBIXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aA4mAqKs4GSp10QEfGNswXq8oHr6f5lesCJE5UgFj98XbB/e2xfQ78AxdnPXXAupxYue8F4CWrlhQsjs3fOTLI5fw5SvlwCgPOzKpRqhtrzn8huh5S4Q91ZeT0lkEDJ/PbzMt7R5neTHXlXpX0onKJ0OCynXVwpdXfJHhAcjtSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Mmf/+pJs; arc=fail smtp.client-ip=40.107.75.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Mmf/+pJs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssMAeXYXZLVsQLM2EhtBnybBafzaAK4hJRL3gfq6v163XhtHFYx9ml+sf2345B2Wn2tz3Yr0F0+e0vWLfX0jRU44CpAmMO7hC9zIgOHaRMRAEGJ8lmf53lqtZNUbKMwlG3EYh539ql5RJHI5OqfXRtmZ1oJtK1g/TdzqOSPGG3pRBlLk/11h4NE+o5rtTqZ5cotvd3m/tQVQgDF3vjkL45lOJS2qusm6bf7g1QscW3dmh4KbMNGhebyU31Yoiuv+pFuBcxYLwYYrTvfVklC79BGiYgpSzggTYwWUNktDzxHILtYAdgNeyMCFyiW2+2csUTk7hkg6Wo8FOz8TUTNqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Be6F0gbDeFJ1rC3JdsB4bRQbewJmZatoibO1hTDBIXg=;
 b=DDs9MD0V0sgO6TPFtQslBwFmwXhKie8oCjLB2A3q9hD6zP4Lmbt3jPI7ZMIBiDpoj4x0dDqCbodjljJGLasgVoI9vOf/hYeD8KhAeRHdLDXVKBjXArhLwVSzIl02BGqZ9Aylr5frqNhVXURQ1Ih7Pa4bjfNIZDlUfsZJh6f+zLjS8iVUG7DXcRwHJsGNs4qr5kBRvsfubqU4BYZJZtMp0dhCy3uR93vXlg/YuC2cn4K985xkJwaI/fn+pTOTwuiP0DBdAnR6G2YKb7DLEf6tr6/z7v6jwXnuIJ3w5TCqW89nnIhajtKNFr9ewsQvDyRFcaVaoBtum3k/HkPU5xrI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be6F0gbDeFJ1rC3JdsB4bRQbewJmZatoibO1hTDBIXg=;
 b=Mmf/+pJsxd7JyzPNDAXf10o5uWXfEerhfIGx1VN3E4Ore9yC8ySVYqui3fnInrgAqrlXaCVAWG9MAQyilCGTBCROtHhOiyOm85/N/Z3jA9njiSdVhEcaPvSdj1BGIkY4WvZZmzZlmod6nYYInEYWyQEfzrYwAnFAm+wfH5N3yLsmAPYYW1XtMSuGu254X0E95Bofn3y87/dEdSyzti121UE/D+P02f11l1cI0Sp6aFZLOqAerMJj/WkTdM3oDUk5/5Egf5CmEzAVDwzvrLHHCerq/y5p5X8S9Onj8Y2g24gmj0MZL4xSeX9DS6DMHY5hlLO4GqN4H8ELbut83ZDnLw==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYNPR06MB8925.apcprd06.prod.outlook.com (2603:1096:405:3c1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 02:53:27 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e%4]) with mapi id 15.21.0406.007; Tue, 22 Sep 2026
 02:53:27 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Stefan Schaeckeler
	<sschaeck@cisco.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Borislav
 Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Krzysztof
 Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3 0/9] Add Aspeed AST2700 SDRAM EDAC support
Thread-Topic: [PATCH v3 0/9] Add Aspeed AST2700 SDRAM EDAC support
Thread-Index: AQHdRZyFCcJDuw2op0azvEk4NXStz7bZ7sFQ
Date: Tue, 22 Sep 2026 02:53:27 +0000
Message-ID:
 <TY2PPF5CB9A1BE6D0247845980A7BD60E60F2832@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
In-Reply-To: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYNPR06MB8925:EE_
x-ms-office365-filtering-correlation-id: 0bf4748f-9fd8-48bd-c1e1-08df1854ad42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|38070700021|6133799003|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Q3qVjhwJ7Bez6/VoTbIyX6ICFIZQMv4mB4woyOvRgQl6VcTPFHAK+PgR86j0VY8t9+JNJwL8dCqmcLy091n6VUd2hPemd/2Dsm9Pmd/Swnxsxd2rJBax7hV69ZTAQ6Xcx75JXekegB1PWB4pnNJG6SLScihypTDGyjGnCtFqwN77mDT2VMQG4FA5rTTVatpyd0fWVDM+xHdOa3frannRWVmKq/vcAEjY1otMFR1LuiRzH8RvmzdJ4WPwn54brqD2++nPQCJGbqpzHeygfamE0RgkB+VmXHsgT0QYCwuk11/h9sqi9A3tzFynm3PVpQxVNI7A7Wt7xo9wDnYdaNPZsJmOxTz0yLkYvaLhoItSMsoPzG5SB7qQ6GZGZ6ih1a2JxWIN1g2IGJilrgzf5YtG2VOCwrss4HeqNRPc809wIVhU7gK45Qx5mJbBfHfAz4vX98OX1korhiVJCrfa/o4zwU5kMbRX0p5k8GJJ7KbdWAdBl3bK3eYik/4q/cH9sghAcYxlxZK4d/aLqHscg0HQGFgXiQdMFCsqn6VklPCtGXr6mSGXtXG7d1uac0h9FLnkPCuNTm8WNUqVpuaFomVivG92rRV9F/tYRXllDKmr/eKsL+fBX19rGsReF7bRG2H8tDDVc5IqXPMDfoWbQ5zONPe6dLACxWEDLWX2F+CAwgA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(38070700021)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHdhU2VWeXliRDVqQXVJKzk2NXpsTlFxQ3JBeDhldCtDVzZhR0FhTzhXbTdK?=
 =?utf-8?B?Ymd3NEIvQXVLY0YrSERyS3lZUVRtNGdTa0V0Q0V5d3Z4a1A5cWJubXpvQzNK?=
 =?utf-8?B?UFhCNmFyWEFKREFQbHdsQ2NzbndoelczU3l2dnpQMUFyektGZjVGRUwxMnND?=
 =?utf-8?B?cVZKOVZTNTFpR1N3eXhIaUZ1T3hXbzNDYXFPek5mTCtmSDJ1Z1BSMlhzSEJT?=
 =?utf-8?B?d21rbXhrZHhpOXRpcS9BS3VOYkFqdzFqVnVBVk5hcTd1RDQ3a3F0TDQ5UG44?=
 =?utf-8?B?SEZ1dmI0ZFBvWk1KZkpiOFFBOHo1UHdBa2p4andsQlFiWmxWWGJQcUZCcEdM?=
 =?utf-8?B?b0pVY1pIN3dVTyttWnhuKzRWQTdHdHB5L0lsRTZTWWdWY1ZlbXFoejhRWk1Z?=
 =?utf-8?B?eUh6eTZaSVpCQ3Bja2ZuOUlla2ZEcTh6YjNBQ0xVNUI2aGlNVUNQMEJ4eFp1?=
 =?utf-8?B?NFBKSGlVSEpUVmRYZEZCcVpLdkRUdXQ1SkVjM1dQT05IaHlLOXFrNENLS2wr?=
 =?utf-8?B?VVVrRlpEaVVwL3dUVTBzSWhJVHUrU1JvUmRKVFpLVlc5UjNhdEJhK3B5WEQ3?=
 =?utf-8?B?NE16eWFqS0ZJTHBsY2xZK3FUazVKQks5UXBoUjV0Qm5rUjF1bTZyUDk5T3U5?=
 =?utf-8?B?d2xnRHptN1hzdUJoM0JWRnV5NEJHM2owYjRIaDFTYUU4OTVXNVROdWZLZU9V?=
 =?utf-8?B?ZUJmNzQ4Ylh5OWdBem9aVEMxK3drYmFiWnFtdkIxK2lEZndsOENMSklCVjdH?=
 =?utf-8?B?Qm9rRjJUM1J4YUtCdFc0T0pINHhjY2ZYbzdQbThSN2dTeGxpR3crUW9kYk9Z?=
 =?utf-8?B?VllRQTNEaEMzYTNPY1BPUUcvY29BL00ybHgvdWpmSkdwTWxzZUYvdVdiMVRj?=
 =?utf-8?B?TktVUWlsU3B1cTZKZ0QyeE50SjVCcHF5czJybVZOaFV3TE1wL2RianI4S3hs?=
 =?utf-8?B?U0gwbWFUaUJVSmZsS1JiYmZtNDh0allGK3VWak5QM3JxcVlpbWR3MnhGNGV0?=
 =?utf-8?B?N0x4VTBKVXFqUFZEa1dlUkV0UG9iZjZZYUhJWStzVWpSS0JYNDIrMGh3K3RK?=
 =?utf-8?B?eXV6OU9WdGRRN0RqbFh5WDJJSGpSTHhkWVJCcHUydVMyZDByVGN0N1NMb0FR?=
 =?utf-8?B?Zzd2cktvSys1Y1pxLzNjbFBIZnVhREppZDZBa2V3N3pUWmUvVFZKdUxpYTlU?=
 =?utf-8?B?MzNmeWtDd1JTM0dwUkQ0R0wyVUdCMWlhbWFOUTcrdnJFbkRSRkx2RGVrV09q?=
 =?utf-8?B?VWlJRG1TSzJKTDIxWTU4ZlF3TlhxRVorUXpqQnVodWduZUhXdzNxeWcza0E0?=
 =?utf-8?B?UjlZNWYzWHNxZlpnbnhHekZnT3k0bTRDeWxsWmNNUTU2WTdKZjB6aTVDZWRa?=
 =?utf-8?B?WWZZQy9lNDFkYU1adWpKYzhrNU1xcmdkUXRwQS90amxiRGpPOHFVVTEzbi9I?=
 =?utf-8?B?MjBUcHNIc3ovUDVKNXhhTkNLc0l5RFZVS1A2cElZVnoxUWp6OEZZYmxrdXNG?=
 =?utf-8?B?dFVUNkFUUFRpSlZMakJOdDhrL3lmd2JKUnlvaDY4cG1ZMVZ3NFQ2S1FRVzNU?=
 =?utf-8?B?UWFDbXBhaFUyWERhbHd6ZFFWSWJlTGlXMVg3NGNxeDFFVFJnRXB0UFNGMC9T?=
 =?utf-8?B?QkJrNTQwek1yTmJNUWFrbDdTOE05dC84eCtyc08zYTBrOFNFN0VoVjFXZUlP?=
 =?utf-8?B?TUtQcDFqK28xbjVxVk9rYmQwRUh5VGczbjdVcTQvQmFzd1hHTDlTUW1ITkEw?=
 =?utf-8?B?c3pmaC93ZzhVYmFQd2R6ZCttaHowYUQ2MDMrVlBaN1dxbkRyZTV1aWxRbWhv?=
 =?utf-8?B?VHpiV0JwL2ZvdkV1TFh4TThFVUJSRWZJYU11RzJ0bW5oaTNXZXFkRXBJRCtC?=
 =?utf-8?B?ZlVnQ0NWaGpDaEMyemlmcGNNdkRpbjBRbVNOaENtVC9HNWZjdmJ0UnBJbFAy?=
 =?utf-8?B?TGFZcXRFZCthVWdPVUt3YWErc1EyN3ZlalYzNUZOVmlBYmoxS295djZ6RzN4?=
 =?utf-8?B?VEJjSUttQnpmS09pOGpOUlhtcll6MzBaUHY4YlV0a3hpUExGR0hxeUVTYS9a?=
 =?utf-8?B?bmFGRG5adm9iYTBkWkRHblRYQlM5cnp3ZGk3MHFONlhidkkvY2xtQ2U2cmdx?=
 =?utf-8?B?T0NMNmZBZ0VpaVFIL1NkWlFvY0JxSWdHRFhvaFIwN0VPcUM1Yktjc3UxalZM?=
 =?utf-8?B?dHcrWWwwNFVPeTJYWi94Zmk4QmRZUVFxQmZHSlNKZ3lvcnFnOW1CYlkrSW9I?=
 =?utf-8?B?bFZPV1BrQWVsQ0tHZTVoT0JBNFBoZVpja2NVSHhhV0xQK0ZsSUpnWmZSOE1x?=
 =?utf-8?B?SVdFT3pqc09mQmJDVGNTc01EeTk0OWJsT1FuUU8xZVVJMEVpRlVodz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf4748f-9fd8-48bd-c1e1-08df1854ad42
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 02:53:27.2710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4xkf7t1TwLemlBjIS7ANC6n7EbrLIVRJz4TXfo5q4AFproZKAAi7OLCBtAdoQ9KmiYPXEGN/txCDW3EEGKbh4pZe7fhDjnegsbmlEB7Dhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8925

SGVsbG8gQm9yaXMsDQoNClN0ZWZhbiBoYXMgcmVzaWduZWQgZnJvbSB0aGUgRURBQyBlbnRyeToN
Cg0KICBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyNi85LzIwLzEyOTUNCg0KVGhhdCBsZWF2ZXMg
aGlzIHBhdGNoIGFuZCA5Lzkgb2YgdGhpcyBzZXJpZXMgdG91Y2hpbmcgdGhlIHNhbWUgbGluZXMs
DQphbmQgdGhlIGVudHJ5IGVuZGluZyB1cCB3aXRoIGEgcmV2aWV3ZXIgYW5kIG5vIG1haW50YWlu
ZXIuDQoNCllvdSBzdWdnZXN0ZWQgYSByZXZpZXdlciBlbnRyeSBmaXJzdCwgYW5kIEkgdW5kZXJz
dG9vZCB0aGUgcmVhc29uaW5nLg0KQnV0IHdpdGggU3RlZmFuIGdvbmUgdGhlIGNob2ljZSBpcyBu
b3cgYmV0d2VlbiBvcnBoYW5pbmcgdGhlIGRyaXZlciBhbmQNCnNvbWVvbmUgdGFraW5nIGl0LCBz
byBJJ2QgcmF0aGVyIGFzayBhZ2FpbjogSSdtIGhhcHB5IHRvIHRha2UgdGhlIE06DQpsaW5lLiBJ
IHdvcmsgb24gdGhlc2UgU29DcyBhdCBBU1BFRUQgYW5kIGhhdmUgdGhlIGhhcmR3YXJlIGFuZCB0
aGUNCmRvY3VtZW50YXRpb24gZm9yIGFsbCBmb3VyIHZhcmlhbnRzLg0KDQpJZiB5b3UnZCBzdGls
bCByYXRoZXIgbm90LCB0aGF0J3MgZmluZSAtIHRlbGwgbWUgYW5kIEknbGwgcmVzcGluIDkvOSBz
bw0KdGhlIGVudHJ5IHJlZmxlY3RzIHJlYWxpdHkgaW5zdGVhZC4NCg0KUnlhbg0KDQo+IFN1Ympl
Y3Q6IFtQQVRDSCB2MyAwLzldIEFkZCBBc3BlZWQgQVNUMjcwMCBTRFJBTSBFREFDIHN1cHBvcnQN
Cj4gDQo+IEFkZCBFQ0MgZXJyb3IgcmVwb3J0aW5nIGZvciB0aGUgQXNwZWVkIEFTVDI3MDAgU29D
IHRvIHRoZSBleGlzdGluZw0KPiBhc3BlZWRfZWRhYyBkcml2ZXIuDQo+IA0KPiBUaGUgQVNUMjcw
MCBtZW1vcnkgY29udHJvbGxlciBrZWVwcyB0aGUgc2FtZSBvdmVyYWxsIEVEQUMgcHJvZ3JhbW1p
bmcNCj4gbW9kZWwgYXMgdGhlIGVhcmxpZXIgQXNwZWVkIEJNQyBTb0NzLCBidXQgdXNlcyBhIGRp
ZmZlcmVudCByZWdpc3RlciBsYXlvdXQsIGENCj4gc3BsaXQgaW50ZXJydXB0IHN0YXR1cy9jbGVh
ci9tYXNrIHNjaGVtZSBhbmQgRERSNC9ERFI1IG1lbW9yeS4NCj4gUmF0aGVyIHRoYW4gZm9yayB0
aGUgZHJpdmVyLCB0aGUgZXhpc3RpbmcgY29kZSBpcyBmaXJzdCB0aWRpZWQgYW5kIGdlbmVyYWxp
c2VkLA0KPiB0aGVuIHRoZSBBU1QyNzAwIGlzIGFkZGVkIGFzIG9uZSBtb3JlIHBlci1Tb0MgdmFy
aWFudC4NCj4gDQo+IFBhdGNoZXMgMi01IGFyZSBidWcgZml4ZXMgYW5kIGNsZWFudXBzIHRvIHRo
ZSBleGlzdGluZyBkcml2ZXIuIFBhdGNoZXMgNiBhbmQgNw0KPiByZXdvcmsgdGhlIGltcGxlbWVu
dGF0aW9uIHRvIGFjY29tbW9kYXRlIHRoZSBBU1QyNzAwLiBQYXRjaCA4IGFkZHMgdGhlDQo+IEFT
VDI3MDAgc3VwcG9ydCBpdHNlbGYsIGFuZCBwYXRjaCA5IGFkZHMgYSByZXZpZXdlciBlbnRyeSBm
b3IgdGhlIGRyaXZlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gQ2hlbiA8cnlhbl9jaGVu
QGFzcGVlZHRlY2guY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBFc3RhYmxpc2gg
dGhlIEFTVDI3MDAgaW50ZXJydXB0IG1hc2sgaW4gdGhlIGRyaXZlciByYXRoZXIgdGhhbg0KPiAg
IGRlcml2aW5nIGl0IGZyb20gdGhlIHJlZ2lzdGVyJ3MgY29udGVudHM6IGFzdDI3MDBfc2V0X2ly
cSgpIG5vdw0KPiAgIHdyaXRlcyB0aGUgbWFzayBvdXRyaWdodCwgbWFza2luZyBldmVyeSBzb3Vy
Y2UgYW5kIHVubWFza2luZyBvbmx5DQo+ICAgdGhlIEVDQyBvbmVzLCBhbmQgdGhlIG1hc2sgaXMg
ZXN0YWJsaXNoZWQgYmVmb3JlIHRoZSBpbnRlcnJ1cHQgaXMNCj4gICByZXF1ZXN0ZWQuDQo+IC0g
TmV3IHBhdGNoOiBhZGQgbXlzZWxmIGFzIGEgcmV2aWV3ZXIgZm9yIHRoZSBkcml2ZXIgaW4gTUFJ
TlRBSU5FUlMuDQo+IC0gVGVzdGVkIG9uIGFuIEFTVDI2MDAgd2l0aCBDT05GSUdfUFJPVkVfTE9D
S0lORz15OyBpbmplY3RlZCBjb3JyZWN0YWJsZQ0KPiAgIGVycm9ycyBhcmUgcmVwb3J0ZWQgZnJv
bSB0aGUgaW50ZXJydXB0IGhhbmRsZXIgd2l0aCBubyBsb2NrZGVwIHJlcG9ydHMuDQo+IC0gTGlu
ayB0byB2MjoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MDgyNC1lZGFjLXYyLTAt
YzhkOGJiNjkzNTg2QGFzcGVlZHRlY2guY28NCj4gbQ0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4g
LSBOZXcgcGF0Y2g6IGZyZWUgdGhlIEVDQyBpbnRlcnJ1cHQgYmVmb3JlIHRoZSBtZW1fY3RsX2lu
Zm8gaW4NCj4gICBhc3BlZWRfcmVtb3ZlKCkuIFRoZSBpbnRlcnJ1cHQgaXMgcmVxdWVzdGVkIHdp
dGggZGV2bV9yZXF1ZXN0X2lycSgpIGFuZA0KPiAgIGlzIG9ubHkgcmVsZWFzZWQgYWZ0ZXIgLnJl
bW92ZSgpIGhhcyByZXR1cm5lZCwgc28gZWRhY19tY19mcmVlKCkgY291bGQNCj4gICBmcmVlIHRo
ZSBoYW5kbGVyJ3MgY29udGV4dCB3aGlsZSB0aGUgaGFuZGxlciB3YXMgc3RpbGwgcnVubmluZyBv
bg0KPiAgIGFub3RoZXIgQ1BVLg0KPiAtIEFjcXVpcmUgdGhlIHJlZ2lzdGVyIGxvY2sgd2l0aCB0
aGUgaXJxc2F2ZSB2YXJpYW50IGluIGluaXRfY3Nyb3dzKCkgYW5kDQo+ICAgaW4gYXNwZWVkX3By
b2JlKCkuIFRoZSBpbnRlcnJ1cHQgaGFuZGxlciB0YWtlcyB0aGUgc2FtZSBsb2NrIGluIGhhcmRp
cnENCj4gICBjb250ZXh0Lg0KPiAtIE1vdmUgdGhlIGRldl9kYmcoKSBvZiB0aGUgaW50ZXJydXB0
IHN0YXR1cyByZWdpc3RlciBvdXQgb2YgdGhlDQo+ICAgcmF3X3NwaW5sb2NrIGNyaXRpY2FsIHNl
Y3Rpb24gaW4gdGhlIGludGVycnVwdCBoYW5kbGVyLg0KPiAtIE9wdCBhc3BlZWRfZWRhYy5vIGlu
dG8gY29udGV4dCBhbmFseXNpcyBpbiBkcml2ZXJzL2VkYWMvTWFrZWZpbGUuIFRoZQ0KPiAgIGNo
ZWNrIGlzIG9wdC1pbiBwZXIgb2JqZWN0LCBzbyB3aXRob3V0IGl0IHRoZSBfX2d1YXJkZWRfYnko
KSBhbm5vdGF0aW9uDQo+ICAgYWRkZWQgYnkgdGhlIHNhbWUgcGF0Y2ggd2FzIG5ldmVyIGFjdHVh
bGx5IHZlcmlmaWVkLg0KPiAtIFJldHVybiBJUlFfTk9ORSBmcm9tIGFzdDI3MDBfZHJhbWNfaXNy
KCkgd2hlbiBubyBFQ0MgaW50ZXJydXB0IHN0YXR1cw0KPiAgIGJpdCBpcyBzZXQ7IHRoZSBoYW5k
bGVyIGNsZWFycyBvbmx5IHRoZSBFQ0MgYml0cywgc28gdW5jb25kaXRpb25hbGx5DQo+ICAgY2xh
aW1pbmcgdGhlIGludGVycnVwdCBjb3VsZCBsaXZlbG9jayB0aGUgbGV2ZWwtdHJpZ2dlcmVkIGxp
bmUuDQo+IC0gVGVzdGVkIHYyIG9uIGJvdGggQVNUMjYwMCBhbmQgQVNUMjcwMCBieSBpbmplY3Rp
bmcgYSBjb3JyZWN0YWJsZQ0KPiAgIGVycm9yIHdpdGggdGhlIG1lbW9yeSBjb250cm9sbGVyJ3Mg
RUNDIGVycm9yIGluamVjdGlvbjsgZWFjaCBpcw0KPiAgIHJlcG9ydGVkIGFzIGEgQ0Ugd2l0aCB0
aGUgZXhwZWN0ZWQgZmFpbHVyZSBhZGRyZXNzLg0KPiAtIExpbmsgdG8gdjE6DQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3IvMjAyNjA4MTItZWRhYy12MS0wLTAzOTkyZWRlYTI5N0Bhc3BlZWR0
ZWNoLmNvDQo+IG0NCj4gDQo+IC0tLQ0KPiBSeWFuIENoZW4gKDkpOg0KPiAgICAgICBkdC1iaW5k
aW5nczogZWRhYzogYXNwZWVkOiBBZGQgQVNUMjcwMCBTRFJBTSBFREFDDQo+ICAgICAgIEVEQUMv
YXNwZWVkOiBTZXQgdGhlIERJTU0gZ3JhaW4NCj4gICAgICAgRURBQy9hc3BlZWQ6IEZyZWUgdGhl
IGludGVycnVwdCBiZWZvcmUgdGhlIG1lbV9jdGxfaW5mbyBvbiByZW1vdmUNCj4gICAgICAgRURB
Qy9hc3BlZWQ6IENsZWFuIHVwIHdoaXRlc3BhY2UgYW5kIGluY2x1ZGUgb3JkZXJpbmcNCj4gICAg
ICAgRURBQy9hc3BlZWQ6IEZyZWUgdGhlIG1lbV9jdGxfaW5mbyB1bmNvbmRpdGlvbmFsbHkgb24g
cmVtb3ZlDQo+ICAgICAgIEVEQUMvYXNwZWVkOiBSZXBsYWNlIHJlZ21hcCB3aXRoIGRpcmVjdCBy
ZWdpc3RlciBhY2Nlc3MNCj4gICAgICAgRURBQy9hc3BlZWQ6IEFic3RyYWN0IFNvQyBkaWZmZXJl
bmNlcyBiZWhpbmQgY2hpcCBkYXRhDQo+ICAgICAgIEVEQUMvYXNwZWVkOiBBZGQgQVNUMjcwMCBz
dXBwb3J0DQo+ICAgICAgIE1BSU5UQUlORVJTOiBBZGQgYSByZXZpZXdlciBmb3IgdGhlIEFzcGVl
ZCBFREFDIGRyaXZlcg0KPiANCj4gIC4uLi9iaW5kaW5ncy9lZGFjL2FzcGVlZCxhc3QyNDAwLXNk
cmFtLWVkYWMueWFtbCAgIHwgICA2ICstDQo+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL2VkYWMvTWFrZWZpbGUg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL2VkYWMvYXNw
ZWVkX2VkYWMuYyAgICAgICAgICAgICAgICAgICAgICAgICB8IDQyNg0KPiArKysrKysrKysrKysr
Ky0tLS0tLS0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgMjg1IGluc2VydGlvbnMoKyksIDE0OSBkZWxl
dGlvbnMoLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA1NDY0OTg1ZTQyYzA0ZTMzNWZiMzBlMzhm
YmM0MDljOTk3ZGI5YmVjDQo+IGNoYW5nZS1pZDogMjAyNjA2MjUtZWRhYy04ZTk2MGUwMmU3ZjcN
Cj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVk
dGVjaC5jb20+DQoNCg==
