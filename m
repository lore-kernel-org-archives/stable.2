Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794387462;
	b=b9hhsKEW4gliaKmHbYS3Lsgyt0OsoewDCLiWKjzVEnBt1Xgqem+j0Ja78Ogj92BYUpei
	 HdSL2soEQ2/XM8+qvTV5fAc/DS+iUtyRkB2qLlTShBmdIS2CrqXGRNj57QeEoSvPYErDT
	 H6Wudw3u/Ce81tDdp6OHyTUrLuaPjRtNkPEO1jdS7u1slWdHdfcaUGhFpIcFFaNMjaeUW
	 vQl3cMoJ4VvFu/yaf7Jch7rVgL+JOv7/HIH/A0B9fTP5mmlBRlPgQOFX1CpE4SwGg5+t5
	 DkLJo84b8dOQPdyyE262VzXprv/zyaK0XlPHpoZ9tjPB0mRdiq37qIGylsm2jpDZ4GA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3+2GeyeiktPWIYhPCUX0ezs+W4stQcbxkOT2VYFqeLA=;
	b=eLNHMLTNB3Pu22dQE+/oy0XvliAPm0OGE1Sn3FCM9fpP8+SYhJvekMnecppWaDBOSaUl
	 tDXBXRWI3CbKAfZhpJGiEtvRcUpquf1SYmk/Zk2r99mqNki2VSXnuSRjWUlWTadswB6Sm
	 P0bPK544IKbUMbDzoV/oR2+AvLErBkj1Neb94qXNuerGHLLjppysbNod9JhDKXAuxqET0
	 GZYEqPR3bIi0JuKl9eZ5uQ4NjR7kYIjy9wyzggD3/Z+z7SeXESa8Wa5ot+0p5B6zciLeJ
	 BNbKErd5bDpMyaP315SPUquc4T4Q/q7kc7DZ6NJgs3RL2JkjHV8ZOTPSm2ZMqqN2A+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TGnWN9hj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AF9606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31AF9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TGnWN9hj
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b5669a5100so3906794a12.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:57:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794387459; cv=none;
        d=google.com; s=arc-20260327;
        b=hI2+CTjOj/xFNIzyxgGR8/0B3lFPr4/PqwkDhDUQtMR04ywPqLL9VW+blX6e1JTUIm
         Qx7RUxJ8DtC4TZu8FZ3GFVMpGU7rob5nFvM+0GOUMxQZiAEHj9uiOX24eUoAPQxajXYL
         Tr+0pLOgF6en8OJhCddz1U4UucKCNCLnyHiw6ribBOZPgqO3HBw5u01AWnMc9omgOTEK
         tkEXshNT+3Oa2BJfZGkQ9hCKJCm4dzwtXO1Af58MJ1M1RNbVyjYOQCHFyXiQx8bPGwqJ
         xdzibKKlLcLT4QkWWj6nHns9CS4e2WEy+2GEj+k4NEaqSF7yDcXVdvSyt3yUkuD1Vn+y
         pWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3+2GeyeiktPWIYhPCUX0ezs+W4stQcbxkOT2VYFqeLA=;
        fh=sgikKwTBBLyKCxVA1EjZbmy3jiawykuk1xoQ9KaSQUs=;
        b=RiNgrQuv0h86wel5qMJNXFsiuGAiHT1jFCYbUVwQ5gNIhXMD4XGIi1Hg12elamAfWd
         rSQYjOb1RNVY32IL3dS3yAJ0upJESH1uWl+nqYXiagfNUl2PQZQgJNrppwDY3kvx7vjy
         FWrcu9IzkDAVMrGbzU+vW56w9KsLNitEmEQqRFq4TPZS+LXomWQ3xvf+YWqYKATkFP8q
         IqPh3vDghCXZCYaLgz2E7IFlxZmnFevDRLsGkhDNomqgWju8XwDVp97JRlUkDGjt1YJU
         +rVJsfgM6s26SyqK/AcPuUdIaNxRPQk2xQavHIyfoONHtqZh6tmVRueXcoTFfrTSA+NJ
         NVlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794387459; x=1794992259; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3+2GeyeiktPWIYhPCUX0ezs+W4stQcbxkOT2VYFqeLA=;
        b=TGnWN9hjQkXsTTeAcowXaHsysAVtv8Dn2mB7VX/EUjS+uxdheNbIVJlJ9ydCDUh6tp
         TNM23Ari3ib+MIkMQ5kHgD/qIv7yzwE4g+aTz9mMiR1X5RxfF3GwqMzuaKGJHoB+X927
         f1rp0VyfA9JhPEWktc5thMRIXvPyMQYVpHggYrXg+01EtVPXTc7Mddc98QMDFV6SmDRr
         4d0mtyCrC+0V2QmXdl5U6X3d2gYNXCUKPtTGpdt50nSPMB4MZcVtwP+t1Ami5xYQMBFf
         23xdUhbRjKW6eVYSDOLmauod7zPsS7cSug29GV17BVgOXccMeT6uaoW1m4c4VnJFm9EG
         GKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387459; x=1794992259;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+2GeyeiktPWIYhPCUX0ezs+W4stQcbxkOT2VYFqeLA=;
        b=LtipJ4PvOfY3aT5LRojR0p5mb+BpX3DZKkyxSnFEQ8bdWOEk33Vu6PLMTd/mGxCzjg
         E+Ee52qDSaxt6Cyfq3jijVqw4WFmYGaa+pp6f9wUBaGbOse0YzTgEjAWfOJcza/1cTLr
         AHoW9sY0f+PhhzlEs7JJW4oOqk1cgE6ujfVgnyb1hSSsXl8XlFTuJb98rgmZqgFhFYdC
         C3QYnHYVkDS5WmR4+ApeCLUVOE0tX15scmX9ARtxiglTzlwmP5DrjbH5zMBSXVSQFNRT
         DPld610CSSGNZmPd2m61hSBESvQMJcsjGe9OsQ3M6jAoXstfd6kxuRBjSeBeIontxUXp
         3INQ==
