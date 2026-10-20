Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792487363;
	b=bme+u7dr9TDTCXLk/GzVsYM59reYeSGoybz8+juhDQql0yk0sJePd08U3wiUEGeRytX2
	 uHFjvmRjjyPH3ZF1vESfcr9jeqgx5rB1tVTDfwPvzhgQfpF2XNoVAeJx8UtGIpXzhFJQ7
	 VlK86pn4QzHZ1PRnU66i/yyiUkws/JqGOEIgsOf1BhsBxBUx/Z+vFrYtMtdUjB9B48PPF
	 5KAXoieXmpxGUV2i05qWL662762STh3JPa08NfRg/ufm/cBw/c8UaIXCJc2Dfz9M7yt8W
	 UmyduFQUOF/8o+aurj2hS+OOq5XVE8Sj5HjtTgz/V5NiKmZzjOleSUmYi+Z2mRiaTLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487363;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=y3uxMvmoDQrFstw6K8YNxvF8PMtDROD7OCevSPVX4t4=;
	b=nDtJ39GULNq6FYvpvhQ0LjIxt/p3V9huTXi/e859p61fylk6Z9rx1jYmcbGQRwyvoNtt
	 4sNkLq4UkX9VTnb91WGCFJofhuXZo3+WvnIa/J7f2V0QK/uO7ExdSA/BidtGCeQm6Xbsb
	 RnCg5vh9fBUh8jea6PyOaA/p7Rc3W95+ROy+dtnML/XxBUDtDAls7iNoz0jsNuHxYRyUS
	 HsJrS7eRYZaQc+IkAunavfA1hTHLqQWBIuurEwfjfd4SXqTs6JcY/s+XuTcO9y5fXBjxK
	 Q0KR0+Sb2cI57o2eC5buvtaoqD/kOYMbJZLEm7GwiY3WgE7F2w7kthP1LdIHqTY9lhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="R/y5Sq66";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.67
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A45606A31E;
	Tue, 20 Oct 2026 09:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4A45606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=R/y5Sq66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGYt8C0q4MV0tm+CPBPPMTIniC265h3/bmNT4UYT44BT4Fktp5g138ziKS3AUMkdVHBdGsmOv+iLFO36HRbysihIs0VKQmDZIGZUObfOrmg+Xhr8bL6ahogmpXq+cHXEXYTW00wlQd4J6PSL2dwuicX+IyD11YGlJGG4iLX4Gbiyg9seali/0pMYtI8BHvLuHvCG6mnvV0u/orkUOT5msambJRwJTqA1EF1uQQIl4cO4Tf+CC/aGetW51kuXEG+wHnbZdVrEBoPizjfSmHX+CqefHm02V3++wLzg0/cN+BZf7dH4/0ovgIQEfJoh49VXEkpmzIPksCBJCkxaZ6uTog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3uxMvmoDQrFstw6K8YNxvF8PMtDROD7OCevSPVX4t4=;
 b=dsvfET7PmPK5DUV39fZehWaYBrNgXPYdhDt3F+dtLMoUsjBY5OcT2VvR84Pne7pK4LeNGvNvd8XiMkwu73W5vvFQ5bMj0o27Bo15iV5JcB2T8RMQqSanBQITqf3ifjRa+8Ddht+5LSFEdYz6/ZxU64xl3SYG7k4duQHB01SkbmTLVfyJ9G/kik1LasYWtco4eykzk7NDdC8TMXkrxGVPffs98/ZsxqBbWXIxqDzTOtb36LDNaAcqPvB3p12WBhBdMM5WZUYEZfD5Z/E1ojxkgBsO8dejZH//+TlpI4GeSOCnh/015wBHPZ0Zvrp/IrQn0iVN8OpFuq1EdsO0sy7xHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3uxMvmoDQrFstw6K8YNxvF8PMtDROD7OCevSPVX4t4=;
 b=R/y5Sq663qc+QfIH3Ri3wwrHEiwfoIKt9p0DtC5e3WFE98UA3T8IUjsImVmylwPfi86AXr4oCeE2DfRG1QQFLEMKNS8vtwb0qA9amxVAdes/Y7UF++8pRsymE4ed1pZKfigb9pYFx35fFNJ5R8TKaiBjvB+9bxFzMYU2m+FEzdSuSKksYg/oOiBARm30ywWV1gdZcTjLWFcKp+2hbNKKQiQt4llYYOHXe9lPWQr5F7IpTX9owK81VEc++icc1olnC8XXRAedYBHfhLE8r50KWkefsZTOYtha0abDsdvXWOZ3f/CL54wS69UQKP/hUyxL9Y5JlZM3hKW6LF2THgMfvA==
