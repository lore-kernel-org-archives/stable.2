Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048106;
	b=vTdR0pJJf6mljZwE2xtmdblgwARtDvXP6rd6LneruyZbzf4+iEX3tIf6CMxU4qf9w/VZ
	 ALSMY7vQ7IczCNb/eXhX3CSsZ6zL/0DjvvMeOHT/XfKM5+vlkOSCivYiGpaGS2SIwsZiD
	 aC/42a18XIJIccpj313rwBqmr+pZ87epHm1zNgk56tycoMe6+BzAIsKt9yt6nYk1+/6/E
	 sXeUUQh07QntvCpzUVfK42oKzXu28cpxk5QhPwFXxgm6wrlyjY6zAPcdEgbowG72fuOXk
	 QmWUW5aSRSX0nJEQJci7NM+JdL2hnTserc+kyv/Tt2VNng12kAsqcLj6B9avdlPopcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048106;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=z3jx264YNWQS2uPjHVz+mBwGrPUZhz92pGFQA+RpdVw=;
	b=ndcqDMFk0CCX+Tezx09bgQBfaG7Xrm+P+clZce02Ux9yeTFi9YUjz6om+rqMChlASSve
	 PgH1UIXZ7E4hjx87NGodKDSna+32SmIFnYDE6+zaakNfgRyuyVgoYPxqWV5SG+w80QBnA
	 SmdDx/lRKCrjwA4Bk60bvwc+1TwPAWzRLKmtGymVzza+VuCdn6bZFmKybZHzIWO6y8M+J
	 Prh9pc7a+xv/v382TMslfdKyhKLv+cGoMrM9UpKFhzfqf93EMN0QT+S83b9QvE6LakveC
	 n5qPUp5+b4khZ3Ax3bgcNNkLlcy5UhIUokb1hVeiCwNXzfwB3EPdansZ52/l+C4owZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIOJENt5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD27606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIOJENt5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270A61F0089F;
	Sat,  7 Nov 2026 10:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048105;
	bh=z3jx264YNWQS2uPjHVz+mBwGrPUZhz92pGFQA+RpdVw=;
	h=From:To:Cc:Subject:Date;
	b=QIOJENt53iyjP7DBx7yTw55vqNwCknSGvgIROq2p4ihBo+B03DHPhXty9duCtO7Yg
	 1or8iZXyeQwCBczBU/o/lwRO0bp2n8XZz8HE7MxqsD/TXateHY4d3DrkQeSENRMy6P
	 KqX6FKEcteRByuv7WLCfOgLCKMSz70Yd5XcURbcX7TqMkzkyZvyFkR1TtrppEArbEK
	 qk6syU49P142OsER98fkOjpQGfGtwN7I/Nyn2vz5glTECp3duKZ2gsYQZjYXD8OYrk
	 KTgnyt8T0axWvmy2jSNMHTe3ZxfLVc0kZzXtDtrDfkTIgwFXzrgpyF2CToupdkrba3
	 UkS6L9fGNJ2cA==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	yosry@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when preparing L2 state" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:44 -0500
Message-ID: <20261107054144-failed-6.1-1c4c84a643b7@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1c4c84a643b704e473cb171f7b61359ff29b12a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054144-failed-6.1-1c4c84a643b7@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1c4c84a643b704e473cb171f7b61359ff29b12a4 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 2 Sep 2026 16:20:25 -0700
Subject: [PATCH] KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when preparing L2
 state

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
---
 arch/x86/kvm/svm/nested.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 49fb10ad1f9f6..23d29597d6bf2 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -789,6 +789,10 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 
 	kvm_set_rflags(vcpu, save->rflags | X86_EFLAGS_FIXED);
 
+	/* SVM ignores EFER.LMA if EFER.LME=0 (instead of failing VMRUN). */
+	if (!(svm->nested.save.efer & EFER_LME))
+		svm->nested.save.efer &= ~EFER_LMA;
+
 	svm_set_efer(vcpu, svm->nested.save.efer);
 
 	svm_set_cr0(vcpu, svm->nested.save.cr0);
-- 
2.53.0




