Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A1324293C
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 22:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781821811; cv=fail; b=KhSUE+1Y86ptitmdy753It8Zm85RPo/hmk/rfQoifa8wvhndxnlVz/R2UHLN/nJjz3oJg6VxRyqPe62sT3P1/B7vtlE6yHO727p2YNwxTm5u40Gx/hBsz7jTrCnYnGFTLHz7sQwHsKRxcIhbuuodY9y11Klba5ajd0NKrhGMJg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781821811; c=relaxed/simple;
	bh=o+XLwPqgW/hBkC2LrZX1d5EjEJBzsLSCZ77quQ2yXRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d9s/daBQD/Bvo+kVBmHpYirxSjn9sWV/vhNWvSwoixy5Z46AfY6vOTK3fvDoJE1gH24h0TlPTvQYxs7TTc40onwhI7iWBqoXGywfQONNyobheJEzsqEOBlpUD//EP0R3YhGwT1wIltgnASki49uuLXlx1SAjJJiqeTlWLGQwzbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KEhxDLo/; arc=fail smtp.client-ip=52.101.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KEhxDLo/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sc8L+D6yOLXOFgaYgnHLB17m68ySJSa1s2gcFnmN93B/D84F/SfgkSohxVA3/igbDhcw4PiZ/5ao5KJUarVJEMTnxxffWG4benaG5iVWly6jCevAlgVej3j4P303QgfNe7HWsDpnrFrAGzMB7ry0aLLmPJlIyR3+TzrebcmV1xAMbyPW//D0VincFMqDycAKPcredHoTV7Ut7UJltgypFO1HI0RkkovMlO4jp0Lury8shyeMNDuoE/3yvalhw35BSEbD7x6Ypzb2ZoyNdr6UGPuvJ3Po0hefmqiys5Id/7x3WshZ8Wz7Rqu8glVFl+UowFATQwIJEKylxKtV0vn57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmGVsorics61RJb6zmQ7BPxGDmAoYXAbo4Zjg5/UOgM=;
 b=CV+C2cc7ljr+6yICBDMyrwC5LGwVKZCMM67hdJK3fJsk5HdABY9eLYrEpX/HOReVgJIa78tW38WNmtZbknLr4kzGFJKrWCKb8by6n3K21xlreHEUr+3ATZHcsAFoy6vcKmAKYLbF4ZJlas0BJALfdYTOtI35r1k6tKrMkfToIA0CwSFFK4bir42tKPHvH/D9v90pcYTWEvv/FM+mCAOoeABmrXqU0W2FIyVQ5YUKOWXCi67ZDGsIQM9R1Y7EVGwyJlw7Vn52zumsFscDqOhuLH9jGtV+TA01k4S/Npgnrxsq5VX6h/AGne3ci9arcEnHf2tMWW6Inw3tIjD2rzBmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmGVsorics61RJb6zmQ7BPxGDmAoYXAbo4Zjg5/UOgM=;
 b=KEhxDLo/Csl2RQMKoE1KCxEqlnyGZNK4x1D3TpyNAOQ6VJoXietN6AlNKN3/FhcLPXCFmtpdWo5LS6EfxWXC17QfByvLGJh558Y+LMEPr+a5r0TVS9OsaN6m8DjyQijRo3hIpKyG7A2w+oSC7e4aW0Dt03GSx5hXUhyGmiYzc7k=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 22:30:01 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 22:30:01 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Koenig, Christian"
	<Christian.Koenig@amd.com>, "Huang, Honglei1" <Honglei1.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages
Thread-Topic: [PATCH] drm/amdgpu: drop retry loop in
 amdgpu_hmm_range_get_pages
Thread-Index: AQHc/ZDj6dTtfhjXuEmGnTr/gWnal7ZBKrgAgAO9rXA=
Date: Thu, 18 Jun 2026 22:30:01 +0000
Message-ID:
 <BL1PR12MB5144584BE0D29513B0EB37F2F7E32@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260616130531.738887-1-alexander.deucher@amd.com>
 <2026061615-driller-golf-4f34@gregkh>
