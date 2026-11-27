Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804636;
	b=5YXkglXh2jik1N5DMTHg9NDMQobImB/LJ7Z+5lCAmUXYrFSPZi0cEu0gsObvyoqEN4N6
	 booSr/UnedfZzFDkdiuzthWY4cICnFMtV+gCAGMu4EI5HM4xmPoIVAHZKGEiimJFZA9La
	 DmbRgQsJlrDXz4GbStL5R0QmF29HksZ0Bn70Wue0nGWkUGsPgXRJbkuF9yaIzsRuCKB/W
	 8Gd4CvMBB8/ALa9fm/4wzhntGmar+wYSm21Lzkl7q4pqvc1LzjgaZtcU5j7t3ALjZtZOL
	 yYnn9VDZXYfhx7CIokOpMhoagj9YcFpm/k+v2XqTr3C6kG+oX+bNoJG8nH4CnGt4Ztw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804636;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jAHrZSXCclT5tuYxbw4PyJ58XQOTUJZ36v6HkISnfd8=;
	b=Lvbg89XUx3Odx75WHF5+uBiwndxwYVWYeotTJUXQxHThrRwMhrDhWxG3oT6uu0L5hb1d
	 i4Vldp4hoT2Vais/g22DCLV6xG1TJfw5R3lxjOM/SbzbU+t6z8qMBijL60bR+DjjapFhZ
	 +vYPXvsF5zJKVUbx28LkdJtcm+XKIcpJXI8I2OiPNZ0E4Wp1KZjcVFwI+1oylS8UrtA2Q
	 3jDzKGqKAlMXl+fDfNh7piNrK3QF7J3cEyqD1dbOoR+eLUhEaYK09s6INHai4rg43DJFg
	 ailV6AJfZvU07wY6eDDkVBk9ENRd4mBZuLArzyYjtetPlxJXUrHSV+3U/IPMCchje6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hTnWc/rd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACCC606A31C;
	Fri, 27 Nov 2026 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTnWc/rd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F731F00893;
	Fri, 27 Nov 2026 18:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804636;
	bh=jAHrZSXCclT5tuYxbw4PyJ58XQOTUJZ36v6HkISnfd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hTnWc/rdupJK1rwSG+PezVhQWPfZEYbSsSWn+bDNB9/dobx8vQ80mfRb1R4zqsetb
	 T23wHKua7F9b1kZ9pHi/4R25b1crGfUcASN9FH1rJmReiqH38+fekp1ZJ/i29Fyp9b
	 hR67XelxwdWjTqqZJGLp1U/sx8VB100klHP7c1MzqkVvNVZecdPOCTcCohNlMXz5yq
	 tnMqFKvMG4l0T/wFJjHpOHw3SS2DVw4K4klHvO1FH1u0okdsQe0giYEHpbV7RsFBob
	 HsO4M308a4cuJmRyjeVNY+ZxTO3j6tuuKrWVESP51A9jxSMwn21VqoR/K8tVo2G9fM
	 CM26aLcnpd6DA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexey Charkov <alchark@flipper.net>,
	Rajendra Nayak <rnayak@ti.com>,
	Corentin Labbe <clabbe@baylibre.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 7/8] regulator: of: Guard against NULL device_node in of_regulator_bulk_get_all()
Date: Fri, 27 Nov 2026 18:35:47 +0000
Message-ID: <20261127183624.3341010-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127183624.3341010-1-lee@kernel.org>
References: <20261127183624.3341010-1-lee@kernel.org>
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

of_regulator_bulk_get_all() passes np straight into
for_each_property_of_node(), which dereferences np->properties without
checking for NULL.  Callers passing dev_of_node(dev) on non-DT devices
therefore crash with a NULL pointer dereference.

Return 0 immediately when np is NULL, matching the !CONFIG_OF stub and
the empty-supply case.

Fixes: 27b9ecc7a9ba ("regulator: Add of_regulator_bulk_get_all")
Closes: https://sashiko.dev/#/bug/linux-626e95b1-6ae0-438b-95b4-b7a96b2fd27e
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/of_regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 81d4f8b6458b..0a316ccefaa9 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -947,6 +947,9 @@ int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 	char *names;
 	int i, n = 0, ret;
 
+	if (!np)
+		return 0;
+
 	/*
 	 * first pass: get numbers of xxx-supply and the room their names take
 	 * second pass: fill consumers
-- 
2.56.1.839.g22a8290db9-goog

