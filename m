Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605784;
	b=mRVweWAkES3XoM8ZIKHvu3CJ+PfKcaXuQJqXJCS6V8JwWwpTPsDPKK+r24QGWT0BhqMm
	 sZnj9t5N8ndUyAX3SPDutlTj5Au/0d81L2H/yKX3/0dJfaqy6IjS6dQYm5iyG9sKKyiRh
	 Dqpx6Oo1WtCeb6NNm6UNoQ2xnJ6Ps6BGRJ5h3AjXHTgysOj2L3goj+AXduPeYPw/8rsiL
	 wAfELjSKBqOU/adL8ujquMJiqZC5yO7SHIT6MdhZfYg55G8qZMnfn0bU3aiwjbxRe7ksO
	 Ui/zNSBNDMNKBuctyBnuLIbeS8YJOKWoNIBegwsu/t0h9Egh26uqlZGY7b3by7KjHnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605784;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iWvBflPdSPU9BiIGUwEbz+htse67r/vqC/LyaDB57is=;
	b=Avya2zCz4hYLzSpFDDOF6HFzU0WmJ1UENeR8Ajo+2sK2/Ed+mN6TXlUbqvdKhkJ3AH33
	 9w/yD/i+kxTF6VE2VAzRJYBuCaLJmsIpGEVkfwL3sR7hBWsfARcK/TvDa3rI3fqACYnCW
	 La+GSuOvt+8/rBov8Q6+8vPijFy2Ew531mv8Hyr/7U7WIRMmNFPm0xPELUVz2jrAjdW53
	 YkrHJkN6VJe1O60oexTM4ou8llPoqWrbqwcQVMR38ucJZf1fTODN/q3gS3nNhN9v1fRSW
	 FuxNrG04XC2UEUj4Xc08DdTFCqBmpU9h2eaa2D0neqlw5LVIw6M10kfaOWGCN5+8Fjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=scB3XPRz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82530606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=scB3XPRz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EE51F000C1;
	Wed, 21 Oct 2026 18:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792605784;
	bh=iWvBflPdSPU9BiIGUwEbz+htse67r/vqC/LyaDB57is=;
	h=Subject:To:Cc:From:Date;
	b=scB3XPRzecTxXjNPByIml/MKe+hl3pO2byNvjVZhR9Zv5nXhaw0sMKCqi3k5IudCY
	 EfM3zvYMnyYCm8PbEveJWrXsq7uqLi2V1DC0u+UaKj0ANhkRvQmkdNh95VKhQZj6ef
	 6eUZDN4+081s3gFQL/9sGv3stAxO6qQ63z2O+e+g=
Subject: FAILED: patch "[PATCH] tracing: Fix NULL dereference when copying keys for a field" failed to apply to 6.1-stable tree
To: donggeunyoo.kernel@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 20:01:23 +0200
Message-ID: <2026102123-faceplate-shallow-02a0@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a0777b9e53157f1f6848a0fd0650f5465391ea81
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102123-faceplate-shallow-02a0@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

