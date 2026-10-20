Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792527591;
	b=kZ4M3u9IUBzNiWWgiKyQwvDhJ0cM3aw5gzLWCSGOmKl6NQE4OGNOOhBqknuzE+/koWmA
	 Gom2v+2EUMh/rrt4dy60RIuqe0/rH8sIuLaButxijv/LhxU+BJaLQH2lqgOyHm7tVotC6
	 8YLecyqHp18OoHyI0VEwLxaj5gvdXXUwh1Y2qAOawyCgVYoP1TO8/MCNmDoC07UzwQfM7
	 4UAAT0Pe6KruSFW6+TgdxBSA17H/yCQ8YMRvpQQYLF5i58BQwTasZgD3PfR+LTkOSKRo+
	 +DXgLsniFmApd7Av0qji4UzycrM6gG4VwzWYMpMmjQyFoWdn7ElN8spqLI8IpzealrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MRhdzsXjkPnZHHLr+3Q8i+R2BJY5HtmbkjLcsOK9Zzw=;
	b=mB9qTeERo/Ou/DvDy+enuCXZ+jRLKzUuP4x3VL1Tcoq4ldDOS55W/bcIzM90ywbdHMcE
	 IRYmoJQ5Av/2Xe01RnpnjKIEwgso+u41gnrOsyH1szwryKV8Ja2HIJ2sQuulNsXeO3Jcv
	 oCwlYRkB98Ez/pwhzZpSlBSfHdx0U5JGe99xdvvTwJfoXZkhnUm/0rsvds3B3/JF+CRFh
	 Dy3v/j++QQmN1EYHYqKCJOgLBDxniINyKoWXivk+a3QTGz/kxF3qLAWNBPzeWq76mPiF7
	 knMuOCe9uWmqs3Ug4/brf2nwrxKh+2Fyqjl5nrsmNxpNMVatP23efKJIkKKHBZpeiVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j8nmofGy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2578E606A31B
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2578E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j8nmofGy
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49d05d51553so25666675e9.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792527590; cv=none;
        d=google.com; s=arc-20260327;
        b=HUCh8PhBV13Z4zwTCPokbHG7IiBV9s5u09+Q/XC6QKa9DiU1ALo0OYKYsDfRTRkDfZ
         YtzA0t8chJW55x6BsQfDMDfN90E27NeqxMmmmjvnBc6Y/TFBfIj0c0cPB4GhScgKSJ70
         w/gsRNR9Vax7TqsFR1hcpdlsZwdVzqqrf/pUVct+XBQOG324BZnmMFYAEHAVJ7X8O+td
         NLWEYp2cn8BZL2n94lBsWlyP4amybVkZElcQbdOR0IxH1uWHIpvpfs2nt/DhVAhpnY/b
         PBkGkStS3b8LE5XlT3OY5ZS3d0dspxI+RZ6TryYrRTZpWfdLjqYWk2mhhFjiHlccwadF
         m2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MRhdzsXjkPnZHHLr+3Q8i+R2BJY5HtmbkjLcsOK9Zzw=;
        fh=6AVZdQZm1w+R3IGjfzvRQ8+Sxz0L/iNZCkhr231Z3Q0=;
        b=ATD1W63Kgo9FDVTLjVysq7gMHAhmjVn0ozkG3gJr53ElCpN54N7ljU9mScocOiIP8Y
         mgm6Cm9D1QnA7hNXxPhU3LWuCaJs46AlghnsP+3Ydcxh/v6b7oPs9LM9xV594TRe2E5Z
         P28hzWQF/lOan8rqmvxRuVbbHkGp7P2iM2vYzsm8TIcliJAa+cGLVMUHZH5bRoaHbBmV
         Q1YcKhsy2VTeOhMIDqYuHf2z1oyQcOxGubmXK6LTtKcAYMByn1hOuTAZhTnBlVMNfvcR
         A962jeiwvp1scjLPrPnKoeW776egCVs1cKja6yn7T/Xn/s8U/Z4MiDU0d5PzzFf2qBAV
         q0zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792527589; x=1793132389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MRhdzsXjkPnZHHLr+3Q8i+R2BJY5HtmbkjLcsOK9Zzw=;
        b=j8nmofGyTJP3d+Aj8hJjpcskIYke1FWfEm+/ciY3MWuek3/agZNaO6jBHreRliLv/H
         Aiho0WyE820F9AzerpvYKHPsDhdHFJisad7hnky+GglPt4lLWUt540+ZMvneRGdZf0FO
         qnRbdt7UNEwoCHN64NHHPPaXQuPGGM2bb9hPn3NE3HLPbBaMDnoePfV+hW/EKMGfV7p1
         4T7dmzxc5S/tHrTkGU7UHMQ/t1aa/3+j+OJegaYoquB18AfdgmK3odddKaxVJlLcYibL
         +rAjKaOIUvgpJ7FDaHN82cu3HU9j2IOvG7Bsmw8Dns8Kjwn/E5nMNSMZo4Z0oNWNqG1X
         7rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792527590; x=1793132390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MRhdzsXjkPnZHHLr+3Q8i+R2BJY5HtmbkjLcsOK9Zzw=;
        b=OrnFrw+5HjV7uJTSr41uwZDg0N7w7i1OXCZP80Xt/d4nDaghQb6ZNqjIUEfzDp9c+h
         gzyjrAPpLAtcGC8zn81GOcvUcTy0TNW7EpkHynIczSF/ozO8I27zr+cCtzn0cVPY44Yi
         ioqwZ/AolFSACfbaE/L80mDOgwOA4CjsEixzrOGRKtuqpg2GoW7zWuIgyCZaKFu1uh9R
         pw9mFZktZQyBDdTFMGHBXSZ5cPbhZDMlNP9iDy+AISUIovYfkUCRi4h1ldfgCuNUYPZx
         FJ1PxmVmDO1cxFuk4j70aDjW3/MPomkBT739Yta07Ijf6AaOgxoDQTK9eAGv3sHkYpOt
         aK9w==
