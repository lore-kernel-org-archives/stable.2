Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3563612DB
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159318; cv=none; b=CFHonpLrxH8QNp7cNS9SDLFH5Vhh1xxzHxuXPV9uaGnKpfrimm1TAxQa/Cu22aq9qDJWJMiossjK5ic4bHhLWbGyKYt3mzRH8QRC8ATFip7xe5KfeaiE0P5DGoDJTleTJLzIIhat5cqa4jCx0wy0yt7HoE56Nl1xPQ0y5sfPdGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159318; c=relaxed/simple;
	bh=P3DEwMDSz7QrnY6Nl3zghY4LlUKgR9E6EOx71pAzN7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qAXSDm/+zAB9o37JDRmvxPJYUPVh63REmOCkX1OMAdwBtuffmBfilmuZJyr1Qh/PN+LtqZU7CcVyjQMLH0XEvYZ4K8GYUm0icw3gCd59rihNNTAjqePhCp/rncSvVyb+JSMk8uEJk3cDym8up/BvEHK7skU7hfUr2I2EeB87uyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxAjv7Nr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxAjv7Nr"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c27fc587ebso19228385ad.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 23:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781159317; x=1781764117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql1o+3bWl8+fth8gszVm+RpfzjR1vuCSvpffdbii/uk=;
        b=cxAjv7Nr/E6arf+wm1ermgrqZx26ssFX5tZvwulkODhW/OPkNeQIem+Amq/I7X2Dmx
         +wqHHT0R288aAKRoUIEBqF9Nc0l3VczCuIMvc5vZMlXinwj4msp+YeHrrwfRDZ/lJgn5
         dutNiotCD05zCM4V4CWp645k893TFKTosoTQayMThTO8cN9WJDT9TPXxFv4k1KUqpvom
         2qyFRyUk8ih5iIiUEDoIHn8yS7pWAlqzpOT1RguHDObZf1iApV4yjvxPKpknPEaL6LDL
         nVOrXUiauaKTztJmoRTmbKuYIeZ1tf1MTQn7Puw2/N4j4cVTrd/aA7GHpg3W0OPPNbIo
         XUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781159317; x=1781764117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ql1o+3bWl8+fth8gszVm+RpfzjR1vuCSvpffdbii/uk=;
        b=Te7y1pwU/A+hDNjqjMWmYTc9AWn5HiT5kU3rP1oxzUznTFd7S6W1oAmMskFZa55j7f
         tYWs4vm2FY4hF7LKLJArCsDPxjSqjl2P4KsczyPFyjhB+jbYS5koVcBfHrbZnqHyOo81
         WxRLrpD1bSOhONlIKWiwS4/SYeeNDMF19Tsx2nrjJ4TQqMBTq1xyajw+ohqDntXSnf8v
         hkEWuFueJPReNxTXbNaieYbS4H3qZllMKW2vN9BDH0VWzxqraa8pTNNu96u9QRmzENEc
         YoEjkaSuUXga99cnz54hl8uSMKOyQreq7rdmZsuM5KHlPVhvIVJh35AigUet2+kYyi3H
         lA1Q==
X-Forwarded-Encrypted: i=1; AFNElJ90ml2e3DjRGVCGAaVAyHdeaKgfMsjXG489uMyid3CTyoICJOAz8YW78BUtLwAtL2EbE9nXkas=@vger.kernel.org
X-Gm-Message-State: AOJu0YztV9QfIFBps3GdWXygmc+13XNO/CxD2PTMhu2tABD+qVGFBhB6
	ntUZe52NQitIPbIxWvuwZmOPIDF3ZneaCFAZDSgVLY3niCYgKOimnbX+
X-Gm-Gg: Acq92OFX4s90YzsHEksgGDTb9JUvfc8qoenb3l0uRCpSsxIz6x2De1DKracniOp6z5I
	BkUjfvy8uau27yva3U+yMZ6kURwAVOP4Lh38O1ephik7X70r2hYEOxejyzgBAGNZ9C3WAi4+BJJ
	EyyqoSoapPTCc9QqCVoIoNJlaabuyu91CD/Gb00AfQsWYfk3JEqzgcaPaoem3xfBL3B51hmMEmU
	iTBPR87z9re48BUsRLrA4iH38vtdwsAqe4r4yVlkSXvNhMTR+f7t3QO47pfzlIvhjdW24QJPbcS
	As5rB9yKfzwORDEMiocucAP6avB2mXJRnRj6sLMxImy9KX/gIbdQrnHQkFVj6wwM+NmvBU3w6UT
	5wWwigGtgcltB9Og+9NLY/Oe+WRJjlF0Fdgh+BrnXzSvTirqTbgpetjpsG6eSdlM3VbGY1KJXAq
	JBy2lm5nsro995SESeLxJkd+eqc2RAP67JXlWOLkZWS3oOo2hrG/6JlHIk3xs=
X-Received: by 2002:a17:903:2385:b0:2c1:d49c:8398 with SMTP id d9443c01a7336-2c2f005eb1bmr18921125ad.8.1781159316899;
        Wed, 10 Jun 2026 23:28:36 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm282891565ad.1.2026.06.10.23.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:28:36 -0700 (PDT)
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
Subject: [PATCH net v5 5/7] net: ip6_gre: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 11 Jun 2026 14:28:12 +0800
Message-Id: <20260611062814.2528793-6-maoyixie.tju@gmail.com>
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

ip6gre_changelink() and ip6erspan_changelink() operate on at most two
netns, dev_net(dev) and the tunnel link netns t->net. They differ once
the device is created in or moved to a netns other than the one the
request runs in. The rtnl changelink path checks CAP_NET_ADMIN only
against dev_net(dev), so a caller privileged there but not in t->net can
rewrite a tunnel that lives in t->net.

Gate both ops on rtnl_dev_link_net_capable() at their top, before any
attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 690afc165bb3 ("net: ip6_gre: fix moving ip6gre between namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv6/ip6_gre.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 365b4059eb20..8ebc99a299c9 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2047,6 +2047,9 @@ static int ip6gre_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6gre_net *ign = net_generic(t->net, ip6gre_net_id);
 	struct __ip6_tnl_parm p;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
 		return PTR_ERR(t);
@@ -2266,6 +2269,9 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct ip6gre_net *ign;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	ign = net_generic(t->net, ip6gre_net_id);
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
-- 
2.34.1

