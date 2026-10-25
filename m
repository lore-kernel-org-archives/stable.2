Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792968616;
	b=tjf7dQimqPWTQN9R3rO0NBvYlGMJUkLXSCLxmyz1N+EcWvtoE7zZffH8udWQF/IyEdmP
	 /+2Xy9cCHQEDZpZGoykX3zsi/rirDc1pAOgjLq8/lihGSKU5u6dl6r8hs7gUk5Ajnggwr
	 +usdc9P5ysSzwF+gqFb1ZrncmkKhHCDpFMlp+QveZ148LCEd0t6aeGKop1k659FYUxPC+
	 4NaiXASqYDZbFXfdDEyAXKJ1JKceS0IK+N0BJOMPW24Ung2fClah+H30lPWSqVgoQ1rpn
	 PGUTIQ2wgPJwI7wXGb4JJZHkvu1xIJByxTbcd4uRkZYXJ0RcOEKV/LWlVLvjx1xEDSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792968616;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=S2b4fzgPseJ0YYTVek2k+9cCGWE8NVj6xa+49CmOEyI=;
	b=DI7HtC49CgrgRsuSyfyaL1Gmq47674Sr4XoL28JmpDR2QYmYmCUwUanSgxlo9Venwlxt
	 oOAy0/S/+sOivJmGp8AsWFPkDY1ly5cFGKCwzUvQm9qmtToJ/3GbXgvx+HW8iQErje5uz
	 3Icv+Q1cqXmBJBO/N9p4pKbyOAKGJx5JUTCAD/gkIRaY7L/NaP0NPMjgwWj4M9BL7kA9T
	 Mv4Cu7he5O2jMMryEMK0uApFt7YmS307i/UjJomKWdwUH/sk1SRtKuZJVMSnZM5n0bwuQ
	 cXIS51uNqZDkbZqn7LtZRu23lrLIgv42tGmFOduObT4VaKs1TBoipVuzxfguP9/ubLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K4MSH6XV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D988606A320;
	Sun, 25 Oct 2026 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K4MSH6XV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792968616;
	b=0aJXbAJxNW1+FUufKrTwTp2T+GJWjqQ42C4CasrmTRiCmVozTs3wSOh98urC5NeYjbwo
	 waEL9fDs3MSMT6Cv86nddemxxtSRSz9vTCGi9TWZW2tY1xcNTFCnBlrTPp5G0rhUvozgH
	 HL6HnKGseFfbLaYmV/6lnyFiYQjl5SbtpdXfrXyKsur64ID6yaH1ZEyIF/8gDKwQrxOlm
	 sEtQt7r0pn9296bzCozrlrlDgULfMMdNKMWasehq8qJq1F667ienLtt3Nf86UZE80nTfn
	 zSubgUHLsY6iachCtCURvD3Po6iiXom2tGfk0I0s89nIBtZSPW8T0U+v/hZW+dmKHcA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792968616;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=S2b4fzgPseJ0YYTVek2k+9cCGWE8NVj6xa+49CmOEyI=;
	b=EiK4vYEvwL6ozfGFF0rPuAR1Y2g3rtSkBGmEofoxelioWIJTxq/LQ9h6FkpzQWbhZhLO
	 5azCr+Ixz+fUt+2rtVJ6+R2bQQCH4zKwSN5tdljH0JyYzuw5auugQ0hTnmWr3kUVFqY9K
	 CYsT6qc/12unq22NBBwZHv8m7vUS8pmsIe8wyzsso0mzLYaiO18EtFSXpCQXzF3vu8xf7
	 M8pvk5M2JGmFwUvDIFC/zeUjNe/XbC+2wA8U+ZGSWQTPTTw1WhU1NmNyHyL3Md1oEHbjv
	 bkaj42dtNmIdgp3KX7NXR92Gl5nZZJqnN8OmjzExYiDlHDX9yuUAnsY+Pam1W0iapwQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4D4671F01829;
	Sun, 25 Oct 2026 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792968616;
	bh=S2b4fzgPseJ0YYTVek2k+9cCGWE8NVj6xa+49CmOEyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=K4MSH6XVymmsxGRHevKOAMSqJQlJ48OAZghelWS1ltidkkcmFvRgWR4WJz1jiPnfe
	 OwAeim7ZBiQd1AW+NhZkcqaQTq03mkwTHuawJWNQFWrJiuMyG4T+JUYJr4Ca7H+gj1
	 iSkzXbtS6Ynue7zPAej+ggUoYbNkyfhjh92281cgV+rj085PC4GjP1y/HmuBrYCh4+
	 8WM9F2FY4L+oeu4iYTJwV4WKiVW/mlt/ZdEfAjjLRDRkZoxvrBoJhNiQcEpXOlcP1x
	 zSeteb/AuX5J/lVR4fS3m904Kaap17RPh5r8K0e5k9rAxHNITWPF/kuap1neAGA6q8
	 h3tHgPhGP9sdA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D2AD744B15;
	Sun, 25 Oct 2026 22:50:14 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Sun, 25 Oct 2026 23:50:05 +0100
