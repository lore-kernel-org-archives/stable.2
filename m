Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632344A3F27;
	Wed, 16 Sep 2026 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550521; cv=none; b=mU3p9vmFu+Zb0PUohpoFxjXiu+pSQgyZ+i12E9PVoWUgEWJRzwXqJJeNfyIqgR6fMntECN6PNKoL4piEgIpJ0wmmrD9xCyR5zHZpCMXtW6uBN5NrUGbspD85FHlXkPhxUUo6wocLPC02eXEdr1na0xyLqmj6tKVW4mZAe0EQWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550521; c=relaxed/simple;
	bh=3q5P5vrkcNPN9SMdNXDvha7uzbQbv2qHtY5w5hdtfUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hcxgrXtXgtmJO8QmEdbZBEEZxgFwmmq/dMym4V06XZ+m4rFRcajoMLzGpJKIQIKfUwz1DyxBdb5ewZF2pYUj/VPPJQhYJCY+yz1Tg5Qph7DcNMykmQaQMLyqDO2N1kjq0uGASTgYjXNpTk3lCPRIaZV72+9Be9wRiLtvIQe/YR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3wT+tX6pq4kHgBw--.41772S2;
	Wed, 16 Sep 2026 17:21:49 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: akpm@linux-foundation.org
Cc: bp@alien8.de,
	dougthompson@xmission.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mitake@clustcom.com,
	tony.luck@intel.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] EDAC/x38: Fix mci_pdev reference leak in x38_init_one()
Date: Wed, 16 Sep 2026 09:21:21 +0000
Message-Id: <20260916092121.2000892-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3wT+tX6pq4kHgBw--.41772S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr17XF13Zr15Cw1kXFW8JFb_yoWDuFX_u3
	WrZFyxXrs3GF4DK3W7GFnxZr9F9Fs0vr48Wr4Ig39Ig343Xr1DZrsxuF1DJr47Wws5Zryj
	kwn8K34rur47CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUog
	AwDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQMA2qqP4eJuwAAsY

In x38_init_one(), a reference to the PCI device is taken with
pci_dev_get() and stored in the global mci_pdev even when x38_probe1()
fails.  On that path x38_registered keeps its initial value of 1, so
x38_exit() skips the pci_dev_put() and the reference is leaked.

Only take the reference after x38_probe1() succeeds.

Fixes: df8bc08c192f ("edac x38: new MC driver module")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/edac/x38_edac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/x38_edac.c b/drivers/edac/x38_edac.c
index 292dda754c23..9c6542c4e3ee 100644
--- a/drivers/edac/x38_edac.c
+++ b/drivers/edac/x38_edac.c
@@ -423,10 +423,13 @@ static int x38_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -EIO;
 
 	rc = x38_probe1(pdev, ent->driver_data);
+	if (rc)
+		return rc;
+
 	if (!mci_pdev)
 		mci_pdev = pci_dev_get(pdev);
 
-	return rc;
+	return 0;
 }
 
 static void x38_remove_one(struct pci_dev *pdev)
-- 
2.34.1

