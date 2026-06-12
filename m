Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57258369D43
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254801; cv=none; b=ccFVNjPuI/Lk77oIlnmYcg7QupB0lIB+tCqDiGu+xu8qWhIN41SqeTaTLTz2UD/xyozueoUWD/WBdtZOs3zTzcLrtUcSNDIZgiicxOWNN/w6QuVedzse1SMgfB0tUtFjIwJqRaAfKpj+HWoTI0RfC7klhR/rXDiQPp/n7tktOkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254801; c=relaxed/simple;
	bh=jy1vx1jZE2D9hbRYBo6NShB0yB6/kvd5EH3YsBhiaKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FWNjdgzdRHWSO74okG7mu59jak7G+JQdowh4MphUBa79cZ5LTcnEUm9OiHE8jsb1CpgK7y80lnw+sKCHRLOyc0p8gg6BkIIgeLG/P7eGo45Hn1ksfvlJ+X2ie9HLzpoX0ilDdC/3/nipIX5cNNz8WgNNYY/K3WtJj9rryDYoSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B87sLIwZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B87sLIwZ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8423efad617so535738b3a.0
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 02:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254798; x=1781859598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrjKQOs/1vwJlEoW3BviCRwGf0Zqke/HPyqRXYkXM+U=;
        b=B87sLIwZxkIDd8OsdPk+FxxUU2FB5qIEX6ckCM0D2/KYaVsEOeqgYUVewODzZduYXi
         NGkOT2jw/vpBtWdJXb1l7ZUQRkQ0IMGnVD9fCArqGFgTAOwyWAFO2LiJIlJj4OhqOahl
         JI10MfIA231GW5bVHFMEEthHF2Zmc2YWp8Z4gRqCYVdLIPWs4BY2upfOmrpvvMdwDA/X
         2Pganai99bU+A5UnwjVpda1W84BE3Xx/w7KcuK2iXKpIkuqawY3jZgFS9wyzVfetv8Zl
         eUkkee6gPpPsgl4KPl+AlUQPVllcOnEAiZCpxCsvctZ+Tp+zGFMsvo1QE9Nej7IAzj0E
         ljfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254798; x=1781859598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GrjKQOs/1vwJlEoW3BviCRwGf0Zqke/HPyqRXYkXM+U=;
        b=skEZPJFUyKTq1eNoWgljHilzLzAYsUmHbYfKdXk74ZqPQA/KgoueMrMSQPPTGj7+Ef
         JAcSWhp0XNf/m9iNVHEn91i/VVuTPtRniC3bXYD0ZrbcTM2mO7bWJ0cJ5dO95HHXd9Pl
         /Sf2cdbMi3BA3ze1ActLLgH7rt4AHw7VT+d/PNMrDIzv5Ek56ZaqZrTgq2mLuxG2XRRo
         AfwxU5f0sGT/k8svAqSlHU9S+57QxnKdmqJrkkejQt8/mXN1EHSL472ULofnM2rPGt1m
         hoMlwGiLpcugp7iPSK1Pw5lf7C9FA4mY++1aOR0PeGl/6JuhQCKl3qkiyUKNi1vN2Qkb
         9ZSQ==
X-Forwarded-Encrypted: i=1; AFNElJ9EkWHPlNGiPIvgjpfjM4VROt8SnpMIkJ/T4/bh/okimtufrOQv1UP5CNImpeKmmOYbs0UNNZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx65+z8NtCgnKtGOZqGu49hjQ+HemdEdryzP6K21gOdl2jYyYg5
	RDoJXHuencMiI8eP542w8CuKuAKximfOAQJVZS/w4IydoEg5J0S2VBeU
X-Gm-Gg: Acq92OEIEHXgdKmXSH2a7wIhbGNDpgsio8+Kmt8ovsyo6X80xLhfB+9TotTj7dSWrhz
	d/dNpiy3BokKhNGk48nweVlLwg5Siznx+75GqECQyZAJREOpf8HP16YyQGro/1bMNo9KfW64i1U
	deKFBIPFk7Ow/fa0k0YCM1E/yD7h/aSmJNmsg8rlftMI9l2KjaAkUPdTm+SPN06TkNLtox/89a8
	mh6R1wyOGjuEcywkGNSi8w3bRrgDjaQD/x4YM2j2ReZcjc3m83RpKkB8/Dl1cMxCzJs1R4VT1BJ
	MLvrRD0uiz8a1op6sRo2/pT1PmanRgdm+rraNvF0QmklGB1KEwVxLPlx7Ay1qePHPklLUqPwb/r
	ojmD+KvStv0CFrWrnBjJE5K4M8GEek4/Rmfl9T+VF8Gg9c5sJ6s9NX9rYqALih4IGtTpBfleZXP
	cz9x/3Ep1B04QNuPGjCie4UrT8i2mykd9XAV2DOtYJYFTqfqmj
X-Received: by 2002:a05:6a00:21c1:b0:837:e9cc:d465 with SMTP id d2e1a72fcca58-8434ce40744mr1961210b3a.20.1781254797743;
        Fri, 12 Jun 2026 01:59:57 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm1646892b3a.0.2026.06.12.01.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:59:57 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH net v6 3/7] net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
Date: Fri, 12 Jun 2026 16:59:37 +0800
Message-Id: <20260612085941.3158249-4-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
References: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
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
Fixes: 895de9a3488a ("vti4: Enable namespace changing")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
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

