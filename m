Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795070451;
	b=Luk/bdUxoWK/8yX/lo8LPAK0hq20MkfFCnQ/R1Jsq3uX6IOUfSZWjVYvxfzOeOEvJNGT
	 9RaHeWWh/U/X+YBHLrKBuRw3vSf9pKYtb6Nkuk4HU1ktV+pTFop8qOQzm3JmuIxm51QwT
	 P3FhnuyylQexVkvjpIwIZd+cuG27VEKSGQpWxji8NbI7uzfo8tQFKVuNb7azh6TlBG4LT
	 19n924Je+fD+TUAjkn7eYzGSWuYWvZPxPvb+u3ywkKz979XTjPH6ruKSe76OojHscJiEj
	 DNDWTdArzLf4cfQ7Glhitwu1aFuEIqOLFcNavX/XvEfKlY6c6mhowMiW9yBCqL7eSLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795070451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4vyBC6w1c2kfBv4g+VEt1O4vX3XdHDpIvEBRZIhB4ZE=;
	b=H4NdIeL2/PIRUQ6XiA96A6eWHeTtTc6jsn1Q9W0w8P42O4KpLgG7y63ilKfdyEUtDre6
	 fBcq5LH/uEzifTjQomxynx3CI2KEAcV0vi1qetQxdrBASISQtcSEAELBKFT4UWvrB7UKd
	 gAoRG3xbvvTbRV+/fM0Bv+JMpH9b26Scg62CyO0ReTjjyiBVffbahbBpCLpxEp7ii5K6F
	 3yu63Wu2sgoMOBd6W6ae7mRMxDFSBLIZGB7deIPDQeASwZK1zbwNg1Szvgae2U96Ylbq9
	 +8EGo4JKDc8F+lwg9+Z1+uAUc49Z4QmRAhO/hWbAUFmDJf01YhNhX5+5Tu5Qg6AdVTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jhW3n0Xn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0353D606A32C
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 06:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0353D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jhW3n0Xn
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-949589c1495so163984185a.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:40:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795070450; cv=none;
        d=google.com; s=arc-20260327;
        b=OTor6Px0sFMPtg89h8+L1Mv0wpEKMa5FUJsAxEqJXcS1kan4T37KOgM0FZ0f5e7kTf
         CtfN1QeLt9/NUm1JTE7PBKOnLH6IikXmLYE7AyW8ZCjfHJdpfTPvBCTaK2ZOOV//4dAx
         A9shPkh7lWwy+eswQzeTnSs5mlMkW3oxHwn+g46EOuqmxGzR5L/KWTkWOqmUjPQzxRWe
         nGT49BfEn2fQf+wdKhCk20/jDXHoXPPQ0+mhruxJL4fJyXEkQa/oqTVE2XXgNZYeCrqp
         A9xRVJjr/w/SlCQC3wHACSVLpQN7Lx/hMZ3SeZG9Q2+8gd02jL4SZ2eTvL9ucqLSglKn
         obag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4vyBC6w1c2kfBv4g+VEt1O4vX3XdHDpIvEBRZIhB4ZE=;
        fh=nmVbYjpLGPQ8Z5YyVasm0DuV9/xKzervM0v58eEmm7Q=;
        b=Njd4jmNBcB2m2vCNaolHpuYO4+5SK7XzOPSfNxqNE/hZKm3rhdfRpraifhlqMqRgoa
         Y9egcnLQrWIxXsG54NNouWIz1H4laqgSZnFo98WgOrmc6xPjK98b5tf6gt+4hqxkIoxv
         godGEJymq4lP+0ovCUrnHODVn4YDE31RSrFgkhE3drWrCKf+W2cfq+eMk7UJLdQGaBIr
         LUGnKCStS2Ed2aICMiZDDpS5KFGE7fzGjl/U27h4EWMFPd14BXqFPkZuTm0m6k9Dcja6
         xohdkJwmTRfGZ5l8C3iLbPnjFHQ0wIPbwsLIRKA2DbZL9DLAtIBgxaao5OY3QUTw1feN
         NZ5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795070450; x=1795675250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4vyBC6w1c2kfBv4g+VEt1O4vX3XdHDpIvEBRZIhB4ZE=;
        b=jhW3n0Xn9gARi9x0ofcuuogedfCn+BkFrjDUJgr84m9OvvVHljmtFoB+NmisYI89Qx
         AxW+LKYOzXjgCMDwzV5xLhiLAQoRQDkx/7Zb0ZI9PW9coK/krjPflgtmmdGrsfM3Ba7k
         qoTrz0p2+kHNjZ7TlzXoGYD0rM3H2quwySZAXLqYKZ+T32TWFvJ73oNCZ5oqprHpMKtQ
         4Lu2rPKLV2z1HmFL/YVhjE1JmDivGLCyPSihRVY6zS9OEekq/nD16qOR/yfs6WmSOBNi
         dQq7Us2dlCjpIH2JcAth8AZ/C1Rkq/hSwRLB96GRjVz+5BnKPI0ztsMqUaBheCAyhKiA
         YmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795070450; x=1795675250;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vyBC6w1c2kfBv4g+VEt1O4vX3XdHDpIvEBRZIhB4ZE=;
        b=XJXc6uEd5MxF/jzxF3U63f6RHUUdHg8PG7UtN284KSxqXYmiXYo2TdDCyfHK1qVBWA
         iR+k8I8Xqea7Mfq/1D2S0cGIimGu5LiyniR0OODkyNYokh5zpqlls+/FtlWxhrO4nrTW
         uhn+TwMDe+vL4cl6zS7HSDHUBGHkTn5vaiZdjKak1+6fx3hnTh3bGRdkelAE5tzwESa3
         y9kX6btZGFrNl/wD7MQnr6vlFNNmSQtnAMq4e/cwJZyXzDqth52LyRINCl9346N3CmfL
         ycItgXgYwNRBUN6xmgZeMiNkWu8XSXth+kwcPSGuEJtB76z2s3vKplWI0w7bMBth+ufM
         Hxnw==
