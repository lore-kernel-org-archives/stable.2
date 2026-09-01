Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020079.outbound.protection.outlook.com [52.101.195.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE8735A39F;
	Tue,  1 Sep 2026 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264221; cv=fail; b=rZTAqP5l6scTDJ6eQqtXu34KLSny26QtZlLoY0sTjupDcYOaOWi4rocq3hC7FvZJcGfcFFxdTINxzAiDcNeiA97QWSa3M4vCdyUvCPB2oC04OCGH7psz5es3sfJLFKxPxSvl/gQX3Eq58VXiIQdnjXqURyzqgNXoonSAaERDDGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264221; c=relaxed/simple;
	bh=o9wHjhFXACmjo/oKndTYxFkXGyQeNmd6Ad9TkHLucCU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=qSsAJx89RXyZ6temu/wGW299B4QqGyYmzCBOYct3SS+E4xMDWgsmnwB8mJvvCubxUdZzW9UTvL/4LKLUcAJ1+LxVbT381D9G3SmVlITEkCGuj5+TfrVo8/auOwiuAfGlJ+cZXW3JYoMZogQm4PqJbVE4fCATQ1UZ+XO7APR7JKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=gS7+5iEO; arc=fail smtp.client-ip=52.101.195.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="gS7+5iEO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTgbA5YStuiI+Q91Pelp51pcbKLkhr9/wry+b/fNzMyR6tmTk1AE2HKNOQ3Z7WL6ENcJL1AeL0wjloQm1RoRDxCqcjvutcDW3Py82LmLK6vXNZ8cb1ywccco0CqhsxZ69PgJ3AV8fQQoVAsqZqw+DOMpS2ykCCdGrnfL50yU9RSC97gbtoY6niz0e9DMqUfhkewJuyzaDKOhlsx+vG5k+NDWdzqJJpEbbGDg0qOQvNXCbFZNxblOXoo6y5uUDf6RL8SXQgCHkZE44sLUXN5Pwl4id893+X0IVZurVQtzg1u1Q980mRTVOABzq4ng4+kjpKQx3zx0rxSukLoDUHCYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpn0DL54X+jIfBYWSwjY60MUoANYYJmRrAJBq4tX9O0=;
 b=E2gZ3VsEOOHKtk1LNRkagf2IQeWJXKOp+NxIQbAOL8GdAy7dG5G05AJDDXX37J+Lfq6TvNkOoIlFNWqK6vS/GDOlZ1TA3Ro2LJAiy5MozVN+yZJcLR/R4IYUPy8AYyzmXdFCJUr7js4Ef3dAy1aOs5HQoEVswqQxBnNSmeLhqno3Ac6PWQgvyOCXXYsZ3sP4ZH4lDnnRKV/6W+YSAWNdaRd31SFEedZXe5l9AxEyln/EQa3t4LgPlBSq18PwUrdhUVkBABQtYbAFhqtl7yRE46IhIVDchQrbBxtxH5GJIjxLCaIBZcaR6PSvYpu6TqgGdUxCkSu7CoV9PUnmg7r85g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpn0DL54X+jIfBYWSwjY60MUoANYYJmRrAJBq4tX9O0=;
 b=gS7+5iEOuu8Q+OrbPSy3U3lM56XPeUdErCow81N4H3+L8/mFeBHsQP0QHOut/evCDciPWVnLp3PxqzPvF8CjlADqKxb0424Nxta9dpSMSaBqMEsDpiGkX4UDPUyJNTcuPkVGY1xuwT+ov9uxKo7enTXeTKs/en7zZIpSZliwAwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO2P265MB5086.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:251::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 12:03:35 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 12:03:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 13:03:34 +0100
Message-Id: <DL3YRAXKKEEI.GOGNVOO3AV02@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <fujita.tomonori@gmail.com>,
 <kuba@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <andrew@lunn.ch>, <hkallweit1@gmail.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v4] rust: net: phy: fix off-by-one bit positions in
 device status accessors
