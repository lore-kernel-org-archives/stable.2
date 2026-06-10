Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F16229B78D
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 02:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781059596; cv=none; b=PxGXSF5+nf+mQsZS6OjiFaVIi3q8gArlrnY77SpfbfZ5OZc2KVzFGcoOvl+K8dKhA8meSUfBpXG4Ud4Ls6Wf/bBgRZYWZ1YFIzB8KDEM/lO3DF65QTiGUodNFG75CNsdGq+Wy4uepeacRwKnZeHq+aLeKfbGaqOz+JtsPmHxcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781059596; c=relaxed/simple;
	bh=NUu5tC4n74302MKFWJZuFSdMSA1Qkn6hFanXk9NTz1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nexs32HfqCLSlLx8V/sW0lwvN97gcJG4e1dae3J7waS7LbbDiSRc4fY2QIQh2ijH+qf8fyiG1DmpxaSSDa2xo/P9aQbEoYd68E02uryGkZzlEVVcxxp/GyLJ2HrLNzFkuWeQ1VjddlaGukrg37pRb6mbOyThSs5sI3BEBJd3SyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p25Bq58a; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p25Bq58a"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-13809ed8fbeso2349144c88.0
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 19:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781059593; x=1781664393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dywY+EaNVUUmyes0LNSn8JSMxfnYFXFyYF6vzqLn8Ec=;
        b=p25Bq58aZ30MerQ3Bo0Rzy5lnWo/kPAuafKg2CO8W66d2KGIsLpyJXN0gIl6wF0VP5
         4YqGWnIViHr1SyPWHMZ62PiFxOzmvlY+dWMRs5bzdtzDpbClumCmsAgwP9O+li25hbn/
         S4U5DokCRHZ+n4neSz+31nNOYgb0HuzgZTLWPBZsjY3rvfWGgJBa4pArRiX5ykWDq4Wp
         5BGqRNrT3q4tjP2NUQi025a4JcLjAHK/evhyuzwCKs9NspM9aM1GArrHzaHxBSPDl61o
         44jfzJabU/prtSddveNu5bhtJvieOHEsJdXy7bFwuxw9uwGtfdaPE3xqqk8C8+Ngnpvw
         pz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781059593; x=1781664393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dywY+EaNVUUmyes0LNSn8JSMxfnYFXFyYF6vzqLn8Ec=;
        b=ZnZJtjx1QJHV4wMdhn9MyOMXKTINYgsEFkSF1L95vSwLQiS6h4G1Xq2OGpYjniTbkP
         +mFbNp5kbl58bm4KcMYzT9e4l7aYUl5lb75jDhcbY9NqKH0eav9RbtK+LDpNdCGbdJRZ
         jPMwp9m9JvwDorr69N1/QRRu3gZOPA3IfVKAQrzWg9IcqG3NLwBCxzNcocM+TgtDO1gz
         18/JTAkp09W6f+QAN67SVO4aTQqFUArioL+IGgGqP5rMOvtoN/3Ka/cWyYIs3yF2yP1h
         /JfwiEWoQVbI/YSSFHBuMMe9myNeodOfLm8xGeGPSICwLbMx/J/FRJzd8rVW63+KJP8N
         EcWQ==
X-Forwarded-Encrypted: i=1; AFNElJ++69pNdyCr6igGSsfUKbzeDpgzGS1rMwUTKsP6x7HIPbKqk8qEVVGGQdI2FwSrBbguX4S2cUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3XEtTDas8T4BxUwsD0Jihhg2SDgvfHRP8iviMoowKNKWlaxPA
	2o3ANVd+j3e1+Mdd5FclU5riddhZ/03J0pN5rV9ZIzpZC3Rz/CghkKib
X-Gm-Gg: Acq92OE5qG9q8ZSlF0zOs/KuQ3fL6O/KVrSkl3OqugI0guH4IVJmsN2Sx8RbsNvzDNm
	P6gLx1gUuoE7q+EG2VypUhFvAixqVLs2lnpOp6BRyjp3bAkcPfe0Cfbb/ZRWlDvscfFYD67rOwl
	O/j5VMhEkUTllh3TunxnXh095z2XeYvsBXSUsEu6JHZ5HmO3lEnQji1Hq0PBwKFnR1bQp2ou5MM
	/NhEx5nCY8w4QBcNi3tSLoCBsZs2vSfMQZHayH97sPbjhoRjzc2LfTdOPRRGvUOCgbg+zB4UCxs
	3RS92An6qINBu23AfOOVLTug8DSJO89JYl7jBbA6ZNreGN3MPQAmYpAnViTlXEdQvfJWqi1bSaz
	OrSN3SFQKa195ogpyhpYu0xCRBdiOC67kaSYgHHXxElNy2ePa2jxuFIyD8J5Uqy6UMwRQy6nr7w
	mt6D8EPyb5kG5mC32ko0tC07rb4+ohIw+5Nm8MXbUeH+kN0+vFvO3rd/ZlveKyL8DO6ub1MVGWp
	rzO7uWV6wU7foT+mHquSzrJXeEUqR014J9cBdY6zLFr54/1Qj1eSdozvMSHt6gn1a7lT7Uy8Bka
	sd9GqphaOqYXn/7hKl1rFrG4NbzM
X-Received: by 2002:a05:7022:ef18:b0:137:6781:7dd7 with SMTP id a92af1059eb24-1380670b7aamr12076752c88.20.1781059592912;
        Tue, 09 Jun 2026 19:46:32 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5550bcdsm17792453c88.14.2026.06.09.19.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 19:46:31 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH] ARM: boot/compressed: adjust Acorn font display code for added header
Date: Tue,  9 Jun 2026 19:46:17 -0700
Message-ID: <20260610024619.129261-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6735b4632def ("Fonts: Support FONT_EXTRA_WORDS macros for
built-in fonts") added a header to the data for built-in fonts.
However, the Acorn font display code in the ARM decompressor was never
adjusted to account for the added offset to the raw data, causing the
font to display incorrectly. Resolve this issue by adding the
appropriate offset when referring to the font data variable.

Fixes: 6735b4632def ("Fonts: Support FONT_EXTRA_WORDS macros for built-in fonts")
Reported-by: Russell King <linux@armlinux.org.uk>
Closes: https://lore.kernel.org/all/aifhAn2RMdxQ2p86@shell.armlinux.org.uk/
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 arch/arm/boot/compressed/ll_char_wr.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/ll_char_wr.S b/arch/arm/boot/compressed/ll_char_wr.S
index 1ec8cb2898b1..7f218e938865 100644
--- a/arch/arm/boot/compressed/ll_char_wr.S
+++ b/arch/arm/boot/compressed/ll_char_wr.S
@@ -21,7 +21,8 @@
 LC0:	.word	LC0
 	.word	bytes_per_char_h
 	.word	video_size_row
-	.word	acorndata_8x8
+	@ The offset ensures that the header is skipped
+	.word	acorndata_8x8 + 4 /* FONT_EXTRA_WORDS */ * 4 /* sizeof(int) */
 	.word	con_charconvtable
 
 /*
-- 
2.43.0

