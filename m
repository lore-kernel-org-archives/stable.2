Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804630;
	b=jjaU1eI+zwO/3Z3969aRrAa+WWRhzrcbvJ963uFYsNXweyzS1bn39BcyPyE3a1XUw/qu
	 XyPLFn67GRgGjab53Vjt4o1HeK/QA1DF1K6BAlCJq/cd3nGCNcr88RLXiJzcUOZSfQT4L
	 Rg3T1Niri6c5o7QPaRCByF5QKlG99eo1uLLW/TQnrJy6PMxTOqDrH7Z1hRhcKXG51/iJ8
	 I7NaXaprK1xga+qtKu0PYsvJSTo5aHVP23IYxyodM3DkJW18L8UKWBnf1whqXq0r3hckU
	 A0PsnzOdCHa0gEKFJttcLn5jk8/fd3VKYigaZOb19LVE6JugaXvA8PYEmjnApYis25A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804630;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Kb/ec86qmdWlooR732Jz5Qk9ECZxpCxg4zmp2LPbsY4=;
	b=llBh235Td1gAEl6YElq9LFW5lv0rvCkj1KVAd+kCTzAPUb+swchdmNsEpZQro4lm2TfU
	 qKuxgD8wpjVR+NQkK2LTKjG26S8qHIfD3Co9TTsTsbgiWrk0x7g8AvLvl7DroiLav32nl
	 PULlFsY2jd7ODzd+mu//OAMJezcZzbAFTF3P8tdh0yQIHduY7piobrv9SuWgi1bYFI+Ex
	 NTqXKU2NUNrXBlppYAJhMiulsAHc/GysZTJX/7MiByUlQ/+8I5RE7A3WA4/ishzRwpjBV
	 o4girw7Tld/AMMVmtCSLlxOUvtI6XmxyDAtFwxs0XxtZpiR8B2IK8CGM98fcNJOFkNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PiOqfKgU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332D9606A32A;
	Fri, 27 Nov 2026 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PiOqfKgU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08551F000C1;
	Fri, 27 Nov 2026 18:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804629;
	bh=Kb/ec86qmdWlooR732Jz5Qk9ECZxpCxg4zmp2LPbsY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PiOqfKgUqAxi4ecaH1yEfqOUNBrEuPa0NtUXSc621gM41RRd1szIjbsHspd5Qqcx6
	 iUhV7mst4J74n6+lMBpPSJ22SAuTZFBXsnrXvCm4+NZGFVSj/IMGHs6gGaVylVFwDx
	 5+ReHkEchC2U4xRKx+buUpATBfnmaS4dwXhlxcid+/oaycsGmyu9KdjRJKO+Z0klhc
	 SowEBn4hSEA0ylxP6ktAx+TFpVo2CN+Dgjt5HiPao9GwjMjB/sIcWgVxe61DK2B2Do
	 z5OUMmLKQuPrEltsbIZda840uuWga+4L8jqwgh95gGFZ4O2qTYw4o+N+BZG6PBXH8y
	 Gj78gRJw1IoNg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6/8] regulator: core: Respect is_locked when disabling supply on enable failure
Date: Fri, 27 Nov 2026 18:35:46 +0000
Message-ID: <20261127183624.3341010-7-lee@kernel.org>
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

When set_machine_constraints() is called with is_locked set from
regulator_resolve_supply(), it already holds regulator_lock_dependent()
and uses _regulator_enable() to enable rdev->supply.  If
_regulator_do_enable() then fails, however, the error path calls
regulator_disable() unconditionally, re-entering
regulator_lock_dependent() and inverting regulator_list_mutex against
the held ww_mutex locks.

Use _regulator_disable() when is_locked is true, matching the enable
path above.

Fixes: 8d38423d9dea ("regulator: core: don't fail regulator_register() with missing required supply")
Closes: https://sashiko.dev/#/bug/linux-e745c649-52f1-4f96-966d-49c3f8addf7a
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 18ec8b77e620..121b0b49b8df 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1688,8 +1688,12 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		ret = _regulator_do_enable(rdev);
 		if (ret < 0 && ret != -EINVAL) {
 			rdev_err(rdev, "failed to enable: %pe\n", ERR_PTR(ret));
-			if (supply_enabled)
-				regulator_disable(rdev->supply);
+			if (supply_enabled) {
+				if (is_locked)
+					_regulator_disable(rdev->supply);
+				else
+					regulator_disable(rdev->supply);
+			}
 			return ret;
 		}
 
-- 
2.56.1.839.g22a8290db9-goog

