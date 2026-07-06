Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EE7213254
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 05:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783316897; cv=pass; b=Arw6JUaDQTIgtR4QS9GPbWdX9cu2Bbyyaa45XZ2SpMoMwuzZDDPqmfcrrD5MN2og/fvXHIcn0+phR0yiT8zeIWRZbeFLrIzbpDh/72yi4SEQKngWGwSjH7U356lAuJ2buQB5MpJ1F1kE+gzTL401RDrf6VhnSJwtod2VK6z9ERs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783316897; c=relaxed/simple;
	bh=Aj0bcYgVyA+h7Yjt5/sByvrq4ZKbO93MgNXOi0Vl2aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNFnYUPFCEpeUH+hQH3dRxOIAQbZtVoIfLv50IUQndU6ffFY8A3qOsVD5knKMtVXYZsKTGqqy03CasLGSOkZ6WQJdM1ZlAblwyZ6ttcM9OH+fgjT3aI37OF3iLlEe2YKW+3cV+0dXviO+AYVJqe2bIx2S3lS24HHz+ca/2Cbh7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/6ht4zM; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/6ht4zM"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e5c92c389so118623085a.3
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 22:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783316895; cv=none;
        d=google.com; s=arc-20260327;
        b=aN9ByDF7/xOsdsyEF3vFZ9UAumKSakzRiMER9p8Z1BYeYMbJ3UMHKrbhS+z0UVtmoJ
         nkzsot3xZCEGGkDHcOzvnSuFMhOJZ67mXzR6cYYNA7OwGqHIn8QWNY0DDTAO8zUf42NR
         M/RPQbwSRIgkxf+wswQ5+w78Xm+k9W+uBpAECFcusNlcN+MceszUnbIaiBkICpWHZCRK
         vswvu5HhortufHU5Pkv9OklAKsvTJvH/xbpyosNwVblakeps2rx4YPv+tnA+lUL0iyqQ
         poYKdeSi+anM1EW9rvu+wviTepwZ2P09K9bwuPYPvK1FCisRuI1TBYpTbk9IwMEXZ+PL
         Gdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aj0bcYgVyA+h7Yjt5/sByvrq4ZKbO93MgNXOi0Vl2aU=;
        fh=pqJBECeoU0zSTn074k10lYMxp+FCxIQNK1vhTeIEKIM=;
        b=WWcida6EC7y9PfBmHs2gz4X3Aow7Fe/l4WMN7K2MdqmMmcobLlKz+xZMGKwBsGFNXE
         yYlFEYzftjtYGdzcDTq1hKAGwWG8a2aRNmrE2T4fHGjN30KDSxfx0rFF+VJGGI5BdOAv
         YF4GlqK4h9/xlPYs1r2VR/nvnGqQu4maE9i1CPxG0DAvYlB935rfhVxHVj0Z3rhaaeFC
         0+MIaJx77P2Cmn7/UjOvj6BUVZ8aOLTIYMWRPtxFqb9SGTiJNzl26n766yny+v8bgE4f
         lDmj1B5nY9LJIUS55eG+tf5pQC/JP9Et34Sa0oaKeYBc/EUwi/YqWaRph6TeMCGsXybN
         y5oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783316895; x=1783921695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aj0bcYgVyA+h7Yjt5/sByvrq4ZKbO93MgNXOi0Vl2aU=;
        b=l/6ht4zMZh8VfzWlOEgUEd9NiRtJf66D6Fao5CtGTP1+9cKrk7Y5f8JW+oY33mptkB
         1CU2ILPMZYZM6gsB//AMM15noY3Z6bpIAKazzXOJo24FHD4NZ7z2JctOeGEe0OHDsMIz
         m8PMK6Bm4Jsc9xT2+r5K9pocQwuU4Nk6RhMm9pr+Dsv63zbRoaQdTbJ2UAKf9AcbMCE6
         M57kKSjLMKaEw5XdEUiMM1Q4hLTKRFaami1cCpJ5WfZHDRPIG5kSt0qAluomWp62JMrX
         oMUR3qvrCubOWTVK/DF7W9cWpV/5kcuHfkKK3fQNKM9FmDunqK0Had1mlSmxxEs7zvGa
         C4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783316895; x=1783921695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aj0bcYgVyA+h7Yjt5/sByvrq4ZKbO93MgNXOi0Vl2aU=;
        b=kQ9Cy+Yz/z5nS9yOzhChsUdZC37Kf036kNf1gYasdTlqi07VNDEQetbvOzopDKJOA2
         +93ytygnv9ER/r1X+0YpM1glN36Rk9Xs+zXr469ZcxyJS8YxZ55mvy0yDB/LjK5TvB0L
         s2E6d/R5sPTPtvzXXvS1VGbGgL8UsoSAdoDaDzRVbBiz6KcLWz5Ofk3vND0N9U//yLKd
         SXhGv4oK3dq1/uv+0kd+DyiMei7zna8mfOH1QFnun9ykeacUp213A+6owgITxwK+fhB5
         HgcBWurxpd/krsiv64DpcQn8ePVnezkLO8y7IGIA0KqP5YeItgfPUicMQHW//oZRlXS1
         IZvQ==
