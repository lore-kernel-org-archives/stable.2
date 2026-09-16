Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF634A5ED8
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585413; cv=none; b=LlJcOS4FQ74uYdjuwLEQLGqg5dOB5z6TOwIp08pKoRAI3gk5Vq2maZA6/569nbrDEzXDkkG17q2fYIGsEbo05HlpMApPXgoNuYqOJbeFjrYGUvN5EftyIZdPOofHrgSU8hYsEFXpvw9crYpouSalvMvRW8129YgJ341jaKIPqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585413; c=relaxed/simple;
	bh=igjpdz/RZkTbAD8eI/yd0z1w3blr9zX+FI/1RItxoxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzQG5w3VKctgsNZhcV8K8PLzIjynm5KASQ25yuU3ZsaGodT8PXyzMZY4gJuIAoZO6AbnjHrggrvzO/bUp1l7qjH3NmHj42qPn7qrIgnGe1oIaFu2dfowJ/JFmrohsFE5ZsUwcpoJSIbrf0NkfoM9vdM3rVV6pm9UTiyZG85qWBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHULpgRV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHULpgRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643371F0089A;
	Wed, 16 Sep 2026 19:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789585399;
	bh=5Ir9wA7J/aeK+EZkKiDq7+s2W6CXG5GYSH/usRbqL64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FHULpgRVL7r0oVroKjohvkOQ3ja71JApPWqKdn0QRwuveAbbfNF+nlVUeEhLwg3Op
	 tQqWwZ3AUWkPMnOSZhzsGz/2cPIiakbzbslCLGtkrrLvW55p8vCu8nP3ngltL5rdKJ
	 0ciplDGSdPDOlDIpQove89zWkq5+tUGBjbDO7dGpVRHOwRbPsd/cRi0bjle5vAykSr
	 NmTAYjeSjOgQ7heZrARIjScGCIKqu9i28ZgupfScX6THgPthRWIT+o/JJMhk7lvdld
	 eOVuxqOZg05pHqSNGZUTixL9sJfbuFA35TP/FMhYsS04dZY0b6tqgzXdtYkX/Qqa9L
	 YElSO3BLu59hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Sashiko AI <sashiko-bot@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] tracing: Take the reference before publishing the named histogram trigger
Date: Wed, 16 Sep 2026 15:03:13 -0400
Message-ID: <20260916190313.1928103-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916190313.1928103-1-sashal@kernel.org>
References: <2026091637-demise-concert-d461@gregkh>
 <20260916190313.1928103-1-sashal@kernel.org>
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
index 7b0fc0bb62f0b..fde1aad3ee539 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6330,17 +6330,18 @@ static int event_hist_trigger_named_init(struct event_trigger_data *data)
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

