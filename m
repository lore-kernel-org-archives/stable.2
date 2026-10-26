Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793040264;
	b=XGYk7JgJFMlKYFHZoyNznD7VOvyTkYZsmTNlq2zXlHbahZB0AGhzrhtydEnOM41EfcSq
	 vTftd5afOcfJQDcirEWRIHm12Sdi/3Gk71t3q8Y+V22dxVvNNBZFOlCKsGYCm1SO0v/6R
	 zwYCyosE4b1+53w6+Gk77+WyKo8g4zJHVAvnp5Y/q+W1wE3dslebfcg5tZFXgBjxcKmO/
	 +OJ5Mc6uby3d46TpPNQR0REr+bA9kwpLmqEDqgeXyIZoit4ACM/5TWp30QFxsT2QHW1Fy
	 Lpg8y5+TQVWL2oh9FWyupVwa3GNfLfUhotJez5JwOulOHc43Akj0YtIlsKuwSr1dQsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040264;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=46y44saD8P5rxD+OY5cJ+zq51H1Duo7SHt2Bubu77+E=;
	b=3NsML11EfBhaH/kKAIQzYb0uLSnaQjlRw+ojJQvtIrdJWTF91GM3/SbvBGG4gGQDrHRI
	 EyB5my43R8BwXAT36MfsSd6zTiJIew/j4gXe60kLrW5rsAJxisMjQAf4sT2IEpY05s8xp
	 MLNSwo+K4YgnmC14pOiCkgv9ppOIYhKp40TkSFX7JZKQXdAcjNB9ie313MdxF9FwmoaXK
	 oifnD4oxBz3S5nVRwn6rMT5kZjbsH42S6pKsRa526OgSwCkqR4wJAyzA6Q8ChgMep6hne
	 w6aJUwHfdRek/jF9bd/Jx3NZDryLjV/V7Iuv2btuk7+SZeiIjBAm7Fo4eFjepHwyHnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZcSiTSg2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F14606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 18:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12F14606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZcSiTSg2
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so13745455e9.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793040262; cv=none;
        d=google.com; s=arc-20260327;
        b=T63t51J9/62vqxUq0rRUg2DaMxzbCB77nAaCaeBtW+HnPiT7H65TCaFahH9ZiEvPaz
         1+tT3ofOnpmaKs+PEu4FD6jYDOmZ5Bpya34+cN/NQlXk+VAEI4jYuBNGjI08f/lVlFmB
         eRLlWNtY1yqfEES3PK9ePZvC9yriHz1rFqWy6aXtE4s0FpsBAgcgyjFqtrB2EztXSE0w
         g1iMJTZXHhU9mJQSDQhhozYB4rKNOlAgqghmzpjuPt0sOWyG6r7ZQLblkcQnv2+ooSJI
         xjYWhS2O61zg2oZsflOQlFqUKhFnQfYFrH4Ms93iPYs2wGm9EUMnL7G7pxDzsk3/K+P3
         zP+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=46y44saD8P5rxD+OY5cJ+zq51H1Duo7SHt2Bubu77+E=;
        fh=2hK+5PgSlhmEy7VWKD7mwa/e5yg8Ga8oJitvYRPuzoo=;
        b=bEokzN9I4j5Rfjs0Iebu5Uhr3sFKigqRnx+Yvq46n+wAfMpSi6tdI05zWKLNjoPtAa
         gDTgvapry6rSETkKf4JmlVYbIOoCgd365fNJv/XxYD998MmWlsTtZFyxwJ2PYkca4ZcW
         YByivmukV36HaiBTnh91fa/BASr1B/mVY5MKAmJ/CLutMGvXX2StCg2QO/4QZU6OL4Cr
         fEKWw6lIU6HqXpFb8WhW3n5RYStIiP2GkeOUySE/FRSKz84702bIc0TsLhAltDxcqBUM
         pacqjObGvvrCWoQHRSpEAQiZqnQiREsCdW2FA6mGahKQ0N0Y9vMUls3iF6ZrUIfc7DSA
         jU7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793040262; x=1793645062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=46y44saD8P5rxD+OY5cJ+zq51H1Duo7SHt2Bubu77+E=;
        b=ZcSiTSg2kXT0fCIGnN10QbwlnCbo5gGNO8C4qOdBgTzHsRR/uy1Bm3/Hbw+fSQRCq3
         fWPUaZCfsA1c0dBZNRTjmzedx9OV9Dr3h2v/oU2IARMzpqYsFRitDZ9CWvMNI/jXHumt
         WP4LvJdCBC9rlei59OqwrB5GjTQKzOy90WqsgOdXXxvzO1zw+Zcs+ssQANQ+5gvIqpzH
         x5JWrhtigQQDFJK5YDxpxdKQJrxc/DyCQ+EOvCVMT5VvvkEci4ICwnkbBwAgEgjTbOoS
         0n4+7lIeaf8nn5Gv1E90QHxIDlXZwmVaI2GRBBQnWXAnCXkUROul7o8n10yjiGwqKzTA
         q15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793040262; x=1793645062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=46y44saD8P5rxD+OY5cJ+zq51H1Duo7SHt2Bubu77+E=;
        b=l6TlmtLIrD/iOG77Y+cFxrSphQZ7MJ8uiV5f4n0aMzW4X7isyq/7KJH3Lq02Ngk3LP
         ToBa7pLzlKpqljjJrjSA+2EoIPzC1L4zWQvChq0lSuxT8iDYxcv/JhcgBk5EuMnpOqdK
         Is/JquVvgjeZ/FrfToBw3zbIiimOAQ7G/TTJU1BuMFLq2SaNTNWKH13NuYugfROok+Fg
         Onja/aO3VRsX7Lyq5ZBl2GJM9y+Ipbiij7aX703muAAW8gdDFEzWx8XJCDSf7MLJ0BYm
         9GqUhHaWgbqJkdsPq+04BbXmImflr8GLjBVt/wdoegBkWcEmvPUfHEz0wbWe+YNbkONJ
         L6sA==
