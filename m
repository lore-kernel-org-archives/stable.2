Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D2536308E
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 06:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159315; cv=none; b=BP9T1sB7zm/DUWJADY7vPXC3hGws+WzOLu96OEy5SFmcQ8ovZVBS9I6uGTQeX3jkOvX1fmdOX3fHCO7SE0xUdMU2AGhvn6MiCcYj9p+0ZHCFmevLc66dMGhYAkG1tnramLNgstbEbCMHzFWxMVGle/AlLt9gXlHQgEbM+Pe/HdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159315; c=relaxed/simple;
	bh=+zokLVbOzGFitsw36alWayaKMRG+sHuntk6NcwDsdUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N1BSD/LTaw+gANgZiRClY2mwiEUUGg8f4Nw8qSb0xxfhkoykgAGbov0f5qIgBoXAN6C0fh5Pa6qQx0svw2dzFtaFV5vdVv41yB+ip2QeSSxhGILNg/2BU/wECFIMErJ5K19f4NkIwxzm4gRkPE8pY/1bDsO38nUTvT3ZtbVnsUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tK2ojUVp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tK2ojUVp"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so53147375ad.2
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 23:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781159310; x=1781764110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KFSPxWAI+mIMkFyj/SFPC1tnivbSRId0vdj8dR7c/U=;
        b=tK2ojUVpDu4IRDIpbOYqs89e0tM1s3W4Hj1RyrBfP/LBVG5FVnsKRZYHL8A09qw04Z
         gLzfEnfrHc97Df2Vymfhgi5blvNNrp9X08fwl5u8zGyXzLEc4x2O7W1C+hYTc15p5EOa
         s2pVS7VzHNyvDuDyYhvNyBx2EiiFj8aAe2gaedMeKHtkLuYT7++eYfTU9iW+v666Qiae
         MmNd6Tq7mulTi4Ne8lmgp4VU0JNk8PT24UyHrxYcGEtsEDHDM8e69Ppxku9iM6PT1XTJ
         8QXuQ6Edeu3JxmiquALs/gbXNhFCpi3WP7FNOiQ6xRKCIYC1mWoavUBh3FGpMFTnF3mv
         hApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781159310; x=1781764110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/KFSPxWAI+mIMkFyj/SFPC1tnivbSRId0vdj8dR7c/U=;
        b=fO0Hf5AU71cd5lDqg7T0gA0gQktRUm5QDpQpLC6TLfi6VWtkvkkVJWMQnw2JInBL9B
         FHVKa5xcKvI95tcnAJivMMyPj/rGIBzks8sd0+t/roPj6U2h5Ax2NOSJrXsG8KnCwfkV
         KR1hiPJJ4ZX/6iNi1yDsFMYoz+Np9WfodviwkIXWF9FsYN0Xf4XxFPA9NXLAiPqOmA2V
         RR9xL8UhBsCO1xmcFiD3XEstnUkFkBG75264SGQigrd8h+o2qjdwNwGgs1bETTc2dV6/
         Fy7mK/3lhFJ4e1sgStpf8MG3snWwCEY/MlrpfeOZoXDZIJf+e9lqpjitSYNbItCcIyHH
         VYig==
X-Forwarded-Encrypted: i=1; AFNElJ/AESBpYjyl2vg5gyDXNxaaA5sY23nC6RuIMzWEP6L+w60V+B3kXj6IVFtXYhkiecSbFAifm0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI1xsfoYRTn5gwxYLnyDWxlXQMgPJac7FMy6uEF4Py58OLTui5
	hDKCz7cqeJg7Cz2TrYaUWYfcgoYCGXVmQYSTjRTjhNW1T5lzKYVzxyzW
X-Gm-Gg: Acq92OG2Z4FLMXc+BBrvm54uMJEho0+QIKUv2vO35gM1eQfgRTFz4VwkjTiQROcxVer
	Ol3N+rulOmFdH4VKKnwC4wSC++q7cpuFiK4LXDO2gcyMKaLAxqVDIRx0AVWyfJ4e1ZsWhYcpqT+
	wuQ7YS+6CVpDybdfOOr21d1OaVLKWtmAZia9CVHzd+w4qlkUZFHvcLAx6eDuhO5aBosFUuLFeJj
	5IQ9gqekVChdO7ywfOXdAO/OI/EnZ8fLmXUzOs+N+LZN75wjAbWuZlD0rg89T4gaI8s1b6EKoyG
	HKgnlFmg+crleOp8oJgOR43jfB2L92m8K74/5UfZzntXCsDBkjrIzZgkOgRoDe0v37g5A9enPoN
	LIA6VoUrvxELX5zc0YQEBMBGJ7zrdLQWw4fAanCy+C/QXaaJQgqzs3ebr4HDo6wLU1Em0yNBwPf
	DaBgKbbvfhHkJw86rxd2PtsKMVH5Z9Zn1vLTEJys0E0nVHbebZhRzFyqQVpo8=
X-Received: by 2002:a17:903:2342:b0:2c2:bd0d:3cf0 with SMTP id d9443c01a7336-2c2f3c0376emr15193595ad.25.1781159309968;
        Wed, 10 Jun 2026 23:28:29 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm282891565ad.1.2026.06.10.23.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:28:29 -0700 (PDT)
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
Subject: [PATCH net v5 3/7] net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 11 Jun 2026 14:28:10 +0800
Message-Id: <20260611062814.2528793-4-maoyixie.tju@gmail.com>
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

vti_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate vti_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv4/ip_vti.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 95b6bb78fcd2..3b80929994a0 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -596,6 +596,9 @@ static int vti_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = t->fwmark;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	vti_netlink_parms(data, &p, &fwmark);
 	return ip_tunnel_changelink(dev, tb, &p, fwmark);
 }
-- 
2.34.1

