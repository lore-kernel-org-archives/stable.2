Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C63D0919
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189201; cv=pass; b=touo0547UIzGgZcWEqLkizuvmEDrbXuvVGQiw3o0qeD4uzhs27+EWl07GOLiBYGqxOtSk15jwCHpJffFOZX+YLW8LEWNVowHcYfmbixRhyrwYiuLVllp6QKgvD8CbDWMAFQTxAu8cJ5xjnA6nK9XKMpL1/84TOdZoixZVaaoKrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189201; c=relaxed/simple;
	bh=g2RpCD6pPbG0jDZvBkn3q6Al3Jxnoi0KYgJ+ZRe5j8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGzmPRFZaIG/bWXAyoZ+RmizRdmTnqCft5m/1i7MtcVqZZ4DoQowylmnfO92ebaJSkRixQLUW5bkQUzETcBiIX2R5ytlr25ms8OKhYzZ8PdRxrdAI9mhn8mfGfcpcB/uZefrjWaShXOUrwfowtTey+r/v+U7FF1ZROwgMa8XfvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q+h9E66A; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+h9E66A"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93c5b7f5bfaso157871385a.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 15:19:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792189199; cv=none;
        d=google.com; s=arc-20260327;
        b=MTki5s9YnDX1i8pnBU7y7YdlshodygVjkAP/2DU1E6xoiv/wwNbk7qUYuYM3xaR4hx
         xJkjhuWila4Hbinhm3ZZILClvhNgzHKqtn91fnCjuvuKk/cwwWcV1rbHJ1QBq1uRqSoW
         ImH6kedrQNYJTPSPi7Pqxmvww4PBe/1ltorFcfYT1WJMKQSAssDjqapy+5Z15hS5EdSj
         FLNU4SUySkGZlMXH1wAtxvBHpYwYfb3kV8QEzUwz28ssgr5h8xgto7rndshuIme3UKnh
         f7w/b3yYu8u9GxzFcXIoHvmSnF8/VUHw16SMYu1SyN67fCrWWv7r3V+XSUWlSfftQt9x
         HClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g2RpCD6pPbG0jDZvBkn3q6Al3Jxnoi0KYgJ+ZRe5j8s=;
        fh=VOJADvUD7AgIdLpJDjwzUcMVLEy3GKwQQYY0DOqUEYM=;
        b=X3Hk39iRNOusE4Xu9IIsDbTecbXswGbA//52tiaETAlsDQdnVOj0/ncK8+eUYX7dCT
         YYr0v5PpoTpRBtTKVU5WV6grqX8uK2bHMGJ0lCg0ExARUX3LCRsk743tcrWvilsJmsYN
         TTCtMxv9kHQaPn9vSVes9uA7qxS8cCEh24qbc1gnJAo8GBMHGxYdgPpUCpv89xQSWTd2
         j4v7ZL7IwcB7/cmgjhsMNEIO3jKz8RMQG9K/nAFL2ZPnzeS9/AfOF/gjLpEDdZiCeSJ2
         vDEUpERK1fkoCDI5UdunrHc6zrNUYBcBSu8FSPpntS5njMC1nMH7ZsjqcHIQfFHVpAnl
         /qOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792189199; x=1792793999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g2RpCD6pPbG0jDZvBkn3q6Al3Jxnoi0KYgJ+ZRe5j8s=;
        b=q+h9E66AaU9a48mn7wf46Os90TFjyXXo6AGhW9dI3rum+Zv87n3uKJvVEXJqhn/rEm
         E9SJ2l69Ir6398j4Q42XnL7wxMth8EkQKXJs5/nMJsfLSc2VMdqS9hexeo4uh6SbvSfF
         xsObDOJa2nbsK+3Iq8Nz4q1qTpdNzLYyqPvNNqw09QwPZ+B1f1BCHubTw55GT+8j/Pf4
         Vl7T/svgox4WDoUSPiXZ7Qzc084VKnUjl+qfhI2xG5BNiMye5K8+rLddu4MnjfYOW0kX
         vgXAKCZpNfJ6CGin3La2hmwxqQ06aMmN5+RXhihjqd1/X/T0je/LhCsMUOU8YcfWOIeI
         06sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792189199; x=1792793999;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g2RpCD6pPbG0jDZvBkn3q6Al3Jxnoi0KYgJ+ZRe5j8s=;
        b=ffvgZMlbvUyUaG4MTXMMN60DH0S0jsl6M0o6LErLDkW3Ii3h9THmoH44Mn0sZzhumu
         JnCON6Q8kYhN4w89gm6nA9NtlpvU7VGTKytMNZpEJ79kQtcDawaYMTQ6uOq1oXujsP3v
         V0cUSDs/YP+6+/HIRtDXy26wROtTqu68TYvXCheSvVg6zbcMzfAZ/+elTtcsBmiN5bKj
         HN1SXMIQUCf9QHISA0xAAsXuQsDqUIbGdpYsjmeBVrOYSehebcvyBanCAo9qdeYtqM68
         lfycr/UTxr4lR7GiB4a+SHpV/Nt9rt4/CmkPFJgHpWfz1jHRQasUoc7Ubq8Y46Ju/pA0
         Zgnw==
