Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792987030;
	b=xuTQ6HC0CBb61pOJ1uk3nGvFD7fPTqDcFrCbkQ/M/2AMCgOjywN7V4Zw+udLNNiFTtUw
	 rMe6m+mx/vx4TVzxF+azZD4MzAOtQbfgxSWfi5zcAOtLK55MDzDRVgNMtyOyn31Rb6V9p
	 CL+YvXQqxkZD3vTTjoVVKa65+750VHa5MMHUHyz5FOii5KoVBTAp//aTmbzck8S1oCp8d
	 NvKuA+SeUha2SRYt7gwPcFczPqlUobR8PZnLTzWaiRCD0DvV4Pub6MEmw6eqYXH3nK4fa
	 WcLW8RZyeR1lvUuOqjH3Dcw6DPFoWHP4IQZAZPXgQgNR4M8Mo8vQ4EsmzMNJItryjIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792987030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+ScCUUWyJM//qpTpz7tt0Fdxp9XvYrNhMa0jbjZM+Ng=;
	b=pZmn2elx1YqT5pTAKT4hm4xZrxvOzwQ4km+nTtrl4VPpvC1AAWZmZ/u0GXmm/P1/5rqu
	 VJQTvg2AZGGxquL/au4a3VHZY3ZADYxES9ZXIUXrc8Bi5fpqi2o0nKds9EL7eTnWd4ynA
	 SBjXjpJhiNBmXByNBqI1308m9t2eKtPAxtBGCm2y9beEvukcOtcimIvWSXkgnLcUsENsC
	 0an5nlFaqILNt7lwCBZBci9nRMR6cc+oa1C6lDmKbgzJtqoItUS8e7fKoCBXQ41ENpoqn
	 swuEoVPQVwKwN3PZTw43PdELkPUz0fJ+IsuK6Kq2rBibrvby5P072cMV2Lwa5gu5pqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CzHL8JAA;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F502606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 03:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F502606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CzHL8JAA
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35b2c599f43so467830eec.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 20:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792987029; x=1793591829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+ScCUUWyJM//qpTpz7tt0Fdxp9XvYrNhMa0jbjZM+Ng=;
        b=CzHL8JAAhVXZp+BFIea6XXS5CXvIdKyvTb9rotyb9xP51zqNOdUyULSyK62QT2G7qO
         7v7qzFb4ekjP8THGtkchX7EdobigL2eBQbw+WhyrhbXrSIQnzUg+mhL33OKcdQw/kCOl
         zq1zDO6mrkZUzmX7FZqHcqcNncLTFdoz8LPdi0HLuB1F1rfz8enfQHRYXYoq422/oXFK
         mPtlgYSvIeU9kcWQBdlA3APCubO0DXLc4kb8YveBwZWFD9FPg86N0L1cKM2rfH9DDam2
         E2jObCINjT2AdecrPCYLiQbyEsbP7oepRFvC9D5xQPmCjEWHmKY3xEsXTQ/XabPJaAj2
         pxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792987029; x=1793591829;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ScCUUWyJM//qpTpz7tt0Fdxp9XvYrNhMa0jbjZM+Ng=;
        b=SUBq7unsedOkpoxVv+QdI3y5LbVVq2JY8PjlZnviAaz5OhZRZKZwiTBehwxD2QFxSB
         AQ6oITgSX1hKy/cs1s7tnudx+k6YF6GXm0gSB4xrBXlH3KnrAryvtp5209Prccu6iv+/
         pT6wZ5Bw4zze0Kt9b8m3eetokxtgKc/PHYYuD0M8MLwvrHQl05vneZ4L0OMmThExohtp
         Q0KIdvej3ZAgaNsr7V7QPPLvg2gu7vg5n66dK8wF8h9dtAG5KJJWW9rFPby2ucm+i3H9
         +qNzGy0Sjva1xFpQqfA+tCHcAwjTus2mt8d4Nk1fGQkM+a5d8V9Gj1Tik00M9+p3yoUO
         ltfw==
X-Forwarded-Encrypted: i=1; AKwUvBz0tXs4b6gIFJO65xGzTjmh3BmjQrx2FwunBg94u8qcmW9f0pjMulWaXDJaVMw8vGKHxZfUcQE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKly4TD9G6sBvqL9bdvt8wiFt/QjlXPfDGymUEIpy0SqaHkf6CL
	txZLfSEMjnGxx8BLVkhsr0SdCkYTPtDZ5UvbRGkHslJDcSVqrQq3nPIa
