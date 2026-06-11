Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B84189B84;
	Thu, 11 Jun 2026 00:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781139214; cv=none; b=bD0Gv6e3zO/b8hU8Phrh2dnrx/869X58Yz2xp9i9C2QiecP1j12FEF4b4DSLm7gXe/wG5m7+CE9+g8J6KVMKh/o6676Wet1foOHJETVcIix1v4DnC3D9VGeqqlv/JIYJHmNy5TCMdZfxn1l9AmoVMlI6NyzNrcZCqCzXWSxyxeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781139214; c=relaxed/simple;
	bh=dGQdlwbgsdkIxpBZitrio/lsX3jJhO449XatFFL3Ajk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jQvz4fJOdnHd88GBCav3jbgR3wPKLH9YSA4XMfLycIMLs6S5H9tn58S620CSvQXu4H/Hr/6XRKy2Oc9x8UogJVJP2FCgF8snNrl6rk7Ldu/QPN5uDFjjHSifKgbh6faBv5lG481thcsd/T88FsQbZkRlgoosBZs2Tw35WRhSZ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-03 (Coremail) with SMTP id rQCowACHp94EBypq43hSFA--.3604S2;
	Thu, 11 Jun 2026 08:53:26 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] power: supply: charger-manager: fix refcount leak in is_full_charged()
Date: Thu, 11 Jun 2026 08:53:21 +0800
Message-ID: <20260611005322.53096-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACHp94EBypq43hSFA--.3604S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1fZryfCr48GF43WFWfZrb_yoW8JFy3pF
	ZYkr9rC345XrW5t3WDJw1jkFyrKa9avry5CF1kG34Svr13Wws8t34UGF15tr18tF1fAF4Y
	qFW3tw17tFnxCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjuHq7
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoPA2op-r4W1AAAsA

In is_full_charged(), power_supply_get_by_name() is called to
obtain a reference to the fuel_gauge power supply. If the
voltage check (uV >= desc->fullbatt_uV) succeeds, the function
returns true directly without releasing the reference, leaking
the refcount.

Fix this by setting a flag and jumping to the out label where
power_supply_put() properly drops the reference.

Cc: stable@vger.kernel.org
Fixes: e132fc6bb89b ("power: supply: charger-manager: Make decisions focussed on battery status")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/power/supply/charger-manager.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index c49e0e4d02f7..c3644018b6bb 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -303,8 +303,10 @@ static bool is_full_charged(struct charger_manager *cm)
 			if (cm->battery_status == POWER_SUPPLY_STATUS_FULL
 					&& desc->fullbatt_vchkdrop_uV)
 				uV += desc->fullbatt_vchkdrop_uV;
-			if (uV >= desc->fullbatt_uV)
-				return true;
+			if (uV >= desc->fullbatt_uV) {
+				is_full = true;
+				goto out;
+			}
 		}
 	}
 
-- 
2.50.1 (Apple Git-155)

