Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477953;
	b=YU2AGWwn9r3Fdl0Gb3MLdi+efNHdrnXF+TT+XWWwcVtTJdkNmkykdmzWUAkN/m21iV+h
	 dukFvDkpZysS3tM8eKWhTzse+iZT5pOHMgpPQu6dGULU6s88SVN6AZEZInCpKvCGLLFJm
	 hH48dCQRnwnKq02CEjUojPdJCJXeUriVxnvoE2ErpmOWC7Lq2hNeiBKygBvfqCMx8SPeJ
	 DhHWyOOfD4PGU/5VWF0tQizgR2CgJ3cgYyyum+Q2HlN6b8+nvxcePZjwnZduDwGE7mDTC
	 oX9z8CXYJhgiexNCyqIXtJ9B+5W+Q23cCmPsEiElOgHVpp8//onmCERqIbyPhHJywLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=eJpy9wKtB4AptXoRSNPEobdF3i9APnAHY5bJ3PMNze4=;
	b=c5cIcwif+OVD7PrZFs+OCYG1Zoc3i5Q/WSeSBeoq0Fq4/U5ZAUIu40mt2pudhbegIhtp
	 ZVT5lxX2vOW0p90QMiiZYyKspRriQjPSye8QkhMPfqZSzH7RAgJch6LIgpqdoESVlJyjx
	 5wZxzRUKOLQnA/mbyGU1pjF9nn0O59EL6hvOxPb2IHTpySJbanlVmmfCAdtlLEKPZ6fQk
	 C82HUigyDhdmwHzIVEs7+MMv9ZU+O3AHJqiKQp6kfG7/rKN/VYm+UXFSv7PRJzA05fnGM
	 XSGXKo8bj0wq8w/hN7JkGyTIq//dRd9+GHQIo+WVH/VJvkZ63XlC8e24Z5n51HHF79A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BgeZ82+B;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B712D606A335
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B712D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BgeZ82+B
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-490f38e9688so585002f8f.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794477951; x=1795082751; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eJpy9wKtB4AptXoRSNPEobdF3i9APnAHY5bJ3PMNze4=;
        b=BgeZ82+Bo79QHpxPv/epRE2RPqK3+ISRFH03lBH5hq3yEXiIpVlggZssbSik1sTmls
         ryG9W1bKSHK/vMPfLMVQjFN7G8f6tv6LVAHq1TNvqTmvLqMwi9lJTgVeQKQJ8rfEM4Wa
         9M+NN5cOwyVUAOmm4f/8gq9c+zbjV0Ahw+Rz1y5Sn4Rr+nnFZ2Ef1MPD0K1dxnCR9Hbe
         hJD30ngytOwvzcBKYF2HMEDEVlJhnWBfPJGC47kYKiKcuIWyBFss1rM923YOvhQyJOXl
         LG9cSq03kz/tOi1fMcez3i9xXAw4GVPLl5Q+rAJ2AYfc2XMtozYXyAMFTsR9PUYtJNBc
         wLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794477951; x=1795082751;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eJpy9wKtB4AptXoRSNPEobdF3i9APnAHY5bJ3PMNze4=;
        b=Tsb2Sk+EmIjbsMF9AlXyw9StQnu0E/owL7g5Dr4ihXABuNYN+wH5pgZ5rR3hAYUkrf
         wkBmm4B7rIJ2j+/x8+VkCWjn8/M8nkUF2tCeFKLG06+OqTe6H+dNf/qw/HBqfpN9B5/3
         vYhyjcN3W1rNK5IdPt9qG1hn0vDDDhcsEeWPO0/Wv+xgT2iX4a8Obghle+FoConQ4FMr
         OMXBiaA18dY633rE0EnbwDwXdPVkD0LOBSZWWw1xLGSt4DH3vrEdJz75P6zvEcdFnbbg
         /2h1nbz3zPrP6p2+gEMuD9idxC25TVECeXNHuWQiCVkm/oqpuh0Qk5FvoVt1l2qAt91A
         po4Q==
X-Forwarded-Encrypted: i=1; AL+hErFvSY7zFpPpD1LoMWRrOAYVEr3SJVHN440kqt4NwHeLTgXJH/dMbLvGgdEsSjjSKKgL7u8/cYI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mrVVj8X3VuJN66FddQQVK18Io0rGoJG0TaQ9kuzRUa2yY/WMX
	VxYmNgrOB+X9yUXc5JogqIQvqrF1ramYLjRK82E3D6IDW6R474Dz1l2J
