Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566177;
	b=uaBogjA94efWBZHuhI0TMBoWAQbvGORqknpNYcpIBEdSqcnM8oC3mG9yklFdm3PitsGT
	 aazp6xYEE+cUX/CsWvFeGjYUYC2QrCuDYv55hBNfEZyEgoWvWXHDA5Kji5yWcvuECUlzQ
	 dvhHwplvBp8GMGowmdtvAOr50DS337GKvoiW5W2PATnldWKVXRJvVz0IoVF8Gv85HRrAa
	 ChrMMFc90bwEJ6GMB3tbW75XnkGpNUiJ1dZ5P3pIDkle+DKcUQtI1pWaJ1xz8guQGsjqJ
	 oVLpR+1M20weYcgMx9t0NF4Kn2n7Y1B6+pZlXLrfQqAsCss5fEAvXXXmc6EoEnr+ahQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c7sK3HiswYiBR3BUWinqF/pjgDocEFdhpnqkaPcX0Mw=;
	b=h9zYAhDbD5/52veHKPA2QAEsvMcTh0yKJgWLH/rp4yip3nm4B3x3tMZSobhrc3/20Ya4
	 fBkJMm/KjdDuzY62BmneF0U0vhs2Reb1nOuFEshPzOh9hSH8OYGCg/4OjqRXsR7QhQTBh
	 3Pe8/Hsrtj5cUVgYkLlu0S+JSoXga194u6spqc/pri+dA6tCoTkVLMNGb3pAAO6Hmf+Tr
	 R4y191WjHEMAYGmDmV9o1PzZhfJNm42pu+mFFdsclZf6bUnJHzbzox9G9tt4pXxaTXiV5
	 bmaPZ2ZA9F4WyjGSCZwOsVO9lyAI5NSPuPb++UkKa8LXiJgnJIq+hGa9MH8lo6MnOEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvpn.net;
	spf=pass smtp.mailfrom=openvpn.com;
	dkim=pass header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Sy0vYPk1;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8C3606A330
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 00:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E8C3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Sy0vYPk1
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso50874035e9.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1795566175; x=1796170975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c7sK3HiswYiBR3BUWinqF/pjgDocEFdhpnqkaPcX0Mw=;
        b=Sy0vYPk1cozpkelPBK5zopcg/tq/bbrII5RY5Ay9pe2Zpk7LWGfOfnDYRUnczkIhKy
         fPvbYbJoJpReRWPrgHlK1zVpJRyNYzGYCsYoCj8OExCZIiX0cGWmyDggZVw0fVe8Fq3/
         nJCDjltN3+CFgsTkasypBw+a8+bVCYCyBs6V3xpUk9BGyDIBLoM3HgJD5gN5W/f7aqqo
         pjkRj3+trg8E0sHWwEthvpagwagPkTp/w/4X5A6U1fgltC9RpRolndNy9F9axqbOU4Aj
         8P0kPii5pupVxKN+H7AbjVrJZDUX7D26KYzakQzAlo7GeGrAnqI4XzB2EGCYzlqAM6D4
         AEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795566175; x=1796170975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c7sK3HiswYiBR3BUWinqF/pjgDocEFdhpnqkaPcX0Mw=;
        b=cCe/PMjYn2KHxFmteUnibsBtdQNw9ufcyvqwpW0MK+Pmll1t/ay5cM0TtkbZqmaijR
         nIcgxUVigdfQpGSi9QE/AIN1VFEFcnCjYsXS365O1gJYE0I0Cn4wz7DnKxlegOsJPqxs
         nrY5+bSK0Ur6XKXuvXk5WdPJYFRJGsbHCGwiWePXHyzj+rPcxAR8moB1y45pHfvA4nmf
         yQkHMljSlmB/68NXRz0EYmgYYGk6Rl+blG4ZPNA0lbMzaZjScEddGKOU4mNCNs+wOW47
         ygCnyVZrLlHc4oTFUKFwQsXVv+UfpchGWabvoUXA7+S3atkTITgmGpI/rYmfdJwo5yHu
         qazA==
