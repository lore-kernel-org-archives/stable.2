Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00630331EB5
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027713; cv=none; b=Cv54prvuShMPvqnXqN5Vj2WdQdzIkVjoRGTAs/UV9ttEzYk3C3EtdPRrQCHqi/pVmHxnjLHkZ56v43V4GZAaXCoUypBG7OVljECX5rQ9E+jpaZfcD9XEuVihrzqD5WqN13JmeNG31gai3e4QcNrBV8ETjyxbJBjMuHAebxyUgQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027713; c=relaxed/simple;
	bh=JB3pvYDFmiwdINt/+5BUpwv5mFWj0AJGyYHELGxa8qY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wnlfn7/B5zcpNwLKovDqrxxlWBhu9eLuV321Q8NwKRihF408b8ucFz0ZP0Vd7jzX6phk2appWaINijW8loGdfywW7Jbfx9+hRIdDJlv28kjTDwfgzaP+JAJtSZcuPzxJis2XLrsynhdK0QSYaqFEJMZJPJC2mo9wBhe907iQ8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lg71xzsb; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg71xzsb"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-13807d2f898so4907265c88.0
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781027711; x=1781632511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFtqMj6mfwPk1h1V5GuLjVXRoPeFZiJCWq3L0vBGFEs=;
        b=lg71xzsb62X8g7SSO5Gmvv2FDju+WQEbY0Nki6pa9gJvF7NSugcTpIx/+segG714FL
         s5aCMNaLqWARo055nnVWucGEXHAVgcPnQYar7e+yfAaInq75yevDOL6AIdYrLaiD2aJ8
         rsPNZBFHsq4bf7qklRZ2TD+/Y8x3nEfdJdrdSUQQco2EN6JNDcPXpSibmdNOE3FoX2qB
         SUpJ8ty3FRLHfQ5o5C/VPdCJoF2CrHDKlpsvejwIVChZavFLMb1gawdifctCMmLca/Wc
         nO+jw6an1qeKLvrazN4h78HAYPdfyefuD84ZeqBIZ3rM3SPUIozQRSiPiN2WKxL4PxdH
         +9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781027711; x=1781632511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFtqMj6mfwPk1h1V5GuLjVXRoPeFZiJCWq3L0vBGFEs=;
        b=hN0KrbMYI+T6VdrBM1h4M5AflT/rhkkYjRIns8mPMIxMi/lTn5i5WgBfcf67MLXFjY
         szntS/QCrhFaKLq9tXWA+w2iWA6EkdGt87jKOoi+xeIwW7s+FN7hXhBp1aC01Ek8DaOc
         4Y2EGf+dVBarZqKD8b/CdrOAdfleEqqBBDgYuRXmH972SkWYMEVVzKiiYw8T//IuW64h
         Jo4F1c5jXdmZcAoPL4lDTaZQvCj4bR2sXKcbWLHAeE8B+e1Q1lqVs6ecf/+kSWcfvGMw
         tpZyl4X79dPd9oBlAVzI110bqIC9XIjgrF6xRGjsp2FPSEXNBk+RFtDyN+84laQ1gvKe
         qlXA==
X-Forwarded-Encrypted: i=1; AFNElJ/kcZy1rbL5r0dC6xn04JV22SfMtpdc6N83ul2rafVQ81cKMRnYjVaKlDtyS+siEUEV4FzTQtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO5g6S19aV0Icy1o+0DUAMqxxeeq8ne+kuciZDv5FCIKdvPIae
	L/gA9R1IQdZ7AtTljiZa4ibjCDrRlPcafdGdFMsfEyeZjcnaUB609QnvZPVDX+K7
X-Gm-Gg: Acq92OHmCqq5RsIa6cHA84h6nectb1Gu3KqcRl3f9GlDQPqJT3dBjOMdCY+yLpHpPl9
	S82Sa1vjwdYsHSsaH5xmQ4roIO5vgcZ0ZzZuja51d0FJsbphVTkMoJZkoAe6x8mWDbXu5wBly9f
	TlhVhOppGyMnxfv8B2oUVPnTaKqS7Zrhr4Jo1tcPShH6h5i9NlrrMG9HNToczKlulCKOjxRVBVY
	m1lxI58TMKuWJuYgmzGtYzuFPxRnixbeO3iEznVyHz7wCnAtGkR0r4d+KPKVGuvntfADTWrXCu2
	y4C0ymTSXXr2aZmRLGEFELkjES5xVY5StrxMOx9yI3LRLnUqebyjU613wTw5Y1pxCrWrIGP8D/t
	Who7wTOFEyW3AMuEMy6G96PucAT/QYClUvEzpwrm/2Rj2klhLP+U4+WSreHbkGDuvlZ4ODowl6V
	yLEw0MIMg+nvSLykQM2beuF9ZaeSgBDVI2Di8mfAPpSjQ9BFdhZgVtAa1bkPORi7rW3ujFXusNa
	mq23kPiheVytJF9Ds+qTl7m2QyPZ6j/oXwpjThr6TUhkSsqOS6UvaN89UbfipwPnn0dQQCRttdC
	hGQo/KqJKYJPqMeEB44udGIZDfUQ
X-Received: by 2002:a05:701b:458e:20b0:138:13e9:e66c with SMTP id a92af1059eb24-13813e9e80dmr5695557c88.6.1781027710891;
        Tue, 09 Jun 2026 10:55:10 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-138063de4a5sm11969808c88.13.2026.06.09.10.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:55:10 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] selftests: ntsync: correct CONFIG_NTSYNC name
Date: Tue,  9 Jun 2026 10:55:04 -0700
Message-ID: <20260609175505.19632-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The config fragment for these tests defines CONFIG_WINESYNC, which
refers to an earlier name for the ntsync driver before it was merged
[1]. Correct it to define CONFIG_NTSYNC instead.

[1] https://lore.kernel.org/all/f4cc1a38-1441-62f8-47e4-0c67f5ad1d43@codeweavers.com/

Fixes: 7f853a252cde ("selftests: ntsync: Add some tests for semaphore state.")
Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 tools/testing/selftests/drivers/ntsync/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/ntsync/config b/tools/testing/selftests/drivers/ntsync/config
index 60539c826d06..0aa68de147af 100644
--- a/tools/testing/selftests/drivers/ntsync/config
+++ b/tools/testing/selftests/drivers/ntsync/config
@@ -1 +1 @@
-CONFIG_WINESYNC=y
+CONFIG_NTSYNC=y
-- 
2.43.0

