Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852148FF99
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587918; cv=none; b=qojfBg0IIPj1YN7OsSgctHovr6mTvXpTZHdmkatVO4fTtOZPsJdirzM5aDA+DRIGlYBXyLi1smIIV9FWOrfPX7nS4zXXgxJcYxUErqS87Uwz069Mq39TmoTk+yHpFbS3hrkDREFAuzzpb016siCHzaknaCFY7Z2vh7BrV3p9eW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587918; c=relaxed/simple;
	bh=gPkTx7bFSWV0/05FhKRT9igdQGtj3aGfU0KhIuYkx6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1oie8Sv3gc2xCl+FkJFiWzcEzdG+H/iOqbT6brLYZOsjDYU+7BjRM//A2Js6HsPPwwgZD6enHf/cJSTD9U1a1Y73WjoK9Zu4/nJ+t+yqJ3cudGMFarmRA7F+EaSc/hV/XYZDSESJINcjquw9GZwuYrDD6mWU2knt06U2rZR91s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEf2NhaP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEf2NhaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F04F1F00898;
	Wed, 16 Sep 2026 19:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789587900;
	bh=T3gur1VSwftwgZcivGZpRiTvlRjTJ+ZQTETUAKJrLmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cEf2NhaPDvPETjxLxAAtno9bHd63t3AtvceK6YXSkJsjg4TCqhid/Oom9udkKLBn5
	 Eewu4fdykzkiCjNMgaOhN9xZQXnL5OKvh49AEvAbw6hEsdd70oQZ1TkfS/+FOtU2bU
	 8d9IggJk91bw0yCqufnmlJVUh8cwmw4QDpyDAl0HIbVvlKXNFjMG1Yns6TGLFAeTVh
	 vAajKERqCE82RpIZqOEriueOlwAFJ3TH8HSoEeIMZKqH4RchpxWrUAN+2lo6sOK04e
	 Njsd9phLRVjUEeiPsMtKp0ovpAU+HbcHRxSUvD3sevjZKtQxPjhHXHInwIDLt/inkH
	 CPk4nNp+8ApDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Sashiko AI <sashiko-bot@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] tracing: Take the reference before publishing the named histogram trigger
Date: Wed, 16 Sep 2026 15:44:56 -0400
Message-ID: <20260916194456.2410788-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916194456.2410788-1-sashal@kernel.org>
References: <2026091639-aim-spindle-49e1@gregkh>
 <20260916194456.2410788-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

[ Upstream commit 0fe23b8eaba0d3372c66b7b31204408da0715edc ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 516a610dce8da..e790cf6fab6af 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6343,17 +6343,18 @@ static int event_hist_trigger_named_init(struct event_trigger_data *data)
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

