Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240BE3F12EF
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724073; cv=pass; b=CZDaCYCCtnwZpA0Z6a3IGLV4Ox/jY2l1FbdMSng04/O2XnvhI01Wb+AFogcjKpxuLrfNKdvOsKyI3KsZexGmlBFgDG3wgH8QZipbyYMM5o69aA+3A+rgcDmnzs+85dlAJS95SEo4BwvE4jrCxXKdcBkShzCzO3JNYHlOJdr5OMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724073; c=relaxed/simple;
	bh=nPqvOZbKoz5l5VUtbF5GpE4Rhvh9PCwXzLfj2fWH7Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njEai1VpeRe92DVxNu+NArM+ojMZucsN/XwM8y0N9M6NQLeaccpSAuMgx+LVbzoG9IGmU1y857r1bbgfUIM+zgPejXAgcLYbIGQAT/yf9WHMEEknyqoi5ovs1NCCJdc1cLm7SDatNd1IYoCCGZxdHEH01Q4ONp4hUogX9WkbL+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nccAKZb6; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nccAKZb6"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469f204f6so345765b3a.2
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 02:34:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789724070; cv=none;
        d=google.com; s=arc-20260327;
        b=V3bSKMeC7szyZneA/mdGP3DML22ThnR5D8F6WIOZZ71JXRT+D25DahDjhZSKuw3ajB
         qqHDKTfdUEL65GReVfY9NNUmmlcmoOxQbTETInJqXEvcib0505wGZbsUSPulXTyjKpEq
         ESATLqg05qbPmvUxfXeq61GGIXfZMQfj1U9IkXn5H+RMbLOymfv5Sjfw6X99fsZIkOVd
         px6DATTNHvsZnY4ml0xY6YegImknibzXmmx7gHThjKctfVGp8gVIOipOG9qVQBXfagCQ
         fjzLghLfMk/v+1ZVtgoLoTEumhJBKmIrLYLrv9qyK/cyw0Rr0AFMUmH1mAVIWVej3DNT
         GHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Uw8V/tjzi/pvdnamMY2FGLe6nYrEvNwyYPwFQRYV9I=;
        fh=5G45mtGr0kOWmPCUrdi2ftLnprtXUvxoVMHFtuTOBTU=;
        b=i7RRWhMGH6Yw8F7E3fgj30WxG3CdaUkK8VjyqxThw8v1NOsZlu+MqzFNtzPb0lyRmw
         whjAFp64RjrkrxDuzz2scZVSiFIHyf3/DmfWQy+IYXC6ap5wMyXoveLqo6dyE5g4oLTe
         THQ7R1ZNur2/6r+Q+j7UhynHkC8arKAvqO/nTKjNYrB+pQA4Ap2W4ip0XuktIJyN4Pkm
         6Jb8z9491VLlBBH6wtq/v/5Eir1MdVHY9bXqzQb24Cto4MVAxxuXpxvScTMACVurRJVt
         yxBqiaFTq5QGW9gAfbFVV/LGHR5aNJEM0uGr051gbWRE4sYus1xkvC7jzH91E9AT8Lb8
         aD2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789724070; x=1790328870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Uw8V/tjzi/pvdnamMY2FGLe6nYrEvNwyYPwFQRYV9I=;
        b=nccAKZb6SQJzVdJB6lrFzgbkcA7favEBSnB55ElHrjyYp6b58L01TvW0vLZ7ElHVyZ
         lLggy32wEAjC1OxOzr54XNIWkqbxgCZXeWhiqPY/X7WdlA3d8OIF+O/P3vSfY4iYlTJx
         jgwsAbUnDBDIQjDJZqnfbW2LktfYhnaPh59fBVXdVjsY1RUReVBOnwsmpLjzGo7Fy6rK
         6ZqezFLoHV0n4HugEtQ8C3JQG1OWxW8ds9vI/VPu4waVC5ovduElviK07vzTojkILnU5
         tlGnsNGiws+ZJ0wL4EaZQcxnBERjRf611lagFBq1CE64RT1KVx5aRYxBoXfw2OKYx7W7
         5QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789724070; x=1790328870;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Uw8V/tjzi/pvdnamMY2FGLe6nYrEvNwyYPwFQRYV9I=;
        b=GummCoAOq6nkas8OOnk9smqokYqddUKSpdq3afX8x0iJW8Gr43p95Zwrzlj+anhaTE
         x1czEvo641uYpVlAnbnAdEJRrizN/NCJD1yDnWYn8SZIODene5YQvrGVEhaedfVT5UYe
         O6G9fuB8hHoS/3W2auL+2C3N3BMJN1uEBi5DEz51s2jSdOPnADfhKpRU8ciwDQtXi5a1
         Dd2u/KAE4VgTCj4DOIpa1YCYV+vzIeepPXBrgrIZMn8nddsuPIPf/fcC8ZInlmMgsy3j
         EQjiFxJpq5BeZvBEocusq+WQ2TuGqF6u/ZZtjkw0QBG9Mq5PN61Su/vgZAu5TVOSBA70
         6FKA==
