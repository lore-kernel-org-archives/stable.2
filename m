Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160399;
	b=AYwOZDIu5Nn81IGZyQu2+UwcR16HPIHYiEpcsf08pdOoRI3EgCX6K4FoKlVAGAyqbfkz
	 NUk51ht45Z4UNx1BLHkb/P9wGQHK9rpvOhMSC+eg6kgKhV4FfFB9+vVlNqWY4IBmif3jN
	 1M3MewHHHoAbhjWZgk6+TPDqw9jXI/OPIYAS7B8kMqoCPQpqpnIOtqItEvxiTd8hHTSXY
	 1TVf3qg+osPUrtqRLI5hm07ktXIXbRVaLO0rALCpgR96w9I0dkZJLbIlM+yyegCYinz98
	 JbW/yMfdVq2P8CtlQ1+7jT3iCYmmjZ+z/x+tflQTH2h/ckBUXJmfqkK6CXH+7J2MGcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b/FH6II3bslDs5YBNTy7AYo6WlPjw5hNbX6vP68QInA=;
	b=Z3VWMwivzTUSrfMbnH8toTX/FMy1xTFwJOp6UcIF730XS/PB4wSFIC6+MpJWKzYjeZCv
	 9KTSBljgt4YjBK1I00ChAvUb/9ceFimg0ftiLkp4jzcpA1KdbtbtxwGyr5yCdtQjY7Smo
	 4o+inRwFZeEFcmUas4GHWSudyfuArLoaEeHG29Smn3nRMUmGTwveAS6EzwWzd4/RdKe5n
	 jEcbPManHTJH0DUXePW+RJ8Cm4KQZRt92MoJAMSCM8KKnPmDBobDZxX54oEwFCEIeFR2I
	 xIAyUCBRI9kk9DZZ9xWCc6Rq/7YWwgtrizgjfV9OfEmpkkCxjMp3KBkzICmFeZxFEGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RG8t87Z7;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98A5606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B98A5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RG8t87Z7
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-38644aedba1so51420eec.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 23:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160398; x=1795765198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b/FH6II3bslDs5YBNTy7AYo6WlPjw5hNbX6vP68QInA=;
        b=RG8t87Z7Z4ZkaeUQYwGbRWVes3PlJ9c1jMrnlHUNMrOp0w5G6vi/d7Bd8p0IQm5wwi
         3hTOuQV1/cxn1TULStIq3x6tYI8z1/tH9ONYhTCiT7Knh5SGjq5NnSsDlS23DuhKirep
         +0MiaZctbhZdloL/vvKhRpppDFypIIYKIu8emtcpzavAUhUv/9qc+6GnukGnczf1uPOS
         G/qWZnXwzCs3D5B5EcO00c0cjRvzn7aep9z4OboyxVwlSGmhZNOSuIQ0NX2Z+zUadCwP
         GJeHqlpdLAnD3sPW7vGc5gRgsGpteYXlG2SzwbvPU/HZV+9n5HMYmo58NiVbd1V5xmFL
         Lvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160398; x=1795765198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b/FH6II3bslDs5YBNTy7AYo6WlPjw5hNbX6vP68QInA=;
        b=IM9Sm9ABckDOhha/Fz/dF6birZv7SAfEvmTw8VXdpDJC5caKC1IQ2ir61jmoou7hAk
         67szHZQLeVf58u6ZZpjmvrPyzl5yO055F99E/1Deh++SFxtX04+Asj5Ffz4olEozDNec
         dJNMFhBR3hLJPFCFJp9/iIV9oYhfXTBahDXnVlly8e2cKqnwBMJBfdD89ChqFhYCggvd
         ntbIL+c7VeS1v510khTS/pXQP3sXcxWKvQPiEUjPZEBQInMiCZwcSiaBpMFiWnPEjqsw
         xZ2RnplLC2FRUvZV58aLniXaVrIjyFi0L/RDLQWFeYauY9v1yCkdem/SIU+ZWluUEOWS
         jfWA==
X-Forwarded-Encrypted: i=1; AL+hErGNT1NPi2x3gUrek3iUBjG7iD3xIrLYPGQLVv/4Z7+AirjtfA3L/lh7HuafUf/OzcO+BfwkQg8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PwLsQOXlv9IksSMu8+L9dLfqpfFlFfhyvym7lQh86res+4gkR
	u4f0epYeB4clHPogQPHPk325s5kxXE7Vl2UC11mmsyxO89CHD/DQoBak
