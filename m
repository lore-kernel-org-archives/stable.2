Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D53439008
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608372; cv=none; b=eciQOlE62rbFhfR2IJXxqdsxJUXka1jWz3W4xwHfPJ3HHHKBxMhU1rnrnaOI5BPrS5hJY1zBnHnB4uMOt1z/5AhtMabNgCm7JM/trKLqukbbEYULBFHaA5vcDSZhMbMsoR6hph0XO40hsTd9Er+KMmB/Ju3f6Q/q6QvMqz1NSHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608372; c=relaxed/simple;
	bh=wPk0jvbiLk1gnxWCbBjPWoSYq2XDqp+9aHn95n8KQik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiem/p14NxgXa3yLoD4U+uVSH84K6OXvGWI180spqjpcovz1m8x9G1uX9ifl3eNuIQIvZcyXfCzOcofwXFVv/VLaNxJiTH220q8Nyx32s//83kj37Uh3AEi1mQIr5DfSYKHeQie/j/6zZavoduC3dVX1OYRHnvk2Dt3tVXMoHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CRHOB04C; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CRHOB04C"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8424b6792efso1827246b3a.3
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 04:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781608370; x=1782213170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=on8hqRmuM/Ky2/WGRUWRuZiJutnnNXtBaovb+8l2mm4=;
        b=CRHOB04CMAZ0FIHIqixvSm16DquGUwE/M4wDyyNgza76pSO4guxxOV+WlTwUn+BGvF
         pO/NfJIF01xfUe3D9mQkmPcKMwZ/vxbz0p33+IO4Qylb7edf6YC0YYZXw0CcwiBUqNPo
         h/VfSc3kjXUQyxOkE4vNELxYWcQKSi/7oQcg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781608370; x=1782213170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=on8hqRmuM/Ky2/WGRUWRuZiJutnnNXtBaovb+8l2mm4=;
        b=ipN9/UhSzrrjzBRi7pF7EpNigbTYXQyzGlkP9358/gigbDJSX6F1D4qg/FMIjIlR82
         adTjF+XqFbhHTJ0qCQjZIzvP//1lKmNp+wCLHKXwWRWvySd8hWGRhe9PC8RsQ3mDtdct
         wEe7DgML7a3Ai/yxvkHFCSrlJM4sghd3TCVm+sRUoaSY2iOcr33DtsNJNnOGvmrphkgn
         xg49uzYFFRqC5NYdSmoey2bYuzkcJlHl7elb+3nAGyjN2Zo8fQOQetquU5ZYss+E0aFz
         IwEwAWANoj/6D/uhGkLU0gtop1xSs0fj150lVBHObyE6duCIOJDqYjCiukSQyTOfET/t
         JCwg==
X-Forwarded-Encrypted: i=1; AFNElJ+zFVZFnNTd9G9BRgIZVQvV1fmPIUfmRQJWihVV4PXnlYrY412yvHLKW615ou5kLBSlJOflL4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgbEVh1lgaPvT6TBsstKMvCVwzhJnwVjI18HCRPn1gRkLgr3lc
	MgEhx3wEO2UHpvEAnSuCA2clkOqQn4LnFMQKQj5t/g3saTjhnbPtiqnDwjc/nhA/Eg==
X-Gm-Gg: Acq92OE+43zFE1Cp5sS3T3DdwMD69R/gQtSDX2Pa6DHMzQX7zlnqyzy9UxMsrlYH877
	FeKXv1j0Lq5anyhpzAUxVA9sLL2tviibGYubeyHXaAWlZig+2mDfNlhW/+CYNb55yR3dY472PCS
	loXVwyM4f9SpRxDj5v8HTij04dkJgzxqa2M/mPoIRUaTQvX3X11sVpN5bDyd0PowyHipNeDNMyH
	fpHobXv+XSuFmhVpFX5XDx1Ly1RUbPbAhTwiPhUccU315UyKCDYeSNS17vlMACnEP40YTxad/wg
	ufk6cU8ZADmBDQX5h+eIKNBdq4u1Oc3JPxyxORWK6ORsw/WvDDwaKAc8SIXa8HgJ58o0C7fBmD9
	lh6wW0DLNlRQOnpueeDoS1jHcGCe289T6ErczkdZI8tLsYnZYAFi8pC1fP67XwGpNzTvgiNgouz
	+nhjlz3qvUFbox7uXManxAEvIuHLBCpc5RugLzZ3NwLGXon06guD72kTabuAG1lOOgBdD3c3TNj
	XWMWdLp1AlD
X-Received: by 2002:a05:6a00:9285:b0:82f:abc8:ae0 with SMTP id d2e1a72fcca58-844e19879d5mr16162588b3a.17.1781608370193;
        Tue, 16 Jun 2026 04:12:50 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:a0b:fabb:5b62:b85b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05921bsm12906321b3a.59.2026.06.16.04.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:12:49 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mark-yw Chen <mark-yw.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: Tomasz Figa <tfiga@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: btmtksdio: correct btmtksdio_txrx_work() loop timeout check
Date: Tue, 16 Jun 2026 20:12:06 +0900
Message-ID: <20260616111224.152140-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616111224.152140-1-senozhatsky@chromium.org>
References: <20260616111224.152140-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The btmtksdio_txrx_work() loop is expected to be terminated if running
for longer than 5*HZ.  However the timeout check is reversed:
time_is_before_jiffies(old_jiffies + 5*HZ) evaluates to true when
old_jiffies + 5*HZ is in the past i.e. when a timeout has occurred.
Using OR with time_is_before_jiffies(txrx_timeout) means that:
- before the 5-second timeout: the condition is `int_status || false`,
  so it loops as long as there are pending interrupts.
- after the 5-second timeout: the condition becomes `int_status || true`,
  which is always true.

Fix loop termination condition to actually enforce a 5*HZ timeout.

Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt service to work")
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/bluetooth/btmtksdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 5b0fab7b89b5..c6f80c419e90 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -620,7 +620,7 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 			if (btmtksdio_rx_packet(bdev, rx_size) < 0)
 				bdev->hdev->stat.err_rx++;
 		}
-	} while (int_status || time_is_before_jiffies(txrx_timeout));
+	} while (int_status && time_is_after_jiffies(txrx_timeout));
 
 	/* Enable interrupt */
 	if (bdev->func->irq_handler)
-- 
2.54.0.1136.gdb2ca164c4-goog

