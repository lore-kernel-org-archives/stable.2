Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD4D4AFE12
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444891; cv=none; b=L9EAKjB9BL9lK71+NLQFMDNS5BtfOdKqFJm6Ju3DR4xBCYzbwbBJ6ulrsZm13jFPoMGl12LM0MLPgQqsxrUZKZd0u8Ns7KLN5xfvPebcs2mar44zCrDX35hXDUEgLibk+K2/DrpI7rJ2dZEne8MbWj1Em5nKuBrmSmUBKm8+Gg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444891; c=relaxed/simple;
	bh=r6PmZ+cXSLYdiGuu0rXxIxIhz8qrMqeQ9TxEiiPLzo0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oN4wjpUN5SccgL9i93USBsvmmZGr3l5IGYdsZxgl9qbJePEDvOANhJ0G6fquHsaiW2D81n0/nPjZYu+P2o2p81dn3/rOmuvNapx9ngAxvcb1yUrYJXE8auDVRCz8NdR7Q08MQmHpV6DCiXRBTqPfZl3Q1AA47VM3816DYa6ZcPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OtmxwqDH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OtmxwqDH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D967E1F000E9;
	Thu,  3 Sep 2026 14:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444875;
	bh=w3BmxNvdH+E91Gwhry6lKHWwdTM7bKEyLIWTF1keH3o=;
	h=Subject:To:Cc:From:Date;
	b=OtmxwqDHJ7qzO3SzcvRc/AyPozW09zfFxJNeWT018LZLgC1esnlZ9Masfhvtv4KQK
	 q+bHvuFp+rAmSWZzQeYuDpb4oCuPL4bCCufsbF6RSVLFqnfpjMuNX7D+WKG7qVO/8f
	 63gsPdKCVpwJ5FN8qVquuk2WV6lCtNCU3Chp/Dxg=
Subject: FAILED: patch "[PATCH] bpf: Disable preemption in bpf_get_stackid" failed to apply to 6.1-stable tree
To: jolsa@kernel.org,andrii@kernel.org,chen.dylane@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:51:54 +0200
Message-ID: <2026090354-evolution-kitty-6754@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 15f1bd8574662f1b7b26aaa2e23ebf4066f0117d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090354-evolution-kitty-6754@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 15f1bd8574662f1b7b26aaa2e23ebf4066f0117d Mon Sep 17 00:00:00 2001
From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 3 Aug 2026 23:01:42 +0200
Subject: [PATCH] bpf: Disable preemption in bpf_get_stackid

The get_perf_callchain call needs disabled preemption plus we need
it disabled as long as we access its returned trace entries buffer.

Note the bpf_get_stackid_pe function is executed already with
preemption disabled.

Fixes: d5a3b1f69186 ("bpf: introduce BPF_MAP_TYPE_STACK_TRACE")
Reported-by: Tao Chen <chen.dylane@linux.dev>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/bpf/20260803210149.296496-6-jolsa@kernel.org

Closes: https://lore.kernel.org/bpf/20260206090653.1336687-2-chen.dylane@linux.dev/

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3ee0034daf52..5b18d728f4b8 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -632,20 +632,22 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 		return -EINVAL;
 
 	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
-	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false, 0);
 
-	if (unlikely(!trace))
-		/* couldn't fetch the stack trace */
-		return -EFAULT;
+	scoped_guard(preempt) {
+		trace = get_perf_callchain(regs, kernel, user, max_depth,
+					   false, false, 0);
+		if (unlikely(!trace))
+			/* couldn't fetch the stack trace */
+			return -EFAULT;
 
-	err = stackid_fastpath(&stackid, map, trace, flags);
-	if (err != -ENOENT)
-		return err;
+		err = stackid_fastpath(&stackid, map, trace, flags);
+		if (err != -ENOENT)
+			return err;
 
-	new_bucket = stackid_new_bucket(&stackid, map);
-	if (!new_bucket)
-		return -ENOMEM;
+		new_bucket = stackid_new_bucket(&stackid, map);
+		if (!new_bucket)
+			return -ENOMEM;
+	}
 
 	return stackid_install(&stackid, map, new_bucket, flags);
 }

