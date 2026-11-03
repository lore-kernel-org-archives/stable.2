Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703344;
	b=TMJfd+Wtx3A730f/bU25zo0Uf5XAdmBykULshNiZsDqbL8yST+Xz2dgdUCbU8s7hJ/pE
	 jUsFc8t1ZQ2eflXsKw4pO09kky0dKkcgIQumRQI8EEATn7c5h/Z+pKntDuzcSPm9DgpD6
	 66/gj4JMI45cow/UEZrnym4cIQ30RRbBctpx98NZ/TZi7WhqqojDHvd4T1rJMD1fQdr6u
	 5SyQim9oZ+1j9TIwh0l+/lN796tK0WCy9i9PN6NoQhqsg0w7fBSj9IuO2hNg8fHK7nHxb
	 nlv6Q7Alqksr5RaCSm2olLxAM1Aec9CDmpkBAIUWLcsspRXl6jOJg5FeMTOsxc8fULQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703344;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=u8NMLcvatPv90Z2O1mm+g19hOes7NsOVQOZdoBu+Xuw=;
	b=t8Dp1+F9mFpKDaLCsS2mW6N6/A0ZX/jEBb4K+OyktAMdCbdqvyvW2isRzU6jxToQijSO
	 3GBhC2UGctFlMqfP+b57QpL3oe8Dxyx6r0hfZ/yAikeZ/SqpgJG09VImjnLFGKlDjECRn
	 Vi0jaV0BX8Zj/tXjH7kiDTcIdu0kk2N9WH0SUBWcJIcdxd6CfSut9vg5vBfuWGbccH1a5
	 CbtwKlL6hClNGpjGMwbzW76SzQetk/tUsHO9XrOAAnHx7HaSbK0BaEsBPPmDSWwmhRzYx
	 nrvox2HyhuLXzST7OPJ6zLPlkJEMpIyI6Hh7WSYtKWv8kwcvibzghWTnxAJBY4Rxtag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7288D60775C6;
	Tue,  3 Nov 2026 10:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7288D60775C6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAA3QpOovelq1OE7AA--.3307S2;
	Tue, 03 Nov 2026 18:55:36 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: pmc_atom: drop the PCI device reference after setup
Date: Tue,  3 Nov 2026 10:55:45 +0000
Message-Id: <20261103105545.1394600-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowAA3QpOovelq1OE7AA--.3307S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW5tr4xtr1ftrW7Gry7trb_yoW8GrWkpr
	srCa43Ary5Kw1Dt3WUZr10vF15AF4Iy34fG3y7A3WDu3s09F95t340q3WaqF1qyFWkG3W5
	tw4qyFW8uF4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6r
	xdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2
	zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07j8wIDUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUAA2rpnICE+AAAs8

for_each_pci_dev() walks the bus using pci_get_device(), which takes a
reference on every device it returns.  pmc_atom_init() returns as soon
as the PMC device has been matched, without dropping that reference, so
the pci_dev is never released.

Save the setup result, release the reference and then return the saved
value.

Fixes: 93e5eadd1f6e ("x86/platform: New Intel Atom SOC power management controller driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/platform/x86/pmc_atom.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index 046933f6d1b6..ac19830703de 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -579,6 +579,7 @@ static int __init pmc_atom_init(void)
 {
 	struct pci_dev *pdev = NULL;
 	const struct pci_device_id *ent;
+	int ret;
 
 	/*
 	 * We look for our device - PCU PMC.
@@ -591,8 +592,11 @@ static int __init pmc_atom_init(void)
 	 */
 	for_each_pci_dev(pdev) {
 		ent = pci_match_id(pmc_pci_ids, pdev);
-		if (ent)
-			return pmc_setup_dev(pdev, ent);
+		if (ent) {
+			ret = pmc_setup_dev(pdev, ent);
+			pci_dev_put(pdev);
+			return ret;
+		}
 	}
 	/* Device not found */
 	return -ENODEV;
-- 
2.34.1

