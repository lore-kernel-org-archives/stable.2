Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E31396561
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210614; cv=none; b=EUBOK20WiTzdY6sOBtVrF2g6xrRzogZMTOo4oh/dUdONKy81FYFTK/C7cNySJxU5dYZzy3HbUet0kK/NcDQpySEBQPO+4A+Fa9xTxMk+UGs/0tRfZq0n6A3kNOYprYFjLqHbO6HpaLLm2q+sNXmdoNAhoIwvGhnyyYbedY/RGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210614; c=relaxed/simple;
	bh=GxZTWI06c+jC9vadAuz7H7eVGJMkiW7amgkM2qMLuM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L36JAyshTa8aZ4EZm5msXkgidMid5NIxbhe+lGEOJYNW+ZY/g9TNzaxprTcWnDxqjOUOLzZofj2V0JCI+xCxvfhA8RwG5lUiiFBlMvp27ClQ5D3oTX+wNXCNM95FhZvwaYnaSUWOKz2ntvQaskfe110WTwng7NqurQhwe8GKcqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kbsm19xw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kbsm19xw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03661F00A3D;
	Mon, 31 Aug 2026 21:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210612;
	bh=CS1EkW3HoWRePrO9/hX8uCKjbDYtIeNUXU3vYQL0DY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kbsm19xwK8kyyr43GhS6bwub7hkD1/tkjZr3iSuV5kv9WDPZU9EytOpMytGP0zVYI
	 GbEVBXqz6aGl7mxn3e17qn6750y5Yq0N2VuSSrEKu06ChEuFZCqoV7VvHRY53152yW
	 u5f5t1Peier5aJi3NZU04sha2TKZEph2q1M3SxOJ0SnOlP9evGKhyZFFmk7jkmH4Yt
	 kJkMAQz1v0YH2pV3AjT0GzpLjcum5eC4ytD+Iv6oxFK8rELWKeDFGOHb5WdqbfJYMn
	 MbdLqXoNipTGuzZWxTlsYqxgyqrH0JovsloWPkI/f8NWd/nqdkGXVfZH/GLJGiV9yM
	 v+926VRuQLJSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] KVM: SEV: Make it more obvious when KVM is writing back the current PSC index
Date: Mon, 31 Aug 2026 17:10:08 -0400
Message-ID: <20260831211010.1798943-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083135-thud-surplus-53de@gregkh>
References: <2026083135-thud-surplus-53de@gregkh>
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
Stable-dep-of: 98ade8c48c28 ("KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is unusable")
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

