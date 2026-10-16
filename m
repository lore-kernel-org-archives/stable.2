Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5363E3D9E;
	Fri, 16 Oct 2026 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792148818; cv=pass; b=ZEnYEV/UQEN6w5cin5sFjxwZFVzB3w1DrYY+hY9gsUkCHwKDEp0iOBYvjx18Q4I7eA6MZkXtqlLGXzXFslGGRvxSjxbfnAvwHhtDTCn86CT+vtI1f/fiWeQm0w+uNanncz+XOhFl03nWRh+TTE8DLt1VY7oKez7edk3k9fWkfKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792148818; c=relaxed/simple;
	bh=V+v9/WoJjCh3t5+lgvT3mGFNrt+9tDSw7DRYoex0D3Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=XGEPg3ptnGa7Hk0XA41u0jkttfuNeYrLbTxhx4ATQ6SiGobaSeY+CmOaY0tF5yVxnWMGCI/rnH7KCJeHdso+klkUSONOVh0c6fpONXv7uQDUXEELBdEU5gWPjRnJcl4FUluL6Oimyzojm/Fu1VeRRLCFoiJmVv9slPRQJVivNrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=hG4we6Xd; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="hG4we6Xd"
Received: from [127.0.0.1] (unknown [IPv6:2a02:560:5ca5:d100:9ebf:dff:fe00:fdb5])
	(Authenticated sender: sha@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A84A2201B55;
	Fri, 16 Oct 2026 13:06:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792148812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GXr3B92E2k2dyeJan3T3f83ODbQurRgLvjQKw7RXF4=;
	b=hG4we6XdQu9JTl/ag584pbCuUCQAgSTAzcScim7ZLWnIRBQdzRx1W+ZboGh9dAdUvkvpdp
	VdTc/Ty2JrjkO3PhhAsIEEY5Tf09TIfrqn8g+WxKtbV6Lz1Nbwwfk+o8g+doopTRgFh0sJ
	bCAIjMQwyMTqof4kMNIO7S2E5MCNE/W3eTDMijh5/PCHwCgloXAfCLKyCCCoKveJU2lbQY
	7M+NFOcBhF7cpjPbzhiAbJYf9KKRZ0VC/p2iMyXdPuwBEOFgfN6/bXPWl2xOO+1OgwH0n7
	EPvDGp+OMI9jxaSfOqzprcI5OL5c7prCUPI5fPl+pTdx6VvV+zthl9QaZBHIPQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792148812; a=rsa-sha256;
	cv=none;
	b=WHifAtqK7PKjzR+Y+1LVYMVAwN153a+2D2bfg5HhnYpHLAh9ZwsP9Sb/jPnYoqow+TTMxj
	I6GWJYDVhfubOroX0XP81ESjShxwmUyeKcoSxh1aJmZH7q3Xa2aULM1jgSnCV1gO+rBQ21
	tAIP70oIM3oEhwz8R3mea7HZf57D/aL2tr4466o/D32phsxJOBDTv3jOqpgZtzJP5i/uOf
	fdiVxuPovFNoDQsOyvaf7fIdm40MrefOiAQDeRYsjJHaw23UAIq55z2K6CDNAJoDlkQm5m
	d59dk4P1pYGy1Sj9AgA82YGQWW/LMjvfG1PhxDOUzOLSEYXVnmSVUu9kxDhuFA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sha@pengutronix.de smtp.mailfrom=s.hauer@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792148812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GXr3B92E2k2dyeJan3T3f83ODbQurRgLvjQKw7RXF4=;
	b=Yxpgavx0/pIXb8NW7Ebcb7+TliQaaFxWWOTliPl7TABpiqeGzwSbUui6TO438TeMrefOLz
	JxsFaQGDX9rfCbFQd1pI6/K7Wd4/gpazilkM/936v+GwEpqimADfSAq0I3wvohchOnuD2C
	4XHV+/xp6YEkEq6tXuSGNv698PwLUGDi3fVJJ339ChG3uSEVY4jANI/eYMQ/kWsvYEbX51
	uqdNEpXnY5cKEVTcbRIaPTw6WQlqqzN99q3WgecpPZraXT4SfZ5SklP4JEMgh5NUMiZTVE
	b6LTUmOuOUOZj9sQ1PD/DcHOnybSyogaHgTxMG51TgcAqkPZEkW8DnYandMvsQ==
Message-ID: <5b3592b1-74b4-43e6-96e8-a600b6fa991c@pengutronix.de>
From: "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 01/10] media: synopsys: hdmirx: free the driver data
 when the last user is gone
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Cc: "Sascha Hauer" <s.hauer@pengutronix.de>, "Mauro Carvalho Chehab" <mchehab@kernel.org>, "Hans
 Verkuil" <hverkuil@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Dingxian
 Wen" <shawn.wen@rock-chips.com>, "Shreeya Patel" <shreeya.patel@collabora.com>, "Gerald
 Loacker" <gerald.loacker@wolfvision.net>, "Lucas Sinn" <lucas.sinn@wolfvision.net>, linux-media@vger.kernel.org, devicetree@vger.kernel.org, kernel@collabora.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <647b6128-2bd1-40cb-86bb-d36e84378d93@collabora.com>
References: <20261005-hdmirx-media-v3-0-71a11a2e3e76@pengutronix.de>
 <20261005-hdmirx-media-v3-1-71a11a2e3e76@pengutronix.de>
 <647b6128-2bd1-40cb-86bb-d36e84378d93@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 11:06:52 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Hi Dmitry,

On 2026-10-07 14:20, Dmitry Osipenko wrote:
> On 10/5/26 16:28, Sascha Hauer wrote:
> > @@ -2792,16 +2807,13 @@ static void hdmirx_remove(struct platform_devic=
e *pdev)
> >  	hdmirx_disable_irq(dev);
> > =20
> >  	vb2_video_unregister_device(&hdmirx_dev->stream.vdev);
> > -	v4l2_ctrl_handler_free(&hdmirx_dev->hdl);
> >  	v4l2_device_unregister(&hdmirx_dev->v4l2_dev);
> > =20
> > -	/* touched by hdmirx_disable()->hdmirx_plugout() */
> > -	hdmirx_dev->rgb_range =3D NULL;
> > -	hdmirx_dev->content_type =3D NULL;
> > -
> >  	hdmirx_disable(dev);
> > =20
> >  	reset_control_bulk_assert(HDMIRX_NUM_RST, hdmirx_dev->resets);
> > +
> > +	v4l2_device_put(&hdmirx_dev->v4l2_dev);
> >  }
>=20
> This is uncommon v4l driver removal pattern, I suspect it's either not
> correct or needs to be fixed in the core code.

