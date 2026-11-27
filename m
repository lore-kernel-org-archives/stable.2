Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.132
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795738351;
	b=1fUJDvvYpd9PgjvsGLquFq47pmXrorYiP+8Ag6KAZCaRWyq408SUsxdmZYuHsC0f8N+G
	 kwMLdm7qLwpzyK4xHGZeU3QYNpg7a2koRikqXeQ8cVbRCuir5Mkh8lLumbYhbqPWx6mR7
	 0LBmwRWqcnYaXQpF4faFrTWK5SA8egIVUT3QPsWmd/fqgC495LqckYKIh60iP7R5j6JwS
	 sa9e6V6umVSlhGMJJXMxi7CiU0fqj3VHxW3qPQ3SF5Y47NabYnCV68HGXwfrrbJZkEoJx
	 NKhUrs7s/to60fZfp1pKJqvLV6AfWH1bNFysbKi/Aj8oBPNE4nxfMIdNgath1IbMMxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795738351;
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
	bh=9n0e3Kl9V8E6WVO038qZgzGzJ+NCYv/rid/OliU2aUw=;
	b=dlLqRu7ECdQWBgdAARftoUi5oOwAjk6p+m9jCAZtIgvEM9jjuUMP6rLyE/ZQqKUkj9RA
	 L26GPMDsWuDE6hqHVrWuQ63TN/biBxdazS5nEREvnTm9lPqMqRoCoBf+CAjPEhCfjD7LB
	 jqlzhXaIAa+cUiTEX6PR3fwHj3+heVmnqInkwJCBYeaoRksaF0L/YZngkfW8YAaAVMEID
	 QiGeNlxNXDFV1dZ5S8gPf3ABqkx9AmUMySFHdm4C6ZgEUCC1mTuNkZU/zncXM0z0xPAdI
	 gQOs9c3ygHJmrbVB/vKGr7GF6LTmFoDmeZUt1TNA6q1ATaPFGSPESI5IHucqht8oRvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=bZckvAgL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.132
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021132.outbound.protection.outlook.com [52.101.100.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECF4606A31C;
	Fri, 27 Nov 2026 00:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ECF4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=bZckvAgL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6ev1HUdeM7UjoKQuPCGFQtkGf55Mm16iWVYgO1UeU0i6hYy3akDPqS8GiRtLveEUSRrs5XRBUfbmOeDmCSz/Sz/2K2FgMiJHKemFMi1Jk1oJOd4dcnyLn7YZmaYP5JJCE6tcE86bi6D0l92v7Bkq6n+jO0MLepFyMUUqPBSl44dbQqsnzgBqgbWMYxUi2RjE+kdtp09UvlPkGrk0fVCZTE4O6NicWl2Y0nz+y/wxi0tVrqkePjnH61KOFS9sCw7SSYwNGFWD3MLf9eKqECuHhsk1DMG8AcJcbYmwcWlY4yZ+DCM9P067Kcp7aYIzVqZ98QjpwVNd4ukD1kQfHLJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9n0e3Kl9V8E6WVO038qZgzGzJ+NCYv/rid/OliU2aUw=;
 b=CISv6K44X3iS1EANgjavbeNNKgnN9XvxVIFaR3BNGu5rDbexX1vseipm50DrCUJnj8mk4pElxIl4uw67i0u8z3np4p7O1rJ3L4FCNH6mLSzYpxEwUWxHyEgMVK4Eff8fOZx2AzfFjZcyNEis32So1hBGDzS8rcFt3/qtwW+xKlWbK2GfHP1KsZck0l6jGLpek0cfMbpGLKeUT4Riax/069V+B5GXG6Zyl+ae6XOZfV+UeM+qz1qYISjmpZL27uSg+wcHlZMLfRFKS0dyn4iztk7TfLdeGUbl7APRFCNd6xWCsXhLnTfuvlDSZBuCZS3yaL5iqvXkPno9ydSbpAc4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9n0e3Kl9V8E6WVO038qZgzGzJ+NCYv/rid/OliU2aUw=;
 b=bZckvAgLqqHaOfZ2PQnlSiOiNXuxsmHoQ602ii/g0Q4Eubpo+PpyqNiqTYwtOEQ17o7OntEQAoMWxe5RGazRp8wOrVd56x1/4FQgNwg1FLJFlTm9UU9w+PwS5MNDKwqvwPemw5mK1Kc3IrDvo0+ZA8PiJ6uew0RF0VcFcGfw7nw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LOYP265MB2336.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 00:12:29 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 00:12:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 00:12:28 +0000
Message-Id: <DN5K48IC7UAZ.3V2ZOST74K63G@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Benno Lossin" <lossin@kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, <stable@vger.kernel.org>
Subject: Re: [PATCH] rust: init: clean Rust 1.102.0's
 `clippy::large_unopt_stack_frames` lint
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261126131456.87524-1-ojeda@kernel.org>
 <DN588MZEFFDT.2Y4U95SAKPKUK@garyguo.net>
 <CANiq72ngsLjcJQK-Tyew1JVW3rh+A9=eUFR5h8c4Sji-FbAN8g@mail.gmail.com>
In-Reply-To: <CANiq72ngsLjcJQK-Tyew1JVW3rh+A9=eUFR5h8c4Sji-FbAN8g@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0343.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::6) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LOYP265MB2336:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbad897-5167-4b01-fdae-08df4c1b1f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|23010399003|366016|4143699003|18002099003|22082099003|10067099003|56012099006|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	XRNCBAzVMYO0VXGpunfqxfvEyFy0Xcvpnf07pKYca3VSXF7jNNiRbV1ze4zgdi+jyaSKUBX9kGWpy4QJB+pN6Vf99Vi3yq7RU9t6xD/R3giOZu8sOR0yydt/umkY5AxVgnMSY/b/MAgmraZL8fHFzvDeTuophnfqvMlEGtLYlyYdKWSz8iBdA+BL3+rNpHVivZ4DjkKBrRrCrk1Hadi/rebQqPuOj+UCFi8xJJFsYlHaWt4V9AxCyQQ0iCxWRbzxE7umxw2BuU+VL4ZIivdBvhOtpagLWfoCxnWJbMhKQ8jVNmlC0BNVcTRGrY//2YigMncLnGlCuUrsFNv9HssQg5idALRfhTwEbMUcFnwV+NJCq8hClt/76HsTvoBst7Q1NUwPy1dmUNWFyMTxCDHyksfoMBBtsdog4IZXVduiqq3+zpUZSMdnIXErc7mZCPp7nFQHMrmK8gaaD828dbE5UOSEZIcAmiAifoplUIQTLlinlKI3Yn+6MyyeqzHPVXSy7rNQmO8qMY0zeCoZDHDCZTdGl1LCNKsnZbqfoNkazLTkPnHpG/zfN0Ez8nd34OCSZsmOAcWCvVgIOPU1MxKoJ5tw1lfRkpUDwKXCxyRBZHBO4Gr3fApnGfxtBa28e7yQxg132qE8NskvCGDlBJTiuQFLjYKIE1EGhZvy52WiOuY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(23010399003)(366016)(4143699003)(18002099003)(22082099003)(10067099003)(56012099006)(261026121527099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1p4cUZoK25Scy9QL1lnQ1pmdHZtKzZ5MHV0UG1ic2RJaGJDN0s5RE9lejhi?=
 =?utf-8?B?b1NSN2tKQTZYajBtdFp0UTg4YklaVnVxTDVaRFlYNnZXTFBWSVkzaDdCM0sy?=
 =?utf-8?B?OSs5SWZBWi9RLy9wUitsMTh5TzUvbVdQNFdzSk8xZTRhSFR6OFhRbUxnejJU?=
 =?utf-8?B?bXlVbmJJYmJqbVVSMStUQy8vOUtIT1FXS0N5OU56TElaS3BCa1VWeDlZb3Ir?=
 =?utf-8?B?eFEvbXhRZ3VYVTRoZzY3Rkh5a0dHNTlwQzhyeVQ2aVRhbUU0YStza2F6MHBS?=
 =?utf-8?B?bGpDTlNpdTVEaG1XZ0ViR3NGTXc4cE9UdzZwQ2x3ZHJPdVZYMldPTFlSYTkv?=
 =?utf-8?B?Y0pCOTFQdmJ1SUwwZnhsa1lwL0ZHb3BobUR2Z0t1MDVNRmRlNHJmNzZtMU9U?=
 =?utf-8?B?OTNUeXdxMUpHMDkrTHcxcjBBRlBKN2lOTGp2SiswQlM0MGVycUJMU0JXdnNk?=
 =?utf-8?B?eHVrK1Z5V01oSmRzcTJlRGdKUnZRL3dJcWhXazZGbzhNSnNHTnZKeWJtckI2?=
 =?utf-8?B?ejZmMHIzZGJZWC83Z0F0anFNV0NqYTZTNEFqbGU5aThxSXBzOEx2YTZRQ2lF?=
 =?utf-8?B?RG8ya1d5alFZSzZNczNtQWx4Uy9YcWRsSHZONjlScHBDczZTME9rRE5mVU41?=
 =?utf-8?B?bWNUd3NKSGlmZnhnR3VHVDYwYzlLNFNsZGFUaW1obDJSbUxkN1l4ekJXN0or?=
 =?utf-8?B?b1k1N1RIQTV0bDE3cXRZR2Y5VEgzczNZeGIreitkZ0xRSWpNbjBwNHEwaHdu?=
 =?utf-8?B?L2dlUncwVGIyL0ZBd3B6VXNwN1hycnBMVnZJRENOUUtjdXRxMGZkaDFGUWt6?=
 =?utf-8?B?Y3hBR3J4SHRjeEt1TzBQSUM4QkRMQUhsb3dRbUZ3a093T0lLdHBWVHdNRTU2?=
 =?utf-8?B?WWx3WmY4a291c24ydW4xTk9XRlRtSG5UNEFlbWMrb1QzZ1FWM0hyNXYvS3pz?=
 =?utf-8?B?NEZBL2dhMUdUazRkaW1ybHQ1ZlVVeG1oQ2RPTmZRdm1lMWFsRGZuNzZ0ME9T?=
 =?utf-8?B?Ui81VnRscEM4OUp5UUJqc0hoNXFtb3dhK2hEQ0pHNGcxZXRCZnN2MVBzL1BY?=
 =?utf-8?B?Nk14WmFBRDdIbEkxQ0pld0ZjVjh0OFkwcVhlaSs4WFJzSEEraFE0UmpXSXhm?=
 =?utf-8?B?WlhWcjlxTXgxZjNaN2tIUzgrNGdHdmwwZ1MyVTFMOTUzVE45dGxXcjA1bWVi?=
 =?utf-8?B?OW9WTTBweVozQ3Ixa1NyaGJYSThnYkt6dk1jdFBOZ3Y2MitRUVJac0dpYzdU?=
 =?utf-8?B?K0c4RGpiU001eHNlaDlpWEdJUTdVWVhvY3VocS9sTjd1a2xSOXBHMkhweEdv?=
 =?utf-8?B?ZHNCWDlJMnF2Z3NRRUE3VDBKbEk1NmN5SkxuL0toZTN0aU1HeGpBZWpyMXdR?=
 =?utf-8?B?VENWQWVFeUFKek9Dalk0ZTZKaUJDcSt6Wk1UZkxWdVIwdWMzNGhWL25aSkVW?=
 =?utf-8?B?RC9IbWVrbjhiRVJKWndzenl6bEZjU2gxdWVrbjZpUENZVUdFUW44Wkk5RUJo?=
 =?utf-8?B?Mi9WYjQ5K3ZPYTF1ZDd4MlIxU0ZNb240blFkRGJHZ2xTaVQ5SGZBWFZnbUxk?=
 =?utf-8?B?QkRaZk9QYUkzWmdRKzJSd0FqRjIwNHdnaTVFbWdoRUhNd3IvSlFod01DbDJ3?=
 =?utf-8?B?elBoM3BHSnovZ3EwTmFXZWd2VUMzMm90WmRVWnBkM1JXRjlXYUZ5bENIbXM1?=
 =?utf-8?B?cjJCV0FiY0phTVlLdUdEaUY1c2p4VTV6MngzVStBbWc2eXZtTTNDTHVhekJG?=
 =?utf-8?B?UE1oZGtKNzV6Y0lVcjJPRHI3OGVXQzFqWGF0ZEIyVEljN2NxMlF0aEtWcUZN?=
 =?utf-8?B?bVpFK24xTFRCZ3ZtbkVKU3lqUy9CZ0dZK2h3QUpTcnRzRThoeXBBcEhHanRH?=
 =?utf-8?B?RWhaeFNOdlVqUjV5a3F0eVA4WTRVMVZPV0hqVkt2d0ErTGFNL2VpaWhkSktp?=
 =?utf-8?B?ZnhQbXluaXlYaC9DUnBPNCtQdGhtd2VCbHlmY0wwSU1VeG5zREJHMTEzQ29F?=
 =?utf-8?B?VGRjMGFydG5UWWUxMUp4Q01ibnNZTVIvVlhYWXE1akpRQ21FMk9CRHRDV0dF?=
 =?utf-8?B?RlBxbDBrSVIyUDVIcWJHTjM2V0JzMXFaVC9JZE1BRkNvRXovYXJJYUFQWCtY?=
 =?utf-8?B?TFkwSThSL3Y1UlQyTVU1UWN1R3JSM3hWZzY0L2plZWZMbUhhaEMrRy9LdDBK?=
 =?utf-8?B?NHJsZXVudnFSbS9ldG1WUXhTOVhvU0taZElONFJINXF0dmloWVRZUk0rcWNq?=
 =?utf-8?B?cHgzRVJVR044UW11RGpjWjJ4U2ZibTZWTDF1RmJBUWFUT05kOVJYUU9YR2Y2?=
 =?utf-8?B?QTBQL1pLQlg2U0padExrOURKdU16clhJc2xEc2p2VTVBWFRqNHNodz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbad897-5167-4b01-fdae-08df4c1b1f7f
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 00:12:28.7518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xdLnT87SDQ+AVutf2vZ6s+Cj+4uZ7Xj3++omFlYCO37RX02Sui2pyT+pwr0leNfyh9Bbfk6wuALa0L4gYxBVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2336

On Thu Nov 26, 2026 at 8:17 PM GMT, Miguel Ojeda wrote:
> On Thu, Nov 26, 2026 at 3:54=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
>>
>> Given this is called "small", would it make more sense to just change th=
e size
>> to, say, 128 and keep the stack init?
>
> Sounds good to me as well. I can send a v2.
>
>> Actually, I wonder if we should do:
>
> Hmm... but then there is no fallibility for the example, no?

Indeed. Let's keep the box then.

Best,
Gary

