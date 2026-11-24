Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542392;
	b=2rRCAp+IH6rEaV70AghxafE9TfI2wKAesnlII3zYftDrnSREX+9f6AuXSW7B7VAtdOof
	 4b8DHxSFQJqOVAaoLda4ZNnHq66fHaBTD9hBP03LxWOH3CpoUTP0ynq2rHbIftkFdDv7W
	 pRJrzTyIY49JnjIopeYYTHWNMURYZp2YPlx86aWQRT46wxEHhRUDzxqLTO0r+CfaLHwad
	 lUpImGChw7M3gjHzALuPVuqMQV+2WD1X1KWzBwNaGmPDSSjJMRFg2aFtGl4+DiahltqtC
	 +JblqirlfOYE+O9V1FDKMsvOBQJoZbsuON+9NDj8ucoC6XY5MXE5YveJvaTeHlbIU+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eJ45RhdWQYaNGviQo8DZFSlW6V3bfg/JFh/lL6cjCXc=;
	b=J6M5hLklQ2nub0aQEoKFf37Z+hh8JGvnlqDhVGFpMLJd0Y6fN1rjm42Ah0fi47cG+zeh
	 7dA5U43NLEBIjR8aZJN+BEp15DtTdTRRO+lXmoHC4DSPUpUYrFSW6ds78jx8NJiqAZtbI
	 Cus7fXdB8zn5elzYu12a+Z4gX3i3glojAlb36S2ZsJ0AfyKqeG5n1CHLou27iFap5e27x
	 1f6J1Yc4lki/dceJs9pYsFNdBmtg9iNFSMjlQNNYUOYTnvaqXzm2bI35MoZMxz4Dv1aCO
	 XeHfwR5yQSISN7a+TBQE0t0avC3tGtvvs7TGMbl0ziMh2y4A4yhOJGHJw/Gccpb0JOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bphLsgMU;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073AE606A330
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 073AE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bphLsgMU
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so52366575e9.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795542390; x=1796147190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eJ45RhdWQYaNGviQo8DZFSlW6V3bfg/JFh/lL6cjCXc=;
        b=bphLsgMUcTwPkjB8anUJ99p+2VGCLqKqRkqXlsXy+lJpPFTBWwtNrZbN43+4vIEd7h
         lJCzArjzpNkZnTQqhPei8hZCob7DexbkSPZcoDrOKH67Laytffz+gAsY0a9pzy4gzQLp
         U0sHfaCRzSKgqWYjQf171AVeHpCbJZyXUXNHUHHZ5mb1HuvpPpwpVYiyk4qlI8g+NxGi
         QixorEntJmNC7QJbhyET2CSBtHhaOXJlc/57xXCULfx+fxzpdyFJZelq4GjemFr6zju8
         WPqdLtY/7DxoMutiY62Cs4EH6kDNXxxDpBr3cMvKs5Nk0LNSW2fi2cHELw2/jVukN49O
         4//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542390; x=1796147190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eJ45RhdWQYaNGviQo8DZFSlW6V3bfg/JFh/lL6cjCXc=;
        b=dDVYcPz2aVzp4TaGT1hZfZsVwsu6p6k1p68s8KA8DHAj/4NirdeKtMbKKZRgPEMWzt
         fdvOcd9zOUypPLnPuNisv5UcQlks3Okwt4Rc9HzYS0OltmHWPS3XKeWZwhn+5PF4v2CR
         UTA1ZXeScjJyW3RpXf0DxSAmwaIQ8H5uMIClCmPMrmCseMmjk5dXLb+EVbyRZK7NKY+u
         XrEKG0zKwx4CPdykgcj5lHca70EIVWN7XeYTWkh/DBdQyZbAEBVmb4aEWIYiSz42BZMs
         0ElPC/I2W6Ri13HBu0wGqIbFv7E+5Ez+++lqpmWM62gRVdAp+m1LMOq7jHYFH4x3vq5E
         Jilw==