X-Forwarded-Encrypted: i=1; AL+hErECHUQR7dei5VAvABRdr54o93tIt70A1eJJs1UvteakLucYHL09kTbtH3Qjo54WuYsh1Holyt0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8IJaZM5DyJ15wGXMpFu51o/7tgKy97Dxf1gxoa67o6cHEirOgb
	tfoDmKSDwySnARanmAN4lm8aU6B15jxQA1H1D6Cci7h5h3lY3NPO+c+YpQQtHzXgESCw3SnZRJR
	wjZ/0P7lKXxeieWjYfyFI5F1TO4SLURU=
X-Gm-Gg: AZFdTZezFcpcyAyoaN8kJ9Kxd+yuddwsjDTpJmVqUT7IMwPvn1PVW/vHSa4EQ/rrdeS
	MrCPdEv5x9ClqPr6fsnxVU22MwjUzEQ+WJgZMt/H0DYjzXg3G7JBpRCOP1nDmL3DaCF+2nSyjCQ
	HAm9Id9sSk4A6VytjFEvOS8EcV00EkzVx6+sz3VO1Kbr+xClxaJXhktylk5WLXK6Rujl3hmxcRL
	X92TJwamc8yt5ak6GBMfJUQedMwU7147SWmgpCHNPjlYVjvn69TBot8jyQ90oh5QV0X/hNP3cGL
	Z/tayiASkvYKizU5L4LzdhYrX46+vDPmpmHfOjm9AJg0jTXrCr7vbyL/Gibnpv03r0HCCm59Hus
	nU7ye6xBwHwFD/Ym5OvJdDkyeuwsEcbvBIWdNPXBBdSu9ybIVVV3GdTvWwelBABiA/AM5gFT6oH
	uHkpllIe2S7qAcrRXmFw==
X-Received: by 2002:a05:6214:c24:b0:921:25e2:f405 with SMTP id
 6a1803df08f44-92125e2f476mr29167786d6.25.1795070449941; Wed, 18 Nov 2026
 22:40:49 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAMcAce8_ZR9xr8KJe6kvDNxr-JW2A5Ya5tn_2SO86hn7oR1KCQ@mail.gmail.com>
 <DMYZ2PEBP5GQ.NPCWIL8HYD9H@gmail.com>
In-Reply-To: <DMYZ2PEBP5GQ.NPCWIL8HYD9H@gmail.com>
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 01:40:39 -0500
X-Gm-Features: Aa3M54plz_Orq12J14XfQGfiJZ2U7JU78GoIdc0A9kFDUk3u54uI30c3-_G3pG4
Message-ID: <CAMcAce8VXbawBDJHta-2HneyVW+r3sFmqbFC9=eqCR4tkU5mBQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, lsm: Remove bpf_lsm_release_secctx from sleepable_lsm_hooks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, security@kernel.org, kpsingh@kernel.org, 
	matt@bobrowski.net, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

