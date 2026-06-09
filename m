Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701AC4A13B7
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022706; cv=none; b=GiIdXw0MC/gnNYJUWNpOqxebwxOrs5glZRXQjZAKawEo6BHXGi+3lwKQo6/YNKkStPvc25gzMxVvGqr96CULWKYHJKEq+XcBfnof08FYXi1BdSBgQBktc1SEEFlejl9HlFB2Hb4wfbOEH1xOLgfveeCvACoWnIYa6q7KglukFps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022706; c=relaxed/simple;
	bh=zgI4NC9pKO7UMNWYBik+NAFMUiFlDyGaDAxNKkRk7eA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HUk0ySSf11a5gG9MVpROyuh3yFUFSFrAbz0ZIQBAGiFMmw5aH8TH8DhJP2jUUIo+5vBjIotO9hFj+bvzEK/S31f6kZH2uere9GCUkNvk3RAV8OS6HrTLiqsXChSLpBTF4I0xznZgQ+ZzUIqag+1bRY79K3NSh0zDhpYsokW76fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3urr+00; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3urr+00"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c2d792c8so38835575ad.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022704; x=1781627504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5U7wZVwHyltBjwcbHNRkOqRDWQCG1C1EbQOzCQU3Qg=;
        b=W3urr+00Sbw0wxX5OumE1wv58gXAcp3q1WiLrk9Bjt1cMM8WE0OmqjQsrWG3hURRcO
         W8tD7ihqLj/eFvD6spSjCgVbhyINIULjj5D0FVoznCSFIKrUQW+RzOf5jHawrdWlflay
         7ZShyF/RcSOo4IIw8UqPKnqlkiSDeBRj+NC03AzRVgcKCtQvOPBSE8+5atVad7ZcPeIm
         RaaEhJbEWWuvSia9Uji31n43UlQR4tx9/CQ+OwUj56l0IH3VxIwccz7s0Qj/ngDyuJFT
         v7J1KXuV+rVeJAaDjutp8AvvfdJd/B48XB9P9ASRaki2bXKVAdyEdJLqz2XbmYjMrqlY
         o1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022704; x=1781627504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M5U7wZVwHyltBjwcbHNRkOqRDWQCG1C1EbQOzCQU3Qg=;
        b=r9XJcdo+6uwnFIaQd+aJytwQ5Uj3F7RET0L9VvyswnQvBLWMabAUoY2NLWHtv9GbOs
         msAlwHLoz6t6ndsNglkTekiRK/9sGIYrFs/SvzzVGYrRkzXn8AA2I9nhbgcLuXsKxywF
         8YenqkJyZ674/ErhNeWaCR6q5OlSTz2sRTkGVAlSr55TKuVaipvnM1sg0X0ts9Kt+fRO
         K90S5QXZSOdKFxF/Dh8qo6QlIE8FFJPj38mn4FODO9lU70hU/9zpVcp6EPM2TvtUSPvo
         nKCUjjXVzp7BvfZlo/MJaEzzf1rZRkINq4TL/jBWEeCekIc9d1GC8wqemTBeI14zWCq1
         1i9g==
X-Forwarded-Encrypted: i=1; AFNElJ++v26mpBbJA3Uy1mE3AeC2cbLccp+HAtX7Y1fMAPONIoMXPZm4kjiW+qdFBdl1rLIXY7DLCQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE8aG7AciqOFhtsZZqwOjQJmwncv9f3iy+ty7EvjuWTO5RxX/E
	6P/OJ4+Q9MRB8lpSq3/og/ZHSdCQP2TDsfwid8HuErDlrPkZ8hZWVoQq
X-Gm-Gg: Acq92OGWeSgcK+ahlzFhCDIoM4KtYE1eofByt2PI528s8Ky9wK4OR6CeM9XK/ekBrE5
	3iMUOwbbccc00zjDm2y711u94AuNKsOa6KYdirLj2QcrtzI0LxlY5Cu6PO9MJ22wEUI5Y59ztc3
	Huxa2o8YityqTdGNHDCT3yPpdfYprgcyVMkbpR6q6jQzdsAE7mO6/8gyJpjec8Y/yuyMSX7rpjJ
	3adRKUr59ZY01e56OdwYNNwKpjzvyDs8r39GRhEvPrrvCPKn8netw4p4yjhCqo6iBx5zXxGySot
	LVEzujyZEHZSDMZn8WuZjgSottXcGkZxRII93poX7lzV8B5i21unjtAtLnPd7ktfLKkM8i86A2n
	ZXmu3q1ukbpVcpb3vnicqY3qJ+4nY5d6jjEJ7UZ6WG9EXnlHk3sdFbBnJx7BpEBIBABJQgm+kxB
	/eZP0/vqAd6Gbm+Fh0q32HglbTtUUrZ0LOPaMlTgEDRa+VIeDKOu/8JA4rhyTa/kyLvAMzZw==
X-Received: by 2002:a17:903:4407:b0:2c1:d49c:8398 with SMTP id d9443c01a7336-2c1e78df934mr242762885ad.8.1781022703723;
        Tue, 09 Jun 2026 09:31:43 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm227710195ad.60.2026.06.09.09.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:31:43 -0700 (PDT)
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
Subject: [PATCH net v4 7/7] xfrm: xfrm_interface: require CAP_NET_ADMIN in the device netns for changelink
Date: Wed, 10 Jun 2026 00:31:10 +0800
Message-Id: <20260609163110.1717419-8-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609163110.1717419-1-maoyixie.tju@gmail.com>
References: <20260609163110.1717419-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrmi_changelink() rewrites the interface in its creation netns. After an
IFLA_NET_NS_FD migration that netns is not the caller's, but the rtnl
changelink path only checks CAP_NET_ADMIN against the caller's netns. A
caller with caps only in its current netns can then rewrite an interface
in another netns.

Gate the op on net_admin_capable() at its top, before any attribute is
parsed. The check is skipped when the interface netns is the device's
current netns, where the rtnl path already checked the cap.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/xfrm/xfrm_interface_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 330a05286a56..8fd3842d20c2 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -869,6 +869,9 @@ static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct net *net = xi->net;
 	struct xfrm_if_parms p = {};
 
+	if (!net_admin_capable(net, dev_net(dev)))
+		return -EPERM;
+
 	xfrmi_netlink_parms(data, &p);
 	if (!p.if_id) {
 		NL_SET_ERR_MSG(extack, "if_id must be non zero");
-- 
2.34.1

