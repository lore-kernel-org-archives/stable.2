Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627313D9693
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785088168; cv=none; b=fKzAFl1pWSp3F+v8IX/EuTFFRe9beR/q4ATnryl4tdaUskjUP3+eUXW3ANvNGhp8WThP/KTzgWaIGw2FonqDGXfAmkVvs7AgbKxWV8vdPLkuLZHd9KQsVDi2qKVLcVMltP3+gga3xYLQBZnNwkW7n29B8zeMX13e9NhAPaCdDV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785088168; c=relaxed/simple;
	bh=3bvh8ELBkw+UtIqX8TEGE5T9LfzIa8fNtzANvVlDEnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=atxcpDUh7QzQNbR8J0phAsOomnD39kkPHLG1+bSm2OtX+cPAb6/V86J/XjAvUt7Ie/RpIpSlHNED2Atd5jEk89o5qpFtEu5elNylPQmfYG4/HnQazGRZnjgu8iseeLL/e7uOYzejdme9UFUMPr9v16+0hl8L+FfNjCJytpIQXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRfMa1Dh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRfMa1Dh"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495635a85d2so16807205e9.0
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 10:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785088164; x=1785692964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OG3fQOQ/VuZuHcKcajMtkmekIa5X8h+Q4MAhuhrOcMM=;
        b=KRfMa1Dh7LPKZFIJrvpehQSWAZhRCW65NrqlWlt9z+ONyr6VoJkzUYHJr+BToKiN8T
         DItrqYR8sg1UClam82AtNYExrNXW7jeLtt7zyxn5YZZDlDqU3E/ZKcgcUCKvExRMbneH
         153FuId1Gf10MyriF9Ay7yjljlbkFEJeLamL0cY9R1s4C28EmWjWbsgY6ZiEFyWmTR+N
         XROCk6Ymfl5w8etxlCS6pgAjxH9T9chW0Q22skBTxY7kySgSARdWWyUUqzxT5KD/Vmfk
         +FNCuPdGmk9MW3NI58YoIkEFnKo9LUvhOHhh/DDsHFf4IErOst3US0lcPC5suJ6MHJr0
         8Avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785088164; x=1785692964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OG3fQOQ/VuZuHcKcajMtkmekIa5X8h+Q4MAhuhrOcMM=;
        b=EenjjlNb+BXS9Ejx45mfMpZuxTFnOqzDXCXkxV7nI/SqHiP43y+ESLQSR0V8KqCtqJ
         LOCu4zada03AeZ1nkTa62F4CBEzdD479zQSFMYS1vNOio3CknPlAnlAoT2JADphLvwz7
         ++08761H7NC4VN29ubTHL/RLUJzOl+fqzePUuvAP95Yv+YYFN9waCeU5PQxoPs14SStM
         5XOdGyaYyjEFCGUfcX5T6N3YCAgdJZ5x0ARWkFR0IcsECiYmpwlvj488VyLtnYPdCQRN
         L8UD+Gj4raqsdNSL94LWgxq5d9PXj76Gly7szNuIprghkLJsQQt6AGEWlmcJzNXw177l
         /OFg==
X-Forwarded-Encrypted: i=1; AHgh+RqmVc3DaiT4BAZF7HHMPXJIYtUrWkDDoU9im98cD/A7tKzEqOZHQQt0fH6DIE8EFNL7lgOS3q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9tRNR2c+f+m3zE2qvlgo3rrolN1MTd0yDYveny337jNKYGZM1
	q0CSKjkh3SPfsf5P4CsIag+IYV7DiMNvhaYx18dj7mhsanM2gdCpTFrJ
X-Gm-Gg: AR+sD13mVJm5TXdmQWJflBWNFD0ewNeatCX/yHy4n45mvFYULwVfmJtGPunE7lWVXOA
	yPHqUq5xOl8R9ZFFbdWDMES7y0PaRb58ZdzrQVRKWIGKornVq245CDCjNc1H0wRDpYesSoLd9D3
	cISNLqibiGtDIAah8t3+SPIFWz5WX2LnyqJwhyA+fduv+cYFW/IMeQvP5m/O7guqveTixggfhIu
	60/xWHMFPS8Fbopg3hQz3tg1VHc4ogjnIlhPTmn70BIIc3RHEwiYFB8onK6dD3H3X9r1t4J6m2n
	qAhrIFUTmVcgSbfztgc3Gqk0+LFpd9b/9cylX5Pode0pt6dP1dnGVjesI0kdfp/CB2nsqyUGQHN
	Kddj1zs2c20tiOeHGmMipdkxHEvNtheo/F1wig85QirSK07R0dfEXngXhoeNpR0bcEQjDf0cQYN
	/Vrq2rJIkldnrH5qVaSLhmKfv+dgL6O7xS27flAevS2yrH1oSRz/TIxePIkfyXU3sJ2h1VhiPIf
	IpZ3KuZ3nmFqObTId02NwZbawnmyPdQxjeEagJv7zqkX9fCL04=
X-Received: by 2002:a05:600c:3113:b0:495:4fd4:619b with SMTP id 5b1f17b1804b1-496b56bbc22mr70116885e9.1.1785088164322;
        Sun, 26 Jul 2026 10:49:24 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-116-215.95.114.pool.telefonica.de. [95.114.116.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a64dsm45288820f8f.1.2026.07.26.10.49.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 10:49:23 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] KVM: arm64: GICv2: Don't WARN on out-of-range GICV_DIR INTID
Date: Sun, 26 Jul 2026 19:48:03 +0200
Message-Id: <20260726174803.5880-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vgic_v2_deactivate() passes the INTID a guest wrote to GICV_DIR straight
to vgic_get_vcpu_irq(), and treats a failed lookup as a "can't happen"
condition with WARN_ON_ONCE().

The guest can make it happen at will, though: for any INTID outside of
the implemented SGI, PPI and SPI ranges the lookup returns NULL, since
GICv2 has no LPIs. A guest running with EOImode==1 writing such an INTID
to GICV_DIR triggers the WARN, and panics hosts running with
panic_on_warn.

Drop the WARN and ignore failed lookups.

Fixes: 255de897e7fb ("KVM: arm64: GICv2: Handle deactivation via GICV_DIR traps")
Cc: stable@vger.kernel.org
Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v2:
 - Drop the WARN_ON_ONCE() instead of bounding the INTID before the
   lookup, which duplicated the range check vgic_get_irq() already
   performs (Marc)
 - Retitled; was "KVM: arm64: GICv2: Bound the INTID in
   vgic_v2_deactivate()"

Link to v1: https://lore.kernel.org/r/20260725154020.37305-1-kmehltretter@gmail.com

 arch/arm64/kvm/vgic/vgic-v2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
index cafa3cb32bda..7182f63fc938 100644
--- a/arch/arm64/kvm/vgic/vgic-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-v2.c
@@ -170,8 +170,9 @@ void vgic_v2_deactivate(struct kvm_vcpu *vcpu, u32 val)
 	/* Make sure we're in the same context as LR handling */
 	local_irq_save(flags);
 
+	/* Guest-supplied INTID: out of range yields no irq, so ignore it */
 	irq = vgic_get_vcpu_irq(vcpu, val);
-	if (WARN_ON_ONCE(!irq))
+	if (!irq)
 		goto out;
 
 	/* See the corresponding v3 code for the rationale */
-- 
2.51.0
