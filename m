Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F442270ED7
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602773; cv=none; b=X9DBxs8shFIG+I1fT1/MN7OB0H82rteGybMThfNUexpNDD4er7xP3HWJK3dhusfrLXJX/1ija0R4Y0JbyyY9u0ItbNkwndhKfNc6/ooDDvn3fSMbHhwfMOhjqwDLi1GXlqcrFkFblwe5BzUbivDFLo7FUmrf6BhxJ/8GyqNWSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602773; c=relaxed/simple;
	bh=eXV85UOU1zgi6P7JVWPpQKScckIM/nj9u0XFq3b/aw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ix4fFq/AFmMrYzmpFLWeMt7C6KhFPSR7NdYBggdJYat9Bd6czdqkamqwHiToxkZgFl8/06pHTtOkfM1OkR0Ss0Zcf0mWFio5/69fnHLW16nShZc9F6bTmR4+lMTU1BFzHkA+oR2/ILAdbXhT1Gu3Xv6bzX+g9zbJ+QUmBoKchNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=l9Q8teU+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="l9Q8teU+"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47defd0c1c5so964073f8f.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783602770; x=1784207570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+okqiPy692T/LbXtU2xfepsNS8cELhNO3bJ/OMjed78=;
        b=l9Q8teU+3ECZbFPdCVmRdNVCRddRzcmdJsUavDS6pylE+0jI6TAUd28Ugd5B8uh4e7
         XlpZe+oauY+WqhhnWHe/3Hv/AHUSVYyyVazzBaA2E5V9LZLdirBcK4xIrDtPavAJPJer
         19mf/2S42of0sq9AcsD0YfPVseRBFp+Lx8ijoFbr+9P74h96dmW8EHZPJ447/s9lHo2e
         zkBeSs4qybOIuhDZSus1bYzRz+0eVd+fYFD/LpUgZnaoHZ2oDCTEvbDbq5oKvMAapESy
         AkHJs4CBZZMqHRqL3d7fKDMKUzzs09JPrK/e9Ln9i6lRoDYvb0BnsM5MKfZRsI4B6SZf
         oKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602770; x=1784207570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+okqiPy692T/LbXtU2xfepsNS8cELhNO3bJ/OMjed78=;
        b=VBJWetdTN92ZuWeexwYBDN+eHMz0yRXvKxH6FYCilkePcTsTnyz3pqzT8sQ44lGYAa
         63f4aZDSOr7YuSnwZDPQYx3SFxbP4V6HqHTNbYqJFojvXn/NF5eCqiVifHILdi+ExIwY
         eDNpFBVjAPlC5EdVJdQgIIdT/tKMaJNTYLZhr6nUcVrPplqVYIF8b5MOuxGqF2ZQa2kZ
         kiUgVQa4nMaV2wBwDxRgnpx7VjogGjuxXBPXVWE+jHprEFAkLpJrOcY03ZTuV2dWCbpb
         6CvoY01jplK9QZ8jbaPokQwbaKJMgTm0NGj1Caj75ou1/gCwGjejuiaNIJs7SfTn0GfA
         ZFYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rowuw1skvjjAnXSRs4fGKj0WuqMNk0V6MZWYGtk6Z3Q6loLjVzJflch3NNXke/A4zV77ZhGWb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy0uMU7flrmwdttPRLzAnZJ21P2+ZjsMN9OwbS8dv/E3Ws17uU
	3cprl3sud2c/GqkZAIADHq3ReVt4eu1hwJdk61Axw6FBRsKKmqHHFz3QpY88Bf966wfi
X-Gm-Gg: AfdE7cngRN8UyMzHKY3OtIX9XB2xA9+HON/2G6RmxYywnCbgD/1vK4sTaxJo1pSD1uv
	wKXEROyubriq+8QyNbZpraDDxwgafH2poGcv7NFAkCYJbUf/QlpkHOvIch6KCTBhi5nHYUWX7/u
	l4MCiOSLi0yOkADpRcvFZMjsf8u4wfO0tbmIFPPl1dSlRAjFcTDpdIfeo6jkPCk1L7m6xAkCn5I
	xiP8QLQHTPTbLWBCLfZj+07wCijA/a0t0uPvPJuc1lzxRF4gfjhzXoGO34wBwYb/9ugB1m8YbFV
	fEJ5+zb6DdBloxgIo5npNdfoAvnDTkDGZOxaonzkOl/7OZgda/Txl5xCxJFgc4wNjslf/jPxDZe
	lYI5BtllTXsmozemGUz9vz563iLf+/MyUtz1HXZjQzaX0cxNWcv3MOiFauo5bhm4B4flN6g5+DX
	gazjszZVcElXAxmq6Y5hOPG0O+oXYxOU3TxmJhoOL1sMy5z4SxRUzxRz0UUTzzDaDHwLqGLEPuG
	b7r5vZ6PMSpkuz/14CkvxvdfVtCPSlQhv0=
X-Received: by 2002:a05:6000:430e:b0:476:d13f:bb74 with SMTP id ffacd0b85a97d-47df07ae2e6mr7871263f8f.15.1783602769947;
        Thu, 09 Jul 2026 06:12:49 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ad21sm50243405f8f.20.2026.07.09.06.12.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Jul 2026 06:12:49 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	phoebe.buckheister@itwm.fraunhofer.de,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net] mac802154: llsec: reject frames shorter than the authentication tag
Date: Thu,  9 Jul 2026 15:12:46 +0200
Message-ID: <20260709131246.44517-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llsec_do_decrypt_auth() computes the associated-data length for the
AEAD request as

	assoclen += datalen - authlen;

where datalen is the number of bytes after the MAC header and authlen
(4, 8 or 16) is the length of the authentication tag. Nothing verifies
that the frame actually carries at least authlen payload bytes. A
secured frame whose payload is shorter than the tag makes
datalen - authlen negative; assoclen is then passed to
aead_request_set_ad() as an unsigned value close to 4 GiB, so
crypto_aead_decrypt() walks far off the end of the scatterlist that
only spans the real frame.

The frame is fully attacker-controlled and reaches this path from any
IEEE 802.15.4 peer in radio range. Reject frames whose payload is
shorter than the authentication tag before the subtraction.

Dynamically reproduced on a KASAN kernel as a general-protection-fault
in the AEAD scatterwalk, and the fix confirmed.

Fixes: 4c14a2fb5d14 ("mac802154: add llsec decryption method")
Cc: stable@vger.kernel.org
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/mac802154/llsec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 5e7cc11fab3a..364a1ac1d771 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -893,6 +893,11 @@ llsec_do_decrypt_auth(struct sk_buff *skb, const struct mac802154_llsec *sec,
 
 	sg_init_one(&sg, skb_mac_header(skb), assoclen + datalen);
 
+	if (datalen < authlen) {
+		kfree_sensitive(req);
+		return -EBADMSG;
+	}
+
 	if (!(hdr->sec.level & IEEE802154_SCF_SECLEVEL_ENC)) {
 		assoclen += datalen - authlen;
 		datalen = authlen;
-- 
2.43.0

