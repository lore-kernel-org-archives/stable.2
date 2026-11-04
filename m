Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819929;
	b=sknIMvmJi19ocqR2mjJpCV8OS4BMp5FADwzQMUx1mUj/ab30GIq4RewQ4aTg7/vRJkr1
	 jsnxLmfY8zQAJll/mXx0I4K7wetw6QitpszxWp/yymNw+SraiIpm0FkQdMhNco3THNO3i
	 lTeCfBeZDG5T7j9oJ0h9qW+Zag677JbC467xMMNvAhLFrQy8kdam5nJJu4N7DSYtu7OkV
	 87J2/tS6MxL1EXxjrZ316k7sOZNNPq9WjqcJSjY/UFqYs4+7knSd7rtpPYJ6wzXs3sJrP
	 tacsOJaIXPzE0cyxfqt47sEDVVSbN2VCOZ+bhR1UtdiICPGW9EZkg7H1gdNARC0VtKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819929;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NWH74B5Ztsfw+d3V3Wu/OyEn09vie4wwAYKAVacTJlM=;
	b=RMNDKw0G27T+YxUkbiAgPje855fh6PLtq/HJOy0UpGIGBr/VmgYym4kfkvT9hGw4J/H4
	 CDHvsZ83s2J41B7P0Ty4ZNzEhWhQk8/86ZURkbynp1E0F6T453WWog2ClBiL72CekaCnm
	 mL2quqhq17M1EK8hg1AAN8tWp4LxDRdMqk42ZVLjyWZH6WqaUrV9sZzjSu4yfpKaLsf4I
	 ubpRjCZiyy+wDl2uOs94QEQXU+xDRnDT4Pf1CgfxZ2uak44P01JQHvUk0Y9G2jdNyv2yf
	 eB9k7iqKS0aRPMp5vEkWW3sUWZF6YtLXFzNVHNBzgj62GDF67W/WBXG5hp18zmf1tVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LVys0iPv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8AB606BA25
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LVys0iPv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F6E1F0093A;
	Wed,  4 Nov 2026 19:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819928;
	bh=NWH74B5Ztsfw+d3V3Wu/OyEn09vie4wwAYKAVacTJlM=;
	h=Subject:To:Cc:From:Date;
	b=LVys0iPvz5yo9+j5oFy5dddmILXsBkmwAChdNFZ5FdFYI4kWZDsFVykYdY4blZPdO
	 c7ak1wc25FnTdgzCs+ps+qAPC242NQsblVOHjQ63rk5ksdwYNz/S3xMQnakU6HLSrK
	 Xwz/4srgYtPtUyT8Xb2Yk6mYa6U17y8IS/4V85Xc=
Subject: FAILED: patch "[PATCH] KVM: VMX: Formally define KVM's "0xdead" exit reason used for" failed to apply to 6.12-stable tree
To: seanjc@google.com,binbin.wu@linux.intel.com,rick.p.edgecombe@intel.com,xiaoyao.li@intel.com,yan.y.zhao@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:18:39 -0500
Message-ID: <2026110439-makeshift-acting-834f@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d85f7dc8cf3c91a131946dae4c3aa8d9c97322d7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110439-makeshift-acting-834f@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d85f7dc8cf3c91a131946dae4c3aa8d9c97322d7 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 16:56:55 -0700
Subject: [PATCH] KVM: VMX: Formally define KVM's "0xdead" exit reason used for
 failed VM-Enter

Add EXIT_REASON_UNDEFINED to track KVM's magic "0xdead" value that's used
to stuff the exit reason on a failed VM-Enter so that the magic can be
reused by TDX, and to make it more obvious that it's an arbitrary, KVM-
defined value (though the whole "dead" thing makes it pretty darn obvious).

Opportunistically add a compile-time assert to ensure the KVM-defined exit
reason never collides with a "real" exit reason.

No functional change intended.

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://patch.msgid.link/20260921235656.1107929-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 3f1b3096ff04..e49b836c7313 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -20,6 +20,14 @@
 #include <asm/trapnr.h>
 #include <asm/vmxfeatures.h>
 
+/*
+ * UNDEFINED is a KVM-defined value used to indicate that the basic exit reason
+ * is undefined/invalid, e.g. on VM-Fail or if TDX never attempted VM-Enter.
+ * The value itself is arbitrary, it just needs to not collide with a real exit
+ * reason.
+ */
+#define EXIT_REASON_UNDEFINED			0xdead
+
 struct vmcs_hdr {
 	u32 revision_id:31;
 	u32 shadow_vmcs:1;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 612ab07d4100..c897dbf0e954 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6388,6 +6388,8 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 static const int kvm_vmx_max_exit_handlers =
 	ARRAY_SIZE(kvm_vmx_exit_handlers);
 
+static_assert(EXIT_REASON_UNDEFINED >= ARRAY_SIZE(kvm_vmx_exit_handlers));
+
 void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 		       u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code)
 {
@@ -7474,7 +7476,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	vmx_enable_fb_clear(vmx);
 
 	if (unlikely(vmx->fail)) {
-		vmx->vt.exit_reason.full = 0xdead;
+		vmx->vt.exit_reason.full = EXIT_REASON_UNDEFINED;
 		goto out;
 	}
 

