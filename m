Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429838;
	b=SgQJupIJzDY04uFna+n1s32UY+knX949JG8EkfODzAA58G7WG36I5A3DLYBqqy6zeFul
	 xThN/yqQqZo4XzGDRfiSA4GK8BuKgZIyr7TtY9GtNFgEHWOpHQpmdgypxGFqnXYZtgYZi
	 lCX4B604yCVYmbj1lrZ30skgwAMFc9x5LZMhI3OmwJ8HvEbuV0UWhKrRiClTmcxy0XmFC
	 Q/OqUug7cgK7tXaL2pUMnuwHRER75W5uCwDCISxCBlOk2Sv6Aox55Ff3FficEgf2TIIrh
	 uIWyMKH7zf5TNTmZ5g5qWy0QGpgd18sa3DGes0yuRgmvHRsNK3Lybby08kRpoMWvuwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=1xhgl5syMRg8qmPTHhAybLDTRj/xX0FiPUcwE+TXMJQ=;
	b=ds9CxDJ4XmLgCOYnKDnL3qoSeQ/qBUwJqxhZBJKH70q/J+hPA6BsRj0f/tzDYWVs0ClI
	 ELImmx12mh+JpA+wdEKbTDrGWoOqNEw7RsQxf18MNzDK+f7cFca6gOfB2z3sqXAbPSTpu
	 i+bB7M3bQY3wiGu0bscAxnnLJHTP5w2xN8Q0sJNCIFgusH8NOQKabcU28+lKkjgAJnIdZ
	 Yc2Cp9WOjRsa2iwoFx0UHRVB3dbs4MfEb4sbFyWTKEeNWVwoB4hdXTwTt7+9qtDZ9a9K8
	 2q8667ISp5Y1j2oAJPQRsini9Px0Ad/zc7gD9eoaLIIgRtYQqlzGp0zBclWFJsXBGIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=OD3yplvW;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A410606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 10:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A410606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=OD3yplvW
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so5207994a12.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 02:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795429836; x=1796034636; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1xhgl5syMRg8qmPTHhAybLDTRj/xX0FiPUcwE+TXMJQ=;
        b=OD3yplvWh4GhIAmmLmVT1SVFODJhg0984JVKDMbgGjfli/sxxcLYqheob/iC31pENZ
         KEADHEMOU667LpIS+NqmkmGIE8YxSeBfigPWS+wx6ansnRtURYITc+BgYYzJzM1ip3eX
         kzUYwW/BE+iX+yU096DI5BbgYn18/Ixdg9ujqrgcIT0TV0KBXj8fyGZBwLL4RKkaq5kn
         3MbT0vfvUJp9AZBLJNRJy9wkM9MsL01fnhO5mW8xQDjESFOJymjkndn+IOaGIy5a5Hs7
         CxoJNLplT7M1PxpPhXDaTibixamuhjYFh6liRRjRfQfLvgn3MllvdrboGURdifD0zYXL
         vmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429836; x=1796034636;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1xhgl5syMRg8qmPTHhAybLDTRj/xX0FiPUcwE+TXMJQ=;
        b=sJrbpHkc3XSqK7cT3yZ1Jwz3joMnq3ngIZ0I5lM5s078Lr4LZpM+bE6mh+2ZC3FXNZ
         wrEMuZQJ3dwdseK45jqzkvL6AD8KC7xiNGkbn7rCohmpd38N9gHZy3LQMOhN6cDokib+
         EdnrpAXSuouFF8FIhCrwSBfUoh0GazuXrqu3HlqqJEn4cl/R1YCdCSn3D1S7DVNvRzma
         tYY4MOp9AfAz7bp+MRKIr95l/u/roWweQ5h3A9+y53QebnQMpJVOzyhykS3fr3WE/fjy
         vT60OEbHIWeod5ISylRiOOW5fDWgftTZ59Ks6WeTl2eAN/6qlH31a6TWZn0pqeqchRWi
         3nDw==
X-Forwarded-Encrypted: i=1; AL+hErHyce5hqNwYu1vGzlxiUFFI7aGi/4OSLweTeof6yL+4ZOAY5VJ/gHNkZwVE57noecgw7GnT4bs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xgIse4miPVBqqobTtM7Rs23NE9mcMU81BggWPzmSnEJ3Y9zhq
	whonP1J/mccdztww1M6JiiTm6E64flUt7YDuJlj65QkGgCc/dmP/rTDB2mN5tta42Ug=
