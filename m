Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A65378826
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 06:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342322; cv=none; b=TmdV0q5Xavi2oLxbRpf8HEzigtfdxRr6umNkJBPSVF6xUjbWx1n3rpVsV5roEIvCSoE9dd6MJJcWR7hx6Lq0twgjunfSn92aJE0aKy2JSgtGbH0Aibu+TZqx6aKPqpboFvs7NmOE06ZwLtgrDBpByhULrQp5xZKDz/GdcK3jmIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342322; c=relaxed/simple;
	bh=dhiJ4S4TwV3ajJalMMqOr1BChfE0uIL3kIxrSt7MsjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TseNdhBBia7rqS6gVxSQ0smSwBsxZp2C1fypkk1plRUaXiTXSNoTIpLqJJMlve6HfwV5quuQ68n4qI2jc++OVf/BxNCngXLeQlyGW6zFQ/S+9fOKSHtpdPVK8Zo5bfkCyOTOku2Gg+Z2/rPNzFE82rht4y2EmJeTulsrbbtSxvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLROyuWW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLROyuWW"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47fecbbafdaso344524f8f.0
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 23:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786342319; x=1786947119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ifkqnnoVhAGXB1m6v9mKwNxlsMhpG5XwEqhjU+tW1mw=;
        b=bLROyuWWxxUuKSwFa8xpXqzmROV9HBgGs3FTyphJdF2SxdyxAvPml5makPhoD32YeL
         Tvcbn23YEPwVw3v47PtRezC7IeKog8dvg7DEmsvRWPazwEcqrdTPFLjmGxNoakhM/ajo
         s/yRGImN3SqJE8XWwp5NLxfQHgGTfnoBxo/2JfjIsIjuAjp6iK4Y5mjVz6boSMPb8+Ue
         dfCg18lFJOsEMxCC564Emn6mqrZ7yD85/b/Dm90XSDbFCYM3pJC60+lsWUi9VGzduGgO
         golTB+bsTU3qXvTRVzelgc5O5wX/HEbXVDH5GtkgeVnboX+upxjLt/6C18t2O4PmK0Dq
         pNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786342319; x=1786947119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ifkqnnoVhAGXB1m6v9mKwNxlsMhpG5XwEqhjU+tW1mw=;
        b=dCvcJwMil+X2ME8QNU4E72ZYJnDSGw4hH3W/zA4bNHp5DdNr885LQ9BfrQJ3UGUP5S
         7Pw5Y3GJoGjCPK4GoGvB2V0M0SRZCRi6qe7j1V0P4tduB42m9Nrr2MSsS41HHuX8vFLz
         28LqBqwqHpjUnx54tIu028kYWUn8h4p4DP4nH07Jme+Bx3rDSRaPUYgV0ELFEKm8Dtax
         0D0TSrrKDXhFR6IvjNvvmhs5rjpTDzUa0q/HoWJ6EzYURVr9M9uIPbVy5gysTpAm39NR
         jP1QJbfewFNVXRS3LgNeSXvCcjqadul6hMY47UenqdI3wHyBS4UQR39BsQQGuoFfG/ZJ
         xZsg==
X-Forwarded-Encrypted: i=1; AHgh+Rrq/2h38ecxPDbQF1PojkpfrvdmdfV7FW+ythJAC0YrrpH6xTvp8dj58XibGZFdu54TXJu+UzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYU/FArpsgdR/RqK8Pwr0TYgMamUHb6C8bW279exddUsR6oxkO
	MqC60z+07kUeyqV/0h5k2YF+FyvOACJzKyzbPjJPZRhFmzC4FoRX+qpMwr4iGA0i1D8=
X-Gm-Gg: AR+sD10LX8BeRfVlpxndPMgv9o2woU1Fzv+aKd5i02mqOFSnqqy9J2oqsVcKLqJZnS7
	j6YZxrgnwhK3s2AAFzs72FX5453bQEy8caKnP8In6VyC81T0mFwdxWUuwJM/vHAYNjrSbIw7NXs
	HEwgPO9apIPehw4UuIk9rcLIM7EVjtMEBTBH0JFQ+4phxzKPuwD1SOtX3JI2GpnYzCpz+zIMSZZ
	xsQZYzBV/ZEiN7QYTa87uY5f4icXep2mymuxAju9fAr5qDJ0ptZ5K0xZcGVkxzLiEZCJxCgSgHb
	b2kP3YQ2t1fWg3B4XUm93dYjy575OL0DjcvhtyMPlbiGjCtCRvr2NFYxVMpkPotACqLh4c+KQ1S
	j0a7jr8hkMIGiJziGhJ5YBAQ8jKjF7Afkz9oAeyoxSkRKbPQDBMC7HXQLE4lQpN8WlKG9C2dJme
	5t/mq4/BwQdKRjGSwKBK6NurXkA8pjZDOgkPHJmfvmTshP19NDIUVIVlbg/fy3Ea+dKwTXMmKH4
	wYuuQTEDuMjZCoUPN4bL3MgfMfqHFGOTgdvnOcUF/UWljb/CSzpBrGwZr9/ph9pYg==
X-Received: by 2002:a05:6000:41d3:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-47fec628b57mr64663153f8f.15.1786342318643;
        Sun, 09 Aug 2026 23:11:58 -0700 (PDT)
Received: from localhost (178-223-21-154.dynamic.isp.telekom.rs. [178.223.21.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480020be8f3sm29210021f8f.0.2026.08.09.23.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 23:11:58 -0700 (PDT)
From: Denis Batishchev <ii343hbka@gmail.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	ii343hbka@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Enable micmute LED on HP EliteBook 6 G1a p/n: AD3Q9ET#UUG
Date: Mon, 10 Aug 2026 08:11:54 +0200
Message-ID: <20260810061154.1575447-1-ii343hbka@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HP EliteBook 6 G1a (SSID 103c:8e0d) uses a Realtek ALC236 codec.
Without a quirk no fixup is selected and the mic-mute LED stays off.
It needs the same ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk as the
already-supported 14" variant (SSID 103c:8dfb), so add it.

Signed-off-by: Denis Batishchev <ii343hbka@gmail.com>
Cc: <stable@vger.kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 6b36c730c..ef8beb928 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7542,6 +7542,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8df1, "HP EliteBook 630 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8df7, "HP Z66 G6", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8dfb, "HP EliteBook 6 G1a 14", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+        SND_PCI_QUIRK(0x103c, 0x8e0d, "HP EliteBook 6 G1a 14 (AD3Q9ET#UUG)", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8dfd, "HP EliteBook 6 G1a 16", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.53.0

