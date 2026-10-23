Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785194;
	b=B/igq7kwfs19VDTJFhGV2820X86+K2Ctpi8pblJdFUhf3p9hP3nRQAqbYK/PhKclw19J
	 a6QWuc8Woe1cVwZja9IATOqCcWEBvIunUJQkinaMEOb+648Zb07KTxLs2uX0zhSn63t7H
	 lDSbZwklptNFKlPh4KG7SrfX4+QrA5HgxPzUw60MpgiFuxTGBTxHQRNs0rR/lctdictb3
	 iJhf+OlwrrJbqA+rExYGrGOyYJqJ9oXOePoVaMFOQuVxB/yc/i8aPlDwpImnUpW/v+gWT
	 R44mUC6g5O3oJx62GtPfFwyex7ttw08Bba2PSDvmQE/Tz7vO274iCGg1djHIIlAjocg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MYMvGahXwl+NkKbqUxWpkDAanrsDHqw5aIx8j0gxjPs=;
	b=jCDYIxEPCiyXmABLy1s14aKpX7L9YPWE1swAhZXGEv1h/sd+wqUNtJn8WijraN4EKrm8
	 /41JRkE2sBH27XiohaQMdf4qeoKixPmXMzua8tnlRnVRteV4JWOH8SGp4/goMLCxpig+y
	 0Xx/45q9ifdgXjBEwgKGWlbxB39oH2U9A4FDwJT/3MS4ITLzjBIEFd5uQyyPocljqLZk2
	 6jRQbaEevA4sAdKsbYtYEsscyG1/8iV0eJwUiLGCeH2IICnlZ/w1KJuT05vu+Q9xQVfuF
	 4AOl9l2Qft8DpOP7R/88ooc1qvi74PbVf9w/al3cOlzH0QjX0RCtWXoe43oxlQ3DALw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SNymd6a1;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8272606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 19:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8272606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SNymd6a1
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso766917f8f.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 12:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792785192; x=1793389992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MYMvGahXwl+NkKbqUxWpkDAanrsDHqw5aIx8j0gxjPs=;
        b=SNymd6a1wWN4/3R20ghV9hJHANXsMHNZSjpLs7ikUYUtr6b9oz82iVM8+eYTK/D3vU
         IGsAk8eCbL0wRGWa2VkqZqGYenDcQblbEh7NY5P5CnCrzU0GVQJd8GQdSa9LiNUopKf4
         H+smT8EN7qxVHmRrLBcf8NQKwog626n7OpXx7vMBHc3nJNf4Ek+rT6LmoMS5Z1OSQAkX
         /vhr8qGpafrpNzpFK/lC3P8bxKvBmvsJGKTJoKns+JWDQ7uGfMcy3Ble1kF/ytdKyupE
         4LNMEbbDLPq2dsN94uKUpxZoySsaQkttM4MnXwwrNGH90oR3nHt597WX+Ij+22CRbRl2
         pKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785192; x=1793389992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MYMvGahXwl+NkKbqUxWpkDAanrsDHqw5aIx8j0gxjPs=;
        b=d7wKqM4N9WDYJszulzhv2wd79BxCAQA7bzoRXnqZXoyNvjrPpdoZKlBpgFi6dyofQR
         GXfTBkbdOCLDuwBSrlT/dnWXyosEHVE4mQWUc5wtiGzOuGPpzErz/vbk+jjsMw1e+BPE
         GKzBL8L5cJ+q9X32HRjubtiJMcK+W0d0C7nvXdViAWcp/+VqNSclhydmrMalAKp2VwGS
         v/BcxnWkbpATL1B/S5yB8DNzkdZoMF5pMUGT34aZ3Tz3rArf4bkFtIn34+/PG+kpzwW+
         ddJuumM+qtyxupFFSPC8a8+RgZsDdn8srzr4eBVvTUY8O2aVl1XW6tTZFfnXobpDSirm
         /R+g==
X-Forwarded-Encrypted: i=1; AKwUvBzvsha0FnbivIOygugWuDiidy1GiTmt7G9WIiVJ4h6Q1NVWBR8kC3dPrsNOkQe07QYX85W8Wgc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFxQhyV72BjF7EK3vwfZ4gi7zTbkIysxvECiphjTvEPBkdLXj0
	s1+3d/5UKwtq3LZctilekXB7r+zyY06Rxx1lM0xJH3QcY5sGIghCsVg=
X-Gm-Gg: AYBFou1zwIicG0+TVMD6MS0C2i79A/YPf6K/l7SaBVS4KCiFufwf0mC42p6W/bMcyhp
	i/Ha+yN+SDAuHXGwxVgjKm0uyk36z+Aa5VfKXuyABkBVwC1suaL3aBoMFIt8oOEDKzTUVVDavbE
	trnkEkCzy4yIOstWx2HXpz198kdSy63i4cStQJRie76oXOSS2RUmRWIgfp9bVD8TfCEBLozRVCo
	V07MHaPHmYffZscRnZSw2rmNYQkHqJVeNioDaRAbATaz8OKtLYhYeOBk2VvczosXftA671HKnMU
	0RpVmpaHpnkUHHu4y0k0vXLft6bfWU3/xjeZkGZXPP0vjzGFhteVGJBIcF67G9uWMIpNwFssnbg
	tnp8VGXY7V+pVi5OUu6di4AL61jzIxwbHlJLFyeRlKz7fqSGCGDlD8Wa8RLDC82lzcGa1KGnToS
	FB/NONv285tSAZoS35Xm/OZgyXXRXt0ME7IFrxw3lDlFCG8LNuT3MY6lWd0TPlu04eugoLiKcpm
	/C2SBX4+liOvwbQStRiH2uICA==
X-Received: by 2002:a05:600c:19d4:b0:4a3:5a42:b29c with SMTP id 5b1f17b1804b1-4a35a42b345mr2557955e9.26.1792785192118;
        Fri, 23 Oct 2026 12:53:12 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359fc1207sm4434875e9.1.2026.10.23.12.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:53:11 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Qingfang Deng <qingfang.deng@linux.dev>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net] ppp: fix stale pointer access after pskb_may_pull in ppp_ccp_peek
Date: Fri, 23 Oct 2026 19:53:09 +0000
Message-ID: <20261023195309.3527129-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

ppp_ccp_peek() caches a pointer to skb->data in dp after the first
pskb_may_pull(), then uses dp after a second pskb_may_pull(skb, len + 2)
in the CCP_CONFACK handler. If the second pull triggers
pskb_expand_head() due to a cloned skb or frag linearization,
skb->head is freed and reallocated, leaving dp stale.

The stale dp is subsequently used in CCP_OPT_LENGTH() and passed to
decomp_init()/comp_init() which read from the freed memory.

Re-derive dp from skb->data after the second pskb_may_pull.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/ppp/ppp_generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 1a610a18893ba..3998ce4332f42 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -3157,6 +3157,7 @@ ppp_ccp_peek(struct ppp *ppp, struct sk_buff *skb, int inbound)
 		len = CCP_LENGTH(dp);
 		if (!pskb_may_pull(skb, len + 2))
 			return;		/* too short */
+		dp = skb->data + 2;
 		dp += CCP_HDRLEN;
 		len -= CCP_HDRLEN;
 		if (len < CCP_OPT_MINLEN || len < CCP_OPT_LENGTH(dp))
-- 
2.47.3