In-Reply-To: <2026061615-driller-golf-4f34@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-18T22:29:33.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB7380:EE_
x-ms-office365-filtering-correlation-id: 89c9264f-9083-4691-5042-08decd892321
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|22082099003|18002099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 QA2bLlIPXaBOJJHbejebuIVmGEghcdWAweVfgqIMxdIFqWhXmEh+EOo+RaFNSH0/Rx/EN00aCX3I96b5UPCC/qrQG230UjvRt1oaoxUkPO6M0APA0phQLIrgX1g1lMCH7vDP5k+3cE/BlcdERq6kx42oM1Ltya9OHCELGsMaHxkm2nPHxR0V0X8jxTLsnobPje0QpoLWWosJMa3dhtuDPoec32roUOssxPxUeu+avDJpH0TnhdUp7a7F7LnVI0uhhqPlyqq5kG5AqLCqe/DdORJal1CW3h1hZ/VCFLz+9P5rRGgJhsJQ4TgWYWqbJJ8802SN8xLuDaPa/1jv4U1XWlGTiAohoHFDGtwoTaYq6c5PteqmLhEy8VSi1zJVcoyO/miYlM7eGnsCTg5NgjD7QVG8QoEjTACJMpjbd/m9ThkvDZGmZ5IGaMqF0QT3WBLYoGesbNyf7DZOyXPQVH8CXID8zZ0BBXWHHC1LqSfQ2xDPuXx1WoVdBWFvfleL9H5rxwV78QNSHIQcpMAmyilr41srRQL/+NJ9T9qoc+oHnGCRBrvjWL9diMjQ9kU0P/pUNHfHoPMVnR6GFAWv77BCUZpBDbGWy1BF3gtwzomlpppLsaawDeWzxkSflVJ5mVDLpHQ5YHphvjlMX+aEH50gUDG850BBJyfNH2OcjKb6lJQEk+MKoO3NTBJhzuU+6aalPxYELWLZQJoFuvdxg1F4ZIWR/Eh7m1DqARQneDd+6pU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KwYVkPw/90fN8XnRD32oIfXUGn2/rIDr5B4WZFtwbXNpdXltw9VflFpd0g?=
 =?iso-8859-1?Q?0M9KlDaKsHGCEmXctmyAhLj5Z0muilHTjJehEzFq3cXdIqgMp7zB/3vLMo?=
 =?iso-8859-1?Q?XYAYWQTSVylME0GWUfE5wufL2eIgVjTeC+O7LCDx8ToeVMhX7gR7kBmanK?=
 =?iso-8859-1?Q?u+C1xYl8GIVKnG5NGkbVJ8oX8FWrbk3TRR1z5ekfXjyajtgO28yp50CYhs?=
 =?iso-8859-1?Q?1bKAxrk+d6dVFOBVZHL4ZWqN0KHd4GQadvl08w/uAeCpXLQzIBaJ8m4LT2?=
 =?iso-8859-1?Q?Hn9s6zozq3zb4N/K/aywaxmgDUowYsJ7eHKRlRh+W97saWZDPT1LLjXRJP?=
 =?iso-8859-1?Q?WOi3jjbN0nmqCfgTo6nUHtcmYHtsf5bAjOBcYCEke+o3iwGx0TUWNISPAf?=
 =?iso-8859-1?Q?zGqFt7a42RV9RLTHuszPW9+hH/yL0AJ2rXGz26OcsP+gL8UYTqYDwk/LYm?=
 =?iso-8859-1?Q?IQR/OE5HeV/pq6PMkjzbGHCAwLKWcuF0AxNlyi/PzezjHuW9WMjbLSYmvw?=
 =?iso-8859-1?Q?NA1hOmXHRuiUo8OeOAPx0NVpxK8kewtFRoBVJ2PKI8XWWI9zMoXUPdvGeO?=
 =?iso-8859-1?Q?NRQeNBrNYwL8sNMt4WbUONrK4YJ7jif8uAY/lMCxDGVKxZq/7CyYCkBed0?=
 =?iso-8859-1?Q?3HgeFZcau4yTa6Gdg3U1VtxoYuJUpfzzBQ3eK71QtTnlNymCm20vVCjlN9?=
 =?iso-8859-1?Q?QN3aYO4yQkQ/BeUXojS4nWSbMhJeEPnARqWg5byfQrsyoapXD6tNs1L+BX?=
 =?iso-8859-1?Q?k5GuySmSbgtVT4k6XPHFdGVnMT+WmfXwXXmvCvQPtSbUkZosVz3dtmoXLr?=
 =?iso-8859-1?Q?0MaHzk6pz8B6UCSl8Y9AYCqxNp2jg+STCeO+Rvp2STwjs0dAhY0U/TKN6y?=
 =?iso-8859-1?Q?yDdecHukltsB3UJJd1vi8cUTv63uBdyYSHuvKzhJuQQ6fT27HCz3YDJc7M?=
 =?iso-8859-1?Q?EyUfHWSlbkzNiUMp5662TX9z8GhNlN//V38hUmnNyWW2uCLr/f3dj7Y9GF?=
 =?iso-8859-1?Q?Krtxp26VpDVmmGfJk1lPvotIBRR6F6wwbIfoKNGfJMmdCpFLCH3jMK1VC6?=
 =?iso-8859-1?Q?4l+TFM3ND7g+orsq7YlCPuCY3V2D6ib+bZ5arDcdOTyBS/VKE/uoca9fX/?=
 =?iso-8859-1?Q?gaJceaOl6rKhh3KGtwZR9QXDysIUizothWJ6G8U8BDYNd4cl6xdRwYZtA8?=
 =?iso-8859-1?Q?bXZUqC9g4Zlz9mfeAoDBCeCsIX41ibeEy607mUs6TpS1CS1ODA+zk/s1PV?=
 =?iso-8859-1?Q?nzPjeRKIHAXM8+EttK930MaR0uzlXIqj9ISC3Dn89WUlsac/LRgAsPoPqe?=
 =?iso-8859-1?Q?hsHTJ1Of8STAiRPJIc8+FeZ8jslOCOsuU5QWNxGLQRjXZQiMryiFW4mYxn?=
 =?iso-8859-1?Q?VXWN3Rpdltbu+6NtEBRXEnFg7833YBkufVE+ai0nurg6FYBgYsICmEyNyf?=
 =?iso-8859-1?Q?jjgTnSQWD4bMHFnhInCkokzb7xRoWWHslWxjO398AY4mijKxYCLlKe2b2e?=
 =?iso-8859-1?Q?byCT/dn+qAQUlFX6KCiCpLFKbZ9mzJzZ/BlnD4Q7WsNrv/fNzAPzq7EG+u?=
 =?iso-8859-1?Q?k+XjsYZmEX/+bPKGrykcZEdXc/Sn+PayVyD64yo5PgGGgv1K8mqrPIHnvL?=
 =?iso-8859-1?Q?ebo+wi7ppUWnISs5693wspI2A/g/f+M9J2dvwQRw4Er/UlMMKzsDp6oSzx?=
 =?iso-8859-1?Q?L87aX3NjeYOK7XoMv7hhQWRQVC+sBkJ3WIh6Tl68KP1gkLZ7AAQsDmxb0N?=
 =?iso-8859-1?Q?ZTi0zrgbWX4RnutjrkXxWjj2KG0r2xuFT/aaoG4fc3LaEe?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c9264f-9083-4691-5042-08decd892321
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 22:30:01.6648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VnspIdFvIbTrS1GD9CFmBF2Rpf0qsP8MsxsSQMxSh9eXPvcorKjMA9TCWtqVKtAQbThhTwJKMvpIb5gImpGeyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

