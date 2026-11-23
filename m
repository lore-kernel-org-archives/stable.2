Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795460157;
	b=cxxFSv8Er19jB/6v/382Kt9e/5+UU4g9O/OAkV3xn1b8oukl5LGQslOXF+5DOUH22uM8
	 Vzrfvr+QsIUnYmGZEr7SMtDzxid/t7YXit0n1l7VbuFc0jOj3cULVj3K3a8MuShnvnt5T
	 ts/RU2dFT29vE45XwaxbIoq/X+70HBr2QwEKwE2GNzxDraCXOz15w9qh2dS/GrwQrpEd3
	 TYsjkTdFxj2FWpNbkfXcmGNsadZLntm/0dzBDQguUyuKH6QCvCLvr2XvfhKxeg1qYOwqw
	 zljLDPY70oBNBYBFChOv0dXiLmDeWwIOoOSnfAS4kwEly7nmtfKbc92LmeC1IYY8mGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BNSwJg+0HhZxN5eag1txmGeKFOOyqEA8cbyAFIEA6yM=;
	b=DOA3mBniJfHKUSRXNj5bGHOve5huIYe29289Rl3k9mIrZiCIrfH3I7wJng0NNRCdR34a
	 Xuwr9t1cLX7R5ycHWMy3lVd9SdOuV7iyElcKJ0z4M4yvBoWvR7N17Sk6A0FzYIZyP5Hh1
	 bo7uDOxxN6iimK7Kn8liSfKHG5aZpryS48TtYGllkQQ0+s32ZZbqUmFWQIhtUx+mQekV7
	 g8Xa5NSr/1BJaQHt9yC+euWfV9TorAyADSVGGrZLUutP+2oMLFax8BpW4qpuJ8bi2FNDf
	 sEVH87QZaVKW38E68p09Xc1wtMisLeHPfJVqJQz3zjgMod88WvJlTc4pccpHLWBbj+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SWjJFVer;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21DF606A332
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B21DF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SWjJFVer
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c50ac25cdd4so496994666b.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 10:55:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795460155; cv=none;
        d=google.com; s=arc-20260327;
        b=gl17anYRFe861sELn/o315HKHY2oqrbyXvGvaJqsmXQBI/nhUZUYvRFCi2+WZxqR4b
         QN56oOKDJSiZwwGbQGxBmKaF/Uv7TD1VKA0VRHd71arNn6amfocz3H9w6OsZMXTd+9Iq
         8G/1w11gLY0htj+dRnq4kRKbmzQL6zTVT1Cg0EAlOuh8A9irISuyaE/EspO3QzcurxaR
         Vxi3yh9aUX03lk73EoDVGXanJtGiWlU4L2baUbuNs/fSAp3UPTJj2BhpBzpk+0z6Oppw
         0/GUps9hz0PRDC+LDA8nvDmDigFbCYutQlWhxf2+nx3maq9QmjmV7A05uVZjLRe7GvL3
         740w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BNSwJg+0HhZxN5eag1txmGeKFOOyqEA8cbyAFIEA6yM=;
        fh=QTvCAPmOresTffanluaoNG8Lr9qj4Bjx+E1q5DfsDxg=;
        b=iF+8h+L5XTbnM6wBr8mLPnzUB2xE8U6diNaC9eHwp7qpv0pBONwF+8PvSnytLtEFhg
         Z2upXvJ4NTdEExjSCxJQiMSsbq/lclTsabHfYDGiWMmEx/WFVmtbtr2/aAMARUMhNMSy
         U6oASEGlBjF0rqXMV66LxyOOgyjA1DXNY4/nTE3QwRTAxdDTmGeubURtrFhzK8PH0rwm
         2iPWqsgu1OnCoP18GpPlZ0YDen9xiwS8J4KQ5YCu8EU+EJrmYCDyjgtASFRGL5/GSaoU
         7XztsNsff5gZOeminZzaCYR32NVwmOAq7F69kePpCF8AmOH1eaWsDA5iueQWMub1NIlB
         qu1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795460155; x=1796064955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BNSwJg+0HhZxN5eag1txmGeKFOOyqEA8cbyAFIEA6yM=;
        b=SWjJFVerFZwp5gdpwgSwsHCvH/MuBZwcTTCLGvQ2+MQp4fpwRO1TEnK3PIl5WkZa/U
         4PYBssodVjWkRVnC2iPkYD4laPHHByLLCScMdEpXN4Fcji3zhcktPBk3hTnNfJvWWx6i
         +xT/2XPzIryntCkoeUD40+jQ9uoeFBS1E4DsHtsDFb5r+ZMBj4ulQvwbkFCvxi/wsmef
         tYLPWBzGqaQWWib7PVsEorJgj25Ih2Bn+igCF6imMbkjrGjtnADAPJuPHJvIXnQXn8Et
         jP0ZfP/o/b9OqmZGm5854VD3POC/VDiGbANhdFn7ir5sxDaBdPzx2VSmKpsAU4dHgfOj
         h97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795460155; x=1796064955;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BNSwJg+0HhZxN5eag1txmGeKFOOyqEA8cbyAFIEA6yM=;
        b=MdnfuE32Nd+n77tdUEGSP0BoDqs5HgTX72Oyie6MAtOa5DQ2h9pbYNodzsEzLlcsCE
         iIJlQDfrykMfLgRfJxaYD1CcvnkE4I5ZsBgMbXuVQyZe/54Oov0Z21pExkb1PxLfgxj4
         jY0CQM7uPeS54dYMS3qrv2DkVlUdxxvj8MLJc71L9Zy/PdLMDETMMMBzp6R9eLwF9AMq
         pq+tBQh2KyLCQjnr1HhdpXwrHChCCWHKtIjszjzcJ+eh+mKQRrXJesL+Gx26bYGTmbgh
         UGYKzRqCm7DLsgaP7zQKl1qAnppGgSNUHMrH18jC+JxODuin+xpqnC5p6MLe4jDARGgh
         GRCw==
