Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C900F33F5A8
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067940; cv=none; b=U/PDKizicxG3wm8n8nMWKAvkY25U0IjWKHq1x9YrYDpYpHRLnodb+M82eW65KyQOMyzBTi+ct0x8XzSG33l9IrExfKD/i4BDkUMA7Jq9rfxvMsfew9AnmZ9YxdmuAf3ANLHbOentS5w0ehZkwGKqP3xePuq+XKhPZbmcuqRl3xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067940; c=relaxed/simple;
	bh=2Mw4C8cP0ikdSYP87ULxE42c8XBOd2yv7kzUvLAoAOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjUL3sCMgJ64gNNKmdeg+1xuDni0KUtDP5Gz4fkewKZxywl1ZdNVrE5W2ZcaVC5tupx1RCGRGdZLAUEcasHlfvZOmubj9DVj1kFUjgadEQFz2Lq63hpfFhVmsX+t1S08e9rVtbVfGUkZOt+5/fz6VbPkDVXGKPNoBJPN8SgY3d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Di6ZMyIH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Di6ZMyIH"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ca64989e64so2985485ad.2
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783067938; x=1783672738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S9S390maFuLWYl6z3JcBWyDaB6H00jCR0tOf9HccGvs=;
        b=Di6ZMyIH8ltZYvdBkB8JanOcWS5t64BqqK1pGO7MhaI30a7OkWCZbuwU9H0EM8wUXq
         zX7Hsg3p1l+RYBkuOf91Q13Z3I7q2Z6hbyov7Yw66YELd05K6gFH2KJLr2e9cjZYPa0/
         AkNTpGRSbpRftEa2ixMQCaagKvcXTmvj35M/iW9YZyjxHsMXeRNLjI5LoqwAuNyGbQmC
         gkpPGbiRYDlKZMx0TEHRBdwsudeGzXp3JFAiVQw2BBCVrf+SWFdc7w/u9QVBlRgKehrA
         16b56Ec/PX1ty+VM3NFT34HSGBPoBQrhd6c9gqGcpXv6GlV3nIdvtkxwKda6nc/AYdOm
         WS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783067938; x=1783672738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9S390maFuLWYl6z3JcBWyDaB6H00jCR0tOf9HccGvs=;
        b=VonpBWuqtxsS9j9V5QRNFDek4S9dbMQ1hmr9pVrF7LbY+RWdDgqzZwNzqsfSB9iWVj
         FxKlopDYLFepNwYwQrnmUVHU0xl/p2Ro5ayJTbuA03xciUxfubxCjX93PgcQTx7UGM7A
         TDQ2Vcars0wy3XjEMaJB4NZbquFfaslkh4kA8XxyQJCfe2qO8ODXD/5YYUrxxHC7M+1/
         z8X+8a/qsDRHs+iBSMo29RCUXGC4gEuf2QoQ0TCocmfshISylAElkfhKHF+epFy3yDdh
         wZH2DFRT2zG7Uk6fJlydttPOdc38NDVCQljp7p2PTnT3WlJioduCdPr9GcxL17v/dRUD
         vr2g==
X-Forwarded-Encrypted: i=1; AHgh+RqO6g4ITdn22r3EHmJwYEZgd44j9icu2jVYklh3Haa/CL+hFzheehzq9DUUT3xQnZ55UZfxaJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrDaLSrxNjobW10bkCJjn8s3c8sCn6jInUWMLPChrmfJJzjMzi
	cCn4xJPJqtNWzbKlPq3CDjHHzbvdcIfClNxQ14flBvawnUX7CBWEWI2A
X-Gm-Gg: AfdE7ckElKCGKW9dhaHC9TB1zhLDdIDtqqwJ7H1iqQtI3IsgHnozInYU/nK1OK6ISEk
	VuTUkmZFdmCt6s0TvGDMSJx4m523Wv8mcMfJ03zQTJw5N3jNDI8wQ47nOgakZFiM/T5n6EgB8QU
	vm3VKE+o5PbhBlhAs2Ck4H5etnInRNsQ1HjFZYyUpftyF1WblFvL9eMZUx5vE1PWT12KLTJMYjd
	OqATp7lInuHv5EH3RE6wR85LgK/QI9zD+VTBDFGSyPwtGQ8FtzZ5T9YVa77+5xm0DrZWm8RZeAq
	pyDcj+yqtCwGK/6Texd3NrZpzprEQTMYhOTycR7Aop/LwCmiF3j26kGoF2K40HzEAt0EJNu9Go/
	EyRaewC9r+Q3Ow3xsq4WuMXWNH373aO/ZFd6ICwH+cOsMy0ln9pFA9lmb1Bs6hJSde7woTINP4Y
	KKhfHN2dt/LLvDECd40UwgHqAQ
X-Received: by 2002:a17:902:ef07:b0:2c9:b1ed:eb5d with SMTP id d9443c01a7336-2ca7e8ebde3mr113691185ad.47.1783067937746;
        Fri, 03 Jul 2026 01:38:57 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f23061sm5954145ad.5.2026.07.03.01.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 01:38:57 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] macsec: don't read an unset MAC header in macsec_encrypt()
Date: Fri,  3 Jul 2026 17:36:33 +0900
Message-ID: <20260703083634.2035145-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
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
---
 drivers/net/macsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index fb009120a924..dd89282f0179 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -646,7 +646,7 @@ static struct sk_buff *macsec_encrypt(struct sk_buff *skb,
 	}
 
 	unprotected_len = skb->len;
-	eth = eth_hdr(skb);
+	eth = skb_eth_hdr(skb);
 	sci_present = macsec_send_sci(secy);
 	hh = skb_push(skb, macsec_extra_len(sci_present));
 	memmove(hh, eth, 2 * ETH_ALEN);
-- 
2.54.0

