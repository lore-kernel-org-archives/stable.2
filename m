Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794963296;
	b=w3CYCYkXuobfG/cCFkuU4f8yo9ehq0WmqfQhjFBks06p1VBnfxwq8kg+A7ZqhdmhClZk
	 ML3wj7yYd4GM522j1ZJvSo37R0JxKF3h3ViYF/dPWBGkYX/nWgeTkJFuIzKXyo1AW6pqa
	 Kn7zCtr7HrQE9laH47dxpt4pw+Ul/HA0Ahd0e6Sv3rXQq6k29YGupyYkbuV60qP6bcvmz
	 +yqhN9/FNaUt0WjNRC9quIyJJ9Sw/777AWdhHyELIkteKx5R5iGo3whye4wWePVVZc/20
	 bmmNmW5OAzAyMqahiu1WaVqGMQZ8IFWrrGeyGQA+lovMDSxg0EgItx3d5lpFYabM4YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=znacOD0B/B/YrxiKPxJW5WlLxDS+ZPkOnsp55TXuXXo=;
	b=1S0qnYSLsnyxYk3lCWWnIGO3JPcvvF/MxgRcP7/n6HEREBnLQU+zKcx1K9GmL3ZfnujL
	 uj5+yQJhWpVPqThJ1p8W2DyRsFIz4Cg8IpePhl2zO30EBytJlnA78l/W6Zda5ZtFfd+hz
	 R2Kkb5uwC5wK5k1PeHTXPfuM1awRFlJgc7Ibg7KdM5eDECkqmWD2QaqeX1NNhx6lkphVZ
	 NBX+tfYeta3VEWWwwXw3nXRbw+YX0S04JKHrVg+Xyzj2Rl6Q6gANwkKpsQtcdf73A2Yg6
	 Kpbe1Xn8wWmcb/tVVKLV9CEQAyIbZkylffGfYmRcuXg6RwdlxGfd2QGyTs6+CL4BM2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=andrii.net;
	spf=pass smtp.mailfrom=andrii.net;
	dkim=pass header.d=andrii.net header.i=@andrii.net header.a=rsa-sha256 header.s=gmail-2025 header.b=nKoR2Ncw;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27137606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27137606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrii.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrii.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrii.net header.i=@andrii.net header.a=rsa-sha256 header.s=gmail-2025 header.b=nKoR2Ncw
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cdba1bbde0bso201128a12.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 16:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrii.net; s=gmail-2025; t=1794963295; x=1795568095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=znacOD0B/B/YrxiKPxJW5WlLxDS+ZPkOnsp55TXuXXo=;
        b=nKoR2NcwkaE8X7zx+Bf1UNS1WXyI++xeFpsYswkqzghJmd/h4/E9kX+bxt5CkWVeYt
         oHMXoLKsGoKYXng5/A6cRnhwRZbar08FYSdnHV6qVKLpecnmvznUVmS16ppDuAALZ0ei
         cEnmDso2vg/woOsxJs8bRrku2aXb1NpiEsIobmvrlkbrI0ebHqM0jPYV+pBeZNwm8Pz+
         Zc/HFswj+UFVXgL0GuIe1idfTm4Kjf8960xIJ7V+9Xr6VrGaF6eipCBOtEGgmmZdkSbL
         U4QD4p9dgVjbcXnH4VaPqgUMTFv/RxiQTjez2/0nfohscW5FywXJhwMZ+mqz5Bx5ONV7
         jEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794963295; x=1795568095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=znacOD0B/B/YrxiKPxJW5WlLxDS+ZPkOnsp55TXuXXo=;
        b=c1Wf8O2tphNcxBxdeQHp1HdjzsYbIGv1LYL+jB88HbsOB9NyYLUX/m90pSGt4dgHQG
         g5pHYtodoBfjHOG7sqhs5coUu9B2FYgB3RsO0tNET2xMSr5qAAQqevsteayoY3IuXg5h
         fajZZPRcx0mSt1BXn+OCWYLhkpyLDuy8hQqF+EC7Kl2FZQ/HOUqElFmVOoYqzyugfNW0
         32HLhOSFVfBr6RWc5cjNkP5uO9Qz8o2e6I/MBsLJz4uEiasHVyFzEHRbfWZDbVXQ/Zkf
         zUh3VmC1I/a1HN3B5rpUJ7IHy+m7m1tlu0yylhBQUrMWsEsbMcaBLNr+EVErbIW84zKI
         8xPw==