X-Forwarded-Encrypted: i=1; AKwUvByc2MTEX5WhPwdV0+K14SZS+aFW+yd0d7TjIa3y2Tpk9IkH3M+qWnq3VhP9GRZH0oS4d5Vq33g=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYOOaK6fBDBGw/zIAg9Vkjf02nHleNyUd08vzXef0vp0KUGcV0
	nfwMqDJpouSywAO6Xb2cNI0AspTeQTMyGvWf5q2vJ5a8Jpq+y9nPBPG/e3eB98/2UDItTcR1uib
	QvaEoAdlziD9PikMS0k+IW9eeQYyTm4k=
X-Gm-Gg: AYBFou18hiOlF3+Oyv5E93yL9v5jhb1p1/9BhiYGJaE/BPsJ8EL6KvwEx1pHBEWUqcI
	2TI1+dQJ8W1tzNS/Gp4riic3xt8xpLH9kbwy+eUJFXN3ND4nk+4WxbbQRyEODWFSMYoegXFICM/
	7iUht5p2b8whZH4UUvhszna0qcx/O7FNMA2kx022btgSPlF5LvRDcT6QHsAyfttm28LKHNB4rUl
	73GnjHYvO2Y/CxZTVBC/zaNqPYuW729fTu5m72jAJcoPkD8xyME1QIkodVsFTKx4o+PnsPsEy+n
	1Goreg7BGkC0kSNlpGbdDP3hgJ3dheY89aDEqlknyk+0RBOy2XpnmQtv0mRbeIFGnYYQ36WlGt7
	hLPbtWHx9lnr4Jsuz730BaXYmPQjKCkIZDwnvM0pF4nwPDB/Ivibm10aeIWfQXOVAeWx8vX5HWC
	dzyvHzAEe+DiVDbVdbhH4pez4Gr5bnnsMBQGzHAm1lMVl8OjSG9okj
X-Received: by 2002:a5d:5e8d:0:b0:48e:6f:19b9 with SMTP id ffacd0b85a97d-48e3eb83497mr12334198f8f.23.1793040262329;
 Mon, 26 Oct 2026 11:44:22 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-6-703206d5fa0c@kernel.org> <at9hs0Unq0EOg2M2@pedro-suse.tail5790ac.ts.net>
