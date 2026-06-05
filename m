Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34616308F38
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667215; cv=fail; b=Qvab+iNeN/UNy5ViVcEQuzdtvC/B02VmwV0SQfhoY/XynozkvYtOmqFwtIS26WucD/6TGHX3xLN5G0TUtlCy1qJAL59UzkARNonekh36P+z/5bPoPSMl7PlgqUGR0xFi36kR9bDF/71SblJIwHf5WeOQFAPyN5bIzuXHyA1JuBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667215; c=relaxed/simple;
	bh=pCj1cTdexbeZQdcZ3o5fbd4eDYnxNH223c5hEKZqTrc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VQbOPGG7m69uFbaZ7yBKzVbFa5sTGH0fsWT1Qkodg0x83v+Tgz2naaxczhEogEE1RQqF7kkukQYkLQVjSWGBc1Q7Fi6re35kKZfD4K3EfEqYSakl1XTUnoNz4OvOTBEGyoZsKtOfH/gGtSg8LpzATClkLsZwHogHkK80N5uQb9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BoZKNEGa; arc=fail smtp.client-ip=52.101.46.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BoZKNEGa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgA86q80sdLuDGI3zqlXS+4EUph3OSqzFp/63bGmGUj7SQFD7SvOpuQJSPLtdEetg26NAY/jpU3TMMM1a7FDB3G2xXqyl5hSUrQLw/bKYQR1aIgPGlqjE3UDwoj/khXN/I8nXNLfpAbjaRSxeGfZAw2aMHY8VjONoYQRPJY5eR0f31yzoJsbTUaqTQKG2Jc5t27+RWftskW5i6tQR2V4ygcgFybG+UoEgx+dVAx68AO0Ws2aryQEIMweM/oChEQuC5WuhE0/sG+dLLwthCuJ+e3Ee8kI4G0N4d/p69K85WDNeSkfZVeASAjVmf8hRKxdQpF1WiIhpDa2HzsLKa3ivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ed0C0o1ExJ48/k7Upiwc6yqRvvBrCGcenpS6xhkeMTQ=;
 b=BpYLNdec+MNQTIOqv08f8qwmYfTsXDqfOY9Fu9h3G9KLQOBCfS9csl5obnextwgQhl8LrP1NeQgbO35TosN1lls+U3tcD3I58MQ1VYdG53pjmSfk75flqOSqLpuEcDPpH5aLURJ/idfMvLELcmQ6WG9QYOjm76y2cLZ40GDR+jyr40XrsL1Qs8YosIGv1bnwYhF1ivTMSXN4bybKZx+ugKN544k8l+N8SuW4Zp5D0RptCBXfp9W3dJhH/HebLYV5WgJSgIZjmTiLRdIRBckAVEjFX0EzMGsPNPvoIjKr0Ef0xvQklQJr2YbFD5iOP3eyoR+LBE3fY5uHSEQpdMfWNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed0C0o1ExJ48/k7Upiwc6yqRvvBrCGcenpS6xhkeMTQ=;
 b=BoZKNEGa7PCK7VwOREOkXWiotIwLsqKnwNR8/A/hO48LEZkb2OhIkyoqB7mlJfi4SE22a4rsnXAuXoFP9nEto/oSPoz75IZZr5ww8yTm7t6TOXTeV3Jz/cZzCWbA8Wr12W9Ve4KNRMd0CHNSLEfVhG2Fb1egkns9DHpUvNVI08I=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by DS0PR12MB999103.namprd12.prod.outlook.com (2603:10b6:8:2fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Fri, 5 Jun 2026
 13:46:48 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%7]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 13:46:48 +0000
From: "Francis, David" <David.Francis@amd.com>
To: Simona Vetter <simona.vetter@ffwll.ch>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>
CC: DRI Development <dri-devel@lists.freedesktop.org>, "DARKNAVY
 (@DarkNavyOrg)" <vr@darknavy.com>,
	"syzbot+d7c9eed171647e421013@syzkaller.appspotmail.com"
	<syzbot+d7c9eed171647e421013@syzkaller.appspotmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Edward Adam Davis
	<eadavis@qq.com>, Dave Airlie <airlied@redhat.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Puttimet
 Thammasaeng <pwn8official@gmail.com>, "Koenig, Christian"
	<Christian.Koenig@amd.com>, Zhenghang Xiao <kipreyyy@gmail.com>
