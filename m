Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795215589;
	b=HFAfWPXsztRpHjm2Xj2a8DiGQj6bsSjVIyhnEHT+RaWQ9pvwJXY9Y9Z3jG//NqTiNX3i
	 H2GY0B3nIUhljnb3eMMbCTfGZCmchECk2VMgy/tvQZly9RXsPkmP7GUc7ygZB3LjEMXqQ
	 fDDB4TQyTGwxu4mHMYgwOZjaQBd80CXY01eFcVS7iNWqlwsRlNG11ObzV0UWNLYQVsnXD
	 ZCsq38Sk6MckFVRWMYdNoSHME9l69pj0u+bGoB/g3ez90OBPYaAMpjyHUHspWTn54fiMc
	 OffbHbbU9+Vc0BbjR7yLb58JR+TSYt6e9K/mv6TT0SLZiMd5WwvHpGgIjDiul7Falyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795215589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SVSQbGh8zYpL/nm46MbvuON7rY9JKSGB3zTi9I6pqNg=;
	b=VdqQkVHQo/g/Kmg+1YsXrLeOD2QLZxTBZ0nZ5Rb5cZtjOz4qe1BKpPL895vniDDWivy0
	 eBXCHQ+5/G636u92qj6ZJ8eGvpAkex988sx9NKgbDvoX7Mag6hzSQfaXodSVAtYPT0cwL
	 oIU87JQOsLvXr2pg5Uk/kJdINmnattGE6dRYcruOGqn2qaGoAzkUDlCwqobQ4YL3QyJ6+
	 RPBmzKyLi2gt30/DuLUNwyhGk8AHUkR5fKs3l6TbAOvYA4mv/+9sEzxo+GH9bCRhF3Kxh
	 NO4S4S8BGKUQPBgVPIiBjMV86+vgguR3MYUSGxztfcZ9vx7vnFuif9Rb/w6p8diCk3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDDwoLwM;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDCD606A6AF
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 22:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBDCD606A6AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDDwoLwM
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so17680155e9.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795215583; x=1795820383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SVSQbGh8zYpL/nm46MbvuON7rY9JKSGB3zTi9I6pqNg=;
        b=IDDwoLwM+AcdFg5sxUKH41H46H4Hrx2xTaUMauB/92+3oqndlAdNyVy9t5GwuvMglb
         b3HC/oIB0sejpbWCH4y7db7Gz3mZmcoxvVZ/j0/72IVl/h3eeSZxIFE206s9ISURrZ7j
         sFtSUsFNwkdUUe9I2k/efF9/7x/cAuzCkOGrgFutCYXSizqDerT7JVVcUKicCZJqplq9
         XTu/glDvJg2p9abIvQDL4MS5xkBd5GM7/N2OGARPNyk1V1rozu7ScFmSPfyXCkpGsIdu
         EEliXWfo4ZgGRALY0m/LovSoUTI1YQCXqyi/yPJgk0Y8YPsH0pfspyQT1XpWvH+5EmgR
         4RZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795215583; x=1795820383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SVSQbGh8zYpL/nm46MbvuON7rY9JKSGB3zTi9I6pqNg=;
        b=KqLspL4riPpZy307RTMrE281xL06O5G7f1HrTUoIFoAWohOhpT7LVnlERCSllTopkl
         aj55NC6cOcRSpIOtDP9E7/AT27At+EZecqX3XUv1CMc6qpOBZA81BbgWDEaaH/9XAlI9
         nK9T+1Yozla9tSXO5A5XEEgnl3R73O4oQB5rGh+e/GmHRgseV6WwuFYt6ig23IKBwJdg
         bvTrpiUrLXkSy6CKU/6Rtd+AhE5Xvls+0zs3RdWveYujPvtzz7AhNXBsKHP/JjfFWcqu
         zVximl0iPVdKdnWYBUkSLTZkU74RW62CA4Byfw8Zo7Y2LioC6Bm32rPzAZoOt03+HBwO
         cUIw==
X-Forwarded-Encrypted: i=1; AL+hErEytq4eJDDXqRXNTwUVYcuvHfPUPvOfo1Dzzo1lyUFkFGUJT9C1ZVqBl2bjrp/eJmmyKjdSXtE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/b9FnIuW34IXTzEFjSBKxP18lgB2zbtj5b7Cwq4Bh/Oign/abw
	gQoKtOA0s34n22NtkT1ajbvRKsMkPmwa/onTbhhCvpXptXajtkHZQqW3g1CA
