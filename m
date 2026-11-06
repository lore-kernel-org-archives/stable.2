Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979529;
	b=fSyQuy3SbBOOqPhlukmSWjNjbE+8bb/tA3gUTfv7vQSXOP2K7uNpUpmTjJH/Q4pTiCS3
	 ui+4yckVANl2qjt3v8jwZrVSGpw4HtSA9pAe6nK7Hh7cPSeGBO9FbVgXhgiXF8lWrOhle
	 EmAf/CNWzgUQuPF44CmqOGO6VJv3gO9wMq3JcuwUBFPxiLwrztXC8KeMAW3+oQPbRRS8+
	 +wA6Dpfte8SqtTCdQvAnIT4VEFsSxBkdj0SyEGFdrRisaIBAmwfXhwmnHfhfX0S350fZ+
	 +Xkh3hTYnsp4PuLfjeE7FpfxXwMH8t5V+Yl2FEALlKndarGQyVCOz0QJvqUsBCqUJvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qAsxFteOOkjn85+iiSYU4HCwymsUrf5TgwAhY4i0RPc=;
	b=nIH7OzejgRV4ihHqtp74nZ8XKPkeZAlO565OiQbVPLMHrm6RZae1dg+5AFrtYavALB+m
	 pVXrcYLtVFi0JRDWR6dmo15S5ftj74TPbB1rcUWk9E7evSYk7N4UvcI9oaPnUJ/ND7gR1
	 vUpxp+0Ioj6Fl41miNq+tIjjTsGhZDk5vSwnATtRz+I9S1/Y8GhX/uUS0i874l8rvgGrp
	 86oAc8KBXH5nyfwMam7/rxG2dZfPvZ8yUmDFBqeNgeglYA9AIsb9Cu2oDqi4ev0yY9sqt
	 E0BjR/i5+5r7l9dKMSJuaUj9ytwylegJKrY3NIkAlsKQqXnDzNslDNJBOHVyk3m971g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dJAJQYE1;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6216E606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6216E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dJAJQYE1
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso434882a91.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 07:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793979528; x=1794584328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qAsxFteOOkjn85+iiSYU4HCwymsUrf5TgwAhY4i0RPc=;
        b=dJAJQYE1w/j77c18sxLOlo+mr1HuEXlS37uqbWjJ4X/5lm97x75Vp+apbxqyhKE+Fn
         HWTJcV1wWbDg5zUaT5jhN8RLS3k6SY9lJX5jXuG9wWu+dB9lWbchMLk6X6vnoBTqWw3s
         pV1RRNRbPPvXt40PH1AIzIM8v4w5Me3sSeOn3O6aAE1+sP7AnnZam8Vyuj0MZ1TKiWij
         pFwvVGrnmK/BCISZfmfpAa/tKPjMkdNwTZ0V9h0795WuYHlTlfZ1/VmoW2x83SisKvVT
         LACJSAj484px3o9i8slantTN37v6/QJsYLYkZAwN/uv/GL41bimO30PxYXrM91Vr43Pf
         HjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793979528; x=1794584328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qAsxFteOOkjn85+iiSYU4HCwymsUrf5TgwAhY4i0RPc=;
        b=B2TDaQ/IWFpaUo+SPQqUC57mQq+N+u8ruUf2rBQBTergmgrplq6+y2+gKtGnArzzTV
         7brByJr3tY5Ji6pw5Qur4Q5bdQFbgaEgQOAZBm5mZTIIgzOi9ZPdK1qJtYFcQC0lZ9Rl
         c99hM6GldxiQS+F9X6urJtcNBHS4FjRFoaWKEtS5Uu4P6cw+m740GYzDc7HXGC9Cv0tz
         8zeeaR9Q/39U2PXYQNTxaUjBRicLihv42YNMbb8FlILVnS7sqkfdX7jGYxmW/zAumCqI
         Fz1OfjWhXJLJbkU62Q3cPlsv0FercUs+PbEl3B+5uibVuqzD6fPH9Ivca0+RjtTO8vw3
         0hqg==
X-Forwarded-Encrypted: i=1; AL+hErHdY4GmzsTe5X/O006E/HGOerCR9W7XW++6X8bXBJj28nXq4Hpqb6wXgAR2al74U8Ey0l6CWFw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DG3l1wgHOJSTR62u+h61o46ap6cTxxKSN9lofSjZc/aXnUVr4
	9wFD93QLbWDZqnm7TzI7WgnzwlCQK5+roBKqBNCcM3zDQ/RDoU0Gzgt/QFf/ykde
