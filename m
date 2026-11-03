Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701733;
	b=HZn5pl/f+bDl/dDp0HwdcsN0auMCoCpPmcGRZ7K0SL2Ibjw/DH/cJj+VcrxWYR6EUxT7
	 Poz+t5MyhjYI/S6FgNGBCioBLZtkvBUAs2yLaxfRlRhM+xLc5hCzTNy1nLsp7TN5JHCXT
	 e6FQn985xYcxCOGT2JGsHes0WblAZf5oYY7z6y8X6RZ1TArAbr/P7bFKNsWMUOFKpKjt8
	 ZbQvz7zUL4YLdckYF8M+xj8eKZr3LITsFD6DYrWAHVVTXErLaFSaeTShcHsOs3Mki0vUF
	 7rJEF9lBBPnwjP9hhh4ZCtYKfflmZ3YkI16zOSij/JtrzRbW5bdsdcahYaNmvLxu5Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701733;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=FYvry7uZeC7rUlWGCCoWDZjRpJGvUxoi5hCCAR3kSVo=;
	b=VdCkLOc9Ppk5pl+F5CxcRGtbN0+6y4b/IwKqnjQGxx9VxLj9mpbM9VVY9Tmneaa2JQwt
	 DvaF2BRaobqhPhTg9bH3kigVElXwhbEoAy1AsV5e0UsmmcxyM/ecjJ+3Q/fk5J7Z+Rtil
	 W4mxdRpHnfZ3CQw4AzcyQscypYJ6Ry6Hl7oUynH/lmbtJqHHq2oNvMsU4h+eNCg+LJdrb
	 JMOvhmis1n/Xnb1kFzTwVg9AaFzGVGXVP5bi2pC04DC/XRUEeoDAgE8eCMGPvuh4cVLPy
	 xbpzLDFA9OyOwoj6UcXeeT9Gr/C6TZytN2peivEXYgmx1GbpMxjz+qqkp7zeliO9Evw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5C460A5BC4;
	Tue,  3 Nov 2026 10:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE5C460A5BC4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnN5hct+lqiqk7AA--.49099S2;
	Tue, 03 Nov 2026 18:28:44 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: mscc: ocelot: release the mirror reference on policer failure
Date: Tue,  3 Nov 2026 10:28:53 +0000
Message-Id: <20261103102853.1340556-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAnN5hct+lqiqk7AA--.49099S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWxCw4xCrykWF4DKFyrXrb_yoW8Gr1rpa
	1jka4DCryDXF4rG3WDXw4vvas0krW2g3yj9Fy8AwsxZ3s8Gr98GanrtFWjqryqkFWjkrsa
	vr4qyw47A3Z8Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYx
	BIdaVFxhVjvjDU0xZFpf9x0JjU-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUAA2rpnIByEAAAsi

ocelot_vcap_filter_add_aux_resources() takes a reference on the mirror
before setting up the policer. If ocelot_vcap_policer_add() fails, the
function returns without dropping that reference. The filter is not
added to the block, so the filter deletion path never releases it.

Drop the mirror reference on the policer failure path.

Fixes: f2a0e216bee5 ("net: mscc: ocelot: offload per-flow mirroring using tc-mirred and VCAP IS2")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/mscc/ocelot_vcap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_vcap.c b/drivers/net/ethernet/mscc/ocelot_vcap.c
index 25e533e91d71..c479af2a423f 100644
--- a/drivers/net/ethernet/mscc/ocelot_vcap.c
+++ b/drivers/net/ethernet/mscc/ocelot_vcap.c
@@ -970,8 +970,11 @@ ocelot_vcap_filter_add_aux_resources(struct ocelot *ocelot,
 	if (filter->block_id == VCAP_IS2 && filter->action.police_ena) {
 		ret = ocelot_vcap_policer_add(ocelot, filter->action.pol_ix,
 					      &filter->action.pol);
-		if (ret)
+		if (ret) {
+			if (filter->action.mirror_ena)
+				ocelot_mirror_put(ocelot);
 			return ret;
+		}
 	}
 
 	return 0;
-- 
2.34.1