From: "Gary Guo" <gary@garyguo.net>
To: "Chunfeng Song" <springbreeze@stu.pku.edu.cn>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260901031824.1377498-1-springbreeze@stu.pku.edu.cn>
In-Reply-To: <20260901031824.1377498-1-springbreeze@stu.pku.edu.cn>
X-ClientProxiedBy: CPAP307CA0010.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:3::9)
 To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO2P265MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 827f19d6-f883-4085-d2b2-08df08210d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|366016|1800799024|376014|7416014|6133799003|56012099006|10067099003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qVB2X61t5gbZh2O0LX4C4l5FAnsHtyl5qWLCh1nqU8S47kQdjt3iI7TatzX1MGEusPSywsB+td4wJa/eNXJyIuTBZ+d6dljW90pzEoUTmZiTYsW91VSlEhlelWvjNSF5R48QNVml6Xm1CiKac9ro21Wf/xURGN6i8yvHamTjKTgHLtY0k7q1UOc3/9ifnUFgLqPGIGsxOzajcakb2TiNmrn0JI0AsgIxo66vXev9x+bSw24baObsZNeDeUDvgYnU9BzRyE4woO4yNyvhrHaa4Vd445znvJCNJC6sFmNiu/e/ivMp2QE3qr3gOlHBRKdbfQ2Wp9HUJ0Cj2RPr1SypwqqtenUn9Qm+OIoSol781s9SKqqTSh3fFsnjkAEm6YcJ030cXY4C22zQy0cDycQ2aTLucXsFX8pP8ciX2ojtEYIGYLmHdMpEvCrRTlhTx/kDToNcGOasV2D5CfhEm8VGr1WM5hHqw48N+kpxR0TY0fyz6nCfocrqL0JAPBWIWcJOBNbuFKy1fKA+KRdQL8ZOZY+QwKfvxPCd299l+zSYmCzNMS33cp5XnA3YAJlhyxIeFYwUR8B1eSvzlAt6qzNytH9SxuaYsutKWQneIT5b6+8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(376014)(7416014)(6133799003)(56012099006)(10067099003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0s4ekdRVjdhdmZEcjc0L1didDJSeFhxUllweGQxNFZMUzhIQ1h6TlkwRGdN?=
 =?utf-8?B?ckRDKytjMTB3aDI5dXVONllaQWQ1MnF4Zm9YdmVkdGxpRmtsdUJxaVgzZmRi?=
 =?utf-8?B?L1ZjYUY3cEJHaHRLR1k4ZTMyZzBGNlc0QzhTU2Y2OW5XOU5CTkYwT0ZWb2Jx?=
 =?utf-8?B?WkdJOStSV2JZbTN1MGxaTE9DcElVUFR1RmdYV2x2L0ZTak5NZ05VOFJSNUlB?=
 =?utf-8?B?Tm1qRU1kUVRReTNwSmJYVEd6US9zcjlQcnJvc0U3cS9BSzJhQ1VZN2FNWG5O?=
 =?utf-8?B?SU5rUjVEcWNSU0hHWEx0RE9TdG5mWXRRbVNYS0RRSUVCRTQrOFVPdU15Tk5O?=
 =?utf-8?B?T1dQMkdUaC9wNS9XUFF1VENWWWtFam15N2Y4ZnZxTnUyRnNOUzhWejc2RlYy?=
 =?utf-8?B?dkw4RHRFVFpQK2NyeVNYbUVyME54Zml0UWRsUGdKZS9QZGhJMzVNU3V4SStM?=
 =?utf-8?B?VWVrTzltblllQm9vZ2w5b1VpWGtsSHdXbGkrODZQWkxldGR1Q25oOG5YOGFq?=
 =?utf-8?B?WlorR1MxRjJCZW1MV08vek5LdXBlUSthaitHZE15YTJxMW5GRDAyT3JkcUtB?=
 =?utf-8?B?ME5iNmhYbytqekt3d250N0t5UWFhT2h2ck1WWDducnhjbVg2bEloenFVQ0Nk?=
 =?utf-8?B?K1loT2k5Mmd2V0dINFk5QzdOSng1L0J4T2V3dUNCTWJzcjZiZ1dTSWNycHpt?=
 =?utf-8?B?NXo1aTFvcFc4eCtBVEV5MHBEUktpOUhoQjZjM0M0YjhEVmNlcTU5UUxyQ1JQ?=
 =?utf-8?B?Vm8yMHhWaGRwc0NtVjdKUk01aTZBaDNuUDQ2MDR4OExabWxsd1k1N3UzWFlL?=
 =?utf-8?B?cDhSRFNyTktCOW83QVY5TlBkTEZCU20zdFdzV25vU3Q3YXVGYkNYZElFV3U4?=
 =?utf-8?B?Q2ZkOHNkWnNJNjJMNzlKdzUraGd3WkRoclcxa1Zoeks2ZzlDVk9JbkRHOWRv?=
 =?utf-8?B?UXMvdXJHL2JVVk1WUHBsNXIzU1puK3RjYkRTZ24wUVJzRnVXcmlJUUMwcGFW?=
 =?utf-8?B?QnBDdWloRGlRcE5nRlE1VjVZUFFDZllDRURUcmE1bWdDZytXZ3VxeVdaMGdV?=
 =?utf-8?B?TDZtbkJBR01Zc0pmU3VIODZIUmxlSTJHSW1mOCtKNU1Ec3NoQTJ0VTFIbG0y?=
 =?utf-8?B?VXpXeWIxaTlCT2E5WHJDQm82bU5BemVDb1c5MXNQLzJjUFUrYlZWY0NVRnRj?=
 =?utf-8?B?aDQ5UUlPWE5RcU40cFlUWWxlTWoybE9ZMkowUlJyaUxLMkcrbG1kRDE1a0Jw?=
 =?utf-8?B?VEMzY1EvOEpBbXpvbkJPT1lvcENzWnYvbkVXbHpWbFRWUzExSTNhUHFUbDg1?=
 =?utf-8?B?alYySHpueXVFQ0syb3F0elVyV1pkRDhNdlp4S0dYT3pnQ2Zzb2dhUjZDK0Ew?=
 =?utf-8?B?ZEtXbjFaT3dNbWs3eGpEZks5dlBzTWVIam1ndjdQRG5nUjVBWVRuSDFDSEpr?=
 =?utf-8?B?SEdHZ1FrU2c0TUlQL1ZTLzV3bmE0a2gwUXY0YXJmWGUyVEl5SXg1WkZaSzhK?=
 =?utf-8?B?ZlZPeklqSUtCMGNjVFFxbkVManhZOEFvUU5oK2N3QUFOOTJwUkI2SEl4UmVX?=
 =?utf-8?B?WlBGcFBwYzVqMm9IZWNsTTZhUmFiUUk4SXJ4bnJUVVR1UXN4THpOYlNNMm9a?=
 =?utf-8?B?NVlKWFJESmdmelZNUmpVNEtKOTdwS3JGOW1rdDNlZ2NsdmZpUzVFdm5mNFpm?=
 =?utf-8?B?RTN6RHg1bTQ0SWZ3UDdkY08zaWtreDRhRHk3Y3U5WkExU1VaMHAyNEhmSnNj?=
 =?utf-8?B?TkNCcThuaTBpaEdYUk94ODZ0NnNqUUxYYzJtcUg1aGFtd2hwUGl5ang0Q041?=
 =?utf-8?B?OU51TU1od2pmZmRuR09uKysyeVI2MU1TVno4cEdzN3E2RHl5U3RzSFV2RGZo?=
 =?utf-8?B?cHdRT09vNUxIMjNSWmlQbmdaSys1Ymd3V3V1M1NET1Z0RUNoall5OGNDWTFr?=
 =?utf-8?B?VDlYY0Zaa1lsQi9NbkNBc1pyL2JzekVRd3I2NjhSS016QmllRzRTZE1GYVAy?=
 =?utf-8?B?SVI4WnBkaEdYVjNXcExyRjRPRXpUaExjTElRbXA3dmJRdVRJemdrRnR6dktM?=
 =?utf-8?B?RSs0RTZjem9HSmpOVDY0RlZkT2Q4amtBYVd6b0ZSMW9iaFkxL1UyUktYWUVo?=
 =?utf-8?B?OVliRkJmdlJ5RjFQMnd4U2RqSDVaOW1Jd29KYmdocHQvTUpYMWNGWTBCSVIr?=
 =?utf-8?B?b3Nwd1ZuNHdTOGJXNHZ6ZWQrMlVoTlFjajkwWjNud2d6MHlXRlhJV2ZsQnJK?=
 =?utf-8?B?cEM2eGpQcGJxbEM3VDV4Q0tqc0FON2RYTk5YdE5EcWtQT3cwODBmUGhXbEpv?=
 =?utf-8?B?UFBvR1lhRmZCd3lrbWVxMmZycVY3bXZQbmhVZXlqKzh0SXp6NGtKZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 827f19d6-f883-4085-d2b2-08df08210d22
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 12:03:35.8274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFpAokcCygZgOHjHUQhEvlwUkC0NDaH9knmyXqV3m/pEqtkP9f4wCnpx9uLnXAkayEGx6H0Vf1nvbF2Z1pM/qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5086

On Tue Sep 1, 2026 at 4:18 AM BST, Chunfeng Song wrote:
> The hand-written bitfield offsets in is_link_up(), is_autoneg_enabled()
> and is_autoneg_completed() were correct when the abstraction was
> merged: at that time autoneg, link, and autoneg_complete were at bits
> 13, 14, and 15 of struct phy_device's first bitfield unit. Commit
> 2796ff1e3dca ("net: phy: add flag is_genphy_driven to struct phy_device")
> later inserted is_genphy_driven just before autoneg, shifting the three
> fields up by one, so the accessors now read:
>
>   is_link_up()           reads bit 14 =3D autoneg
>   is_autoneg_enabled()   reads bit 13 =3D is_genphy_driven
>   is_autoneg_completed() reads bit 15 =3D link
>
> The official ax88796b Rust driver uses all three accessors in its
> link-change handling, so it inherits the bug. On genphy-driven devices
> is_genphy_driven is always 1, which masks the broken
> is_autoneg_enabled() check.
>
> The ordinary bindgen accessors take &self. Calling them through
> (*phydev).link() would create a shared reference to the complete
> bindings::phy_device, which is not appropriate for an object wrapped in
> Opaque.
>
> Use the bindgen-generated raw accessors (link_raw(), autoneg_raw(),
> and autoneg_complete_raw()) instead. They retain the bit positions and
> endianness handling generated from the C layout without creating a Rust
> reference to the complete phy_device. Drop the hand-written numbers
> together with the TODO comment that marked them as a stopgap.
>
> Found by a static equivalence audit (C2RustDrv, a C-to-Rust driver
> migration tool) that compares hand-written bitfield offsets against
> the bindgen layout of struct phy_device. Verified by building the
> bindings and checking the generated accessors; no runtime testing was
> possible without PHY hardware.

Might be worth mentioning that this is change is only possible since this
April's bindgen version bump.

This is a bindgen version that we requested
https://github.com/rust-lang/rust-bindgen/issues/2674 and available since
bindgen 0.71.

This will affect backports.

>
> Fixes: 2796ff1e3dca ("net: phy: add flag is_genphy_driven to struct phy_d=
evice")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chunfeng Song <springbreeze@stu.pku.edu.cn>
> ---
> v4:
>   - Use the bindgen-generated raw accessors to avoid creating a shared
>     reference to the complete C `phy_device`, as suggested by Jakub Kicin=
ski.
>   - Update the SAFETY comments to describe pointer validity and the
>     callback-context preconditions.
>   - Add `#[inline]` to the three small forwarding methods.
>
> v3: https://lore.kernel.org/r/20260825111334.795732-1-springbreeze@stu.pk=
u.edu.cn/
>   - Use the bindgen-generated accessors instead of hard-coded bit numbers=
.
>   - Update the Fixes tag and add the net tree subject prefix.
>
> v2: https://lore.kernel.org/r/20260824111227.742645-1-springbreeze@stu.pk=
u.edu.cn/
>   - Use bindgen-generated accessors as suggested by Andrew Lunn.
>   - Explain that the offsets drifted after `is_genphy_driven` was added.
>
> v1: https://lore.kernel.org/r/20260823103644.342849-1-springbreeze@stu.pk=
u.edu.cn/
>  rust/kernel/net/phy.rs | 43 ++++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 956cda573ddb..3f1c1637f027 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -123,39 +123,42 @@ pub fn state(&self) -> DeviceState {
>      /// Gets the current link state.
>      ///
>      /// It returns true if the link is up.
> +    #[inline]
>      pub fn is_link_up(&self) -> bool {
> -        const LINK_IS_UP: u64 =3D 1;
> -        // TODO: the code to access to the bit field will be replaced wi=
th automatically
> -        // generated code by bindgen when it becomes possible.
> -        // SAFETY: The struct invariant ensures that we may access
> -        // this field without additional synchronization.
> -        let bit_field =3D unsafe { &(*self.0.get())._bitfield_1 };
> -        bit_field.get(14, 1) =3D=3D LINK_IS_UP
> +        let phydev =3D self.0.get().cast_const();
> +        // SAFETY: By the type invariant of `Device`, `phydev` points to=
 a valid
> +        // `struct phy_device`, and the caller is in a context where thi=
s access
> +        // is safe. The bindgen raw accessor does not create a Rust refe=
rence to
> +        // the C struct.
> +        unsafe { bindings::phy_device::link_raw(phydev) =3D=3D 1 }
>      }
> =20
>      /// Gets the current auto-negotiation configuration.
>      ///
>      /// It returns true if auto-negotiation is enabled.
> +    #[inline]
>      pub fn is_autoneg_enabled(&self) -> bool {
> -        // TODO: the code to access to the bit field will be replaced wi=
th automatically
> -        // generated code by bindgen when it becomes possible.
> -        // SAFETY: The struct invariant ensures that we may access
> -        // this field without additional synchronization.
> -        let bit_field =3D unsafe { &(*self.0.get())._bitfield_1 };
> -        bit_field.get(13, 1) =3D=3D u64::from(bindings::AUTONEG_ENABLE)
> +        let phydev =3D self.0.get().cast_const();
> +        // SAFETY: By the type invariant of `Device`, `phydev` points to=
 a valid
> +        // `struct phy_device`, and the caller is in a context where thi=
s access
> +        // is safe. The bindgen raw accessor does not create a Rust refe=
rence to
> +        // the C struct.
> +        unsafe {
> +            bindings::phy_device::autoneg_raw(phydev) =3D=3D bindings::A=
UTONEG_ENABLE

IMO it's little bit awkward to have the comparision be inside unsafe block.
Perhaps

    let autoneg =3D unsafe { bindings::phy_device::autoneg_raw(phydev) };
    autoneg =3D=3D bindings::AUTONEG_ENABLE

?

Best,
Gary

> +        }
>      }
> =20
>      /// Gets the current auto-negotiation state.
>      ///
>      /// It returns true if auto-negotiation is completed.
> +    #[inline]
>      pub fn is_autoneg_completed(&self) -> bool {
> -        const AUTONEG_COMPLETED: u64 =3D 1;
> -        // TODO: the code to access to the bit field will be replaced wi=
th automatically
> -        // generated code by bindgen when it becomes possible.
> -        // SAFETY: The struct invariant ensures that we may access
> -        // this field without additional synchronization.
> -        let bit_field =3D unsafe { &(*self.0.get())._bitfield_1 };
> -        bit_field.get(15, 1) =3D=3D AUTONEG_COMPLETED
> +        let phydev =3D self.0.get().cast_const();
> +        // SAFETY: By the type invariant of `Device`, `phydev` points to=
 a valid
> +        // `struct phy_device`, and the caller is in a context where thi=
s access
> +        // is safe. The bindgen raw accessor does not create a Rust refe=
rence to
> +        // the C struct.
> +        unsafe { bindings::phy_device::autoneg_complete_raw(phydev) =3D=
=3D 1 }
>      }
> =20
>      /// Sets the speed of the PHY.
>
> base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6


