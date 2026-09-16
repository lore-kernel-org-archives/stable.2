Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187463ED3CC;
	Wed, 16 Sep 2026 06:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541370; cv=none; b=CKs8sMBmYHeyjuC4bx5rzZZ0rDn4w14tspMPJOUujmOF5oKd6u1xfBY39tPeWsIxrhu0OY0OMIw2jyqRwa8kyOWfR1IFljFW4aIjAQMtkhZzmadTjM2Akz3vn2mKEYTDUelRDcZWYcJNBjJxxqS2JfegGh1em2pMhSbb6114cbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541370; c=relaxed/simple;
	bh=qOIPWsp13X9r7EYozdgCKL/qzN2Wk7DhYqV7rf8ImIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=agKZugw7fYuzxEtmmTN5SZqTwINu3AHZoghx+t4VrA/HtzYc52tyeA4SHYKrjJzJmXmuU/3gjs6FPPNF05HKhh6RH0/U3rVBxauPn2EeOk9H71rY4KxoWt8SaQXKerSGpWiC8Cbo8YyjgoQo61emKRaVW5m7D9/rx50vHAuQxA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8lDpki2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8lDpki2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BB71F000FF;
	Wed, 16 Sep 2026 06:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541368;
	bh=vXEBdpOLFPBPlqKg/6+KeMflN5If6mNqz+3rPjfZq58=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Y8lDpki2YN8MHxOx5LdvKA1IC5TJXRg7uuMdLL6rfHaK3qVTZZ2qRNkj7Wy+ansIw
	 eHjukKJVvrXA8+6JfiHdOg1cYM8TCpVCTV5lOs/edC/v5FyaEwBtxiE8V0N0a1CrBG
	 OrxacniJ9TM/Zo3xSkSG3e+KiASBLToKHiObUJLhfi2XWWn7BF0iYDCVaIUfeRR2cO
	 v9W3sz85zlHP3t+8LLFn7HOezi95msqflC7Nu0yn6vQxV0JIyJNmdmlM/VFOCTSnP7
	 9xXg/oX/Y1MvRrD3K2lixy8BliOmIU4L2aGY3EQCx1fS5iyYhT/6fTbj4XsfcrRK0I
	 OxmbR/g+WS1Yg==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 08:49:24 +0200
Subject: [PATCH 02/15] power: supply: ab8500_fg: Report sub-percent charge
 changes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ab8500-charging-v1-2-e986ed321cc6@kernel.org>
References: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
In-Reply-To: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

The fuel gauge updates bat_cap.mah from the coulomb counter but exposes
bat_cap.prev_mah through CHARGE_NOW and ENERGY_NOW. It only refreshes
prev_mah when the rounded integer capacity percentage changes, making the
momentary properties appear frozen between percentage steps.

Refresh prev_mah and notify userspace whenever the new charge remains
within the currently accepted percentage. If a discharge estimate tries
to cross upward into a higher percentage, the existing rejection still
leaves both the reported percentage and charge unchanged.

The AB8500 fuel-gauge implementations in the Samsung-GT-I8160-Codina,
Samsung-GT-I8160_HD-Codina, Samsung-GT-I8530-Gavini,
Samsung-GT-S7710-Skomer, Samsung-SGH-I407-Kyle and
Samsung-SGH-T599-Codina-TMO product trees retain the same percentage-gated
prev_mah update and contain no finer-grained reporting workaround.

Fixes: 13151631b5bd ("ab8500-fg: A8500 fuel gauge driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/power/supply/ab8500_fg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 016ed35e90f9..c5eaa32c4a2d 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -1387,6 +1387,13 @@ static void ab8500_fg_check_capacity_limits(struct ab8500_fg *di, bool init)
 		}
 	}
 
+	/* Keep the charge properties current between percentage changes. */
+	if (di->bat_cap.prev_percent == percent &&
+	    di->bat_cap.prev_mah != di->bat_cap.mah) {
+		di->bat_cap.prev_mah = di->bat_cap.mah;
+		changed = true;
+	}
+
 	if (changed) {
 		if (di->bm->capacity_scaling) {
 			di->bat_cap.cap_scale.scaled_cap =

-- 
2.55.0

