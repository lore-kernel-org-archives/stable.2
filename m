Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA6947426A
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789815866; cv=pass; b=A6ON3V1L6G8uYzdJtm/O6MNmLAkDtFz21HKHyrIo8VfB/LfKc323RXx3HwLIo3Vko8/VAWOsnE9H9PifZKzY6oc25iMFZ1P9YDShRMbWPZZoZ+x9LcJZwDpnKln2/RtAqi60D4YF0s1YSiLG95XkwN1x6GG9pH+ux6+upucfWyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789815866; c=relaxed/simple;
	bh=Uy8pdbu6T+f7Vaa/HfQOkCmS8NcxSl/AYSWfTMzxSOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MG71fNHaCWmbGxhz5+u8697jFZKRsNIdyVolnzrGMDs3uoiqK/Wu69iKYgFrxoNcOSyzwHS3w2PXR3dMsCh6Bg1AVORtjI9tcT30SZfnOpV4MKxuCA/RIswQJ2yeuA7VI0PUTZXKTQJSTqdDnPHijFBhRjobOn7dVm4M4ng4O4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hA9OeGUz; arc=pass smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA9OeGUz"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6aa053900f5so2720490a12.1
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 04:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789815861; cv=none;
        d=google.com; s=arc-20260327;
        b=AkNE26EZ1tG31Lj+tXLjNLkBQPp5j0PH87wbM7IwN/djR8miiLoi8UB+JkAQE8cQwY
         Qm5KeJYzGQ60tUWC/ZE7Qp6i7xgMpsS9KSxptdK8FMrCoMFUqmeJd/dlvWeFd4gxiZym
         cD5EX0wDPK8FS+zAXVAvGCiyVDDpU/TglxcNFV74ZAggWgwbaAII6zM9g/XPxAS8XFW9
         u28NZnBliqG+aZLWR+wAxoaZq+HuM69vq51B+xjzMPW+CiFEJpf3482RdYKqp5cBy9R4
         M0HgTSfDc2hhGWNKqxaZPnixJ3btEd8WnhEOWEDtXugLhYKQpystpuGQcRcQLNs70WDJ
         s+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TaoU/CXeNzW1XLhDMwPnWzYzMZ7xTqLcjubBtefo9dU=;
        fh=eA257s14IhFgArlPZpymidvtG1JZAGk8vq8Ajh2RXoQ=;
        b=QanZg4lwSr6KqEp55MMXjFQQpdtuRqtDTBycICx8qvv+1wlnPk9g+Jk6gE1H+cTFY0
         T5ik+TpcM6B+VPhbhtja9PHCodv6c86iXjzV7MFKBxn1gzRMtMlNqJkQ0/0dO+0Qe0Gi
         lpQbG69E/DOHBZ3puLhOgHOJ3EJO63gU9/w53F2xgkRvGmjpD+esJ2xnpK4X9rj5kE1r
         WZhl6xdASRGQfhDg+bwnMaTU3DCaPQphLceIxZGd9Ina7LOQxG3crFPqDXr0iYCwy5ut
         glJA2OZTv2Cf/oqT+9kPOaOX6EGNhGRCJ73dSJBLM1xf5i+PU3UEJRf9T7IOaqd+71Le
         /NLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789815861; x=1790420661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TaoU/CXeNzW1XLhDMwPnWzYzMZ7xTqLcjubBtefo9dU=;
        b=hA9OeGUzy3Vd6kP9d4L+TDaxqU1xiw5lxsywbrcJT8yepumnd5t5E8BWcHU48ejDJo
         e0dbw6a2Cv4eH6yPzj8ZTnHhRiXNDDGYA1GHqsO5IqfCjRQRZBcld8GHhDrXMoJVY7AM
         zL1frWoKvvpueQYCvecI7zKN+nB7LH2K6PUNG7GAFvSuxqivvjqRUz+H0mcDxFqb4Q6u
         1/K/hFGKtU9H2mvCs9Rx1iZEFlwIad6IFfJyLkey2Vl2Uej+DaYWp3aDWHfNCCzMHdmA
         pjn2J8YN8YfwHeqrRiQQMfRY+4ZKxMc0Lwm1AfUNlncJSvhk0lSUcNiP40kwS8BsARb5
         LCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789815861; x=1790420661;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TaoU/CXeNzW1XLhDMwPnWzYzMZ7xTqLcjubBtefo9dU=;
        b=F1Vym0RHLs3m8WHQtAosAO2T1azfmVcfdtzmMtPtMJ7+9hmwTKDkjrGOuElC19kOgB
         O5vlPu4t9nUOEtdR4EUQpE/TCTJ4nGLlR3TG+abfu0zCEjui0IGjRCo5oLaophmjV2Pf
         RqmBba66kTorzUI+evmx55fAseUzSMwIOlu5kcEl081lDEMSBNMP4jbqKPbrvcIPLCgV
         pxvBNxOdI3Yd1NMaI4wsdPg3fDDiGutIF8vlgDfkw0zwpKXDXUV3m5YyJYA8nJsGL8gQ
         5F9dF98v2V+fh6E+iaM0WreIENXjGi0ES1C5zqnMhLSzbsO4AOJDsX58D4G7v0cSZ6Kw
         XiYw==
