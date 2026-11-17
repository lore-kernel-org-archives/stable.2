Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.115
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794914850;
	b=0OVT2y7wgC6N3aI8stJY/mHy1nlWI2Gv9UxlY40PpCLBppJgQg8OmDzEUFZ6XmwKOxJ/
	 7WmR/T9vP7EJKBtpSSR+ZTtMhr1ABajTb+Z/3LBzYKgkdCDw+2kmp+E5R90Zq4qysR03d
	 9ePnSWhyYw3KQbZsqOQf7WRzxsIykoB38cxMRUVz2rbwZCsWAkTT4RAxFIuBWhINGeTT/
	 2VrPj7F6VLVRJaoFCc5VZsFuyLaK6tB74ETEse9EMnm83R6YL57B6PUs6vr4ELA1eEnJe
	 lp+ZZr3AZ7eNv9+kUN4akyu0ZaGUy6HKh+4juC4NNswygN7srLH4gt23CVEBdgCjL/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914850;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
	 From:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=Wqxu/HsWobdFl32BaPJZM1XnlJpY9KZSoiXKb13je6g=;
	b=ksQeGiEF8YQhDKZLuoQtqp3Jp78yvDdfsfPNRXMw2ZfYjZiJ+oOWwJbgP5cGhd0zH1nl
	 D8WIps/IbogiMXUOxLqP7hsPVCN62ejavWlmAB++jSrMZG9n0bblx2LNXxvRlFYR6f2po
	 EeJL1DvpNw5kvOfjVxpjWPRF5zNiE0Fh3qB806iWPUkkcbvth80+m+LUdiONvqd/KkzcA
	 BUwBcX210qvNbUId+r9TVsBsKGiU0xlu2IKAZCSbiMseNImSHtou7tNtuvQZA212HzNU6
	 wbKm5ceuAMocU/7j1GU9zZ1K+sTk85C/mdJR+DdYgj3h2UuJgRsxUj6TfFqsIETCw+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=UtOltTdz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.115
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020115.outbound.protection.outlook.com [52.101.195.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E496606A31C;
	Tue, 17 Nov 2026 11:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E496606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=UtOltTdz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuroqnnUoyBcKswXpeOoVdk9WufzcRuX6Qec0W4mnIb959hsy7dBW6irXUGGeMWRx18vYSr6HdQamHqF8RZVwP2KBsZ5oBtoykduQFAYg+ZP0MegaXnNGo9sUTCojhGUkEqpkjDcStkPjWs6txEiI+OnhsSMfIKqqUOxIX/5GA9CMiTU1DcNG1IYecTMy4TOHT5I6anWFblBUODjaq8X6I3n//ZEgx/hBKop4g1JaAJyDzauUaOnEDx78z9cgszE5ztyMeSuUwpelSdmU2dHwdFVGOREmMQgWRy3hvh2rf7Uu9gbqNEzC1snaRSO/S8DdeZIbvijkSAMyNiazcbpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wqxu/HsWobdFl32BaPJZM1XnlJpY9KZSoiXKb13je6g=;
 b=fRcXEVClaL2FmTE23KgL+4UW9Skkw7HTWLHiOnmrJ7z6wAeBKWjA4NUuw7tOGmPHaggyujHfP/T0mLn5eRpKpNc1eiPnHtOtxhS3gyNOOq3rhuOUdsL0YyqNeTWBc/A/mDoFELRy8K3Wny+E7Wxm2hEEm7mwqsonwsOal77fVfQ7xwST70q6IMScZC0ICssSj2pKoTfpcpvf0oXk4wUp4+KNKX5ejumoR2iByh/hsq4d2Wei9P7WIzj00UOlljN9BK9y8eX/k3cEYKbZXhLJXAUhLM5A8hBKq4FRUiIghjj301/qICS4G618oFOvUz6OVfmuolH76l1zrJFLxvBI0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wqxu/HsWobdFl32BaPJZM1XnlJpY9KZSoiXKb13je6g=;
 b=UtOltTdz8MCrQ8CLh+ye8zOfRsHk4dUkp3ri+XgHe6F0nESeIlACNO/n8LxvejEr2n8KdSL8lvdZdjZ2tSs0ERuFXHXsBDkRQneT+YFS6Uwp1SsNbU5RXJHFAjGKT4WlR6Sr5t/9YHd7tm789ZRWT3Ql8QK45usg8tdC8E2TFmk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO2P265MB5398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:259::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 11:27:26 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 11:27:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 11:27:24 +0000
Message-Id: <DMXG7K9AMK2E.1QL8P4O7L8RFX@garyguo.net>
To: <peder.bergan@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>
Cc: "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Georgios
 Androutsopoulos" <georgeandrout13@gmail.com>
Subject: Re: [PATCH] rust: str: tie Formatter to its backing buffer
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261117-formatter-lifetime-v1-1-9d7f38686552@gmail.com>
In-Reply-To: <20261117-formatter-lifetime-v1-1-9d7f38686552@gmail.com>
X-ClientProxiedBy: LO2P265CA0501.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::8) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO2P265MB5398:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c471ba-ad06-4034-6283-08df449dc13a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|6133799003|22082099003|18002099003|261009223027099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261026121527099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	wdTIk00QNd+5VYTyH39tztjkSZ1z3e47kS8fewXe2rmw1xXJmIBlr9u6x/o8PK4MQ3uocPyieUGGNa4YM2DAFjoQ/j2NZCQwK8j/qBVpgfFoAURXAL6l9PJK7yNIOxgDhLrhrLweNirPa5qykS9nj8/5i1gFq9MQlewdNV9QkEYI836AomWrSn9j11y2K4QbaG1AJpIRUefn/U1jn3PJhxgbWjrXcjv6d+7KppVJnBpRfmb6aCsvKFIs7st+GUYF68sFu4NXUwz6c3atrWBmOhpyXRlZ4hZCK785uYEmMSE2NrsYzPHaxFPU795QiGMydMufSq/FK4fTf/3b2X4niHKLf99QZ5ZZpdwGk4RUiS2nWGzZUxr5kxWcnJMpfA7JIugi3rcm9RNkythpqNW5nv6scNTwuq9W8WK+ciWC7Ae2j4xjAaGgDootdPFeT8KEgOHibEwSEYQP7Z+bGID7p+/cjilyxyaPvErJM8EnYaMG+6WT3/QPOxfMOj8mE+wTfHyuRkCMv/b2YJsWYNhEqPaG3gaZaKjzerOUqiD6btCEDM3DSqopgjtJiMVeQAzEfFHIKNBMhbNiKkPT4Ip36xgANyvDjnKwxf8l5jdyNPcbvDY7zRXXy7cTPFQyrSVytMuxUD9iof5jd1dZ83VarrV+Pt/9AOm8C39qKIjJkfU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(6133799003)(22082099003)(18002099003)(261009223027099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261026121527099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UElrVmxRNlg3SUYwLzR2TWY2ZzhFa3pRU0EyWDI1TGFVS2ZyamdSQ210aGpE?=
 =?utf-8?B?TUtHUWU3ZGFrK1krZS9DVW90ZjFwQTByUWRyTU9UVmpKbkw0aEFuRmJFZTJX?=
 =?utf-8?B?cFNJQ2FmNG9LQWtYcU1lV0MzYlBGUnQyL1ZUZmtyTElFNS9oc1pORlZXNmho?=
 =?utf-8?B?MXpwaUw1SnpuQlpKemI0eUdaczhoR2VIUUh3ek00VzBIVHRZTnFyeVdEcmJG?=
 =?utf-8?B?RCt2QmtDVXUrbUlHQlpqOGJLYVpFYWxQeDJsaEtnNHovYTNJMkhsRHNoblNU?=
 =?utf-8?B?NjVUTHAxVmltTERRQVVJWWplL1EzdkdVWUk0NFY2WlF1Q0NBVGdwUklyTUFs?=
 =?utf-8?B?R003TnhIeUVQQXdpRzNHc0F1YzB2dTFrdHhVSnhDNkk4ZHpuOERVNnlKMTNp?=
 =?utf-8?B?MlFmZW5FWXliUk9lRDNGWnBCb1JKQVEzaTVDckYrRVQrSVdkOVRXbUo4aGxD?=
 =?utf-8?B?S2Qrc3lJRmpKTjRnV3JQeVRjdXN2aVJvR3BraGZTRVlaaHRnR0tsa2NINjIz?=
 =?utf-8?B?OXlaWWhtT21iOGM4MXNJU21qRlN3cEwrcFlBVlpvWFJhdC95TWgyaHk0eDVX?=
 =?utf-8?B?bVB1SnFSK3k5emZUaUFBMU0rKzFrUDBkcUtmUS9MUEJ0QjZwVEMxdG9vQ2dV?=
 =?utf-8?B?Mk8rcU1QbXBkVXVVUGdSZ3JXbFhqd25rbDJnYTlIK3R6MHYwUkE3TTZBOEdQ?=
 =?utf-8?B?YXJBYVVKK2RPaXVnamQyeWN6Q25CZkN3OEdYK2VmWWMrRTU2Z05OWDhvSW5q?=
 =?utf-8?B?VGFDMTFqcmRneUpKWC9sa2E3TVFQOUlvWUVPdkM1WXUzMnJkMVhJeUdpVmQw?=
 =?utf-8?B?dTk0bEZRZkRyMjBiZHdtSGZmQ0wwOUZPMUdNOUJmcFBPZWMyM0QrenpWbWww?=
 =?utf-8?B?dUZFcUswckYvZjBkbjZWMzlMOHIxNFdYQ295a0t4M281MERrZlVtNGdRdHY0?=
 =?utf-8?B?WXdTbE5YMVdPYUJXbi9EazFTSjliZ0pVM1hGbi83cjk2NnlXNlVyRWgycFIv?=
 =?utf-8?B?Yi9jMStLYmU4d04rRXJ2VGRpeUdXcUZlQjVodGpWaThtdXVHTC9ZUnV6dmI4?=
 =?utf-8?B?ZytVc1BxM1VkdU9sTlpkVG9YVXUvUXlDaWpXSEJEdDZXc2RkWW5Kd0pRbzhJ?=
 =?utf-8?B?VHRuWlE5N3RUWFJzY0VnU3g4WEtISklLeU9VOUI4RG5VWVgzZVJnK0U5RkxV?=
 =?utf-8?B?RUhTdFlLcXd6N3VKNmxPempZRURwUGdpRkZ3WURrSGt0TTZ0U3FmcVJHdTJU?=
 =?utf-8?B?clFsTFZhWkErbUhJaVExQ0lJVGxMOHhabHQrRmVLYkpEeHhJTEJvWjY0YWRT?=
 =?utf-8?B?Z1Bna0Y3WVl0UnlTeWpodGxROTUxSHhLNFNkWjd5c1VRSGk4MWhqT3loSUds?=
 =?utf-8?B?UEFva1pGU0dXcEU1Rlk3dFZ1SzZINWtBT2sxaW55M3M4czBzRXJTTThkcXVU?=
 =?utf-8?B?UThKU2p0U3dzMGFVNDJYSUhjQnlnb2J6d1JOQ0R5UG9WYXVZYVB6cldRNUVh?=
 =?utf-8?B?YTZQVzZwSmlEU0R3NXBFSGJ1TFpuQjJ6SzUxdW03MEdTQ2JlNEo5MkxqaExM?=
 =?utf-8?B?eElGNEtnSHFZVktNVTF1WVdJcmZsMndLQ3RJYVpVcEQyY2R2LzlrRWd4Wm1o?=
 =?utf-8?B?LzJsN0hDNWdtVGRISXk0azY2cUxNUUpkMlZTY0NXVFkzME54R0lBanFLVmJm?=
 =?utf-8?B?R1A1YVhFTVdjN3FrZ3FlSUcrN0EvbE1MNzJVbEd4ZHZsaXREVm1hdmtjQTRB?=
 =?utf-8?B?Yi9FZ21IcHJXWHBJdmZQdlJJOHJ3V29yR2xZZFB6eGZWSDgwOVdLTXN5ZWZt?=
 =?utf-8?B?Szd6UkdYUFg3Q2JIUG9CbUZDWURURW5BZFRncFl3ZEFrVTkrQ0h5NW9nQ1lR?=
 =?utf-8?B?SFpoV2NJbTMvbFRicGlCRDNsblNpaTZvTHVVVHZOYlphWmFVRDNPeWZpTEtz?=
 =?utf-8?B?THlYanBxMEkwTGFSa1NDcHdjZTdCSmxXbzJEb1AvaXJRMjlvSGVDcFJCRHpO?=
 =?utf-8?B?TkNNUDBCUUtIZHVaSGVMYU9yQlBBUGsvQVQyVWlGcE5zYk9RVWdlYk9zQU4r?=
 =?utf-8?B?YXNIam9sblZsYUVESFVxTHdpZDVRdnRwR2w5amRUNGd6ZUxGSGFsZmcxSmts?=
 =?utf-8?B?OW9NUWxPUVVjN2RrMVdzNFZrSVBxZ1ZVZXpHb2E4NVZwV3ppa1RhWlhNT2dt?=
 =?utf-8?B?eDVBZkQ5SkJmL0R2ZGgyOUpHYlJVNXdpRWhQNkdQWDJZaWxzZVJBaVRVelVy?=
 =?utf-8?B?V2N2bVY4THIrenU1bEFBZUhTOENFc1hnZStPMFE2M2dtZXVhRllueG1YZ3RP?=
 =?utf-8?B?Yi9TYm1EaHdjQXVSamNGN2RUNE94dE55NldjVW9sZ2QxTHdzWGVOQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c471ba-ad06-4034-6283-08df449dc13a
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:27:25.4017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/vGon87mDkK0cB1/FFymHlWo24fSIr+qla8UiH1M/vV3mRKsNA/zvQkHoNCrce+1VfCKeanmTEHKoucsWGicw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5398

On Tue Nov 17, 2026 at 9:47 AM GMT, Peder Bergan via B4 Relay wrote:
> From: Peder Bergan <peder.bergan@gmail.com>
>
> Formatter::new() returns a Formatter whose lifetime is independent of the
> borrow of its backing buffer. Safe code can therefore drop the buffer and
> then write through the formatter, causing a use-after-free.
>
> Tie the buffer borrow to the formatter's lifetime so that the borrow
> checker rejects such callers and prevents overlapping mutable access.
> Add a doctest showing formatting into a borrowed buffer.
>
> Fixes: 87482d6d9104 ("rust: str: allow `str::Formatter` to format into `&=
mut [u8]`.")
> Cc: stable@vger.kernel.org
> Reported-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1261
> Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
> ---
> I compiled the in-tree callers with Clippy and ran the string tests and
> kernel doctests under x86_64 QEMU. Three borrowing probes compiled before
> the fix and failed with the expected borrow-checker errors after it.
> Rust documentation and formatting checks passed.
>
> OpenAI Codex assisted with coding and testing.
> ---
>  rust/kernel/str.rs | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 644b4279a..6222faacf 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -645,7 +645,7 @@ impl fmt::Write for RawFormatter {
>  /// Fails if callers attempt to write more than will fit in the buffer.
>  pub struct Formatter<'a>(RawFormatter, PhantomData<&'a mut ()>);
> =20
> -impl Formatter<'_> {
> +impl<'a> Formatter<'a> {
>      /// Creates a new instance of [`Formatter`] with the given buffer.
>      ///
>      /// # Safety
> @@ -658,7 +658,23 @@ impl Formatter<'_> {
>      }
> =20
>      /// Create a new [`Self`] instance.
> -    pub fn new(buffer: &mut [u8]) -> Self {
> +    ///
> +    /// The formatter exclusively borrows `buffer` for its lifetime.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::fmt::Write as _;
> +    /// use kernel::str::Formatter;
> +    ///
> +    /// let mut buffer =3D [0; 4];
> +    /// let mut formatter =3D Formatter::new(&mut buffer);
> +    /// formatter.write_str("test")?;
> +    /// assert_eq!(formatter.bytes_written(), 4);
> +    /// assert_eq!(&buffer, b"test");
> +    /// # Ok::<(), kernel::error::Error>(())
> +    /// ```

Please split the doc change to a separate commit and leave fix as a fix onl=
y.

Best,
Gary

> +    pub fn new(buffer: &'a mut [u8]) -> Self {
>          // SAFETY: `buffer` is valid for writes for the entire length fo=
r
>          // the lifetime of `Self`.
>          unsafe { Formatter::from_buffer(buffer.as_mut_ptr(), buffer.len(=
)) }
>
> ---
> base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> change-id: 20261117-formatter-lifetime-48391ed7affd
>
> Best regards,
> -- =20
> Peder Bergan <peder.bergan@gmail.com>


