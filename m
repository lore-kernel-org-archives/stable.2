Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC96485CC4
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392639; cv=none; b=SABrPjFBP2J5Ifrp+IRJhJy5B2tPhkiqa2iVHto+b8xC8GURduCM9Xjkdp3gDVz6KmLor3mV1Y95aVPD50TKquNpRt+9JJ/aJOxO6uGYCEJWW1ifss0Gy1fnvEsTVuZ6bi2C2seQ4YNgJOSx1kjY6yeAyB6EwH8/XHkbM0bax08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392639; c=relaxed/simple;
	bh=z6OivWSzqfsIkGB+qypMYD9sy6gvak55sKurmHllDIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asicFqEmP0wX2LNpuSksh7T1+6fsgutVcqr4iulsLWpIqAwPtYLpI7kbMvRori73mA2gi6Qp/6uarb5WokfYChgvO19JAkQERUiWo6MrC5LHjjqXwJshV1kOpuK1oRZF3+6drXlbkq6200pbA1rN/B7McwbD6wr+JlSsWDdE5PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=PnNBLts5; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="PnNBLts5"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so547961a12.3
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 23:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792392638; x=1792997438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g6wresGPlOerJ8rL7c+F8upCIM1dzOSfqyD9Zn2laIU=;
        b=PnNBLts59+ZjE0mn8497vEQjSIMe0AW7vywZSY147n9N9YyvJ9FV6Ki2+5VXzWv9Jj
         5hvlLOE4s/PBGD1jMDFEMrL5CB6jtqLAutGd4FUPLaEgPJz/J1lLKArD6+XQGL9McuCn
         +/GIqK7XVyqC3qgHLhfT1AUbHoqpVNQLBtYJXahT5H3xkHtB7PaJYUWOxW0ESlLdGFcb
         3TLM7SB5bc+2mHqV0zSbAOufEFYxaxbuL+ZaSjHICVhGE5OwqkDwIZLvGCoZoZvlIw42
         YH1GrqjMJ3Z4Z0xkd5F46hQgb6N6pl10jTslgJIS/i/agPkqBnzk52G8uWyR5wu3sSB6
         I2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792392638; x=1792997438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g6wresGPlOerJ8rL7c+F8upCIM1dzOSfqyD9Zn2laIU=;
        b=afdSuWD0pOEP3uTIIyhwTjyxr7xaYinUPEeu1lI3ZiUdHErShds6go5FnwAkfEo44M
         Z6jNqi3U94JKkoFtx6RDET01jEJwagWhRRzVcBqj5yToURPZ05U0UNYNEFK/oX/2Qo9g
         4nzfkZxGIPNNaRE6hhF7F9deAw2ncneN5Abwjwph4aKNt5zLtCCF694+4H4JquZtFJOa
         EE7TGPrdNHx0Fk6EPuQjc1GPytlm8VuB+M4t6vYJpPAkN4VTi7PzTxzFapZ04IpBCiec
         q1JgBCQTv+YtGpsYkubLt+/tNsecnmIIZT28Xuz+ywcV+jQ6o9KqMDJhjKpq07ynlv+S
         s9+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwOWDjl9Vyl1bapaedzDjtRUiuez44uM2BJcgSX5ypMo7eO0ghNzgmMoR5d7/AjWeQ3cKmqMVY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6sISG8z5m2QWmI4TbC2TslglQ2gJOqYurkzsIvipoImCkWxP1
	bIpQu8rTzNBeC0fUBkcTpDyn6pKBr/SVafpsihv7p3xqhf1+Mkc7tcTSGaIQhsuyUSM=