I sincerely apologize for the confusion caused by my Gmail display name.

I am an academic security researcher, not an AI bot. The display name
on my personal Google account was inadvertently set to a fictional
alias, and I completely understand and respect the kernel's strict
Developer Certificate of Origin (DCO) requirement for real names. I
have now corrected my sender name to my real name.

The patch itself was manually analyzed, developed, and verified on
QEMU x86_64 running 7.4.0-rc3 and 6.12.118 LTS:
- Context: security_release_secctx() is called in atomic/RCU/softirq
context by Netfilter (e.g., ct_seq_start() holding rcu_read_lock(),
and nfqnl_enqueue_packet() in RX softirq).
- Issue: Having bpf_lsm_release_secctx listed in sleepable_lsm_hooks
allows lsm.s/ programs to call sleeping helpers/kfuncs (like
bpf_copy_from_user), which triggers "scheduling while atomic" warnings
or RCU stalls in those paths.
- Verification: Tested in QEMU with a custom BPF reproducer loading an
lsm.s/release_secctx program. Pre-patch loads successfully; post-patch
is rejected with -EINVAL.

I will re-send a clean v2 with my verified legal name in the
Signed-off-by and commit metadata.

Again, my apologies for the oversight regarding the sender identity,
and thank you for keeping the mailing list standards high.

Sincerely,
Yingke Xiao

Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2026=E5=B9=B411=
=E6=9C=8819=E6=97=A5=E5=91=A8=E5=9B=9B 01:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu Nov 19, 2026 at 6:18 AM UTC, =E6=A2=93=E5=B7=9D=E5=92=B2=E5=A4=AA =
wrote:
> > security_release_secctx() invokes release_secctx LSM callbacks
> > (selinux_release_secctx() and apparmor_release_secctx()), which only
> > kfree(cp->context) and never sleep. Because the hook is non-blocking,
> > Netfilter callers legitimately invoke security_release_secctx() under
> > atomic, RCU, or softirq context:
> >
> >   1. net/netfilter/nf_conntrack_standalone.c: ct_seq_start() acquires
> >      rcu_read_lock() and holds it across ct_seq_show() ->
> >      ct_show_secctx() -> security_release_secctx(&ctx) until ct_seq_sto=
p().
> >   2. net/netfilter/nfnetlink_queue.c: nfqnl_enqueue_packet() runs under
> >      rcu_read_lock() in packet RX softirq and calls
> >      nfqnl_build_packet_message(), which allocates with GFP_ATOMIC and
> >      calls security_release_secctx(&ctx).
> >   3. net/netfilter/nf_conntrack_netlink.c: ctnetlink_conntrack_event()
> >      allocates with GFP_ATOMIC and calls ctnetlink_dump_secctx() ->
> >      security_release_secctx(&ctx).
> >
> > Listing BTF_ID(func, bpf_lsm_release_secctx) in sleepable_lsm_hooks
> > lets BPF_PROG_TYPE_LSM sleepable programs (lsm.s/release_secctx) call
> > blocking helpers/kfuncs such as bpf_copy_from_user() in atomic/RCU/soft=
irq
> > context, causing BUG: scheduling while atomic or RCU stalls.
> >
> > Remove bpf_lsm_release_secctx from sleepable_lsm_hooks. Verified by
> > line inspection on 7.4.0-rc3 (20eef29b7c84), 6.12.118 (bpf_lsm.c:347),
> > and 6.6.162 (bpf_lsm.c:337), and live QEMU BPF verifier runs on
> > x86_64 7.4.0-rc3 and 6.12.118 (lsm.s/release_secctx: LOADED pre-patch -=
>
> > REJECTED post-patch with -EINVAL, "bpf_lsm_release_secctx is not
> > sleepable").
> >
> > Fixes: 423f16108c9d ("bpf: Augment the set of sleepable LSM hooks")
> > Cc: stable@vger.kernel.org # 5.10+
> > Signed-off-by: BoBppy <inkxiao12@gmail.com>
>
> This is not a real name.
> I'm dropping all of your patches.
> Teach your bot basics first.
>
> pw-bot: cr
>
