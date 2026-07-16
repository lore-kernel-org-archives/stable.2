Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020134.outbound.protection.outlook.com [52.101.195.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3753195EF;
	Thu, 16 Jul 2026 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210413; cv=fail; b=ZrtZ7XdldtzD1nt9FS6aND4aARuyZHFSeZCHZJG6l3KejOea6YVO/7qiQcGHS3o4XCOKgMwux/muQi3bK0ABEAKQ3ljtdEFFp7s1PHcIA4ravqDxBz5qigL0eYYguKI3xBLmx81UOM0HJgzXMcToFLRNl8M9I5Kul0WtS9pJNYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210413; c=relaxed/simple;
	bh=I9Xlz/5kOkT4Tycu+qZzsVATZrexRNJt8kMhSPhXqbA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=o3vRHaXKS9aiXBSWajZKPvSFoS2m4L4gTWhUFX7zNtTvtVLj1HorYPr0uGPYSIBtPSfVlnwqhxoONOCyYpY1Uqm9mQYmC2theYNnKg2y6UGj+LkLmoq2Usr+sA/vY1A0hOrmmITgfxdFBw4uXUpNQO+Bt7wXcf98v2mgCf4EymI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Q8lLhROS; arc=fail smtp.client-ip=52.101.195.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Q8lLhROS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRJ7IwSM9c8gb6uGWlB8b2etvIRAkvTx6u51ot6JEaBQs9bIz0jlXhO2IDdDhnnpbzD/fUVXamB69AT+J1ABrr1gjyw/mM0B8UjiVXyEeAwjT4zf16GF7HAwK8vF8lA+fdnVXEweLn9/sL1ExHsAjdwlmHtbRNJ3s5R+0CoplZuj1wX0Pk38rpKDBAsL7udk64p1O0wj5GW11W4gZMOD6bGWvnaOT/Ur/4EcBMQ/B+u2xTTstzAtbOplBwv9XbwyuwBM7hjRpWPHBees9UNp6+pMt/aYg4+5tDKCLrXDxrUVn/LSkPXQBdXD3f/1XWm1NLLVT8eIV/YAwyc6WXD9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BC5g6R+ENvJB23uLT7PoM6+a4wPhPmNPG5AdO0ILN9E=;
 b=GFqWu/flOojyWaiygeC4ZubU8WQM5Se0slOxWd7K+3F+nAdzgOHgUQ/v2HTiIJsUt5EnkGDWr8UoJnLA40TBNsejFf3Gr/m59cCYrblv3nT2pg5yRhPatjA5WDGBRJPk9af/9O5XUye4c+cUBztZi0q5lI6tLKDA8drw/Nmgw7tiVd0WIcgAbFOze2m0rK/xMM3Fg+6RB92Fh9FWEzdODyO5+qQMkiWPrr7asvamDfsyySpm7O0uA9/AXkTZj2TLVahwQKVVKQBfsCTUTe8KMzCbPEj5SNyjWBuLPBz+8Q/heVd7KnTtCn8Q9bBVHuTWh+LFF5MmV/byO0HcQWcGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BC5g6R+ENvJB23uLT7PoM6+a4wPhPmNPG5AdO0ILN9E=;
 b=Q8lLhROSAA3hbI6vk2ZxXiYX7FP+2NbxrPj1wIBvRLnIsPCieWK/dNC2PiIytrgoXGAGopkNVyrxFGfQA/EKamJCHw9lrOIgA+6qddA3vo7TnyoEzLYT50i9vSHA8uzYv+RtR1IBZ3NH+J6UsBMeoeOahemjDYtRcL/fL39//LI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5209.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 14:00:04 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 14:00:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 15:00:03 +0100
Message-Id: <DK01SW0X7PXH.15BGNJS3Q18BL@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] rust: device: avoid trailing ; in printing macros
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
X-Mailer: aerc 0.21.0
References: <20260716-device-trail-semicolon-v1-1-f48e9dcfae15@google.com>
In-Reply-To: <20260716-device-trail-semicolon-v1-1-f48e9dcfae15@google.com>
X-ClientProxiedBy: LO6P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5209:EE_
X-MS-Office365-Filtering-Correlation-Id: 08891a2b-ea49-474f-3d32-08dee3428934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|10067099003|6133799003|56012099006|18002099003|22082099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	M/qQZBjA5NUzWltwENs9OyFpuSKwJVzkyu7BO2ChiDGlwnTd1Pt77qiKZrWNpi6hK9ZXthHUWLCN9pK94IrKLL7BsySaefH2cLsi9IWqi/29L/MLK6BVrTTsVxk0sPkkXDy+nYBOKWyHn6cu1K0Le29own/LozHUJNXvXxXFXmVTilyBVvST5xJUMmSGMogAaSkcsYyJXsjfEmtyWTx716h+RzoZBADtl6y1S5hptFNlSAM2kqoVBxG1NeiZavyeVFHcJ2c2JSW+MTL0FiRNowUNuGk6vfFkYKyuQjtYnEEcRMsBkCfL0a4pxLzr1M4oFUVvnDkulMqpjeZwsjfxSQj3ufnuPn1BV2N0cnnuuCo6nBlZODTGnKd5o3aRIdVYApl5XpMuz72fdAIqHNdTgh2ym56NM0g/dQ4UwZiOHPuunbpD4KtK8V8ts2qsjgYdeT/6zAGhufkg843nPLXTExEjEa+mtwn8zQ127wmum7dWEsQYW4PLys5r++Aslf1QObsHqG3hHA5Wr3odgy93YZcmRwa3iSypfrqCzBmC2ikbWShAb8zEQb2XAqmbW0nFRhsBoa6wdx4vCk3oGh7du+7BpbXaCrwYiqR2mw/Ch8DG1ODJI1miNbnP0jpZGm5rVreGkgxMd+SPkPCWLhQQ3Tc7qiRtaeETs2zG9kMwBwuLeCN7BIQFw/B9wIAOC8zTMogv9XwOvswyW0SgDsr4bg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003)(13003099007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3o1TTdnYnFUU3E0VTI3aFhOZkZIL0wraTJGRHBrZkNKVjFpQ3lGenFPeklx?=
 =?utf-8?B?Vk8yZHBwZ3kxRy9JMWZsN09OWm1jWWhMMU56MVFZWGVNTkRBeDhqQWVLMmVl?=
 =?utf-8?B?Um81WGp0S3Y4cXZ6Njh2eU9pbEtuKzZwRVd6NUpDeVM2M1dUSCtvbWtoc3Qv?=
 =?utf-8?B?TFNVVngwNFpTV3FHYjFRUVY5UkYvTmp2Nmc0ZmFLdVRGYTFROFpHaC9lWmFr?=
 =?utf-8?B?d2xaV2tRRnFRT2RMLzFWN0hjZFZXNzFITVBhTkx4YkFGYXAyWWM1V0JUVnRH?=
 =?utf-8?B?YnBuWHBmeUsrUC80djUxRVIyeTFvUW1vZmNwemhzT2JFM1I5N0hWS1Z2MzlQ?=
 =?utf-8?B?RjdPNkhtOGUwYUlWNmpjeXc3d2hlRDZPd0JpaFA0MG9uVXZybEpwTmtGUTIw?=
 =?utf-8?B?ZFJqaC9RTVlYSWx5ZEYrM09hVlAyOGJHTWd0bzZDanQ2VEp6aW9qTmVScWNj?=
 =?utf-8?B?RGVNQkZzenJsLzhPWTNrRm40WlFXTW9xVVp2M3MySEFySWJPSGNpdlQ4L1Ir?=
 =?utf-8?B?a1ZIdFNJSWNGdkhkWFNyVlRDUEtuMVlvVHhybThWUGJZZmNrN2Y4YzZZN21Z?=
 =?utf-8?B?U3E5Tk9FdTZYako1d3VCOW04bndiYmtuRXZXZWhtUHVKaVFRL08xb3FoL01G?=
 =?utf-8?B?clRscVpLTWFRQ2ZGNFpUbHRBK085N3ZFRzlrRUoza3VMZTBsTUVkbUc1N3NC?=
 =?utf-8?B?eHVMZmVmdDR3aWpQdUZhRGFUMnI3a3VPZ003Wm9mbkFxdGY4NllMWVFXOVpl?=
 =?utf-8?B?Vmp2UlIvd0ZHakQ3a2w2dzRla0JxNTVoNHZyRUVud3FVcHhTbHVhOGpyc2dB?=
 =?utf-8?B?MVNMdGtvMzFnNWM0RUlxdDRhZ3dlSnVMd2hCWmVobHY3eXFINXFDdVBnYTMr?=
 =?utf-8?B?aDRLMDRkLzFQZ0h2VW5OYS80MXhLTHNTNlJGc21YdUFTRnVGajdlU200RkdY?=
 =?utf-8?B?NjdObElGR3JiWFhLdjZERHNISnQrRHBlQ1Zndmdaamx3LzdzL2N6WU1aelE5?=
 =?utf-8?B?RlFKVmtvUkY0cDh3cUhqUzkyUDFrR0hmZWQ0T0lMbmdobzVOeGpVcGF4OThF?=
 =?utf-8?B?RGZBamtTNlk5a3A0dW1SZUVGaDI0dnRsUWNhYWJ3MWZMS0RLVnhIaEtkenpz?=
 =?utf-8?B?NGZ0SnZEY1IyMlR4VEF6NW9yczlnSmNWdktTK0hsRzBTZCtaUzZlaTlHK3kr?=
 =?utf-8?B?aHBmZmRONkE0dHRpb25WeWZ5ZUhSaERNMDNPa0RrL3RSRTJIT3R5VGQ0c2Mr?=
 =?utf-8?B?eFJOb0lrdlVZcnJVYlhWRlQwWndEZlVMZHFIM3IxMG5xQWU1d0VUOXBTUy81?=
 =?utf-8?B?d0JaTy94MFl4TExIWDhBLy9uZVM5OUs1Q09EYVRrZzhJN0hCcEw1SW9VWk1T?=
 =?utf-8?B?cjF2NGxNK3BQcmRCSW96b3AxOU0wcWlwQnpsbGUyQXRlS2M3MDRNbHZvWWRS?=
 =?utf-8?B?SjZGS09BTlNJSlBQU2xGRWttMFd1cEJsM2lJNmUrc2hTak9HbFQ2VGhPdFBG?=
 =?utf-8?B?K2RzT1AxbmJqUlhBYm81bS9KMGRyNzFPbXR2QVh4M2JHQ1g5SmhROWNZTnZw?=
 =?utf-8?B?QzhpRmtVN3dQdjZyZDhSREdJamQzb0YyY05sSXNEZkVBazZ1aDVwbm5PWkh5?=
 =?utf-8?B?SnhBWEN0K3I4SEh4dHd6eFBGQ25mOTBVb1lIaHMzNmFzZzlueWpzaHYzRFNy?=
 =?utf-8?B?VHpLL1BBQTRhZlBKbmlhdllVMU9XdzJKTlV4U2gvdnN3aVVaRFd3Tm01czVC?=
 =?utf-8?B?dU10QmJub3FOM2JHQlRoSFQ1UDlmbHdsZUcyOEZnREcyNEE5Wmp1eWZONXp0?=
 =?utf-8?B?V1NUSlJBNXoybXVTZHRVUkMxMnNpYjhPbmdwd2t5T2JmOUlDbDYrTk50Q1BB?=
 =?utf-8?B?RExKbVBZVnY3MVRPaW5EY2M0OGV4TFdHU1J3VHAwN3BxVDBsUGphSFR4Y3BQ?=
 =?utf-8?B?Zk5QLzZrQTFQenQvMk9RZ0k1SEc1ZEdKM2dEKy9TeGNMS2FSTWVTWWxjRTZ2?=
 =?utf-8?B?V2c1SWlOSTN3RGtwYzRzeUN6bnVSWHF2ZWRPZWx3YzFLV01tR2ZqL2NqU1Zk?=
 =?utf-8?B?SUNXTk52cHJhbmo3TityaDE5Z2lsMy9IUk1MeEVkak56V0FnSEg4dlVOdEt2?=
 =?utf-8?B?Qy9xLzZmQ2NobG1qTVJBTVk5SFpJZTQ4T1A0QVNweWEzbTh4eXlTZUk1Z0Yy?=
 =?utf-8?B?ZG5PSFVCWUJJVG1YQ09pQzdCZkdlL3A1Wmo2Y0dsRy9WcGhQYWhrcUNxRURG?=
 =?utf-8?B?SFRaMVVYZmJoRzhXWHRsdGM1ZnZOZGEzd1h1OXpLWEFtNG43cDkzejFtbVl0?=
 =?utf-8?B?RDRJcWszSldtN3I4b3BINmZ3Q1k1akNHYXkzYXJPUHZENFllMk1ZUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 08891a2b-ea49-474f-3d32-08dee3428934
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 14:00:04.3860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0ECv9hLL+YPF+fyjHOr75AWdP/yePoo5uGIuCOeVoGviE62M0iImk7cN993koPe/AIH2sqh0pLwiwsWqMl3Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5209

On Thu Jul 16, 2026 at 11:22 AM BST, Alice Ryhl wrote:
> These macros are used like expressions, so they should must not emit a
> semicolon. This is being turned into a hard error in a future release of
> Rust.
>
> error: trailing semicolon in macro used in expression position
>   --> drivers/gpu/nova-core/firmware/fsp.rs:79:34
>    |
> 79 |                 .inspect_err(|_| dev_err!(dev, "FMC firmware missing=
 '{}' section\n", name))
>    |                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^
>    |
>    =3D warning: this was previously accepted by the compiler but is being=
 phased out; it will become a hard error in a future release!
>    =3D note: for more information, see issue #79813 <https://github.com/r=
ust-lang/rust/issues/79813>
>    =3D note: this error originates in the macro `dev_err` (in Nightly bui=
lds, run with -Z macro-backtrace for more info)
>
> Cc: stable@vger.kernel.org
> Fixes: 5c7ca6fa603f ("rust: add `dev_*` print macros.")

I suppose this can also be argued to be a fix to the user that use them in
non-statement positions (by saying that original implementation is for
statement-position only and expression-position usage is an improvement).

But either way:

Reviewed-by: Gary Guo <gary@garyguo.net>

Best,
Gary

> Link: https://github.com/rust-lang/rust/issues/79813
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/device.rs | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 645afc49a27d..1a38b3bbdfb7 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -708,9 +708,7 @@ macro_rules! impl_device_context_into_aref {
>  #[macro_export]
>  macro_rules! dev_printk {
>      ($method:ident, $dev:expr, $($f:tt)*) =3D> {
> -        {
> -            $crate::device::Device::$method($dev.as_ref(), $crate::prelu=
de::fmt!($($f)*))
> -        }
> +        $crate::device::Device::$method($dev.as_ref(), $crate::prelude::=
fmt!($($f)*))
>      }
>  }
> =20
> @@ -737,7 +735,7 @@ macro_rules! dev_printk {
>  /// ```
>  #[macro_export]
>  macro_rules! dev_emerg {
> -    ($($f:tt)*) =3D> { $crate::dev_printk!(pr_emerg, $($f)*); }
> +    ($($f:tt)*) =3D> { $crate::dev_printk!(pr_emerg, $($f)*) }
>  }
> =20
>  /// Prints an alert-level message (level 1) prefixed with device informa=
tion.
> @@ -763,7 +761,7 @@ macro_rules! dev_emerg {
>  /// ```
>  #[macro_export]
>  macro_rules! dev_alert {
> -    ($($f:tt)*) =3D> { $crate::dev_printk!(pr_alert, $($f)*); }
> +    ($($f:tt)*) =3D> { $crate::dev_printk!(pr_alert, $($f)*) }
>  }
> =20
>  /// Prints a critical-level message (level 2) prefixed with device infor=
mation.
> @@ -789,7 +787,7 @@ macro_rules! dev_alert {
>  /// ```
>  #[macro_export]
>  macro_rules! dev_crit {
> -    ($($f:tt)*) =3D> { $crate::dev_printk!(pr_crit, $($f)*); }
> +    ($($f:tt)*) =3D> { $crate::dev_printk!(pr_crit, $($f)*) }
>  }
> =20
>  /// Prints an error-level message (level 3) prefixed with device informa=
tion.
> @@ -815,7 +813,7 @@ macro_rules! dev_crit {
>  /// ```
>  #[macro_export]
>  macro_rules! dev_err {
> -    ($($f:tt)*) =3D> { $crate::dev_printk!(pr_err, $($f)*); }
> +    ($($f:tt)*) =3D> { $crate::dev_printk!(pr_err, $($f)*) }
>  }
> =20
>  /// Prints a warning-level message (level 4) prefixed with device inform=
ation.
> @@ -841,7 +839,7 @@ macro_rules! dev_err {
>  /// ```
>  #[macro_export]
>  macro_rules! dev_warn {
> -    ($($f:tt)*) =3D> { $crate::dev_printk!(pr_warn, $($f)*); }
> +    ($($f:tt)*) =3D> { $crate::dev_printk!(pr_warn, $($f)*) }
>  }
> =20
>  /// Prints a notice-level message (level 5) prefixed with device informa=
tion.
> @@ -867,7 +865,7 @@ macro_rules! dev_warn {
>  /// ```
>  #[macro_export]
>  macro_rules! dev_notice {
> -    ($($f:tt)*) =3D> { $crate::dev_printk!(pr_notice, $($f)*); }
> +    ($($f:tt)*) =3D> { $crate::dev_printk!(pr_notice, $($f)*) }
>  }
> =20
>  /// Prints an info-level message (level 6) prefixed with device informat=
ion.
> @@ -893,7 +891,7 @@ macro_rules! dev_notice {
>  /// ```
>  #[macro_export]
>  macro_rules! dev_info {
> -    ($($f:tt)*) =3D> { $crate::dev_printk!(pr_info, $($f)*); }
> +    ($($f:tt)*) =3D> { $crate::dev_printk!(pr_info, $($f)*) }
>  }
> =20
>  /// Prints a debug-level message (level 7) prefixed with device informat=
ion.
> @@ -919,5 +917,5 @@ macro_rules! dev_info {
>  /// ```
>  #[macro_export]
>  macro_rules! dev_dbg {
> -    ($($f:tt)*) =3D> { $crate::dev_printk!(pr_dbg, $($f)*); }
> +    ($($f:tt)*) =3D> { $crate::dev_printk!(pr_dbg, $($f)*) }
>  }
>
> ---
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> change-id: 20260716-device-trail-semicolon-1c02e29ea1cf
>
> Best regards,


