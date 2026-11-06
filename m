Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976313;
	b=iOeGMn/WOkttDz4p5uQdcdueKPxkAVaM3SMweCkrLQ6To1sySa23YiItpQoBnRo9j9Cu
	 x9qkwg96trFoHY+uPjxwP2WIfLEUOitscpVt0jfMud3+utLcIe9yH56ilbvUM8ATD1HSl
	 kNniGx4xgzAqPKqUxoYGc7Qpg1YkpljaL7IKw8rfUubH+dE01qcUHHeT+7yLjZSPWLBys
	 SDZg7k1I7Y2SwvibN2ArKRPuIz791Ouk2lUfuljxt77FcHMTBOwga/g3GB/8ka2xdB0Ji
	 34gB4qYR1/Jq0FkQrEdM/7SbQkJWmLuCj7XHWU2f4a0aZ/PQbLPnbN543p44q9Lq6Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976313;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MAyMkCHNTjVelINpx+uKnqU8FFzztO2wWHuVY/Pv21M=;
	b=s1zWTDDe0bZjv530zSW0E8gt+18WQbY7sK41r7a+2G5EnVx1oki+wvDIEBc+fjUkDgvF
	 O8Xv9tzgYGI6JLe5RkRAy1jgXD1XMCZTvcWt7JEv8S7a35fqTNhkLMxe3RUWxplTR6CWO
	 3ggxOymzgFgFR5ldIPzZyx7L29pYHmXd4f0z4kyabBDFT86fGWauLCkRspdRFfSpBcr+W
	 D+h2lF4MRCt3d9iApyHuZQD3pfO6s/DZVLryApcTrReOfi7N34QfIRTmyIEGmFD6Rftp9
	 +MEHG+eKXmrlXXBbZoSVQdy9sHNIhkLJLUaZtvEBHduF4bmZLS1AmtYALyMoe9umCSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYqPhbmV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F8D606D807
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYqPhbmV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F25E1F008A1;
	Fri,  6 Nov 2026 14:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976312;
	bh=MAyMkCHNTjVelINpx+uKnqU8FFzztO2wWHuVY/Pv21M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eYqPhbmV5TkPRcmmZnWsKK2GfABCrfGo6TyhGXKgoQGlV3lbBHg+BLG5FYnlFuphH
	 RlIZQgYkenmDxTTgiW6wHv3WA/hQWCGMbf4aQQFppq/JvMhPV7slAs4tllR6sD0h1w
	 ZGq6WQV/ObE7yCW7BqYV6h1nZ5ae1+1bZczvXufJgpK8N3ls5ybJlEy82/q6QBVDzH
	 ORiVguHHGdMBy+GzhwUSkyu8INDfw8GMQww8y0U5dWAGuacchZMPsjyJv1brlAM/7E
	 L4eTvWuLgEBabC1Qlmc8ucstTLohWrfAPlEh2Ho9c3U91wPFWj1QKNBKxccJB4iUz/
	 9Wwlz8vqY20Fw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] KVM: x86: Preserve DR6.BLD (Bus Lock Detect) when delivering #DB payload
Date: Fri,  6 Nov 2026 09:45:10 -0500
Message-ID: <20261106144337.255276-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110455-refreeze-failing-83c2@gregkh>
References: <2026110455-refreeze-failing-83c2@gregkh>
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

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 719a1d58bf43edd03b271df90b67c58c1e9a7da4 ]

Preserve Bus Lock Detect if it isn't present in the payload.  Unlike RTM,
which is explicitly modified on every #DB,  DR6.BLD is modified if and only
if the #DB is due to a (coincident) Bus Lock Detect.

Per Intel's SDM:

  Other debug exceptions do not modify this bit.

And AMD's APM

  All other #DB exceptions leave DR6[BLD] unmodified,

