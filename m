Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541790;
	b=c1z3R/VtuWHTxEAsYJWeYChwzSlPmWqCFbnmGMm+3VwEYYUGqJpdprL6hGsUIsaG0EMB
	 QWwxoR1RVWNngzkc0lPRKEjTazVHQpXlMxsf1JEf9v9pDF1jBTs55FmcI0V2HHfGipsya
	 F3Q8d6vpkcYsd8KYcRYEb04yKRp2o0qX4EoTeBX6lpO4VIjrA2Ntg1k7htz47ojB0RV/j
	 O+eNqSD3tqCdYwXrUgz9zSCDc9XoDIN4kdIdv7S15kfdEfvjGt/HWQpQ1r4iyyCnX1/9Z
	 4uM48SdesRaAEM1oOjOMIO6DjTMjoz1aBmcAqXwAsmoRhZWs0yM2M5PdocN+P0PyHkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T+gWk7jbAQldzIm4Te3qJfsfZ1r9nUHOK8HpT65IhWQ=;
	b=ukWlNE2NGnpQnb6+EJRPnh+x0iiw6PNMa3OK+LNStCfJbhVho2nB6wHp1jyhO9FT+DB/
	 /4mxTDkTxLljDg73OAF8V2KcF6p6VDAsARM//1pwWnaU2JRh1ktRF2BPnmLg/8dhk8SKx
	 k13GEdxh6XEQWuYCNEBDEjrqtbdngjC4woAnDkxYTeYRjmVq/kOFcbVrj+vSmKWlOpyO9
	 wZzGxbCaSbswH9GmUFPfUlIUrE2k4WV67CU0y3nxcfbBV5Y5YwylyMrT4Q8hd2U7+tG76
	 Sp8DewmFffCjN3sAaULEm2QLuolqQpXqm2K+ZDnIvbqSWyX0BuQGyGCmV15xzk68Elw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FwixNfKg;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6FA606A332
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F6FA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FwixNfKg
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so46943905e9.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795541788; x=1796146588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+gWk7jbAQldzIm4Te3qJfsfZ1r9nUHOK8HpT65IhWQ=;
        b=FwixNfKg27t0r5+SXYzmPZh0r9iJty6jafsBzMCflDZbbR5Okb9+QpIzeYuHZ7/COM
         4M8xfW8cJsj7Pn8coNecLw1fcY7V0sdGcU9hHsvDqMiicU+zaYxuWdl3s+azTY2J7u0j
         mCdGZz0idXyjnyhy6V7Sx3EFv9ElHGmvbBzGRSyvWUeJMxQtjuOyreWaknJ7aDt/X0q0
         G/p3WqBlNKyFRc6Xoeo8ZdaRTO7V4bOW19Ammb2HIxpBc+qInt0EAIGzgKHLv5T+oHdJ
         i25QsAbrqDOgRn7WR6tgpoZrGOq27J1EdpoACuFo8vLgPfE9jssHZqz4KxAiDEmuAwVj
         hXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541788; x=1796146588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T+gWk7jbAQldzIm4Te3qJfsfZ1r9nUHOK8HpT65IhWQ=;
        b=zTaI2UKFqHnMRPb4gV/f0E0VSjx7F8IkX7Sdp4V8GRIUzWCV4oWsh6+MvBxZnRS/85
         KvqavHDELLO4suRA129r/L9v+HwXNj4mmcEh1/DZO1pZq2Qu3v8COCHLsOFtCmVpk+Ew
         VMvDyHOH6oeKyVtbG8BtDy6FMxBTXxDKaxtE1xNJzri0Xg0QNLkmpCSCvDNkTYeBXLHH
         yADZzz+gDWdmKzHjZG8XEQ4LXBMrMWrisqr65vES+1gHZUDlzqxEQqqULQja20/TwhVX
         tKHrg27OEiOON1vO0SYOcO8YqxlTBLCRcpYEyXf2MhJMg5I2mqQWIq88JC+/lzhAypwM
         YhWw==
X-Forwarded-Encrypted: i=1; AL+hErFTqUG4sLD8SbdSxgYxIHDwx4cQ37zml8sSR7EM5Z7jTOOeb6eC9lEcxXa6YINRC10VsszjQTs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RssdIgEZkqcFzHb97pVNiLHgH8BfkbF9q9yefjTlN1Jt0bfV1
	TAgwqoOkc52/qNnoyvpXq2NrePLby2qvGIiwCDU8p0tgvgh7KOedvks=
X-Gm-Gg: AZFdTZfWosn25dasUQbdDRhGS/z9eO2AdTjLCFBZvgy693HNW0bkV+HfLUQcuxLGi+4
	muf3NuCRwFBC0ByPa9Bb4WOCQAHQ9QIMxyOFbbzBXh+gN9LMZuG7fA28JhS9SJIzDWjgUIiXvnK
	PI7zwITBxsXSkQUU/el6SMPlYyMt9DXGcNNiTO/rjAxuELsL8EX1aVXDstr42+qb236LXnD9d55
	dI+9bmqomZjfwCWiR5IToRvTxiJ5+xLNDlMArCcyDBk807L8E1fK6wnioBF9ZOL6MquuPN26Cr1
	l65QiWvI/rGngxPyT/fAe6xnIiET//EYKJH2RExPYDR7+cVG7oee9Kh70HcCx8jOKs4O2ButBBg
	2HnZduzvkT8+YGoRPk3Hdsw9wTKg8F6wDht5G1C8oI08o+GUV1N/9UD8f3lPqjWmWLYWA4sme6d
	6du5iqzO/FuyHBPL/NBdZsMUVILtuXMJevuflIuu8E+s69wXKaWDZJeyhbfdZuU/WgfQ+zMWIBN
	eZO5Y2tn87e7Y30t5NvW0Hp3GElNtj3RSNzhpqvNenWqdaV9Ukwk5eVPLnPkW1trRgT76ePWvIM
	sqHR6xHrqWdin3A=
X-Received: by 2002:a05:600c:1548:b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4bb88800020mr340879635e9.7.1795541788246;
        Tue, 24 Nov 2026 09:36:28 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90655f5asm267098675e9.1.2026.11.24.09.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:36:27 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Jeff Chen <jeff.chen_1@nxp.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Bing Zhao <bzhao@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 wireless 2/2] wifi: mwifiex: validate command response size against buffer length
Date: Tue, 24 Nov 2026 17:36:17 +0000
Message-ID: <20261124173617.802875-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124173617.802875-1-tristmd@gmail.com>
References: <20261124173617.802875-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

mwifiex_process_cmdresp() reads the firmware-provided resp->size field
and passes it to individual command handlers that use it to determine
how much data to process, but never validates it against the actual
response buffer length. A firmware response with an inflated size
field causes subsequent handlers to read past the buffer.

Add a check in command response processing that validates the declared
response size fits within the response skb.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Move the response size check after timer_delete_sync() so the command
  timer is properly cancelled before the early return (Jeff Chen)

 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 6e04d7da62179..62f0e3152b055 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -831,6 +831,20 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
 	timer_delete_sync(&adapter->cmd_timer);
 	clear_bit(MWIFIEX_IS_CMD_TIMEDOUT, &adapter->work_flags);
 
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
 	if (adapter->curr_cmd->cmd_flag & CMD_F_HOSTCMD) {
 		/* Copy original response back to response buffer */
 		struct mwifiex_ds_misc_cmd *hostcmd;
-- 
2.47.3

