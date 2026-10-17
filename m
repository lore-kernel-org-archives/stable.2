Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5EC37C109;
	Sat, 17 Oct 2026 23:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792279005; cv=pass; b=HT5X7fTM6uZoub4IPsBiW6P/lJWluq1pHLgh3bLBCO4ULh2WX72+aaYHJxduSCj/yo6/iPCQGYYdkybC57syTZL6ny/nY6PH75iomEWsz2a5yR5TEySx9iQjkEvVUXHfi+owWreznpRA5ilSWTOetRQkbUsXJVvsZhNwTj0CyyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792279005; c=relaxed/simple;
	bh=3NLu69xnmXGuJpUsAFPYowmvOmnuWDR4fL1ZandStho=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LaWZtPAZuUU0rv4grH1TZRCBIEadrII5nt6kmBl7pXgP4n4JNKE0hdK1RyNAhXcAXFEd4/5SkojQeYEyeZObFUVtPpytrfN2bkOZDd8POxV6WwCLrIrZ8veHSJRnoBEKUkTvn/iHN6o/eR1JdiLMUQHpSS/53AWQm47+xQcP+5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=Zq1M+mOS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="Zq1M+mOS"
ARC-Seal: i=1; a=rsa-sha256; t=1792278994; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bhITBwjKH8Pf/ovfpye7cm5efSAx8IRc+EuBGR56rnhOS7VZ7gh8EekMPBmA9yQ2i87pzKANlfq+fu9Q/DZfR82pGLF1LxAjMLhFihJxEMWPnTRY1ZsLwpNZ/PQvydr48eYwFKyvqh/BoRwMeb24wnj2pQhnPwn3mL2BN9qXu4c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792278994; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=53HKstwmkLPFbV8XfZ5DGpoM+Ybu/fPwYEuOn3Qd33A=; 
	b=UcP1d6/i8IdKG+793rmgjMcMzsG8KkvwSxpeUwwlnqcz1IiuP3GyaBGlc0HnJtN4s8s8WzxeI4r6Myl2D15NdsJ/+RN/PcZtifkbMnKbAwknENOPDEQ0QpmCRfaAUcy24/vha4jb8nH7VJvHosXlEpYsg7IH+FxMvRMgRuhn5fg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792278994;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=53HKstwmkLPFbV8XfZ5DGpoM+Ybu/fPwYEuOn3Qd33A=;
	b=Zq1M+mOSRLIKvEUQ56W+cLGx7wx5qvDyRRZUUKNDPBLGW9OhK0NGOTeQUPemFnoD
	QAlAdasQCIdg9d7vx644j5mlXyL6oHVoUFM2piOstcYnG0sgzcPtW6mw8IkzfiCHIeW
	Oxt77yBC8JV/yDL518Fyv3Bs8XvYs2gJzeSw/ce+u2fTmGXsfc3Ffip42yZ+hvw5fQH
	0e3za3KtmgnFCXrfxxbaYRFhfS9z65eh+z0YwInWjEUSAMcql19ze58FnEUxl0iGfIQ
	tWddsjR6FBOXmnfgjWFxlb4/kA91xN6Qn8zOnA4GAqhOMi3xNVqI+Wl8g4G5yxJ+GVc
	nBOsS5cMhg==
Received: by smtp.zohomail.com with SMTPS id 1792278992220550.5663809917767;
	Sat, 17 Oct 2026 16:16:32 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Subject: [PATCH 0/2] platform/x86: ideapad-laptop: Fix unexpected
 charge_types on probe
Date: Sun, 18 Oct 2026 07:16:17 +0800
Message-Id: <20261018-ideapad-fix-charge-types-v1-0-db52e3bb061a@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQBBE0auQXjMJkhGBqxAWA11os8DJNBgJ4
 e62unzJrzpIkQRKbXZQwktUnovhkmc0PsJyhxM2E6ayBgdvRIiB3SRvZ0WyYt0j1BXVjX3FRd3
 4K9k8Jljzu+76v3UbZozr94/O8wOVuyxEfAAAAA==
X-Change-ID: ef28eda4-ideapad-fix-charge-types-067d46d08945
To: Ike Panhc <ikepanhc@gmail.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-73bef
X-ZohoMailClient: External

It was reported [1] that some unfortunate combinations of BIOS and
Lenovo utilities (e.g., Legion Go 2 + Legion Space) may enable Rapid
Charge and Conservation Mode at the same time, which is very out of
sepc.

If both are enabled during a previous Windows boot, ideapad-laptop will
see both bits set and correctly shout "unexpected charge_types".

A planned BIOS update will address this. Before that, if unexpected
charge_types are encountered on probe, enforce [Long_Life] to prevent
the device from operating in an out-of-spec state. On check or fix
failure, skip registering the battery hook and the conservation_mode
attribute.

Note: the switches never enable themselves autonomously, so there is no
need to fix it during runtime.

Fixes: 90430ea98f55 ("platform/x86: ideapad-laptop: Add charge_types:Fast (Rapid Charge)")
Closes: https://github.com/ValveSoftware/SteamOS/issues/2876 [1]
Signed-off-by: Rong Zhang <i@rong.moe>
---
Rong Zhang (2):
      platform/x86: ideapad-laptop: Factor out charge_types methods for internal use
      platform/x86: ideapad-laptop: Fix unexpected charge_types on probe

 drivers/platform/x86/lenovo/ideapad-laptop.c | 113 ++++++++++++++++++++-------
 1 file changed, 84 insertions(+), 29 deletions(-)
---
base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
change-id: ef28eda4-ideapad-fix-charge-types-067d46d08945

Thanks,
Rong

