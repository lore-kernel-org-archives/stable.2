Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794728502;
	b=UA2uHLcc/PquQev8KhFIP+Bt4iAhR7FfrJOnu3w/fhv+lDX01lCLULngxkU93uLTSisR
	 5WMtyhe6uNkFqnnRamYJtbOzenQhgcH0HeHnIPK9/gp0GK8piuCQp6DlyqYs0SAti2Wz5
	 /dnm5cCBDitJh3xPLuv/FqJFjUD1PenKlmljhHvcAA6JY980W/qd2LEd551Nno5nqc1kx
	 5TruOf9Qp3SwuMc9LeJpD2GMZ7UYm5QyZ8TPFqX1cinCLd63yhu9W7/b+vzw3TTBS/XE6
	 e4uHOgbNmetu2OZ2ife+vY/8PtgckLVeCUrCiyDRMgBww5Y2yBuexl2ehC/FZSBaT6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794728502;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ztg/5bmLq4//z0uMVnXVVg1kfKv0mUBJtxsLi/sRiQA=;
	b=EP1ZgxoKvMuvpzxGyHfWKexN7oDSZ6EuQSzue2s6hnJsGLoUiOhuXGtTZdxn1UU74Jl2
	 2llnkrVKl/SeOnO+IPdEdvRV6l4d7zntZproipP6g4Ia7+2KtR9BQHNzv88xheQFKRhf6
	 pYfNDtljBsl9yo3UOwBV/mBo8FrGXH8IB1QLwyXMr4yc2571znQhPjVmwzxEuonkGkiks
	 BsVx5k+9dj5pmWoN75+PMw7OHH2cGIem/d/Vyam9znwip+YAtdftcD6fbTvd7nvQcVJ1l
	 JLnGAMSYy8daD3MS2TTq2wpLRZzxsSKwqQYZClKPk4vChsaRZwJm6Kdm+xnnVQVLrHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=l0zKy9Wm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.0
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010000.outbound.protection.outlook.com [52.103.2.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CD8606A31A;
	Sun, 15 Nov 2026 07:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33CD8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=l0zKy9Wm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0SrnCnq6G4k/Ss4abdMq5PluArrl0dd43BAx6Ytp5hHtBj58qYbzyqSWZ+g0vg33dn99Q5XHfElK/xnnTOU+WypGfM0hwwpPTsHd+EKYqxc6fhBtPMHol2QZEA2FtLIRQWDw26WHz7yQwjw4+WYjauFmCNeh5OMva8wnEui7Du7LtDmmeEgU0MTybjXm3OqYQIhM0WDcg6hdfIWfwRu4AEMWfRZniGPOxq2T1oAzFhusVaUsO1mq2gcaHYzpvhkRRET3WsTcF+nNJ2+aeIFoOeLorqukXeUhA1vW35Q+jX937cyTwzDlzW26wTVuEdJ0kx9gyfDtXQsO07cRzuUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ztg/5bmLq4//z0uMVnXVVg1kfKv0mUBJtxsLi/sRiQA=;
 b=Sz0iig8biBxcJjEkYF3x6p+W4v6vuetToryNaTw5bqENMvaMui6RnoSNL/zSAN9g2EAHTDrVNrGaizPQej6crcuboTWivImvrvwxvwcD8LPMdm6pttyH+IGKkjE55jgzkybp5KmCJTGCFDKEmgym/OPCQ2FCqXtxf2fmjD8+ucD3rG5vuGfqJHERg5b8GgpZOIyV48C64Alg0qPq5xSxUZRxe03mVqpWscxGFbHK3rIdjz4Cg5FATKDeEq19YrPiJ8htNA1/V2y8Ry8EahronSfIyIPq1CKY4grOKvsWIpRM8oqTTtnW4GknHQzDJA/2LUFXZ84Lw0PbqLXaNf6kJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztg/5bmLq4//z0uMVnXVVg1kfKv0mUBJtxsLi/sRiQA=;
 b=l0zKy9Wm9k8nHKf3Rm2HdGOnhUv+j6i5jP6b2mpTGNu+m/yJsPAVUW08W1EH6gISrp9MPg69423LYtyp5J5nLdUlhQsguNpSjO0vm9mYXfcDI79ogu1TsDys0wVmiUiIShY+hRt5OXqDz7wl1bcI6plwMsWiV6MzZSRAV2xUVe3aWLJSfPWqRp0HqBWI3Vh5jKK+A/41soiN/vhIfH3RihMgVIqnRjEbDMCpsDnOulFV7M7Q6lUJpdspE/uUmZdahwSWmuteNvkrGi7r3CXb18dXaTDJQZ6tmbu0loEM4SjMb/iSKF/lAzFpaQpfH4XGYOET9w+83ubdHLRcOfijEA==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by PH7PR05MB9777.namprd05.prod.outlook.com
 (2603:10b6:510:279::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 15 Nov
 2026 07:39:47 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0615.012; Sun, 15 Nov 2026
 07:39:47 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: Song Liu <song@kernel.org>
CC: Yu Kuai <yukuai@fygo.io>, Li Nan <magiclinan@didiglobal.com>, Xiao Ni
	<xiao@kernel.org>, Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2 1/2] md/raid5: roll back failed PPL disk additions
Thread-Topic: [PATCH v2 1/2] md/raid5: roll back failed PPL disk additions
Thread-Index: AQHddNR9sO68s5V3eEG6Y02YmYgb5w==
Date: Sun, 15 Nov 2026 07:39:47 +0000
Message-ID:
 <af1b5bd75adba880937981e8e78b9e7fe32bdb48.1794555233.git.x-professor@outlook.com>
References: <cover.1794555233.git.x-professor@outlook.com>
In-Reply-To: <cover.1794555233.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|PH7PR05MB9777:EE_
x-ms-office365-filtering-correlation-id: f9589f41-222b-461b-4cf1-08df42eb9ff3
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|38102599003|8062599012|8060799015|19110799012|24021099003|31061999003|25010399006|15080799012|4140399003|24121999003|22091999003|12091999003|18061999006|40105399003|102099032|440099028|3412199025|26121999007;
x-microsoft-antispam-message-info:
 =?utf-8?B?dVlIVEdSazZyNFlMWkdIU0tVdVd5L1pyb3BFYWhUZ0c3bVE4a2g2T1l0VVlU?=
 =?utf-8?B?L1JRMXg4bHM1SzR6MGZpdHQvRVAyVSszTW9HekhYZkJta2Y2UWJhZmRDMy9X?=
 =?utf-8?B?ck1rSFdFMTdRNUhDQm5COW9HRVFmUEpjMWVFVXBDVk43My9jMFl6cEMyRFBh?=
 =?utf-8?B?QXJ5eUZSUStPZjVMcS9nMEZNR1lWMmtidzFMelN1eHhFbG1wNW5OeVcvV2ZO?=
 =?utf-8?B?WnduQ2VDYUc2LzNIcERkbGRDei91SUpwNnYyWndnT1doQ2N2UWxkU3lGSGVs?=
 =?utf-8?B?bS9ubGRFdjRUaC9WVDdDMWRJMDREUWdjelRkWUhKMURnRTZCUTVWbGl4WThV?=
 =?utf-8?B?c2JDMi9qbFRwMnpyb2hWOFRveUkxaFRBUktiVWVVYU43UXFZd3VPTC9HYjFV?=
 =?utf-8?B?SjVLRXNtUXU1R1kyY0dFaC9zMHJ6dGtVbUd4amMzL24walN0QVdTb09WUk5P?=
 =?utf-8?B?VlQ4T2VsNjNMUTRibzI4eklzMW16elZzUjJvelYwTW4zRzl1MUkxd0xXYzhB?=
 =?utf-8?B?L3RlWnQ3RmFqNjdTNzRKTEswdDVDdzZqWEpMY0s5ZTVsZzdCN0JObU9RUjlk?=
 =?utf-8?B?dm93RWdRRkNsSHEvUjBvWW0wckdpVmRlZVptTEFPSVU2bzNPUXZJQzBFKzkv?=
 =?utf-8?B?V051UEs4bnB6bEJDOVYxMlUvV2JFSHNsUER5MFRSN1l2SC9nVmxzTEI3WGxF?=
 =?utf-8?B?QjVVZFphWThubDhVMG52Y0x0a2M5ZGxoOG5sSEdMenpMMUhTczhaMjVrS2kz?=
 =?utf-8?B?WjVGZnRHUlN2S2EwVHlvZkx6WDBKWGlseEd1cDRXVG1VUUgxSFpZQUlBekpr?=
 =?utf-8?B?dzdkUVlqbnJZMzJUOGN4N3JYWnBwTk4vR2VydWxCcm5udDRnM2tJQVRoSFNO?=
 =?utf-8?B?L1A2R3JqUDBpbTAzREQ3WjBYd2lrbmFqMWl3QkRpYjJSVUlGVk8rR2RKNWVW?=
 =?utf-8?B?eEJCeUFnZSt4WUxjK3ZLbDZHSHJFN3U2aVlSTmlYLzVBTFNyNTVvTUFvaGdo?=
 =?utf-8?B?MFdCSHVOUTM1bk5INmFyQ24zTlFzV2Z6TmdENGJGTWQ1cXZ3VmQxNitOVVJG?=
 =?utf-8?B?Y2Jja0dJSmt6bkFoRjYrK0puNTVlTGUzaXFFbHM4QXVGemxRaUZLUzhmRlZL?=
 =?utf-8?B?VmVXcEQzWjhTVUduQ01iT0ZPSEY2Q3Z5L0lodnN1cllodnB5TXZMOW5RcFd2?=
 =?utf-8?B?ZEwzR3VVeE5KREMwOVhlRVc5SUY3SXRXdTBMblFJeFMvcDZrbVpDdjBtZjI5?=
 =?utf-8?B?ZHB6bVVnK3plVnhYU2x1eXo0cno4VXdGc2hNa1gzK05NRTlkRDBZbEhCbkNp?=
 =?utf-8?B?cEFJaGsyeXhuSUNOeXE0SFh5SXRoTi85Vm9TZTVpeFVQTEdwcDJXbnZyaWEr?=
 =?utf-8?B?RFM1Y011WXdlYlVrNVhKaUZEUlVUOFY2ZWF4dHo4ckVJTUQwdEtrczlMRDNL?=
 =?utf-8?B?SlFKV0RvamYwblQ2UlFjUlg4bjJFaDRWb3psbkRSWDRTV244dFkvQmliZFMx?=
 =?utf-8?Q?rUqvxRU6wsp7elbeoHV6rctdAk2?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGdQd1prNEdKemVjMmtBYVQzaE5uYUhCcERSTUN3M2JMdWkrcHlESTFkekdm?=
 =?utf-8?B?MjhaM1prd2xLS2xFV1puZ2d3ZEd0OVZzL0VDMURZUGVYN3ZaSmNJV0R0K0tR?=
 =?utf-8?B?MnNqa3ZwNmZtNERVSU02TVMzR3hYRUUwY3ljenVhdkt6OTAwRkdHQktnYXhV?=
 =?utf-8?B?Y1hvTXNYb1NTWUxCenFFTUVHbTY1ZFFPdDhXdCtsa0dMNkNjdUN4SG9LZHdx?=
 =?utf-8?B?UEZ4L1VvQXVEUkRkV1VkaUQxY0ZOWkF3ZXFoVXFqeDRneE5iNzV4WlpFZTJN?=
 =?utf-8?B?Mzd2KzhvdW9GcnFtZTVaVUJGTDJDNUt3Y29PdkNaS0s2bTB0blBKWWhuQXh6?=
 =?utf-8?B?bUJRbFFuanJ2RXJReUFhR3JPUkJ0dXdua284b2t0ZEpkN3ZXU21OUlgyb1R1?=
 =?utf-8?B?TnlPTy9Ya2hGRXVRRlN5cUY4YURhVEx6SEZ4RnJIT1dtd09RQ1BlSGJFT3hq?=
 =?utf-8?B?L1ViL1FwU1VxbjQvTHdLOUVFS2dFUmJuM2J2NUhRampnbXNmZzRHVFVTNnla?=
 =?utf-8?B?Z2VXUE5QTktldkErbi9vTGdxV0RVSmVXN2I0dEtCWDcyN3pQWjkxQnczZW1V?=
 =?utf-8?B?WWlMRXJjVzFjNUlxQStxclllTWxDN2xVbm5OVjNxTW11aFNOblMybE5Vby9U?=
 =?utf-8?B?b0ZoSGZrV3NZemxHSTQ4RDdqcXdhNHJsUm50LzVySUZXMTZPY2RhemtaR0Ro?=
 =?utf-8?B?dGhiT0pnL2pna3E3WFUwQ3dNOU05RHFXa1BrWVdJaXV4TjhxenhWRFBobzFu?=
 =?utf-8?B?eDF0T2VhTzdabnRiRXdBYVRYNlZwaUpZY09aRkoyU0xvazdFbGZMV0VteUdC?=
 =?utf-8?B?TER0c1ozRzVFRWowRjlJeTlyYTRsdmJ0cmFMZTA0a2JVQko5NVFyRS9ybk0r?=
 =?utf-8?B?RGVkOUxkbjVQU1Y2ZkFtNVAwRmZKVVc4NEV6ajFzYk5qaWNtcG45eDA3RVpj?=
 =?utf-8?B?U1lzd3BZcGFhS2NZVDNmcE1TYWRiTldUUTBCOXJVOGo1V3BZQkVuMnpBajdB?=
 =?utf-8?B?ZjlDSjZFd1o2THpNZUR4Zm8rTWx2QWZScXZ5dnp1Z1U2MFF2bDBkQU1GdFhj?=
 =?utf-8?B?YzQ0ZUEyVkwzWExlYmd2TzF2RUtkbTRybzhjK3ZHTEpleDFEY2FBZjNjYmI1?=
 =?utf-8?B?NEpCTXJYWVByR3pMek9pVFBQOVhkaWozNDF1eDNYVWlGWHh2bUVNemVySDFS?=
 =?utf-8?B?Q1lTRXJ4bmRQd3BBdEgyNll5OVZXTDZzQ3dtbm42aFFCbk1Ldm5FY2pMV1Qw?=
 =?utf-8?B?Qmt1WEJZYVRsOStJcVhFYlpzb0Z4ZHBuNDJaSThUUEk4bUdrTWpsUzlPeGsz?=
 =?utf-8?B?T3NtUnVUOVhIaERvS1g1ZExMN3lhamloZUtVamx6dkcwRXlaOFFWQjJCanJV?=
 =?utf-8?B?MDh3N2Z3ZU80Wk9JTmp5UXJTS2tvRzJ2dkl6dHlqTHlTWjhCaW10Y0I5MVda?=
 =?utf-8?B?ZmZ5T2l0K1VRdHhzcExsUkxxcWVDSFVrMjFYY0tDeTNyb3ZpemZjQjAyeVE2?=
 =?utf-8?B?U3l5MS8zTGJqUlVzMCsxSTZidUMwUnlsYXloNmFybFBKNVF6aUpNTGdMWHg1?=
 =?utf-8?B?dzVodGRkdEFYZDVHckxxM2RFWEpKVlB2dUloaHROSnhaWVo0ek9NNmxXcmxO?=
 =?utf-8?B?bzIzcjIwMS9ZbFhyWEs1RHRySkNUZUJlc3MzMEtYZ2tnS0J2V2pSV0pUTi9G?=
 =?utf-8?B?QWl3aTNTdGpybGo3RWtwRE1HSCtKY1BML2F2SnJyN0NPUjkrWlkwMTN4SlhR?=
 =?utf-8?B?S3pjdDhyaExnNmpqeHZLY0NWb3hIMEZtN0pEVWRrWHFTVytVd1g2blQ2Skdn?=
 =?utf-8?B?TkpETnhyMTB6c2xyZWJtSFh0d0dEa0N4MnlPWGhlUGM1ZFJrb21MUEJBTzZR?=
 =?utf-8?Q?U8hYaAYLZIH9P?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR05MB10385.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f9589f41-222b-461b-4cf1-08df42eb9ff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2026 07:39:47.7552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR05MB9777

cmFpZDVfYWRkX2Rpc2soKSBwdWJsaXNoZXMgYSBuZXcgZGV2aWNlIGluIGNvbmYtPmRpc2tzW10g
YmVmb3JlCnByZXBhcmluZyBpdHMgUFBMIGxvZy4gSWYgUFBMIHZhbGlkYXRpb24gb3IgdGhlIGVt
cHR5LWhlYWRlciB3cml0ZQpmYWlscywgdGhlIGNhbGxlciByZXNldHMgcmRldi0+cmFpZF9kaXNr
LCBidXQgdGhlIFJBSUQ1IHByaXZhdGUgcG9pbnRlcgpyZW1haW5zLiBBIGxhdGVyIHJlbW92YWwg
Y2FuIGZyZWUgdGhlIGRldmljZSB3aGlsZSBSQUlENSBzdGlsbApyZWZlcmVuY2VzIGl0LgoKUHJl
cGFyZSB0aGUgUFBMIGxvZyBiZWZvcmUgcHVibGlzaGluZyB0aGUgUkFJRDUgZGlzayBwb2ludGVy
IGFuZCByZXNldApyZGV2LT5yYWlkX2Rpc2sgdG8gLTEgd2hlbiBwcmVwYXJhdGlvbiBmYWlscy4g
SWYgZW1wdHktaGVhZGVyIHNldHVwCmZhaWxzIGFmdGVyIHRoZSBQUEwgbG9nIHBvaW50ZXIgaXMg
cHVibGlzaGVkLCByZXN0b3JlIHRoZSBwcmV2aW91cyBsb2cKcG9pbnRlciBhbmQgUFBMIHNpemUg
YW5kIGRvIG5vdCBpbml0aWFsaXplIHRoZSBjaGlsZCBsb2cuCgpGaXhlczogNjM1OGMyMzlkODhj
ICgicmFpZDUtcHBsOiBzdXBwb3J0IGRpc2sgaG90IGFkZC9yZW1vdmUgd2l0aCBQUEwiKQpDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBZaW5namllIFdhbmcgPHgtcHJv
ZmVzc29yQG91dGxvb2suY29tPgotLS0KIGRyaXZlcnMvbWQvcmFpZDUtcHBsLmMgfCAxMSArKysr
KysrKysrLQogZHJpdmVycy9tZC9yYWlkNS5jICAgICB8ICA5ICsrKysrKystLQogMiBmaWxlcyBj
aGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbWQvcmFpZDUtcHBsLmMgYi9kcml2ZXJzL21kL3JhaWQ1LXBwbC5jCmluZGV4IDA1MzA2
MzJmOWQyYS4uMmNlNGUwZTcyMjgyIDEwMDY0NAotLS0gYS9kcml2ZXJzL21kL3JhaWQ1LXBwbC5j
CisrKyBiL2RyaXZlcnMvbWQvcmFpZDUtcHBsLmMKQEAgLTE0NjEsNiArMTQ2MSw4IEBAIGludCBw
cGxfbW9kaWZ5X2xvZyhzdHJ1Y3QgcjVjb25mICpjb25mLCBzdHJ1Y3QgbWRfcmRldiAqcmRldiwg
Ym9vbCBhZGQpCiB7CiAJc3RydWN0IHBwbF9jb25mICpwcGxfY29uZiA9IGNvbmYtPmxvZ19wcml2
YXRlOwogCXN0cnVjdCBwcGxfbG9nICpsb2c7CisJc3RydWN0IG1kX3JkZXYgKm9sZF9yZGV2Owor
CXVuc2lnbmVkIGludCBvbGRfcHBsX3NpemU7CiAJaW50IHJldCA9IDA7CiAKIAlpZiAoIXJkZXYp
CkBAIC0xNDgwLDExICsxNDgyLDE4IEBAIGludCBwcGxfbW9kaWZ5X2xvZyhzdHJ1Y3QgcjVjb25m
ICpjb25mLCBzdHJ1Y3QgbWRfcmRldiAqcmRldiwgYm9vbCBhZGQpCiAKIAltdXRleF9sb2NrKCZs
b2ctPmlvX211dGV4KTsKIAlpZiAoYWRkKSB7CisJCW9sZF9yZGV2ID0gbG9nLT5yZGV2OworCQlv
bGRfcHBsX3NpemUgPSByZGV2LT5wcGwuc2l6ZTsKIAkJcmV0ID0gcHBsX3ZhbGlkYXRlX3JkZXYo
cmRldik7CiAJCWlmICghcmV0KSB7CiAJCQlsb2ctPnJkZXYgPSByZGV2OwogCQkJcmV0ID0gcHBs
X3dyaXRlX2VtcHR5X2hlYWRlcihsb2cpOwotCQkJcHBsX2luaXRfY2hpbGRfbG9nKGxvZywgcmRl
dik7CisJCQlpZiAocmV0KSB7CisJCQkJbG9nLT5yZGV2ID0gb2xkX3JkZXY7CisJCQkJcmRldi0+
cHBsLnNpemUgPSBvbGRfcHBsX3NpemU7CisJCQl9IGVsc2UgeworCQkJCXBwbF9pbml0X2NoaWxk
X2xvZyhsb2csIHJkZXYpOworCQkJfQogCQl9CiAJfSBlbHNlIHsKIAkJbG9nLT5yZGV2ID0gTlVM
TDsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWQvcmFpZDUuYyBiL2RyaXZlcnMvbWQvcmFpZDUuYwpp
bmRleCBlZmI0YjBkMzdjYjAuLjQ1NWUzNmRkY2VlZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tZC9y
YWlkNS5jCisrKyBiL2RyaXZlcnMvbWQvcmFpZDUuYwpAQCAtODU1MCwxMiArODU1MCwxNyBAQCBz
dGF0aWMgaW50IHJhaWQ1X2FkZF9kaXNrKHN0cnVjdCBtZGRldiAqbWRkZXYsIHN0cnVjdCBtZF9y
ZGV2ICpyZGV2KQogCQlpZiAocC0+cmRldiA9PSBOVUxMKSB7CiAJCQljbGVhcl9iaXQoSW5fc3lu
YywgJnJkZXYtPmZsYWdzKTsKIAkJCXJkZXYtPnJhaWRfZGlzayA9IGRpc2s7CisKKwkJCWVyciA9
IGxvZ19tb2RpZnkoY29uZiwgcmRldiwgdHJ1ZSk7CisJCQlpZiAoZXJyKSB7CisJCQkJcmRldi0+
cmFpZF9kaXNrID0gLTE7CisJCQkJZ290byBvdXQ7CisJCQl9CisKIAkJCWlmIChyZGV2LT5zYXZl
ZF9yYWlkX2Rpc2sgIT0gZGlzaykKIAkJCQljb25mLT5mdWxsc3luYyA9IDE7CiAJCQlXUklURV9P
TkNFKHAtPnJkZXYsIHJkZXYpOwogCi0JCQllcnIgPSBsb2dfbW9kaWZ5KGNvbmYsIHJkZXYsIHRy
dWUpOwotCiAJCQlnb3RvIG91dDsKIAkJfQogCX0KLS0gCjIuNDMuMAoK
