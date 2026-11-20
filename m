Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795188602;
	b=getWkJdAsJL9f4bq+lVLyaJv1K6oQaKSkEy37ydPvcl5IP5ARpigO1jnkX2XXKnW6tvf
	 YnSVzNEfb4fpNEsgWwiKmODEmo2RAK/TYniwuycaXIwXFTTvVwIa7gHdattpFjAlXiFwT
	 co6xlpIslkUxpJWr6/Z95u2rt3/iLGUH266YS8HCqjbx76ssn+IFckjH0SHoirk5TrLG2
	 3akT+hFfHtlFaZI+austa+OED4QGXTBQrQqhUh4tIfOEv0L/chXRBz5592jYhdIylUmpX
	 KcRIK66P90+AbepwD/gtmIRvRODt4Rd1Gvi6jUBdHEkHnb7CPLz53AsczNXbXDQOA0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188602;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:To:Cc:References:Subject:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=NKyNDpLlJhpeH1fHV9UmzWC+jPv+XYatXbkV4j5NoRA=;
	b=vdSuiajIMdsaQd4z5vQr0Z4W/j6xObEp7Fxuem3P18/wHSpDYpfAS0fZbARDUxReV0py
	 bDotJtYGmjIPJNeJU5mK9j8zYzGferku1F3fQ7T2PczSetY5smzmQEdaF1Uubbpu/Bf40
	 fvXkB23se4VC+NKuRb4nSgNt90dSXY4BEiTyTwBqYDWWnREJMWT4lb1CBo0TTXMq+2Qci
	 InBgyQTWRU4mRtxya24xfr7mxEexVcgft7lYNlziiXLPnhi+GqGysZpiAjvdP651gqqCe
	 8HP5zLNHCPUWKsYN04jZ+3hvN0o61Gwt6Ie9IRV2oVVY5gIFJHcznMXbzt73GF0yPlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=citrix.com;
	spf=pass smtp.mailfrom=citrix.com;
	dkim=pass header.d=citrix.com header.i=@citrix.com header.a=rsa-sha256 header.s=selector1 header.b=WetzKL5v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.52
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194BA606A330;
	Fri, 20 Nov 2026 15:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 194BA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=citrix.com header.i=@citrix.com header.a=rsa-sha256 header.s=selector1 header.b=WetzKL5v
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oo/OpXVISFDReu8amGmyboKBJaknQdDuW7n5EuY2MPlr1yuH7g90VE1bo+d+mBVYaZz1dQjOE4MgKYLowUOihI0c/RP0Hqp/FE2+pgBfHQ6bDtgxAcEbZ9+vNV2nbDESosxvFiEgRlVM6gEjeqxjAxG5Cg5E8Dgw+5yxAXi0EzaF4xxs/3LWRK1JapfhFSA83Br0XMr+wHYjVa+hF6PA3I7rduyHw/MKRkMGLHP6InqdrwGwqgg/TEdXsorAlipUTecQx+9lMDhLoexz0hHzkGqIh4bePbHdyTxdzUljBIHBGmxaWS6ieaj4TJJMUDYz9DUX3KlaDcHPB7DzUyJx6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKyNDpLlJhpeH1fHV9UmzWC+jPv+XYatXbkV4j5NoRA=;
 b=o67xkzJPydo67iFcTna98C40uCeLOYC7sco3Q/4+yI0VWmxznu+rIVKRbgdBk8nStCoIjSt831wfS5jbkFjdt46OsrkLKNw4YIuh3OFkj/4Ch7CXi3NceVcHxeVbnprnhBhEvlm8TdDcbIrrul6NBPIGeSQhie4vvaenVXV9I+3IFAI5LKtrjthTdkw5UaJmyFHHS/TsO9yNC0zTg+I2kTltCtCgfB64tcXKpb4x0SWgLyMjDaPEL8PyVDD+8oEci4HVcJbiulAjtbH9wpligpeTWoYWim1zRZUS4aXJXEoFZ/J0nkDSjZ7d+40wh5E+c1r9eiyAqvj93ydWWoQQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKyNDpLlJhpeH1fHV9UmzWC+jPv+XYatXbkV4j5NoRA=;
 b=WetzKL5v/43pQVaEkye413Rt3UMc7ryvJmcoD4ek/9pubI/WeSmKg4H/Bkumd3vqlXtCvL7OpdVju8YRXsy2eujlnNVU78G+3cQ2rGiUlRLQNhERtq+ROAwkR/1leHypHp6ZhwudzOGRIOoOzPm20UBSNstyvl0Jukd4hzQAz+A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by BN9PR03MB6155.namprd03.prod.outlook.com (2603:10b6:408:100::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 15:30:00 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 15:30:00 +0000
Message-ID: <89a5aef2-ea88-43d7-adcc-3f6b7374932f@citrix.com>
Date: Fri, 20 Nov 2026 15:29:55 +0000
User-Agent: Mozilla Thunderbird
To: dave.hansen@intel.com, zhang_wei@open-hieco.net, yangzhen@hygon.cn
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, bp@alien8.de,
 dave.hansen@linux.intel.com, david.laight.linux@gmail.com,
 dengqiming@hygon.cn, hpa@zytor.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, puwen@hygon.cn, stable@vger.kernel.org,
 tglx@linutronix.de, x86@kernel.org
References: <b04950ad-d655-4ca2-8cbd-59360509d25b@intel.com>
Subject: Re: [PATCH] x86/cpu/hygon: Work around XSAVES Erratum 1386
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <b04950ad-d655-4ca2-8cbd-59360509d25b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::9) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|BN9PR03MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc1ea47-712d-4f4f-e6a4-08df471b23a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|22082099003|18002099003|261021121427099003|261021123027099003|261022105027099003|261028144727099003|261026121527099003|261026140227099003|56012099006|10067099003|261102123227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	9WLxA2xlaKPUPVbSPtCTmZKFq1q7odarn6srYueLZ9H/8WhXtbmqLi9bb6hzToq5eJAhrlItWtyGeaCjJm7QLQkgDIQK6YourxpX9zInvmakv+q1OYMdRL4jSryPP8K6PaBk0CvJBnr2r1ZI/pxbFsW1d/uutaw1fB2MCVtsTCoJ97YeGqBIiQM0k6U5gYE6erO+xZQ5SCTlFfr5Ekpv6QLNIHwFZ4659ZBCi2y+TPJb13rR6rPsv64Q8oBneu6aIsqmVxECKioc3euW5ipeJsULxmFlAZVMJRUbL6q3yJIHHGhdGp3SdRWehD8Gu2cbjXrBbu7Fl+HwYUdCgtDCTYNiNto8BgcOHuQc6UCGtsi6jhqskyUL2Hbu8/dOpVP2hNPq7dmLz0tU2U2vAiydqQZ7VyDqDR00HY162gxOotmbqY7Hzv6xjMPjyhm4MMb3fYKIYfnHhzePMypXB4KijvLG8mvQqb+CgVlcgKG6e5IHZ484Nmh7gzIspMPHk81BDTSXd8FjL4lvk8BHlQoc5fVo8FTNFzvzf6FPAyGDMmnCdP/SkjqrYqb/ISuvTNbtZORakWWKpDZJcyop4JpBSbVu2PiUmd4thScaUQTbhda5URZEsBRzVxNut9kesALMxAEuftWB4rIW7s6Z5FWC9vAxS3BT0IFa/V00G67gd4Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(22082099003)(18002099003)(261021121427099003)(261021123027099003)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(56012099006)(10067099003)(261102123227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXYzVjh0ZHo4RGNXVmF0Szhpb0xITTl3ZkduTGdUdktPeTdlalZSU0RibFNP?=
 =?utf-8?B?TmRHLzM3SGpjWGhRa2pJMDE3TUIxL2lQOTVuU0lMSU54Y0JoNDhYd1NkTloz?=
 =?utf-8?B?bzFvT3grUWhXSEFQcXBuUTJOVjJHK2ZZS29ON0FzWng3SEZ4YmpGQTM0Njg0?=
 =?utf-8?B?U0VWMm9mbHZFeU1zNmlmamlUakRKMVNPajh2dGVYTkN2SFE5dFJYcUZIbDEy?=
 =?utf-8?B?QmkvcFhXZzV1dFlVWTZuaHF2cTlIU0MyTnF2OWtralJtbmVLUE5tWlFkOHpm?=
 =?utf-8?B?R0liWHBpV0JXN2ZxdDFFcTVNSUpQMHhpVWtQU2t5UTF0d3JsbzRYalFOZm1r?=
 =?utf-8?B?TWhFZDNDTjRRZTFqVW40SGVaZ2FnSk8rOWtIMWJERjdSZVhSZkZvTHRQc2c4?=
 =?utf-8?B?YkI3aE5BODZyL1hDSzE2elZjTml6RDJXMkpsUHh3Q1ZhNklmZXNVVjZsNm1w?=
 =?utf-8?B?TlpHQ09rY3krdG1BMFQ1bTZuRG5aTk5VN0cxWDA3eWd0K3RsZ3lCblRTOU1I?=
 =?utf-8?B?cGw4VCs3Yk1tWTBzZXgyTS84MXJZTWhHcCswNUpJMzVBUUxucjUyOGZ3UHFt?=
 =?utf-8?B?VS9HenpGdEZ5OEJOWnl6YzNjckx5WW9JOVV1dGgyRjlzSU81TERkblJBMzFi?=
 =?utf-8?B?UkZKQnJOUUk4Rmc0cExnVnAzSTI2MnFTcmRJaWc2RFR0TnE5OXZjanh5ekRj?=
 =?utf-8?B?WlJVb1hHRmlEeXF2d3FEMFpYc0pwUmpnZzZiazNGY0FRaFZ0RnVaQlhkaVUx?=
 =?utf-8?B?ZXoxQ1lOaW5oSGRNK21YT1U5YTBlbTRBQVd6UWN4aVdSaGo5WkFuWTVxTGRV?=
 =?utf-8?B?UUtNcEFkZndxTkJZRnlsUi9IUEc4bVcyQ1NOMzRYYUdKYUZ4dEZHTGVuOEdE?=
 =?utf-8?B?MFpsekJkZ0VhcWljd1JnL1Y4K29oRjhpWEVzVm0rTzBBSlR2K1dZdDI5eXho?=
 =?utf-8?B?bFg4aTdwOVRIQTdNaTV4cmFPZENGci9iaEJ1RFpzVXNPam1OYmJjdmtBTC9m?=
 =?utf-8?B?MGNNOEdjOVd6RXkwMW5hWnh3MGZaelVRSGJKVW40SlhTYmlnMERGZlpLOWtO?=
 =?utf-8?B?ZVVxZThtWUwzZGp5aVF2S3F3OUdSbjNDbllZT25mT3RzNFJWMjVzNmFuK203?=
 =?utf-8?B?cnlsaElJSE04L1VJenpURExWOG5sMWF2T2o1RzdIVFJlU2ordFBmSTAvNlB6?=
 =?utf-8?B?NlBnWjVvOGMwaUR4a3dCaHlNdTNsOGdtOEFnc25iQnN5MG05bmpvU2tQYzFr?=
 =?utf-8?B?Y0FxZUxISW8zbldxV3FTRlZSWHE0cGFsSWZkMmZ3Ymc1WlNtRXVZMjgxdkNY?=
 =?utf-8?B?RVU5a1NVcitZNGt1UzdBQnplNWdxeStkSTFNRmk4MDMxTDVySzNORC9VOE5m?=
 =?utf-8?B?Qi9kbXMxR1hja1oxci9WdHd4SG4vOUUyYi9VWTJZMFlUMTFxd1QwRkNFQUsy?=
 =?utf-8?B?Q2x5Y0hFZ1FWYzNBMlRBTkVsTXVhcTFDMDN5S3k3UjJjUFk4R1VqeEJlNVV1?=
 =?utf-8?B?eUdPTXgwNHhJN1ZkUkJGSUZkZGN3YU1aY0o0M3FXSXJ4QnFRb0tLc3A3UVhE?=
 =?utf-8?B?MG9uZ2lJbHdxQWt5a296R3dKWXVvVWNQMkFYTURKVENYdVpyU1l6Snh0NjFV?=
 =?utf-8?B?NjF5QWg3c2pWcmRvV2tZOWt1QmlZRFBTbXhQb1lzTjRuaUNYcmxsNTZiQndR?=
 =?utf-8?B?VnVQbiszSVZaL1k4dEc3SlZrendhVFladllVODdGMk1zRkh6bEJ5MTZUUUJu?=
 =?utf-8?B?YnJHcHR0dzExZld0Njl2blV3aTF3MmVaY3p2UWNIS29wUjhraThTVE9iQmF2?=
 =?utf-8?B?WHJKNnhHSEZMY1hFbG02bHJTMzhzRlZDU3RSdkRGUGtYOElpbTM4MTJsU0JB?=
 =?utf-8?B?ZXNDcHZXdXVCL0JvU0ZHOXplZTN3MXNpRTA3YVZIbXQ0L3I0dDRKYjNSWFI1?=
 =?utf-8?B?VmJUL1FpN1BzTGNMbll6Tm4vZVcrbmNRRjhZanRWVXU5UnNsM0MreTI0QjA5?=
 =?utf-8?B?d0dOQ0daT0dkaVgrazBaSmVTc2VkV3ZyaHI3ajFvL29jaUVzQWVvV1pjOFdk?=
 =?utf-8?B?Qm9HV0thUW01cm41YTM5Y0JBSGpyOTc1aW1xQ0pmVzlrelZINW9rdTFyOFl6?=
 =?utf-8?B?YnN2aTJ0aEFsUnJZOGZuekF5ZStDcTQvR3VabXBwVU5Fa2lDK0czQ3ZCN2dK?=
 =?utf-8?B?NU9OU1JPTUExUDNNVThsWmJiMFRlczBack1GTnRVMHY0V25LbExTckNuclk2?=
 =?utf-8?B?OVNhNEUvU1d0THVQODJ2U3pSQzJTOHJpWHREQ1NkM3MraHkvNTJFcWE0Z2U4?=
 =?utf-8?B?OEs1U0xscDhwNkZ6dlF5eGhuT3A2aVZJSENiZ0dhSWdmYktlSDErY0ozcWVP?=
 =?utf-8?Q?gUqsR+nCvXz6IBSc=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc1ea47-712d-4f4f-e6a4-08df471b23a2
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:29:59.9506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wuP/bhN6EjipHBxOrwEMP+RfFloAOwmexoCJMvlQk5C15UnME8TeSFOL2Kvoy40xYzIcpj36O6aSfzO6NT/2J5Q3M999lHQcCjImSJeEpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6155

> Could you explain how that would help, exactly?
>
> First, there needs to be a reference to the erratum in the changelog.
> For me, searching for this string git the PDF to pop out of Google:
> "Revision Guide for AMD Family 19h Models 00h-0Fh (Publication #56683)".
>
> Second, I don't see anything in the erratum that says it is triggered by
> supervisor state. Do you know something about this erratum that's not in
> the public document?
>
> I'm not even sure AMD _has_ supervisor state components on Zen 2 that
> Linux uses.
>
> Third, even if we could move to XSAVEC, I'm not sure it buys us much. I
> certainly don't want to add the complexity to our already horrid XSAVE
> mess. The right fix is in the microcode. Let's not give our dear
> hardware vendors to mitigate even fewer issues than they do already.

Linux already has a mitigation for #1386.  The mitigation *is* to
pretend that XSAVES doesn't exist, which causes Linux to fall back to
using XSAVEC.

See fix_erratum_1386() in amd.c.

Hygon should extend the microcode list and call that function, rather
than opencoding it differently.

~Andrew
