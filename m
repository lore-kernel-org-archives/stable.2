Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070262AE8D
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919576; cv=none; b=A+1LS6a+IelwCKefTAMUP53FKsa0HJb5G2xpfnoOKy2e0Fr9MpcfBM850Z9QzdNoMljdsMmURS6E7fFoUcV8NnPt8kGOkO5C32LjV7VyjPJXXGBGi5p3Swi1SfynjJr6GG9C19bzHfup3IoSH4PAmAag7KD+uUF4CzqI4cK+aGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919576; c=relaxed/simple;
	bh=A1R0s7u+JChv9Ss8a/PFkaOtOi6o6Mi+M9DnbV7Za0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ju0XGZmHDArqTAnW8a9D6d7xwU1hHyBQ9BwIjrhtujQoZr78F0vZCMBx380TzFBC/shIOIvoeJQy4QZAoB9/zcnUHz6w7K7hhSRCP0Q4PeA2382B4Wd2SCJJmfSM16gJ/fp2JGuu9R8x4ngK7OVc0/fry5GN5ytSJ/f0HBQgoz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=YeBjtbQg; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="YeBjtbQg"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51bfad59921so6974221cf.0
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787919557; x=1788524357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jeXsbVKGJ8b2tXZYkkCjnNDpr+fkfs4wKW6CIseyfpk=;
        b=YeBjtbQg5qzNwQwvgj7C2mBOlk8DmyAtHd6cVfB+AzGWCghS7kOBZb4ymqJ2kFhgnu
         yYzkklheGgyhGMQjd6dNRgTMj9Gmh7kp1ePuKQBsttyXE8N83Rmid6QjsOxNIyNu4/bo
         Jw22TuaBNhQcCyb6uZbvpLV3w27AJ5EGmAj4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787919557; x=1788524357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jeXsbVKGJ8b2tXZYkkCjnNDpr+fkfs4wKW6CIseyfpk=;
        b=GyX0gQxQPSniKFFDU+kPPz9lEkkvs51vVaqKYsgJRJG2vY1n4H4gCl+GAzh4Kf/Ui8
         izHRuS+iY9wwkg1P7IMYohuLGOuusp4xHIsnGvyWzkXzjCLvoVesDUvjN13gNeAJOw6O
         yaDS/GRP9rLJ0QZ9y+Rc9B/iit5DXkUKOpKqgefgwyeqfGpAUqdMlNKIeXfMVGIIPvy1
         8cja8fW9HfVeCbqCoFyCgLyRlizCBhXrKKyKj/B3ONyriLpjICOVm6tIGulgnuK75/bF
         MzI0pdMv6e9l1jk6s4kAIBktA0nqNEAE6OtDpB+s/mEiuMBdTdmAgjwkI+DAO4PsPygN
         MJ5w==
X-Forwarded-Encrypted: i=1; AHgh+RrcaydkCdbWMoxl+CdTa2+X1qjaoTRzHn5rHM/tJxLxtt2WrMev6Tr2FYfu1ODBBU8WVDELDPw=@vger.kernel.org
X-Gm-Message-State: AFuF++lkvStHUJq5uLiRHgjQiCcA2cyo/fZggZ86RnFWwKSdy+dl7603
	Q9xO4jz5p1dlOvTPKGLLrFVVN6grQ8sV8fuuauy+qqvTX6D1y4DSqxeOZDc2JBderA==
