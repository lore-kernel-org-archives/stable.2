Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050126;
	b=Ll71nViidX1PNEqSTv3m4hUUIyjVJ6U75Q8kOncSWeZ00EpFXWF6vrTOtLsqbIYvA6y3
	 w6ecrI1APpHWR5OIxYHXXVi9VuZR5HOi4HIZJkq7v+KQtv1xc0BUteVTMn5RJDS515AEc
	 lnMXueFoioCsAAWa5zV4Z42p7GfpldAJjhi3GM2OYOAwmkaViBpdpln3Sskgvjiuy/GEh
	 rZje9S9kWsPLj2Kw/Fb+ll5C5Ue0ef1wWA9WMbacftUm6+28CH8dW8TpAF9DWcd0cMiru
	 1Ure+r+U3pTLP+KoDTWoSRKRPMXZ7YBeWHtZotSyHXqgFCk0ob9PeTGwmLGFgpMGImA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050126;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BrEKIRoNfncIB4SrGAwP8JLBsfTx61rB6JX4GnhvP9A=;
	b=N82ssif/p/3dfTBb7BIUmjMZAtYkYqC4hTR55JI6Y/1c2g2mVdcUhT21ft5jGXoUm1uB
	 iWJtZtecwql1OCv5PSqDbOgwnyiiOG/oZIEf/YUSKt5z4uylQA+gzGncdEqWSLRU6/amT
	 LrHjr+b5SCbpdIBGmwikhdSVfYcvYXr04UlBql//rz4rJeKjxGB9nnYbKNXN3KndoBt1R
	 DdUDj930szYpXcTaHOpzWayZCF3mkIuDKWAh7ZC6yoRmfQpoOaQy7Ln7WbvmTtbnDXCS8
	 F9EiGn1GnV+0axgHyz4vwjDxkbGVvj7Rh7EuR44M7n8JtSlH6uA8Di6DmNdreqBQAjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2NtU242;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEAA606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2NtU242
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF891F0089F;
	Sat,  7 Nov 2026 11:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050125;
	bh=BrEKIRoNfncIB4SrGAwP8JLBsfTx61rB6JX4GnhvP9A=;
	h=From:To:Cc:Subject:Date;
	b=Q2NtU242Q+SXLxXuYZpNDJCvYlpS3T4meT2th+Mq+AEjPpLsKR3NAXMvdS0dJ84CQ
	 oY1v995bGqQ0kzVJ4/ZwfUIs0LT+Ey9wXoOj07h/MzvOdqS0Sg+o7rxRSwkLsmoUAA
	 UfSRn1uzAZt1oMxSn6PAA4Jalx4LXG/z9b+3JfZC6ngTSrpEcpZPRDcuN2zbEkNJ5H
	 BGNhavf41xPGm7ZKUIyD7s51zpJcW+OS7TJz2FmK1HQL2yXbRICaNtrX+fzb6i9w1N
	 jZA+7m+3VZADqv00D6opr954vrsC4Cfmb9PNDO0jumy9sz9J7qQIBmEYq/HSwBIGTU
	 zfFVVtn/rr/RQ==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	yosry@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when preparing L2 state" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:15:23 -0500
Message-ID: <20261107061523-failed-5.10-1c4c84a643b7@kernel.org>
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
git cherry-pick -x 1c4c84a643b704e473cb171f7b61359ff29b12a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061523-failed-5.10-1c4c84a643b7@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




