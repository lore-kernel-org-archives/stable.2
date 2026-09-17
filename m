Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5D44AF9D8;
	Thu, 17 Sep 2026 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642295; cv=none; b=HOYBkQS93PXADPhgAdbW66ByPhiproafRODjGuACHSdSeoruwMiQXpZ62wEAz7EUf4EPKqxaMsHm7+8kMYR+Wrr3+lrMcHR+ZJHJLaYYYWOlrFMDkho6Op00PtWBqiBExCYF8IB/KiOiBB0Ld8Sl+9JMQ8WxRp8CKELOq2WFSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642295; c=relaxed/simple;
	bh=VdTPJyVCO26D0ME9c3UkWlcovgq8+DrvUMuLM8iRBNw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aThfLfNwNyiMs2bzFuixy3YbhhjJAucRx3v08z51ZJBNAzgNcTneeNaoqAWraSy+cAI9cztCdl9rtAg3BkNZUgX4azUbHoqi2NSqU76wFX6Ngof4VS4ST8N5Zulpk+1HVvpxfkkFsRqLxRDaI+Ms8zGhFV5aATJW2uhsGLo2n88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB3pkAYxqtqgft+CA--.1014S2;
	Thu, 17 Sep 2026 18:51:05 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mchan@broadcom.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] tg3: Fix peer device double put in tg3_find_peer()
Date: Thu, 17 Sep 2026 10:51:04 +0000
Message-Id: <20260917105104.2147646-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3pkAYxqtqgft+CA--.1014S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry5JFykXFW5AFW7Kw45ZFb_yoW8Jw13pa
	nxJa4j9ry8Grn0ya18Ja1fXFn09a97t345WrW7C34rZFW5Za45Cr9YkFZ0qrn5ArZ3XF12
	vw1jvanxurs0kaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU8rR65UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgINA2qrq3ZdKgAAsh

pci_get_slot() returns a device with its reference count incremented.
When the loop ends on tp->pdev (which happens when the adapter sits at
PCI function 7 and no other function is present) that reference has
already been dropped inside the loop, but the trailing pci_dev_put()
drops it a second time, underflowing the refcount of tp->pdev.

Treat a loop end on tp->pdev as single-port mode, just like the
existing !peer case.

Fixes: 16fe9d74f14e ("[TG3]: Fix 5704 single-port mode")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/broadcom/tg3.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 73a4b569b03e..57669a22c036 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -16122,9 +16122,10 @@ static struct pci_dev *tg3_find_peer(struct tg3 *tp)
 		pci_dev_put(peer);
 	}
 	/* 5704 can be configured in single-port mode, set peer to
-	 * tp->pdev in that case.
+	 * tp->pdev in that case. The loop can also end on tp->pdev
+	 * itself, whose reference was already dropped above.
 	 */
-	if (!peer) {
+	if (!peer || peer == tp->pdev) {
 		peer = tp->pdev;
 		return peer;
 	}
-- 
2.34.1

