Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D2515983
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784808; cv=none; b=HVb2Zn8q/qUhnvB1ah0HzQFuEouostAlJiJPEgRSXV3QkLGywAlTIoDdX4ctr+9Ygg2WrFNezufVYzl4EW5EQiP/fDXhhsYsOZQetd1XGBzZnHUCndXlU8xXu+zZMg6S8/V8TXg+ciEgPmf0edETQBB1dNLWK6EQRrF+68iR7U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784808; c=relaxed/simple;
	bh=vuq+i0+bCMQ9/9d/xtbVztfdytZENeiCb9lc3buC0uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oi7X0Z+uMHTqW7f6uKYSxcBTrr/sTMK4TQfBKwYsRwE3mxkW0p1OSeYraymfzr3KSOriCQkkzrHIk8ExP5+NOGJOqwLxzgkix9Hs8ax1Y255PVEI66HTYr7p75LaL+zhkjUWehVwaUon9GoYtHFGLtwl+1Hp0vMXH72XA+KGlW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=dakHQUqF; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="dakHQUqF"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so31455885e9.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790784801; x=1791389601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=phJsUqb9NaFMguRfrpAljTIHGvzpGMajrsq7kQa1w8o=;
        b=dakHQUqFVoP8/DH5/4ZNOcnswKRERe67T0uVckYeu0iF9+fcJzwEmXcpvOQOl7kUMt
         se2JJGrR1ERDEAzTXZis3KQ+AbJIQMaTaP8gFN9vlE40HKJN1gvwNgLVcFJ708Xc6+j8
         US/yezwHUwBHJIgCCPF/OfZ91VV6MonTffWtE7gIbLDagOszGgPp7zRybbcRdh/9UWx9
         k83iaYbb2DmaPxOCN/S0iNkcytrIjFDKwKC9aVt+Z0JMGs6ab3w8VWGyKTPkbIkb91dD
         03pyPDEe4gCA7dIZghHoKYQ9RBOgFUI4J+U+DEEuNGeHJGF31YUaRB1U4iXmH8VLGINl
         7nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790784801; x=1791389601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=phJsUqb9NaFMguRfrpAljTIHGvzpGMajrsq7kQa1w8o=;
        b=f0cnW3hMWVmKnwTU/705R0y9wUCa7KmJ26TWFp8xgDuDpnWXbpvMSYHsr+R18+DAps
         kM79SxxNH55AYFrf+tjZynRW7cGhmacQ2lpnAy6Pq597dt2s2mzDQJgrnbVZMHAo3Mbj
         1QnboG6YWHl54jInWvJsNq4buY2F8KIv3VQC+lNmrl/NEsGg2WJlLVAvfa2CQdcxVIX/
         XKJo7AITyjnw929fHKufVDdo88gfT57BbcK9+rqncZPdifV1ipN5PQnP3f9lOsAHRatF
         0Qzz/6H496DRJTZGFRxbKrBI9jTjkEzSOoawbrmagPnrHCeFz2Uh8hZm0n0FQGvazrJu
         f7mQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/THKtOvF86XxYjHQG2Ug+9bt3gUM0qnog1Ej7OF0P9nVwXmMnIfJcHUemfZq7uU+ipzo79ak=@vger.kernel.org
X-Gm-Message-State: AFuF++k4X1Q6Ro19t8/BwPbETWIC1BP+79p5Uy1RU5QaApdCg28f9dLU
	JUUV4mZ9JWGRexxcIW45cq1jd6EnbLVINMj0WmyqE3EOgd/z1ZZLonosmt30DHZNG1A=
X-Gm-Gg: AYBFou3bMJs5jBKYhtQjOQLT1S+RAE1CNVeH5U2lDpO19tcMJBPoMFW6VXzPGWnvYhc
	r9MDti9W9yJfpP5v1cNHQAJM7DxLfOvzWaRygy1zNmCeoljp/Jh2d8daBKQCxZ8yTfESwpcsC/l
	drikqwfyx77sY8FWoitz9nEBMul/lMZLgWSgU1ua6ZD5KG7+U8p0kdH2UFbneq4wsd2ig5fWk2/
	z/BFDhk8UOal0ciwo2YZ6BVz2tFDTyA4u5hAqHnDW+w31udrHVz+ulBa50ykugMvMD6kIYwjgt2
	p4NirzKpq7gSnVICUky2BTw4NWhOWBDRbE6jiiDpStditI5zP46BQ8ru+h/YGsojTzk8b0a6xKD
	fouSvvfIxXndQ+qCsOynow/WAp8NHZSvTAzKj8Ijb/m2kFUq4nPPnZsL+ldoZ7IPNZB+NYaPVaG
	3AjGqrC0W2SNGWoC2womSiiuLb+ZMl9pxs4H79B306sevDySe18trublEji+kvZBxHZZGngNjm3
	kZ1n4q59iSIcY/7
X-Received: by 2002:a05:600c:800e:b0:4a0:3c3:1ad4 with SMTP id 5b1f17b1804b1-4a01b11de4amr32375055e9.22.1790784801391;
        Wed, 30 Sep 2026 09:13:21 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b068bc9d1sm119384f8f.5.2026.09.30.09.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:13:16 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 30 Sep 2026 20:13:03 +0400
Subject: [PATCH v2 1/2] regulator: of: fill in supply names in
 of_regulator_bulk_get_all()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-regulator-get-all-v2-1-ca82070d22f2@flipper.net>
References: <20260930-regulator-get-all-v2-0-ca82070d22f2@flipper.net>
In-Reply-To: <20260930-regulator-get-all-v2-0-ca82070d22f2@flipper.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Corentin Labbe <clabbe@baylibre.com>
Cc: Alexey Charkov <alchark@flipper.net>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3165; i=alchark@flipper.net;
 h=from:subject:message-id; bh=vuq+i0+bCMQ9/9d/xtbVztfdytZENeiCb9lc3buC0uc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTtNRWXn9fF8OjO5LzWZ1JRLw5N+66q7/3CLmvSjhOLW
 BNUg5VvdExkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVkqwM/+wljylkcOizaIhuv97WW3nBe559BOv0h0kT270Wnvlx6isjw5d3zCv
 +KLDuXfwo/eFrmeZZp1b6NHA8rg4qU9xwKaOBmxUA
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

