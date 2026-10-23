Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792791069;
	b=XEJWnFqv6uN5i4IIuktYQkHsgbROJWrV8qrzIdF/au7P9eUUFOGmNp7BXeFT+h6HE3GG
	 QVxIbX2zOTmaM5odIYdaRpRp30Ibipsb6vZV6KlJGU2QzAyojOxmm0kGz8dtWvyGElvip
	 AJBPHZx8iWks0q+drqdIDUe9Z3kT6czd2RujDFvwwNmbj/EqPJ7Bsxx3FxdciNWhSPXDG
	 Z9Z8huoPzAadpaJOupz6QbsjIcu1cxUuY4mev9HUEguJlmf2kuFEvkcJGiViAyu+XODO7
	 LfduCBHCc/MUTle+jbtSH/8q4SjCYaPtkkiaaDliHOj43ODyYU31Bde4WRHgHHvA06A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792791069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PzEYTFRDtyc4C3h5BFo8qsoM3fBDf8Wp9E/Xwuh394w=;
	b=kB2QwcjzQiq0A7tMS+5vlzUEfEttyB8GoyiKw/frqF0d7g9HtGXJWCFLHbuv7UKBrWt2
	 EorZgyWIam2xrNueKkI0cSno5yWZUDMZ0hyP0fsq/VB/jB5wI7nz2MUbBJ7BIH+aI0xh0
	 3+O25Or6at5qISL7/b9bAVwijhjBP9Gmn8OSzlixryjqxCI62z8rUefWyr+GtZqgTx5/v
	 0PF+9YKVhQu1FdvfpL8m+Kj44/U9KQJgezpWZYFQsR0yMX879hhO5J9f/42FjrMCw4/8K
	 VqTd+Ax0jxpFf9t3aGFtl6mBjNJotmRNpCErC0FYcsudTs/lG2WQ0P+e92SxUm2MLoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Cz8UiCpP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5FD606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 21:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD5FD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Cz8UiCpP
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a070b3f44aso527305b3a.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 14:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792791068; cv=none;
        d=google.com; s=arc-20260327;
        b=L5prAra4AauJ4YLK/riBLqRBpGcP7j5RFcyi1dEursNWA54iJxVFYO1QwW/yGDR0NQ
         aWZQAyw/c8NRn6sevh+0tkifPteWN4B1mD2YHlqkaf1VmT5hGYpqwgZRiISM+EnxfAsn
         lwC/CrvE+biCsFyJ+bDw4kLla8k1E/U3hXsboRUjXVekxJMyQwM79cr6xTRdOhpCDIzx
         BjvUHw4wopJnlgD4C2xiGG/3EnvkxESQrj6ZUvnuh6Q0DqmEoDd8tgMpdixU9XPd3HDm
         ZHCMyXsOTVcMLx5ymb1t08vto3ZluxA6gbVm5JSOgX5t900BmmHdR7zNv3z6twJzBV/Q
         sYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PzEYTFRDtyc4C3h5BFo8qsoM3fBDf8Wp9E/Xwuh394w=;
        fh=NAGV9z0mvtL1wxZa3nZZg0DpCA9LQUzGKje2w0ViMNQ=;
        b=f0ba9J6nlCsytWEsYbHSYsJtT/9pJyTkmADyxO9nozH1wTu/qLnYdBm6Z/ddCbDqvx
         mhio8XX93aU5Sv8dJynZoEcheZVnCsXzLoJjDiBrYVT1VjLjmW/JHjvdqVVEkO15ts+p
         OOCR8FV0zQ/Qqw64A5t4OHR5ZRh5fJPrHHV5nWSDHBXp8jO3f+UqSGN2PN4AaFyY3/1b
         w4937hWvf58+uAQXx6edxUYiFZL3iPqz7wT/mx075cbzMDPck5J9EFQuDuS4URwJ+EBK
         5pG37rFuj61SVBuXrZTJM9gk0Cl/RAuK9JFQsFjqU0VJMoxcjEbQUlQ7mh6jnOExgc53
         w1tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792791068; x=1793395868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PzEYTFRDtyc4C3h5BFo8qsoM3fBDf8Wp9E/Xwuh394w=;
        b=Cz8UiCpPA8AGlKB1MxLsix2zKDAkQ11XDr2O4iWmC/V37vL91mBt1ynXloR898RzAn
         tk25S/OqHUsV+63Q+Jp8QgDuM80S3ybFd8ktMUW60fz6WzylowQ9XhJzSrB5NYD4CDYK
         m7P+2FHrNiAyfvowAfX2h+OkgzlbCTFI+HWdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792791068; x=1793395868;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzEYTFRDtyc4C3h5BFo8qsoM3fBDf8Wp9E/Xwuh394w=;
        b=iuRfZn4pstpOERFq7YvU0+v6OKP9FfVtgu0SdnuxPykmOt+R3GTx1LeksYdY9V5meI
         XpDva0HZAHAlhjFkfEKV+9xgQyYJLiduD82Fpr2ObHa7QWkuAi4vEgsYHXRFmIDpMC+g
         g9wzjJ2o2vqooD9tfk5OcdvPt4fp6fZf5Ry9Ze0MIeOeYNQfGP+J8JoQ6Q8YSWMy+Rx5
         wtuSifM0tp7OYclAFIxHcrrHlOSA8FnIgf4vkx383x4Msxz0BmMuBG01lObK/oOraD//
         9gW3tEMV9F4K9H1Jwt4FbjJz7DG4Bd8Q0Bk8TCdjyQ3tzrDoGmBx/2bsnY+gYGfcHTtl
         B8Sg==
