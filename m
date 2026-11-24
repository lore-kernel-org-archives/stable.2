Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537429;
	b=Z53Gn+zHWMLPuE/NWGhS6LxrlTUl9R9rDOzf6AsPeuGAbp62gRqz/YiLvszd6FOgaZnb
	 CVQMSork+GXVyT4r2t0JToGWeurGaJaOWGTre2wjxvRlVm7hNnH/0RWA9EDqf/337EMb0
	 6Nbkbu1f6Z18Mhg3pd+ulJte34RX2jTrKSEv0XhGeJN1KPYqkKCLweJLVi+lthtYo1akW
	 j5HcPL1uf9fczW6z3EejPE+eirPjC9Uhu3D8/8Zk0KGdxGuLU6h8WRA2qfhfRKMrPUJOm
	 QlRwhNhFdu9Iw6vwi6iA5jrkFAUVn+qJiCNIKYTqFCtH/7jMD2ywukFK9JKBwxMAlXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537429;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1Fpi0rawx8IAER5Jf6QAaacwgU5guDYn8kZYpfEvCSc=;
	b=QWNJAUAMG2hlVTlzAiIqsbinFEAWjY9C5bIPVG2AKCKVP3TfNd5lNau3Wlv3gHi7F5bn
	 cDFva6GaByfGjgm6im6tDrOq5TIseMLoMwBBPDflWdh1PJFsLgJ7BAguql4HnUd50C9+V
	 ufpQRHOSwn9IR98v/lwnmjEdT6qW02Tmg4epnU5sAdv8XlNl9S/aJK5HFcJ6KyMaL5ej6
	 ePG0yR1OLxRaE8p+ME7mRGovKf7Mw/jjJ6IvNYC5vJ9igMX9TuRrXYLVdkS9S86wTrMAU
	 USRTkKG4igBF1p8Qc+FAf/bs38BIKm27IH47en7eO+CN4fzTc755IXphB50leklTaXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=iuq8Pd6P;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AEA606A31E;
	Tue, 24 Nov 2026 16:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02AEA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=iuq8Pd6P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=1Fpi0rawx8IAER5Jf6QAaacwgU5guDYn8kZYpfEvCSc=; t=1795537428; x=2110897428; 
	b=iuq8Pd6P0NUfuQFSW9OVSciMLRp3c6/PcIR60yebkeWJQ9dsLVq43qum+COpf+0CezOzRXXrxvT
	InrxG4VaL94pzcMZ2VS2tDYm6Y8cBZDNsht+hTlCd5YSe67uUmUaVvCubEOwRSPSc4s3X9uQ7HwmX
	OyHOmygcQ5YoyoeLB2bDR4s+eZHSwgEWPGws6UKKiY2ovC6rp78bP2F31fc8gXmtxSRAWIPrQL/vb
	N1GJnFlMe6NEbtBtoxDSMep6gQfkLK9Ucv/+2oLbIcrrlBldQIzSa10lDexIq4UvXc0NKREsQEF7/
	G5sotDdWe5f9MSAaXqXXgltdaeREghOKP57w==;
