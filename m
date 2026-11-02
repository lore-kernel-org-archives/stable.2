Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627976;
	b=YG1+l2tq6+mzMoThOx45LDD4JsU6+TjVylwq8jFxtYzWYXe7xTufsOrHYmOJMJV5FSyt
	 osWwtR6dyEs06i8q/MbRDrBqL/veARX46jFImNc3b+nOVOmZpAVXKQyFW4sfBHhnclCVU
	 VZx3Dfwhju+YiH008GOoA1Jo2yPD1vC+FLBu0eskTb3RJ/FUfU+MT2uPJkZ/QadweoFr6
	 7QWv03inY/BhNn4ij5NF/FI/ZP/h2rWGTBHkCERf32T5+R+A+6OgKIoCnB1z20BHsrBV/
	 +6OtJ0gGekNMRdLvbcuB3QJpLfbg2nMRaIexVvkBHnKB0a4ABGO9ARk8264/CP0lJbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JDW3C0JG9F+VgV3yAEYWd1Rq691qrVYJKPbnw+u7tgM=;
	b=P34NcJMK9/kxbYHbdYPB08QI39ATG6jn62Q/e5gtjiMlwoyPB0qIhqsYWGDWl8GLRT0L
	 WL5MUTVnqJw70qhDaWUs/Ic57if7hG/f8UmM2tWS6xFJsU0j4ZtcoN6ywEMtrWWoh+X41
	 s8o9tA85vr/VJqjPdbfHyorYvEu3IfxCFzsS7bf962lAYN1B7D7sBq1r40LsW/xGylzUO
	 Q4j/ndivw3C125TtCTo0RNfFVBBpc0KjCyIdJeyX6fXixzKfIdyyxJVJ54GbGJ37imJaW
	 NG3PTnb0aARoQkHlomnRB1SlQjr+xrMw8lu2+9VH9G+21SXbcwzIRujojVtvn2wzR8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kXFr0qft;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D101460A3817
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 13:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D101460A3817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kXFr0qft
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48df54150dfso1404236f8f.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 05:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793627974; x=1794232774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JDW3C0JG9F+VgV3yAEYWd1Rq691qrVYJKPbnw+u7tgM=;
        b=kXFr0qftq8TpaDfhB3HDXokLdzchLcJzDmVA0zhPPblEpo3JTgmFsJpojcN/BHrZ9G
         3WSwIF35i6AoJfSUkrD4ytMa754Sf8B8AwAXG+pw/q71WkBYxqL+SyCAu2gpTx38JadK
         +Gla5T9a5vJdXM7PYhInRx6R1gZK9IwsKw9XVzamXU+XL67sKpja0v4JCaf1VYVMbsJN
         YOiUvDokYHkWF1Lsm21gaeoFrw4wSeBcF5hvw2DJot6QwqBFf7xUaDuLrGCE4J/4Y4S2
         +Qm6qYH545glnEsHbBm/1v7TsObieZnz+0OfrMW7O56D5pFbNSxQzi2/n5DoFIDix8Op
         rC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793627974; x=1794232774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JDW3C0JG9F+VgV3yAEYWd1Rq691qrVYJKPbnw+u7tgM=;
        b=uR3sIujkPaQI2+/vGTX6bHNGrGctXxPAaRyUqoxWiBb7LDbJ5MH9V5qRzFJZ01h6EM
         weAXJ2aIi483vwwWfztgxGVqVhO49xR3FoRiFvru/p9H1MTUl4FtvehfKZekMw41mM20
         +ZB9wgUqZWEWT9znl8DDqOKzro1Jo5CKeYHn/d5rWdOoZxa5rlaFcnoby4uVUNSjRLPZ
         EmCzmxpXGBa1DdfiHU9m57wxcNxs+NVgFzj1cL2iRLtxB6/eWPbPXo2CNRwqBziXYBWJ
         7keYNqZi5Jejah4q+TsgkY/Y4mnJrAhQxIR8I/aYX++X49Xc/Y52AZySUdfkBN3xQSeC
         /1XA==