X-Forwarded-Encrypted: i=1; AKwUvBxEloofm+XVTErq5HRaG58VZph0tp3MNfARnn1U+I9QeQSsvrs8Ee7cUVSNqD08e3zVebgkPc4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpjdUwoaFhlvqV6LTyZ2vRl57/vkQRgZG7HFWeQJ05GsVxCura
	FOOQtYRvkRxcvXllsmRDXcIq5I2A5I2dOqyATKkJjQqbuRpWdgrq8faUVvqoWVod0AMyUNl5wf9
	u2j0Yswo5pkpnK1A3CAXhLTOBl2DQ7HU=
X-Gm-Gg: AYBFou0QlnFMRzy4jnzXjHCt48lIPNpXmTwC344XxIaz9DczhPhrZEwPujIkafl+dnD
	KZ5bJzfXuugfFMBZ8kJs2DG1QL+etPGDYlyPF4jTurkWmeEd5uzN082NIyAM60OWBk3Q58582CG
	V+KiC3P/krMm9Z+Jr9utYAkKu00FU0iYaflRVKuariaTmQoT6cZLR/SJXjw4yzB9mhe8G5OkVYO
	BalEvoBA5cRaop2wf5Iuz/hNq6hAx+QqT0A2TAz7/toVbu8vabLyxKiQ9HqmFGsiiAqCO5isk4n
	gXRsavxEkHn3Hu16xU0QzFIphLRYBC89u9ghrVu5zP+0bC7znX89aEUkCjNmp3c3QL2SIl8TYZy
	Lc5olFQmotbLp0/d5rK6AdwrBm52HyrAWSKkQjYdG
X-Received: by 2002:a05:620a:8006:b0:93e:5de7:fd45 with SMTP id
 af79cd13be357-93f17efcb48mr754027485a.18.1792189198909; Fri, 16 Oct 2026
 15:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026092253-dimness-unethical-2515@gregkh> <20260922153334.136648-1-bub4z0r@gmail.com>
 <2026092320-reentry-lyricist-330b@gregkh> <32446a55-070d-4739-bd3a-d56c4b628e29@amd.com>
 <2026092332-alkaline-overthrow-494f@gregkh>
In-Reply-To: <2026092332-alkaline-overthrow-494f@gregkh>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 17 Oct 2026 08:19:46 +1000
X-Gm-Features: AclHuK_7jePb0TrqT3zGoVqGEPf6lhbuQZGz5zOPfyLgS0sUKe6-z1rwyROI4cs
Message-ID: <CAPM=9tyVcUdb-wjv2unksLV-BVcOxswqB0Y+H7agBU5vYGFKDw@mail.gmail.com>
Subject: Re: [PATCH 7.2.y] drm/ttm: fix swapped-out resources never leaving
 their bulk_move range
To: Greg KH <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Vadim Nikitushkin <bub4z0r@gmail.com>, stable@vger.kernel.org, 
	thomas.hellstrom@linux.intel.com, dri-devel@lists.freedesktop.org, 
	skainsworth@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So I got a report that

"the backport of "drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on
swapout failure" to yesterday's 6.18 missed "drm/ttm: fix swapped-out
resources never leaving their bulk_move range",

So can we make sure this patch is in the stable branches the other one
went into?

Thanks,
Dave.

