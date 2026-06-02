Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87088347BC6
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432622; cv=none; b=BrMJBjbqAsPaHziNxEEJfBB+Hn/1nJ4choUAKSE4PrUGNWHJ3q7Pp5yQwPX/gTumXmMUNh/PqCHUJOBx38bOJYAMoX0MuwYjl6qfiMHVdbfeIMhc8mtWbVGDlr5JZI0/Z5m7G5Nyy5Nuy5LWxopDAiuA6HubhVpQ/vauGe3StZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432622; c=relaxed/simple;
	bh=vxHw5xkHy0lTmOexWYZmYDQrDKC10LTfZ92WPsi1YNA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CBakUJEg01jQBa2EPSq8LUlIuuUj5O8qk4JyX0zc4ryCvEhW1fSEo5HLVEE5iWqNrz17Ssh1CPeXhBxDvOoK7sGcz0Ig73MM9mRXZKgjl0o2yybW42ZU7ggIGj6HhCsWsbEweueTOLqTnxsGXebrzGW6oWLtybkLRDoHrdu45rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpqtuJkm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpqtuJkm"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4906238c62eso97875165e9.3
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 13:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780432620; x=1781037420; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lnNRjX0pOem9zyj1qCVaeq1WznhVA80tQOfhyf64lQg=;
        b=YpqtuJkm+bW3O9ZATOSroPafS9Y6ymWpEnVo6Db2BS/eCaY8XEooMO683quqncxei/
         uFN3Oew3+oHXOsOnJX8HM6kDYUoOWdpfu33oXeNqpoCTsAEbPvKtDWnbkKZLpGxSFsfj
         jDk1r+akHqCTGQYvZT+XTRrqTYMvE6qmQduSpWzE14VuWXq5p5YlYiJnNKsKoHt1OQ1d
         S0ATKXXp2fG3eX0TsthCfJ1pCSxVofoc4gxadRF0fK64q07b5s8a96pCuL1M4DFfTZw7
         3dRSH5Pei+gpTL6ihJVf+rD0jxYEMFDtIFA52VeDn/34j2PLCH1BIwvM1TboRpSQeIoc
         yspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780432620; x=1781037420;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnNRjX0pOem9zyj1qCVaeq1WznhVA80tQOfhyf64lQg=;
        b=oi9gECdGFUfMSCkzIFg+s51A5E/TKHKZ5KPB8issnVeCpyQryflFXQjM79a/Z1w6oa
         ZtsCqrC/KwllsIZSuC6DDxHC8LT54WqxO9neFV8Tp5O/IErDnFR0Fd6g4vaKgHS4XTvl
         GptXlNQ0crDWOzZBnOjJ7L2nAQwdVrjc5OcI+Dxr44cTSgEQWgliA7TsH6PGo/mnEmBs
         bla1IaQ3z5FvdolXgSoM7rwDPRjPM9viGXm9XwHRGkYcH6KBQm7SDBUI2RIukecOaHp8
         YoP1qOmzYA65SKA6b92QV6+CgJoL1uEHu278DATCp5xJiKGIRC+DoP/nx1XnKxku/lbT
         3iHA==
X-Gm-Message-State: AOJu0Yx3NpuoBxsjQ9XYg1OI+Oe0EWkh6eYjkPlok+eMYjIFXyD4wO4H
	tDOIbIHd2xFQ89+Brl0m2rTCeC/gGSRd1R6zzKlG0HKVgsuikcPPlfJwKcvzxbE8
X-Gm-Gg: Acq92OEc9MiAXp5nIdWceWM6bn57aUq5z/ott+dGsr4JzKOA4AWBg4y3DQM89uIJT9B
	2caBmRKBohuLFBDVihUavP7djJ5H/Tllnt7hWEyC4G/vPl1g2p4I6ZoRbU/YU0gKUtTtVAyx3pt
	Da0SPpmegaFozJKpjYO9EMqiJu89d+5Nj3D6CkO8nKUGu6uzNfhZtEf1Y86H66LNHWCHHkHYhwR
	xNOuw/NXOpBFjujwR05sPlLHhhfg7IUnCVMazKMjJyPsQXiCyQ3p33L8BQu0pBg4pfk4Olcrrd0
	nRFaTUrxyTArfAhrMD3S1ZO5Ul+WL6M5h09lyPHnCHDXqvnzUO7HRQAUW9oReMWH7NSD5klvNJp
	qrQaXgF6vBjkdvsQpG4d0otb3cxVvAwDAK7iLwLKp3DvaOSQ0/D+fW5E4rVGSAnbXEySOg5gX0F
	ku0LwuD/Snf6CS1uFGonT5vGt2PWhAPxSO53c+E07oQdYEWc5HsWCtanr6tStyWvkmgLfr7w==
X-Received: by 2002:a05:600c:4e92:b0:490:6869:46d2 with SMTP id 5b1f17b1804b1-490b5d44845mr7425075e9.0.1780432619792;
        Tue, 02 Jun 2026 13:36:59 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm2096844f8f.1.2026.06.02.13.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:36:58 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 1A00ABE2EE7; Tue, 02 Jun 2026 22:36:58 +0200 (CEST)
Date: Tue, 2 Jun 2026 22:36:58 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Huzaifa Sidhpurwala <huzaifas@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Please apply commit 4db79a322db8 ("net: gro: don't merge zcopy
 skbs") to 6.1.y
Message-ID: <ah8-6irgXpRvuZ8T@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

4db79a322db8 ("net: gro: don't merge zcopy skbs") was backported to
various stable series (6.6, 6.12, 6.18 and 7.0) but not to 6.1.y as it
does not apply cleanly. With adjusting context the change applies,
proposed change below.

Does that looks good, and can you pick up the change as well for the
6.1.y series?

Regards,
Salvatore

From d6ad94fa8c6ff9c191e5545bc6277d2e3c75b811 Mon Sep 17 00:00:00 2001
From: Sabrina Dubroca <sd@queasysnail.net>
Date: Wed, 20 May 2026 22:44:42 +0200
Subject: [PATCH] net: gro: don't merge zcopy skbs

[ Upstream commit 4db79a322db8c97f7b73b8a347395ef4d685eb40 ]

skb_gro_receive() can currently copy frags between the source and GRO
skb, without checking the zerocopy status, and in particular the
SKBFL_MANAGED_FRAG_REFS flag.

When SKBFL_MANAGED_FRAG_REFS is set, the skb doesn't hold a reference
on the pages in shinfo->frags. Appending those frags to another skb's
frags without fixing up the page refcount can lead to UAF.

When either the last skb in the GRO chain (the one we would append
frags to) or the source skb is zerocopy, don't merge the skbs.

Fixes: 753f1ca4e1e5 ("net: introduce managed frags infrastructure")
Reported-by: Huzaifa Sidhpurwala <huzaifas@redhat.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/c3b7f906bbfcbdfd7b4fa9d6c18a438870df85be.1779307748.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Salvatore Bonaccorso: Adjust for context in 6.1.y series without
e8d4d34df715 ("net: Add netif_get_gro_max_size helper for GRO")]
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 net/core/gro.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/gro.c b/net/core/gro.c
index ea6571c01faa..c5a9733d929a 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -171,6 +171,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	if (p->pp_recycle != skb->pp_recycle)
 		return -ETOOMANYREFS;
 
+	if (skb_zcopy(p) || skb_zcopy(skb))
+		return -ETOOMANYREFS;
+
 	/* pairs with WRITE_ONCE() in netif_set_gro_max_size() */
 	gro_max_size = READ_ONCE(p->dev->gro_max_size);
 
-- 
2.53.0