X-Forwarded-Encrypted: i=1; AKwUvByWFkP09rapnfGtiJ8dAgMb9FVdRC2PXR8S3+S/+24tEXw02HHrmP0niJQLDMjdZQsR980GyQA=@vger.kernel.org
X-Gm-Message-State: AFuF++mWJsSguscW7GiGojOn2RYcO5WzYvBNeu/hH1jj2YWClqKmEPOw
	15vAO65VY0owJvnTrNzrRQSuQfLRdDprxMKIL8KcBxV0wTPPx9D5T2xz+5278Zoga+epljxRZcc
	4C/2vnuOwL1Q4omtHDEwPdsme/DfwANA=
X-Gm-Gg: AYBFou0hmLsFXxu1pV/jiPB38RYlHr7js4W2+h9F9RfoET4xiFXid+y5UWXn7M9UyD+
	ZAdUqhKMQm2icPZEyAFshr2eD0b7ywXVvoFA6mlgIba/zrgSO9xCPiJ/wZQNoZqIHW4xL4iBqna
	7O7gTk1YtJD6KXtdOgaMWPZXW3ggUCq0xLn3F1iL9fQG/zLmtlpI6NY5W9pEnLZ1HVOXD1VA4gz
	UtCfzWnlSGguVF7muaYR2vawNr9jw3YDWX301Hj77Ll3Ifnw5VmCCIhNvyMBzjOS0n5IDB9gnsv
	VCOupgMafXRIja0lXLpkSV4GuabqQfH3AaypMTXCdvtMeQDD87xQKcFtKRmv4JdDRTDJ7C8gTPy
	G8eu+u6WN
X-Received: by 2002:a05:6a21:32a3:b0:3dd:85aa:d26d with SMTP id
 adf61e73a8af0-3dd8c5c7cd1mr4479780637.37.1789724070188; Fri, 18 Sep 2026
 02:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-LQFE.v1.20260911041746.1@mojatatu.com> <20260917120801.GA51261@horms.kernel.org>
 <CAKYWH0RMJ+sxMku8UGmmcujnO9fJBg3Ok_ofbvyh5eTJm=2uTQ@mail.gmail.com> <CAM0EoM=uw-3EAVQBWWMtNSHJjzcS-ftfFYpbSX+BXJyx-gdjuQ@mail.gmail.com>
In-Reply-To: <CAM0EoM=uw-3EAVQBWWMtNSHJjzcS-ftfFYpbSX+BXJyx-gdjuQ@mail.gmail.com>
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Date: Fri, 18 Sep 2026 11:34:17 +0200
X-Gm-Features: AcwNN1UzjY3rarwg-alFhA-7zbkCReJl4rhHIs9sOcz_PArn3s5cZxt8Ai-scw4
Message-ID: <CAKYWH0SYbfjEgpqQMkdQ91VZnT8vwcc0TaH4xs5hHkLCc1BqMg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: cls_u32: fix manual hash table handle
 IDR aliasing
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, Victor Nogueira <victor@mojatatu.com>, 
	hybris <hybris@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 18 sept. 2026 =C3=A0 10:22, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
