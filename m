Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACDF37756A
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783754024; cv=none; b=dg3LEDkDK+X9JS06iIMJsLyz1Ucxt76TlZj9y1k1PQE/tJrqBdzLJ46TbkTyBxkHeeVvo3Qy8HvEjzfcrBeAXN+5xvVhPQiW/VG4WVq/wkyAocT+1pS9lSzLRfkQRlAH6WV42vG6xUwPBBEpA5qb+vROUtV4kwUHCkaMl4PNwC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783754024; c=relaxed/simple;
	bh=+/tkY4Q2PIoNmSY1FcLszemDBSTTa8pciPDIAh6Unuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gtgP9JiAVgQ27w5Sj6qAEFtdZ5tHlwsYPmpkc0qsyhyrWtc3QzyGC661XBwDd8By9J05FLC3/j9zDq3Ave0NplhSoxLqxzTCCq32IzG0m0JYs//04NX5ncCzcmqjxY1HOLDI6uiA8eVeNJl/O2NXpZE+piFL7FyRw4c7HJKeoQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=zZjQOj4+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="zZjQOj4+"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so7850905e9.1
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 00:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783754022; x=1784358822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dEi1m+eaAK5Iu/90PGDOyH4Bqqrw8wWIiPdDe9qpKnE=;
        b=zZjQOj4+N+RwhF0Ipc/kaaFTRi7StYKtnHdJCdkr4ph+4ukZdRREQRCBZOtS+d78ha
         FLmcKcv/gtsxk6vt4Hl2J5DK7mxymy4XDHvcZ1bSv3tUZ9XQ7mhTtLRP7RwzEWsXINo4
         176V/NzegZdQkRZTvYJLjEZDr9EBtFYMYtTg03xoc3KZWq4zAnNK/telHlXCRh9O6QWC
         pCRoEaB/UyRjqiOszlSz/6r2qYUq2BXp2442N6CxP+Ggbks1TjVntRAtsMkjr3JG33Ur
         ZqDIp7/H9P3jWyFGwYjXtNpEd0UzrVhd0QcAI8h5fU15y2uWADj48x0AI+fnA2oluDEQ
         WAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783754022; x=1784358822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dEi1m+eaAK5Iu/90PGDOyH4Bqqrw8wWIiPdDe9qpKnE=;
        b=eHudHLPAtLL8hnRwdn1ahuz/14etf5JV7tUfiRIDUs35Uary5Ps/jb3DtKsLJBo3ec
         FkPubyDSNsMoE27u9gn+qz1nD3ve0s2F29B4RA0PLAQkXZyamEbIy4g2EeUECkba3e2J
         qxv/LmX+apOcAYxQ2GDDIAXG42He7u7PQHj3D7x2Msjg88xXOYNGzX+7baQV01qfnosz
         IuJO8s3fKLNYRl6qxrPIh36WZoBzfiU1ueHpZOD/z9VQwaMsq16kYsr9l3jFYg+p7Ri1
         YxP3a/2Dbg7gL2bmYV3+mjhVEpScFA9z5JLDofS3rNm8SWQquhDONkKDZXQ+NtT9CCn3
         zH3g==
X-Forwarded-Encrypted: i=1; AHgh+Rp3Y+QRMaFbHFyCloTn/nIWpyU1f9U4r3tK9uoOd9bWkR3cD8qzyJhXXLv9L8Gb+ouaorgxlDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqVfaly1nu+SGJJh6Ln/obCEp/de+G28DHzxK3+VBzHAUAGJDW
	sgIDZbhs6aiI/Nt7bv2T9qXtsV+Xr/N/Sa6OiEvZXWR+YvP9SjZ8oIMaDtOEOS3jjYhA7EBg1oX
	12TnmQcQN