X-Forwarded-Encrypted: i=1; AKwUvBxXAhSAha4WyGVmv/gUznwmQemGNF2fAPX3MSoo7dv8AkyOea1O31lnLt/vCqq+Gt5iFhOnGLo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHE3WTHV4MSnwvID0dRqJ8Ax/5fEzl6av8M4smxX7sY5DsKFht
	qPZ0t/MrrXlmmU4lXlVKC+NDLRbNC2Aa/8U9K3Xsy9PyhXAQapsWcGfOIQvDi8wL0um2KQidImi
	szbk9PlMQ9YcXBRJem+9lh604N/zCDjG4YJ0AAKpy
X-Gm-Gg: AYBFou2vwNuoSktp0Weeo+3bhMwa3bo/TQcS2DkZdX0iYnhZy0nWaYRG+IAMd8/F6F+
	68eUlud0J53SXlS+O85H7+ygSqXVPmhY+HUZzok5eBXuLv7xWA+Clpv71tUrQrn2uMtLNDvh9CL
	cpG59BO0KCOKgC+1zFhDr7h9tyJ5KSvwyf0JVgLnRYNvZLoMPo48Z7fSlZAOLFatDR4XZSraDOL
	qiMkoIDfvMkiVO69ufVZmwG0N03a+lTf/VHADs4PTKTHAeVy1zbLYyGufdp5ZntraI796iruov+
	vhgm+V+EAmKPJRnDWfP9aPLa3kZBG3/44WQnKKNltxJF0cpjqYLMoXW8zo12q3O2BfN2gD8Y5Zr
	a3H0ORbAKKSmAw53pqKHrhduDjZlPY5ZAUaWT83fCFUGaRKQd/HP/Jg1delhP4xcL0aGxcdYtPw
	e6mhJPqeuLIE52SHo=
X-Received: by 2002:a05:6a20:918e:b0:3e2:1656:b7c7 with SMTP id
 adf61e73a8af0-3e7cd4d7e66mr232661637.58.1792791068108; Fri, 23 Oct 2026
 14:31:08 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <20261023122819.5e48ea9e@kernel.org>
 <CAM0EoMkaPX_He3yCExA0DG4KuQQd6JLP=6qgsXn0kzry4+P2nA@mail.gmail.com>