The pattern looks uncommon because many drivers in the tree are affected
by the same issue ;)

Just like many other drivers the hdmirx embeds a struct v4l2_device in
its private data struct which is allocated with devm_*, thus freed
during driver removal. With an opened file descriptor the video_device
outlives the driver removal, and v4l2_release(), called on
the last file descriptors close then references the already freed memory
via vdev->v4l2_dev

This is a long standing problem. See [1] for example for an attempt to
fix it in the core. It seems consencsus at that time was that it must be
fixed in the drivers which is what this patch does for the hdmirx.

[1] https://lore.kernel.org/all/20240610100530.1107771-1-sakari.ailus@linux=
.intel.com/

>=20
> What is the user-visible or sanitizer-visible problem? How to reproduce i=
t?

It can be reproduced with Kasan on affected drivers, below on the hdmirx
driver, but it should be reproducible like this on hantro and others as
well.

root@RK3588 CORE:~ exec 3</dev/video10
root@RK3588 CORE:~ echo fdee0000.hdmi_receiver > /sys/bus/platform/drivers/=
snps_hdmirx/unbind
root@RK3588 CORE:~ exec 3<&-
[   93.435616] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   93.435627] BUG: KASAN: slab-use-after-free in v4l2_release+0x258/0x3a0
[   93.435642] Read of size 8 at addr ffffff8106ae0428 by task sh/493
[   93.435647]
[   93.435652] CPU: 7 UID: 0 PID: 493 Comm: sh Tainted: G           O      =
  7.3.0-rc7-00345-g6e644a6aabaa #3 PREEMPT
