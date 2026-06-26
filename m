Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059A3859FA
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 05:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451090; cv=none; b=bzmqPbrCkEZTxsAgr/AE8xbNkaNxEalSmj1G/FSIBYnHpfpb6XmfTgDocDHxTpQna1+sFyp1K/1Nf4mSqoGjURIcsUEjSqdf2K5KUYHmIIb553VQYQvVfVZjclDNhwoo8RLC+lQV9QLe7Eufdflo8IgZLLs0pV1YHh66DN6LTxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451090; c=relaxed/simple;
	bh=u0pnnlHNvhqHKYXVP83TDPb5Gn++EFyiGysaMS0mB0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ti8/uPjDSScIBHzmsLA92wxGTdS4McEn+qNymFaKe9/Y7/Z74zgktLTCrGRzQdcR4idNxDZSWxueAjh5J5I4Niv02RO2ApCIi63ORmRU0DFlgNQBHizLmLBRDX79ZXM1eG1Rae4OTQgs7pSQNQZb0V8+UUSASlE3jtoANykdNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ayfg7CK7; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ayfg7CK7"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so1444397eec.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 22:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782451088; x=1783055888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbR6UOmyF/4gNI6/KiEAATTeZ6SiaSNdrydBVvOp87E=;
        b=Ayfg7CK7kpGN0oTqzckiHtaWSPDVuX0qncYtg7JfGS3rF/GW+Qizys9/y3SeKDPjmE
         b35jpdTSYosjvUuBCDMb2rKzdq7xAUUUVn88xdKaR0dBxHb6yzmqI0iuzBmvP9KL0Tdj
         JiLaJSPExMZ+QqoGeqmCSiIHujXTRwlK0sJH+onvuAMY7fGSnV5DJmiaLlbDZo83vQ5/
         Q5MUnaOgFkd4b7vYh5P9dTSwnhIJrywmkMDwK4kGrU12yezaPvvjYOtpCmi8d14xcOOu
         zA3RYy5bJhaeNH5xKBMXiIKXSC/y4pZuKV+kKGY30tsKLqGcM97cZUvuBWAurE+hay19
         gA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451088; x=1783055888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QbR6UOmyF/4gNI6/KiEAATTeZ6SiaSNdrydBVvOp87E=;
        b=KcEz/w9T0zHxBL9yc8sz8DSfZwCWsSXCu/7v6d//CdrQnsVUXns0h1L5fDb84aR0h4
         vjxAq9XdUCEr8k7UPQFVJ315ELTKcPKdT6SxE8nHSvz4KI1V1aON3zzBbi8Sf6wJBeyu
         ttAf8t7cXifVhTwEXke0SjWAYOX8Mx0KINCCdv0zqXMk+nb1HvDyJc+J+abtDO1eDRsj
         5qnOvRpCHlGfj/L4s4QM6klMrgWKtYjdWWiJRHjvXA0rZwOlwfcXb1yww7tbVHFjJ1Pw
         Lk4x1WncP3hB+WNUgNbjZwVDp6hOSYlpihIWjpsHqehjJuSISE57vIXgdZjNhLVzmscm
         MejQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqtw106/vbYIMhqhaF/WHl93TA9dCxKVb6KrtXiaRKbCvHoSGNYhnibkh9BS5vXuwndjhTudSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjnSFRieolU/RiBvNCxwGLcCt4aluv8KD8McXUi5v6YzDiaRuV
	+Wayp0cw+gLCNqhQa4pT2Ficw+S02oMx0Ju52fEprku7f0OBiHwHcSow
