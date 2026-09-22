Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022081.outbound.protection.outlook.com [52.101.126.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974F93BCD05;
	Tue, 22 Sep 2026 05:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790054760; cv=fail; b=s2uTQwpRQisLTs8IY0Ow1mqm0tc+/vASp6Iimb+FR9q9iXhYVK228DChIx+vch8ka98ubU8usX7TQAtgLyUyNrATwr/Gh+HR9VDI0EGGL3aj21L4f+i6vI7Dgm1J3CEVNPNBEyrXNWJxMzWTV/CLFqShaXD296o+dAri1DBFQnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790054760; c=relaxed/simple;
	bh=4pHpPmhfpV2Qcb8wRDsDLy+Gi/yvXc7aQb4tg0B5yiY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AgJEsBZ7UaXcwGJK9IbZujcmmALSWlUno9eDxwfgva5bSpz4ph9qwIG9/le+V/qHbTni9iopi9J68II/1DhgOceeEEY9YG9GiMAba/GcWO34XPx8yQBm6843NebnAuso/N7WtC2Jbodgu5PL0KyBaN3OgpC8t4xAWdEu+z0gDPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=DObsA3li; arc=fail smtp.client-ip=52.101.126.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="DObsA3li"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4gIAQVJKXG1YIdCA32xVWwz+40r2wFKFyW0FU8yIRe+Xt4GSfuuYJgYXDqf+Edjs7PHdOkFcCokTEeYqlXE5nYU3gKkN+Wegzk4FtVfOyCbpGM7QNbl4QN/z3ETkXvICX1+4frfgf+KHkwk2AOd7wL5Bb+MyTiKRP+HlP2CLuafRg6uNtaPfg6gZh2tmYz2+Vyj8hP/x+jZkViSMq1BEpUFmN+dv9u0Gqius88PbGM4xT/qsYrkiVvLz+IfDSgaFv0Js3ujl+dRAOGKRT5aWOjRTY2j7D2kf9BO3BITIVPhXkwk4C+bbJadcI467XmXxINOGbcw1ishw9w5BsfKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pHpPmhfpV2Qcb8wRDsDLy+Gi/yvXc7aQb4tg0B5yiY=;
 b=ha5RxQxcigIr3kVdFjzfv9mXZNaIL0OU658qCKI6VjTEb45SIhf/Tv0JCJXsHjh6ySlVzTkP7f/O8qiVV7haXdS9Fm6Y/JNZvjAzJh3XlCZ2Py7qpEFZDSqhb/h8oFJwlDT5/D3M66/Cme5teNMg86WtHlzrwM7VIYkaTG+j4EfaEBeqHHLZRP419CKDjUsZJ/UkSRpTCLONU+jOBkmLpIDBYfCC8Q6dvOwJSqwd5Qp23Sx4j32DWM2lQdx4B4rg97e8pkuyHans/7KWKjQuEgqWuPt9g24s/BadGrhQo7b3LuFewvRGI2zB4RuQVOy2s/2GdS7mzASM2mVZ8AFfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pHpPmhfpV2Qcb8wRDsDLy+Gi/yvXc7aQb4tg0B5yiY=;
 b=DObsA3li6mV2w8FAMGV+J1CMbUDq1TGzc9X7w5npmPrO+NtloH/oescm4UgrFyvus+2AkMyDmQrPnWT41p6h3vetk24TeHhr+wayInpPHjcUHpw15WqY76EST3dirb3o82zwi27btQd3un05vN5vZjrtzLErYTRATo5Xw9IETaz/k2fMXJoE0VUSpWNw1Y9xn4zuhMqWmkRFbNYLwYJymGtqJZgTPpGMfWr4Ua/3WcJgOTy/Sp6s94kMs+g0piDUbFmqmI6CmJeBQ7j7ioelckG8TGTFmJXQ5spvhJWNCYg4qdVaJl4Mbukpdf6zHrBYi25TRRty71oQu8bChqL4sA==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by KL1PR06MB6347.apcprd06.prod.outlook.com (2603:1096:820:ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 05:25:52 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e%4]) with mapi id 15.21.0406.007; Tue, 22 Sep 2026
 05:25:51 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Borislav Petkov <bp@alien8.de>
