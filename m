Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389335;
	b=MPmn/HeA+wG1MPbLK5w8Sa0o/fZF0THImZS6IAnEgerqjJWzJI+RHx+R/E5iPqQDxOG8
	 +jt/G1eMaZZXMpxIqYxgt+PnkfYtE1C95wG7uHDxj0JTYAbyOJ2S1wEV1vSGbdPdaq4dd
	 Aof21pA+Oc58Q/mOLQdKpAUI2Cuwui48Zfgl2BhyG38vXRMODCZ1rY/gwl1OPf58n0AhZ
	 k71eqL3aOW9jQMX1HVDMzf8AdQhai2ninPyKrIY8N5pQrSzBRDGkEyuG5JstfIFUm0rc5
	 Z9aBFj9T/TDchlhIn2uX0CBcWZLty2AIfTEp0iqL196iiu0o6pI32A60niAUyjKtgCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389335;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qlD+cGMr3wTaXsI1Ws5nhCy30FUV4lzPs8nNTVDf9yE=;
	b=K5ELVmvvCddnAR7C7tHU7sWdeOw3a8lXxI0vHz8SLjTZUPIAAGweyVRD+7JHDr2Vp5K3
	 VwELYB/mTbEEfJdAnm9ufMVLCsbgiPQsLdHbF1HM6hJ6a6CtyjoSihzXwcSvqeUac6/vg
	 Y9IKjtv4CquW7HaiY4MfazNS1E/kF4zokK3Xi/GLf5IuoTev8bzCf6eKuG/CVzN74zgmo
	 xa18E2lWSJej3XUprLRx6ctoxZcPI7ASlcOzfyFA9oxQzsOk+qKWtdJY/HydaLdGBpUD7
	 b+owFnmLTDbWwax0K/4FywGZ5nN9cBFK+OR6KTG2Z0GGmBfor7Iyb9V4YdwSp2/DBfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=KGvkreVk;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6195606A326;
	Wed, 11 Nov 2026 09:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6195606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=KGvkreVk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=qlD+cGMr3wTaXsI1Ws5nhCy30FUV4lzPs8nNTVDf9yE=; t=1794389333; x=2109749333; 
	b=KGvkreVk3y/NZQiHhQdKDUE4ak2av/Y/3wHv/idBGrh4r/T/GZrbV7C/93NskhTtqPk0HiaGKEp
	B/XGT/k8YaSCxfxynDWEo/JP9NAsmcQWJJ9jQsVV/8K8Bqk8ssHApeFXt2Qa1+G/ebpWEfln2b3p9
	FAMk2PuHgddWU1pqZS84lhU8n7t6LkJxT9yASGsJT1eZ98hcrCsHOQ7N+Ril7BRyV7pKJP4h27rTQ
	2+rMf2gNSzDxVeC8UC2rJvLsdYQIBPMvSu1sau0zTCZGIQh6BnTgVbvI6OCJD84u8FGSum57l9kQa
	ZfuoWf0FzJqXgnh3UomdWTwy9LRHjIc0vgNg==;
Received: from [188.250.79.109] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xR4dN-008h3G-CK; Wed, 11 Nov 2026 10:28:49 +0100
From: Luis Henriques <luis@igalia.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  fuse-devel@lists.linux.dev,
  linux-kernel@vger.kernel.org,  Miklos Szeredi <mszeredi@redhat.com>,
  stable@vger.kernel.org
Subject: Re: [PATCH] fuse: defer dentry_tree_work until fuse_dentry_tree_init()
In-Reply-To: <20261110150250.71520-1-ekffu200098@gmail.com>
References: <20261110150250.71520-1-ekffu200098@gmail.com>
Date: Wed, 11 Nov 2026 09:30:31 +0000
Message-ID: <87cxsbg1fs.fsf@igalia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11 2026, Sang-Heon Jeon wrote:

