Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A33A984F
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 07:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786950095; cv=none; b=qmHBWOA3lguHYOfN5GxNGch3KUKIGM99wt+Ich3YmfpVwP0osv79xh+gI3qXgaKJhCW2p144b6a9vdPRsslbPT0mcxXIzrLGydqRg0JqId5QvbxPL0WI3X/FuKinS7/sX/2vIFT0LNIyQ/MKATahbo/e5/hGxVGD8IDfvAy83Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786950095; c=relaxed/simple;
	bh=6kWVZxkaJrP2alMq9sRei0KuXnZM3rimkkYv/KPNMvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uCzPQoxHFIU9d+SnIzRT48Fts7zpgZGgc/9BS1JShgyxkbJop1HQ1pH2KPmb1S/piGjt1Hh0l3sAcXSHyQ3fcHkU8lwtEd8ogzJlFjFifyvskGpsiD1ywTTr6W0BJxsZNlfucMx3CuAMtmyuU89tZvPCgi4yqu4BkypEkKk2McM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRiygVua; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRiygVua"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aeafa51b5cso341435e87.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 00:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786950091; x=1787554891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8nFik9rvis0EY9a3fH4rtoEYKyrkMbT6h34IIsACnTo=;
        b=hRiygVuaNNZpWHnxb2rx572ozj//Zv+wx09ny3d0S3fT+ag37gYAn8vBZbP8pAf4+p
         QXMZ1ZR5sRKDlOwJi41xT/jEyQdAEaL3t68iSyYF5dAbo6BMdYatPDbGCaE1HIGZ3CRp
         zADl2JhzBcU0Qiq9UMB1rZj/SmtN6uXBHH+SwcibvWYVu3MsRqXV3U9h1FDASlB0aUfS
         o6WGY6DXW/JuzDeX1vGC9VycoXhxKEslpA5Jio7bXxl7b0y55wHYUqvMQ6BJRzBUczXB
         bv6UxYXFakSPF0dz8PyuRjf25W/Y5B5E04psG8ajqk2aahHp+BYdmhAjcTdijBkD0cOt
         3Swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786950091; x=1787554891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8nFik9rvis0EY9a3fH4rtoEYKyrkMbT6h34IIsACnTo=;
        b=Q2+y+cgABcMKVAgNXOxPLbYI1gbwEp7xy81Me1RZnJ/NtdyW93Opc8dMkT8BY+OZPh
         CJV8bGap2XyAk8eiJCL34mT3AzLII8wF7bwPJO59Z7IJYMFPykX7HvoQ5RrgSgk0MeXP
         7Hfxdks0MWpxkTUYDLqiMtdkz28u1FVdxF+6rqSBUK1ondprspHko/Kd7jIc4plDanfZ
         pSbu8iuoPP94VDCcy7Kla3TbVXAmjl268lHAKyryh4FCeA5h1kxttMolNCCg82O9rbkD
         bordxxaA038S7UGFIBVqMQutgT6ptE61lpodI9VBy+EZf6oZkFE/jSqI8oBcG0PePVL/
         oVEg==
X-Gm-Message-State: AOJu0Yyho1gcjMLBkjgvLfMcsSVWV6HbU+AY6C/WvnrYZrZPMKX2uGrD
	7tbpgoOc/J7G9r9tA4AzIMo5A0UhyNoXk637OKKBqDAlztQxT1xLt/UgSif5DSzOciY=
X-Gm-Gg: AR+sD12kStSTZ3PNeclbNiBsFaZbg4fX7d2LFgKyPwplFn6k6hd3C+fJqTFb4TER0Ac
	vaM9QoIgpfIXdPOgpTW/ggRbemuzZlDwoeZ+Tvl2yjwrFdge4SAio5/BPMqQbf/fUaRWjHPemAW
	HSjqlrOHaFE5eg7nWB9bi/+AfgsjFijUbgLAc4Ixcz4iVkpvFl+4lX6Bcak4H3Seb9udP0YRZUK
	q0BN13S/tJHnShzphqds6U185Fna9kfCZd9G3D+ZlOus1C58avoX425wE6tMXZ+9oi8HeMtQNLY
	+C5fFoHTllHQ1zxbO8jGFpyymPH8QJT0VtMEgypIs7VrJsJzXw2np1eG2jRu4syQa+cGqQkEMBd
	jh8lfzEzcmLNq5rWCwrMF0hZOsCUejBdKrZWCP/dYarEVanXSOIWqgKwrs8WeAWnLzF4KlTeCqS
	Y19jktSRlfnNhau+OOqLXn57aYnmxt2Z4ZsIcJ6S/GetyHjykFv/BheEYyN3PI1mGMl0eI9O+Gm
	BU=
X-Received: by 2002:a05:6512:63d2:10b0:5b4:59a3:c67 with SMTP id 2adb3069b0e04-5b459a30ec9mr1732291e87.3.1786950089145;
        Mon, 17 Aug 2026 00:01:29 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46cfa87f8sm141201e87.33.2026.08.17.00.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 00:01:27 -0700 (PDT)
From: Dmitriy Okunev <dokunevdmitriy@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	lvc-project@linuxtesting.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Kees Cook <kees@kernel.org>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	Daniel Kim <dekim@broadcom.com>,
	Franky Lin <frankyl@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Hante Meuleman <meuleman@broadcom.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10/5.15/6.1] wifi: brcmfmac: initialize SDIO data work before cleanup
Date: Mon, 17 Aug 2026 10:01:12 +0300
Message-ID: <20260817070112.4828-1-dokunevdmitriy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

commit 2a665946e0407a05a3f81bd56a08553c446498e0 upstream.

brcmf_sdio_probe() stores the newly allocated bus in sdiodev->bus before
allocating the ordered workqueue. If that allocation fails, the function
jumps to fail and calls brcmf_sdio_remove().

brcmf_sdio_remove() unconditionally cancels bus->datawork. Initialize the
work item before the first failure path that can reach brcmf_sdio_remove(),
so the cleanup path always observes a valid work object.

This issue was found by our static analysis tool and then confirmed by
manual review of the probe error path and the remove-time work drain. The
problem pattern is an early setup failure that reaches a cleanup helper
which cancels an embedded work item before its initializer has run.

A QEMU PoC forced alloc_ordered_workqueue() to fail at the same point in
brcmf_sdio_probe(), before INIT_WORK(&bus->datawork) is reached. The
resulting fail path calls brcmf_sdio_remove(), and DEBUG_OBJECTS reports
the invalid work drain with brcmf_sdio_probe() and brcmf_sdio_remove() in
the stack.

Fixes: 9982464379e8 ("brcmfmac: make sdio suspend wait for threads to freeze")
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Link: https://patch.msgid.link/20260619064401.1048976-1-runyu.xiao@seu.edu.cn
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Dmitriy Okunev <dokunevdmitriy@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 6ac2132c3064..5338d93e5b22 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4438,6 +4438,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	bus->sdiodev = sdiodev;
 	sdiodev->bus = bus;
 	skb_queue_head_init(&bus->glom);
+	INIT_WORK(&bus->datawork, brcmf_sdio_dataworker);
 	bus->txbound = BRCMF_TXBOUND;
 	bus->rxbound = BRCMF_RXBOUND;
 	bus->txminmax = BRCMF_TXMINMAX;
@@ -4451,7 +4452,6 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 		goto fail;
 	}
 	brcmf_sdiod_freezer_count(sdiodev);
-	INIT_WORK(&bus->datawork, brcmf_sdio_dataworker);
 	bus->brcmf_wq = wq;
 
 	/* attempt to attach to the dongle */
-- 
2.53.0

