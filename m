Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401653B6C18
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 05:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095017; cv=none; b=bzyIEQ7+lLcMfNG7ntXdOdAyO/+gsbhdI9c3WV8BFkqLNLgkCVjfdxR0OOEBQoScrLUwpVZhwYWiVsP4y+J399JtXg/+dMKQ/5AeXfdXKvoYQ/OlqV4xsACZYqxRCXsMQNIHdu7mBCyrLHNt1Xz6TdUnhT1GGiRls0mBiK9OYBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095017; c=relaxed/simple;
	bh=mOnwR/pIE5XzBsYGILop0yuiJAAjA0tbnoT2QDJFZ1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSjueI1mWJBsKJ/aqUgNsadMcaV3+uUF6J2S/j06nqFx42z9KHdC7yDP8mNwkchYH0oOE58PtkYsBpK6Qzo8KPYWTpypMqgg8G8vUX/20HlSu5CA14U/vDsYqXpG0sHk/RRB95z1TfJxkXvVtu2gU2/YV2d1bP06dYb5TKBGADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=T5zrB1p9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="T5zrB1p9"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-474560436c3so1251604f8f.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 22:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784095012; x=1784699812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZAOalb6etao4htQR6eohIIXgH1RFAxhgVjEFqDvisp4=;
        b=T5zrB1p9pSYg+XFfJLafCx2fFJHA3XWy+nVqPanzh+7SZpeZ1g2Lor7bUtUXp+8bk6
         uT5IAAziQJwUND2o0ilr1l/A+rI4Nh+F2tnbFO/os1hdR6FsBbcKbAL75cAb0NpSA7u5
         HbozE0ZGCBmtf84OzKBBjIJqpvoT9ZaiQ78Uv5wg21pEgmbQloVm90ysZpZv0Wl5Bl7I
         U5Li44VPWMEmmJMokJbicgk9e3mTeDoZ2T2zTBLOXtObgOaeMY/npLdW4wWj41kt1q5y
         W4JnMMtvt4pcLJxm5HtFouO/8RPbXz4hd9DOevIECH6z0Nn8ehQrG8ITC8FCr5uGufCN
         7w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784095012; x=1784699812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZAOalb6etao4htQR6eohIIXgH1RFAxhgVjEFqDvisp4=;
        b=eAKi07HiEZ7e7UMUjwvQQwyQpwm+mgLBDUbE5gFmktareY1x2LWuXPJpouRrOasEEO
         288GFrtjJWu1apICjKKwo9fWghqcmz6ikwJDiaZPlVmCAqozJm5ReSpVfA14eyRAiU7h
         WqIdVYbd+aHzeCSH6sUxfs40y+pBjWmD7WC6lvR6yGRy2dBAoQqRYwoOQ3yNI7zrvLeY
         GIDrYsL0gFfwu15CkfP68ovK9bfFT4b4q8R1bmO7OEoXbc/EKJiIXqcq/hcNIErGTyAG
         DgzErlbJvbV02R2pvOUeGm1GAU8XxHqRznknmCHMp/Z2mroRcGNWimbtjCRXKLwTNSo1
         j4aA==
X-Forwarded-Encrypted: i=1; AHgh+RpYv1rFP+efzIMUajYCg+G/Gn+paNkuq8xi9ZvH2w3MIa4YFaMqQUdhp2QgRvYIj5L0ymTAi48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3PPhNsHSliBvco99knw8WxJ8ecLICymqDQMEdwz6hJEnGy3SH
	15tgxss2x5kGYraTriRl8bF0ZKYcP3UpQXTNpceiBxNKdGaCdG+7h40/g0aNB8EQB4oU
X-Gm-Gg: AfdE7ckP31uii04Q8ZaDB8iuoy6aPiTyvyyyMxCOmWsqXdCXKWk57IBiDgo0Peee7+s
	1mDreZNk+Wr8iSIVt3fnbgjkTDQCvnPEfGbEqqkB2ByYKeWmkM0tvIfohW3z1LeyAMyj98UhuzF
	aJBcpqa6fUF8BIIQnJj3AVF4OMn+EcZb3QkVCJKRF0tVEfipjndMWYDoFXF2bYvMFCNBA1UDzlu
	W4g1Ay7Yb0HqS0IdYatlOe9NEXPKyVV8RN6xpPjZ+rnQjAi8O03Yav5+AtZlCjvvNZ4sFx3k8Ti
	YETGl6u/gJMbuoBLvvLgHttkYTtuTIYs4FRhYYCNQDMa2PmxSk/Bh2CGDQAw/lqHl9PoKIesvjR
	GRFzLY9uecsBmLPijGhWxMT20isesnLHuRc+CLLa0SE/26WKh0QJYx9yzkntpIly1eHXzIMlzWB
	hVW/VfuX+DnAGyR3Npcttkhi77H6hJV1sxGFa48KvCq5zrpoTksheV1J48w5tJ2cv11c9dVCUDo
	+x5DfUzQpoA11PAKYgWrq6HLFG4HUlOzzA=
X-Received: by 2002:a5d:5d12:0:b0:472:4861:5d4d with SMTP id ffacd0b85a97d-47f2dcc35e6mr17464772f8f.23.1784095012002;
        Tue, 14 Jul 2026 22:56:52 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635082csm14220369f8f.7.2026.07.14.22.56.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 22:56:51 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: sd@queasysnail.net,
	linville@tuxdriver.com,
	mschiffer@universe-factory.net,
	maoyixie.tju@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] vxlan: require CAP_NET_ADMIN in the device netns for changelink
Date: Wed, 15 Jul 2026 07:56:47 +0200
Message-ID: <20260715055648.33060-2-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715055648.33060-1-doruk@0sec.ai>
References: <20260715055648.33060-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tunnel changelink() operates on at most two netns, dev_net(dev) and
the sticky underlay netns vxlan->net. They differ once the device is
created in or moved to a netns other than the one the request runs in.
The rtnl changelink path checks CAP_NET_ADMIN only against dev_net(dev),
so a caller privileged there but not in vxlan->net can rewrite a vxlan
device whose underlay lives in vxlan->net.

vxlan_changelink() validates and applies the new configuration against
vxlan->net (vxlan_config_validate(vxlan->net, ...)) and can reopen the
underlay socket in that netns, so the same reasoning as the tunnel
changelink series applies here.

Gate vxlan_changelink() with rtnl_dev_link_net_capable(), at the top of
the op before any attribute is parsed, matching ipgre_changelink() and
the rest of the "require CAP_NET_ADMIN in the device netns for
changelink" series.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: 889ce937c98f ("vxlan: correctly set vxlan->net when creating the device in a netns")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/vxlan/vxlan_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 67c367cc5662..d834a4865aec 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4421,6 +4421,9 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct vxlan_rdst *dst;
 	int err;
 
+	if (!rtnl_dev_link_net_capable(dev, vxlan->net))
+		return -EPERM;
+
 	dst = &vxlan->default_dst;
 	err = vxlan_nl2conf(tb, data, dev, &conf, true, extack);
 	if (err)
-- 
2.43.0