X-Forwarded-Encrypted: i=1; AL+hErGf4YHffnxSYmhXZSQWAVc8LFWMsr2Oc2GXkUPORy3DiHLn8wffI2IurSh9Tc/e2BSRUlz0neM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bRsD3bU1zPa+Prpy5AEEKAI6I73MkCFlyvWlDNdciCSDy8eGh
	5vvLUtAsvYU+mkWX8S1IYW8hd2reTrWrRVroDPxbRtYAk6PTWb7DiWnB59RUw1ytDVHRpAYgM9x
	kIxZI/wLglaK/0zjatPCk2tfYJBBTXd4f7XpelCiTjIBmI0c2urDj
X-Gm-Gg: AZFdTZeTdRmv2+W5WksivP+gfsUm9cCqxeC90Oa5ngNeSWDEHAR9XsGT/cg6q+Y2HVD
	SLAZi5zMYo/wyskWdNQ1E+/+db0MiDivDTqfoPOQtsmc68qO2IpRHmVna8uyeFRfiY2e3WX95SC
	lt+fH/0nL7oGyW0HdWFC96hwwh8ET7IXbb/Gp7SRPs2rSDDlDGxJCOF5etz48nThQHSjuWOPKpR
	AYe1LqjjlEyGc2oNUclZLvuohYJuFXYBT0MRTo7w3v2lL7t8sFyPto6tGhD/DRdrEi8jE0JFPyB
	rgFE1lzdaxfNTXARoiX4i7oJ6LH2Owin3aCOUFo7TojTSOvpTp3y3YcE2GJkB3xE9+m8lHhafcE
	P7BkVTyuHtz+BqD/k7dGIxQJmXm4=
X-Received: by 2002:a17:90a:d444:b0:3aa:fc22:8aad with SMTP id 98e67ed59e1d1-3b3d07c23bfmr1077396a91.54.1794963295498;
        Tue, 17 Nov 2026 16:54:55 -0800 (PST)
Received: from andrii.ai (mac.hestia.andrii.net. [2602:f337:ed:4865:7374:6961:204d:6163])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b3d4914caasm161524a91.2.2026.11.17.16.54.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 16:54:55 -0800 (PST)
X-Relaying-Domain: andrii.net
From: Andrii Tereshchenko <opensource@andrii.net>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Hopps <chopps@labn.net>,
	netdev@vger.kernel.org,
	ipsec@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Andrii Tereshchenko <opensource@andrii.net>,
	stable@vger.kernel.org
Subject: [PATCH ipsec 1/2] xfrm: iptfs: don't modify the shared info of cloned skbs on output
Date: Tue, 17 Nov 2026 16:54:48 -0800
Message-ID: <c1e999b5-15ee-468d-81c5-530a560e84df@mid.andrii.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <b56bbced-a8b0-4ae9-80b4-1958ea36684c@mid.andrii.net>
References: <b56bbced-a8b0-4ae9-80b4-1958ea36684c@mid.andrii.net>
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

TCP that a host sends through its own IP-TFS SA can panic the kernel
when segments are retransmitted.

iptfs_output_queued() aggregates inner packets by appending them to
skb_shinfo(skb)->frag_list of the first one. It appends even when that
skb is a clone, which shares its skb_shared_info with the original.
For local TCP it is one: tcp_transmit_skb() sends a clone of the skb
that stays on the retransmit queue. Appending to the clone therefore
sets a frag_list on TCP's skb that its len and data_len do not count.
ESP copies the head before sending, but the original keeps the stale
list.

When TCP retransmits that skb, the new clone carries the stale
frag_list. If the clone is then appended behind another first skb,
iptfs_rehome_fraglist() moves the stale list to that skb and subtracts
its length from the clone's len and data_len, which wrap below zero
when the list is longer than the segment. ESP copies the clone in
skb_cow_data() and skb_put() panics:

  skbuff: skb_over_panic: ... len:-340 put:-340 ... end:0x180 dev:<NULL>
  kernel BUG at net/core/skbuff.c:215!
  CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 7.4.0-rc3 #5
  RIP: 0010:skb_panic+0xbe/0xc0
  Call Trace:
   <IRQ>
   skb_put.cold+0x1f/0x1f
   skb_copy+0xfc/0x180
   skb_cow_data+0xc5/0x630
   esp_output_head+0x38a/0xb40
   esp_output+0x1c5/0x390
   xfrm_output_resume+0x113c/0x22a0
   iptfs_delay_timer+0xdb7/0x1990
   __hrtimer_run_queues+0x16d/0x340
   hrtimer_run_softirq+0x136/0x210
   handle_softirqs+0x162/0x420

