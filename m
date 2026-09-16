Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F7345731;
	Wed, 16 Sep 2026 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541367; cv=none; b=Bq0PSoUsoLoBG0kfCs1c/g373+q2623yWl/n+IWP3zh/hkY7uN97DVVUubf55Ir049Kqq9uqOBQP772b/lL9mcFYJEEVh1ej/YjjjcVIKxeI+VDz67buuKrD7CNNpr1DFjvabKx0ELQSqDCRt+1h+Qoxwcre0Po4s6xYgA3LbnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541367; c=relaxed/simple;
	bh=mCF4fxxxOnevSk0YHRVmuEF4GA8MIJgi/Rk6gjZClX4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=obqdSjfwPlQvr+teW1Qe6BuQhhdc0BPlxkBYW42HZAi2Er79ECWzx+xlV8+hPqGN+0PmbYMkilsnPBgrwVV/bvsiVzV4+qZm0R3jdjOmz5msbJI1Au7/fChb25qUR5Fq3e+/d1S/wdWoGfoo0yk4suKjJjMVrFolQhHzDin02Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYtkLmea; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYtkLmea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6FC1F000FF;
	Wed, 16 Sep 2026 06:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541366;
	bh=1+3AKlVt0GCOCVPUz0KKtTk0th0aRBbvGV1wqK97g2E=;
	h=From:Subject:Date:To:Cc;
	b=FYtkLmeacaFUGcXTONhYaZUWMraGw1MgdON4pVosIazEFlOPsEkWTT/4fmwVSDptw
	 7r9OLzXBiRffKtR6Qv1S35YIpkUCmF30qYBL/Jb8NEAYwV11qGwuF/m2Qz7dH+7nGX
	 xzcjFjMnllxxEQykZJCjTrHT86kRu+hR2xE264Y1xQmIVJdSkHb+pLZrSKN+xWOlQX
	 0l0stJCo28Bwn82THZE90DXKXuACeEkZuj2VQZ+m7oXLadGafml86AlcyFkoD4rVgE
	 034KXfF0NkFxOz0z337+bLBb+w2GNDWxn3t/sdvmqzc+MsgOava6zjUjr6t4Ilv1pA
	 E5JnylI7USBNw==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH 00/15] power: supply: Fix AB8500 and AB8505 charging
Date: Wed, 16 Sep 2026 08:49:22 +0200
Message-Id: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7TlgNI/tKdNDabC8WChFIf2/pO
 AwzDSoVpgqTalDo5spnFjCdgvUIOZHmTRgs2gG9cTrE0SFqkSVxTnpFu/fO+NCHCFJdhXZ+/uO
 8vO8HZrmRZ2EAAAA=
X-Change-ID: 20260915-ab8500-charging-c02f3519a3ab
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

This series first fix two serious bugs in the AB8500/AB8505 charging
code making the charging report bad figures. (It only affects the
human-visible status, the charging itself is safe.) These two patches
are tagged for stable.

The series then audits the AB8500 and AB8505 battery-charging stack
against the revision 3 hardware manuals.

The audit found incorrect register constants and several independent
logic bugs in the common code. It also found that AB8505 needs dedicated
handling for its five-bit USB link-status table, OTP-programmed VBUS
overvoltage limit, longer VBUS debounce, reserved autopower field, and
lack of an integrated main charger. The final binding and DTS patches
remove the five nonexistent main-charger interrupts from AB8505.

Some further fixes come from auditing the Samsung product trees.

After these long due fixes the AB8500/AB8505 charging is smooth sailing.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (15):
      power: supply: ab8500_fg: Accept status from supplied power
      power: supply: ab8500_fg: Report sub-percent charge changes
      power: supply: ab8500: Correct register definitions
      power: supply: ab8500_fg: Drop nonexistent AB8505 controls
      power: supply: ab8500_btemp: Fix event temperature reporting
      power: supply: ab8500: Preserve battery termination current
      power: supply: ab8500_charger: Fix AC charger re-enable
      power: supply: ab8500_charger: Decode AB8505 USB status
      power: supply: ab8500_charger: Respect AB8505 register layout
      power: supply: ab8500_charger: Handle detection errors
      power: supply: ab8500_charger: Skip absent AB8505 main charger
      power: supply: ab8500_charger: Retry AB8505 USB detection
      power: supply: ab8500_charger: Recover inactive AB8505 charger
      power: supply: ab8500_fg: Finalize current measurements
      power: supply: ab8500_fg: Avoid reserved AB8505 CCConf bit

 drivers/power/supply/ab8500-bm.h       |   8 +-
 drivers/power/supply/ab8500_bmdata.c   |   3 +-
 drivers/power/supply/ab8500_btemp.c    |  30 +--
 drivers/power/supply/ab8500_chargalg.c |   9 +-
 drivers/power/supply/ab8500_charger.c  | 404 ++++++++++++++++++++++++++++-----
 drivers/power/supply/ab8500_fg.c       | 179 +++++----------
 6 files changed, 421 insertions(+), 212 deletions(-)
---
base-commit: 803733e3585d6fd2d43c452c502173fa153b683d
change-id: 20260915-ab8500-charging-c02f3519a3ab

Best regards,
-- 
Linus Walleij <linusw@kernel.org>