X-Gm-Gg: AZFdTZdrRLhiy0YfuCvO2NKxQ6wynHoaCeZwVZJwX9pEm5GKLsu4cMmNn4NPmrZhonm
	snF0HI+gAYVLOEJMzmFf6vDjhMgjshp6lQqJMhpUgGi5NUOTYugdiGotCNSbBfJLfKgNO6VaxyN
	E+nrG2HevUTQBc3fzwKnR9uRYrYFWZBl56x4d4rW3lF1bFe5UQbVcfOsa3pV/j19SsBP+3hn1TN
	MHUw76IRuLWqO7oddHGIujtVs++7RIL16b0AjiwCJu0m2Ecrg1sTGpMaVhDeQ8nEaB1q4Nrbmfp
	TtRyiU4hhAp06j/YdsK6eAd+UE459ceZ2I42bQcX/VB1Cu15iTjz4R4Il3BUdUciiznGyRVV4bg
	5NnIxaGob4Bsd+NoEoOd6PICDY9I3zR7VJtvT+gS+FSLr1K3TFvCchqhD4YcbHaboRqCa4m7NlS
	hQQ0/Ja8iQLucBNV1xbero6Zeg7K0rdHOG99xkRWkblg8KUEO8+/0/onpTKI+I5JOK/aFkPt5iK
	9ewMVCwdLKQQfOpMwnvZPzNdUFFrwsBzjUmKxFpb7Ya9LhVJRISPVyvGnDPBsymxEF5ECNqALEH
	AXj9zquMp86LI1o5CCay6tUYrxvcCcBcbukzMYcHzuEdRNkJbBJMpZLJhReHmjGwglslRdOSqAC
	yMpcitKlj2Z6o8+kdlTbGrp75Z1PSdkdsoG5H+alK89WahAz3aRD1Ju8CKA==
X-Received: by 2002:a05:7300:601e:b0:376:6aea:ab with SMTP id 5a478bee46e88-3856c5b58e2mr1958638eec.3.1795160397725;
        Thu, 19 Nov 2026 23:39:57 -0800 (PST)
Received: from localhost.localdomain ([38.58.103.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm6326640eec.11.2026.11.19.23.39.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 23:39:56 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	alobakin@pm.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>,
	stable@vger.kernel.org,
	James Sawyer <jamessawyer@outlook.com>,
	syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Subject: [PATCH net v4] xsk: set network header on skb at generic transmit
Date: Fri, 20 Nov 2026 15:39:17 +0800
Message-ID: <20261120073917.63158-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.50.1
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

When constructing an skb in the XSK generic transmit path, neither
xsk_build_skb() nor xsk_build_skb_zerocopy() calls
skb_reset_network_header(). After __finalize_skb_around(), the
network_header offset defaults to 0 (pointing to skb->head). The
subsequent skb_reserve(skb, hr) moves skb->data forward by hr bytes,
but leaves network_header still at 0. This makes skb_network_offset()
return a negative value (-hr).

When such an skb reaches a tunnel driver like ipgre_xmit(), the call
chain pskb_inet_may_pull() -> pskb_network_may_pull_reason() computes:

    pskb_may_pull_reason(skb, skb_network_offset(skb) + nhlen)

The negative int from skb_network_offset() is implicitly promoted to
unsigned int, wrapping around to a huge value. This triggers the
DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in pskb_may_pull_reason().

Call trace from syzkaller:
  ipgre_xmit+0x958/0xcd0 net/ipv4/ip_gre.c:658
  __netdev_start_xmit include/linux/netdevice.h:5400
  netdev_start_xmit include/linux/netdevice.h:5409
  __dev_direct_xmit+0x4b6/0x730 net/core/dev.c:4942
  __xsk_generic_xmit net/xdp/xsk.c:1079
  xsk_generic_xmit+0x277a/0x40a0 net/xdp/xsk.c:1120

Reset the network header so skb_network_offset() is valid (0). For the
non-CHECKSUM_PARTIAL case, unlike AF_PACKET, AF_XDP does not need to
locate the real L2/L3 boundary: an AF_XDP frame is always a complete,
opaque blob from userspace. So resetting the network header is enough
to restore the invariant and avoid the crash.

Note this is not sufficient for CHECKSUM_PARTIAL skbs, where drivers
derive the L2/L3 split from the header offsets for checksum offload;
that will be handled separately after this patch.

Fixes: 3914d88f7608 ("xsk: Respect device's headroom and tailroom on generic xmit path")
Cc: stable@vger.kernel.org
Reported-by: James Sawyer <jamessawyer@outlook.com>
Reported-by: syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f16c1b285c9f63994eec
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
V4
Link: https://lore.kernel.org/all/20260902121028.74092-1-kerneljasonxing@gmail.com/
1. use the one-liner change to fix non csum case at a minimum. As for
   csum, since the blamed commit is different, I plan to cook a patch to
   fix that[1].
2. revise the commit message accordingly.
3. add James reported-by tag since he spotted this and sent this in
   private.
[1]: https://lore.kernel.org/all/CAL+tcoB8f7H1ptcEk1iVH065AcUNPEL2V1gKoJacwr3zndfPWA@mail.gmail.com/

V3
Link: https://lore.kernel.org/all/20260901083325.3445-1-kerneljasonxing@gmail.com/
1. remove the misleading description about af_packet

V2
Link: https://lore.kernel.org/all/20260826012052.51028-1-kerneljasonxing@gmail.com/
1. add more clarification about why we don't probe the header like packet at
the end of the commit message (Jakub)
---
 net/xdp/xsk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f22f9a2cdbbe..52d538160e0a 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -948,6 +948,8 @@ static int xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
 {
 	int err;
 
+	skb_reset_network_header(skb);
+
 	err = xsk_skb_destructor_set_addr(skb, addr);
 	if (unlikely(err))
 		return err;
-- 
2.43.7