Unclone the first skb before appending to it. ESP copies a cloned head
anyway, so this moves that copy earlier and does not add one. Send a
cloned first skb on its own when it already has a frag_list or cannot
be uncloned: uncloning the head does not unshare the skbs on its
frag_list, and appending writes to the last of them. For the same
reason stop aggregating at a cloned skb that has a frag_list; it
becomes the next first skb. Do not let iptfs_consume_frags() take the
page frags of a cloned skb, because that empties the frags array the
original still uses.

A first skb that was a clone can now take the page frags of the skbs
behind it, where it always used the frag_list before.

The panic was observed on a machine in real use while rolling out
andrii.cloud. It was reproduced on an unmodified v7.4-rc3 built with
KASAN, in a KVM guest, without fault injection. Three network
namespaces form a client, an IP-TFS gateway and an HTTPS server that
is the other IP-TFS endpoint. Clients fetch a 50 KB page for 40
seconds and netem drops 5% of the packets sent to the client, so that
the server retransmits through its SA. The boots ran with the server's
normal segment size or with the client advertising an MSS of 130. Most
boots of the unpatched kernel crashed: some with this panic, the
others with the use-after-free that the next patch fixes. With only
the next patch applied, a few boots at MSS 130 still crashed, all with
this panic. With the series applied, no boot crashed. Kernel selftests
were not run; none of them covers IP-TFS.

The analysis and the patch were produced with an AI coding assistant
and reviewed by the submitter.

Fixes: 0e4fbf013fa5 ("xfrm: iptfs: add user packet (tunnel ingress) handling")
Cc: stable@vger.kernel.org
Signed-off-by: Andrii Tereshchenko <opensource@andrii.net>
---
 net/xfrm/xfrm_iptfs.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 0313a43aa..95ba73013 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2234,6 +2234,19 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 		if (iptfs_first_skb(&skb, xtfs, mtu))
 			continue;
 
+		/* A clone shares skb_shinfo(), and with it the frag_list we
+		 * are about to append to, with its original, e.g. the skb TCP
+		 * keeps for retransmission. A cloned head that has a frag_list,
+		 * or that we cannot unclone, is sent on its own rather than
+		 * aggregated; the skbs on a frag_list stay shared with the
+		 * original even after an unclone, so they are never appended.
+		 */
+		if (skb_cloned(skb) &&
+		    (skb_has_frag_list(skb) || skb_unclone(skb, GFP_ATOMIC))) {
+			xfrm_output(NULL, skb);
+			continue;
+		}
+
 		/* If fragmentation was required the returned skb is the last
 		 * IPTFS fragment in the chain, and it's IPTFS header blkoff has
 		 * been set just past the end of the fragment data.
@@ -2273,6 +2286,13 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 			if (skb2->len > remaining)
 				break;
 
+			/* Appending re-homes skb2's frag_list, which a clone
+			 * shares with its original. Leave such an skb to be
+			 * sent on its own as the next head.
+			 */
+			if (skb_cloned(skb2) && skb_has_frag_list(skb2))
+				break;
+
 			__skb_unlink(skb2, list);
 
 			/* Consider the buffer Tx'd and no longer owned */
@@ -2292,10 +2312,13 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 			/* skb->pp_recycle is passed to __skb_flag_unref for all
 			 * frag pages so we can only share pages with skb's who
 			 * match ourselves.
+			 *
+			 * iptfs_consume_frags() empties skb2's frags, which a
+			 * clone shares with its original.
 			 */
 			shi2 = skb_shinfo(skb2);
 			if (share_ok &&
-			    (shi2->frag_list ||
+			    (skb_cloned(skb2) || shi2->frag_list ||
 			     (!skb2->head_frag && skb_headlen(skb)) ||
 			     skb->pp_recycle != skb2->pp_recycle ||
 			     skb_zcopy(skb2) ||
-- 
2.53.0