Subject: Re: [PATCH] drm/gem: Try to fix change_handle ioctl, attempt 4
Thread-Topic: [PATCH] drm/gem: Try to fix change_handle ioctl, attempt 4
Thread-Index: AQHc9FcRkUUCbPtMbUuCWZFIHWxW7LYuzHiAgAAMnICAAKSzAIAAfKbr
Date: Fri, 5 Jun 2026 13:46:48 +0000
Message-ID:
 <SA1PR12MB8144E4605F341477BD6D6E89EF112@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260604191916.1713387-1-simona.vetter@ffwll.ch>
 <20260604194437.1725314-1-simona.vetter@ffwll.ch>
 <ab2c8c81-8ab6-4a93-93c9-31445454421a@linux.intel.com>
 <aiJqYgnTekPoXK_q@phenom.ffwll.local>
In-Reply-To: <aiJqYgnTekPoXK_q@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-05T13:46:47.503Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|DS0PR12MB999103:EE_
x-ms-office365-filtering-correlation-id: 88aa5f6b-2e91-4600-6f87-08dec308e3cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|18002099003|3023799007|6133799003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 98B3duTusw68YzRdvObFglCsi3FCwxt3A9AN+7p7UIvws1w3aVpIZaEiU2OIZIEnBCksI8DJD4jvGZoyx/f29NcITRJzxFM+ghtJv8cUMCKO6o5K8dwpwQ8mEQAdvEJsP8MW0UvHC4AAdYNKJNv3hm+kPoAo6LRmA8qb/YkzGeAhL4KTm8ouUSk/Sv5KvJANZ7o/jzFbe2rHoTjdcGhEW6Qa0OOrWQfcmRzjmDDS3H6mEZgj74sZOq3Lkyka9Ro6eJDTLroVfmxFYhhBkbMVxszBA2+pv/qVMvQMP6orGB1c8tDmGwoKDUXoASEp19n3viTPK1m++R/P2xiYvp6KPhHARFXKQucofF3J2rpSTJ2egTDQfClxg7aBW23hijk0KT/xKBJ6z421dZAmWTqJggUZ0Ch+nDNss8Ty6FR0NG1FcM4+mN2rRf3i49659e2fXZLi/e2SMsB1yVbZMhN0IYjTFDBOToFbPlwzy+EqLrT6hAO/ZURirzWEBf0EGTS+pDBTUJfrusTbNYKsbJX5B3IWPtmum0J9rnd0ds72r0/fWqq2EESVApY6QLssNLz6kt+LprZttks6azM4acxsC1JtDnlRiCWEW80aghfK/xuG57EjFiRrhji++cnEL0vLv46psOQ94ymAqAiGzhJFGyyjr76nLPOX1iEzBBeaUiN4LeEnaTtjJe3/NdOxu6ZC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(18002099003)(3023799007)(6133799003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Wx0JQhrgeoVIMnSEFPVLRKGe26RN2OMqpVRZ2YA/DKpvDvMKINienrPIiIi2?=
 =?us-ascii?Q?yqVQxj1N5mjp96s9Bd9hNuHjFOnvWlNNbCVdQqSyTdF24k+vNm+ohzPb8ePw?=
 =?us-ascii?Q?0lgDt8oe5dxuy/o+fz0dQKR2+sA2bKeQ+ZrGuomPg+7OkhQFrVEaWVNenlrO?=
 =?us-ascii?Q?Fot/rz7yeGKP5ooYN3Sr96sxLbmF09EwnKc/sKMaD+PdRbLvmvgoyvTwGlSo?=
 =?us-ascii?Q?Dpy7VN4I8eTcS/V+TIK5GNal/YuCr2Bfj+XbYjSyhYMEv3o/57TfbwCnZLnY?=
 =?us-ascii?Q?zB80jK55m1ltqHkxxWfmH1eDKxVHchDbk585YOGnAIBiil5F6K6z6+vatZ63?=
 =?us-ascii?Q?E6VxdqO0neI4TDPsZBvR95ZJG6QEQwI9nqfnxvfIOy7TFVkjK62C49kx+lXr?=
 =?us-ascii?Q?lfmDj/bvClnj6BfaFMv0fWgJxO1ol+zp1AbTT8mTInNk7nsKqWhW+/yId8+O?=
 =?us-ascii?Q?HLCiqQXzJnPoLpU9A9hGx86h6GfwbSpBY42rLWL0+Ei+f8YibDuLD3ghKEk1?=
 =?us-ascii?Q?Ji7rjowTWFcgm8m/3MA1m1v/EfoqMXDtQgu9UR+ar7hPX6UG9aLhZ6fTmGNe?=
 =?us-ascii?Q?GFFNyLjLAp+2IMNlSK8LOY2b19jezuK3vPN/zpJrAQ4WJzDCNfbTHAAt7mLJ?=
 =?us-ascii?Q?IiRU7vnbwijmEfEVG3g7RD9uwQdV3VthWjmTyO45x0oJdJCPFsKseMeBxX9U?=
 =?us-ascii?Q?veLnK9UDKUoxLHES6EGqNOjuSguuupkpVFAVQ1uEsBrAogPhT19lQyaoDRAA?=
 =?us-ascii?Q?flkoz9S9VgVATLiXhIr68A15SiQ1TkUs8gl1va+ULXgQuaULtjUbkBRR1xQk?=
 =?us-ascii?Q?kcmZSds6zNdQZ6PUi2ggFHyGh5yxT0HVDpssl+48KwzkiWVx/VoXg/biv25L?=
 =?us-ascii?Q?J3mK1hgwiDLHpCzjhsP0i+S1Q4gM8LiXiblE5eBovnRRv0Y6d2eM+a5pJ1U/?=
 =?us-ascii?Q?o3+7k8NzvebPeHYRzwqGeHVfPpQx9/EZKUtp5L3mnUog9CgEDd4d1hlk4fG9?=
 =?us-ascii?Q?793nOmmkWzQPGBE6KfKKLMBkguyJlvAwQ0jI+xWaT4QroztdkiYMXTJUajOX?=
 =?us-ascii?Q?lYugBRXtE/m+SNpuxWluyL24wa/qdcT5GXt4Y+PjScNRJVZmAjJcBSn6cGdt?=
 =?us-ascii?Q?baxVbCMAcZ0wxwRWmEBanF9xh5rx3pBu9olCVLMbBGJSKm1uaii6vpwAKdQ+?=
 =?us-ascii?Q?0+VYwx2qh6qnODT95Xin/GWA5u9wSk8Qo6/qexy3LzZFDoqAGqxPYfllQUXF?=
 =?us-ascii?Q?DCgt0DQA4g7xh+VCOTmaLyaJD/fo59j0XDbU5nnTjfYzBTcoZ8Cg5bvEtxp8?=
 =?us-ascii?Q?4/nnYgC7JaSC0Z0ek5JhiFauHo02rWduxPWRpfj/7OgI6hvswGWrpWMFUxwb?=
 =?us-ascii?Q?tZvtpPqcJhIGhiITObygSP6VwotmfidabFp91qYnntKTgBZTM9DXTc62Ib9e?=
 =?us-ascii?Q?Cyp4xvGOPVqpbIAajOyeECj0BdcOXkm26J7m7IYa+jgFR4GEh8ZiTkWnJ3GE?=
 =?us-ascii?Q?l5zNEhE6F3jeAWvDu423D++iOAD59CPiMtEVSoCuEs9O4JfOVm+Q3IlUXRF3?=
 =?us-ascii?Q?Bv7e/W0jZzKttKdvmgjFAPqVZZlLAxJDwD2UuT1Q2KDtmHPEmdMNfUesct5v?=
 =?us-ascii?Q?fGkUD6azwnxT4AciUX68HEZrRHr2Bh2It4ly6eOGvbMhgsvG4wE3fOiUhTTD?=
 =?us-ascii?Q?YWA9TrfR9ttlGYli2bJMXLXuxSJR+btvWlkQbRGw4lZ7l1L/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88aa5f6b-2e91-4600-6f87-08dec308e3cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 13:46:48.1856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UhbOFFP3dYk/2+zqE1WmKG8PuqBLbHjRjHntsd/VgFjaCvVbMbKSlo4fbXsyodjT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999103

Simona's patch is

Reviewed-by: David Francis <David.Francis@amd.com>

Looks like the both-dances proposal that was raised before

Although seconded that I'd need an IGT test to be confident at this point

David

________________________________________
From: Simona Vetter <simona.vetter@ffwll.ch>
Sent: Friday, June 5, 2026 2:19 AM
To: Maarten Lankhorst
Cc: Simona Vetter; DRI Development; DARKNAVY (@DarkNavyOrg); syzbot+d7c9eed=
171647e421013@syzkaller.appspotmail.com; stable@vger.kernel.org; Edward Ada=
m Davis; Dave Airlie; Maxime Ripard; Thomas Zimmermann; Francis, David; Put=
timet Thammasaeng; Koenig, Christian; Zhenghang Xiao
Subject: Re: [PATCH] drm/gem: Try to fix change_handle ioctl, attempt 4

On Thu, Jun 04, 2026 at 10:29:45PM +0200, Maarten Lankhorst wrote:
> Hey,
>
> On 6/4/26 21:44, Simona Vetter wrote:
> > On-list because the cat is out of the bag and we're clearly not good
> > enough to figure this out in private. The story thus far:
> >
> > 5e28b7b94408 ("drm: Set old handle to NULL before prime swap in
> > change_handle") tried to fix a race condition between the gem_close and
> > gem_change_handle ioctls, but got a few things wrong:
> >
> > - There's a confusion with the local variable handle, which is actually
> >   the new handle, and so the two-stage trick was actually applied to th=
e
> >   wrong idr slot. 7164d78559b0 ("drm/gem: fix race between
> >   change_handle and handle_delete") tried to fix that by adding yet
> >   another code block, but forgot to add the error handling. Which meant
> >   we now have two paths, both kinda wrong.
> >
> > - dc366607c41c ("drm: Replace old pointer to new idr") tried to apply
> >   another fix, but inconsistently, again because of the handle confusio=
n
> >   - this would be the right fix (kinda, somewhat, it's a mess) if we'd
> >   do the two-stage approach for the new handle. Except that wasn't the
> >   intent of the original fix.
> >
> > We also didn't have an igt merged for the original ioctl, which is a bi=
g
> > no-go. This was attempted to address off-list in the original bugfix,
> > and amd QA people claimed the bug was fixed now. Very clearly that's no=
t
> > the case. Here's my attempt to sort this out:
> >
> > - Rename the local variable to new_handle, the old aliasing with
> >   args->handle is just too dangerously confusing.
> >
> > - Merge the gem obj lookup with the two-stage idr_replace so that we
> >   avoid getting ourselves confused there.
> >
> > - This means we don't have a surplus temporary reference anymore, only
> >   an inherited from the idr. A concurrent gem_close on the new_handle
> >   could steal that. Fix that with the same two-stage approach
> >   create_tail uses. This is a bit overkill as documented in the comment=
,
> >   but I also don't trust my ability to understand this all correctly, s=
o
> >   go with the established pattern we have from other ioctls instead for
> >   maximum paranoia.
> >
> > - Adjust error paths. I've tried to make the error and success paths
> >   common, because they are identical except for which handle is removed
> >   and on which we call idr_replace to (re)install the object again. But
> >   that made things messier to read, so I've left it at the more verbose
> >   version, which unfortunately hides the symmetry in the entire code
> >   flow a bit.
> >
> > - While at it, also replace the 7 space indent with 1 tab.
> >
> > And finally, because I flat out don't trust my abilities here at all
> > anymore:
> >
> > - Disable the ioctl until we have the igt situation and everything else
> >   sorted out on-list and with full consensus.
> >
>
> Can you push the revert first, and then worry about fixing change_handle
> parts of the ioctl properly later, so that part can be merged ASAP?

I've intentionally combined them, but I've only discussed the reasons with
Dave in private chat.

In the original security report discussions off-list almost two months ago
I've both suggested that we do the full two-stage removal&install, because
that's the well-tested pattern. AMD folks convinced me that being more
clever is ok, but they got it wrong.

I've also suggested that we just outright disable the ioctl since it's so
new, and sort this all out on-list, least because the igt didn't land yet.
The igt has still not yet landed.

Furthermore the igt or AMD's testing seems busted - because of the handle
confusion (which I didn't spot, because I've assumed that the code was
tested) the new code actually installed NULL into the new_handle slot,
which should have broken everything. It also resulted in an obvious leak,
which syzcaller spotted and which one of the referenced patches fixes.

Which means this is an examplary case of how not to do a new ioctl, plus
collective embarrassment of how to not fix a security bug. I've figured we
need one patch which both a) disables this mess and b) puts down the draft
of what I think it actually should look like.

But really, no re-enabling of any of this until we have an igt that is a)
actually merged and b) actually tests something. Or maybe the issue was
with AMD's testing infra, I haven't looked at the igt.