Subject: [PATCH 2/2] serial: tegra: Fix overflow in
 tegra_check_rate_in_range()
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
Message-Id: <20261025-upstream-serial-tegra-overflow-v1-2-267b5b7a79ee@tsv-stahl-riesa.de>
References: <20261025-upstream-serial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de>
In-Reply-To: <20261025-upstream-serial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de>
To: Laxman Dewangan <ldewangan@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Shardar Shariff Md <smohammed@nvidia.com>, 
 Krishna Yarlagadda <kyarlagadda@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, 
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792968614; l=1845;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=itgIcGWGOLTyUm1KE2QunM+q/33HpForOO0+9QOkieo=;
 b=ifzVpAwj3ytlam2cPbnwHEpgbVut600nZsB8xfp8yN+PiAPG/fl0ebaGnWo93f+fn/JFOt1PD
 DyJny1Zu3E3BqCKSZejwKM+IswXF+xrNvbegyTICip8X/rspzZoLoSW
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de
Content-Transfer-Encoding: 7bit

From: Patrick Fischer <admin@tsv-stahl-riesa.de>

tegra_check_rate_in_range() calculates the deviation of the configured
from the required clock rate as (configured_rate - required_rate) *
10000 in a long, which is only 32 bits wide on 32-bit ARM. This
overflows as soon as the two rates differ by more than about 214.7 kHz,
so the check lets through exactly the large deviations it is meant to
catch.

On the Tegra Note 7 (Tegra114) the Bluetooth UART ran at 45.33 MHz
instead of 48 MHz at 3 Mbaud (-5.6 %, see the previous patch). The
check calculated -0.18 % and let it pass, although the limit is 4 %.

Do the multiplication in 64 bits.

Tested on the Tegra Note 7 with a tolerance of -500 for 1 to 4 Mbaud,
which gives 45.33 MHz at 3 Mbaud: the driver now logs
"configured baud rate is out of range by -555" and does not apply the
rate. With the tolerance of 136 (48.00 MHz) it logs nothing.

64-bit platforms are not affected.

Fixes: d781ec21bae6 ("serial: tegra: report clk rate errors")
Cc: stable@vger.kernel.org
Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
 drivers/tty/serial/serial-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index cc09fbc3aad8..cb5ef8aac198 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -380,8 +380,8 @@ static int tegra_check_rate_in_range(struct tegra_uart_port *tup)
 {
 	long diff;
 
-	diff = ((long)(tup->configured_rate - tup->required_rate) * 10000)
-		/ tup->required_rate;
+	diff = div_s64((s64)(tup->configured_rate - tup->required_rate) * 10000,
+		       tup->required_rate);
 	if (diff < (tup->cdata->error_tolerance_low_range * 100) ||
 	    diff > (tup->cdata->error_tolerance_high_range * 100)) {
 		dev_err(tup->uport.dev,

-- 
2.56.0