X-Gm-Gg: AYBFou1KnLuLmjOaTuiagMNpW9z3hbcMddO5+fbkYPoBi/AEJ9rpE+JT/AScWoJN4o7
	pIXdnG7/l79P0stlJCpE/s6ImmnJ6y7qgEVbiiwl+g86nX7TyzJqHNfYYi0MK5+VpmViGyovip6
	uCqSLaUGPnYpMqigglllbinQ08TxB4B9u6Pm/2jpOm9tW4ENS0HXLvsA/8LRSf3BPyQ+frqvdYf
	6pM7PaWYRqel6QbFUibG/orOOkmfDGVEnZlYgMd1ONi7/qTe/cBjWpgY0XFIt4lRVO2gppHqT2y
	+4I3thF5MfJWKDqIFvPP0ommLIPT2ulREdHalNFFEJbNVtQZjNsScXhOepRxEx/kAOIBYyvRWQc
	zwrfWCSuXD2oOB9r6K2xiRhABhNo1qmNh94SEgZLyBCVkRjKTk3lLtX8FPpDG7REHJ2CJ9nnaTI
	4XHayLNCv31l4ITw1vf4rWOlnm6HJaGVZtnXNRJEoteBHj0Rd5TgcY83QRTai8ChxYhfbv60EBM
	EchBKAXegtgtu9+
X-Received: by 2002:a17:90b:4ac3:b0:3ac:7874:639e with SMTP id 98e67ed59e1d1-3acef4fb85dmr6103457a91.46.1792392637645;
        Sun, 18 Oct 2026 23:50:37 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3f3ce5asm5870887a91.3.2026.10.18.23.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 23:50:37 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: njavali@marvell.com,
	mrangankar@marvell.com,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com
Cc: GR-QLogic-Storage-Upstream@marvell.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] scsi: qedi: bound the sense data length reported by the firmware
Date: Mon, 19 Oct 2026 15:50:19 +0900
Message-ID: <20261019065019.537183-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019065019.537183-1-yhlee@isslab.korea.ac.kr>
References: <20261019065019.537183-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qedi_scsi_completion() reads the sense length out of the CQE and uses it to
copy sense data out of the command's sense buffer:

	datalen = cqe_data_in->reserved2 &
		  ISCSI_COMMON_HDR_DATA_SEG_LEN_MASK;
	memcpy((char *)conn->data, (char *)cmd->sense_buffer, datalen);

That mask is 0xFFFFFF as well.  cmd->sense_buffer is a
SCSI_SENSE_BUFFERSIZE coherent DMA allocation and the firmware is only ever
given its address, so 96 bytes is all there is to read there, while
conn->data is the ISCSI_DEF_MAX_RECV_SEG_LEN buffer libiscsi allocates for
the connection.  A reported length above 96 reads past the sense buffer and
one above 8192 writes past conn->data, and datalen reaches
__iscsi_complete_pdu() afterwards, which reads it back out.  Every
SAM_STAT_CHECK_CONDITION completion takes this path.

Cap the length at the size of the buffer the firmware was pointed at.

Unlike the unsolicited path in the previous patch this one is not covered
by the KUnit harness, since reaching it needs a whole task and connection;
the bound here is just the size of the allocation the sense data is copied
out of.

Fixes: ace7f46ba5fd ("scsi: qedi: Add QLogic FastLinQ offload iSCSI driver framework.")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
diff --git a/drivers/scsi/qedi/qedi_fw.c b/drivers/scsi/qedi/qedi_fw.c
--- a/drivers/scsi/qedi/qedi_fw.c
+++ b/drivers/scsi/qedi/qedi_fw.c
@@ -640,8 +640,10 @@
 	hdr->residual_count = cpu_to_be32(cqe_data_in->residual_count);
 
 	if (hdr->cmd_status == SAM_STAT_CHECK_CONDITION) {
-		datalen = cqe_data_in->reserved2 &
-			  ISCSI_COMMON_HDR_DATA_SEG_LEN_MASK;
+		/* The firmware can only have filled the buffer it was given; cap at that. */
+		datalen = min_t(u32, cqe_data_in->reserved2 &
+				     ISCSI_COMMON_HDR_DATA_SEG_LEN_MASK,
+				SCSI_SENSE_BUFFERSIZE);
 		memcpy((char *)conn->data, (char *)cmd->sense_buffer, datalen);
 	}
 