X-Forwarded-Encrypted: i=1; AL+hErG4SHaodDK3XHk6kH2rZ4c5Mhh7DTfsXAl0U1IGNk2QCjWZgb4hksl0U9TmN7mAec9y1FIM43M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sHKGU/blODu3QbTVzKTyGwgGXHWMvnTYtTS/TyxTHowgEDh+O
	yP/B9WbOUR2i/1vBWwvS2ctBpTzrRB4M8ylNTShl6cWVoi3KLNIw4D/avfPeLkbWGTgYfblXr1l
	Q08IhdvXiRPbLk/heBuxaZtyqyfElXPC4dAgCzUcDaBoT4LU6pZo=
X-Gm-Gg: AZFdTZePadskAqH5QM5Mk8ESdyL8c6YBFTelQzPuNoqiAhoMPcJ4qHwTrl0kN/jazq2
	Pj0FDmUlpP09KG2fmJqs9GC2sctd7F8OykNk3ICZTUgYO8+qs8Zjo9gDiQZSfAaR8ekxjHRM/mY
	7ewXi4rhEhIanN2tDTZh8T4ZSHjgm1U1ADQj9dKvpG/zPLkr4RxIiWpYQ34HRCNxoeOObi/E7KA
	sQD7wd0pkB9igOneN96UWRjbYKu+AV/bQqQ+i+ex39o0LyAX8G7auqKIrUWNM4ncLjphoWtC+XU
	FSm+LHzPKRb6wtW1GyrRPPlNLxT0wWgo/cMdK5OGFZB/dwmUAWGD5Hv4wuD3FpeaAwPxMJyQp9n
	IGsXPwE8WGjDL6AIXTQ1NQ2GjQouqLbGRf1EIcG1/hACkahbSnM5wECLBOqtdhwxqhqKLOy8Edd
	+76S18TEmZ3EPEeuCFHlETjDCeSzc9QWFGnvxOkKmYPhXSPHTWcWg7cGi/ISPc2Wmu4tW7p2Zv1
	smGMc3kYCrklSuyCPRuVbWlVgy6rDlETTtdssU3hLd0Arhnp3u5bQkyTZnSrQkGNDMWhVRBuFoe
	UcgqwKZ5RZIi/6L9PQEVEfdnAi72StnqCNZi4NeAeqooVVET1Jem
X-Received: by 2002:a05:600c:64c6:b0:4bb:6fd3:5aaa with SMTP id 5b1f17b1804b1-4bb887c30fbmr290488115e9.3.1795566175644;
        Tue, 24 Nov 2026 16:22:55 -0800 (PST)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:5c82:5cd3:7bc5:2809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm31518448f8f.16.2026.11.24.16.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 16:22:55 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net 7/7] selftests: ovpn: avoid calling freeaddrinfo() on NULL
Date: Wed, 25 Nov 2026 01:22:38 +0100
Message-ID: <20261125002239.1191542-8-antonio@openvpn.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125002239.1191542-1-antonio@openvpn.net>
References: <20261125002239.1191542-1-antonio@openvpn.net>
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

ovpn_parse_remote() always calls freeaddrinfo() on its exit path, but
result is NULL when no vpnip was passed (with or without a remote host).

POSIX does not allow passing NULL to freeaddrinfo(). glibc tolerates
it, while musl dereferences the pointer and ovpn-cli segfaults.

Only free result when getaddrinfo() actually returned a list.

Fixes: 0bd9cfebc1c9 ("selftests/net: ovpn: fix getaddrinfo memory leak in ovpn_parse_remote()")
Cc: stable@vger.kernel.org
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/ovpn-cli.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 00b80bc5157f..a6f0f6be43a7 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -1888,7 +1888,8 @@ static int ovpn_parse_remote(struct ovpn_ctx *ovpn, const char *host,
 
 	ret = 0;
 out:
-	freeaddrinfo(result);
+	if (result)
+		freeaddrinfo(result);
 	return ret;
 }
 