X-Gm-Gg: AYBFou1Da6r3V64XVXKQj2r2oSNsnov5FO+hZiUQ1dlp27/CoAmNk2juP+EYMnii3Sy
	XGCnjXlhu/ktQU8z9kOR6KYw2+kP+0JUeusF0u0PvAsiPVJz2j4MRMvzq84SDGb8HmmZAvERnl5
	BQ8kEJJTgqssgueMixnGkWbC3QrqRNIpYzmOq0yduC58sHMUCInSY1OYjnF8qMB7ge+RpWohdGg
	YZoIZfY6xZW8qCs6v8iX45XNWH03F9TVrPeZFMh9JYTPgdW8vxFrKVR9qXQAEPd43g0I27QhNMl
	4rOW7YoOKcUhV09lAnIp5xqF2kdmNOBP/7hmFMkySOZSzw9Wl1vasS+pa25o8gKvyaMFxCMgJfS
	QtDC/bnve3O3JsL1hjaoeBbowVWvWbuA6JOxJUPSkVd8qw+20D3tLdl/AhGriT+H5Q77xc9wTX+
	QM9suJYAXpOC2ZFhLX0tyBRTZdzWExa3hVu1zsd/tJVLQkmio/jLFuQk607iKtpVxCHe5BRm7Gj
	U6ehx8bAM5X08aICpeWHRrdMtGSyL4AOtZbTr1GlRE9JQbsrkstQ5vQVdtsdQUDdjj08inBKhBe
	+q8GolaOTFYxmMcjI6dpb7n1tlnZoT2iAAOmAbbVvg38SG2w
X-Received: by 2002:a17:90b:388d:b0:3a7:9adb:2a0d with SMTP id 98e67ed59e1d1-3b0db13e119mr2605368a91.0.1793979527519;
        Fri, 06 Nov 2026 07:38:47 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32b2b57sm9067695a91.15.2026.11.06.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:38:47 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: cx23885: altera-ci: drain CI status work before free
Date: Sat,  7 Nov 2026 00:38:31 +0900
Message-ID: <20261106153831.2736659-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunjung Ko <hj351016@gmail.com>

altera_ci_irq() schedules inter->work (netup_read_ci_status) from the
cx23885 interrupt path, but nothing cancels it on teardown. The worker
netup_read_ci_status() obtains the fpga_internal via container_of() and
takes inter->fpga_mutex, so it must not outlive that structure.

On device removal cx23885_finidev() calls free_irq() and then drains only
its own works (cx25840_work, ir_rx_work, ir_tx_work) before unregistering
the device, which reaches altera_ci_release(). free_irq() waits for the
interrupt handler to finish but does not cancel a work the handler has
already scheduled, and inter->work is not among the drained works.
altera_ci_release() then frees the fpga_internal via
kfree(state->internal).

If the CI interrupt fires shortly before free_irq(), inter->work is left
queued on the system workqueue and runs after the fpga_internal has been
freed, so netup_read_ci_status() dereferences freed memory and operates on
inter->fpga_mutex in a freed structure (use-after-free).

Drain the work with cancel_work_sync() before freeing the fpga_internal, in
the final-release branch where it is about to be freed. altera_ci_release()
does not hold inter->fpga_mutex, so the drain cannot deadlock against the
handler.

The sibling NetUP CI driver cimax2.c has an identically-named
netup_read_ci_status() work and had the same use-after-free fixed in commit
4e143d662ca9 ("media: cx23885: cancel NetUP CI work before teardown");
altera-ci.c has the same pattern but was not covered by that change.

Found by static analysis and code review; not runtime-reproduced (needs a
NetUP CI card on cx23885 hardware and an interrupt racing device removal).

Fixes: 349bcf02e361 ("[media] Altera FPGA based CI driver module")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/media/pci/cx23885/altera-ci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/pci/cx23885/altera-ci.c b/drivers/media/pci/cx23885/altera-ci.c
index 20a3b6c..94930e2 100644
--- a/drivers/media/pci/cx23885/altera-ci.c
+++ b/drivers/media/pci/cx23885/altera-ci.c
@@ -496,6 +496,7 @@ void altera_ci_release(void *dev, int ci_nr)
 
 			ci_dbg_print("%s: Actually removing\n", __func__);
 
+			cancel_work_sync(&temp_int->internal->work);
 			remove_inode(temp_int->internal);
 			kfree(state->internal);
 		}
-- 
2.43.0

