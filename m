Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC2B22B8AB
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782296665; cv=none; b=uoL7Z0XljNPogeoRiOnJgd6k6YkIoOBjFq3ePmauForDVgMYjTRSjlTpFfRIyaaBuD2T8+pUKDyJAhlOzFn1Cf2PjvODTRs+nmI0yS8d2sMoLgtv7TkN5nEAZ8D5+aiYCssCC8fXMADtrePo6ijDnUVcCkJrjfNR+CNAImjxohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782296665; c=relaxed/simple;
	bh=OUUsz/rpfkh41d2WBLP9eBgUftp+R0FXlnvQcqi9ovg=;
	h=Content-Type:Date:Message-Id:Subject:From:Cc:To:Mime-Version; b=gJrbaJkVtonpbLw2dQnsCj+nVFfdEwEqUZgsKPxg8SqhZxfCFezRSzHc+S6+PO9gtL58w7Ypo932Yvox14emVbYfzp1jea5YtnRmIupVwcnBy5CzL/b8LpFwm6hfFiqarBkU2NSWYtb+9E7g9pJcrhHhqEWrWGkbQRcXR5ihsTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=txYeW/oJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="txYeW/oJ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso8698755e9.3
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 03:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1782296662; x=1782901462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:to:cc:from:subject
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=psMCbfiKmo+4NN+mu9QSDkmE7/mlMaDSUmmzTMO3/gc=;
        b=txYeW/oJqCtC4stirHGFs7jlyNXt9XNY1415VRi9x/6h9+A3/nJAEpRstWuHifacac
         wZjo7NV8CqzgetCXiheMxn53PZQxLFaH/ue7WfGs/MmLiLcNDCt9tLmXtzJKJQCpBii4
         s/hbJfwGnAc+70gd9/mLGJFdbpbRUZZJ5Ighw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782296662; x=1782901462;
        h=content-transfer-encoding:mime-version:to:cc:from:subject
         :message-id:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psMCbfiKmo+4NN+mu9QSDkmE7/mlMaDSUmmzTMO3/gc=;
        b=nzXdg4fn/e1qt3vL1Wh95+KZeFfEOyHb8g4IEY7+DgGVijoPwKScDig51OyYJV1gdX
         w17IkWzEitdiPI0tbRPFrvOzV2vzUPEBFIUeG75eR8u2QA1FaHzmVqXsPdNOkStqG4VE
         jeetltmqrSp2LgDoj1YBsP0MB/lRpEW7Wi7/1ijLvMUn+RFQQrJIDzZcVI9NlqTno1zt
         48lv7fW2UzFjNG/Vrxx4r40eor9gLIbd0LSQWHJQndOyZ0M1rez26wMIWEzm4YwD/RO7
         ejk/j+rWyYm/jM5V3XqYUbaqg6WPcjpUFoQ1u9ePafr4OZjTd0ycfNfpLDLpVjODjI49
         /o4Q==
X-Gm-Message-State: AOJu0YzFSnAEe4MLFJ7wkOiizpDxf+K29j0GF5P4MoyEhAEf+C6YzJkb
	uV1iB1vTHLHJXVeSZmWLOsIOMX3Ig9FMaB931gAdJDCjaC3RRpjmJO3xXs9aKpcUVQnFbol69QO
	K7ZJG
X-Gm-Gg: AfdE7cnHU/jvulzRo9R+0u1pDifFXNFG1yGUZWBNGsjc/3qtvDoCVn1LDs1/D6RF89A
	gxFfdEyTWJFeliRRf0DEMdfkemLJ4FYtB2MceXPZSKj0cUGkusAf/eJ2/1FQWeRSeU0A3tDLHy+
	T3GBFTJGCqhi71BJPHatJp3Mako00Y7YyC6STNpBihIhi20Fo1O9CSMi0SuwgS4fYNuB+29kXrx
	sPzjp88r+b5H7EkRlrNbkm/xTCwd255laXa3ixC+ZS7m6/0eS5Kvi4HPYkrNdynz1mVeVnQI1/b
	ANl3HNuERnpCRHfWNqpgr31hA72CdnAsdhmghrPwMXIv0aUrE7WSU0JyTJm9LmX5RD5b1iza5ur
	6jpYfsXtsv9lMGm82ugIXwhs5dL5HJ7G7T4rsf4nT9NJEh+Q0G1Jlntrt4gK0sPCQXcCnZKcmz9
	bqS2RrXjMGpv+7O97RmUHUX2Uw4paXjFpRaP0cnf7O2mm3iTXbKLAKS4WBETTPbT6VCZn0ekYG0
	AEo5A==
