Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976316;
	b=va+E96xn1PTcjZRfybcK7rAtLWsvJO8tIE44Yy03CgZ+c75zNyt39GVSZ0nZrQNVmtMR
	 wXN+vmmnHkO7Qix1HS2pgqD+UnxRyXYT58X+8pFUbpdt7rVVSvM5RcbLUFvw9T5Dr/Iig
	 CSYHWGO0ThxOqGeF7S/2s3hsZ/r0eW02+aYXQ/m7sfIC+a2ZMe9lEZ1Vx/entoQf7Ywj5
	 JaAMszi62EWEW06DOPIbAHB4EhZM3Yys67DBnr6EIXTV/gJJqJ6xXcVb5x4zaUxHZRUPL
	 gAnAtTkJiJhOaHU0VoXGG1NJUrR1gmcKgMA3xm9s8byjdq4vzliHAMSyrwIr5AMnL0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976316;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vXzMy/0XvlsXfc84AYJFfGyD7DFDjjSbnD66Q1/3qD4=;
	b=FLAr6alL/aJRlzz379W3MWZz8jBtMsS7ZW+LrvGJWPaESY6sUAhtBnU2aJkwtvxekt7v
	 QYk7K6i/gYUYJBUaH2bWILNq/yKfvBt+/WE5z9E6kILnUWS/4iR8ksXcUjO2jCF0TY+rG
	 4rAP7XkQhvCBiBB471SMONd3tAZKJUlDRblQNTFyAsKY55WxBR6C5IKegIKQ+hTp/PhSO
	 G2xm6KGukpCazxyDOCsE2R9vAI8lsA5n/fHnh+ACwRa24UJHcM1JKPASIpMxlNpmPZBa2
	 oHbiJxygbCH+uaeazv02NgGBKnaG41p38X38m4kqJbhhtWNEjn0gxfGBZBdlmcyjruw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L0/GfYda";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC25606A339
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0/GfYda
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937881F0089F;
	Fri,  6 Nov 2026 14:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976316;
	bh=vXzMy/0XvlsXfc84AYJFfGyD7DFDjjSbnD66Q1/3qD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L0/GfYdaEVvkrGQQgACstf7Faohfmv30Xl1rEGFi/e+oNtJP4WbrhISJ7v5cygNRl
	 eN3CjJ4CApzukT1nNC/BBuXu1cdxYRAL0xLZ/cTnmRcJQ3heSkvB1xEHdPQrkjIDzG
	 GcDBWzocFdBJxL9dtBjfY+LtPyWowEv228Q0toI6KX5bwpQzk/3VRL8Mitu7kTgxU0
	 9twyE65o2Q9UimKaXHC0Sk6SS5MOrsdKferYjv2RXitBsmIX0gQis2X2eDWIrugfZz
	 vB7vEagKGiGgNTF0qjyFvZ2XhqhsC6vgYITXQCnx6AsxnpJt3ovW+bTGaMgzghrisj
	 ChaNhcFh2objw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: TDX: Stuff exit_reason with UNDEFINED on wait_for_sept_zap return
Date: Fri,  6 Nov 2026 09:45:14 -0500
Message-ID: <20261106144335.364098-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110443-stage-reproach-62d3@gregkh>
References: <2026110443-stage-reproach-62d3@gregkh>
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

[ Upstream commit e5f1d62c59aea4f270773de1bf6e8867f5b1124c ]

Forcefully update the exit_reason to KVM's "standard" EXIT_REASON_UNDEFINED
if tdx_vcpu_run() bails without trying to run the vCPU because KVM needs to
wait for an in-progress S-EPT zap to complete.  This avoids handling the
previous exit multiple times due to a stale exit_reason.

Fixes: 4b2abc49712b ("KVM: TDX: Kick off vCPUs when SEAMCALL is busy during TD page removal")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://patch.msgid.link/20260819094903.3060020-6-xiaoyao.li@intel.com
[sean: use EXIT_REASON_UNDEFINED, drop comment about bits 31:16]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/tdx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index dcbfcd79791c8..02a15ad90c586 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1041,8 +1041,16 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	 * allowing vCPU entry to avoid contention with tdh_vp_enter() and
 	 * TDCALLs.
 	 */
-	if (unlikely(READ_ONCE(to_kvm_tdx(vcpu->kvm)->wait_for_sept_zap)))
+	if (unlikely(READ_ONCE(to_kvm_tdx(vcpu->kvm)->wait_for_sept_zap))) {
+		/*
+		 * The vCPU never entered the guest, but this looks like a
+		 * handled exit to the caller.  Synthesize an invalid exit
+		 * reason so the previous exit's stale value isn't consumed
+		 * a second time.
+		 */
+		vt->exit_reason.full = EXIT_REASON_UNDEFINED;
 		return EXIT_FASTPATH_EXIT_HANDLED;
+	}
 
 	trace_kvm_entry(vcpu, run_flags & KVM_RUN_FORCE_IMMEDIATE_EXIT);
 
-- 
2.53.0

