Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C874F4F7CA5
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909011; cv=none; b=fIarfXgCgTcSSSFocakKrnrpe6vSPobKZKbBpBcQf0ZtpWAXLpZSaoH/UMnaKXjG6RwxQJiy3BoGRTKADrxUhkhlM68V+Tn+4PRkpv6CRX+t1UdOz6nExYPYk9LpRTpaO1syyorVfBvlEjlCrpEqYbnO+49kIK0OLIRmMJWb2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909011; c=relaxed/simple;
	bh=+HGJ91G3vE8I+hjbAj7JZo7VbwjxkPRsRJSUwJ2/ZT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=liqJCgJfRb4qMqKjaQZFef0DqdmFhaV8ygvyLCR9QwnJ2va1ID2vNde3LoWzDcKvGStal7y8nMXwvBVuclKn2wfYh+KWgzZ+kG7Fs4yCq4XlchRHz/54e51aXTOIWaiqCwQiUmMdKTjQPrj5461vfMcpUYO/a3wBKA/ZFlxjprM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPqEYhYM; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPqEYhYM"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd15c885bdaso196388a12.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791909009; x=1792513809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T42dDgF1G2T5CFLnp1NKvSC8C3hiWB9MunCO19ie1Ug=;
        b=FPqEYhYM14VrOChheN/JPEgFgIlnbyAWoiz+Dgdn9Zqf3oEM/6jRQhDKk5iP6YXxAA
         ypGOxF6nL+ZX9xXEkrrolvMO7NFdDUcU8zgBXJh+cuJIVkeODW3mzODXax3c+1HVNyfM
         Atz8b6d+AvV6cnGlVBTVdRFily8TLgkeRcqowt6hsIZ7u3MGL7+BCBWldsB/kg/9RYZs
         /5XWBVuh4CpbVhyM1381mDhbau8GjUux2bdXoY+cv1QPhUnZjF+9OiC3y/z4vZ1a4Ej1
         7VKEcTfKTj+YSXjnDqjhaIkeJlPQV/fIZRWMLfyjYENf1RAV3xxEec4BUY71LzvGvEJy
         GO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791909009; x=1792513809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T42dDgF1G2T5CFLnp1NKvSC8C3hiWB9MunCO19ie1Ug=;
        b=x1rTP71p2Vw2adWtzCa2nQ+QXn47hw/GLm4dhrBKIMcwVRoiHGuWkJd6WqNbhT1vBG
         EKlv0XTdlFaa8uR9p/8mxCThLeMDE4UEClfgCXfqv+KxoNZE9DV+Lq9FkhdYOQFK0eUV
         q/sCNV/Hwkor6DnAr7GcxXpziUlGRnhUMpKinlMCXnbYr3i/tdE5NJ+gbGgAaOL+pgie
         iY0LAZKJltjcJotkU8j25Jl/FdHSBSB9gsYuPv+SBv9pcU+L3vChbQnVWRkajor5FKXF
         pAfN5fwL1xLSZROAAJEdeYwRdtBMi6Qz7SQrtoteREBTPNSQkhFdxp5tYV8nR7IqQ55T
         hvxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAlPaS92+Cla/TaaTixxhAcqYX6aYfVTKD4qWf7yezHd6gaVn2W+sKC5WF5mfqWErLNYf69Io=@vger.kernel.org
X-Gm-Message-State: AFq9FYID5YMnQP4BkbzOtLDn7KFwC+P/4WRN/mg9jSAU+xZk7BEhnEij
	ceds8YI9TC8EEHpWFnR/6/TVnM8rWx9HJ3XTMC/qFbPlKxHGRWZ2/I7i
