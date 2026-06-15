Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A7130DD1C
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536993; cv=none; b=rgbIsf5QOUS/+z0EHfjHeuAFut8LaGbXuIynhCwX1D3FzgZ34IuC8rpe3oXHyA+4T25RaTsdnh9iu7RLsWH8iTVAu0IfikI/VzkIUf+WAI4/Cmqk4O+zFhB2jxYGDcZ3PhPyboGBOnWKi0gv8y02KFPyPk1xRagoGAZ0nef5yQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536993; c=relaxed/simple;
	bh=yEqzqr1PJcDdqKlkjBeBhIvLfLn9/+MOEMnuPGxqtlE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YZTpoAbuzVxfjpcma8hFSCiSzMttFmzPM5L7/zqkdQs2vzVxOh0JhgbFENdn/EhAij1BngEP/lfgcvtCS1neeZJ4ttWJCkrzQyglh3iRd4SdxNi9TeWfIkDIctgRCm1o0IcI0ZOeSMS4oNXcXwSpqSny2mTknzFQ8f6e8EeMiIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m6XuvE/Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m6XuvE/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D73A1F000E9;
	Mon, 15 Jun 2026 15:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781536992;
	bh=t9K5EiR74L0JIrMnXy/LwzIIB39Ghx/iIA3l4gluf94=;
	h=Subject:To:Cc:From:Date;
	b=m6XuvE/YbryzVS9i0r+oMMIB344c+bsTPysy3ET3C0x/3rqEZPpNhN2Qjj+VYwiea
	 7EHiEFTji4v9pLaMAxjqRtpBMg+9OrepjKXHtabflJo1VI0MJHByTX7wmn4792IhNp
	 CN5Zs/hY7Vqjda1tZn7HBLV48OoDKGMZkaatokl8=
Subject: FAILED: patch "[PATCH] nvmem: core: fix use-after-free bugs in error paths" failed to apply to 5.10-stable tree
To: bartosz.golaszewski@oss.qualcomm.com,gregkh@linuxfoundation.org,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:51:26 +0200
Message-ID: <2026061526-hypnosis-sprang-85b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5b6b6fc491899d583eaa75344e094796ae9b530b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061526-hypnosis-sprang-85b8@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 

