Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049185;
	b=j3YtlCP27NwoLiq3i89OyYMfLK4KCaxOxpmFNc+hp1hImV3l0wH1BQ8kho0vFmGVEpBH
	 JUTdrMn5+1tPmQkS0Tp6YvGsfVZBcs4mk6WNjsUreLbMSJZrWKJ2rzQg3GnK6Aw6vq2qW
	 NylipsLMHZQvT/wLk3RWmEtHn+5CGshr42ALbfCSGKFXdXuM83vfBSHZOSLLtP8v+FnFH
	 odkJEdAfiuQrWdCe9u/yAIlwYIuRGBkRxJuv4k9F+9ZVxyPVN3zAAHWjFOF2PcfokL8nu
	 TaDuXipSo+Tv6c/81qupt2d2lG8K627I+g5mqCpHEX2stbJ/ZmzNtZxiwlNAow2wBtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049185;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dey53WxpMpZHi1BG8gT3nqnReWNTS6WSOO4U5qJLBns=;
	b=LSfUMi21JGJSHOXf6WfoR0dyBp84wHV47+op780eykTkjGi+qRBM6jVA1tbtPlNDuQjX
	 G9HHeKUcJH3CN73jZVB/VxSIFC2sLtbifGwP6+HptHUA0PtDTtY5thIkYu9bTeg6gasH+
	 kL5K403+1RsBhV/R50XrxtcTylmMypJYROSDvi3jOEVxNL6whJVRkkrG3PcLpW7NifpQL
	 Bc7cJcFqs2B9mdwOJCHTy7IBlVtWMv6hpUG2kl6UE0niCIc7rif/4IbxyUD5rodfESnyJ
	 6xZukwrnlcXSoGWoEhl9Nw/msx8j4ZSLi6jnZDC3hG90ZKM+5n4ylrQY/mH6o8UtaZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hPBqiYn+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12143606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hPBqiYn+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA281F008A1;
	Sat,  7 Nov 2026 10:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049184;
	bh=dey53WxpMpZHi1BG8gT3nqnReWNTS6WSOO4U5qJLBns=;
	h=From:To:Cc:Subject:Date;
	b=hPBqiYn+6PfsQQ7b3iLgE+mYvqrf1FHk+jeS8KqfhQD15ridv0sXAGpL2eafKaKRa
	 RRVD6iCFCeDwELb16yUaXawjigf9Pbqn7ZVzMVsC1h3dCXYy2dhw4lup0bs7trDbi+
	 fGkHKc13QpRJiVzl8bvyQXIBVDYN8q3nCatYpsIVgvZuKP/5VbWORGNEdZO+MO8BBd
	 4T07+MKb89v/XhtD5sRUo85OK4Tj2yJAnpNCxUpCpx8JEe4vlRsgYrvxQKUI9UAA8R
	 O/wa7fDGxSzts/y6HReJQL3Jcd4DZlc0TBjm9Z441UfnVWJFahryCKWm3RxzerZup/
	 WDvykgFr+tYAQ==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	david@kernel.org,
	ackerleytng@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: Use goto to handle errors during memslot preparation" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:59:43 -0500
Message-ID: <20261107055942-failed-5.15-23a205797cec@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 23a205797cec86f391d0be886b9bc741e1262063
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055942-failed-5.15-23a205797cec@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 23a205797cec86f391d0be886b9bc741e1262063 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 17:13:28 -0700
Subject: [PATCH] KVM: Use goto to handle errors during memslot preparation

Use a goto to unwind early memslot changes if preparing for a memslot
operation fails.  This will allow moving the creation of guest_memfd
bindings into kvm_set_memslot() without needing to copy+paste the unwind
logic.

No functional change intended.

Cc: stable@vger.kernel.org
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Link: https://patch.msgid.link/20260922001332.1121266-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d8..3c0dbe60a5b4f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1931,21 +1931,8 @@ static int kvm_set_memslot(struct kvm *kvm,
 	}
 
 	r = kvm_prepare_memory_region(kvm, old, new, change);
-	if (r) {
-		/*
-		 * For DELETE/MOVE, revert the above INVALID change.  No
-		 * modifications required since the original slot was preserved
-		 * in the inactive slots.  Changing the active memslots also
-		 * release slots_arch_lock.
-		 */
-		if (change == KVM_MR_DELETE || change == KVM_MR_MOVE) {
-			kvm_activate_memslot(kvm, invalid_slot, old);
-			kfree(invalid_slot);
-		} else {
-			mutex_unlock(&kvm->slots_arch_lock);
-		}
-		return r;
-	}
+	if (r)
+		goto err;
 
 	/*
 	 * For DELETE and MOVE, the working slot is now active as the INVALID
@@ -1977,6 +1964,20 @@ static int kvm_set_memslot(struct kvm *kvm,
 	kvm_commit_memory_region(kvm, old, new, change);
 
 	return 0;
+
+err:
+	/*
+	 * For DELETE/MOVE, revert the above INVALID change.  No modifications
+	 * required since the original slot was preserved in the inactive slots.
+	 * Changing the active memslots also release slots_arch_lock.
+	 */
+	if (change == KVM_MR_DELETE || change == KVM_MR_MOVE) {
+		kvm_activate_memslot(kvm, invalid_slot, old);
+		kfree(invalid_slot);
+	} else {
+		mutex_unlock(&kvm->slots_arch_lock);
+	}
+	return r;
 }
 
 static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
-- 
2.53.0