X-Gm-Gg: AYBFou1TmejvPfrBC9J/EvgvaSGuq/V1zlEOB8ULVMVKt4qlAxxnNOf51OeY15Ttk5f
	FJBpKyM2PyzjbK4X44Jhug6QhWVq5/F3GUc+irurwd3FX4vMCJQdQDHsxx1jsnSHFr4JUZN0H1d
	/rkGB0vRb5T1+/JQ9XrS3DCvKZ22V3Z2JKwmW0JLOLJrcdrAPQD+6HMWh55uBHUvYFi4h+BAkju
	S2AiG49ACwPy0b5AHyFoqMRqMhBxByf8VfAMQrejEtGm8vewzxHkeMok6iKtLFm7lL7e3w2SSfD
	TiyUJWkFaNEtFdaFuiTa2ASVMq4znsbu8nOqzaXCwrkcR/gyh+dFZXdAZDO0x5EvkgNk7IqtrOK
	879Ozza7PWQxBHU3Tk1b8mqh89dn21PYI70u2Edu1OcelOedzcLQremAGb012ACcmwlBnADU2Gu
	zl1oowWLCifcPzbBrJGJXO4fyZsCNC7hEEUMVUFmT0vA8Ll+539yshsCiU7P+1ghzfyna6TobKu
	gGE12/7mbTxwXM0iy3SPf4xbM+Eh+UJciJDCwbPwS6fGLeCWNiM/wlf2IJLQwSch8+jnBzsXSa9
	3ssscQZedP3PT89fICCZm6l28IUz46usJznyuEXy4mHjldX5Ql8o
X-Received: by 2002:adf:d032:0:b0:48a:f4d4:e1f3 with SMTP id ffacd0b85a97d-49afede0d3amr2836432f8f.13.1794477950811;
        Thu, 12 Nov 2026 02:05:50 -0800 (PST)
