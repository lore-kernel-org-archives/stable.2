Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6363C4154
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782848999; cv=none; b=BH2/ERFLZxbga9snjJsxtW6cr8vc69Fbzf2rMvqp+TgplcCzTCIvxD/c+P4tWropCcr7Yuia3bkPYH/z9BulTuFLOLQdGAUYovaow24+l230wdvMDJOEMVXTLTDGKpcrOZ5YIdV/j+Lsm6wLpG/RB1euvFRgRJ/c6NrgvzMP9Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782848999; c=relaxed/simple;
	bh=ndjrqTDd7iJKz5Vy6GvgobLXO+ceomtbKFEb3u3b6EM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hkOYwvI6O5DVmoVXC5BExuonIycqRtbc5gQJsSY8mhew2ULRvTdK0WbzkLqI32NEfSSLPXbX/MNC+xHoOWtJxQPBigJzkgswD0hQLFSq2GuL0SD5bY7eJJJPUR/zaUG9BdC23SQa+Px9itpMgc5vUas1OJt0GPNiAsLYZJRt/LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfEvfRS9; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfEvfRS9"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ee88fce536so24046896d6.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 12:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782848997; x=1783453797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n1qWlnp0byEBEeqkZdCjA2Jg1Z+PW8t3ekcekpBNKTw=;
        b=WfEvfRS9wgll8++0qRTBXGf3uVtr4Fd3CdmSt3/ecBmFVdzTaKzgS3ZvLI/ZkMQifh
         Y6t7k3f3oAGm2zGFRtSJIquyMGPkbCFpUL1VqLePDdDJuimT9uRpZHZkJ9z1/qFB8MTe
         WiPjcUy1BuU2ioxGPG7cbHJyGDP8daUiFjQKE1gAWZs4P5splOqOBCPLyCcbAj2pqple
         RB9MS862488hwpaX+xQrJFHmUx8qb7UZ4vXNSIgfxNMiAE7Tp9ScMnIx0SNDd+K9Y/hC
         C0pds9pUSfVGAFwLKQ8neftJVLax8Grd+6IPUxpmet7TL2/bcG42Nlox4yhY5TaP/wP1
         4xQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782848997; x=1783453797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1qWlnp0byEBEeqkZdCjA2Jg1Z+PW8t3ekcekpBNKTw=;
        b=dduPd9wpBftGXen1R2bsmfL0Cr1IvUArpVvEn41F+9ceoh03X6HBE+wzr3x6cQKNFJ
         lb/GE+Dg0dXGTtcDhHJ31oy9T+fywgt6Ey5bFCsdt7Bn/X23fIIJj5nVVJwSgItPZ3Ts
         OU3YrndCsKP+kuYprSZ3Jct4Qcv79yYpQmBdeYSkXJuRulN/h/9GV9844tN+pn2L/fSK
         LeEql/l8+K2+fycxOpJlv48EsPRPF7EkhBUixzQfGZvGRqvKCV+z8F0YikV/tYsnhPVw
         kSO0AOT5+1U1yiYJyTZSDYYfWxAWrbeBlY3uqUW7UVjEGONZqLuYqd04QESxqBBruNl1
         IyDA==
X-Forwarded-Encrypted: i=1; AHgh+RruES6PUOG9ExnLvQFwiBvPgW8A/jBzuyPc/5gH16GdUXkAk+TEMC/WLWWrF5orRK3ux/3dUbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRRJ/8xrfHZfdLDoTlon1R+z7hNrXbSPkVLkCIkDxWUmKSno5S
	zTgkvWufy1bzV3PhXjFUsHpeJtaTBUWHovkiUsLsvmDAC7jdEMm8mf7B
X-Gm-Gg: AfdE7cl9xjGJ/5gMPF/Gf9Xtl/vOisrQtiKqyJVHhJpPDBdtsC6ubfNpoQrSKeBZdCP
	CIft1cRtpQ1zEBiSZPtpcwHjq2ZBkC9Jde4goRxfi+l/T/g3QOT61/9VMql4FRsYLHy4M3rI36g
	MDETJz8VGfvwybbSpzk+FIx3/Azz1suZQZDloNNIR8FPaioCBB1Wt+aZc9DTr352INh2e+JxXf/
	Tv5pW9XgkVgv9VqekZU49v7tkI3kH023H6JJhQmQsDb6cCQbwIroptqquEbh5BcyAfkBwsHsaJh
	9DeLFmoJ+CD72M8WICuJHp4D+OmR44hNXtdWxz+J7TZBMVVTxyim1guIRkhMAMh76RA9MbryKOg
	qO+/7zEhFuElt0qtUFMWAKWcBYoEzTo4u3slYYysCmAYYd5KjC2ya9nEKtjsixcfNwSZFpO9wKg
	v6ldbiT49S76jKaGRuylrw9Eirhv4Nub8oqKPIbXXdOw==
X-Received: by 2002:ad4:5baf:0:b0:8e9:f5b0:f623 with SMTP id 6a1803df08f44-8f1bd6f20f8mr82544276d6.51.1782848996851;
        Tue, 30 Jun 2026 12:49:56 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a7e0d5e3sm33242986d6.48.2026.06.30.12.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 12:49:56 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] llc: fix SAP refcount leak in llc_ui_autobind()
Date: Tue, 30 Jun 2026 15:48:56 -0400
Message-ID: <20260630194856.1036497-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llc_ui_autobind() opens a SAP after choosing a dynamic LSAP.
llc_sap_open() returns a reference owned by the caller, and
llc_sap_add_socket() takes a second reference for the socket's
membership in the SAP hash tables.

llc_ui_bind() drops the caller's reference after adding the socket,
but llc_ui_autobind() keeps it. When the socket is closed,
llc_sap_remove_socket() releases only the socket reference, leaving
the SAP on llc_sap_list with sk_count == 0.

This is user-visible because repeated autobind and close cycles can consume
all dynamic SAP values and make later autobinds fail with -EUSERS.

Drop the caller's reference after a successful autobind, matching
llc_ui_bind()'s ownership model.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 net/llc/af_llc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 8ed1be1ecccc..b0447c33dbf0 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -312,6 +312,7 @@ static int llc_ui_autobind(struct socket *sock, struct sockaddr_llc *addr)
 	/* assign new connection to its SAP */
 	llc_sap_add_socket(sap, sk);
 	sock_reset_flag(sk, SOCK_ZAPPED);
+	llc_sap_put(sap);
 	rc = 0;
 out:
 	dev_put(dev);
-- 
2.43.0

