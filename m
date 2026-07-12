Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013054.outbound.protection.outlook.com [40.107.162.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6302539656D
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783845974; cv=fail; b=DOw4vo7zoBzG7aIgNCkYY+ubpOZT1+DWpG4aNakV4bwsdMtfWPjS3KHrsA756GopGuImZYKkCo/DJHQkCe3QIXkvi74tlz7ndmtIyaIMUieI1A5xHW5FKYl5e4D50c2W4w7gjFtY+SmFzRXQxTpUnURFqh/xGbF5hl7SlekkaLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783845974; c=relaxed/simple;
	bh=lg4QCIBNuvFbAiK0p2gMoSN0Nm6SxDY4AqVGbrLb/SI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qIqO4kX+5DmhSM7fWBVX6d/AuckD27SngDAOfNZDZZd3CvLPFHE12SrHgsIst6doNqwwMYcgVJbIxZpgJ1D7Zz8PIBTmrqoURMZkfx7TGDDZ4GVw7ryjtSz4JhgIMbqu4SNB2kONnj5nzL0UIrvUqCgndKd/ytB/7lFK5O4bDmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=student.han.nl; spf=pass smtp.mailfrom=student.han.nl; dkim=pass (1024-bit key) header.d=student.han.nl header.i=@student.han.nl header.b=MVRC3v0y; arc=fail smtp.client-ip=40.107.162.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=student.han.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.han.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=student.han.nl header.i=@student.han.nl header.b="MVRC3v0y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJFbrgTulJlK56PlWVxpzpZCZVfBnFMgf8Np57o2w1IO2RbnF3rIlmi36SX8nBBdi1PmaqYGK5cASfWphS4LrZH5QJMJ6zT1T+TEwnPgPzMJsssEE9Xg0STr/yvFLvcQI/RyeShREqbeej0IAF/T/dujbGOoWbv6ODjvSDNUClThbD8Ljk/BlNqmPMB+SNLFu7/+fURX49fVO0Kgb83HdlJV6NcHE7JVDGAtIJPrfbZSuSBTWmilL4pVTuIjyA8wDjPfCXj0GGP7YURfzjkZAQBiRmXmu4Xli6rorbKgMcMt01go3knGWqHOlbDbrLLeFxnhk7jJCF4rr2bJx+XNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbq99AV8U63B3uGgmii2oHCBh1YmP3DGUYEAuAXefE0=;
 b=krkKpLcIs8v7Q5KADzQfBhwPNzsxudEzGUmeXzjlBnHdqvR4IJa8JPRx0N4h/v5XolGyZObvNjPMEv4dRAejzbqSvxcpKEctGZ1G7a9A2fVz6pSj4lQ5adDKmDLv+OQViTFtc0p5qN4jeBL7HnNtSC11In9mDhFUL7gUzxfoUJS3F0KDGD+PgZRPAOehwIVNB+Flp6WaMorSGml/aFI2JeI5S6/hZCBGj7hjI/OH49uMHxeHgmomfy4kFycgbSD4LnwuNladPG9N/H2lKybJwdFmETg+VdpN0+iNGJuF7XYUFW6aXRz6SbtayIdT+p+G8Atxepou8ljIpAxMBMo7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.han.nl; dmarc=pass action=none
 header.from=student.han.nl; dkim=pass header.d=student.han.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.han.nl;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbq99AV8U63B3uGgmii2oHCBh1YmP3DGUYEAuAXefE0=;
 b=MVRC3v0yIGb+DSCLPzemQVf336puSgHqGDRuUY6aTbEbX9VH6Fv6Ph/iKARU4Nv6+5/xG0ViZVtLeU0YLrkFDGPz5nxsbZlbQP1sFa6o2hiPDuBcauLqKtnwGwVwRNuQB9lW5nA/GD5eteoo7lAbDnsAizzGaOHuh+kH1tBLhUU=
Received: from MRWPR01MB12852.eurprd01.prod.exchangelabs.com
 (2603:10a6:501:84::16) by DBBPR01MB7660.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1e2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Sun, 12 Jul
 2026 08:46:08 +0000
Received: from MRWPR01MB12852.eurprd01.prod.exchangelabs.com
 ([fe80::6185:3771:1740:81ac]) by
 MRWPR01MB12852.eurprd01.prod.exchangelabs.com ([fe80::6185:3771:1740:81ac%6])
 with mapi id 15.21.0181.008; Sun, 12 Jul 2026 08:46:08 +0000
From: "Danyil Demchenko (student)" <DO.Demchenko@student.han.nl>
To: "jose.souza@intel.com" <jose.souza@intel.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: [REGRESSION][BISECTED] drm/i915: GPU HANGs on v6.12.20+
Thread-Topic: [REGRESSION][BISECTED] drm/i915: GPU HANGs on v6.12.20+
Thread-Index: AQHdEdrEXRa6GO8CjkuHu8r6loJB9g==
Date: Sun, 12 Jul 2026 08:46:08 +0000
Message-ID:
 <MRWPR01MB12852A981954ABE86057B04AEBBFB2@MRWPR01MB12852.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=student.han.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR01MB12852:EE_|DBBPR01MB7660:EE_
x-ms-office365-filtering-correlation-id: 6788c148-bace-4417-a596-08dedff204cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|786006|56012099006|11063799006|18002099003|3023799007|38070700021;
x-microsoft-antispam-message-info:
 rSgQ2BE284FGsKyx5vTjEUmgmQBOvh2FRm652MEwMLfAOh8smha2TH+f8zwsi90LvA+raKxu2oSwx4nKA3XnUVWMY0ReYdM4C4PgffOF6yQL9fN1YXe2cdac2l8gSOGN+z7sHO3tImuaGZyeAcnTIhzf5jo1OlTY83DWnL4dxdBzgNqjFUtjBbiZUOUd6ILBOBwRa2xorRJmoLl0TFEvk7dwKLPB6fRd32xueYQyD7zu2TlOuooQa8F8bT+3TutPevftEmDW296DkamBsN2a5O+SbFRXFj/lmbmlIDr6w/t8A9WW7dbS4/xneJnNnW7y4Vp1Q7+de7NosufJI1BrEIUjBbzjHbR8xu1P7P0VLT1q+at3WnCkmFQQKsSthn5n7OeuEf91l6wWeCMQHha+ElQdIO83uBU1I0PUnlnLOB+lDNuzi1Vh8IosvpcnJpba2piSxvzIRDmuB3leMCEIiadEXVgl/nrdIA7o8CtLmxxSuhXVFjmwnTPOuypHMAylzlIFJDxQdA6xmL9f+3ZHcJ60/6LJ/b3y5FlL3dkeLqb9vCZjahmq7k7C0jJdoZ2ZGow000ZEG2y7km24X9tlsdMLaQQwYR20XVFiefHtd4gNF1EKUIBBetY+LEsxcc43Y/l8edq7aEspbQMAPAYnDgA1fvKp8bWMNCat1QQGnIkALrNDndq6MK5o0UMwW1Y62A7uwle0ga9pN4b9aZAO6wXhPaLOJRVxq+mB9oPuYD0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR01MB12852.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(786006)(56012099006)(11063799006)(18002099003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?M2Ltazw1nWvc+SZTtrfG55yOrXRD2tZ6SmxKzZ/95l7hPrc85u7+JtBAi0?=
 =?iso-8859-1?Q?ZjdsZMqMUT0C6qozoTdxZqUVQrhMarGxB1ur9H5DAbyN0Y5uarjbzK+dHa?=
 =?iso-8859-1?Q?pYhFClEm7NSuGcm0XFRddr2KMSbgN6rPXI6maA5E55gK6Owrf+B1i/VB/N?=
 =?iso-8859-1?Q?SU4ykqqVc0LSpQ06yIyXfcH+/Wn+lMZEoeduS1KsUDvILRHh2acXYN2/Nz?=
 =?iso-8859-1?Q?0HJDZniOwEB+cRVozZEVDwDJSKl+j0hSjqzTcBzH7nEZ2JMf2aQX760oRL?=
 =?iso-8859-1?Q?5WYDMEE4qJVnoKQP7+eERGWef85kTCW3Q51iU4LRbQH8ekfrjvZjoc7sYF?=
 =?iso-8859-1?Q?T1yu0GmZbkxtae2xhyCOw2fxXW5jeiwnMm+qGZVCqaJhnEyZ8WxtzxZDUs?=
 =?iso-8859-1?Q?hw/iJ2nkP1iujzzF53LrwrO2q7xQwIAfV2Vo17frzBB5pdYJgivI0DYTHB?=
 =?iso-8859-1?Q?PHPatu5THMlIIaY8WHXo4W/MxqCOXiRbhO5NBvyRaPP9zXjJnFaSOBS4H1?=
 =?iso-8859-1?Q?Yr5WXpkHjGa2R+ngVtrsrzkWlUMrpENnuSpPSLcbDWMlYs7nxy85c3ZGF6?=
 =?iso-8859-1?Q?siQU5HE7zAF8LKvrJv4rU3inhawcPGWrrU9Nhw665l/A/7dwUUX+F3T6h7?=
 =?iso-8859-1?Q?V9Q414f07en0/DcMRykgOtZBpNHGqCcEkuaCo0qaWxAVddn9e9le3be84Y?=
 =?iso-8859-1?Q?7QBObS++OXu8SZr3gO+IWVkZwmJ5W+CH6L/1LghYZv8dNtk/pXqoNnL8Vo?=
 =?iso-8859-1?Q?G56wu/2R626eWDkXPHHIuvhxoQZO558y0hAaAeGkDiaaWxdubFE8sn4Dpm?=
 =?iso-8859-1?Q?2/Ll1GWGjZ+nShr67jQ2KbUhn4c9kXYpiapoEzoom+osMcHLGdjRsnhgbx?=
 =?iso-8859-1?Q?RV29MxWTxHl8c8rs72zB0BFYD3CP9m7xjrPdakl6Dcf5ZWMEhPXY/MWTED?=
 =?iso-8859-1?Q?ASDmPvLLfM11fU5xNzOBZsURo0aUWm6831xh6xfEBQokzklAChX+bgn3Z5?=
 =?iso-8859-1?Q?we32tr3ArYs9VsgW3ebH0pi7NdT/1lElyBFRT4RwzuTY1dPgbagiJPkkWm?=
 =?iso-8859-1?Q?rQhg2uNWEvQ9zAGqThoymQsCh8iiIl0E00sNxE4rTT92lekU8KCs+q0Byk?=
 =?iso-8859-1?Q?UpOuKRaF4KcxegJgJqmK3OqmT3mzqwJu2h/FC3UgfmsGgkoUcSfF1dZcz+?=
 =?iso-8859-1?Q?/ZrMltQj/UHUq32kqFfyj9RefV1pdq7rPIm6CxBBIOumlw8aJkC8Ig6wD5?=
 =?iso-8859-1?Q?3ofJubmcq3BZYu6Swtf87j7f9rtTgaDAK4Y4+z5kfqeJ02EJtfjBGsibYz?=
 =?iso-8859-1?Q?ES4AolEUo/ahZVJHa/KC56suzaKl4g5NAmcMoa6znLQON7p+/0V58bkZHk?=
 =?iso-8859-1?Q?3TozF8y8usl8PRNtK7wNaxTdTDulm8h6NbUdhNiwGiGo6be3Ot+KhIn6Vj?=
 =?iso-8859-1?Q?x1/UowaVlH8hi3elHV6swqlDJUYaPDhFjjZEnkfmA8+Wal/AW22nlG7JQ8?=
 =?iso-8859-1?Q?/WQJo+MC4Li8QNs8mSAwxZU30PcMAVACtfXmTyqyPuPj6zh4v+AZa7rlf5?=
 =?iso-8859-1?Q?l2cEqQBDT0NtO6F3F/jZV8bJcebyQ37XR0ml09RZpYXYAzbGyVWWfclPPl?=
 =?iso-8859-1?Q?ciapvwwF/U4f3rGGZ92c/cge6BGZYoRf+rwE59Y8h42t2e+ujsCb06NVEt?=
 =?iso-8859-1?Q?KISj5Ua7K+iRw7IgAey4aSzT7gJhqiLsWDxSIQw0B4w3GeRfe0/QtFpOLB?=
 =?iso-8859-1?Q?EBdIAA/B+6RbszedqCNrC9036yDKAo8cpmfVnOuhwyDENoeRj/C4KBQ4e2?=
 =?iso-8859-1?Q?x+C2vt9Y6A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: student.han.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR01MB12852.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6788c148-bace-4417-a596-08dedff204cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2026 08:46:08.8318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d73e7b7-b3e1-4d00-b303-056140b2a3b4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XAhXiokEqtf+JNxYsMm4zofaH2ThhROvSuwLMmrUcBsyhwNl8T2W6nr9/IAx8YUfEgp9LE2J0o9oCEMDfq7GO6Hf+oBZUEXODssgSkettA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR01MB7660

TLDR: on kernels v6.12.x i915_gem_mmap_gtt_version() should return 4=0A=
=0A=
Hi,=0A=
=0A=
This patch shipped with v6.12.20 introduces GPU HANGs on Intel UHD Graphics=
 620 =0A=
(8gen igpu)=0A=
=0A=
index 21274aa9bdddc1..c3dabb85796052 100644=0A=
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c=0A=
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c=0A=
@@ -164,6 +164,9 @@ static unsigned int tile_row_pages(const struct drm_i91=
5_gem=0A=
_object *obj)=0A=
  * 4 - Support multiple fault handlers per object depending on object's=0A=
  *     backing storage (a.k.a. MMAP_OFFSET).=0A=
  *=0A=
+ * 5 - Support multiple partial mmaps(mmap part of BO + unmap a offset, mu=
ltipl=0A=
e=0A=
+ *     times with different size and offset).=0A=
+ *=0A=
  * Restrictions:=0A=
  *=0A=
  *  * snoopable objects cannot be accessed via the GTT. It can cause machi=
ne=0A=
@@ -191,7 +194,7 @@ static unsigned int tile_row_pages(const struct drm_i91=
5_gem=0A=
_object *obj)=0A=
  */=0A=
 int i915_gem_mmap_gtt_version(void)=0A=
 {=0A=
-   return 4;=0A=
+   return 5;=0A=
 }=0A=
=0A=
kernel: i915 0000:00:02.0: [drm] Resetting rcs0 for preemption time out=0A=
kernel: i915 0000:00:02.0: [drm] aces[2257] context reset due to GPU hang=
=0A=
kernel: i915 0000:00:02.0: [drm] GPU HANG: ecode 9:1:e757fefe, in aces [225=
7]=0A=
kernel: i915 0000:00:02.0: [drm] Resetting rcs0 for preemption time out=0A=
kernel: i915 0000:00:02.0: [drm] aces[2257] context reset due to GPU hang=
=0A=
kernel: i915 0000:00:02.0: [drm] GPU HANG: ecode 9:1:e757fefe, in aces [225=
7]=0A=
kernel: BUG: unable to handle page fault for address: 0000000078280000=0A=
kernel: #PF: supervisor read access in kernel mode=0A=
kernel: #PF: error_code(0x0000) - not-present page=0A=
kernel: PGD 1462e9067 P4D 1462e9067 PUD 0 =0A=
kernel: Oops: Oops: 0000 [#1] PREEMPT SMP=0A=
=0A=
GPU hangs if i915_gem_mmap_gtt_version() returns 5. If set to return 4(as i=
t was=0A=
 in v6.12.19) no HANG occur. This happens on v6.12.20+ kernels ONLY, v6.6.x=
, v6.=0A=
18.x, v7.1.3 and v6.12.19 are unaffected.=0A=
=0A=
The actual commit introducing this is bfef148f3680e6b9d28e7fca46d9520f80c5e=
50e, =0A=
but it doesn't seem to affect any other kernel tree.=0A=
=0A=
#regzbot introduced: v6.12.19..v6.12.20=
