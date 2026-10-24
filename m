Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792835403;
	b=yIXOemIOSfkhkOpURFlyR3+QsEC6EcsMGyek7ER4RUcGg+dCciq5/jN5Ariz7KyzAfXe
	 +PE2m7iBDTh5MEfsBXchQcuEKm7APKqLWLR3j28GB7WmeextVGJyJ6TLjoxpwSu6GJKNQ
	 7sKFQKp1lfMqMZZpmX80y0JA+QnN7O1gr7e7vTqleZtWgzfjz2jc1VW6Y3eHokosDemin
	 mneL577IhQP7o+MOu6RY/EihmwNs4mfb4Ux3q2PUxSXEegLJ06M24OPxNN7jKbvUR00Pf
	 vknvk0xK1iZ1Vx0wu3Zz63j8LWJaDJfXHL1PrvYoIehqwHQJLcUZ3d7ZQNaLHPsy2Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792835403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3fBYLV7XeCk/bCS0oq+NT8Fg65KCTf7AWpXNbKkRrbg=;
	b=vERUONqVCq7p8xh7F5LLiY0+lsBs6lW5uczRTkiFgEuLzcchbuaYfDxCWdveWFyDs0b+
	 5DQYyv6zKMkFQGuM8jOVS+/X7YD/X6zulgtRY6dxcKlCEECzlgzCpIcMpbsvQRwqgCpaw
	 2L/8tQijtrpAsS8w2X565ZK1bjBWmC4WIOVWl90NhcexOt4/vWY2AVOYpBRO1X6q2xg7m
	 MI2X2kUAXw64yVV76Puw1j8d8PkB51Uq1vlIV5gNM6GDQ8Ssb1mX7bssQZVbZn/rP0XiZ
	 9qTmrHYeyIThFtUTgq4kmGw0JrW5+UsPpyTRnkeqW+FCyarmHFUo+FlccFwK7dng8Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pRo99I1D;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E54606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 09:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93E54606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pRo99I1D
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-89ff475a152so682604b3a.3
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 02:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792835402; x=1793440202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3fBYLV7XeCk/bCS0oq+NT8Fg65KCTf7AWpXNbKkRrbg=;
        b=pRo99I1DA8d/qHPfM3wlOVWoGLf+SHCIKZ+7a5XygQPITzBsKIQhXpIMVqxtgOoyea
         R5ozvTOSyIhIR/QAsmqUqO/0oEPcogGhYLyoO7aGRDGrCEPIIxMi2wy5psGSuudBEyVs
         JXQ0OMLfCCf0Bty40tfzP8pwEQmW0x+I5w3t3VVXJw6MpWubUTDngUcs+r5BGv9hYAuG
         y3FRkejD7adnW9MfAo6y9zb+Lt5+b6WWMh7oXR4Bwot+tQ4n70GAZanIZyDmQO1m0LJB
         GSNZXn9MKZJQA7EdRYwvtsOMLnyqC2vJyBZY5Bw6PHsmlh2C3Cw068N87MG5Yw9PQm/3
         Jc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792835402; x=1793440202;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3fBYLV7XeCk/bCS0oq+NT8Fg65KCTf7AWpXNbKkRrbg=;
        b=k/OUnZqtt8Iv2cGJPg+5U6lmhLf2i231Wucv4avZIHJABHuFFfjTSg/8YchhHLkeUq
         iGS5eRbrb4KElaTYcQB3zPLsa4j5iMec5GOSvLnmZTYkBzAEwRYYia8MTmj0JOqEVRtw
         4fjtRTp3OX5sp89frzW3Sj02x2jW6X6WvWxSSvEP2UW5y2EsLhctGuUAsD/mbZNLzl6Y
         NhhdxJw1+gLl2MCmr+Ih2zUONVaeUglujaj3BknAT21IyemyskXhkVeOKULrMymUMNvE
         ++sz349bxAHd3Tdoeo8tMU/bneakLAdNvWWsyI9LFx8K8J4znhggfPUmkVDscLDbEwPG
         5nXQ==
X-Gm-Message-State: AFq9FYKMWgeDDAz7YEBGW4xhjjmjTYIKBebD+flKgIZxGr5mSpLLZUtx
	Ym4hoDHxMNepVz2KfvEba4ml9FikvQc/qI/cpzJ+hbd+kXvL8Ez+atVfetVkB05DwY0=
