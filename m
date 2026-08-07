Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244C154458
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786071349; cv=none; b=GCCBQGx2e7uYFVgpt34TLukn7bHrAzG5xTolAA6X6bXu85+sdfcaBmV5sN15nt2oFrVuS1np1NuAadTVKxnSzWJjoIDdHXUBv7RJGuB4Qkrcnt4B4A5fAq32fo0XJqtOJ6X1uAOgRJQtu2adYR7PL9eYZbWAE2r/aq9Jxp00BZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786071349; c=relaxed/simple;
	bh=ehfupAjiBlPbXzgN3KQshK2fO0ZqW1VYU2bmsKIMqxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQaBEbmR0D4Igtq5hV8I4XDexUc6UUdsyrm7i3qjKNrEtqLKvyVy1HpHFnyVNyTTC6dp01Z9f8O6go90DvD/cUU6cd8VIPSbv1lPBy7XBtScYVrhXM5pQtzHAGIc9U/kbAqDsRr8M9oqd2s8o6aYXrKz+MWUVEcsymEuLHGAwCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XioJjH09; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XioJjH09"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e252fbb7bso462441b3a.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 19:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786071348; x=1786676148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pIGWzVgFBhi3QS++pGVJA0SUneFjy47jOKVOvjRMiOA=;
        b=XioJjH09zN590ZaYVtlWpRkzwrTZpP/xG2quAqqDWWtswCc7Q8I7YpNyUM323H3U8/
         QVBn/iGx58VJeGyLuVzKcKIlCIVYzbeRuml/Bs0dUH++hvbneGEWp2a4Y308mNIp0xhk
         GnCZauaVpgRCS+u8npq4wSdg/hK5HMFCbdOAVfwSKUGgNSxDIuutqzg6IvBSyf25foNw
         PJYDXv9DKiRO9xx+/i2X5tqpIdH5i1tLgt41zVULVHVWk8ao7o0CypfEorhHcKaNly5S
         QLUxlUU/2WpR1NDsmZq6iUwBU1oWYEUSNpnmsN5uPRU2/P31Lg/X58o1jLkRs1V4X+ab
         rXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786071348; x=1786676148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pIGWzVgFBhi3QS++pGVJA0SUneFjy47jOKVOvjRMiOA=;
        b=ivuPRHXu1/yrwnqZ4zvieAbycP6hp8Hmimr4HRoPJXMiEkpofY+2w38zom2AGmZI5n
         NDodie97tS+/wmZMVQXLz2coDY9xRTykO9H8QgkiCrhT410FTM4m6tC/2RLGKY/ALo8N
         OCtxNhhse4tYcmYbknXMtmvQJ2sbd2Y31IfAxBNtSE/YWrwDhYAIuhcALOd19G5Z2Rrt
         3Esn7LEM7r9ml9FWWc15Q3wbkdQtENdWtsJNpJl3RJWOhVdGNq2RpM0dCjgBqqnl1+Ba
         3XjOEtTaf+JMFZTIaCLwl5YLaRLqcbvDqfMo66cLLP0O1KcMXY22PIyajchF/MtPyaF8
         FnAg==
X-Forwarded-Encrypted: i=1; AHgh+RrCvruxsdt5kxw6YACEUrmGKZHpwEcuXGDsI3fXnLa6naOxpP8IIXPaoh9nGtQM9FnPHRr1I18=@vger.kernel.org
X-Gm-Message-State: AOJu0YycbkSCy7LOcSbA98hy9fk8EYyHOXjhNo8TilJDh2NLms+VXxee
	ezzdD9TPttT4MxcXLSapUJ++GYYk/hFZwUk+KlRitecOU1l5oBUl64yg
X-Gm-Gg: AR+sD10/g0UhSO9rLwkIyIqTiAWMhEC/LJ0KqaEmlf7YaxuonGQkU4n9UBMwRzgFRt/
	nwvod3Ka03a1DbJq7TCEAmm4L4gEfyn00N4Wo1mOvu8hVR7Y1PcM39FyPZu+BbAFmG997aHYlR7
	rKi//oZVvC0gyszVFU6bLGO2Qlz9Fsko8MxidULiGgY4zgRWXxMVzgbyDDbTCwbo5UMNYEAH59B
	8qF+/hDBYW3TDIKZ1+oTp3ABzz9BjwmTf1lNUqY85XYGKjF066ZfDE5MeGs/QO/fH3v8FlPdMIq
	Q/OLR0KEFEieMBoyrqbtZ0HOwLenLVXYUo0hde6jmRdhFlW0iB6voDBwJFIeMyPxYPJS/QBsQk2
	7Mt9t4Wfmd5e360irX55kECpn1Mu+wRIGbuxnsVhVBhA3vx3EVFIQV9awQMxq2o54TY7ZXiLcbc
	z9+DM9pEh4khEa2PUxY8DZCmtwk7JIpdFaKcI7DAgMFGISo743oBusSkSoVRbsi02k6NJX0fRZ3
	pNsPx+XW2qxnIq4Ary3bXM+UiKxyOW3ijBa0F6WLSB4HtBBc+U=
