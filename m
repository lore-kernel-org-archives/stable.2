Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB0D501281
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676387; cv=none; b=gnAKCC0bsQCa4SbyAmuwnzgcH9moEy6TvFccJO1zdZDd92rj2aeGYPPH+LtA+7GdVu0vDMDg35rQWD9k+tJd7Sk4pqGtBTYom3dks4A/kPL9KbdnNtcl4ydNqVksLYzYV1oz20X+LAMvN3rUIIulBXe2tKbhFSiE3e/xYwJn7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676387; c=relaxed/simple;
	bh=vuq+i0+bCMQ9/9d/xtbVztfdytZENeiCb9lc3buC0uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oAAg5EV4CxiGQ2y2bJEADSz/4IBC5wE0iafcmEo8o9RDBdXZ7Oe/6XmQzU+xU2t5A3fyqavTld+t8H6VQ/f0Tex9w54uM1tMDh35/nk+oF7Yu2kUyySeRLMKyzvpERFJQTGATEDgyFLangyOffSJGFTPg1OFQ69iU65U+Phbt1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=DmJaxyNX; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="DmJaxyNX"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so32349905e9.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 03:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790676360; x=1791281160; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=phJsUqb9NaFMguRfrpAljTIHGvzpGMajrsq7kQa1w8o=;
        b=DmJaxyNXl0kSXFQW3MwMi0x/90mN6eC20joPOGB8Rv3OpNNPjJt5iJPJQng0/rrVJX
         bTGY1iArxC56NMPOxL1lsGslMylSHlWKtizF1ootQkPUaUujAsLig9Un0jFT9H/vkmsF
         53C728alOmkUf7CJBAFXA9Gx55JbMnRLdwo+BHmJJKdNjGHVcIwP2v6BbK+Od8LmMwEm
         5bviykArwBbMGY0LJQB/vE8soVsLyZ7+QTFpkT3E+yStXPic2DNvTacRaChWQSAXXjrq
         zOXaVBZfxI7omJ6auc7ISCD45jS/mQBIEVW+1NwdR60kjq37XixmA/apv3XnoQXH5/cw
         qnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676360; x=1791281160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=phJsUqb9NaFMguRfrpAljTIHGvzpGMajrsq7kQa1w8o=;
        b=RM+6ADOYdyAZZQpCOXD4yEC7rVdxONN8o4NI8HUslp8YKWoiyP6G2IsEt1ngz/3O5x
         arB7vvsxHh0LJtQseehel2DhWpy9fSxOtpq4aD7p0hVJ/JTAwFCaFVSQmQiTzg/fFsyf
         ldiSiAvltsSayrWQzUlMMtb2F/vM1XvwT8XyFK2isqlN4yJL19YsIBNQHBC/InlV/voB
         YdtyQsMRtWGPjMQy/GackqTd6oTQX4600r7TziiQYNLL8WkVAmHYSvrzFmflS9iHmhNx
         Ogp4iFX4Ns4Ls6AcXkdFOjVGsj/c3lGDQh6Km6zAay7TloDqqsnscHIFJCebF94T2FFQ
         YA3w==
X-Forwarded-Encrypted: i=1; AKwUvBwumDsS2bNGgIo9ITuel05CSmdV2gxIBWScDy7g84pdainDDqR7nZgwmgtgaW26LfdULHPy4R0=@vger.kernel.org
X-Gm-Message-State: AFuF++nUWZnJg6GK4KrvrtXL6DBYslqQg32vryEXfcd+kZdJWzEIF+VF
	jgVuBIRkuNZoDuT3TYcKOaa6nCpsdrs5GLA6XvsXENoqgTPp5MwNRBMhgTp4UVMCakE=
X-Gm-Gg: AYBFou1YDa/6MWvl0aI6h38LbEleUAcFk1p9/mkmGG+QcLb4xeKGnB5oJF2PrJ5Zwu5
	cuKovdnh155gbOALvsq59/CgLE0NTzjMnN5wLC35UYX1pbkuZCrUbZq1jznjWpqjTIBNDr7C+p+
	h1AcJFc6ZbCh+yTJH3gTeiyT4QAybXqp2G3Uiy92FRFmANNZ3Pn5rMTFSSn63WtdbXnCgkn8KaN
	OD9Ir4E13TjimjMe2rtlwuhIUhG+0OBN0gf9oVMrxBHOFYQ5aHMB8bfOlswREJhlp3buSygmiJz
	I18UxKgQ6vR2hM9eByIv7wNNFTJ4ySKxL0eI9tpMVqzQFIsqPCtpvfy5adKC2dtgtZ1wzmUoAVs
	HV4rFURpyZgBnk2F1JSnfFhoqlVbve4y5PdG+l638rcys+doQUnX0pBRWclyLHEjNvCEIuGa1Ll
	iFUNw6uRk2EEHEZYve4HZJv3t14QawD2bjm7X6KmMlZuYg7ZRdYMMvJCDBykIljKqBlF+Xr2svr
	T/H1Jx3kc6UT3DlVPsykyjee4A=
