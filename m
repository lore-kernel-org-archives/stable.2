Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.101
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794861902;
	b=Eo9cAskQrnEiOAqW+RVXC7C3hQBnMgVT5pl8DjWUC5HUen/4VMVKLZ4YbYLVQcwZZ6fn
	 2YuNHt2iO/WNWWnJpDz1Bx+ZvfbmF014iWeyHu1CBK3cUQHOFZ021WmfgBM/XAAyNOkAZ
	 srNeF0dCI1NW32S5Ze+/AMd5ktspCEQi2oG9e7pogkcoBK9bWZQWAEKqYNoCb6Txrd9lp
	 Kx57S+ep4mx3axhQQiVqgBWU062aat3Vr9wBJI+HgHsHDZTmr8kpnjQf2PFAQMgvoV29i
	 olhzCn34B0PDQzADt+WvU8+de6Qc/D2gfh71g7+tZht5IbOqKK3wbW7zCKF8Xvf/WFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861902;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:To:Cc:
	 Subject:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
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
	bh=3J8dm3+9EEvG6cz1MmZihFTVWyAoYeeI2dUSBOJ11RQ=;
	b=ZMCMsz9bLgFVeBC3paP5Kq1msHceSRYWqhZjwtPx8gDTSeBnEI7gV1QI2gj2fOj1iOgR
	 4uNyTPYvMMf8UvL77Lv7PU6xFOXUsZm88+DKjg+pbo53XNyVTqh+6aFrKUCU87D7OX7bX
	 xeYG+P/B1BBfuZN24KBAUsqNRSisPHkM/1M355Jtrg1XKWyLiVWDi0hVBsprE9W00RPOB
	 hdpBT4SKdWJfzhyoSBz8BsSKlcx9MHy7DyI6rbDTxQdy3uUDPmASKIreLPsYhRqqWX8rl
	 GCes8S0gaYTSJuvPMFPXbwimffnQjeyhNSK5MkAra2HCn1m6OoKO84N+pc9HY6puciw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=wQNB1mBI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.101
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020101.outbound.protection.outlook.com [52.101.196.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20F0606A335;
	Mon, 16 Nov 2026 20:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D20F0606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=wQNB1mBI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g74Qpewb3MlSSl/k6abp/CTHV90Gbl/cbul1OKhzGJ3Odi6S4cA5X0M9yZiE3dhg3kfDdEpHjQh1sW6SPob0iQJgf9/qhD73d08sj7ij7SxNo8ZJHfB0MZ+6p4RKoql0Rd4TIziJWRi1BoU4vTwu3dg0+GY7sqCBGRshJ+cvmThbp2+nZHcPuBsXkb3nYnqmDkC2ZOYEtMZPahF1K7lkquuoQVGMp6SQWwVcM22sXiZBzpXWympU4EKlxKOQyI4ThUQ3IvZgPNZMzweLsl8mDn1neb8G0Q9XCKD8hwbYnwfTK+Giirc6Qz9fSATt0a3J1WKwhMHD4CHTYeLonDKcjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J8dm3+9EEvG6cz1MmZihFTVWyAoYeeI2dUSBOJ11RQ=;
 b=ZKU1Jxh6goZz4ka7+1q+iOcLP5wwu98/4fsomLpGZ147M2VISXBpHOiYjRtCv/TyxiqtkoWdkz3x9/S+tn+pgFJVrwuyKzmtardRJkjKbitnoxsiLvQUGEHhg+3R1+xRsHl45gm95PhwME9sa/4W7UGXTnvXIc/Qbmj8MBpAU/L/oLdMXCVnjdeTVB+VcmwTOhsP0zfmj40lahGxU0iKrfaQgaAKZU3EWLsS/VMjlNybbj6Not1Alb2eaLHeB+MHQ6C1nPp4EWXiY4fkyoFr2R6MSgNCJKwdSmTI1i6KUx0AOYnuOXLLvYUhAz+0AdCmnNidLPgVp/tWHU+z0RY0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J8dm3+9EEvG6cz1MmZihFTVWyAoYeeI2dUSBOJ11RQ=;
 b=wQNB1mBIs+rM2OhSwJpseq4JFepuLIWLApSY1rreuhKOl49ZPlD/weYS0kW/jnkPSwsQSWpqWp6KWc6R0d+RC1HTj8zpTnf0gcUz4XAnWSymeF3TqjZPuOn5TSQcUtGlg8hr3Gx2VjiOCQhNV2ggvo7VzGOlkYI9DDLhe1ecRkk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LODP265MB577040.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 20:44:58 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 20:44:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 20:44:57 +0000
Message-Id: <DMWXFWMTEWTQ.2UMH7J6HAX3OR@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Josh Poimboeuf"
 <jpoimboe@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>
Cc: "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <rust-for-linux@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] objtool/rust: add more `noreturn` Rust functions for
 Rust 1.101.0
X-Mailer: aerc 0.22.0
References: <20261114001708.80599-1-ojeda@kernel.org>
In-Reply-To: <20261114001708.80599-1-ojeda@kernel.org>
X-ClientProxiedBy: LO4P123CA0219.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::8) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LODP265MB577040:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c992cba-ed03-41ca-cd89-08df44227a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|10070799003|1800799024|376014|7416014|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261021135927099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	MGWAXp2PlNIX2a4Gm6RhkHKY7WG+MWW0pe+fEItNa5zummj8k7DJ0S2kq7Ss96N8voW4P6umtOzsxRzjotIZqaRtfNVfgbBOC/oRblWYZXe/LYJJ/4bIf8mOJkKq1DZ8I4tJH4sQnm9dLq/v1UubtXEcb5ART1NsJAsOy31L1VQI8yTlPyEZGqsSyfwZXT7OjP7kz+tc6+0pY6nWR/6E1Wr7epKagCyFoiRnThq9U9J+f3JY2mQGoESk2eKwApZjjnTnkarpMRETsAEkXlMuxfkqxQg/vRmYeTNVqaK3xmlO/gWa+01HBiyvBTub5sj/Lv87NW85EAyui2qz1ew+Rb3ajjJQMIBsgeKtOYFCQblv6lTV0pj/Aby2bPT3xGk0+brreCLyyzFs0wGd8i/jw8JLSwZHq1cXQhHwS2+3FPwHYmiqlIMJ48E75qDF4tVFbV+9s4FzsXmnInRSRD2ra5y7dIlOdMddsSwDEM2bPDSvoc6HUgv4UOkjhbIdLN5yEfm/JZSzdO9prNBBMxZpBECyTlEcSZlmWqnPzirxDr+Ab8c9xcBLsiVL1iFaO4RrGikAfgKD9A6A/6J5xUdyAJSt3JL/GQXUZpg1EmxdfHrcCVl+Q/cpRcEcY8Dt590zADiDvIeuk8RTHwa1/nTf3weEIPfERCj07ICCVk1PQzU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(376014)(7416014)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjRMSDdEb0lUMWFWdDJtL1I0bFhUTTdneEhXRnRjSHh4UGxjQXNEZ29GMWVt?=
 =?utf-8?B?ZzBaM21wczkwRGVJczkrYi91RHEzRlBxeXJCc2MrNEhHcHl6dXFvZ0VKWEdY?=
 =?utf-8?B?bUdmcEEyWWQybWN0R0wyVGhOS1JLZVJuV0J6Y0VTWURjbENERFd4aUFCeExB?=
 =?utf-8?B?OGpiUFpCMXFVc09GVW5IaENES3NSSGZqazZBb3FFSTYydWU0dGxPeEJrQ2JX?=
 =?utf-8?B?UzNnb2U0K2FlcU96dDdSYnVEVjJwT2NGRnoxWG9GUWhMRzF4d2tZcUMycHZx?=
 =?utf-8?B?dHRTYThDWGxZQnJJVGsxcnowNWcxb3RJUFk0eVZXb3RscUNuaGw4WVQraElN?=
 =?utf-8?B?ckNVdWFwclE5c2FRTHExWUVIb2E0bnJaR29PN0VRcGxLQ2FpM01ScDdVU3VX?=
 =?utf-8?B?MHdmNlFjZm5haXI5MjFHQjd6S0toTzhSbDg4Mk5Hckl2VHlFWEppRDlOYmpX?=
 =?utf-8?B?dFlTOUJEcTRnaTI2aStEUVBwM0M3OXNqZjF0Z2hPN3lHUkJ0Z2hhclRSa2Y3?=
 =?utf-8?B?a0NjMFBvVUc1ZjRGcGx2WXNFZmVIbStmUGZYMTlCbHRvK21uUCt0RGtnWDZl?=
 =?utf-8?B?SElmaElTYVY5ek40aCtqZU8xKytONFp0MmsxRUlMV0VhU09GVGIrWXNTV0ZC?=
 =?utf-8?B?UVcrUms5NlBNS3Mwb05MSEpLVTFCQVladHgzRzhxd01Yb0F3eDFnbzZheDJH?=
 =?utf-8?B?TldkUmxYYXVSMkxnZCtmU2ROVTJwNEUzZ2JPNXNUNWI3WCtCV2RDeTFzTWp4?=
 =?utf-8?B?T3pTZlNZdjkrNjVVNjJMNnFWMUR4Mi9iUXhYV0JZSUMwUUVMQ0hzOEdwYjdB?=
 =?utf-8?B?bW9neHAwUFE1UHF1TkpKaFg3bWdPUllXb1pYcTNtbWZNWlNERE95Zk0zUzV2?=
 =?utf-8?B?Vm1WaG1lcjhYK0lJMHQ0aFNhV21USVprS1JOb09VclhkbW9idW5MMHEyT010?=
 =?utf-8?B?VFZZRVFTcDdNdTdBKzhKRlBrUjVoMkJmZjRGazlvSzNrbDZGOEptM1V3cFdu?=
 =?utf-8?B?NmJYM3NZNGlsTXN5aVl6R0pqM2dSbk82ZnQ0bDVKVjBSamNjNE9nb3RWTktr?=
 =?utf-8?B?eHRFeFplVEFidkEvMXluTy9pL2d1UlZvT2tsZUtDRzlhakJob0FFVVFYcmtD?=
 =?utf-8?B?Nnp0OWczeVNuUGg2Z1VBemFvT1VZaXNiU2tSN2N6dFhSUTA2Z0U4WENKeUJU?=
 =?utf-8?B?T1hvV0dGMlFUY2ZjN01LdGZGRkhhVXFwNFhWbm1nVGxaUnJ4cjBLS3RZTGto?=
 =?utf-8?B?SUl6V1dETTdOV3lubEM0dmc4bGlvSlRERFBJM3BUYXJvQXZSZGFhbXhlSGpT?=
 =?utf-8?B?clNsK0RsZ01WWWlxeHo3eXJodTV2Wi9ZT0prMU9SRTI2Y1I5clM5aDJnYWVP?=
 =?utf-8?B?NU5xWGtWMVFYMnZ4SXBCcGNKNDlIY0thZm5OZGtCcjVFczdHZ1hqK0k3NU5J?=
 =?utf-8?B?MGdIMGlVK3U4ckFZc0xNYXFrNjI4cHI1Z1lWS0FFTVUzOE12WVdZTXNtdk1P?=
 =?utf-8?B?RlJFYzdUMEs3ejErSzFIeVdQNmVOK0pNaGx1QTNjRDNWcGsvaDdKS2g4bFBk?=
 =?utf-8?B?Q0dkVE5TazI1UWM0dFU0cHdPb2loemovZnE1VWNHUEJITG00bFZzbm53OGJ1?=
 =?utf-8?B?ZW5uYTJQc3J5U3Y1RENhcFdTRmVkOVl5WUtuV0tEYU42aGwvOGppVkFLekd1?=
 =?utf-8?B?VVc4Y1dwYWZqdnAvTzJsYW0xNjhoT2pUSDN4dU5DNFBIMmY0b3VXWWkxR0lD?=
 =?utf-8?B?UjNKZ3JXTVlBbkNpQWszeTlYYXNjZkFvYndXR25IZnpnWXlMSGtpd1NMTGhO?=
 =?utf-8?B?b2lSZjUwQnJueWRZc2N3d2hlcG93bTB4N01YUC82M3dhNlBJZGJUUVpxT09K?=
 =?utf-8?B?V3ZFQzRPMzNVbGNpbFdjTnY3YkFWSkkvbnh6MjNkMUV4U3MremIvQzRIeDV6?=
 =?utf-8?B?L1QyZUJlTHBmZUZOVjF1eWFxT2RNMjNHTSt4TFdBZEZxdTdZaU9oNkRpSHE0?=
 =?utf-8?B?b0NacVdqNTgyMWhQM0VUaDl4V2Ezak1wVjVsanFZcGZ5TE5Zek1sU21XWnIz?=
 =?utf-8?B?blp2UHJ0UXkwSlNWYWgvQzl1bCtxWVJiMkw4dDhXVHRZNVVEaU9RV2xuSjha?=
 =?utf-8?B?M1VHT2pQZDVOYUtWMnFIaDMvSEw2ajBySUE2bU83REkzcndKMDFxcitCa2lh?=
 =?utf-8?B?SVNVWlFaZFdlblZlR0pyWXVqVTd2TGV4SGdGNGthYk5DQ0NtdFBsWkxKdm5u?=
 =?utf-8?B?Q202TjNReDR5L0Eza1cwS0xhZllPNEdKOFRDbWowWnU4dG5XaXpMd1hIaFd1?=
 =?utf-8?B?MEpLZU9LZzJpYjR5RDdZV0IwY3JBV2xWbWZ2Z1ZkRCtKZHdtaXB6dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c992cba-ed03-41ca-cd89-08df44227a3c
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 20:44:58.2453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uklwEX4pT2KC4z4En1Awbg8RGBs9sIzJ5Z++O1havFoB4LGXudD9MAfcfr7k4+fIFyT3Kvez2YP0tmAzgdGTrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LODP265MB577040