X-Forwarded-Encrypted: i=1; AKwUvBxgnU9BZrlKeV0HNzO1XiMsmynuiYApMEFd1E7nDIDokdV93t8uD4wfuulBRN3buGVf6jJ4cuw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCzqhlCoza8YP8oHJfSNkRc8tFTlS5ezdM7/9yL2QFWYKzkfTi
	/Az1hQIBnbm3guRXXSljdfs5V7/j8HLluiPmkZ9UFvT67Bmr01jfuqHAKJVHdUNm0GVl3MsfLOD
	VtTGMCtL3oYVSZHuOxve7u89QpWxIndM=
X-Gm-Gg: AYBFou1O2mpZcd0MUD6jisuFePn0Lkihttfkmag/iD4EV1d87msnxxAy7tu4jonZ0N0
	ZKpzR5iXyBFzXMbIt8vWsOIO4r38duuqQt2QEe2sFiv+KjSG9tbt1U020bMfpon13bcHwHlNWQ0
	/XevBYHdPJFuFhEZmOtJ/rhqZ+D59gmPeQ7hlu/FfNYruItL4+fYW+2UZav09Iga6PLZqZ60OxC
	7IBm6zocZbkY69KyVZFZbpsqiMPSes9y24l8v94SHGuMKb9eFoCEc/xMNS73nFoUe7OGMnv1Uh+
	w4yPWIYMaOgIuXqKftatU87+8uhwgma2BP50+sxzFZSdRKm84NQlJxohmrp2Tm1CN99g4rx9d/w
	j+KTgE+kMl2cRrh9P3d4ebpv/6WWpUwlR/Xd+YYliSo1hRuhGJDOUpEZnOrVMWcbOzL9XJDI=
X-Received: by 2002:a05:600c:83c5:b0:4a1:faa1:3813 with SMTP id
 5b1f17b1804b1-4a1faa1386cmr33962685e9.27.1792527589379; Tue, 20 Oct 2026
 13:19:49 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019160615.2348500-1-nphamcs@gmail.com> <CAMgjq7AEg6XEUJPaM3mMBQAeS_KiDv8_za4w-R2WaZ=ZGenvuw@mail.gmail.com>
In-Reply-To: <CAMgjq7AEg6XEUJPaM3mMBQAeS_KiDv8_za4w-R2WaZ=ZGenvuw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 20 Oct 2026 13:19:38 -0700
X-Gm-Features: AclHuK9xKTOFZ19xiMZBkY3q582rEW0wqbjhnZMOWfykMSCUkqYNJyTrgcZkxG8
Message-ID: <CAKEwX=O=PL3DEaEDe=F-=zhQ=VW3_UtcqesdX9fH_cr6orb2wQ@mail.gmail.com>
Subject: Re: [PATCH] mm, swap: revalidate populated clusters before scanning
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 10:58=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> On Tue, Oct 20, 2026 at 1:41=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > swap_cluster_populate() can publish a cluster's table with the cluster
> > lock dropped. A cached allocator can use and empty it before the
> > populating allocator reacquires the lock. The resumed scan can then
> > dereference a NULL table.
> >
> > For example, CPU1 can retain a cached cluster offset on an SSD with
> > per-page discard disabled:
> >
> >     CPU0                          CPU1
> >     ----                          ----
> >     swap_cluster_populate()
> >       swap_cluster_alloc_table() fails
> >       spin_unlock(&ci->lock)
> >       local_unlock(&percpu_swap_cluster.lock)
> >       swap_cluster_alloc_table()
> >         rcu_assign_pointer(ci->table, table)
>
> Nice catch!
>
> I think the real problem is that it turns out calling
> swap_cluster_alloc_table() without holding ci lock is bad idea... I
> think this patch still leaves some other call site too?

Do we have another callsite? There's a callsite in setup code, but I
assume that's safe...?

But at this point, who knows any more. The caching only stores a
swapfile struct, and an offset. I wonder if there is a potential race
between swapoff-then-re-swapon and cached allocation? That'd be pretty
wild.


>
> We may instead add a "bool locked" to swap_cluster_alloc_table, and
> let it lock the ci first before it does any assign (not the alloc) if
> the allocation context is not locked. That is, keep the
> sleep-allocated tables private until swap_cluster_populate()
> reacquires local/global/ci, then install them under ci->lock,
> something like pre-cdd77f84d966, always assign it atomically.

Hmm so a bitlock?

Lemme think about it a bit.

>
> That should also cover the problem reported by Kemeng a few weeks
> earlier too, and prevent further misuse. My Bad on that change :P

No worries. Lifetime is hard :)
