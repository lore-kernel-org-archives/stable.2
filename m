Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEE8471258
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792323006; cv=none; b=RFKVF28gRwYf23WPdjAb6c96gHFv20SMFXmDyL9nT+ZthOBzU8pBAWYSQXIwAHh4Xd3JMYt5O/K/K4WV0yJkLE2NdDdT2/M1ykUJpfosDOVGIhnkjfi8rp3WYcC3AUsT3WkJFOEgTCm1uH1LW876N1e9TbV28Ai57SNmVnW5kEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792323006; c=relaxed/simple;
	bh=z9mZ1nkUPH//WXspdQ7uPbIwDfgZdqWERRmaO6Hli4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4qmvmtvB02OoTFGYCEZqdseSqkWxm322rjDNrOr/Tp6elsXN82hxR4DIioxdXjnPQcX/uCMg25+Mhdkw5BSZpz7ffkif5zTMuyxPhOW0x1KZSTE8MuE77OG/ADDBwJGQ1EHklFam4Z+fTxtj+usXEc4m95PcRLT8A2to13jXeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjjZIECs; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjjZIECs"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-89e2d6c31f7so39787b3a.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 04:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792323004; x=1792927804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iv8yp98/kiK12Je0YsBkzTzUev6Y+uj8yzE4h7Pr6dI=;
        b=PjjZIECscdpymnIA8mlSUDvnOisC/CEzSRhDuh4PSFSuxAydCiDWzWNU7OUw/9vmuR
         3RvFPYbWyLVexONIdOUMPF99MjfqYDr0xw0YXW89kYtrthnVfzHvwtvbwp1w9RLJujd9
         oc384QEgZWLwZ9bxIpOhJpVFs8wPJSveGfrlWUY0UeUk08gZiMXW/tZN80+s7IZQxnD8
         vyXm0Mno8/D1jRAIlHrdY7r2EuKxbViXYRBINYETj1mMHL+03jGg5OCn501IV61HonFq
         X4s5g8Z2NdtLlE0wFGvVfzWqX9B9Sl/WRNLTT0gwu7VMEpO/jsj7/y+KCEE8ctr7rZGk
         +31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792323004; x=1792927804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iv8yp98/kiK12Je0YsBkzTzUev6Y+uj8yzE4h7Pr6dI=;
        b=otmU5+m7qucEFX/6hsMm4M8CPTnAPDtfguKCR9Rp7K4KyFpTr5KkZ/97aK1r1lfYpv
         FgIWNq0qIGR16rlcsuu7dBZIYCBDFBTVyezV9+IWeah1xdaDg+R6uJI0/XbpjNoFaM1M
         BYekmu2O1bs5NxC06ALdmndUywv/uQLsUD67gfq5MR08cUO6l7w0xYKbXlpeYR8E05ug
         Elg8tyn3K/F1qvxk+/FPdg/bO5bOMpPC7zao+YsZWMUx5z01FQLStuvnAWdMwk5hNnCg
         XjKxcrr9NXAtN/6J69T6sQLPOpM2tNi1ySzoq0R7keffN40CSIz7rbCBPt7zbrAD6AoQ
         7Ynw==
X-Forwarded-Encrypted: i=1; AKwUvBxxVQvMfn6zHQDyWIt/n7n06BywZLvYT5tSfZq70p5rLxY4ZjcZnDbsEBxrn6f1NSGMVKXeCg0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVjXPWsku6C+OB0EW0jqIDUJC92OULWErBvMLbT3/lLUd75vR+
	NAwQu6KO7/bkC/LhINlfGvYQ0Y0ia+C5qLS95pVNGJb8GWSiqbRaSGcR
X-Gm-Gg: AYBFou22e7WYLURO/++YdKv5W0ylmP8PSW1eO0wHcK69N60bMp1+l9R0X5LBM1jZ1+g
	AUbXZNR0B2/ZeX0D9EMnS1M8R4aWVJAD0wmKmGYYrb4GJBpbXoh8YK5nhj5CRA9Bc276GqVmf0c
	ihndruPpqS1VdSw0T6ECDO5aVQ8FEmqP/6KrTJDKen0ezvxF3kThgjRigUfIwVs8y8jXoQLr3Xf
	7Yz9tBje49QQubOz7zTHriSq2WnQy/Cv9JBiq1xHzM1tZ7mX2r1jvRkbEs6qGvD5kiBOCevulR5
	CcFTkZE7GRsF3TnMnMth7OkQjXUMAptnj0eKy9tBzjiHXzLQpBzays5HSu9peWnDHWsWgHi60Tw
	t+bcyRsRf0DkczmNAiNynrKeG+ss5H72jJCggWXnKM4ymAKtvaXFQXkhRpLNenVlGywsbwvtutM
	d+4vZW7gvbxy4Xz9oVVm1x+nNCMm5fG6NXizc7RUfraR120dPJGEI8Dm9ImfAAgVl60g4dvogz+
	3ROiLUReDQ7PObIbwrnhK1/0/ZRzbnVLYKfXrzNylZu7eCQ3UAWUGw93Qh1ySOeKNs=
