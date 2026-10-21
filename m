Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605780;
	b=IXnEWt0AEjCcJ4RTdQUnlBmTmP9LvKPqliBG3aiW2yGT4hCC+WE5wQejvNm4ydVz54xd
	 FAwIHz33tG58E7lUlUS9xQ7gDJih++LPq0Qfzw7SnEJGQIBchcYQUP1nhqT3r6bOiw0Cc
	 52ERO1VyeUF4HV/06rZHoutkoZBy2sZ1L5UIVxFQjUleEs2jGqyNX7i+e4/Tks9m8u/IP
	 vN9muIH6y2NMCDJkSaBA8FJk4JakZhN0agQu5qtBVpZNhw4j/gdRInxfStCuYh71BYeEA
	 EdufzrKv7YsbnjzAWep/kESuDqx6ku7POUptVxXrea3IG0gMQouOXLDV2hKZRQK79wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605780;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=K8j4/rNiiTPP9dCOLEnbghgHdMcy/i11GtA2em6CvL0=;
	b=Fhip5XfYhy3aLt0JOSYWU6XcVVQFavYqpDYaXC8JABMrYpFfKi/WyUWw7A0UpEKNV0m3
	 q+9Vyv9Q27v7b9B98nynZcqJIo/L4Oitmh2zoK3o4imvaNJER6eMYuPil4mghOhkwS2Xo
	 h8u/aGB+MKyt6Z1AmVZ2dg5sf+yUi8Ge8B2UjSZ0LJwKn9DhttlI0f7l7kT6nrgQUKmAZ
	 mFd0iY0a+O4TRZMNRecKcZ7E+qfz7WcS8PDBWyQoV6KOdxhBYTf48Yq0yXSLoaKYZCBhB
	 T19LoLHBwol9ndUqOkQLQ1jjeq7wRrxo8Efiuof05cDqnqbirlP+Sq55ZHLTI+EM/2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=g6lRo7rE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A239606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=g6lRo7rE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197021F000C1;
	Wed, 21 Oct 2026 18:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792605780;
	bh=K8j4/rNiiTPP9dCOLEnbghgHdMcy/i11GtA2em6CvL0=;
	h=Subject:To:Cc:From:Date;
	b=g6lRo7rEg+6HIHEbspbdgTzKyX2uOXxKudbaK/M24kziefTYs+ZySKUjNYnTl6EB2
	 /jBkk72DOVlkc6O7nkEJyIQ+pwVlKDRj9s1t2LgSU+2zfo7+iFEoaO1U5/bkjdN9Gc
	 RFPKz4R2umefmFN5bHFUiyG5i78VOgx1FI8MTYCA=
Subject: FAILED: patch "[PATCH] tracing: Fix NULL dereference when copying keys for a field" failed to apply to 6.18-stable tree
To: donggeunyoo.kernel@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 20:01:22 +0200
Message-ID: <2026102122-spinster-handler-2d56@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a0777b9e53157f1f6848a0fd0650f5465391ea81
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102122-spinster-handler-2d56@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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
 

