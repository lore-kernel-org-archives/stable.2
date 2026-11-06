Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793997120;
	b=kff46tO/7xWF95MarYBlkYFQeu7Ky0zfGm+WnZgyEyqmH4UES/57zgrefL3m9CzXmyU6
	 YJt+hERqym33vtyvuNffj+dXZZl+xnn+1Q2BViLwdY8cn+to/QVOuJ7q48qCzlUMtvFAe
	 JFFpXxEYNQP496dIE2ykrAxIKvQgQHBjEAw9SgSwPTNAmjW7eNXrU1OJgCjK7/JvU/zLq
	 fo/OMSQSae8leYgR5fwXpMlBB38QXLQ6d+hK5b2Zoz13kN+p64N+ow6kXcasJvqPtJQxl
	 l2ORR/fGtw03brktLfUankrzbkLKZrxKoZAS2/c/j+tI6Ste7TsHCwiLcyfqmWlvv+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997120;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=sKi2o/uu5IgPrw1L2INPtDLbQ5T1UDEqxDKdO3wNGXw=;
	b=bfvxKJacKAQ5CbXiQu3OpJ3dHrA83xV12VmP/vUDA9BXNfmZHtdXnFxVtknsc00YBFkz
	 lU37GY6RTnZeji99wXbfFuyTcS3I3kMcWckvcHU3XJkoN2wKHjQ+u3ZPrrCYR4lNkEy9C
	 sVc4TEjxSmLI/WK8SiZO2h86kTQQFz4YemeDG9b1Mo8lrQMJJ1W2Qd28HNq3hIIVDdlWO
	 neiRCjdLzPFg0hFuS3DgrhUIduPbY4PqKqEAhH9SEcBTWqgBuyVE7dWyDMfXHcgQwRMOB
	 aLXVsUUpivydxTOtEx8mfemrOPtaI8LZcoBpstd/Fsb6JIC26EibfNOuUVkGWDDFJNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXRgfNAv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6611A606A32E;
	Fri,  6 Nov 2026 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXRgfNAv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793997120;
	b=NLkIGl7iYauKC2PWWCQqZwHuBoQrfQUEsGqHclqtIHVEngjOK6qukuaa+1DxAhlSgFiF
	 zZr3fTDr1gug8jB7Qgc2Yc1Wxq5tFv9a2Usw9xdtt3Hbc3JD7Bibk2cBc6Ujf6sL3W3pB
	 aTpuZr802EqU94jyiKTBiOX0SO//g944k1/UyMzZ70rArJ/F9TNJGJX96PAdkPRFUB70+
	 9OTo+FZhadq2Kn2kEHfd7+ZZ8hr7fmpRnhVqXBcVsW/1G//jrMhl1AZT9yNy53yOewmus
	 QvSypB5nCkVXt16sk5+S+VpyJIYTLVmz8Eu+N5hJmDJO/sIVXB/H+IrfP2DtStLvXLw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793997120;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=sKi2o/uu5IgPrw1L2INPtDLbQ5T1UDEqxDKdO3wNGXw=;
	b=Tb+gaWp1WcxWw/PWX2gMh9OWpyZsCNtGAUPhaclPlRZlgk8WFQhW0lYw3Vl4On+wl6wo
	 jH6mzfwlxVsMRMaHOVJKYFJDTHgUq3gWD7Pp18/6OTpMHoQK0J3QTATj5BHWnIJMD7GDD
	 i45E0DM67XtPenMz7+ZgKpPLBx2nzNy+m4ozDOl90z0HuLmhyPatSh7asqm8HlT8w4vCo
	 c5FPuY3nv2/EfEIWbtHNIkbejiCYlOhR1E7ALu6mvvlqd4qyY0msD9MHsPXqUIPHUHEdi
	 G3lEYlaO+10hqVWwYDz2eaf3RCGBji5PZGwk4TSB6us9ui4VF3PuB+lKlYt3ZklmJ9Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 425F61F008A1;
	Fri,  6 Nov 2026 20:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997120;
	bh=sKi2o/uu5IgPrw1L2INPtDLbQ5T1UDEqxDKdO3wNGXw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=lXRgfNAv/tncRuQghnssQatsgmfz5HW7HxsSQwvxmIaXM0KvYg5/yZKO9IjHz86GI
	 /RyIwycJLdint+6UUfEYl4rEiOQvcE354fUL3c9WvpF3suaNm2wWd7RDZbr2kTcvy5
	 y6BjLKFocI8I6R+w2Y0bFlas9xqn2TObQd8fqjTIe0OPsVnrfizH9nENoVmo51c0RV
	 d6SPVm04BMYc0hbfvA0cjD74O3UCeM98MlwSEKR8l5feI/KATTKFgfcrOwdP03i09H
	 8qHliwFgvS/2jmFrhl942I/Bmjui6/mTSfR8Lc2c2N18EOgJXC7WfhvFVPmiKLbNOq
	 MBeXfKrKaRYaQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C760947855;
	Fri,  6 Nov 2026 20:31:58 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Fri, 06 Nov 2026 21:31:55 +0100
Subject: [PATCH 1/2] thermal: tegra: soctherm-fuse: Fix shifted_cp
 extension
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-upstream-soctherm-t114-v1-1-c875d1921084@tsv-stahl-riesa.de>
References: <20261106-upstream-soctherm-t114-v1-0-c875d1921084@tsv-stahl-riesa.de>
In-Reply-To: <20261106-upstream-soctherm-t114-v1-0-c875d1921084@tsv-stahl-riesa.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793997117; l=1434;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=MLvTnVsW0kVdSgK51jO4RNGfRwj0oR/unyRQ4OwOQTg=;
 b=7CKnSpoLD386zMftzrm0HMM+g7cE5QtB0xWJNCCAWsgCyVJ6mYNiRP2bEC6WP4y6N85K33quW
 UOh8I/6qWgaB+7GyapE7IitnT+qt4w4hqzlUvSrY0PoY0U8kjfUGI5q
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de

From: Svyatoslav Ryhel <clamor95@gmail.com>

The shifted_cp value in tegra_calc_shared_calib() should be passed to
sign_extend32() similarly to how shifted_ft is handled. This omission
caused malfunctions in the GPU and memory thermal zones, which was
observed on the Tegratab.

Tegra124, Tegra132 and Tegra210 are not affected: SHIFT_CP is in the
low six bits of their fuse word, so sign-extending the whole word gives
the same result. Only Tegra114 has SHIFT_CP in bits [15:10].

Fixes: 48fc33b95159 ("thermal/drivers/tegra/soctherm-fuse: Prepare calibration for Tegra114 support")
Cc: stable@vger.kernel.org
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
 drivers/thermal/tegra/soctherm-fuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm-fuse.c b/drivers/thermal/tegra/soctherm-fuse.c
index 8d37cd8c9122..2de1d0cb676e 100644
--- a/drivers/thermal/tegra/soctherm-fuse.c
+++ b/drivers/thermal/tegra/soctherm-fuse.c
@@ -102,7 +102,7 @@ int tegra_calc_shared_calib(const struct tegra_soctherm_fuse *tfuse,
 
 	shifted_cp = (val & tfuse->fuse_shift_cp_mask) >>
 		     tfuse->fuse_shift_cp_shift;
-	shifted_cp = sign_extend32(val, 5);
+	shifted_cp = sign_extend32(shifted_cp, 5);
 
 	shared->actual_temp_cp = 2 * NOMINAL_CALIB_CP + shifted_cp;
 	shared->actual_temp_ft = 2 * tfuse->nominal_calib_ft + shifted_ft;

-- 
2.56.0


