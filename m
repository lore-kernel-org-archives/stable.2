Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3DA40F731;
	Fri,  2 Oct 2026 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790966541; cv=none; b=YaafrtEbmoHITtJHEw0edOB1mUxqUcDMrG4wqSJV0c7hOlPK9lbeRQ3kieUFPIQ12LsY1bwXiKZkFvRqe5j0ba4H6UtlTZG0eg+0vCNaxe9G33aidr7igjL66Jrtv288AOg+Ek4V6o8Lbi53TdfZ/VluKwgqKa+84p9DItTH9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790966541; c=relaxed/simple;
	bh=WsbRLXFMa/48H/dT8PaNpKrs9iP790k6JcjLcD47riU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ohTag3zc4YLwb1uDoVbF2NH0/aP32NRrb11KJv1cbm+wplVCQs6RnJf/N3CjZAvdt+1Y0I00cstWY9FL+zzxM9nUEeRPAufp/aGi7k0weLHBfR3uOLi+PdfCCnDbe3ingfP6K3pP12lCKAhJBmmcommkKkBPqqs2ax0HDREtqM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=savoirfairelinux.com; spf=none smtp.mailfrom=mail.savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=OTZ+jmzR; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="OTZ+jmzR"
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 992943D8174B;
	Fri,  2 Oct 2026 14:35:41 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 3IWiaXvPzb1L; Fri,  2 Oct 2026 14:35:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B53063D8182A;
	Fri,  2 Oct 2026 14:35:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B53063D8182A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1790966140; bh=5RfKBhv7HX4UGZIhZtZWAgEkt+3t+SOv8khO+Jp0Lvo=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=OTZ+jmzROQSD9EMpHssLk1AduIcArVrGKTdDWFJjREoZg+e9cU8Tk++w626FUMduu
	 dwx/PqNdpoEpqL/F9ysKyPq3LNXW2Yoig1KIOyJ1qRBUxaRUgWTulsvfjvU0OzcvYD
	 hUSikpSeipwDf8RrF87GoMGhoxRKVNocJLrBTqX1BLvhymujqeUvu/8cKdXSj8R+ND
	 /v+RoDoTgUB1MZ+6SOC7iHZBO9qO86N1F11T7ASs3u3bEpDO5QN0mj9pSIcYiry2vh
	 /PSRYUj8DIUpTuU4Ff+GuuWOoe9ivm5+0MPgjhHlW91uwLADFhxQa7gR8X/kPWgIp6
	 2CTP4RCNBSP1A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id pw8dF1jareRx; Fri,  2 Oct 2026 14:35:40 -0400 (EDT)
Received: from localhost (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 5F0773D815B9;
	Fri,  2 Oct 2026 14:35:40 -0400 (EDT)
From: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
To: Linus Walleij <linusw@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>,
	Alistair Francis <alistair@alistair23.me>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
	Felix Boucher <felix.boucher@savoirfairelinux.com>,
	Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
Subject: [PATCH 0/3] Input: cyttsp5 - fix device startup
Date: Fri,  2 Oct 2026 14:35:26 -0400
Message-Id: <20261002183529.166248-1-marc-olivier.champagne@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series fixes three startup problems of the cyttsp5 driver that we
hit while bringing up Cypress TT21000 panels on a Renesas RZ/G2L based
product. They date back to the initial driver and are all in the
reset/first-command sequence of cyttsp5_startup().

Patch 2 relies on patch 1 to identify the sentinel and patch 3 is
written on top of the startup sequence of patch 2, so they should be
backported together.

Tested on a 5.50" TT21000 panel (Renesas RZ/G2LC, edge-triggered INT
line), with the reset line wired and with reset-gpios removed from the
device tree: cold boot, warm reboot, watchdog reset, 20 driver
reload/unbind/bind cycles, and binds timed around the reset sentinel
without a reset line, all without a sentinel or HID error, plus a touch
and button sanity check.

A follow-up series with cleanups and firmware version reporting depends
on these three patches and will be posted separately.

Marc-Olivier Champagne (3):
  Input: cyttsp5 - fix bug when parsing reset sentinel packet
  Input: cyttsp5 - init IRQ early to avoid app startup problems
  Input: cyttsp5 - only launch the application when in bootloader mode

 drivers/input/touchscreen/cyttsp5.c | 150 +++++++++++++++++++++++-----
 1 file changed, 127 insertions(+), 23 deletions(-)


base-commit: a215720959c5450b3699e243904b39c3f8f68888
--=20
2.34.1

