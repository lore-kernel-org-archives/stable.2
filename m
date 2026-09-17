Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1284ED198
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677739; cv=none; b=K5iIFFLhSz4TUsxIL5RMawIL6H9iq8tPW51qasoDzvm0vF81pbBNx2AxQCua6EMCF0ROcgKLzdUAz7pCmqKgxVhUhJYMR0TytX8wnsr8b80ECPNGSo2Rgsnpx+fGb9U/rmWY9n3juNJIoQ89jqHT3t3vwAU0G8Mz2MkBDU7Nfbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677739; c=relaxed/simple;
	bh=kZtK+sVq+OakP0n9604KZpM7r41BPS7WKoDg0NZh8xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oWgDuzadIEkRo7TzM+gCEoTqRDgQe1o2ISZC/VqBygyiCdVrZ0g/5LdGe+LePHp//LdfSkZHK172L69MaPPwV1T+871FqFUHHF7Zoc4HqQ4+4a9n5FLX1hr1vX2uxulGx5UyNSFuIHI3hRW9/7sgNMlXK3bS7AaArkxUTzAYDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CP1TPdtQ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP1TPdtQ"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52f9fc510e1so9823171cf.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789677737; x=1790282537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=38H1xf2/ET/SoNjoIYflqfRDEtEJGG8vw0YM1GLHy9Q=;
        b=CP1TPdtQF61VSBDhw7T6xOw4woNmurF1GSWogVHDp0M9X8uPG0p9a+GPpo7xb11f3N
         d9i0rgqqBs/ATuuCTLNYXGeDsSdau5JgcohHzaIhGwjZlgGfh2DYMORX2CT7qdmpzvSv
         astxVyvKa8iTjvqpX3fjZcRqiUGB7NQV5IVksjgnGubW8Zhe575s0TOWHbi3oenDrVs3
         NbeS0/+m1nIvuxx49gdwBWDZTCAKhtYEuZVKz58Ina+s2andDJyFTOf/LXYuT2zIrh/c
         bfiFEpWFX+thpiY4pH9KXSUZSOmrtlUmVXp+Wi9aqN2ikvnaK1FPe5TjlLVFbhhVfJ0M
         F6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789677737; x=1790282537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=38H1xf2/ET/SoNjoIYflqfRDEtEJGG8vw0YM1GLHy9Q=;
        b=0BLg9W0yB8jbAIdO9qQ6vlHqapWohWqLyIgGumMbKH8rRoSwtUUw8AEgeqKMinRjRw
         5vphwg00vkLHxW6U/WFSmvqAEwjAZ9RAB2X6RLsQktF9ixP9TQk5mQYEMQoSbzsfmwez
         6fh8Sj9FIBo2Anu8a0JIadSXdd5MiDigdXJA6wkALY6fRMzVVLkr1fmLJqc4lLWpMLp2
         t/jvod1JxqRsCJ8TArt+hoGnRvWTgCSMKDa6Dk4y03HjQwDMihLqRkvwab//kR4uJYo5
         zRKgI6oHpEibCekv92XOZcI9ce6eOFuVRUKdx7UA/IDaRyqQluuVKew1XdZcmaiPu+9F
         G/xw==
X-Forwarded-Encrypted: i=1; AKwUvBzvB/uUk4Bajnl4VHsy55tH/a9FJJ+LIF35HOwbedkekL33TcKCLu3ytBaRtgpmh09nUzzOh1g=@vger.kernel.org
X-Gm-Message-State: AFuF++kpKKv1ZAVH+4Ld9jLKgThjY0BM6ixC/hy14jZL3fL5ZrtfiAp9
	0JUaFucLKUghhLphyjNDTj482kxj+upHVpxmeMw9odxOqoEMByN/tuY=
X-Gm-Gg: AYBFou2DitkJyXzAo9ipWUFnhrRL3qwkAu5s+OzKQeHf61W2vBjfaox5dWUNne+YhnI
	wC/p4dmdCV3U1RchCRLCfHDPJcvlzOXpoTn4nz/WxGmpk+iz74yW/VMWW2uGah9OY9c4TDxwd2v
	jrbA9gf5GuRYTVxS69hOwHCfOt5YEVEpI6T9h6vhZ+mGWhBkOcHuqkYocD72ixWFMFdT4At4RHm
	Zv7zj59GWUZHalYMU/xAWHG/vT7Feyz8GYsAx988L29lMvk9IAbv67VbFxLcOiRqawhLCJzLqXf
	ahmDBbEZEUjB5NdPUWHh+LvnCAKg/zSF4woRE1wK4kUTNrp6qgFBESf2NmPq0l12aV+1xSt6unx
	niz413tkNHG0YllNAocjRPG7wRQuX2h87FV9D8bBTtbGaByfDwNjgWaBrDWcPdR65gA5weBidr1
	NVuN17HzMwQqtxj5pJDnmtrGgWOw/ItBmEI7SC9bBTw6+7F0XTDy6drkMOrFIXnu9XAScRCCdwE
	uxXjlXZnwNuXf1VhIePQHK2Gxy5b/rkK6iYjbvjCq/VdKqGxn7tj6/7WoN8Vn8NiNhKpEEPBqWM
	GiZ1tapX08CqiUgTP1k9b4RuSmvOdUkSPxXL
