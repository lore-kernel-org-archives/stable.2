Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E94C3603DB
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 01:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783992322; cv=none; b=JzSIBui+ySS1e9Thf9Ux3pFr9pD5cUngzPVbXfTi6PJsNVS0cn0r5kBYsQNh1khD2TDg3wWFsB2lRxEip4I6wPgzcOorhD8guHh4A1Gqz8t4/M1RFdLjmO5FPjOwPNXzk3fU7ElB7lx8u7wALSWY2JaSaW9RSRgqBUVD86/89Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783992322; c=relaxed/simple;
	bh=UpIskQRoRZw0G4kaCZaIbGuZ8Rx1AzltxvgIihmUHXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xk3thp6RP0NbRCZV8KUkM+0Su8+5LZzI6WsvlVdWLPyqM5T/dseAz6uiQ43atCSqKiApnSnxbP1WEiUy+EVpWSO82xpoj1dyGNqR5/P6GMslHaX4ztPUkHpETE/BiWEG+3mioWaTgZVA9ExtBDb56O5TZrSxKiOCk/2Aj+8lu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GprTZaZ+; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GprTZaZ+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783992319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7yhxlaZt1DrXHjwOpFmxqrX4pBx4t6nDZd/DzMtksX4=;
	b=GprTZaZ+XL1q+oicodSCvWXe3UDAfk7YT/VZySSOtQi9YTwdnNO0GKssBE8/LUvxSr3xo7
	+Sx5w1dA5CjFDhQmHnjmMzjhJ11Nf1I3ssD5m7t2BZxvtAK+U0GPekssKLHKKOHWg0wcP6
	0ZjbhYddQQ11344nnk98tXJqpBQFBSc=
From: Tao Cui <cui.tao@linux.dev>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn,
	chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	lixianglai@loongson.cn,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 1/2] LoongArch: KVM: EIOINTC: clamp ipnum to valid range in INT_ENCODE mode
Date: Tue, 14 Jul 2026 09:24:51 +0800
Message-ID: <20260714012452.1021833-2-cui.tao@linux.dev>
In-Reply-To: <20260714012452.1021833-1-cui.tao@linux.dev>
References: <20260714012452.1021833-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

The IP-number decode in eiointc_set_sw_coreisr() and eiointc_update_irq()
clamps ipnum only in the default (1-hot) mode. In INT_ENCODE mode the raw
ipmap byte (0..255) is used as the index into sw_coreisr[cpu][ipnum],
whose second dimension is LOONGSON_IP_NUM (8), so any ipmap byte >= 8
accesses the array out of bounds.

The value is guest-programmable through the EIOINTC virtual extension
(VIRT_CONFIG enables INT_ENCODE and the IPMAP IOCSR write is unvalidated)
and is also restored unvalidated from a migration stream via the
LOAD_FINISHED control attribute, resulting in a host slab out-of-bounds
access reachable from an unprivileged guest.

Clamp ipnum to [0, LOONGSON_IP_NUM) in INT_ENCODE mode as well.

Fixes: 3956a52bc05b ("LoongArch: KVM: Add EIOINTC read and write functions")
Cc: stable@vger.kernel.org
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/kvm/intc/eiointc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
index 2b14485d14a7..0c34d7ab264d 100644
--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -17,6 +17,8 @@ static void eiointc_set_sw_coreisr(struct loongarch_eiointc *s)
 		if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
 			ipnum = count_trailing_zeros(ipnum);
 			ipnum = ipnum < 4 ? ipnum : 0;
+		} else {
+			ipnum = (ipnum < LOONGSON_IP_NUM) ? ipnum : 0;
 		}
 
 		cpuid = ((u8 *)s->coremap)[irq];
@@ -42,6 +44,8 @@ static void eiointc_update_irq(struct loongarch_eiointc *s, int irq, int level)
 	if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
 		ipnum = count_trailing_zeros(ipnum);
 		ipnum = ipnum < 4 ? ipnum : 0;
+	} else {
+		ipnum = (ipnum < LOONGSON_IP_NUM) ? ipnum : 0;
 	}
 
 	cpu = s->sw_coremap[irq];
-- 
2.43.0

