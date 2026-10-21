Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594947;
	b=SKLTq67XXDNeXI6QN9lto4IoQi+BF5Fod/6RtW7sfWSeKnx25Ei6QzHDa3q5sUk+Vo7c
	 eR3kcEwW0nLpByq//JUNNh9/XIe39bG6BRVtd4hYo39CSqlQdwEqrs6eAYGMGh3iF8v0s
	 aEYbF+vivJfx/L2sd0FBVCsFHh6OGhtP8nnjVvW1fitFluk1W2YLeLcap8jb193isPm+A
	 +Y1AMQa3HwsGO1XqTGZy8tQo5DZXPCNmrRgPTy+P/BIN0d0B8Lq+sORTJxm2dsciRsWcR
	 g+jVlnDU8iZXDhsKbIHNGl+3GzRv6MY3FKtxglG5JLmpe1QSam9caYs942NR9wku4FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594947;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fx9BoK7N9qN4u1RYLHCWRfnwYwFj8ATZm1TSL/u6pCY=;
	b=NsnurUMlzFSIUoma6r1B2cXseV37mXM1TeT+wxbVbOQ9XIur1CM7SBS5J9UeakmUekYV
	 JaKfF4hVYHyiB/394Y2wotoIGLL6BrUpOozqwalpLthY4hlIGSjdreWDF0s2ZT+jjiCq+
	 vYIpJWzpAVOlSDRi3b2MA50vhWIT3dNNJkq0+WTn/GU2ti3neK/GzKpR50ihP5ebL6HZu
	 qWeDLy+81OHNtAJm5+8/SsZySwgysrI3/cCvtvRbdn+O2u3FeLRX5/RkXIYyEQj8ALjGq
	 2+WjqKeQVioFWS5ZawH48nD/B6Gtdmf7QdkL4GI7ZkLp7csLVSKnvjfhpIVMalcV33w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ANIfkzCk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF9B606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ANIfkzCk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7071F000C1;
	Wed, 21 Oct 2026 15:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594947;
	bh=fx9BoK7N9qN4u1RYLHCWRfnwYwFj8ATZm1TSL/u6pCY=;
	h=Subject:To:Cc:From:Date;
	b=ANIfkzCkVbQyAQ5uRdNTpsck1EmqOsGol8UcAd40P94aHzmfl5Pal1EINCF5zTxvR
	 Q6jn0oTcYIbrNqWL1YJYy8xgAZoCwLJIjKI04KqEdqfaP8LaJLzSErDHh0BGOVg27n
	 mVjyAflLQBHL78SGo7vIjNpWSdtAGrdxy5RfOSAQ=
Subject: FAILED: patch "[PATCH] tracing: Fix NULL dereference when copying keys for a field" failed to apply to 5.10-stable tree
To: donggeunyoo.kernel@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:50:27 +0200
Message-ID: <2026102127-agreeable-wisplike-bc63@gregkh>
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
git cherry-pick -x a0777b9e53157f1f6848a0fd0650f5465391ea81
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102127-agreeable-wisplike-bc63@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a0777b9e53157f1f6848a0fd0650f5465391ea81 Mon Sep 17 00:00:00 2001
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Date: Mon, 14 Sep 2026 14:34:43 +0900
Subject: [PATCH] tracing: Fix NULL dereference when copying keys for a field
 variable

In event_hist_trigger_parse() where it needs to create actions like
"onmatch", it calls:

  event_hist_trigger_parse() {
    create_actions() {
      action_create() {
        trace_action_create() {
          trace_action_create_field_var() {
            create_field_var_hist()

Where create_field_var_hist() does a loop on the hist_data
representing the keys. The issue is, if the keys uses one of the
pseudo field types (like common_cpu), the hist_data field element
will have NULL for its field member causing a NULL pointer
dereference when accessing the key_field->field->name.

  # echo 'hist:keys=common_cpu:ts0=common_timestamp.usecs' > \
      events/sched/sched_waking/trigger
  # echo 'my_synth u64 lat; int prio' > synthetic_events
  # echo 'hist:keys=common_cpu:wakeup_lat=common_timestamp.usecs-$ts0:\
      onmatch(sched.sched_waking).my_synth($wakeup_lat,prio)' > \
      events/sched/sched_switch/trigger

  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:create_field_var_hist+0x771/0x1380
  Call Trace:
   trace_action_create_field_var+0x360/0x600
   trace_action_create+0x393/0xe80
   event_hist_trigger_parse+0x3e47/0x69e0
   trigger_process_regex+0x1a6/0x250
   event_trigger_write+0xce/0x160

Instead of accessing it directly, use the proper handler
expr_field_str() to get the name.

The three previous patches are prerequisites: without them a .buckets
key and a common_stacktrace key each render into a command that cannot
be parsed back.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260914053443.981201-5-donggeunyoo.kernel@gmail.com
Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8af97fd4ee2d..b3df8862855f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3090,7 +3090,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		key_field = hist_data->fields[i];
 		if (!first)
 			seq_buf_putc(&s, ',');
-		seq_buf_puts(&s, key_field->field->name);
+		expr_field_str(key_field, &s);
 		first = false;
 	}
 

