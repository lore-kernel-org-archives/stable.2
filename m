Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EEF3F1ADB
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146404; cv=none; b=hw77StA1zTCtjD/VGdRXESFteUz571OZYgQELXrXk57IjH+V9GzRKkHGz1HP18X5EACcK3PNtW6L2CmihxE6aPyzrpNgiB8usPfsLY54KiGW28kqQ80UTja4aH/MsvZMHMZxi1KUrlG1Ru9BDLNOfdcQ/RxMwZ+UpkVz8nOsNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146404; c=relaxed/simple;
	bh=HBhrJZPHy4NttI3kxYs+41g7lpzIjLkpzKHnokIwQmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hs1COF6VzDcPxZEN9+48vQYf0KsfF4o0Wl7NVZsUD0EfEHUsctycCRXbb/WnFxL2ZWkRENSSMT+lwy8zOcxTsSSy/PJEDEz/XJm44RkL2Hki9LnA8NlfpxtaG+MVPPkPss4pqGdy9Lci47bQXLeQUbVEruH93xmbVKX9SV1o6/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=avts7ZsO; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="avts7ZsO"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8486ac3f347so3168805b3a.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 03:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785146402; x=1785751202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AdMBeaECPK2Yn5UEPgGlAZr7zLN0mOyttvrm73A1z44=;
        b=avts7ZsOegrB9JpJJUbSRv79AEm37Xvo7TJonbg+UEeq/Vz7X+T1/5MfU8jOQQlFYj
         IHxac2mEzTdlVlq0nT7x2OtmpDXUojgkiB4lbldhsSrwwC5LnTStFrOR75rqsgcALOlI
         IHI9m89HrhHq8IZCkvQWE4XfgdAbkroBRWtt7NiyocrWoej+1zDMf7ZIozwGW+12Olfn
         tBC0XgjFgNg4rJoUpmQkx8nZ95en5xSVDP8xoPzUZCH7PlM22ipo1isJe5ZLDmFRFTjp
         b5ntLP2yZ1EXRRJt7ZZN/qOY7COpR5G83NlXo8cP1k+76fgNdonl7Sfohbc4QABrEw6O
         A+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785146402; x=1785751202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AdMBeaECPK2Yn5UEPgGlAZr7zLN0mOyttvrm73A1z44=;
        b=nqkf1sCNPeNtQDOlm0d9ZxjspaSBYqWRb8DoPfYRSMOpnUO2PZG0YE2Z2Ez8fZ4cL6
         0XlNfRDiEv1LqVlOTnrKvCE+CIu0Ycw7Y52EjFiIP6/9PoMz/EPN6MxV+xPyvQjeSWKA
         lcZ98HtsP7OsvWvFDLFnoeN+RfAh7jCuXEU5jb5TObI412VgrKk2M/IHHpVMK86Isr0w
         B3D8S4fqyBov2K1qN/2E+lby9cxBuWdbPfRj3QH6yoZHRLoR6aIkYH7woN2xX0XHEeES
         SNZpZb1Sn4CzXvJ6JJk3rcAzq8sq8+TNsuv53t79Of2yqN33S98NzFtebc82q5hKY7AR
         NndA==
X-Forwarded-Encrypted: i=1; AHgh+RrPMIQcLOSEyLfxdPb0IcWu1fvB4IowaK9yMYEeB4YUGr84VQ+MWVSPTer91xxakrVTKWyaVPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjnxFEMUQ9VCMTVVcPx99k175TdKz+Dn5ryxOy0Ob+f/VFYQ56
	syyx7Gb7wXzPOrSxGv6uy8LLTroDdLSxc/XPUeuMXOPlBE+AS1wVdDgPzly5y/mOWRNK9o+AfI0
	yJI+oI3E=
X-Gm-Gg: AR+sD11JHrpUPtbRi8B/vQma6ynPV4EZQETsnr89QB6h3rq8fhJOOkvbqmeBnpFzlJK
	bYty5ygadvueAx44yW+KmCEbkF60Cy4Ll2GrS3+qsgfG5Srzat97KKh5XishgtZxNNEdiKBfcrp
	2P0xp7OiSCCply4+MkVoipZkDI+waUbLVuw2Uk6BSiD9x31qE0EovqM+Borp1WA0LQdiQnCV6Cv
	lvjvlHpVlxKJP9g+Zlv1zn7DWh/mj3mZfntyfdInYZx6TPQ9pjYc9tmBESYQMCdul5AJrLtR1Dr
	ZRviHqhFBZ+zy0KFTP/L4KZsklWUaujwZz7OK2druzQ8fKCdoY2nBc6deqBnUCqpm4h6tevKq6j
	kaeJ7HIbQohspcMREFTFImd4MWdaSgEMhBEFtyYAFArzTbcFo5gYPCLdfJkvQBeDs6yACgPpDjC
	BuH7anFUjc7WgsBFzQb5IZBj8o20l1PqEtbda9huAbZpKN35n68ABs+3NYl5hGnO79YuFm99rwz
	iNJBpNyAZyu6eFGx/IsEe1Qn/psLY+y
X-Received: by 2002:a05:6a20:e290:b0:3bf:9bd9:cf54 with SMTP id adf61e73a8af0-3c67236de41mr9855864637.8.1785146402370;
        Mon, 27 Jul 2026 03:00:02 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-314bc3e127asm49271112eec.2.2026.07.27.03.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 03:00:02 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: o-takashi@sakamocchi.jp
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] firewire: core: fix possible memory leak in build_tree()
Date: Mon, 27 Jul 2026 15:29:53 +0530
Message-ID: <20260727095955.104972-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for node in fw_node_create() is not freed when a
parent port inconsistency error occurs. Fix that by adding a kfree().

Fixes: 3038e353cfaf ("firewire: Add core firewire stack.")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/firewire/core-topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index df2ac0dab106..317f8f57e521 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -227,6 +227,7 @@ static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self
 		    (enumerator.quadlet_count > 0 && parent_count != 1)) {
 			fw_err(card, "parent port inconsistency for node %d: "
 			       "parent_count=%d\n", phy_id, parent_count);
+			kfree(node);
 			return NULL;
 		}
 
-- 
2.43.0

