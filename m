Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794052977;
	b=OZ9k3azpatwf3YTXjzuj+dwMHZ+CV3/+BZbDE+GzkPdhimN6fiqN7/06HrHQvkpLvpma
	 RehdNs29UHfQH2kd6MwXcHDwe25IeZ8KBj2LXTC2Wd2s9JjHabfdyUMEh3YnqKlM05elI
	 FfEToWopuYR0+w/sTC6qM0sn4bAf/Pzw/79d7Gq+C2cNdLaZPBpIZeOYrFxD+KJh9441c
	 ovWgDuY1paEOT3ib+g/5JTKwMcj5W6bERdK2goLj54oskEejeLpk42Xzv8UBXaK4f1h1S
	 rrT7cKDd+2dAqWkz5ETvLVzo1wfDGhEn9L6iWUWh4j4vycsxj30DB/WcMDS+ETp8+Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794052977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tqqd9Qn7XH6yaCoHROgHbyoaW5MULnhvtXp8QpnIYQY=;
	b=mhTtrdpmsJPipj00XG6T3882UgxHhW6G6XipxUmV0cim1lFn1hXM4a/ONFuBBzhu9QMD
	 1LEyOZZz1WbawMpPGKe2hvTSgZwLrlPdsJmZqBTXTnMXrI3bHLAN4XF88jN1kzX90itjn
	 8RrXR6JSNIKIopdh9h1EQehhOxojrtLJN180+FzE2L54eIMDlnJkQWcl2Rlb/ZH7oXoOf
	 T6MhVWdmdPgNvl/mpvI40kTfP9afMSaH0i5k3cGWDNQLOQ6/soAXCtmXsemn6VirIA7sQ
	 10IxTNKaLhgUZCdKMw2KlHevN5CjOORjPQ4oL0Qc5bqE2urS3ZdJ79JIPaXvlLq9H2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yQhJ1pz4;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA45606A338
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 12:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BA45606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yQhJ1pz4
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b577addee9so1766530a12.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 04:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794052976; x=1794657776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tqqd9Qn7XH6yaCoHROgHbyoaW5MULnhvtXp8QpnIYQY=;
        b=yQhJ1pz4YyOreNQp5KdXS+QHl7KMd9b9k8p7LETWwf2PtCe+0D87xaWgkW0SRHqx0B
         OaR7wc0QhfXKGZNOT/hNK/U7nCA9FtJR21dC/Xm5a1TYvPQ/AFVwOIKPt7nf1XNvKiRT
         FieUowpC2lpNfLKQbqV7fZ//MHf2RDsYRmf8cZtwg0zDtYyPYmMf+DrzQaakTo3Zdaqh
         VvA51vuQPZCOSJZf9YZwgn0Axu+GcdSMyquTjRVMEgf7oHTOPc00FmqM9xcUvn3VzK29
         4pVLRedMgeWPBAVmwqPibHXn/h2dvp1u40/QlCAFM9hQv9vNptUig8LrCTvoDV3q9xeB
         A8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794052976; x=1794657776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tqqd9Qn7XH6yaCoHROgHbyoaW5MULnhvtXp8QpnIYQY=;
        b=oGvzVVMI3xLHAMKDDyrvxHfvWO/pJ4ROUFjgEazvKHd/HJXaawtsOvJC6jdGXGZ3fi
         AE+Jnb2c/XN1ZrE6PCx9ZBO0TUpecLU5qRzDwnZdDnZ49ho6VqcyznbJqzxhEi44CH7O
         ymtv2D4pX/YVr91/qPBOiVRJcmMMONLeyotk0cC2qPJvDylELuqIDHnPuAP2R/wuz67E
         W+sukZi9gqbSWGwAqSTrxxjdv3tYMeOSa6X9nr7y8sD1E4qzlCNnoZnynDZuauomXVoB
         VecSv5lVl3jyo8Qjfi28Y0rMLuDeHSWyt2U5K8UUuUW7Lk/r1fInLQwJH3S3pUplwAHF
         SF0g==
X-Gm-Message-State: APuU4Z+bLxWhwI4TSmXMF75gRy9dpm9gFSgKBUqXsHz7HgvJ4KHiat/H
	ueUyAYORaSHOR6rQTXTKFe610tgno9zGiIAIY0+Mi1HzK6LldxRluq7pMv6ntA==
X-Gm-Gg: AYBFou2V99U5e4vNaDFGdQkkmLuc/CQ+3uMUVEEY3E6TXAHrrT5DwNelf43n1kvN1cX
	ubWkIv2BxEl+rnYx8HEUnsg9P6MLtEqnv/P0ThyzFUqAoENF1qrSyUv9jOOnW4+SYSFk+dhLXUj
	Xtc101rwzmb10jAu7TztL+byUKSff9RgG8SRkE9J25HgY2SCkcYip2xUdVDU0zEFYsmlsDhj93s
	B3kmh4TmL8Y72rO+wJET98hwIGf6aVMJsgtjbyM95yu2o24YEfRNpcVFX6lobdprOKf++cIzM/R
	W0y9OqabhSVYsdhH888Y+5hKLXyFo3pdczEcr0D+VjyPe/Y4WsrNDcXsnA61vqlc/pHWW+MkBUE
	0gA3Z+0HCFtD9sZ34bbXtV2muxKLjCULPagw7F7AIAyL4cpdyJwVNROPVvmxSs60YzRqe7p83zE
	0bISrCGbCZYAek1SpAAdl/EK/IbGug9+CtFer/EtBy5DxVYPMOfGQTLMLeUFeoFakOx8Qx2BHQt
	uVW3lLpYYVc6j0Fk36fXzWddtMnHi2Rp76cjeReqIH4+5xoSby49mp9xHbyB5wvxz763eelgQA0
	G/6DSk5SczCX6+9Ch6nw0gYITP9fjbUbkAQN0QonaVpjknFeHd1OvTONFTrhmne5
