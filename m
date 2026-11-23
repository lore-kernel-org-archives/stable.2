Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795459108;
	b=j8Qgsc3xR0gX2LEJomTQC2uzlk20rF94l3VM+uIj77maRu3D0gQWr93TY8j1fUV+4B53
	 R45pCyFJzn4xOyVp6CYmtE47zeZFCGIJZHspfCpTr+QahWNS8UzIEGxHedC9GjzmgSa6y
	 OA9QxfH4RWx4t2rQNStbyIE/LRzZMWrPpS/FKzDigphTbQNl2Hd4fP4msmUbpD4CpiO6K
	 TFg1bTKTBtTyv6zilx29VhHUkd+3vH1pmiStMNRAnnPIKFRbnNv+J7Ro/nnIyrpzFaEN6
	 acoZ63/C+WiOM9gjv4ikbB23UDZkpVzJ5wNSDe9lv0iqxb3t46r97rBJJwIKA2MgZiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B6rT2mc8WeFdjm1vVBne2NA+OPpqByCAF69se4xF3d4=;
	b=rv1MruG7cDfZNoVLdq3adVGjMfx43m41sB62DjI/Q2b4w/mKEVh17Y5iMzWfqqZEK4Tq
	 LDWe8BEZ/MBJDYkqRiX0rgKTlQcHplfvtV69loap/dYHiLMwWQ63Y8MFgqOw18ISbYxFR
	 OV5YoUvSXPXLViyl3F1QUoRWiQ/37hH2VjOh9VKrs8vDBYbJB96O9YNXyranayBdL6Abt
	 Hwbpq9Dhc2ZZjFYs1Md4a0yxk73jkQWDLaOmxpWflZv5gKz2IvhNVYAEkc6z5Hx+RDEWd
	 LnGPlyVEpGwBGYiAth6g0AnyuaiOiJD4c5nynaLoZonA7RQgxjv9PHQAQdA3+sJRXpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YCoxV0Oz;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D1F606A32E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10D1F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YCoxV0Oz
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1ae58d17cd9so3479518c88.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 10:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795459107; x=1796063907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B6rT2mc8WeFdjm1vVBne2NA+OPpqByCAF69se4xF3d4=;
        b=YCoxV0OzkOyM2fdNuBNuyjI011Ae7t2DkkCoTkbvytolV8hQiLw+LzzO+gevKO+G5l
         /4Q2S2vsx4TifhlQB/B9D9iy01p6u9chqcGCGtqMy3/4GZ4kne38GWyO7OYnwIBo7WPF
         R64JDFXDJOUUShESgPiEncrkfPHBHPQPzHarpNKemQNRZGBp/Zd/LAIGKATbw32X0R5l
         ZsX/Ru/LzU0WueBH8WPTjE/CuiVwMlssyqxgCvQHLZUtESI3+j0N8rDf3IoKDjZvBXfJ
         t18+Af1caLBxpPU3D6ndV6P38BnMWfMpIk/FfBEkIcw3Z0Lz2p3UmBjEX8zPTl1oyVgd
         A/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795459107; x=1796063907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B6rT2mc8WeFdjm1vVBne2NA+OPpqByCAF69se4xF3d4=;
        b=ytOWEuvD6+nVZ5k/GAwl0HimAk/QLDIHhuFb6aYj1aqMZyD9csZ8NfVWa2vjkRD86Z
         n+B38yI4YvpOCYWWeEJi/SC+aG/mcsG3nTllvGaBUJAKNhKjNUPNoIhDySnyznT/zdSu
         bsb9zs4icu3qN5zHhb1qOKWYFZDKopsEsyQQVkftm9Frwe/b91mQsib1xGoQKEQiowkM
         /fU/BAHfXjVFKWE0GOloTZMx74islSXJqwLViIeWXe89twdxJavjkti4GEcz6676rxvy
         hbNuCtiAFN4UAfKrkEygBKPgT3nttUyEEGYuGZnoj5U9H369n8dMb0WfaWf+oeq7d9hE
         ixzg==
X-Forwarded-Encrypted: i=1; AL+hErE3WRyQdh2y30yiWGlrq6CH6+x3zYx3IoKy5bF7JnAbk7sxO8+ZluH4hCqU3bwEDR2le7FhQIw=@vger.kernel.org
X-Gm-Message-State: APuU4Z96hsJdrMgUbUbZt8C3iOej5WzgUHuIIukkCYOzGLamenSG4jv8
	uvPOQgqGz5PGscgTNGs3h4Jhxmpw1RIsCmxUHjw0TB8HpJ495LD8+K3v
