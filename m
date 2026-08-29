Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A3B2D12ED
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787997302; cv=none; b=OodcVMoBxI6OKyDML+RzdrdWYk5hxcNHGkk3B4kNjgtnLmN9R/B72h8JavIz5R0wUuseuITas/ahcIFdu7WhZ7K5HjR51gqCjJvvVQuNo+2IOAd/mVqQPGJht/CzvZcVXp/MEfADh9rpVU2t3KpAJaOwMxDzZP2A0+aWceUmGNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787997302; c=relaxed/simple;
	bh=tGg7OnyL8/9JmC2shM+2pm7rQpu1dy5h3ZLrB4k//cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdoyKkb8xaebRnoAm0ufE814cjXGRYJ+3ihgvAYPr6B91U9YxbBzHWDT4K52k76oLA4jClYLG+n13btVxDp4Hq9PzCQhcL5scuHZGYVWyyjCcPF0E6bFZJpGQ3mm8QFveDXzqUHU7f7XwSvpllEvqp24ZctYdTgN7gLe8+To/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTB0P2os; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTB0P2os"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d70066b704so1579115ad.2
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 02:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787997301; x=1788602101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r+XYc/uhp00twA6hJyfMPfZH8ZjPnbMc9r1vC8WbHMM=;
        b=kTB0P2osEwYH7u+U9W9rnjkE1jsj5xpqGXD7R6EJLXyvjV/gtzAYRTjZ+irtalDgeD
         gM2X+o+6/cLbTPaHr9Ybfleyqge4eTX8tqwAQv7PEMbwAf6zb1dZ+PHk+TEVuFKR9uT6
         AL5YvsdNoqHH+kHXanuZEqeKCoC5FQEOI+gtD1e7UVIzXBW/kLWYamBHVq/F4CTGNLjZ
         qlYXKh+4lpvXUeCPYQpe0NR8nZdiGyl3tOeivAJkXz5gBZVI7RKxX3kNeT618UXtLaWC
         C4eARuRrFyMuhGkqMzcp3U5Ylzt/BQj54CX4bVsmkvbrGa32LAdzVBHLsH4CJrNzVmbu
         VOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787997301; x=1788602101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r+XYc/uhp00twA6hJyfMPfZH8ZjPnbMc9r1vC8WbHMM=;
        b=C4SvVFVN/5Zbsxx6WToENMGziZrKt60UzGprZ8pzSNMzzSe7WotkhqLWsyQvCO6siQ
         0/nG9/q8aEb3QtjIewfvsJ5khk9vyf8R2O7tXm0muySVlaOeaK/qSLDE1c0ey3LQ6/Nn
         TvNGTDEvzQO0YpSGbPViS4Uss6bVVYoebL5cMTuoh3BQ/YP3lOOjMAeQTza/PXQtL1gi
         AbL5+Mv8UJ0z35iU+wukqiwv8Y6pmRxbUmiBqovsYs8DY3cv45SbWyBiTQ48TgtvTa60
         obBX+GBci65/XScP0PVWDlQf9iZ6dnM7Mt62hDK0IBPf80meo/WdKKBOCcsXZ8jJPZkI
         fljw==
X-Forwarded-Encrypted: i=1; AKwUvByBDJ97l+zVce5dnKch+XVNX6Aa33otZmiE38iV8jBUtDcWTp390vcEsCqkt3EagNOsVoHGKa4=@vger.kernel.org
X-Gm-Message-State: AFuF++l863tvvSWgnp2troPpOANl+Ur4DeR/m+MhzmxBoGZEG9qnSyw+
	T3jWhwF1h1//RP+Z/3nYkSgo+9nWwk+ZLalTLStlXu7atQFxrxsv3OGF
