Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D502D9EDC
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 03:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495970; cv=none; b=OS8NdKvHgj4d4vZLpxvJukWaz/D8uX0qqK7xA3AwraaOmipO8UVJlWlY8sv7A5zMtqGIHeRVY7CAhKZM8FOTvGEARkNVZY+0x2SociLJ/tZzfrDmoQg95IRrtc5IU2vOOP2sZZrR4PDnx7rm2HFcHQNwumu0aPB2QKciKUmcEhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495970; c=relaxed/simple;
	bh=E0KQ4eA+Zlhbl44M8baXfJ3OJ3c/ZYXN2qIN0lxvrIY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jSQ0PHXGUw0E3gEciXOFNaMOuy4kyLxeBKA9VzSN0sfstpu4s62Uji++FX1b9kiWgevI7pCKBpNYhT2x8/6Hh2T3h9n3a+VN/MKGFCz/AGZ9QlbaJnoMDNabTCtcMvAYjFBN7xQ4SDBQhR6wL8kUYw4VGOPZflk13GHBbB4JLAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nJWUvzzG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nJWUvzzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029631F000E9;
	Mon, 15 Jun 2026 03:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781495969;
	bh=n2Srmi6FwCuZfTb8I2ex8CA4MaYD5qi+1eyL5J4PzhE=;
	h=Subject:To:Cc:From:Date;
	b=nJWUvzzG80sZ4jUkhu4c06F80AJuVjB+H/empFGWO+fgsD4EBiiA7zkAH5VZdEjHS
	 TmfVrfwRyUH20ioB26c/wfI4PA3JbK5trDklEJd7iIQPyRswnKhkdFtSEzd5+NPnT7
	 BsvclUi2QJuGtoz7A0EJ19PppE72Wmz9XPR4S7LQ=
Subject: FAILED: patch "[PATCH] KVM: arm64: Take the SRCU lock for page table walks in fault" failed to apply to 6.12-stable tree
To: imv4bel@gmail.com,maz@kernel.org,oupton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 05:58:27 +0200
Message-ID: <2026061527-county-underwent-3b10@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x f2ca45b50d4216c9cc7ffabf50d9ad1932209251
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061527-county-underwent-3b10@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2ca45b50d4216c9cc7ffabf50d9ad1932209251 Mon Sep 17 00:00:00 2001
From: Hyunwoo Kim <imv4bel@gmail.com>
Date: Wed, 3 Jun 2026 21:09:33 +0900
Subject: [PATCH] KVM: arm64: Take the SRCU lock for page table walks in fault
 injection and AT emulation

walk_s1() and kvm_walk_nested_s2() expect to be called while holding
kvm->srcu to guard against memslot changes. While this is generally
the case, __kvm_at_s12() and __kvm_find_s1_desc_level() call into the
respective walkers without taking kvm->srcu.

Fix by acquiring kvm->srcu prior to the table walk in both instances.

Cc: stable@vger.kernel.org
Fixes: 50f77dc87f13 ("KVM: arm64: Populate level on S1PTW SEA injection")
Fixes: be04cebf3e78 ("KVM: arm64: nv: Add emulation of AT S12E{0,1}{R,W}")
Suggested-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Oliver Upton <oupton@kernel.org>
Link: https://patch.msgid.link/aiAZfdeyanIvP8SD@v4bel
Signed-off-by: Marc Zyngier <maz@kernel.org>

diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
index 9f8f0ae8e86e..889c2c15d7bd 100644
--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -1569,7 +1569,8 @@ int __kvm_at_s12(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 	/* Do the stage-2 translation */
 	ipa = (par & GENMASK_ULL(47, 12)) | (vaddr & GENMASK_ULL(11, 0));
 	out.esr = 0;
-	ret = kvm_walk_nested_s2(vcpu, ipa, &out);
+	scoped_guard(srcu, &vcpu->kvm->srcu)
+		ret = kvm_walk_nested_s2(vcpu, ipa, &out);
 	if (ret < 0)
 		return ret;
 
@@ -1665,7 +1666,8 @@ int __kvm_find_s1_desc_level(struct kvm_vcpu *vcpu, u64 va, u64 ipa, int *level)
 	}
 
 	/* Walk the guest's PT, looking for a match along the way */
-	ret = walk_s1(vcpu, &wi, &wr, va);
+	scoped_guard(srcu, &vcpu->kvm->srcu)
+		ret = walk_s1(vcpu, &wi, &wr, va);
 	switch (ret) {
 	case -EINTR:
 		/* We interrupted the walk on a match, return the level */