X-Received: by 2002:a05:6402:210c:b0:6b7:6f9:2ef7 with SMTP id 4fb4d7f45d1cf-6b706f93056mr666729a12.11.1794052975560;
        Sat, 07 Nov 2026 04:02:55 -0800 (PST)
Received: from kali (83.11.29.10.ipv4.supernova.orange.pl. [83.11.29.10])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664b07d24sm1796492a12.27.2026.11.07.04.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 04:02:54 -0800 (PST)
From: Kamil Sawicki <user148783812897@gmail.com>
To: stable@vger.kernel.org
Cc: willemb@google.com,
	kuniyu@google.com,
	edumazet@kernel.org,
	kuba@kernel.org
Subject: [PATCH 6.6.y] net: limit priority VLAN untag depth
Date: Sat,  7 Nov 2026 07:01:51 -0500
Message-ID: <20261107120151.28321-1-user148783812897@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054017-failed-6.6-d3ff07f5acc5@kernel.org>
References: <20261107054017-failed-6.6-d3ff07f5acc5@kernel.org>
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

[ Upstream commit d3ff07f5acc573e5f72bf1c581bae5d05191ba61 ]

The priority VLAN receive path can repeatedly remove VID 0 tags and retry
packet processing. Unlike the read-only VLAN protocol parser, this path has
no limit on the number of nested tags it consumes.

Each skb_vlan_untag() advances skb->data and resets header offsets. The
offsets are stored in 16-bit fields. With enough nested tags, the network
or transport offset can wrap. A later protocol handler can then derive a
large pull length from the wrapped offsets and access memory outside the
skb allocation.

Apply the existing VLAN_MAX_DEPTH limit to the exceptional VID 0 retry.
Count the tag already stored in skb VLAN metadata as the first level, then
stop before untagging a ninth level. Keep the accounting inside this
uncommon branch so the regular VLAN receive path is unaffected.

A single VID 0 priority tag before a real VLAN tag is valid. No normal
deployment was found that intentionally emits multiple consecutive VID 0
tags; permitting eight levels is therefore conservative.

The issue was found while researching the Linux network receive path for
Google kvmCTF, with OpenAI Codex (gpt-5.6-sol) assisting the analysis. The
affected path, reproducer and fix were manually reviewed and tested.

Fixes: 36b2f61a42c2 ("net: handle 802.1P vlan 0 packets properly")
Cc: stable@vger.kernel.org
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kamil Sawicki <user148783812897@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Link: https://patch.msgid.link/20261024004835.17862-1-user148783812897@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[ Backport to 6.6.y: __netif_receive_skb_core() has no local
  drop_reason variable, and this branch does not define
  SKB_DROP_REASON_RECURSION_LIMIT. Omit the upstream assignment
  and keep the existing SKB_DROP_REASON_UNHANDLED_PROTO drop path. ]
Signed-off-by: Kamil Sawicki <user148783812897@gmail.com>
---
Backport based on linux-6.6.y b5a1dc3ad4822c6edfb53429e9a3759c9b0ac2be (Linux 6.6.161).
W=1 net/core/dev.o built without warnings. Full KASAN/ftrace
bzImage built with W=1 CONFIG_WERROR=; unrelated files emitted
pre-existing W=1 warnings.
Boundary test on two isolated KVM hosts: the eight-tag packet
was delivered and the nine-tag packet was dropped.
Original nested vhost/TAP trigger on each host: ftrace recorded
eight skb_vlan_untag() calls and zero tcp_v4_rcv() calls; no
KASAN report, oops or panic was observed.

 net/core/dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index f9436563a2e84a..19d3149d320dbf 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5618,6 +5618,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	}
 
 	if (unlikely(skb_vlan_tag_present(skb)) && !netdev_uses_dsa(skb->dev)) {
+		unsigned int priority_tag_depth = 1;
+
 check_vlan_id:
 		if (skb_vlan_tag_get_id(skb)) {
 			/* Vlan id is non 0 and vlan_do_receive() above couldn't
@@ -5629,6 +5631,10 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 			 * 802.1Q or 802.1AD and vlan_do_receive() above could
 			 * not find vlan dev for vlan id 0.
 			 */
+			if (unlikely(priority_tag_depth >= VLAN_MAX_DEPTH))
+				goto drop;
+
+			priority_tag_depth++;
 			__vlan_hwaccel_clear_tag(skb);
 			skb = skb_vlan_untag(skb);
 			if (unlikely(!skb))