Received: from PH0PR07CA0099.namprd07.prod.outlook.com (2603:10b6:510:4::14)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 09:09:17 +0000
Received: from BY1PEPF00026959.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::60) by PH0PR07CA0099.outlook.office365.com
 (2603:10b6:510:4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 09:09:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF00026959.mail.protection.outlook.com (10.167.244.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 09:09:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 02:09:02 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 20 Oct
 2026 02:09:01 -0700
Received: from inno-dell (10.127.8.11) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 20 Oct 2026 02:08:55 -0700
Date: Tue, 20 Oct 2026 12:08:52 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>
CC: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy Baron
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
	<acourbot@nvidia.com>, Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, "Dave
 Jiang" <dave.jiang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Jonathan Cameron <jic23@kernel.org>,
	<rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Sami
 Tolvanen" <samitolvanen@google.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] rust: fwctl: declare cfi_encoding for fwctl_rpc_scope
Message-ID: <20261020120852.6d2ff11b@inno-dell>
In-Reply-To: <CAH5fLgj6oCjVheVLYu+X=ptFA-+x4cznX1+bgWT3ayndiA6eiw@mail.gmail.com>
References: <20261020-fwctl-cfi-encoding-v1-1-ebb30d1500df@google.com>
	<20261020115534.1134f2b3@inno-dell>
	<CAH5fLgj6oCjVheVLYu+X=ptFA-+x4cznX1+bgWT3ayndiA6eiw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026959:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fda0b8e-85de-4871-67f1-08df2e89d1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|36860700016|82310400026|56012099006|4143699003|11063799006|22082099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	HBYjph4Tzfxwv3ofol19MssFfCzTAADYwPDnmgnhwEYiHXA9wcyx2PEeiAlM34nwa2WBTAUz/H0Xg2srrQw/byML1Oruunl4JZpIBnJDqr38CqWKwf+FOYUffDp/sSsjfKggXFBROquQ+lEp7F8hCb3SSMoLzpQ8WHh4ptZxX3ZlVwTWeciIwUh8U0cfiXbO/sLFgQVhcmAtjAMo+8KhsddHb2COfDoqeU1xTmTDtqvo5azpNNbhrWLAmkA+hGfwyB+806MM2CWf58ckv7xVtNAEA2XQj2Ibtk/DO5Mxio4myTNhTW0XygtygA0I62Ye9m7atqg1uDfqso1XAHqiTwkA8O6I8O98aVM2isHnUY6KoNxAZfdta9cQ4/RCCfkOUUTrPEob2Nmp/DpCJ7e3OrFiS65QQZT5nAxneDbaSJk9biFmGzJEetL44F9e4bzz8OCIemulqBRlDGmeuUJBodEQjjCsOpyn6M4mGKQWhE+doDOUZyxEzr+1Fb0kHcmZCILIoZ2FdxD1F7co7HueZ2BwfdO4O79e9kJ0Vtivj79/qUa0cO6Jd5ohHPnvpFyG4ahlTEFZrC/Ojuw0TDpJfo1cUM0U2YWnobvQn1Xc8lbHQ61P5OdvNHrthOdDsRtSuFkOyOlRr5s+N4G6eJPdGCypF046calJdGmE1O0pcmGJg85J+T+SujDLAmIHh1nDkphIuLQhmpf5W90MuovgTQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(36860700016)(82310400026)(56012099006)(4143699003)(11063799006)(22082099003)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Re9/IKAY2+jUyT/I46xbGqvckxQsQDIuDkYpKdQd0x74FmyaasCDLIqvORvdbOF/0T2YUI/30Ysat67S61WskNK/5Xv3CLV0df59tR2q3mGTcCeRdio3KvccgTEBYsqR1/0XdaJb9A+9OJvyx2cUg1gRSsvYiW8sCj98h8C0VulCjo695G9bI0RmYr05rR0b4k+/z3lw1M6C5n/9TxEBrnsE+nq91QddsESDUEhOGtdypz7EMOg8kEdMa0SSzehLuPgDhZW5rJ4jQWSXvicN1EG3zPEFAq8GPTv9R0nuC//8PZXtb0Jwtjw/i7NA3UT8gmL3smp5cr08w3pULUQBOnesGUTjonBYpVdVYZh84iFxCO13fHW5cRIb1h0qYA+3jTPvxteCGycIw5zEM1nt5FMh06G0pHZOOXIwD03SjW44yc+s0f3YeU63ZfIkUOHW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:09:17.1562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fda0b8e-85de-4871-67f1-08df2e89d1a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026959.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650

On Tue, 20 Oct 2026 11:04:43 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> On Tue, Oct 20, 2026 at 10:56=E2=80=AFAM Zhi Wang <zhiw@nvidia.com> wrote:
> >
> > On Tue, 20 Oct 2026 08:28:37 +0000
> > Alice Ryhl <aliceryhl@google.com> wrote:
> > =20
> > > Currently, VTable::fw_rpc_callback() takes scope as a u32,
> > > whereas C calls fwctl_ops::fw_rpc with enum fwctl_rpc_scope. With
> > > kCFI enabled, enum types are encoded distinctly from integers,
> > > causing every fw_rpc indirect call into a Rust fwctl driver to
> > > trip a CFI failure. Thus, generate fwctl_rpc_scope as a newtype
> > > with a cfi_encoding attribute and use it in fw_rpc_callback().
> > > =20
> >
> > Thanks for the fix. Looks good to me.
> >
> > Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> >
> > BTW: I saw this =E2=80=9Clru_status=E2=80=9D needs the same treatment, =
guess bindgen
> > will someday automatically handle this? =20
>=20
> I believe lru_status is already handled.
>=20

Yes, lru_status is already handled.

I meant that both lru_status and fwctl_rpc_scope need explicit entries
in rust/bindgen_parameters. I was wondering whether there are plans for
bindgen to generate the newtype and matching CFI encoding automatically
for enums used in function-pointer signatures, so future additions
wouldn't need the same manual setup.

> Alice
>=20

