Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC455D896
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788959668; cv=none; b=uVsgFxIedvli/Uk6OBe+kqSRs3qut8Dsprqyj3SuiX/4mB2DujoCCVOzbYA35MKYJM1Ld/OnND0N07/MotetIbrz9YJALbnTg68tHeszPz1C3N7bPUrPZFFVZoyGJ9UOB4EU2tqdBrttDAH+QEPKazYXWoaRiGUlWAvcQRXuC0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788959668; c=relaxed/simple;
	bh=C8RvZeFI+cGsHoc+IhP8F9e2YLd7vBJr6uLrc4K1O5w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p+vhVYufOwO1Io5sKFjI3GMLp/2XYTMIY4rLwreYuGZ/L2b/gxeUFzPRrTsospemThbTQlslzxyQKQKLbw22H2E+ZZm9hSBy5oDVw/d5KL1hzWaPFTFvJ5QKyNoyydfRrb5z/1Dvx3JMFaVwF3u0PImhzpHrMJ2lUOPWJ7wfR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oSAhCzAI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oSAhCzAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D831F00A3D;
	Wed,  9 Sep 2026 13:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788959666;
	bh=PfVzujmKryF1ZElA/u50d4RzcFtIAI4pKfSl7YFPfAQ=;
	h=Subject:To:Cc:From:Date;
	b=oSAhCzAIYTv8e3GBR+NUwDChekxvMgoDOS+ooyfVAmMG+GGDwMtrxi26c5d/Toc99
	 6lecHl+Oqyv1LmEh0/hzymnyYduFhUsjssRYcz1saJYlB9gwdFe++IqfVtZc7Y/cOw
	 qlGgHA3l8P1iQPWMwscy0+TdMLWi4w+zLqY5SQfw=
Subject: FAILED: patch "[PATCH] rust: devres: ensure revocation is complete before device" failed to apply to 6.18-stable tree
To: dakr@kernel.org,aliceryhl@google.com,gary@garyguo.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 15:10:50 +0200
Message-ID: <2026090950-monetary-spookily-8bf1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a10639966fd72fff8f7fbf3c8e733307daabd38f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090950-monetary-spookily-8bf1@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a10639966fd72fff8f7fbf3c8e733307daabd38f Mon Sep 17 00:00:00 2001
From: Danilo Krummrich <dakr@kernel.org>
Date: Sun, 28 Jun 2026 22:02:53 +0200
Subject: [PATCH] rust: devres: ensure revocation is complete before device
 finishes unbinding

Now that the revocation Completion is in place, also address the
symmetric case. When Devres::drop() wins the is_available swap and the
devres callback loses, the callback returns to devres_release_all()
without waiting. This means device unbinding can complete while
Devres::drop() is still executing drop_in_place() on another CPU, which
is a problem if T's destructor accesses device state.

Make the synchronization bidirectional. Whichever side performs
drop_in_place() signals the Completion, and the other side waits.

This does not reintroduce the nested Devres deadlock fixed by commit
ba268514ea14 ("rust: devres: fix race condition due to nesting"),
because that deadlock was caused by drop waiting for the release
callback to return (the old 'devm' Completion). Here, both sides only
wait for drop_in_place() to finish, which completes within the current
call chain. The Arc<Inner<T>> keeps the Inner allocation alive
independently.

Cc: stable@vger.kernel.org
Fixes: ba268514ea14 ("rust: devres: fix race condition due to nesting")
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patch.msgid.link/20260628200304.2365598-1-dakr@kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 4a1e5eec78ab..ebb5c19e851e 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -269,6 +269,11 @@ fn data(&self) -> &Revocable<T> {
 
         if inner.data.revoke() {
             inner.revocation.complete_all();
+        } else {
+            // Devres::drop() is concurrently revoking; wait for it to finish `drop_in_place()`
+            // before returning to `devres_release_all()`, ensuring `T` is fully torn down before
+            // the device finishes unbinding.
+            inner.revocation.wait_for_completion();
         }
     }
 
@@ -366,6 +371,8 @@ fn drop(&mut self) {
         // SAFETY: When `drop` runs, it is guaranteed that nobody is accessing the revocable data
         // anymore, hence it is safe not to wait for the grace period to finish.
         if unsafe { self.data().revoke_nosync() } {
+            self.inner.revocation.complete_all();
+
             // We revoked `self.data` before devres did, hence try to remove it.
             if self.remove_node() {
                 // SAFETY: In `Self::new` we have taken an additional reference count of `self.data`