X-Received: by 2002:a17:90b:48cf:b0:3ac:e6a:1af5 with SMTP id 98e67ed59e1d1-3acee6f12famr6963832a91.2.1792323004381;
        Sun, 18 Oct 2026 04:30:04 -0700 (PDT)
Received: from localhost.localdomain ([113.102.237.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd9c4b4eesm9195365a91.2.2026.10.18.04.30.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 04:30:04 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pablo@netfilter.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net/sched: cls_api: unlink indr cb on a failed bind
Date: Sun, 18 Oct 2026 19:29:55 +0800
Message-ID: <20261018112955.61470-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a device is bound to a shared block through the indirect flow-block
path, flow_indr_block_cb_alloc() links the driver callback on
flow_block_indr_list.  If tcf_block_bind() then fails, its error path
removes the callback from driver_list and frees it, but leaves it linked
on flow_block_indr_list, so the next flow_indr_dev_unregister() of that
driver walks the freed callback.

Remove the callback from flow_block_indr_list before freeing it.  That
list is protected by flow_indr_block_lock, so do the unlink under the
lock through a new flow_indr_block_cb_unlink() helper.

commit da94a7781fc3 ("net/sched: cls_api: remove block_cb from driver_list
before freeing") fixed this same error path for driver_list; indr.list is
the link that change still misses.

flow_block_cb_alloc() initialises indr.list, so the helper is a no-op for
the direct (non-indirect) callbacks that are never on the list.

Fixes: 1fac52da5942c ("net: flow_offload: consolidate indirect flow_block infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
v2:
 - unlink the callback under flow_indr_block_lock with a new
   flow_indr_block_cb_unlink() helper; v1 called list_del_init() without
   holding the lock, which races a concurrent flow_indr_dev_unregister()
   walking flow_block_indr_list.
 - initialise indr.list in flow_block_cb_alloc() so the helper is a no-op
   for direct (non-indirect) callbacks.

v1: https://lore.kernel.org/netdev/20261013162949.25622-1-q.h.hack.winter@gmail.com/

 include/net/flow_offload.h | 1 +
 net/core/flow_offload.c    | 9 +++++++++
 net/sched/cls_api.c        | 1 +
 3 files changed, 11 insertions(+)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 70a02ee14308..b8ca8cc0a241 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -640,6 +640,7 @@ struct flow_block_cb *flow_indr_block_cb_alloc(flow_setup_cb_t *cb,
 					       void *indr_cb_priv,
 					       void (*cleanup)(struct flow_block_cb *block_cb));
 void flow_block_cb_free(struct flow_block_cb *block_cb);
+void flow_indr_block_cb_unlink(struct flow_block_cb *block_cb);
 
 struct flow_block_cb *flow_block_cb_lookup(struct flow_block *block,
 					   flow_setup_cb_t *cb, void *cb_ident);
diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
index 5071d7fe6ce2..62bc2eb6e0da 100644
--- a/net/core/flow_offload.c
+++ b/net/core/flow_offload.c
@@ -266,6 +266,8 @@ struct flow_block_cb *flow_block_cb_alloc(flow_setup_cb_t *cb,
 	if (!block_cb)
 		return ERR_PTR(-ENOMEM);
 
+	INIT_LIST_HEAD(&block_cb->indr.list);
+
 	block_cb->cb = cb;
 	block_cb->cb_ident = cb_ident;
 	block_cb->cb_priv = cb_priv;
@@ -525,6 +527,13 @@ static void flow_block_indr_init(struct flow_block_cb *flow_block,
 	flow_block->indr.cleanup = cleanup;
 }
 
+void flow_indr_block_cb_unlink(struct flow_block_cb *block_cb)
+{
+	mutex_lock(&flow_indr_block_lock);
+	list_del_init(&block_cb->indr.list);
+	mutex_unlock(&flow_indr_block_lock);
+}
+
 struct flow_block_cb *flow_indr_block_cb_alloc(flow_setup_cb_t *cb,
 					       void *cb_ident, void *cb_priv,
 					       void (*release)(void *cb_priv),
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a9f54988561f..9e4ea3715419 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1665,6 +1665,7 @@ static int tcf_block_bind(struct tcf_block *block,
 err_unroll:
 	list_for_each_entry_safe(block_cb, next, &bo->cb_list, list) {
 		list_del(&block_cb->driver_list);
+		flow_indr_block_cb_unlink(block_cb);
 		if (i-- > 0) {
 			list_del(&block_cb->list);
 			tcf_block_playback_offloads(block, block_cb->cb,
-- 
2.54.0 (Apple Git-157)

