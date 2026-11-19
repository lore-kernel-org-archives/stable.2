Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092039;
	b=DDj/Xm2LarCptoA+XC/MWs9nvQqCkUs5q783D84H/9g169lF3RAUXX96R+XdoYIBZeBF
	 AoCKoHHdjBxCAsYjIzkx+W/JPQqG0+luekNlnw/oSiO12e5LyIstzPmd+a6xtXNgi4jvY
	 dniAOyQrY1QVuY+fIeY+DIMaTKoaeiT/Ln5b4mOcd33m0FHBQpFy10/dNVcoCNOd4P437
	 gb8SV9zw6U8xkWOpIXa1J7MiHPovgA9RtfW106uAdowUYbpVx8vcQD2SGKJpUsMxqwqq2
	 8JUrF+ZzUmAlkhJrhnbhaxg1CZF8Y05uAy+5K4Y9EE2nq8nLApzVb29hR61M97u8E9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/HBktdhhH40COOtgFHhMziUMTJYpM/f/9inUmvkMpn0=;
	b=Jelyt8k15itndTUAoqbX1PFLeu34V0tnhHAd7zQ3/0n96UUVJbXx1MMYklWdXwcRvVJT
	 YDq/WYHVyc1JYwFHSMgOvQFrrViMqOEYoJo55dpOvywT6cgDiJuKpMNZtAex1zs/E4szn
	 Vm0DJwaSl4pDnrOIKK73EdOe0NcfYo8yJlaXkuYb7XRsKZPkeNYHjmTo8N2vNkwreHs0Z
	 vRSUkYeDBqZaBjTY4teRU8S5uFTtAylm7JaEeYfQv+WdwReAoZwVKzqB0CJWZoRfFbGWS
	 wv1bFRbAbNX9+M6nx0VjsMs4Tv4WVzftgmHrGw66vSBbb/7EcPunxxZSXGRQ8bvwi+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=TG59cT47;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930F3606A330
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 930F3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=TG59cT47
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5366ae57896so20824041cf.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 04:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795092037; x=1795696837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/HBktdhhH40COOtgFHhMziUMTJYpM/f/9inUmvkMpn0=;
        b=TG59cT47d78F1RoC28G8m4TwPz6aL4pqdP6Eo2YIKsEOX6vagNfv3qWajo+aP3L6vL
         bJobuGx0zpMVC8S5LTj4VZvIyTLEPzCcs1u5Pn1oHPdt3yXV2H4YHlQ/lAUaBDuINIhS
         NTPjMyB8ek/ZQ2OCKgWgzvG06qpqF/XuuLApE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795092037; x=1795696837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/HBktdhhH40COOtgFHhMziUMTJYpM/f/9inUmvkMpn0=;
        b=Zn6dip1ZeaSKwaecKJhPQrFDn6Q3kl4dDGDSLFZBWdxcbaWxiuEnIBSDFh7eMVYCYi
         fP6KVP1F0mM4fxKo5IWewjRvjakEh9RhyswkNmnRxAHMNnKE6X+obUlQzZ6paCox9mld
         5qwbogTfGWqthu9bZqNFjguLXc8SeRW9ed41VxbX1Kiqkr1zEdAas/YmhBMm3AeXpArk
         TQsyjtcO68q/9yUPwgdco447YubaVAHkxX5OoeG2mRvfztsJoWiaWOEcA7MamS1YTitH
         UL9+g10VfekTTtj6y3HkiqehyI624xsjLRYGW/O5c+PAQ+SBqkf5AX1t6kD88/QwWCA/
         TsbA==
X-Forwarded-Encrypted: i=1; AL+hErHxC3qQDqw9WwwUr186uAQnBVT22WKZUcPsnfBtggX8nbeMRTOBNb1zWEtYxFYr40zB0vZSewg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SA3tDpyEompWwlYuxGZA8oszpIN9k2jFlE4Ofi/qS2BiPUyX/
	eg4fPnGLmSZF/B2tSq6e3LQq/ySJyok5cfCLViJ0LsA6pqd87dY6A8w64K4fPOSGXA==
X-Gm-Gg: AYBFou0TvXPkARPQZLCPMg6KugI9i9n648QdxjQRhueA2qudGfybeLM5HIzNBVjExpr
	HFg6c294m+GNZ+/AKEqZRFzVPkVGyxntXn/AflcuqaqTDgIGFZSY5EmMkaDJG3hXhZ921JsajlG
	pZHaz9hK+q3V0+rtxicGxlJKkUrbf/7Sf0WXzKGmKwAZFJpz4Mf5E/+n67060Q8EYmuTaN/BYc2
	tQjZ9Wdzt+CeOTWP6zoFlVU4WChvBVNalmW9AfhOl3g5TaajIMGlJxp6RifCrCbvoDOi6bBxNJY
	BVcczkXrBwTJ7jewNRjrxUiboOpg9241ghYF5vqp5UlaSjIjQOfVyj7E94dmqc2O752uId8G4jV
	LLSVkFOpJYStHZdpnAg1gQAyFmAN2R3wXGeXpVRQfEpg5GA8g912WCJp0Dx6ze/8xq6ldQeSP0q
	xObvEPp2aaFtipvBpZMgnAolPXKKXmUjJjZvrFaKvkt6WxzSFXtvuGUXHFMRkG56Z9CF8+mUbVK
	qXlWbRxdstk55qbwIAdrrNk1qCDYbaJzDO94t8pRJGcbOw8WvMm8M/aUDwhkQvQqUrQKo9f/U34
	p4cEJqM6m3wh9LJxrl7jyPOetByhfih32x603w5U70MP1/b+pz+XJzdPTDQJBX/6Qu/z7CbbY0N
	I