X-Gm-Gg: AR+sD103STgvE8iV8sWi22CwZfywHjUfnTWGPTBOSJJxRQXmiLf3KpUXwOPUqdwgrL9
	te5krSghDzWppWp5pOZSOunhMlcsBG4a+VSC14KcP4jhUf15Y7qAS0+lsJk9IPXbmkUh9a58y9X
	C7c0NwUu70KY7/HxK10Yw5Fc5EvWemIxNCTA10n50abImlzBltwaJ+TFiTnQ/znJrPCVkkAYIun
	0efHsSgaJLzUOu7za0darcN5WqVmMsmkA/90bWqBWUY1/gao7amuYwChJl5LC8W33kbMAINh0Nj
	CzLLUsZ/plrWcjI6w4hov7QS284W0BBSiJqYDTw3BRrh+QXJl4vXZqEqPeOWka0yywhaK2XxHX2
	wwtW02xsIKNqw0ktR5nbmZR6tPMLu8SZModeEg/hSdXaM66CH/+UxoLksA9NWFDzxpNCh6ij6mW
	eCv4ooxXtgp7tK960yADotH0bLMUDZ1EwvPm7yTQeQKzHvfUoWsDDXqTb2rodtsIClCXnjotVO+
	k89hfq/lrwZS5QbFmIrv3jHjFgeILW4oBlLuw==
X-Received: by 2002:a05:620a:27d4:b0:930:adac:1e99 with SMTP id af79cd13be357-93913988103mr688492485a.38.1787919556836;
        Fri, 28 Aug 2026 05:19:16 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9391740a306sm128672885a.42.2026.08.28.05.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 05:19:15 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net 1/2] net: cap tx_queue_len at S16_MAX to prevent oversized ring allocations
Date: Fri, 28 Aug 2026 08:19:01 -0400
Message-Id: <20260828121902.66837-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several subsystems allocate ring buffers sized by dev->tx_queue_len
with no upper bound. An unprivileged user (via unshare -Urn) can set a
huge tx_queue_len and create many devices/queues to exhaust global
memory, causing a system-wide OOM:

- pfifo_fast: pfifo_fast_init() and pfifo_fast_change_tx_queue_len()
  allocate 3 skb_array rings of tx_queue_len entries each.
- tun: tun_queue_resize() and the queue-attach path resize ptr_rings
  to tx_queue_len on the NETDEV_CHANGE_TX_QUEUE_LEN notifier.
- tap (macvtap/ipvtap): tap_queue_resize() and tap_init() resize/init
  ptr_rings to tx_queue_len on the same notifier.

netif_change_tx_queue_len() is the single entry point for IFLA_TXQLEN,
sysfs, and the SIOCSIFTXQLEN ioctl. Cap new_len at S16_MAX (32767)
there so the oversized value is rejected at set time. This will take 
effect whether the device is up or down before dev->tx_queue_len is
written or any notifier fires or any ring is allocated. So a good
choke spot.

S16_MAX is the virtio virtqueue size limit: the virtio specification
stores the queue size as a u16 with a maximum of 32768, so 32767 is
the largest tx_queue_len any in-tree driver can meaningfully use.
Values above that only serve to inflate ring allocations.

Conditions to recreate the bug:
- CONFIG_NET_SCHED=y, CONFIG_VETH=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y.
- Unprivileged user in a fresh user+net namespace (unshare -Urn).
- pfifo_fast: create veth pairs, set tx_queue_len to 500000, attach
  mq+pfifo_fast. ~28 iterations OOMs a 2GB guest.
- tun: create 50 tun devices with IFF_MULTI_QUEUE, set tx_queue_len to
  500000, open 8 queues each. ~1.6GB of ptr_ring allocations OOMs a
  512MB guest.
- tap: same as tun with IFF_TAP. ~960MB OOMs a 512MB guest.
- On the fixed kernel the oversized tx_queue_len is rejected with
  -ERANGE at set time.

Fixes: 6a643ddb5624 ("net: introduce helper dev_change_tx_queue_len()")
Reported-by: vega@nebusec.ai
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 38336858c168..1d3fc0a268a5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9982,7 +9982,7 @@ int netif_change_tx_queue_len(struct net_device *dev, unsigned long new_len)
 	unsigned int orig_len = dev->tx_queue_len;
 	int res;
 
-	if (new_len != (unsigned int)new_len)
+	if (new_len > S16_MAX)
 		return -ERANGE;
 
 	if (new_len != orig_len) {
-- 
2.43.0