On Sat Nov 14, 2026 at 12:17 AM GMT, Miguel Ojeda wrote:
> Starting with Rust 1.101.0 (expected 2026-12-24), `objtool` may report:
>=20
>     rust/kernel.o: warning: objtool: _R..._6kernel3pci2ioINtB7_6DeviceNtN=
tB9_6device5BoundE8cfg_size()
>     falls through to next function _R..._6kernel3oppNtB5_3OPP18from_raw_o=
pp_owned()
>=20
> (and others) due to calls to the `noreturn` symbol:
>=20
>     core::panicking::unreachable_default_msg
>=20
> Rust now outlines the constant messages of the panicking macros [1],
> thus `unreachable!()` (i.e. without arguments) calls that new function
> instead of `core::panicking::panic`, which is already in the list.
>=20
> The same change introduced the equivalent `noreturn` functions for
> `panic!()`, `todo!()` and `unimplemented!()`, which lead to the same
> warning when those are used:
>=20
>     core::panicking::panic_default_msg
>     core::panicking::todo_default_msg
>     core::panicking::unimplemented_default_msg
>=20
> Thus add the mangled ones to the list so that `objtool` knows they are
> actually `noreturn`.
>=20
> See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
> for more details.
>=20
> Cc: stable@vger.kernel.org # 6.12.x (Rust is pinned in older LTSs)
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://github.com/rust-lang/rust/pull/163766 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  tools/objtool/check.c | 4 ++++
>  1 file changed, 4 insertions(+)