X-Received: by 2002:a05:622a:40b:b0:55d:37d8:5037 with SMTP id d75a77b69052e-55d5a75b268mr87571091cf.77.1795092037457;
        Thu, 19 Nov 2026 04:40:37 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d66b75823sm22370191cf.13.2026.11.19.04.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:40:36 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v6 2/3] net: neighbour: reinject a parked skb through a headerless output device
Date: Thu, 19 Nov 2026 07:40:24 -0500
Message-Id: <QDISC-6HS9.v6.r0.20261119070330-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v6.r0.20261119070330@mojatatu.com>
References: <QDISC-6HS9.v6.r0.20261119070330@mojatatu.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue:
neigh_update_process_arp_queue() drains a neighbour's arp_queue and
reinjects every skb through READ_ONCE(n1->output)(n1, skb), where n1 is
the top-level neighbour re-looked-up from the skb's dst, not the neighbour
the skb was queued on. skb->dev is whatever the producer left there.
Note: skb->dev and n1->dev are not guaranteed to be equal.

When n1->dev has no header_ops, arp_constructor() and ndisc_constructor()
install neigh_direct_output(), a plain dev_queue_xmit() that transmits on
skb->dev and builds no link header. Such an output sends the skb out
whatever device skb->dev names, not out n1->dev, so a producer that
parked the skb naming a lower device has it leave without the link header
its own transmit path builds.

sch_teql is the producer that hits this: it parks the skb on the slave's
neighbour while the top-level neighbour is the master's, so skb->dev and
n1->dev differ and the reinjection has to come back through the master to
leave with a header. It names the slave on purpose, so that a parked skb
does not outlive the master it came from.

This was split out of the sch_teql fix on review, so that the neighbour
restore carries its own commit log and its own Cc set. It is the first
half of that pair and is applied first. The behaviour it describes
exists once the second half, "net/sched: sch_teql: keep skb->dev
consistent on the arp-queue path", moves skb->dev = slave ahead of
teql_resolve(): until then the parked skb still names the master, so the
assignment is a no-op and the recipe below does not reproduce on this
patch alone. The two are taken together.

The Fix:
Put skb->dev back to n1->dev before the output call when that device
builds no link header, so a headerless output transmits on the device the
neighbour belongs to, whatever the producer left in skb->dev.

A forward that steers the skb to another device, nft fwd ... neigh or
bpf_redirect_neigh() with explicit nexthop parameters, parks it with the
dst of the original route still attached. When the original route is
itself a headerless device this gate matches there and the skb goes back
out the original device, running its egress hook a second time. Those
forwards supply their own device and nexthop and do not consult the
retained dst, so dropping it at those two sites is where that is fixed;
that is a separate change to the producers.

Conditions to recreate the bug:
CONFIG_NET_SCH_TEQL=m and CONFIG_VETH=y, run as root. This is the
neighbour half of the sch_teql parked-skb fix, reached once the sch_teql
half parks the skb naming the slave: create a veth pair, make one end a
teql slave, give the master an address and a route, flush the slave's
neighbour entry and send one packet:

  ip link add v0 type veth peer name v0p
  ip link set v0 up;  ip link set v0p up
  tc qdisc add dev v0 root teql0
  ip link set teql0 up
  ip addr add 10.0.0.1/24 dev teql0
  ip route add 10.0.0.99/32 dev teql0
  ip neigh flush dev v0
  ping -I teql0 -c 1 10.0.0.99

The packet parks on v0's arp_queue. When the solicitation resolves,
neigh_update_process_arp_queue() reinjects it; without this change it
leaves v0 directly, with no link header, and never reaches the peer.

The window that frees the master, and the unload recipe that shows it,
are in the sch_teql patch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v5 -> v6:
- the commit log names the sch_teql half this neighbour restore is
  applied before.  Considered comments from Sashiko (nipa).

 net/core/neighbour.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index ae2db3912454..d36d86cfc441 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1342,6 +1342,9 @@ static void neigh_update_process_arp_queue(struct neighbour *neigh)
 			if (n2)
 				n1 = n2;
 		}
+		/* headerless output transmits on skb->dev, not n1->dev */
+		if (!n1->dev->header_ops)
+			skb->dev = n1->dev;
 		READ_ONCE(n1->output)(n1, skb);
 		if (n2)
 			neigh_release(n2);
-- 
2.34.1

