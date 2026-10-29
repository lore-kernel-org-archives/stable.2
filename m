Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793238825;
	b=xT+YO+pgKkYCC877uxQWrbUbGlpQPXm2ZP6CpqQEImiPYc/fKvXXtb9pbsJY1eekRDW+
	 gm/G4jQ/fbwGQE5jzYffOc3y0Yp4YD5nPbAtX8f+I4PP+y/aE1Voylt1vgLXoyatl/FIV
	 Y+DTBDgGcEzDNUUHWrrE4JhkpV/oJsI+CPZS8iIN0LXmBKWKpGSPPAHZu37ySxnl+rYqK
	 AASxPcVT9V33J+lcpPhvklZ48KY1efWoqLAcn05y/vsUOlYeuvqclpDfekzvrDHtw5bqM
	 J/6Qf69Ga0r6ORdNT29DcxlCzFtnka+hFx2dzY/FRc2QCWioS1b0S7A/rt9hOYVgQ5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793238825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=N5xbfmRTc2/OENBILE/RMV+LpLgDZOf9nebMaXGSGAk=;
	b=wWZstsoqRPwCWNJ/uaydbjPDFm/LpZLnyrpqCiDu/mRYYwV3m9xByEMWZCfu+qGND2XG
	 9cfmEWSUEgUmOU04VAT8fJAQJxraVDO8d6iS+qEVoKBFNo+HAMjjBVmDl2DiNfPt6MMwK
	 MwyJWnSZTLrNdfaOV1AqyN3WSriO+BUK1I6JE7khzo7hBU9XIJjnuYWyKfGBaRh+tNoZx
	 7G5MGMCJs9TLsTIQLf2CtrBLhQ73AXc/FeCYDAR3jQiUpuquhjItVqfIHoVE6Qe0txuFk
	 p0iJbwb4rS/5wjeR4Fi2M7TZnomgRzMxjtbl6D3gEB+FmrLcDTUFEkgrMVLOQ9D6YmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VJMzm+5y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B1606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 01:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD2B1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VJMzm+5y
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-156cbe59622so1854182c88.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:53:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793238824; cv=none;
        d=google.com; s=arc-20260327;
        b=hQQXexoBObVWDbd5+2TlAmUwJ9wlkoq/2NYEv4BGfg/06JG2Ty/hh7/4EJ5Mw7HjHl
         eQ6oqhRf1a0aqz9peBqlhpvfzDGNdTF+nkztJQjhNBcIeGE7rlyi7gBonWtLFcKojzAy
         W5kvr1Qi9TcbXd8kjfz5kiQCeI+Ppg+8YwtZugDPRFU97mm23HMX/TgHMsH6sb7j/6Zg
         DEAE7ZpgpHwPlKRwKD4E4YsXzvJe85K7y0llVkkRHSV2zLB7M1dL6K/AMhU/w26bn2fD
         E5ca1AbLruqTeUy4Mm93f5VnxKlI6mE9RwxnkEGGmHJjcrXLCj3/Gt3hiYT+NxE6aKQc
         GgXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N5xbfmRTc2/OENBILE/RMV+LpLgDZOf9nebMaXGSGAk=;
        fh=cdjnIL/DCK9SgQ1d4GYaPYcfraOol6icOollMZmlhIM=;
        b=dICoOMSh1sm9d/MY5262Yaai3MP+tRlflea/ZnOKNtq6cVINWjJdAodqSDP+7RYS5S
         NkVJMGOdA/9uq9HOAm88LQbpjCEupF0lbYX6A/dWf3K3nGI/1sEGwotHUbsKZiQATuhe
         az2PWCd+qQzY1ukoryFCJseANiV7P+y5OBpt+qbbiBesgb8gjP4spNk1PxHGzdGUCLmy
         fqlsd4WN8thf0U8axSBRjCNlLp3nF3sLEMHvaWp4K6JdXOc8KyLTOOGnV4n+k044E++z
         5E5ZcSdBLzKbLG6iWUBMFDq4Ir/Q5gAj1Ki8AEvKLOb4LE7xX68EqQB2GIpbcKTTCI7X
         T17w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793238824; x=1793843624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N5xbfmRTc2/OENBILE/RMV+LpLgDZOf9nebMaXGSGAk=;
        b=VJMzm+5yD/wIGHVb+4KCC3ZIoBHwdyH59pUaKB4/gMct4nvQyIr2wWO9MLgEISmdE2
         uB/52VoBo5XGV2qq6eknNQRI7sDqvlynkCX6gXlIFvQ9WN8zW6sF6uMxmjYsaPrWwQDZ
         9aPPNiiCI6s9pR8d3WmkxbEvTLweIzjoXZhqaPA6zXQiku/+ST+0/BiWCNgIllf0nTbi
         4CuxBgFA36h3YyUTfk1wtsg4MxCFBsrDasyRaJJtGMdEtQyZtD5aylVNvwROoLnUWsWU
         110wWLj7m8gMQlWLPLjNm4F0y5lFAKBKm8U5+URAyRD4lfHsDAfBbvVaN5SFJxhMz66a
         wV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793238824; x=1793843624;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N5xbfmRTc2/OENBILE/RMV+LpLgDZOf9nebMaXGSGAk=;
        b=zPHkfphxEJPUfGiSqRX0SRjb/tQprjl+dnJKc1DwgJqt0LU+Z1FQHzmbmsS0MIPCxb
         K9loHcUbix+YD5f3Ud7BtGxWcnpI21hWBzKAq3ehu+FeAF67+YerWEzHV9t5xj/ZWvkE
         o8LL4Av+2SGYKQtMoNAYt20wmkku9rRYxL+/rCq2wanX7CH3PcumS998E1c4YvQkfwBo
         RSnfUsrKbB+2/r5wxR3rj4CSpv8zi1UIwezsZwBFylgbvpD2kBnQkluc+RBM2snpYwri
         zCrKBGWi77g03lCqifNKJuP0XfFJwWqS3UF4ngigCmQDlACgpxyZaeR26lrAj4KVjfxN
         p0zA==
