Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794759538;
	b=3GrOGIpVtcSD5qLbLPrED9edbL5lPR+yr7DMa2koGKmUojKSgP3G45jg2i3oPdYsr6Wq
	 G3s8toti7Hy62dHHiUMm6D7mDNxZzAXPmu0NM6205lFyXwYhcPzbnpBrNt4dL/e8XYy32
	 T0RPsr1/ukroEddOhMtxQMLLN8wJQFDB0tqXzu81TinB8r7JuJVot8kls8uxHtRjYwG68
	 1ObelyiC9m+6lqM8GXe5YWYKeom8hLj1cvUw4WzNuc5IOKXsHYLT3TLZuuV7Oh8YajfLL
	 FTVFh5u3gIW7pJaqSr6CdidPCux+vy3PMGx5wi1fGNZfsCQ2hDYCqPeMohJiU4cuOCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794759538;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=rC46ljI1wkzuuDt36qNW3ZBG08s5+InoUkoZUDEJRkM=;
	b=vnuw5WlnwA019k2RFjoBcgVNZIZisFRmAM4UnFMp3fu+OpIbKAwlEiTXrDrv5BZOi8/H
	 XdGmKh13XiHCszY7RN8SaWDgkRFfHZDQKPtruFRG1+xJQUpW46xRaJQJyAYmAgoD5InCF
	 WCpgsS32w62LO4QssdRpV6cmrfXCoI/6D3XJWueIi4QNprt7L63Anb1Pk8bSCSj+QH1Bp
	 +fTeRmyWP3dtg6DEYCPGTWRWrvaZhw5W7HllOV/BQJfl0gxM4+HyUVB2I7tJ8VQsji5zR
	 HcwtRPippVZO/iSCfDxHoZxPzzfDF1CTwA+EUpFtzPlu7vrQB8Kb/tZujDCGJ2O1p+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Z2D8lpiQ;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F38606A327;
	Sun, 15 Nov 2026 16:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04F38606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Z2D8lpiQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rC
	46ljI1wkzuuDt36qNW3ZBG08s5+InoUkoZUDEJRkM=; b=Z2D8lpiQSkP6DrID3o
	xM0C1qjqrmSPB2pigbVTNwejoLNAqaLAp4jQ7LHsEfALBB/EXm9Omp2RqkNCFglS
	Y+Tom948M8rhnepNNzgAZa2OzGxZlUg2k/DVX9ZjuGlGQbj/7dumrG5lAAgfR4St
	xhLwaRCoXK9PR6taz9CbUhRno=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnr8BI2_lqw3h9HQ--.52158S2;
	Mon, 16 Nov 2026 00:18:16 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: qed: fix dead NULL check on the MPA buffer list
Date: Mon, 16 Nov 2026 00:18:15 +0800
Message-ID: <20261115161815.941090-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:_____wDnr8BI2_lqw3h9HQ--.52158S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF17Jr17GF4DGFyUJr1xGrg_yoW5JrykpF
	WrAFyDCF4kJF4rG3W7uw40krWY9FWxZFWjgF9rKwsxZrW5ZF47XryUKFya9rW5Ars5XFs2
	yFWUKFnrGFWDJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jlCJPUUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7Qgicmr520gxwwAA3H

qed_iwarp_ll2_comp_mpa_pkt() takes a buffer from mpa_buf_list with
list_first_entry() and then checks the result for NULL. list_first_entry()
never returns NULL: on an empty list it returns a pointer computed from
the list head, so the "No free mpa buf" error path is dead and the list
head is used as a struct qed_iwarp_ll2_mpa_buf.

Buffers taken here go back to mpa_buf_list only through
qed_iwarp_process_pending_pkts(), which keeps a buffer on the pending
list while an FPDU is split across packets (-EBUSY). Whether the list
can run empty in practice depends on traffic and rx_num_desc; the driver
already has an error path for it, which just never runs.

Commit fbb8bc408027 ("net: qed: Remove redundant NULL checks after
list_first_entry()") removed the other checks of this kind in qed where
the list was known to be non-empty. Nothing guarantees that here, so
keep the check and make it effective with list_first_entry_or_null().

Found by LLM-assisted source review. Validated only with a test module
that calls the function with an empty mpa_buf_list, which oopses in
__list_add_valid_or_report(). The fix was build tested only; it was not
run against that module, selftests or hardware.

Fixes: fcb39f6c10b2 ("qed: Add mpa buffer descriptors for storing and processing mpa fpdus")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---

Notes:
    The changelog was drafted with an AI assistant from my analysis;
    I have reviewed the code, the fix and the text.

 drivers/net/ethernet/qlogic/qed/qed_iwarp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
index 4d1ce9b1a..057d6c0bd 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -2314,8 +2314,8 @@ qed_iwarp_ll2_comp_mpa_pkt(void *cxt, struct qed_ll2_comp_rx_data *data)
 	u16 first_mpa_offset;
 
 	iwarp_info = &p_hwfn->p_rdma_info->iwarp;
-	mpa_buf = list_first_entry(&iwarp_info->mpa_buf_list,
-				   struct qed_iwarp_ll2_mpa_buf, list_entry);
+	mpa_buf = list_first_entry_or_null(&iwarp_info->mpa_buf_list,
+					   struct qed_iwarp_ll2_mpa_buf, list_entry);
 	if (!mpa_buf) {
 		DP_ERR(p_hwfn, "No free mpa buf\n");
 		goto err;

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

