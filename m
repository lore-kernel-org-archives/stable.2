Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370843;
	b=e6Hssif9Ho13dWNuQ24Qsbb6y4BFpc3rmd3jGJkTksEn2uHlQs3OiIHKm2fR9xKaHOy/
	 wI9/5Ng9s+gxgaKBZdgifd3kCNHJ1Qa2ejr+lZhqMhDY26FYTH7XOB28FF6r+8NhmXQJb
	 8PQ8hOXky3FpLWnLLJOYTaGF723eMWRQSmtj1UrliKlA6FM0sJXd1E5PEZhNrJC0DIS17
	 DhJHrQgZ2DCUAws3dOuiYERHrkVR3oSp1g8EkI7nDJQY19DJeJ9qOxMu2+qg+FBIT72XQ
	 cjQAg8COMVliGO/ekKAXBJwE+qqF06nPjB58XsHc+S/9FliHOOb9B6E7f0M0Xi0D5sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2y/k0vv1KZWvdv/tcZ3kHN2M7tA63Ao7aQ+R/TLoEBY=;
	b=Z1ZmnkkgkH24NlOybI2qZPt/1nKHZ+8VVBycrP0QC9mVAIwZlsU52R5pLkxiyKGl2irV
	 UohI8KNijEdaV8pT4N+ubI5AOAd3ySN9J5UeTWGE4d1CBB9TF3V46CSfDThO20hmmpY4X
	 ORXQqysAOuga39ZFDa+2+1pWE2C+itNO2bPGA3QRNbW1gutZnbjVVOo06U9pRL+12gzyn
	 bWFrU0r9RYreLamyO1XyWKWRboDJ3yQ2kcpa8FMgsSku3D3fjsO3TNEqgYEuT/7wtiZS8
	 HwQFhUeJE6ddDoHwcqqQtEq080VYFairivbszyEi9Ln8a74aQfwWMQ0NVIhjQ5pnzoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uYDcDVWe;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85764606A33C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85764606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uYDcDVWe
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a60f90a924so1123178b3a.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794370843; x=1794975643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2y/k0vv1KZWvdv/tcZ3kHN2M7tA63Ao7aQ+R/TLoEBY=;
        b=uYDcDVWeZFrbHF9vMV26+UGVFxPWRvQtoJIqvx4qNzOIngOFXdhm8vzZZS1gQ3fLAr
         JX0y8XI2F4z6eD4bqeXVvyLZNZnW332lc1+gbGjBffXKFTqCtgNPtHKnXilCmBQj0pRj
         Xmt5hAVOP0f/NAKzErpgM2gEZrRrggBAyor6jJp+a0iUAMb7DnoeW1bIBttmTa7P7Ana
         OtCzGqSCpUb9fbhZ5pfg9/3WLAzlucpqWbPARzhxp2pJlPFbu2P9TsgPIdBTx4Xwk6yJ
         F9x0H4woEb4gS85UMTVPzQArwPBs8/7QmVVF1Fd80irwKP4l9yFFUgy9Fa6z691zLIxj
         zVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794370843; x=1794975643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2y/k0vv1KZWvdv/tcZ3kHN2M7tA63Ao7aQ+R/TLoEBY=;
        b=zqhgidH4I58TeSCZ81+l7c1GmYHO3IfryJPMxg9H8z/oIcsteYI7TfZ2SG45uv8kuh
         2ldBn0qFekRhVlhP/K9gzhFtYOBa3Tpplc+Lz4dgvk8C1HIZkm0RPki6x5q2InTfcq0H
         mFOCHQb7RAiiLWlFh6SRcO4TiRhUP/Cis9NMMT7qFXcJEp+HRlAmaAD3CATg/hhGhVqx
         VM7GhUDFzNFregfq4SUD1sZNejgIDafdkBqWO0RfvEfu7CpW1wmittqpwrO0LzYybLor
         GkKDIk5xEJJ4wNP3Z67XKafOB88d0ekSVw3P2h0g1pjtoZb1i6lYPDMrOiYHTmPg0+Q1
         qOqw==
X-Forwarded-Encrypted: i=1; AL+hErEM9xRBQDXtaSR9Ywn9ECLhuCTjfQtD07RbgrKiOOs3227S9bBbs1zxPcHsqYvFGDLUHRHTdqE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tFfJFbLW+ecGNjsXTN84zKpkj7VdRXyG4ewt1ZHIV4niS8hOV
	FpYv4fUHw/RcsLvA6GRMleg5w5HgRCe6B0WhVhMCa0Fv2V+5ekuRwvgD
