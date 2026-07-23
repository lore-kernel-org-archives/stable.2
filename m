Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BD946EF86;
	Thu, 23 Jul 2026 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806192; cv=none; b=eVm3vWDrH9XjIuMzIXovQeHoc4yzlWfzCSVPX/hOSmlCa2tqkRMn/mTbha6s/kT6e3hcO3Pl31Rvo5MvCwh18XlfM8F5vR5JFz75eRujbJ4nzBTzqwSwOJk01D4uWnyu/c1a9CBhiOyEYMy1hqWN3sHMoIGPczMeQdZjsMoDAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806192; c=relaxed/simple;
	bh=8eqZOBUfkQDlwy8RZHnDajm0pNDJeoHzBlpiFPExPpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nkYspod/Rst2SDVkgJhYfH1MJFaF7EVjDSoHehTMFpugLc9oci+XrxfhhLpfr46Tbk3o09fB3xu5wM7abnpVwhHmwolAoT/c0/C9vxi7lPc07Kg7kjlOmQtryr46U6zSJm294wzOQe4djN6b/1DrXXgEK6s0eMRBxQLs5Q3EsnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wAX8jYh+2FqltUxAA--.58151S3;
	Thu, 23 Jul 2026 19:29:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgBn2c4h+2Fq+sAjAw--.62939S3;
	Thu, 23 Jul 2026 19:29:37 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH 2/2] mmc: via-sdmmc: cancel card-detect work on remove
Date: Thu, 23 Jul 2026 11:28:42 +0000
Message-Id: <20260723112842.3592137-2-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723112842.3592137-1-fanwu01@zju.edu.cn>
References: <20260723112842.3592137-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBn2c4h+2Fq+sAjAw--.62939S3
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?xcZE3QXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI2ttbJyx2JOSL4dsDqYeJ1lPNXtp7qzk+5MaElx+9JEc28B
	47UJV8JEwKdn63LDaDcnaKepICEmVsObHDpBBsjd
X-Coremail-Antispam: 1Uk129KBj93XoW7AFyDKryUtF4DuF4fGw45urX_yoW8Wryxpr
	W5Ga9FkrWDAa1ak3y3Ww17uFyrAw1ftrW3KrW8GwsrXryfZFy5Zrn29a4xtF17JFykXFsx
	AF47ZF15Za43CabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU2VWlDUUUU

Disabling the device interrupt and freeing the IRQ prevents new card-detect
work from being queued, but carddet_work already queued by the handler can
still run after via_sd_remove() returns. via_sdc_card_detect() recovers the
host through container_of() and dereferences its MMIO base; once remove()
returns the host can be freed, so that work would touch freed memory.

Cancel carddet_work after freeing the IRQ and before cancelling
finish_bh_work, which the card-detect handler can also queue. carddet_work
can re-enable the interrupt through via_reset_pcictrl(); mask it again
afterwards.

This issue was found by an in-house static analysis tool and confirmed by
manual code review.

Fixes: f0bf7f61b840 ("mmc: Add new via-sdmmc host controller driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/mmc/host/via-sdmmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index 5228a1fe0495..cf7b74835aa3 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1206,6 +1206,10 @@ static void via_sd_remove(struct pci_dev *pcidev)
 
 	free_irq(pcidev->irq, sdhost);
 
+	cancel_work_sync(&sdhost->carddet_work);
+	/* carddet_work may re-enable the interrupt via via_reset_pcictrl(). */
+	writeb(0x0, sdhost->pcictrl_mmiobase + VIA_CRDR_PCIINTCTRL);
+
 	timer_delete_sync(&sdhost->timer);
 
 	cancel_work_sync(&sdhost->finish_bh_work);
-- 
2.34.1

