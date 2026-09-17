Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57A649C4D3;
	Thu, 17 Sep 2026 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646708; cv=none; b=M0cBGspIHQaCQVoCS74jKUdJH4/WBWCSGdIs4UF61BYdiB9oLWazWS8qu0LlTh0ah/I9yAq3l1UuRErXaYErh3f8b4R4cORH+kyv5Nn7EZ1n6Zf1f49l8zCb5oWjEwVffK2vHwpSPyikwjqoK0+7Iee+4MNagdxDIi4F2+ulYn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646708; c=relaxed/simple;
	bh=f6dEYUg3qwnuiNz8knI4frPeCoas5Lo7cFmz+uMmNZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W/0ViLk3a1VZG3aYxf2fD1OCd1iX1Hmco9uzzXptUBQQ/9WzET2rvvkJ5ByCsEIlkMuvBsXgUgk+JM7xRPXHM+wWxw1+ZE2FMUKNt78HC8bgiP9JTk4c1rfv+gAbo0O4j6O9nlNAQpDfrDjziYJSv2tG9oxLa6D38soAB/oe/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAXgDpb16tqDiSACA--.8S2;
	Thu, 17 Sep 2026 20:04:44 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: ath12k@lists.infradead.org
Cc: jjohnson@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	quic_rajkbhag@quicinc.com,
	quic_ssreeela@quicinc.com,
	vasanthakumar.thiagarajan@oss.qualcomm.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ath12k: Fix rproc reference leak when configuring rproc IRQs
Date: Thu, 17 Sep 2026 12:04:43 +0000
Message-Id: <20260917120443.2150370-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXgDpb16tqDiSACA--.8S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1DWF4xJw1UArW7GFWUtwb_yoWkAwcE9F
	4rXw1xZ3yIkrWjkF15Ca12vw4IvFyDXFWxJFWqqFWfJFWxJr4v9ryrZFn8AFsrtry8Cr1f
	GFZ2qr47A3srWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSxYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwCY
	1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48Zr
	WUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2z280aV
	CY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjxU2U73DUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUNA2qrrRmBsQAAsJ

ath12k_ahb_configure_rproc() returns the result of
ath12k_ahb_config_rproc_irq() directly, so a failure there leaves the
rproc notifier registered and the rproc reference taken by
ath12k_ahb_get_rproc() unreleased. Route this failure through the error
path that unregisters the notifier and drops the reference.

Fixes: 10a355ba6238 ("wifi: ath12k: Power up root PD")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/wireless/ath/ath12k/ahb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 2dcf0a52e4c1..0b69ff42dd7a 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -889,7 +889,11 @@ static int ath12k_ahb_configure_rproc(struct ath12k_base *ab)
 		}
 	}
 
-	return ath12k_ahb_config_rproc_irq(ab);
+	ret = ath12k_ahb_config_rproc_irq(ab);
+	if (ret < 0)
+		goto err_unreg_notifier;
+
+	return 0;
 
 err_unreg_notifier:
 	ath12k_ahb_unregister_rproc_notifier(ab);
-- 
2.34.1