X-Gm-Gg: AYBFou16aPzwSvUP9zJXEO94UKCAJHMWx14eZVbJ+Ztug87Y4M2weG+EzoN0mGMhaPw
	xgYanxgHL1G/lpC88+0g2+jvYMyqS9kKqioFXA/10Tf3F0qEEUX0sAmDcUw8ruNpBTR8gNBQtsJ
	5zMur40Vt4J2ZfVFpsq2xUob447uixrwEld3DnpHLTN/wVaSoi9E9P4dv52wxyKGpiRJOJVlfP1
	Urqkyn0hJq7hra5vA7ApcRndCB/gtRR6SCSPXT9HSCDCVgRA68IpRaOBCRxb7NpR1Fz1oSEbaO9
	ZPeQGh826voJgZXWo3P2ZZLCkloqlp/A6mHQYemOOZJUwBxERhF3hH5unBaGJNcqBvof3yABMq2
	hc8dRrg8yaBEwu+B5FMfPYQqv1UAZ3uZkXhinKvnWStwWfiFRXDL/3WLNWHkiy3YC2n254M9flE
	UCn050hEPBgBMIjouOPVCI2zLJYa5JVZl2xzeDSvWGNe+ZeuAeAUo8TpJLWN9AK/lT0LmQDCttX
	UYOjAzmaA4nYGkLz3x+9ARdMD9Hwulu3Hnk0K/Q81/tSZUOzyB9Z/qGit6267MUKG5pNFrk60bY
	L9WIETZ2TN8V0aTvVfZ0QmzfAJWB
X-Received: by 2002:a05:600c:1548:b0:4a3:59c9:a756 with SMTP id 5b1f17b1804b1-4bb88800013mr112919255e9.6.1795215583402;
        Fri, 20 Nov 2026 14:59:43 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm128863475e9.2.2026.11.20.14.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:59:43 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 wireless 2/2] wifi: nxpwifi: validate command response size against buffer length
Date: Fri, 20 Nov 2026 22:59:33 +0000
Message-ID: <20261120225933.1148680-3-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120225933.1148680-1-tristan@talencesecurity.com>
References: <20261120225933.1148680-1-tristan@talencesecurity.com>
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

nxpwifi_process_cmdresp() reads the firmware-provided resp->size field
and passes it to individual command handlers that use it to determine
how much data to process, but never validates it against the actual
response buffer length. A firmware response with an inflated size
field causes subsequent handlers to read past the buffer.

Add a check early in command response processing that validates the
declared response size fits within the response skb.

Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Move the response size check after timer_delete_sync() so the command
  timer is properly cancelled before the early return (Jeff Chen)

 drivers/net/wireless/nxp/nxpwifi/cmdevt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/nxp/nxpwifi/cmdevt.c b/drivers/net/wireless/nxp/nxpwifi/cmdevt.c
index fc1950a125b65..ebcfee8cb3872 100644
--- a/drivers/net/wireless/nxp/nxpwifi/cmdevt.c
+++ b/drivers/net/wireless/nxp/nxpwifi/cmdevt.c
@@ -732,6 +732,20 @@ int nxpwifi_process_cmdresp(struct nxpwifi_adapter *adapter)
 	timer_delete_sync(&adapter->cmd_timer);
 	clear_bit(NXPWIFI_IS_CMD_TIMEDOUT, &adapter->work_flags);
 
+	if (le16_to_cpu(resp->size) > adapter->curr_cmd->resp_skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "CMD_RESP: resp size %u exceeds buffer %u\n",
+			    le16_to_cpu(resp->size),
+			    adapter->curr_cmd->resp_skb->len);
+		if (adapter->curr_cmd->wait_q_enabled)
+			adapter->cmd_wait_q.status = -EINVAL;
+		nxpwifi_recycle_cmd_node(adapter, adapter->curr_cmd);
+		spin_lock_bh(&adapter->nxpwifi_cmd_lock);
+		adapter->curr_cmd = NULL;
+		spin_unlock_bh(&adapter->nxpwifi_cmd_lock);
+		return -EINVAL;
+	}
+
 	if (adapter->curr_cmd->cmd_flag & CMD_F_HOSTCMD) {
 		/* Copy original response back to response buffer */
 		struct nxpwifi_ds_misc_cmd *hostcmd;
-- 
2.47.3
