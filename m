Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489382;
	b=JaRd/TQHa0/wLcWWeeZX7nt1nH5gvga3///dlnmI4w1JY6IoWTI0fIsD1gPkaNWGj7L2
	 +b/QdxQgcWzX5FG0Hu8JGJgyZinK+s1xIQjS47+XK79+NH+hJ8N9yatY6RJUMhex14euP
	 mubv09TGOE8cIDrxbtmuSbFGWBv/pNKZt/FAShlyIh0XJTMXwHpA1IPK5IsnT4xnP24Co
	 Jy7kRm2WD0wWRR9NNs5wlB+6/25q//LRZHlMRdS3/gCoV4vDXMysAR1vCdrh9Cf89Had9
	 uJ6Qb0r8TI2UeUPv8nQtPVRIehe4ltP/G+FO4P/GSy+JN91zF48krwd/wfGQYt5Dumg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489382;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fZUhw0CWQnff/DPaxOVvAeyjDYBTZif+6gSrN7s7hlM=;
	b=02eP0Epj7fF4PLWZoEcxdnl9+hiKtP849yNixGThRkqajzR8KwKJgL47FVvpaq9B4Tga
	 V94ZZKyPy/7wpxZNgjOnRDjgjftnvc2AVdDLBnGnFf4bd0y3xjcRtsj2AbTnMHonGwUDN
	 IB73edVtFqAtz5jx0nvqHvibNdma36tdncYtLGsUJoTmtgkZtNcVI22LKh1t2bbZoCmdv
	 VKzUryuwituk+fUxmxE6akoaLBZbr5opXjPRtb2iRUrKuWjkDRUF+JnJYIJ/rahNBprWu
	 qnH2D214fJDp4+2vnrYYPJT6SpC+UDE+NtqKvcv655uFGQedFHC0CSfd/s72gYoXi0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=DYvPlAHP;
	arc=none smtp.remote-ip=115.124.28.73
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97741606A321;
	Tue, 20 Oct 2026 09:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97741606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=DYvPlAHP
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792489376; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fZUhw0CWQnff/DPaxOVvAeyjDYBTZif+6gSrN7s7hlM=;
	b=DYvPlAHP4TsYGps2k/rIJ9FD+Xh3dPyn/3+1bxvOTnYdFlkwnIRuy5pmP7bEalmNVPKAuLxqv6wnaYbsZ4JkzMTwLIQ0NH4bXtZd2uObRydLPpyNjSKrmmBZ+be6eixlMrvPCTSsqS+X+dWI8SJiKBwKwjEbylJNfD5aYCy9ud4=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0835114|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00524836-0.0014099-0.993342;FP=10105117881427270734|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083099174;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jlb8AAG_1792489374;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jlb8AAG_1792489374 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 17:42:55 +0800
From: liuc63 <liuc63@xiaopeng.com>
To: M Chetan Kumar <m.chetan.kumar@intel.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Fang Xieyan <fangxy@xiaopeng.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: wwan: iosm: validate msg_head before indexing msg_ring
Date: Tue, 20 Oct 2026 17:42:49 +0800
Message-ID: <20261020094254.4017726-1-liuc63@xiaopeng.com>
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

ipc_protocol_free_msg_get() reads msg_head from shared memory and
uses it directly as an index into msg_ring[]. If the head is out
of range, the subsequent memset() writes beyond the message ring.

Validate head against IPC_MEM_MSG_ENTRIES before using it as an
index. The ring is a circular buffer, so a value outside the valid
range indicates a corrupted head pointer; report the error and fail
the allocation instead of writing out of bounds.

Fixes: 64516f633bfd ("net: iosm: protocol operations")
Cc: stable@vger.kernel.org
Reviewed-by: Fang Xieyan <fangxy@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c b/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c
index f2f86f41fd10..004920068c45 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c
@@ -14,6 +14,11 @@ ipc_protocol_free_msg_get(struct iosm_protocol *ipc_protocol, int *index)
 	u32 new_head = (head + 1) % IPC_MEM_MSG_ENTRIES;
 	union ipc_mem_msg_entry *msg;
 
+	if (head >= IPC_MEM_MSG_ENTRIES) {
+		dev_err(ipc_protocol->dev, "invalid message head %u", head);
+		return NULL;
+	}
+
 	if (new_head == le32_to_cpu(ipc_protocol->p_ap_shm->msg_tail)) {
 		dev_err(ipc_protocol->dev, "message ring is full");
 		return NULL;
-- 
2.50.1

