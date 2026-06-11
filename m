Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11F636308A
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 06:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159322; cv=none; b=l3CJYteDkxoC25pNUC9Mab4ddehUN1kmOBUSVJkarjxVFF/iP4A+sABlHmoCuZTHmyBwzBCvK68dKkL+W2p9Sz//vf14ebjhJlZ5BQgELQCR50l4XaZDf3TXFOMKDr80ln2Bmw+/vXrlh9UkWKF42hglOb6MUbN3K0Ebxn6ZH/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159322; c=relaxed/simple;
	bh=4Nvj/htZQGso53Mmm0lreiAmj6V5PmDqdYSnHL4fZ+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYAlTQ6zbRMrI9nRZQGbGKDizp88YJUXnMMuhZqs8f/cCgzmYkIdkBEKK16E18oidgnH1UEGJM/3uVuff6xkLjg1ov20T+P8CPiAn7QDr0dEgnkK81SMBrY3fi8O4TSdBJB1wabDhG8abDIoMOFDgsQMDx9L4uW9VZDVCARTapc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO89fSLQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO89fSLQ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso58808125ad.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 23:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781159320; x=1781764120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDIz/z+wpE+gNeERCet5gmogC5x6oFr8X90Oro0lyGw=;
        b=BO89fSLQWumSP51LRMfKqi0fXZ4A56qNlQJ8NDbbketYaBNUiI030qjZSjlVRoABx8
         DjqPqIUueH+L9S9XhM0B09TECMlDOoDaKfry/uZtSjz3irYvILuVMa2qRtcUqqR5/mix
         XHhnqab7fGSVJTU34ajJMnAEpWTFJC4ybiKCP9CH7TlTBlwvzMCkXQvqzV5qG6Cstajy
         zR9lsO5ewO6Fnqr1VftpayuI35DewcN+nPPuXP2T4C25vM3YayuziYviNEQ4Wc2bnC9B
         ymO/HCVO8EDCdPcfkqJW4YE/q0IO3+UcpAsV+DhuY7AfWMqndLAw0JXGN5sT2n7ZKIiM
         okng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781159320; x=1781764120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bDIz/z+wpE+gNeERCet5gmogC5x6oFr8X90Oro0lyGw=;
        b=oNDl72gFWZsjMWTkrs3GvLFRUiULAFBsgkKNNTXqYoDzPZIRoHrf4pkPqtEsrFZHSN
         +0D2EGgKmusyjMveX+E0Wb4Zo2eYVgBIx4Vl6BtWThIZjcNF1Trt8dGJ5XnE4cbH/yTl
         Rf/lI8Ssq3cQaVMhwSsbsPvBjKHybHzrur1HCdxg/aX8zQZpLq6y4k6Dyk59L4yaAO/B
         Mta1NgzSD/OhjY6OIFquE9sfvfQqNzPa9XiVIx7sOeZvqyGR4kv42SrRBiNbE6EeSE9D
         zAvSnfidWPFLY336gy5TER9Y3wd9D8hl4npyuOgRKmwEnwnFSx9pPwvl3uRxiywP26Vh
         afKw==
X-Forwarded-Encrypted: i=1; AFNElJ+elhqE/saJCqSmBlDWESZlOl+wcuNEd+BfW/bvaOhiB+Y/KYziTtMZ2eNZ1uxrTUzGJCwn6ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDije+kjOzjMveT1U+HOgkMw3ccOgyaaMPhszBNVpubcKdT4+N
	+ZLlWL93QAnN6U9jMXRNgCBGqpxZ2hO6DFXdm9wbSFolwLRSaPcB8ilMxqKdtw==
X-Gm-Gg: Acq92OG+rZowcws/V6csvEr5wpGGv6fdcsquIUbnG7rQPKlxMvZCarhhxLrGySrB2xE
	N836/h4I+XuDxBb7HlLBlscG+hzi3TcB5yg3NCduIHG8/Au+9tOligYxMMTaygl/KStXh5I8Ms7
	POHWdbzk22a4tg3r19CogDCGLEl3XpYiu+RkdlWKEKOkiWC1QqaY2MBK29Al8aXxHdsBIfbL1zz
	3UdkcGcX4MBCUcEn/TVagO8s5LBA1bqCos+fCLmmwZpCC/TWAHIHS0nRkSuj3RTQZApzbOoLI2b
	XCViZin1qr2VFSPfibeWJXMjnaEKH+UNjUKop4fwhCk9LymLcEF7+VB+XVTnIV9Rb+rlghmhehm
	Bar+fepJOhZs9L3yVA8vt//OV/dAbW2MRX+Bnj1KrTO9AnoW3/mw+J5Q/JcjMvPFxu3BzejA0wz
	V2ETIhn8B2pyxFKk12ntrfEnegcQ1xZKAc1n1fITf0VmsMBmNC16P7YrRmZ2o=
X-Received: by 2002:a17:903:2f04:b0:2bf:23ad:8595 with SMTP id d9443c01a7336-2c2f18e2911mr17791965ad.4.1781159320304;
        Wed, 10 Jun 2026 23:28:40 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm282891565ad.1.2026.06.10.23.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:28:39 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v5 6/7] net: ip6_vti: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 11 Jun 2026 14:28:13 +0800
Message-Id: <20260611062814.2528793-7-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611062814.2528793-1-maoyixie.tju@gmail.com>
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vti6_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate vti6_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 11b326fb0a37 ("ip6: vti: Use ip6_tnl.net in vti6_changelink().")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv6/ip6_vti.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index d871cab6938d..ab94b3a4ba9c 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1046,6 +1046,9 @@ static int vti6_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct vti6_net *ip6n;
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	ip6n = net_generic(net, vti6_net_id);
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
-- 
2.34.1