X-Gm-Gg: AfdE7cmIlJ8ZwOloAeylX2lbZuXq9dyVmC8PMp3BvtcoiFcaUvL0Ka5Dr5EgMKcG7I3
	p2KsjY66k2c4eZVf4yW++gfj9nsfi3niqNqpA06JBgSr3KzgHWQ12GKfnEGfKwK2HbjmHxlo905
	/jakk1oM/iDG+L0vpkEPUk/blav+FzP554BYUQOP8KWajqPIRf5tyF3OmN5oEUXNWY0bvoR+/wO
	xnT5tPPn4qrqPTdSTM16SbOiz2hSuFosr+WfkyXil5KV/uj7txDRLTxbeurMaaXtjHSGww2Fo4z
	Hu72IiYZrwMJJT87hbOxAChGkZ/Rl6ynE05X28bbbc9FTMg0IFJsqnv7R9kYIOyx/PZ30v02PTf
	3pNh2VYYJt1C4wHtyGrSTxfJvrrTj5RnraAOB2v40ipABiO/E/4NOtjkFqf3to45V+H0V7yVChO
	ox1h0lUWzX0yfNq+ejOuv/GaRjDmJekFiQC1sezzXr1HUJTdwJH2KZyv5qrIN9DHZaFywiJnoLS
	JLpyjwFgr9CLf6OvHiGJBZtwRgIxO9CMrk=
X-Received: by 2002:a05:600c:5395:b0:493:df5d:6ca6 with SMTP id 5b1f17b1804b1-493f881de70mr14942685e9.25.1783754021017;
        Sat, 11 Jul 2026 00:13:41 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb742a49sm185161215e9.12.2026.07.11.00.13.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 00:13:40 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>
Cc: Liu Haijun <haijun.liu@mediatek.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] net: wwan: t7xx: validate control-message data_length against the skb
Date: Sat, 11 Jul 2026 09:13:38 +0200
Message-ID: <20260711071338.58345-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

control_msg_handler() handles a CTL_ID_HS2_MSG control message by pulling
the ctrl_msg_header and passing the modem-supplied data_length as the
length of the handshake-2 payload to t7xx_fsm_append_event():

	ret = t7xx_fsm_append_event(ctl, event, skb->data,
				    le32_to_cpu(ctrl_msg_h->data_length));

data_length is a device-controlled __le32 that is never bounded against
the actual received payload (skb->len after the pull).
t7xx_fsm_append_event() then does memcpy(event->data, data, length) with
skb->data as the source, so a data_length larger than the payload reads
out of bounds past the control skb (the destination is sized to length,
so only the source over-reads). A compromised or malfunctioning modem can
trigger it during the bring-up handshake; both the modem and AP control
ports reach the same call site.

Reject a data_length that exceeds the received payload.

Found by 0sec (https://0sec.ai) using automated source analysis; the
missing bound is evident from source. Compile-tested.

Fixes: da45d2566a1d ("net: wwan: t7xx: Add control port")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
index f869e4ed9ee9..871ed63d3c4d 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
@@ -186,10 +186,15 @@ static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
 			int event = port_conf->rx_ch == PORT_CH_CONTROL_RX ?
 				    FSM_EVENT_MD_HS2 : FSM_EVENT_AP_HS2;
 
-			ret = t7xx_fsm_append_event(ctl, event, skb->data,
-						    le32_to_cpu(ctrl_msg_h->data_length));
-			if (ret)
-				dev_err(port->dev, "Failed to append Handshake 2 event");
+			if (le32_to_cpu(ctrl_msg_h->data_length) > skb->len) {
+				dev_err(port->dev, "Invalid Handshake 2 data length\n");
+				ret = -EINVAL;
+			} else {
+				ret = t7xx_fsm_append_event(ctl, event, skb->data,
+							    le32_to_cpu(ctrl_msg_h->data_length));
+				if (ret)
+					dev_err(port->dev, "Failed to append Handshake 2 event");
+			}
 		}
 
 		dev_kfree_skb_any(skb);
-- 
2.43.0

