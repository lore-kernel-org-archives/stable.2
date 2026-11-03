Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793688296;
	b=Lie1KAJwZ2F741HJvvGZD9SB6zjX0QcOWBGgQisN4R36fKxwlsjUOiYKp8nU855hg211
	 4YzY81ax92Y6ONWqZmACLNANpnBUl2Hs3ELK2VPuZ/IpDEZOj0T8nZfKyoUU/MrGSIA48
	 N9rld7TRgBIwmxvSXwlkzGi3V50cQ0grpxZadUWwMdMTuztDMiwI7TZrDf055r+/q9GY2
	 Vdp9PoZRF0/W7qCNbHKNrI2c3uYHzhrYfcl64A0vb3+27NfTAUYw0dmNXwvHZFvsPKoxb
	 bpNSLhLZ06iJcUHhhB23PTdaYs/mHwT1ERo9s25oXLvGD4E4XtMwYgDo+FmivVovnDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793688296;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=/dOVXsFMDkU6zs9kk0Fxy+2LOf1FqeDj2v2t86/TN+I=;
	b=v1wun0UMxoeYbh6FIOUdVdPMdjFV97f0GazH8B099hORGvSvdccqaNEZf4vqxIREa+g+
	 pOW1yz+hHG6xSquefqKPFD347Zq5VKOXh2fKDD1N7OEunPp1I8KF27UnMPEtTsQa4z55L
	 1JPG1qLwgyDW2BF7R4Vxa5oHPB662P93XqutnSDm0atVQe+pkUJUDMhPG48IarPv1lf2D
	 rF9KHU4jbrY8gxPwhP66DAJMT0WFEhR8IgwSF3/h7HlFdLP2D9/9cAHieTqKfMCJXUI3p
	 IDTmrFQM6Jxi3xIDZgJgxw0kAwR7Pwmb5qMonRst95pg33L2zKChQIJ3p3iHV1H+AyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B355606A324;
	Tue,  3 Nov 2026 06:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B355606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3xZbggulqE305AA--.203S2;
	Tue, 03 Nov 2026 14:44:48 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: phasta@kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] dma-buf: Release input fences in the unwrap merge order test
Date: Tue,  3 Nov 2026 06:44:57 +0000
Message-Id: <20261103064457.1056056-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAC3xZbggulqE305AA--.203S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF17GF1fKF1kCF1kCF4fuFg_yoW8Jw1Upa
	yxKF1j9r9xKa10vw1jvF17Xa4akw4fJFyrWF4jk34F9as8ZFy0vFWktFWIvr1DXr98G3yF
	yw15C3s8XFn5AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbtl1P
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwQAA2rpWtmDRQABsH

The merge order test creates an array and a chain as inputs to
dma_fence_unwrap_merge(). The merge takes references to the underlying
fences but does not consume the input containers. The success path only
puts the merged result, leaking both the input array and the outer chain,
which owns the inner chain.

Put the outer chain after checking the merged result and fall through to
the existing array cleanup on success as well as failure.

The dma-buf-fence-unwrap KUnit suite passes all 11 tests under UML.

Fixes: b1cce631e61f ("dma-buf: add selftest for fence order after merge")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/dma-buf/st-dma-fence-unwrap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/st-dma-fence-unwrap.c b/drivers/dma-buf/st-dma-fence-unwrap.c
index c5353b36f0e4..8115a721dc88 100644
--- a/drivers/dma-buf/st-dma-fence-unwrap.c
+++ b/drivers/dma-buf/st-dma-fence-unwrap.c
@@ -437,7 +437,7 @@ static void test_unwrap_merge_order(struct kunit *test)
 		KUNIT_FAIL(test, "Not all fences seen!");
 
 	dma_fence_put(a2);
-	return;
+	dma_fence_put(c2);
 
 error_put_a1:
 	dma_fence_put(a1);
-- 
2.34.1

