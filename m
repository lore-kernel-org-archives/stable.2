Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603880;
	b=dT6ZlzrngXXwwmeH7zfU7nb7MMoYi63b22stNzfkarnqOP879VWn/9quuhBgNDgyc20l
	 uxS3h6zS32OuDSpiR2T29XbbfBgxn+TnnM8Hb5kt/4To3oXY79mDstcxtiaT+2n68ZkKC
	 8OVbm3NPWKrQ0EM/JCykh4KdaIOHg7V1LMLnmaL0zdcjq/eTNfruvPI4lWKCmHmju8e9P
	 ArrvMoP5pYQmbOwQtv87cZPWJs/REvSL/aM56Xa5H5X9eHf3j/yoUYJft7b+2LMh0UWAI
	 zYraGHWddf5B0htFK6al+eR4aSt8swVMDkGd7eC1oOg+J6xsTh3HzGrd37IkfLvOtJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603880;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uduc+gEwX/974Tljgf0QSm7qnQ+4GeXpHOuUK/XqxnE=;
	b=03q9wUNrgnoqURIdqDhwRlA2eQ7uPkc30GJTzthBignmNyIYMNkNVJ21CYTaMum5l6N6
	 JAS4rmMdWs6lnQgvGHsp46vu8GBBoPM+CMw7DE9r7KoG6sTFCzIEHUfKzNJUMAsQZPbSh
	 7tIZnKj3vGF7iRea9XO8Tk3wFo4pwq338Q9yThLWwyeb6LEYM8nwIurUiZBmXwXc1nVqu
	 eZPSqAIenb5XFpZSqM3+Bevwh8GuDCmPjeDVWFeUnIPQkY1J0ap1fm+GxupDF92w94OOB
	 AfIW5Wm4l9aj3AC6uSNgeagDE3xM7aUBW40LZEZPmmpx6nGWBnqPYeck3KTLPyWULzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0qm7eBjQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5DF606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0qm7eBjQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1CA1F000C0;
	Wed, 25 Nov 2026 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603879;
	bh=uduc+gEwX/974Tljgf0QSm7qnQ+4GeXpHOuUK/XqxnE=;
	h=Subject:To:Cc:From:Date;
	b=0qm7eBjQno/eCWNbRl8YyjJKMgzfGyYcGQFpq4WOnvsdwzyprcqEU85iUSsvn96bX
	 /u1c5togvikJiIbFqIzs5j31p3Em8djIpiGZNA2Mffx8AXP35TPNpoFM0DR9y/Vnav
	 gt2y3PLJ8VIhS68E6ySb7dmf/KEJI1eLJmNDRUqU=
Subject: FAILED: patch "[PATCH] tracing/probes: Reject array count on non-dereference string" failed to apply to 5.10-stable tree
To: mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:37:25 +0100
Message-ID: <2026112525-deflator-chunk-bba2@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0941144ebeaf3ce46c80711f00e935921eb28b21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112525-deflator-chunk-bba2@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0941144ebeaf3ce46c80711f00e935921eb28b21 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Fri, 13 Nov 2026 17:29:13 +0900
Subject: [PATCH] tracing/probes: Reject array count on non-dereference string
 sources

The runtime array loop (FETCH_OP_LP_ARRAY) for string types requires a
preceding memory dereference instruction so it can advance the pointer
address on each iteration. Non-dereference string sources such as $comm,
immediate strings, and eprobe event fields cannot be indexed as pointer
arrays, but finalize_fetch_insn() still accepts an array count on them
and emits an invalid FETCH_OP_LP_ARRAY sequence.

Reject string array counts when the preceding operation is not a memory
dereference.

Link: https://lore.kernel.org/all/179455855309.403392.4197028577158545202.stgit@devnote2/

Fixes: 40b53b771806 ("tracing: probeevent: Add array type support")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e0340ae126b8..cff55dcae36f 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1990,6 +1990,12 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 			 * For the symstr, it doesn't need to dereference, thus
 			 * it just get the value.
 			 */
+			if (parg->count && (code->op != FETCH_OP_DEREF &&
+					    code->op != FETCH_OP_UDEREF)) {
+				trace_probe_log_err(ctx->offset + type_offset,
+						    BAD_STRING);
+				return -EINVAL;
+			}
 			code++;
 			if (code->op != FETCH_OP_NOP) {
 				trace_probe_log_err(ctx->offset, TOO_MANY_OPS);

