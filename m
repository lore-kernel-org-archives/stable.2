Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E7323815B
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294256; cv=none; b=poTIIdOq5fna+r8AptWz/ZcjLE+rJHb31pvp2lsNPhjFAxvlPfhiijsVZhU7EhJTosbPtGM0pXpCtj1/ouveKYZwsXHpKQHhsPpYPSIBbJ2X/IETlu0RmVN8XVj8BxCw7VMBy/FTqmonXfNh6g8sZeQAbaZsvCA2KSHIOtg7dxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294256; c=relaxed/simple;
	bh=aATK1sEVFfEN1flToVMo+gLb4O8j9U5pRQp9S7eNg24=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:Subject:From:
	 References:In-Reply-To; b=FhIwrYOVdeCkK46WoD3gSE9X213LtsySa9sgZ3N3ro23i147lpE+Y5sXknPjcqoJ8JsXpen69H3vIFetWozEapeHLPobC2v9vz7NgMKd/0fxrqyZpsJgUIOiqtBUK1Ns0Zo9SqJa6NK7dS9f25WWmfRrkoGxd4hDNSD1Eps37Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=1G2wrf5M; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="1G2wrf5M"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49230a567a9so3453665e9.0
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 02:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1782294253; x=1782899053; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0akH757bDLYysV6YFfPe/LFBwtkplHQTrN4WH0R5ZzQ=;
        b=1G2wrf5MSJUGvibsVi7eGV+p0SEMfIT37Evgir36x14628nOshcQymPe+j0vtUnqKY
         p4WtV9QsQeavrUI+2tWKewqvoq42Q6TREFBRk92Cqa43MknrLjQ+nuJ7E3aUEhR6I2m8
         9WWPOcARS9vZ0HcsqXkkm1cTKYJkRIRoGMBgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782294253; x=1782899053;
        h=in-reply-to:references:from:subject:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0akH757bDLYysV6YFfPe/LFBwtkplHQTrN4WH0R5ZzQ=;
        b=Wo4Rxj+kHXPX6Si91w7n1niunoHMKw1GTTwZGbRpxK3JPVKfzZ+pZzCTuXH1+m5rrI
         2qGCXf3hep1L/GLh37X8d8Wwqt/aFTFJ6Xh7uP9WlPGKV1eNybHy/+p3zQcwWUqGByFI
         wnaxpa/x1RV5zyn9OR93tUlOXLNd2GSAozQ5oCp1FQeY+Vm7nQumlxWuCihk1mBe5V/S
         QqkssCgNpp895CzW0jznYB6tGYG+mtvi0xS6qfmdgNQ+ry4hu++5F/+BR8r3k8C4lU2b
         JAjVRqqcqorLAYTZUNFib9MU6wT8y5QgnE0XFMk15l+QVc+c0ETaxqWht32r2+b27UA5
         wSXg==
X-Gm-Message-State: AOJu0Yx8POCmwBwLwueln2Tlxcgwsdp5te2AFhiq/ZYY8S34hqiwzMMY
	pdCHvk4Df4jUw82lsojX9KVVglb34F7jOnFxoPW4grHW2xVVW8L1jiUy2gkveZ/NYsx/yxU4AFl
	1n/V2
X-Gm-Gg: AfdE7ckFY1HvCsoLOtNwZw2JPskAhugtXF0U/R2Y8P4pxAWwQopR+Cw7T7v3tcK/0zo
	hh3LmuBy5d65AbPOc4WIdGCQwXAZ+HeHBpSonpNh93AyVLpuqKIebT2EO6kEnytGVCjLjEBylic
	I82GBXlfdp4N7p1tRSmYZNdo5Ki9tjmRh7Rq0+icjXtjz/xDO3LNEx2wlIoVMdmmC+6nuEFIfPr
	MtxPTWAt43Tpb1vIvrZahX1kqQ77MxZHW5twhESZD4XaKC+o4zWDrKctyjGA6wDyH53brVGL0Mo
	o+gMYrbKDv/mNIy/BfHxqiVUHExt3eZyrHu2bL7Rvz8H2wg8geWxawyUHmfVE+nFQLjxc7H44jq
	OIdGq3NcaC21pi4rMbIZNXwxnFVPbYtLLHGITS5lKJTwHPS9E1oviT95XsGyTnNDMUwaK+NEamN
	PQXELuWJu5spUCNXU+JexjZ4owtgKhmvY+ONX8Bgg4xFG/gZVz6ccgDP073U4lwP4rWSBsv+u9b
	1OAdw==
