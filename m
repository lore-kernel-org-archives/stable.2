Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BAD30DD1C
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536984; cv=none; b=NnvN9An+wQqERhyLrRBNGM0C5CUmvzapv76XvuMGQ5AAzw7RrXhHEyudSdIp6/5iVhM6aJ8p3u0Fjwr6hLFbX6oIk5Ucb3wSqUI9FZZc6HDayF3quy2WN3jnIHvY/nodrrxJyvYGu6fv91WTzYx+pNJ5+3sAaBnhqNpSCKTiBGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536984; c=relaxed/simple;
	bh=2PTJ9rIaDdw4QWDDUH25H6m5xMYtD82l8fRGvsm02Mk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qhm9hsAE3bA7Azu8jk2yDu+fDoP6MOwQ4xDXIy7oPXvDwOrGE7ry5zEyDEbB7H8OyuCklJtaXB9VxJmWYGDremi8M3juCs6xYNm6pkpX+6r5FMa/BO7ClRkPn8QBu/+kYYcb5N7dKGJcEb5ndeiAF09t22DyTgjTCzik6V8KY9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AUt5ze39; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AUt5ze39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99E31F000E9;
	Mon, 15 Jun 2026 15:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781536983;
	bh=2KGEjc4FEdtgyibrTxW+qjHa55Culu2PwRgq8XQqM2k=;
	h=Subject:To:Cc:From:Date;
	b=AUt5ze39dxaqglc6rliEL8UR7aoQd9fTnuYGaxmIbhH7qemzwe7szkPO1IoP1cixf
	 AkfJxsmeYV986WmbrdbODsySgeYCWWrhE23FlK8Cqto84SfoUMRWolsah7+Zlmq6hB
	 5ckJXkt0bZqPsdmxS/Ar1HW1QvcN69JYv0TB/EtE=
Subject: FAILED: patch "[PATCH] nvmem: core: fix use-after-free bugs in error paths" failed to apply to 5.15-stable tree
To: bartosz.golaszewski@oss.qualcomm.com,gregkh@linuxfoundation.org,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:51:24 +0200
Message-ID: <2026061524-undefined-splinter-9744@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5b6b6fc491899d583eaa75344e094796ae9b530b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061524-undefined-splinter-9744@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5b6b6fc491899d583eaa75344e094796ae9b530b Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Sat, 30 May 2026 21:43:40 +0100
Subject: [PATCH] nvmem: core: fix use-after-free bugs in error paths

Fix several instances of error paths in which we call
__nvmem_device_put() - which may end up freeing the underlying memory
and other resources - and then keep on using the nvmem structure. Always
put the reference to the nvmem device as the last step before returning
the error code.

Cc: stable@vger.kernel.org
Fixes: 7ae6478b304b ("nvmem: core: rework nvmem cell instance creation")
Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration time")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204340.116743-3-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 311cb2e5a5c0..e871181751f3 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1468,18 +1468,16 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 	cell_entry = nvmem_find_cell_entry_by_node(nvmem, cell_np);
 	of_node_put(cell_np);
 	if (!cell_entry) {
-		__nvmem_device_put(nvmem);
 		nvmem_layout_module_put(nvmem);
-		if (nvmem->layout)
-			return ERR_PTR(-EPROBE_DEFER);
-		else
-			return ERR_PTR(-ENOENT);
+		ret = nvmem->layout ? -EPROBE_DEFER : -ENOENT;
+		__nvmem_device_put(nvmem);
+		return ERR_PTR(ret);
 	}
 
 	cell = nvmem_create_cell(cell_entry, id, cell_index);
 	if (IS_ERR(cell)) {
-		__nvmem_device_put(nvmem);
 		nvmem_layout_module_put(nvmem);
+		__nvmem_device_put(nvmem);
 	}
 
 	return cell;
@@ -1593,8 +1591,8 @@ void nvmem_cell_put(struct nvmem_cell *cell)
 		kfree_const(cell->id);
 
 	kfree(cell);
-	__nvmem_device_put(nvmem);
 	nvmem_layout_module_put(nvmem);
+	__nvmem_device_put(nvmem);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_put);
 

