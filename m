Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C87E48B37F
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022690; cv=none; b=YiO971vJF58aTVpiNudOPQNC+eh81dq5tM4gn231Ey9nyr926sLzjh4f+jzpvUaHZz4emZ15Diwsh5XBmy3AfEiMG3c8qLH1PfiG5Z1KO0apZDCEze9nGRL1ce5Fa62Vbyz5STZDyj1qbfZWLgbnp/4y04ESOjh76tqAXxTvTTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022690; c=relaxed/simple;
	bh=CKQ7zjMxV33Xpql5BA8n/9v9zqRfxq06nC1RhTinzkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rwzrf5yI7EkYFlfCqc7HgluvYcxvOEHOWBG7XA5o+R4q/6oI393MAP+NWKZ7SShDch6MQkpb01x5FeYlXPcs6CNfyd5Dp7P6olR3pNc1vQIeQ0Hk2qcc5vSh9BahpqxCX2LdDSthAChiirF0XqTMvnlsFKGDc9TgogdTIriKCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLaFhtzd; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLaFhtzd"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36dac5d5da0so3013764a91.2
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022689; x=1781627489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mr5itRaGOdJM0OW4OLU24W+WID9quq8c5B9yuT9g/6c=;
        b=CLaFhtzdY9YR6LphasQyWqWEINehXZ8NbkKn6F0mAP9pEhid7MbXr3aocycNAi1Iyp
         hp3DIqCiXD3+KKffiYVuUZTdAxZte5S+TNmMJKhMSzB5kya1/cWK3mkHPrCEXxWqiinQ
         LbS5J+ALTkEQffo2Yn9z9PXLLPj7sbhJeuKtrb+aDKQn027j7uQ3sY3kwHIrMhUgGkux
         WIgnKE6gxqhBzxD9GSx+TwWBPdo2CqCpjbVZ4NWXs4s0M/GOnUP12ibofuU+/kuIJ9XM
         w+zC0uQRK9AkXIuU7kXXhxP04xPs/lYgM4ecXyn4qbOSSn/gf/s/l8+qwxiVeeWk0QM1
         np6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022689; x=1781627489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mr5itRaGOdJM0OW4OLU24W+WID9quq8c5B9yuT9g/6c=;
        b=pQ/FNM/wfpiy87/+7Y95SkY4VmI8LLDp3f1WetVSaldyiy4ZVyPziFF1XdQoaGSGyq
         sRrPP2ZpmAPGFYQQQSU0me/xn5/mkeDyY9X2sqfDBWEvbXpoTqTyADUvf+CxjByWvJaR
         F8Q9nwWfboBhrEhxKdtIdrO/Uva2VQKBNma4LNnB6jfEB2kIdWdykQG67+JZhxx+O9hS
         pvVUIdzURqPlySsMcDtWjWPih7N3gu/t0TLpSoDTbOPs2jb917Vu/qMa9nexZC8cwBJz
         zpNnRVKMP4/cTBn6E3S8qxnVrYuJQAGd+B/WPnMu1c2v7aXp1y/vxNX+L8QiXSUfS/Bj
         IwyA==
X-Forwarded-Encrypted: i=1; AFNElJ+9lrEzdWTIwFKimnggZaI5euULMiidFeqh31T+iXOGzcXcxgYAT0/Lk8YGD7SIaqqd9sSG7x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG9usp6xBGjK+0XBtkgq5FSXCe2rXbqlBF69Zcan8JdqeyMG1j
	cuGlcFJAlgNbPELTVi5P54j3MyfhPQl3+oofqf6c5yCkaspjHwfJQxgX
X-Gm-Gg: Acq92OGatDHJbxFH5NXkqvuZTal2BVu6qaj5xWvB5bswtDdxqfia1SXgIJn34qjO/vb
	QQ44vznonub0DIlA0zJoIVXwM3s1J/F9hp4XSHt013yzVa1YLzVRx/i6WcHVchMCGJ7HIdDReMv
	0239yjJfVxapwvVRFPUad9ESQx/GinPsUTvYuYXVOanH5sLZ9xEgbm2KhqPFM93hP0mNC42SJZg
	BpNOBz5/XaOp6D1bYEmvcXDYejA0D3aGL7aPy7gam64ggADtrmsfbT2+VTAARQd6wCB8nCxTXho
	rCCHglzo/rvs0mtUBX1u1LN8BNFiQXUfuMjYdbk7RMZ+NPmdIH8kdxk9kN5C3ub0uQb+92q2N5b
	hEPAC4cQ3hC3jm9Yel+TkczJdAR/H/kXEF9aeCzBvuPu5XikQR7Vei9R5TB6mehl6SCp0rfSUvS
	zPL6Dwi5JbKWaiJT/pNGaC6jHNBNYoxFyI/DYo0sgbDZaYI0GCRiS0y4SyU3s=
X-Received: by 2002:a17:90b:38cc:b0:36d:f28b:72e0 with SMTP id 98e67ed59e1d1-370ee92adfdmr22988746a91.12.1781022688682;
        Tue, 09 Jun 2026 09:31:28 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm227710195ad.60.2026.06.09.09.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:31:28 -0700 (PDT)
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
Subject: [PATCH net v4 3/7] net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
Date: Wed, 10 Jun 2026 00:31:06 +0800
Message-Id: <20260609163110.1717419-4-maoyixie.tju@gmail.com>
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

vti_changelink() rewrites the tunnel in its creation netns. After an
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
 net/ipv4/ip_vti.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 95b6bb78fcd2..55ec52bc5db0 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -596,6 +596,9 @@ static int vti_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = t->fwmark;
 
+	if (!net_admin_capable(t->net, dev_net(dev)))
+		return -EPERM;
+
 	vti_netlink_parms(data, &p, &fwmark);
 	return ip_tunnel_changelink(dev, tb, &p, fwmark);
 }
-- 
2.34.1