X-Forwarded-Encrypted: i=1; AL+hErExhVtWFNKD+UMl84ij/gYeOOF26jyErU5Q/CjprWS98sBUmaViDrKAv2wfo+c5qrRInI34KEE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ifXMVUBZeQ30zdwTx0X8pWcw5RznJPfSFgolevDK0eQNjqm5e
	VWtVOG72O7n2ugyW61oBRsN6OHZH1/+S+OzXttFPVqflWVD6x5V3os/xedfB1Zzi+YD8LszP+g2
	DR4DhM49hCgdBpCUmLx2Na7yx59CW1Ic=
X-Gm-Gg: AYBFou2BWmlB0S2lXHNZf+YljrYlfJjToZXPPoZsZOUmyMxCTNHSHtSGG+WvEWaCOMD
	+w+4zZy5QmvAJPojxEhqS5Qu2Hp4nL1AgNW/Gsc+VlH+UwYjdpng+8YiZMBeA2ygYzpwjIcHsfd
	oPLlxBugcuWlcGUWQvAt0+vqworfpW00ESUQy/13T2Y4PhqtERYfoGp4QYP+JKXfKbKHn4m7Hd+
	w+oZh7UjKoLEbnHWclr/XrQmZklikClUYdG6Tc4bUx06qiiH2upPGz2DL7SYEE7tYw+SeywbAOe
	0UItzz+bRZXiiNcww2sVoJXEyDmP3/2BFXU9Oa6tzwuRr1lA1zdUNvUsxf8XPp+Dk8VeTzOfwUC
	bfbcq8fJpcyvu+9f6REodtXAMekG5NRigi9iOaM9W08dbqbxaRH/4eCFg78Pwb1zPQXHIQA==
