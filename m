Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A7440652
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005167; cv=none; b=SWsZV7fVZggHz/9Alre9/E7a6KCTvOMKB9OSdCnqLima3gMusOoiWP6jiXgLS1qJYWPX/c7JeD5S0QnopgzFXKiMBVQSBSKN87BGhf4Tp9j/9hqoqKRlmAfY2ynprGF2Qn6W/DooNFZ7ei4LvldsdSTroSn4Ztun519uKlQL83E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005167; c=relaxed/simple;
	bh=xIq3t6dChknsEnIOTV74XW7S7ach0NV56IdvrMJxXGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vx+su9KJMpdl4WO3vvtNEMzvY7KC6H916LZs2NYXhiaQuE0/E1ZHwe5zUWqZzxc5ArqH1nvWkmWLtD49ACCEBgIFBYcWd6Y+l6QVKzCBwB+EzVTEyvLepY06+fov5YbmZSyztIA4gP5aL4ehPvF2pc7gmf6Zt9ZQ/XpFv+Ed+pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=YvuStzba; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="YvuStzba"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3514b90bb89so2226055eec.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792005163; x=1792609963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CrhnOyCnuFrl0jSp2QdE1/m0irIgtCD+WhnhWodFpc4=;
        b=YvuStzba+iB0SB8lhAE/rqO16PB8rBnF9dYmh1SZ6IfWmPI8l+9zI+NDhqhOzDsY1V
         5ZfnOfbPLKNZwn30vgfaAWXGTJDoSRLpBuTVecfFaF2+hyyLxoTdBQysoiATfTNHSdtj
         Vb74+tD8fBDQ/nhum5+CQFgdHS/JewpPzVO6on9pXxHZQe7XE9PvTjuu7QM3w8h5GrHS
         yLUCX/U3Ax6mTtUIbezBk7mWg6vys21s28AHU6OlYPkfpoHj100Pmm0Z0/4xHHBVt6Er
         upYVmkMwKr6u+uJsVgXK8h0Kfg0PI7KKp6Q+4EFStDO346MPFPSRinEVmHhiwc98fV3c
         KyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792005163; x=1792609963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CrhnOyCnuFrl0jSp2QdE1/m0irIgtCD+WhnhWodFpc4=;
        b=BulqV1zhkeIStHoTIfOrBdrv6hWm6uidGcbtkGva0b1t0ytti9kxyQbNxRNGXAg6RB
         Nj0TFJ8RmVe3UbHPs9yhag4NyCa7+HhUswoWFSAec9IcYT42/hPJFUQkR0d/r6jqAauO
         6BPSsDd8Cbdb6SDsaVmOCK575Sq4A+NXwTfdRGDa/zpHO3hl2JHPMRqoa+mX5kDA+7fB
         Y5A1tn10Nn0F8qIGU2hju0VBB4AG1nGeTXIQ3rHu7yIVi7LlpjayYJDp2G+4ONOS4NkO
         WU5mT39Mv2un3SWNk76+52gTCAQX9DYiU6KroM4ap/ylFNE11VnkXgefwHe+2VbPLW/6
         qrpg==
X-Gm-Message-State: AFq9FYJCnQJW3Q0TEiGsGpFDWwViMAKDP8HtlbKMJerHg9KDLkLY+cbs
	F11jdTbX/EENoXAN4Z047BRcL+AmLJqlI4HHEx4/02eQ1NHV3MZWMSB0SLEkI6G6n5OrKpCKaDN
	niXF9zVkYfA==
