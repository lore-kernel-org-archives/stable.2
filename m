Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAB23DC861
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510817; cv=pass; b=SwzzxX5XWH5zii8OfOwn8UYkfswijtjjjqmJJOWn09/QyDur17MwwP2g/wfseFa7//akimrsub+FmCYp6sLCx7dn5yDTC/ijuDds4VmzAFEg6cmlwLWLUUyFd3/3GmuTQ/4nlzulvsDEJRq+v0OZ5rQ9ryNqCo7E26nBLh2gbns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510817; c=relaxed/simple;
	bh=nDd/qvvIkL8yPJgYiNDZEKASX0pDnHeCOcIyAH5I6VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DO/SytLgYgztCtZDH5PBNxVEYWZjjOW6mLzfaBiVdxAKks1SuYEhbRwARkXeYqQzxCGwmeRc4OtHqeuil0S/xIQzboIcKgw7W95/vWYoILu5xm8tk5Xjnxw/g4GtwnI1ygZl9j0Y9Dg28eO3c9sL17gj0ROV0sYjhVK4lkBOuU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcpGlrGu; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcpGlrGu"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c2a68d01so26079345ad.1
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 11:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780510816; cv=none;
        d=google.com; s=arc-20240605;
        b=GLFOLEkiEYlp8bOcX0wkqGmDHy/xYcbxENKoowCo8xa50lzmuXNWpYj7WYFnRa2HFI
         8CeZawbkTmBZ0bEZOPkif6DAJebjebZobx8t40i18pOb/5sgxqsQk/ZkU+GBKio24tLi
         XUriDVHdMmCc8mREwxFS1viNcIAAL1BqF+LGYpaIxUfXZGQC/3mGQck/doSXtQBECpar
         eGCHjgu42zLgQd3rmIdXWFTSKaMJsBSIcPH6+qyu41zy50NCziDKjzJ6ySCwypehn4oG
         CRuWPPH+OKWmau8o+yHsKd7uNVdVdxD+LWPBCGocLeQ/V8eQOTjj+VZVvoXy572JCRCP
         NUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E/xKk/OwjaxQKXU03tfhIHQaaH7nE7zS1IRGXiU5gzc=;
        fh=bLx6OpQzmhfdN6NF4K54or36YOjTe7QGrnJ3gRJzPbk=;
        b=cgUyGqwx8xuVHzmhz4qM0DqjIbCsbvAzF9ltKJHiM2PzprELsww3g7WS/Fxp621CR+
         RR6lUw6UrYRoaM74mQueHYwSkM6rP3eAC+cOrFRYs+FEkdzcDcZF1P0CbliOtIGf1ddg
         MWd6+Wkv2scpd7n3dg+7HEOJcXXZ1LddNGroETljsIpt7QKfvc2rntmcW7WPBmw1zoAT
         C+PZTbKe7TrWvGLiOEn/wV80dX8jpZOqj6ZVzA8gxA2EflK/+nhes+Ojz0rkLPdVuahB
         tfucnUCB757H/bYPzammboZ20ottGUFLp4u/8TPwYXiOcLVp0BrcmL/IT/8YG9VhxP3g
         2AmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780510816; x=1781115616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/xKk/OwjaxQKXU03tfhIHQaaH7nE7zS1IRGXiU5gzc=;
        b=HcpGlrGu0ThJEyfcwAzFnvv0cQjmu9yoPPRb+NUFUZGZRMsMOsyxJWqmm8ytfEclw1
         ijZ27TXGtWRLaVg8db8D/YGajOOb14loMDDbulBB5YTHwQdZEM3VscZZjNBeqt5UkHX8
         62ZPAwA8SIf48MvBRwxoy+BG+7mPear9TEYSRtLd6nPnKVbl3YT85YQduw69L3VS1GFC
         ojyimLC9mdtCJvbEXO+HhVu9OuxUw0LsYAfyx/AFgVRLK5b+xRoXIeGYHo+xjSdq5Sm4
         1cW7RVoMRj2CPTgyoGrCBqCeaHKSO4xowRYo8pSZyA7lgM8aRb0EyK2pHJPU8L4KY/GG
         9B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780510816; x=1781115616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E/xKk/OwjaxQKXU03tfhIHQaaH7nE7zS1IRGXiU5gzc=;
        b=rShG+U1tLapmBzaQWNPOnaXc5d2EeEZKaBm6KQ312Y90o9FEMu8az5HAGgdMeE5owZ
         m83YXTTeMZ7swwzfWuDnvJRR5xt+IE82JhHhDaT2fCC8i4wyw7qUDu92JWSGSXICsYfb
         fzc01KFdCioHVGk9SjyHLQtC2c4bo9Fe/djn5Ne61z5jf/wjUT0DboJoULn82mSKbuzO
         dJif5jWiGacwoVlH6cZKZ9TEO+8bBotpmyjMsULw4Y57SX5NjuA/uNj4XypLvb0s3bIb
         RcpFzjNbQTgLr4CCVXG0BA3xvCmKP9+jSH8Fukf2OGyZG44MoAcHmmx57dTV2CxzdBGL
         xUtw==
