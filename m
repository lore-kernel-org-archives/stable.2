Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A850EBFF
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568433; cv=none; b=pKh8mGUJWrThfoYmYZ1a1oqZqtVjiY9erLV7KyEgA+QkrZGBZZS4p3g8q2TD+6CejpsUZRC7CKvsNeUuIEd12klDr9lrm+1kDlZLwzvmrS2BA9+1wQ8Heb3xDLPQjkBX2/JkKlOvQxit9UvMhk95ZVp9DZWJpiVlwMyUa3RXXZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568433; c=relaxed/simple;
	bh=jjyQ3v49hGiN5uCCCME99GYsQRrEuK/vECd/melnFeU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pj2NHtQbGfCHtMJ6rZDO0JzScU4KnBnmPTXQowQq1dnRGKWh1hPxwV2yRBSfpx+hLJNE03fqnzVCPmcU4mSgB4wSzWHfE7PKf6Z2Z8RUTlAagiRz0clGGQMVX5aOmDbu3JsMfxdp7BhmpmyopAstsrfjcg0naLfCM7plv9x/oSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oOp4sXCS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oOp4sXCS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB9C1F000FF;
	Wed, 16 Sep 2026 14:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789568431;
	bh=JSIgjoVkWUbvptuBrdnngI4D6EZ3O5zGSalz57LkOdM=;
	h=Subject:To:Cc:From:Date;
	b=oOp4sXCSblqfx6nPfWMQ7CiGKIA0mX/85dz/HPqgZi6eCtB241+OqzO5y5RYzamaY
	 nPFIKAK5p864XflEfra/JhX5Be4QuQi542OZS1VTx1vGAx7Y34s26s1jVhdVGhOYtC
	 jJciFDnOb6086ZqPgOlB+zhbQpsUtWd+UQser1rY=
Subject: FAILED: patch "[PATCH] tracing: Take the reference before publishing the named" failed to apply to 6.18-stable tree
To: donggeunyoo.kernel@gmail.com,rostedt@goodmis.org,sashiko-bot@kernel.org,zanussi@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 15:18:36 +0100
Message-ID: <2026091636-unreal-encrust-edca@gregkh>
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
git cherry-pick -x 0fe23b8eaba0d3372c66b7b31204408da0715edc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091636-unreal-encrust-edca@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0fe23b8eaba0d3372c66b7b31204408da0715edc Mon Sep 17 00:00:00 2001
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Date: Mon, 7 Sep 2026 21:44:19 +0900
Subject: [PATCH] tracing: Take the reference before publishing the named
 histogram trigger

event_hist_trigger_named_init() puts the trigger on the global
named_triggers list and only then takes the reference on the trigger it
shares its histogram with:

	data->ref++;

	save_named_trigger(data->named_data->name, data);

	ret = event_hist_trigger_init(data->named_data);
	if (ret < 0) {
		kfree(data->cmd_ops);
		data->cmd_ops = &trigger_hist_cmd;
	}

	return ret;

event_hist_trigger_init() fails when alloc_hist_pad() cannot allocate, and
nothing takes the trigger back off the list on the way out.
event_hist_trigger_parse() frees it, and the next lookup by name reads the
freed object:

 BUG: KASAN: slab-use-after-free in find_named_trigger+0xac/0xc0
 Read of size 8 at addr ffff888009346860 by task init/1
  find_named_trigger+0xac/0xc0
  hist_register_trigger+0xc1/0xa00
  event_hist_trigger_parse+0x3146/0x6af0
  event_trigger_write+0xce/0x160
 Freed by task 67:
  kfree+0x154/0x420
  trigger_kthread_fn+0xfd/0x160

Do the reference first and publish once it has succeeded, so that nothing
which can fail runs after the trigger becomes findable.

Cc: stable@vger.kernel.org
Fixes: 7ab0fc61ce73 ("tracing: Move histogram trigger variables from stack to per CPU structure")
Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-trace-kernel/20260907092944.3950E1F00A3D@smtp.kernel.org/
Link: https://patch.msgid.link/20260907124420.607097-2-donggeunyoo.kernel@gmail.com
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Acked-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1889e310b73c..54c95f9bd0a3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6371,17 +6371,18 @@ static int event_hist_trigger_named_init(struct event_trigger_data *data)
 {
 	int ret;
 
-	data->ref++;
-
-	save_named_trigger(data->named_data->name, data);
-
 	ret = event_hist_trigger_init(data->named_data);
 	if (ret < 0) {
 		kfree(data->cmd_ops);
 		data->cmd_ops = &trigger_hist_cmd;
+		return ret;
 	}
 
-	return ret;
+	data->ref++;
+
+	save_named_trigger(data->named_data->name, data);
+
+	return 0;
 }
 
 static void event_hist_trigger_named_free(struct event_trigger_data *data)

