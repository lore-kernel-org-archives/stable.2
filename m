Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793967705;
	b=L373XH0x7NsC92xR/tEv9rik5Phbd+cpy52WlBac+VMZoFcgdv6izkQv8SXShMzvwQY4
	 Jxzf8rUE2u7cp8p55EMmGtBbXsG6jE20gZ1jZXtGwGNGNBlf9A/ObaBLvlNGcBhTkbBCr
	 iiNCx8XoDuYcL00xHC3UzQPtpkFDWcq1Dh/KovrCeSnjX8fHWj3WBmjl7fihm/Z2IOQd+
	 HD1bg9nqlmsSUOdUdX/ZeLcZuf+fdvL1q7SvwgychG6daBNEwVL9xG+D/MnJ19c+aDeqw
	 PN3rY01YmJrptNT4hdbhuL5oVJuyJsyWonz9Eduz7cKrp4Xtlulo9d5RJcAEsCXCGQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967705;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
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
	bh=4nrA6PHYaiaynFKQI4kjWkw12p0RCg9OfJZU6NJ2BGM=;
	b=lxOf9vhxgYg5TQkCE0rI8cvQ2P88MqVRVADO9pgH6nRS1Inb0WZf3FlmiF6yQxEL41Sk
	 jc872eZ+VixMthMP/VASWvqBYhtNCAIgqFLME39b22VTLHplMd17oII0HcCFt3yIndN23
	 0wjwEVogN/x64HveNDQbVuxe78HFKZKLkGOOYnjUEPx7F1IADP7w+WA+GsfhORY4dc6Um
	 fCqn/Td/gG72X33oT+LnjRq8LZpddxzee17CcVAd9/oo1sKZqcbgFlEX3FylfS8xmseUR
	 3Gt8JECAMtwlflhk2jsHnKwtngdv+1JCr1Ba1vuQWPYKAooKFNKt5S5iPciJEpMbHaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=E1mxUZ+p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.113
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022113.outbound.protection.outlook.com [52.101.96.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFE1606A329;
	Fri,  6 Nov 2026 12:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDFE1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=E1mxUZ+p
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o16DjShmRdeF0CEFNPbQ0wB4AILF3R0ULjq+cFbEg3eZtrZkb6xJaqtFl/wR/OSa/luZAHZHHo8xZPteKPMT4spm7MuK2kwL/2b21fzSa0uWIVV2E9vXUMRrX4Yj/ZRfCxgCi77EdPM5WgREPsB1IUBa0HI4k/9vcyy7noqfcxAslPopuHsMr9JnpshuPJeHJOLHzFiOab5Tb8TbPW+E+YKaLSFnSyAiYVwseb/XHImKZb0dQ/DiDfCLH/hqz662XKkQgTgCi5bMSinSyTEYJuZ4zcmaBb6l6x0KZKd8ghydmAu3/Z+FVfpPoJVK67B2E9osaBXMZBIueWWGlWgRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nrA6PHYaiaynFKQI4kjWkw12p0RCg9OfJZU6NJ2BGM=;
 b=Fkw/VQpyz9JllndJsFzw90kFq79LtnIPlI5sbYOlX2hDQodMBmHHwRk00I7jEqR+b5Rrw7nci1AryfvmVlGVU2CNHvGYinBhnSlik5y027fDAx2QHAfqvlM0mYo/2YEXdKg1+iTztS4YMqeO1vOTf9XWlEoiL1JMdj7LRwaMaA5a5kZ4EIDh3gaJfW+Dtntrjxq1Z/Coz6AUY5QclG1q7z8t+hrRoun7G7tuaEneoa2Z1AFN6ewWgnvO2qR2mUmT0JAEFSVFPr68+KcLAV8IsFEIQon5+40TYzKIsPEex64VH/oym5p0FHCxzWa7PbSo80DqQFla7ckRPo/d3zPS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nrA6PHYaiaynFKQI4kjWkw12p0RCg9OfJZU6NJ2BGM=;
 b=E1mxUZ+pPeVZF+weKu5eI1P9TWUFqzkK+Ftqo2M3RAsbcavXds5qxR3g3LK7nlG5T+CeopQ56h9/yctrnTH0N4s65Fpr7JyKp0sMYykIpgxPbCAgvT1WPjLN4UogxJpxpLyJE+vu2YjLC5IwekgzRRj+c0qn9IVISSyQcjRAsgg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO9P265MB7842.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:39e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 12:21:41 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 12:21:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 20:21:22 +0800
Message-Id: <DMO4GW3EKHEY.2BZ5FKK7BMPS9@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Rong Xu" <xur@google.com>, "Han
 Shen" <shenhan@google.com>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nsc@kernel.org>, <linux-kbuild@vger.kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <rust-for-linux@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] kbuild: rust: support stabilized flag
 `-Cprofile-sample-use` for Rust >= 1.100
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>
X-Mailer: aerc 0.22.0
References: <20261106073528.93371-1-ojeda@kernel.org>
 <20261106104546.2297584-1-aliceryhl@google.com>
 <CANiq72kSG61mTC3_0pPokoLbbE87oFrKHcNUZhxhbxpg24USYw@mail.gmail.com>
In-Reply-To: <CANiq72kSG61mTC3_0pPokoLbbE87oFrKHcNUZhxhbxpg24USYw@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0111.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::16) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO9P265MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d5a78c-14e7-47d1-b19a-08df3c0082fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|366016|23010399003|18002099003|22082099003|4143699003|56012099006|261028144727099003|261022105027099003|261026140227099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	z1R2GnM1BXlgXvbz2eIUHEyfF7xfnCR45+3C0Y23ru1siSI4armvaqSCjUu3JdajH7lvUNhgU+jJG/wk+g+MSffoRVBvBY08o2/lKQBY8ONXfIsRJBJ3CEHqxn9vN/NQFMUTD2OJvDZGODhuHkcX2I0WQR35nkUTP0pRAGUpZU0Z4pl5ACCZZoq1po2b4tNVQe8ZUTudaFUPEZX78c53hxX4hHlihHmwQeVc5IsGG8pmuNDlQt/nNkj55lEpZt5lm+LooWxbPbo12/gg8K2xm+1/+6VhWBz4OZGWo5pC+PWX/Qcn5eoTz4h7ppNYL1wN/Yne3M95KniNfMUHFDLLjswp4oElNtqW0pC3k/Vx4db+RWJCDMjXflPSjHxpP40gySzhegaqMne1f1N2K7U85r9c7t24B3R034EPSMQ7lbO0G1qRLtu4UteTYcIMEVwAOgxoPTIBMDDNYwo6gehStoHucxIy3yfk8chRoGNf/qk7I3cexHTPZ05QOJ6A+dBPOfkhrXFYYniK+2tyhsLL2AkJtClVg2bbOSWZdlvwPHu18Bz9nXF72M56r8OjJTCjzjbcPO7C7MNSpsPv385w79kF3zAc0cQD26xFH3rYrNqgKDQ4F4mOLZMITOmborwNmSEfP4dCLzMbfC/TTk82PET+ERIUmmb3mpXLgr9gkC8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RitxUmNVNG5DZjgyTGNzVlp1bUFtVDV2bUk1Sk5ZZmxaMmdaZ2JGS2FiZlIw?=
 =?utf-8?B?ZWxPc2ZyNjFjcUUxNEViUWpVVWFPMmt0dFdQR2ozL3ZjdlpZSEZzSnV5SkVC?=
 =?utf-8?B?MjB3WGVmSDZrbDdVNm9lVG1YK2ZiMjlZMFpqempzbWJpTGJtUmhYdHVmR09m?=
 =?utf-8?B?SVFqRjFoWngzVDc0YmNWL2VVNzZXK0hGUFoxZEo1b25kK2RJcm91OTh3b1Vr?=
 =?utf-8?B?VnNGMWk3SFQyQ0ROYUJ2ZTBZbmkxa3VNaldieWdxMjF2bEg2UERoTE8wQU5n?=
 =?utf-8?B?N2pTYU9oSzkwcFkzWmUwaGRWeEIvdTExV29MOEVxK1A1OGVQYnFUWG9RUC9t?=
 =?utf-8?B?MTVHTUJBVkZHd21XYXozaHFrZmxCcko2bDBkcVE1RS91SjRmN1NueWFQbGc5?=
 =?utf-8?B?R25HMWNVV2lKdGM2YzUrSyt1ZEZrSlpIOXBpUWJMdkZWOWlBdllSelVZTGhP?=
 =?utf-8?B?WWk3SVFGdHhlaDhLVXZxNmxpYzJ2N1EyWHFJSlNvMWE4MlZFOHJwU0dsN2d6?=
 =?utf-8?B?N0lzcUUwTDE5T3YyandtK2h5NjZoZCtSYWJLQXR4azVGbjdlQ0JWUmg2c1Z5?=
 =?utf-8?B?N2k1OXRVTnAzcGFobHpRa0dtZDQzcGNXVkdnYTEyQmt3YnhXbXR3TW5JKzlT?=
 =?utf-8?B?Q0tKS295OGhrTDkxOUdoc05pWm8wblpwbXNiU3JEZE9FK3QxRzhHTTIyTTh4?=
 =?utf-8?B?YWd5YTRDMDJ4Q2htZzA3bXgxeEIxRW9KZjIrSlVOWTBBM21KQWZRekZVSFhx?=
 =?utf-8?B?SU1LQmEvMHRrYmQ1QlppVWU0d0g2VkkwRUpmbGEra25TaWcvZTcyZ2lpTUxY?=
 =?utf-8?B?cEFNTFBERXIwQUxLMTBCREZiclRXYm5ReVN0L2RMWjdPa3hDejVOelV5WmhR?=
 =?utf-8?B?S2I5VnJXekRnbDdldUhRVzh1SHZkRTZ3bmlVV0taWlJqelFmckNPbzhmMXVC?=
 =?utf-8?B?NnpQK3h3bkZSNG5vWmkvTU4zNHczYkxJWVdQdUZVMDBEZjk1bHJMV0o3TU5J?=
 =?utf-8?B?ZGNUeUZ0UDN5ZDVqY3NkcnA5YlIxcXRSNDczT3cva2h3YkF0RGREZUlJTldM?=
 =?utf-8?B?Vk5YZGdVcFhKT1JOeG8raE9namRQTTNVeW41OU9wQkJ5TEN3cnZDcy9mQ2JO?=
 =?utf-8?B?Sk0wVXVxaFMvZVozcmxHVXJqV29VVTZqaTVkRklKQkZaUUJHRGpubGFsSXZw?=
 =?utf-8?B?Umt5K3RER0t2YjNaNGhMT2tGR28yVEU2cFU3MUgyaHFGSHRrVFlvb0ovQTA1?=
 =?utf-8?B?bjltZTh6bEowTnhqQzg2S1FpOVRiVkhUMm1wbEVtZVcwSXRzN054ZEJ4bjNo?=
 =?utf-8?B?S3lMVXAzZFBrbCtuT2dWTjA4b1J1dGJ6RnhkQjFLTWI0OFlSVmdOUEg4bldy?=
 =?utf-8?B?UnVwTUJUeEFWSExGV240a3JsWUo4dkIzT014VnBkckRNcEtxZk1pQ21lN2s3?=
 =?utf-8?B?Tzd6WEpXKzVhdmNhbm56clI3RmFvbEc2R0ZHUEEwNktlNHAwQTZQbGdxYXNN?=
 =?utf-8?B?T09DNXk4aU0wM084cFZaMjJxanFYREdtWDRQWkVDVkZZU2FOSlpVKzZMaEhK?=
 =?utf-8?B?Q1ZIWW45VnVjU3NYaUFoY3dpK3A4VCt5OE9mWmhHKzVYNUIzU3g2ODJ4NjBL?=
 =?utf-8?B?S1IwYUdranlaNnRpakJiVk40NThoQWJNYlVmZmppSHVvWHVJTWZtWEtSQWxO?=
 =?utf-8?B?cUw0U3V5QW8xMURNcjUxT2NucFF5a0IxdDlacXlXUU9aejNYZ0NBMGkvR2Zo?=
 =?utf-8?B?U3RjdzdhWnZYcVlGUGtRZXVEQ2ZrY2pvb2NRNGlXcXpqZWdMTmR1QXNkL2dW?=
 =?utf-8?B?aWVXR1VKOGpaVjhmaGQvdUlBVks5L3BjNXc3RmduVWtUcEFnOHZDakVhemhR?=
 =?utf-8?B?N3RuenpWdExGdWFCNUZ1SmRGRFFwU1pBUCtvQmY4bzU1YmRrTDU4bDJQckEw?=
 =?utf-8?B?cmNib1FucFlzVy9DWTNlNTladFN6SWhubEZmV2o4a3BiSzFLNGpYTU52Tndl?=
 =?utf-8?B?cnNUQnlubHoxZmg5eGJDeXdsa1hFMU1hVWF3Y29Ubjd3cnZpS1c1U1A5SWZx?=
 =?utf-8?B?MGU5L3c2UE9Ud2ppTmtmcnVUc25zRTlKNDNmRkhSaGVBZUpXbXVDNGJmeEdt?=
 =?utf-8?B?Qm5waFRhaEswWVVGbU9LS0VZUEQ4eE1Xc1VhenJpa3J2TGJHLzA5eDJKTjFw?=
 =?utf-8?B?NGo3QWVxRHFyaU1LVmxzL1Y5dEVkVmVDT3JsOHc1VnBoOE81MC9ZWFRMeFVw?=
 =?utf-8?B?RjllY2pXL3BVT3dtTHdJejRoZUF4SHdUbi9LUjFWK1BzTVN3WkVOT2NLdTB5?=
 =?utf-8?B?NTkrNkR1Ym1jdytRYmFWUHNnUzA0djljcWxqVVNIWUdrNTFNY09sQkNYM212?=
 =?utf-8?Q?lDSr0yl+wj94lXW+yenYPWDPiK2iM7KsNLN2o?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d5a78c-14e7-47d1-b19a-08df3c0082fc
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 12:21:40.8257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rft94Oi7FDttKLP2A04cczlN+2P6MfZcWn2phSKF/7DFCmG5XxTfpKaVmx3lMOp9sloEib7DuvZMBdc3fWwsNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7842