X-Received: by 2002:a05:6402:a512:20b0:6b7:dc8:c814 with SMTP id
 4fb4d7f45d1cf-6b7775eba61mr879038a12.27.1794387459367; Wed, 11 Nov 2026
 00:57:39 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111000913.22943-1-shakeel.butt@linux.dev> <CAGsJ_4zRycX9dcW6P1J2R6f+xyO4+z6_LXz1i+qbNbMEnYm9uA@mail.gmail.com>
In-Reply-To: <CAGsJ_4zRycX9dcW6P1J2R6f+xyO4+z6_LXz1i+qbNbMEnYm9uA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 11 Nov 2026 16:57:02 +0800
X-Gm-Features: AclHuK-Ok8BVFpQUzx9SWnWjlX8eBeANeatd5JCiC55UEIemRs5iAoKwKc61kM0
Message-ID: <CAMgjq7ATR2RDZBg97ihoqDV-G8dEA+8XBy-G2xujVC7ZmMX8QQ@mail.gmail.com>
Subject: Re: [PATCH] mm: mglru: splice all generations when reparenting a memcg
To: Barry Song <baohua@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Noah Feldt <noah@feldt.systems>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 8:29=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Wed, Nov 11, 2026 at 8:09=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> >
> > Noah reported list_del corruption on single-node hosts running 7.2.11,
> > which already has commit bf4ade7dbd76 ("memcg: keep folio's objcg same
> > as its node"). The bad pointer is an MGLRU list head in a freed
> > mem_cgroup_per_node:
> >
> >   slab mem_cgroup_per_node start ff31bfa36a3c9e00 pointer offset 528 si=
ze 1920
> >   list_del corruption. next->prev should be ffacf881ccc70e08, but was f=
f31bfa36a3ca010. (next=3Dff31bfa36a3ca010)
> >
> > When a memcg goes offline, __lru_gen_reparent_memcg() moves its MGLRU
> > lists to the parent. It moves only the generations (gens) from min_seq
> > to max_seq, and it puts each list at the same index in the parent.
> >
> > A folio's gen in folio->flags can be ahead of the list it is on. In the
> > parent, the same index can stand for an older gen, so the folio's gen
> > can end up older than its list. Once the parent's min_seq passes that
> > gen, sort_folio() puts the folio on the list for max_seq + 1, where it
> > stays until the next aging.
> >
> > If the parent goes offline before that aging, the folio is not moved to
> > the grandparent. It stays on the parent's list after the parent is
> > freed, and the next list_del() on it touches freed memory. This needs
> > two cgroups on one branch to go offline one after the other, such as a
> > container and then its pod.
> >
> > The parent always has MAX_NR_GENS gens at this point, so every index is
> > valid in it. Move all MAX_NR_GENS lists, not only the gens from min_seq
> > to max_seq.
> >
> > A reproducer that drives these steps through the lru_gen debugfs file
> > gets a KASAN use-after-free on the freed mem_cgroup_per_node without
> > this patch, and no report with it.
> >
> > Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios"=
)
> > Reported-by: Noah Feldt <noah@feldt.systems>
> > Closes: https://lore.kernel.org/all/20261110132853.71228-1-noah@feldt.s=
ystems/
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Cc: <stable@vger.kernel.org>
>
> Thanks very much, Shakeel! I saw Kairui has exactly the same code here:
>
> [PATCH v4 14/17] mm/mglru: reparent folios from all generations
> https://lore.kernel.org/linux-mm/20261016-mglru-fg-v4-14-2106750c0bfa@ten=
cent.com/

Thanks for looking into this!

FG needed that because FG's folio_inc_lru_refs is a generic MGLRU
lockless lazy promotion, it may cause race between aging & lazy
promotion, landing a folio in a stall gen list. This isn't a big
problem, the worst outcome is a hotness inversion, which happens
almost once in a million times.

And right as Shakeel pointed out the problem already exists for
reparenting and lazy promotion, so we can fix it first.

>
> somehow, Shakeel's patch makes us need the change earlier even before
> mglru-fg lands?

Landing this one first is totally fine by me. The code is actually
safer and cleaner, in my opinion, with this patch.
