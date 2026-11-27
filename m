Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795823087;
	b=AbWs+s5p5qcDLNftGA4zVsVssXwwR4O7jtC5I0ettMe+Jt5dDkmQlzSJ9xvT/t6jWobV
	 T65dMMyg9XlcLaDmdqm4JMfOBKuvQ8s6L8LuNekhUGnWtzWOYE97Q25qOOLF8Hl3GxAU1
	 UngUzu8FCvC8Eh1jPkT+djoTziAnnyPQZSqjFhSccgaWiFopatUxHqFB2jQ8/7BPDLutz
	 jKLzqkD0KlWNixm3Khj6FSXGDkQ1ZY/7UB5nfcFW++vuN/GbZYOKElluiS47hA6rD2pr0
	 RwCLcwrHydli314QAKZtpYrBiW++jR0Ifs/N988NbXXGvaxVe5MNkiZttaXXjgtxtWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795823087;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=NyFa5+QRGdiGBA7vzS8aDyP7lR2va9y9iB0GSwTVIec=;
	b=wxJ4/3aDJrpBUfAEsqqJG6s8/Pyrbxyt+cBeXYDZ7sgmbkzK8jBFea+qQuHi7GXpTN97
	 gHCyKNwNJkp5kJUYslrUT/C4H1xT2lVqQyZTQLA2N/ljxho1tb/PYDSFvbGLPsHq+mpgI
	 b5bJBCQ1HQ3UCff4qNg1MKTeA6OECdHfT9VRd/tZ9qO6aRAEqg5MKvZBo38uxgm3Wgw6D
	 cEDCRJfVY3sQxya6mk8fffBMlrw+nEeUZdzUKZl4ML7GRVHMgS2x1/yA0yTqmNtj+aikQ
	 mZO0bRPeZ7+t8InWFq2WswgRglacKdciLQiVjcrkx/ENsEKqLZcpkc2HlYY0wWhok0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=niSETPpG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6CC606A31C;
	Fri, 27 Nov 2026 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=niSETPpG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795823087;
	b=TF1PNK2ea/XuB35zXA8eAW2g9SsyJz09gzY6d2mKRXwmwWFR7BJrhiNHFxaaTyLLQEV7
	 mlVSq8bmYZDW15KOAm/8O1uXCSMmlwwtFPJr+y/qrBSc7r1FNsbQHe5fkTQl9jkFkn6ss
	 p0K2auFXQadnWpZIaj263416zQ3+oWcXAkIMPm4avsZaLSID1DhmDJOpFKkyRPosflIm3
	 y4X1EHsJd9EvUxrZcnkGSPVRW/rf/F9O3k/n6hQXPqBUNYnwEVT+O6KRJa90lA0JFRoaN
	 T1NuYgFC2M1IcAJPFLrAQ7GXgGDxiz8YH3sammsORQa7bBQMRPDW0J0Ju7d9SiwOhdQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795823087;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=NyFa5+QRGdiGBA7vzS8aDyP7lR2va9y9iB0GSwTVIec=;
	b=Gphd5qGNbw2sowCrkAiPzKx9DD18Utr5TGBBmufzgI3AfBX6CbCvdJzJgl7jzH/G64FS
	 jNuT2Jp2XBQcnylIEzyILHlpl2oASgT26dIcdhwhgZn+8vcU3Ln149P5cXecjLOmUR6K6
	 YQCMGKZ3s2iJc7Vwn1oys2nvu6G0qH+e/9E0oSvfAS6FlsnrbO8EX/rGVME2TZB2anxzp
	 mknndOWFeTJ2CmjVv1bOHSqF8rKpxFuDBdzXrvW8cVLsKvtoMeKQPjD5lXDoKqwzqKDeU
	 Gv1Ioj1PHGxW/2te919htzyGUG02RqQBcHFmdTNn23a32JC9qHdO6NrvEw4NdFduWhQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B58DC1F00898;
	Fri, 27 Nov 2026 23:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795823087;
	bh=NyFa5+QRGdiGBA7vzS8aDyP7lR2va9y9iB0GSwTVIec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=niSETPpGN8HUgBTzUnazdJM9gLA9btDIZGirmV8G5QWmV/wNWTGd3PFax+6S+nHKA
	 fEWUgohc8iHKmqhSj0JNrSzdxp0eggY7e6iEFZkTy9g7d71LyUtcB3ek4pMT3N+FPH
	 lIrfS8W7tG/mgviJt83rPs3VykTAmJTVO5T0IWpCCwsp+rNwJDOcClHYqmaPzU3w/I
	 isJAhN83G7VNHcZJGDoulrB0GhQ0VTTjFG1lhC7zldhZkxLT/kmGTt8erdPizFPGZ1
	 5l3HVpkMOzkAGzt6yweIAZyNouBy4MqfMwbpGfKCS1xAIPTYq4iME7H+MaJsujuenq
	 zOHinfKOakEGw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4125E4DE96;
	Fri, 27 Nov 2026 23:44:44 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Sat, 28 Nov 2026 00:44:38 +0100
Subject: [PATCH v2 1/2] thermal: tegra: soctherm-fuse: Fix shifted_cp
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
Message-Id: <20261128-upstream-soctherm-t114-v2-1-abba0b143037@tsv-stahl-riesa.de>
References: <20261128-upstream-soctherm-t114-v2-0-abba0b143037@tsv-stahl-riesa.de>
In-Reply-To: <20261128-upstream-soctherm-t114-v2-0-abba0b143037@tsv-stahl-riesa.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795823083; l=1488;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=IcjQLi3EWU6uv5WDPVnI7H+1UDXjOHTlhu+GBJlQqns=;
 b=PgIHvzOtSW3OLtcWYAoN4ygEWEv/nJyAbtlhH6pa0gTNCPLy+U1zvXYZZwcGageMbNMYQlO8u
 0JhS/246hv/CTm7TdNmTUGdL2OxuIp7B8e+EgZmYlUhDG78kgtkD1kj
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
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
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
2.56.1


