Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700337;
	b=d5Rz3m7MGVNVomD8HglJvL7xJ+YJrncDb/iDd3EU0UslpDuHD2nUjm6F0bTyzrVH/xZ2
	 yxRmCg299wkFiQjPA4mDIWSWRoZzX3bMOTvmSn5QV02FowPjvc/cFf+4BXQS2xBgNe5N9
	 7VB2wcicrtZ0uE6wYbP8Fddg/bNsw//5N1gkQjZmW8Nq/vs4M4JeOOgMJFzywwpzwTpl8
	 ea0chwYxGDmQ2enHRrOnDVOcL9/xlE1o0Yolm3XPxOCctnlHSUOkPZahlKGzAQwCxFQII
	 qDfsmDsWizBG/Jl/uwTjryhY8hzCKjdaQPzRD8OZYICdn1s6XKCp0IUv3Z3fG/FWHAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700337;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=pHILoWh8cXh4Ja4FuwvyiXCXnwvyYnbih+aBsUhTx5M=;
	b=JnxRVp5u320dv+GQtEzu6+4JA68/wb54ogte6yUeRc96vWh9RQ8j3m4TIKZ6nUoFd7lF
	 4ph2SjXemGAfQQXD81IpRZoXG/E+6yBgvRQLffoo2I2Q3XeEst/dKFMDdQRj0xF4KpXQt
	 Pq8gaFaz+tcmK7FdbTK400TaAj9nwApOwNRETrNw1LB1QJmp0Iagi4TT6omIMky2z2QYu
	 E2ocjS72hUT0vz93ItsCn4jtxwS3+QSMRacGVY5zZhcRQe245aCTAtbov7KESROMJ2Vn1
	 zJJ5oglGI55NS5rnzepTMh0b44VKK5F6PXwOHQbKjMI5QOlhKtiCzf20QrHgihJVx3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F576085094;
	Tue,  3 Nov 2026 10:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3F576085094
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACHkpPlselql3s7AA--.2932S2;
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
Subject: [PATCH] net: ixgbevf: drop the SA reference if secpath_set() fails
Date: Tue,  3 Nov 2026 10:05:34 +0000
Message-Id: <20261103100534.1310071-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACHkpPlselql3s7AA--.2932S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtw17Wr17tF4kGr13try3XFb_yoW8Jryfpa
	n8CFyj9ryrXw4jga4DXa1kuF9akayxtrW5GryFkwnavwn8Ary5CFnYvrWj9ry0yrWrGF13
	tr1jyFsxuwnxZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQAA2rpnOFgZgAAsz

ixgbevf_ipsec_rx() takes a reference on the xfrm_state returned by
ixgbevf_ipsec_find_rx_state(). On success that reference is handed over
to the skb's security path, which releases it when the skb is freed.
When secpath_set() cannot allocate the extension it returns NULL, but
the function returns without releasing the xfrm_state, so the SA
reference is leaked.

Put the reference before bailing out.

Fixes: 0062e7cc955e ("ixgbevf: add VF IPsec offload code")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/intel/ixgbevf/ipsec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
index 076fd0a24858..bf3fcab3bd57 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -596,8 +596,10 @@ void ixgbevf_ipsec_rx(struct ixgbevf_ring *rx_ring,
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

