Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789914;
	b=1MBTMPt5w3QoNyE6kwYV8n8Lh0PYRgFye+9SobhpokkFKYd415E9zxGD1Rrg14nw9UFB
	 d8oWxL8mFJLLa/jMNSGalLFKCEVCn3GUP9aoX5aM1JFnsbM+0nd5j7KoQeDYkYBQm3C66
	 6NVntal75yGwoHOrQc3dtFVGVLyIkfkJ+h2vunT5ePSrnDsZ4q753/LCVuZh+739g+C08
	 VFuGIpxxj5JRxh0qySEM8H2Eqy5Kjw48klLBxIM8uXk4tS2HZALTtrjqD5evYLg5m7D6i
	 jP09S4pc2IJ0ArYyqjLMo3gqX/Nn2q5ajkcD0hhDwdN3kD1E0btVLK0pQI31R2iDqeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789914;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UYMZYA16pBJWYaNihgVXIF9xjzU0+2ohahxkf0gwfVc=;
	b=f+odEFr/jri0Wjc93B2AYQTAsAMhYawiEVXOdSVc3wCCnjIFUYvB2Krg0z5H1WAdxaRq
	 XsGBSK4WqZZpbjKroRo9qcdhbwk9taUVzcnG69O5dISDsGn0JL4rzNVN1qzz1LJO+QRvt
	 x8Wp/MtAX9Kpahssc4g6na2bOt8MpvKFQReYb2l5t4bzePgM0eF4Xy47+eU1at4n4iP7n
	 ogQ3cQ6gyCBWAs/cmgZKZOU9aO/js7szCRgcwwcghYZestel0hYGspK1YRHs7rovVgQyV
	 UalFbDyd0xynjrSGH2TbSmy61EOtEIicfq1wT4OzBxbQJOBH9F2tD+bbVcYpUPgq85Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJVeFQnb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A69606A31B;
	Wed,  4 Nov 2026 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJVeFQnb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626021F000C1;
	Wed,  4 Nov 2026 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793789914;
	bh=UYMZYA16pBJWYaNihgVXIF9xjzU0+2ohahxkf0gwfVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AJVeFQnb6VpMx40meUsvImeqFm1Ho0oI2xBeCY2Vz0GN/UolsUN+T7DAr0lEVoJY+
	 u7R9TGhgk/uITOn9aBD5Q9RSTzV6OVQ3cNn7qrk0mmniV/2Lycp/7XX77G9Gk00445
	 tNojgdaSBrRrZzp5/EIoJb+Npm+1VC0lP75BK2PMlGQxxrCwwMy1c4EzeP4zFwPRdN
	 Fo6X2gStnKUsBvj/JdLT4srE+fW00YDc+qFvgSOzosomKInJVKUvd/nVpBneg7NYnP
	 Ri6Sjue8N7LMkf5EWuuG1AkFicMniK+6HxjZnyjSnai3FJxYAiJ5P8gtgn1eAXrdIy
	 OspWeFijkhAVg==
Date: Wed, 4 Nov 2026 10:58:29 +0000
From: Lee Jones <lee@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: dmitry.torokhov@gmail.com, jic23@kernel.org,
	linux-input@vger.kernel.org, mfd@lists.linux.dev,
	linux-iio@vger.kernel.org, stable@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH] mfd: mxs-lradc: Pass mapped IRQs to child devices
Message-ID: <20261104105829.GI792264@google.com>
References: <20261018022400.599028-1-festevam@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018022400.599028-1-festevam@gmail.com>

On Sat, 17 Oct 2026, Fabio Estevam wrote:

