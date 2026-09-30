Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01634F85CB
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784803; cv=none; b=mRPDis1NIbP3Z+bxSpo0fCWzjoaodKuSUC3y/bTRZJ7pWS5eRe+eXU0RNcIW9K7fjknzdr+dmYZDdL/b9RI1KCup5DSSUu7LcjBjWCYB8i4SF9D9Jsc0xsJXbewv3RkX0dMfMCcNSjQhp6JvYqy97a2Dr/GifRtYzWq9zSYsYyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784803; c=relaxed/simple;
	bh=QkBc673khEJJQGbx7I/5zeyC7cHA7PV8YOmbgM+RWaw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z9DhwTnNbtfSH95RQ/cPjkieAHZOnXGmTsjuFbBvGmOfwG6YYmWZzl34spOkqb7ST+tZJr6WFmZJaFl/OcC7tqSnaxFvP8X8TJ4Bgx7sHXhM2q94XJg47sJVTG4sdRgQHVGYlD5sZKPxD8nVa7M+lnJ89yNWh06sQUz1YNmxo7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=ZZZNAopr; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="ZZZNAopr"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48afe3b2383so834944f8f.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790784795; x=1791389595; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=86dchXVzlnHFM3eNazc1BHx4E9vCuJAvMqBHhXFBlXY=;
        b=ZZZNAopru5lujsSMo72/VYP43gvLQLX3BmgMuxGYuU1EiwnD7T4LwGEkZk6ARbtNaY
         gU4AtWysJXXt0jSwpwZqyTeC+d3UqbK6MlWw6CWwioFk6wL4k/93ZvAfr8V63YJDN+nE
         hOJAh1t//VunCgjkPD3saad4JQEBlqszr4CslfDNkVBEiw593s+T8Q9M4ODtjxfaCu+g
         dxJ1jXgbG2iHAFu64hsDRjYIrSt/Ud4FM6Zc9KXAmx0RyvQlCDmnQthx1I9bzvQunByF
         2iabjCrGbBNoASPP1KXE/9U9JSimp+QYz4ZaHn2FhjaSoqm+JLQW6kDSGhX/WrrMSPVg
         Ts5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790784795; x=1791389595;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=86dchXVzlnHFM3eNazc1BHx4E9vCuJAvMqBHhXFBlXY=;
        b=oQjfvLU4RRx6PWdrH8ucuK5kOyct7vAfX8QhOruiLyn39eNdhzNe5OuitkNHbmACHR
         qDeu46/etnme4Ayky8C/iCN4PpF130Hr73in/uHp7ZYuOzXf5EzJNfHIY0nM7hqV/bSG
         VYASAQI2/ISEuDZVfLsosXd1TxdcrEC/GRV1OizGM9Rudakc3HiE6E3UhFwo2zxSMSPY
         l0LnVz0ZPDhkyfXnBSGFUSwkFf+ArRj13yeaLcHEOK59ne19XRK/LAq5WdZBhfXaX9cd
         D+Zc9B5mJZ6BUC6gbLXGFxYOzq6jy93AjYwTPWHpmMvKlpamo6+tfcRQkNZDWYgwMNGP
         KNbw==
X-Forwarded-Encrypted: i=1; AKwUvByUx1Wr6OthkCB4SM/enwpWQ7GbkIS/4URvG5QzrEWzUurVbk1mswaMHG8fouRj/D6YNwifAKM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnVHsKFijpjVByFwZHCw+2NRHS8lxMCdH8tOY+ojAOvdLQcP6l
	7ntaDOW02SLpXRyVAQ0IxxkuD8rSrNIy6Ufe2yEUHHnxFP3QJjcsLdIDPp6n6RQPgeA=
