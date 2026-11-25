Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603873;
	b=5IWESaqDSGmeVSdjwXq6WbOYb/PI7Psxv4Dlrwod7cZQZNFLc8rH4eAsZlc+6BgJHiFr
	 lMDT5VIw9H76GSb9eLZE8VD0sft+8XkEnROt1jxLFepshHHO8W1cBY8dMH0chpxZLWKh9
	 +Mi1UU/Cvvx6f+SigKqNV/peFUkDR9OB6dXW2TglBzQkq5NeAZEtwwhk3EUJIiZrEJeuh
	 ZJZi4/rTaNFMyDocJmNx61y6uVRG8/qc+EVCBXb2PZ1YqkJKWUwTeTbIhuC9rlvBlSCkW
	 75rCJYF8tfkxCY1c0oSvym42i1M3MgHRrJsA/H5F+c1VmULntjaN+VlLmBZ0wPc20jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603873;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DCHYR3I90AgscAnesasMMd+KcdFaYEYF8OGsElWfnuI=;
	b=I2ywdNtszunxTugPCkY39Nh4ItGWYJ3MlpbNz3lz+q9VdUgNukMB7+kMs0aRNbPpIvkx
	 cOUUwHlCi2BY4YQM1Cgda4hD69PnoZU7bjly2bo9AFRvUXLkRVqttUgOUtzeqthD6hqbG
	 9tfjyqyfaX/0KPbz6CWz2ezBmx/T85FV8oDkbyDf25Tlv+1O/9zfWaDEz19bJSONCOZ3d
	 49Dp/uyLN661fjktwonp/Vze75pB3LPlIvXzkdLeOtUXxQKnQkKmQYdQwHtOrn2DAIbO2
	 2dDUtjtc6TQO9PC7Ol5y65i8G6zJ4YFzxVVl+C3fugkb5jyoGLAbheeYzQTDjo8mFYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="rwnIQ/gj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0DD606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rwnIQ/gj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DC41F000C4;
	Wed, 25 Nov 2026 10:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603873;
	bh=DCHYR3I90AgscAnesasMMd+KcdFaYEYF8OGsElWfnuI=;
	h=Subject:To:Cc:From:Date;
	b=rwnIQ/gjuIcucMvt1mKv3fkicvUQ8JE8psl1JoL89TazipZkeYkT8uk42fKhG42OZ
	 S8pIY6avB76pGHOmk0gMEkYJo4xMlNXn9vvYdir7MQ2GuPGMGIYJA9S4DqTfbW40mx
	 PodJ8sWuXwFBw3Ow4I6fXzxpDR+Y7A1IuBpkoIaA=
Subject: FAILED: patch "[PATCH] tracing/probes: Reject array count on non-dereference string" failed to apply to 5.15-stable tree
To: mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:37:24 +0100
Message-ID: <2026112524-broadband-national-e3ac@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0941144ebeaf3ce46c80711f00e935921eb28b21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112524-broadband-national-e3ac@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

