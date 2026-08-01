Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D025367F2F
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785563738; cv=none; b=RyudwggCuNijUFR4fMNp494A35Yir7RIpvdoTU9/2N9e1X6W/v6AdoCsYpgBtNtcQUFgPHdsBlzhEENnNQ2zaLY8022P9CjzteLn6zKrCDQ1D4U8rm8EVslkyrCqWnoTKdL6SniQ9y9VuBGU+n03TpfGt8n73A/XsI2mmgNaP2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785563738; c=relaxed/simple;
	bh=ZHdedNPcudEcVol+83qSYMha4eWY9xZ3jg45Y9HOidY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSzjlrhO38f0YouU/gr8fDcm2BI28kSpAecgKMnXym/CWOGRaTPHnaXQWvIKk418HqGfu927p9rnIIn8DAMawFyDTWnzAe5i0Rk+x1Qwctys5wvMCwKqyS7OWfLUiP+N0Al6MqdlbsTjwLN8759v31QwBKYSl+WTyx/aTAb2HzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=bq0Lksk1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="bq0Lksk1"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1706361a91.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 22:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785563735; x=1786168535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d0YoODerQIzEOVN20KJQiVnY06JcnNCgCt2bly7t1Fo=;
        b=bq0Lksk1Lv0zrJjlb4BgOI/7ySE/jGJyriPfZutvDqXQiBzkprJuBByFyJFedLq79I
         AJID9AJf9FOn118dIH6qYNIWqX0xtMS8U7EK2rgHMOOWXk2Mu+Q7RqtitrqGriBSDucL
         cD2XhI+dLpOehAGKLI8z7yU+ygf1KT0Kpa5xrAzhMmGXwuj8XoElt7yWVp1tUE/KILhZ
         ottEQqyo7UD5yZQYKl24m4zeQRlGR6PF+BN20/3+knvO44+jbrVs9Jt2qfHaZn5gGdFq
         nwfwcQoqimYZ5XkTQu2dTZXzw7opAAEjeCv3na8bkuEvdwXXqmSu9D4JExD2pZ2cYJNh
         L+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785563735; x=1786168535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d0YoODerQIzEOVN20KJQiVnY06JcnNCgCt2bly7t1Fo=;
        b=RhDIXmV0I2PiOqsZ1Tn5HqxkJCiR9slIvvU0t6vTRS+5HCiQYVlaB3+SBYrJkvHgjw
         eIJQz4DRTClHo3v6XwNDQJH9DDlZToPgmW4D+mLokigrk9QM2IJlkJA4QXXzYr0EFFa3
         YroCZTW0ZxxinErvdUDrPYMH3+iwff5yrxBAWcumz8Zqc5V9dTJx6NE7nNtVJ/t06J67
         1TY5Sm0+hmDYivrJTjuMhYqBoSyz2FcjvCaXxH3Vx02bs9uAPI4BeCEzr2Q3h/intMET
         UPyDK3maTYizpWvz+k1lUGfjRHcgINvIiGbUlE1BSOVuXWR5lzAUNJmyz461eXILAaZa
         1JTQ==
X-Forwarded-Encrypted: i=1; AHgh+RoA6E0JrCmieDZ4AUexrMXWZ3+qYe5D1uMpuj113vcavYvQMM6tIvN2Was8jqoCel3J6i73/Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl0+/JdwawW6XXtAnar02zgem/nuPA4j0Um6tkzqk43bsOkxTw
	3HWrm5oZ+Mmly+9TbMw7w7EdtdfSg/MS7ax5OBOresPZKf6GvARF1OBD4mrP6yM4HK8=
X-Gm-Gg: AR+sD10FpzH6PqFZ5R7LQbsKTy9G9+x0DmF0ArBJCvCPPbjINqHAB4sjKHnvG7OEfGz
	1PqrhQ0hlloUWZ5BaejtHJ52KGX5QDUkSgJ5hXR18Zcot8qV5Ri6LZiqtFIK1PDPv9UsGjMB2it
	iJHgPI1XyKc78d3PzzY+IT2vh2I+UcFER8hxUtgNI5lesWNcizTMJgogEWQg53fZ2H1uIjKulvL
	ykX7JH54glbHzB7PtUgk2bcDom7fE7WAczGMIWAGlQIQrPCFM8MYyrWmEk3urFrX0e70sEBa+dg
	4hDvLgU5C+5ZRQtht1TzMX/e5C3DgkC8c9uJT2S7+kagxRQeGVaYEUHn5DmavRha9xGwJFsqtTE
	QRRHnL4viYTqGVr3t2WalSDb/3iWfVPnZkYpRu1a1rIQdrymrwhNl/RUChoAedt+YGJvQRe4ZHK
	PU4Qevf6bKFO/p40tWMRoJCnJbXI+b30DI4S7+8yPJPEiH2TWKETvCNm8NI9j6mUVgfslf81TSu
	jTEjDejxZetYFqLFKah1zqNQlnYhqdjpFnwu9oudHHfYIGq+n8y4gfAwiTZ0NAM9geGdvICR1pn
	Lq7xIXPzSoU0Mow=
X-Received: by 2002:a05:6a21:9995:b0:3c3:b4e8:5565 with SMTP id adf61e73a8af0-3c92a8f301emr2512911637.61.1785563735027;
        Fri, 31 Jul 2026 22:55:35 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-13fab050d8csm16502537c88.0.2026.07.31.22.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 22:55:34 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Steen.Hegelund@microchip.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	joe@dama.to,
	horatiu.vultur@microchip.com,
	stable@vger.kernel.org
Subject: [PATCH v3 net] net: microchip: vcap api: Fix possible memory leak in vcap_decode_rule()
Date: Sat,  1 Aug 2026 11:25:05 +0530
Message-ID: <20260801055507.47534-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for struct vcap_rule_internal, keyfields and
actionfields inside vcap_dup_rule() are not freed in some of the error
paths in vcap_decode_rule(). Fix that by calling vcap_free_rule().

Compile tested only. Issue found using a prototype static analysis tool
built on top of the LLVM compiler infrastructure.

Fixes: 610c32b2ce66 ("net: microchip: vcap: Add vcap_get_rule")
Cc: stable@vger.kernel.org
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---

v2->v3:
- Rename the error label to "err_free_rule" to denote the first action
  being undone, as suggested by Jakub Kicinski
- Move the information about compile tested only, and how the issue was
  found to the commit message, as suggested by Jakub Kicinski.

v1->v2:
- Convert the error labels from "err" to "out_err" to avoid confusion
  with the err variable, as suggested by Joe Damato.

Link to v1: https://patchwork.kernel.org/project/netdevbpf/patch/20260727125757.134611-1-nihaal@cse.iitm.ac.in/
Link to v2: https://patchwork.kernel.org/project/netdevbpf/patch/20260728114253.196398-1-nihaal@cse.iitm.ac.in/

 drivers/net/ethernet/microchip/vcap/vcap_api.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
index ff86cde11a32..788c0728d763 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
@@ -2427,18 +2427,21 @@ struct vcap_rule *vcap_decode_rule(struct vcap_rule_internal *elem)
 
 	err = vcap_read_rule(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto err_free_rule;
 
 	err = vcap_decode_keyset(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto err_free_rule;
 
 	err = vcap_decode_actionset(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto err_free_rule;
 
 out:
 	return &ri->data;
+err_free_rule:
+	vcap_free_rule(&ri->data);
+	return ERR_PTR(err);
 }
 
 struct vcap_rule *vcap_get_rule(struct vcap_control *vctrl, u32 id)
-- 
2.43.0