In-Reply-To: <at9hs0Unq0EOg2M2@pedro-suse.tail5790ac.ts.net>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 26 Oct 2026 11:44:10 -0700
X-Gm-Features: AclHuK8AArvz4X8t1WY3GQA4kuy3-FUfTY-4j5HzxhSUW6GQg7l6zLPND04oXb8
Message-ID: <CAKEwX=Nkd5057Yze+9jbk+VQ+b7i-5x4EorQCyK94qWetOb_1A@mail.gmail.com>
Subject: Re: [PATCH 06/16] mm/shmem: hold off eviction in shmem_writeout()
To: Pedro Falcato <pfalcato@suse.de>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Stevens <stevensd@chromium.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	William Kucharski <william.kucharski@oracle.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 8:14=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> wr=
ote:
>
> On Mon, Oct 26, 2026 at 10:40:39AM +0100, David Hildenbrand (Arm) wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > Once shmem_writeout() has moved the folio from the page cache to the
> > swap cache, the folio lock no longer keeps the inode alive: truncation
> > and eviction find a swap entry, free it and do not wait for anybody.
> > That did not matter as long as swap_writeout() was the last thing the
> > function did.  But since it puts the folio back when swap_writeout()
> > returns AOP_WRITEPAGE_ACTIVATE, it uses the mapping and the inode
> > afterwards:
> >
> >   reclaim                               last close of an unlinked file
> >   shmem_writeout()
> >     shmem_delete_from_page_cache()
> >     swap_writeout()
> >       zswap_store() fails               shmem_evict_inode()
> >       writeback is disabled               shmem_truncate_range()
> >       return AOP_WRITEPAGE_ACTIVATE         shmem_free_swap()
> >                                         destroy_inode()
> >                                         ... RCU grace period, freed
> >     shmem_add_to_page_cache(mapping)
> >       xas_lock_irq()            <- use after free
> >
> > swap_writeout() behaves that way if zswap is enabled, cannot take the
> > folio and the memcg or one of its ancestors has memory.zswap.writeback
> > set to 0.
> >
> > shmem_unuse() already added infrastructure to deal with that.
> > Reuse info->stop_eviction to protect the inode during writeout. Increme=
nt
> > it before removing the folio from the page cache, and decrement it afte=
r
> > swap_writeout() and any attempted reinsertion and inode accounting.
> > In shmem_evict_inode(), wait for the counter to reach zero even if
> > swapoff has already removed the inode from the swap list. Add some help=
ers
> > to make the code easier to digest.
> >
> > Fix generated by an LLM and sent by Josef Bacik in private.
> >
> > Fixes: 6344a6d9ce13 ("mm/shmem: writeout free swap if swap_writeout() r=
eactivates")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > [ david: code cleanups; improve description ]
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>
> I've been looking at this for a while trying to get a smoother fix, but:
>
> Acked-by: Pedro Falcato <pfalcato@suse.de>
>
> Things I looked at:
> 1) Could we just drop this logic? No, it's fairly recent and seems to hav=
e
> impact on zswap setups with no writeback.
>
> 2) Could we reorder swap_writeout with removing the folio from the page c=
ache?
> Perhaps, but it would be a larger change. I'm not sure if the logic all w=
orks out,
> but you could possibly have a:
>
> error =3D swap_writeout(...);
> if (error !=3D AOP_WRITEPAGE_ACTIVATE) {
>         shmem_delete_from_page_cache(folio, swp_to_radix_entry(folio->swa=
p));

Hmmm, say the backend is zswap. On successful zswap_store(), we drop
the folio's lock (in swap_writeout()) before returning.

Would it still be safe to delete from page cache with the folio
unlocked? :/ Seems dangerous - without the folio locked all bets are
off.

(analogously, filemap_remove_folio() even explicitly bug-out if
folio's lock is not held).

Maybe we there is line of reasoning to prove that this is safe that
I'm missing, but it just seems rather shaky/untested...
