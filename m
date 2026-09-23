Received: from mail-qk2-f35.google.com (mail-qk2-f35.google.com [74.125.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2514353A7A
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 05:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790140795; cv=none; b=cAM4g0/2lj49P+pF85nsLIW71PFIyXzKUWPfooCIUu2nh5ntujP6wdUzCDqwKKlxn7cT/xs24+dTezIo/t4kKugHGy0JdNJ1ttEmgHlqgbFgQOlCLYZsIrhnZgP0jGj/ytp2HcOW6iQRNHVaIMLlryC7WMF7c3W2/0QrQwJels4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790140795; c=relaxed/simple;
	bh=rd4bVtBebW5Eh3X9btyAfOosrbirLB3M1wbnj3/C+mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1kNWVc1fDHepSzGy6lD9J09afIO6QuhaaFtzkcnGO/Wr9BQsfVC3a32lnq/uZRSbyqfjrs9B2s87MWmT2mr9pFZzWPPNsATdbsOSKuOstKoyeRyN/CMeR8Dn53Avtbrl+o6mqr3Q9Rq8FYIGdqFGcAVZFDiBp4S6SrQl8HHd8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh+9KJWR; arc=none smtp.client-ip=74.125.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh+9KJWR"
Received: by mail-qk2-f35.google.com with SMTP id af79cd13be357-93910cadeb3so49478085a.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 22:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790140793; x=1790745593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xv3eebB7JJQAp3Uiqk1W5LHA/Ob2Oi0cbs08SqtlKHI=;
        b=Uh+9KJWRKSuR4dXeYYSL9Bh7Ke/kxwRKu57nLCFnC++eHkjr50M1zXVBr0+7XbA9eg
         9uLjwwDZ2DuS9FVTA2O0jVXFFwSwYoz6nszwJZAb2SzwCReCzTdXLfBCPKmZIGMgbwhA
         rw78PGeVkXE8JS5kRuG970uyZfvAKjz6b7THA0rwNbXeoGFYAVV5E6V5AhiISOOdg2am
         urfZatCo0upDueOK/brmYxImgN2k+X/JH8votrDrOlmyr+6t0qSukdUrgrVI2Q7N6Fij
         mfgV+9Gz8Rl36mkh1mysd9JRxB9esfYiI8CFsf2Og9irWhMzxwV3Cy0OuAzAykdMgPPM
         +jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790140793; x=1790745593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xv3eebB7JJQAp3Uiqk1W5LHA/Ob2Oi0cbs08SqtlKHI=;
        b=HsPGzKGif3nTDNVV2XWo6+3Tjrw4GVLgTwizgEzQCd0xaDJPYueAMoGIjFiFdB8GBf
         OlGEESb2oOmoycP0XkcaqJJOBCj5aEDcbXio13eyNDnobBqNaIpCeO5y96jygpUXzbew
         1qOOQavLnOhEcn+YYCpQEUoZetVW4O3hQEC3OQyzbifyKnscuklrmS4LIaPtIp+KWyhH
         uvUUH6z5Td7SuL9hc3xpH+SrRf0yLZyR7a54kcL3Rg2mswdvno/NbtTPN4YJ5a2cYlxK
         QJu47LqDOZp4wQl3vO6VwlAnROPfdADqih73ggQwb1CsN4S4KAyZrs8MVEVuhWfAnHbn
         T/gg==
X-Forwarded-Encrypted: i=1; AKwUvBw0+TDk4KkFV3yAfEgIzEfCc8v0TR9jz0NQIKghqejrWokPVgUXHIoA9+q7vj89BZhn+PNWD7k=@vger.kernel.org
X-Gm-Message-State: AFuF++kGVSUKvKKTsGixBRoWIuyvtZKFLSj2XReZ/x1pw0JRkeeCmhIY
	MUSAXaD42G3+TvzK/QW1Diz82O5dLRER0gB/+L3NrHDqfxfEr1MZsYc=
X-Gm-Gg: AYBFou0Utm/mGwdqTMFpXDL28Lk5tMIfO7G6Q2h2aOKlfbhroV67a0P1c+Yiv9GC8Ld
	OAGC1OQUZqyMS6s0vMFOhT3G8roSkxtGaaGzcmn3Qy9jb5a78vXhV4FeavCucw17fs4UtyXLm3m
	VqfuLXXDsmi5k36OQ8c7KWO+9dbVuPztHItFIBzBXQ4+LFhTY68NXU0AJ2mmCtcU+ZjlHicIYeD
	yHT4ynp2Nmqd4cnGaq/Y4seNo2Xy/BasQmxdv638qhCNI8C9qPINKEsI24e4YaBQl4/+aNJfdHQ
	9xBKaF4elzoNiHVnXJqy0JdhaCidhEBYJOO945WVaxLQzoTolKs7I61gTrMG/BkfTHrcx7lxT7W
	SwAjIJ3XHfSb7catY/r3TAQ0yAVLMkOZD1aoR5/yBj+8IUiCSieQVighxjg74YZZXRI5DJIAo6s
	LkX1uiwytt0u/FkoiaNlXdIfIrSfd144oTP/Lgrsn832KQ+1otzMBv8VsfcNdkrzgzEjolZvd7I
	NhUCzKoqrJkQPApY2jEd6IZu2dzKlrtszK0s/ZP/006g9STtZeanohgSaKtoWYAJtdqBhVnl7gC
	7WDFlYZS4siQWOgSMUTar6rqBsZkoSMvNCJ80NcJRA5wI6JqARyQj8gFzQAmLodw3xXRkH9aLL1
	V0tODrpHl5CGz
X-Received: by 2002:a05:620a:8810:b0:93b:e917:6888 with SMTP id af79cd13be357-93c251052e9mr240052285a.33.1790140792573;
        Tue, 22 Sep 2026 22:19:52 -0700 (PDT)
Received: from localhost.localdomain (h16.44.55.139.dynamic.ip.windstream.net. [139.55.44.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c248b7f22sm149877685a.37.2026.09.22.22.19.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 22:19:51 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ming Qian <ming.qian@nxp.com>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Zhou Peng <eagle.zhou@nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] media: amphion: Stop mailbox RX before freeing the message buffer
Date: Wed, 23 Sep 2026 01:19:50 -0400
Message-ID: <20260923051950.89403-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vpu_core_unregister() frees core->msg_buffer and clears core->vpu
before cancelling the message workers.  The fifo keeps its own pointer
to that buffer.  The core workers read it and queue inst->msg_work,
which uses core->vpu and may send on TX.

vpu_isr() fills the fifo from the mailbox RX callback.  i.MX MU
free_irq() waits for that callback, not for the queued work.  An open
instance holds a runtime-PM reference, so remove can skip runtime
suspend and leave RX active.

Stop RX, then drain the core workers and the instance workers they
queued with vpu_core_cancel_work(), while core->vpu and TX are still
valid.  Free the buffer and clear core->vpu after that drain.  Drop
the runtime reference only then: runtime suspend frees every channel.

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/amphion/vpu_core.c | 28 +++++++++++++++++++---------
 drivers/media/platform/amphion/vpu_mbox.c |  9 +++++++--
 drivers/media/platform/amphion/vpu_mbox.h |  1 +
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index 85cc4a14f8ed..000000000000 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -299,21 +299,23 @@ static void vpu_core_put_vpu(struct vpu_core *core)
 	core->vpu->put_vpu(core->vpu);
 }
 
+static void vpu_core_cancel_work(struct vpu_core *core);
+
 static int vpu_core_unregister(struct device *dev, struct vpu_core *core)
 {
 	list_del_init(&core->list);
 
 	vpu_core_put_vpu(core);
-	core->vpu = NULL;
-	kfree(core->msg_buffer);
-	core->msg_buffer = NULL;
 
 	if (core->workqueue) {
-		cancel_work_sync(&core->msg_work);
-		cancel_delayed_work_sync(&core->msg_delayed_work);
+		vpu_core_cancel_work(core);
 		destroy_workqueue(core->workqueue);
 		core->workqueue = NULL;
 	}
 
+	kfree(core->msg_buffer);
+	core->msg_buffer = NULL;
+	core->vpu = NULL;
+
 	return 0;
 }
@@ -700,10 +702,18 @@ static void vpu_core_remove(struct platform_device *pdev)
 	WARN_ON(ret < 0);
 
 	vpu_core_shutdown(core);
-	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
-
-	vpu_core_unregister(core->parent, core);
+	/*
+	 * Runtime suspend frees every mailbox channel, including TX,
+	 * and is skipped while another runtime-PM reference remains.
+	 * Stop RX first.  vpu_core_unregister() then drains the core
+	 * workers and the instance workers they queue, which may still
+	 * send on TX, before the fifo buffer and core->vpu are released.
+	 */
+	vpu_mbox_free_rx(core);
+	vpu_core_unregister(core->parent, core);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	vpu_mbox_free(core);
 	memunmap(core->fw.virt);
 	memunmap(core->rpc.virt);
 	mutex_destroy(&core->lock);
diff --git a/drivers/media/platform/amphion/vpu_mbox.c b/drivers/media/platform/amphion/vpu_mbox.c
index b2ac8de6a2d9..521fd47f1d90 100644
--- a/drivers/media/platform/amphion/vpu_mbox.c
+++ b/drivers/media/platform/amphion/vpu_mbox.c
@@ -88,14 +88,19 @@ error:
 	return ret;
 }
 
+void vpu_mbox_free_rx(struct vpu_core *core)
+{
+	mbox_free_channel(core->rx.ch);
+	core->rx.ch = NULL;
+}
+
 void vpu_mbox_free(struct vpu_core *core)
 {
 	mbox_free_channel(core->tx_type.ch);
 	mbox_free_channel(core->tx_data.ch);
-	mbox_free_channel(core->rx.ch);
 	core->tx_type.ch = NULL;
 	core->tx_data.ch = NULL;
-	core->rx.ch = NULL;
+	vpu_mbox_free_rx(core);
 	dev_dbg(core->dev, "%s free mbox\n", vpu_core_type_desc(core->type));
 }
 
diff --git a/drivers/media/platform/amphion/vpu_mbox.h b/drivers/media/platform/amphion/vpu_mbox.h
index 8b7aea4f606c..a934fe61b294 100644
--- a/drivers/media/platform/amphion/vpu_mbox.h
+++ b/drivers/media/platform/amphion/vpu_mbox.h
@@ -8,6 +8,7 @@
 
 int vpu_mbox_init(struct vpu_core *core);
 int vpu_mbox_request(struct vpu_core *core);
+void vpu_mbox_free_rx(struct vpu_core *core);
 void vpu_mbox_free(struct vpu_core *core);
 void vpu_mbox_send_msg(struct vpu_core *core, u32 type, u32 data);
 void vpu_mbox_send_type(struct vpu_core *core, u32 type);
base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.47.1
