Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C3C3E92B7;
	Wed, 16 Sep 2026 06:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539011; cv=fail; b=gTZYOiKY2Uea3rk28l5IHhxTCqmk92/+3tJ4O3Fgr+rgTCuhLBXvCLOJJ/JNwrE+jurs5Uyqzo7iYM6/pYSybx/vFYGpX74vKg/WuwV57H/eHyQ8zO1snk209gwyw/j1aYk5Jktuu4sYr4NRfMyiO5p0wAV8/bWQNcSdnL0dPvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539011; c=relaxed/simple;
	bh=G/eg2PhsDoXR0HJ4bHAKi/YHHT4cpoYVDcUMGO/mQUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MgBvzaMDc+skOG9FzCOSBpvnJO2LpqYV9Y0WzepvhHe5oneo5uiUOH5Om2SppK4MQVGo+y24FSzVjARqys5Ada08HUlP3h7sbdSSGaKgeDWH0PTw8Fx4Hi4z+35BPAO/VNsPtq0zWF3mxY6UxH7A8sorLax1nF0VYZEEyu8mqFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=irCEiA+T; arc=fail smtp.client-ip=40.93.198.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="irCEiA+T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zdg3I+EJS/C4CTCCYmvw3ZvRx0r/QNipvTy6mWXBWecGrTAmUkAhW/clLuN5K88KMLoePT/fGLsfcNmpfPv0x+saTxCXC9PsxB05Uvh38lbD1ujiaShs3axrn+tb1naK3iS9vB1EblvMTpacqnVCxeehQlGddkVAG+kd6+HqlLT+CJJyZT5XU4FVji8F0XtdB9/TH+Rbwi/GSnpyb/ze3yKcEMF6T6LdvWSiOLYQSrILuNSkSKjcCOC+xpGjThyI4MXy30dnB+a5wPX4ivIVvOU7wSVlq1745D/evXYdvy311NDkaNHb5AGQIiv9iLJOCHBQ0uei9qdons39lY+l4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/eg2PhsDoXR0HJ4bHAKi/YHHT4cpoYVDcUMGO/mQUA=;
 b=RU/ZpP1Z2to34DW/SqBONQe8zKjb88ztj22kwwcCuos6UQsaSkbSSyC7xZQtn/TYyv076NyoyNmzisnt/uCANWRKTUlzQtlFe8OLKvmjUmhtZU8MeoqsRSKxYjpC2/UpQRj7Rg28YQoeOkHmFCQ7LchCjecO72gAkdkj6Q9BOmtKOFbMJvdP9XDCjsVnmLnJnLqlgsSxzTt7uEaLM/1uCcKp4uaS2uip07zD3MxvccVLr+DHzQl80sxp/rNRmDbHS7jwEc+kW6aYaJUsUmWoeAe4qKxGSyI/SI3URUjifL0rZuNIEVj9ZWsPTZvZsxdqQiV3buZetDrKMLE9weA6ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/eg2PhsDoXR0HJ4bHAKi/YHHT4cpoYVDcUMGO/mQUA=;
 b=irCEiA+TLnfTFuB3zsJ3nyCVi+YXFV3EHgU9XPyYZm5N0D6nDDUNdM2lqM3I5zr9iykniQHqTTCeyxTghLsiI1umMv2Im3pjR/6htcC8wYVLn17RTvZy+5JboBUWwl+HdNSkS+n8rrF13WUumtXwi9sROuyNHVQrpU62QGpeJiwPcB8/BmhbR6kqnLEbTz18Q+kyd7MNt5WJtzNbmQEVZM09Z7ceyWkrZZTMHWxTp+8yUCLNnPqxvC85jmmuLk9M9C0Rx8Ajj3nk980XE2rfMYcUoS/s+86YpLm27K4a/yfbFAZOmd7VbzNuvCLjIYm8cOdWFmHGdQFZQo1pfgSkFw==
