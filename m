Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5845545C71C
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347051; cv=none; b=VyRAzmkT0Dqybngf1ZcPCXrfQl3tYQ9LQzQyMd6N6iAms7/MXsZOA1iFsUDJYO6KqwvaWz4CGvGFq/lCL8AjMIXQld/q1RR1dIKvCi2qiia77yvFyc6LRKzLzjuG97TCK2itwsmObvv8kS8CmrVOFfHAiORNsGp77CcRkOxpqmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347051; c=relaxed/simple;
	bh=InWdAuxyFhGUYL2HTGnHaN6Eysn7z8PAuhLPW+fSIWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=los4qv1JmE0Dd9EMGilWLdeEqdZgYFL7fi2k4Vu588NZQ4R6NVDG5bpkGx/j+4l1LlDPXLdG5piDqElObTZQ6piTq6yRIuIpzNbHs6yQ/ZPVe1Lw+CgpMByRrUNpToVZPcXcugwxJjPOyGZXBZcEwpIhw2Dd8UvHuQFtwgUl8kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=ZlLGf51W; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="ZlLGf51W"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so7853245e9.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 04:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1788347046; x=1788951846; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mGpDj/ts2TvIc7WC65F3OWBSjwCUTru8TXHzW2dzmkQ=;
        b=ZlLGf51WtuNahQQaShSAeTAAZs4ZTbdn5NpVPaQSfvAMSIjfkz28rW+chll42sCDuy
         BsrVr/fnh00ghWtEvv+z6sIOWO8w7dszdWT7AMgdLckNYNpFG2dMxqYLjr+jZS638c18
         NNSE1meMacZtALdSSTP9Hg5Eiz8CI6D5c2tqj0EehprE5cbK9GDhbPdNyAKZa2yH5kkd
         QYRmpalrZMFfACsUTI9CincD9i3glujJh6cFoySAOpejKCnkV+b+oBJdW58HjTPzCwHn
         wSeliG1wS2YdFX5TQKeTWbSIEh5ZAESbkBLE+DaXjhnmhlPBixICozhF8yed2DK5ScPs
         yGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788347046; x=1788951846;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mGpDj/ts2TvIc7WC65F3OWBSjwCUTru8TXHzW2dzmkQ=;
        b=B6lfKYi21lgwncn+52sZPiD1kWzhtRg4YQV2+V7orpGadDhhKg+elA2LlABB8KS+xB
         T3Rkn3NK9pm52e+pQhfZEd6SSqsJo+rI0ng3xlkW8WeeZxgMviOYgw0V6VHyXe6XcZ7M
         z35HK/BFW5m9qIouhDrtvY8rnqrlO/nYmoepMAcz7jk/EutLf1vW7RkLNaZBrFouu7IF
         ik6BVhwiZnOqgPXp1eEiXAx8uF4lY3KEFwtQMLM3qxgdlkmAwKZmZFIsIbqlwhq5ocU4
         nLzbBGs3ubvl61D72eP1+pde1+g7fldxQvtTy6neJ8Z0agDlaUljSOI+CAIem3fvHSH6
         ZILg==
X-Forwarded-Encrypted: i=1; AHgh+Rpf8ph3w1WbjnRxFEJtLtlK4rEsoWkYNv6Ovcl0ICCg8F70Rzpiib+UJf1opBPq4ieM2eKnbWI=@vger.kernel.org
X-Gm-Message-State: AFuF++n2QiJdf+Yzd05Zf4w7T7/atNgkwQZJTS+Z8WsWX4wTiM9gXNZ/
	i7gwkTubsZ/EPFDsIYmPTTMVI1/IbvQHdu9yoQlDisz2oyv/0YbzpSPnxmGtvShFC8U=
X-Gm-Gg: AR+sD12f6dOV0d1DdMwtzPldfALz8VxLHQso8sxuDwwYuACRqCChUFVwM1ytEelwfOh
	swoNV1DvOq4NllVYh0mvOWDwyFEcrU9hMYpsOP+TkjkWd9nfF57Dchh8zXwibDdyvqrc52n3IpW
	45slcPf6KAsAhmv5cnpO6scBFeG7J8AhHVV81dvep6uHuHYfZWQO05kpLOfOb6+OkISeJe/MUkl
	txrVUgQY9gBd+43HqIg2ZtmbJPbglpKvLHH3amckjQOGbNDD+JHed+Zh8gWe2FKU1fyuEP/0lJ2
	W8jx1NVmCaNjkxrPMdJUHgsJj0Pg5vLQJtOYiITkyKmi5HIHEZey9079FZ5L5geHhui+EX65Zdu
	PnVR80k3HIPABVubIBMfbNgC90NETZ1LjLDPrPNyvmfdbFDijEjvVe3WU+vqndYUh2X8mLbB9az
	t+6aZAsX/ljP+5dUK8Dip0OnP2CZlBQ5CT9EzpE6h/R+HZuFn++o8EkutsTi6gerqqc+SulgPEZ
	7G15S014i0IAB6CfPes22T0uRxTV3qS4E6KI5rk6Q==
