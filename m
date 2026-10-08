Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED663497398
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456169; cv=none; b=CZ2BmRO3Xy6MFitxTtjCW2w2d9klqExenDWXsg/3Iv5zK4N2aUT/RVMoFSWSQGSCu1jOnv0tX1tcZVZ14/IUG4P6sHvwva4hLbrvrYO78/NNL0S5smOCFlH1Ad1n9YRI6OFzgkc9Y3BzgfphVuOjueI+3bSSdne9TVavd+lUyX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456169; c=relaxed/simple;
	bh=Pc4BNRTJOTAvPAzY24OovCuqd7bgTd/I0IOAu7zieiA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H+jlhIPUOboFdh2Oj+F/UWpCY0nvmsDi+Us/0p5cw+p/VPzP7EJQptIL8QyiNP67ZuWCLs5uP3ZXjfXyeEskN4oOmftrehY5I2QFRgLIAdv1ioEywoPEBFBKcBh9MVV7oGnJsaBUNNbrCXYuK03O6nszGGKn343B61mNIrCLjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cnVbYbo7; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cnVbYbo7"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a170fa0879so31260885e9.3
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 03:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791456166; x=1792060966; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7A3TCDs1xynx1LpYwQyPlW/nabg1O3gtjbirRm79U8s=;
        b=cnVbYbo7Ddb4l6lnhBcbs5k+IVOhvB+rHbapoTVk4bOqGeNu6A9frlteaVksEE+uNS
         WgpBSkMzH3+7MK90zqAem56epcHqu4WIJQ8D2daTljp5YEyyISiFS8UbdN76iVWMQ/VE
         2KhTAe1Aw59WDIFOeW+4bfMPJPNYhHnqObmHx2t6XkV2zPtyLq3QkyEz3zb760z0T9th
         kq4a3Y550bjNDeugw7iwXq8hgRkYw4h9nCqG3MT/t/zkqdllO1mzbAKIrlMrdI6ub0k5
         zCkOYICK2eMX50D/MlNu8nVna1gbxy07nuzQF2kKKY+qPBpaQPMOoRF7iSIO+GqkVku2
         T40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456166; x=1792060966;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7A3TCDs1xynx1LpYwQyPlW/nabg1O3gtjbirRm79U8s=;
        b=YF8c3U16d8AXrmyRV/qwWsrvr+SUfWV+x1Mrep5XJYlJ+ReRjFn0ooXp63gkmPMU6x
         OLFVrlqP24BmCjKrNOZJnj9XEAhr9eg3K4aJLsj6jH0qIeYyZnH1CZ44RIHI/acN3QAp
         w9+Zq2qdaDPQph2r7nUOZcTLc0jQU2hXN3gTJ9U4Cdd9fCyI1Vc8zpuykkfFYxy/og98
         W6xWrfITNZ7hjpIdNbZMuuwR6+SbVSbkT9epJzXk/qCtOCqGNhocdHtRPP3W/rJ7JYPC
         vDCSaO4/+FZHFj8NHMnBwB0NObnHErBiMgFbd7p07zJAnX5bb1N6Vcmht27deEfAD7Jp
         Rciw==
X-Forwarded-Encrypted: i=1; AKwUvBwVDKm74OrCP0qbqNAWaWG7fwR0LnsBMNtlgrDSBXTTHZRceba0kJi8U0iO6d4DEApVZNqJKEo=@vger.kernel.org
X-Gm-Message-State: AFuF++nC43+S3JFlXn8t8X5xy7IZ34+EeAa1PkqQ/Rcpmy0ip6eegjqb
	VIN/0bCYpowROsMCRXo5TrklvSMYveHULSQbWb8O0CMME9aipP8rXf2aGyWbRmqxT0Q6aSDcZKY
	FnQs4fBIzB9UJoJ9gS7aLGg==
X-Received: from wmol7.prod.google.com ([2002:a05:600c:47c7:b0:4a1:708e:7d78])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c0d:b0:4a0:1efa:c74c with SMTP id 5b1f17b1804b1-4a18043c6a5mr113186995e9.20.1791456166130;
 Thu, 08 Oct 2026 03:42:46 -0700 (PDT)
Date: Thu,  8 Oct 2026 11:42:11 +0100
In-Reply-To: <20261008104212.3134550-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261008104212.3134550-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008104212.3134550-2-vdonnefort@google.com>
Subject: [PATCH v1 1/2] KVM: arm64: Prevent 64-bit overflow when computing hyp
 clock rate
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	kernel-team@android.com, fuad.tabba@linux.dev, qperret@google.com, 
	Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The hypervisor clock rate is delta_cycles * NSEC_PER_SEC / delta_boot.
It is computed whenever a deviation occurs. If the delta between two
rate updates is big enough, delta_cycles * NSEC_PER_SEC will overflow.

Prevent overflow with mul_u64_u64_div_u64(). And as a bonus, simplify
the clock estimation with mul_u64_u32_shr().

Fixes: b22888917fa4 ("KVM: arm64: Sync boot clock with the nVHE/pKVM hyp")
Cc: stable@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 arch/arm64/kvm/hyp_trace.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index 9241d5a325fb..26fc13c16458 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -60,14 +60,8 @@ static void __hyp_clock_work(struct work_struct *work)
 	if (hyp_clock->mult) {
 		u64 err, cur = delta_cycles;
 
-		if (WARN_ON_ONCE(cur >= hyp_clock->cyc_overflow64)) {
-			__uint128_t tmp = (__uint128_t)cur * hyp_clock->mult;
-
-			cur = tmp >> hyp_clock->shift;
-		} else {
-			cur *= hyp_clock->mult;
-			cur >>= hyp_clock->shift;
-		}
+		WARN_ON_ONCE(cur >= hyp_clock->cyc_overflow64);
+		cur = mul_u64_u32_shr(cur, hyp_clock->mult, hyp_clock->shift);
 		cur += hyp_clock->boot;
 
 		err = abs_diff(cur, boot);
@@ -85,7 +79,7 @@ static void __hyp_clock_work(struct work_struct *work)
 					    err / NSEC_PER_USEC);
 	}
 
-	rate = div64_u64(delta_cycles * NSEC_PER_SEC, delta_boot);
+	rate = mul_u64_u64_div_u64(delta_cycles, NSEC_PER_SEC, delta_boot);
 
 	clocks_calc_mult_shift(&hyp_clock->mult, &hyp_clock->shift,
 			       rate, NSEC_PER_SEC, CLOCK_MAX_CONVERSION_S);
-- 
2.56.0.360.g66cac248cb-goog