X-Gm-Gg: AYBFou1+/pKNCRe1LeT6qnYvAKi1MQlz9+AQbYkaAoUX5NMG9IRr/XBu2PiCG4j2FPD
	bfyLbwmMcTW/JOyKzpZErbL/ZUflBHSzOqVVDgtS9XQ2RK8zYJGkEhuS3sRU0rn8V6n5XMYXPXK
	TrDVfVjDnSENNo5UNB9qUY+RzO9Xfhy9t63In5dKH6oTc/1LuV4x2ZUS3ttHPv0oq7JGUfV9lqE
	yoy0trRdo2638DzqIxSYIt7wS8VP3JvyGbxkjSUjgOuGZVszHxbw11SzHUtx1ZKgzC1XvwMN0Tw
	5LMcSdOyO6MT054uG15HbSIQoKlIG7/+0X3ZyKHwZCbiicPoslFuCMCRRVJyJ9a1/AODNi48S7L
	R6fExtLIrhxsZt7u7LYu9clAmbkjx8vYC5Ebr0wAV+KSkgblB1NxNkfH0BmoyrvDSESWEqCM4pe
	oMHEX3MokcNd9bcLh6QjXqRu1n8P8GUD9W0X0CrvtVESaIruObpxhlmndKhNoCzOo64yCmTwDg8
	1E0Q9mvb8L8eE2zSVrcLBV1gAoIFFQVLkL6bj+8DFDtl0IWVlj3Nk3M9NEleFWmO63DwDeYVT6Z
	oRO2veuk4OQK1/vSl6Q+qNDiXUZXKM0TUzd1eaNiRb+Zt9figUNkHEk185wXfkDwB00DI/IITiF
	vChex6J32oZJoicKvxjVNI09ZEPmbLabKKRJg69+MD96WdmrNgb202otQyuXLVmA7Szg6THa1eZ
	jKaygNyxa5qFf/Bhz0M+QoSGiaOClB5h79EKwXLl0Gb8r+Rac1bnUReR/V
X-Received: by 2002:a05:6a00:8e09:b0:8a0:20e0:b131 with SMTP id d2e1a72fcca58-8a367a3e739mr1307445b3a.19.1792835401840;
        Sat, 24 Oct 2026 02:50:01 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a368d86790sm378078b3a.1.2026.10.24.02.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 02:50:01 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] gtp: disable BH before calling udp_tunnel_xmit_skb()
Date: Sat, 24 Oct 2026 17:49:56 +0800
Message-ID: <20261024094956.833-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: David Carlier <devnexen@gmail.com>

[ Upstream commit 5638504a2aa9e1b9d72af9060df1a160cce2d379 ]

gtp_genl_send_echo_req() runs as a generic netlink doit handler in
process context with BH not disabled. It calls udp_tunnel_xmit_skb(),
which eventually invokes iptunnel_xmit() — that uses __this_cpu_inc/dec
on softnet_data.xmit.recursion to track the tunnel xmit recursion level.

Without local_bh_disable(), the task may migrate between
dev_xmit_recursion_inc() and dev_xmit_recursion_dec(), breaking the
per-CPU counter pairing. The result is stale or negative recursion
levels that can later produce false-positive
SKB_DROP_REASON_RECURSION_LIMIT drops on either CPU.

The other udp_tunnel_xmit_skb() call sites in gtp.c are unaffected:
the data path runs under ndo_start_xmit and the echo response handlers
run from the UDP encap rx softirq, both with BH already disabled.

Fix it by disabling BH around the udp_tunnel_xmit_skb() call, mirroring
commit 2cd7e6971fc2 ("sctp: disable BH before calling
udp_tunnel_xmit_skb()").

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Link: https://patch.msgid.link/20260417055408.4667-1-devnexen@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Ting-Han: this tree does not have commit e3411e326fa4 ("net: ipv4: Add a
  flags argument to iptunnel_xmit(), udp_tunnel_xmit_skb()") or commit
  1bec9d0c0046 ("ipv4: Convert ->flowi4_tos to dscp_t."), so the
  udp_tunnel_xmit_skb() call differs in context; the change is the same ]
Assisted-by: LLM
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
This fixes the 6f1a9140ecda ("net: add xmit recursion limit to tunnel
xmit functions") backport that is currently in queue-6.1, so it needs
to go on top of it.

Build-tested on v6.1.190 plus queue-6.1 (x86_64, gcc 15.2,
CONFIG_GTP=m): no new W=1 or sparse warnings in drivers/net/gtp.c.
Not runtime-tested: I could not find an existing tool that sends
GTP_CMD_ECHOREQ (libgtpnl does not use it), so the echo request path
itself was not exercised.

 drivers/net/gtp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 501dbfa917408..f192a7db81d1f 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1826,6 +1826,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 		return -ENODEV;
 	}
 
+	local_bh_disable();
 	udp_tunnel_xmit_skb(rt, sk, skb_to_send,
 			    fl4.saddr, fl4.daddr,
 			    fl4.flowi4_tos,
@@ -1835,6 +1836,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 			    !net_eq(sock_net(sk),
 				    dev_net(gtp->dev)),
 			    false);
+	local_bh_enable();
 	return 0;
 }
 
-- 
2.53.0

