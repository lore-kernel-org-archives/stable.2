Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF7438494;
	Wed, 16 Sep 2026 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543028; cv=none; b=c+Pyg14484BK9+JidgEjqShXammW+CNPzYJTMqp7+clk0iFQfB9nHo6xV2ajByl1usfPdGlzJs+i1CZSMVeX2m4UzmCql82Fj6/hZY0YCSLp5x1+Xwopm2iQ7poMnX0t3gFRgJwLiQiIPpa/WBmpVym4q5eikNN4MfuzssipFGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543028; c=relaxed/simple;
	bh=C0R7WZ3y2UBTdK870GZt38ZGoF8EjQW3ukns5/2dBrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rJnhpcUTcL0IJXq08+HjKKtDHD2CWLywnXPuhH8lYEvy0NUKqs+m/AmB9S3pm6aQ+/jdBCdxlgDQYAbEk/pC+YV09iq5yIBFnA/6hu/mGJLL8pEWAnuy1Z2HavyDOkaSUGmH33rAOfwm/MX9mR2yjjPfBa4v284T7zoH12iLaDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnKjhrQqpqfQTfBw--.39852S2;
	Wed, 16 Sep 2026 15:16:59 +0800 (CST)
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
Subject: [PATCH 08/20] ASoC: audio-graph-card2: Fix device node leaks in graph_count_c2c()
Date: Wed, 16 Sep 2026 07:16:31 +0000
Message-Id: <20260916071631.1966635-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnKjhrQqpqfQTfBw--.39852S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWxZF13ArWkXryDtF1DZFb_yoW8CFWxp3
	Z8KayYvrWDWr4UuF40vrWUJrZFkr47C3yrGr1UJ3ySkasxt3yfA34UZryDua15Ca1xuFy8
	JrWDt3W8J34UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUCNt
	xUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMMA2qqPpQQpgABsX

In graph_count_c2c(), port0 and port1 acquire device node references via
of_node_get() and of_graph_get_next_port(), but they are not marked with
__free(device_node), nor released with of_node_put(). Furthermore, an
extra of_node_get() was called on the result of of_graph_get_next_port().

Add __free(device_node) to port0 and port1, and remove the redundant
of_node_get() wrapper around of_graph_get_next_port() (which already
returns an incremented reference) to prevent device node reference leaks.

Fixes: 5f281c3e82b1 ("ASoC: audio-graph-card2: use __free(device_node) for device node")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/generic/audio-graph-card2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card2.c b/sound/soc/generic/audio-graph-card2.c
index 0202ed0ee78e..4f2da4d5803b 100644
--- a/sound/soc/generic/audio-graph-card2.c
+++ b/sound/soc/generic/audio-graph-card2.c
@@ -1198,8 +1198,9 @@ static int graph_count_c2c(struct simple_util_priv *priv,
 			   struct link_info *li)
 {
 	struct device_node *ports	__free(device_node) = port_to_ports(lnk);
-	struct device_node *port0	= of_node_get(lnk);
-	struct device_node *port1	= of_node_get(of_graph_get_next_port(ports, of_node_get(port0)));
+	struct device_node *port0	__free(device_node) = of_node_get(lnk);
+	struct device_node *port1	__free(device_node) =
+		of_graph_get_next_port(ports, of_node_get(port0));
 	struct device_node *ep0		__free(device_node) = of_graph_get_next_port_endpoint(port0, NULL);
 	struct device_node *ep1		__free(device_node) = of_graph_get_next_port_endpoint(port1, NULL);
 	struct device_node *codec0	__free(device_node) = of_graph_get_remote_port(ep0);
-- 
2.34.1