Received: from IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 06:10:03 +0000
Received: from IA1PR12MB7496.namprd12.prod.outlook.com
 ([fe80::f543:a776:e72a:76bf]) by IA1PR12MB7496.namprd12.prod.outlook.com
 ([fe80::f543:a776:e72a:76bf%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 06:10:03 +0000
From: Wayne Chang <waynec@nvidia.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Hunter
	<jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: ucsi_ccg: Add retry mechanism in ccg_read
Thread-Topic: [PATCH] usb: typec: ucsi_ccg: Add retry mechanism in ccg_read
Thread-Index: AQHdQG/kQxaTpjpOT0ez7Y6e/leW0rbJOvYAgAeIMIA=
Date: Wed, 16 Sep 2026 06:10:03 +0000
Message-ID: <18ccdcbb-66ed-421f-b0cc-e10c230b6eb7@nvidia.com>
References: <20260909152805.6254-1-waynec@nvidia.com>
 <aqPhQPUh6ZkpCPp0@black.igk.intel.com>
In-Reply-To: <aqPhQPUh6ZkpCPp0@black.igk.intel.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7496:EE_|DM6PR12MB4121:EE_
x-ms-office365-filtering-correlation-id: ff5423ff-3692-4d0f-832d-08df13b925d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 BEkJxytlIhRwSsNvqQMo6GKKejlAEUp0dZ2zHBpB92eU01KwPJ4+8gMN6ItO4cUyZaeTwvF0JE/eTozEsvvyGM5ewJ2t5C3l32BKCoYLbxvz2wNhUCCVUSiYaTwO26Fj6SEa2Vmv7m5pnUN0QCBOGhbypyqRENXL3dIoX99RMeAcp6FxS3ULU/w7lm6Jb+W9H8JZdp1ftHm4OYl9Rhh0XRk2YYUr97fGvXWx52YhikC7VLaGoMInTUTDtZke/HNSH05N7rbxDTlxDTb3grNuLa3NtUHlNjodAN8lYzaT1sKcLCFIU8QBLbguw15PO+nAXQRozE40ZnE3mm+0c10qj2UUSbsbZ1CPono2E3kuWrSJzCTUBh5PZoe3s4vHa+G9re7KaHZg+oRv4DR9BE+XnGAE66sORCsQ7nmF8gmui1UzI5E2UmFwSXcOvTdBOImpYxy3/4Jl3bYhqhHlrugH/oUO6BkFE+tB+3zOZJSiv/GwV5B1maiviWHSB/Ls+JTpJpmoONOoR1BttJdElGt9W1ZTa9HDStnn7sKckzoFkX/JJy2R8QZEYSvVTp/qPj1px80IMy02O6eoaqxSn5OLHe38OZuHGOGuZiMu4WB44Zpt1Cb6nUumtgbSyx1xiff2NdlkR64YLNUeUk6DgMBsUZR/o2X+7X8qcarHaWBlo/st2piIKmGZgnnP59LQPMV6pcn7lOYQrfMUI+tk++6unGmaFWjncbp7qXFQZTTTx/U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7496.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2d0TDkzc2dVN1p1MGlOM0FzbGpicU16TkUzS0hCQlJwT3NkZmxHaHpTaUk1?=
 =?utf-8?B?cnlJWmdELzVGQ1JQSEY4QjFxVVMvNVlFVDhJeHhzcENVWEFXS2dLdHc2OUlB?=
 =?utf-8?B?T2sveS91M3U2QUhXV1hNb3BPNEIyajFJaXVsTnFwZHhURFRIdERaeEJNZGNZ?=
 =?utf-8?B?ZDJ2bytxZ0IxUzFCcEo0dnUzWmFUNHErS3JHVGdLeHZRVnp2czdiK0N2NjRT?=
 =?utf-8?B?bVZWbVRpOVNidXdjd3VUYTY2ZTRBS3owdnJoT1ptdll5amFROGpvMWE0VHBC?=
 =?utf-8?B?ajcxQ05YVHh1VGZnYjh5M2lSTGpudzFEblovYTFNNlRTbFo4bzQxS0tmeFJ3?=
 =?utf-8?B?amhLTUJid3lneE5RU2F2aGRGVjZ3czNvMlhGN0xmczhJcUs1Z2FLUUdBRTdn?=
 =?utf-8?B?dS9MQjcwQlZRT3o2VXFZRHZSVjU2bHdSaXU5TCt5NERRc2RZNGZQRlFCbTUr?=
 =?utf-8?B?RVlML1pZbkg2THNudTRMcGFPQW4ySGdmdVpzK3pFZXlucVNrdnQxVzF2R09Z?=
 =?utf-8?B?cHNva3hxeWpCdnFwRSt0dkdEaHp2TU1RT3I5L3AveGcrSTQxcEhnL2tZT0ZH?=
 =?utf-8?B?Ti9GNkxuSkI0aWZXKzBzYUVzd0ZlcVhFQmN4ZHlqSHRBOTByemNXQmIrV24x?=
 =?utf-8?B?OTI4WC93NlJJNWs1OWdWZDVVdDdhemJWWjh2K2dib2hkM0N4bjBLSlh4Ynpx?=
 =?utf-8?B?UHdSeWxPb20yT2dRK1hITFc4SWhNRnBDdlJtWUZuR1ZPNmViYWdEeXhxUWlG?=
 =?utf-8?B?WjYwTU4zNWVXaUJiRS9FS25HZFdDUVVZWXo5bEtpL05OeUVzYjlWb2tTY2Zs?=
 =?utf-8?B?WHJCdU05UCt2cVVFMFJIek5ocmR5ckVxdWswNk0vT2hmZmxKQkJ2a25pOWIw?=
 =?utf-8?B?dmZzN3R4eDBabWhiaFJCWHlBRDUwc1laV3NFTGtVY1JHSTNMWDdHdUJqVGFt?=
 =?utf-8?B?VVVrZ2I4dHdsSE9kQzh3TEhUUm9mdm5ZbTNDNVdXdXZwYjVYSDlhUmRKVWRz?=
 =?utf-8?B?QWFYQlU0V0RVM1FyUnprV2xpdkhLdGUvSm9vcFBwQk5GZjJudEJyWEhOVUJ0?=
 =?utf-8?B?NVJWWVlKZ2QrSmJFQTNWeXlGSkFKVVhCcW8zM0ZLT0JKL2w2eXZJSXU2Rk1l?=
 =?utf-8?B?OUlES1EyYUhsOVR4aUdCbXRGekdFV0JtQndPdU5meHNpQjkyZEJ2Ni8vK2Nr?=
 =?utf-8?B?U3lKQXFaTDM4OC94bXNGMkFzM0dxcWhPZFpTSlVqb3lneWczWGdQeCtoeUQy?=
 =?utf-8?B?M0FobUVoc0R3eFV1ejdvRnJwUFhQRVJCUGk1d0pSTURrc1ZkMzFva1FUOFUz?=
 =?utf-8?B?aDJwTnhrM3hNOXNIT3FINExKaVptcWJwUnhMTFNEVHM1K3pCU3FYV0J0K2lZ?=
 =?utf-8?B?RDN1czh0NUgvQmhMWk9JTmE1MmZ6ZnluWWhNVzh1dW42eFEwQ0Ryd0k5L0I3?=
 =?utf-8?B?K0tXTHpCcDA0VWZ3aXgrQXBsR3pNNEh5RGgzS0VxVUVqTDgwQkJCZHd3cWcv?=
 =?utf-8?B?d3BXVGVhNVpnQnhBOVJNbmFVeUgxVnZaMjhZeU5CSnE2SkdNcG9sTnNJUyt1?=
 =?utf-8?B?ckwzUWxwTncyK3dkNk81d3ozNE9lQzVjWDg4Vlh0UjhUKzhqaElMMG91UlAr?=
 =?utf-8?B?RWE2Wjg2ckZOUVJRSzFMRURmSnNUbEJnTmJDNFV0c2JLU2xyUWhid3ZFSGE3?=
 =?utf-8?B?WHJKSy91Znk3QVFscnRCVU5SUU1TWEkvcHFsd2hRbmFPcFdJclp2TjhaOTli?=
 =?utf-8?B?K2NCZFIyMVFxR1pRYmNqYkVMT3V2NFlDOFlYcm03UmJpdmJJZFVMaCtTeXZa?=
 =?utf-8?B?NmFCcmtSMVpsc1c3a1B1RkZYb2ZXd0ZIaWNpS291Tys1aVFCVjlvMjQ5SWRE?=
 =?utf-8?B?ZEFOZ0xCYU5VcHdMd3JmWkd4Y015aUlMbnZHVXRtTXk5cFpxNHhsWFdoaXJD?=
 =?utf-8?B?TUFVeVlJT2NWVmFRMjVJVXhTd2wvdkdIdUVBZi9BeHFBckd3QTdVMFc5bU1N?=
 =?utf-8?B?ZTBIU0pFWk5UZmh5RTVXNGFWd1hnakpIUTVNYWVna2hMWVJkMDFVOEI0bDJp?=
 =?utf-8?B?NG5JMkJ3VTZtME9Zc1NoMjh4SC9vR09pZHQzb1VLZjVORVlaQloxLzMyWDMr?=
 =?utf-8?B?VStUSXVOcE5XQkhsUjcySmxPcHFzVnBQdHBiVk5GRTZCeXNUQXpubVMzN2VL?=
 =?utf-8?B?MVdRTVNNNWI1R0wrNjROMzZ6VjgwbzhTYlpjdzMvRjFFQnpZVUhJdnZsWjdQ?=
 =?utf-8?B?SVlVeWVBVG1ITkIvdWx6U0hCZitSdkpMMnFyanRURzJ0cU1wUTF2SXVRTWMv?=
 =?utf-8?B?Z21BeGN6MjdGVHFUY0ZTbElHalRHRkZpK2Y2b1paa1NxMHArUUFlUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <792DB4A0BB4C4340813AEEB603CF72E5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7496.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5423ff-3692-4d0f-832d-08df13b925d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 06:10:03.4301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqBn1qTIHihsoPhpYYu/A5TrxJ2ai57x+ZttlrZ2ngsNjnRtnOWIlfgTVkm9l8/cYmpX+W9vzOzbYEAbTtqdlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121

T24gOS8xMS8yNiAxOTowOSwgSGVpa2tpIEtyb2dlcnVzIHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFp
bDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPg0KPg0KPiBPbiBX
ZWQsIFNlcCAwOSwgMjAyNiBhdCAxMToyODowNVBNICswODAwLCBXYXluZSBDaGFuZyB3cm90ZToN
Cj4+IENDRzQgZmlybXdhcmUgb2NjYXNpb25hbGx5IGZhaWxzIHRvIHJlc3BvbmQgdG8gSTJDIHJl
YWQgcmVxdWVzdHMsDQo+PiBlc3BlY2lhbGx5IHdoZW4gcmVhZGluZyBjY2kgYW5kIGludHJfcmVn
IGZyb20gdGhlIElTUiBwYXRoLiBJbiB0aGVzZQ0KPj4gY2FzZXMsIGkyY190cmFuc2ZlcigpIHJl
dHVybnMgLUVSRU1PVEVJTy4NCj4+DQo+PiBUaGUgQ0NHNCBpcyBFT0wsIGFuZCBJbmZpbmVvbiBu
byBsb25nZXIgc3VwcG9ydHMgZmlybXdhcmUgdXBkYXRlcywgc28NCj4+IGEgc29mdHdhcmUgd29y
a2Fyb3VuZCBpcyBuZWNlc3NhcnkuDQo+Pg0KPj4gUmV0cnkgdGhlIHJlYWQgb3BlcmF0aW9uIHVw
IHRvIHRocmVlIHRpbWVzIChmb3VyIGF0dGVtcHRzIHRvdGFsKQ0KPj4gd2hlbiAtRVJFTU9URUlP
IGlzIHJldHVybmVkLCB3aXRoIGEgMS0yIG1zIHNsZWVwIGJldHdlZW4gcmV0cmllcy4NCj4+IFRo
aXMgYWxsb3dzIHJlY292ZXJ5IGZyb20gdHJhbnNpZW50IEkyQyBmYWlsdXJlcyB3aXRob3V0IGFm
ZmVjdGluZw0KPj4gb3RoZXIgZXJyb3IgcGF0aHMuDQo+Pg0KPj4gVGhlIHNsZWVwIGlzIHNhZmUg
YmVjYXVzZSBjY2dfcmVhZCgpIGlzIGNhbGxlZCBib3RoIGZyb20gcHJvY2Vzcw0KPj4gY29udGV4
dCBhbmQgZnJvbSBjY2dfaXJxX2hhbmRsZXIoKSwgd2hpY2ggcnVucyBpbiB0aHJlYWRlZCBJUlEN
Cj4+IGNvbnRleHQgKHJlZ2lzdGVyZWQgdmlhIHJlcXVlc3RfdGhyZWFkZWRfaXJxKCkgd2l0aCBh
IE5VTEwgaGFyZC1JUlENCj4+IGhhbmRsZXIpLCBzbyBzbGVlcGluZyBpcyBhbGxvd2VkIGluIGJv
dGggY2FzZXMuDQo+Pg0KPj4gRml4ZXM6IDI0N2M1NTRhMTRhYSAoInVzYjogdHlwZWM6IHVjc2k6
IGFkZCBzdXBwb3J0IGZvciBDeXByZXNzIENDR3giKQ0KPj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNCj4+IFNpZ25lZC1vZmYtYnk6IFdheW5lIENoYW5nIDx3YXluZWNAbnZpZGlhLmNvbT4N
Cj4+IC0tLQ0KPj4gICBkcml2ZXJzL3VzYi90eXBlYy91Y3NpL3Vjc2lfY2NnLmMgfCAxNSArKysr
KysrKysrKysrKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvdHlwZWMvdWNzaS91Y3Np
X2NjZy5jIGIvZHJpdmVycy91c2IvdHlwZWMvdWNzaS91Y3NpX2NjZy5jDQo+PiBpbmRleCA5MWMy
OTU4YTcwOGMuLmRhOGJlYjE0ZDg0YyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvdXNiL3R5cGVj
L3Vjc2kvdWNzaV9jY2cuYw0KPj4gKysrIGIvZHJpdmVycy91c2IvdHlwZWMvdWNzaS91Y3NpX2Nj
Zy5jDQo+PiBAQCAtMTM1LDYgKzEzNSw4IEBAIHN0cnVjdCB2ZXJzaW9uX2Zvcm1hdCB7DQo+PiAg
ICNkZWZpbmUgTlZJRElBX0ZUQl9EUF9PRkZTRVQgKDIpDQo+PiAgICNkZWZpbmUgTlZJRElBX0ZU
Ql9EQkdfT0ZGU0VUICAgICAgICAoMykNCj4+DQo+PiArI2RlZmluZSBDQ0dfUkVBRF9NQVhfUkVU
UklFUyAzDQo+PiArDQo+PiAgIHN0cnVjdCB2ZXJzaW9uX2luZm8gew0KPj4gICAgICAgIHN0cnVj
dCB2ZXJzaW9uX2Zvcm1hdCBiYXNlOw0KPj4gICAgICAgIHN0cnVjdCB2ZXJzaW9uX2Zvcm1hdCBh
cHA7DQo+PiBAQCAtMjU1LDYgKzI1Nyw3IEBAIHN0YXRpYyBpbnQgY2NnX3JlYWQoc3RydWN0IHVj
c2lfY2NnICp1YywgdTE2IHJhYiwgdTggKmRhdGEsIHUzMiBsZW4pDQo+PiAgICAgICAgfTsNCj4+
ICAgICAgICB1MzIgcmxlbiwgcmVtX2xlbiA9IGxlbiwgbWF4X3JlYWRfbGVuID0gbGVuOw0KPj4g
ICAgICAgIGludCBzdGF0dXM7DQo+PiArICAgICBpbnQgcmV0cnlfY291bnQ7DQo+Pg0KPj4gICAg
ICAgIC8qIGNoZWNrIGFueSBtYXhfcmVhZF9sZW4gbGltaXRhdGlvbiBvbiBpMmMgYWRhcHRlciAq
Lw0KPj4gICAgICAgIGlmIChxdWlya3MgJiYgcXVpcmtzLT5tYXhfcmVhZF9sZW4pDQo+PiBAQCAt
MjY2LDcgKzI2OSwxNyBAQCBzdGF0aWMgaW50IGNjZ19yZWFkKHN0cnVjdCB1Y3NpX2NjZyAqdWMs
IHUxNiByYWIsIHU4ICpkYXRhLCB1MzIgbGVuKQ0KPj4gICAgICAgICAgICAgICAgcmxlbiA9IG1p
bl90KHUxNiwgcmVtX2xlbiwgbWF4X3JlYWRfbGVuKTsNCj4+ICAgICAgICAgICAgICAgIG1zZ3Nb
MV0ubGVuID0gcmxlbjsNCj4+ICAgICAgICAgICAgICAgIHB1dF91bmFsaWduZWRfbGUxNihyYWIs
IGJ1Zik7DQo+PiAtICAgICAgICAgICAgIHN0YXR1cyA9IGkyY190cmFuc2ZlcihjbGllbnQtPmFk
YXB0ZXIsIG1zZ3MsIEFSUkFZX1NJWkUobXNncykpOw0KPj4gKw0KPj4gKyAgICAgICAgICAgICBm
b3IgKHJldHJ5X2NvdW50ID0gMDsgcmV0cnlfY291bnQgPD0gQ0NHX1JFQURfTUFYX1JFVFJJRVM7
IHJldHJ5X2NvdW50KyspIHsNCj4gVGhhdCB3aWxsIHJ1biB1cCB0byA0IHRpbWVzIGV2ZW4gdGhv
dWdoIHlvdXIgbWF4aW11bSBpcyBkZWZpbmVkIDM/DQpUaGFua3MgZm9yIHRoZSByZXZpZXcuIFll
cywgdGhpcyBjb3VsZCBzdGlsbCBiZSBzb21ld2hhdCBhbWJpZ3VvdXMgaGVyZSwgDQpldmVuIHRo
b3VnaCBJIGNsYXJpZmllZCBpdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNCknigJltIGdvaW5n
IHRvIGNoYW5nZSBDQ0dfUkVBRF9NQVhfUkVUUklFUyB0byA0IHRvIG1ha2UgaXQgY29uc2lzdGVu
dC4NCj4NCj4+ICsgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSBpMmNfdHJhbnNmZXIoY2xp
ZW50LT5hZGFwdGVyLCBtc2dzLCBBUlJBWV9TSVpFKG1zZ3MpKTsNCj4+ICsNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAvKiBPbmx5IHJldHJ5IG9uIC1FUkVNT1RFSU8sIGFuZCBub3QgYWZ0ZXIg
dGhlIGxhc3QgYXR0ZW1wdCAqLw0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChzdGF0dXMg
IT0gLUVSRU1PVEVJTyB8fCByZXRyeV9jb3VudCA9PSBDQ0dfUkVBRF9NQVhfUkVUUklFUykNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPj4gKw0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgIHVzbGVlcF9yYW5nZSgxMDAwLCAyMDAwKTsNCj4gZnNsZWVwKDEwMDApOw0K
VGhhbmtzIGZvciB0aGUgcmV2aWV3LiBJJ2xsIGFwcGx5IGl0IGluIHRoZSB2MiBwYXRjaC4NCj4N
Cj4+ICsgICAgICAgICAgICAgfQ0KPj4gKw0KPj4gICAgICAgICAgICAgICAgaWYgKHN0YXR1cyA8
IDApIHsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2Vycih1Yy0+ZGV2LCAiaTJjX3Ry
YW5zZmVyIGZhaWxlZCAlZFxuIiwgc3RhdHVzKTsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
cG1fcnVudGltZV9wdXRfc3luYyh1Yy0+ZGV2KTsNCj4+DQo+PiBiYXNlLWNvbW1pdDogOTQwZGU1
OTBiODM5ZjcxZDZkYzg0NjE2MDUzNGJmMjAyNDAxYjhiNw0KPj4gLS0NCj4+IDIuMjUuMQ0KPiAt
LQ0KPiBoZWlra2kNCj4NCg0K