CC: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tony Luck <tony.luck@intel.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Krzysztof
 Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3 0/9] Add Aspeed AST2700 SDRAM EDAC support
Thread-Topic: [PATCH v3 0/9] Add Aspeed AST2700 SDRAM EDAC support
Thread-Index: AQHdRZyFCcJDuw2op0azvEk4NXStz7bZ7sFQgAAIRICAACMCYA==
Date: Tue, 22 Sep 2026 05:25:51 +0000
Message-ID:
 <TY2PPF5CB9A1BE6730491EF623D2CC05D71F2832@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
 <TY2PPF5CB9A1BE6D0247845980A7BD60E60F2832@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <20260922031905.GEarHzqf56ypqALDHi@fat_crate.local>
In-Reply-To: <20260922031905.GEarHzqf56ypqALDHi@fat_crate.local>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|KL1PR06MB6347:EE_
x-ms-office365-filtering-correlation-id: 6512e2da-f183-42ef-b3ff-08df1869f79e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|56012099006|4143699003|10067099003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 FTWI5XiHtFQOhM5pygoUIeLc0GdKEqm7j9Rqj77MVc/5Uh60rAR2WbyCQd2EaDTlLuDlg5ywymdk52ib2hQ02j3f7tL5NShql7iN/Q9XSogIfsN1r6k4G2h6fBbZQs0iYRaHKDc/VseTP3Zr9zP+CJKKrnoAnlexqhXJkOyMupkpak9JVp+A5e8wYG8synFjjBGDYmBN3KXwvyol6N11FYeo7SFwBPS2FxB8NZYTTir8BcbAenIIofcn7732G5HNImAwaQehUS7vT7KlkM7F6ass5fAk64yBeL0Uk+Vfmt5EG+zl5BYkmO/sVqRJvvouqB+oYjM7C7r4d712g4Hw36nm5yZXq5wHsTk88fDnlReSdnhAYzx/hJRTc+4LdKiY6/t6E8b8fwlcpN6QIeuA1xy6aKhSjh1ZcV5x6l73t9DRsYGZCr8xSX1+5oLPjtbCad/06n3n2OXaFEgrxymcnVcRQ/SiHEuebMy8sF/hEqEAWa1YsjVis3Y43xn6usG/uKrdKVPvBTo0BHyNR9nAWcCLHG7DlOD277GRWX2Qw0qVx7P88o+8mxbgMpF3dYcwNY2h6LkXK2nD0lh+qZkyQOkmSVckV4s0aO82jnKa6ZjnknltpkTRCXpcLEMexPY1jWPYJoVONsMSqVak51zBNwM5Pet5WYnDl5PVbFzhzvQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(56012099006)(4143699003)(10067099003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azdqMVRBY2VwUDRSLzNpZDRSaE9JUFJoS21sdmIvQ3dXMVY1K2pQWDZmcXlT?=
 =?utf-8?B?R3ZGU1UxYjd2MzNGU0hLdUpTQ1d5NXJ2L1FjWUJ0Z2gveXd3bklQeDNxZ2xV?=
 =?utf-8?B?Ym5vZ0lZcTZQeTRBWkpEZzFJSkhRUXk4aWZpeEJLcDZiK1B1YkIvVloydVl2?=
 =?utf-8?B?L21qMnU1RHR6VEpDalp0djEzSFp5RWQ2aHVQNU0wcHptTUwvMVRONGtHZG5n?=
 =?utf-8?B?YVlBcFRuNktOOGt3Y25zRkIzSU1ESDlRR0YrZVlDYU1lV2puaTlkWUNDWHB6?=
 =?utf-8?B?aTNKTlFNTkpEQnJENjdhZ1U5eTYxMG1WSmxvWW5hUkJFNGVjMHhXeHZKWXF6?=
 =?utf-8?B?V0pxdDJLZUdrNUs2TVBqdytaNG5RdXJYenhQcXBLYnc3MFpnRlFidVFtazdH?=
 =?utf-8?B?MjJBVEhWbzJtTXpKbWhqZU9jSERiQjZrN0ROaTROVTJtUU5kbkhLcXZiWStB?=
 =?utf-8?B?YW9URDd2Yk5UMGxjR3BkZXZxNk5TektTZ3lETlNtWklaaFNpN2Q3di9YamZG?=
 =?utf-8?B?bVhTVWRYcCtuQktLT3dDbDlkeThhaTV4Mmp6ZTAzdExtU2JBR3piVEc2aTM1?=
 =?utf-8?B?ZlFuczlETFlpSTlVNStPcnhEc2ZFTk1JNlptVWhadys4NjE5QWVoV3lCZlV0?=
 =?utf-8?B?K1F5STIrRWdwMWh1MDhlWWJJZ0FLa01xK1hjQmFVZ2QvaTR0ZUVENStnNjkz?=
 =?utf-8?B?blRJTktnTjZsM3Y0WU1HMnlnTGdWMitRaU5DLy9Ta3FHTzNrWksxSkR0d1FZ?=
 =?utf-8?B?QjMvUWJKWHNyVk9LVWpGOWMwL2VqRTJvQkpHVzZsSlZrQVdNWmJEQ2R3amhu?=
 =?utf-8?B?TVVBdURJVGZnOUloamw4ZnBwUVBuZmZYWllNSWZ2YWdSeEozRkZ1VEN0aUNj?=
 =?utf-8?B?TUIzYmNiTmkrRTZ6MC9xSHFZRDkxZzZ1VGxzTmFiWVA0Z2F0dEtIRzN6WU8y?=
 =?utf-8?B?REhNS1ZNZTdpOFdoUFV0Y1RuWWhhQkQxanpZOVJLVENrVGQ5MWRoam9GVzZV?=
 =?utf-8?B?b3VvMEMyanV2QjJwVTNaZExTdHcydGhEMWxSSzhyRHNKNnZxL2U1UEtLS1NS?=
 =?utf-8?B?SU5nT2tPeEc1d0I2cG1jK0x5blM0R2hOdzFrN2xjdDhpY1RXcWRla3RmNFJI?=
 =?utf-8?B?ZWIvRDFBRW80SGRCUU5lRVpKMGM5WkMvNit5NjBhSFp4N2NBMllITlc2UkhJ?=
 =?utf-8?B?SnVOWmRGY05sdmc1WEEvQUlLQjBLNzVTeGNoRmVMRWliVHp1TmZDSTI4K0JZ?=
 =?utf-8?B?dmU2TEhqK2JidWc1UEhVV1dreDJ3QTVtekJQcHpTRzR0RnFnRzlGRm1lTXBU?=
 =?utf-8?B?Q1ZMQmJGcWZjaThob1VqQUxreTBXdHY2elQvclR5QklJd0dJU0d1MWxmTHdv?=
 =?utf-8?B?NGVZZzdDWWM1T1ZEYUFOMFJHTml6cjd2a0VZM2hMczJ6emt3ekI4SEFRMVBH?=
 =?utf-8?B?Zi9ybjR6L0NqK1BBdUJ2ZGdqVXlxQi9nbGZLR0o2UG5ZQ2RaZDd5eG1QNEpQ?=
 =?utf-8?B?Qi9TNk1pcG43NVpkUldqMTdFWlVIbDV5RXNFdmpYV0praFdxU1FHZUVHd3ly?=
 =?utf-8?B?VXZlYVZpenFva3lXQTRWenpHbW1QQktnbW9GY0phK0lQZUc5SGM2ajFmWkEy?=
 =?utf-8?B?bU1rT2pEMXVVV0tsaVVxS012bU04SktDYWlIQmxRd2FBUXRFMk1CUUJmNDA0?=
 =?utf-8?B?VDZqWkVMNHo1ZWxSTHZsQTErUlZuZTJaeHFNWTVvNTJERHhjNEZWQjJiL3M4?=
 =?utf-8?B?L2QvbUtmZXpiazNLZDVuTzFzdFBDbThIL05ZK0lPNkJYYytHVW8vVlpqTHV4?=
 =?utf-8?B?ZTRWbHdiUXBpZ1NQTytyRjFOYWZubmFBZ0V1SnN6K0hkeWwvS3dkNGNUOGd4?=
 =?utf-8?B?VXlTdklWb0ZNc3pUYmRXcStkVWsxN04zRkE5MGNjSnF1REhTZ3VJbFBPODY3?=
 =?utf-8?B?OU1SQVUvbUJyS00zd0hvTE11VDFjWmVGZjdlRUJtQ21GT1pwWjRVOTNzNFJ2?=
 =?utf-8?B?Q3dvNWN1N1l6RDJkWWxvUmo3dC9kREFPWnpWNzdWbUsyT2RPU0NkTE1qaEln?=
 =?utf-8?B?Y2dwWitNc1ZmckFNWDhOZFkrRVoxck5NNlZ5b0Vyd0dZdnIyMEJBZkZTQ2l1?=
 =?utf-8?B?OHRBdGdIU0FnY05xUmpXVkVHcU9XQ0ppenczRnBFZHJJZWZsK3dUY2FndVlt?=
 =?utf-8?B?TWhESVJlaytHOFordE9NZzZydi9oTitkRTJyblNDelgrM2JUMEoybXAyVEZ4?=
 =?utf-8?B?anc0dEF5ZkJ4TWEzNWs3aEY5RStKYW1BNCtBUXNIZW9RTjlyQ2o3cC91Z1I5?=
 =?utf-8?B?enViZ09VTnZVSEoyUTNZVHJRMWpwbnA0bE1vL3dKVDFoSlNURDM2dz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6512e2da-f183-42ef-b3ff-08df1869f79e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 05:25:51.4301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7zYQUjA0Z7y6+4FlPsPAgu0qf5SPUXGLkDFgXKqeuQAm00plvSKhElqROcHC0xOQo+wBtbgHr7r8XVdjkXuujfMtJgvRoGonawGlSlt5xSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6347

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvOV0gQWRkIEFzcGVlZCBBU1QyNzAwIFNEUkFNIEVE
QUMgc3VwcG9ydA0KPiANCj4gSGkgUnlhbiwNCj4gDQo+IE9uIFR1ZSwgU2VwIDIyLCAyMDI2IGF0
IDAyOjUzOjI3QU0gKzAwMDAsIFJ5YW4gQ2hlbiB3cm90ZToNCj4gPiBTdGVmYW4gaGFzIHJlc2ln
bmVkIGZyb20gdGhlIEVEQUMgZW50cnk6DQo+ID4NCj4gPiAgIGh0dHBzOi8vbGttbC5vcmcvbGtt
bC8yMDI2LzkvMjAvMTI5NQ0KPiANCj4gUGxlYXNlIGRvIG5vdCB1c2UgcmFuZG8gcGFnZXMgZnJv
bSBzZWFyY2ggZW5naW5lcyBmb3IgcG9pbnRpbmcgdG8gcGF0Y2hlcywgd2UNCj4gaGF2ZSBsb3Jl
Lmtlcm5lbC5vcmcgZm9yIHRoYXQuDQo+IA0KPiBBbHNvLCBwbGVhc2UgZG8gbm90IHRvcC1wb3N0
IG9uIHB1YmxpYyBNTHMgYnV0IHB1dCB5b3VyIHRleHQgdW5kZXIgdGhlIHRleHQNCj4geW91J3Jl
IHJlcGx5aW5nIHRvLg0KPiANCj4gV2UgaGF2ZSB0aGUgd2hvbGUgZGV2ZWxvcG1lbnQgcHJvY2Vz
cyBleHBsYWluZWQgaGVyZSwgcGxlYXNlIHRha2Ugc29tZQ0KPiB0aW1lIHRvIHJlYWQgdGhlIG1v
c3QgaW1wb3J0YW50IHBvaW50czoNCj4gDQo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0
bWwvbGF0ZXN0L3Byb2Nlc3MvZGV2ZWxvcG1lbnQtcHJvY2Vzcy5odG1sDQo+IA0KVW5kZXJzdG9v
ZC4NCg0KPiA+IFRoYXQgbGVhdmVzIGhpcyBwYXRjaCBhbmQgOS85IG9mIHRoaXMgc2VyaWVzIHRv
dWNoaW5nIHRoZSBzYW1lIGxpbmVzLA0KPiA+IGFuZCB0aGUgZW50cnkgZW5kaW5nIHVwIHdpdGgg
YSByZXZpZXdlciBhbmQgbm8gbWFpbnRhaW5lci4NCj4gPg0KPiA+IFlvdSBzdWdnZXN0ZWQgYSBy
ZXZpZXdlciBlbnRyeSBmaXJzdCwgYW5kIEkgdW5kZXJzdG9vZCB0aGUgcmVhc29uaW5nLg0KPiA+
IEJ1dCB3aXRoIFN0ZWZhbiBnb25lIHRoZSBjaG9pY2UgaXMgbm93IGJldHdlZW4gb3JwaGFuaW5n
IHRoZSBkcml2ZXINCj4gPiBhbmQgc29tZW9uZSB0YWtpbmcgaXQsIHNvIEknZCByYXRoZXIgYXNr
IGFnYWluOiBJJ20gaGFwcHkgdG8gdGFrZSB0aGUgTToNCj4gPiBsaW5lLiBJIHdvcmsgb24gdGhl
c2UgU29DcyBhdCBBU1BFRUQgYW5kIGhhdmUgdGhlIGhhcmR3YXJlIGFuZCB0aGUNCj4gPiBkb2N1
bWVudGF0aW9uIGZvciBhbGwgZm91ciB2YXJpYW50cy4NCj4gDQo+IFRoYXQncyBtdWNoIGFwcHJl
Y2lhdGVkIGJ1dCB5b3UgZG9uJ3QgaGF2ZSB0byB3b3JyeSAtIHRoZSBkcml2ZXIgd29uJ3QgYmUN
Cj4gb3JwaGFuZWQgYW5kIHlvdSdsbCBiZSB0aGUgcmV2aWV3ZXIgYW5kIHRlc3RlciBvZiBwYXRj
aGVzIGZvciBpdC4gQW5kIEknbGwgc2ltcGx5DQo+IGFkZCBTdGVmYW4ncyBwYXRjaCBhdCB0aGUg
ZW5kIGFuZCBhbWVuZCB0aGUgaHVuayBtYXJraW5nIHRoZSBkcml2ZXIgYXMNCj4gb3JwaGFuIGFu
ZCBpbnN0ZWFkIGFkZCB5b3VyIGh1bmsgd2hpY2ggaXMgbWFraW5nIHlvdSBhIHJldmlld2VyLg0K
PiANCj4gPiBJZiB5b3UnZCBzdGlsbCByYXRoZXIgbm90LCB0aGF0J3MgZmluZSAtIHRlbGwgbWUg
YW5kIEknbGwgcmVzcGluIDkvOQ0KPiA+IHNvIHRoZSBlbnRyeSByZWZsZWN0cyByZWFsaXR5IGlu
c3RlYWQuDQo+IA0KPiBMZXQncyBzZWUgaG93IHdlIHdvcmsgdG9nZXRoZXIgdGhpcyB3YXkgZmly
c3QuDQo+IA0KQXBwcmVjaWF0ZSB5b3VyIGhlbHAuIA0KPiANCj4gLS0NCj4gUmVnYXJkcy9HcnVz
cywNCj4gICAgIEJvcmlzLg0KPiANCj4gaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25v
dGVzLWFib3V0LW5ldGlxdWV0dGUNCg==
