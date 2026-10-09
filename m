Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851D2440622
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551218; cv=none; b=CcxmLYOilIv5DwfYtV2BlI+Zc3MEbuXH81YhEVcjQv9BiI3wMUGjZuZyrzNbN4wXF6r6RSNzBpQ13X3fCsjxMBR4oKQMMHO/o3+rqIFUun8xLRcUxvrYfGO2V6g6LXgiecTdWCo2AIMPepA6trnjzMsjBaPfSX2snCoDuh706Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551218; c=relaxed/simple;
	bh=eoZDl/MVKXc1nl/j8SXwKVZ6btTOejFn1IXAMipbz9U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TJb4wC6RKYzVKPORB4z0QEDRv1E1fZhJNYf7EF0P0GShEsUNOwNvySLCMqeTuZyiN33BqzUKJYMDOLzpuLQz9cpeVpOE/sazigEQEnnK5xu/taApL84bMyppgoqdmenpL6mwYJ60X53AQi/IMyUmVYPiudM1xb/j8ljNhHaoW0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJbyzaiu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJbyzaiu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791551216; x=1823087216;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=eoZDl/MVKXc1nl/j8SXwKVZ6btTOejFn1IXAMipbz9U=;
  b=nJbyzaiuGWJLk6t+qoPjSxSWAqL0XxZPyXr01jQrZylljF9XybrY5qjV
   iFY0YO3HGDMOoZAYRdMEfR2CKbbtcK7v39NpNBs9RR5owoeZhDNhGc8zv
   V0NoLkNKoqyLynlDjxXM5PLkBCzB95xJ5Bl8nYXqfbI77J8nCQAhnSO63
   qIbKvbIdb47shvD/qhTNvM29rjCNnmCB/FkHBAS9U0mptys5f1siC31Vt
   wynqAtzDsMZJ9dtdb1AngU1MBFh9H5tPHOAjcCi451LBQks6bwrZtme9J
   5s6iBR3vW2UeodfS0BEKOK0qNBj5CzItw4mH9F2G1C637TFxUcsjR8u+Z
   g==;
X-CSE-ConnectionGUID: kbESthNjTZe48iNohG3yOA==
X-CSE-MsgGUID: ABvp0SVUSUehlajxMWNU5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="229405"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="229405"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 06:06:55 -0700
X-CSE-ConnectionGUID: Q4HHGMNaSUytkpvvIpwTog==
X-CSE-MsgGUID: sSdm5gdaTm6MGRm8hLPz2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="247687"
Received: from abityuts-desk1.ger.corp.intel.com (HELO [10.245.245.243]) ([10.245.245.243])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 06:06:51 -0700
Message-ID: <a048aaa445d06d2452853c2677fc2b2d21888325.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/3] drm/xe: skip p2p for suspected display buffers
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Matthew
 Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org, 
 Christian =?ISO-8859-1?Q?K=F6nig?=
	 <ckoenig.leichtzumerken@gmail.com>
Date: Fri, 09 Oct 2026 15:06:48 +0200
In-Reply-To: <1a852df2-c2a4-48bb-84de-cdd4b98b95bb@amd.com>
References: <20261007153605.1743626-5-matthew.auld@intel.com>
	 <20261007153605.1743626-8-matthew.auld@intel.com>
	 <2c6a97ac21c5ef161dbac279f9b971f383b6b944.camel@linux.intel.com>
	 <dbabed4e-468d-4ecf-b295-f5d8c9c4b263@intel.com>
	 <bc2f4d82-5a8e-4d1b-a921-ee819ca5cac2@amd.com>
	 <992d57f0-7327-4c36-adf7-6dd72137fe73@intel.com>
	 <31f7eb68-6dfa-4ea7-93a4-d4897fbe6a74@intel.com>
	 <3579864a-0283-4f92-b895-5cf399c2ee69@amd.com>
	 <16cfde6b-8881-4ffe-8068-9530286da72a@intel.com>
	 <1a852df2-c2a4-48bb-84de-cdd4b98b95bb@amd.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-10-09 at 13:38 +0200, Christian K=C3=B6nig wrote:
