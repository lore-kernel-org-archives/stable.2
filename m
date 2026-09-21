Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0A647C11C
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983695; cv=none; b=Bk6Omi047Btc3HGv+KupUUl9uHpZmQE+W7G/lE2ZkdUO/teciTAXl0DAfz7FsrTAMFuJaqggANi/aXuhpnxrTx5KF38rGUnVyiZ0l9m+AcYOgQ790Wqyw19MayIX6/iw5jkH5mgdZ6RkQGnk5oqXEAxDE6NGpBqr6icA6cE5DNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983695; c=relaxed/simple;
	bh=ozu5/SZuYmOj7l/+TcTNUYCFkfrJn6H80xQ/szzuqj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceyKvOzpEEuch10YANmemBiuDbWnEMYlf283OAc55aGOAa1cm3U3VgeRPx+YLWra3adBe3qG86MFSflVQ14IW4d/X9Z0rJXAk/H1nm7rGUBoBXPobE7Cf5LXG9OZ1weIq07bMu1SFtzEMr6+x7+sGevhzLWyUi64wugVFy7+t8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbZCAa+5; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbZCAa+5"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334e72so24660695ad.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 02:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789983692; x=1790588492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJ8HiLAEu0EI7hAaBs+acvitqX1WjD8B529R9qokT7o=;
        b=cbZCAa+5cVog9asM1kucgkDgEirPKJf2FWMUurtmxxfBMpWniHsQWfyNDa+wcPBYG2
         nW3ZrKoCTcs1VPCDC1AYpSOBMW9SKUX2eRZ9Ru1BITSBMJctVM8NxRwe1SjmZyImwCXO
         ufrmjkUinPi9UscH3XLZsnPP6pUazuzRr6+hWO+33QnhyBppGyxvK7bBj2LmbNbVnTZE
         L2fvPXARJx2IHY67edo4wGBlnGasZXFga2i0086duAcP0E5tN9ZwPWRVpyQv3qXRB/rS
         mc6KFejXmtCLykbNqJx4k/3xyu1bNn9Xzsh/kmdeZyYsG96m/1CoLS6OYcgTtqOpXNuT
         T3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789983692; x=1790588492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pJ8HiLAEu0EI7hAaBs+acvitqX1WjD8B529R9qokT7o=;
        b=oblA5DMU5oav0/QX2+W3WOjFTZRtkRmIpZYAXJB1SM2W5ivGazPpJ5iGqKNs9U00fE
         oEU/7fRjdqV4cQORSkGyVqoFAt/Cvwpv669rgVitA5c/2mM+Y6FTSzdpCRJyTuJAJfCA
         UiA7Q6HDkE7n6qY4ple0XzOU3t0ve5SK3+32JqIwgX/B0rZGr0QnQLmYHvBs4fCGffih
         HeOGpZCnfCfVG4H3Ps55yV+g4FDwKvXPcvhpHfztMHVROWsxxmxDO2/xg5vc49hZtdzG
         PMc/Fz2GItjdv2hexf4Xf4RwyWOli1/RnO4XSUJQ+ay1T9h1riH7/p5SOMzZvrxvQDlb
         GjQQ==
X-Forwarded-Encrypted: i=1; AKwUvByqFkq35nq+EGXN8/p9muBe7SIPvS8X/FlfEGaCLxQ8fAgWq5774hAAckUQJMrT04pQS6FtWF8=@vger.kernel.org
X-Gm-Message-State: AFuF++lX9l6vdmlXHI9kgAbAzWCLaOQVFdI9lodLel293xLXTFUuuyBE
	nV2MYfN/efIQd8zSQ0htf4XRqfX+jnbMZviYSRdv+eJMkwlKcQDL1ENg