On Wed, 23 Sept 2026 at 20:51, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 23, 2026 at 09:53:54AM +0200, Christian K=C3=B6nig wrote:
> > Hi Greg,
> >
> > On 9/23/26 09:41, Greg KH wrote:
> > > On Tue, Sep 22, 2026 at 06:33:34PM +0300, Vadim Nikitushkin wrote:
> > >> commit 3db7d7d583419f7b1f2e141e36418802dbb25cf8 upstream.
> > >>
> > >> ttm_tt_swapout() returns the number of pages swapped out on success =
and
> > >> a negative error code on failure; for a populated ttm it never retur=
ns
> > >> zero. Commit b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite L=
RU
> > >> walk on swapout failure") moved the bulk_move bookkeeping in
> > >> ttm_bo_swapout_cb() under "if (!ret)", so the
> > >> ttm_resource_del_bulk_move_unevictable() / ttm_resource_move_to_lru_=
tail()
> > >> pair is now skipped on every successful swapout. The equivalent chan=
ge
> > >> for the shrinker in commit 1d59f36e95f7 ("drm/ttm: Fix ttm_bo_shrink=
()
> > >> infinite LRU walk on backup failure") tests "lret > 0", which is wha=
t
> > >> was intended here as well.
> > >>
> > >> Before b2ed01e7ad3d the resource was taken off the bulk_move before =
the
> > >> swapout; since then a swapped-out resource stays inside its BO's
> > >> bulk_move range (and on the manager LRU) although it is unevictable.
> > >> When it is later freed or the BO leaves the bulk_move
> > >> (ttm_resource_free(), ttm_bo_set_bulk_move() via amdgpu_vm_bo_del())=
,
> > >> ttm_resource_del_bulk_move() skips it because of its
> > >> !ttm_resource_unevictable() guard, so a range endpoint in pos->first=
 /
> > >> pos->last is left pointing at freed memory. The next
> > >> ttm_lru_bulk_move_tail() or ttm_resource_add_bulk_move() on that cur=
sor
> > >> is a use-after-free, seen as the resv WARN in ttm_lru_bulk_move_add(=
),
> > >> "list_del corruption" in ttm_resource_move_to_lru_tail() or a NULL
> > >> dereference in ttm_resource_manager_next() -- minutes to hours after=
 a
> > >> hibernation, or at process exit / reboot following one. Samuel
> > >> Ainsworth's analysis of drm/amd issue 5387 (see Link) identified the
> > >> dangling cursor; the missing removal at swapout time is the reason i=
t
> > >> dangles.
> > >>
> > >> Testing the condition for success restores the removal. On an AMD
> > >> Phoenix APU (ASUS UM3406GA, gfx1103) running suspend-then-hibernate =
on
> > >> a 7.0.y stable kernel carrying the backport (Ubuntu 7.0.0-31) the bu=
g
> > >> crashed 5 of 18 hibernation cycles; a function profile of one
> > >> hibernation showed 336 ttm_tt_swapout() calls and zero
> > >> ttm_resource_del_bulk_move_unevictable() calls. With this change the
> > >> removal happens for every swapped-out resource and 12 further cycles
> > >> were clean.
> > >>
> > >> Fixes: b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite LRU wal=
k on swapout failure")
> > >> Cc: stable@vger.kernel.org # v7.1+
> > >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
> > >> Link: https://lore.kernel.org/dri-devel/CAHYiNPa6aVacJoLOje-qZ1GyYx-=
9p0tN4NuP8D_eSL+UJeevXw@mail.gmail.com/
> > >> Signed-off-by: Vadim Nikitushkin <bub4z0r@gmail.com>
> > >> Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com=
>
> > >> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > >> Link: https://lore.kernel.org/r/20260909205028.13799-1-bub4z0r@gmail=
.com
> > >> [ Squashed with commit fcfe64715b425262af1b36f498f9197f3537ceed
> > >
> > > Do not squash, send a patch series instead please.
> >
> > in this particular case that squashing is the correct approach.
> >
> > AMDs mail servers mangled the initial patch so badly that I had trouble=
 applying it and ended up pushing a broken patch upstream. The squash is ba=
sically fixing that up.
>
> Ok, I'll take this then, thanks for the response.
>
> greg k-h