X-Gm-Gg: AYBFou325GWdSefwqrb8DheCN4qHUo/STCfrc8relwSi/QHNleGxbyNFtRQDeJtc1Lh
	1VametSBP+BlwvQkhNTxFO3Ry+f9tObl/UKA/eZwb2kWRgryfj6vUODLVzKelw5VhgeVlYxaybQ
	dj0PWNgP8lnIK01+a1miqw/U1fDJHJSIWTfoLA/K5H8AlD/6Ckmd2GM1GaXArzYO3Qa3/L8qC7j
	XIRXGsEGfs02vyycdQnu/NjP8U20Fex5Rx3n7d/D83O/8GwWrtpcB30P9S/vFr3+ehBl1CI5S6I
	yBryY+6/jTeyKDiZVjTnF9xZkan5EzECLtTQQr0usenE3BJAbWFtSDaVujbKwRv0Yn678Gd6NHS
	ALbXb5DbYICvvKFZAq6sUXpD+lnpS3li/+8IZeoirtuJ0ipUH7P6pXREQZEUDqXLHhBfz+WEOTw
	3wfaJLSUfHmsVxKcgNK+KT6cswHyicXeEG4u4kWUPNmexKuuNK6n3iKL/JqrfskOPgNZI2Z6YdC
	buVo4rHqB3TGlw2k52CMbHH9NgfwpRGBStvSBP1BzBlYT1xN5uQBGOXPs95KFJUt4fkL3zRYhBH
	j7beDWEi1HjDVywrM4A=
X-Received: by 2002:a05:6300:220d:b0:3eb:affa:32c9 with SMTP id adf61e73a8af0-3f2f72992e9mr1463244637.0.1794370842730;
        Tue, 10 Nov 2026 20:20:42 -0800 (PST)
Received: from oslab.. ([101.6.42.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d7dd5bbsm1319947a12.30.2026.11.10.20.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 20:20:42 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: mchehab@kernel.org
Cc: Markus.Elfring@web.de,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] media: dvb-bt8xx: Fix double-free in dst_attach()
Date: Wed, 11 Nov 2026 12:18:43 +0800
Message-ID: <20261111041843.1278057-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The caller in dvb-bt8xx.c (frontend_init) already frees the allocated
dst_state when dvb_attach(dst_attach, ...) returns NULL:

  if (dvb_attach(dst_attach, state, &card->dvb_adapter) == NULL) {
    pr_err("%s: Could not find a Twinhan DST\n", __func__);
    kfree(state);
    break;
  }

Remove the redundant kfree() calls from dst_attach() to avoid
double-freeing the state on failure paths. This keeps ownership with the
caller until a successful attachment transfers it to the frontend.

Fixes: 6792eb0cf931 ("[media] bt8xx: fix memory leak")
Cc: stable@vger.kernel.org
Signed-off-by: Tuo Li <islituo@gmail.com>
---
v2:
* Update the subject to refer to dst_attach() instead of frontend_init().
* Add Fixes and Cc tags.
* Thanks to Markus Elfring for the helpful suggestions.
---
 drivers/media/pci/bt8xx/dst.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/pci/bt8xx/dst.c b/drivers/media/pci/bt8xx/dst.c
index 110651e47831..5cdf8a77260c 100644
--- a/drivers/media/pci/bt8xx/dst.c
+++ b/drivers/media/pci/bt8xx/dst.c
@@ -1694,7 +1694,6 @@ struct dst_state *dst_attach(struct dst_state *state, struct dvb_adapter *dvb_ad
 {
 	/* check if the ASIC is there */
 	if (dst_probe(state) < 0) {
-		kfree(state);
 		return NULL;
 	}
 	/* determine settings based on type */
@@ -1714,7 +1713,6 @@ struct dst_state *dst_attach(struct dst_state *state, struct dvb_adapter *dvb_ad
 		break;
 	default:
 		pr_err("unknown DST type. please report to the LinuxTV.org DVB mailinglist.\n");
-		kfree(state);
 		return NULL;
 	}
 	state->frontend.demodulator_priv = state;
-- 
2.43.0