Received: from smtpclient.apple ([217.111.110.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498367b99bcsm16587079f8f.51.2026.11.12.02.05.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 02:05:50 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH ipsec] xfrm: use software GSO for inner tunnels without
 crypto offload
From: Usman Malik <usmalik90@gmail.com>
In-Reply-To: <179354432643.3131.245171497251536441@kernel.org>
Date: Thu, 12 Nov 2026 11:05:38 +0100
Cc: steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 horms@kernel.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 cratiu@nvidia.com,
 leon@kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <33CCA7F8-9B0F-42F8-999B-32E9AF5826D1@gmail.com>
References: <20261028-xfrm-inner-gso-v1-1-1908f0eb7313@engineer.com>
 <179354432643.3131.245171497251536441@kernel.org>
To: netdev-bot+sashiko@kernel.org
X-Mailer: Apple Mail (2.3901.200.71.1.16)

On Sun, 1 Nov 2026 14:45:27 +0000, Sashiko AI review wrote:
> [Severity: Critical]
> Can this cause AES-GCM IV reuse for the transport-mode software SA
> traffic that this change sends to xfrm_output_gso()?

Thanks for the review.

The concern is right, and it is not new. Packets with
skb->inner_protocol set, such as vxlan, geneve or ip6tnl, over a
tunnel-mode SA already go through xfrm_output_gso() when an ESP GSO
handler is registered, and with software crypto they hit it today.
Jeremy Jean posted the fix as patch 4/7 of "xfrm: fix ESP IV generation
and ESN authentication".

=
https://lore.kernel.org/netdev/20260930144523.435271-6-Jeremy.Jean@oss.cyb=
er.gouv.fr/

It calls secpath_set() on each segment before xfrm_output2(), so every
segment keeps its own xo->seq until esp_xmit() or esp6_xmit() reads it.

This patch moves the same packets over a transport-mode SA without an
offload device onto that path, so it must not be applied before that
fix.

Teaching xfrm{4,6}_transport_gso_segment() an inner IP tunnel would add
new functionality. Before 0aae2867aa60 these packets never reached the
ESP GSO handlers with software crypto, and the transport handlers do not
produce a valid ESP packet for them. Restoring the software GSO for SAs
without an offload device is the smaller change, and the one stable can
take.

I tested this on v7.3 with a tbf qdisc on the egress veth, so the
segments wait in the queue before validate_xmit_skb(). The traffic was
TCP through an ip6tnl tunnel over an rfc4106(gcm(aes)) SA, with
esp6_offload loaded, 3 MB per run and 3 runs per case. All kernels carry
patch 1/7 of the series, so the esp6 IV off-by-one does not mix into the
counts. The sender capture was decrypted with the SA keys.

kernel                     SA mode     IV values reused per run
v7.3 + 1/7                 tunnel      50, 50, 51
v7.3 + 1/7 + this patch    tunnel      92, 51, 51
v7.3 + 1/7 + this patch    transport   50, 51, 50
v7.3 + 1/7 + 4/7 + this    tunnel      0, 0, 0
v7.3 + 1/7 + 4/7 + this    transport   0, 0, 0

There is no transport-mode row without this patch, because those packets
take the SKB_GSO_ESP path and arrive malformed, which is the bug this
patch fixes. Each reused IV value is shared by up to 7 segments of one
GSO packet, and for one pair under each value ct1 XOR ct2 equals pt1 XOR
pt2, so the keystream is shared. Without the qdisc every case is 0.
Plain TCP over either mode goes through esp6_gso_segment() and is 0 in
every case. v2 will state the dependency on that fix and carry this
test. I will post it once the series is in the ipsec tree, rebased on it
and tested again on that base.

> [Severity: Medium]
> This isn't a bug introduced by this patch, but transport-mode SAs with
> a crypto offload device (x->xso.dev !=3D NULL) still set SKB_GSO_ESP =
here
> for packets with skb->inner_protocol set.

Agreed. When the hw_enc_features of the device do not cover the whole
gso_type, validate_xmit_skb() segments the packet through
esp{4,6}_gso_segment() and xfrm{4,6}_transport_gso_segment() with the
same transport header. v2 will name that path in the changelog. The fix
for it belongs in the transport GSO handlers, as a separate change.

> [Severity: Low]
> This is a pre-existing issue, but x->xso.dev is read here with a plain
> load, and xfrm_dev_state_free() can clear it at the same time:

Pre-existing, and the new test only uses the value as a boolean. I would
leave a READ_ONCE() conversion of x->xso.dev to a separate cleanup that
also covers xfrm_dev_offload_ok() and the NETIF_F_HW_ESP_TX_CSUM check.

pw-bot: cr

Usman


> On 1. Nov 2026, at 15:45, netdev-bot+sashiko@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 1 =C2=B7 High: 0 =C2=B7 Medium: 0 (1) =C2=B7 Low: 0 (1)
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let =
patchwork
> know by including "pw-bot: cr" as a separate line at the end of your =
reply
> (one such reply per series is enough).
>=20
> - [Critical] The patch sends more traffic into xfrm_output_gso(), and =
on
> that path AES-GCM IVs can repeat.
>=20
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but =
transport-
> mode SAs that have a crypto offload device (x->xso.dev !=3D NULL) =
still=E2=80=A6
> - [Low] This problem wasn't introduced by this patch, but =
xfrm_output()
> reads x->xso.dev with plain, unmarked loads: in =
xfrm_dev_offload_ok()=E2=80=A6
>=20
> --
>=20
> xfrm: use software GSO for inner tunnels without crypto offload
>=20
> This commit changes xfrm_output() to use xfrm_output_gso() for GSO
> packets with skb->inner_protocol set. Before, that only happened in
> tunnel mode. Now it also happens when the SA has no offload device. =
The
> goal is to stop the SKB_GSO_ESP path from producing malformed ESP =
packets
> for ipip/ip6tnl traffic over transport-mode software SAs when
> esp4_offload/esp6_offload are loaded.
>=20
>> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
>> index e305ba32e356b..c370d28a83f50 100644
>> --- a/net/xfrm/xfrm_output.c
>> +++ b/net/xfrm/xfrm_output.c
>> @@ -808,7 +808,8 @@ int xfrm_output(struct sock *sk, struct sk_buff =
*skb)
>> skb->encapsulation =3D 1;
>>=20
>> if (skb_is_gso(skb)) {
>> - if (skb->inner_protocol && x->props.mode =3D=3D XFRM_MODE_TUNNEL)
>> + if (skb->inner_protocol &&
>> +    (x->props.mode =3D=3D XFRM_MODE_TUNNEL || !x->xso.dev))
>> return xfrm_output_gso(net, sk, skb);
>=20
> [Severity: Critical]
> Can this cause AES-GCM IV reuse for the transport-mode software SA
> traffic that this change sends to xfrm_output_gso()?
>=20
> Before this point, xfrm_output() has attached a sec_path with
> sp->olen =3D 1, so the skb carries an xfrm_offload. xfrm_output_gso() =
then
> calls skb_gso_segment(). In skb_segment()->__copy_skb_header(),
> __skb_ext_copy() only takes a reference on the extension:
>=20
> include/linux/skbuff.h:__skb_ext_copy() {
> ...
> refcount_inc(&ext->refcnt);
> dst->extensions =3D ext;
> ...
> }
>=20
> So all segments seem to share one struct xfrm_offload.
>=20
> For each segment, xfrm_output2()->...->xfrm_replay_overflow_offload()
> writes to that shared xo:
>=20
> net/xfrm/xfrm_replay.c:xfrm_replay_overflow_offload() {
> ...
> if (!skb_is_gso(skb)) {
> XFRM_SKB_CB(skb)->seq.output.low =3D ++oseq;
> xo->seq.low =3D oseq;
> ...
> }
>=20
> The XFRM_SKB_CB() copy belongs to each skb, but xo->seq.low is in the
> shared extension.
>=20
> Encryption happens later, at qdisc dequeue time, in
> validate_xmit_skb()->validate_xmit_xfrm()->esp_xmit(). That code reads
> the shared value:
>=20
> net/ipv4/esp4_offload.c:esp_xmit() {
> ...
> seq =3D xo->seq.low;
> ...
> esp.seqno =3D cpu_to_be64(seq + ((u64)xo->seq.hi << 32));
> ...
> }
>=20
> XFRM_GSO_SEGMENT is not set on this path, so nothing advances
> xo->seq.low per segment. esp_output_tail() then copies esp->seqno into
> the AEAD IV. esp6_xmit() does the same.
>=20
> Segments can wait in the qdisc while the xfrm_output_gso() loop keeps
> running. For example, dequeue_skb() returns nothing while a
> TCQ_F_ONETXQUEUE txq is stopped by BQL or a full ring, or another CPU
> may already be running the qdisc. In that case, won't later segments
> overwrite xo->seq.low before the earlier ones are encrypted?
>=20
> Each packet would still have a distinct esph->seq_no on the wire, but
> the explicit IVs would be the same. That is GCM nonce reuse under one
> key. The receiver takes the IV from the packet, so decryption still
> succeeds and nothing reports the problem.
>=20
> veth is noqueue, so in the test setup validate_xmit_skb() runs before
> the next segment's xfrm_output_one(). That would hide this.
>=20
> Tunnel-mode software SAs already use this mechanism today. In the base
> tree, however, these transport-mode packets, including the vxlan and
> geneve traffic that worked, went down the SKB_GSO_ESP path. There,
> xo->seq.low advances per segment within one validate_xmit_xfrm() call,
> on an extension owned by a single GSO skb.
>=20
> Could the sec_path be unshared per segment, or the IV be taken from =
the
> per-skb XFRM_SKB_CB() sequence? Another option would be to fix
> xfrm{4,6}_transport_gso_segment() instead of rerouting these packets.
>=20
> [Severity: Low]
> This is a pre-existing issue, but x->xso.dev is read here with a plain
> load, and xfrm_dev_state_free() can clear it at the same time:
>=20
> net/xfrm/xfrm_state.c:xfrm_dev_state_free() {
> ...
> WRITE_ONCE(xso->dev, NULL);
> xso->type =3D XFRM_DEV_OFFLOAD_UNSPECIFIED;
> netdev_put(dev, &xso->dev_tracker);
> ...
> }
>=20
> The new !x->xso.dev test is only used as a boolean, and either value
> leads to a valid path. At worst it is a data race that KCSAN can see,
> like the one already in xfrm_dev_offload_ok():
>=20
> struct net_device *dev =3D x->xso.dev;
>=20
> Further down in xfrm_output(), the check-then-dereference also uses =
two
> plain loads. This patch does not touch it:
>=20
> if (x->xso.dev && x->xso.dev->features & NETIF_F_HW_ESP_TX_CSUM)
>=20
> Would it make sense to read x->xso.dev once with READ_ONCE() into a
> local variable and use that for these checks?
>=20
>>=20
>> skb_shinfo(skb)->gso_type |=3D SKB_GSO_ESP;
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch, but transport-mode SAs with
> a crypto offload device (x->xso.dev !=3D NULL) still set SKB_GSO_ESP =
here
> for packets with skb->inner_protocol set.
>=20
> The commit message says:
>=20
> "An SA with crypto offload that falls back to software
> segmentation in validate_xmit_xfrm() takes the same path."
>=20
> Is the reroute/overflow fallback in validate_xmit_xfrm() the only way =
to
> get there? validate_xmit_skb() also does this:
>=20
> net/core/dev.c:validate_xmit_skb() {
> ...
> if (netif_needs_gso(skb, features)) {
> struct sk_buff *segs;
>=20
> segs =3D skb_gso_segment(skb, features);
> ...
> }
>=20
> That runs whenever the device's hw_enc_features don't cover the whole
> gso_type, for example SKB_GSO_ESP | SKB_GSO_IPXIP4. The call chain =
would
> then be:
>=20
> skb_gso_segment()
> esp4_gso_segment()
> xfrm4_transport_gso_segment()
>   inet_gso_segment()   /* inner IPIP, transport header at inner L4 */
>=20
> followed by validate_xmit_xfrm()->__xfrm_transport_prep()->esp_xmit().
> That writes the ESP header 4 bytes into the inner IP header, which is
> the same malformed layout the commit message describes.
> xfrm6_transport_gso_segment() has the same limitation.
>=20
> Could the commit message mention this fallback as well?
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028-xfrm-inner-gs=
o-v1-1-1908f0eb7313%40engineer.com