X-Received: by 2002:a05:600c:3501:b0:490:bad9:de43 with SMTP id 5b1f17b1804b1-492608fa418mr31527155e9.0.1782296661935;
        Wed, 24 Jun 2026 03:24:21 -0700 (PDT)
Received: from localhost (2a01cb001331aa00f2ebd4aef93feb0a.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:f2eb:d4ae:f93f:eb0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492609154cdsm40143165e9.1.2026.06.24.03.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 03:24:21 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 12:24:21 +0200
Message-Id: <DJH7FQUH9KQI.N8NISCQILPH8@smile.fr>
Subject: [RESEND] "ext4: get rid of ppath in get_ext_path()" 6.6.y backport
 request
From: "Yoann Congal" <yoann.congal@smile.fr>
Cc: "Baokun Li" <libaokun1@huawei.com>, "Jan Kara" <jack@suse.cz>, "Ojaswin
 Mujoo" <ojaswin@linux.ibm.com>, "Theodore Ts'o" <tytso@mit.edu>, "Andreas
 Dilger" <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
To: <stable@vger.kernel.org>
Received: from localhost
 (2a01cb001331aa00f2ebd4aef93feb0a.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1331:aa00:f2eb:d4ae:f93f:eb0a]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46caad603b3sm1938065f8f.7.2026.06.24.02.25.07 for
 <stable@vger.kernel.org> (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256
 bits=128/128); Wed, 24 Jun 2026 02:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.0

Hello,

(Resent with developers/maintainers of the patch in CC)

I'd like to request the backport of
6b854d552711 ("ext4: get rid of ppath in get_ext_path()")
on the 6.6.y branch.

Rational:
6.6.130 commit fb138df7d886 ("ext4: get rid of ppath in ext4_ext_insert_ext=
ent()")
created a regression in ext4_ext_map_blocks() by changing the path value
under error (NULL -> ERR_PTR). But path is only checked for NULL value
in ext4_free_ext_path (not ERR_PTR).

The check is added in 6b854d552711 ("ext4: get rid of ppath in get_ext_path=
()"),
hence this backport request.

More details:
This regression was triggered during LTP test on a 6.6.129->6.6.142
upgrade for a Yocto Project stable branch:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/98/builds/3837
-> https://valkyrie.yocto.io/pub/non-release/20260622-121/testresults/qemua=
rm64-ltp/core-image-sato/qemu_boot_log.20260623002740

[ 6952.500858] Unable to handle kernel paging request at virtual address ff=
ffffffffffffec
[ 6952.503768] Mem abort info:
[ 6952.504431]   ESR =3D 0x0000000096000005
[ 6952.505333]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[ 6952.506541]   SET =3D 0, FnV =3D 0
[ 6952.507354]   EA =3D 0, S1PTW =3D 0
[ 6952.508154]   FSC =3D 0x05: level 1 translation fault
[ 6952.509208] Data abort info:
[ 6952.509849]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
[ 6952.511175]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[ 6952.512372]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[ 6952.513667] swapper pgtable: 4k pages, 39-bit VAs, pgdp=3D00000000412500=
00
[ 6952.514909] [ffffffffffffffec] pgd=3D0000000000000000, p4d=3D00000000000=
00000, pud=3D0000000000000000
[ 6952.516423] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
[ 6952.517503] Modules linked in: x_tables tun loop [last unloaded: ip6_tab=
les]
[ 6952.518691] CPU: 1 PID: 1078 Comm: kworker/u12:1 Tainted: G        W    =
      6.6.142-yocto-standard #1
[ 6952.520269] Hardware name: linux,dummy-virt (DT)
[ 6952.521094] Workqueue: writeback wb_workfn (flush-7:0)
[ 6952.521985] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[ 6952.523184] pc : ext4_ext_map_blocks+0x260/0x1860
[ 6952.524011] lr : ext4_ext_map_blocks+0xdb8/0x1860
[ 6952.524851] sp : ffffffc086a3b620
[ 6952.525421] x29: ffffffc086a3b740 x28: ffffffffffffffe4 x27: 00000000000=
0808c
[ 6952.526624] x26: ffffff8017dd9000 x25: 000000000000808c x24: 00000000000=
00002
[ 6952.527849] x23: ffffff8035e766c8 x22: ffffff802e589690 x21: 00000000000=
0042f
[ 6952.529087] x20: ffffffc086a3b948 x19: ffffff8035e767f0 x18: 00000000000=
00000
[ 6952.530310] x17: ffffffc081691310 x16: fffffffe001ab548 x15: 0000005564d=
4cb48
[ 6952.531519] x14: 00000000ffffffff x13: 0000000000000000 x12: fffffffffff=
fffc0
[ 6952.532683] x11: 0000000000000040 x10: ffffff8005d81d80 x9 : ffffffc0803=
cce14
[ 6952.533886] x8 : 00000000bab647bc x7 : 0000000000000000 x6 : 00000000000=
0d847
[ 6952.535065] x5 : 0000000000000000 x4 : 0000000000316019 x3 : 00000000000=
00000
[ 6952.536264] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff803de=
ec880
[ 6952.537425] Call trace:
[ 6952.537860]  ext4_ext_map_blocks+0x260/0x1860
[ 6952.538589]  ext4_map_blocks+0x19c/0x598
[ 6952.539258]  ext4_do_writepages+0x5a4/0xbe0
[ 6952.539977]  ext4_writepages+0x84/0x110
[ 6952.540624]  do_writepages+0x94/0x1e0
[ 6952.541240]  __writeback_single_inode+0x60/0x4d8
[ 6952.542086]  writeback_sb_inodes+0x208/0x4b0
[ 6952.542812]  __writeback_inodes_wb+0x58/0x118
[ 6952.543578]  wb_writeback+0x274/0x440
[ 6952.544198]  wb_workfn+0x3b0/0x5c8
[ 6952.544788]  process_one_work+0x16c/0x3e0
[ 6952.545434]  worker_thread+0x1b4/0x378
[ 6952.546059]  kthread+0x118/0x128
[ 6952.546599]  ret_from_fork+0x10/0x20
[ 6952.547197] Code: 2a0103f9 b9009fe1 b9000e99 b40055fc (79401398)
[ 6952.548170] ---[ end trace 0000000000000000 ]---
[ 6952.551090] ------------[ cut here ]------------

Reading the resulting code in 6.6.142:
fs/ext4/extents.c:
int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
			struct ext4_map_blocks *map, int flags)
{
	struct ext4_ext_path *path =3D NULL;
	// ...

got_allocated_blocks:
	path =3D ext4_ext_insert_extent(handle, inode, path, &newex, flags);
	if (IS_ERR(path)) {
		err =3D PTR_ERR(path);
		/*
		 * Gracefully handle out of space conditions. If the filesystem
		 * is inconsistent, we'll just leak allocated blocks to avoid
		 * causing even more damage.
		 */
		// ...
		goto out;
	}

	// ...
out:
	ext4_free_ext_path(path);

	trace_ext4_ext_map_blocks_exit(inode, flags, map,
				       err ? err : allocated);
	return err ? err : allocated;
}

=3D> Under out of space condition (what LTP does a *LOT*): path is given un=
modified to
ext4_free_ext_path() that only does a NULL check (no IS_ERR) before
dereferencing it. And that produces the oops and then, the LTP failure.

Notably, master commit 6b854d552711 ("ext4: get rid of ppath in get_ext_pat=
h()")
never got backported to 6.6.y. But does add the IS_ERR_OR_NULL() check
to ext4_free_ext_path:
 void ext4_free_ext_path(struct ext4_ext_path *path)
 {
+       if (IS_ERR_OR_NULL(path))
+               return;

Thanks!
--=20
Yoann Congal
Smile ECS