X-Gm-Gg: AZFdTZd0AGRAivbAxrcz4v1jL+avtq9OLckZDNOM/WABWAqIUE2WQ5aUsAuHqkS84WX
	nZc+IqOwx05tt3PwmVLJm2h4tK25VM2fqDeuHkA4OS1p+MAfLaOvqTR1fbsKCK7D2k8xYxQfTIl
	V6umPQRxZSw9MOmYNgWcg8cuPxjv3JunRbZ7UYFDPxi63wuiG4cFMSzlzUHUj6U9wccJKpity69
	JpE8pKNkF1azAnwYffXt1aCVNkl9FdIQOd0wU5SWqITNxQQbfG6Q9W1GIbcoq1SpXYK/sPS70vw
	fzReYA5lR5CxOoQd9szzqBHXxgm/11MUPjVwXLEn+Agreyy0PqVjPnzjAYyjHE1PT2sObGBVmJH
	s1gUrNRznRJv9h2j+AUB5geajLDSqsdyLN7HCA9G2cdxVUJNWpCVTKy9MWNjroG/asJHhO/KjHp
	xUXAYmJe7RtrmevBrIRm6oU9FGSOUAELVa4WTnuvC5A89CAynh5/A1XhWWw57WKC7Zsvk0Gqe5+
	Hx75FVcSoqdq+M6UG/thYHwWzQKGxddyvFivqSiPsQrLSVbfQxVG/fPkCBI74Vu1LuIK1MYqOn5
	BORML3lfD9uqxqOZugnzCcv0xThbgYDuXVJP3iSPuShsOIdf2qNXsNjPIWODBXoDHRevxbqZObC
	7CN5WFbwRlERlsItdObN2urneJA==
X-Received: by 2002:a05:701b:2604:b0:1a3:dbb2:478a with SMTP id a92af1059eb24-1b5568b9037mr12781657c88.27.1795459106853;
        Mon, 23 Nov 2026 10:38:26 -0800 (PST)
Received: from ip-192-168-31-150.ap-south-1.compute.internal ([2409:40d2:2011:872e:6565:a2df:e6e1:88c7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567e2bd1sm28875720c88.3.2026.11.23.10.38.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 10:38:26 -0800 (PST)
From: Tanuj Sharma <ertanuj96@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: gregkh@linuxfoundation.org,
	netdev@vger.kernel.org,
	linux-hams@vger.kernel.org,
	stable@vger.kernel.org,
	ralf@linux-mips.org,
	horms@kernel.org
Subject: [PATCH] net: rose: fix OOB read in CCITT facility parsing
Date: Tue, 24 Nov 2026 00:08:18 +0530
Message-ID: <20261123183818.24508-1-ertanuj96@gmail.com>
X-Mailer: git-send-email 2.56.1
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

In rose_parse_ccitt(), the 0xC0 (variable-length) case validates that
len >= 2 and that the length field l is in range [10, 20], but does not
check that the remaining buffer can actually hold l + 2 bytes before
performing memcpy operations at offsets p+7 and p+12.

With a short facilities field (e.g. 2 bytes) and l=10, the memcpy calls
read up to 15 bytes past the buffer, leaking adjacent heap data into
the facilities struct. This data is then copied to the socket and can be
read by userspace via getsockname()/getpeername().

Add the same bounds check that rose_parse_national() already uses for
its own 0xC0 case: if (len < 2 + l) return -1.

This code was removed from mainline by commit dd8d4bc28ad72 but remains
in the 6.12 LTS branch and all prior LTS branches.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tanuj Sharma <ertanuj96@gmail.com>
---
 net/rose/rose_subr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rose/rose_subr.c b/net/rose/rose_subr.c
index XXXXXXX..XXXXXXX 100644
--- a/net/rose/rose_subr.c
+++ b/net/rose/rose_subr.c
@@ -369,6 +369,8 @@ static int rose_parse_ccitt(unsigned char *p,
 			/* Prevent overflows*/
 			if (l < 10 || l > 20)
 				return -1;
+			if (len < 2 + l)
+				return -1;

 			if (*p == FAC_CCITT_DEST_NSAP) {
 				memcpy(&facilities->source_addr, p + 7, ROSE_ADDR_LEN);
--
2.43.0
