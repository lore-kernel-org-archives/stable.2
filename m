Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701730;
	b=k5azWFgejNcXGLXOergpOwHKEJLsnMfTpgt5htVRlrOnZrRHzU2m2VctInepmaGBu/5d
	 myNKUaD1sGju2Y6Wsy5jnjxhNsTr6K9Ufd/JVCEd/YmkKFLrJNTa7pndwj12GEJNVPJxE
	 MJlWwCzQ/5u/uGzg5zF864tmxSCgNQuCGmsnrVAt1kBzASS41BQFvnqJKtoJWFMWoh5+4
	 bpfKrnlRsJAQpuAQyvmQhSq4bhXT0yURYUmvAvYjG6MoI9K7uqauIuM/+5h1L4mlbXEx+
	 IMFzE9y3BebsGDKVN+2HmOsDCTn62fupCyJGa+l38HhEIcAvxwq7Cx7m3WYehbmghfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701730;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=IkVoS4jmvjr31zvtykWxiCv9bdGPQENa/hPZ76jhwso=;
	b=W4fzD23EYEVtJ5ijkXZUhKS2E8fYdD4uiuis/j1mq5/9dIVsTupH4PGENG+TU3rZaNgD
	 vYAA9qrYWjWTq8g9pOaNfez8KACDjvKeZrmYFlLKiSOqcaoUAb3b25Nd4Z8rRMR3nELdW
	 wDqm1qYec1Ds+7KqBNvmv3DgI7YbKhfaILMYegcxCcTivZMz+jMvNCbnkt8ErlEJk4JJZ
	 nys/xcC2RYDyVe1zkmNY9g9a5G8DHzjxJy5ZyIf8x5oErpj38iMuHdEJNbreTiCS3N/hW
	 oAwczoZeSgXU/JoT/6+ei+VQPust1QpwTj1vp0VQx2n25BiyHbkt42pSSKRPYCn6zCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E7607153F;
	Tue,  3 Nov 2026 10:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE6E7607153F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAB3hpdat+lqc6k7AA--.6645S2;
	Tue, 03 Nov 2026 18:28:42 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mlxsw: spectrum_ptp: release parsing depth on MTPPPC write failure
Date: Tue,  3 Nov 2026 10:28:51 +0000
Message-Id: <20261103102851.1340480-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAB3hpdat+lqc6k7AA--.6645S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWrCFyfurWrtw45Gry7GFg_yoW8uw4Upa
	1Yg34YgF9xtr1aga1DXFs5XryYk3yIqay09FyfK3WSyrn5ZFW0vw13WF10yw18KrWxJryx
	tr1fZFyrAw4DAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcS
	sGvfC2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIAA2rpnOFw7wAAss

mlxsw_sp1_ptp_mtpppc_update() increases the global parsing depth
reference count before writing the MTPPPC register when timestamping
is enabled for the first time. If the register write fails, the
reference count remains elevated even though no timestamping
configuration was installed, and nothing will ever release it.

Drop the reference count again when the write fails. Also only drop it
when disabling timestamping after the write succeeded, so that the
reference count always matches the programmed state.

Fixes: c6b36bdd04b5 ("mlxsw: spectrum_ptp: Increase parsing depth when PTP is enabled")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
index 9c5862f4e16a..0db77af4828f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
@@ -1190,6 +1190,7 @@ static int mlxsw_sp1_ptp_mtpppc_update(struct mlxsw_sp_port *mlxsw_sp_port,
 	struct mlxsw_sp_port *tmp;
 	u16 orig_ing_types = 0;
 	u16 orig_egr_types = 0;
+	bool depth_inc = false;
 	int err;
 	int i;
 
@@ -1214,12 +1215,21 @@ static int mlxsw_sp1_ptp_mtpppc_update(struct mlxsw_sp_port *mlxsw_sp_port,
 			netdev_err(mlxsw_sp_port->dev, "Failed to increase parsing depth");
 			return err;
 		}
+		depth_inc = true;
 	}
+
+	err = mlxsw_sp1_ptp_mtpppc_set(mlxsw_sp_port->mlxsw_sp,
+				       ing_types, egr_types);
+	if (err) {
+		if (depth_inc)
+			mlxsw_sp_parsing_depth_dec(mlxsw_sp);
+		return err;
+	}
+
 	if (!(ing_types || egr_types) && (orig_ing_types || orig_egr_types))
 		mlxsw_sp_parsing_depth_dec(mlxsw_sp);
 
-	return mlxsw_sp1_ptp_mtpppc_set(mlxsw_sp_port->mlxsw_sp,
-				       ing_types, egr_types);
+	return 0;
 }
 
 static bool mlxsw_sp1_ptp_hwtstamp_enabled(struct mlxsw_sp_port *mlxsw_sp_port)
-- 
2.34.1

