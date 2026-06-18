Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF014A4F0
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 05:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781760809; cv=none; b=LS+T8xaVMFC6zD+OokU1ohtCLuuliN95u+sTxxvjN6RoEQY6dghlwYuMOt0rhXVK+QawBo2pJx2EwvBikofp2VATF4pQ9qX2br1lfzbQo8EER7JuxCqZMXzs2Le5eG1BM9BKgm/0wVyQB0nVm68ii2nAIuTSOOlPazQKJEa53J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781760809; c=relaxed/simple;
	bh=sW5xyKDUaPnM6cUopV3mk+CIkNTSQ52tQUCTumc8JbU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q6EvqfZkg5ULJDPxh5Jbo3n0ntq3aaohjsBvUZ5WT+LGJ7GcATp7yd8lsK5p+QZEWxHqWIf8JYaPtBrIKuJ/dAmL2pHJmhasOhOtAR77DFLhaQrGDUgN+nH4j7ksZV0O1I74oLXhWWueBYWy2o8l3/urJvnN/NwOtbm5jDF+ag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpFyOwU8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpFyOwU8"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-464192ab2e1so106707f8f.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 22:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781760806; x=1782365606; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=i0uwRadVCrKcgbTyVtvSnT1KA2KxE6PBBbL07wYsqME=;
        b=BpFyOwU8+Z37WqrUzfwXK3biAX6IAjrKoM1+fF1fszq11Njgdx7c4aHSEAdbH9h1BN
         fDbvqGi5SlNFzPNWWwlpBk+rNHnK3nEucxgHVQwOcR9Gr5ZshSkISXaYXhnSbfwkvJcu
         NtXA2yzJJ9poltaVOW8V/+A85cT+vXCmr61qR8QmZMbBH40CBHP8si0qkitso3riSFE5
         0mQZ81XZCUFwYv8lbeN4px/OhV6brUWta7WS7s22zqYYiBFHvl0Ph2Pi+dRzusFntJxE
         ChkHTFEpW4TzCk6AWOmAEsMIXYjGDE/270vWev3O31F5jSN7VNKR1QmWCWnwNTen6QNW
         J97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781760806; x=1782365606;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0uwRadVCrKcgbTyVtvSnT1KA2KxE6PBBbL07wYsqME=;
        b=d4EUs4Vh4jzY1tswRjozVnUtXf9cTMc4D4XR3o13yevDte46RhgKLrFJxn5iPUgFft
         ZmZBG8pQIDmV5DbGR6GiES9yN2EEJfIC7rWZXVzdOOh2LNf631aTnzLdb8my9HOUGiHc
         Any2vU+t0bQCtCl7LZx9Tk3eCEzCqut/wND6wjuRyi73D+yfD2ZhqYvLZ6PLM3vz/aqi
         Qt/VXpdsrvkHm/gElH4q76KY+AYNygiJYC2eWEVoXKKZZaJiOdvt2bmJiXyz4DQcLbhk
         AaviaWuKFgCCKDv8Ka98l4Is8PsIcKv6sNOk2f9Tx+xRcBKTrFZOwLpbejAt/i7VejmO
         7LXg==
X-Gm-Message-State: AOJu0YweSGjdxtSuVqz/ssmjMYa3GU/yAqFXXFaR5odwFk8vlDGIVlOM
	sotf0rtCBIat2jHRfgYb2SCRqxh8OTt+3Lbejen7HHfvmX9g1THPCDhi