X-Gm-Gg: AZFdTZeCuiiuRRISgwJbbJ9zvetAI30Saq80KHWi9XAcrHiI5DcdvjsDzPnD+DW8lks
	fi6wZyQLCqoo/JVhCDWXDFNdsGG86JX+fV9Bx/LbHygbUP1QacMy1XjP6enYR15JUBCmceeKSsS
	Ylrg1cMCpjVn+euXKkzx5faq/m5A7KeupNQX0AIOZY3O6Yu0beqxhep/hcHiiK2C7KRoQzkXGMi
	r4s0a2o4oWhA6D4/oCYuVoGetG6bmbELE6ZeLJoLttol7n8J23drdMc+4MB6fbNBSehdBXwd/tY
	YVsBONdwnQcgtJ5h6OiIjMQ9yHtAgKbIzSDVQ8ODE9m0/+MqLwwqpn5/dyOazH74sOlI+I6jLPn
	A0Q91+zdj9oXZa5BlA9CEddW9X5q5flCvVUmyGA4ypAIEUyRBOd37mFqmSplAunOa2VjXj4ju+J
	lXZeL1uQE97CGfTQNpRL6vfMflmlcF3lpKgtpzL1fxHsmJqUq4y+sAwhXXYs/Aq2y26G1eK34PQ
	UWd8I7VYfygfsP7tlMpyFg2inNEAkHxLXsnsQm0M8Ox04/mF+fiwLAuCqmsWRu9SRinbbJ6g1yQ
	gpFle6NOR8Z4bgy8z30=
X-Received: by 2002:a05:6402:28c3:b0:6b3:b10c:40f9 with SMTP id 4fb4d7f45d1cf-6ba37e9532dmr7417775a12.31.1795429835843;
        Mon, 23 Nov 2026 02:30:35 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba854bed08sm2967549a12.30.2026.11.23.02.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:30:35 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Mon, 23 Nov 2026 13:30:16 +0300
Subject: [PATCH] KVM: arm64: nv: Never invalidate less than a page for a
 TTL hint
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-inval_range-v1-1-815e15797089@pereq.eu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02MywqDMBBFf0VmbSAPFOqvFJEkTupISUvGSkH8d
 xPduDz3cTZgTIQMXbVBwpWYPjGDqivwk40vFDRmBi11q5Q2guJq30M6K/loXAhWjgYN5Mc3YaD
 /aXv2F/PPzeiXoigLZxmFy28/leguKxXs+wF3KZ0pkgAAAA==
X-Change-ID: 20261123-inval_range-095bffa0d3e3
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>
Cc: Karthik Bhargavan <karthik@pereq.eu>, 
 =?utf-8?q?Cl=C3=A9ment_Blaudeau?= <clement@cryspen.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 stable@vger.kernel.org, Dan Carpenter <dan@pereq.eu>
X-Mailer: b4 0.16.0

The compute_tlb_inval_range() function takes the size of a nested TLB
invalidation from the TTL hint in the TLBI operand.  A guest hypervisor
can give a 4K level-3 hint, which asks for a 4K invalidation.  On a host
with 16K or 64K pages that is less than one page.  s2_mmu_unmap_ipa()
passes the 4K size to kvm_stage2_unmap_range(), which hits
WARN_ON(size & ~PAGE_MASK).

WARNING: arch/arm64/kvm/mmu.c:407 at kvm_stage2_unmap_range+0x38/0x60, CPU#1: ipas2e1_ttl_tes/568
Call trace:
 kvm_stage2_unmap_range (arch/arm64/kvm/mmu.c:410) (P)
 s2_mmu_unmap_ipa (arch/arm64/kvm/sys_regs.c:4246)
 kvm_s2_mmu_iterate_by_vmid (arch/arm64/kvm/nested.c:770)
 handle_ipas2e1is (arch/arm64/kvm/sys_regs.c:4258)
 perform_access (arch/arm64/kvm/sys_regs.c:4917)
 kvm_handle_sys_reg (arch/arm64/kvm/sys_regs.c:5455)
 handle_exit (arch/arm64/kvm/handle_exit.c:466)
 kvm_arch_vcpu_ioctl_run (arch/arm64/kvm/arm.c:1583)
 kvm_vcpu_ioctl (virt/kvm/kvm_main.c:4595)

The shadow stage-2 is built from host pages, so invalidating less than
a page makes no sense.  Return at least PAGE_SIZE.

Fixes: d1de1576dc21 ("KVM: arm64: nv: Handle FEAT_TTL hinted TLB operations")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
 arch/arm64/kvm/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 78d5b18dbd2d..e964b122e9d0 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -735,7 +735,7 @@ unsigned long compute_tlb_inval_range(struct kvm_s2_mmu *mmu, u64 val)
 	}
 
 	WARN_ON(!max_size);
-	return max_size;
+	return max(max_size, PAGE_SIZE);
 }
 
 /*

---
base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
change-id: 20261123-inval_range-095bffa0d3e3

Best regards,
--  
Dan Carpenter <dan@pereq.eu>

