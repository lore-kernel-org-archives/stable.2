Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858A3F0AA0
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359218; cv=pass; b=Ed3QtQ1/fmv7CVxqYXkkmJ5m2w9b11Rhv3+eREN1x64z1Fp/3Jis7Dbwqm+1lgwqr510lDlSII0JBYryS3nzs68ov422mjzficUbB9OzCVI7sUx+PI/T92AafcvrI3/e03gRqDwBuT6vwAqFEd+KrcQT+z2f6fZICTOUlZwvkgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359218; c=relaxed/simple;
	bh=F7cMAvRIjL0nUwsv9kBZ1UgXriSkdgwgovqaLz3rWdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gxc6pe0JXGPE/Kc5z9cyg26pN/A/DVkO6+8Zx0ZpkA21xHS+Dy+shyqKQ0gju4kkTry+4Dhuch9ebxEVU0isqSEppjgd05x34RP1TdGLK1Hw49lqKfxJNeusIkQsJuyt27Z6/Stu2neBf3X7rQVSNghPrk/KjHDIh5Ic9HwcMes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXKGfz79; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXKGfz79"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c0006ea8eso14990641cf.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 07:26:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788359216; cv=none;
        d=google.com; s=arc-20260327;
        b=noQroYRia8FB7/o71aI1kCBYGVhib9/W/Ire36ZryS5zEl6bX+9SSZVbawj/UXIIfe
         tJi37bmL01J2dJIYLRmK4fe18HdFd6zUwbX3Oqas/yltd5W9hTGfB0+1UJZ2EUgH64hf
         jnx3i4phyjTKYVxas181PRioj/4LZVk+ZOIuZQoeMFo9TzlHSy+sUov3DwBVmu765OwY
         wfrJe7Wt0ep2ibH/Hv0T5AqS3bviG5r6jlZzxANtirP/enWDpMr4cVW8/dXzSpEtV7qI
         FEFZzdhcEZYTSNYiHQe7zAIs3dQ0Q+9qSvhnzN6pWRMoVGySfycVdRpsGxB8MQ6xqjuJ
         gIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l9gYycQMUu7NhAOY65WxyfsF7dFw87l8LexzeO9K2xg=;
        fh=5gf7/62WULv1XexCzByRbrKms/Wx2tjLaYWnv1GLng8=;
        b=FcbHcYvMV/2YKGeGPutgLNLeQ80gFObUMAlMlKZaCyBBHr8LuxxprZ44AZKfZrh3hV
         IpWVICMNsf70TaaQH38ToKFIcD1BuF78Aln8jGV50jpZX9zfnXhnL768lvXvlYSyi3su
         LkLcOMm8Mfscl4Vm/3Tf4F2aJT+n7kxide3tsGeJuW8PU+xpOs52BHQDrRS+dfc2UUUG
         kj5xJ9bsR7iYcE5POITD6urjwdHzTbk7FC0gii5h39IpBbZgqojBduEG4zY0VePWQWSY
         D7R2M7A+XbEQtMjOVwDkLIZPLuaB3UJITwprxMbGw2Ly0eDa5wCwYrA7nTSYk+dnLCge
         2kRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788359216; x=1788964016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l9gYycQMUu7NhAOY65WxyfsF7dFw87l8LexzeO9K2xg=;
        b=JXKGfz79mYhM8r0w8XlDcjF7dqHet5cHXRvGUi9Dpyc5X+CfS7kJ5haMBgjJDJ8MN3
         pKdjG6ViVXY+O1XQ4MKMiZpk7OXdQGBAWFfPagijOaDtWXr+0BhlKjS2pvqjuhNQQ/Gv
         hrdaVDDBrPCcHlerOgjkitf12b+zEyGIvl17+WLyhthvUv2GRlQUQk9V1Kzed1XmXMCi
         crsWPAlh2Go4lqNB+HT9h3AdWeRrYxX3JBGuWFeJ92pVFASTyz8ZBSbMOhXt83jGRFM7
         uGeMLF7ZmpE8GRJa+jIig4DcKjSE8bw5dYRGKvAGpZXUibGIWhkr/QOMZEYZ8hdX/aer
         u/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788359216; x=1788964016;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l9gYycQMUu7NhAOY65WxyfsF7dFw87l8LexzeO9K2xg=;
        b=jVOBCP4bR0B/62SEIPICgMbhzmz159KV4VvqEAgIh5kIMOfo+96KSnwQn57TcZnpHH
         00F4P3Ezt3XwONK4AqSwDNcr/yhmmVWQBAIWUCnJQGwh/+d/GAUk728WYKYGMCVILllr
         SvJKlOHVHPBCi/oX3qx5/AmVa5caJvyJN/AvGaezpkar7FQh1gj28bhW7QN8RX180N5U
         TP6V6K+4stVIu/mXhFC8JRNdp6IhMimWfJ/xCyQRAYzKS6KCG0YuVYfzV4c+JXF9qUUm
         F+HyNSJ8RP9lnLk7id9lpSdE4TN4cXrPxDRwhEjv5aP0SxXCyjjo/6/PgEmluiuGV41k
         o5gQ==