X-Forwarded-Encrypted: i=1; AKwUvBwYTIREnUsVEM+8U7/fk9avK14QnlmTcFtFRgsqlCqLgl9jUJ7/UmAwbUVbtH/hemEWm+K1aEI=@vger.kernel.org
X-Gm-Message-State: AFuF++njGzVnz2T5LUgY9KF0j41FpCfgwtO8G6XHKkNY6cg2XkvNxd4B
	VaBbBd+yOcyyzckCxbr+Zby0CvY6+pPKJPQRs5Q1aWaqYTpzX2Ra47TEb2zJT+NluYGRE+IQA/5
	ar7SmXPRy/wRl1OfFkXWs/3RPIjb/uYU=
X-Gm-Gg: AYBFou1E6i9eUQPeNxlB6Ljs6A6xor5uCTpg+k+SI07kUhuJnkj5Mf/PXmIDs0tJCEZ
	wN7Sc2IN4/LN+NtkGX5/o/Ld+RQIJxJwZfHwU+IDANgLmhY9FWK3k8A0PCxOKgFP8ZC3PHYeWKK
	ZwU8s4R4PIc6nD19qWtYKVd/P2Z+Pf+3pLtNR+g22jbxC5KQ6C+C17LmhBsE9vG7qZ2Dt/YHkz3
	m+/AKORwxrCUUVgq3FMVvfP3D7BW8La4i6QOmQJCtBdqImvxQiIuJusP+ffmNt0F7jYKJMyw3mi
	f++nCnXN7QfYgItMdy1jzzxMqu9TiyUO1TJ+7JM6olDQT/9DRIad+lj0cLN+SBi/TDIxPiKyPJZ
	ZWSzzD1aEr2X5lwAQgcA33wQ=
X-Received: by 2002:a17:907:1c93:b0:c19:6104:e5e4 with SMTP id
 a640c23a62f3a-c2a159adbefmr463681566b.20.1789815860423; Sat, 19 Sep 2026
 04:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917161335.1020405-2-bestswngs@gmail.com> <20260919110053.497301-2-bestswngs@gmail.com>
In-Reply-To: <20260919110053.497301-2-bestswngs@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Sat, 19 Sep 2026 19:03:43 +0800
X-Gm-Features: AcwNN1VEN7tDxPHeWKB8Nrg6EuEcehqwkEM-7eNLy9K-KJ6bav9GGVH1VcMnkSQ
Message-ID: <CANgPUi3E4g09FpaR2gz0eXuLQuLg4qJAp_Qscorb0b4Szj_akA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: reject dev-bound-only programs on other devices
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, xmei5@asu.edu, 
	co+ac0a8c41de69121d@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<bestswngs@gmail.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=8819=E6=97=A5=E5=91=A8=
=E5=85=AD 19:01=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Weiming Shi <bestswngs@gmail.com>
>
> __bpf_offload_dev_match() falls back to comparing offdev pointers after a=
n
> exact netdev mismatch. Bound-only programs normally have NULL offdevs, so
> unrelated netdevs compare equal. A bound-only program on an
> offload-registered netdev can instead inherit a real offdev and match a
> sibling port. With CAP_BPF and CAP_NET_ADMIN, a caller can use
> bpf(BPF_LINK_CREATE) with a different target ifindex to run metadata kfun=
cs
> specialized for the bound driver on the target driver's xdp_buff. Running=
 a
> veth-bound program on tun reads beyond tun's bare stack xdp_buff as a
> veth_xdp_buff.
>
>   Oops: general protection fault, probably for non-canonical address
>   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>   RIP: 0010:veth_xdp_rx_timestamp (drivers/net/veth.c:1673)
>   Call Trace:
>    ...
>    tun_build_skb (drivers/net/tun.c:1739)
>    tun_get_user (drivers/net/tun.c:1856)
>    tun_chr_write_iter (drivers/net/tun.c:2091)
>    vfs_write (fs/read_write.c:595 fs/read_write.c:687)
>    ksys_write (fs/read_write.c:739)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:84)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> Restrict non-offloaded programs to exact netdev matches and retain the
> shared-offdev fallback only for genuinely offloaded multi-port programs.
>
> Cc: stable@vger.kernel.org
> Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
> Reported-by: <co+ac0a8c41de69121d@bugs.sh>
> Link: https://lore.kernel.org/bpf/20260917161335.1020405-2-bestswngs@gmai=
l.com/
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> Changes in v2:
> - Drop the redundant offdev NULL check.
> - State the capability requirements instead of using attacker wording.
> - Move the regression test to patch 2.
>
>  kernel/bpf/offload.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index 0d6f55695..d85539981 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -698,6 +698,8 @@ static bool __bpf_offload_dev_match(struct bpf_prog *=
prog,
>                 return false;
>         if (offload->netdev =3D=3D netdev)
>                 return true;
> +       if (!bpf_prog_is_offloaded(prog->aux))
> +               return false;
>
>         ondev1 =3D bpf_offload_find_netdev(offload->netdev);
>         ondev2 =3D bpf_offload_find_netdev(netdev);
> --
> 2.55.0

 Sorry for the noise.

 I mistakenly sent this v2 series as a reply to the v1 thread. Please
 disregard this posting. I will resend v2 as a new two-patch series.

 Apologies for the confusion.
