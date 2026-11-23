Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441947;
	b=y9qtnIc58JARNYxQqJvD3LAwlhv7DIutfw2U295/3w/peXNs+/xeYKyHlwOMbVMi0Bsm
	 HSsFHx8FbP9vQ/yvGiYgCzMoEemToCAtJf+mARqyDSU8YyKJbbLgXNYrEdmN6G9k+jJji
	 H/vUdCEx2donhhLBSKBrFkDRhxWVpnq0h8tSiPoCg9KAD09Gbw6+2MthondQ/u7Luyo/V
	 +WQHIPzE/JJ7dv156GWemDZzwgDh4bV28hdqpQ5fWnsrFfqwg6bI/BnCQXRzwd/PQG83B
	 D96URtAoIZ8fHhk5TYR99PPxQZrh6qf72rR3rM3zkgFChBGiFiEBVY0fh8uUodtkv6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qTTU/HttU3fjnx/LLkySkKgelZHAjJmF566oK0Z4Ap4=;
	b=T+UqD9oNUtPAT3A0vPH9HYJynukJ30y8w1kGDGPFUR1B9KoxPvn6M1AcJy+fao7fGZZb
	 7jL9JXZQcrO01nMM3RAt2L8+C/U6zSY2lY3+Bb9S/3TjNLf+xB0927+FyrP55F9Zq53M4
	 K+1++DEu1DwUUjfp1WbEa0Klm4L9pI+17KLcTgMbB/jh+Uc668L3QBByWcasPDLb7LGsv
	 hsmCTFWeO7eduDpCE6ASphcZMuDj7HGHehNCgqCJTA8AtVeyGq8Ta5BAr6qlxcdLEUtY5
	 eEWmvU9zkD2surrdSQycs+wgr8uKC1pWplx0wOBoq2XIWwjIyRdGjQQXCnUFuq/vVQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D+sKvCWW;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9D3606A33A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED9D3606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D+sKvCWW
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b44bdcea8aso1282619a91.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795441946; x=1796046746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qTTU/HttU3fjnx/LLkySkKgelZHAjJmF566oK0Z4Ap4=;
        b=D+sKvCWWkugsDPcUD//j61XqpK43oeLeZI49ZkHsDvNaK3pVKTlj5bAnu909xhDZHn
         0AB5yDbH64SGRTREMoW+6P/WlIEk5jDqTad0ppTyzsXermU5M0St6RUsd8tHa3CfJkJi
         tML0hOXu4UuHqrtIWBbE1AyzNVWBSRvm37TXcuH1IiVQhQgdhpOFCcLSnTbhUGTxX43M
         opEVqbckBmyp91Yp+/jTRRYiI/GF2Mr+Uj/vy1Y0rSGXloP0tD+LO5dn0LcUSew5Ff+4
         dMvnSt0Fci9Rushp7JKuvGIvE8U+Wa3HPNDd8fUewaM2p4K42WAKK43wObH6UzrKs4H1
         2kLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441946; x=1796046746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qTTU/HttU3fjnx/LLkySkKgelZHAjJmF566oK0Z4Ap4=;
        b=262blBmrAtDWjDhAaMX7Xg/AkWCoqKFJYuqgoxQyd6dHWtlQy2BCNKZZzdHZesQtKQ
         j3gN8WeYi4NK9A6GdlXgwz2bz/nAt9k3k7zRqpsHfI/b9GD7E7kC/2tRC5OfgnPajJpL
         zmjCixK7bwnlUFBg6IN3zreBiIrB/OBVLs6vEV3sCzN5g81RzqiuX64I6n7gdRopJLNV
         4HDhpkqGgA7iZSM8JcGE+echH5bs0giiP8S4dEC4h1oPL6LSSDMVBzu4PMQ7m8rsUpC+
         eFfxiMRhSRmZ/k9WGcsu0OQxatBOH4jC7KYLlNxDrEWgtPULak+rgq1v+HJUATEFs3dC
         nXJA==
