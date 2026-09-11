Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747504B1473;
	Fri, 11 Sep 2026 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150586; cv=none; b=gYRijB58Dzc5n+yE5dpd2I7ePrvOoWT5wUZo2xavBrSUH/jrceU+EIcjntr68jzhZpxrsJFkWM+b2xlLaaMuY5PC5PsQ+3D2gjctDpQ/kqrRwDV1rR4dCSP9bEA86+KrbTu3fz3imF3i49vtHzec/J0ZkR66D77XkAKF0jZfHrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150586; c=relaxed/simple;
	bh=h8jc8CfPjqwE/cE4ogLFRAF/HxsukaCJ//a5gqGd0yA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OCzGklnJomK1LarrdeHPtazz/Cd0OEaZbRJcmv/is3X6I7aX/+9rWKb+un2OD2G8beiTNIvdlYp/72Q9waGALy4Vryk6HN1Ej3t/YeiE75zMhVENNxRjA8ewW83UTmd0UXWrGhpQV/wBh9vtZ+uU/UftljPg4W0rS5mDwhXqYig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2UPb9g3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2UPb9g3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530151F008A4;
	Fri, 11 Sep 2026 18:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150569;
	bh=QTuelLlM14RAKfKiCxcUFQNPREEn8bUD3IeV7jrQiac=;
	h=Date:From:To:Cc:Subject:References;
	b=j2UPb9g3mFQToQL8uml34DwAw2Rx9fdESnoVao/Be4jpVFu7YnnxylQV0aWkzFb1/
	 QCtc6KaawqZAoCP6CqwziqUEHlCq5MmfrSMh2utue1lOrxiXiGVffH6LHlDepPkEMP
	 2GyonIoNFgbKIa6mOGbsckMT9C1KWmuoDT+wkMyHu0VdP5vrGZXcKCC25DqaXpwHss
	 zymUQjZcn1W8g5go+2PjFzNvhkbWn3JhJ03ywnm0GRl53OCwkOXsa3zyOVTMCP78rS
	 7UL6VhjmefURempxBXrPZRXj3zvrdt6QftELGc/qbYOzkgXnnX7l+z6PdACNzGmDox
	 Ir6bzBvhBtK+w==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x55oZ-0000000951k-03aK;
	Fri, 11 Sep 2026 14:17:31 -0400
Message-ID: <20260911181730.835279329@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 11 Sep 2026 14:16:49 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Sashiko AI <sashiko-bot@kernel.org>,
 Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [for-linus][PATCH 13/20] tracing: Take the reference before publishing the named histogram
 trigger
References: <20260911181636.485043797@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

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
---
 kernel/trace/trace_events_hist.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

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
-- 
2.53.0
