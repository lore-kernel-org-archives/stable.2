Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0D357C9F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785295222; cv=none; b=q+gqiLCygx/fGpdVqtPMecbikvKjxdOdbEYqqzDVLUhXxjjhUiShfCwF8HFCENB3morrfdCwwX1VeAq3AOLUpuVGvTyFuyb82ePlc9ihXf8LtqVzzBQsKKgy7XJUkoNX8nOBoBAF6xsO/ivRCPf6LyGsvG9lvqzntP6l/lLLdg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785295222; c=relaxed/simple;
	bh=+r6O13nnSwg13UF9WCWd5Z1iGPftdZD+f8RH9/oshNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hajYG/8lFvl/UZSR2R1TtCekE2q9i/hQ52R3XdWWHo9bJlEidV15+LfZk9lgkNpJOgGuv0Mvh8I6u6A80u9+E/Rgv/RQBXPlyc2HQtX3IAy6MQHFJEcBENwmWmvRkBPtw8GfZ7JESFxImOes2fQ+zEFVx1jB/ejI6DxSrTIHiNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zh2AWrXw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zh2AWrXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE8F1F000E9;
	Wed, 29 Jul 2026 03:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785295220;
	bh=2qFRWo5QKOPNMn3SMmU97B1y7nc/5jadbvbOChRqVC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zh2AWrXwxvAufCV5XzXuD3GzlWJpyOOaQ75LqqXQuYR8NPWnYHelRnV0rWERec9Tk
	 yNHZfW5tysZlBZxl2U01z7A4OxeLYayc2IOZYKMQjXxBWm2T3RYxHrMHRGjePsB+FH
	 Y6mo97foiBX5e0UHkQJAm1MDFYuplsqHhwuI9M7NEgOShFJVZoq7uJTElDS6iAiR5w
	 15Y7x/j69b32lCiZMoHO8jX/1hHl9MQHlE2NVUPJlcMAlTLtFxODkuj4D8KvR3YmkZ
	 tc/gznwE/f7SfsYzJMAsoHxY7mNzqZPMQftxC4v+pwxRK/LHvOaNIO3OP5Q9f44jDQ
	 rrcl1PNTG3Wwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] tracing: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
Date: Tue, 28 Jul 2026 23:20:17 -0400
Message-ID: <20260729032018.1223942-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072147-clang-iguana-51e4@gregkh>
References: <2026072147-clang-iguana-51e4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

[ Upstream commit cae16f2c2e11c60c888715f4d98c12740683d6a2 ]

The kvfree_rcu() macro's single-argument form is deprecated.  Therefore
switch to the new kvfree_rcu_mightsleep() variant. The goal is to
avoid accidental use of the single-argument forms, which can introduce
functionality bugs in atomic contexts and latency bugs in non-atomic
contexts.

Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Stable-dep-of: fe58f457ad8d ("tracing/osnoise: Call synchronize_rcu() when unregistering")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_osnoise.c | 2 +-
 kernel/trace/trace_probe.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 676d9a3e65cde6..417b62f7550978 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -137,7 +137,7 @@ static void osnoise_unregister_instance(struct trace_array *tr)
 	if (!found)
 		return;
 
-	kvfree_rcu(inst);
+	kvfree_rcu_mightsleep(inst);
 }
 
 /*
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 125111d310d1ba..241b7ba9a3a777 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1179,7 +1179,7 @@ int trace_probe_remove_file(struct trace_probe *tp,
 		return -ENOENT;
 
 	list_del_rcu(&link->list);
-	kvfree_rcu(link);
+	kvfree_rcu_mightsleep(link);
 
 	if (list_empty(&tp->event->files))
 		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
-- 
2.53.0

