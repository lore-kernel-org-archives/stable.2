Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491116;
	b=VBjFFd7caJ6KFoayAceWpx/Xvw/a6Qc9QDvmfIFLnx4D4FpEpMVZvu5IeciVn2gCiHSq
	 oOvoXwYXWAkOUA3CnS8FIny5/torUnpfclIziXm1P//tH+92tCivafjriIkG0HTmd389w
	 Oco4JuSJJJZxmdo5fL5Lj8pn2tbxwcvIeZk0UizaGfd3xDOr0Dv1EKZVmI3lieLUSWEZR
	 Hi+Ul9QMJgPNfCwsJHFzpa3Ykhh7ICqZxrn11/DuXf4ZuwtnyuO9s2rQtlJF3kX+m3p/r
	 wGtTmXFblWbKWM2clcS9AHALxPxUXPO5Xzg7tT3ZW1W7iNgWZfZuoUtUP1ZADbLykwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491116;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7nteGObl6tpBTZEAOzKq4nqis2nYsetm5CtazCpg/Ho=;
	b=ihHR67re/46iZJd2wf1GvN9RwacHMBDUiAdCiAX8uhg0rSfne5KjTjPTVsyolWOWd+Ep
	 GW1pkWa8ikobCrI5KzYkwWADixS9UIBbLCKjhkAnkYmaDo+U2UvvJrERDB/EaAAvhR4W1
	 BhVexGZTepYB3sQwkuWkBIzWFpuYchxO16HXgFaFYLcGcXdNwu2ESGl6C76wk1dKB9E6W
	 lO0UkKIhUT5ArhCHOt6H3UAHGkz1LRE/kmZhMrnwVChGNElWgCbESKXReW/mVGbOxNW1A
	 uyBFdyhqOYOwrMToBQS1dMPyMy1ILqVM5zQ8NOjfs3jAF3/s0ZMG8V4qdPeHmyC6+zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=c1ut7cfn;
	arc=none smtp.remote-ip=115.124.28.49
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com [115.124.28.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D499606A32A;
	Tue, 20 Oct 2026 10:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D499606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=c1ut7cfn
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792491112; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7nteGObl6tpBTZEAOzKq4nqis2nYsetm5CtazCpg/Ho=;
	b=c1ut7cfnaZk5pqV4gZ9+eI/31zPprYX/PR4nSFHx+8306ipQKLjsOllwdeHfPOV0GVcsEJ/uqM+ce8p+z3dGcivfJZpwwSNmo5WkwJdG5ayV5q+IsbezkbRDmMtg9XKA4PKglUHz2Vj2QQTfzcEHVcvOlSQjecQaKZe5YcEM+VE=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07892643|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00381769-0.000805355-0.995377;FP=12127585923466235074|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023087102;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jlhO7Fd_1792491110;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jlhO7Fd_1792491110 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 18:11:51 +0800
From: liuc63 <liuc63@xiaopeng.com>
To: M Chetan Kumar <m.chetan.kumar@intel.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Guanglei Zhu <zhugl3@xiaopeng.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: wwan: iosm: fix NULL skb deref in ul_td_process
Date: Tue, 20 Oct 2026 18:11:41 +0800
Message-ID: <20261020101150.16967-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

From: Liu Chao <liuc63@xiaopeng.com>

ipc_protocol_ul_td_process() fetches the skb for the current tail
entry and then dereferences IPC_CB(skb) when comparing the TD buffer
address against the skb DMA mapping. If the skb slot is NULL (e.g.
the entry was never populated or was already consumed), this results
in a NULL pointer dereference.

Validate skb before dereferencing it, mirroring the existing check on
p_td->buffer.address. Return NULL and log the error when the skb is
missing so the caller can handle the malformed descriptor.

Fixes: 64516f633bfd ("net: iosm: protocol operations")
Cc: stable@vger.kernel.org
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c b/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c
index f2f86f41fd10..dee2e6607f77 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c
@@ -302,6 +302,11 @@ struct sk_buff *ipc_protocol_ul_td_process(struct iosm_protocol *ipc_protocol,
 	if (pipe->old_tail >= pipe->nr_of_entries)
 		pipe->old_tail = 0;
 
+	if (!skb) {
+		dev_err(ipc_protocol->dev, "skb is null");
+		return NULL;
+	}
+
 	if (!p_td->buffer.address) {
 		dev_err(ipc_protocol->dev, "Td buffer address is NULL");
 		return NULL;
-- 
2.50.1