X-Forwarded-Encrypted: i=1; AL+hErFczVyITA+e9+/26ZUSNL3VKflXZ8twx3mqt60XDKMcnlZ8BHp6QXG0uldLeYlgromalCwKh/A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xc3ljrq/TnFXOQOoYsZznfWwePg40oCg6sR1lkFCfHkcAxNar
	KkvfJ16Yt9oZPgflbcFLcNZMORQ0H67MibnwCVcBS10Gzh0uUBKXPXj4QqHjOWSjyl8eNQ1Ib/b
	By6KHP1w47/fSdAkGHrWgnUY42i6imXKli/tmBY8K
X-Gm-Gg: AZFdTZe/IHwtFJuvxOzrIb3tKAA5qteiHsefFBNzQ18sTwACHFthFyZLFouBBF/jbFG
	9kUfGHPFPd/f/S6VudqzJOt9u4iRrDWxhMR8ZAYG6NCt8VyrvT8hF7rMujf8DonjfF7oLBM0i7W
	6uuDvcWjZ5d7Ja4OMvqsXAmMBjFCHOD0bC4EtY7MlcGkSCmzjr+MemY1YmOWbUueVy5/LT+sh3Y
	wkfNnQLi5Q5zGf+AX5P1Fwd9+trn3yKQZ1WOcRSzkRdZIKtpxFJpTbTFfrHGrLtLLPFf8ypkyTd
	Zl6zZQF5nqXXSS8QHjg2N//kzfuFO0gD5/KvKG1nfZWn0ub3/6+abz8kPSd15brxyZYzcCHyid6
	VGiGHwaq+qQsVllDod9jh+j9x5jghiG9s19T9k1TiHaALml5U1fYS8+/eOpO8eOaq9dDZ+fZNfa
	doXhZFydZLA9gnqM4BBWlZXjeEOX1//ktrNkDkeYARIeJs5Wxf55l4A/NqXm0psyhSVnjxz8jA
X-Received: by 2002:a17:907:a890:b0:c50:9432:b7e3 with SMTP id
 a640c23a62f3a-c513aace654mr1151233566b.42.1795460154527; Mon, 23 Nov 2026
 10:55:54 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123153238.1036972-1-smish149@asu.edu> <20261123153238.1036972-2-smish149@asu.edu>
In-Reply-To: <20261123153238.1036972-2-smish149@asu.edu>
From: James Houghton <jthoughton@google.com>
Date: Mon, 23 Nov 2026 13:55:17 -0500
X-Gm-Features: Aa3M54o3BkLplxoImmTCvpPC5WgG3n0ZneGbPk_xxpY2ZYPc3HauVZVJB5o2TiI
Message-ID: <CADrL8HWj6qLSB4h_JC7qSr6+t6Z6p7zzL7fgVne-m8_cfrHwOA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: Disable preemption while pushing to the dirty ring
To: Siddharth Mishra <smish149@asu.edu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 10:33=E2=80=AFAM Siddharth Mishra <smish149@asu.edu=
> wrote:
>
> Disable preemption in kvm_dirty_ring_push() so that another push to the
> same dirty ring cannot run in the middle of it.
>
> kvm_dirty_ring_push() selects an entry with dirty_index, fills the entry,
> and only then increments dirty_index, all with preemption enabled, e.g.
> when vmx_flush_pml_buffer() pushes the logged GPAs on VM-Exit.  If the
> vCPU task is preempted in that window, kvm_sched_out() calls
> kvm_arch_vcpu_put() while kvm_running_vcpu still points at the vCPU, and
> kvm_steal_time_set_preempted() or kvm_xen_runstate_set_preempted() marks
> a page dirty, which pushes to the same ring.  That push fills the
> selected entry and increments dirty_index, then the interrupted push
> overwrites the entry and increments dirty_index again.  The entry after
> it is never written, its flags stay zero, and the entries after that one
> are dirty.
>
> Userspace harvests the ring in order and stops at the first entry that
> is not dirty, so it never harvests any later entry, and the GFN of the
> overwritten push is lost.  A VMM that tracks dirty memory with the dirty
> ring, e.g. for live migration or to restore a snapshot, then misses every
> page that the vCPU dirties afterwards.
>
> Fixes: fb04a1eddb1a ("KVM: X86: Implement ring-based dirty memory trackin=
g")
> Cc: stable@vger.kernel.org
> Signed-off-by: Siddharth Mishra <smish149@asu.edu>

Feel free to add:

Reviewed-by: James Houghton <jthoughton@google.com>

> ---
>  virt/kvm/dirty_ring.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
> index 572b854edf74..1ed8b8771c3e 100644
> --- a/virt/kvm/dirty_ring.c
> +++ b/virt/kvm/dirty_ring.c
> @@ -221,6 +221,8 @@ void kvm_dirty_ring_push(struct kvm_vcpu *vcpu, u32 s=
lot, u64 offset)
>         struct kvm_dirty_ring *ring =3D &vcpu->dirty_ring;
>         struct kvm_dirty_gfn *entry;
>
> +       guard(preempt)();
> +
>         /* It should never get full */
>         WARN_ON_ONCE(kvm_dirty_ring_full(ring));
>
> --
> 2.54.0
>
