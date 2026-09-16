Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C2C50EBFA
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568446; cv=none; b=P87XB3TNa8OHXmB3/utkWwudD02m50clk0+/ExZe/SxLIeOgvYcuIWYRY/o9mhizBEkkSpM0KTsP8zPewQiNWTrzD2Msq/1ez+wob8UP9Ekl0nd7G3B+l7F86UZqbYLnzJtasKV2GMqGvdpp8ZppCbdzcwtMWTqKHjeBm7qwA3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568446; c=relaxed/simple;
	bh=w3uaH4YVbunYG3878FKtrbQ4UINsCT65gS+bdWXDHSM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HwWJstI6BQADP0Sayv0fsJAsONCK4fro0fStIV4xnYKhbub5vBTDQKVl1JxTEZUlv4uj3wPBeLbgXGH+ErPnq6aX4G2/KKKN7RJbFtnmOGpsmcYmTLk8G8iBycBpvFBL9qGoEicjkTdq9h+8DaiPHdWMyxBJ5kjeWLqvq8u/8qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gPA+7Vke; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gPA+7Vke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183CB1F000FF;
	Wed, 16 Sep 2026 14:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789568441;
	bh=vJb4+i+PLaXD6uoQSITmVsgGxR/Pn35uQ9cCTn70BbI=;
	h=Subject:To:Cc:From:Date;
	b=gPA+7VkeyRQHug6VNvAE+4jG2/MejAJhXpgkwnHYvUfk6jLeZQkx5QuRxu9qiTPW6
	 vdHasx4pHLv38/pS8Cp1Vk0aLXRcL+bBe5nHV56sUOVk46s7ASvQjSvc2mU6XqDYMF
	 leGkyhlKEWeBHf/CZTnYsRnkLSekEkXlrHYjszck=
Subject: FAILED: patch "[PATCH] tracing: Take the reference before publishing the named" failed to apply to 6.12-stable tree
To: donggeunyoo.kernel@gmail.com,rostedt@goodmis.org,sashiko-bot@kernel.org,zanussi@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 15:18:38 +0100
Message-ID: <2026091637-demise-concert-d461@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0fe23b8eaba0d3372c66b7b31204408da0715edc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091637-demise-concert-d461@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