[   93.435659] Tainted: [O]=3DOOT_MODULE
[   93.435662] Hardware name: WolfVision RK3588 CORE (DT)
[   93.435664] Call trace:
[   93.435666]  show_stack+0x24/0x38 (C)
[   93.435674]  dump_stack_lvl+0x70/0x98
[   93.435681]  print_report+0x160/0x4b8
[   93.435687]  kasan_report+0xb0/0x100
[   93.435693]  __asan_report_load8_noabort+0x34/0x48
[   93.435698]  v4l2_release+0x258/0x3a0
[   93.435703]  __fput+0x288/0x8b0
[   93.435709]  fput_close_sync+0xe8/0x248
[   93.435714]  __arm64_sys_close+0x78/0xd0
[   93.435718]  do_el0_svc+0x110/0x2e0
[   93.435723]  el0_svc+0x2c/0xa8
[   93.435729]  el0t_64_sync_handler+0xa0/0xe8
[   93.435734]  el0t_64_sync+0x15c/0x160
[   93.435738]
[   93.435740] Freed by task 493:
[   93.435743]  kasan_save_stack+0x40/0x68
[   93.435748]  kasan_save_track+0x24/0x40
[   93.435752]  kasan_save_free_info+0x58/0x90
[   93.435756]  __kasan_slab_free+0x78/0xa0
[   93.435760]  kfree+0x260/0x450
[   93.435765]  dr_node_free+0x20/0x40
[   93.435769]  release_nodes+0xf4/0x180
[   93.435771]  devres_release_all+0x100/0x1c0
[   93.435774]  device_unbind_cleanup+0x74/0x200
[   93.435779]  device_release_driver_internal+0x354/0x470
[   93.435783]  device_driver_detach+0x44/0x70
[   93.435786]  unbind_store+0xec/0x120
[   93.435790]  drv_attr_store+0x74/0xb8
[   93.435793]  sysfs_kf_write+0x178/0x210
[   93.435797]  kernfs_fop_write_iter+0x2dc/0x488
[   93.435802]  vfs_write+0x4f8/0xa30
[   93.435805]  ksys_write+0x100/0x1f0
[   93.435809]  __arm64_sys_write+0x78/0xb8
[   93.435813]  do_el0_svc+0x110/0x2e0
[   93.435816]  el0_svc+0x2c/0xa8
[   93.435820]  el0t_64_sync_handler+0xa0/0xe8
[   93.435824]  el0t_64_sync+0x15c/0x160
[   93.435827]
[   93.435828] The buggy address belongs to the object at ffffff8106ae0000
[   93.435828]  which belongs to the cache kmalloc-8k of size 8192
[   93.435832] The buggy address is located 1064 bytes inside of
[   93.435832]  freed 8192-byte region [ffffff8106ae0000, ffffff8106ae2000)
[   93.435836]
[   93.435838] The buggy address belongs to the physical page:
[   93.435841] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0=
x0 pfn:0x106ae0
[   93.435846] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0=
 pincount:0