X-Forwarded-Encrypted: i=1; AL+hErEvNFibGNHogSgLlKPfAERNu/e5MtQF6+v44AcfEvz/2rf9PjZH86hs2zlJ7STgUSFijaE5PJk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tAscy6GaqSyXVu1O8O0c+XwMY6CszYpYn1KjVFGXwpDhaQC8I
	MK5NiMgTOljCD6a1i4DAMtA919l4oE9vyfVLH+zc075RQw7CLYGL/tCi
X-Gm-Gg: AZFdTZcVNmoOi+6iliB0Kv1/+RsbpBZT2tq32jkFBYYfVNrpecety8IUajXiD3Od0VV
	ELrHkecpIYFyEZp7F5K7220Zj14bqwbZl2lmmhpvO7gQzM60mYJU8c4mdRkka3DoLPCryfgDtcs
	HBW9jPZe5fBnQhb5gTYtRh0lhtvfNX1idZJxVtEToLnL7/10gBEADsLoEct1FXVSvuMrGafmVV5
	2gxoDMJhql3HjUvlly3eXs+YCQneuL3+YlDXu8/Ub3PfPMGIwa7LPUCX5qaFA7yJr9hDK0fwbQh
	W1PplVJQkuBN1v6sPHRgqStvv5CO+SposQRSXDajUKzhrZ6y4GEjQpB80d7Idbp1ZGbCEDS89EY
	shyG7Db1FdID+3r2+e0Yyy3ODYfF3LWzo/YJgHQ0aq+yFAQnUFgQw5wbK08NshdWffCo26N4wX0
	mNTYl6EUmuSz7LiQabAJgbilnECDjUtQX+t+4hTYbk4USM7YEfw5hqck0ilzqCNpN6xnKjzxfxX
	TS3ALtkiAjUgiaWY+LEvfB19mWF6M5hNNqri1kz+8KUN85PDsLBj5ZLDNU9XtsNyIHu81cYT3kW
	yHFixaUY4tcX9OjYP7+U1SqMFC9a2HE21w==
X-Received: by 2002:a17:90a:e70c:b0:3a0:d7f2:5a58 with SMTP id 98e67ed59e1d1-3b41c7bc5a5mr7828786a91.3.1795441946295;
        Mon, 23 Nov 2026 05:52:26 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ec698dsm20842512a91.14.2026.11.23.05.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:52:24 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCHv3 4/4] powerpc/kvm-hv-pmu: Free hostwide stats buffers if perf_pmu_register() fails
Date: Mon, 23 Nov 2026 19:21:53 +0530
Message-Id: <a9e4029d0e11b3c944f4b4cb781fc5ff1696709b.1795441238.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795441238.git.ritesh.list@gmail.com>
References: <cover.1795441238.git.ritesh.list@gmail.com>
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

kvmppc_register_pmu() calls kvmppc_init_hostwide(), which allocates
gsm_l0_stats and gsb_l0_stats. It then registers the pmu. If
perf_pmu_register() fails we return without freeing them.

Call kvmppc_cleanup_hostwide() on that error path.

Fixes: f0c9c49c5067 ("powerpc/kvm-hv-pmu: Implement GSB message-ops for hostwide counters")
Cc: stable@vger.kernel.org
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/perf/kvm-hv-pmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
index a58634f656e9..ec05b4855736 100644
--- a/arch/powerpc/perf/kvm-hv-pmu.c
+++ b/arch/powerpc/perf/kvm-hv-pmu.c
@@ -402,8 +402,10 @@ static int __init kvmppc_register_pmu(void)

 		/* Register the pmu */
 		rc = perf_pmu_register(&kvmppc_pmu, kvmppc_pmu.name, -1);
-		if (rc)
+		if (rc) {
+			kvmppc_cleanup_hostwide();
 			goto out;
+		}

 		pr_info("Registered kvm-hv pmu");
 	}
--
2.39.5

