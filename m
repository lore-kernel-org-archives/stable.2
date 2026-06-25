Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A670923BD1B;
	Thu, 25 Jun 2026 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402724; cv=none; b=GAG37CElHKB+kmLiSgyOFMy7KHJSoy49U3bo5uPjsNhW2qt7l66A9Hc7UFIhy6Xpig2E6P4MvFfREOCYwOkgzaqtlKej9yICTV3DH4D+clvf5OTBhf9AvthZ/3CLtzGW7SvwBZhN0yc2Pb/MjGWlQKICtCNQYf/sNqQj9qRI+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402724; c=relaxed/simple;
	bh=IC6Q6MTRSyXrG3hxFjc6o6YbwEReB2tXb5S0XSApuPY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n7ptaScpkbY+ZPb92pWug8nhdK6/hAZElvN7tyXSaIckgrRamFhWJiLiAwf0FKIqI84bhD9Ac6dbJTC6edTXQxzNZqByAMV3dE2K8v7G6is82EnfqEikhpgE5AZb+9Syfnm+9PQbnazAV0scsPzpNtvqI+qn4DQvZ96F7UbtURM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowABXrtGXTj1qke88FQ--.13788S2;
	Thu, 25 Jun 2026 23:51:53 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] btintel_pcie: Clear hdev pointer in error path of btintel_pcie_setup_hdev
Date: Thu, 25 Jun 2026 23:51:49 +0800
Message-Id: <20260625155149.79838-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXrtGXTj1qke88FQ--.13788S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw45Xry7XFy3Wr1kArW7twb_yoWkArX_ur
	yrAr97XFyUJF13tF17ArW5ZF15CrySgF4vqFnFgrW3G3s3Xr1v9asF9r90q3Z3GrW5tr9a
	y3WUXr18Jr13GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8miiUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgJA2o9Q+oWyQAAsv

In btintel_pcie_setup_hdev(), if hci_register_dev() fails, the
function frees the hci_dev via hci_free_dev() but leaves
data->hdev as a dangling pointer. If a subsequent error handler in
the probe function accesses data->hdev, it would result in a
use-after-free.

Although the current probe error path (btintel_pcie_reset_bt) does
not access data->hdev, setting it to NULL after freeing is a
defensive fix that prevents potential future bugs.

Cc: stable@vger.kernel.org
Fixes: 6e65a09f9275 ("Bluetooth: btintel_pcie: Add *setup* function to download firmware")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/bluetooth/btintel_pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 37e050763633..56d24467b7d5 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2478,6 +2478,7 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 
 exit_error:
 	hci_free_dev(hdev);
+	data->hdev = NULL;
 	return err;
 }
 
-- 
2.39.5 (Apple Git-154)

