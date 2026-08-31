Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CEE369D6D
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214805; cv=none; b=B++E5WF7lKjh7BpzJGq8/7d+SO33j26bTHCSaZotvr2F8mhZnIdrOV1ih+/cCocfn4EOCWHvrWZW4vCqCeJPCTz3oEf5QiQUyf6Y3AhNRMgf0BmbdUI/DNEnJiveIePh5ruYtV4QC7wfJPjLtIHf7VQLBk9pNPk9esg0wXRROHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214805; c=relaxed/simple;
	bh=K7d+GRTDYoCQo2eqiR3IVPc0QqvVlrhoUfvM+14mjKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcCE0ZIq2N/wipL2FYRmvBQDCq9BhHiFblVP4DZtBwKVdMiyeFD2KXe38Hv7qHwahR/YEhBXgUpBw/WLgtj0hhzoPvqMR3UsbFhMu4GtdBalZnJ+X0A/gnBZn0CAc0QUzaVdX7BPJpmw6yXSdQd2huceq5AO5yFjzM6VDCtMhhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpXrwEe9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpXrwEe9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31291F000E9;
	Mon, 31 Aug 2026 22:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214804;
	bh=FODa3Wo/kgpvL0EZ4jwMxOYkZdZjexWxDkTRlcGpIcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TpXrwEe9RhUf6q9XH8g0jKM2lp8lgQtOUVlMpIIp9GmKhyisRJ5ATTHEpZss8IUQ/
	 /2CheniI/aO1BCLNMOJw9Om1Cp5b0WMKLEPIXlqGSrpg11WAkuHrS+OBzwGStot8K1
	 PvZ8lcGwXli5B0JGN9oM1sdra48I5Qwf9m/EBzlXUu+YKmqbZvkc8T7XqWm+/omcP/
	 j7kXArs85zlcYvn8F3EjiOZdlD3YYfFzvHp6e0hRaxLnj74GQfO8rTZbOnq/79gi74
	 puvKHHSqg6IfIJ3s+h67PlsI5dvlmFydtDcge6lIuSBs0sebNh2cHL0ercn+dg4AME
	 ywWkPjSr6Wxjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] KVM: SEV: Make it more obvious when KVM is writing back the current PSC index
Date: Mon, 31 Aug 2026 18:19:59 -0400
Message-ID: <20260831222002.1858641-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083120-cilantro-legacy-9d5a@gregkh>
References: <2026083120-cilantro-legacy-9d5a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 17d62e0b157f262dd8c7586cb882ece72a5b10c2 ]

Increment the guest-visible "cur_entry" index outside of the for-loop
when processing Page State Change entries, and add a comment to make it
more obvious which code is operating on trusted data, and which code is
touching guest-accessible data.

No functional change intended.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-12-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260529183549.1104619-12-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 0060569e4f18 ("KVM: SEV: Extract loading of guest-provided VMSA to a separate helper")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a6971cd236bed..e5587675cf9ec 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3821,7 +3821,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	}
 
 	/* Find the start of the next range which needs processing. */
-	for (idx = idx_start; idx <= idx_end; idx++, hdr->cur_entry++) {
+	for (idx = idx_start; idx <= idx_end; idx++) {
 		entry_start = READ_ONCE(entries[idx]);
 
 		gfn = entry_start.gfn;
@@ -3848,6 +3848,14 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 
 		if (npages)
 			break;
+
+		/*
+		 * Increment the guest-visible index to communicate the current
+		 * entry back to the guest, e.g. in case of failure.  No need
+		 * for READ_ONCE() as KVM doesn't consume the field, i.e. a
+		 * misbehaving guest can only break itself.
+		 */
+		hdr->cur_entry++;
 	}
 
 	if (idx > idx_end) {
-- 
2.53.0

