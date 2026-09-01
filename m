Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C372C351C35;
	Tue,  1 Sep 2026 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263622; cv=none; b=bohWMDlQq7lGnxm679HbgtkWkvG9kMff7ktGV9w5IITKqlAuVfS1ydemrUwB3XtUcIRp7kVGkCNQO1lV0GNVd8kib1BLiiPVxET+qYhPKyn1vEjT33FwOzFpUcduG5U3T2rqAVXhWymheGQrcKpSlNdGKE9Ss2xGCMHGN5kAgNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263622; c=relaxed/simple;
	bh=VZJMguHaSfwgD5qCtOBgajBCJiQ9J50kwB7jP3/rKdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UkomBzcYNzeOEwINe3n6y/VTrNGN3Y3vE+hxXV99ZyExaANsMSDjA0LPnRNElh7UCAbXPp4GMujCEzCS3bjeTNlKgeJOMFTLConyEnWwVu6bG/zpm2JVX7lndQNCi3UYLeux1dNVBFlaHU3O8WcEfTUo2YKCy6Dv49u+/JCQHuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=HoCwL/Ta; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="HoCwL/Ta"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c1dd2d99;
	Tue, 1 Sep 2026 19:53:24 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] stm: core: Initialize source state before device_add
Date: Tue,  1 Sep 2026 19:53:20 +0800
Message-Id: <20260901115320.3270602-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa05cd122af03a1kunm35ce7b8e16bc7f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHx0fVkIYSR9PGk0ZSk9JQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
	5VSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=HoCwL/TaUT4BUVW/FM6DganyIQHH+VY9A/4L5bVG+VUkAs3VamHw9UgPuehjr3/TEVGgpRgUp0/ERfWpqAUiZ7I4B4lbnWSiDB+DgVm3d1koH6lnf/nC3CoJIdbrBj/Fw8QfReum8LVYSfnskkkD7M2z6kIqVrGkE5xr8WI4/1c=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=0kg/xb+uh9YTaL55AYx88ooXtwAtXXFzRFvRme8FFeU=;
	h=date:mime-version:subject:message-id:from;

device_add() publishes the source device and creates its sysfs
attributes. A concurrent sysfs operation can therefore reach the source
before its output, link lock, list entry, or data pointers are initialized.
Initialize the source state before publication, including the back-pointer
used by source callbacks. Drop any link established during publication
before clearing the back-pointer and releasing the source on failure.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Assisted-by: Codex:GPT-5
Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
Cc: stable@vger.kernel.org
---
 drivers/hwtracing/stm/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index f48c6a8a0..487fb747f 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -1256,19 +1256,21 @@ int stm_source_register_device(struct device *parent,
 	pm_runtime_no_callbacks(&src->dev);
 	pm_runtime_forbid(&src->dev);
 
-	err = device_add(&src->dev);
-	if (err)
-		goto err;
-
 	stm_output_init(&src->output);
 	spin_lock_init(&src->link_lock);
 	INIT_LIST_HEAD(&src->link_entry);
 	src->data = data;
 	data->src = src;
 
+	err = device_add(&src->dev);
+	if (err)
+		goto err;
+
 	return 0;
 
 err:
+	stm_source_link_drop(src);
+	data->src = NULL;
 	put_device(&src->dev);
 
 	return err;
-- 
2.34.1

