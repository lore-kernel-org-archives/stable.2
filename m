Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274005;
	b=3aH2ISwu+nBcko7atiSZmzV/Y1iS0B2fSyR4b/Q1Y3Vb7i6osNMx0/q5pd4AouQHlxck
	 eoE/et4DjQx51iPn2adjrO6722+ftNoYZDGaoiDAGDm0T0Pf5Y0R3wUCdn6ArOihle+Tj
	 O/DwpAPwVjokgVbeaJMAADplHzpCU0Jd0/Ebkk/ELNosRy69qlUI2zQXMm3IWaYAV5A0e
	 sbUwBiS0qyxrAHwdxubIC9DVkcj7y/OdOCtlehB6ZZ72oh+G4OeHvPe/LnKIz6Wh62kh/
	 zJBIpVWEE7zDd74UwJV1EwQwVtoLSlJVg0JOk2iqyoAqsgdoJeYMlyjVxvM6NiVXHBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274005;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=F/HI6SxyJjV0EyqCjqLA+0Kc37emhG3cY5/6IjWK2Iw=;
	b=hSWZqEnUfdUErc8z7yPmdurDMsmlFRpBUgsQefUcwcJvdWiEq8bykdJUvKHp3JRhWpsb
	 VrnCPebGRvgI8N3T3Lf/1kcqnXCtlwfWTqEejTt4VlFYiPoPHTrnbf8j7cUIqVi4IGZLE
	 gcoDVgjxDnFdZpJIb+Wl/Y4oTIJgz0KfYw+cqof5/TNpGkOB/QFwYNpqNzZP7vJ53ilTb
	 I3cmGPjxgMzWYeVWicAH9rrFav9d0Qn9R1stJeCwMXr/2zwzVRHNN0MBVUL75fsr6UZUV
	 EthUMX6COg+2ac6gecl5ibogt4eaX/Pvn6zZeaxzG3Y3qn2s+7ZVK4Vkza6pP5lSENA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvsllEum;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA78606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvsllEum
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D00B1F0089F;
	Tue, 10 Nov 2026 01:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274005;
	bh=F/HI6SxyJjV0EyqCjqLA+0Kc37emhG3cY5/6IjWK2Iw=;
	h=From:To:Cc:Subject:Date;
	b=WvsllEums1nF3zNyd22rF2kUVqC5hbhY65sIe0NyGwXg5sFRmsPLJHrcbqaKj+6jM
	 JS7YBPVZe7Qzj3VXqFdE4QLdZ9s27bWsJWtXG87WfO6Ge/CTER06xCWlTCLED/hBnw
	 jPb3khX3CQniulJqaqTGoVrRZDWoNCppMBEPChRz6OLF2TzB2LY0phmyCSAiPObkLb
	 Swy2MUsiNUEValhDOLr2WNWzCCCnefJIQK8I9TjrqlrNiSa/EBVi2J4CK0dQTyC/Z6
	 2MuMuCqYwQDGwPrTZuUVmIoqHHfYhexBSqm0RnE1YV2JmsneynrKIqnLbRoJ6/sad8
	 cyfKkogpWeM1Q==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	dwmw2@infradead.org,
	fane@google.com,
	pbonzini@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: x86: Conditionally resched when restarting REP string emulation" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:26:43 -0500
Message-ID: <20261109202643-failed-5.10-ae85ac25eb67@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ae85ac25eb671d174811cc3101549448671fd505
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202643-failed-5.10-ae85ac25eb67@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ae85ac25eb671d174811cc3101549448671fd505 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 10:36:38 -0700
Subject: [PATCH] KVM: x86: Conditionally resched when restarting REP string
 emulation

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
---
 arch/x86/kvm/x86.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba99..c4a06214cde69 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6558,10 +6558,12 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
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
 
 writeback:
 	if (writeback) {
-- 
2.53.0