Restore the explicit RTM handling that was clobbered by commit
9a3ecd5e2aa1 ("KVM: X86: Rename DR6_INIT to DR6_ACTIVE_LOW"), as the
semantics of any given bit are feature specific, i.e. are obviously not
consistent for active-high versus active-low.  In other words, while the
bug was technically introduced when support for Bus Lock Detect was added,
it's really that attempt to genericize handling of active-low bits that set
KVM up to fail.

Fixes: e8ea85fb280e ("KVM: X86: Add support for the emulation of DR6_BUS_LOCK bit")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260930193634.3415089-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ sashal: Replaced ex->payload references with the local payload variable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 52 ++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bbfc8ccf4fcd9..9dc0b1f3aa16d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -569,30 +569,37 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu)
 	switch (nr) {
 	case DB_VECTOR:
 		/*
-		 * "Certain debug exceptions may clear bit 0-3.  The
-		 * remaining contents of the DR6 register are never
-		 * cleared by the processor".
-		 */
-		vcpu->arch.dr6 &= ~DR_TRAP_BITS;
-		/*
-		 * In order to reflect the #DB exception payload in guest
-		 * dr6, three components need to be considered: active low
-		 * bit, FIXED_1 bits and active high bits (e.g. DR6_BD,
-		 * DR6_BS and DR6_BT)
-		 * DR6_ACTIVE_LOW contains the FIXED_1 and active low bits.
-		 * In the target guest dr6:
-		 * FIXED_1 bits should always be set.
-		 * Active low bits should be cleared if 1-setting in payload.
-		 * Active high bits should be set if 1-setting in payload.
+		 * DR6 is a mess.  Reserved/unused bits are fixed-to-1, and so
+		 * to maintain backwards compatibility with existing software,
+		 * features that use previously-reserved bits have active-low
+		 * semantics, i.e. clear the bit when the feature is present in
+		 * the payload.
+		 *
+		 * Further complicating matters, some DR6 bits are preserved by
+		 * hardware, while others are explicitly modified on every #DB.
+		 * The trap bits are always set based on the payload, as is the
+		 * RTM flag (but it's active low).  All other bits are modified
+		 * if and only if a relevant debug exception occurs, e.g. BD,
+		 * BS, and BT are never cleared by hardware, and BLD is never
+		 * set by hardware (when supported, excepting RESET).
 		 *
-		 * Note, the payload is compatible with the pending debug
-		 * exceptions/exit qualification under VMX, that active_low bits
-		 * are active high in payload.
-		 * So they need to be flipped for DR6.
+		 * Lastly, the payload does NOT have active-low semantics, e.g.
+		 * so that it's compatible VMX's pending debug exceptions and
+		 * qualification fields, and to avoid bleeding the DR6 madness
+		 * into other KVM code.
+		 *
+		 * To compute DR6:
+		 *
+		 *  1. "Reset" the bits that are modified on all #DBs
+		 *  2. Clear active-low bits that are present in the payload.
+		 *  3. Set active-high bits that are present in the payload.
+		 *  4. Clear fixed-0 bits.
+		 *  5. Set fixed-1 bits.
 		 */
-		vcpu->arch.dr6 |= DR6_ACTIVE_LOW;
-		vcpu->arch.dr6 |= payload;
-		vcpu->arch.dr6 ^= payload & DR6_ACTIVE_LOW;
+		vcpu->arch.dr6 &= ~DR_TRAP_BITS;
+		vcpu->arch.dr6 |= DR6_RTM;
+		vcpu->arch.dr6 &= ~(payload & DR6_ACTIVE_LOW);
+		vcpu->arch.dr6 |= (payload & ~DR6_ACTIVE_LOW);
 
 		/*
 		 * The #DB payload is defined as compatible with the 'pending
@@ -601,6 +608,7 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu)
 		 * breakpoint), it is reserved and must be zero in DR6.
 		 */
 		vcpu->arch.dr6 &= ~BIT(12);
+		vcpu->arch.dr6 |= DR6_FIXED_1;
 		break;
 	case PF_VECTOR:
 		vcpu->arch.cr2 = payload;
-- 
2.53.0