> inval_wq_set() schedules dentry_tree_work when inval_wq is enabled.
>
> But inval_wq_set() can be called at boot or module load before
> fuse_dentry_tree_init() initializes the work, so __queue_delayed_work()
> warns and the work never starts.
>
> So defer scheduling the work until fuse_dentry_tree_init() sets it up.
>
> Fixes: ab84ad597386 ("fuse: new work queue to periodically invalidate exp=
ired dentries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
> QEMU based test result
> - booted with "fuse.inval_wq=3D5"

Thank you, Sang-Heon.  I've sent a fix for this already[1], but sashiko
still has some race complains which I haven't looked into yet.  But maybe
Miklos is happier with your patch, in which case you can add my

Reviewed-by: Luis Henriques <luis@igalia.com>

[1] https://lore.kernel.org/20261106155512.24801-1-luis%40igalia.com

Cheers,
--=20
Lu=C3=ADs

> 1) AS-IS (before fix)
> [    0.011073] Kernel command line: rootwait root=3D/dev/vda console=3Dtt=
y1 console=3DttyS0 nokaslr  fuse.inval_wq=3D5
> [    0.011114] ------------[ cut here ]------------
> [    0.011115] WARNING: kernel/workqueue.c:2704 at __queue_delayed_work+0=
x11a/0x140, CPU#0: swapper/0
> [    0.011124] Modules linked in:
> [    0.011128] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 7.4.0-rc1-0=
0010-gab9787d7e66a #1 PREEMPT(undef)=20
> [    0.011130] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
> [    0.011131] RIP: 0010:__queue_delayed_work+0x11a/0x140
> [ 0.011133] Code: c4 08 48 89 df 5b e9 85 28 0a 00 90 0f 0b 90 4c 8b 42 0=
8 48 8d
> 42 08 49 39 c0 0f 84 1c ff ff ff 90 0f 0b 90 e9 13 ff ff ff 90 <0f> 0b 90=
 e9 ec
> fe ff ff bff
> [    0.011134] RSP: 0000:ffffffff82e03e00 EFLAGS: 00010003 ORIG_RAX: 0000=
000000000000
> [    0.011135] RAX: 0000000000000000 RBX: 0000000000000040 RCX: 000000000=
0001388
> [    0.011136] RDX: ffffffff83a3f320 RSI: 0000000000000000 RDI: 000000000=
0000040
> [    0.011136] RBP: 0000000000000000 R08: 0000000000000082 R09: 000000000=
0000001
> [    0.011136] R10: 000000000000000a R11: 000000000000000a R12: ffffffff8=
2c09fd0
> [    0.011137] R13: ffff88807ffcfb89 R14: 0000000000000000 R15: 000000000=
0001388
> [    0.011140] FS:  0000000000000000(0000) GS:ffff8880fa26e000(0000) knlG=
S:0000000000000000
> [    0.011141] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.011141] CR2: ffff888003a67000 CR3: 0000000002e30000 CR4: 000000000=
00000b0
> [    0.011142] Call Trace:
> [    0.011143]  <TASK>
> [    0.011143]  queue_delayed_work_on+0x6a/0x80
> [    0.011145]  inval_wq_set+0xc4/0xe0
> [    0.011149]  parse_args+0x299/0x3c0
> [    0.011151]  ? __pfx_unknown_bootoption+0x10/0x10
> [    0.011154]  start_kernel+0x3b8/0x7c0
> [    0.011156]  ? __pfx_unknown_bootoption+0x10/0x10
> [    0.011157]  x86_64_start_reservations+0x24/0x30
> [    0.011160]  x86_64_start_kernel+0xd1/0xe0
> [    0.011162]  common_startup_64+0x13e/0x158
> [    0.011165]  </TASK>
> [    0.011166] ---[ end trace 0000000000000000 ]---
> [    0.011173] ------------[ cut here ]------------
>
> 2) TO-BE (after fix)
> - no error while booting, and also fuse_dentry_tree_work works well.
>
> ---
>  fs/fuse/dir.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index da23ccd8685c..6965a77a871f 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -39,6 +39,7 @@ static struct delayed_work dentry_tree_work;
>  /* Minimum invalidation work queue frequency */
>  #define FUSE_DENTRY_INVAL_FREQ_MIN 5
>=20=20
> +static bool inval_wq_ready;
>  unsigned __read_mostly inval_wq;
>  static int inval_wq_set(const char *val, const struct kernel_param *kp)
>  {
> @@ -62,6 +63,10 @@ static int inval_wq_set(const char *val, const struct =
kernel_param *kp)
>=20=20
>  	*((unsigned int *)kp->arg) =3D num;
>=20=20
> +	/* Defer the work until fuse_dentry_tree_init() sets it up. */
> +	if (!inval_wq_ready)
> +		return 0;
> +
>  	if (num && !old)
>  		schedule_delayed_work(&dentry_tree_work,
>  				      secs_to_jiffies(num));
> @@ -224,6 +229,11 @@ void fuse_dentry_tree_init(void)
>  		dentry_hash[i].tree =3D RB_ROOT;
>  	}
>  	INIT_DELAYED_WORK(&dentry_tree_work, fuse_dentry_tree_work);
> +	inval_wq_ready =3D true;
> +
> +	if (inval_wq)
> +		schedule_delayed_work(&dentry_tree_work,
> +				      secs_to_jiffies(inval_wq));
>  }
>=20=20
>  void fuse_dentry_tree_cleanup(void)
>
> base-commit: ab9787d7e66ac7e6e94fc975b37c5b56fff98ca9
> --=20
> 2.53.0
>