X-Gm-Gg: AYBFou08I9ack9hyfTLoR7+IKJVH+UlmVyb9UlHPgBdmuc3fsJhg8K9Q8iVPkxTnLy4
	MxFCmaDRM8AnySSdy4ZDoByPMGQkbp+LUcllAbVAgC8eGj8hh+wZasIMCYPbtC0zLX3Prg74nJv
	HUCxtQvrST+fJFY+gmeCNDBaZkOLoJlw4QOXMlvKB8/6tEHwY8WeJ0rhJce2uH3i2Ke0JCqDATJ
	roko3icQhHKYoIWZq1hatUs5U73TWZxN+a4ZF/pq9aLim29DGzupwTLqwhPdC30WXtbcPT/wtJK
	oiU824ceGgaaX+CFLs0S5lnjfX6zsxjvvPU3AHXHLb1lqly9r2HnA9si+4KnczAAxD/fRlT6E9f
	Orj+25VHRpDZ7ijtU+gSC7n57a8+Gkj4hU2mGwBmvFD2HvJ4BGQf3AuaJPj3S54iej4e9gCiX3r
	J8RoL0+bZOYNTjtwAD+PqUjYjZyh4JiYWn6VJa/FuJd1xyqOowZs4NJIiL5tq5VaCL+rAVq0zOV
	9CCh2dGsdqyZ9692gS20LwuyYzX1l7Vbnk=
X-Received: by 2002:a17:903:228a:b0:2cb:2b50:d9da with SMTP id d9443c01a7336-2d74df53523mr116538065ad.3.1787997301027;
        Sat, 29 Aug 2026 02:55:01 -0700 (PDT)
Received: from cachyos-aura ([2409:40f2:3104:d691:c7eb:3b03:2c8d:127f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f783c37sm15775697eec.6.2026.08.29.02.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 02:55:00 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: miriam.rachel.korenblit@intel.com,
	linux-wireless@vger.kernel.org
Cc: nika@nikableh.moe,
	emmanuel.grumbach@intel.com,
	helgaas@kernel.org,
	markpearson@lenovo.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Navon John Lukose <navonjohnlukose@gmail.com>
Subject: [PATCH wireless 2/2] wifi: iwlwifi: pcie: request a product reset when the device is gone after resume
Date: Sat, 29 Aug 2026 15:24:37 +0530
Message-ID: <20260829095437.44716-3-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829095437.44716-1-navonjohnlukose@gmail.com>
References: <20260829095437.44716-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On platforms where D3cold removes the WiFi module's power rail, the
device can come back from suspend completely absent from the bus: config
space reads 0xffffffff and the downstream link never trains.
_iwl_pci_resume() currently notices only a subset of this (scratch ==
~0U, and only when the device was enabled), then "hopes for the best" by
re-initialising over PCI, which cannot work - the hardware is not there.
The result is several seconds of handshake timeouts and a bogus
ADVANCED_SYSASSERT dump before giving up, and the device stays gone
until reboot.

Check whether the device answers config cycles at all, and if not ask
for a product reset, which power-cycles the module and re-enumerates it.

The check is deliberately placed before the STATUS_DEVICE_ENABLED block:
that block is skipped entirely when the device was idle or down at
suspend time, which is a common case (e.g. the radio was switched off)
and one where the device is just as dead.

Fixes: 9673c35486d4 ("wifi: iwlwifi: implement product reset for TOP errors")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221695
Cc: stable@vger.kernel.org
Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
---
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1232,6 +1232,18 @@
 	if (!trans->op_mode)
 		return 0;
 
+	/* Not answering config cycles: it fell off the bus and will not come
+	 * back from a PCI-level re-init. Deliberately checked before the
+	 * STATUS_DEVICE_ENABLED block below, which is skipped entirely if the
+	 * device was idle or down when we suspended.
+	 */
+	if (!pci_device_is_present(pdev)) {
+		IWL_ERR(trans,
+			"device is not on the bus after resume, requesting product reset\n");
+		iwl_trans_pcie_reset(trans, IWL_RESET_MODE_PROD_RESET);
+		return 0;
+	}
+
 	if (test_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
 		/*
 		 * Scratch value was altered, this means the device was powered
