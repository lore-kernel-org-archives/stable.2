Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8EC499F0D
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818989; cv=none; b=gTd78pUQI7/7jmNXQLQ6KSUOfx9yvSpN9BpRMP941JpW7SIKitvBERBAmCMvSGTQMh8TNkb+CRHi9P8TrNpyI4kSDuF1ZUtEUjDxeJtw8wOljUnf2jiADrSbX+MDtq2kVFb6M3Uv1b4xyPHYcakVeOrUyCpdj7fvXiqmHTMFi5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818989; c=relaxed/simple;
	bh=9dzPjKfPwF17gWuCkkQ90Iab6Nca17sirBocvyaC4KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZjfiBUXQ1k55bLVruMlvXZGIeQkCH2Zr0u3SUQWpXDItbC3kCTuuDSNULqCoV54kUayaC0bSKWIzUv44xtIBQgpkAze/pR20bBwRn+BwiBEE1f2oV9WVi4oINO55LoSCSirqgQ7UrUr/MBufT/A9qX2mSZb3gKzf68xO47bUN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=68r0OMWH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="68r0OMWH"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48b02b1b4cfso2607951f8f.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1791818986; x=1792423786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C3qaO1Pq728Eu3QsHaCVeWW61AJ9yH0UYKYPAuaGLhA=;
        b=68r0OMWHVobaY66VMOkJ4RyM/fWpVUi6pEKQXXxS8xgZFmHVUtTOBhf+vE5sZGZc05
         /wZ1HnG5SnSaF8UwZSnsY+TEWTP5zYTVlOL32Nx32ctKayxgUvQh7Z75TB2zYaicoYMw
         7U1RmF4VESLIA0tOfAYKttxz7Qk5aCPoYY36nCX19m29T481VNz5fT7mfm9chuohR5uf
         eBKXIteGzW8yBQqh5eeqKdH7DnHyFyhshCAqeb3Gkmmvr/2AERQQuhjJY0sJN4tN0vz1
         vQCjVKrrW7MFNkXA7Baq95vfFiKKnqufbFVKG/EQlUCN/O8PfkX3JgUWawB6ZEUSyWAC
         u/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818986; x=1792423786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C3qaO1Pq728Eu3QsHaCVeWW61AJ9yH0UYKYPAuaGLhA=;
        b=IpDveX0b0Q8ofHXfHLRLoHSwxUWYhHCt4S68LUlrYrVwMi+m4KwlOql1UV+zxOrwe8
         hFDZB8hbwomMj9XDVeTlxh5we4ZeaCesGPDLsOT57rO9jx3vjVsF5JQ3Pxmknv1jXxOS
         X9eKPEF7Glcc6mYd6iuXp6m8n66ZmOR3b85LrJ987gele0Nlgrc7ISnZh/FOxbJUic9A
         xrvcRBvOowxb/YBomTLtaaFmIGryLqXzgVzQgHYpXE5WtfcZQuUYZc4fYxANRulAWyQj
         T/sbC9djFOyXrLO2TP1FZU5EWBUoANa5W4LT9Dtn8t5CGOVTFq1zuj1JQwI0qB65K5z5
         dc0Q==
X-Gm-Message-State: AFq9FYJHfBatZ9YeKYVP2meX9t6Jx5smodkae/3+BGR1Ry8FmdWyUh31
	Xmo8If89bBdrT+Q5Ox1ZmxXt+Pcfh3UusUiK2cEl41JT4dwT9J+jt+LCJebcz/kaq81Zje0Qzj8
	8XPT/PJo=
X-Gm-Gg: AYBFou2VYTmsskZTaJUKWXzaZOL8ObLKW6xYRPIAsnoYORykgYfIEirPKwvELssDc2A
	Lz/CBIuFZQ/xD+D2OQLjxRPHoUdtGF4KMJEH11qPO0jWhVHqc5SIY77wCIYV3Q5oRXXurFkTqsg
	PZX4ycO7g5zP5PuhGlt1VYNbk1SQSBzgPZdDq9zMJmaKxqoOAx28/hJ8DUzTdOBAJvk2txBao8B
	F3nskZrSDsmKUEdIkEX5C21kI3/kT51jj04ZSAcXE7UzwULgLWQ68S3cgAisOj9Lmln3EwUBcpl
	/xXBqedzIUR0Qo2IA18c1QUiQt4wOeSCTFRPkkZS7pdE2Xulw0wDej3v/ENtbLVhwwdOXM+XCud
	IC5Ogy8ulte/eQKhLaRJ3jdOslD8aEaJPXealy+QM7mSXCQJMN4QzPiJEG8HuM61+PCB6Kgk+h9
	jmP/tdWoofgl/FSMSY9n5+Ls67kVhFPKbCWlkdn5U+ouz9bjNDQHfeEdXNNNSOV8Kqwd+PKPV72
	bP/Bk/ZmRUJuWQ9yCgN4BkIGUEa7QSE/wdPOD2oThk=
X-Received: by 2002:a05:600c:4708:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4a18e4a6ea5mr193465485e9.13.1791818986420;
        Mon, 12 Oct 2026 08:29:46 -0700 (PDT)
Received: from alchark-surface.lan (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19471edd5sm359712935e9.11.2026.10.12.08.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:29:46 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
To: stable@vger.kernel.org
Cc: Alexey Charkov <alchark@flipper.net>,
	Sashiko <sashiko-bot@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18.y] regulator: of: fill in supply names in of_regulator_bulk_get_all()
Date: Mon, 12 Oct 2026 19:29:21 +0400
Message-ID: <20261012152921.1140956-1-alchark@flipper.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026101213-dealmaker-endearing-04b6@gregkh>
References: <2026101213-dealmaker-endearing-04b6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit e2151c29cec73f6cc70abf1c7cbc7b9b202489f5 ]

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
Link: https://patch.msgid.link/20260930-regulator-get-all-v2-1-ca82070d22f2@flipper.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/of_regulator.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 32e88cada47a..c6ed75eb1ece 100644
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
@@ -973,11 +976,16 @@ int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 	}
 	if (num_consumers == 0)
 		return 0;
-	_consumers = kmalloc_array(num_consumers,
-				   sizeof(struct regulator_bulk_data),
-				   GFP_KERNEL);
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

