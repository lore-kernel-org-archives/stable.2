Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0490D4A2A5E;
	Wed, 16 Sep 2026 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550208; cv=none; b=UOIalBnQuVsveYNms4zt2iR9sJ/oD8ec1rEkjfbFSzHQyc9IMakoqDQTvfakCDdBHprpG61M5PE7ei9uPg9JxZrrjQSt39tJUBmLf+98dB0zTsYV5RGqVoKCD5/1xaaS2kBSPRTFpFfb/hbGMTLp0r0I2rdRCxqT09qembGFn+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550208; c=relaxed/simple;
	bh=d0WWrY2JFvGVRywjigkEhTNyV/Mh9NTYbglso1vrsyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CsTdA5637QgMeFKbI1G8BgjDcEpV2DHGKQaC11exT264qYSCywW8SULMmfCYSAt6L8P2JjdLAXLT0EziSQTeP3u0E2TkoOG7/xEWmElJertgng00YWdPivbEIsRg1mcPo+5mTK6GzjcEonoifrouZ6Qg4vT/4Vgqc7UGyonp9b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADHk0FmXqpqBjPgBw--.41336S2;
	Wed, 16 Sep 2026 17:16:22 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: akpm@linux-foundation.org
Cc: bp@alien8.de,
	dougthompson@xmission.com,
	juhlenko@akamai.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tony.luck@intel.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] EDAC/i3200: Fix mci_pdev reference leak in i3200_init_one()
Date: Wed, 16 Sep 2026 09:15:54 +0000
Message-Id: <20260916091554.1998750-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADHk0FmXqpqBjPgBw--.41336S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF43GrW5JF4rWw1ktFy7KFg_yoWkGrbEg3
	WFvFy7Xr4kGF4qkw1xCr1fZr9FgFs2qr4fWr4xK343Cr4fW3WDZan8CFyDAr47W393AFWU
	Kw1DKFyfJF42yjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JULo7
	NUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMMA2qqP4eEvgAAsX

In i3200_init_one(), a reference to the PCI device is taken with
pci_dev_get() and stored in the global mci_pdev even when
i3200_probe1() fails.  On that path i3200_registered keeps its initial
value of 1, so i3200_exit() skips the pci_dev_put() and the reference
is leaked.

Only take the reference after i3200_probe1() succeeds.

Fixes: dd8ef1db87a4 ("edac: i3200 memory controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/edac/i3200_edac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/i3200_edac.c b/drivers/edac/i3200_edac.c
index 6cade6d7ceff..c80c77230369 100644
--- a/drivers/edac/i3200_edac.c
+++ b/drivers/edac/i3200_edac.c
@@ -439,10 +439,13 @@ static int i3200_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -EIO;
 
 	rc = i3200_probe1(pdev, ent->driver_data);
+	if (rc)
+		return rc;
+
 	if (!mci_pdev)
 		mci_pdev = pci_dev_get(pdev);
 
-	return rc;
+	return 0;
 }
 
 static void i3200_remove_one(struct pci_dev *pdev)
-- 
2.34.1