X-Forwarded-Encrypted: i=1; AKwUvBwkCmbbcZ5r23YcJmPvpvjFNwFW+1SJJbuOkXOezfUWKZddgHOlaXyexDBEsjkqluR9C5CvG6E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqFuy2bO8gCnkwRcBI8Cus59335W8Xxge8k4dpje00w7JA0LP1
	mrhCXXANGp+ugkhQnqEGftmS1YZJYIVywh68UJ2ex1spfh2faanA3Bp0LNik/C92rM2bIjZNrs8
	EL0818FhuWHy2snD9fjOQc4+N4wnQHUbKSV+orRsD
X-Gm-Gg: AYBFou2Xl47+hOzCxEuVdjo9gA6B+MHOA+alHnHyya3QtnezqS+WEThfzcX8z8CDMQr
	EuLOBfR6bv7wjVA/pV/Fg4Gm3PzOq3mv5QBoGTwCUhTuvOHbclSx8a/5QTK1dZbkrzKsnJiFIA+
	ZGDaCm2Z4Ic7eS/guja/eTAi1vNV5LpE5bkMheGX+LEz5rkRUMawGBsqG/MT/Sc8tKOy8+/O7ys
	g6t0Qz7JRTgV4Gj7/JN6orHzvBJO2HbnPyIsRXyWYHH3jehwBZtsOS8CdWvYHCukPbD+F8c8Fzw
	NDB7ZlluH3ACNyVZGOYC6VZZZs4h4dSuukJdb4gaFg1vvjRWUPWA2ndZ6jzsZAn4zuQZ7E082dU
	6W6IWMBkzOC6HqiwgqTUEL6yQj9eWY2M9VGoGJBB6CIozWVCsscn3w9Tyc6SJwkVS4UDfkWoTEt
	zq2C7Naf8aQjLrC7yQ2iYIE7y5obx30QaW7RfVmWWt2StewhgPuLa/T21qQR+V/TqhO7COipuGy
	h8gNvw1OA==
X-Received: by 2002:a05:701b:205b:20b0:194:f017:5a01 with SMTP id
 a92af1059eb24-1a6d1f92f62mr5111887c88.42.1793238822982; Wed, 28 Oct 2026
 18:53:42 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027104701.296240-1-jiayuan.chen@linux.dev>
 <20261027104701.296240-2-jiayuan.chen@linux.dev> <CAAVpQUCBBaVmaZUv+D+a4anSbGSR_pKukYVXvRJRzSGVnjb2kw@mail.gmail.com>
 <eb85d54b-778e-403e-a5a5-56805b23b560@linux.dev>
In-Reply-To: <eb85d54b-778e-403e-a5a5-56805b23b560@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 28 Oct 2026 18:53:31 -0700
X-Gm-Features: AclHuK8XDsp5T4jIaX_MBCMs6DhlHPSgPvRq7TjuW4iyJKF7VUF6t-zq0kYU-QU
Message-ID: <CAAVpQUCHeydud7_NkMuUyK3tdNYLD9GrCGJiGQO6gV+r0-GuHA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/5] ipv6: restrict gc_elasticity to 31
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Fernando Fernandez Mancera <fmancera@suse.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Joel Granados <joel.granados@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Willem de Bruijn <willemb@google.com>, 
	Maoyi Xie <maoyi.xie@ntu.edu.sg>, Jiri Wiesner <jwiesner@suse.de>, 
	Gerd Rausch <gerd.rausch@oracle.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	Yung Chih Su <yuuchihsu@gmail.com>, Wyatt Feng <bronzed_45_vested@icloud.com>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>, Flavio Leitner <fbl@redhat.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 6:47=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 10/29/26 7:58 AM, Kuniyuki Iwashima wrote:
