Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9851AFFF;
	Tue, 29 Sep 2026 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683350; cv=none; b=WPDbEuEPnG0hkJxWLnf0wxn1wouowEJ+qNpMQac4MnrA15bvijZLw5tYEiXEPVo0mB9M5+NhE+dkxIvG++WSJX4AkPseOUNQn+oMzpMDBnnQkAKGMjBEfIHU/d2eh9KNLw2+sHEAG4mqTTLhUBgI90nPg+dpP5JZ9Lchh7/sFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683350; c=relaxed/simple;
	bh=wJ9PVLSIq6X7O5ZhoJEWBuB6leO8e2NgoslQ6mcWslI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Kr8hct0MICMaVJ+dGOQ5ZbB6tGSIGEWQS8gujNEjMUXCa/Bk2rtG8um4zBnzYkbg+qJExqr0t498VrKgn1KvcXK0YtW3pwBNb/c9gZGh45GBYDbbPYASOUCBgxhIKOcWtgtpXo7FXVO2wTd2I4qLFTBAIOCJYSrO+roTblpJX0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTuNMHlS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTuNMHlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441161F00893;
	Tue, 29 Sep 2026 12:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790683349;
	bh=QFu4TV/Yh3C4ZczXnV817/jCqQsTVBiQDypj9KNrY7k=;
	h=From:Subject:Date:To:Cc;
	b=FTuNMHlSaS8ULO6fO+IxVQ8pwc6Fpu/XBRMky3Qzgqi0n1t4v4dA2RVXN1bKEmWXD
	 0M+L0wGfmTsVk+zzJGWRlxP1+0PbvAQbr8YKz2YrRp+xepCWrGhj3c5DVd2oVEVSNG
	 WapUhfEF7AHp0PN4ux9M/rIbMKjcVsutZ9VBvj4h9EYtt32ryY6mjWk+W61ntQQMC0
	 3bcUAZr6p741FWPwFax74hLvYRT5ck7Vbymsny/ZYVZKoUrlcUiYm6t9svriS81Fqu
	 Bz/WpgVTd8m0RtHwCLRMMAhGlwE/qorFmGyzIBPcWURk22PZgkmqNkafSb2+ZnTuGR
	 jzAVudzGFoPHw==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH 0/3] media: mali-c55: Fix IRQ lifetime and wake handling
Date: Tue, 29 Sep 2026 14:02:23 +0200
Message-Id: <20260929-mali-c55-irq-supend-resume-v1-0-e3af34afff12@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQqDMAwA0F+RnA2kHXXOXxEPVbMtoJ0mKAPx3
 y0e3+UdYKzCBk1xgPIuJr+U4coChm9MH0YZs8GTr+jlapzjJDiEgKIr2rZwGlHZtpnxQX2gZ/R
 EzkEOFuW3/O+87c7zAl0pO/VsAAAA
X-Change-ID: 20260918-mali-c55-irq-supend-resume-30b507a20011
To: Li Youhong <dayou5941@163.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Nayden Kanchev <nayden.kanchev@arm.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0

This is essentially my reply with the "proper fix" for:
https://lore.kernel.org/linux-media/20260903025526.2657105-1-dayou5941@163.com/

Keep the Mali-C55 interrupt requested for the driver's lifetime instead
of changing interrupt ownership along with the runtime power state.
Synchronize and disable the IRQ before power-off, and enable it after
power-on. Hold a PM reference until probe installs the IRQ, and stop
runtime PM and drain the IRQ before removing the media entities.

Allow platforms to mark the ISP as a wakeup source. Hold a runtime PM
reference while IRQ wake is armed, resuming an idle ISP if needed and
preserving an active ISP's configuration. Balance the reference on resume
and failure. Hibernation still uses the power-down path.

Wake events require a configured stream and an input that remains active
during system sleep. The internal TPG shares the ISP's power state;
external sensors and receivers need their own wake support. An idle
pipeline is not started by this series. Hardware wake remains untested.

The first patch extends the binding with the standard wakeup-source
property. The second patch updates the driver IRQ and PM handling. The
third patch retains ISP power while IRQ wake is armed.

Tested on the Renesas RZ/V2H board with the other in-flight patches
(DTS changes and the TPG enablement) doing full suspend/resume cycles
with wakeup from RTC and NMI and capturing images before and
after the test.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (3):
      dt-bindings: media: mali-c55: Allow wakeup source
      media: mali-c55: Keep IRQ requested during suspend
      media: mali-c55: Keep ISP powered while IRQ wake is armed

 .../devicetree/bindings/media/arm,mali-c55.yaml    |  2 +
 .../media/platform/arm/mali-c55/mali-c55-core.c    | 96 +++++++++++++++++-----
 2 files changed, 78 insertions(+), 20 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260918-mali-c55-irq-supend-resume-30b507a20011

Best regards,
--  
Linus Walleij <linusw@kernel.org>

