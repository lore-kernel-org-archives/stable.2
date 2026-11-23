Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458231;
	b=wYOc9skAvcshu1TOqz3THi2sjJOkN8dqW36cmd2SOWC6ZbYsyCkRoUTubZq7ukWcVI/y
	 qFTbJNnzroO9RgEbKw62W99GBeNOYedDra2pAvUY3aQo5s7zjyrkVBYsHSHTrdNwB7K5i
	 D5oZ3bsxpB9h2NG88zyRwJdoBFc5nb1gY/j+Y6Iu7R+a3RDyQ8NSMNnlmnMhkegK4L3DQ
	 EGGaXNTk6mKDFq/uWwHuuMr62ml+gGdpIVLlg0WV+NxYB2LqcuI7RRReyamebcktkuZrm
	 5m65Ns+R0Ps1tlZafYPln+/IpKCfvq9JVl/d+4zXzvUnIMc5UefL4vwm2zd72taeepg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458231;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-SA-Exim-Connect-IP:
	 X-SA-Exim-Rcpt-To:X-SA-Exim-Mail-From:X-SA-Exim-Scanned;
	bh=Hd4SLQ7MWR/iBTNIr8B5VgmRb7vBJXLkdh3krL32bK0=;
	b=RtIeL9QycNbQ3YZ7lB7G2qHATyKXaYTroBmHtPKbAxTN3xKgNwiHts1MnRKrHL+aOdNJ
	 zlOmcbpTXmPYqHjhNSvMUowA7qFrSSbH3JHAxdtDIyrX6TO/OK1j/SxpSkCR/74PQybWf
	 NmrpkjaSSKMIuuJaReMoUhxAVIizcSunHPwYwe25+WaxWY/fhjYDn2tdrsHR2UuUAraeU
	 Jhw0dGvkbwZ/tUgv4VAM56aJ7TAf8u42RmFE3+59FFOhEJWNtOUTr9zGX775fe9j9V2Km
	 1+8WsVT8Witsc6J7O1pajMX9fi+jXiDDzBr/pUDt/ZHNINMBMB7YfhdPS/6VebDY7Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izcB8oEs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0D606A31A;
	Mon, 23 Nov 2026 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izcB8oEs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24F41F000CA;
	Mon, 23 Nov 2026 18:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795458230;
	bh=Hd4SLQ7MWR/iBTNIr8B5VgmRb7vBJXLkdh3krL32bK0=;
	h=From:To:Cc:Subject:Date;
	b=izcB8oEs7g9UOk5t4x0Y8eK6QIcWcO1RzvlZ7/2/8UL9x8EEWa4RLh/TDYixSBGAC
	 NtS534Y6AsvIJrbeM8lf/Cj2LCoLMK2iRzag2rVNXlJd6BPwePcRBFeHto0yX5Z5lK
	 NN8B56PPGGY26DTZOL8s6rcaq8X/ksZV92zPnF6oTyw1S+PNehnu1kSBHPqjEhWwEH
	 gR13YARvaVNmh4l711gGdJmJE206fGFQqFYWBQSedd1hodYfOp7Iu/1w5LJ8dHhJnA
	 hXRC8NatvT38II7kfwfb6ivYZwHBsPkKE1+YH7p10gUZlKnLjXH7Batq7oNzoknMS1
	 /RXr3rBbkhrCg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=localhost.localdomain)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xVYhg-000000028SU-2ZLX;
	Mon, 23 Nov 2026 18:23:48 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Dan Carpenter <dan@pereq.eu>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: arm64: nv: Upgrade sub-page TTL hint to maximum size
Date: Mon, 23 Nov 2026 18:23:12 +0000
Message-ID: <20261123182312.4842-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
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
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, fuad.tabba@linux.dev, dan@pereq.eu, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Should a guest be slightly foolish and submit a S2 TLBI with a TTL hint
that describe a base granule size smaller than the host's page size,
we take the resulting size at face value and feed it to the S2 unmapping
code. Which legitimately screams about something not being page-aligned.

The architecture allows us to drop the TLBI on the floor, as we don't
support a S2 granule size smaller than the host's page size. But it turns
out that doing so is proving pretty hard (we call compute_tlb_inval_range
from a number of places, none of which is amenable to an early out).

Instead, detect the annoying case, and pretend that we don't have a TTL
hint at all, leaving the size upgrade mechanism to take place and use
the largest possible size for the guest's S2 granule size.

This will still allow nonsensical stuff to get through, such as a 4kB
level 2 (aka 2MB) from a guest with a 64kB S2 base granule size running
on a 16kB page size host, but that's not worse than doing nothing, and
the host code won't get shouty.

Reported-by: Dan Carpenter <dan@pereq.eu>
Link: https://lore.kernel.org/r/20261123-inval_range-v1-1-815e15797089@pereq.eu
Fixes: d1de1576dc21 ("KVM: arm64: nv: Handle FEAT_TTL hinted TLB operations")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---

Notes:
    Reposting this as a first class patch, as I'd like to plug that one
    as early as possible (and Dan has plenty of other patches in flight...)

 arch/arm64/kvm/nested.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 78d5b18dbd2d6..36e4e83badf0a 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -714,6 +714,13 @@ unsigned long compute_tlb_inval_range(struct kvm_s2_mmu *mmu, u64 val)
 	 */
 	max_size = __ttl_to_size(ttl);
 
+	/*
+	 * IMPDEF behaviour: treat subpage TTL-annotated TLBI as the largest
+	 * possible invalidation. Don't try this at home, kids!
+	 */
+	if (max_size < PAGE_SIZE)
+		max_size = 0;
+
 	if (!max_size) {
 		/* Compute the maximum extent of the invalidation */
 		switch (vtcr_to_tg0_pgsize(kvm, mmu->tlb_vtcr)) {
-- 
2.47.3

