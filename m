Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795823101;
	b=QKctw8jd9I0EC3AMmd1TTUKbuoPLPLw2J8HyhS6vvTxyBn1GPs2ojkU8PClGTinGHQMN
	 kNfKXtbJ7DUfNGsCRvi7Yo79vrvqylznxiCQFIZNgHeMfnfdWLkZULCj0ZQHf//DxbB9f
	 1vugJr+w+07kEMwj9qypf312DVfCKQ/cQ4NYn0+O0frFnUWDZ9EQzsdTYK/eQAHNI1ZBa
	 J5Lr+7j0rtnSebQnAzPKWLYU3Zselo501qLTGyylEG5pakzGjbV5l5DlBsOOJKpx9XyoC
	 iPUlXuqPWaD6tafwv0Tx5AUczab8+hrC+hiJAiCQHJdxaN2dg7FoJdyhwrQW3tr3uxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795823101;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=syLsiIwnXzdBZfyEbQ/+vbqdrjFhzaLPW+SuQ9HVRFc=;
	b=m4M9q/uTZDTSXnZDK3CHHGoptq1ONWZQeK1t9TJ84wKXpQRKV0eQqYOH4VEYHTip6q9o
	 LPE/zYct/t56c6v24lOhsh16YV/4SHNp2ybwoy1pZDmPL4z8PmHhYy47mFLhF7ftniGOv
	 e1iFq9bOlbvmb6UgkvacX9dF0IgcRBDylFRi8Bs0QajLh92iinjbDJZE90zfOo6aky3fQ
	 K/tt23UOBF8cH+uoxzax0x4YDM+vZv8e6KcYSH2c/YoPfjQZoc/rqQ5bbE48H2z7IFZor
	 DtJoOrRQ56r3bblTzUIqgpoqEFuWlGrIrwsckJfRmCSjWGGiXowRK3l3jgvg2ptLPaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVtLTV+Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF929606A31E;
	Fri, 27 Nov 2026 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVtLTV+Z
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795823099;
	b=MNaHy8/3xVIm266hkfj1ewHt/nKsQ8tsCj0XNB7rLIKVm9KKk/yLFTSBcRJVUuilaYUq
	 sCCusTs9g7Oh/Pbb6tJYejMSCefjBa6B1w2MRhbBD3zKJu2tHlFIhxhn/WvxgBCdwRlLI
	 /h75Dw0z+NItGzWIeCRaXSBYoRjgOxKyJ0S3eoOwbjgbK8+tM3II9ctmPKSLkbJHD5VRP
	 FTfd2zsCxmkcOs+u+Uwwxqkp+N9TZLrV/VelCh3wboKjSBPSaE0nyM+lULaA+r+D3o7l5
	 QokBuUZvrp/wiQiLCCWfXG+V4N7N0hPtRNUeEnJfZ36vERsKzBaXl5BOhlMAgfSezoQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795823099;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=syLsiIwnXzdBZfyEbQ/+vbqdrjFhzaLPW+SuQ9HVRFc=;
	b=jtYKvj/gdvPi0DL1aN0DJ94X/AHr/7vATrZ+A78igl60IAyUw6cDTISNugrONilLApY6
	 4angAgALb51M0jW/FJTV8AJUs35Q+oenXgIjhJRXrkFZEw1N7LUDkBgVeIXSnnr5yPq8x
	 dxfYZATG+lBjFdORoeZ2xdp3zoYsA7qaUcerIM0jkifMidwV3b05MorlXr5HPJRaFg+Dw
	 E4wtXEdmQ8rN1yzt4OwD2spchFGd0TLJIGSmc0fuB1dw3SHFGZMxxyWg9QKYeOTneIGrk
	 sFBQhhe6cpV0aR9HXQ1xQe0bGbdNVbClk9ylX84q4kRvvMQvzxHEcr3UbmopCAlx8dQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B51651F000C1;
	Fri, 27 Nov 2026 23:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795823099;
	bh=syLsiIwnXzdBZfyEbQ/+vbqdrjFhzaLPW+SuQ9HVRFc=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=NVtLTV+ZNmzErfsfc1SF9LT8xfcZiMWMlO8TB9lkKK6AiiVXoLqPoxjIZFs8TcWCn
	 PR58E4PQ1gnsCM5J1vJNXbr35kQYxrH+Na8NjLApLDGACBTRyoCmgcr7IJ3kCK8DDF
	 RKHj+AXp0FyvmZJPipGJjEsGZ/0wArpmMJvXtsU2qn4+s+WpCcFzs1GzrksNHoxnmu
	 ZHwD4iPUcaUFMqq07wp7WDAMAsj3nZ0W+FEWajEW+AmQWrfc48hrIBcIZFHTGIlrFO
	 L0+1aWWOaZj79qtNa0oXmvUDbAbPo3dbx4P17acFywAS4gLpMZ+wgSH08vslW3WUZN
	 s+orFb5oyW6GA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 171394DE86;
	Fri, 27 Nov 2026 23:44:44 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Subject: [PATCH v2 0/2] thermal: tegra: Fix SOC_THERM temperatures on
 Tegra114