X-Gm-Gg: AfdE7ckFYoPQgUm5xhD5hjNEKjLtOxnysNpFbUNacntaq8gcXG3jr38bJkpygotlmKb
	VJmlhH+kCbaZ6mjZeZX4rszxgDN0MckZdQPazVigM/A34oRLM1TGV3I+B9couOndJ/D+qZv3qcm
	AP4rQbA9ycC0ngPbs1LpXsFyXj3smz/zr29jYO2il/1poIeNmVsGoH+yoFDNnthuQVgukSn3tyF
	Q9wjsFkI5Q/kb02WzP8myDr0fqmkUO45LJL6X+nBi4UOhE1ZWusrXc17oIg89ggnreDB/ds7mmj
	MttFpuIIGdhry75nkJjrQBpCIk+ioFWq+V2GmDiiWH6lSv/6Qad0dsOM6lqP9w6DPe+8DJiIDDk
	6vPMdFgpo+kTjkLjzsmmZiQQPXjGngmXXiu8EirkAbO8/1Dz3yVeA1183wmkP+dOxIz8maWIpOr
	FKuCn3DJvPpX7ewmr3fNKUGQbTmFAO8zaZ7J1ceRsixWvR1IexGckCi31yvwFr0NlnUtQGU8j0p
	0iPUClWlbgjjdg=
X-Received: by 2002:a05:7300:7b94:b0:30c:71d3:dc6d with SMTP id 5a478bee46e88-30c84df6433mr6124250eec.33.1782451088145;
        Thu, 25 Jun 2026 22:18:08 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm14804188eec.20.2026.06.25.22.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:18:07 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH 02/10] Input: synaptics-rmi4 - zero report size on F54 work error
Date: Thu, 25 Jun 2026 22:17:51 -0700
Message-ID: <20260626051802.4033172-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rmi_f54_work(), if an error occurs during report request or command
verification, the code jumped directly to the 'error' label, bypassing
the 'abort' label where f54->report_size was normally zeroed out.

This left f54->report_size containing its previous successful payload
size. If a user then altered the V4L2 format to a smaller size, and a
subsequent run failed, rmi_f54_buffer_queue() would copy the stale,
larger payload size into the shrunken V4L2 buffer, causing a heap
buffer overflow.

Fix this by merging the 'abort' and 'error' labels into a single 'out'
exit path, and ensuring that f54->report_size is always set to 0 on
failure by checking for error and zeroing the local report_size first.

Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot@kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f54.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index 61909e1a39e2..8eac320c43e3 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -545,7 +545,7 @@ static void rmi_f54_work(struct work_struct *work)
 		dev_err(&fn->dev, "Bad report size, report type=%d\n",
 				f54->report_type);
 		error = -EINVAL;
-		goto error;     /* retry won't help */
+		goto out;     /* retry won't help */
 	}
 
 	/*
@@ -556,7 +556,7 @@ static void rmi_f54_work(struct work_struct *work)
 			 &command);
 	if (error) {
 		dev_err(&fn->dev, "Failed to read back command\n");
-		goto error;
+		goto out;
 	}
 	if (command & F54_GET_REPORT) {
 		if (time_after(jiffies, f54->timeout)) {
@@ -564,7 +564,7 @@ static void rmi_f54_work(struct work_struct *work)
 			error = -ETIMEDOUT;
 		}
 		report_size = 0;
-		goto error;
+		goto out;
 	}
 
 	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "Get report command completed, reading data\n");
@@ -579,7 +579,7 @@ static void rmi_f54_work(struct work_struct *work)
 					fifo, sizeof(fifo));
 		if (error) {
 			dev_err(&fn->dev, "Failed to set fifo start offset\n");
-			goto abort;
+			goto out;
 		}
 
 		error = rmi_read_block(fn->rmi_dev, fn->fd.data_base_addr +
@@ -588,16 +588,16 @@ static void rmi_f54_work(struct work_struct *work)
 		if (error) {
 			dev_err(&fn->dev, "%s: read [%d bytes] returned %d\n",
 				__func__, size, error);
-			goto abort;
+			goto out;
 		}
 	}
 
-abort:
-	f54->report_size = error ? 0 : report_size;
-error:
+out:
 	if (error)
 		report_size = 0;
 
+	f54->report_size = report_size;
+
 	if (report_size == 0 && !error) {
 		queue_delayed_work(f54->workqueue, &f54->work,
 				   msecs_to_jiffies(1));
-- 
2.55.0.rc0.799.gd6f94ed593-goog