> On 10/9/26 12:29, Matthew Auld wrote:
> > On 09/10/2026 10:26, Christian K=C3=B6nig wrote:
> > > On 10/9/26 11:16, Matthew Auld wrote:
> > > > On 08/10/2026 12:17, Matthew Auld wrote:
> > > > > On 08/10/2026 10:55, Christian K=C3=B6nig wrote:
> > > > > > On 10/8/26 11:46, Matthew Auld wrote:
> > > > > > > On 07/10/2026 19:11, Thomas Hellstr=C3=B6m wrote:
> > > > > > > > On Wed, 2026-10-07 at 16:36 +0100, Matthew Auld wrote:
> > > > > > > > > If p2p is allowed on the CPU (like on AMD), we
> > > > > > > > > currently permit p2p
> > > > > > > > > for
> > > > > > > > > all exported VRAM buffers. However, in some multi-GPU
> > > > > > > > > setups, like
> > > > > > > > > with
> > > > > > > > > prime rendering on a dgpu and scanout/compositor
> > > > > > > > > using the igpu, it
> > > > > > > > > looks like the exported dma-buf window buffer can in
> > > > > > > > > some cases end
> > > > > > > > > up
> > > > > > > > > using p2p.
> > > > > > > > >=20
> > > > > > > > > However, user is reporting a kernel regression where
> > > > > > > > > performance here
> > > > > > > > > massively tanks across many games/workloads, where it
> > > > > > > > > looks like on
> > > > > > > > > each
> > > > > > > > > frame, the igpu is reading/sampling from VRAM over
> > > > > > > > > pcie for the
> > > > > > > > > window
> > > > > > > > > buffer, since it uses p2p. p2p is currently more
> > > > > > > > > intended for dgpu <-
> > > > > > > > > >=20
> > > > > > > > > dgpu, and not so much display buffers with igpu <->
> > > > > > > > > dgpu, at least
> > > > > > > > > for
> > > > > > > > > now.
> > > > > > > > >=20
> > > > > > > > > We don't currently have any hints to say "please use
> > > > > > > > > p2p for this
> > > > > > > > > buffer, or please don't", however we can use some
> > > > > > > > > heuristics to try
> > > > > > > > > to
> > > > > > > > > determine if this is likely a display buffer being
> > > > > > > > > exported to an
> > > > > > > > > igpu,
> > > > > > > > > which probably never intended for p2p:
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A01. FLAG_SCANOUT being set on the =
buffer. Window
> > > > > > > > > buffers usually get
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tagged with this, bu=
t not always.
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A02. Importer being a PCI device wi=
th display,
> > > > > > > > > which is not xe driver.
> > > > > > > > >=20
> > > > > > > > > We also rely on the existing p2p Intel CPU whitelist
> > > > > > > > > to stop this
> > > > > > > > > happening on xe igpu. Currently p2p is only enabled
> > > > > > > > > for server CPUs,
> > > > > > > > > on
> > > > > > > > > Intel. We also limit the above to dual placement
> > > > > > > > > buffers.
> > > > > > > > >=20
> > > > > > > > > The original regression was bisected to commit
> > > > > > > > > 609fc8766d68 ("dma-
> > > > > > > > > buf:
> > > > > > > > > Always build with DMABUF_MOVE_NOTIFY"), however the
> > > > > > > > > behaviour was
> > > > > > > > > already present when enabling that knob, so this goes
> > > > > > > > > back even
> > > > > > > > > further.
> > > > > > > > >=20
> > > > > > > > > User has confirmed that along with the sticky dma-buf
> > > > > > > > > TT placement
> > > > > > > > > fix,
> > > > > > > > > to prevent ping-ponging, the performance is back to
> > > > > > > > > normal.
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Actually, I think this needs to be fixed on the
> > > > > > > > importer side. Until we
> > > > > > > > have some some user-space hints, I don't think the
> > > > > > > > exporter should
> > > > > > > > second-guess. Most sane solution IMO is if igfx
> > > > > > > > importers could just
> > > > > > > > not advertise pcie p2p support?
> > > > > > >=20
> > > > > > > Yeah, not sure tbh. I'm not a huge fan of this patch
> > > > > > > either. But you could argue that the SCANOUT flag is
> > > > > > > already a good implicit hint/ signal on the exporter
> > > > > > > side, but unfortunately there were some games where this
> > > > > > > did not reliably work. The other implicit hint/signal is
> > > > > > > perhaps the dual placement angle. For example, in
> > > > > > > compute-runtime, it might be that they use VRAM-only if
> > > > > > > they want p2p? AFAICT mesa for us always uses a dual
> > > > > > > placement or just system memory for these types of
> > > > > > > buffers.
> > > > > > >=20
> > > > > > > Christian, do you have any thoughts here? We have a
> > > > > > > kernel perf regression after DMABUF_MOVE_NOTIFY was made
> > > > > > > the default after updating to a new kernel. The gist is
> > > > > > > that this then turned on the p2p paths, with a multi-GPU
> > > > > > > setup with an AMD igpu/APU and Xe dgpu doing prime
> > > > > > > rendering. From the user bug report it sounds like the
> > > > > > > dgpu linear window buffer exported to the compositor
> > > > > > > (igpu) is dual placement VRAM + TT, and so this now
> > > > > > > attempts to keep that memory in VRAM instead of moving
> > > > > > > it. Compositor then uses p2p to access it. It works but
> > > > > > > performance falls off a massive cliff here.
> > > > > > >=20
> > > > > > > Perhaps Intel Mesa side should use tt-only for this type
> > > > > > > buffer (?), but since this is a kernel regression I was
> > > > > > > hoping we could fix this on the kernel side.
> > > > > > >=20
> > > > > > > Some questions:
> > > > > > >=20
> > > > > > > 1. Do you know what is the general story with p2p between
> > > > > > > igpu and dgpu? Is this a legit thing? For igpus/APUs,
> > > > > > > advertising p2p can't be dropped? It clearly seems to
> > > > > > > work though.
> > > > > > >=20
> > > > > > > 2. If this is legit, do you guys then also prevent p2p
> > > > > > > with display buffers? Are you just doing that at the Mesa
> > > > > > > level, or is there some magic in the kernel also?
> > > > > >=20
> > > > > > If I understand that correctly that the igpu is the
> > > > > > importer and the dgpu is the exporter then yeah Thomas is
> > > > > > right that definately needs to be fixed on the importer
> > > > > > side.
> > > > >=20
> > > > > Ideas on how do that? Could we do something like
> > > > > allow_peer2peer =3D false in amdgpu_gem_prime_import() if this
> > > > > is an APU device, or further check if the exporter side is
> > > > > not amdgpu, like APU + Xe?
> > > >=20
> > > > For example:
> > > > https://gitlab.freedesktop.org/mwa/kernel/-/commit/7ec86c68b42655b4=
bb85ee90af434a617e7bec8c
> > > >=20
> > > > Is that something you would accept?
> > >=20
> > > No, you misunderstood me. Enabling P2P is perfectly fine for APUs
> > > and mandatory for a couple of customer projects.
> > >=20
> > > The buffer should just be rejected from scanout in the display
> > > code and on the AMDGPU side we already do that if I'm not
> > > completely mistaken.
> >=20
> > Reporter confirmed seeing the issue in windowed mode also. So I
> > don't think it's just a case of rejecting from scanout?
>=20
> Then I don't understand what the problem is.
>=20
> When the dGPU renders and the iGPU displays you have only two
> possibilities, either the dGPU pushes the frames over the bus or the
> iGPU pulls the frames over the bus. Both should be equaly slow or
> fast, so what exactly is the expectation here?

I think PCIe reads, even p2p can be agonizingly slow. From my
understanding writes are posted whereas reads are not. The reading=20

/Thomas

>=20
> The only thing you need to avoid is that the iGPU starts to scan out
> over the PCIe bus directly, cause then the frame is pulled over the
> bus multiple times (if that actually works correctly).
>=20
> Do you have a link to the original bug report? I was only added later
> to the discussion so I don't have that.
>=20
> Regards,
> Christian.
>=20
> >=20
> > >=20
> > > Userspace has fallback path that when a DRM atomic requests fails
> > > for an imported buffer it falls back to copying the buffer first.
> > >=20
> > > Regards,
> > > Christian.
> > > > >=20
> > > > > >=20
> > > > > > At least for AMD APUs we clearly support P2P both as
> > > > > > exporter and importer, but what isn't supported is to scan
> > > > > > out over P2P. We explicitely reject that inside DC/DAL.
> > > > > >=20
> > > > > > And I'm pretty sure that you should do that as well. I'm
> > > > > > actually really suprised that this works technically and
> > > > > > doesn't cause corruption or anything.
> > > > >=20
> > > > > AFAICT on Intel iGPUs it will currently always end up with
> > > > > peer2peer =3D false on attach. Not 100% sure if direct scanout
> > > > > was happening on the p2p buffer itself, for the user report.
> > > > >=20
> > > > > >=20
> > > > > > Regards,
> > > > > > Christian.
> > > > > >=20
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > Thanks,
> > > > > > > > Thomas
> > > > > > > >=20
> > > > > > > > > Assisted-by: LLM
> > > > > > > > > Closes:
> > > > > > > > > https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items=
/9415
> > > > > > > > > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > > > > > > > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM
> > > > > > > > > driver for Intel
> > > > > > > > > GPUs")
> > > > > > > > > Cc: Thomas Hellstr=C3=B6m
> > > > > > > > > <thomas.hellstrom@linux.intel.com>
> > > > > > > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > > > > > > Cc: <stable@vger.kernel.org> # v6.12
> > > > > > > > > ---
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/xe/xe_bo.c=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +-
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/xe/xe_bo.h=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/xe/xe_dma_buf.c |=
 63
> > > > > > > > > ++++++++++++++++++++++++ +------
> > > > > > > > > --=C2=A0
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A03 files changed, 51 insertions(+)=
, 16 deletions(-
> > > > > > > > > )
> > > > > > > > >=20
> > > > > > > > > diff --git a/drivers/gpu/drm/xe/xe_bo.c
> > > > > > > > > b/drivers/gpu/drm/xe/xe_bo.c
> > > > > > > > > index 5065a7bac39c..e63437a261cb 100644
> > > > > > > > > --- a/drivers/gpu/drm/xe/xe_bo.c
> > > > > > > > > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > > > > > > > > @@ -3658,7 +3658,7 @@ int xe_gem_create_ioctl(struct
> > > > > > > > > drm_device *dev,
> > > > > > > > > void *data,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Displa=
y scanout is always non-coherent
> > > > > > > > > with the CPU
> > > > > > > > > cache.
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (args->flag=
s &
> > > > > > > > > DRM_XE_GEM_CREATE_FLAG_SCANOUT)
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bo_flags |=3D=
 XE_BO_FLAG_FORCE_WC;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bo_flags |=3D=
 XE_BO_FLAG_FORCE_WC |
> > > > > > > > > XE_BO_FLAG_SCANOUT;
> > > > > > > > > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (arg=
s->flags &
> > > > > > > > > DRM_XE_GEM_CREATE_FLAG_NO_COMPRESSION) {
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (XE_IOCTL_DBG(xe, GRAPHICS_VER(xe) <
> > > > > > > > > 20))
> > > > > > > > > @@ -4228,6 +4228,7 @@ int xe_bo_dumb_create(struct
> > > > > > > > > drm_file
> > > > > > > > > *file_priv,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DRM_=
XE_GEM_CPU_CACHING_WC,
> > > > > > > > > XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe))
> > > > > > > > > |
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XE_B=
O_FLAG_FORCE_WC |
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XE_BO_FLAG_SCANOUT |
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XE_B=
O_FLAG_NEEDS_CPU_ACCESS,
> > > > > > > > > NULL);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(bo)=
)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return PTR_ERR(bo);
> > > > > > > > > diff --git a/drivers/gpu/drm/xe/xe_bo.h
> > > > > > > > > b/drivers/gpu/drm/xe/xe_bo.h
> > > > > > > > > index 1ddf3b6d4a9e..6965c2655731 100644
> > > > > > > > > --- a/drivers/gpu/drm/xe/xe_bo.h
> > > > > > > > > +++ b/drivers/gpu/drm/xe/xe_bo.h
> > > > > > > > > @@ -56,6 +56,7 @@
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0#define XE_BO_FLAG_FORCE_USER_VRA=
M=C2=A0=C2=A0=C2=A0 BIT(25)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0#define XE_BO_FLAG_NO_COMPRESSION=
=C2=A0=C2=A0=C2=A0 BIT(26)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0#define XE_BO_FLAG_NEEDS_1G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(27)
> > > > > > > > > +#define XE_BO_FLAG_SCANOUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BIT(28)
> > > > > > > > > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0/* this one is trigger int=
ernally only */
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0#define XE_BO_FLAG_INTERNAL_TEST=
=C2=A0=C2=A0=C2=A0 BIT(30)
> > > > > > > > > diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
> > > > > > > > > b/drivers/gpu/drm/xe/xe_dma_buf.c
> > > > > > > > > index b973579a69b8..0a347f09cee4 100644
> > > > > > > > > --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> > > > > > > > > +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> > > > > > > > > @@ -36,10 +36,40 @@ static void
> > > > > > > > > xe_ddebug_flip_bool(const struct
> > > > > > > > > _ddebug *desc, bool *flag)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0#define xe_dma_buf_p2p_debug_flip=
(flag) do { }
> > > > > > > > > while (0)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0#endif
> > > > > > > > > =C2=A0=C2=A0=C2=A0 +static void xe_dma_buf_move_notify(st=
ruct
> > > > > > > > > dma_buf_attachment
> > > > > > > > > *attach)
> > > > > > > > > +{
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 struct drm_gem_object *obj =3D attach=
-
> > > > > > > > > >importer_priv;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 struct xe_bo *bo =3D gem_to_xe_bo(obj=
);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 struct drm_exec *exec =3D
> > > > > > > > > XE_VALIDATION_UNSUPPORTED;
> > > > > > > > > +
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 XE_WARN_ON(xe_bo_evict(bo, exec));
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static const struct dma_buf_attach_ops
> > > > > > > > > xe_dma_buf_attach_ops =3D {
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 .allow_peer2peer =3D true,
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 .invalidate_mappings =3D xe_dma_buf_m=
ove_notify
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > > +static struct pci_dev *xe_find_parent_pci_dev(struct
> > > > > > > > > device *dev)
> > > > > > > > > +{
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 while (dev) {
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dev_is_pc=
i(dev))
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return to_pci_dev(dev);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D dev->=
parent;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 return NULL;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static bool xe_dma_buf_attach_is_xe_device(struct
> > > > > > > > > dma_buf_attachment
> > > > > > > > > *attach)
> > > > > > > > > +{
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 return attach->importer_ops =3D=3D
> > > > > > > > > &xe_dma_buf_attach_ops;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0static int xe_dma_buf_attach(stru=
ct dma_buf
> > > > > > > > > *dmabuf,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 struct dma_buf_a=
ttachment
> > > > > > > > > *attach)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0{
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_gem=
_object *obj =3D attach->dmabuf-
> > > > > > > > > >priv;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 struct xe_bo *bo =3D gem_to_xe_bo(obj=
);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool verbose_p=
2p_dist =3D
> > > > > > > > > drm_debug_enabled(DRM_UT_DRIVER);
> > > > > > > > > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > xe_dma_buf_p2p_debug_flip(&verbose_p2p_dist);
> > > > > > > > > @@ -48,7 +78,24 @@ static int
> > > > > > > > > xe_dma_buf_attach(struct dma_buf
> > > > > > > > > *dmabuf,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 pci_p2pdma_distance(to_pci_dev(obj->dev-
> > > > > > > > > >dev), attach-
> > > > > > > > > > dev, verbose_p2p_dist) < 0)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 attach->peer2peer =3D false;
> > > > > > > > > =C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 if (!attach->peer2=
peer &&
> > > > > > > > > !xe_bo_can_migrate(gem_to_xe_bo(obj), XE_PL_TT))
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 if (attach->peer2peer && xe_bo_can_mi=
grate(bo,
> > > > > > > > > XE_PL_TT)) {
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_de=
v *client =3D
> > > > > > > > > xe_find_parent_pci_dev(attach->dev);
> > > > > > > > > +
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * There=
 are perf issues with using p2p with
> > > > > > > > > display
> > > > > > > > > buffers,
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * like =
with igpu (compositor) <-> dgpu
> > > > > > > > > (exported
> > > > > > > > > p2p window
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * buffe=
r). Probably we need some actual
> > > > > > > > > userspace
> > > > > > > > > hints. We
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * shoul=
dn't really assume anything. Also,
> > > > > > > > > note that
> > > > > > > > > some of
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * these=
 buffers are not always tagged with
> > > > > > > > > SCANOUT.
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bo->flags=
 & XE_BO_FLAG_SCANOUT)
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 attach->peer2peer =3D false;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (clie=
nt && pci_is_display(client) &&
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
> > > > > > > > > !xe_dma_buf_attach_is_xe_device(attach))
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 attach->peer2peer =3D false;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > +
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 if (!attach->peer2peer && !xe_bo_can_=
migrate(bo,
> > > > > > > > > XE_PL_TT))
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -EOPNOTSUPP;
> > > > > > > > > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xe_pm_r=
untime_get(to_xe_device(obj->dev));
> > > > > > > > > @@ -349,20 +396,6 @@ xe_dma_buf_create_obj(struct
> > > > > > > > > drm_device *dev,
> > > > > > > > > struct dma_buf *dma_buf)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret ? E=
RR_PTR(ret) : &bo->ttm.base;
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0}
> > > > > > > > > =C2=A0=C2=A0=C2=A0 -static void xe_dma_buf_move_notify(st=
ruct
> > > > > > > > > dma_buf_attachment
> > > > > > > > > *attach)
> > > > > > > > > -{
> > > > > > > > > -=C2=A0=C2=A0=C2=A0 struct drm_gem_object *obj =3D attach=
-
> > > > > > > > > >importer_priv;
> > > > > > > > > -=C2=A0=C2=A0=C2=A0 struct xe_bo *bo =3D gem_to_xe_bo(obj=
);
> > > > > > > > > -=C2=A0=C2=A0=C2=A0 struct drm_exec *exec =3D
> > > > > > > > > XE_VALIDATION_UNSUPPORTED;
> > > > > > > > > -
> > > > > > > > > -=C2=A0=C2=A0=C2=A0 XE_WARN_ON(xe_bo_evict(bo, exec));
> > > > > > > > > -}
> > > > > > > > > -
> > > > > > > > > -static const struct dma_buf_attach_ops
> > > > > > > > > xe_dma_buf_attach_ops =3D {
> > > > > > > > > -=C2=A0=C2=A0=C2=A0 .allow_peer2peer =3D true,
> > > > > > > > > -=C2=A0=C2=A0=C2=A0 .invalidate_mappings =3D xe_dma_buf_m=
ove_notify
> > > > > > > > > -};
> > > > > > > > > -
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0#if IS_ENABLED(CONFIG_DRM_XE_KUNI=
T_TEST)
> > > > > > > > > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0struct dma_buf_test_params=
 {
> > > > > > >=20
> > > > > >=20
> > > > >=20
> > > >=20
> > >=20
> >=20
