Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB9035203E;
	Sat, 30 May 2026 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173835; cv=none; b=YMgb2Ygs15gBkjGGeo5cU3KR6dtzI0NxPdPjLniwwmiw9bu6ggaYwK75P8q5nbq+A9wfc6fXSz/9En13iluQF6i4kGL5xxWUb6V2No9/uY5G/V1wsByQPVaBer8nzRwmOkf5cwNKPnlzMSffV+0TTC4izBn+RMMX7qCz9jZFnGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173835; c=relaxed/simple;
	bh=NBiNNOZ7ppkAGEMCPKXAcUmyiX2x8UQCji/NKXqzUlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvuSXq9UADpFx7auD184m1yREW5/pYl512caJZHILywJF0Rv+eGzLu6li78TnwJ8jzl8tDScGyekaJonLZuG3oTxO7HGB64Ui++hKT8a3yhP4DdHFexajIYmAWf6llakJiSjEUo4WLkJoE9Q9jriVI9aX694/6b95UNI4ZC8mLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnpHussE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnpHussE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038801F00893;
	Sat, 30 May 2026 20:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780173834;
	bh=6rRzrKY+Y0EORNDYkmctl/wGL7UatyXvPKDCbTQlR+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NnpHussEiAuq8A/wIXQjlrlB87kDxZ+5GHiKB7Hjzq57ONLtD1lLki9bOhWVGUQLo
	 iZcD81BJd9VjvnwZpCgBJ6GbHoMOEJQPpDIpt9EpmDzvdkEg4469buJEKK7SR6kLPy
	 ycMYvxK8N6Zwt/j7NNPCrruTDQbpwLY9lwJeFd0mNMg7mBNFljTg6l8umFvHWSIOQD
	 00VYMP/7MyQ0NSwF/IfxzLMeLEhyP5FS54oIat1Jz8EUozly7tDt/dWkG+171kIytD
	 1H2Np+xI7y6K0Ycc/h9WpmryI2K5HCzmmnQkMb4w35qgS0EhqnMK/I8Hrn+gGmwIyY
	 Jfmc3kzRZBKrg==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 2/2] nvmem: core: fix use-after-free bugs in error paths
Date: Sat, 30 May 2026 21:43:40 +0100
Message-ID: <20260530204340.116743-3-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530204340.116743-1-srini@kernel.org>
References: <20260530204340.116743-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

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
---
 drivers/nvmem/core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

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
 
-- 
2.53.0