I did tell Dave that he can split it, if he wants to, but for backporting
it shouldn't cause issues since all the 3 previous attempts at sorting
this out have also been cc: stable. So should all apply without issues.

Cheers, Sima

> ---
> > v2:
> >
> > Sashiko noticed that I didn't handle the error path for idr_replace
> > correctly, it must be checked with IS_ERR_OR_NULL like in
> > gem_handle_delete. So yeah, definitely should just the existing paths
> > 1:1 because this is endless amounts of tricky.
> >
> > Also add the Fixes: line for the original ioctl, I forgot that too.
> >
> > Reported-by: DARKNAVY (@DarkNavyOrg) <vr@darknavy.com>
> > Signed-off-by: Simona Vetter <simona.vetter@ffwll.ch>
> > Fixes: dc366607c41c ("drm: Replace old pointer to new idr")
> > Cc: syzbot+d7c9eed171647e421013@syzkaller.appspotmail.com
> > Cc: stable@vger.kernel.org
> > Cc: Edward Adam Davis <eadavis@qq.com>
> > Cc: Dave Airlie <airlied@redhat.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Fixes: 5e28b7b94408 ("drm: Set old handle to NULL before prime swap in =
change_handle")
> > Cc: David Francis <David.Francis@amd.com>
> > Cc: Puttimet Thammasaeng <pwn8official@gmail.com>
> > Cc: Christian Koenig <Christian.Koenig@amd.com>
> > Fixes: 7164d78559b0 ("drm/gem: fix race between change_handle and handl=
e_delete")
> > Cc: Zhenghang Xiao <kipreyyy@gmail.com>
> > Fixes: 5e28b7b94408 ("drm: Set old handle to NULL before prime swap in =
change_handle")
> > ---
> >  drivers/gpu/drm/drm_gem.c   | 62 +++++++++++++------------------------
> >  drivers/gpu/drm/drm_ioctl.c |  2 +-
> >  2 files changed, 23 insertions(+), 41 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > index e12cdf91f4dc..f49f1724eda5 100644
> > --- a/drivers/gpu/drm/drm_gem.c
> > +++ b/drivers/gpu/drm/drm_gem.c
> > @@ -1019,8 +1019,8 @@ int drm_gem_change_handle_ioctl(struct drm_device=
 *dev, void *data,
> >                             struct drm_file *file_priv)
> >  {
> >     struct drm_gem_change_handle *args =3D data;
> > -   struct drm_gem_object *obj, *idrobj;
> > -   int handle, ret;
> > +   struct drm_gem_object *obj;
> > +   int new_handle, ret;
> >
> >     if (!drm_core_check_feature(dev, DRIVER_GEM))
> >             return -EOPNOTSUPP;
> > @@ -1028,52 +1028,36 @@ int drm_gem_change_handle_ioctl(struct drm_devi=
ce *dev, void *data,
> >     /* idr_alloc() limitation. */
> >     if (args->new_handle > INT_MAX)
> >             return -EINVAL;
> > -   handle =3D args->new_handle;
> > -
> > -   obj =3D drm_gem_object_lookup(file_priv, args->handle);
> > -   if (!obj)
> > -           return -ENOENT;
> > +   new_handle =3D args->new_handle;
> >
> > -   if (args->handle =3D=3D handle) {
> > -           ret =3D 0;
> > -           goto out;
> > -   }
> > +   if (args->handle =3D=3D new_handle)
> > +           return 0;
> >
> >     mutex_lock(&file_priv->prime.lock);
> > -
> >     spin_lock(&file_priv->table_lock);
> > -
> > -       /* When create_tail allocs an obj idr, it needs to first alloc =
as NULL,
> > -   * then later replace with the correct object. This is not necessary
> > -   * here, because the only operations that could race are drm_prime
> > -   * bookkeeping, and we hold the prime lock.
> > -   */
> > -   ret =3D idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,
> > +   ret =3D idr_alloc(&file_priv->object_idr, NULL, new_handle, new_han=
dle + 1,
> >                     GFP_NOWAIT);
> >
> > -       if (ret < 0) {
> > -          spin_unlock(&file_priv->table_lock);
> > -          goto out_unlock;
> > -       }
> > -
> > -       idrobj =3D idr_replace(&file_priv->object_idr, NULL, handle);
> > -       if (idrobj !=3D obj) {
> > -          idr_replace(&file_priv->object_idr, idrobj, handle);
> > -          idr_remove(&file_priv->object_idr, args->new_handle);
> > -          spin_unlock(&file_priv->table_lock);
> > -          ret =3D -ENOENT;
> > -          goto out_unlock;
> > -       }
> > -
> > -   idr_replace(&file_priv->object_idr, NULL, args->handle);
> > +   if (ret < 0) {
> > +           spin_unlock(&file_priv->table_lock);
> > +           goto out_unlock;
> > +   }
> > +
> > +   obj =3D idr_replace(&file_priv->object_idr, NULL, args->handle);
> > +   if (IS_ERR_OR_NULL(obj)) {
> > +           idr_remove(&file_priv->object_idr, new_handle);
> > +           spin_unlock(&file_priv->table_lock);
> > +           ret =3D -ENOENT;
> > +           goto out_unlock;
> > +   }
> >     spin_unlock(&file_priv->table_lock);
> >
> >     if (obj->dma_buf) {
> >             ret =3D drm_prime_add_buf_handle(&file_priv->prime, obj->dm=
a_buf,
> > -                                          handle);
> > +                                          new_handle);
> >             if (ret < 0) {
> >                     spin_lock(&file_priv->table_lock);
> > -                   idr_remove(&file_priv->object_idr, handle);
> > +                   idr_remove(&file_priv->object_idr, new_handle);
> >                     idr_replace(&file_priv->object_idr, obj, args->hand=
le);
> >                     spin_unlock(&file_priv->table_lock);
> >                     goto out_unlock;
> > @@ -1086,14 +1070,12 @@ int drm_gem_change_handle_ioctl(struct drm_devi=
ce *dev, void *data,
> >
> >     spin_lock(&file_priv->table_lock);
> >     idr_remove(&file_priv->object_idr, args->handle);
> > -   idrobj =3D idr_replace(&file_priv->object_idr, obj, handle);
> > +   obj =3D idr_replace(&file_priv->object_idr, obj, new_handle);
> >     spin_unlock(&file_priv->table_lock);
> > -   WARN_ON(idrobj !=3D NULL);
> > +   WARN_ON(obj !=3D NULL);
> >
> >  out_unlock:
> >     mutex_unlock(&file_priv->prime.lock);
> > -out:
> > -   drm_gem_object_put(obj);
> >
> >     return ret;
> >  }
> > diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> > index ff193155129e..937fc1e2c017 100644
> > --- a/drivers/gpu/drm/drm_ioctl.c
> > +++ b/drivers/gpu/drm/drm_ioctl.c
> > @@ -660,7 +660,7 @@ static const struct drm_ioctl_desc drm_ioctls[] =3D=
 {
> >     DRM_IOCTL_DEF(DRM_IOCTL_GEM_CLOSE, drm_gem_close_ioctl, DRM_RENDER_=
ALLOW),
> >     DRM_IOCTL_DEF(DRM_IOCTL_GEM_FLINK, drm_gem_flink_ioctl, DRM_AUTH),
> >     DRM_IOCTL_DEF(DRM_IOCTL_GEM_OPEN, drm_gem_open_ioctl, DRM_AUTH),
> > -   DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_gem_change_handle_io=
ctl, DRM_RENDER_ALLOW),
> > +   DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_invalid_op, DRM_REND=
ER_ALLOW),
> >
> >     DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETRESOURCES, drm_mode_getresources, 0=
),
> >
>

--
Simona Vetter
Software Engineer
http://blog.ffwll.ch