X-Received: by 2002:a7b:c3da:0:b0:49c:d293:70c8 with SMTP id 5b1f17b1804b1-49ced887bfcmr5783815e9.3.1788347045902;
        Wed, 02 Sep 2026 04:04:05 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce0b425sm140373575e9.1.2026.09.02.04.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 04:04:04 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 02 Sep 2026 15:03:48 +0400
Subject: [PATCH] nvmem: Drop a layout's cells when it is unregistered
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-nvmem-layout-unreg-v1-1-2d16bebeb518@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrDuQTlCwVyldJDrqSI0lP6KId
 zfV5bd4b4fAXjjAq9jB8yJBZpfxfBTQDMb1jNJmAymqVK0I3TLxhF+zzSlicp57pFYZqzXpurS
 Qw5/nTtZr+v7cDsmO3MT/CY7jBCAmijZ2AAAA
X-Change-ID: 20260902-nvmem-layout-unreg-2d0ab332395b
To: Srinivas Kandagatla <srini@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 stable@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7797; i=alchark@flipper.net;
 h=from:subject:message-id; bh=InWdAuxyFhGUYL2HTGnHaN6Eysn7z8PAuhLPW+fSIWY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNYJpnNl3CQ+LlsyWBvUmbHbO/HmW2n5XEW3GDZZv5M
 cm6m7kLOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZhqnRBGhhf3k3fc3xG27j33PBnppS672WPni+4WbZhRX6HWJXKir5qRofuRjXT
 CPjE35TKfx7vXHw6wePNMdmOhG/9frxVXlp9Q5AYA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Layout drivers add cells carrying a read_post_process callback, and
sometimes private data, which belong to the layout driver itself.
Since layouts became regular devices, that driver may be a module,
unbound and unloaded independently of the nvmem provider, yet
nvmem_layout_unregister() drops nothing: the cells stay registered in
the core along with their now dangling callback pointer, as do the
sysfs attributes referring to them. Reading such a cell afterwards,
through sysfs for instance, calls into freed module text.

Nothing prevents that unload either. The module reference taken in
of_nvmem_cell_get() is released by nvmem_cell_put() as soon as a
consumer is done with the cell, so once the consumers have probed the
layout module is free to go. Layout drivers cannot clean up after
themselves, as the core exports no way to remove a cell.

Record the layout which populated each cell and drop those cells again
when the layout is unregistered. As the sysfs attributes point at the
cell entries, take the "cells" attribute group down before freeing them
and rebuild it afterwards for the cells which remain. This also stops
the cells of a failed add_cells() from being left behind, and releases
the device_node references those cells hold.

Fixes: fc29fd821d9a ("nvmem: core: Rework layouts to become regular devices")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260901160339.C57051F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/nvmem/core.c      | 114 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/nvmem/internals.h |   2 +
 2 files changed, 110 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 0556d140170a..c9a977c52c61 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -35,6 +35,7 @@ struct nvmem_cell_entry {
 	int			nbits;
 	nvmem_cell_post_process_t read_post_process;
 	void			*priv;
+	struct nvmem_layout	*layout;
 	struct device_node	*np;
 	struct nvmem_device	*nvmem;
 	struct list_head	node;
@@ -517,11 +518,42 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 	if (ret)
 		return ret;
 
+	nvmem->sysfs_cells_attrs = attrs;
+	nvmem->sysfs_cells_pattrs = pattrs;
 	nvmem->sysfs_cells_populated = true;
 
 	return ret;
 }
 
+static void nvmem_destroy_sysfs_cells(struct nvmem_device *nvmem)
+{
+	struct attribute_group group = {
+		.name	= "cells",
+	};
+	unsigned int i;
+
+	guard(mutex)(&nvmem_mutex);
+
+	if (!nvmem->sysfs_cells_populated)
+		return;
+
+	/*
+	 * Removing the group waits for any read in flight, after which nothing
+	 * refers to the cell entries through their attributes any more.
+	 */
+	device_remove_group(&nvmem->dev, &group);
+
+	for (i = 0; nvmem->sysfs_cells_pattrs[i]; i++)
+		devm_kfree(&nvmem->dev, nvmem->sysfs_cells_pattrs[i]->attr.name);
+
+	devm_kfree(&nvmem->dev, nvmem->sysfs_cells_attrs);
+	devm_kfree(&nvmem->dev, nvmem->sysfs_cells_pattrs);
+
+	nvmem->sysfs_cells_attrs = NULL;
+	nvmem->sysfs_cells_pattrs = NULL;
+	nvmem->sysfs_cells_populated = false;
+}
+
 #else /* CONFIG_NVMEM_SYSFS */
 
 static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
@@ -529,10 +561,20 @@ static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
 {
 	return -ENOSYS;
 }
+
 static void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem)
 {
 }
 
