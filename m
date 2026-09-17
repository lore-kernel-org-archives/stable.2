Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A542EEE91
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629770; cv=none; b=mLnGBJ46Iq1+DjDx0pnJWMFi1uy00H3td4J2xgAW+/bBP+XdraOtwj/iVub2LyrWkNoCS50MvyLKQ9d0jmGpicptQNrDKABIMWkm4MXkwXPR/M3nHh5JeNDSvwMKCgaPJWQFv9VWRQ1SCVZuF1cPf6S4pAQ0Tq8qo9PzSfV3410=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629770; c=relaxed/simple;
	bh=cYbK+iFcA/rHB+b8Sla87g88LXLMoRAm5V1nqvPUbZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=micHIA/td3jIg+kodECIzrHyqB6n1dAECmVerGzmP6ZUCxuyQxG/HcCoHK/UeFu5jDD57ZFcBZfM4n6ajpUhm0d313EVeZVM83hINB5G+TtfBOXyxzfO6vFJ9OcWQFSjVS2G1i6olnd0zQ/RNk6ylR8BV35I1qgtlyrDttujtLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jl7Qevi0; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl7Qevi0"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc42c773d05so28234a12.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 00:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789629767; x=1790234567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LEz5AHj50hXRMoOhzaQCHtJ4fdUwgfjyyc+kMNRjsig=;
        b=jl7Qevi0ZZA6Yuhq1qJ/n4RadUjYtKfXsiMwDOTDg1rsxka5X7JJfsk/RzpAT3mvXS
         ZLEj8YMBAK7PrulF5VFq2FMV1GqR8PXhRVcLunqrwRj2VN5/4qB2294RmPNy7KUSVdEm
         Jw7HU5LoIHRWk1SugUPLdfgYCXHhBWEi6TujTRMaNnBSBn2I+85i+ayb5ml9utjkYutb
         kWD59fYSg8MvYK0nibKkn2zgCtazNPubWiMAcSomvmackn0n2WD90/fxy49jXf9ASSnU
         HsStYYx51EoQDhPUr0PWuqG5fvvDe23bcLxrQz4EgMoLfJBmLJ1Wlpl3nTGBg/vmZKzh
         CMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789629767; x=1790234567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LEz5AHj50hXRMoOhzaQCHtJ4fdUwgfjyyc+kMNRjsig=;
        b=knWSX0L+4Ke34CQOLC4lEM8Ys2eGqrWv4wN0Sn2ebdOdQyjriw4dg9feEsxB1EdEZj
         vIGddb/R1pKTb161jH2v3w2cQg+oyD3Mv8Y3St27eU6Ox1IBDQ3208o8nXgHzI0gPU9E
         cYr9mdEfph775TMYsP3Fa+F7UkZB4Gt+IV81dzhOk64iUJ3u34zDbEr9a1p2JwcplvlO
         nO/S+OqTxxwJ8OYDBFLntRFw7p8rP1aAUgjRcfxQBkOmAuU0uLd6a+K1NBZaEk39Fa82
         ejeuC+eipHD9p6c1ifme7rD8uahos40i2UGnvqHfwFBVuJAhIe5Js6k5hWvKN2jdi7+r
         EHXg==
X-Forwarded-Encrypted: i=1; AKwUvBy2u9LPfxAJXM9piwhlA9vQ2XVb+qf8oI/JbF75iS86IiL1zjTVHnBJ1jyuOWYM4PWOvdRMMg8=@vger.kernel.org
X-Gm-Message-State: AFuF++m6enNWDPFwv2Kzzs6oPsX1HBeS9HO39MqXztcbbQnc/zfbVAvi
	bSXXukCx3cL9B0bhVtw7J176i4uw4O7TwYygNEtQRUrQzc4wIlFdAtTh
X-Gm-Gg: AYBFou2hvD+948PyDu7ETSig0MQVkR3bAWDOeepmRCF0lG0fBCugNMTrqYtPo6mlwdv
	mSmtCHYsoYE3Jyfhhsa0531E/q9WZASI9ZmfyUT6b9J+xNB7bI2jR2e+7t0J+0YpvWtXF5HZPc1
	K8j/eVBpyx2JdWxg2bP38ERmM7J2Awrsh4HXle9ml0VLKrktoIdA31wQOItyvt5Cn+wZ++rSX+f
	74yRfJDvTLBiK0K41PUfyNGKztbENZYMhwZCbVGgrz7RavouyCClpbqVJlGztXlNnqilFwEEd1t
	J1q9ldkCH3Gdwvhj+tla+N360ySaffoAQRJUXa7E6QpBHnNLdLr7HUXEgWgE2NpyAl35L58coSM
	HYsbh9ShvXG06sH4YZfRGhqL9QD/VWAkjI6mW0eLJz7TkAn8ud5AaLcdDvqHnjd73zNLtoIc3xr
	w5GbtY0qPqkGMYkOkGdNDXzuYo3gczhypyBjTYYWVq8Dvz30Xa2JRHSUNN1Q72ksY7JVJqezYAy
	W4JgTq1fVvYWkgooKZoXktNJett/iK96/arN2f5EOaJnRx3XKVV7wMAwasK8g==
X-Received: by 2002:a05:6a00:7110:b0:871:3a50:638f with SMTP id d2e1a72fcca58-872367ed514mr5780054b3a.1.1789629766747;
        Thu, 17 Sep 2026 00:22:46 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87200d4cb44sm2463091b3a.13.2026.09.17.00.22.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 00:22:46 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	Qihang <q.h.hack.winter@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] xfrm: validate ihl in xfrm4_transport_output()
Date: Thu, 17 Sep 2026 15:22:26 +0800
Message-ID: <20260917072226.80788-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrm4_transport_output() reads the IPv4 header length (ihl) from the
packet and uses it for __skb_pull() and memmove() without checking it
against skb->len, so a frame with ihl * 4 > skb->len underflows skb->len
to a huge value.

Packets injected into an xfrm interface (e.g. AF_PACKET on an xfrmi
device) reach xfrm output without the pskb_may_pull(ihl * 4) check that
ip_rcv_core() applies to received traffic.  The underflowed length then
flows into esp_output() and the crypto scatterlist setup, where every
length in the underflow window ends in a fatal fault (BUG_ON in
__skb_to_sgvec(), or a wild scatterlist access in the crypto layer).
This is a deterministic local denial of service reachable by an
unprivileged user through a user and network namespace.

xfrm6_transport_output() bounds the header length via
xfrm6_hdr_offset() and the IPv4 tunnel/BEET paths use the constant
XFRM_MODE_SKB_CB(skb)->ihl; only IPv4 transport uses the live,
unvalidated value.  Reject the packet when ihl exceeds skb->len.

Fixes: b59f45d0b2878 ("[IPSEC] xfrm: Abstract out encapsulation modes")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/xfrm/xfrm_output.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -66,6 +66,9 @@ static int xfrm4_transport_output(struct xfrm_state *x, struct sk_buff *skb)
 	struct iphdr *iph = ip_hdr(skb);
 	int ihl = iph->ihl * 4;
 
+	if (ihl > skb->len)
+		return -EINVAL;
+
 	if (!skb->inner_protocol)
 		skb_set_inner_transport_header(skb,
 					       skb_transport_offset(skb));
-- 
2.46.0

