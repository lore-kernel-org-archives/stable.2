Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702549;
	b=gfHU3em28/pvukxfklzvQoUD6YsZMY5giA/3QH/CT2jPd5MFburM2frkKNvCZbT7KkVB
	 A4va0sKOww1k7QIWl4p4I1Zqj6ogCxyZ4ecGiu+MZ8DUihGxN/iysbEliuXqCDnCamORu
	 fGi91myaFVBEBPM3xSq6q19sGud52zlyjKLCnMHvbqYb61MZks3/yBNlSjAJvydZ8zKeu
	 K0xmdzSU8tWIFCod5iUnmXIPf5Le9+j+YxOjxxSXcX/Ka6Ac8m1ssfs7Zjiku9yGpRL52
	 6eOJiVt4UZRJTGfsDLb6sXXUU+NtP7lAqhc+LQhFAWRW9qDj0m6t/Wi4ApAwYUuP17g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702549;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=GRTj+bMCLTRfP6oBh8/ntORla+AQfg5mUpWuW2EaPZI=;
	b=PyJ0gtBOmXz1jnPlJ1Moa+mA0wxqyMv2pf5UDdUu04eg6gX7SVBTfzMhV+row1gF76pa
	 TEHyvGJxZRk+qAR/fsrRhLG0+9aBeBPA+djghIUMJN3sChDxIZpfvcAd9BHj4Oe9GrdzW
	 kRxfCMIedgrXQCKfnsLqBN36otzGMXPpDXnEQtuT+NFPODPEd56QaVEsOBjOMfB6MWwnA
	 48sZgOWk2GrjXLppMWbljyUMiUoz/j5NC+JRNT7x2y8708HMzdMroXhcTFcAvnj3HkELs
	 awEzsS5JoBEz0mmgad/RY13OFWcuh+xxFOnjZqARtbVkzsgOkkgJ/O9ioDp7zXu3keg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9B4606EDAE;
	Tue,  3 Nov 2026 10:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D9B4606EDAE
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3wJGSuulqbsg7AA--.2801S2;
	Tue, 03 Nov 2026 18:42:26 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: fix node leak in phandle remapping test
Date: Tue,  3 Nov 2026 10:42:35 +0000
Message-Id: <20261103104235.1373591-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAC3wJGSuulqbsg7AA--.2801S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4kWF1rJr47ZFy3Kr4DArb_yoW8Jw4rpF
	WSq3Z09Fy5GF4xtr48Zryjvayak347JrWfGFyYk3ZFvws8Ja4jq3srWay5Wr1DZFZ5X3WY
	y348tF4UWF1jyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWx
	JVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VU1
	YsjUUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggAA2rpnIR93AAAs3

of_unittest_parse_phandle_with_args_map() obtains a reference on the
consumer node with of_find_node_by_path() and never releases it, not
even on the normal exit path. The error path taken when one of the
provider lookups fails also leaks the provider references acquired by
the preceding iterations.

Drop both sets of references.

Fixes: 357aa4b61c82 ("of: unittest: Add phandle remapping test")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 8133c954d335..a6ac58b4d883 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -581,6 +581,9 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 	for (i = 0; i < ARRAY_SIZE(p); ++i) {
 		if (!p[i]) {
 			pr_err("missing testcase data\n");
+			while (i > 0)
+				of_node_put(p[--i]);
+			of_node_put(np);
 			return;
 		}
 		prefs[i] = OF_KREF_READ(p[i]);
@@ -711,6 +714,8 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 			 i, prefs[i], OF_KREF_READ(p[i]));
 		of_node_put(p[i]);
 	}
+
+	of_node_put(np);
 }
 
 static void __init of_unittest_property_string(void)
-- 
2.34.1

