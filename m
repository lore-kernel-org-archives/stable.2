Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFA0229B38;
	Fri, 17 Jul 2026 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784250900; cv=none; b=I7LCvm8IbREcxjx4raYZlYRJQS9iF8VJGg2xyRxZ6HM23Vur6JCXEkYNzT2z4hD/R93/dbr3Gq49z9oI4Kzp7YHqSGWcHAbeGkjzQll4ToK/IJI1tpIME7lFsPDxoXEgBSr9nh/Zo8DhcwIrSN1M+KOPYO8zEWdorHw4tTT91uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784250900; c=relaxed/simple;
	bh=zr0ECF91I15oSc4s2YT5iUepBgUeUKKUpPo3A5CpUaE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DmSsYvVKAbg2tiHs+Ct+JAbH9WDIUXPAgEL6uLExYynH3BWs3sm2v1imG0ro5BIlY84uyCuC4x0oIMRAmJEdtuL3NtDlj9KMpPSxghX2KhT08iEXYG/HgY4uvpe1U74wvjnXsag18uV3F2cqQRGY0+4Y3SJ/qAYYh5v1/P0l89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDXKDQEgllqkIICAA--.4781S3;
	Fri, 17 Jul 2026 09:14:45 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgBn+tADgllqPGf0Ag--.58410S2;
	Fri, 17 Jul 2026 09:14:43 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: dri-devel@lists.freedesktop.org
Cc: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] drm/xe: Use timer_shutdown_sync() to quiesce the self-rearming irq_fail timer
Date: Fri, 17 Jul 2026 01:13:48 +0000
Message-Id: <20260717011348.3141550-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBn+tADgllqPGf0Ag--.58410S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?S/T2MAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI2lcIsOMl+SKSxLpipLfxGxgT1v3pfDpcRD3+WkznGT7PQ+
	s3jpI3sGajjaNn4hN2UgQOeVi8muadMAnkH2STNd
X-Coremail-Antispam: 1Uk129KBj93XoW7WF4rJw4kKFWDur1xGr4fXrc_yoW8WF15pa
	y5Xr1Utr9Fq3WI9F17Zan3WFy5Aas3JFZrK34DGay3Zrs8Cw4rtFyDurZIyFyrAa47XF9F
	yrs5trWSqw4DCagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57
	IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE
	14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2
	IYc2Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

The execlist port's irq_fail timer re-arms itself from its callback.
xe_execlist_port_destroy() currently uses timer_delete() to stop it.

timer_delete() neither waits for a callback already running on another
CPU nor prevents that callback from rearming the timer. Thus, a callback
can rearm irq_fail during teardown and a later invocation can access the
port after the drmm cleanup has freed it.

Use timer_shutdown_sync(), which waits for a running callback and
prevents further rearming. xe_execlist_port_destroy() does not hold
port->lock while shutting down the timer, so this cannot deadlock with
the callback.

This issue was found by an in-house static analysis tool and confirmed
by manual code review.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/gpu/drm/xe/xe_execlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_execlist.c b/drivers/gpu/drm/xe/xe_execlist.c
index 9fb99c038ea8..c1153dca8af3 100644
--- a/drivers/gpu/drm/xe/xe_execlist.c
+++ b/drivers/gpu/drm/xe/xe_execlist.c
@@ -287,7 +287,7 @@ struct xe_execlist_port *xe_execlist_port_create(struct xe_device *xe,
 
 void xe_execlist_port_destroy(struct xe_execlist_port *port)
 {
-	timer_delete(&port->irq_fail);
+	timer_shutdown_sync(&port->irq_fail);
 
 	/* Prevent an interrupt while we're destroying */
 	spin_lock_irq(&gt_to_xe(port->hwe->gt)->irq.lock);
-- 
2.34.1