X-Forwarded-Encrypted: i=1; AL+hErE/18DwuHWgiVjHRSPODSEiVQZdFHoY/my8aP6S+DdAdTxxO1JLL7stVm+nCdqdlgX+XUIzQXU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Z/DUwRnPZywQgsfMviC2vVIYzkhxqtXvv11/w1bW+qod86Sxz
	09eWQFe2wuEBTgsK2QwGFXOfA87bTZ6uiykkLUHXaZ/2Un7nyGe8MsU=
X-Gm-Gg: AZFdTZcbKSCU21IflC6tEVlPYVdnsXMGrIurQ0cihrRyXvDiyWEpQgd6NGWZMLQx26a
	0wUe/4I3F1JlLebLLGaZ03Yt/a8ZWnq/xbAPs07SeDUTjDbGXYDP610BlCWf3ZAeEhf7ZTHeOIQ
	sLRIpom+7j7w+Wz5c+8cS+uoU/TCJ7nAzUi9BWW3jyUlPZiDsUwpjOSJf4dx4/kNAxQpE2poDOl
	l8ArWbLLPDhFD64v7MODOoMSGXvjavi2M3D01rwhjPW8unjA4pZ1qN6YJtJCJmuVAcAfcsg8yMb
	ltjTJOZF1JQKJq0VvAAq/V+SBaBpKIMvg4vWmSb+7KynLaqyaRfAlf42Z7NVSV0jZ9diyAK3faA
	nH8G5DHehGjv8LLhzmYrNLv6+yz9HA9jMWF77IK8tLPBqpBf+JZRldRIJcs7+TcaYn+k7XnG/nf
	xIr/pIDreiz8j1HYNdq3eHF8MHwFMLYYPsTPVLi7NIjR6c1knuKXICYGo2qPDSynePP0p4eJbwH
	L3lc1Cziyg6rya8aXmwyDTyMPjbT2Y8ureU24uUY8a8mK3T9PV2WolvxhsI0YQKn8SHu64IfTgf
	JUEadgZ0mLiG3lc=
X-Received: by 2002:a05:600c:3b8a:b0:4ba:761:c0c5 with SMTP id 5b1f17b1804b1-4bb8880f0e0mr316226585e9.5.1795542390429;
        Tue, 24 Nov 2026 09:46:30 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b39b6sm413261165e9.12.2026.11.24.09.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:46:30 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Jeff Chen <jeff.chen_1@nxp.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 wireless 3/3] wifi: mwifiex: cap TLV length in IBSS connected event handler
Date: Tue, 24 Nov 2026 17:46:20 +0000
Message-ID: <20261124174620.1572200-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124174620.1572200-1-tristmd@gmail.com>
References: <20261124174620.1572200-1-tristmd@gmail.com>
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

In the IBSS connected event handler, the buffer-bounded evt_len is
replaced with the TLV header length from the firmware. An inflated
value drives the IE parsing loop past the event buffer.

After the fixed-size header advance, check that curr has not overshot
the event data before computing the remaining length -- the
subtraction wraps when curr is past the end because event->len is
unsigned. Then cap the TLV-derived length at the remaining data size.

Fixes: 432da7d243da ("mwifiex: add HT aggregation support for adhoc mode")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/marvell/mwifiex/sta_event.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index 1f746e8f6b3e1..98f33ec186e63 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -45,6 +45,10 @@ static int mwifiex_check_ibss_peer_capabilities(struct mwifiex_private *priv,
 		 */
 		evt_len = le16_to_cpu(tlv_mgmt_frame->header.len);
 		curr += (sizeof(*tlv_mgmt_frame) + 12);
+		if (curr > event->data + event->len)
+			return 0;
+		if (evt_len > event->len - (curr - event->data))
+			evt_len = event->len - (curr - event->data);
 	} else {
 		mwifiex_dbg(priv->adapter, MSG,
 			    "management frame tlv not found!\n");
-- 
2.47.3

