Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF457481FDF;
	Wed, 16 Sep 2026 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550013; cv=none; b=pYz0xg0u37gZtAjj2K/cMv6HMAhU4ZvVPafj+gwX99MEiX3xvVnyPhSMn5i6ulMG+cu/of6Cn6y1sH2bSUvoq/cBskO8JMP00z0w6jRnTiFfZ2ygatWLsq6X3ogYwro8uF323viqv6xmp/OoXrMjH05lwG8m0BBJHd7scTELL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550013; c=relaxed/simple;
	bh=/uW7dS2+cYvaC0td5unKme5V/yFKA18iJFNkCfR2Be4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QxF+XPsZUhfZViDt3DR8ZOZNdnRY9Ya0qu1y+G1MYy+m6tpyFd//QxomtlgFHonQ5IeRQLTbfl74gqyj9ShMlre7qpyv16xiitSrCnfHv+3JnIJKN6/+KRt8WANsD3rwN4rOG0fq7hio1FW/41IVQG6Ups9xlJjHapbg+rQRHVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAB3eTevXapqQSrgBw--.42445S2;
	Wed, 16 Sep 2026 17:13:19 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: bp@alien8.de
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com,
	tony.luck@intel.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] EDAC/i10nm: Fix mdev reference leak in i10nm_get_ddr_munits()
Date: Wed, 16 Sep 2026 09:12:51 +0000
Message-Id: <20260916091251.1997522-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3eTevXapqQSrgBw--.42445S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr47WrWkXr1DtFyftFyxZrb_yoWDGFg_Ga
	ykZFW7ZryqkF1UGr1DKFWfZr92yF1vvFyxXws7tw13KFW5Xr17WF13u3Z0qr17Gw4kAryY
	g398Xry7Zr12kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbLiSJ
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEMA2qqP7mAiQAAsN

In i10nm_get_ddr_munits(), get_ddr_munit() returns a PCI device with
its reference count incremented.  If ioremap() fails to map the MMIO
space of the memory controller, the function returns -ENODEV without
putting the reference held by mdev, leaking it.

Put the device reference before returning on the ioremap failure path.

Fixes: c545f5e41225 ("EDAC/i10nm: Skip the absent memory controllers")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/edac/i10nm_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 63df35444214..b0cabe0daccd 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -847,6 +847,7 @@ static int i10nm_get_ddr_munits(void)
 
 			mbase = ioremap(base + off, size);
 			if (!mbase) {
+				pci_dev_put(mdev);
 				i10nm_printk(KERN_ERR, "Failed to ioremap 0x%llx\n",
 					     base + off);
 				return -ENODEV;
-- 
2.34.1