> The MFD resource tables store indices into the parent DT interrupts
> property. Since the MFD core is given neither an IRQ domain nor a base,
> however, it exposes those indices to child devices as though they were
> Linux IRQ numbers.
> 
> The touchscreen interrupt is at DT index 0 on both supported SoCs.
> platform_get_irq_byname() therefore rejects its child resource with:
> 
>  0 is an invalid IRQ number
> 
> On current kernels it also returns -EINVAL, preventing the touchscreen
> driver from probing.
> 
> The child drivers try to map their resource values afterwards with
> irq_of_parse_and_map(), but the touchscreen driver never reaches that
> call for index 0. More generally, translating the parent firmware's IRQ
> indices does not belong in the child drivers, where platform IRQ
> resources are expected to contain mapped Linux IRQs already.
> 
> Have the MFD parent copy each resource template and resolve its IRQ
> indices with platform_get_irq() before registering the child. The child
> drivers can then request the mapped IRQs directly. Use per-device copies
> so later instances and reprobes still start with the DT indices.
> 
> Apply the same fix to the ADC child, which uses the same IRQ mapping
> scheme.
> 
> Tested on an i.MX28 EVK. The mxs-lradc-ts driver now probes
> successfully, and its interrupt counters increase when the screen is
> touched.
> 
> Cc: stable@vger.kernel.org
> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> Closes: https://lore.kernel.org/linux-input/CAOMZO5CgTzo6GuXptD4mFTN=UsJJqpkixDW1Q64gqZGrij8+uQ@mail.gmail.com/
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> This is a long-standing bug that I reported in 2020:
> https://lore.kernel.org/linux-input/CAOMZO5CgTzo6GuXptD4mFTN=UsJJqpkixDW1Q64gqZGrij8+uQ@mail.gmail.com/
> 
> This patch touches MFD, IIO, and Input. Since the IRQ mapping is moved
> into the MFD parent, I suggest merging it through the MFD tree, with
> acks from the IIO and Input maintainers.
> 
> The full backtrace:
> 
> [   10.540505] WARNING: drivers/base/platform.c:492 at __platform_get_irq_byname+0xb4/0xcc, CPU#0: swapper/0/1
> [   10.555516] 0 is an invalid IRQ number
> [   10.559627] Modules linked in:
> [   10.562849] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc7-next-20261016-00003-g36062817a968 #17 VOLUNTARY
> [   10.573732] Hardware name: Freescale MXS (Device Tree)
> [   10.578934] Call trace:
> [   10.578992]  unwind_backtrace from show_stack+0x10/0x14
> [   10.586955]  show_stack from dump_stack_lvl+0x48/0x64
> [   10.592170]  dump_stack_lvl from __warn+0x8c/0x190
> [   10.597114]  __warn from warn_slowpath_fmt+0x94/0xcc
> [   10.602232]  warn_slowpath_fmt from __platform_get_irq_byname+0xb4/0xcc
> [   10.609027]  __platform_get_irq_byname from platform_get_irq_byname+0x10/0x30
> [   10.616337]  platform_get_irq_byname from mxs_lradc_ts_probe+0x18c/0x378
> [   10.623247]  mxs_lradc_ts_probe from platform_probe+0x58/0x90
> [   10.629174]  platform_probe from really_probe+0xc4/0x2cc
> [   10.634649]  really_probe from __driver_probe_device+0xa0/0x1e0
> [   10.640721]  __driver_probe_device from driver_probe_device+0x30/0xc0
> [   10.647315]  driver_probe_device from __driver_attach+0x94/0x158
> [   10.653466]  __driver_attach from bus_for_each_dev+0x7c/0xd0
> [   10.659280]  bus_for_each_dev from bus_add_driver+0x158/0x1fc
> [   10.665169]  bus_add_driver from driver_register+0x7c/0x114
> [   10.670901]  driver_register from do_one_initcall+0x60/0x294
> [   10.676721]  do_one_initcall from kernel_init_freeable+0x19c/0x24c
> [   10.683073]  kernel_init_freeable from kernel_init+0x14/0x10c
> [   10.688997]  kernel_init from ret_from_fork+0x14/0x38
> [   10.694200] Exception stack(0xc8819fb0 to 0xc8819ff8)
> [   10.699335] 9fa0:                                     00000000 00000000 00000000 00000000
> [   10.707591] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   10.715843] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [   10.723117] irq event stamp: 146363
> [   10.726729] hardirqs last  enabled at (146367): [<c00adbd8>] __nbcon_atomic_flush_pending_con+0x120/0x1c0
> [   10.736770] hardirqs last disabled at (146372): [<c0008f38>] __irq_svc+0x58/0xb0
> [   10.744618] softirqs last  enabled at (146362): [<c0032c20>] __irq_exit_rcu+0x148/0x1d4
> [   10.753153] softirqs last disabled at (146385): [<c0032c20>] __irq_exit_rcu+0x148/0x1d4
> [   10.761603] ---[ end trace 0000000000000000 ]---
> [   10.766374] mxs-lradc-ts mxs-lradc-ts: error -EINVAL: IRQ mxs-lradc-touchscreen not found
> [   10.766456] mxs-lradc-ts mxs-lradc-ts: probe with driver mxs-lradc-ts failed with error -22
> 
>  drivers/iio/adc/mxs-lradc-adc.c          |  7 +---
>  drivers/input/touchscreen/mxs-lradc-ts.c |  7 +---
>  drivers/mfd/mxs-lradc.c                  | 47 +++++++++++++++++++-----
>  3 files changed, 42 insertions(+), 19 deletions(-)

Nightmare!  Right, let's make a decision to stop kicking the can down
the road with these hacks on hacks, and fix it properly please.

While your patch fixes the immediate symptom, keeping DT indices inside
static 'struct resource' templates and kmemdup'ing/mutating them at
probe time is really just building a hack on top of a hack.  This stops
now.

Background:

The existing IRQ handling in this driver is a bit of a historical comedy
of errors:

1. The MFD driver stuffs raw DT 'interrupts' indices (0..12) into
   DEFINE_RES_IRQ_NAMED(), which is meant for either Linux virqs or
   hwirq offsets into an MFD irq_domain.

2. It registers the child devices with neither an irq_domain nor an
   irq_base, exposing those raw DT indices as if they were mapped
   Linux IRQ numbers, which understandably blew up once IRQ 0
   started being rejected by platform_get_irq_byname():

     a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")).

3. Both the MFD parent and the child drivers duplicate the exact same
   lists of IRQ name strings, only for the children to loop over them
   calling platform_get_irq_byname() to fish the raw DT index back
   out, pass it to irq_of_parse_and_map() on the parent's of_node
   and then register the exact same IRQ handler for every single one
   of them.

4. To top it off, the YAML DT binding added last year (009528b5aa13)
   doesn't even match the driver's IRQ index order, since it lists
   the touchscreen IRQ at index 6/10 instead of index 0.

Solution:

When the parent platform_device is created from DT, the OF core has
already parsed and mapped all of the interrupts into the parent's
resources.  Neither child driver actually distinguishes between its
individual IRQs (they just loop over them and register the same handler
for each) and both children already access the parent's ddata.

Instead of jumping through all of these resource hoops, let's:

 - Drop all of the static IRQ resource tables and the duplicated
   irq_names[] string arrays across all three drivers.

 - Collapse mx23_cells and mx28_cells into a single 'static const struct
   mfd_cell' array (passing the MEM resource via the mem_base argument
   of devm_mfd_add_devices() rather than overwriting RES_MEM manually).

 - Resolve the IRQs in mxs_lradc_probe() via platform_get_irq() and
   store them in 'struct mxs_lradc' (similar to stm32-timers.c) for the
   children to request directly.

If this all seems like too much, let me know and I'll spin-up an RFC for
you to test.

-- Lee Jones
