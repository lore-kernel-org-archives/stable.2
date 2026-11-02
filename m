Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623746;
	b=jcGwflV0N/jJ4tVTwxjO5MMo3tbT7By+5ihC7a4IXSU3jcyEcPHBuMBGjPO7AH6lJ+GG
	 vwpsRyL1Q56UoP50RqfQscSa1IV6MRXLJiS6zCJUfHYNtK9t0UbldAsFq/pgRgiSRl+LQ
	 q7ah8MnS/OSSolEbKfqTA2wVGHS2AK7Sy+V9kkXx/8cr/VWg1AXt0BFxG7TiqLNTO2/79
	 geJ8TVeFR7ZKzMR/jaKQyNrsC86HimaAl1L3c821LFJy9ffQZZqI1ne5US7+q2wI5owDq
	 zBzGugKE2OuPv3L4aIzvn2KhIVFTAtnTKxaaaY6KjSWEngp8fuZmr6n5csMw57Y0oBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6XnqB70rXSs+gjzhceVbINLoPc35zaUEJn/5DXHkxzA=;
	b=jmGdMl4WZMqRpH3JKuu4cYXmC1a9q6QDp9AFYXEJblSrM6lQeeEaoVraESIbDrffj4Bt
	 GnotCXatMIqE0OOnU3UMb8u5+Bdm1S5UhV8RvrftEZtjIE1k7VghPsc3wXKLNhHKcAUIx
	 SWDLx9zJTXftZ06gR+lMVxRhqP7/Qjlw9Q7VQkjc7FiXRW0C9+ergKsMkrDHaWo0J6mzt
	 7jr5SPVJ0hurBXl1nOTvArue79D1pjvAgE/e+9r0vH6FXtVXF9p2QcUhJDN8QXT40a9ti
	 LiT/waz4Bxipc5/VDSrMIyI+hKdwYyWGAagNvnibFp7Vh3ceTv665Sfi/2pvrP6/aFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yPFET6h3;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E0D60A2633
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37E0D60A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yPFET6h3
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e0d1da913so2248757f8f.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 04:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793623740; x=1794228540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6XnqB70rXSs+gjzhceVbINLoPc35zaUEJn/5DXHkxzA=;
        b=yPFET6h3ymIhzYfTSsZwQqIEDHtlUaPrM3o+jCOhKPl48hSOiJ/XlIS+P1rehHbLFW
         WI5x+rlX0Hy8b8kPIdv3MjwSWESjt5qkMuB5wv3uz/bL9T5K7it4lcUH06aN26njy55u
         YAvuS/ATk34QZBaUn24XtvGM7cfqakpfSBorVwZpuoNAwFQijIKJtMjB/1uHz0MfToir
         qits2/pTRwzSOVq0sw6Z6LFZXqL1PNqb3RQCN3H8v1f8hA1mrwzW9dqOAEn6f21h4QBe
         VNiUuC26oEx2fgJ2kTpg1UmyY0ETkda3+TMfO22n6EfzWos6bTry9AtLWKiSPgc/0h1C
         XZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623740; x=1794228540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6XnqB70rXSs+gjzhceVbINLoPc35zaUEJn/5DXHkxzA=;
        b=LCwWWt/48HJZf86+G3BzhTWVyJ+jGd6AjsPEred9RzEd8ZuwlDMOxNy4IzodXmJ27V
         7jg1a7xY6UIg+E2rz1irq0HWVJLkfWYp4KgWhSLN/OUZkb4UVlG2gJ/ibqajGUETNO/K
         6bAYWTDA+le5PZb6wJ3rxfJsNZmY44BK3MWSoo1O+FeI+XbN3zVC4v6n3iL27zyUvWb2
         CQJPx++aniyhiMpx2ce/LxpHTN4EKudewChMCllaFPpR9rzbPXoOV19e9M2iP9yRkGSj
         7UdJDfql82BixTkMzDOFMLN9XcAdPgS+Bqs4SIm13R7oOXQOpYJLwUCJ1f9j6IdbvIaV
         ZKOw==
X-Forwarded-Encrypted: i=1; AKwUvBxM47VywkKG7OQA+4y6xffmIKR9oBKdlB042QZ45p1GjoMVAsiWraW6/1AYeZUnogtzcSP/vgU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9V9hESRTbEsjEfV9O8BHja810CacrS14nvcO8pkfKRurroTWYf
	UM1A/IRC/jEq1g3gxEqXjhXA7A+o7HlxHIvefH/hxImtvgLGsAOPvMf+1FEE
X-Gm-Gg: AYBFou0Q7ncLxht8kJKPD2z7LFbDOvkju5q7H64hbh5Opt4S45+rgfG3sDoFdHhRfsF
	mgOOZ/BXu5072/ZZLxM4pTJI9NLDEOi7yla7LYFeFfaZMGbaTzeGnYbUAZgWXtAZ0GQd9nO+nXF
	X3cq9rUI/eTEhOOQjtzvZC4shoqqpZKjJ/XBrhB0+sCJZWYgiaMFioB9oO7PEl5gpjppuH9h6C1
	AiR4zQLXL97yPBLIgrWRicnv/wPOQowCTDKlRvnmclRcKHbNxQb9yxlXFDoW/maWNdzNFkt8zMp
	XptrOtm30JmlziIlWlCe2aa2b3gMOSC1yaimO6p1qvEzc9ejfk+KMIqJi1+bHlNCZtq3RnAe4op
	GqzZ1jND4n+M5Ryf+h8ECfyuEj7kz550jJyL8/IMjzUixkUK9tY6iUbk6TYLENqNIaZ/EA+KNSJ
	QN8cSU89GKPcJnngre1ezwYyNyVKuG1pwBzrB21HLm9MrIFLQEaL69/u6ZsGH5mcOjtIJ7BzGT3
	iviQUlBfAPxMTOg4kbgyWJYqQ2jg+d2QC0VOQx4v4jchq/EUoFWmCGOiKhtXaKvIBh5Ft6xhg==
X-Received: by 2002:a5d:5d0c:0:b0:48e:7833:2e56 with SMTP id ffacd0b85a97d-48e7833321dmr15104937f8f.23.1793623739325;
        Mon, 02 Nov 2026 04:48:59 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723bfsm18719736f8f.15.2026.11.02.04.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:48:58 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless 3/3] wifi: nxpwifi: validate command response size against buffer length
Date: Mon,  2 Nov 2026 12:48:54 +0000
Message-ID: <20261102124854.325979-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102124854.325979-1-tristmd@gmail.com>
References: <20261102124854.325979-1-tristmd@gmail.com>
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
 drivers/net/wireless/nxp/nxpwifi/cmdevt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/nxp/nxpwifi/cmdevt.c b/drivers/net/wireless/nxp/nxpwifi/cmdevt.c
index fc1950a125b65..50aabf1a72b2e 100644
--- a/drivers/net/wireless/nxp/nxpwifi/cmdevt.c
+++ b/drivers/net/wireless/nxp/nxpwifi/cmdevt.c
@@ -722,6 +722,20 @@ int nxpwifi_process_cmdresp(struct nxpwifi_adapter *adapter)
 	orig_cmdresp_no = le16_to_cpu(resp->command);
 	cmdresp_no = (orig_cmdresp_no & HOST_CMD_ID_MASK);
 
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
 	if (adapter->curr_cmd->cmd_no != cmdresp_no) {
 		nxpwifi_dbg(adapter, ERROR,
 			    "cmdresp error: cmd=0x%x cmd_resp=0x%x\n",
-- 
2.47.3