X-Gm-Gg: AYBFou0ufZ4WT09Z53rTbd7gDiVGdOvungQT42/PHW1gO9d8qA/pYQRPrye31kliNUG
	X2f/y4h3xCh1z6z4IyS+K+CdUXSBHU/H1vfAlu7hhjOVc6WBuvhW70RkJ4IIBF2P6MBnj7LS3wd
	/cFf3iSXZIWFg5vwVu5x8V3BGVmTs8XMEoZK8LdV2bUIAfuZ7qE9UsTjbZaI1XxdRZ7ks1kXfTb
	VF3q5fMFf+4Xsv+8nsEJp0lTdW4sO41QJfhf+Bww4PdD0jsEH/Njhl9ftMSTp3IU6pTRlas6yp/
	8JTjVvYaLByHUu34NarNDzsrZu+e2uuzbDX0tCKswrsrSIO/VhE02/OFj7emZozwkbKJYpDnxPK
	8+qcb5puZ7wsRsfaVy22cUuGc4pFTQkmBof9YbDDQghg8+Kv4DWJCnjeSIF6lXAma6qgDv0wAUG
	ybb/HRniQ4OUUNnZ1RzjRqvdmMXmAbO7cJI6XezUkioEldL2Rf42VVBway/Uu9A8FvWdAlZVs7g
	cJAw3nMIXflEeDwU4TSlaqFyI5/KrSXAKlFDyc0KUQwhjnuzPVrAa+lI+9Q5F8BT+PHLiDlO+f0
	s9dt
X-Received: by 2002:a17:903:2c0e:b0:2dd:c100:7cc3 with SMTP id d9443c01a7336-2ddc1007e21mr89901765ad.63.1789983692380;
        Mon, 21 Sep 2026 02:41:32 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (n112120123178.netvigator.com. [112.120.123.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17a04afsm31053665ad.42.2026.09.21.02.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 02:41:31 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH net v2 2/2] tipc: make conn_idr teardown safe
Date: Mon, 21 Sep 2026 17:41:15 +0800
Message-ID: <91e85c3211fd31d24b231e8def5755c0f18b71f4.1789960909.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789960909.git.xuyuqiabc@gmail.com>
References: <cover.1789960909.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The teardown walk iterated conn_idr by incrementing a numeric ID while
holding idr_lock, so it could scan a large range of unused IDs without
letting a connection's final reference release make progress. An entry
whose last reference had already been dropped could also be resurrected
by the unconditional conn_get() while its release callback was blocked
on the same lock.

Walk conn_idr with idr_get_next(), release the lock and reschedule when
no entry can be taken, and use kref_get_unless_zero() so a connection
that is already being released cannot be revived.

Fixes: 35e22e49a5d6 ("tipc: fix cleanup at module unload")
Fixes: 667eeab4999e ("tipc: Fix use-after-free in tipc_conn_close().")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
---
Changes in v2:
 - Rebased onto the current net/main tip; patch content unchanged.

 net/tipc/topsrv.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 908622a3d0fc..9333e36a74de 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -710,15 +710,20 @@ static void tipc_topsrv_stop(struct net *net)
 	cancel_work_sync(&srv->awork);
 
 	spin_lock_bh(&srv->idr_lock);
-	for (id = 0; srv->idr_in_use; id++) {
-		con = idr_find(&srv->conn_idr, id);
-		if (con) {
-			conn_get(con);
+	for (id = 0; srv->idr_in_use;) {
+		con = idr_get_next(&srv->conn_idr, &id);
+		if (!con || !kref_get_unless_zero(&con->kref)) {
 			spin_unlock_bh(&srv->idr_lock);
-			tipc_conn_close(con);
-			conn_put(con);
+			cond_resched();
 			spin_lock_bh(&srv->idr_lock);
+			id = 0;
+			continue;
 		}
+		id++;
+		spin_unlock_bh(&srv->idr_lock);
+		tipc_conn_close(con);
+		conn_put(con);
+		spin_lock_bh(&srv->idr_lock);
 	}
 	__module_get(lsock->ops->owner);
 	__module_get(lsock->sk->sk_prot_creator->owner);
-- 
2.55.0

