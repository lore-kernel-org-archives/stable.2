Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795814897;
	b=aOhHeKHJgMk7u9K3VLKGkZt2BvStBr+m5nEDTqHYcIhUxmyypAFQA9Yysbo+X9WBdpOT
	 Nnq6w4G1NaDgBqyvgiUk3fOqNlL0r9F/oW5DnOwNxY6lbmdVszbWnl7PnqRhBzquwA6vM
	 s1+1FHBak7AUpIVVO76qaubDzhvCIOLybsPi4xujY8mskMKzpvP4qLOTnC1HR6Uy+I3XP
	 zewsmV1z4ez1YYnrIjQGZG3M84BGOu56uiEhCDXtDvFZmR3mA5FjlZTuwWemxGnnvMKz1
	 twM0IvR79SIc8hlK7dG5E/7EKTT+BWDcwViHlXYonstbRnX8Ds8hCXgNncaplASj8vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795814897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=+mb9rF6VJRzXR4i4y89PW+yVWJyrkXOWuPHAFuVlX7c=;
	b=BP+AmNobwkmw8DwdwO83wLq9aujEGip9+4+B1xZN8mnurwIRtQ814hVBxRVX7qz7Di90
	 zL4VOcpCBOVCEKCOHgxH8ClI3gaVLiB8fHChdH0+7evYIq71+32hGnNc19QVCd0/cxEEJ
	 pYQa6nDtveS0LifeUE4fgX4GBFZVuk+9gHsOED40Ai+K0p7x6WFCdt4bjtl/o5MHsZmoW
	 KTV+iiq6I1qf7AFg1NC/8taYEzPwB3N11VJ50HYAdffHwU2/aBOBGa0o+IdUkrkbETTpQ
	 aTUPS178Pc46W1V8lW/N3ZvNorFOtPNHvhrXPR3ZFo4MJBwIwIw+TjuBkGaUzdb0sTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WdnTQM0m;
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B8606A31F
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 21:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C6B8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WdnTQM0m
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c505eecba6cso665727966b.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795814895; x=1796419695; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+mb9rF6VJRzXR4i4y89PW+yVWJyrkXOWuPHAFuVlX7c=;
        b=WdnTQM0m8LO+yuAjtAy0mmfS+ur+8+5LknV4Mw7UCvU9eLgcLVWZ3iOMkEuFrCgcbk
         NR7hjGIHZ9GioNtrfRxRleS9JtbGFc4u+UXFzeYcSIl2/MCLSTBfXEQcte3k080g+D9A
         H4FWpjW+deZRCbxbavWRsVbWQYH8ijvWp8rKQOSzwH4qxLo7a31c9Q/j03cyrvodpEE8
         3Hk0bIgtEee8uGOs9bVCRrlUjHzdCDbwdKEF2msUbRWcHNAc48slGiXNrJlCLRoQ1GWm
         oiRZ/PKkbOCHDklImmf037sZ4amMhrwIRDcX8G9hg/T09rUgpjRZF3CUGHW9wiaKEoeP
         nw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795814895; x=1796419695;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+mb9rF6VJRzXR4i4y89PW+yVWJyrkXOWuPHAFuVlX7c=;
        b=OqeTPqYmd6Crf66DN6Td4ScATKU9C4wvqHHfVx9dXJ3waEDOld1E0xEUmJnz9DhQ+T
         qtoTIxVLujKctb4ol8bs6cHAzkfm91ZYVJcm6yXzN1g3ATeiWGMR+D/DuqCVVRm7JD0J
         gyEsLUMQSTt1aQI2K9XuAhQ0B4+9ERpbHM+Q8+EPsdrmQzEdOzE0fmu+iGLJNi+iF3+r
         Bc5O1NZo9mN+uKqnm3biuJOwabbmT9O3s4//Jc0bxzemVM/Z5AcXbt3qazaBWBHPN45X
         SsHxxNF3LlJqfyKTnHN1PhJskBfezuqK9sWvhqHfnM7iFuKC7VVKmK6D1pheBspmVgF0
         aitw==
X-Forwarded-Encrypted: i=1; AL+hErGFttYXvrW9xzuBlKu1GgUOXnzjVdMon0vfgbkWwL5aVkXirGQZ6TwqLuiFMI7q/h0yvrwHdXI=@vger.kernel.org
X-Gm-Message-State: APuU4Z++jH5djTL7wUNIUJZswkgRkv/DfMsc7QAkYs3byjf+yCBqhaVr
	6S04VkyIgiptREBUCiJwxJbvSyOgegXP8J7E51fGwVBkepQtvLIBdLzapiewniWI34gv9iIwbPV
	goh7Pcq+R0rHaIxGh+uIU6w==
X-Received: from ejbbx9.prod.google.com ([2002:a17:906:a1c9:b0:c50:487b:9fb8])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:c10e:b0:c41:5e31:5184 with SMTP id a640c23a62f3a-c513a99abe6mr2130168566b.13.1795814895264;
 Fri, 27 Nov 2026 13:28:15 -0800 (PST)
Date: Fri, 27 Nov 2026 21:27:43 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261127212743.1139739-1-vdonnefort@google.com>
Subject: [PATCH v1] KVM: arm64: Use CNTPCT_EL0 for hyp trace clock
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	kernel-team@android.com, fuad.tabba@linux.dev, 
	Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

trace_hyp_clock() reads the virtual counter (CNTVCT_EL0). Under nVHE
(and pKVM without hVHE), loading a guest with a non-zero offset applies
that offset to CNTVCT_EL0, corrupting the trace timestamps. Use
CNTPCT_EL0 instead.

Cc: stable@vger.kernel.org
Fixes: b22888917fa4 ("KVM: arm64: Sync boot clock with the nVHE/pKVM hyp")
Reported-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 arch/arm64/kvm/hyp/nvhe/clock.c | 2 +-
 arch/arm64/kvm/hyp_trace.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/clock.c b/arch/arm64/kvm/hyp/nvhe/clock.c
index f3e2619db4e4..ea4412e6737c 100644
--- a/arch/arm64/kvm/hyp/nvhe/clock.c
+++ b/arch/arm64/kvm/hyp/nvhe/clock.c
@@ -54,7 +54,7 @@ u64 trace_hyp_clock(void)
 	u64 bank = smp_load_acquire(&clock->cur);
 	u64 cyc, ns;
 
-	cyc = __arch_counter_get_cntvct() - clock->data[bank].epoch_cyc;
+	cyc = __arch_counter_get_cntpct() - clock->data[bank].epoch_cyc;
 
 	if (likely(cyc < clock->data[bank].cyc_overflow64)) {
 		ns = cyc * clock->data[bank].mult;
diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index b9404496f977..06d6bd7aeac7 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -510,8 +510,8 @@ int __init kvm_hyp_trace_init(void)
 			per_cpu(timer_unstable_counter_workaround, cpu);
 
 		if (IS_ENABLED(CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND) &&
-		    wa && wa->read_cntvct_el0) {
-			pr_warn("hyp trace can't handle CNTVCT workaround '%s'\n", wa->desc);
+		    wa && wa->read_cntpct_el0) {
+			pr_warn("hyp trace can't handle CNTPCT workaround '%s'\n", wa->desc);
 			return -EOPNOTSUPP;
 		}
 	}

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.56.1.839.g22a8290db9-goog

