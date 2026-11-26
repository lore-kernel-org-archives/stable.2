Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795689293;
	b=C/MltAXybRBXJ8skCiUkCNQooeJBAe44G5deJGSH2mSV+giRrlcTbPFml+3DOR5ZF26k
	 cRmw1RDJL1TzFS1ytAo9lBGumR3VuZ8C4DdLfDPp4Y2YSN4dVCEV1pi80y2YcLRroXEnJ
	 tdpQQ8Mp9ybjUwLyWkJBUao76PJLoaTXEUjWtpcmYrQBVQWBXO2hNRSM74WW/i+OZtaCh
	 fJYZluGq/IzNhl3qqQIcn3oTc3bZtVdZpIcTK9MarIM6+Fp4QKuJscRG2qYdhNIyohqd5
	 Z9yxzPI6/NE6d4OjOAZF8Yi0T2yQCrQNkc5ExEYndJnXDMQ5IZGehb/RdB3FZJhRapw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689293;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=2JYZPx51REunevoZ4dK0f/jIdotpD84eHhmzozcTR1s=;
	b=Tm/lOnzl/JzQyoGd/mrB1NQu+IjkbVNQQHsw4tf44RqZehn32q92ch3lRVhwR7yUwU79
	 +d1aTJEp3vrgrxZV00lpTA7Ze+WRysI8MUFFiUQms/lvJiyscS8v75fGPXwIvWwPhKClh
	 p5C1nyG5zwi2zOyKilYpQlAhMr/p+7I/n0kg8ZhD8yvqzBk+xO2pzYgCafiZDDn3E6CgB
	 A0WInIEG3P+CwtpfljRQr9RbiBtmxjlu1ZB/fhqrZMkWKUNLh7Lm+nCxTKCWdmWo0ayDr
	 XCxdwl/N3zcs7FpOzvsSN50VOR8500HKeUddyCIbnqXSI1lTZh+9mx/jBW5gudDem0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=enSLGa5U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573BA606A685;
	Thu, 26 Nov 2026 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=enSLGa5U
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795689293;
	b=f4dmtEtdkDnM9kgegzwDgN+Zp9v7HwsuSKYlMEGuCMiSn+6gx/oEA97eLBmR3sqzTRUW
	 IwqlhKTUo0xyw64rpcw+x8tCtZyuH+DxUBhVijqQCHGjwqh4spy7j1TXgowrdm8KGxc/8
	 i4p1LdvZXTFs2s+N/Xl2e+bSqGJtuMuOQFfLB68Mw0mq9RcF0rch/bBnBfiqR1gDYw8yO
	 thFGZHLcP3q5GUkBaFxIICo8thIH4kmKKKqB0J4DHegmexEAWCOT8WurVbYdHC4w6XS9Q
	 ZpxJwlANq0EmyE61UEZ7LiIosxR3tX3yBxsOJHDUSoFXIzwavOU8HokUQLAbhqk6nMg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795689293;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=2JYZPx51REunevoZ4dK0f/jIdotpD84eHhmzozcTR1s=;
	b=dmpQl6CRS+t9MTI2xX2UpVjQlq0qk2ef+zILyBMmS5+cxFqw75p1ugZLHQa+kQRbg84F
	 khhiDMpKrl48vCpmIlmX29CHPIESmGW/3y3+LkgcQpzCIaVTKWXYCBbLw8lzgTTFj7X0t
	 kF7y3u5AfrJimn5k8nKSGeNRV7I2XD28ID2hRHjao7Nmfs19oo07wLG1d2Egd5D9478jm
	 s1BvlKTdziiFCNtK2nVdXY3CQAON/n2DtKXLWuvdi9DK8sAsM+f63t3xqSIFh3mRC0wGU
	 9VPGBVEefd2/imkIbqamo9Y+xI2QS5mPTAnvE+vgBADHFjBbQoRvN6IeK+rSOfSAJeg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CC4FF1F000EC;
	Thu, 26 Nov 2026 10:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795689293;
	bh=2JYZPx51REunevoZ4dK0f/jIdotpD84eHhmzozcTR1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=enSLGa5UthnGWupLRQDjvmEGoyBaaSXNXFRdEA+uFydZDzILto9NGjquvQ4cai0Oi
	 cvgZ4vIKo9Y2tfx+IxTXexOV2pjtjKk1UrH8x/LnM/Y22i5BS0PkLTfHIhqXGRadka
	 dvvmP/6z3HKohsyAm2xyx8d2mAdKUkAoLgLEi1BLAR2pfeb1I5GZTrXAx3B5Ucn9Ut
	 NRkASpY5dzzynBdSH9sq5M4l1Ntv4cWOSRr50SEPxuXqFUJ2IwG8j9kJwyfQ7xEdIh
	 X93gQf6QoVjpsTJWJiZq91YvjELWbPFmBL/O1hpwBrAL4Foey6xXamOHUNaiF7Rm8y
	 YhhMqzDNDIdMQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5A4E24D44D;
	Thu, 26 Nov 2026 10:34:40 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 10:31:58 +0000
