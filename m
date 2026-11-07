Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050196;
	b=rYLxCS0ksCPK6fgBWyM7NhvimKwjs3U7f/wEKF/tXTBdepmUkjaRXxV7pAyES99FmpND
	 lPiOC6f1zl5p1br96WH3SVUuXgKkr8izBXB3mCuXE0ADFjg+i8vhdqEOFmonarb4SROOJ
	 CPfUWJrnEi76sRrapSGqA5jGPgo+VCdRDDm2STia/DoW9VgDqmbR+rgPZEKjTDY0RSS1D
	 cISbqciszMDGLDaoVuLw+oa7TKJQTUl9mufdI4q7+7Nu9r0Ovvm8KOpFHmlOwe44AFtTE
	 Z9m1YhhCz4bOAXoixscFkj6UYiS9GOsqSnkMk+jZXtNYOENUVC6FJT3F+vo7YsUs32A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050196;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EWGK6GOrjPzUgmjvv7chsdXL4jOHJkZOuqEHLtA8RXs=;
	b=NZAI3RIzDIZJgve26HgM82fgQgknEgzDFmmDLkZwOSZ312AOSJUxS30zlScmS1lD7Q7/
	 EKXBgs6W6mn0ao8q0mbdEy0a7kqOcu4ytyjJd6vl3lgF0dTAyNtTf/JM4Q7NDJU0zUZ/a
	 1BFUCCPRuNwkybaPeq5FmE1EX8DdEBUtE4UVoS499vKmh1sybmZ7Ni32LHlzz40XKTkjT
	 CcLUBlkSX1Q0MKaRQIkABaCR7/+X7s5G6Zorv8aOhm6cU/xJ2JoQsHeOnqiPbZpI47sKm
	 HwCWz4jQngKEEuBafKbBcDWWwJ4irZqmexkB77Xs+F5vrwTIzIS0BshWskZqGkSLBhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cp5dksyn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1672606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cp5dksyn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050FA1F0089F;
	Sat,  7 Nov 2026 11:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050196;
	bh=EWGK6GOrjPzUgmjvv7chsdXL4jOHJkZOuqEHLtA8RXs=;
	h=From:To:Cc:Subject:Date;
	b=cp5dksynt8mUeRMH0RQOo4xVSf/D6yPdeViuWCw3EaygA89bwOj4xJkkHm3XGnSzN
	 51uaalfZeH7L2pK7MX5wabFW39weUmrUpB5G+423KX2DhPJNltO/nt1JJNLgHgJ8Hz
	 ZgBCyTDU5JDTEIW01YoSCBfMRvCRLX9BNrE8oh8i3z63W0yIUpp2d1VnSswif+TE2K
	 3Twtakf1uBlhK7MmurA25wb0DkkeEaf2sjr410HQfQy7ZExtTrerohkQq+JsUYZYBR
	 tgDIaoaYEBPvtuXGihs1O5LWdbSj4Qz8W7oMRpAFte3xniDlqiFB+0x7SpavFHSbVf
	 jPHzvvAgLuf3g==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	david@kernel.org,
	ackerleytng@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: Use goto to handle errors during memslot preparation" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:16:34 -0500
Message-ID: <20261107061634-failed-5.10-23a205797cec@kernel.org>
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
git cherry-pick -x 23a205797cec86f391d0be886b9bc741e1262063
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061634-failed-5.10-23a205797cec@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




