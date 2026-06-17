Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD5731E849
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693010; cv=none; b=mKyM3tl8KST/TJXqAA6qhhCfQUMcXDAMwfjoq0/O5WcLvuWhA5YJQfoNoaTcul5QT1UsO1FW0tf4CK9MBgxlACd9Xr2Gw387KBGPEDZXxXaKLRI7VUqbiNkeFOIsNIA10JK9EQPRf2r+kjGQp7iJUMagHlMVgPt4DDPTA0dcuzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693010; c=relaxed/simple;
	bh=7A4+DQqpE2+A6BpwI07pYLPXlISkd4NbDnDpIvO/p+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MbJvCO7yh7mZ/txi4GS1r1+4ZXRbbsCFZerNAWe2mL67Zgjz0s8KigiTBWidrkdVatSAaASdMyVvN0+KEw8oGE7jOgUt0UF5m1ZHEtO2dvKT9KGsLAWRWU5bJxqakBAzyWur4IG5SMyFUNm4gI0yh/HUP9bOz9Ou+30LW9Xorqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQFs2kg2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQFs2kg2"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so4098625f8f.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781693007; x=1782297807; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=d94Cd91wHWU/3ubJW6/TMlkM9ZNPumLifPdPubPndHY=;
        b=WQFs2kg2n5O+6TlGppGOXhVdeFfnpiCn3ItG7CY/BqvNAlhd0OJVAGiklKSYRueNx0
         IzJQpXNjLcMY+Ldca4/Mffo3jTZmmuzVW6LyjSID8ZxAtKYNppw2kK8WhAZeK8eKZNh6
         sfvsB0Oor71aoKQ6HnL/MkncXij+n50anDUf7jh8E9GwSZnLcFNMAp02ABp6pYCNPGtj
         IxpJUOYbguzfLGeqHv9kt999i+ELbQrR6fl9uOE5KtjmzsepsRtIabTgpOMAhYZNoc4X
         h/lzCy1KFzN7RHr+BqvlONkg9kMew4tgYSUl8VRo2Un5qbGeoBJULgltifYVtpkpZRnW
         GvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781693007; x=1782297807;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d94Cd91wHWU/3ubJW6/TMlkM9ZNPumLifPdPubPndHY=;
        b=ZQo+u04JtNYcQHt2kvxfhJYDzX+tIKkRdMsUDCQ/LNrI4AanXAPBlq5CzmGx5eeoUh
         Cm3KsXu55jvgh5lfCRkKQre3QJ5O+O0meOVhyKsvPMuIK9TXmyaNqXJBZMfP/hDDr5Cd
         hVPXqWwYkVbC5IMqgfyuS9sZGQXiOvibK7cD0zvvAjIEe0mKcfbyqxJfDuePbv01dnmh
         qsQRDja/mDvZTsYjFLGWhk04yl4+8pThHKRHKB6JDEbCzYu9Ay/L9ooV1J9J7o8Q8ORU
         mYpoIaN8W5dIfYGnST1kLiHdx6XTHXt8xuEpZPrcWm05pPqT+4wIXeOG3+qXU/tljFqk
         /Mqw==
X-Gm-Message-State: AOJu0YxLfKIFNMn0JmkYfPBklPCTLir+jdTWUOZTihKL6xV4qW8LdTWo
	nHX+wxYSAJhnWue7WQeoxfsPCqgEVBbDOKYakaIcGosCvJ215AMWe3Ab
X-Gm-Gg: AfdE7clFtoXEpenE/3KtLqH8PXhrbJ0dT44YIKvyX7MrHoYlCG92V6HHvnTyEAADWnG
	BZd+XBTXXoMs+9irET4mypc+Qy9zJ9lpbmqq+xHtzb3+ydob4zLdja9Za1LfRbwq6GC8iT7rD+U
	MfQv032PEC3InVbFJjXVutvTRrk/37wQsi0VlhY8Y+4Z80uDUx0RGoVif/55Oc3sINPd8jQjlS7
	sYiSGJVJ70jy2nk6PPHgA3HexI+PSpJ43R9vRSP7plhvISiDJaPk3zeKNcr47IXOTU8caqyXXVs
	J3cJy14uAqJ2oaxAPmh+bp1DAebQddaVIb0bhbtKFfUOZhnsLes8tcE50vMxxL80bAhxkvBnGmo
	Ph/jhwJor1QR8oz1mm6/tqya9o7gZ0/w/XdWJ1TQnroLAFGSPYNFLu2IJPLR7lqVzQuY7IFs3QV
	pjQuhToGhePow/85s4TzPdFOpLRBmOHGjk8EPEmjO77YZO/sgK
X-Received: by 2002:a05:6000:4697:b0:460:c9f:8747 with SMTP id ffacd0b85a97d-4623788fd67mr3935871f8f.33.1781693007205;
        Wed, 17 Jun 2026 03:43:27 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4619fb12edbsm15811424f8f.17.2026.06.17.03.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:43:26 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 9AB5FBE2EE7; Wed, 17 Jun 2026 12:43:25 +0200 (CEST)
Date: Wed, 17 Jun 2026 12:43:25 +0200
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
 fallback device.") to 6.12.y.
Message-ID: <ajJ6TSzxuWdfQkxf@eldamar.lan>
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

For versions which do not have 0c493da86374 ("net: rename netns_local
to netns_immutable") in v6.15-rc1 this would need backporting.

Below is the backported patch for 6.12.y.

I have a question: Given the commit say "ip6_vti: set netns_immutable
on the fallback device.", but this won't be anymore a correct
statement, should 6.12.y get a "dedicated" backport instead of
claiming it the upstream commit?

Unfortunately the same change won't apply further down and will need
more work.

Regards,
Salvatore

From b004312340b7c6ec2d757c24279f5a1d0b3a831a Mon Sep 17 00:00:00 2001
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
rename netns_local to netns_immutable") in v6.15-rc1 and use
netns_local.]
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 net/ipv6/ip6_vti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 2ac88593a954..892533dbb527 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1157,6 +1157,7 @@ static int __net_init vti6_init_net(struct net *net)
 		goto err_alloc_dev;
 	dev_net_set(ip6n->fb_tnl_dev, net);
 	ip6n->fb_tnl_dev->rtnl_link_ops = &vti6_link_ops;
+	ip6n->fb_tnl_dev->netns_local = true;
 
 	err = vti6_fb_tnl_dev_init(ip6n->fb_tnl_dev);
 	if (err < 0)
-- 
2.53.0

