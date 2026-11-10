Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293864;
	b=c4MTG4WWhhCi96gv+9+Z2bD7GwfES/GbkYnrdH0sIBVT6f9CXwAGyqkIi3Tf7reiOUKh
	 3F4+EYYNRgXfTCXEBz9lLYEH6QV2M0JvFjM4KcKFaBxHNcFwKl5Pdj/2r9EqYUpJBJdmR
	 pPFXAjzFT69MQt3rDty5rN+9hPXcM1gFOWvdJDzw71cZJ2Mg0CN0oLxlnb4B6/9bnK/bR
	 nxW0w2AlhOs5s9kaeEMPQsC3txU66wWgxureqgtgJ3fYfOMxkNtuzan5KFzuy2GgMk2wX
	 Y84aIszA0EMWdsjucYVIGAT6rh1UkdHnEZTG1VpgrUSCmpS1D16o9O/Xu9SL4g/peQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293864;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0uSyDd8eHyUNCVVi66iOkkGA4uNu73UjkPVNXYBzaus=;
	b=aUqPhG+/0/FWTZfg8ErsLnmIqlYUHQw7EobFrzHTpx7P92VCrgWqd6BQUTij3ZQT7aCs
	 fWFm9E66loEmvZ68dCHirOo9L226JRP72/sDzam/VjO1X6i0Rb5s5MHC6yNIZ15DDAWNa
	 FWwlQ0e2n9wPbYar96Ld+KvQtfkQOwQlo3HBxsblqKRhqjSrsDG81+PRGyld9LXa5qG0l
	 ymsPR18+GRCnnA9DNk5VY0N4IkbZ4a9GzAFl5S00nhn+sTe/d4/n+aFKEuaLYT6vBF03O
	 CDiPPvwRhwh7skeWC0qNg+FPoR2IhClI9tWhwwpUmxY9cilwL51Bg1mNP4D+NNeDi4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6nTasdn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D974606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6nTasdn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBBB1F008A6;
	Tue, 10 Nov 2026 06:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794293864;
	bh=0uSyDd8eHyUNCVVi66iOkkGA4uNu73UjkPVNXYBzaus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S6nTasdnHG+ggv5uLLXF+yJHNKJepf0bzpCnXH9FGpy86yq3kah1WKYMR1lQhtAgO
	 FHRM/KDHt2tX3vhOTAVzYdF4izOuZ/EU3u0pTffXzP+F1anzz/hKysbFptpg8WOg0d
	 wfzGUjyIjAD2F6Uriqn8wu9rdF7jj78ve/wTMaEwy4eiToPIq6V6CaMpEloIcfFFDS
	 BGlCATp2R3h8Fw8jpTkBmi9KT5kd/T0hEVmKpWVocqh99iqPOoWIYjpZGebn95zYlF
	 UXTrgXj2o4JESyvJDtTagK3ocJv4zDIjsnAHrpPguVGgtemPGDpapuM4MM00/+97Po
	 WoiXMo04hHzFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when preparing L2 state
Date: Tue, 10 Nov 2026 01:57:42 -0500
Message-ID: <20261110065725.535932-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054144-failed-6.1-1c4c84a643b7@kernel.org>
References: <20261107054144-failed-6.1-1c4c84a643b7@kernel.org>
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

[ Upstream commit 1c4c84a643b704e473cb171f7b61359ff29b12a4 ]

Force EFER.LMA=0 if EFER.LME=0 when preparing L2 state for VMRUN, i.e.
mimic real hardware's behavior of ignoring EFER.LMA if EFER.LME=0.  VMRUN
unfortunately allows the nonsensical combination, i.e. doesn't fail, but
KVM itself has an invariant EFER.LMA can be set et if and only if EFER.LME
is set.   Breaking that invariant can lead to a variety of issue,
particularly in MMU code that keys off EFER.LMA when determining whether to
emulate/virtualization 4/5-level paging versus PAE paging.

Cc: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260902232028.2767071-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ sashal: Adjusted context for direct &svm->vcpu and vmcb12->save accesses instead of local vcpu and save aliases. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 86ac990d7a0ef..af9caff998eba 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -559,6 +559,10 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
 
 	kvm_set_rflags(&svm->vcpu, vmcb12->save.rflags | X86_EFLAGS_FIXED);
 
+	/* SVM ignores EFER.LMA if EFER.LME=0 (instead of failing VMRUN). */
+	if (!(svm->nested.save.efer & EFER_LME))
+		svm->nested.save.efer &= ~EFER_LMA;
+
 	svm_set_efer(&svm->vcpu, svm->nested.save.efer);
 
 	svm_set_cr0(&svm->vcpu, svm->nested.save.cr0);
-- 
2.53.0