X-Gm-Gg: AYBFou2OzvQDrjQe6emYmhJrEXQqwCa4Z8hAZ6yNRhwGwA2TXpHkIavxAl6wPg55JR2
	x1xc979lnt0AVphMiNLZTsMf5RFtv74ZYBCpiOo4uTsn763mMWNEKA0AFXIX8lQN1LpNlCiClPH
	a+Hun96R97tNHmdjnunnwpeUSjJfS2t/7420OjuCXA/oLKuJFfsbv0lkfqgUKBd+qR707Ag63q3
	fOFfsTNFS/eL3tYL6/N/cvO/8scEFJX795vgmPt07feNH3sWHHkhI5ovL7q0q9VxurdJP8u2KmT
	xp6AemndRccQl5L/SjhIvonq0h1khg036R+lTcm8MKvbcv3t+odtKSC3PyeH2mP6G2rhvWBYhRF
	UtS2Ppegf/GKSdWXOdVZLzzYHbprp4r/eZT245jyv7UE1nC1k0Ht4cnzAlnTBdPjoekcHfy0CQ2
	5XAh/PMBGUWjxjpiH49u5bH/IILaNtFeyoGr8kZ+rMbmLOrj+1Vth+TFO/5ZX/o4F1ibOKnbT/R
	kh8zGSFe7poC0a2npeyC3EztPmcY+nl9UWiwPGb0VzPO1Z69v602rQ+vN2gaivZH4eVjPs=
X-Received: by 2002:a05:7301:182a:b0:34d:7ae5:8d78 with SMTP id 5a478bee46e88-3537e034fecmr22587390eec.31.1792005163180;
        Wed, 14 Oct 2026 12:12:43 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:39d1:d8de:aae7:23dd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm54329888eec.28.2026.10.14.12.12.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 12:12:41 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	linux-kernel@vger.kernel.org,
	neil@brown.name
Subject: [PATCH 6.6.y 1/2] llist: add interface to check if a node is on a list.
Date: Wed, 14 Oct 2026 15:12:35 -0400
Message-ID: <20261014191236.23696-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014191236.23696-1-artem@trailofbits.com>
References: <20261014191236.23696-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

[ Upstream commit d6b3358a2813bb14791259a2227d9af1e7019ca0 ]

With list.h lists, it is easy to test if a node is on a list, providing
it was initialised and that it is removed with list_del_init().

This patch provides similar functionality for llist.h lists.

 init_llist_node()
marks a node as being not-on-any-list be setting the ->next pointer to
the node itself.
 llist_on_list()
tests if the node is on any list.
 llist_del_first_init()
remove the first element from a llist, and marks it as being off-list.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the prerequisite for CVE-2025-38264 to
6.6.y.

The code changes are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series: x86_64 objects
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 include/linux/llist.h |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 85bda2d02d65be05f9fad9c52f60b49ec483d2a7..dcb91e3bac1ccce7c8327cbeb42462f5eaeb79be 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -73,6 +73,33 @@ static inline void init_llist_head(struct llist_head *list)
 	list->first = NULL;
 }
 
+/**
+ * init_llist_node - initialize lock-less list node
+ * @node:	the node to be initialised
+ *
+ * In cases where there is a need to test if a node is on
+ * a list or not, this initialises the node to clearly
+ * not be on any list.
+ */
+static inline void init_llist_node(struct llist_node *node)
+{
+	node->next = node;
+}
+
+/**
+ * llist_on_list - test if a lock-list list node is on a list
+ * @node:	the node to test
+ *
+ * When a node is on a list the ->next pointer will be NULL or
+ * some other node.  It can never point to itself.  We use that
+ * in init_llist_node() to record that a node is not on any list,
+ * and here to test whether it is on any list.
+ */
+static inline bool llist_on_list(const struct llist_node *node)
+{
+	return node->next != node;
+}
+
 /**
  * llist_entry - get the struct of this entry
  * @ptr:	the &struct llist_node pointer.
@@ -249,6 +276,21 @@ static inline struct llist_node *__llist_del_all(struct llist_head *head)
 
 extern struct llist_node *llist_del_first(struct llist_head *head);
 
+/**
+ * llist_del_first_init - delete first entry from lock-list and mark is as being off-list
+ * @head:	the head of lock-less list to delete from.
+ *
+ * This behave the same as llist_del_first() except that llist_init_node() is called
+ * on the returned node so that llist_on_list() will report false for the node.
+ */
+static inline struct llist_node *llist_del_first_init(struct llist_head *head)
+{
+	struct llist_node *n = llist_del_first(head);
+
+	if (n)
+		init_llist_node(n);
+	return n;
+}
 struct llist_node *llist_reverse_order(struct llist_node *head);
 
 #endif /* LLIST_H */
