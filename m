Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702553;
	b=4vS2zZC88mVBiIyFH2SHo3liolfIimGCzqOp+/5lRhMUxnbut5PfbNXenJY9LxpliHwh
	 airWxBi6LmbeGLkD6P/pQArave2DsrXvPkiqkn5ffCjfVwRR82LEbakJGttfV1cAVYedM
	 0tMMbplwJTAIZvT3LhuoSd3K52J1YQQDC+kj0APNzksJp2gjJQFmpbvWj+ocmC7t8w1FC
	 LbzEjanX5J8oBQIH6gf9uc0K7QB+m0OCfnYAhkeqtcDet+0LrL3KNJrLTKqtP78d8rGlG
	 MtKnmVkujvoGZKUsV6Eh9+vUg+KhRGsI0X/4TK5Dml+myfjPyk7cI2DDr5DXwXY6jIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702553;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=/nl4W4KQsgnt1xFgLdGYlMAuu56jNFRNvgMoeELoTt4=;
	b=kBLyUBvjl6by5/kHK9N8BQCtuC8J3N5T2qa7oyYowScaenKtcgJ0xA7HgE+lVohzCRK9
	 fsOWcJd7FqQZDMR0HoWWrcTbBe144JaLKeJ+6MZcbkVO4zuHMqZZE/cA6MPMjox7SiV+o
	 OJS5+uxU5IUDDEMB62bvHwqtnhocbsCM8oUh13Atv03gx7BzUHQKp7ugqXy0YUvhqk2wi
	 emWpBwdOowgJgdpTxpH9RCtTi2QbHd8BPl5R+zqC3OwUroldhCn1yjZcSDldCiM4X+hBK
	 wErS9D0gQSy6LwA5gNodOTNyTXxCeWZrqitujtX/Q2SwN/4N+LEfFR9tbvEUAf8+Lrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25459606EDAE;
	Tue,  3 Nov 2026 10:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25459606EDAE
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAB3h5iWuulqk8g7AA--.2938S2;
	Tue, 03 Nov 2026 18:42:30 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] PCI/IOV: drop PF reference if max VF bus computation fails
Date: Tue,  3 Nov 2026 10:42:39 +0000
Message-Id: <20261103104239.1373721-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAB3h5iWuulqk8g7AA--.2938S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWfCr4fZFyDZF4xtw45Awb_yoWDurX_W3
	W8Ar9rXFWUCF1qkw1Ykr1fZrZak3WDX3yIgrWIq3WrGa4Yv3WSvrZ0ywn5J3WUWw4xuF98
	Jw1qkr15C347WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-kYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVWxJr0_Gc
	WlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E
	6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr
	0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVWxJr
	0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU0Oo7tUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgIAA2rpnIR95QACsG

sriov_init() takes a reference on the PF found on the bus and stores it
in iov->dev.  The reference is normally released by sriov_release()
through sriov_disable().  But if compute_max_vf_buses() fails, the
error path clears dev->sriov and frees the iov without dropping that
reference, so the PF device refcount is leaked once per failed SR-IOV
initialisation.

Release the PF reference on that path before freeing the iov.

Fixes: ea9a8854161d ("PCI: Set SR-IOV NumVFs to zero after enumeration")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/pci/iov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9185934a900f..b7ab7e0f6fcb 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -880,6 +880,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	return 0;
 
 fail_max_buses:
+	if (pdev)
+		pci_dev_put(pdev);
 	dev->sriov = NULL;
 	dev->is_physfn = 0;
 failed:
-- 
2.34.1