X-Received: by 2002:a05:6300:648f:b0:3c6:61b9:9162 with SMTP id adf61e73a8af0-3cb863e0633mr15912712637.3.1786071347910;
        Thu, 06 Aug 2026 19:55:47 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8bbfc330sm143385a12.27.2026.08.06.19.55.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Aug 2026 19:55:47 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: maz@kernel.org,
	oupton@kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Qihang <q.h.hack.winter@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] KVM: arm64: vgic-v3: take an LPI reference in vgic_v3_save_pending_tables
Date: Fri,  7 Aug 2026 10:55:34 +0800
Message-ID: <20260807025534.34125-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vgic_v3_save_pending_tables() iterates dist->lpi_xa using xa_for_each()
and dereferences the returned struct vgic_irq in the loop body without
holding a reference on the LPI.

The xarray iterator only provides temporary RCU coverage while looking up
the current entry. That is not sufficient for this loop body, which reads
fields from struct vgic_irq and performs guest memory accesses before the
iteration completes.

A concurrent path can trigger this race: the irqfd cached injection path
(vgic_its_inject_cached_translation) obtains a transient LPI reference
via vgic_its_check_cache() without holding kvm->lock, vcpu->mutex,
config_lock, or its_lock. If guest ITS DISCARD then drops the cache and
ITE references under its_lock, the transient inject reference may become
the final one. When vgic_put_irq() drops it, the LPI is erased from
lpi_xa and freed via kfree_rcu(). Meanwhile, vgic_v3_save_pending_tables()
may still hold a stale pointer obtained from the xarray iterator and
dereference it after the RCU grace period completes.

Fix this by re-fetching each iterated LPI via vgic_get_irq(), which takes
a stable reference, and dropping it with vgic_put_irq() on all paths.
This matches the pattern already used by other lpi_xa iterators in the
vgic ITS code.

Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 arch/arm64/kvm/vgic/vgic-v3.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

v2:
- Add Cc: stable@vger.kernel.org as requested by Marc Zyngier

diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 9e841e7afd4a..c3a5e2f1d09a 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -605,47 +605,53 @@ int vgic_v3_save_pending_tables(struct kvm *kvm)
 	}
 
 	xa_for_each(&dist->lpi_xa, index, irq) {
 		int byte_offset, bit_nr;
 		struct kvm_vcpu *vcpu;
 		gpa_t pendbase, ptr;
 		bool is_pending;
 		bool stored;
 
+		irq = vgic_get_irq(kvm, index);
+		if (!irq)
+			continue;
+
 		vcpu = irq->target_vcpu;
 		if (!vcpu)
-			continue;
+			goto put_irq;
 
 		pendbase = GICR_PENDBASER_ADDRESS(vcpu->arch.vgic_cpu.pendbaser);
 
 		byte_offset = irq->intid / BITS_PER_BYTE;
 		bit_nr = irq->intid % BITS_PER_BYTE;
 		ptr = pendbase + byte_offset;
 
 		if (ptr != last_ptr) {
 			ret = kvm_read_guest_lock(kvm, ptr, &val, 1);
 			if (ret)
-				goto out;
+				goto put_irq;
 			last_ptr = ptr;
 		}
 
 		stored = val & (1U << bit_nr);
 
 		is_pending = irq->pending_latch;
 
 		if (irq->hw && vlpi_avail)
 			vgic_v4_get_vlpi_state(irq, &is_pending);
 
 		if (stored == is_pending)
-			continue;
+			goto put_irq;
 
 		if (is_pending)
 			val |= 1 << bit_nr;
 		else
 			val &= ~(1 << bit_nr);
 
 		ret = vgic_write_guest_lock(kvm, ptr, &val, 1);
+put_irq:
+		vgic_put_irq(kvm, irq);
 		if (ret)
 			goto out;
 	}
 
 out:
-- 
2.50.1 (Apple Git-155)
