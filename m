Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072D63B2FED
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676659; cv=none; b=sPK9mZR6Iy0NAmWzsb20Gnya83Sb0yd3dcmAQxpCUT9cqn57l+oA9TUgDXgwtmOAP7epLoPpobkX84U+hXQlpA+/5BTbKtTRqtBBkk5dAQoRVvUlXoHW8Z+tVWqk9QhNEWxhcJw0fSHWYMjz3+xRkvZD4yf9CfNWAoY71PV/V9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676659; c=relaxed/simple;
	bh=oJAtrOLVtF+GBmtQGqaY9bBzbr0/iVZWQUsi/oY1hhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AG3N+sRqBWdmrSM/IHDOXd3pR8pIiL3oSArIe+28+DQDs0mVeZUm8or9H8gEzyxl13CDKy2wHdscsiU6CG4P3ElVwO6fqu/NwE5MNx4xiB+hA7lpN4UZb/Yot4ZlxslaWIqi1gj76gIL60qfGB0QTGnXBfdgzLZCu3ELJBhTy7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=L1dNSXLd; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="L1dNSXLd"
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 73A8D3F60E
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 06:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781676656;
	bh=yYyjbUwTbz5kYjrY+YDLT8Sq9O45djIje08c44tj+s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=L1dNSXLdhygcRMn7A9AblErsG9ZIB//1tFzNasW3PyXsr0MPvoj0xX4nPdaK88C0U
	 OCU35XLLR1R3HJ0CKUZfxDVrHdhEPjaAz4q1qPmE452CfLdLwIVY7pXukPGErtaQ+p
	 ihzRghRE32xA3GBkr6Kedhbzvh+6du8iwEvWLvl44pEog9ldySC+PC73Dq/hFzpVHy
	 3xVDZs3qA9uIQ8uX5Og4h3wSNb+14RKAf5qhI0Y/UNtZTrGLOZAOPSfeNxhlzuR36q
	 zx2W/C2jezx5x0YfYH102h2hulc8mjKuPTnXTU3QLguxzG4UzR1bFNsz+WPyjxgSQH
	 /iHf2WZnA9rPTRVU2f2al3UVoi2TomeiZZ+hk17FdOIz60LWfRfQ9EKPW0dAy3dMzg
	 E40wueYTxcU7KjhX3pgBhTuYpsCXq3Sg8I6NoJrKJIFLLLndPoBffluPvJMaQa9qrI
	 p8WuU0PY8Fk6JyXYQpAoPrq+dY5axMOavoDgrPBJrm8usvyPq711WVoViHgAgi9AHE
	 dhX44iTr+HVmJ05GhQZyYhBfwq/ZK+Jv+uQBPc+JodgSNgRxuGw0f2CagNlvTpxJAl
	 YDi0sumNWriNVVZMHk7uU7rHmQcMpssKkGHfC56SmvGWTHlFw/UQZ6D/TQnbK1yvda
	 3yPwtNmhk/t8EIAONgLCC8Ao=
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a060eb84so37761825e9.0
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 23:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781676656; x=1782281456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yYyjbUwTbz5kYjrY+YDLT8Sq9O45djIje08c44tj+s0=;
        b=KW7Rardtcl8HJ7un2MoSf8iWb1zQIfkPvx8xcMfBuuIjwQRn0mFx2kffub/XHNGyE2
         vA4l332+8r8umiti8Vtu9kwfUpHogKbzT8F7epVv+fP8KLXve2/I5HomHP3zwk8Njltj
         +8oXqmOIh+Z7+otrzPnYS1YRrWpSZpIHYBBOAmz/2uSpnT9VKYFKqMImuVUKtUKrmnNS
         kKdJUBxOjUVidipsLsnMy/TZHsgXxCNWVN/KJW1ukgs66n7RcMu/zuF5qJsYyjFQpORE
         wO9tF5LkqPGlfPuODKWQL4sf8JqPryI0H+K2OmFCAqEnfjyYOBkajNBlQHR+PQlCpcGA
         IeMw==