X-Forwarded-Encrypted: i=1; AKwUvBzupL8AVQdY+3iB2dTVGiCqu7nAZ2dWlmgEG6Ou9hLkG7xjGqMoQ1uzgp72LBovFVqgCkW0B/o=@vger.kernel.org
X-Gm-Message-State: AFq9FYICPZhXbwLXEPBsPpUcfgUWF8I6vBS7+lfpMRsGCeqU98cy/Gtw
	BT/yG8vUBL6grntLD/WTERffEKyoqsfodrNSlNfEH/v/uo/W/ds8NDw=
X-Gm-Gg: AYBFou3kr3PGLHirLGJcGoeNzgkpW7YwVe8X/VE1f/kQWkD3KPJFt9UgMQlMuFzmaMJ
	BQ8eMwIwfrQ6ml/UiV2M5eoDf0jhNoDzPLcJP/peu2EI6GO6gtlFs8o1WILp+x62Yhi75YnSwOn
	QhUvFXTzJpF2oEt6D7Trl/kgFCusOHv+mNEXRa+iRESzrlX8DQu0xenxy6/ST1aYxJafE3LCbcW
	HWe96fjgelqiPZER6i6EN6CfVzdqRaAMhxNZMb/gc2rbTh4LLiz9J5ma4c+a90WspuYGyuU0LST
	ZRLCaDa0EaikHe2o7wWWb7R5tjUsHpqVcXqzpm6dYgUKZVQ/gnYupfMjvoNBIp+PEtHbb7Vj6bY
	KXnJ/H90I8JHjFItu/ihOYvUr7tAQoftDrQvNNZnSX0xOgEhlxvbJE6AtfFben8L5HYhJ+QdKEq
	As0hY2r9dkziBhUPbIvldeNNPHb5zoeHnTehJWpMVWjlRzmD/fwn1tEluCka9uEqHTguPRhysca
	n8SYLxtGMiqxyucn2tvLw3PixycER4GO8IukrC63aBrrF5+4OTHg1WA/kf7QlPVdVwCbEtcQvPB
	/sr/Dxg6K/U=
X-Received: by 2002:a05:600c:3d05:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4ac187a6960mr231274955e9.27.1793627974216;
        Mon, 02 Nov 2026 05:59:34 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6e63e0esm352680265e9.12.2026.11.02.05.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:59:33 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: briannorris@chromium.org,
	francesco@dolcini.it
Cc: bzhao@marvell.com,
	akarwar@marvell.com,
	linville@tuxdriver.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless 2/2] wifi: mwifiex: validate command response size against buffer length
Date: Mon,  2 Nov 2026 13:59:30 +0000
Message-ID: <20261102135930.701845-3-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102135930.701845-1-tristan@talencesecurity.com>
References: <20261102135930.701845-1-tristan@talencesecurity.com>
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

mwifiex_process_cmdresp() reads the firmware-provided resp->size field
and passes it to individual command handlers that use it to determine
how much data to process, but never validates it against the actual
response buffer length. A firmware response with an inflated size
field causes subsequent handlers to read past the buffer.

Add a check early in command response processing that validates the
declared response size fits within the response skb.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 6e04d7da62179..f59b53c2e7b5f 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -821,6 +821,20 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
 	orig_cmdresp_no = le16_to_cpu(resp->command);
 	cmdresp_no = (orig_cmdresp_no & HostCmd_CMD_ID_MASK);
 
+	if (le16_to_cpu(resp->size) > adapter->curr_cmd->resp_skb->len) {
+		mwifiex_dbg(adapter, ERROR,
+			    "CMD_RESP: resp size %u exceeds buffer %u\n",
+			    le16_to_cpu(resp->size),
+			    adapter->curr_cmd->resp_skb->len);
+		if (adapter->curr_cmd->wait_q_enabled)
+			adapter->cmd_wait_q.status = -1;
+		mwifiex_recycle_cmd_node(adapter, adapter->curr_cmd);
+		spin_lock_bh(&adapter->mwifiex_cmd_lock);
+		adapter->curr_cmd = NULL;
+		spin_unlock_bh(&adapter->mwifiex_cmd_lock);
+		return -1;
+	}
+
 	if (adapter->curr_cmd->cmd_no != cmdresp_no) {
 		mwifiex_dbg(adapter, ERROR,
 			    "cmdresp error: cmd=0x%x cmd_resp=0x%x\n",
-- 
2.47.3

