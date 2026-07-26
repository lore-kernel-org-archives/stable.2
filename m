Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3E1F942
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 05:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785042999; cv=none; b=gxN+DEb4X4VYrV0Cqr2vm94YWnQLuQ2WS2EocIj/Q5bVq0k3oCm35kgKZnWZdJnOQkXnkCBtPamInHnCA7hqpXJ8llWrN7f5wewoOjdN7AiXGc7PZ0IRgymvrv3qLcVSrsYP/jZ3MEgzp63AxrwUAf9QEtzTRJcU/eftaYJFJ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785042999; c=relaxed/simple;
	bh=qQw9JPEm96h7ALUc0SghAENmUNYOa4c6FVUiTYHLPnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bD+rSNPF/ovT0hWfE9K4Xhhp9JbPUcZrSqMgsjuK2yItLFoIyaDtzvgk2CY0ueYjysoT+hrG4df6P8q4rKJNfFzT46qk8Ny9ERwPTDmSaNBxO7VOHBm0U+redzEahdcgcknEDJe0TVHyi9avLdogbJMhBfuWAtP9tnSOsIm8IZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=WFDJjNCy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="WFDJjNCy"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cacb8416a1so16060835ad.1
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 22:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785042997; x=1785647797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tzWhDyTff580ghlpgewRs7awFwMox1Cw1VJXwDERVqI=;
        b=WFDJjNCyzcM30HiNfDCZeyARCvy2Nwb/yqQsWaF2JfY9sMop/6m2kfP6w0xYDay9cj
         G+jYrI0FiVHnfUKW9PYMyv057mimcNm6W7qoadNy3NOyAZRFkvlf4+7PAjsiIZPdZ7jX
         mjhOnwmZI0OGxUPeR0WlF7I+B1NL65Y15bMZ1RTzuEOCEngduXWyQZvmomuBvTAbexEq
         2QgA7DsMF9/ov5xtRN5Bk6ePtWMPLSCdoHVyX2yGfrJbDHwnkhHbm/gM0haMIelmaThm
         70qBExfT9IZBClGi1xbL4EvF2hwZvec62HSpk4C4aDQKBYU8hzodzhc4thr/nFZpYy3O
         TZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785042997; x=1785647797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tzWhDyTff580ghlpgewRs7awFwMox1Cw1VJXwDERVqI=;
        b=e1e+/fInOVqMBe4gXP/+S/9dAvFm6UFZN2Pk1Fmf6D4nt+9527QR1qKFH83aAxbvq4
         m6a26YEu6RoRa3R7XzEMiNryfHVGvS+EmGXNffIiX4LTYmV8mD8uSeUkW7G0gDfPa0gP
         xFCaQl/l4GP/HvcXmQ6z9aDc4WZAwrMNaNIlBQp4tk0cUtIih9oGoQau4Z3RKphw0g14
         Gmjt2YR7edSg7jg97v/z+N0U7V7CT+GxqXnLsq4Ns+iYN27BBvyjI1bzxoUwmci1mx5A
         2EJTaHRDvzlSmqArBpOIML6OiYjJFZ+9Vg3PA70cOoAvq+mnAEjvACP6VWq4PgPl/Y9k
         TRBA==
X-Forwarded-Encrypted: i=1; AHgh+Rog0+ruYQm3zTfo5AOeRycUt5GaRK3umsV0HdXQLp0WZtySwFxH3LKFAuxCLSqcLoj7W77cApc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRBezHubGJUOahP4uIwex4jXlpZcAKmJSn5rDw35nNQIKTZegd
	exySYn89rfsHnmxf/zmD5d+ZI3g1Br5viKVY6kGbvNYKFDf9ZLJ6AVBjb2o2DKCf3xK47VX3qec
	jcpLO7Xg=
X-Gm-Gg: AR+sD10g7f/XGyl12l9XfBYvA7EAG82afocTY9nBeJkVgTiHl9ukgenhyBEaN+0XINs
	MdXXGrlrqdXkjjQMnDfbi8wPQGwqqjllTFDPei9Etu7CnFHt0iawWB4tEX7ko6EzPEx9slLGfkI
	cjK4C3iUvejlTqadYQlHJbr99Z5pgW7K6TXvUM1nOXRMY1QLHwXm8hyvngoFlXY07gvPN2eNQWr
	3hx4xliDl6qLSx5q5rrB9lf8Ac05WkcYWs1cn3oWRE0oCSAzl4WcNXx1HcQgB+YPsMUYzKLvU/p
	ujn0zHzekm0aoSEQhLOaAbp4j94kwHLO1Eg4QV2UG1jSKP8+xWF84bcRFXNn/gCbw09+La67C04
	Q9i54ycPK8C/SqvPGc6F9MfmK6wFrKNHASCHnZJKX9ak7c95+iRKBTgyj3cXeYNo00l1vidMO0e
	GYBW349t2y3BXgbZj0TufXPNj2BzjwB/2GHxlyZeO5rvrfxW2k5wGqEnkpT+Tr
X-Received: by 2002:a17:903:2446:b0:2c9:97a8:afef with SMTP id d9443c01a7336-2cfde8673a4mr38550675ad.40.1785042997347;
        Sat, 25 Jul 2026 22:16:37 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5c8337sm16912195ad.20.2026.07.25.22.16.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 22:16:37 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: linux-sound@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: ump: fix double free of out_cvts on rawmidi error
Date: Sun, 26 Jul 2026 14:16:33 +0900
Message-ID: <20260726051633.41206-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snd_ump_attach_legacy_rawmidi() allocates the legacy conversion array
ump->out_cvts and, on the snd_rawmidi_new() error path, frees it with
kfree() but leaves ump->out_cvts pointing at the freed memory.  When the
endpoint is later torn down, snd_ump_endpoint_free() frees ump->out_cvts
a second time, resulting in a double free.

The host snd-usb-audio driver attaches the legacy rawmidi for any USB
MIDI 2.0 (UMP) device, so a device that makes snd_rawmidi_new() fail
reaches this path on enumeration.

Clear ump->out_cvts after freeing it on the error path so it is not
freed again during teardown.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 33cd7630782d ("ALSA: ump: Export MIDI1 / UMP conversion helpers")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 sound/core/ump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/ump.c b/sound/core/ump.c
index 70520c7ca293..632c13baf21e 100644
--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -1365,6 +1365,7 @@ int snd_ump_attach_legacy_rawmidi(struct snd_ump_endpoint *ump,
 			      &rmidi);
 	if (err < 0) {
 		kfree(ump->out_cvts);
+		ump->out_cvts = NULL;
 		return err;
 	}
 
-- 
2.50.1 (Apple Git-155)