Received: from bl17-56-70.dsl.telepac.pt ([188.82.56.70] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xVtJ3-00000003YKD-3FZ8;
	Tue, 24 Nov 2026 17:23:45 +0100
From: Luis Henriques <luis@igalia.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  fuse-devel@lists.linux.dev,
  linux-kernel@vger.kernel.org,  Miklos Szeredi <mszeredi@redhat.com>,
  stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fuse: defer dentry_tree_work until
 fuse_dentry_tree_init()
In-Reply-To: <CABFDxMGGtxxm5OyLiihbVLBJKihoTxtV2g-FG6rURdPWnQdwPw@mail.gmail.com>
References: <20261120150008.1144420-1-ekffu200098@gmail.com>
	<20261120150008.1144420-2-ekffu200098@gmail.com>
	<874id6cuvh.fsf@igalia.com>
	<CABFDxMGGtxxm5OyLiihbVLBJKihoTxtV2g-FG6rURdPWnQdwPw@mail.gmail.com>
Date: Tue, 24 Nov 2026 16:23:43 +0000
Message-ID: <87mrqyb3lc.fsf@igalia.com>
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

On Wed, Nov 25 2026, Sang-Heon Jeon wrote:

> Hi, Luis
>
> 2026=EB=85=84 11=EC=9B=94 24=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 8:49=
, Luis Henriques <luis@igalia.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>>
>> On Sat, Nov 21 2026, Sang-Heon Jeon wrote:
>>
>> > inval_wq_set() schedules dentry_tree_work when inval_wq is enabled.
>> >
>> > But inval_wq_set() can be called at boot or module load before
>> > fuse_dentry_tree_init() initializes the work, so __queue_delayed_work()
>> > warns and the work never starts.
>> >
>> > So defer scheduling the work until fuse_dentry_tree_init() sets it up.
>> > Also hold kernel_param_lock() in fuse_dentry_tree_init(), because a
>> > sysfs write can call inval_wq_set() at the same time.
>> >
>> > Fixes: ab84ad597386 ("fuse: new work queue to periodically invalidate =
expired dentries")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
>> > ---
>> >  fs/fuse/dir.c | 13 +++++++++++++
>> >  1 file changed, 13 insertions(+)
>> >
>> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> > index da23ccd8685c..0d5d04df477b 100644
>> > --- a/fs/fuse/dir.c
>> > +++ b/fs/fuse/dir.c
>> > @@ -39,6 +39,7 @@ static struct delayed_work dentry_tree_work;
>> >  /* Minimum invalidation work queue frequency */
>> >  #define FUSE_DENTRY_INVAL_FREQ_MIN 5
>> >
>> > +static bool inval_wq_ready;
>> >  unsigned __read_mostly inval_wq;
>> >  static int inval_wq_set(const char *val, const struct kernel_param *k=
p)
>> >  {
>> > @@ -62,6 +63,10 @@ static int inval_wq_set(const char *val, const stru=
ct kernel_param *kp)
>> >
>> >       *((unsigned int *)kp->arg) =3D num;
>> >
>> > +     /* Defer the work until fuse_dentry_tree_init() sets it up. */
>> > +     if (!inval_wq_ready)
>> > +             return 0;
>> > +
>> >       if (num && !old)
>> >               schedule_delayed_work(&dentry_tree_work,
>> >                                     secs_to_jiffies(num));
>> > @@ -224,6 +229,14 @@ void fuse_dentry_tree_init(void)
>> >               dentry_hash[i].tree =3D RB_ROOT;
>> >       }
>> >       INIT_DELAYED_WORK(&dentry_tree_work, fuse_dentry_tree_work);
>> > +
>> > +     kernel_param_lock(THIS_MODULE);
>>
>> I wonder if this is the right solution.  The solution I had in my local
>> tree was to simply declare a spinlock with DEFINE_SPINLOCK() and use it =
to
>> synchronise access in fuse_dentry_tree_work(), fuse_dentry_tree_cleanup()
>> and inval_wq_set().
>>
>> Do you have a reason for using this kernel_param_lock() instead?  (Honest
>> question! I've never used that before :-) )
>
> AFAIU, parse_args() (boot, module load) and param_attr_store() (sysfs)
> already hold kernel_param_lock() when they call inval_wq_set(). So we
> don't need to declare another lock if we hold kernel_param_lock during
> init and cleanup. Let me know if I miss or misunderstand something.
>=20
> But using a spinlock should be okay as well. So if you prefer using a
> spinlock instead of kernel_param_lock, just let me know and I'll
> switch in v3.

Well, I think your solution is correct and it should be OK.  My question
was mostly a bike-shedding question: we're using a lock that is defined
outside of FUSE, and that doesn't seem to be used a lot elsewhere.  On the
other hand, this kernel_param_lock() was likely created for solving
problems like this one so... yeah.

Let's just leave it to the maintainers :-)

And sorry for the noise.

Cheers,
--
Lu=C3=ADs