Date: Sat, 28 Nov 2026 00:44:37 +0100
Message-Id: <20261128-upstream-soctherm-t114-v2-0-abba0b143037@tsv-stahl-riesa.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WPyw6CMBBFf4V07ZhOhQKu/A/DAtpRauSRTmk0h
 H+Xx9rlSe69J3cWTN4Ri2syC0/RsRv6FdQpEaat+yeBsysLJZVGqS4wjRw81R3wYEJLvoOAmEK
 ZlWh0k+el1WItj54e7rMP36uDeWpeZMK2tiVax2Hw390cccsdEpT6nyQiSDBFnlksFcoivQWOw
 KFu37C9qM+WRLUsyw+eKDEM1wAAAA==
X-Change-ID: 20261023-upstream-soctherm-t114-9591c6b779d6
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795823083; l=4026;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=HMbDX/tvfwFB9yCKapyd4+Ik7HuObbH7taQimA/KzxA=;
 b=izg2hsSXyYuLLiU64w9sd/5EJAUCtmU0aZRCYpn2chN/5KNw1JgxGHCh4v2BKtyjZtaNO9fN5
 TckFW0yaljrDmE0EhR2FSWJEzQMHu7Vb6r5+aCDRiFPblQKxopf2WH7
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de

On the NVIDIA Tegra Note 7 (Tegra114) all four SOC_THERM zones read 0 C
with mainline, in idle and under load, so throttling and thermtrip have
no effect on this SoC. There are two separate causes:

1. tegra_calc_shared_calib() sign-extends the whole fuse word instead of
   the SHIFT_CP field. On Tegra114, where SHIFT_CP is not in the low
   bits, this distorts the calibration of every sensor.

2. The hardware calculates THERMA * capture in 24 bits and discards the
   result above 2^24 (TCALC_OVER set, TEMP_VALID cleared). With the
   calibration in 0.5 C units a Tegra114 sensor is only valid for
   T < (2048 + THERMB) / 2, which is far below the thermtrip
   temperature. Patch 2 switches Tegra114 to 1 C units, as the
   downstream driver does. The fuse calibration stays in 0.5 C units,
   as discussed in the review of the Tegra114 series [1].

Patch 1 is Svyatoslav's fix, unchanged apart from the Fixes and stable
tags and a sentence on why the other SoCs are not affected. Without
patch 2 it gives three zones that work only up to about 45-53 C on this
device.

Zone temperatures on a Tegra Note 7 (P1640) in C, idle / after 60 s of
load on all four cores:

               mainline   patch 1      patches 1+2
  cpu           0 / 0     41.5 / 55.5*   43 / 63
  gpu           0 / 0      0   / 0       39 / 55
  pllx          0 / 0     44   / 52.5*   43 / 62
  mem           0 / 0     39   / 50.5    39 / 53
  thermistor      -       34   / 39      34 / 42

  * the sensors behind the zone were already invalid, the zone stayed
    below the real temperature

"thermistor" is the board thermistor on the PMIC GPADC, as a
reference. With both patches all eight sensors stay valid and thermtrip,
throttle and trip thresholds are programmed as 102, 100 and 90 C.

Tested with v7.3 on the Tegra Note 7 P1640 (me) and P1988 (Svyatoslav,
all four zones work). The series is unchanged on top of
thermal/linux-next, but only build tested there.
Thermtrip and the hardware throttle were not provoked on purpose, the
highest temperature seen was 98 C. Suspend/resume was not tested.

The series is independent of "thermal/drivers/tegra/soctherm: Program
throttrip with hot trip temperature" [2], which is still pending; they
apply in either order.

Tool use (see Documentation/process/generated-content.rst): patch 2,
its changelog and this cover letter were prepared with an LLM coding
assistant (Claude Code). It evaluated the SOC_THERM register dumps from
the device, recalculated the calibration from the fuse values, wrote
the code change and drafted the texts from my measurements and
instructions. I reviewed the change and ran all tests on the device.
Patch 1 is Svyatoslav's own work.

[1] https://lore.kernel.org/all/22816196.EfDdHjke4D@senjougahara/
[2] https://lore.kernel.org/all/20261020-upstream-soctherm-throttrip-v1-1-c67f8a02ec3b@tsv-stahl-riesa.de/

---
Changes in v2:
- Patch 2: commit message replaced by Mikko's shorter version, with
  one sentence on what the coding assistant did. No code change.
- Collected Mikko's Reviewed-by on patch 1 and Svyatoslav's Tested-by
  on patch 2.
- Rebased onto the current thermal/linux-next, no conflicts.
- Link to v1: https://patch.msgid.link/20261106-upstream-soctherm-t114-v1-0-c875d1921084@tsv-stahl-riesa.de

---
Patrick Fischer (1):
      thermal/drivers/tegra: Avoid SOC_THERM calculation overflow on Tegra114

Svyatoslav Ryhel (1):
      thermal: tegra: soctherm-fuse: Fix shifted_cp extension

 drivers/thermal/tegra/soctherm-fuse.c     | 17 +++++++++++++----
 drivers/thermal/tegra/soctherm.c          | 21 +++++++++++++--------
 drivers/thermal/tegra/soctherm.h          |  6 ++++++
 drivers/thermal/tegra/tegra114-soctherm.c |  4 +++-
 4 files changed, 35 insertions(+), 13 deletions(-)
---
base-commit: f79e51c70ef3209103fbe0200a1a012eaad763d9
change-id: 20261023-upstream-soctherm-t114-9591c6b779d6

Best regards,
--  
Patrick Fischer <admin@tsv-stahl-riesa.de>