X-Gm-Message-State: AOJu0YxKv3fkTa2JG3P4au4tKJyn3xba52r/RMJfk84kefPXh+pHtnaK
	YM28UTex0mo9ZYVzSRT7jW2wlAJdiP9/Qo7HxWSnIqiZg1b1Hq+ULb4nMQYaHQH5fdKOAsi6CvJ
	wefE3pHP7zVg/6ND3/GGzFB7J/wsE/6ffgvmIMYDJrzA2
X-Gm-Gg: AfdE7ckEuR4QK/GlXboCGP5ucgDhaG4tZ2PFvKs4LeKISW/QaikP9yeDcOCfQ4v1WMu
	kCfPV3cAgyb2CXCSvazHHkd7ztbClETqeMfLJFHbdV5oGKBjcxYyZ9hxyjAr36SXrOCIIKuzBiH
	12E8JZeSCkPPLqJCK9CjSpSHOofDH5WGUDt/5XOwppIfGv19f6prwkTeRrQFWgBMZVPU5TR3tNK
	c2sJv6+DGFbb4uWvn4HhqEUpX0glesASYhRYtikp+bwIzlUzjALyoPnaSTAToR81O5v4A==
X-Received: by 2002:a05:620a:198b:b0:92e:7467:fea0 with SMTP id
 af79cd13be357-92e9a4a487bmr1138752185a.34.1783316895422; Sun, 05 Jul 2026
 22:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703105059.3821189-1-pulpannie@gmail.com> <2026070315-stable-reply-0030@kernel.org>
In-Reply-To: <2026070315-stable-reply-0030@kernel.org>
From: Annie Kim <pulpannie@gmail.com>
Date: Mon, 6 Jul 2026 14:48:04 +0900
X-Gm-Features: AVVi8Ce2bpFZQ0LqTjQlhtqmIJXrDOstcTRaQAV3amwkajRdQ0fBD1k8sRVG7fA
Message-ID: <CAGJdW3G3+Wjm7rGyV1Z2EYtbXQ=j9Dx7yd3QCvy6tsk=U+L6Cg@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] virtio_net: clamp rss_indir_table_size to VIRTIO_NET_RSS_MAX_TABLE_LEN
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Thanks for working on this, and for the KASAN/UBSAN testing. However, rat=
her
> than a stable-only clamp that deviates from what upstream did, I'd prefer=
 a
> proper backport of 86a48a00efdf

Hi Sasha,

Thanks for your reply.

Sorry, this is my first time submitting a patch,
so I was unsure whether it would be better to ask for your preference first=
 -
between a clamp and a backport.

I understand now that the preferred approach is to prepare the backport.
I=E2=80=99ll send a tested backport once it is ready.

Thanks!
Annie Kim

On Sat, Jul 4, 2026 at 11:06=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Thu, Jul 03, 2026 at 07:50:59PM +0900, Hyokyung Kim wrote:
> > This was fixed upstream by commit 86a48a00efdf ("virtio_net: Support
> > dynamic rss indirection table size"), which reworks the driver to
> > allocate the indirection table dynamically. However that change is too
> > large to backport to stable. Instead, clamp the device-advertised lengt=
h
>
> Thanks for working on this, and for the KASAN/UBSAN testing. However, rat=
her
> than a stable-only clamp that deviates from what upstream did, I'd prefer=
 a
> proper backport of 86a48a00efdf ("virtio_net: Support dynamic rss indirec=
tion
> table size") with the conflicts resolved for 6.6.y and 6.1.y. Staying ali=
gned
> with upstream keeps future backports to these trees from getting harder, =
and
> avoids carrying behavior that was never reviewed upstream.
>
> --
> Thanks,
> Sasha