[   93.435849] flags: 0x8000000000000040(head|zone=3D2)
[   93.435854] page_type: f5(slab)
[   93.435859] raw: 8000000000000040 ffffff8100003180 dead000000000122 0000=
000000000000
[   93.435863] raw: 0000000000000000 0000000000020002 00000000f5000000 0000=
000000000000
[   93.435866] head: 8000000000000040 ffffff8100003180 dead000000000122 000=
0000000000000
[   93.435869] head: 0000000000000000 0000000000020002 00000000f5000000 000=
0000000000000
[   93.435872] head: 8000000000000003 fffffffec41ab801 00000000ffffffff 000=
00000ffffffff
[   93.435875] head: 0000000000000000 0000000000000000 00000000ffffffff 000=
0000000000008
[   93.435877] page dumped because: kasan: bad access detected
[   93.435879]
[   93.435880] Memory state around the buggy address:
[   93.435882]  ffffff8106ae0300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[   93.435885]  ffffff8106ae0380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[   93.435887] >ffffff8106ae0400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[   93.435889]                                   ^
[   93.435891]  ffffff8106ae0480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[   93.435893]  ffffff8106ae0500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[   93.435895] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   93.435898] Disabling lock debugging due to kernel taint
[   93.435909] Unable to handle kernel paging request at virtual address df=
ffffc000000001
[   93.435913] KASAN: null-ptr-deref in range [0x0000000000000008-0x0000000=
00000000f]
[   93.435916] Mem abort info:
[   93.435918]   ESR =3D 0x0000000096000004
[   93.435920]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[   93.435923]   SET =3D 0, FnV =3D 0
[   93.435926]   EA =3D 0, S1PTW =3D 0
[   93.435928]   FSC =3D 0x04: level 0 translation fault
[   93.435931] Data abort info:
[   93.435933]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
[   93.435935]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[   93.435938]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0
[   93.435940] [dfffffc000000001] address between user and kernel address r=
anges
[   93.435945] Internal error: Oops: 0000000096000004 [#1]  SMP
[   93.472299] Modules linked in: aes_ce_ccm nf_log_syslog lt86102uxe(O) tp=
s6598x phy_rockchip_samsung_dcphy lt6911gxd(O) iwlmld ath11k_pci ath11k qmi=
_helpers btusb hantro_vpu rockchip_vdec btintel rockchip_jpegd snd_soc_hdmi=
_codec mac80211 rk_vcodec panthor dw_mipi_csi2rx v4l2_vp9 iwlwifi v4l2_jpeg=
 v4l2_h264 drm_gpuvm drm_exec cfg80211 fuse
[   93.474957] CPU: 7 UID: 0 PID: 493 Comm: sh Tainted: G    B      O      =
  7.3.0-rc7-00345-g6e644a6aabaa #3 PREEMPT
[   93.475868] Tainted: [B]=3DBAD_PAGE, [O]=3DOOT_MODULE
[   93.476279] Hardware name: WolfVision RK3588 CORE (DT)
[   93.476728] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   93.477336] pc : v4l2_release+0xbc/0x3a0
[   93.477681] lr : v4l2_release+0x258/0x3a0
[   93.478034] sp : ffffffc088837cc0
[   93.478325] x29: ffffffc088837cc0 x28: ffffff81150db900 x27: 1ffffff022a=
1b728
[   93.478952] x26: ffffff81150db940 x25: 1ffffff022a1b724 x24: ffffff81150=
db904
[   93.479578] x23: ffffff81011ee2d0 x22: ffffff81032a5400 x21: 00000000040=
a0019
[   93.480205] x20: ffffff81150db900 x19: ffffff8106ae0090 x18: ffffffc086e=
fd038
[   93.480831] x17: 3d3d3d3d3d3d3d3d x16: 3d3d3d3d3d3d3d3d x15: 3d3d3d3d3d3=
d3d3d
[   93.481458] x14: 3d3d3d3d3d3d3d3d x13: 0000000000000001 x12: 00000000000=
00001
[   93.482084] x11: 65756420676e6967 x10: ffffffb8108cd54d x9 : 1ffffff8108=
cd54c
[   93.482710] x8 : ffffffb8108cd54c x7 : dfffffc000000000 x6 : ffffffc0846=
6aa67
[   93.483336] x5 : 0000000000000001 x4 : ffffff8106ae0428 x3 : 1ffffff020d=
5c085
[   93.483962] x2 : dfffffc000000000 x1 : 0000000000000000 x0 : 00000000000=
00008
[   93.484588] Call trace:
[   93.484803]  v4l2_release+0xbc/0x3a0 (P)
[   93.485150]  __fput+0x288/0x8b0
[   93.485429]  fput_close_sync+0xe8/0x248
[   93.485768]  __arm64_sys_close+0x78/0xd0
[   93.486115]  do_el0_svc+0x110/0x2e0
[   93.486422]  el0_svc+0x2c/0xa8
[   93.486694]  el0t_64_sync_handler+0xa0/0xe8
[   93.487062]  el0t_64_sync+0x15c/0x160
[   93.487388] Code: d2dff802 f2fbffe2 91002020 d343fc05 (38e268a2)
[   93.487919] ---[ end trace 0000000000000000 ]---

--
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