X-Forwarded-Encrypted: i=1; AFNElJ+3ZlFwH+/xaWXvye3V2H9bvd09vydte4FYeoUQ0bma9O8+VG9nRGZ01myDWRhlbLjltOPt7ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK06LQHmf9+XeZuaZFV5b5IH5BnckrlrohEa+6+cFW8/OhHK9t
	MlORhY9P158L8arDZpVxuLqpq4eAqPeGj38Tzh3W1IU44QgfNTT4Kaby5WXenI1KBMI+kAbZ/yl
	8/Z+gKJdMfuYDgGBssyuGDUsoXUCWT5ja406Ib7TiiVtqanIGJWiHG0u+BEfwjcfGRXP4BqmtjQ
	==
X-Gm-Gg: Acq92OF0ByfrO+N3Sdr5vM39dbbhtP7qjTyssZ3fIbigjoNGE+HoXtO+NGxHP4rW8Sf
	ewuKRoY+EQH2rBTYTrzFLYuE1Fnb1TyCxLiiECON6Cyf4DTgzmiSbzQArLHymSdW9v6bGPw542B
	id9vvzYzu0Z1z2195+RvLJlHunrTh2hINlLne4YVP6kmOUUp0y488iawqfvRPTfmFzUun6mitWp
	dbXb2UKuTEL4vghukDdw2e7JW97LZxOlzCYnDJwpdmedYElP2KtxF2ty8dIpXIeF5Zn1Ggqs3hd
	7ZDVGh50g77qgEcP2ESkSIoUwfD29MBuJwhcMTQsFYE3Pqylf3LIRXWzrZeWsotBc3WsaH4S6oV
	w8QxGEEMRaI0=
X-Received: by 2002:a05:600c:5644:b0:490:adb6:7957 with SMTP id 5b1f17b1804b1-49234141d98mr16811905e9.33.1781676656071;
        Tue, 16 Jun 2026 23:10:56 -0700 (PDT)
X-Received: by 2002:a05:600c:5644:b0:490:adb6:7957 with SMTP id 5b1f17b1804b1-49234141d98mr16811665e9.33.1781676655730;
        Tue, 16 Jun 2026 23:10:55 -0700 (PDT)
Received: from ross-pc.local ([2001:67c:1562:8007::aac:41a0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f309sm46674988f8f.14.2026.06.16.23.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 23:10:55 -0700 (PDT)
From: Ross Porter <ross.porter@canonical.com>
To: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ross.porter@canonical.com,
	stable@vger.kernel.org,
	Edoardo Canepa <edoardo.canepa@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Brett A C Sheffield <bacs@librecast.net>,
	Oscar Maes <oscmaes92@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] selftests: net: fix file owner for broadcast_ether_dst test
Date: Wed, 17 Jun 2026 18:10:39 +1200
Message-ID: <20260617061039.79717-2-ross.porter@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617061039.79717-1-ross.porter@canonical.com>
References: <20260617061039.79717-1-ross.porter@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure the output file is always owned by root (even if tcpdump was 
compiled with `--with-user`), by passing the `-Z root` argument when 
invoking it.

Cc: stable@vger.kernel.org
Reported-by: Edoardo Canepa <edoardo.canepa@canonical.com>
Closes: https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/2129815
Fixes: bf59028ea8d4 ("selftests: net: add test for destination in broadcast packets")
Suggested-by: Edoardo Canepa <edoardo.canepa@canonical.com>
Tested-by: Ross Porter <ross.porter@canonical.com>
Signed-off-by: Ross Porter <ross.porter@canonical.com>
---
 tools/testing/selftests/net/broadcast_ether_dst.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/broadcast_ether_dst.sh b/tools/testing/selftests/net/broadcast_ether_dst.sh
index 334a7eca8a80..5e7a8fe23c7a 100755
--- a/tools/testing/selftests/net/broadcast_ether_dst.sh
+++ b/tools/testing/selftests/net/broadcast_ether_dst.sh
@@ -44,7 +44,7 @@ test_broadcast_ether_dst() {
 	# tcpdump will exit after receiving a single packet
 	# timeout will kill tcpdump if it is still running after 2s
 	timeout 2s ip netns exec "${CLIENT_NS}" \
-		tcpdump -i link0 -c 1 -w "${CAPFILE}" icmp &> "${OUTPUT}" &
+		tcpdump -i link0 -c 1 -w "${CAPFILE}" -Z root icmp &> "${OUTPUT}" &
 	pid=$!
 	slowwait 1 grep -qs "listening" "${OUTPUT}"
 
-- 
2.53.0