> > On Tue, Oct 27, 2026 at 3:48=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linu=
x.dev> wrote:
> >> Every counted IPv6 dst allocation runs ip6_dst_gc() once the number of
> >> live dst goes over gc_thresh (1024 by default). ip6_dst_gc() decays
> >> ip6_rt_gc_expire by gc_elasticity: the smaller gc_elasticity is, the
> >> smaller ip6_rt_gc_expire gets, i.e. the more aggressive the gc.
> >>
> >> ip6_dst_gc() reads ip6_rt_gc_expire into a u32, but gc_elasticity has =
no
> >> bounds at all, so writing >=3D 32 shifts a 32-bit value by >=3D 32 bit=
s, and
> >> a negative value gives a negative shift count. Both are UB:
> >>
> >>          val =3D atomic_read(&net->ipv6.ip6_rt_gc_expire);
> >>          atomic_set(&net->ipv6.ip6_rt_gc_expire, val - (val >> rt_elas=
ticity));
> >>
> >>    UBSAN: shift-out-of-bounds in net/ipv6/route.c:3369:53
> >>    shift exponent 32 is too large for 32-bit type 'unsigned int'
> >>    CPU: 2 UID: 0 PID: 615 Comm: ping6 Not tainted 7.3.0-rc7+ #364 PREE=
MPT
> >>    Call Trace:
> >>     <IRQ>
> >>     dump_stack_lvl+0xc1/0xf0
> >>     dump_stack+0x10/0x20
> >>     __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
> >>     ip6_dst_gc.cold+0x15/0x1a
> >>     dst_alloc+0x4e0/0x620
> >>     ip6_rt_cache_alloc+0x189/0x7e0
> >>     __ip6_rt_update_pmtu+0x68e/0x1160
> >>     ip6_update_pmtu+0x30c/0x3a0
> >>     icmpv6_err+0x1fa/0x330
> >>     icmpv6_notify+0x303/0x770
> >>     icmpv6_rcv+0xc12/0x1670
> >>     ip6_protocol_deliver_rcu+0xb4a/0x1520
> >>     ip6_input_finish+0x19c/0x400
> >>     ip6_input+0xd4/0x240
> >>     ipv6_rcv+0x1fd/0x330
> >>     __netif_receive_skb_one_core+0x118/0x1c0
> >>     __netif_receive_skb+0x21/0x150
> >>     process_backlog+0x37e/0x1200
> >>     __napi_poll.constprop.0+0xa5/0x5e0
> >>     net_rx_action+0x4c0/0xf70
> >>     handle_softirqs+0x204/0x9b0
> >>     __do_softirq+0x10/0x18
> >>
> >> Make it a u8 and reject writes outside 0..31 with proc_dou8vec_minmax(=
).
> >>
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >> Cc: stable@vger.kernel.org
> >> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> >> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> >> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >> ---
> >> v2: switched to u8 and proc_dou8vec_minmax(), as suggested by Kuniyuki
> >> Iwashima.
> >> ---
> >>   include/net/netns/ipv6.h | 2 +-
> >>   net/ipv6/route.c         | 7 +++++--
> >>   2 files changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
> >> index ffda15318be59..aefce37c04a4f 100644
> >> --- a/include/net/netns/ipv6.h
> >> +++ b/include/net/netns/ipv6.h
> >> @@ -25,11 +25,11 @@ struct netns_sysctl_ipv6 {
> >>          int ip6_rt_gc_min_interval;
> >>          int ip6_rt_gc_timeout;
> >>          int ip6_rt_gc_interval;
> >> -       int ip6_rt_gc_elasticity;
> >>          int ip6_rt_mtu_expires;
> >>          int ip6_rt_min_advmss;
> >>          u32 multipath_hash_fields;
> >>          u8 multipath_hash_policy;
> >> +       u8 ip6_rt_gc_elasticity;
> >>
> >>          __cacheline_group_begin(sysctl_ipv6_flowlabel);
> >>          u8 flowlabel_consistency;
> >> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> >> index 94e5ef1c4f83e..abc8b811cd423 100644
> >> --- a/net/ipv6/route.c
> >> +++ b/net/ipv6/route.c
> >> @@ -6579,6 +6579,8 @@ static int ipv6_sysctl_rtcache_flush(const struc=
t ctl_table *ctl, int write,
> >>          return 0;
> >>   }
> >>
> >> +static int ip6_rt_gc_elasticity_max =3D 31;
> > as you need v3, s/int/u8/
> >
>
> Hi Kuniyuki,
>
> proc_dou8vec_minmax() put extra1/extra2 into proc_uint_conv(), which
> reads them as unsigned int, so the max has to stay an int like
> tcp_syn_retries_max and friends; a u8 there would read
> three bytes past the variable.

Ah exactly, then please use unsigned int.

Thanks