On Fri Nov 6, 2026 at 7:04 PM CST, Miguel Ojeda wrote:
> On Fri, Nov 6, 2026 at 11:45=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
>>
>> Could we check for `-Cprofile-sample-use` directly using `rustc-option`
>> instead of checking the rustc version (e.g. testing
>> `-Cprofile-sample-use=3D/dev/null` or using `$(call rustc-option,...)`)?
>> That way toolchains that cherry-pick the stabilization (or older 1.100
>> nightlies from before the flag was stabilized) are also handled
>> properly.
>
> It is definitely an option, as usual, but this file uses the version
> elsewhere, and we have preferred so far the version one where
> possible, because it is way simpler and spawns fewer processes
> (especially so in newer Make), which Kbuild has usually appreciated.
>
> Regarding old nightlies, those are not supported by upstream nor by
> us, and we intentionally never attempted to make flags work for
> particular binaries out there. I think the fact that we support even
> nightlies from Rust is already quite a success :)
>
> Same for custom `rustc` forks, if you mean "cherry-picking the
> stabilization". We can't really test those, and if someone really
> needs that properly working and can make a case, then we would need to
> take a look at all the version tests we do (and not just for Rust).
> Perhaps some folks only customize 1 or 2 flags and thus only care
> about those working, but we wouldn't know which ones.

I suppose another option is to check version and fallback to probe when ver=
sion
is not new enough. This way it handles both the case described here (and al=
so
have the benefit of being self-descriptive that can remind people of remova=
l
when MSRV is ultimately bumped.

The "cherry-pick stabilization" can manifest in other forms in distro Rust
compiler too, so the issue is not entirely novel. IIRC Fedora enables shado=
w
stack in Rustc with patches despite it being unstable upstream.

Best,
Gary