In-Reply-To: <CAM0EoMkaPX_He3yCExA0DG4KuQQd6JLP=6qgsXn0kzry4+P2nA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Oct 2026 17:30:57 -0400
X-Gm-Features: AclHuK8KFEdBienchfGQ8aWKEmTXYn0IoyZR8uNBb9I_76trZTMsow8k34a8Nw4
Message-ID: <CAM0EoMmKEvDD6YSu-CXxE39AhfF9MA7GA2HTho3+_etCx6ArcQ@mail.gmail.com>
Subject: Re: [PATCH net v2 0/6] net: pull short linear Ethernet headers before eth_type_trans()
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Guillaume Nault <gnault@redhat.com>, Simon Horman <horms@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, 
	Ren Wei <n05ec@lzu.edu.cn>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jason Wang <jasowangio@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	stable@vger.kernel.org, Martin Varghese <martin.varghese@nokia.com>, 
	Pravin B Shelar <pshelar@ovn.org>, Shmulik Ladkani <sladkani@proofpoint.com>, 
	Yotam Gigi <yotam.gi@gmail.com>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, dev@openvswitch.org, 
	Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 4:49=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Fri, Oct 23, 2026 at 3:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Fri, 23 Oct 2026 07:59:15 -0400 Jamal Hadi Salim wrote:
> > > This series fixes a class of producer/consumer bugs in which an outer
> > > header is popped and the packet is then handed to a consumer with few=
er
> > > than ETH_HLEN bytes in the linear area.  eth_type_trans() pulls ETH_H=
LEN
> > > from that area and can BUG in __skb_pull() when the inner Ethernet he=
ader
> > > is not linear.  The affected producers are act_vlan POP_ETH, act_mpls=
 POP,
> > > act_ife egress decode, and the Open vSwitch MPLS/TEB and NSH pops.  A
> > > consumer-side guard in act_mirred rejects redirecting a headerless pa=
cket
> > > to a device that expects a link-layer header.
> > >
> > > Patch 1 makes act_vlan POP_ETH pull the inner Ethernet header after t=
he
> > > pop and drop only when the packet is genuinely shorter than ETH_HLEN.
> > > Patch 2 does the same for act_mpls, gated on the pre-pop MAC length.
> > > Patch 3 adds the act_mirred guard at the redirect boundary.  Patch 4
> > > keeps act_ife egress decode from consuming the inner Ethernet header =
and
> > > restores the header metadata.
> > >
> > > Patches 5 and 6 establish the same linear-header invariant for the OV=
S
> > > MPLS/TEB and NSH pops before restoring MAC_PROTO_ETHERNET.
> >
> > NIPA CI flagged a regression that appears to be introduced by this patc=
h
> > (or one of the closely related act_vlan/act_mirred patches in the same
> > series).
> >
> > The selftest tools/testing/selftests/net/forwarding/tc_mpls_l2vpn.sh no=
w
> > fails reliably (both the "ping" and "ping6" sub-tests, on both the
> > regular and debug forwarding test configs, consistently on retry as
> > well):
> >
> >   # TEST: ping    [FAIL]
> >   # TEST: ping6   [FAIL]
> >
> > The test builds an Ethernet-over-MPLS L2VPN using exactly the tc action
> > sequence this series touches:
> >
> >   - ingress: mpls mac_push + vlan push_eth + mirred egress redirect
> >   - ingress: vlan pop_eth + mpls pop protocol teb + mirred egress redir=
ect
> >
> > dmesg on the test run shows mirred failing to redirect the traffic:
> >
> >   tc mirred to Houston: device veth2 is down
> >   tc mirred to Houston: device veth3 is down
> >
> > This is the same "vlan pop_eth followed by mpls pop" chain described in
> > this patch's own commit message as the bug reproduction scenario, so it
> > looks like the mac_len/pskb_may_pull bookkeeping added here may not be
> > correctly handling the ingress case used by this test, causing otherwis=
e
> > valid packets built by this chain to be mishandled and the redirect to
> > fail.
> >
> > Could you take a look at whether the new POP header-pull logic correctl=
y
> > handles the "vlan pop_eth -> mpls pop protocol teb -> mirred redirect"
> > chain on ingress? It would also be worth double-checking this alongside
> > the companion act_vlan POP_ETH and act_mirred link-layer-header patches
> > from the same series, since they touch the same pipeline.
>
> Victor monitors NIPA but is currently away for a few days. I will take
> a look. Eric pointed out this broke:
> tools/testing/selftests/net/forwarding/tc_mpls_l2vpn.sh
> I'm working on updating that and will try to fix this as well..

ok, the new update fixes this. I was planning to wait for the
obligatory 24 hours (so tommorow my AM)- unless you say otherwise..


cheers,
jamal

> cheers,
> jamal