X-Forwarded-Encrypted: i=1; AFNElJ8dWgqH7EHaEtEMYH8NI3YwiW7OGt5Wd+sf5bBAyk1LFKz4R5wJFiqrY368iB/j8giKqes/PGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJ1u2CTroaUAg15ptiD6mLqF5jZCay8SNhR69h14Jg0rLNt16
	eQ8v5SjiqAWYpg7ypsiCICCIW2T+6LI+jgR90haUlWYrjhnqVP5OmSjMJu1KF89zgw8BvAABzFl
	ABvvM5ICfL4lJTzfooZa/UIPe/M5Jnvs=
X-Gm-Gg: Acq92OHajTbzxgO1G/aXoP2375mTdfliQ6qNRIdMET+dnD9xOb8HkVGSB0YSm00qJhZ
	n7HgqSdP9FzWV0CcpcJCrcyH5n86fgSra4dmrvQLxyBLMCpn9WSr7A+EFaQxh+PBY/lKHu5KZr7
	E54f2F5jWU8ydmeDokf5zonnNFdPLcvuppSc8iO4tq1BAfmC+Tky3D/yDIY8fPiwWtgNSYDKzUT
	Tb97wa5o8T6l1Z7OMM57GfgbYEDMq+d1HiOwg0bFXVX08y5jpvRhZDvXjFWsZtCrtuVxWVYHtm6
	M98RtNCsahoyPsRyJnWZwX2P4CVtvBpWhMXtvUFuU1UdXrk=
X-Received: by 2002:a17:903:acd:b0:2c0:bd76:cf18 with SMTP id
 d9443c01a7336-2c1646df446mr47625875ad.38.1780510815853; Wed, 03 Jun 2026
 11:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518212336.337104-1-michael.bommarito@gmail.com>
 <20260520154715.1457495-1-michael.bommarito@gmail.com> <20260603175455.GA1554392@nvidia.com>
In-Reply-To: <20260603175455.GA1554392@nvidia.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 3 Jun 2026 14:20:03 -0400
X-Gm-Features: AVHnY4K9-vy-xLKYffHfh0DLdmiI2YKCvImD1UjcMB8ApiVt3f8nUnGCu8vXfNA
Message-ID: <CAJJ9bXyva8La+ZLbG5cwaE87AR3GizLH9U37XKgKR1xxOHB6kg@mail.gmail.com>
Subject: Re: [PATCH v2] IB/mad: cap RMPP reassembly window size
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vlad Dumitrescu <vdumitrescu@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, 
	Bob Pearson <rpearsonhpe@gmail.com>, Sean Hefty <shefty@nvidia.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 1:55=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
> Why do you think it is OK to only search back 64? Where do these
> numbers come from?

512 >> 3 from IB_MAD_QP_RECV_SIZE in mad_priv.h and max_active.

> Is this a real issue?  It looks to me like all this code is gated by
> IB_USER_MAD_USER_RMPP and no in-kernel user makes use of RMPP.

I originally found these issues looking for reachable quadratic
runtimes with libclang+Claude, and these are in my notes on
reachability.
<CLAUDE>
  - sa_query.c:2436: the in-kernel SA client registers its GSI agent
with rmpp_version =3D IB_MGMT_RMPP_VERSION and flags =3D 0. So
ib_mad_kernel_rmpp_agent() (mad.c:856) is true for it, and
ib_process_rmpp_recv_wc()
  =E2=86=92 find_seg_location runs on its receive path. ib_sa is always
loaded. Not a umad-only path.
</CLAUDE>

So I think the reachability is wider than you expect.  Perhaps that's
the real fix you'd prefer.

> So I don't see why we should be changing this and risking regressions
> with the window reduction?

It's obviously your choice as maintainers, but I'd encourage you to
test the pathological worst case from an unprivileged peer to see the
impact before totally writing it off.

Thanks,
Mike