Subject: [PATCH 5.10.y v2 2/2] KVM: x86: Acquire kvm->srcu when handling
 KVM_SET_VCPU_EVENTS
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-kvm-510d-v2-2-bcba96aa2088@certik.com>
References: <20261126-kvm-510d-v2-0-bcba96aa2088@certik.com>
In-Reply-To: <20261126-kvm-510d-v2-0-bcba96aa2088@certik.com>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795689116; l=3140;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=PMK0gZrBAmRQrVrXOfeI0jd8iITYPjI9GzoyJjp5PyQ=;
 b=AsNEqMlI3dBGqzOWLi52zGIO5UhAN1dWaR5vo5DfilLwILCQivK0vI/dLLcKXv5gMX6lGoj2f
 5Nd/fukKfjZAugt/rMjZ6/vW6yPksZRXjnGnE2WfM5pnDrYWGqGPl1P
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Sean Christopherson <seanjc@google.com>

commit 4bcdd831d9d01e0fb64faea50732b59b2ee88da1 upstream.

Grab kvm->srcu when processing KVM_SET_VCPU_EVENTS, as KVM will forcibly
leave nested VMX/SVM if SMM mode is being toggled, and leaving nested VMX
reads guest memory.

Note, kvm_vcpu_ioctl_x86_set_vcpu_events() can also be called from KVM_RUN
via sync_regs(), which already holds SRCU.  I.e. trying to precisely use
kvm_vcpu_srcu_read_lock() around the problematic SMM code would cause
problems.  Acquiring SRCU isn't all that expensive, so for simplicity,
grab it unconditionally for KVM_SET_VCPU_EVENTS.

 =============================
 WARNING: suspicious RCU usage
 6.10.0-rc7-332d2c1d713e-next-vm #552 Not tainted
 -----------------------------
 include/linux/kvm_host.h:1027 suspicious rcu_dereference_check() usage!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 1 lock held by repro/1071:
  #0: ffff88811e424430 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x7d/0x970 [kvm]

 stack backtrace:
 CPU: 15 PID: 1071 Comm: repro Not tainted 6.10.0-rc7-332d2c1d713e-next-vm #552
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 Call Trace:
  <TASK>
  dump_stack_lvl+0x7f/0x90
  lockdep_rcu_suspicious+0x13f/0x1a0
  kvm_vcpu_gfn_to_memslot+0x168/0x190 [kvm]
  kvm_vcpu_read_guest+0x3e/0x90 [kvm]
  nested_vmx_load_msr+0x6b/0x1d0 [kvm_intel]
  load_vmcs12_host_state+0x432/0xb40 [kvm_intel]
  vmx_leave_nested+0x30/0x40 [kvm_intel]
  kvm_vcpu_ioctl_x86_set_vcpu_events+0x15d/0x2b0 [kvm]
  kvm_arch_vcpu_ioctl+0x1107/0x1750 [kvm]
  ? mark_held_locks+0x49/0x70
  ? kvm_vcpu_ioctl+0x7d/0x970 [kvm]
  ? kvm_vcpu_ioctl+0x497/0x970 [kvm]
  kvm_vcpu_ioctl+0x497/0x970 [kvm]
  ? lock_acquire+0xba/0x2d0
  ? find_held_lock+0x2b/0x80
  ? do_user_addr_fault+0x40c/0x6f0
  ? lock_release+0xb7/0x270
  __x64_sys_ioctl+0x82/0xb0
  do_syscall_64+0x6c/0x170
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 RIP: 0033:0x7ff11eb1b539
  </TASK>

Fixes: f7e570780efc ("KVM: x86: Forcibly leave nested virt when SMM state is toggled")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240723232055.3643811-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ adapted to 5.10.y: open-coded srcu_read_lock() as in the 5.15.y backport ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 69ab4e317422..d0bbf595dd47 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4970,7 +4970,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (copy_from_user(&events, argp, sizeof(struct kvm_vcpu_events)))
 			break;
 
+		vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 		r = kvm_vcpu_ioctl_x86_set_vcpu_events(vcpu, &events);
+		srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
 		break;
 	}
 	case KVM_GET_DEBUGREGS: {

-- 
2.43.0


