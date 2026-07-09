Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5F44195BB
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620324; cv=pass; b=nveMXj9jt6Te75Tar4hQwn83/8FVw5j2zYi40fTZneru8wbcghdvKcMvX4ewOWWvTGpDTbZFm8ycNMCH5YJfeXfAobi0UYfkuOLnsJgj6Ue+cH2a2pPd1mcAsG0m3QGy395IX665cSrf+oAUD/f0mmuRWTnW0qsfintR0C+sP48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620324; c=relaxed/simple;
	bh=OItJ99cRfcG+Mx+g5/rTGfu5JQvBTvkxMrJ0It72QXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ig2riC9l47D142ZY2Cu8Dx/z+F0HCB5CY7HIK8YmLvfxzDDfuugq18y0HiYwUdTWoq3GWzL95IbAINngZBPHGem5rYTrLpwM/XFOs5lYpg/za5sPmZQF/ynRdFExv0VcLX2w6m7TMMt834GKhoFD5iwS2Sf/cc2yER7R6iikzWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5zGRqnq; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5zGRqnq"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-384422b05b5so41052a91.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 11:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783620322; cv=none;
        d=google.com; s=arc-20260327;
        b=gqjatTkhBQms9AOoMj+DVftm8J5Z3m5fmWAGiHqSac9FbvPk2Xw02Ji7dekgIimwk1
         R9qUQtHknH/Gmj24hWLNS25cklNMdfqoC5udQniHuRpQzB9fRQmoAHUJJrCrYw5LNBsA
         AgAGl9Uxd977n8AzGYKflcCO5vu6BtOImFBdJXa/FrTeX0QurEk5B+BJ8uIKbpnV/QJ4
         xo0PbUOAk2qwzgMOhj/n2VqNgIe53IUMSIfLC2U/K3kU0idIJa9BBIUxtmua+524+TvP
         PJjwKvC2XfWZKoE/Dm0e+3ngOP3c+O2ka1WC3+lIOelDEprIBs6I+OGX89tqDqoian47
         mwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OItJ99cRfcG+Mx+g5/rTGfu5JQvBTvkxMrJ0It72QXg=;
        fh=HHqTzdzJx8NGVeWyIqObcQP7uTM5uAj3I0zJaJbyaqw=;
        b=KEKGrkcgWcOBsLhFKZFXM8UMXBWue8ApTM9yp3e8L3UjdIdN6RvtTwm2zOnh2zqtJM
         p08cFl4s7CCrb89TSkdL9rdu2+TrYp6iu5/mi+a0SIuKusw04LBc+R2zfqiVql22pL3v
         M8JUaZpfCyh1zZ6oYvDayIEFbo4mDx+tJH+i96SRCl5CNL2RR1NSiNh5c5IwkUYXw6ID
         RqbrHQ2eo1FG4ECKw/rsNxBFqAnamC/jl+kwP0tmmd5q3sdW4yUNhqVXjGlf8QNv4pzJ
         GGXYWludNm+5HhTTxeHwVvOVJm6ONKzIGU4xINkJOAVbcXJmZo9CvtMumpIN+EVVpK+T
         4wYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783620322; x=1784225122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OItJ99cRfcG+Mx+g5/rTGfu5JQvBTvkxMrJ0It72QXg=;
        b=g5zGRqnqxaoWlrYOfY6uTF70cQD5NW/GcUQOgnftTUN0+t/FArojIKYG3iKMi5uxsZ
         O1ac+Y9mN54XoVn38tLXWvX2K7vOamFJzqi75kyiomLdbzfei+awQ+9gID/0te18Gvou
         5dHF9anY3mJKieh6nfHTyQMr+AKOKA7jqzIVGfdSQb97nwwuFL20w6sjjgiflA3tfIUo
         iR4bLFrNK0a0EcMmiu15kyme6jY2Fo9Z1nD4uyuV1f01WDvu46g/+e4MCxn2qaihmRZz
         yKuM4w+yA6j31dqhCtV29QwHeNNoj+xfPII4AV3oCKAk/MX7B3oMZ+h/oG1OunbIHfhs
         A5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783620322; x=1784225122;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OItJ99cRfcG+Mx+g5/rTGfu5JQvBTvkxMrJ0It72QXg=;
        b=KoibqmrScTVNU783w/A6JeePdB5KgDunjltKEMOz0lUo3dhdEgias+SUKobcWxkkcK
         ybuKV1tJsZ3dpni2p47Ezjy6034iT8LAHdyG3fWNwt3xIj9AMe2EzDq+rkgiKfR1xK3c
         0FMjemlSImqO6V5KYirIZ4/zi8EahhFIM/HW777hvu/w5QkMpkLr1lTtI588Xgzf3wGD
         z90qgOVcO25Ub7mmQk4B4LRlTaOIUdBtZzkriEMK1Ok0DmCoQtFE9wjKxf+EzCS1nh+h
         vFo1mBDDqJodMyvVIR+DHmS/7N/VlrSxQihj06UQPk/wc4KQC21hWy8gknJ8IZIGldiq
         bd0g==
X-Forwarded-Encrypted: i=1; AHgh+Ro/Yc1wmv7ZUH+3VO+R7qGxz0QgoGzap7OLxS76mTDWm2+gc9x0xXPtava5XJnelNy1GOp1WHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9N2bYAqVi9cN+jV8NLy1brDoi11jGqNe8yF/VskLRt4ci3Q0J
	uxMmbL+ezLXqgw/g1DmT4KgcKCz9yzzNWBtWfnrRzm9q+oJ75IwaUNf4wuvNntNfXpuuFFd4Y42
	2VBFEUfL82djF694iu1u6iS3fOZydhU4=
X-Gm-Gg: AfdE7cmLvC/p/Ah7QR8pEhjuTiLb1/AT8F5rT5hyjaK7hmos1D4Cb/kX0ii40vUq2pu
	WYYF6uDCKTNxB8CQo+Q6kdpq/AbixZsllk1X5mMyJs7E8QdbIBeT7+UN3o/1debIKLVxiuZGXTM
	AUFA0ttuhVfxEIMiOhOjaA7+osb4foBLPdqeKQZ2X+nnrCNA0yXz+Tn8z6n40IwKaPU9rAo9VOy
	SAxzhac3REOHI0bh0t59YQKICSfix3VWVzXWLPFKENf1G3oQ+D6vM1tOfXJZSJBr6k0PWtD+rFE
	y3pwH6odJ2gQsZg6+nM9jtOpk5FvBWdMN4LdDP/HhXhIW2iT70n5of7UzkHbMw7MhZxMV1hevHz
	kOC1XX1xCq7h0
X-Received: by 2002:a17:90b:3fc8:b0:37f:df57:2ddf with SMTP id
 98e67ed59e1d1-3893f97f9acmr6975572a91.1.1783620322185; Thu, 09 Jul 2026
 11:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026070939-unworldly-mantra-5611@gregkh>
In-Reply-To: <2026070939-unworldly-mantra-5611@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 9 Jul 2026 20:05:09 +0200
X-Gm-Features: AUfX_my3BseaH_aLDHQrWW8xmhTgUWNd1DjaFmouHaw42Hs8fstZaNAwR1Znj18
Message-ID: <CANiq72=zGG5McmM9h90wzax=+kX_3401ciouPRyKtMvQY0y+WA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: kasan: KASAN+RUST requires clang"
 failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: aliceryhl@google.com, gary@garyguo.net, ojeda@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 7:36=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x 5b271543d0f08e9733d4732721e960e285f6448f
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070939-=
unworldly-mantra-5611@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Done as well.

Cheers,
Miguel
