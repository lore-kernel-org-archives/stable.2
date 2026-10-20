Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792486565;
	b=UcnxEuG1eITng592ONykx6V8zrJ4xdvEUqTlHzZGOw1KaTBYDFtIbCspVm6KZpuK0xF3
	 VrIu44MI7vEq7b5mjZc7x8AVvR9R6rIEYmNS0XJcK1ml7MY8pT/PpHzT4ECerOLNN37E/
	 F6TacIqrm/oB7TFk2uctBXg+TWQvZKfnKOEBW8bv/G81De9qbd5tvIVyD9eMrEhmB8oXO
	 NU7XAJwY0HJ+RJezHcj624JY7jxyTDSJUGM9igF+bRAeDmt7PSGRxPhJDKabbpnvKFji8
	 CJCS/Fq8MN+sQdHRoLCAfUULJgTdc0252Urs4JBGlCpZnMppcoJw53OImJM7iR8E9pA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486565;
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
	bh=cIpZyNVYXmILukAUgZqSzfPwWfI2Ag6jz2J1V0odIfA=;
	b=FVomO9z2Dpbx9qFN4TRNw/IuJ7nt4FqFSU8XiiZIKXyvOr2qyfwwqOiDaNEYJN3zj9+Q
	 KTITVTTpx0/f7CsB+w3DPjWRW+NJoKII577gi7Q0W6o9cgoJlw57S0JGl8I7XrqsAwqS8
	 OL9a3NB5FpVWe28JmxdKzzcN8ANfB99dPdTmShu8fVtsoYdt4HsGFddbx+RZ62L68hTbs
	 Kr3bqtAOIl+a9kpkKmj/euNZT/klVOO1ImoqjXm3jJkD/pWB8yPpwnNNmL6gFJrvQhXub
	 fxxyLq6aWwJk3SKHrzTJ3iSbV2D5ThAt/mPdJCOjoOqjmEmSRbh7vPxhiGGD/K2ztsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oOBBksCL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.5
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012005.outbound.protection.outlook.com [52.101.53.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8803F606A330;
	Tue, 20 Oct 2026 08:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8803F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oOBBksCL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeGAI7lQh9dE0fpEehf7z5dPByTDCLp13HTryM2AwPvrWjWgdbGvcVEBN7A4mrKd7gtJExfnSKC9X+9D5xf85mwKbvrsDDPLhC9ua4TPXWgcBwKANGdTMrXHk7G9sRLlytG7J1lRLneZfIP9YMHjsqszMYTapKaK5VxyqULOiw85LiD9tQOSczE9VJfCFmcWsNGWxJ71p751OyQq4dCk1ebWLjf95BojLnB9acuS/3JI1ngekLmKSxVqV8LP2hQFowa4bxP7WVIGOwyrXgIKWnWIrsbxSI9chdMjoe8YHoBszHDZa2mYneWyqghTAQ8QTxhuyyKdAAPZI/PYoo7C8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIpZyNVYXmILukAUgZqSzfPwWfI2Ag6jz2J1V0odIfA=;
 b=mRgpi15ewEU1No4b8rRso6EMZLjWNM4prfFtZHB5Q62tKQ6q6pUdmOVZfrmBjKfdDwVZBcUzKynVdoSiAEcYm/94OaEcw4LRsyH1o80CwkDaFHjB9ceF77EJh96upmn0DKO+h8uLwDWSVWnINsz6n47/r/NvxnuTJW55T7QJheEkSfKmw6XMgK3Pji4GtuRcJ44sKrcf8sVauidqQoP2/IDDDrYBY7qEcZ9hkk/Wwya/oa+TjhQDmuUCBwwPq+UezjMa0AvQpLrJJm3u53xhM1fbrGqK0bL5wkhShbZAbdI8EZ+UozgH0gppQYtnJzhlEiWoAKujae6Ja0dfsH1azA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIpZyNVYXmILukAUgZqSzfPwWfI2Ag6jz2J1V0odIfA=;
 b=oOBBksCLkE+AmuXqk0F9jPaYR2JPNm+mcLep7JrR4viuC8IFYVnoAiXwvLDzRrV1A+U3sOs2pN3xSisorSF4KxlQUjiK4DHK1tdtj5W1Vr1JoxGXKoNZXScPADINilEyXWuJYYffxIhupxf6OdRM3bc4e+kt9+LVzA5JVb4YqihP4ywL5Js7E4ibCxbONtIjQR2ilbXreiCcsQrHuThPRKUzj1QBE2XnbTTCZ82Bzh1YFOSLkuBHSEqzqs23bZXHCS53ma8m8Y0KdEcvodVe06hWGcYwluGqc54Schqs5hdernrPFQ8K2mD8KY0LUq/Ko7l1sVRW/UmPckqPDZCxbQ==
Received: from SJ0PR13CA0128.namprd13.prod.outlook.com (2603:10b6:a03:2c6::13)
 by PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 08:55:59 +0000
Received: from SJ1PEPF000037A0.namprd04.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::7d) by SJ0PR13CA0128.outlook.office365.com
 (2603:10b6:a03:2c6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Tue,
 20 Oct 2026 08:55:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000037A0.mail.protection.outlook.com (10.167.244.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 08:55:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 01:55:43 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 20 Oct
 2026 01:55:42 -0700
Received: from inno-dell (10.127.8.11) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 20 Oct 2026 01:55:37 -0700
Date: Tue, 20 Oct 2026 11:55:34 +0300
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
Message-ID: <20261020115534.1134f2b3@inno-dell>
In-Reply-To: <20261020-fwctl-cfi-encoding-v1-1-ebb30d1500df@google.com>
References: <20261020-fwctl-cfi-encoding-v1-1-ebb30d1500df@google.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A0:EE_|PH8PR12MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: 11239bd1-23d6-4884-0365-08df2e87f626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	WPppd+BSbzF5csKk1E3MdPrR1iOxtpPVpHRRxPk3OheM8576pMS5IT6vr+hTmS8+hGoYnLCcitZw+/fvKO0QzT6QlRSUGfhYBGpj523vEsTiInqpx/3zYuSrRPv3Sdf6QTPLFQ74L+WLuiZbfLRFPUCuS23T2nw5B/fPjYWg6PjTOzfI2fxLwHVsknqn6PHm91I4xOrhCDigYlCJEFBdhmmFq468U5VE1UPCzj7n0QPANH0c59v4L6bd29Am71mWvGo2Z5Nob6zxL7BeLzGdcp9QcGDYiqWvPYDKSCHk+LtSFDSssNFT1QbN8IJz8QfJiOuSbADsDK7Z9Ke2LUKg1OopnXIMhU9LmjnVNAVDQBZbQx+gLmPoUkDJ1lAPSCWV9fePYyEkPTmXhUbXNHN9E5k3+UEHoooHLIOKIxEFIYc5uWX18hIBJsMkahpKiBln8xm6ciS2Kh6k6e9kLzZtVC9vn8vX0PYN5nzBgiFeX9waHbkJtiqxMW+F+FJObj7SytO+Hx/exEqHiJ08hEbAtQ18doH1Engi9arKM37DF2sM0JUhDZxW9FahRCWumxv6sMe0SeRVfDlLxW+hYXCdxeF4ljgfVh+xBMTdJ9QX5pwuFQkoup8OGRnoN31xiYALocBRIzGqir5euE0ssggSAweKIHF+xM1ky5/K6p8x+qFOZ52yIknapStV+kXzx6r5DgSHycIH3EGkXA10UvOueQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wC0zy5l7l0TYQjLPf3HHc3HX5f36ejMaI0LHNWzCMwOS/MuT+xFOArJ7sRyc6XDCM4vNHKJQr4UE0qtXWYTU7pzI9JREv2avGYAboFRACaW4xVfD6SwxJufhOdKowut6aIRrxQuYa+EDimLTldgFxiL4gBaoV9b/VNNWReogQm6eaxlR46PBjfNDrWzwnV0sijxNcb7UyrRZJ0wM3VZzN3jcxHaEn7kRAhwtYHIN321O0UdQtWLZMvs+phUhbB4BuGLpF1lYbeCDdWxQa8O2RqiRQqgtvRjVVbKjNY+IPXDkdMYqB2nxTs/hZRp9hyLNV0iKHDokii+RfGLAvg16XcaJn8TfLShsHkEPLg8RuQbiC5F6YIufIE1ql2VJYK6MkQAoEIzQKHnclTNWro2+pTtiSYyfyFiY3/9qmknjnVi0nOW5HnF3V5T+zCXhKttK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 08:55:59.4397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11239bd1-23d6-4884-0365-08df2e87f626
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6938

On Tue, 20 Oct 2026 08:28:37 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Currently, VTable::fw_rpc_callback() takes scope as a u32, whereas C
> calls fwctl_ops::fw_rpc with enum fwctl_rpc_scope. With kCFI enabled,
> enum types are encoded distinctly from integers, causing every fw_rpc
> indirect call into a Rust fwctl driver to trip a CFI failure. Thus,
> generate fwctl_rpc_scope as a newtype with a cfi_encoding attribute
> and use it in fw_rpc_callback().
>=20

Thanks for the fix. Looks good to me.=20

Reviewed-by: Zhi Wang <zhiw@nvidia.com>

BTW: I saw this =E2=80=9Clru_status=E2=80=9D needs the same treatment, gues=
s bindgen
will someday automatically handle this?

Z.

> Cc: stable@vger.kernel.org
> Fixes: e052daab94ee ("rust: introduce abstractions for fwctl")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindgen_parameters |  2 ++
>  rust/kernel/fwctl.rs    | 12 ++++++------
>  2 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
> index 8402b0c93545..e4f8c07743a8 100644
> --- a/rust/bindgen_parameters
> +++ b/rust/bindgen_parameters
> @@ -27,6 +27,8 @@
>  --opaque-type spinlock
> =20
>  # enums that appear in indirect function calls should specify a cfi
> type +--newtype-enum fwctl_rpc_scope
> +--with-attribute-custom-enum=3Dfwctl_rpc_scope=3D'#[cfi_encoding=3D"15fw=
ctl_rpc_scope"]'
>  --newtype-enum lru_status
>  --with-attribute-custom-enum=3Dlru_status=3D'#[cfi_encoding=3D"10lru_sta=
tus"]'
> =20
> diff --git a/rust/kernel/fwctl.rs b/rust/kernel/fwctl.rs
> index f29244fb0d1d..b7778e4d5ee0 100644
> --- a/rust/kernel/fwctl.rs
> +++ b/rust/kernel/fwctl.rs
> @@ -53,13 +53,13 @@ pub enum DeviceType {
>  #[derive(Copy, Clone, Debug, Eq, PartialEq)]
>  pub enum RpcScope {
>      /// Read/write access to device configuration.
> -    Configuration =3D
> bindings::fwctl_rpc_scope_FWCTL_RPC_CONFIGURATION,
> +    Configuration =3D
> bindings::fwctl_rpc_scope::FWCTL_RPC_CONFIGURATION.0, /// Read-only
> access to debug information.
> -    DebugReadOnly =3D
> bindings::fwctl_rpc_scope_FWCTL_RPC_DEBUG_READ_ONLY,
> +    DebugReadOnly =3D
> bindings::fwctl_rpc_scope::FWCTL_RPC_DEBUG_READ_ONLY.0, /// Write
> access to lockdown-compatible debug information.
> -    DebugWrite =3D bindings::fwctl_rpc_scope_FWCTL_RPC_DEBUG_WRITE,
> +    DebugWrite =3D bindings::fwctl_rpc_scope::FWCTL_RPC_DEBUG_WRITE.0,
>      /// Full read/write access to all debug information (requires
> `CAP_SYS_RAWIO`).
> -    DebugWriteFull =3D
> bindings::fwctl_rpc_scope_FWCTL_RPC_DEBUG_WRITE_FULL,
> +    DebugWriteFull =3D
> bindings::fwctl_rpc_scope::FWCTL_RPC_DEBUG_WRITE_FULL.0, }
> =20
>  impl TryFrom<u32> for RpcScope {
> @@ -539,12 +539,12 @@ impl<T: Operations> VTable<T> {
>      /// - `out_len` must be valid for reading and writing an
> initialised `usize`. unsafe extern "C" fn fw_rpc_callback(
>          uctx: *mut bindings::fwctl_uctx,
> -        scope: u32,
> +        scope: bindings::fwctl_rpc_scope,
>          rpc_in: *mut ffi::c_void,
>          in_len: usize,
>          out_len: *mut usize,
>      ) -> *mut ffi::c_void {
> -        let scope =3D match RpcScope::try_from(scope) {
> +        let scope =3D match RpcScope::try_from(scope.0) {
>              Ok(s) =3D> s,
>              Err(e) =3D> return Error::to_ptr(e),
>          };
>=20
> ---
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> change-id: 20261020-fwctl-cfi-encoding-70766ce0a03a
>=20
> Best regards,