X-Gm-Gg: AYBFou1dVXzQWF6Iy4+Ks71UOvIHHx4T3lvjYHqyIicyT/lDB+afPVPB7eS+2QpEK/I
	UvIDikqybsPG5Aq4KRJe4zu+wL1NOGlO3onnrD13NZExn6ztTaDzVu4Zr8tklHiXmpg8+ZJU9e5
	wYPf95jTYV4x2/1nqxoZoNVA9tkMf6kn+oaE26J5Ozwe/+heyX0YQKrVPkmD9infM2b/wWEjBPu
	tNS/zEnooYgC8fbJoOsySxGbl+RqereWX9wfNNhtNPtJJy09mh7p8AYyEwN/Mey0s5NqmfEH5S0
	y5LuB+lt/bIi7tQcAKM0RmCgu7yKJPmrzE3SHJlyUWGKoXjRGdzfXMppVurY+VT+6mfJz92DY0w
	psUlHz3y0Fr7cugfV+3XkAX/Rv88RTIi33D6R23pwwxYFDBwCYfF7fLw+tSy6VMYn0tcOOCneXC
	RT4ITPsjWymfoLM5zIP1jfIqdjjkDUi0EEvtN4HgCt3KHLwSP6pSn34M1r9QCm/fzfJ9ImrIXXU
	S3agk3qpLlHlvmCHk1bKHWagX4sSipuwk0fFQUjjt/F5zfT0d68CnCv6zUJyc7xX/U5
X-Received: by 2002:a17:90a:d49:b0:3ab:be66:ddc5 with SMTP id 98e67ed59e1d1-3abbe66df3bmr7123391a91.6.1791909008669;
        Tue, 13 Oct 2026 09:30:08 -0700 (PDT)
Received: from localhost.localdomain ([119.127.198.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e26ddfsm5672992a12.17.2026.10.13.09.29.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 09:30:07 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pablo@netfilter.org,
	stable@vger.kernel.org,
	Qihang <q.h.hack.winter@gmail.com>
Subject: [PATCH net] net/sched: cls_api: unlink indr cb on a failed bind
Date: Wed, 14 Oct 2026 00:29:49 +0800
Message-ID: <20261013162949.25622-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binding a device without ndo_setup_tc() to a shared block goes through the
indirect path, and when that bind fails tcf_block_bind()'s error path
frees the driver callback while it is still linked on the global
flow_block_indr_list.  The next flow_indr_dev_unregister() of that driver
walks the freed node:

  tcf_block_get_ext()
    -> tcf_block_offload_cmd()
       -> flow_indr_dev_setup_offload()  [ allocates block_cb and links it
                                            on flow_block_indr_list ]
       -> tcf_block_setup() -> tcf_block_bind()
          -> err_unroll: list_del(&block_cb->driver_list);
                         flow_block_cb_free(block_cb);   [ kfree() ]
    -> err_block_offload_bind            [ no tcf_block_offload_unbind() ]

The only unlink is flow_indr_block_cb_remove(), which a driver calls while
handling FLOW_BLOCK_UNBIND, and a failed bind never delivers that command,
so nothing removes the node before the callback is freed.

commit da94a7781fc3 ("net/sched: cls_api: remove block_cb from driver_list
before freeing") fixed this loop for driver_list; indr.list is the link
that change still misses.

Fix by unlinking the callback before it is freed, and by initialising
indr.list in flow_block_cb_alloc(), so an unlinked callback carries an
empty list instead of an all-NULL one.  That is what makes the
list_empty() test exact for the direct and the indirect path alike.

Fixes: 1fac52da5942c ("net: flow_offload: consolidate indirect flow_block infrastructure")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/core/flow_offload.c | 2 ++
 net/sched/cls_api.c     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
index 5071d7fe6ce2..64451129a230 100644
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
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a9f54988561f..ffbb8353251b 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1665,6 +1665,9 @@ static int tcf_block_bind(struct tcf_block *block,
 err_unroll:
 	list_for_each_entry_safe(block_cb, next, &bo->cb_list, list) {
 		list_del(&block_cb->driver_list);
+		/* linked only for an indirect bind */
+		if (!list_empty(&block_cb->indr.list))
+			list_del_init(&block_cb->indr.list);
 		if (i-- > 0) {
 			list_del(&block_cb->list);
 			tcf_block_playback_offloads(block, block_cb->cb,
-- 
2.54.0 (Apple Git-157)