>
> On Fri, Sep 18, 2026 at 1:37=E2=80=AFAM Alexandre Ferrieux
> <alexandre.ferrieux@gmail.com> wrote:
> >
> > Le jeu. 17 sept. 2026 =C3=A0 14:08, Simon Horman <horms@kernel.org> a =
=C3=A9crit :
> > >
> > > On Wed, Sep 16, 2026 at 06:01:14AM -0400, Jamal Hadi Salim wrote:
> > > > A u32 hash table created with an explicit handle ('tc filter add ..=
.
> > > > handle 801: u32 divisor N') keys its IDR entry on the raw handle, w=
hile
> > > > the destroy paths free it under handle2id(handle). The two key doma=
ins
> > > > disagree for handles in the 0x800..0xFFF htid range:
> > > > handle2id() folds them back into the auto-allocated id space (1..0x=
7FF).
> > > >
> > > > A manual table therefore leaves its raw-keyed IDR entry unreachable=
 on
> > > > delete (a permanent leak), and its delete can drop the idr entry of=
 an
> > > > unrelated live auto table. A later auto allocation can then hand ou=
t a
> > > > handle that aliases the live manual table; u32_lookup_ht() first-ma=
tch
> > > > routes lookups and TCA_U32_LINK for that htid to the wrong table.
> > > >
> > > > Key the divisor-path alloc on handle2id(handle) so allocation and
> > > > removal share one key domain. A manual handle that maps onto an id
> > > > already in use is rejected with -ENOSPC, and auto allocation skips =
ids
> > > > held by live manual tables.
> > > >
> > > > Conditions to recreate:
> > > >   ip link add test0 type dummy
> > > >   tc qdisc add dev test0 clsact
> > > >   tc filter add dev test0 ingress protocol ip pref 1 \
> > > >           handle 801: u32 divisor 16
> > > >   tc filter add dev test0 ingress protocol ip pref 2 u32 divisor 16
> > > >   tc -d filter show dev test0 ingress | grep 'fh 801:'
> > > >   # unpatched: two live tables with handle 0x80100000 (the pref 2 r=
oot
> > > >   # hnode is auto-allocated id 1); patched: the auto hnode takes id=
 2.
> > > >
> > > > Also tested with a poc with a live u32 table on the block, add/dele=
te a manual
> > > > table 'handle 901: u32 divisor 1' twice; unpatched, the re-add fail=
s with
> > > > -ENOSPC because the raw key leaked on the first delete.
> > > >
> > > > Fixes: 73af53d82076 ("net: sched: cls_u32: Fix u32's systematic fai=
lure to free IDR entries for hnodes.")
> > > > Reported-by: Sashiko (gemini + nipa) <sashiko-bot@kernel.org>
> > > > Closes: https://sashiko.dev/#/patchset/20260822222049.114526-1-jhs@=
mojatatu.com
> > > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > > Tested-by: hybris <hybris@mojatatu.ai>
> > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > >
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> > >
> >
> > Hi Jamal, Simon,
> >
> > Thanks a lot for the fix.
> > One nit I'd like to pick is the "Fixes:" header.
> > Specifically, it mentions my patch:
> >
> >      Fixes: 73af53d82076 ("net: sched: cls_u32: Fix u32's systematic
> > failure to free IDR entries for hnodes.")
> >
> > However, what this does fix is *not* a regression introduced by the
> > above patch,
>
> This patch fixes the alloc/remove key-domain asymmetry introduced by
> 73af53d82076
> Prior to your patch, the alloc/remove key domain was symmetric; you
> forgot to convert the "else {" part in your conversion, which this
> patch fixes. The comment tries to explain this detail.
>
> cheers,
> jamal

Oh, I stand corrected. Thank you !

-Alex
