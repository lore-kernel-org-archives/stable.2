Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700338;
	b=NJEiRCC/MvH5queNgw5dn0uhcJNv0rQm1RGMsK+bVDzOzi8bk+/xNeC+AwZRhn+cosZo
	 /YE41SRhwUJlNwmhvba1vRNTEYQVZK2EwFs3fnlcE9MeVezxeduQsQ1WuO5xaf+ecQY2C
	 hZbZ6OozL+6CbQgs/6GNg9Qw7DaK4+VgGLbtsr1GR7hNAWZTr6uXiESVYixKZ+cLJyqFh
	 8pXOFXspOwX9xN1TZvQE/H2xRVLt+/m4dwUUYUUcQL6Dg7k0EVSSs7QCBksUk6drGHIjD
	 RL2k8UPEZytag9UzNRqqhClgFE12S3Mi1dNoD5T2ElNI5AGyAqJWartkGnR5fplJDBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700338;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=Oh/m/hg+bzvxxYBT2T2fdKMkhIaukkQ/MVnjb8MgjsY=;
	b=m1jb2XQh6dInPRqDc88B94FlOO8IJhWZ6RXqdkrnrkpvwoqb0FuibbYMm+aJX4DS9T/O
	 t2rAYfqLWkyub09wIfck5FV6ub9xnG13MHa2ItLuoDkd6v01xKjmtuGrBdafA6ah1tF9T
	 n9WCRjFMx+eQtiAVUQU55YTe7EXfXl+692oXTbWNBFMHBt1uc77t78IHzirmIzBlJiiqB
	 lV5N4q1Re7XME5tDEguS3kKtT9BxcmemCQ5Gas6mj8fuRXraeykfNxRvi0q/1TL0bztkR
	 1oDk/OmY+5s0jRa3As+JGcxc5v6gHtELls+oGYE+EtBPrJmZ3/RjdiJDwLUddjTpBkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB3C60850B3;
	Tue,  3 Nov 2026 10:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDB3C60850B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnt5jnselqoXs7AA--.2514S2;
	Tue, 03 Nov 2026 18:05:27 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: octeontx2-pf: drop the TC mark reference when adding a flow fails
Date: Tue,  3 Nov 2026 10:05:36 +0000
Message-Id: <20261103100536.1310108-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACnt5jnselqoXs7AA--.2514S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4UWw15uFy7JF4fAF4kXrb_yoW5JrW3pr
	48u3429F1rAr17Wrn7Ja15Ary5Gw4jqFy5Gay8Cw1Sgw13Arn7Za4DK3y09348KrZ3Ga9I
	qFyjyws5Ca1DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIAA2rpnIBiCQAAss

otx2_tc_parse_actions() increments flow_cfg->mark_flows when it finds a
FLOW_ACTION_MARK action. The reference is meant to be dropped again by
otx2_tc_del_flow() when the flow is removed, so a flow that fails to
install after its actions were parsed leaks it: the checks for the MCAM
entry, the insertion into the flow list, the mailbox allocation and the
mailbox reply all free the new flow node without touching the counter.
The same happens when parsing the actions itself fails after the mark
action was processed.

Release the reference on the error paths of otx2_tc_add_flow(), using
the match id of the parsed request to tell whether it was taken.

Fixes: 6a57f091622a ("octeontx2-pf: Add support for offload tc with skbedit mark action")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index dee38d5c7f65..c3726d9f455a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -1237,6 +1237,13 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
 	return 0;
 }
 
+static void otx2_tc_put_mark_flow(struct otx2_nic *nic,
+				  struct npc_install_flow_req *req)
+{
+	if (req->match_id)
+		refcount_dec(&nic->flow_cfg->mark_flows);
+}
+
 static int otx2_tc_add_flow(struct otx2_nic *nic,
 			    struct flow_cls_offload *tc_flow_cmd)
 {
@@ -1273,6 +1280,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 
 	rc = otx2_tc_prepare_flow(nic, new_node, tc_flow_cmd, &dummy);
 	if (rc) {
+		otx2_tc_put_mark_flow(nic, &dummy);
 		kfree_rcu(new_node, rcu);
 		return rc;
 	}
@@ -1287,6 +1295,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 		if (rc) {
 			NL_SET_ERR_MSG_MOD(extack,
 					   "MCAM rule allocation failed");
+			otx2_tc_put_mark_flow(nic, &dummy);
 			kfree_rcu(new_node, rcu);
 			return rc;
 		}
@@ -1331,6 +1340,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 	return 0;
 
 free_leaf:
+	otx2_tc_put_mark_flow(nic, &dummy);
 	if (is_cn20k(nic->pdev))
 		cn20k_tc_free_mcam_entry(nic, new_node->entry);
 	otx2_tc_del_from_flow_list(flow_cfg, new_node);
-- 
2.34.1

