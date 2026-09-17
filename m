Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7140049D583;
	Thu, 17 Sep 2026 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664342; cv=none; b=lcJQCNvL9OFplIaApEtFNvzU73m5gNvffFmse5gejzt9lD1dz7Ubrxe7nhRaN4kF6VUYkD1MaKm0NmViKBxmMD0KP/NXWGwhf/iwudkDIeJx3bOgsTKNu5d9k7eKbE01F8Cjs41lzx4XgkiImWRchOkpDCRvl6bk0C6Ug7k1JiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664342; c=relaxed/simple;
	bh=MycG3yYr3m3hyQ3sKhvgTVcsHY/rCjgmG4aI/ttkpOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tp8asiNaYQAtJiDCGUoE3VreFej5Lrn5FwomBfPFxnAoD2uZz4MFRf/qwaGHUR2MSLM8Vgud4qbIk3wYm2ksi6o3Ko4D4lLbAfUrXBOdpU6lQDPzcVbntL7CGHvlbfubyJzABbSfB4/JLTaTYTBElwIt3ZrBhFV1irHSJSY9Dts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADH+EJLHKxqMO+ECA--.48164S2;
	Fri, 18 Sep 2026 00:58:51 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: broonie@kernel.org
Cc: kuninori.morimoto.gx@renesas.com,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: audio-graph-card2: Fix use-after-free in audio_graph2_link_c2c()
Date: Thu, 17 Sep 2026 16:58:51 +0000
Message-Id: <20260917165851.2163548-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADH+EJLHKxqMO+ECA--.48164S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWkJryrGw4fur15XryrWFg_yoW8GF4kp3
	Z5KFZ8JrWDWw4UuF40vrykJrZ0yanrC3yrGF1UJ3yqkanxt3yfZa4UZrn5uF4YkFs5uFWk
	JryDtas7Jws8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IY
	c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbUPEDUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUNA2qr9LZdKAAAsk

of_graph_get_next_port() consumes the reference of its prev argument.
port0 is only borrowed from the caller's iterator, so the call drops a
reference the function does not own, and port0 is dereferenced again
afterwards. Pass an extra reference, as graph_count_c2c() does, so the
reference the callee consumes is the one taken here.

Fixes: 5f281c3e82b1 ("ASoC: audio-graph-card2: use __free(device_node) for device node")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/generic/audio-graph-card2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card2.c b/sound/soc/generic/audio-graph-card2.c
index 0202ed0ee78e..268023d6f939 100644
--- a/sound/soc/generic/audio-graph-card2.c
+++ b/sound/soc/generic/audio-graph-card2.c
@@ -969,7 +969,8 @@ int audio_graph2_link_c2c(struct simple_util_priv *priv,
 	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, li->link);
 	struct device_node *port0 = lnk;
 	struct device_node *ports __free(device_node) = port_to_ports(port0);
-	struct device_node *port1 __free(device_node) = of_graph_get_next_port(ports, port0);
+	struct device_node *port1 __free(device_node) =
+		of_graph_get_next_port(ports, of_node_get(port0));
 	u32 val = 0;
 	int ret = -EINVAL;
 
-- 
2.34.1

