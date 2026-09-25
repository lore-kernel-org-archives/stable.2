Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9323859D3
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790303725; cv=none; b=ab8iihgpucStohRymXQmDFN/PoHD+BrFdW21oq/5euIpdLu77i1ELscAWFARrXISMEs6FOyJKO1k4vaqCyyF0OyUqWMVgW0/oN+vQTta784YX3LxpzDApauZwAaAjTOa4Jo2eyT8Qkkbfk/DHbYNSFTzJfAtzL6k4DCsZ7vy8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790303725; c=relaxed/simple;
	bh=mzoEsAc2Sr91/I0SgoFP1CmTbLAMnntKENmE31N2EC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSTSr4nppk2DRYVe0SmsHS2UMDyFf41x3/7Mi//46J4v52R0v5LWZU82kYvUI1O7U+FLJZBRpHGsOC+N1b68uzb0r0VPWDdATBzCVE1QltKPcCbwpGX64kgWx1J7ZjpnO0/6tCYoM33w9RV0HmXkPIANUG4eBtGLxSBQqaJWaf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDIvft/t; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDIvft/t"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c98e194227so164223e0c.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 19:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790303722; x=1790908522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ABMyZuvqxUd+c3too9IAPvLCmxU7UkIesXzVqZa5J60=;
        b=LDIvft/tV3wpf3QhyYh6QDYfh8F4t0/qiXGJfQyFRcw7SyP/OG2SMZ3gXRhsKdnZ5w
         7A90/SeAD8FMTU/ni/LbiCs1Xl0YbKoYWD+jbcLxsFnA2+7C6LXlnCx6moEtmKeJuKIZ
         0lYbVcWhNRd4Tvr6vjqbf2uCO5av3QXp28nYkEl0haKIfYP+2nWJHMWxt4TdymPDGEAS
         p1e41F+AwBPWytzOhPcPi5bh77FWmR7gci8/zZiPDCBKX5FzkJ+fVnV8ayJ5LBfsITNh
         J5Yf6fNfj1VTiBNtt7K2lXQNWpQH8pli2yNqDP4nOYMoGZR5VDezApADuKKLw2HF4EMF
         H4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790303722; x=1790908522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ABMyZuvqxUd+c3too9IAPvLCmxU7UkIesXzVqZa5J60=;
        b=Kz4n/31nVq75dX5fzKrwcyXeZ/HiWiGYFrT/UqvL2ndt85fplU65MtRQ8aBKXGB8vB
         NH0sybigOmX2/4LXl2rA9QlTCbsdYsPCujPO/Z2NajTXAQJLcYJUi1mahB1wjXKMDM77
         uc15VN6R/AoElWnCq8qg0mENxEqFrLvih3cyPoHZw0C2yzU5hWpRmqd1kKX/JQiKdgfQ
         y/KSeZ4bS7ty9jEgOOkw+HeMuTRWB5NgA2pcVuqbVMSKEif/ocMErVICasNy2uzisJaD
         pJMofTJ/mL1kYDNmCirqsBprBqXIRG/UKtVsyiIQDJh3YoBfw6xL3prT+wNn6iG3mIVt
         RIbQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5yUOOx99DkrMmqhIsVB/6N3nA6egP7TyIPl0vh6uHtLY8+7J1tmkI2bSFLEIe8TSndSraHfg=@vger.kernel.org
X-Gm-Message-State: AFuF++nvmkADn/lhMpmjQqTrNTt9TNNthcCZQqKaOI/0Z9YCRsnoPn1r
	WG/lL3K8ZkEJ0SG6b+8DI2y0XmlXKmWIAKmYz3kIPvd+mE7B8rrOdHXx
X-Gm-Gg: AYBFou0TimuEcnM2/zHklXhwPm6bGRoqQQxFk+bglmBNFXyLJz3lhkwlAnuBJ7bzJBb
	fpAlHYeaQAGO31Rjh2YT6+AML+VwAY50vFFIlaMCmLVZWm7UTQLGZz6vcQ2Kfk1CYv7X+nzKp7C
	PItQZzxypA/CoZlju62e9ZSgqsR8SKXt3G8/i8zrAlK79RFsuduCGdmeek9+S0TUYikQrBttBDb
	b5UIYPKZMeHvaXQQaEdU6YoGRyZMA8trhtwuv3lVzUH8cZyCWp8RZv7V9PEbaeZ09haDoz2PUOr
	CEWsz9UItY5WCoqCdFRNs45s6Qa7fux0EIT4MH0bMRRfdL5cCFtuER70Yxmc1y+tGgMqjsrd4nX
	F+Xu38aJVNma7cisM9uSd2YfX5RaIWaUb6JuuzzDj9KdhZtBogt99YLdnmEt40ZMWvckt1Kdc1D
	sJ06/h6HAe2tTyzhw0C9b6wdWulXk15Ok6TozUYbyYJRJOI2DkFfBYa28ZwaPo3Hk=
X-Received: by 2002:a05:6102:3911:b0:79e:df6b:d2b6 with SMTP id ada2fe7eead31-7af1c483ba4mr1717243137.2.1790303722355;
        Thu, 24 Sep 2026 19:35:22 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc651999ecsm1303758e0c.12.2026.09.24.19.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 19:35:21 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net] nfc: llcp: check socket state after locking in nfc_llcp_recv_dm()
Date: Thu, 24 Sep 2026 23:35:09 -0300
Message-ID: <20260925023509.3060096-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923133339.2518641-1-qwe.aldo@gmail.com>
References: <20260923133339.2518641-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Between nfc_llcp_connecting_sock_get() and lock_sock(), another
thread can move the socket from connecting_sockets to sockets via
a failed connect + re-bind. After lock_sock(), the socket may no
longer be in LLCP_CONNECTING state, so unconditionally unlinking
from connecting_sockets corrupts the wrong list.

Add a state check after acquiring the socket lock: only unlink
from connecting_sockets if the socket is still LLCP_CONNECTING.

Fixes: bf1460acdf8c ("nfc: llcp: Fix list corruption / refcount desync in nfc_llcp_recv_dm()")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/nfc/llcp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 74bf81700..acf113311 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1326,7 +1326,7 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
 	 * corrupt the connecting_sockets list / desync the socket refcount.
 	 * This mirrors nfc_llcp_recv_cc().
 	 */
-	if (connecting)
+	if (connecting && sk->sk_state == LLCP_CONNECTING)
 		nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
 
 	sk->sk_err = ENXIO;
-- 
2.43.0
