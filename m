Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793954586;
	b=ojZsYfd14DNY5vZrsO1Cy4s0zvpdPClwvwf3kE/v4hAKArQD3QNxBfz/7iuoKRzjBv9/
	 letdKP6p4u/kjkDVILZY2mr36SNZ2YX2WoGIhVUA/dEJh6bYsq11qvvkc3XAd5Uy+e+Wk
	 McR7g3ahcJsxjeVtWXqEH2YSyOJ1klkgZ6l+mT4FXkEI4I16JJq1N9EUQZjf9ikDOuCd1
	 9KJVLmWoDcV0J/YH1CMu/K5nCocd5Bze5DVcfnfJjktEkkH/uxcDMY9dSGTp32YJEnM4R
	 M6pMcrvBkUisxYO7B3EH75aYqva++zfny2uGJIeA+AUC4fAZujLOj9i2GQ9tPkTEYgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954586;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SharedMailbox-RoutingAgent-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=fnkAoERUoMjceUmC1LRGJ/JEjLt6PRsa/7H8+bUTvz4=;
	b=zHWoRN/1dbiE3ukO6OcCOLFs2nYRC+1prTVpeLsHtclkoGcMYWBC0RoRZ+uH14N+55xy
	 fRQ/AIN0QzDCHDL/+Uz4pi14HPbiy3Kf369vtA5Bb1nkMK3aDxB6MYFuip/U0unVvQ8Pm
	 rUFRmUkulOXEnPi6rTrCX5QbAlwjjIKJHyKrhtix6805HEluiHLMaFWN4P+CSxzjilfn0
	 TQOd9kXjJHwCkZ2DNacTGD+V/IE15p74sAbDjnsx6DMx0/hF99T0lPAoy+BvX48U1g/MB
	 RR6eCn/tQg886X9olgnDUk9SYa04YkYbda9EVKCqfqaUyHKRNeyx0XBdKVoQeBY2bZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=u95uMk9i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.1
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A165606A329;
	Fri,  6 Nov 2026 08:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A165606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=u95uMk9i
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJrJM9hx4vTqKPy9CocSMxKyU1mpWTxheFOXpY+7ftWORmhlz9vHeOnk4QgxBEsHWxag8Ip1WoTVA+QrcNO8US715dSMyf8VDd7jDIBdSnzvBQUnD+eEFPGrlNCzNZ25jMhL2DB5DD0ePhbFxgQDO69gL+qgM0vWmu7TRXrhhvAlzzVQV+DkF8D0lvPLVjQsgUh3yoJ4mVRM63yGqQMAxlYCZI/CtS3O3f+ySTX9gc8TKoUcI7JDj9sI3UJzug2LimvkXQPaSUtEqNFrarZOsjEEyr18RukA7oIkROmIObnd3Ls4+W3VIvptVSmepybcpe15W3VTyI1UMXodeyz1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnkAoERUoMjceUmC1LRGJ/JEjLt6PRsa/7H8+bUTvz4=;
 b=XljjJmotLnu9xaVBXKUJctPmDQDkjuPXR4oBT2gRid7jmTPYm0l/wWdbxSyjivY1f2CCwfH/EbW+Ct/KwCzslT2i6LA602kZG324RcFl1ytBB8nEjyo+UfEwNtrdR1EYzPAgrtfgYgQ1NONwGdIAELb4PVqGx55PpYpEVu1ABHlefzOAF+QC6XLDqnJhw4TtaBWOlulOJbWhYDzfv2zuAstj4J5k0Yc+vUbpwC1/l/KL4tvJkuLgq4ia5R3qAO2nsPkl1lR1wLbtelK1ZgtFf+CpPPtvyLQ7Kh1EiJVb/dHN/dO4gJjUPTryVgBqsFQYFSzdOjKDIjTDAFwJWqs+SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnkAoERUoMjceUmC1LRGJ/JEjLt6PRsa/7H8+bUTvz4=;
 b=u95uMk9iI1mae3pYYYLULYbsqEVu8dlJw17uT/s4MzvAuNG1Z+bewwTYPgkN85zwrToXkzZpUHdxHMcSscYGCT2O8jtQXvJpn0FX3SMkbCvP+dWbG7ZWm80DkoxkXi8ev4LEAf+JliZXPR2FvZ90uzzJdTsLYqs+LiR8YiMukN6NIwEWFfuZueKhLD2EbTxvXCLuBLHZOc2EcpCGUaxx/LsTXRam/ImhyLOjLuCYJg56OC7v/mCJCFSiVANvfa4yjh817+ulglA161FyY76WDqX0Oa3quqcZxyL9duaXkppVKSvKZ+mxQ9Xi41ckHCl7kvCC0bJ53osW5D5FZGYyEg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8179.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::20)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 08:43:00 +0000