X-Gm-Gg: AYBFou3NdIQ4x3+1SC980wnYqWgYCGXxk++nfB4WhkLZOB66DoPAVy52ByvKnfyPwcS
	YylnHZoY1nD613M1wBPbrlO2ORptbvyLRPMyMJNwYYQlVf2l06i8LdOu3wAkHkn3WITxE8Upr8k
	par0HLiGIVZzjLDP0M6p3ZjGjTPHGIy2qF+LbCUGDseOUlsZUTqUBecE8i0Ig9HW84zkD33XIwJ
	5AT21LabmbTh5MtG0Zs5nVx++6qSdaP281UBCVxLBwQf+luMHVEXnf6jW64jTH1IrHhBRpi7Zld
	c3e/4X7L4WrURms96GRsmXF5MqKqnTgyRWA5jyCVgzSlE8vmb/bENrfVd1yOV8WY87etidpcoy2
	jnamynvYJrw6Nvq+s+w4m559RFVmn7bJmA/AIABgHEAMFx89Cq3bevty7kAA2nCSG5UqZ/SJ3E8
	1ySU/0EB41gwJXHKufcBFyjeyP5rnGsTeBazEwfA4LL651cElK/FShvoVIs1xnX8d1McRiaxWSS
	8tNhMwQXaWp/K/Zl7sNbp+rGLgpvWqyts7L9A0QCGIER32fXgW7f0GNcgg2gnbAvvzUOo7aRo7O
	zQPcvOqjN3WJZGdJINroRMHL9a7fIfz1FMn1hdU5GCDaKqK0ya+GK5h+fB20GBMs9MEDr4Xb
X-Received: by 2002:a05:7300:f0ce:b0:366:846a:e21d with SMTP id 5a478bee46e88-369e84d35c0mr9182619eec.33.1792987028486;
        Sun, 25 Oct 2026 20:57:08 -0700 (PDT)
Received: from MacBookPro.lan (113x35x113x191.ap113.ftth.ucom.ne.jp. [113.35.113.191])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d93663sm24441240eec.13.2026.10.25.20.57.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 20:57:08 -0700 (PDT)
From: =?UTF-8?q?Paul-Louis=20Charri=C3=A8re?= <plcharriere@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Jalen <jalen.lin@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	regressions@lists.linux.dev,
	=?UTF-8?q?Paul-Louis=20Charri=C3=A8re?= <plcharriere@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH nf] netfilter: flowtable: remove hardware flows before unbinding
Date: Mon, 26 Oct 2026 12:56:51 +0900
Message-ID: <20261026035651.40052-1-plcharriere@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAHqkChbVoGHrWtaFyGFaLQDiAunWw1qOpW-vKSgkKxWEfQ_tCg@mail.gmail.com>
References: <CAHqkChbVoGHrWtaFyGFaLQDiAunWw1qOpW-vKSgkKxWEfQ_tCg@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit 13210fc63f35 ("netfilter: nf_tables: imbalance in flowtable
binding"), FLOW_BLOCK_UNBIND is called when the flowtable hooks are
unregistered, in the commit phase, and nf_flow_table_free() only tears
the flows down later.  Their FLOW_CLS_DESTROY requests then find no
block callback, so the rules stay in hardware: the flows keep being
forwarded, and drivers such as mtk_eth_soc and mlx5 keep their entries
and reject a later flow with the same cookie with -EEXIST.
Commit 5acab91458ce ("netfilter: nf_tables: unbind callbacks from
flowtable destroy path") had placed the unbind after nf_flow_table_free()
for this reason.

Remove the flows of the device from the hardware in
nf_flow_table_offload_setup() before unbinding it, as
nf_flow_table_indr_cleanup() does for indirect blocks.  The GC run that
nf_flow_table_gc_cleanup() waits for may skip flows with pending offload
work, or have started before the teardown, so queue the GC work once
more, wait for it and flush the delete work again.  A direct
nf_flow_table_gc_run() would race with the GC worker.  No BIND or
UNBIND call is added.

Found on a router with mtk_eth_soc flow offloading, where each firewall
reload left the flows of the old flowtable bound in the PPE.  Jalen
reproduced it on mainline with mtk_eth_soc and mlx5 and tested this
change on both, see the report.  Build-tested with W=1 and sparse on
arm64 and x86_64.  In an arm64 guest with lockdep and KASAN, with TCP
flows through an offload flowtable on netdevsim ports, the delete work
of a deleted flowtable now runs before FLOW_BLOCK_UNBIND returns instead
of after it, and nft_offload.sh passes.

Fixes: 13210fc63f35 ("netfilter: nf_tables: imbalance in flowtable binding")
Reported-by: Jalen <jalen.lin@gmail.com>
Closes: https://lore.kernel.org/netfilter-devel/CAHqkChbVoGHrWtaFyGFaLQDiAunWw1qOpW-vKSgkKxWEfQ_tCg@mail.gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Paul-Louis Charrière <plcharriere@gmail.com>
---
 net/netfilter/nf_flow_table_offload.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 4365859220e..3844a23af5b 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -1279,6 +1279,19 @@ int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
 	if (!nf_flowtable_hw_offload(flowtable))
 		return nf_flow_offload_xdp_setup(flowtable, dev, cmd);
 
+	/* Hardware rules are deleted through the block callbacks, so delete
+	 * the rules of this device's flows before unbinding it.  Run the GC
+	 * twice: the first run may skip flows with pending offload work, or
+	 * have started before the teardown.
+	 */
+	if (cmd == FLOW_BLOCK_UNBIND) {
+		nf_flow_table_gc_cleanup(flowtable, dev);
+		mod_delayed_work(system_power_efficient_wq,
+				 &flowtable->gc_work, 0);
+		flush_delayed_work(&flowtable->gc_work);
+		flush_workqueue(nf_flow_offload_del_wq);
+	}
+
 	if (dev->netdev_ops->ndo_setup_tc)
 		err = nf_flow_table_offload_cmd(&bo, flowtable, dev, cmd,
 						&extack);

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.39.5

