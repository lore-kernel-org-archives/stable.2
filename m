Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.63
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443940;
	b=OtRjYulavnyfvyixk9kJ7sm+KTZKAIv7dcljnRng3dNYVBFqwrkTxLFoA6wyM6l5YSHP
	 7Cvt8Sq1d64NTtG7NCUr+GrWYvg82g96dqPftXiGdcZtI9PXNeB1tFICTODO4QOez9szc
	 9f3NOe9bIq66lFmslkiJCU0C04bdPMGRnjkji0ehPdVBxcEb/OgIpin0en0copRaUzt5G
	 jAkwdAkLgL6njfRoHzYNpqOxjW5jo5h6hTqbU4+WqmHpy+iYquw9zPl9hQtM6FaKn73+R
	 jPG94+PAA7JH/6QKqcrO09WWyHA2K15ypdJnCbFo2u6I1tannllbqK1HB2cLnHZccjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443940;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=sB0hPTHRDwA3P79tcE0bF9Aq9M5h4zOzCASvBHfpxy8=;
	b=W/zLVGvnHxanwCjocSqX5kcigwUxxl714V9TdufGMQLLWX2U1qGeEYTr2R9MvKvk6BDY
	 MOBXkM1/NaCJwWjJd+GvGMuZanCK17kKgddMSY5MAvTX0esYWU12IIrrSfAQ5uXTpEAuA
	 ICPsPskdGTnMlBErLHOQAcxO7kENJ2DEPeKq/Kror95PZ3BzrZ6BaezRWZWe92mrOe799
	 HJDOjc9vmr8sagnStpjJ5ZwxuNYVVMiRaal9oEXKcHf+x/K6PEsSN0tin5IDicPcr5sVR
	 fTlEHPyfU1qDVADs5/OWeqJzpnYm6Lq9VlRH75hycP2YslVYEavXMwG4t/7DTn7AI9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=cYjCJzpj;
	arc=none smtp.remote-ip=217.74.67.63
Received: from smtpo63.interia.pl (smtpo63.interia.pl [217.74.67.63])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FD3606A334
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24FD3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=cYjCJzpj
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Mon, 23 Nov 2026 15:25:36 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: gregkh@linuxfoundation.org,
	jiashengjiangcool@gmail.com,
	yun.zhou@windriver.com,
	zzzccc427@gmail.com,
	bigeasy@linutronix.de,
	nab@linux-iscsi.org
Cc: Slawomir Stepien <sst@poczta.fm>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+2799146a53c356f8017d@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] usb: gadget: f_tcm: take the TPG in tcm_bind() instead of tcm_alloc()
Date: Mon, 23 Nov 2026 15:25:13 +0100
Message-ID: <20261123142513.204652-4-sst@poczta.fm>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123142513.204652-1-sst@poczta.fm>
References: <20261123142513.204652-1-sst@poczta.fm>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1795443937; bh=sB0hPTHRDwA3P79tcE0bF9Aq9M5h4zOzCASvBHfpxy8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=cYjCJzpjA8zt9Md9hTm89mrb9iTQ/bm+S9Z7mt8IEudhbU7bt5SsmzuU2L/ICl7Or
	 wonEISpsBfmumOEvcN5KTbujuhuaWfKPA57/HNgiszBd8wePwwHOnSC1eJh234iQZ3
	 pyDSyL8txrEO+xn4oopWkNer7Hl6psYxj0kXUd24=

tcm_alloc() runs when a TCM function is symlinked into a gadget
configuration. It searches tpg_instances[] for the function instance
and copies the TPG pointer into fu->tpg at that point, under
tpg_instances_lock, and fu->tpg is never updated afterwards.

The function and the TPG can be set up in either order. If the
function is linked into a configuration before the TPG directory is
created, fu->tpg stays NULL. Creating and enabling the TPG afterwards
lets tcm_bind() succeed, and the first USB request that reaches the
target code dereferences the NULL fu->tpg. Likewise, if the TPG is
removed (the previous patch detaches the gadget first) and a new one
is created and enabled, the next bind keeps using the freed TPG.

Store the TPG in struct f_tcm_opts instead: set it in usbg_make_tpg(),
clear it in usbg_drop_tpg() and copy it into fu->tpg in tcm_bind().
opts->tpg cannot change while the function is bound: tcm_bind() only
runs for an enabled TPG, and usbg_drop_tpg() detaches the gadget before
clearing it. No extra locking or reference counting is needed.

With fu->tpg no longer set in tcm_alloc(), the tpg_instances[] lookup
there serves no purpose: f->fi already identifies the instance for the
item's whole lifetime. Drop it, and with it the tpg_instances_lock
acquisition. config_usb_cfg_link() calls tcm_alloc() with gi->lock
held, so this also removes the gi->lock -> tpg_instances_lock edge
from the following lockdep report:

  WARNING: possible circular locking dependency detected
  task is trying to acquire lock:
   (tpg_instances_lock){+.+.}-{4:4}, at: tcm_alloc
  but task is already holding lock:
   (&gi->lock){+.+.}-{4:4}, at: config_usb_cfg_link

  the existing dependency chain (in reverse order) is:
  -> #2 (&gi->lock):
         config_usb_cfg_link
         configfs_symlink
  -> #1 (&sb->s_type->i_mutex_key#24):
         configfs_depend_item_unlocked
         usbg_make_tpg
         target_fabric_make_tpg
         configfs_mkdir
  -> #0 (tpg_instances_lock):
         tcm_alloc
         usb_get_function
         config_usb_cfg_link
         configfs_symlink