Received: from AM9PR04MB8179.eurprd04.prod.outlook.com
 ([fe80::a551:cde0:6730:1d85]) by AM9PR04MB8179.eurprd04.prod.outlook.com
 ([fe80::a551:cde0:6730:1d85%5]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 08:42:59 +0000
Message-ID: <c160d4a6-9b47-4591-bfc1-98509e792f80@oss.nxp.com>
Date: Fri, 6 Nov 2026 10:42:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Fix NXP STM clockevent bugs causing lockups
To: Enric Balletbo i Serra <eballetb@redhat.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 NXP S32 Linux Team <s32@nxp.com>, stable@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20261105-nxp-stm-fixes-v3-0-8129b912e74b@redhat.com>
Content-Language: en-US
From: Khristine Andreea Barbulescu <khristineandreea.barbulescu@oss.nxp.com>
In-Reply-To: <20261105-nxp-stm-fixes-v3-0-8129b912e74b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AM9PR04MB8179.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b5::20)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8179:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: afd33a5d-bd4a-49fb-e8d9-08df3be1f644
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|7416014|376014|366016|56012099006|261022113327099003|261009223027099003|261102123227099003|261021123027099003|261021133027099003|261021135927099003|261028144727099003|261021130227099003|261022115727099003|261026130827099003|261026121527099003|261026135527099003|261026140227099003|261022105027099003|261022075727099003|10067099003|261021121427099003|18002099003|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	HRIcqjcgQwNC/d0izOUt2+1alCoZiETuvdZDEHnb5h2Ob4A7OzNCdgFE+IdSB4HLCsKGnTspQXxbW8mSmwuDIshieqbxLnl5hfWXp0i+SvphBtjFNCVk1pLL1f+jFUOTERxbMs8/J4g+PvL9xGoImh1WGzwGA4Lc+yM4rDljXSnyQAokB71hgh08YkLuL6VVb8ZyD9r+MJ+54ttoOW+MOFKGlgDtVWxS2Tprxk+5wwBIE5wqjZ40sasdZhBf0opn9iAM3Hy7SVywRkYOtUrlzkAW/DB5fmoO8+B8Hrp5hh3Owq1Vf9oKxNgANfXL6dmeYRJbzYKg6Pqq3DfhJZkgt6zYuhhA1g9aO9bvfdTyg4IhOJ4DgUKL0+rZ56EQtFCgl5Z9wxGsSnFyIN/UM4Q41VjKUIwzKzwUZI647HwTG+ckhnUkMJMUJOvUFU7T4sKcQ8rpBDroMVbRKvTy0X0WBJ0sOUNXzmqZs963GCreBf6jlgqN69PgDZRxnNneKc1veuRkG7TGhh1W/FY7TrTAhwHBsuq9p3y5xh7IOedk5OMRSwTMfgxxdoDYmIh5Z9+1RSBhHk8PkIMb9eOhuv1Fp3zOS9GJ4zM7upDTul9a1LcXrY9mqtYFfNY6V5PNs6gV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8179.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(7416014)(376014)(366016)(56012099006)(261022113327099003)(261009223027099003)(261102123227099003)(261021123027099003)(261021133027099003)(261021135927099003)(261028144727099003)(261021130227099003)(261022115727099003)(261026130827099003)(261026121527099003)(261026135527099003)(261026140227099003)(261022105027099003)(261022075727099003)(10067099003)(261021121427099003)(18002099003)(11063799006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWxKdVRvM3RaTHROWTV6ODNEbm1XaTZnRkhVUkVUdU1KQVpWTUdtcjZiaDhG?=
 =?utf-8?B?WUYzTkZDS3FCK21QTTdjZlNmT29sQlpVV2w0clJrZUExK0UxZ3RVZ1RKdGQx?=
 =?utf-8?B?bDZ4SjUvNTVoOVh1VFN1THFCd2VsNVlGZER3ZHY2YWFycFVZWWNuZ1I5VGgy?=
 =?utf-8?B?bFVxWXRjdGg5SGZHNE1rbXdNMFVMaXdnY3lZdERCSml1RmlQWDdoWVpKKzVX?=
 =?utf-8?B?RTk5M0hpV2twbi8xQVpKOUI3akxLYUFibXRZUk9zcFhheS8xazZKTm10UXlH?=
 =?utf-8?B?VkdldkVwckFmVyszc1VicXgwMDE5U1pEaFFoWjgvREczbDh0VjlxZldMM0ww?=
 =?utf-8?B?RDJxTmtEanpad1ZFNE10b090QTJyc2F2SG5DSFE2dEFBbi82R1Y1cmx4UFZZ?=
 =?utf-8?B?MTQzQmlrUXBycmVDWXZuTTVmMWIxdi9OTGhqWHkwSWo2R09vSzJjVnVKaXlp?=
 =?utf-8?B?T3BENWFUUTNxL2FKRGdzamFhYmNpcE0ra3UvejhxMDU5eG1iOUYwbWllU2hv?=
 =?utf-8?B?UkszaTJtOXFuUVdHQTBFOFpUTE9FUCtkbzNISTQwRVJEWmpXdEJXNkVQanJo?=
 =?utf-8?B?V3V2Mm5hKzBtQTZCRTE0dGVBYzVjS0dZSUlGVERFQ3JOUHIzclUwYTZIUFoy?=
 =?utf-8?B?U0RPRFdncWdyZzE0K0Vadk9JZG1VM1hSTE53Sll6ekpEMVNkelk5TTc0enRW?=
 =?utf-8?B?STc5VDFKTzRlZlhqY3hnUmpJaHZJT2ZCcldOOHZaWEdiajB0NEU5MmphOW95?=
 =?utf-8?B?OG0vS2pveFNrR1BZb1k1b1JsdStnVlczZ2o4ZkRvMWRyUmxKR1VkdzQxdnRR?=
 =?utf-8?B?a2l5TlpySUNuSXUwY1cvVTJuSUlyZVRIVUdNZjFsZlZJVFViVERuQ1Fxd2Ni?=
 =?utf-8?B?SThzdzJKWE5lVnIzYkhXRENibldvRFJHTkkrelJpMUlqM3d3ZmFxc0VYSFB6?=
 =?utf-8?B?TWppbnQ1UEVFSHFiUHl3aDFxb0xGNnhqWTZGR0dXeDNqRHptTEdjeS8wVnMz?=
 =?utf-8?B?eithc1ArelVFamhhczZtWkVvUmF2eGU2SlBtQXVNRjdNdWlWa3RBb1V6L0JG?=
 =?utf-8?B?N24xajlrRTJHempNMFNYbTNod25VT2ZkbnBHbGl2ZG5mRE4yRGJETXVoYUQy?=
 =?utf-8?B?cmlUeHhOSk9nSVVMc2U0K0crL3lNd21DcU9RZ25KL0Z6d25KdzVEaHU4Vitm?=
 =?utf-8?B?aWt6Unc3VHJ5aWFkZmR0TlBiV1BCdU1Ea2RJS29IOVpzMDNlNmhBclRnOXdN?=
 =?utf-8?B?ekdhR2dWQjZRTUptU2dtaUViRE5xQ0NSNXRzWnlDRkpYOEtQVWl2eGlhRm84?=
 =?utf-8?B?MHlqL3NyWDEvUy90WmpwVmlFT2JEOHZ6VStKRHZwQnd2VHBWTFdnWmNEK0V2?=
 =?utf-8?B?djNsZWtJNFl4Y0hXYUx3TXZTeWFjd3R2a0QrSSs2OWZrMFREM0pZdUFpbnJs?=
 =?utf-8?B?Tm15c21YT1RIdmdXcmZYOXpicWJmVXQ4S1phNy9EbFdnYUE0WnRrenh4a1pZ?=
 =?utf-8?B?dkNZTGZFTWMvYjc3N2x5ZExlWXM2STQyUHZxa3JXWmd0RVM4dWhHUXhxLzBY?=
 =?utf-8?B?OURtTDZuMkxSaFR3TDU5RFZIWlAwcXRBMTQ4YWFJczRQMWJ6dTdEbVJNNlZU?=
 =?utf-8?B?UG1Pc25Wc05ITUZJdWZHbzdadnJKVEVpSkt1cXROcHg5aWpzSWNWdVhWUjl2?=
 =?utf-8?B?eEFNeEpOYU1oVkVCMkM3RWJDQVFBbnNhMWhCYVV4YVlmdHk2M0dYcTd2Nmsr?=
 =?utf-8?B?cTRTc3R1cGd4aGZ2SWg4NC9kZ3dxejBwdFRQbWRJZXUwUlRkN29rd1V5c2pp?=
 =?utf-8?B?Ukc5UkpoWnMrellNcFcrMUVHNkhaL2I0WnNxNDgvbjhEdTZ1dk9LSUpNbXBp?=
 =?utf-8?B?MTR3d1lGRVBCb01YMkk5RUUyNnlwcHFRMTJpQ21hNWxMenVUODZzL0dYZFpJ?=
 =?utf-8?B?WStxU1dSbjdYVWJoL2NOclUrVlRtQmpPdkVUTUEvUElLTVBMUWRFUzgxOENj?=
 =?utf-8?B?L25neGR4bzVOZHdidzdyTS82N3FzVkNyMFRIRXdDOHppZ1JEejIwcjhXQVE0?=
 =?utf-8?B?Nm5sRzR1YXNrbXJNOERiSFhvNWhWUmlXVXI0THBqaGVZQ2o2YWwzL0lJb1RX?=
 =?utf-8?B?bSt6VEt0RVA2b3ZpbkFaSkV3QWZmY0tqaU9vTDlIYXovRXZDRjVDaHdkQ0U4?=
 =?utf-8?B?M2F0OTdVUCt0azRVaCtnaG9UTVRybXJjeVVMdWRjdjJZQUh3Q1RtRW1jMG1R?=
 =?utf-8?B?NGRFK2dpTnpzc2MzdjZ1NWFrWGJudUo1c1Z5Mmlpa0JnYlRDOS9qUWJpNVdX?=
 =?utf-8?B?K1oranh2ejNpaUNYRTR1bmNvS2cvbzh4UGlWNHdKOTlqRFlKb1Q0dzA1b2sr?=
 =?utf-8?Q?qTRuK3mAisLuTLeLOZWzNc1tIQITcyEPixRAm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd33a5d-bd4a-49fb-e8d9-08df3be1f644
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8179.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:42:59.7743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/7gjznULLqSwR9tGhwf96a2ovWBe/6sSugh7IuybBBIz0bUhVJOE8n58H5TZ1wXYjxzJKxOkfoJ+5ibwnXP/QpLPBwfRvxlo/mMOWQtQrmju6vMcSOo1DKQ8Up2OrXc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

On 11/5/2026 10:18 AM, Enric Balletbo i Serra wrote:
> This series fixes three bugs in the NXP STM clocksource driver that can
> cause soft lockups and missed timer events, particularly visible on
> PREEMPT_RT kernels running on S32G platforms.
> 
> The NXP STM generates an interrupt only on an exact match between the
> counter and the comparator registers. If the counter passes the
> programmed value before the comparator takes it into account, the match
> is missed and the hardware must count through all 2^32 ticks (~32.2s at
> 133 MHz) before firing again, causing soft lockups.
> 
> Two independent bugs made that possible:
> 
>   - The overshoot check in set_next_event() only detected a counter
>     wraparound, not the counter advancing past the programmed value
>     during the read/write sequence.
> 
>   - The channel-enable write at the end of set_next_event() lands after
>     the overshoot check. If the counter passes the programmed value
>     before the enable write takes effect, the check has already passed
>     and the match is missed. No min_delta can close that window.
> 
> Patch 1 fixes max_delta: on 64-bit platforms, ULONG_MAX exceeds the
> hardware's 32-bit compare register width, making it possible to program
> an unreachable compare value.
> 
> Patch 2 replaces the broken overshoot check with a margin based
> comparison following the pattern of hpet_clkevt_set_next_event(), and
> derives the minimum programming delta from that margin.
> 
> Patch 3 keeps the compare channel armed for the whole ONESHOT operation
> and manages it from the state callbacks, like the HPET driver does, so
> that the comparator write is the last hardware access of the programming
> path and is covered by the overshoot check.
> 
> With this in place, any delay of the programming sequence - however
> long the accesses to the timer module are stalled - degrades to a
> -ETIME retry by the clockevents core instead of a 32-bit wraparound
> stall.
> 
> Measurement procedure for the overshoot constants
> --------------------------------------------------
> 
> Both constants (STM_MIN_CYCLES and STM_MIN_PROG_DELTA) are sized from
> measurements on S32G, collected with temporary instrumentation on
> compare channel 1 (which the driver never touches):
> 
>   - A write-to-match sweep programs the comparator at CNT + n for
>     increasing n and measures how far the counter advances between the
>     ordering read and the comparator write taking effect. Targets
>     within ~32 ticks are never reachable (the write needs at least
>     that long to land) and the window grows beyond ~256 ticks under
>     bus stress. No misses were seen at larger targets, so the landing
>     window is bounded on this platform. STM_MIN_CYCLES = 512 keeps a
>     factor of two on the observed tail.
> 
>   - Tracking the read/write/read round trip of set_next_event() under
>     the lockup reproducer (stress-ng matrix/memthrash plus 1ns
>     clock_nanosleep hammers) shows a worst case of 574 counter ticks
>     (~4.3us at 133 MHz), against ~146 ticks (~1.1us) without load.
> 
> The minimum programming delta must absorb the worst case round trip and
> still leave STM_MIN_CYCLES to the event when it reaches the check,
> otherwise a minimum delta program fails deterministically and spins in
> -ETIME retries (CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST is not selected
> on arm64). 574 + 512 exceeds the HPET-derived 1.5 * STM_MIN_CYCLES =
> 768, so that factor does not cover this platform; use
> STM_MIN_PROG_DELTA = 3 * STM_MIN_CYCLES = 1536 ticks (~11.5us), which
> covers the measured worst case with headroom.
> 
> Reproducer
> ----------
> 
> The lockup can be reproduced on an unpatched S32G board with:
> 
>   # ./trigger_lockup &
>   # stress-ng --matrix 0 --memthrash 0 & dmesg -w | grep -i "soft lockup"
> 
> Where trigger_lockup.c is:
> 
>   #define _GNU_SOURCE
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <time.h>
>   #include <pthread.h>
>   #include <sched.h>
>   #include <unistd.h>
> 
>   void *timer_hammer(void *arg) {
>       long cpu = (long)arg;
>       cpu_set_t cpuset;
>       CPU_ZERO(&cpuset);
>       CPU_SET(cpu, &cpuset);
>       pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);
> 
>       /* Request 1 ns to force the kernel to clamp to min_delta (2 us) */
>       struct timespec req = { .tv_sec = 0, .tv_nsec = 1 };
> 
>       while (1) {
>           clock_nanosleep(CLOCK_MONOTONIC, 0, &req, NULL);
>       }
>       return NULL;
>   }
> 
>   int main(void) {
>       long ncpus = sysconf(_SC_NPROCESSORS_ONLN);
>       pthread_t threads[ncpus];
> 
>       printf("[+] Hammering hrtimers with minimal deltas across %ld cores...\n", ncpus);
>       printf("[+] Check dmesg for: 'BUG: soft lockup - CPU#... stuck for 32s!'\n");
> 
>       for (long i = 0; i < ncpus; i++) {
>           pthread_create(&threads[i], NULL, timer_hammer, (void *)i);
>       }
> 
>       for (long i = 0; i < ncpus; i++) {
>           pthread_join(threads[i], NULL);
>       }
>       return 0;
>   }
> 
> The soft lockup trace looks like:
> 
>   watchdog: BUG: soft lockup - CPU#1 stuck for 32s! [swapper/1:0]
>   Modules linked in: nft_ct nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft
>    nft_masq nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
>    nf_tables veth bridge stp llc rfkill binfmt_misc nls_ascii nls_cp437 vfat
>    fat ina2xx rtc_pcf85063 regmap_spi micrel phy_package aquantia crc_itu_t
>    ci_hdrc_imx dwmac_s32 crct10dif_ce ci_hdrc ghash_ce sha2_ce sha256_arm64
>    sha1_arm64_ce udc_core stmmac ulpi phy_generic pcs_xpcs usbmisc_imx
>    phylink ptp pps_core i2c_imx fsl_edma virt_dma flexcan can_dev s32g_wdt
>    watchdog sch_fq_codel drm fuse drm_panel_orientation_quirks nfnetlink
>    dmi_sysfs ipv6
>   CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G               X   ------  ---   6.12.0-274.el10iv.aarch64 #1 PREEMPT_RT
>   Tainted: [X]=AUX
>   Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2022.04-15.el10_4 04/01/2022
>   pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : default_idle_call+0x3c/0x170
>   lr : default_idle_call+0x30/0x170
>   sp : ffff80008011bdd0
>   x29: ffff80008011bdd0 x28: 0000000000000000 x27: 0000000000000000
>   x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
>   x23: 00000000000000c0 x22: ffff0008803ac840 x21: ffff0008803ac840
>   x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000000000
>   x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>   x14: 003369266b813144 x13: 0000000000000000 x12: 00000000000002eb
>   x11: 00000000000000c0 x10: 00000000000010a0 x9 : ffff800080350ff4
>   x8 : ffff0008803ad940 x7 : 0000000000000000 x6 : 0000000000000000
>   x5 : 0000000000000004 x4 : 000000000c1c684 x3 : 0000000000000001
>   x2 : ffff0008803ac840 x1 : ffff800081712628 x0 : 0000000000000001
>   Call trace:
>    default_idle_call+0x3c/0x170 (P)
>    cpuidle_idle_call+0x1a8/0x248
>    do_idle+0xa4/0x118
>    cpu_startup_entry+0x3c/0x50
>    secondary_start_kernel+0x124/0x168
>    __secondary_switched+0xc0/0xc8
>   hrtimer: interrupt took 7246 ns
> 
> Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
> ---
> Changes in v3:
> - Code review and commit message editing assisted by Claude:claude-opus-4-6.
> - Rework the overshoot check following review feedback on v2: replace
>   the signed <= 0 comparison with a margin based check in the style of
>   hpet_clkevt_set_next_event(), and derive min_delta from the margin
>   (3 * STM_MIN_CYCLES) instead of increasing it to a fixed 20us.
> - Add a new patch which keeps the compare channel armed during the
>   whole ONESHOT operation instead of enabling it on every event: the
>   trailing channel-enable write was a posted write landing after the
>   overshoot check, which no min_delta could compensate for.
> - Size the margin constants from measurements on S32G instead of the
>   estimated timings.
> 
> Changes in v2:
> - Update the code comment in nxp_stm_clockevent_starting_cpu() and the
>   commit message: clarify that 20us prevents repeated -ETIME retry
>   latency, removing the misleading reference to 32s wraparounds.
> - Link to v1: https://lore.kernel.org/r/20261026-nxp-stm-fixes-v1-0-20a64a4ea454@redhat.com
> 
> ---
> Enric Balletbo i Serra (3):
>       clocksource/drivers/nxp-stm: Fix max_delta overflow on 64-bit platforms
>       clocksource/drivers/nxp-stm: Fix overshoot detection in set_next_event
>       clocksource/drivers/nxp-stm: Arm the compare channel from the state callbacks
> 
>  drivers/clocksource/timer-nxp-stm.c | 101 +++++++++++++++++++++++-------------
>  1 file changed, 65 insertions(+), 36 deletions(-)
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261023-nxp-stm-fixes-ab0163517e6f
> 
> Best regards,

Hi Enric,

Tested v3 on S32G399A-RDB3:
- trigger_lockup reproducer from the cover letter with stress-ng
  (matrix/memcpy/vm) for 30 min: no soft lockup or RCU stall
- stress-ng timer/timerfd stress: all stressors passed
- all 8 per-CPU STM clockevents register with the expected
  min_delta/max_delta, each IRQ fires only on its own CPU

Looks good to me.

Tested-by: Khristine Andreea Barbulescu <khristineandreea.barbulescu@oss.nxp.com>

Regards,
Khristine
