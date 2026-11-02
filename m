Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608177;
	b=4LDglghpCbcohHmecxWRK7hosNmMH7Y8SmGd630HYBbPMg3RPYG/z/LWJv3En9RkkcbI
	 g6QobeJ9K/Daf7qN4LiCT8EVPNujYELRjtGiv8fNljNXda2XwWCg7XPBQZFqXRSDKtMFh
	 JvUEWXOBMBr7Odj+4LutpnTS0iBQ/cVUckc/uIyAulLwp+h0RIUp+MYPolW4/1+YXTT35
	 v3G4IBZbsuPOd4gHOdTBYsxhz/AftIbxLB88F4KdoKHvRRaj9djxjNYUG16yQLFOYFmqF
	 7Jy0BAU+hVDgHYCsf3Q/pO8RqhcbhoYWubBwgdh3yY8RLHTCe+kKNR37qAo2ZhZ4hAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608177;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=euznYBocIb8kfNgcKlt2GHcUVDSBs2gzY/11E05nVeE=;
	b=Jctip3fHHRc/S1k0r2ShGDjjItDiOu0LB0iCDiiTc0B/oHF1IqoHmidX7RTjHtamXtYr
	 sEcuqnqVwY6rCTv1AYo41RvmTbVdNVict/dtK3laPE2HQjbKC/XeEMtFBfEfTzssUyygo
	 VUlQCXvbsy4NUc5xAWo+wqP3hCW4mfgYaqCENeM39LPgwyWs96k0RDa77ZkxiTwNZZ18B
	 TK26PQIBzlEhFeTMNjZ/QBFQMwyNdsY5WBzR/2TJPLfcqpA3fZ08IF7M1J+OvKQzQJ3Lj
	 esZ1vultEmIN6knteSzw8v9GIyoZuS/OQTzaLP01AHZjZvATOL2JBCO+n+GYjZ+WhWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F+5WWgPW;
	arc=none smtp.remote-ip=95.215.58.5
Received: from mta1.migadu.com (out-5.mta1.migadu.com [95.215.58.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C088B606A32C
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 08:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C088B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F+5WWgPW
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=y8BgwjagvHGf78IlM6ng3nm9vDTk3b3hu1EyL1SF7ec=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793608174; v=1; x=1794212974;
 b=F+5WWgPWHTgZkLOdWp34fjp8vKNTzLwWGqZ/4900AI/b1FTmGpR1sFpQt8SzIiPVy20OvRLv
 h7fwwNHkpAZeLqoAxkwBPghJibjqFi5yr5vvVF8G2NWNsTRh8Fx/D44CNgsqKctPTHRQgrIphKQ
 IaHcegGiTwV+63OFDSO3Vjy0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eddade33f188acbf;
	Mon, 02 Nov 2026 08:29:34 +0000
X-Mizu-Trace-ID: eddade33f188acbf
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Eric Auger <eauger@redhat.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Will Deacon <will@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Sebastian Ene <sebastianene@google.com>,
	Fuad Tabba <tabba@google.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] KVM: arm64: vgic-its: Update GITS_CTLR.Enabled under its_lock
Date: Mon,  2 Nov 2026 08:29:33 +0000
Message-ID: <20261102082933.2673799-1-fuad.tabba@linux.dev>
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

A GITS_CTLR write that disables the ITS clears its->enabled and
invalidates the translation cache under cmd_lock, while an MSI
injection tests the enable bit and populates the cache under its_lock.
An injection that passed the test before the disable can cache its
translation after the invalidation, and the cached path then injects
the LPI from the disabled ITS on every later MSI for that event.

Take its_lock around the store and the invalidation, so that it
serializes the store against the test. Nest it under cmd_lock, as the
command handlers do.

Fixes: 86a7dae884f38 ("KVM: arm/arm64: vgic-its: Check the LPI translation cache on MSI injection")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Link: https://lore.kernel.org/ah6Lsi4MfKUU6wBR@v4bel/
Suggested-by: Oliver Upton <oupton@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---

Notes:
    Changes since v1 [1]:
      - Reworded the commit message.
      - Rebased on 7.4-rc1.
    
    Picking up the fix Marc was worried had stalled [2].
    
    The GICR_CTLR.EnableLPIs path has the same window and is left as
    is. vgic_its_invalidate_all_caches() can't take kvm->lock there (it
    runs with vcpu->mutex held) or config_lock (the userspace GICR_CTLR
    route already holds it). Instead, the vgic_target_oracle() check in
    my LPIs-disabled series [3] keeps an LPI off a redistributor with
    EnableLPIs clear. The two don't depend on each other.
    
    vgic_its_free_collection_list() still leaves the cache alone. A
    guest reaches it only through a GITS_BASER write, which already
    drops the cache (8cd92f77ae4f). An ITS reset frees the devices
    first, which drops it too. That leaves a failed collection-table
    restore. A VMM gets there with translations cached only by enabling
    the ITS before the restore, against the documented order. Those
    translations then keep injecting their LPIs into the old target
    vCPUs.
    
    Based on Linux 7.4-rc1 (6628e7d4c6b25; also applies to kvmarm/fixes
    79f3724ca8913).
    
    [1] https://lore.kernel.org/all/20260917162020.1612577-1-fuad.tabba@linux.dev/
    [2] https://lore.kernel.org/861pbr6emw.wl-maz@kernel.org/
    [3] https://lore.kernel.org/all/20261026092802.2636798-1-fuad.tabba@linux.dev/

 arch/arm64/kvm/vgic/vgic-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 7e9b265b1f521..68e3034e52236 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -1800,9 +1800,12 @@ static void vgic_mmio_write_its_ctlr(struct kvm *kvm, struct vgic_its *its,
 		 !(its->cbaser & GITS_CBASER_VALID)))
 		goto out;
 
+	/* vgic_its_resolve_lpi() tests the enable bit and caches under its_lock. */
+	mutex_lock(&its->its_lock);
 	its->enabled = !!(val & GITS_CTLR_ENABLE);
 	if (!its->enabled)
 		vgic_its_invalidate_cache(its);
+	mutex_unlock(&its->its_lock);
 
 	/*
 	 * Try to process any pending commands. This function bails out early

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.47.3

