Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B363DE43F
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636456; cv=none; b=BaaoDvZjDa3BrcPV0tW90rIFnZNDAoYJuS4TAElluvWnJowZRxondiFTkPqpw7AsUuV3cYMkhoTQ5E/gNfYjOXhec3es/a7xyFqJjBcLJbrHznyp5FxJivQtB4qwxTx5GChZl6kgz9h6uAMRKX+80xVZ4wxDV2+xloA8EFTSFWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636456; c=relaxed/simple;
	bh=9Tyx3IZ683JCdQMRbGJeTjnP9qW7Us8tqu9ScIW2eJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZulkPsnN3oHnEy1DdoEnSbMqdixKyd2QcNabVg6KkQ3LYMfzSC4/fx5EPHE18T66Ko2S09VwyBoyIUI9vF7HFT5sxav+5k4NltqFCm6ZawLy5FCl7Uxcr9WR5Z9VjgC3UwZEGlnrl6OCcYnka1gnhYI2oruTAelBRd2Fq0pqabo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bE3JPLzf; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE3JPLzf"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-397e391cb2aso43986121fa.2
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781636453; x=1782241253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hAylVLBoI1FWIRaqnARn0iCZWEh0HddelhXPEdFepIU=;
        b=bE3JPLzf2Ayr90aodKGCy3QXSoUKQacdo32bqaaB1GxC8d2+KrbeH4ujPMw3Bl+Ln+
         gwa8VvdpxKapffdh+G67FlMyVuI+I4LJO5A3Ccp8Egzw4O2fPhGc/BBWkC7ZhYQEDeTk
         sEzsTIJG7g/PLmIPt3tCUemUUa3VLAP3/7e9XztNdxOLb/V04V/OAVWbt6Cydr8jKasl
         A+3XsPRDsMxCfIRZQs5KueO/ftN/k6TvI6RamGeZ5cMrJHP20TIbEAS/oxVRHUi7sdMF
         lcdnCQ/+gPvXMBIOXVo3B3uGTWZaoapq+rFjBPnS+a4WThbrFNL7v0O2cnvObe91sd9N
         trsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781636453; x=1782241253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAylVLBoI1FWIRaqnARn0iCZWEh0HddelhXPEdFepIU=;
        b=H8zy7Ug0em7uaYo7CApmrabwMHFJqwlGugXK0UeRBGWgZw3wg3qsRmsexHsjSVt/qq
         ZW4Kt6hHC3tMZPYT62cdWLYjzFbsPrMA4/LTqimbH42jjx+mYZfl6lqDr4iTbS7eevCI
         G3xcqfu3g3zTDavUHnk/id793n3G2r1eW9qxtJKYcPWssKupnm38q54lIzOGbQb9EkGd
         MeVJrmW/eh/vCRNC3Lc8zW4YmePJRZRUvCbX/WoABCCjss/cjZsFjcxOoxIgfOEJnykV
         FTLzeuVsMG4/wqaJXkIM1mDoCbm/pDf6MiPGh2ABtfu0BuisA05VEIOqfKqD06DEn7ZA
         +a3g==
X-Gm-Message-State: AOJu0YxvDIkMVVu6zni5g137FlqHd4KRka+XGn9UzQQtNUF0O7rAyEOr
	KdiNR55t2prIVt9xsBMBRv9Kx7OcaKl5/2B0zLCsl7qIxKUlQpVtFGFOzpBP3b7VtJ7LbQ==
X-Gm-Gg: Acq92OHUE5IUKST6JbkDLnSx4mh5hEBK7iKXY34NpnKxw8gckaAS928wqVN/wZbbd/Y
	B0JSmtbPBkW/LQRtfWMhJ/jw1mciwt6crcPrEBfHKPIWJrPVORfi6y8SXqOxSvJlhgwsp8BN1gP
	se5pwbZVRnH8uGtL7TVttyQC6LSIEYKmhkUTlYDTZezoZSieMZ2t7rrp9t+pZxsgaApPe5YSYB8
	yrsiHQF2kkE4Rvu2nW7sKGQeARVN9U+IODzA0jwKfW45KjE8Nq3phNHfwTc+XESOxOWfEctO5wv
	F5otQ1SPkfqoLBllCq8WX/D/C/buR7X+WIztabguESGk9DDTgouLPiSYXzbQbHubcT7kxkuSZad
	pUeF4M6OTpTMo4mPfFRugzogTQhnX03tS+TfQCDJ5idAm7tshArNhFeFUi8dItaMGbAFTIcHQw/
	3Y/fj7kguvljG0g6KfMqpbIfoH6k+nQttDC3UeIbo=
X-Received: by 2002:a05:6512:baa:b0:5aa:74f8:72f4 with SMTP id 2adb3069b0e04-5ad46fe041bmr185686e87.32.1781636452394;
        Tue, 16 Jun 2026 12:00:52 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e124462sm3738075e87.0.2026.06.16.12.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 12:00:51 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Huzaifa Sidhpurwala <huzaifas@redhat.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH 6.1] net: gro: don't merge zcopy skbs
Date: Tue, 16 Jun 2026 22:00:36 +0000
Message-ID: <20260616220038.87364-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sabrina Dubroca <sd@queasysnail.net>

commit 4db79a322db8c97f7b73b8a347395ef4d685eb40 upstream.

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
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-46323
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
2.30.2

