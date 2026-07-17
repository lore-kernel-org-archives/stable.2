Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69232F25F3;
	Fri, 17 Jul 2026 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308008; cv=none; b=B/vp2/3/VXI5DKxoVMUXJj93CvD7G6JwsJ/1G3GD7bYwSCQlJSKTIQrcO4q937bRHjZnipxYkT+e/ABZczexLwB/Rx8W2Kdx6zcIhN93nk402xc1saRBDRAixy42tBJ3SDQRKET73xlbBmlml1Pg2SsSUOP4zbKKdgOzmMKHUlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308008; c=relaxed/simple;
	bh=ATAuCtRgTI47ab/4i/ehtkuSuuifYx0O+tpApZ8SsTc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BtEDl++YefKZZdiabakuYvqFYNS5FPNUsCeA8HFTDX0vShCboOYBirF33kC1M7mwVys0zG5KAUfatuyLZrc8EK8BA6PPKVv8J7h0aT/NS3wbdRrt3rboBe6srOzoVVak4C9EUbsvQxxEJhg4c4W3kbfhI7L/At0SgkS+6/hR4vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.100])
	by APP-05 (Coremail) with SMTP id zQCowABXiEIWYVpqwLcMAA--.14167S2;
	Sat, 18 Jul 2026 01:06:31 +0800 (CST)
Message-ID: <9a55a96b53c5f88bc1e079945b710ee854471ee3.camel@iscas.ac.cn>
Subject: Re: [PATCH v2] drm/imagination: acquire vm_ctx->lock before mapping
 memory to GPU VM
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Alessio Belle <Alessio.Belle@imgtec.com>
Cc: "airlied@gmail.com" <airlied@gmail.com>, "tzimmermann@suse.de"	
 <tzimmermann@suse.de>, "matt.coster@imgtec.com" <matt.coster@imgtec.com>, 
 "simona@ffwll.ch"	 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"	
 <dri-devel@lists.freedesktop.org>, Brendan King <Brendan.King@imgtec.com>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>, Frank Binns
 <Frank.Binns@imgtec.com>,  Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,  "dakr@kernel.org"	
 <dakr@kernel.org>, "maarten.lankhorst@linux.intel.com"	
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>
Date: Sat, 18 Jul 2026 01:06:30 +0800
In-Reply-To: <164ad51d357350cde4e9e84cbe1ebc970c871af7.camel@imgtec.com>
References: <20260714073641.1935075-1-zhengxingda@iscas.ac.cn>
	 <164ad51d357350cde4e9e84cbe1ebc970c871af7.camel@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:zQCowABXiEIWYVpqwLcMAA--.14167S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw15ArykCrW8CF43tFy8AFb_yoW5trWkp3
	yfKa4Ykw40krWqy3W7t3yYkry3Aw4F9a1fGFyktas5Zr15Wrnrtr1Fqry5uFyDArs7Gw47
	tF4qva9ag34jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUqiFxDUUUU
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/

=E5=9C=A8 2026-07-17=E4=BA=94=E7=9A=84 11:14 +0000=EF=BC=8CAlessio Belle=E5=
=86=99=E9=81=93=EF=BC=9A
> On Tue, 2026-07-14 at 15:36 +0800, Icenowy Zheng wrote:
> > The drm gpuvm code doesn't protect find operation against map
> > operation,
> > and the driver needs to ensure a map operation shouldn't happen
> > when a
> > find operation is in progress.
> >=20
> > In some cases a find operation will be in progress when doing
> > map/unmap
> > operations, and the find operation will do a NULL pointer
> > deference.
> >=20
> > An example of the stack trace of such NULL deference is shown
> > below:
> >=20
> > ```
> > Unable to handle kernel access to user memory without uaccess
> > routines at
> > virtual address 0000000000000010
> >=20
> > [<ffffffff01e989d4>] drm_gpuva_find+0x28/0x6c [drm_gpuvm]
> > [<ffffffff01ed3a40>] pvr_vm_unmap+0x34/0x68 [powervr]
> > [<ffffffff01ec69da>] pvr_ioctl_vm_unmap+0x2e/0x50 [powervr]
> > [<ffffffff8080ce0a>] drm_ioctl_kernel+0x8e/0xdc
> > [<ffffffff8080d016>] drm_ioctl+0x1be/0x3e0
> > [<ffffffff802bec3e>] __riscv_sys_ioctl+0xba/0xc4
> > [<ffffffff80d858b2>] do_trap_ecall_u+0x23e/0x3f4
> > [<ffffffff80d92288>] handle_exception+0x168/0x174
> > ```
> >=20
> > As all occurences of drm_gpuva_find*() are already guarded by
> > vm_ctx->lock, make pvr_vm_map() to acquire this lock to prevent
> > disturbing any find operation. This fixes the NULL deference
> > problem in
> > drm_gpuva_find*().
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related
> > code")
> > Fixes: 4bc736f890ce ("drm/imagination: vm: make use of GPUVM's
> > drm_exec helper")
> > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
>=20
> Reviewed-by: Alessio Belle <alessio.belle@imgtec.com>
>=20
> p.s. there's a double typo deference -> dereference that I can fix
> before
> applying this early next week.

Oops I made the same mistake again when rephrasing the message...

Maybe I need some reinforced learning.

Thanks,
Icenowy

>=20
> Thanks,
> Alessio
>=20
> > ---
> > Changes in v2:
> > - Dropped wrongly duplicated mutex_unlock() call and reordered it
> > to
> > =C2=A0 before pvr_vm_bind_op_fini() (the lock is acquired after
> > =C2=A0 pvr_vm_bind_op_map_init() call). (Thanks to Brajesh)
> > - Added a extra Fixes pointing to the original broken code that was
> > =C2=A0 refactored by the original Fixes (but still broken). (Thanks to
> > =C2=A0 Alessio)
> > - Fixed some typos in commit message. (Thanks to Alessio)
> > - Added a stacktrace of the oops that occured on my board. (As
> > suggested
> > =C2=A0 by Alessio)
> >=20
> > =C2=A0drivers/gpu/drm/imagination/pvr_vm.c | 2 ++
> > =C2=A01 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/imagination/pvr_vm.c
> > b/drivers/gpu/drm/imagination/pvr_vm.c
> > index 396d349fb6ce4..ceb78694cd987 100644
> > --- a/drivers/gpu/drm/imagination/pvr_vm.c
> > +++ b/drivers/gpu/drm/imagination/pvr_vm.c
> > @@ -747,6 +747,7 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx,
> > struct pvr_gem_object *pvr_obj,
> > =C2=A0
> > =C2=A0	pvr_gem_object_get(pvr_obj);
> > =C2=A0
> > +	mutex_lock(&vm_ctx->lock);
> > =C2=A0	err =3D drm_gpuvm_exec_lock(&vm_exec);
> > =C2=A0	if (err)
> > =C2=A0		goto err_cleanup;
> > @@ -756,6 +757,7 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx,
> > struct pvr_gem_object *pvr_obj,
> > =C2=A0	drm_gpuvm_exec_unlock(&vm_exec);
> > =C2=A0
> > =C2=A0err_cleanup:
> > +	mutex_unlock(&vm_ctx->lock);
> > =C2=A0	pvr_vm_bind_op_fini(&bind_op);
> > =C2=A0
> > =C2=A0	return err;

