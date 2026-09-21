Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20684BF939
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006979; cv=pass; b=h0oHWsuyLItwckonIYcOlUTXEBr10ijH3HGNPygqUQUffPWN4DZen8FbHfLT2Pi+ijnl7X7wqk5JvdJ+Bw/e6apnjZgdRH8CKQ21TFaxFDzPv0/eC9HnoHj0x12LWl077J+Jost+xvhelu9cM5fbqYhaWktlPbIrZQnH5EYR0gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006979; c=relaxed/simple;
	bh=rJMR1goI84UOj1zlSEMdnigQDLXKxYXLLUMmZidqtWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLpXYn/xenArizgst2FIylvVmlEE3ZTAit1KQU7N5QrXXCXWFSi0ykZfocShH+OyhGx015QWkLwepk66I9T2NzelSijTIpWWpug284cCs7ULfiKcskXpi5IwV8PfvMV5gdHIOHPqjtQ04GxvxeeAUp6grAXVR5f+OxOEF6WsUG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BpbCfK+M; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BpbCfK+M"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d0d5ae11so33465541cf.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790006976; cv=none;
        d=google.com; s=arc-20260327;
        b=Fx2FNfjPM9xi9awtzoOakAiSuCB++Bl7zZAP6zi9ZUeaJBIGIQHRTSr6uNs+xkDpuG
         WSIv8U89byuX+VpWZ8AFQ5kGUN6ypCLHwrGiiEn6K2N2SQ+83oWYt8Yd24CG8oLrj7He
         jzEScikEVX86TTZnfVWJkSfYTxL1nFseMcM9q4wXefaLcaEG0Tji3YndY7sP9fHpRMf7
         FY7xcieNXu23yNzTKxBPlYVQzcN5EWf/LPuccEHRcxf7eQkBA/5zWBqQysk1WnJhPWlB
         vPVmF+e4sYWJ1pG12lFDp7sKia8FxDjKkR5B63yL8rj2/qtsqPP9kd/UBm3C5mHr2WM/
         IgTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hT30naHPFA+SFGs6iwdccYenWnBCPLYfxZ1O0va1VaM=;
        fh=1npOklfHOiq+JwS5/fJXwv/dl5N4LiLEfSmNOYtxsOc=;
        b=cV1qwyPn3JQAbYNg1ROVObuCx5bNbGkfgMlDQ37yp2uQrEdmS2a2Gt7VPJbJAeKMxK
         TxezYhF0HLAY+KDmxCr5Xn/NbdnVoJumf7rcihrOYRfrjYRniByLj18UxA0bop61yUcl
         dZi3I8RD/yOB7L3fI7OaqrCU3wpG9zSclxBDgZ/m6TgTRZYlFVzcjms1s7eUFbm2toJP
         O4lnBeX3vjnwzjbdL/byC1RZpDsfXD+b91Yk5/+pALwOGzXV+jFCMwK0m35ccEXrWiTE
         AR6SiQQbbNa2BUMLhKAcQJsODL/3wMQ7CuYXF4SURDtIL0JhxC1qbolEKTRhrx1Rx/am
         ZUdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790006976; x=1790611776; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hT30naHPFA+SFGs6iwdccYenWnBCPLYfxZ1O0va1VaM=;
        b=BpbCfK+MO0cnrE0M1KFqsdXEVqe5uxoOFKp/DrvA1scWBZYfx1yIZlBMF/g4P8tA0G
         zjTjcciudLufbkADG03H0F3XJgJkrdbv8NGFAfgdyVtIH9o8Qf8yCTpRi7PdiBqOB4Sy
         yI5TvmbG2hGmnHZLRmK312lU8LRU2ZwUHsVGPP0Ng7ItPeFB6zs/P4GHRRCm04mRR/u7
         bqHMGqPPt8VuOck8tDsFplOZ4U6AySzVAx2RnqsTPqaCu9j+mhxWOMDNpQVR5J6D41mu
         2A/pBbkxoKDhjT5AJIIX2DBMd4xeTgKPO5Q0FX9hWYmOaN1SJ8m5MLviZYnlYHPtbIWQ
         ytow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790006976; x=1790611776;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hT30naHPFA+SFGs6iwdccYenWnBCPLYfxZ1O0va1VaM=;
        b=Qc/oaYWw8V//T5xDYBoCl695Way9gEG68Mqm6tpe4UvoTb0PmWTvTVjmshZzj6cKvT
         k0MHwuIsvJwexvFAvL0oVS1SGO6ZVuDldkyP3RJ+0FKAG+FSQuRlMq5mfGLo1vDB6ip3
         PasUg3IaxWNZQxaD2aBTwGedxNn0R1WfJPmuDuSz5qpl4qoIJ008ZHqCG/ZogMUeKx2g
         SU2+ZSSAQ+Uc0Blk1W13g2JKi91EguYn7GO+inVGhdgqizNEuXgvofE8rvDRHC7qcWfz
         ug5bgtGLLx8aGy0BhOE5/UM/EMUuExkjD04zJ7EmcsVsMfVpMs6NMB6cEJXrC1Jr07Vj
         BnZw==
