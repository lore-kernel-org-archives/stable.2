Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B775E34DCE4
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784677304; cv=none; b=DH48XMUOW3EnGN6RLSPkLJitHyaATZ+NtlbYktoggh3AxKNWzSXct0qpBtLOCKb+/MvWNv4yqEwX9smMGDTOrN+1SCQimaYrl6hqF6NRaMdyjMQHcQoerpNhbx3Jc+JhAkazorLaDSpr58KxLzRz1WBNbiP48prTyMl1Uls5fWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784677304; c=relaxed/simple;
	bh=uJw/j7XXAIX+37l+sRNWuyCP9Qw++QDGzi0pU1m5OpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNy0lNPpGWnUsSuRqUzVQSjXTe6SX9OxIbmvp7EujtwBmOcAi7oFSwOvp15Y6+TAeH+PvcN41Oj2Lbh6xzdZSXPYo55fASZGtQe5LsCCHxfj1N/5wQvY17bqtM0GFe4783itc1llIX9B49xgMfOsQmBPbcL6CnYFP+rQhJ5ZumU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fezMharW; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fezMharW"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso8178661a12.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 16:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784677302; x=1785282102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r6dWzaVGKWGEEGUN1y0cZ5+QPx/NLUXjn6OIbSQi+UI=;
        b=fezMharWZuC438K4v4+FdXicKdhRCvHK5nCxZysgW5/B5xPXmi/jKt6UiMW3poO7Eb
         +xlYwFL6Uey622+m7pT3HzED//xFbyNYCAUldvt0NCEYiKXapDAtIm2eQjzyQlFaFohB
         LmTkFVXCFb9Q5yVlPzXIZjzoOg3+GSNEnRiUwd11ldraPWuST1UTMlSwPCt1xMHnPjFE
         jXUwRCXH6SXp+Xo1S0Mr5br0vCFke9M0Y5xN2bpqB9/WTDzORbWSVP+YMzfZ9A6YZFtn
         cKd0VoJnC+QtpRyrzwAYScACsAG0OkUyhGRk/+UTnnTKNmxBoKIvcU9kfPGw+sLqQQpH
         HlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784677302; x=1785282102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r6dWzaVGKWGEEGUN1y0cZ5+QPx/NLUXjn6OIbSQi+UI=;
        b=G/yqOHkjTeICyEtm/jMpmmedfDCBHob68bE6jWcpdFM3sULCt6s3k5ccC8YKx8wdLq
         MifOFZAZbkMUKYH0cOaUemE7uYq3xQsxqmzMJguoTLF6yW5n2n8v60K/bh104L637CWP
         c814lfHkENtPWi1ojB0AH7TgHvOwUJj4iQLQDuov6mAPGPWNwQu12joAqqEvNAHQS0va
         CiqeywB4n7qrBjxftcqqb0c80qn/CYFwPeh/t2Sc7+R6USVZtrxToHxbapAgWDfKntjo
         5eKYeIlhIwOfDubSkmrJqy7LQ1Asm3etRDOo9Jsod31NNEchMsba2FeOkG2MLzzi1gqg
         uhfg==
X-Gm-Message-State: AOJu0YxOWmqkBZ/Rkzqvoh+dhPVUvrdIovuQIPOwfyk7M6jhElpX/fNj
	i4MMBx3X9yRVFFRjwxf8D1X4Jj+IhVEED/uJ2nuIdKLZK1bHno65Q1OQhBFPb9vEqU0=
X-Gm-Gg: AR+sD13Y4FIG5kPuSPhgswQ1pkp0c04UKPORj1qaOuJQhgdVuq4quubfL+vm5MkvrXU
	V48AKMQqotn1L/94wiYvEQ2WajB6mvP/BMuR9uFsky2aTxysOgrV/NpptY4mvfPVQ97RUd7iEDf
	1hna6VH7NKSZ+8pVRPloUi0QV7DhYShT/CoqtpGxbTrnkF7P/Sow1CulPnN6NGFicAdFea9qCfy
	gaPBRgHjtBgdzsMAVZ5LxUHTiZlVsg9QrSIEBcjH3KpNmOqByB/v14ZfTUJsVLzSde1avzeWUJo
	2PKcihQftDecQ1bBU7mlTBa41iA/OqoUtFHJHcYV32iiHky/wNW2uJ3vITQCRJGnTeKSIP2N13m
	5jYqzw4e2m0EkxMML5FBx8y9JwTzcXdwNy9ZC65kumxKVG/vDIFzBtKqoyslLGD2zYEYnaGzvKg
	VOOPEmn9ugXPpZMA==
X-Received: by 2002:a05:6a00:ac3:b0:82f:38df:681c with SMTP id d2e1a72fcca58-84c293053b0mr20729793b3a.6.1784677297318;
        Tue, 21 Jul 2026 16:41:37 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17604a46sm375928b3a.60.2026.07.21.16.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:41:36 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] macsec: don't read an unset MAC header in macsec_encrypt()
Date: Wed, 22 Jul 2026 08:40:44 +0900
Message-ID: <20260721234044.3472868-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026072122-whinny-gravel-daab@gregkh>
References: <2026072122-whinny-gravel-daab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

macsec_encrypt() reads the Ethernet header via eth_hdr(skb)
(skb->head + skb->mac_header) to memmove() the 12 source/destination MAC
bytes forward and make room for the SecTAG.

On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
reaches the macsec ndo_start_xmit() with the MAC header unset, so
eth_hdr(skb) resolves to skb->head + (u16)~0 and the read is out of
bounds: a 12-byte heap over-read that is also emitted on the wire as the
frame's outer source/destination MAC. KASAN reports a slab-out-of-bounds
read in macsec_start_xmit() on 6.0; on current mainline a CONFIG_DEBUG_NET
build flags it as an unset mac header in skb_mac_header().

On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), added
by commit 96cc4b69581d ("macvlan: do not assume mac_header is set in
macvlan_broadcast()") for exactly this purpose.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/20260703083634.2035145-1-4ncienth@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit f5089008f90c0a7c5520dff3934e0af00adf322d)
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 drivers/net/macsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 011665c81f15..2ec0ccae7fd8 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -662,7 +662,7 @@ static struct sk_buff *macsec_encrypt(struct sk_buff *skb,
 	}
 
 	unprotected_len = skb->len;
-	eth = eth_hdr(skb);
+	eth = skb_eth_hdr(skb);
 	sci_present = send_sci(secy);
 	hh = skb_push(skb, macsec_extra_len(sci_present));
 	memmove(hh, eth, 2 * ETH_ALEN);
-- 
2.54.0