X-Gm-Gg: AYBFou1fWaC1RaZ2qdYeRu0aMgxUnltJZpLjjsP1zO6x+repTijNEKHR4WuCbuVCxiV
	2nYm4AIa5MSEaK13Hal3i5IOWdtGOhm6JKgWI2x9MVAcOSJLa0GmSrvhrCa9j71ZZmNeroBtHQo
	e7g70+1VNP6KINP2M5/39qRsVIfCNbItgnN2qkjffbeo7bhL4PrHz1ieuwEb1JC1vTbHt/uY0QL
	fXvdpIhUDtbbDyxM3PFTUrdHCMJo/emsQIuhvrh2KpGVkf/Fk/2WT6IZZ+WAlviUAgNbASIfiKG
	fYMAHJ4ciSX+to0O9sfjswvLwSzPj/HwmHwjBGQIuggr/WXx4n/rCT7DOBvcBV8GoHsfodpoB1t
	ydKm6wcA7amTqfu9j3aceHXHOHb3dSuomnSpyaP8DpWoZqSbCwFnZ6feT03xbBZ07ra6Q8NR/ch
	c/2enL0DBmkQLhcswOaMdnK4mQn84Q5+OJNYr8rpSbzoTovEF+hYdGbuBYTCNcly7QslyXUWdWn
	h779eQ9vDvEpH9a
X-Received: by 2002:a05:6000:4285:b0:48a:fcec:2a29 with SMTP id ffacd0b85a97d-48b024bd048mr4067392f8f.20.1790784794818;
        Wed, 30 Sep 2026 09:13:14 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b068bc9d1sm119384f8f.5.2026.09.30.09.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:13:14 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 0/2] regulator: of: Fixes to of_regulator_bulk_get_all()
Date: Wed, 30 Sep 2026 20:13:02 +0400
Message-Id: <20260930-regulator-get-all-v2-0-ca82070d22f2@flipper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBBFf4XM2jG0yMuV/2FY1DqFMQ00bSEaw
 r9bcO/yJOeeu0IgzxTgmq3gaeHA05hAnjLQgxp7Qn4mBpnLKm9li5762ao4eewporIWVVkWVBf
 GCE2Qds6T4ffRvHc/DvPjRTruod0YOKTA5zhdxO796y8Cc6SmqXVVqUttxM1Ydo78eaQI3bZtX
 xuBYbnGAAAA
X-Change-ID: 20260929-regulator-get-all-a553e73ff1ce
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Corentin Labbe <clabbe@baylibre.com>
Cc: Alexey Charkov <alchark@flipper.net>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; i=alchark@flipper.net;
 h=from:subject:message-id; bh=QkBc673khEJJQGbx7I/5zeyC7cHA7PV8YOmbgM+RWaw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTtNRU/ZnY4fMvfP4eC2XfZubcrfZgX77jw8hL5b4Is7
 prCYR3XOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZhqdidGhg/hDUmn/kxWfSDJl1nkLqsqXzg58wyXzZM/e/qOXU15vZqRoVN+ssW
 M/pB0D+bi2atm5qg+P3G1d1b66t+reTOb25/u4wEA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

of_regulator_bulk_get_all() only fills in the .consumer part of the
struct regulator_bulk_data for the regulators it gets, leaving .supply as
garbage, while the rest of the regulator core expects a meaningful name
there (e.g. for error prints), causing uninitialized memory access in any
failure paths in the core.

It also allocates the supplies array and hands it to callers, but never
says the callers need to free it (which they don't currently), causing
leaks.

Fix the former and document the latter in the kerneldoc to help any new
users avoid the leak.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v2:
- Split by subsystem for easier application, per Mark's feedback
- Link to v1: https://patch.msgid.link/20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net

To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Corentin Labbe <clabbe@baylibre.com>
Cc: linux-kernel@vger.kernel.org

---
Alexey Charkov (2):
      regulator: of: fill in supply names in of_regulator_bulk_get_all()
      regulator: of: state who owns the array from of_regulator_bulk_get_all()

 drivers/regulator/of_regulator.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)
---
base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
change-id: 20260929-regulator-get-all-a553e73ff1ce

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