X-Forwarded-Encrypted: i=1; AKwUvBxrTD3ExxAeYfGxBLJ79N0YKG3ZadpDdkKRpSmiKIN5CIYSJxcqFmE/+0WkuA7liah3k0Ie3pw=@vger.kernel.org
X-Gm-Message-State: AFuF++nmWpE+cfBVvBCXHgZxP6tNmoK51GXKUvPVQzPjny/HcijuZB92
	sKbNM26Bm05W1px2ZVg0DI9UtvsUFHrPuIHlwu04i9CDCMKUUPeT30CFfW0Umfq9+e9Bm3Fedtp
	GVE3ueV3D61ZVelCFUXG4Dqx2rkvWPmMUwdAe2Pa+
X-Gm-Gg: AYBFou24kc9ZADgXEPa0cB9yiPtrsv1apdc6JdYQyV8jj+BF/3l/8eJxlxw5y43KnQB
	0GZhrRnCBUPlj0GVOjF3kT+LeyjWUQpYJMI64SeWrC7BA2PWjS3sHE6vv19aDTLhV1qjUjk2W2N
	dkxKDyOw+8z2h/mQM0qJTW5RMnR9nYIC82qRXGw9gsrob6fERhT+u4RBCjBFJXjMZ3qgKsrUAC6
	QKznO4YdRpPFSh/Ejh07ruoDSh356GyiCOFCVCD+2CuJUlDzqd4X8vf1OvUSZ24kP/RDfA/PSvc
	SzPN8GfJ0prfsm4pBmb7JXKy3Y8Avs2MSW2a7ldIUqnC2cSuYps21lPMVuyLEXPeIpVbOrDwUDh
	sJ3NAGm1HuP58U8U5wI0M5uABiefo9ygfbxAURT3Yk/h5gGOJnMg42hsckHn9X87DN1pw+Q==
X-Received: by 2002:a05:622a:307:b0:530:e3dd:dfb8 with SMTP id
 d75a77b69052e-532d8d3478dmr13680971cf.14.1790006972661; Mon, 21 Sep 2026
 09:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921155522.679350-3-yunseong.kim@est.tech>
