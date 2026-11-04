Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823542;
	b=n37MqPQUHrxoa8a3R+IgheRp8UYVslr1oKDVvIuuM2NTePJX8Lda1Z2r2MxOPcm3VjEj
	 6c0cCDhzdMSzBlBJKAcCni2z/uAsKvvy+yXpZWIPuhrb8OvAVAFGsz1m3OSeGmBKrm3LM
	 RSp1AWMGrsXpqKE/Uvy9ZZ3X4aryV6vCDIVC/Pgpbvwsw6yqZGbZfPahtUjzNsldsXz4F
	 v0z2EhU60tzaHpkhpFMt9V1ZYyN5ajok1I+i9a/bMG2wgn6cDHafh+yL083goC2QUn0cY
	 Y+lA90IZnZNmS3c9k630Zpd3a432eXhfniH0v1/qispzZ3CTZ6GH7mMC8pFqzy0wW8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823542;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nBCgyIYDa7dohF+GjG3JHxP3hKp7Gu67HzbATissiDs=;
	b=sBRHdXxz3hE7p6REUpUih4Yws58vfVXr79RL/VigAXOgTgRInkuxmghhA968n8BajDzY
	 0JYWbBzj88Wanv5hLpKCvXGaD52O2f7X3hYUZxmMLPlvsnb5Kt4vsYnqb7ZkJtQhaUHW+
	 iKG7b1UxHBZWCZ+meL4gJOmGahoumpwfA943/nsKqG1osOA6ETvXFhr9cw7RpHmZqXgu5
	 hXnzbauYF4qVzRZmKHBhi12rKFcrhbhBa04P1sqHfdlF9thSeOwZDswVH3N+DLtjTfm5+
	 KajIbV4D+Sbc/25IvW2xroTCBuHaaj7Rvexc1hZyYHo++UGctKpEATa+SQv8S2oXo9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HalcJpMZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A593606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HalcJpMZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E740E1F00919;
	Wed,  4 Nov 2026 20:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793823542;
	bh=nBCgyIYDa7dohF+GjG3JHxP3hKp7Gu67HzbATissiDs=;
	h=Subject:To:Cc:From:Date;
	b=HalcJpMZBSzl9tQGl+lku/lMwDQZ7gTEj1R8+smOAGKX/4KC14WcX4YtGFhTaDjMM
	 4XtCq/Ug/iaYWLGnNYv3/a6F7zruvdWdySn00EmxbZJuJLDIx2Qj4JRAzLY/Llbh5m
	 fkdJ/J0E83QFITQi+VkDUXEhCN9Pi9sKQLQo8zfk=
Subject: FAILED: patch "[PATCH] KVM: x86/xen: Take kvm->srcu in __kvm_xen_has_interrupt()" failed to apply to 6.1-stable tree
To: dwmw@amazon.co.uk,paul@xen.org,pbonzini@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:19:00 -0500
Message-ID: <2026110400-cinch-argue-06fe@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x aa8ad943f242ef14d136c5440b1178de77466c9e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110400-cinch-argue-06fe@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aa8ad943f242ef14d136c5440b1178de77466c9e Mon Sep 17 00:00:00 2001
From: David Woodhouse <dwmw@amazon.co.uk>
Date: Mon, 31 Aug 2026 22:26:41 +0100
Subject: [PATCH] KVM: x86/xen: Take kvm->srcu in __kvm_xen_has_interrupt()

kvm_gpc_check() checks the cached memslot generation against the current
one, which dereferences kvm->memslots and therefore requires kvm->srcu to
be held. __kvm_xen_has_interrupt() does not take it.

Most callers do happen to hold kvm->srcu, but not all of them:

 - kvm_emulate_halt() on the VM-Exit path, via kvm_vcpu_has_events() and
   kvm_cpu_has_extint(). vcpu_enter_guest() drops the vCPU's SRCU lock
   before entering the guest, so it is not held on the way back out.

 - kvm_vcpu_block() -> kvm_vcpu_check_block() -> kvm_arch_vcpu_runnable(),
   which is the case the existing comment in this function describes.

On a PROVE_RCU kernel the former produces:

  WARNING: suspicious RCU usage
  include/linux/kvm_host.h:1092 suspicious rcu_dereference_check() usage!
  ...
   kvm_gpc_check+0x344/0x3e0 [kvm]
   __kvm_xen_has_interrupt+0x83/0x310 [kvm]
   kvm_cpu_has_extint+0x1ff/0x370 [kvm]
   kvm_cpu_has_interrupt+0x16/0x100 [kvm]
   kvm_vcpu_has_events+0x4ce/0x690 [kvm]
   kvm_emulate_halt+0x52/0x1f0 [kvm]
   vmx_vcpu_run+0x988/0x2630 [kvm_intel]

Use guard(srcu) so that the three existing early returns don't each need
an explicit unlock. SRCU read sections nest, so this is harmless on the
paths which already hold it, and srcu_read_lock() does not sleep, so it
is also safe in the atomic case which this function already handles.

Fixes: 7caf9571563e ("KVM: x86/xen: Use gfn_to_pfn_cache for vcpu_info")
Cc: stable@vger.kernel.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
Reviewed-by: Paul Durrant <paul@xen.org>
Link: https://patch.msgid.link/20260831213632.81023-11-dwmw2@infradead.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index a4befaaa39af..75225a3b1246 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -732,6 +732,16 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 	BUILD_BUG_ON(sizeof(rc) !=
 		     sizeof_field(struct compat_vcpu_info, evtchn_upcall_pending));
 
+	/*
+	 * kvm_gpc_check() checks the memslot generation, so kvm->srcu must be
+	 * held. Most callers hold it already, but this is also reached from
+	 * kvm_emulate_halt() on the VM-Exit path and from kvm_vcpu_block(),
+	 * where vcpu_enter_guest() has already dropped the vCPU's SRCU lock.
+	 * Taking SRCU does not sleep, so it is safe even in the atomic case
+	 * which is handled below.
+	 */
+	guard(srcu)(&v->kvm->srcu);
+
 	read_lock_irqsave(&gpc->lock, flags);
 	while (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
 		read_unlock_irqrestore(&gpc->lock, flags);