X-Forwarded-Encrypted: i=1; AHgh+Roygw99oJ+l1YPMYlM12xZM8JHLjT/4gSLPjfDO6BLEV6RsGx6IDov9kwce4Z0NvIU48lWgmhU=@vger.kernel.org
X-Gm-Message-State: AFuF++mDGz3LAPV4IRQrus6R7DjN+KWSfYoOuLqFzMF7FR1CPrRLkXfb
	F+0QITuQ8GEaPk5uRW+u5XuN9CzXK8aISejLC21FCHbq2H8iM/BwgT2lq38aER0J1hE8xj531s2
	m5RdnvdSNaghWDTWAtqQ1MlPz1QzN/Fb3FjU+en8g
X-Gm-Gg: AR+sD10ON5MFkc69wjkR0yE6k3kw3LskRO69nBOCM++zPqoAsULIxFNe82YfJj1gKWL
	QQ5k/QSliEpdQT0Z4lrB3VbCpKGLJ10xswvj/Zg6+FHEn8J42mLWevKUYKTk5/Anqtx+A5ch9W4
	nBk3x0FHGgFQgX1uJmsDxP6lpYI9PuzzNtOJmZq15rq3S+qt8q7LzBXjZlkOHJQjWeMilxvexPj
	SMqaoobYPHH+G2GLvoVDczuQb3d9oGC0jvbsGyYTC6jGcmziwbimkvqUEcXgI8TkkCsBZIK8FbF
	gaKSDUaZpihXDkXFapBhvmEzUyBjKeixsNRxWG+di+FNZtYBHGVLlWtnitFdxJwH4y4Z7NTpy8U
	ola0jRcuObvSu8TNUSefY/K8d6SPlQLG0uRrDL+IKLXsWVkawAUvvM9vSB/TOTtcrwdZR
X-Received: by 2002:ac8:5748:0:b0:52f:f59f:2b2a with SMTP id
 d75a77b69052e-53036d15de7mr55895081cf.32.1788359210665; Wed, 02 Sep 2026
 07:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com> <QDISC-0CFC.v3.20260901204856@mojatatu.com.2>
 <CANn89iJCBTSGwKK02xw0XdZRsP=2VGmJny27cdi0bnpz4aBwHg@mail.gmail.com>
 <CANn89iL+o5mdPOvRUy_vSiHxj3Kc9Wzr3HV_dGf2tsKJJNwniA@mail.gmail.com>
 <CAM0EoMnENJAY7pP9dP6pbbWnW44Ug-Ow3C=sf87pfOTwxjMdaQ@mail.gmail.com>
 <CANn89iLr_3Z1MTa6U9SuooU7q-Yw8nXgRb=heSvoR=uUSTJgzg@mail.gmail.com> <CAM0EoMmB+W6gkKpWD0JNXgxK8=9U9CiSrP-rEAE52KADvq-TQg@mail.gmail.com>
In-Reply-To: <CAM0EoMmB+W6gkKpWD0JNXgxK8=9U9CiSrP-rEAE52KADvq-TQg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Sep 2026 16:26:38 +0200
X-Gm-Features: AcwNN1W_C0hNxg6_USaPe8Ri3FrNNTga26i9iiUEzbv-KnCsWP0RQ7PQUcMGdoQ
Message-ID: <CANn89i+9M++rSRRVrNpgzXYCi+hNDBXjYKBEi1H5gEJ2oF2+GQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/9] net/sched: fq: clamp quantum and
 initial_quantum in change path
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, 
	stable@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Vijay Subramanian <subramanian.vijay@gmail.com>, Petr Machata <petrm@nvidia.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 3:55=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Wed, Sep 2, 2026 at 9:04=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Wed, Sep 2, 2026 at 2:40=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> > >
> > >
> > > Trying to understand your concern: Are you arguing for
> > > stylistic/readability improvement or robustness?
> > > The only place i can see where the multiplies you describe could
> > > happen is what the 709f34f7c28d patch closed. i.e this part:
> > >
> > > -       q->quantum              =3D 2 * psched_mtu(qdisc_dev(sch));
> > > -       q->initial_quantum      =3D 10 * psched_mtu(qdisc_dev(sch));
> > >
> > > IIRC, you are suggesting restoring the original logic (x2 and x10) an=
d
> > > i am likely missing why that is a must do? Does it break anything?
> >
> > It does not break anything; it just causes a cascade of various clamps.
> >
> > After your patch we will have:
> >
> >        mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
> >        q->quantum              =3D clamp_t(u32, 2 * mtu, 256, 1 << 20);
> >        q->initial_quantum      =3D min_t(u32, 10 * mtu, 1 << 20);
> >
> > So @mtu is no longer the psched mtu anymore.
> >
> > This is fine.
>
> The u64 variant would read cleaner for sure.  If i didnt misread you
> though you are saying the current the mtu-no-longer-psched_mtu
> aliasing is fine. So would it be ok to see if any other comments
> spring up from says sashiko that are worth reviewing the patch before
> I proceed with this? Or do you want a v4 or a followup?

I think v3 is fine, thanks.
