Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE74D9561
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583815; cv=none; b=H5/tlGTY0KIDG/xbqeb5SHOJ3uj07cJXLJvEo1gbREgXWgyaGTYA7H+RgoLM/pIARyp6SI/WyQ89iTbcEnUUAnGFXMd7WGNNoUqoyaqQ7Huss9xi3rPnyWguV16hyLFNyeQg86YthIzk6/i77tLJAWQvtqF2L0Cy4QagwmG6i+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583815; c=relaxed/simple;
	bh=J5Gakx/H01AKLbDSbO242ohYQXGwSKa4qEUZXN/bmnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWy5dGTRtDzQyRkvZulIThFdjSkNFYEA7q+xEr0va5R+hklP6aLHc7KRl84GNaar3fPILiOeB8BtPdpz8ghtZyxi6dG87QIdRZ7JVHkJ4n2wSRG2bcHGaLpG0j+HVXYYgSylPsXkVlBGb1xE/tvDqO50YuRQ+61Bnsn5aMeVbEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPVNStwx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPVNStwx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BADD1F00899;
	Wed, 16 Sep 2026 18:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583798;
	bh=Szj6qC5EaDV7EiP/qUOle609+tQq9lNUmZpfGmT6KW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BPVNStwxJwABT5eP0BMNr02+9tZL9z2vpsh7Ev1rnNooNqkj9/VUbz4g9eqszhCE1
	 Kg1Gn/N6BKVHJvWixq6bn0Zcpm9LmQYThtKumeiikDZzDDKjFP7oAs5JzY8ngeZFdM
	 hGj9T4eyEN9rzttyOlybO6ITHpLfXE4RlKSKlz8Ak61ljK+z/Fee4LmMR0eoR1ReEk
	 QntCzdUftiHgURHBplrIaANxO06i/OCpyBDuVaPmu3AtOF0Wlse6bo1wz2jND6Ze3H
	 2HHSlKOve/XmOJ7YhQ69CY6goC/8RR1s9viiosp26JhV/je3n78KRAyeIgxg+Gprrz
	 6H5+OjSTNY0jw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Sashiko AI <sashiko-bot@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] tracing: Take the reference before publishing the named histogram trigger
Date: Wed, 16 Sep 2026 14:36:33 -0400
Message-ID: <20260916183633.1770561-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916183633.1770561-1-sashal@kernel.org>
References: <2026091636-unreal-encrust-edca@gregkh>
 <20260916183633.1770561-1-sashal@kernel.org>
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
index aa7736dcbb545..9174a15fee184 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6358,17 +6358,18 @@ static int event_hist_trigger_named_init(struct event_trigger_data *data)
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

