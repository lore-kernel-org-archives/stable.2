Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794639028;
	b=CNFj0opW3wfycGgi38E/5Y74s0vP7bdGdGb4/YuaHViLH+4hAI7scZM2XFbkWGfS9fdX
	 8K3bd/evhmGiBtnd3cF0lyGFAByZLg/phwMDcniZnL3BihkkjLDdj8XBOodKWYBXimVxb
	 i0NcPCMNtXiyKJrfOS/S/v56WJs4R5YHDRQtYW/qVlNzd2ZHwGKxwQhyGwua7WTKTr3FR
	 ukgN8ZNPEBaNmjBnhEfisjjcgnTmfr9zn3jVIRUutIYTbEIVsb/H4Fc7Uo5R/EVSOfstx
	 qnnRzLTrnUH9eMzdXZnOJ20bACuWX9/wN0G8/+ekRoRsuHCeD+6mDmTA7/wLzrZs2pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794639028;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9YEl5BPuj1BJ1vy/FM3kTlD5HQ8FT9SYFa9+/D0ZCHo=;
	b=BXy0HIRj2XKJFZn989bSt8YUdxrWmuCuD363A/ROuaQbZ6csWk9V1gao1sh/7hoxMKNG
	 l6x0mga82pffgBTsjBVR81XkC/ptjbAN3gVbXCWh8MJhpDlSdZPDB2umRb7x2CYDi6Dz3
	 E6Al3sdlcTw2Hf3nEvA0XXZjOV4SuwBJD6J+u80rJ9h516Gx0KHYli9owy9VP2Hv840lx
	 PYHeg8vkhU5/IfaH/dujON2qHvdd0hOhcZ+CxOe9UyozwVk3wP4/sFaix3pjyEDuhadNt
	 PtQEYhj3ds4MmEY/ElDpECVgGtfpRp5+oucXd1d6QEK3NFViKYlKGoGH+ia2eCuR1Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lW/ZdIQk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF240606A330
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lW/ZdIQk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080341F000C5;
	Sat, 14 Nov 2026 06:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794639028;
	bh=9YEl5BPuj1BJ1vy/FM3kTlD5HQ8FT9SYFa9+/D0ZCHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lW/ZdIQk9dICsk9GI8NdSWOV447/pEfil5CcT6VpjFz3bRiXK0RLeIhrbLlCWiFIQ
	 7rlwnWoNFiQ2x2o1eUNbLMSkgKWhyDt44r6Tg7aYI5GKTIb4sPrTHaTmg2AC2S54H9
	 roOtIAC3hY1kbAccJ/rfP4eDiW8EiOGTP7D6QykmSczW2qExDgIr2C48YK8zPVqNQr
	 GdYdeqwRINVpoVMG7Kc30CbXCIQxSnIK092mPhFeZyV7V4kYwWpOwff/lBuLGoVjVr
	 BZM5a7XiivsmqCcoqc5lpwHytAQ5dM1FY3gh3ve4MZbmbTQe+34uzmXSVXOs//HoBI
	 Hl9uwaETudoWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Stefan Teodorescu <fane@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] KVM: x86: Conditionally resched when restarting REP string emulation
Date: Sat, 14 Nov 2026 01:50:25 -0500
Message-ID: <20261114065019.3231096-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114065019.3231096-1-sashal@kernel.org>
References: <20261109202643-failed-5.10-ae85ac25eb67@kernel.org>
 <20261114065019.3231096-1-sashal@kernel.org>
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

[ Upstream commit ae85ac25eb671d174811cc3101549448671fd505 ]

When restarting emulation, e.g. of a REP-prefixed string instruction,
conditionally reschedule as emulating guest writes can be deceptively slow
and expensive, e.g. when shadow paging is in use and each write can trigger
write tracking.

In a perfect world, restarting emulation (or not) would be less arbitrary,
e.g. would honor not only host events (NEED_RESCHED, signals, etc.) but
also guest events (e.g. by checking kvm_vcpu_has_events()).  Unfortunately,
as pointed out by Sashiko, pio_in_emulated()'s read-ahead logic is baked
into the restart logic, as KVM relies on restarting emulation to drain the
cache and avoid duplicate reads from the I/O port.  I.e. re-entering the
guest on kvm_vcpu_has_events() or __xfer_to_guest_mode_work_pending() would
introduce architecturally-incorrect, guest-visible changes.

Fixes: 5cd21917da24 ("KVM: x86 emulator: restart string instruction without going back to a guest.")
Cc: stable@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>
Reported-by: Stefan Teodorescu <fane@google.com>
Suggested-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20261028173638.1765329-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d7236e8467316..58660d5de1413 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7720,10 +7720,12 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	} else if (vcpu->arch.complete_userspace_io) {
 		writeback = false;
 		r = 0;
-	} else if (r == EMULATION_RESTART)
+	} else if (r == EMULATION_RESTART) {
+		cond_resched();
 		goto restart;
-	else
+	} else {
 		r = 1;
+	}
 
 	if (writeback) {
 		unsigned long rflags = kvm_x86_ops.get_rflags(vcpu);
-- 
2.53.0

