Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EFD429825
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935777; cv=none; b=l0X6R0GLyCoJHIQAcuOSj1QPRS9JqQIkxGATfP2If+DhpvwqYQKRglM/t05KIxQdr1gkZ9GjJgmV1Wfo2fF4Q9Nc79NQSZtOfxjx/K4w/jAyfY7Z3ylqcCik/lLZXcq0wOEOP53iDE0GLur3Y99CpVUg1KoJO5QHMvbxSbqYHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935777; c=relaxed/simple;
	bh=Rpcyir0pucMYwxwpWT3J9PaLulRi5dtQNJE0Rr4sZxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GiR2LeZAZOgi2VTdu7Z/tp3v9kb5Vva/RL/KlQqm9JtQKwhuNkcssz6ZNdODkkrxbYXqGbhhhwRLNJi5EpSUbzbCdXm0Py6amN5/eFI9WH+EnNLd3rOJ83oF/ZBANgaTwLgIVzBh8jaOX17qFZ3+XGXI61yBIz3A4qvbONdaYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBKryzqF; arc=none smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBKryzqF"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb8b78d6cso6072323a12.2
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 03:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790935773; x=1791540573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OaHZhhfoGTOQXtD+qa+qVp4d/gsPVtdPnGCiXPLugxM=;
        b=EBKryzqFqcfR5/P4sFDZ2d4sqtg89IR9iUAd+eCHQc+GQdaRaLm0h3CvomdR8Ui+KK
         qtdwnOhp9vgaspoisjuY4rJr4wSyMgDX6TjC8kLz7XAsUPWXAI4B7sXsajJR1x9ayU0b
         TwvBGyZfTSrXPWO9X6yLctO1yWBhY7yHhWd6JHdmIFxdzA4qW8WImgLfqLCS7YKinL/i
         bZSu/rHGLRJxx+/UN9rNWflb6D0w1JfpYekadgoz20WChKzmpsk5+u2O06CDMwIpX8UK
         AM0iFXg53SeI2tdHxJc6ta0F5+YnitnNzUYsL6QXcCBnefRpRqI1v+DfmHWNk/dWeZFI
         zJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790935773; x=1791540573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OaHZhhfoGTOQXtD+qa+qVp4d/gsPVtdPnGCiXPLugxM=;
        b=z6dnqTPjVooe7kuZ8F4YAHUeRdGTwhKpZvq/2mmuk0Od0Gwgvxo6gT3iAIPm29kk4T
         2cOkKLrZA0irHsw+lmURb9t+lOG18XDdSuzwtEuetMIzmmsJwJQEAwbk/e+oPaqPOT26
         VOhNJJuhvs/DCboy6eoeEpO3jdo2TrwY/Z68SnAz9pKxZiTKGsaaAJtMyW1ZzWRLlT+J
         S7KCiESWFVkVD+AmfS8jD5lU4XlriaOCYmy7ttpkd9mTRwPn3G/3lCIxMerxgur6/2mo
         EJs3foZxHqHcT0/UAlh/2yVTGEnFLk0l8Y6VAcag2iPHMaH/0DSdsoVHJ1BxSjcer8pY
         q9UQ==
X-Forwarded-Encrypted: i=1; AKwUvBwF9T4Ofrc0kDu+VPneSEAqrneBBYa+wcP7oTu4n8hrVXQdbELfqZG4IBuQ23IcaVCSXTww3YY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKygj52i/pS/q94xTsmYtNleiWwoQFdLHibQALPeEihInxkqmdK
	2dbQtTC/ooF0nQQZgbWvhoA1wwE9eV4WzD8OGXdwGiW9YKNtmPeNWjz9
X-Gm-Gg: AYBFou0WpbBkNxf27vdBMSwCEL5hFuFoTlvMiyJdV7r27vizrGRKMqS+Gnkexow/uyo
	0AdrO8HtLXAmCaQYFK/LdmsCcNwDSjKdr1yn6rbiDN6f1huhUcNwqlXOrpS1H1nM6vGz0TmGWLW
	0EimDBe/qECUdYYM+Zp0pJL7qIPDpCdJHzYo06HZnukkbzWvLOgWFaSKFPUR23su8zs1ea5DZO4
	T2Ylm2ngYa28N+NVkEcbVFCYlj0V2rdBK1Dndyi7FE/V/tqRnGsa9F/AakO9FsSE5PByG5ws9CR
	Ru6sEHrlFcAbB9See/xG4PDKgxKPywJsf/uel8kYeQcI/Bp1N2NnlJjJs1t4jwXODyWXTVC9BwC
	Y/LwKLyqrW8vlD5INSCABiDjc68dOSFlXSG9Nsca6sya/00RvWc+zy98df4aLp6Zmtgi9Yx+DA2
	kGMxv0Jqi7KDv9iHIWkmddsa/l+K27NDYABqdcmtIi5rwwe6fmwuhBxHwFgPqEzaW9MEUSPg==
X-Received: by 2002:a05:6402:5113:b0:6aa:985c:7bae with SMTP id 4fb4d7f45d1cf-6af9e2e13d3mr1400063a12.20.1790935772569;
        Fri, 02 Oct 2026 03:09:32 -0700 (PDT)
Received: from Ubuntu-24.04 ([62.171.228.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6af9d889452sm753687a12.14.2026.10.02.03.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:09:32 -0700 (PDT)
From: Alexander Kochetkov <al.kochet@gmail.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Siarhei Volkau <lis8215@gmail.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Alexander Kochetkov <al.kochet@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "Input: matrix_keypad - force switch rows to input mode"
Date: Fri,  2 Oct 2026 13:09:35 +0300
Message-ID: <20261002100935.449473-1-al.kochet@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 01c84b03d80aab9f04c4e3e1f9085f4202ff7c29.

The commit makes every scan call gpiod_direction_input() on the row
GPIOs. On pin controllers where GPIO input and interrupt are separate
pinmux functions this switches the row pins out of interrupt mode, and
enable_row_irqs() does not switch them back: it only unmasks the
interrupts. Row interrupts then never arrive and the keypad stops
working. Seen with a matrix keypad on an Allwinner A64 board (PINE
A64-LTS); it works again with the commit reverted.

The workaround is not needed on Ingenic either: the author of the
reverted commit re-tested all available JZ47xx SoCs and they all report
the live pin state in interrupt mode, see the thread in Link.

Fixes: 01c84b03d80a ("Input: matrix_keypad - force switch rows to input mode")
Link: https://lore.kernel.org/all/4130C026-2A83-408B-836A-ECA044491C47@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
The same three-line removal has been in use on Allwinner A64 hardware on
top of v6.12.33; this version is rebased onto v7.3-rc5 and build-tested
(arm64, CONFIG_KEYBOARD_MATRIX=m).

Siarhei, Paul: you both agreed to the revert in the thread above, please
reply with your Acked-by/Tested-by if you would like it recorded.

 drivers/input/keyboard/matrix_keypad.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 8863b741d1a3..cda2888b2e56 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -134,9 +134,6 @@ static void matrix_keypad_scan(struct work_struct *work)
 
 	memset(new_state, 0, sizeof(new_state));
 
-	for (row = 0; row < keypad->num_row_gpios; row++)
-		gpiod_direction_input(keypad->row_gpios[row]);
-
 	/* assert each column and read the row status out */
 	for (col = 0; col < keypad->num_col_gpios; col++) {
 

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.43.0

