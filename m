Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023089.outbound.protection.outlook.com [52.101.83.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15FE36EA82;
	Tue, 23 Jun 2026 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782211138; cv=fail; b=X4ncnufrsxBJoFXVg/5B8knlh5BZhC8uqMaPTV6fNQNuYXdekUy5pTMmj8gMX9twgukHotDNv7HTwEA2DZqSuPUPNPb+6fNRPgOp5g1b1y3LyxpsnQFhVnFMAfur+faDviQrqE8XE2Obj0znC+nc9WRIDFRjj+OTxaJRTHQezEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782211138; c=relaxed/simple;
	bh=3YgDkJjidOCdRi2w+h22x6mUi3zGcKAZlqmxLYZpqWA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ung9qVeoDQy6+PthHpiRJ2xZLoy6mtSnNqeuzCKMFfrnxi3xPW8oKqVJGWkjSxrc9XpPbjvZB6amL5qOX+AJ4JrwmRpBOGQQVscF3jiUQM9tzCrNhVJlX8j/f3O0tE4l3TwLJj9YtqWUT2FzdulX/yCaKwaWiZIEwJeZwL4Cs00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aweta.nl; spf=pass smtp.mailfrom=aweta.nl; dkim=pass (2048-bit key) header.d=aweta.nl header.i=@aweta.nl header.b=Dp3lO4Kx; arc=fail smtp.client-ip=52.101.83.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aweta.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aweta.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aweta.nl header.i=@aweta.nl header.b="Dp3lO4Kx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5OhBuqMBkoptzeXXZ4XiATqwhJ2widS4T+uQMrUvCjWoabEHJEZXJ3TEfM862uwBV+PNCcXaXENnj6kBz3qn5fHvlkn5zk24IRotaI8Ep8eM8R0YMOQjni61XLwwz1AotHHwRZLNSNX5ruPpdeeEnj7zM/UzGcoPZRyKpW9N8zXWlxuRaDOZBTYLW+Jb49WbIwLeYI6J3RaZ9dwgS4JD6am1Bby2lGMD1zSECUiTVKvIBY9CzI3FBTVIixt9wFBK1Wy03aD8r5sM6D9F33exs21TAzwOTiysHRNZbpOHARDf2VzbBmJHXzsoYCrYxrDJU206XFTZtt22gpJWSna1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YgDkJjidOCdRi2w+h22x6mUi3zGcKAZlqmxLYZpqWA=;
 b=wP7zi9wQh2vRLK8sgpS+aeATQqJ+AWiExgTVsvECx+Zo+A9a0RutHsv3h5US9kxxmcD7RWe/VpxrFtlLXu1tQrG80kxKCO+ymW0X6pPQPRxiTGsnDHofwKTKDmS/yGkmAQQmDg1CQtHl5N/K1R3L9OKU+wL+K6ce+3b9siYzBYbTY6nOWr3nNES7UEe4c8EXRmnpygtdTTks7QyUF5eJhXgNc4i/87jTT3Em4jVa8DldvmRIjv4NH5FBTmwYeCEtVRToKOwAooNsunQMx0TXp7/v5Wm7PMgzFzTtMeca7Dkioz4AFfqZ68AUQ102CqRjG0mtP2mP89RHmUYI0rikBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aweta.nl; dmarc=pass action=none header.from=aweta.nl;
 dkim=pass header.d=aweta.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aweta.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YgDkJjidOCdRi2w+h22x6mUi3zGcKAZlqmxLYZpqWA=;
 b=Dp3lO4KxxAZY1rZnbMVj3onK+O6lAu1l0ACL5WunkcJKpVtQlvtuDJzqw0AJfwK8gvZVZSPFY7XjNtLL6ZQFzgjqbzPQtTpyvEAU+WADqKFhRTA9G5RvHtooM4KFoykDJy5BA47/AX1bpIwHEExbHGFLeadw0UFlCiTFgIzhUFGCAWJ8kOSH2s9ftSDjYdeTHCNRqXjyucVCi/y78C528PXnX7DPsNVDCLVqpew+Ffz02aOtRtsN8/wTI9M58tdi0bI2ILSs5fClFNUcl4FI63Z8J+7GPtKZ3ryLw8yJ1OaAlKf99Lx46uPTXKdYywzzYrTeSSVAFGyegO0oxPVjYA==
Received: from PAWPR05MB10691.eurprd05.prod.outlook.com (2603:10a6:102:35a::6)
 by DB5PR05MB10720.eurprd05.prod.outlook.com (2603:10a6:10:48a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 10:38:48 +0000
Received: from PAWPR05MB10691.eurprd05.prod.outlook.com
 ([fe80::3b9c:573e:3c13:3754]) by PAWPR05MB10691.eurprd05.prod.outlook.com
 ([fe80::3b9c:573e:3c13:3754%6]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 10:38:48 +0000
From: Tjerk Kusters <tkusters@aweta.nl>
To: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Kurt
 Kanzenbach <kurt@linutronix.de>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v2] igb: only strip Rx timestamp
 header on the first buffer of a frame
Thread-Topic: [Intel-wired-lan] [PATCH net v2] igb: only strip Rx timestamp
 header on the first buffer of a frame
Thread-Index: AQHc/7tT1+QLGKmA6E2ZCaRCpSVOLLZL8HGAgAAG4rA=
Date: Tue, 23 Jun 2026 10:38:48 +0000
Message-ID:
 <PAWPR05MB106916E499B9B12E25F1A654FB9EE2@PAWPR05MB10691.eurprd05.prod.outlook.com>
References: <20260619-igb-rx-ts-fix-v2-1-d3b8d605ca62@aweta.nl>
 <BL1PR11MB59792FC9956781218FC85B66F3EE2@BL1PR11MB5979.namprd11.prod.outlook.com>
In-Reply-To:
 <BL1PR11MB59792FC9956781218FC85B66F3EE2@BL1PR11MB5979.namprd11.prod.outlook.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aweta.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR05MB10691:EE_|DB5PR05MB10720:EE_
x-ms-office365-filtering-correlation-id: d22f6831-5be4-42f9-b5ff-08ded1139bfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|921020|18002099003|22082099003|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 MfeP1/g+Cs3M/x88/w5aHRVKbABBuhL8jgVC4SKcB9KvcZUSqA79hU4qHvRDz8qLJ9khwc/o0Cv5XmW/DLYfqriS7PHHySFwp7h0j898adbAgEB+Ay/SUx7lct+jGYyQXAHZvq+tcMLlkm7rASja6gDEJ88btSNzz5y8JD2lrY7wUuz392fM61eGUuI8K6dboF18Y3EGmsmvutkcmdtYkXZ7jo9Dw72YkMJdyktatxF+4eP/uog7Zu5BI+rqundW4syEuFblK6HwTkgZDQ5m5W7OG2zZQas4Bxsw4vn+60LIoiwozIbQ57S2/fTpwT3l69U8wD+J6OdJ+wv70eB8LgNAGjALyh4Ocot2NWi5jWdaf90I5YmPoyy0o5FeR6DKCgoAwPS48XBHKh//GFSt2qPdSPl6XMnO06thBZ1nD3o3bGzUN6QgyaB7pOtO26aPfvjaczz8jEgrAtE0NY3PwZfSpxEFBDw1ahfCsLvnlp+JYYD9XaQVxiFJyfMnOscPRkS3+S/uvxXFENjUu14s0lnz7BhF9mRHRlgEvzi9iAi0g0JeFXLoisTUQUmEYAZY/bz7ldxpaUwBmgbb2i+8eMEe+38xWtI/vkqHMrm8JgPZJhFJhc8xyAoBKqIi5LBPkg10LMX7LL2ERAU+Fqepg5nrTvgx3DzVa7SnPbMpgsHpKh1ADOVl91jTTGov7lECgeqQr7FryOYd3HawDE8zF4V27uHZQAzRmItVdBl5Ha2C8Al+fPc4KGxkvvo9mUlR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR05MB10691.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(921020)(18002099003)(22082099003)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGVyY3VSU3o4Ukc1RnJFWTR4emZ4MFdqNHFoUm1jc1JLZkM1cXR6NXNsblNo?=
 =?utf-8?B?WTgwK2RlL2tSa25FdCtnaUR4SHZSbXJGWnpJSDNMQlQrSGxzSEhWUTJ1cXVi?=
 =?utf-8?B?US9qc3d0NDRiRHNyR2RpUFZ2THQ1Tk02UXAxN1pvUC9zTTluVXpjS3M5TTZC?=
 =?utf-8?B?Z2srUjUrNXhVc0VJTThrTExTbW1jMkxGR1VTSFJiL0tUUkZscW5WNGcvaXU0?=
 =?utf-8?B?bGoxMTBncE9lZFZndlBVZDIzaU5TV0xxQ2hjSGdlQ1l4NDUxK2hKNG1qVW14?=
 =?utf-8?B?RTE4OEtHZW9MQTJJRC9PZGZqRTJveVp2NmtLWmw2YkhLbFg3czZDUlVPNlp1?=
 =?utf-8?B?NHRYTXFPRFp1QnEzbzNjOFRROGdjMFFxa3l3OWh5VlVnM0kxVFduQmpOQ09N?=
 =?utf-8?B?eUVUWnVQTC9YUnE5OTJTT0ZZTGg4Sm1iU0ZicTFRUVNFMFM0cEhPUTRESWpY?=
 =?utf-8?B?R3RGOUU3cnArY2dDYWl4Y2lNVVJuZlJSYVlQdEg5S1BMUWdiR1ZoVE5nR3dz?=
 =?utf-8?B?UGRBNFd2QlhEbUFyQVVSWDYzMmtlZFM0OUxyb0NVUmJIMkRVVENTa1hIdEZp?=
 =?utf-8?B?ditXSmNLWTh3RzJsOHh5UXF0VE0xRjdFYmE5cnVFRmdDOGR6Mzk2cGU2MUxH?=
 =?utf-8?B?YStrMGhBZDM2Y3FwQ2lSNTNvTG1DWER0dlZOS2JkWTNyZ2ROWW1mMUlJMVdK?=
 =?utf-8?B?akt4VWdnelZYdkZQK1hxZEZ0UWZ0SFlLV1p5UHVSMVdMZ0U2THpwR1I3WkhY?=
 =?utf-8?B?L1g4YWVsWkRRY3JkV3AwT0JMK2l0Snljd0ZyOEphYlkvU3dYd1lwZG9WdjBW?=
 =?utf-8?B?b2VOM0w3NW1OdmJMUTZXeGZsVUdsblcvd2xNeHZQOTJYZGZKVVNSWFhMcFNw?=
 =?utf-8?B?TEE1MC9VcURjQUxheEZMdnFtUzF3UmFObjA1dDhTYVBTQnU2dFptVVFwd1Bx?=
 =?utf-8?B?eTVQaVRrNG1jakdqRE5tM3dTUkkrbTl6TThJZzN2U0ZEMThwVGVGeFViQWZo?=
 =?utf-8?B?QXEvYlIxZi9ya1hkSjVDSkYySGtNKzdHbzl0Sk4wQVFXTG5zQzNSSWp3Qm5p?=
 =?utf-8?B?azNFQTRSYUI1TExXMGtrQlNsVXBXYzlXM2NjbFY1c1ZOWldONDRueU9Qd3V3?=
 =?utf-8?B?MElaMmZucUdlcStpOGh3dTNzWFNhcVFEaW5VUGFtUDNLcUZ5ajJpUUJyU3J2?=
 =?utf-8?B?cVFpbFZicUNFNHh0WTk0R0FBcy9hTVdVWHhtdWxpa283NFNRZEZxWWdCK245?=
 =?utf-8?B?SURQVG40L0drcURLSncwTXdlVmxGRm5FaGQzQjIvS2JXZXQzTTcwTTJQbXZw?=
 =?utf-8?B?YXlSdUhpRjZCNktLWXlKRVdHanRFeWxQRUgra016ajhvRlg3TFBuZ0R2Z0w5?=
 =?utf-8?B?dlMxSmhFNUhFN1JkbmNibGpDNlFJNXRpRkI5UGFqK2ZrcUgwY2VBUkd0QVE0?=
 =?utf-8?B?NVY2bXpzSnBNUnhrbzlvemxPZmlWSVYzaWFhNEZHNVp4d3V3VW1zT0NWVTYx?=
 =?utf-8?B?ME9zTjB4Q1kwRnJaOUJtTktXT0J3RTE0YU1PQ0xSeVNDQVp0RkdRcFdHZ1p0?=
 =?utf-8?B?NFd4R1BaRGRGWkxkUE5zYU50VVB1ck9KcVh6eWVSUnl1MDJPSkREYm9xTC9V?=
 =?utf-8?B?UG5VV2EzdUorVkQweC9UYzRIYlp1SGhySzhSUnhtQTdta0xVclcyaHRKLzNF?=
 =?utf-8?B?ZnFqbHNPMVQzRDRLbkFaTnpEZDBIb1VzSGNuaWxhYm1BcHRQb1ZZTG82Q3Rx?=
 =?utf-8?B?cUdCWmZvaEdKK0FSbHA4cU5nSGhJL1IvcWV4dGxES1hERWNJSi9XaUlHWXBZ?=
 =?utf-8?B?dnd5WWRsa2crallrbzNXazBhL1pBZkpEenZhUVk3eVFuNDNwMmp6ZzZ6eUFY?=
 =?utf-8?B?WGZLY3l0RjJUUmdzcHFBYU11bGtQcUc1L0xUNmY4WDBSL2lpRFZTSlFaNzBZ?=
 =?utf-8?B?M1lLS1RWSTU4VU9XeElOSWlwemlUVTZjM254ZU9RNkxNbVhYMVhRNzVoMGhy?=
 =?utf-8?B?ZjUyb1dFanhsTXpLOUttRzUzRzVrbUdVR0hsZHVvdGJreE1zVHZJZk10MkFU?=
 =?utf-8?B?dnF1a3h2WE9TcHByL2VMTC9SUDlTTGJ0YklRSEdDZW8valpobm5IaHpJVDls?=
 =?utf-8?B?VWFnckx2VSt6QjZYUzkrYWVxSkR2bXVCZEZyWkx2a214OStHUHJvVUg3VDRq?=
 =?utf-8?B?MlZVK3JXRmE4RDRkN0dWS3NxNStqT1Zkd0R3WHErQVpIa3NBQ1IybG1iVFZu?=
 =?utf-8?B?TEhjeElnc3F3dDIvYWJiOWROOU4vaEZZVGRQMWtPd3duMDdKOVRKM01ITHNa?=
 =?utf-8?Q?G785SXtIFDG5Qx87Na?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aweta.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR05MB10691.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22f6831-5be4-42f9-b5ff-08ded1139bfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 10:38:48.4346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6546512a-ba20-41bf-9d8d-c076dcbf6fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JtFBmtH8ondFQ9cx04zbv67RXCZSnchZdObfx+cu/s+0ELXFC9MzS1VhziPtiZtFmQF8UZtxBkA+I4cVUBW54g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR05MB10720

SGksDQoNCj4gPg0KPiA+ICAgICAgICAgICAgICAgLyogcHVsbCByeCBwYWNrZXQgdGltZXN0YW1w
IGlmIGF2YWlsYWJsZSBhbmQgdmFsaWQgKi8NCj4gSXMgdGhpcyBjb21tZW50IHVwLXRvLWRhdGUg
bm93ID8NCj4gUmV2aWV3ZWQtYnk6IFBpb3RyIEt3YXB1bGluc2tpIDxwaW90ci5rd2FwdWxpbnNr
aUBpbnRlbC5jb20+DQo+IA0KDQpHb29kIHBvaW50LCAgdGhlIGNvbW1lbnQgZG9lc24ndCBmdWxs
eSBtYXRjaCB0aGUgY29kZSBhbnltb3JlLiBJJ2xsIHVwZGF0ZSBpdCBpbiB2MyB0bzoNCg0KLyog
cHVsbCByeCBwYWNrZXQgdGltZXN0YW1wIGlmIGF2YWlsYWJsZSBhbmQgdmFsaWQ7IGl0IGlzIG9u
bHkNCiAqIHByZXNlbnQgb24gdGhlIGZpcnN0IGJ1ZmZlciBvZiBhIGZyYW1lDQogKi8NCg0KVGhh
bmtzIGZvciB0aGUgcmV2aWV3Lg0KVGplcmsNCg0K
