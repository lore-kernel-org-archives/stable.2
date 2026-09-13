Received: from mail-pz2-f27.google.com (mail-pz2-f27.google.com [74.125.228.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E613B960F
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 06:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789281376; cv=none; b=fvGz3DeG/63XNrME+wFykISuEVLOsFSj+me4fgqntReW/mReX+iDG1ir0b+znd6JY+z3d6pfXAZ/yMzIiQazvZT+O3LG/CGBVG6eNrsZ2QyePH1kcLDUW62lbRoAee2tezK7/b2Fr1cBpYuj+PdAL20rBWL6ksiItxoru7kN9F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789281376; c=relaxed/simple;
	bh=AuFaBted7/ybu6Z97TCANitruKWhIXrZTsYS1kpRTBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ehWxGtCQMDDL26U6pGVx7lGjQCXQEXl8bodZpDC41Wlh3Jzy0IL+NimFvdnHlA/0Wi3Ry5GziMnxGlJKfO+OWqvSOa1ZGwAJF6zvNs5ierb85hR2So7INkRJUXgTrWhNleEs/BLQcWmSu0km8nkC7i/JRljCLpw+1QHit75AM3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWVVc0d7; arc=none smtp.client-ip=74.125.228.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWVVc0d7"
Received: by mail-pz2-f27.google.com with SMTP id 41be03b00d2f7-cc1cea50dc3so556528a12.3
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 23:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789281374; x=1789886174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PFP3Vj8KSIBbfPKyIBbQZMT08Gt8pVUubEOX0me+VXU=;
        b=UWVVc0d7G4sGBlPEeWNYM1sJDTtN1xDmI5zlhxSCwkDtl0TGceCvWh0QZsl1q+qwp6
         CnQGtxmRxjMHtPxlxhfACtBop6YWuhrOpPulVuFvDizMQ2SzWhHck53CxHJ0Ng6sniCj
         1DaPPhdWJnQ1EXvJj1eA1ofO2ae46Fxsg6VRDq4YDJ6LK9nKdsQfbzQCRBZDmXllJtqH
         ID/Znci18kS0VuFbuO9TmEzc+Ckr1ew6jiHLVYJmjB/ZiXLrcddqx6kJDsfLy3OXJ8nr
         I35Z2U3cH4Fv6OCXBaCS9HNBwYCSfsWKJQl9boYKV4xAtVBn70zkh3jIXwsSnt7Zsrjr
         /b8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789281374; x=1789886174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PFP3Vj8KSIBbfPKyIBbQZMT08Gt8pVUubEOX0me+VXU=;
        b=kVGqcIXUnlTTEC2fMjkjuu7o8g3VjJAScPnBi3WVjSZ+61rLJ3vheLFLLcD7FZ2uEH
         3JfGqZbhtD9ySQnJ0eieik+IOj8jBFKWLrgNZpoP79DUdXIIwoeeACG9+I1exU/BAlet
         nCm9vMgWxyvOm9Qyf9PWPhjJ/9+oDctz8qFMCwg8vDpp1GZoOAMqVsFYkmwiWQnrToWL
         fqDvyfFvae9U5CstuYyC6LorJA2JnGm/X6QDwVkdBfPIS603YbCRx15nlb5HZG4v4+tX
         UVUsDE8t48W3E7Rv2sZwBFvpaQ3phY0JCVbV8i8NkULWEKJiyU+3aWOhwWjwss+tWcIQ
         tzVA==
X-Gm-Message-State: AFuF++nEpVri9FY/xkOSjsKN4v3weazjnkq32oJcpp2bEwYwr2rIxTaA
	e9qhC/ZNEBpUhPNwQem8Z/wsGK3GVo3rsKyqytRFeV2PlP9xLFA7F2o/
X-Gm-Gg: AYBFou1/HDdlDhz5u8MWE7CC4Icld+Wb0KcTE9gukaXo9DXfqVoocIzuH38idTAIPK4
	oPksy42irYNpDdU99oxEeewEQu/Z9MevRaCmzqAu2KycyHetdhGW8RwxfwUWuhTAlYGXz/PCqjO
	60K9s+kMXq9uOPDzSI19OAscF0ecQW0fmlTQIyq/O1X2E6yVPfyGWk5LB3Q6BGGItyARQ0op993
	PcA7h+eY7dTcDJiPv9e945KwA5CbnrrWoQ9zm+YJV4GPuGaNa647HTLnRmq8GPJET4lvpkhnxoo
	3mLoY27QsuWNEX/7RC6rrJZfrViFb1eXjEN3BD2J4Uynp34T68JIDnKxp+TtACqdCGMQ0L4B3yP
	pxrjGZPlMtksjUU+OFYf2NKWR0dhHzRTS3THf5u1F9kwtYrcMizSM9KqAsDtkoTFbxk7tP2gcDw
	cFoQ+0RbLvisNH+qJWyad+8d8gZarvHiinI2/ufppg1FM5V6cgVDAQwA==
X-Received: by 2002:a17:903:2c50:b0:2dd:3ddf:b876 with SMTP id d9443c01a7336-2dd4ba9301bmr99485275ad.0.1789281374229;
        Sat, 12 Sep 2026 23:36:14 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfc56b1sm30770505ad.54.2026.09.12.23.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 23:36:13 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Dominik=20Karol=20Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] gpib: tnt4882: fix memory leak on probe failure
Date: Sun, 13 Sep 2026 14:36:03 +0800
Message-ID: <20260913063603.1443403-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ni_gpib_probe() allocates a local_info_t structure and stores it in
link->priv before calling ni_gpib_config().

If ni_gpib_config() fails, it calls ni_gpib_release(), which only
disables the PCMCIA device and does not free the local_info_t
structure. Since probe then returns an error, the remove callback is
not called and the allocation is leaked.

Handle the configuration failure in ni_gpib_probe() by freeing the
local_info_t structure and clearing link->priv before returning the
error.

This issue was found by manual code inspection.

Fixes: 0cd5b05551e02 ("staging: gpib: Add TNT4882 chip based GPIB driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpib/tnt4882/tnt4882_gpib.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpib/tnt4882/tnt4882_gpib.c b/drivers/gpib/tnt4882/tnt4882_gpib.c
index 3cd13f637ed4..fc201ad17e30 100644
--- a/drivers/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/gpib/tnt4882/tnt4882_gpib.c
@@ -1585,7 +1585,13 @@ static int ni_gpib_probe(struct pcmcia_device *link)
 
 	/* Register with Card Services */
 	curr_dev = link;
-	return ni_gpib_config(link);
+	ret = ni_gpib_config(link);
+	if (ret) {
+		kfree(info);
+		link->priv = NULL;
+	}
+
+	return ret;
 }
 
 /*
-- 
2.43.0