Fixes: 4bb8548df632 ("usb: gadget: f_tcm: add configfs support")
Cc: stable@vger.kernel.org
Reported-by: syzbot+2799146a53c356f8017d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2799146a53c356f8017d
Link: https://syzkaller.appspot.com/ai_job?id=51e1f189-6d91-4321-a6ba-07d4eb3cd8cd
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/usb/gadget/function/f_tcm.c | 23 ++++++++---------------
 drivers/usb/gadget/function/u_tcm.h |  6 ++++++
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 3949b5c50cc0..469939a3329c 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1720,6 +1720,7 @@ static struct se_portal_group *usbg_make_tpg(struct se_wwn *wwn,
 
 	tpg_instances[i].tpg = tpg;
 	tpg->fi = tpg_instances[i].func_inst;
+	opts->tpg = tpg;
 	mutex_unlock(&tpg_instances_lock);
 	return &tpg->se_tpg;
 
@@ -1763,6 +1764,7 @@ static void usbg_drop_tpg(struct se_portal_group *se_tpg)
 		tpg_instances[i].tpg = NULL;
 		opts = container_of(tpg_instances[i].func_inst,
 			struct f_tcm_opts, func_inst);
+		opts->tpg = NULL;
 		mutex_lock(&opts->dep_lock);
 		if (opts->has_dep)
 			module_put(opts->dependent);
@@ -2308,6 +2310,11 @@ static int tcm_bind(struct usb_configuration *c, struct usb_function *f)
 		mutex_unlock(&opts->dep_lock);
 		return -ENODEV;
 	}
+	/*
+	 * tcm_bind() only runs for an enabled TPG, and usbg_drop_tpg()
+	 * detaches the gadget before clearing opts->tpg.
+	 */
+	fu->tpg = opts->tpg;
 	mutex_unlock(&opts->dep_lock);
 	us = usb_gstrings_attach(c->cdev, tcm_strings,
 		ARRAY_SIZE(tcm_us_strings));
@@ -2734,22 +2741,10 @@ static void tcm_unbind(struct usb_configuration *c, struct usb_function *f)
 static struct usb_function *tcm_alloc(struct usb_function_instance *fi)
 {
 	struct f_uas *fu;
-	unsigned i;
-
-	mutex_lock(&tpg_instances_lock);
-	for (i = 0; i < TPG_INSTANCES; ++i)
-		if (tpg_instances[i].func_inst == fi)
-			break;
-	if (i == TPG_INSTANCES) {
-		mutex_unlock(&tpg_instances_lock);
-		return ERR_PTR(-ENODEV);
-	}
 
 	fu = kzalloc_obj(*fu);
-	if (!fu) {
-		mutex_unlock(&tpg_instances_lock);
+	if (!fu)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	fu->function.name = "Target Function";
 	fu->function.bind = tcm_bind;
@@ -2759,12 +2754,10 @@ static struct usb_function *tcm_alloc(struct usb_function_instance *fi)
 	fu->function.setup = tcm_setup;
 	fu->function.disable = tcm_disable;
 	fu->function.free_func = tcm_free;
-	fu->tpg = tpg_instances[i].tpg;
 	INIT_WORK(&fu->delayed_set_alt, tcm_delayed_set_alt);
 	spin_lock_init(&fu->delayed_set_alt_lock);
 
 	hash_init(fu->stream_hash);
-	mutex_unlock(&tpg_instances_lock);
 
 	return &fu->function;
 }
diff --git a/drivers/usb/gadget/function/u_tcm.h b/drivers/usb/gadget/function/u_tcm.h
index 2cd15d9a1c0d..68ce03d3fb6f 100644
--- a/drivers/usb/gadget/function/u_tcm.h
+++ b/drivers/usb/gadget/function/u_tcm.h
@@ -15,6 +15,8 @@
 
 #include <linux/usb/composite.h>
 
+struct usbg_tpg;
+
 /**
  * @dependent: optional dependent module. Meant for legacy gadget.
  * If non-null its refcount will be increased when a tpg is created and
@@ -23,10 +25,14 @@
  * @ready: true if the dependent module information is set.
  * @can_attach: true a function can be bound to gadget
  * @has_dep: true if there is a dependent module
+ * @tpg: target portal group associated with this function instance. Set
+ * when the TPG is created, before it can be enabled, and cleared after it
+ * has been detached, so it never changes while the function is bound.
  *
  */
 struct f_tcm_opts {
 	struct usb_function_instance	func_inst;
+	struct usbg_tpg			*tpg;
 	struct module			*dependent;
 	struct mutex			dep_lock;
 	bool				ready;
-- 
2.56.0