X-Gm-Gg: AfdE7cm/IczhP4V0bS7kLjr88NFzEBVcIywHbF5Lc3E1u2qUSV1c/jHuHdr2mAMTKqG
	yMi49CEbUao/Ai7hDwhmnVoNflGSqN166OPv2rZbS7xuvFwShgg13LBUV4c9Jzuk5yg1ugk7qbL
	oFpcYECQq+uUCsyKizzyTljH6fgaqN9YpoEI3jcOF++ZlqAub16LoMAtvXO6A05jli1dA1F1XSQ
	knFoKNmfYF20ush0LlUENm6L3J/Lw76tPZwDOYJl5jjoH0UQRmIEJs6u6MS2hcfP7Biggwj8wpE
	we7LH1BJmTJ1vD8VEAVvIuwRC2zTui+v79BDMnAKakAYQWLeP5i4VTbIauTxymZ0581wiMcXYvJ
	Qh94BQWSmPih8XKmfAboXFGkhrpwAmYXBp9r4O7beQeAZTS57nFmdWBOnUZxZsA57wJYxpnyQvc
	avKzcSt1SvcuAvAkkDVYiTBEylEOgmQyy/01O7ABmqsaHe1Z+F
X-Received: by 2002:a05:6000:178a:b0:461:bfd6:510c with SMTP id ffacd0b85a97d-463ab043b6fmr2966327f8f.3.1781760805582;
        Wed, 17 Jun 2026 22:33:25 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-461eaa0d1c7sm16536416f8f.7.2026.06.17.22.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 22:33:24 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 93682BE2EE7; Thu, 18 Jun 2026 07:33:23 +0200 (CEST)
Date: Thu, 18 Jun 2026 07:33:23 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Noam Rathaus <noamr@ssd-disclosure.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Please backport d289d5307762 ("ip6_vti: set netns_immutable on the
 fallback device.") to 6.6.y and older
Message-ID: <ajODI0ViiySkNjK5@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

d289d5307762 ("ip6_vti: set netns_immutable on the fallback device.")
was already queued for 7.0.13-rc1 and 6.18.36-rc1:
https://lore.kernel.org/all/20260616145117.258480602@linuxfoundation.org/
https://lore.kernel.org/all/20260616145103.487984074@linuxfoundation.org/
but not for the older series as needed.

A backport for 6.12.y was added in
https://lore.kernel.org/stable/ajJ6TSzxuWdfQkxf@eldamar.lan/ .

Here is the backport for 6.6.y and older for versions which do not
have netns_local.

Does that look ok?

Regards,
Salvatore

From baba4cc5ae46577aa7fc4f163c0dc44833298d9d Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jun 2026 15:59:18 +0000
Subject: [PATCH] ip6_vti: set netns_immutable on the fallback device.

[ Upstream commit d289d5307762d1838aaece22c6b6fcad9e8865f9 ]

john1988 and Noam Rathaus reported that vti6_init_net() does not set the
netns_immutable flag on the per-netns fallback tunnel device (ip6_vti0).

Other similar tunnel drivers (like ip6_tunnel, sit, ip6_gre, and ip_tunnel)
correctly set this flag during their fallback device initialization to
prevent them from being moved to another network namespace.

Fixes: 61220ab34948 ("vti6: Enable namespace changing")
Reported-by: Noam Rathaus <noamr@ssd-disclosure.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Link: https://patch.msgid.link/20260608155918.787644-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Salvatore Bonaccorso: Backport for version without 0c493da86374 ("net:
rename netns_local to netns_immutable") in v6.15-rc1 and without
05c1280a2bcf ("netdev_features: convert NETIF_F_NETNS_LOCAL to
dev->netns_local") in v6.12-rc1 and use NETIF_F_NETNS_LOCAL device
feature.]
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 net/ipv6/ip6_vti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 04e4368fe465..33b21ecd51ba 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1155,6 +1155,7 @@ static int __net_init vti6_init_net(struct net *net)
 		goto err_alloc_dev;
 	dev_net_set(ip6n->fb_tnl_dev, net);
 	ip6n->fb_tnl_dev->rtnl_link_ops = &vti6_link_ops;
+	ip6n->fb_tnl_dev->features |= NETIF_F_NETNS_LOCAL;
 
 	err = vti6_fb_tnl_dev_init(ip6n->fb_tnl_dev);
 	if (err < 0)
-- 
2.53.0

