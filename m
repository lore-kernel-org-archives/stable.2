Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEAB35A39D
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 02:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785291487; cv=none; b=tMrntcTlBtEGvT18LHvOd6hjnWqUvQ5XbQnTb4vLJ7mbNpU0PumuAhWj42Z58DQOMDu1bdqFF9xABmWU6sg9XuGlfxaKoGn7AGZug5+VMIcZnYDnQtuO2/MwVVfTomaoVburjvFe3Y+f3QhOKXsfh9oif/6JacKdii+BEm9oO2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785291487; c=relaxed/simple;
	bh=flvQXJwYxQzImdEpjPa/q4K2tmrj2oOcdMd9zvRpMS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRZsNPTHNaBk7X+49ITCcRSZYzeZY1JlllsZi1Kk8lmbbznp5zdqZpc6Uu/z6TiVG2F8ARVmzxIfEZutpoGjZL7QdpGwIZKh3N08dfyn5/Y+q1y+/fj6eMFhE7nQg14y+TgGaU0KcCQcTpjeT04HaOFg+Z0F4XTVdPCW2y7HKKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekku+KDl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekku+KDl"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8487214ad2bso685101b3a.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785291483; x=1785896283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oKxp8OyC0qry4zNtvMecpuE/hbir09TCLAtTFykGWS4=;
        b=ekku+KDlzq1of1zy6AJw5ANEEmLG0934EBDvIE+aL5so1pNR3+kdJHi5bJ24Z+K8In
         GI5YDsgPDUB2JiZadUeVGbMpzlTh80bbmjk9dFwnYoUkwSywbYx9LyZ+i+JBNID6SVAi
         yRqA6n8GTBug8C0zwyP8w6nqYCVNGh/qHoTD0STUYMAtabjNAD61/n7ozl3UHGULZXeu
         oH+MWGL5nuAt4suNDm9rxNue4845ql627egNW6ft8SB/K3UIdjFc3yQWlDNjVEHeKfYQ
         x5bYmakow15gYyeNyZPDx4nUOCm3BgAF8fz2NC5FCXG/9d9wiwaq39kWjS4nFocgO44n
         L0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785291483; x=1785896283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oKxp8OyC0qry4zNtvMecpuE/hbir09TCLAtTFykGWS4=;
        b=aAOmLPPgwr5K+pfk2u17I380jW03ZbYHpJq0GzaWf4u6RbUMfsdZOTMc6fkL/Eusbl
         ci6OjUk2/dTDLubDybIrR9vZdAP1Ac3AocDslCqx60f4KMEBR6JkedfifE1u1ApI8ZsO
         ww+LoKMapoAICRc9sM1WCElHpSDHRJhlX2zlnIg/5ldtW7AuA+Nqh84bUA5S/kCh4hY2
         lkp3xom+0UTmavYDbtJFeBcJhwWH/PF/7Yo2tNgTj9SteWaU5N5UkIbhws0AtKIBVeRy
         UGTBfqSr0WJmlKHXmliiAOPrcEMF70HWgePN6ii4pyGzzsmx1ignRVEFv15+fbOMZtvO
         vxlw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6vmAw+4tMtr3XBStzrOfIGrH3R3oB0jB1mGiervoSsUuhO4DdAzRJdhSFs8jWM399ftx6Zvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEARubAB3P5ytT8RTnYuLf3TiRA+/oF530HHXbLHNZAU+smba2
	hYfsEWFjPGcrkQZEcMrEmvj5NEYwWahgj8gkuF5C+NdX+4y878ICdjY=
X-Gm-Gg: AR+sD103uKr8+Ix4/N+ymrq4kpHB/GQuH2D76n52AZuLK4isVQOWAU6oArElEbpc9BR
	3Dchvwo2eUzRnQgJ6TQRJLkXaZHDCMrbbuFbU0OzqedYgtPhMoJeShQoYpgaYoscy5ynZ75whvE
	zgzfWu3QHiyLWoAoL/bQJm3ip44//L+IWJUhgPiddgqMIcrthgwzxp2Zdynm/awhzpbnl6Srjl8
	4/bmmWyjuAx/1Nima7Z5fbyTwTibIl+AdEqoxzk2pMoB9dKeWn3EvVNPcrHkoGNzm5SAsFjW0q4
	a/Z90eAlsmuLam+DkaMr7qJvIdWEn8sonMFwq7y+W902ya1VYRtEr1JpmqUyO7XN7DywPI9pEaP
	NY1zbGhIRMJkMlN7hGRnhProP7VWRmW2cvjQ5vb8xhX87GqaJITjQZFxgtqwWCnNke2g9aIzfap
	pNHdrN6ETZB9XBklAn9ELopYHkt4Qbyw4z2YAyIVw58T/SqgY/LJO4BRrV3a0o0wBcR1ycVdCbD
	XMDOw6O7BtsUxM+DDaF8fz7vNSW+lW/HMpaQ9zGaTUVS58m9q8VQeoYJy4JPPx6QZHWGRknZcbJ
	4mAOmQl9ypalq54BaVRUR7U=
X-Received: by 2002:a05:6a00:805:b0:848:86cf:267b with SMTP id d2e1a72fcca58-84e9336c482mr4934959b3a.61.1785291483412;
        Tue, 28 Jul 2026 19:18:03 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02fa474sm605327b3a.30.2026.07.28.19.18.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 19:18:02 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] ptp: fc3: unregister PTP clock on probe failure
Date: Wed, 29 Jul 2026 11:17:50 +0900
Message-ID: <20260729021750.49181-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ptp_clock_register() leaves a registered clock referring to the clock
information embedded in idtfc3. If either post-registration operation
fails, probe returns and devres frees idtfc3 without unregistering the
clock.

Unregister the clock on both post-registration failure paths.

Fixes: 1ddfecafabf7 ("ptp: add FemtoClock3 Wireless as ptp hardware clock")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/ptp/ptp_fc3.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_fc3.c b/drivers/ptp/ptp_fc3.c
--- a/drivers/ptp/ptp_fc3.c
+++ b/drivers/ptp/ptp_fc3.c
@@ -835,11 +835,11 @@ static int idtfc3_enable_ptp(struct idtfc3 *idtfc3)
 
 	err = idtfc3_set_overhead(idtfc3);
 	if (err)
-		return err;
+		goto err_unregister_clock;
 
 	err = idtfc3_init_timecounter(idtfc3);
 	if (err)
-		return err;
+		goto err_unregister_clock;
 
 	dev_info(idtfc3->dev, "TIME_SYNC_CHANNEL registered as ptp%d",
 		 idtfc3->ptp_clock->index);
@@ -847,4 +847,8 @@ static int idtfc3_enable_ptp(struct idtfc3 *idtfc3)
 	return 0;
+
+err_unregister_clock:
+	ptp_clock_unregister(idtfc3->ptp_clock);
+	return err;
 }
 
 static int idtfc3_load_firmware(struct idtfc3 *idtfc3)
-- 
2.50.1