X-Received: by 2002:ac8:5ace:0:b0:532:8063:4ccc with SMTP id d75a77b69052e-5328cedfe9dmr79101391cf.3.1789677736834;
        Thu, 17 Sep 2026 13:42:16 -0700 (PDT)
Received: from localhost.localdomain ([104.39.169.225])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5326204ad36sm58764301cf.18.2026.09.17.13.42.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 13:42:15 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] platform/chrome: cros_ec_typec: Stop altmode work before unregistering ports
Date: Thu, 17 Sep 2026 16:42:09 -0400
Message-ID: <20260917204209.97699-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DisplayPort and Thunderbolt port altmodes queue work to deliver VDM
responses to their partners. Port teardown only cancels port_work and
then unregisters the partner and port altmodes, leaving the separate
altmode work able to access released altmode data.

Disable and drain each port altmode's work before unregistering the
partner altmodes. Disabling also prevents a partner callback from
requeueing the work while its driver is being removed. Use the common
port teardown path so probe error handling is covered as well.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: dbb3fc0ffa95 ("platform/chrome: cros_ec_typec: Displayport support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Validated with static source review, apply checks and strict checkpatch.
No build or runtime testing was performed.

 drivers/platform/chrome/cros_ec_typec.c      |  1 +
 drivers/platform/chrome/cros_typec_altmode.c | 15 +++++++++++++++
 drivers/platform/chrome/cros_typec_altmode.h |  6 ++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 50a68819ceb7bbfbd888ca919d678d4c75237c26..e91bbc219c077067294935dd5602c1aec636cfa6 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -378,6 +378,7 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
 		if (!typec->ports[i])
 			continue;
 
+		cros_typec_altmodes_stop(typec->ports[i]);
 		cros_typec_remove_partner(typec, i);
 		cros_typec_remove_cable(typec, i);
 
diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/platform/chrome/cros_typec_altmode.c
index 66c546bf89b532d3bae1de322a1cfb1205e0190f..2492058d98b8ef2a4a1a9bee87ce0574f4f0a736 100644
--- a/drivers/platform/chrome/cros_typec_altmode.c
+++ b/drivers/platform/chrome/cros_typec_altmode.c
@@ -37,6 +37,21 @@ struct cros_typec_dp_data {
 	bool pending_status_update;
 };
 
+void cros_typec_altmodes_stop(struct cros_typec_port *port)
+{
+	struct cros_typec_altmode_data *adata;
+	int i;
+
+	for (i = 0; i < CROS_EC_ALTMODE_MAX; i++) {
+		if (!port->port_altmode[i])
+			continue;
+
+		adata = typec_altmode_get_drvdata(port->port_altmode[i]);
+		if (adata)
+			disable_work_sync(&adata->work);
+	}
+}
+
 static void cros_typec_altmode_work(struct work_struct *work)
 {
 	struct cros_typec_altmode_data *data =
diff --git a/drivers/platform/chrome/cros_typec_altmode.h b/drivers/platform/chrome/cros_typec_altmode.h
index 3f2aa95d065af709643ad653df487a9987780da4..9e67f82ba031d67dfbe3a0549a7987386c33d120 100644
--- a/drivers/platform/chrome/cros_typec_altmode.h
+++ b/drivers/platform/chrome/cros_typec_altmode.h
@@ -11,6 +11,12 @@ struct typec_altmode;
 struct typec_altmode_desc;
 struct typec_displayport_data;
 
+#if IS_ENABLED(CONFIG_CROS_EC_TYPEC_ALTMODES)
+void cros_typec_altmodes_stop(struct cros_typec_port *port);
+#else
+static inline void cros_typec_altmodes_stop(struct cros_typec_port *port) {}
+#endif
+
 #if IS_ENABLED(CONFIG_TYPEC_DP_ALTMODE)
 struct typec_altmode *
 cros_typec_register_displayport(struct cros_typec_port *port,
-- 
2.47.1
