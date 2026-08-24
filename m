Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431D84052D6
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568720; cv=none; b=Ii7s7WsNrhGZp6IHM1Nv50p5r2F2e76z/mVtTlxluPeRMZXghR2DwrkwqVFFCg7rqGrlQ9EDsYdefHbR/EavCgUYONdhmR+K0mhVwYusTd2Znzlv/fD3omDuprtomxi1v5JqsVQHVBlwqsDjVJIDwVJgivTFCwtRa9OLKNSSpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568720; c=relaxed/simple;
	bh=w9LgZ/avHO7/LgM6cuaOKBpICd6sFZZDfMop+V/VENw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HkqKaaTUEGW1zfPj5uibdh56nB5nic6zuqjfBU6CFU+zae1nXjtjCwWbkDzQxW+gnVFy8UYJGnGIR5boM1USLO6vXEZlB78cm7V41XUnxFPeAhALCwKVfnbMN+n29F4luLuv4d/bZl6rSw8eYCXhJDmVdPkUZ/9EzCw9klIBEII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a7bwJWue; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a7bwJWue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF011F000E9;
	Mon, 24 Aug 2026 10:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787568718;
	bh=c1ddOdlMqKqP9jQNa4W2aXw6xWMmpp+o7YRJ5XuHzDA=;
	h=Subject:To:Cc:From:Date;
	b=a7bwJWue9GOwaTG3c2F4Pk1ndXBonFY0Lq2+KKHa6FlzRBgZuOg15KbCOkwgScTTC
	 G/vDmKif6m9KbOTs5H7E6l/8LWW51Y4s856GUEB1YojwUt/2FQaRFEMqQx00EwiZSf
	 e8csppg8Mvi0u5RlE9lQyFXVhkoO9hDKvCEuUprU=
Subject: FAILED: patch "[PATCH] futex: Avoid private hash use-after-free on final put" failed to apply to 7.1-stable tree
To: f3lix.dev@gmx.de,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 12:51:54 +0200
Message-ID: <2026082454-wharf-swapping-5328@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1c7efabfbaf796f11000a46094a69955a01ec6cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082454-wharf-swapping-5328@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c7efabfbaf796f11000a46094a69955a01ec6cc Mon Sep 17 00:00:00 2001
From: Felix Hoffmann <f3lix.dev@gmx.de>
Date: Fri, 31 Jul 2026 17:50:24 +0200
Subject: [PATCH] futex: Avoid private hash use-after-free on final put

futex_private_hash_put() drops the reference to fph before evaluating
fph->mm for wake_up_var(). futex_ref_put() enables preemption again before
returning. If that put drops the final reference and the task is preempted,
another task can pivot to the replacement hash and free the old hash after
an RCU grace period. The first task then reads fph->mm from the freed
allocation when it resumes.

KASAN reports a slab-use-after-free in futex_private_hash_put(), with the
read at offset 24 in a freed kmalloc-512 allocation. The allocation and
free stacks point to futex_hash_allocate() and the RCU free path,
respectively.

Load the mm pointer while the fph reference is still held and pass the
saved value to wake_up_var(). wake_up_var() uses the pointer as a waitqueue
key and does not dereference the mm through it.

Fixes: bd54df5ea7ca ("futex: Allow to resize the private local hash")
Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260731155024.1150011-1-f3lix.dev@gmx.de

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 0864c6e8cde7..d3fcad4ee716 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -139,8 +139,14 @@ static bool futex_private_hash_get(struct futex_private_hash *fph)
 
 void futex_private_hash_put(struct futex_private_hash *fph)
 {
-	if (fph && futex_ref_put(fph))
-		wake_up_var(fph->mm);
+	struct mm_struct *mm;
+
+	if (!fph)
+		return;
+
+	mm = fph->mm;
+	if (futex_ref_put(fph))
+		wake_up_var(mm);
 }
 
 static struct futex_hash_bucket *

