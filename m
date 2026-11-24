Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520953;
	b=Q2J0kXYX/iga25fBfu79Y+O2q9+IVgFrmc2lgU1rvU1Vw8R5kIExrZn9khJd2jn37tOy
	 tfK2vsXF/BcuTcf0QDt7aNhFsXMXdSp5fFvJoyJdi3sgQ8axR0cVXPQr6SZ1+kyV0gfWd
	 rQFHYpXMcBOkhI1sv3NTwMr1MTOKDhH8QCwe/Ll8cW6diiwbG4eXRK/IEvzNsvswJa8tR
	 1TtND7icw1bz6BFNm4Kkwt9kgW7aWjtnmvY5kHvQKt0125O/E+hyXSKYwZ/ZJeFgVTZrA
	 9rtmPVFn7qhxXfNJ9ViqRvXIraJQsZ2birjNhcOHn4RlbbhcSpH09PovI6MnLdXUSDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520953;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=otCJ5d1UzM/T9DZmT1DhstzhCZjq10O+wJq0ht/u0fg=;
	b=fWBR6Ztp7TMT7sbjjRRW3KskbYxJX9U3pKGtdZm2W24MjPNtu6/86C9LsVLS/MkaOvQI
	 OGZmfrXVAih2re/ee6uPwoxuCKOdJivaqCjI+A8P5z62v6eOiPUJDI9o9mh5KgwrQu1+9
	 KttVhfeNn1oGhcM4kcdF6hGa4TfGlJIFo+uVXvuaTQ36O2FThwZFmnn10K7g8shInh+qk
	 /bQIJOH90OdTS6htHYFHZ26Q1NdKgdshZHU6KINVvi7gx93faCtn1i3r5VlDRma1noJDt
	 r72zK5ztHlAvs79Kkpxmk3imkLVbWwyMUjjkCPxIPlgjqpGDZMtV9+Z2t9j8FsQ0qxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Mmiyp+mA;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206A606A31E;
	Tue, 24 Nov 2026 11:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D206A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Mmiyp+mA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=otCJ5d1UzM/T9DZmT1DhstzhCZjq10O+wJq0ht/u0fg=; t=1795520952; x=2110880952; 
	b=Mmiyp+mAnZDG19NW610SyF32ULiUUJ5UyJyUEO2HYkR0tc7VzGYl5UbRZiyJjFGmIYukedwiHIE
	jeDkD89OIjKnZ+0MLCg943qJ1r9sWiAf9BIFZ3Oi14BxgsrLC5HnOekBh9vUbqDKjbZCA2vAaV5qS
	Q6MwX+FuldrsDOkeRodtKRDpgZSfiC3Y+vQ6973qQmApWLTUIbSVdc6WYkO6KMj6mpKxHjC8AfAXr
	W6MpCgt4nJXfZ/eAb81K4ue9XZO2wcItVCyJjHw5yM6qGsCjKpAKeFJFXrJEexhyioVdkq3NhvjTl
	mRCxsiDtYspon1yrG8jgBwzN6BoQjuww0UDg==;
Received: from bl17-56-70.dsl.telepac.pt ([188.82.56.70] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xVp1J-00000003L0T-2V2N;
	Tue, 24 Nov 2026 12:49:09 +0100
From: Luis Henriques <luis@igalia.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  fuse-devel@lists.linux.dev,
  linux-kernel@vger.kernel.org,  Miklos Szeredi <mszeredi@redhat.com>,
  stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fuse: defer dentry_tree_work until
 fuse_dentry_tree_init()
In-Reply-To: <20261120150008.1144420-2-ekffu200098@gmail.com>
References: <20261120150008.1144420-1-ekffu200098@gmail.com>
	<20261120150008.1144420-2-ekffu200098@gmail.com>
Date: Tue, 24 Nov 2026 11:49:06 +0000
Message-ID: <874id6cuvh.fsf@igalia.com>
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

On Sat, Nov 21 2026, Sang-Heon Jeon wrote:

> inval_wq_set() schedules dentry_tree_work when inval_wq is enabled.
>
> But inval_wq_set() can be called at boot or module load before
> fuse_dentry_tree_init() initializes the work, so __queue_delayed_work()
> warns and the work never starts.
>
> So defer scheduling the work until fuse_dentry_tree_init() sets it up.
> Also hold kernel_param_lock() in fuse_dentry_tree_init(), because a
> sysfs write can call inval_wq_set() at the same time.
>
> Fixes: ab84ad597386 ("fuse: new work queue to periodically invalidate exp=
ired dentries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  fs/fuse/dir.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index da23ccd8685c..0d5d04df477b 100644
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
> @@ -224,6 +229,14 @@ void fuse_dentry_tree_init(void)
>  		dentry_hash[i].tree =3D RB_ROOT;
>  	}
>  	INIT_DELAYED_WORK(&dentry_tree_work, fuse_dentry_tree_work);
> +
> +	kernel_param_lock(THIS_MODULE);

I wonder if this is the right solution.  The solution I had in my local
tree was to simply declare a spinlock with DEFINE_SPINLOCK() and use it to
synchronise access in fuse_dentry_tree_work(), fuse_dentry_tree_cleanup()
and inval_wq_set().

Do you have a reason for using this kernel_param_lock() instead?  (Honest
question! I've never used that before :-) )

Cheers,
--=20
Lu=C3=ADs

> +	inval_wq_ready =3D true;
> +
> +	if (inval_wq)
> +		schedule_delayed_work(&dentry_tree_work,
> +				      secs_to_jiffies(inval_wq));
> +	kernel_param_unlock(THIS_MODULE);
>  }
>=20=20
>  void fuse_dentry_tree_cleanup(void)
> --=20
> 2.53.0
>