In-Reply-To: <20260921155522.679350-3-yunseong.kim@est.tech>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Sep 2026 18:09:21 +0200
X-Gm-Features: AcwNN1U5ucC_8slHXtj9uoeN3R5L6EFD4XqPILQZKmxegu-LKV9HjKuAx7U_Efs
Message-ID: <CANn89iLpT1hqqNS2vWM1xL_Y-Eqpj5UBxjJwyfVc5JuFhSZcjg@mail.gmail.com>
Subject: Re: [PATCH] ipv4: guard inetdev_event() against a NULL from inetdev_init()
To: Yunseong Kim <yunseong.kim@est.tech>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Taehee Yoo <ap420073@gmail.com>, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 5:58=E2=80=AFPM Yunseong Kim <yunseong.kim@est.tech=
> wrote:
>
> On NETDEV_REGISTER, inetdev_event() only checks the inetdev_init()
> return value with IS_ERR():
>
>     in_dev =3D inetdev_init(dev);
>     if (IS_ERR(in_dev))
>         return notifier_from_errno(PTR_ERR(in_dev));
>     if (dev->flags & IFF_LOOPBACK) {
>         IN_DEV_CONF_SET(in_dev, NOXFRM, 1);
>     ...
>
> Because IS_ERR(NULL) is false, a NULL return flows straight into
> IN_DEV_CONF_SET() -> ipv4_devconf_set(), whose
> set_bit(index, in_dev->cnf.state) dereferences NULL.
>
> inetdev_init() is only kept from returning NULL by its trailing
>
>     out:
>         return in_dev ?: ERR_PTR(err);
>
> which relies on every failure path that leaves in_dev NULL having also
> set a non-zero err. That invariant is fragile and lives in the producer,
> while the consumer's IS_ERR()-only check silently depends on it: any
> future inetdev_init() failure path that returns NULL (directly, or by
> leaving err =3D=3D 0) becomes a NULL dereference at this call site rather
> than a clean error return.
>
> Before commit 20e61da7ffcf ("ipv4: fail early when creating netdev
> named all or default") this call site used "if (!in_dev)", which caught
> a NULL return; that commit converted inetdev_init() to the ERR_PTR()
> convention and switched the check to IS_ERR(), dropping the NULL
> handling here.
>
> Decouple the caller from that invariant by using IS_ERR_OR_NULL() and
> translating a NULL return to -ENOMEM, so a NULL can no longer be
> dereferenced regardless of how inetdev_init() signals failure.
>
> Cc: stable@vger.kernel.org
> Cc: syzkaller-bugs@googlegroups.com
> Signed-off-by: Yunseong Kim <yunseong.kim@est.tech>
> ---
>
> Syzkaller reproducer:
> # {Threaded:true Repeat:true RepeatTimes:0 Procs:8 Slowdown:1 Sandbox:non=
e SandboxArg:0 Leak:false NetInjection:false NetDevices:true NetReset:true =
Cgroups:true BinfmtMisc:true CloseFDs:true KCSAN:false DevlinkP
> CI:false NicVF:false USB:false VhciInjection:false Wifi:false IEEE802154:=
false Sysctl:true Swap:true UseTmpDir:true HandleSegv:true Trace:false Call=
Comments:true LegacyOptions:{Collide:false Fault:false FaultCal
> l:0 FaultNth:0}}
> r0 =3D creat(&(0x7f00000000c0)=3D'./file0\x00', 0x26)
> ioctl$RNDADDTOENTCNT(r0, 0x40045201, 0x0)
> r1 =3D socket$inet6_udplite(0xa, 0x2, 0x88)
> setsockopt$sock_int(r1, 0x1, 0x1d, &(0x7f0000000380), 0x4) (async, rerun:=
 64)
> unshare(0x42020000) (async, rerun: 64)
> truncate(&(0x7f0000000040)=3D'./file0\x00', 0x9) (rerun: 64)
> ioctl$sock_SIOCBRADDBR(0xffffffffffffffff, 0x89a0, &(0x7f0000000000)=3D's=
yzkaller0\x00')
> socket$inet_udplite(0x2, 0x2, 0x88)
> rename(&(0x7f0000000640)=3D'./file0aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaa\x00', &(0x7f0000000780)=3D'./file1\x00') (async)
> ioctl$BTRFS_IOC_BALANCE_PROGRESS(0xffffffffffffffff, 0x84009422, &(0x7f00=
000004c0)=3D{0x0, 0x0, {0x0, @struct, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @s=
truct}, {}, {0x0, @struct}})


inetdev_init() can not return NULL.

err is initialized to -ENOMEM, and the only place it is assigned is
inside "if (err)" after devinet_sysctl_register(). Therefore every path
reaching "return in_dev ?: ERR_PTR(err);" with in_dev =3D=3D NULL has a
non-zero err, and IS_ERR() is sufficient.

Please do not send patches for bugs that can not happen, especially
with a Cc: stable and no Fixes: tag.

Also, the syzkaller reproducer you pasted has nothing to do with this
code path, and there is no syzbot report or Reported-by: here. Please
do not decorate patches with unrelated material.

If you used an LLM to generate this, please verify the claim before sending=
.

See Documentation/process/researcher-guidelines.rst

pw-bot: rejected
