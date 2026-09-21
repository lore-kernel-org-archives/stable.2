Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2D5488DA6
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989330; cv=none; b=TcKgDwfPAkSj353rxrdoEJrkbd6vA/AvHqccLZOhh0y5z+ihufSG5RJ/jhSbOG5GnngHFZIZlu29hfrvClM99nnIJiyIzFRnPy7eeiPgMIijSWvp3SfcrLVZVxQF1pJbjDfLutzb5Fv1p1lyWLp+3u6s5cpRRuW7f7XqlOQXtp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989330; c=relaxed/simple;
	bh=Fl8LEDF2+G92eNmZm/5BuP9dhnVEgbjMk0wmGrfEco4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEklwu9J1SRQsSspwNPKJ9m/NDoSylHSYmYlFrcvdGeSHJYTpy8LL23XEwfI+XE9KxR4x6e9OrMoSzwiR3eMEQaKljsTJ9W5gG4oNFo8ip7aBH7+AAVfgAk1Z6jaBAtqMV6bY7cCOzlmMKw/iuF8AGzevOgj6XHb/agpCYG7FNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmLrjts+; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmLrjts+"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f05ffdso19975815ad.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789989328; x=1790594128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9cuLvycUbpxuZeCkGbkO7ppnyiQyHbP7lOQEyxsj8o4=;
        b=CmLrjts+SmFjYe8X1EtSivLGW4wQkrY3nCdzDy+M106XjAWPD4iOMhaVxJQAoNqSs2
         3g2FEirfVX+45m4+iS9JPJH9vQNr10LOKOL0SQMO0DlGflNTay3PsPIDvJzXAiK7ZUbZ
         L7PpuZ+VRdohsbhzF4z+aR5rkAOdeECDlCq3Bf1VZyqI4XoJSGP5ZukxfjlBuD29+sKr
         JUd7BkjiwKv45besbG9S/+8FQ5gL6AgRyrGYqOlm+TP8WfHmIBRpVkamZlw9yL5yX0Dn
         yKQJk8pZwn42nPrQ0lTOd8Z3S2/Cbc3eWX+GrSXpfOVcNZtgWxfZz8t0jBHBO0u5zk9e
         kwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789989328; x=1790594128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9cuLvycUbpxuZeCkGbkO7ppnyiQyHbP7lOQEyxsj8o4=;
        b=oSteQ9Hw16lHIX3Q1Qg05qAXBj3OoWf4uEmyeHriSmNC6zF4G2iT7HI8pqEpflvnlF
         ZmboGqxqOZgo7SN7lIVJoVduGn6i9snH5ok0TMbe/mA0I1f5E7gnMbdjScCPMmhj4zZw
         SdBfPUKZlMIMglbETWevgnesflExdx9d4VEI+3lHcId4k/ocLPc6PMdafxIOls9eeosr
         3BMjszEgcY6fJ1tU05H/klf9anrm7/HmBHUn1/h3XsuT+3hNGC+XmI2gXdWKXqJYF7cX
         w1EECSlDe6y5mlKJZam5J59QJrJqPFdyL+q82py17TRI9d9yACtFVrPnpEd0rLz9hU8c
         Xrhg==
X-Forwarded-Encrypted: i=1; AKwUvByUl8pZcDbFKiHqoUVi9XyZSNkJqKXkK5IDE/o6DD/R5sdbB1FqjaE+yyUK5n95FZmsvseDUUE=@vger.kernel.org
X-Gm-Message-State: AFuF++leXaja+RPWW2YKiPnS+9h3hVJ+4RAMrGUJ9tk1+5qZ+H3wD9eZ
	7/7O/kmifagg5/Ksu3wBPG4UDk0mRqTzH0vwxWjlaZCCtF3uvB4enbnynedRUO1W2pGcoQ==
X-Gm-Gg: AYBFou3bYsqbyc49Wk7e6oBOxJT5na/KaQjv7JQ8wf7z8q17Wry8IHob/XTy8DmNg5S
	45iC3UE3C09DDeAiZqAI/FE5A0UIHiTjx0TxgLeDqY5p9Vby3ocBACDHLo4l3f2h1T2xSLugmyf
	xpjF3wFTxq+rnbaw9qx0JKhhHRFAZ9i7GDktGuITWnz31MJ6mK1H1iC8lw+9rljgQ9NrX015Aay
	cbH6M4twMar4qja3RdnzMYp+df1CESVW89rQWRwxm/+qJba/eFgCfqN2heC61q7NFMtXrAJ05lC
	cYxI2PxA+clAzaq6g2j5HoVvw8fGw93iNPBsxSvrXycRuE0e5MicJ3Lkq85GfBLIwFcdQu2Wuc7
	oWB1Vc/GP6pTtZ4hgmUUIMmRfVbQO/sDIGMGuqCK0D4Ga3c4DeftTbh27y/jQ/Fb0MbVu9/U2SO
	mxCJHV/8RF2kQupSytL9jIsHTVMf7u8BzkV5W3LQPvmXOjjo+NEe8UmKhiFoysOHOeHrYobh72C
	i93L6U=
X-Received: by 2002:a17:903:2c47:b0:2dd:c168:c4e0 with SMTP id d9443c01a7336-2ddc168c512mr84966165ad.0.1789989327719;
        Mon, 21 Sep 2026 04:15:27 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df378440f4sm26419465ad.59.2026.09.21.04.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:15:27 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Mattias Wallin <mattias.wallin@stericsson.com>,
	Ludovic Barre <ludovic.barre@stericsson.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Julien Delacou <julien.delacou@stericsson.com>,
	linux-arm-kernel@lists.infradead.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mfd: ab8500: fix child device leaks on probe failure
Date: Mon, 21 Sep 2026 19:09:09 +0800
Message-ID: <20260921110909.370945-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ab8500_probe() registers MFD child devices before completing the
remaining device initialization.

On AB8540, the main MFD device batch may be registered successfully
before registration of the cut-specific batch fails. In that case,
the probe returns without removing the child devices registered by
the earlier mfd_add_devices() call.

The same issue occurs when sysfs group creation fails after the MFD
children have been registered. Since the probe returns an error, there
is no later teardown path to unregister those devices.

Call mfd_remove_devices() on these error paths so that MFD child
devices successfully registered earlier in the probe are properly
unregistered and released.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: cca69b67b3ba ("mfd: Export ab8500 chip id to sysfs")
Fixes: 9c717cf3fa16 ("mfd: ab8500-core: Add device for new RTC version for AB8540 cut2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/mfd/ab8500-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index f0bc0b5a6f4a..e675223b6023 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1220,8 +1220,10 @@ static int ab8500_probe(struct platform_device *pdev)
 		ret = mfd_add_devices(ab8500->dev, 0, ab8500_devs,
 				ARRAY_SIZE(ab8500_devs), NULL,
 				0, ab8500->domain);
-	if (ret)
+	if (ret) {
+		mfd_remove_devices(ab8500->dev);
 		return ret;
+	}
 
 	/* Add battery management devices */
 	ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
@@ -1243,8 +1245,10 @@ static int ab8500_probe(struct platform_device *pdev)
 		ret = sysfs_create_group(&ab8500->dev->kobj,
 					 &ab8505_attr_group);
 
-	if (ret)
+	if (ret) {
 		dev_err(ab8500->dev, "error creating sysfs entries\n");
+		mfd_remove_devices(ab8500->dev);
+	}
 
 	return ret;
 }
-- 
2.43.0

