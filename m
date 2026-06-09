Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C703FD943
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022687; cv=none; b=isEWln1pIcjeq4FEr0nBolddqMtpsCwLQbSlYHeCUBFJ8QGQswvgmVoU9unXqfxQ7r+PLqa5hiqG/jUG3IUMo+hd4u5PLnkR40xoxU61BpkEI5foAdERMZ3uGeGx9MHHvGfDI8vQNEiim/SSQK4xHD1gO0Z+e1KQlUXzugOkSzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022687; c=relaxed/simple;
	bh=FRg9Eu9QhiI3/I6NgMvgK88AoQP9jiLCzpjsRaCrM1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tPwbqYUwuU1cD6RV40zgOXkIIYbE6FgK4fXPPgi+fDz2qOGgvf7pfWRG7XySLj74hGgAM2hT8w0wl+1/RcaPuzVXWahVQlyMns6yEO8XgadDVEe7VPQ9o+i8uqUSIIz9U9RPQpvBPCYBgNVRJGB/1RxP/ABxt1VSNkc/glUDYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRi/wk1B; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRi/wk1B"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2247e38eso59970225ad.3
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022685; x=1781627485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcMeU35QKR/m7p0ys0S4K0EvNKBoe36L4mK1QCkh7IA=;
        b=IRi/wk1BdcqaWByMeEt9Bxy7LMhrl9XIeNjeGyZAbrZxW+9XYUQxo+HZW9X8BJ1nAp
         W7eT62eBbGavrGblFHUcIqOZDSo3W36IjSnE/4o76RC9rTkKzgXMUZftnoUMZdc0v8vy
         xhtugYKCRiBerZ8HxvtH4lQSuCYwtKgDUtiMqXSzxh7sksTfBhvvsqZBfOrbOL1pT7Dc
         rz3zLVcB0Xub2xdMuYNNF1zf3SLoADyiavt+E3mCL6+sRC3Gof5ABENV80uAdZ14DVsg
         2arlVligUZV/xhKFoZKRFiYIIs1LF04ejjli/2MRPHP+4hAzNMD7q6ivbmJAOY9yKLrE
         /f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022685; x=1781627485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TcMeU35QKR/m7p0ys0S4K0EvNKBoe36L4mK1QCkh7IA=;
        b=BqKbOMiqxhlWcNP3vuujpsONM3YDmywVDGjZg/yNLjYON0GN7oNkT9hekURA1E3DRD
         btBre6+oIVoRWQyyYyA5mQ7b+ebibVNXqkGBaeXMAR5qRlRjo3Ab+t42na5d6g+nHDSH
         jlYbzbMIoBhm0qjADNRWIVYvrfaTaM7E+nca1tNEKLL7gVAfd6CXI1ctGT0YeaxDRAwU
         Ya+ohjBAaUrTeW4Rb3BbQDRkMmFw7SMRIct3HzdbUeupVD9aUEEO8Rno2PRZ0yYlgVsZ
         jeC0YncvpERDf+/GFJkyQvdQHTqBFnvdGQT8PPzAyu4USw/k57WljFjPWHatuXWVQyZX
         W1pA==
X-Forwarded-Encrypted: i=1; AFNElJ/MxWZktHo4ZvX6hzHxGRbHap/ttu59S6j9Kbcx7KWheSi4kXK3iYs+fFXK5b7v7qjseJFE3SU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjrt5ceFt+2zu8c2Pzo1Emz3+W/yKfY+1HLkSQhJavYLCAx98s
	dVwD9Smf/uLs4A2NOldsNd/4TjRzIjF+tHujQ5KLFpfO/9BKdAKBthI3
X-Gm-Gg: Acq92OEXR5eUcKin1MHvTIPihk+9fKWvtfo08k9bXFpMT6rtiVNMw7yUnLHeaWIdsjJ
	ptKEmDaTX4SGqY0xhwFjWlDEVapX9LV2d0OvAptTjquHTgqD6ctptI/g2ju9Y36+RDjHTXvkHip
	QG0CFkpqMgGIhRlk5aO2OLUiXMbACnf0kGSCYaKqtZ75kVa1vc4jKMbOmMuKasVQz42s1laE3Pg
	s66THlfgPngZfZ2f4oOZo2WUuMmGnI7R/tiVToZ1IKh8b0ATYmRW6P/7BWoGt+gmu+69yWKf72j
	aOz1qz920kWzZa3q/tORUog8dMr/vzrX0B/RQ1wj2OxyoFoyeKuP/zP8S+9Rb6QUOPPmqFCfLPK
	xTKFyBhUdvh139cMkJ981cJPUF4c3lrqCLQfIc/xVTZuHWw+QNGLFDqi+zwJHFQYwNYMcVB6Vu0
	WQu0jPyxAEpRRA9JdC/01lh02eRgzCZ9Di8I+2VGDc4cWbOgs8BB34NW1gATScmDGGrMfdHQ==
X-Received: by 2002:a17:903:1247:b0:2c0:b35d:ed54 with SMTP id d9443c01a7336-2c1e85e04c7mr245030845ad.35.1781022685002;
        Tue, 09 Jun 2026 09:31:25 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm227710195ad.60.2026.06.09.09.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:31:24 -0700 (PDT)
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
Subject: [PATCH net v4 2/7] net: ipip: require CAP_NET_ADMIN in the device netns for changelink
Date: Wed, 10 Jun 2026 00:31:05 +0800
Message-Id: <20260609163110.1717419-3-maoyixie.tju@gmail.com>
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

ipip_changelink() rewrites the tunnel in its creation netns. After an
IFLA_NET_NS_FD migration that netns is not the caller's, but the rtnl
changelink path only checks CAP_NET_ADMIN against the caller's netns. A
caller with caps only in its current netns can then rewrite a tunnel in
another netns and pick its endpoint addresses.

Gate the op on net_admin_capable() at its top, before any attribute is
parsed. The check is skipped when the tunnel netns is the device's
current netns, where the rtnl path already checked the cap.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv4/ipip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index ff95b1b9908e..1813f6026e49 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -494,6 +494,9 @@ static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
 	bool collect_md;
 	__u32 fwmark = t->fwmark;
 
+	if (!net_admin_capable(t->net, dev_net(dev)))
+		return -EPERM;
+
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip_tunnel_encap_setup(t, &ipencap);
 
-- 
2.34.1

