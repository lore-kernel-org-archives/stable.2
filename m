Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36BA4B3379
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444881; cv=none; b=kYAsuoGmmHylOyMHztAB0TN97NHXSB0fsSfK+ddn7uQQbtIs4jeCqJTHiivTB7/+uy/CHiuWVG/GL6SLUTEuSHoJ7TwS7P9bp/FDL4OGTZcU86No5LLgnvef6q0sPdRarnBtOAW5xsqR8HjvVYQ/EOmk4NFfMh0hnpuIi8zwWEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444881; c=relaxed/simple;
	bh=ASH1IOfSs1k2poMiTxpphYwZ+xoQ4m+0WY9GPU5c9YA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XeOyAZTMoXyTPTIU7Y6Q83R5i57FNEEZ2ywCgb7Cais54asURrWyN4Uy6QzUQ6MQDZsqatDVc/RDhp2KbI57I7qzHIYgbglbtiwX8hTyNlg3Vn9B1LjcRmpRhSDuCwP0VqPJZr3PkADMQHU/po4BTV86elAXrn80oJAsabsaFkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JLBKiPG4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JLBKiPG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611381F00ACA;
	Thu,  3 Sep 2026 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444866;
	bh=il0ihm9lTPTLFFHnD8Vd+29gxP/3fMbK8utqseiFJ8Y=;
	h=Subject:To:Cc:From:Date;
	b=JLBKiPG4QYLqT2p5HrB2zMdihGkMR0Akn7MuaRMk367Ne5m6vc/sXePInHMC6BOXC
	 7Zb65CNgWkS+cuoYtnsP4aH4lR046JWWxMTXm9zrNQTXb2EbtYEodgVZBlA5/1Oh67
	 ZML0Eqrwclkag+2ez4fEj46ndzBVLjRmtOJhkjhI=
Subject: FAILED: patch "[PATCH] bpf: Disable preemption in bpf_get_stackid" failed to apply to 6.18-stable tree
To: jolsa@kernel.org,andrii@kernel.org,chen.dylane@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:51:47 +0200
Message-ID: <2026090347-bodacious-studio-93ee@gregkh>
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
git cherry-pick -x 15f1bd8574662f1b7b26aaa2e23ebf4066f0117d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090347-bodacious-studio-93ee@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

