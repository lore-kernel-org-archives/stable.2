Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702551;
	b=ybCuUXzWGPuXm1ADYziQOgzgZPYu6N5WORmujq91Kk8XQI9eUscTjJhJZVu75sscNVqS
	 OMbxwMzcDwJzbJnsgku2rZIZVlOsiRQw3mzCPFqzYS2uGkdzwUWxAkK368y5pbxT6W5g3
	 SLM6f1eQLY+p0TlbZ0TrwYsnNRbAtIjzSDbdpSTdpmtZH7QmPZKswbbltyRPQYf1dMvi4
	 QWQcUUVXBNKvhmsBkbtIuH3BiFe4v5CX37D+3iBa4Tg1L2GlON+97fJKNd6EfAgxmCpr0
	 r0fQWotQtjECzEDbya1NF6uVbg93hCI+RAZlNV2eDDTPVfeDtNQAWP/z8vYXTl4V6Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702551;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=PlgkJ8DNGy17CKp66HUrWOQ4sNeyfWcOL+ZcM/3ZPcE=;
	b=L5SRjPaE6LzzHp+Fs8t0fsOecmNHNs4siduetcEs9N+a/fiX6qpfHSdTOkDKznBlHxzE
	 ULO89UULNBUf7vqClrSemWxhiuioNUAif7XHWouOW0AmLtgF9iyFll2EdzKhSL8eQ++95
	 p5B7cTt0IS+/J4fBDyXXc/Lz9Bg1+X486zOIxju1I8NN/36RwKlefKr8ELwCJvspRN0kL
	 zXlFzZrjLyXrJwg8QJSOGy/wooxDUgk5kUmGJ4pZQ8GbE78NFTUbVU2eMNFu8Mt+i/R6O
	 rNHRJId748ujPjkBdQSLAcT1eeSOFokLsPaur7IFGVybJhpA9UJkFPrUS03P9MpbrvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48729606EE80;
	Tue,  3 Nov 2026 10:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48729606EE80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3xZaTuulqecg7AA--.2902S2;
	Tue, 03 Nov 2026 18:42:27 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: fix node reference leak in of_unittest_dynamic()
Date: Tue,  3 Nov 2026 10:42:36 +0000
Message-Id: <20261103104236.1373631-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAC3xZaTuulqecg7AA--.2902S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZFyxXr18Zw1kAF45Wr1xKrg_yoW8JryrpF
	W5KFyYkryrGF47tFW5uryUua4ay3Z3JFWfGry7C3Wvva95ZFyUJFyDXayYqrn8XF95Za45
	Z3W8tF4UGa10kaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Cr1j6r
	xdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2
	zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	yj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07jcgAwUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUAA2rpnIB7kgACsr

of_find_node_by_path() returns a device_node with its reference count
incremented. of_unittest_dynamic() only returns directly on the
allocation failure path and otherwise falls off the end of the
function, so the reference is never dropped.

Release the reference on both exits.

Fixes: 7e66c5c74f73 ("of/selftest: Add self tests for manipulation of properties")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 7426d13e9958..d2f5c7ef3178 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -200,6 +200,7 @@ static void __init of_unittest_dynamic(void)
 	prop = kzalloc_objs(*prop, 4);
 	if (!prop) {
 		unittest(0, "kzalloc() failed\n");
+		of_node_put(np);
 		return;
 	}
 
@@ -244,6 +245,8 @@ static void __init of_unittest_dynamic(void)
 	if (prop->value)
 		unittest(of_add_property(np, prop) == 0,
 			 "Adding a large property should have passed\n");
+
+	of_node_put(np);
 }
 
 static int __init of_unittest_check_node_linkage(struct device_node *np)
-- 
2.34.1

