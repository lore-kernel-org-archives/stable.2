Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5826947ECE4
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526000; cv=pass; b=Zyd0XRIHjbfqYRjaob/RounQsMrGe8zl2ELMCv+/kXPodT4DNBfUj5jaohQSwDBhZjWpX/Ag1uEC3pTTHB3Y88s8t1x26MhE6+shESCn9dBOWsyFBfSKTZ7TM8Wi17wRSBTw5D27PVFXR+gJfAJFnWN2tS5xzGoFUc3pux4dzTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526000; c=relaxed/simple;
	bh=73pWa1BlX5RpNJhwInFUJ18btopb328zkDMMQ6IUiC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gs03LfAmae32c8bjsIfFFPYh4KirVGSL+KpCv+qdA4pNK6fiDWeiNXvNKx9LgYf7aI9jLCXNg2JOSrFkTpaoYn44Z8XZq6z+rJH0QnmJ/5v9Pn4zYgplIOce1Y26DR/tCVt1OU8XumhOA2v+coC+jzcpGQgKw0WmeXcvG3c3u7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=nuXDQ15W; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="nuXDQ15W"
ARC-Seal: i=1; a=rsa-sha256; t=1785525958; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=in8HxxLgJjCXoDRIa4cCLwjY1UoxO1RFGyw+SFVstFDAqUD642wRFCLHMNHK6B69VvnU6q5WbKrploVngXapJA24EPqAQ201KlYbqdPlsCuIdMeyg4L0//C7l9KSuft4UbBaLRjtfTyLw6Oqk0DNez0p7QSZcb2Dos9kG9Pdt+k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785525958; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+1MEG93QTr2RoYK3YV/UK/c3NShlE3HAOJF+xBCkrUk=; 
	b=DJwdmEzkCvZv+dMDKq7h48bQp5Eo3nMvJuSg1evbWWF1osC67kNf+xzGyGAWNUZ/EtsBvPFxo82jcElgwoRcS1oBeZNixTeCinuqVJGDZKwTMYbuAajFT1JPr4vad/hRsXMVRUL8kEEd3kb1hrFFKkB9MwsxLfo3N3LWDWQC23U=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785525958;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+1MEG93QTr2RoYK3YV/UK/c3NShlE3HAOJF+xBCkrUk=;
	b=nuXDQ15WpC6YtNp7GRwpQCEpdrtwpwWBUP3SEcwReUrJ2FbuSVzd5/vHfrTnsLei
	vRO3haKDllhoxhTBzv3RG1UklBRlz3EBdF3Liu+8/k+a7BZBGGXGjUSZrc1XZI1ueD+
	j2OyqicmRjqhOE3JcGHK+QrYIGTNzfa63CYvcT/w=
Received: by mx.zoho.eu with SMTPS id 1785525956388972.9501036438804;
	Fri, 31 Jul 2026 21:25:56 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: hsr: wait for pending node-free RCU callbacks on module exit
Date: Fri, 31 Jul 2026 22:25:43 +0300
Message-ID: <20260731192545.176969-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

HSR/PRP node teardown and the prune paths queue node frees with
call_rcu(&node->rcu_head, hsr_free_node_rcu). hsr_free_node_rcu() lives
in the hsr module text.

hsr_exit() tears down netlink, debugfs and the netdev notifier, but it
never calls rcu_barrier(). If a node-free callback is still pending when
the module is unloaded, RCU can invoke hsr_free_node_rcu() after the
module text has been freed, branching into freed memory.

Per Documentation/RCU/checklist.rst, a module that registers callbacks
with call_rcu() must call rcu_barrier() in its exit path before it is
unloaded; synchronize_rcu() is not sufficient because it only waits for
a grace period, not for the queued callbacks to actually run.

Add rcu_barrier() at the end of hsr_exit(), after netlink/link teardown
has stopped any new callbacks from being queued.

Fixes: 415e6367512b ("hsr: Implement more robust duplicate discard for PRP")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 net/hsr/hsr_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index 33951d9bd..05d2e5750 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -179,6 +179,13 @@ static void __exit hsr_exit(void)
 	hsr_netlink_exit();
 	hsr_debugfs_remove_root();
 	unregister_netdevice_notifier(&hsr_nb);
+
+	/* Node teardown queues frees via call_rcu(hsr_free_node_rcu), whose
+	 * callback lives in this module. Wait for any still-pending callback
+	 * before the module text is freed. synchronize_rcu() is not enough:
+	 * it waits for a grace period, not for the callbacks to run.
+	 */
+	rcu_barrier();
 }
 
 module_init(hsr_init);
-- 
2.54.0