+static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
+{
+	return 0;
+}
+
+static void nvmem_destroy_sysfs_cells(struct nvmem_device *nvmem)
+{
+}
+
 #endif /* CONFIG_NVMEM_SYSFS */
 
 static void nvmem_release(struct device *dev)
@@ -571,6 +613,15 @@ static void nvmem_device_remove_all_cells(const struct nvmem_device *nvmem)
 		nvmem_cell_entry_drop(cell);
 }
 
+static void nvmem_device_remove_layout_cells(struct nvmem_layout *layout)
+{
+	struct nvmem_cell_entry *cell, *p;
+
+	list_for_each_entry_safe(cell, p, &layout->nvmem->cells, node)
+		if (cell->layout == layout)
+			nvmem_cell_entry_drop(cell);
+}
+
 static void nvmem_cell_entry_add(struct nvmem_cell_entry *cell)
 {
 	scoped_guard(mutex, &nvmem_mutex)
@@ -844,33 +895,84 @@ static int nvmem_add_cells_from_legacy_of(struct nvmem_device *nvmem)
 	return nvmem_add_cells_from_dt(nvmem, nvmem->dev.of_node);
 }
 
+/**
+ * nvmem_layout_register() - Register a layout and populate its cells
+ *
+ * @layout: nvmem layout, as handed to the layout driver's probe callback
+ *
+ * Runs the layout's add_cells() callback and takes ownership of the cells it
+ * adds, so that nvmem_layout_unregister() can drop them again. Meant to be
+ * called by a layout driver from its probe callback.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
 int nvmem_layout_register(struct nvmem_layout *layout)
 {
+	struct nvmem_device *nvmem = layout->nvmem;
+	struct nvmem_cell_entry *cell;
+	struct list_head *pos, *last;
 	int ret;
 
 	if (!layout->add_cells)
 		return -EINVAL;
 
+	scoped_guard(mutex, &nvmem_mutex)
+		last = nvmem->cells.prev;
+
 	/* Populate the cells */
 	ret = layout->add_cells(layout);
-	if (ret)
+
+	/*
+	 * Claim whatever the layout has just appended, including on failure, so
+	 * that it can be dropped again when the layout goes away. Cells added
+	 * by anyone else, before or after this, are left alone.
+	 */
+	scoped_guard(mutex, &nvmem_mutex) {
+		for (pos = last->next; pos != &nvmem->cells; pos = pos->next) {
+			cell = list_entry(pos, struct nvmem_cell_entry, node);
+			cell->layout = layout;
+		}
+	}
+
+	if (ret) {
+		nvmem_device_remove_layout_cells(layout);
 		return ret;
+	}
 
-#ifdef CONFIG_NVMEM_SYSFS
-	ret = nvmem_populate_sysfs_cells(layout->nvmem);
+	ret = nvmem_populate_sysfs_cells(nvmem);
 	if (ret) {
-		nvmem_device_remove_all_cells(layout->nvmem);
+		nvmem_device_remove_all_cells(nvmem);
 		return ret;
 	}
-#endif
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nvmem_layout_register);
 
+/**
+ * nvmem_layout_unregister() - Unregister a layout and drop its cells
+ *
+ * @layout: nvmem layout to unregister
+ *
+ * Drops the cells which nvmem_layout_register() has populated, as they refer
+ * to the layout driver and must not outlive it. Meant to be called by a layout
+ * driver from its remove callback.
+ */
 void nvmem_layout_unregister(struct nvmem_layout *layout)
 {
-	/* Keep the API even with an empty stub in case we need it later */
+	struct nvmem_device *nvmem = layout->nvmem;
+
+	/*
+	 * The cells this layout added hold a read_post_process callback, and
+	 * possibly private data, belonging to the layout driver, which may be a
+	 * module on its way out. Drop them, taking their sysfs attributes down
+	 * first as those point at the cells, then publish what remains again.
+	 */
+	nvmem_destroy_sysfs_cells(nvmem);
+	nvmem_device_remove_layout_cells(layout);
+
+	if (nvmem_populate_sysfs_cells(nvmem))
+		dev_warn(&nvmem->dev, "failed to rebuild cell attributes\n");
 }
 EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
 
diff --git a/drivers/nvmem/internals.h b/drivers/nvmem/internals.h
index 4e610deeaa7b..9345364f6ed7 100644
--- a/drivers/nvmem/internals.h
+++ b/drivers/nvmem/internals.h
@@ -36,6 +36,8 @@ struct nvmem_device {
 	struct nvmem_layout	*layout;
 	struct nvmem_operations	*ops;
 	void *priv;
+	const struct bin_attribute *sysfs_cells_attrs;
+	const struct bin_attribute **sysfs_cells_pattrs;
 	bool			sysfs_cells_populated;
 };
 

---
base-commit: 8b72f6626dc39b9e7e82b2721d4f7c3b86286012
change-id: 20260902-nvmem-layout-unreg-2d0ab332395b

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