Public

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, June 16, 2026 9:21 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: stable@vger.kernel.org; Koenig, Christian <Christian.Koenig@amd.com>;
> Huang, Honglei1 <Honglei1.Huang@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: drop retry loop in
> amdgpu_hmm_range_get_pages
>
> On Tue, Jun 16, 2026 at 09:05:31AM -0400, Alex Deucher wrote:
> > From: Honglei Huang <honghuan@amd.com>
> >
> > Since commit c08972f55594 ("drm/amdgpu: fix
> > amdgpu_hmm_range_get_pages") moved mmu_interval_read_begin() out
> of
> > the per-chunk loop, the captured notifier_seq is no longer refreshed
> > across retries. As a result, the existing -EBUSY retry path can never m=
ake
> progress:
> >
> >   hmm_range_fault() returns -EBUSY only when
> >   mmu_interval_check_retry(notifier, notifier_seq) reports that the
> >   sequence is stale. Once the sequence has advanced, the stored seq
> >   will never match again, so every subsequent call within the same
> >   invocation returns -EBUSY immediately.
> >
> > The "goto retry" therefore degenerates into a busy spin that simply
> > burns CPU for the full HMM_RANGE_DEFAULT_TIMEOUT (~1s) window
> before
> > finally bailing out with -EAGAIN. This is pure latency with no chance
> > of recovery, and it actively hurts the KFD userptr stack: the caller
> > ends up blocked for a second while holding mmap_lock, only to return
> > -EAGAIN to the restore worker (or to userspace) which would have
> > re-driven the operation immediately anyway.
> >
> > Drop the retry/timeout entirely and let -EBUSY propagate straight to
> > out_free_pfns, where it is already translated to -EAGAIN. Recovery is
> > handled at a higher level: the KFD restore_userptr_worker reschedules
> > itself, and the userptr ioctl path returns -EAGAIN to userspace.
> >
> > No functional regression: the previous behaviour on -EBUSY was already
> > to fail with -EAGAIN after a 1s stall; we just skip the stall.
> >
> > Fixes: c08972f55594 ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5393
> > Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
> > Signed-off-by: Honglei Huang <honghuan@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com> (cherry picked
> > from commit 342981fff32802a819d6fc7cf3c9fedf9f3d9d60)
> > Cc: stable@vger.kernel.org
> > ---
> >
> > This patch is from drm-next and fixes a regression in a patch that
> > went to stable.
>
> But this commit isn't in Linus's tree yet so we can't take it, right?

It was only in drm-next when I sent this email, but it has since landed in =
Linux tree now that he has pulled the drm tree.

Alex

>
> confused,
>
> greg k-h