X-Received: by 2002:a05:600c:4512:b0:490:3d62:f5e1 with SMTP id 5b1f17b1804b1-4926087280cmr32835515e9.22.1782294253390;
        Wed, 24 Jun 2026 02:44:13 -0700 (PDT)
Received: from localhost (2a01cb001331aa00f2ebd4aef93feb0a.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:f2eb:d4ae:f93f:eb0a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee01d51sm4173539f8f.15.2026.06.24.02.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 02:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 11:44:12 +0200
Message-Id: <DJH6L0GAH8GW.2B0XOOOLUDTP0@smile.fr>
Cc: <stable@vger.kernel.org>
To: "Greg KH" <greg@kroah.com>
Subject: Re: "ext4: get rid of ppath in get_ext_path()" 6.6.y backport
 request
From: "Yoann Congal" <yoann.congal@smile.fr>
X-Mailer: aerc 0.20.0
References: <DJH66E0ZKMBD.RJREJPRY6MMD@smile.fr>
 <2026062418-upswing-scabby-0f83@gregkh>
In-Reply-To: <2026062418-upswing-scabby-0f83@gregkh>

On Wed Jun 24, 2026 at 11:38 AM CEST, Greg KH wrote:
> On Wed, Jun 24, 2026 at 11:25:06AM +0200, Yoann Congal wrote:
>> Hello,
>>=20
>> I'd like to request the backport of
>> 6b854d552711 ("ext4: get rid of ppath in get_ext_path()")
>> on the 6.6.y branch.
>>=20
>> Rational:
>> 6.6.130 commit fb138df7d886 ("ext4: get rid of ppath in ext4_ext_insert_=
extent()")
>> created a regression in ext4_ext_map_blocks() by changing the path value
>> under error (NULL -> ERR_PTR). But path is only checked for NULL value
>> in ext4_free_ext_path (not ERR_PTR).
>>=20
>> The check is added in 6b854d552711 ("ext4: get rid of ppath in get_ext_p=
ath()"),
>> hence this backport request.
>>=20
>> More details:
>> This regression was triggered during LTP test on a 6.6.129->6.6.142
>> upgrade for a Yocto Project stable branch:
>> https://autobuilder.yoctoproject.org/valkyrie/#/builders/98/builds/3837
>> -> https://valkyrie.yocto.io/pub/non-release/20260622-121/testresults/qe=
muarm64-ltp/core-image-sato/qemu_boot_log.20260623002740
>>=20
>> [ 6952.500858] Unable to handle kernel paging request at virtual address=
 ffffffffffffffec
>> [ 6952.503768] Mem abort info:
>> [ 6952.504431]   ESR =3D 0x0000000096000005
>> [ 6952.505333]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>> [ 6952.506541]   SET =3D 0, FnV =3D 0
>> [ 6952.507354]   EA =3D 0, S1PTW =3D 0
>> [ 6952.508154]   FSC =3D 0x05: level 1 translation fault
>> [ 6952.509208] Data abort info:
>> [ 6952.509849]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
>> [ 6952.511175]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>> [ 6952.512372]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
>> [ 6952.513667] swapper pgtable: 4k pages, 39-bit VAs, pgdp=3D00000000412=
50000
>> [ 6952.514909] [ffffffffffffffec] pgd=3D0000000000000000, p4d=3D00000000=
00000000, pud=3D0000000000000000
>> [ 6952.516423] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>> [ 6952.517503] Modules linked in: x_tables tun loop [last unloaded: ip6_=
tables]
>> [ 6952.518691] CPU: 1 PID: 1078 Comm: kworker/u12:1 Tainted: G        W =
         6.6.142-yocto-standard #1
>> [ 6952.520269] Hardware name: linux,dummy-virt (DT)
>> [ 6952.521094] Workqueue: writeback wb_workfn (flush-7:0)
>> [ 6952.521985] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTY=
PE=3D--)
>> [ 6952.523184] pc : ext4_ext_map_blocks+0x260/0x1860
>> [ 6952.524011] lr : ext4_ext_map_blocks+0xdb8/0x1860
>> [ 6952.524851] sp : ffffffc086a3b620
>> [ 6952.525421] x29: ffffffc086a3b740 x28: ffffffffffffffe4 x27: 00000000=
0000808c
>> [ 6952.526624] x26: ffffff8017dd9000 x25: 000000000000808c x24: 00000000=
00000002
>> [ 6952.527849] x23: ffffff8035e766c8 x22: ffffff802e589690 x21: 00000000=
0000042f
>> [ 6952.529087] x20: ffffffc086a3b948 x19: ffffff8035e767f0 x18: 00000000=
00000000
>> [ 6952.530310] x17: ffffffc081691310 x16: fffffffe001ab548 x15: 00000055=
64d4cb48
>> [ 6952.531519] x14: 00000000ffffffff x13: 0000000000000000 x12: ffffffff=
ffffffc0
>> [ 6952.532683] x11: 0000000000000040 x10: ffffff8005d81d80 x9 : ffffffc0=
803cce14
>> [ 6952.533886] x8 : 00000000bab647bc x7 : 0000000000000000 x6 : 00000000=
0000d847
>> [ 6952.535065] x5 : 0000000000000000 x4 : 0000000000316019 x3 : 00000000=
00000000
>> [ 6952.536264] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff80=
3deec880
>> [ 6952.537425] Call trace:
>> [ 6952.537860]  ext4_ext_map_blocks+0x260/0x1860
>> [ 6952.538589]  ext4_map_blocks+0x19c/0x598
>> [ 6952.539258]  ext4_do_writepages+0x5a4/0xbe0
>> [ 6952.539977]  ext4_writepages+0x84/0x110
>> [ 6952.540624]  do_writepages+0x94/0x1e0
>> [ 6952.541240]  __writeback_single_inode+0x60/0x4d8
>> [ 6952.542086]  writeback_sb_inodes+0x208/0x4b0
>> [ 6952.542812]  __writeback_inodes_wb+0x58/0x118
>> [ 6952.543578]  wb_writeback+0x274/0x440
>> [ 6952.544198]  wb_workfn+0x3b0/0x5c8
>> [ 6952.544788]  process_one_work+0x16c/0x3e0
>> [ 6952.545434]  worker_thread+0x1b4/0x378
>> [ 6952.546059]  kthread+0x118/0x128
>> [ 6952.546599]  ret_from_fork+0x10/0x20
>> [ 6952.547197] Code: 2a0103f9 b9009fe1 b9000e99 b40055fc (79401398)
>> [ 6952.548170] ---[ end trace 0000000000000000 ]---
>> [ 6952.551090] ------------[ cut here ]------------
>>=20
>> Reading the resulting code in 6.6.142:
>> fs/ext4/extents.c:
>> int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>> 			struct ext4_map_blocks *map, int flags)
>> {
>> 	struct ext4_ext_path *path =3D NULL;
>> 	// ...
>>=20
>> got_allocated_blocks:
>> 	path =3D ext4_ext_insert_extent(handle, inode, path, &newex, flags);
>> 	if (IS_ERR(path)) {
>> 		err =3D PTR_ERR(path);
>> 		/*
>> 		 * Gracefully handle out of space conditions. If the filesystem
>> 		 * is inconsistent, we'll just leak allocated blocks to avoid
>> 		 * causing even more damage.
>> 		 */
>> 		// ...
>> 		goto out;
>> 	}
>>=20
>> 	// ...
>> out:
>> 	ext4_free_ext_path(path);
>>=20
>> 	trace_ext4_ext_map_blocks_exit(inode, flags, map,
>> 				       err ? err : allocated);
>> 	return err ? err : allocated;
>> }
>>=20
>> =3D> Under out of space condition (what LTP does a *LOT*): path is given=
 unmodified to
>> ext4_free_ext_path() that only does a NULL check (no IS_ERR) before
>> dereferencing it. And that produces the oops and then, the LTP failure.
>>=20
>> Notably, master commit 6b854d552711 ("ext4: get rid of ppath in get_ext_=
path()")
>> never got backported to 6.6.y. But does add the IS_ERR_OR_NULL() check
>> to ext4_free_ext_path:
>>  void ext4_free_ext_path(struct ext4_ext_path *path)
>>  {
>> +       if (IS_ERR_OR_NULL(path))
>> +               return;
>>=20
>> Thanks!
>
> Please always cc: the maintainers and developers involved in a patch
> when asking for it to be backported, as we need their approval as well
> before we can do it.

Ok, sorry, I'll resend with proper CCs.

Thanks!

>
> thanks,
>
> greg k-h


--=20
Yoann Congal
Smile ECS

