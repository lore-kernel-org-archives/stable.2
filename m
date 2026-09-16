Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28C44CAC6;
	Wed, 16 Sep 2026 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544121; cv=none; b=ABgCTM+LgTjiWXWn9uS2TigzfXDaqEllTrdK2DQZtMBXda4MnB0eViHZAXeWbnunbgdYDSefYUO0DiQHCqEQqCxN6YWjyP7WF2zBlAFAQXbNVY3uCGssZPoTBNh6CnW7ujs2NsV7e60mzYUhEJilib8POm/GKMmX8K/cR56c6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544121; c=relaxed/simple;
	bh=1UVeQwscyNpnmYJo6LD9uYaqcx3DxYBMukW55ElL214=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qbQ5EAakh4h3nRJRbhGPAh08d2RzaJaMAsjMMR4YHS0B5ESwD6omDDgF3Jlwoq0OGshogFUSmwTxXPlKCiAXh5tpebiDkqeWukxbDztK2SZkIW2vItFwU4z9tfaXX8pvF9EnVnPtS+KkeQP+ShW6MzrQArbsX+YqFIrU7uu/qCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnLjycRqpq3DDfBw--.40397S2;
	Wed, 16 Sep 2026 15:34:52 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: davem@davemloft.net
Cc: david+nfc@ixit.cz,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	pabeni@redhat.com,
	sameo@linux.intel.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] nfc: llcp: Fix socket reference leak in nfc_llcp_recv_ui()
Date: Wed, 16 Sep 2026 07:34:24 +0000
Message-Id: <20260916073424.1971784-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnLjycRqpq3DDfBw--.40397S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKryrArW5WF15Gw48Xry7Wrg_yoWktFc_AF
	1xCr17Xrs8CF43Ja9rGr4jy397Wrn7Wr4fZr1IyFsrJa4FyayFyrnxWrn3CrnrCa1UuF47
	ArykArySqw1IyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUCNtxUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIMA2qqP7kcHwABsF

In nfc_llcp_recv_ui(), nfc_llcp_sock_get() is called to find the bound
socket. If the socket type is not SOCK_DGRAM, the function returns
directly without releasing the socket reference via nfc_llcp_sock_put(),
resulting in a reference count leak.

Add nfc_llcp_sock_put() when the socket type is not SOCK_DGRAM.

Fixes: 968272bf0087 ("NFC: Handle LLCP UI frames")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/nfc/llcp_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index db5bc6a878dd..5813c80ca593 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -888,8 +888,12 @@ static void nfc_llcp_recv_ui(struct nfc_llcp_local *local,
 
 	/* We're looking for a bound socket, not a client one */
 	llcp_sock = nfc_llcp_sock_get(local, dsap, LLCP_SAP_SDP);
-	if (llcp_sock == NULL || llcp_sock->sk.sk_type != SOCK_DGRAM)
+	if (!llcp_sock)
 		return;
+	if (llcp_sock->sk.sk_type != SOCK_DGRAM) {
+		nfc_llcp_sock_put(llcp_sock);
+		return;
+	}
 
 	/* There is no sequence with UI frames */
 	skb_pull(skb, LLCP_HEADER_SIZE);
-- 
2.34.1

