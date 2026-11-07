Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049109;
	b=wTsO+CBEx4gxdVdMvy1GzelsFVMFDp0bgqn6AhUfOYr4RT0U0PCmB4yUe9wEZSATsPtL
	 YwHHH1+k6Js72/wpgm/XVBciRHOw6iFNugyF2tujcdgbJipICvlEzlAOUdcZH46Y0r4iV
	 C06hoJs7585AlhHXLSYBInMWagreT0ksK4yiwdZQoD5Gf3NgtoYZbLv4awQ6DBfKSgj1+
	 53tvyNQwplv6zRComsieKI9TFI7+EUwNaY9olgv/WRAOIO91qgnJW1gGU0ZSZqS4/Jc4y
	 +YRMx35my6Gh4JULItZQ2VpGQ+QKtvFUmfYnUQJbzV4qwEMmIfj5mQXULm1azopdPbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049109;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IPzqat9i6W28aivKfx2eG45k57O5xseNiIq9uaw0u5U=;
	b=IZa/hYcCm4kOZzmXMK1cFJ8+LYq20uR8jqLRZk1wedgtsPDRahHEi5vkfO0FznbvnDLk
	 dQBTe3wHgzyWVmlbb1GvpnTfaHG7bUFlwnv20pvXKwpQkSUfQMTz/kgvlM6cwimkPbJjZ
	 pCGJCcDHvDSmhRptSvCXT6Msd463+1aMeXDdniZdjaEWPZiHf5SqU/hw2aM3a9BJWCyFf
	 JHJTwL4M7Fwi6QQB3TOdgxHFaMtmCgKy2y6b+uhwg/CFf+Z9fTRNtrzuqxTxIPG5QeWN2
	 +5RLQe7KOiK0vOVtOAfTxFZL8os/a6csRZJ6L0ZwWP2niz2U22TCHx20BtZWy7+yl4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JTz/o293";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05858606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTz/o293
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415D41F008A1;
	Sat,  7 Nov 2026 10:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049108;
	bh=IPzqat9i6W28aivKfx2eG45k57O5xseNiIq9uaw0u5U=;
	h=From:To:Cc:Subject:Date;
	b=JTz/o293cvXMYFrNOTBLSUCjr2NowJCsk2YRgpGz4CxXhjRELv9OlNC2Hs8Dl1Njm
	 O5UJXtmjbY55na+MHQHMBoHUr+/7AVP+wPkibs6gII9WQqNxVJKmCEvdNWuGgkcAs/
	 YDbZgaqqmAzbF4FnYsZfNTF4f2KHVFYrYWl5IX7apUkkVlq2MH+gK28c821NlPdZ6t
	 4Kq9wo6HiQxJHQYyF9L7XLq0PxkxJQB+6GHNK3HSBn0UhYQoSrIf8QfrkFsdSWEAw/
	 jw2y7gQWX6H81H3mMj49sTqP4U4uHg93A64HVAw6DlEC4ilVsxcNd7Uo/EBJYaA/Qq
	 g6IkG/DN/X0QQ==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	yosry@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when preparing L2 state" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:58:27 -0500
Message-ID: <20261107055826-failed-5.15-1c4c84a643b7@kernel.org>
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
git cherry-pick -x 1c4c84a643b704e473cb171f7b61359ff29b12a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055826-failed-5.15-1c4c84a643b7@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