X-Received: by 2002:a05:600c:4592:b0:49f:ed8c:6cad with SMTP id 5b1f17b1804b1-49fed8c6cccmr258300315e9.19.1790676359994;
        Tue, 29 Sep 2026 03:05:59 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af502f79dsm2954995f8f.6.2026.09.29.03.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:05:59 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 29 Sep 2026 14:05:46 +0400
Subject: [PATCH 1/4] regulator: of: fill in supply names in
 of_regulator_bulk_get_all()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-regulator-get-all-v1-1-e887c66a47f1@flipper.net>
References: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
In-Reply-To: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Corentin Labbe <clabbe@baylibre.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3165; i=alchark@flipper.net;
 h=from:subject:message-id; bh=vuq+i0+bCMQ9/9d/xtbVztfdytZENeiCb9lc3buC0uc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTt7m35+qM7b/X2jd5XvXacmmW2oT1uls1fsQv7tBVbS
 8wvW2rKdkxkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVs50YfjE/mTJ/yhk+2R1bzPNF+T/s5LHd9c9E7eFumzCuDTyPHi1mZLg5P1Y
 6MPhi55H+vL3e1zf6BwduLw09l6tb5S6ptjDKiAcA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

of_regulator_bulk_get_all() returns an array it allocated itself, and
fills in only the consumer of each entry. Every other way of getting a
bulk array has the supply name set, because the caller provides it, and
the core expects it to be there: regulator_bulk_enable() prints it when
a supply fails to enable, so a caller that hands such an array to it
dereferences uninitialised memory on that path.

Copy each name into the array's own allocation, right behind the
entries, so that it shares the array's lifetime and callers still have
nothing extra to free. That also retires the fixed 64 byte stack buffer
the names were assembled in, which is_supply_name() never bounded the
copy against.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260928-b4-rk3576-reboot-mode-v1-0-65486b03bd41@flipper.net?part=3
Fixes: 27b9ecc7a9ba ("regulator: Add of_regulator_bulk_get_all")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/regulator/of_regulator.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index c0cc6cc0afd8..785b7a11dfc6 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -935,15 +935,15 @@ static int is_supply_name(const char *name)
 int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 			      struct regulator_bulk_data **consumers)
 {
-	int num_consumers = 0;
+	int num_consumers = 0, names_len = 0;
 	struct regulator *tmp;
 	struct regulator_bulk_data *_consumers = NULL;
 	struct property *prop;
+	char *names;
 	int i, n = 0, ret;
-	char name[64];
 
 	/*
-	 * first pass: get numbers of xxx-supply
+	 * first pass: get numbers of xxx-supply and the room their names take
 	 * second pass: fill consumers
 	 */
 restart:
@@ -953,16 +953,19 @@ int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 			continue;
 		if (!_consumers) {
 			num_consumers++;
+			names_len += i + 1;
 			continue;
 		} else {
-			memcpy(name, prop->name, i);
-			name[i] = '\0';
-			tmp = regulator_get(dev, name);
+			memcpy(names, prop->name, i);
+			names[i] = '\0';
+			tmp = regulator_get(dev, names);
 			if (IS_ERR(tmp)) {
 				ret = PTR_ERR(tmp);
 				goto error;
 			}
+			_consumers[n].supply = names;
 			_consumers[n].consumer = tmp;
+			names += i + 1;
 			n++;
 			continue;
 		}
@@ -973,9 +976,16 @@ int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 	}
 	if (num_consumers == 0)
 		return 0;
-	_consumers = kmalloc_objs(struct regulator_bulk_data, num_consumers);
+	/*
+	 * The supply names are kept in the same allocation as the array, so
+	 * that they share its lifetime and the caller has nothing extra to
+	 * free.
+	 */
+	_consumers = kzalloc(size_add(size_mul(num_consumers, sizeof(*_consumers)),
+				      names_len), GFP_KERNEL);
 	if (!_consumers)
 		return -ENOMEM;
+	names = (char *)(_consumers + num_consumers);
 	goto restart;
 
 error:

-- 
2.55.0

