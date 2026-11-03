Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700336;
	b=xReiPsKhO+GvOOCJv+2CVWTs3WnV1D0QFRFHmzKxFj7fb4c67WZjSYTXjpMv+w9vs9gi
	 Fy+ldQZhJQC4kS7yom0MipVVgbAFt2Q0PzvXRMm6xpU/ft5O8EU7g3bWQv/ilPK6IDFFu
	 pscZTW7mbGwhbSFo7emneDT85BY9W9givKD4Vqfuk1v/YNzCt8zRP4MQoLaT9FS/2rg3T
	 ZVKMFXrtN8g6P40LFwBlUOujwESYjDbKm2foy4zk+c2sU9NcUTu774pFlpek4nZxYvOtZ
	 F0jWQOUPHTZh96VFpNBneYus1EX/YuDBsOqxU6RQ6gGruejFfAzy5xYLEz51YgZlEdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700336;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=Yt3HBs83jX9B8IR02MP/6eu/676fqC4Ktt+8AJPnvUs=;
	b=spYvAxGri2JfQCCellxECTRbkWIUXfVe6x3udgN4yn8SsscIhMOPcTaP1Ea32zd7uWjx
	 66XopN9KMofYkRHbLL7d0/V2IvmSXxn7JXBG1owCvgBUHevXAcFTJAE4jOv5MPInrWHAO
	 igpoCefGc1NPV3RlvDuLtR7ErGnf2CGnHAOI0IaZTZDYQQ8KxKY4RrLiqdvy26Si3/M1A
	 YpS65eoQ9yyO17NxhEwEQycLmegy1oxUzrjHVM7bUJOaouivIuPvYbcErYaCBUV5qBheA
	 H/aAXwaK4myfJuUaqcEUgNz7VXl3RHvwlU9+HVST3nNk3+dxrjRxL6OtMfrPiXz5ujA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2672C6083638;
	Tue,  3 Nov 2026 10:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2672C6083638
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3xZblselqkHs7AA--.2541S2;
	Tue, 03 Nov 2026 18:05:25 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: ixgbe: drop the SA reference if secpath_set() fails
Date: Tue,  3 Nov 2026 10:05:34 +0000
Message-Id: <20261103100534.1310039-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAC3xZblselqkHs7AA--.2541S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Wr4Uur18tF4UXr4fuFyrtFb_yoW8JF15pa
	n8CFy8uFyDXw48Wa4kXw4rCFZI93yIqry5Cr9Yk3Z3Zw1rAry7CrnYvFyjvr18AryrKF43
	tFy7AFsxC3ZxA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6r
	yUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_Gc
	JvcSsGvfC2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggAA2rpnIRi8AAAsE

ixgbe_ipsec_rx() takes a reference on the xfrm_state returned by
ixgbe_ipsec_find_rx_state(). On success that reference is handed over
to the skb's security path, which releases it when the skb is freed.
When secpath_set() cannot allocate the extension it returns NULL, but
the function returns without releasing the xfrm_state, so the SA
reference is leaked.

Put the reference before bailing out.

Fixes: 92103199f10a ("ixgbe: process the Rx ipsec offload")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index bd397b3d7dea..e44d5eed9ab5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -1197,8 +1197,10 @@ void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
 		return;
 
 	sp = secpath_set(skb);
-	if (unlikely(!sp))
+	if (unlikely(!sp)) {
+		xfrm_state_put(xs);
 		return;
+	}
 
 	sp->xvec[sp->len++] = xs;
 	sp->olen++;
-- 
2.34.1

