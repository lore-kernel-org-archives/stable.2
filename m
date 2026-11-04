Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820183;
	b=E2K+SOFZWH+h04TtdcLBC2WxHMYxUu+u2vLhPSzxvnm/QNZeee+1jfIp3uv77V0VrARQ
	 emR/QmKlrTV7Y+QU11SAeTac8GcB8ZhSLk/SmOx1Gswpg9+Rmbavifjxzke9u6PkOmRqL
	 Dq0oscZd5QsjO61jsZEezqGIC7zv3zeZNBbOdZwi9QHtdytbkfZL918BBJa52VywYbpdG
	 Oh4A3ulsmrmqD/wx1DTAhERPTorpLmKkpXmVNFMmjXaR7An6ndh8Nsct4TPKDTBFICOn2
	 ovYZEy1bzUgUBUSC6s//2L4pj+9n338uzEPPq+odVER3NsWTSnvGHeO3qOMjkecOlmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820183;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Q1W7xIyJgzvyxHQ7v4UpUK7+MJZk2+B4nUAl1mhe8FY=;
	b=2WlPq64QEh3zi7Nky3SXpJiehmIxyDwjDh/39XHI/6mRTrZjTlaD7FFBaj9n2k4S7kB+
	 TQSu+SyFAL6Hg2gBlTXm94l+uevYoTbFwk+VSPuRAdUheu5xnb+lNMBaLNlst3NOXFVjt
	 furWBh6K+kvzongrECPj7jXeHBGlvh2nYkvmJhVSxxDJo64/LqEtOagN6MJm7mNRaDYPS
	 cumcUoIxLLlJ45U2zkaQsSWPO26dig9Oif0ObxCoTQDp73GJUxv05hvlL6lM87ESNK9XT
	 cuty2DK4JzdksVR6t1YVjfH/bBfx0NtIaCPGp/qVVhyM+krq3DnHykqkVhK0gHz5qOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Wvx8167t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBCE606C938
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Wvx8167t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992801F00919;
	Wed,  4 Nov 2026 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793820182;
	bh=Q1W7xIyJgzvyxHQ7v4UpUK7+MJZk2+B4nUAl1mhe8FY=;
	h=Subject:To:Cc:From:Date;
	b=Wvx8167t9O7E4METpEIHDjRf2fGv8szObzNX47sc5vjZ0LWqbiAYXarB6pEqsGjSJ
	 VnymfwoDnsiAwbCeoz2VJPiaXvD5if6LXK9hHFJY/01l6rqabHHDTQ0xEstS/BPOx4
	 NT5w25/OjCYjiIFksS52Iwg2/cjFU5SuixKjxKHw=
Subject: FAILED: patch "[PATCH] KVM: guest_memfd: Establish memslot<=>guest_memfd bindings" failed to apply to 6.12-stable tree
To: seanjc@google.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:22:52 -0500
Message-ID: <2026110452-straddle-void-d182@gregkh>
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
git cherry-pick -x 3fe5d2944e5ac3fc5073344b0982c73703332e18
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110452-straddle-void-d182@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3fe5d2944e5ac3fc5073344b0982c73703332e18 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 17:13:31 -0700
Subject: [PATCH] KVM: guest_memfd: Establish memslot<=>guest_memfd bindings
 *after* memslot is ready

Wait to bind a memslot to a guest_memfd instance until *after* the memslot
is fully prepared, as creating the binding in guest_memfd will effectively
expose the memslot to readers.  As pointed out by Sashiko, binding the
memslot before it's ready to be exposed to the rest of the world can break
various memslot assumption and rules.  E.g. x86 could observe a NULL rmap
pointer if a PUNCH_HOLE hit the guest_memfd after the binding was created,
but before KVM made it through kvm_prepare_memory_region().

Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Cc: stable@vger.kernel.org
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260826170551.BEF801F000E9@smtp.kernel.org
Link: https://patch.msgid.link/20260922001332.1121266-6-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c7526c1617f7..f26986136bc6 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1934,6 +1934,15 @@ static int kvm_set_memslot(struct kvm *kvm,
 	if (r)
 		goto err;
 
+	if (change == KVM_MR_CREATE && (new->flags & KVM_MEM_GUEST_MEMFD)) {
+		r = kvm_gmem_commit_memory_region(kvm, new);
+		if (r) {
+			kvm_arch_free_memslot(kvm, new);
+			kvm_destroy_dirty_bitmap(new);
+			goto err;
+		}
+	}
+
 	/*
 	 * For DELETE and MOVE, the working slot is now active as the INVALID
 	 * version of the old slot.  MOVE is particularly special as it reuses
@@ -2111,32 +2120,25 @@ static int kvm_set_memory_region(struct kvm *kvm,
 						   mem->guest_memfd_offset);
 		if (r)
 			goto out;
-
-		r = kvm_gmem_commit_memory_region(kvm, new);
-
-		/*
-		 * Drop the reference to the file, even on success.  The file
-		 * pins KVM, not the other way 'round.  Active bindings are
-		 * invalidated if the file is closed before memslots are
-		 * destroyed.
-		 */
-#ifdef CONFIG_KVM_GUEST_MEMFD
-		 fput(new->gmem.file);
-#endif
-
-		if (r)
-			goto out;
 	}
 
 	r = kvm_set_memslot(kvm, old, new, change);
+
+	/*
+	 * Drop the reference to the gmem file, even on success.  The file pins
+	 * KVM, not the other way 'round.  Active bindings are invalidated if
+	 * the file is closed before memslots are destroyed.
+	 */
+#ifdef CONFIG_KVM_GUEST_MEMFD
+	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD))
+		fput(new->gmem.file);
+#endif
+
 	if (r)
-		goto out_unbind;
+		goto out;
 
 	return 0;
 
-out_unbind:
-	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD))
-		kvm_gmem_unbind(new);
 out:
 	kfree(new);
 	return r;

