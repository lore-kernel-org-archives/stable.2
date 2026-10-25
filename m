Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792968616;
	b=x39hgH18R0pJlRcA+xaM+hUJkdI/qoGGnYO9YMTGB+pS9hjI/epJQlPAefkSNaaigDXO
	 Ilp3SjDBF9h5EIHl2L7DIQtx74HP/dP8JaRHXEiV6A3IBEgBYTLsRoWc8Uht+IUZDzLxx
	 NjYepVzFaLc82bgtPigLYlbG/T6wAkUjVgxPIiLhWsBPf/x3puPvQ17SFEuhLhAlIZLYz
	 fiCmNHUXNLXKrRosMJ1loWVQrEpSCg8rdtYEBO34JnPqOg9mcj5s8Fj5ZOJmbfH0CLuld
	 ZU9Nr2uThaQUObO8XyvxSs4e0UGVYMvXIf47ar7XBIRRvqgo+f3WK13NT86YGCnLBxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792968616;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=a9Qiko2feZgxRy5+X3KOBqrrvb16AA+EtLX8DrgxqDE=;
	b=BCmTCMdbsLJcM92/1kC935hKuxhHtLje49ll8LCmsasOfPJjZSlOQa/oBHzw+05j+zer
	 YiCUi0jvCOIn6yTFpQVmO/z6VaDDrizpm3iHpq4UcJBF1afAa7Ypjssp+o0PPp795t2BH
	 IVwtUGjpAxsWPQwEgdtS/AY1MZ5TZveTp6qy8uLdklaRpr0y4bggzkgiF7tARRYP82gva
	 ltTs1VCOFZFobUb7GvXbohQHHhstHWW7j9oYHlixsaPCMJX7DOuszUK0rBVDJ6zHwm1wX
	 L4b3A0cTngs3kJtO8PXo9X8jUvxakNz8ZaycZp1Gblu95qhIRUnEgLwx+J+wDRidMfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTwtY3yR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F006606A31A;
	Sun, 25 Oct 2026 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTwtY3yR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792968615;
	b=v/G+urbiRqePt6UIpBpWZP8bLbGJm8jGyZc2hAcF/wVsaYTTPtwkh6jNJEZHxvExwu7O
	 TsaFAg52fJ6LmBwi4nJDZwTJSxqnWfhm+8+KkY3POi4i/cKrl+C+QaCYNIqpmUYQulfyB
	 /3shBtO98imEuzO6uBDqANs+fR1HHpWrm8DpBpXCZt+MS4NM5xmi5ae6jYQQ0kfe8vxoK
	 nTH/UkOwvKfiNTYK0fANyXrJBiyvgNOZ9uLz4/Bb3tGgoV3EtkGFdDwkQNJGc2vN2o4jg
	 Oeeb/2TzlTxmsTE9mz0e9jFEtQMZKeb1FKmuwF2N5/emBJJnDRpkHFwVqqxNyhFycKA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792968615;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=a9Qiko2feZgxRy5+X3KOBqrrvb16AA+EtLX8DrgxqDE=;
	b=xe0uEGKXL9NPb3TRk4foYDj65W4vEoCgeUArK2kXRy4xBaOZIyxh7Ql+jeVw3XmeZgGD
	 ejdfys5fnN6aQjL8C17xeouojP0JaoKzeWzNWPGQPHG7FIxc22JUtP6xmTHCyqJLsGXAD
	 Q1F1PuOa5OinbkqDFm+AMc4edT2WMRWHz4CRUNkPBAgbrEPrzr1jDVard9fAq6wISA4T/
	 v5yFZ+qOaOclzYJoe/fPL2u+z3Lw73fpmeHkEsfx7Iw5VpIG8qt2crCEgrFH8qT2mooS0
	 Gxi1IVtbnNXh2Pwyb2p30o/EXGxXpm50nxwF0k3kI6YilCSSEHhH5hSvisjNiUMV70A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 357D01F01828;
	Sun, 25 Oct 2026 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792968615;
	bh=a9Qiko2feZgxRy5+X3KOBqrrvb16AA+EtLX8DrgxqDE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=QTwtY3yRp1VUTWEXYIZTkPSeeIPSvO8P0jFtrqeWzKKvr/oCo9VVqQkjKm1448AEP
	 9RwtLs67qJETXOf7pRdg8V41MTmePeQEqEtawMDMDrWyQPZJNAaAliBlVZTe7se7Jf
	 HeTqzcDfPkB1QfjVnZ4GPGydc7w08OoY7APeqQZ347mVz/WgjDoAVnnBVy88rm+BUb
	 AtBQDhAu5l1TOEd51Jg4GJBtWgxgidRa5p7UWEoJXT3F4N7Yk4xsJhwAsnCd7CNzGv
	 NnNLBC6PtXF8fq0m9E0pm5uvu4+VWY213aWXlUahrvv0ZYWTyMXH0bSrD1paeiMKmT
	 NM8stAptCMEYw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BBCDF44B11;
	Sun, 25 Oct 2026 22:50:14 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Subject: [PATCH 0/2] serial: tegra: Fix 32-bit overflows in the clock rate
 adjustment
Date: Sun, 25 Oct 2026 23:50:03 +0100
Message-Id: <20261025-upstream-serial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNyw6CQAyF4VchXdtkGIy3VzEuKtPBGmRIO6AJ4
 d0ddPktzn8WMFZhg0u1gPIsJmkoqHcVtA8aOkYJxeCdP9TONziNlpXphduQeszcKWGaWWOf3rg
 /hSa4eKQYzlAio3KUz+/gevvbpvuT27xVYV2/5xV1CYIAAAA=
X-Change-ID: 20261023-upstream-serial-tegra-overflow-48d3d0f7afd9
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792968614; l=2014;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=6EwOpSqQKG4Eh41ZzqS8mdnou7ZQ+bwoEZb8R5Qxc/Y=;
 b=dOtxdFiyP5QQqFHMgbg5Yi29rC6fDt+1DPiL6e561nRFUU6GC7l7b1GuEiU2nixn8r2ZuZ5H7
 xQ7UgE/Z9r+Bu/PkHgJnoNc/fIyQYUed7VWa9qWjjNLCMTQoqjoUR+j
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de

On 32-bit ARM, both the clock rate adjustment from
"nvidia,adjust-baud-rates" and the check of the resulting rate overflow
a 32-bit long at the high baud rates the adjustment is meant for. On
the Tegra Note 7 (Tegra114), Bluetooth at 3 Mbaud therefore ran with a
UART clock 5.6 % too low, and the check computed -0.18 % and let it
pass.

UART clock at 3 Mbaud with a tolerance of 136 for 1 to 4 Mbaud
(pll_p 408 MHz):

                    requested    configured   check
  without patches   47.79 MHz    45.33 MHz    -0.18 %
  with patches      48.65 MHz    48.00 MHz     0.00 %

With both patches and the unchanged tolerance of 136, Bluetooth on the
Tegra Note 7 works at 3 Mbaud: the UART clock is 48.00 MHz, and the
WL1801 scans and connects to a paired device without HCI errors.

With a deliberately wrong tolerance of -500, which gives 45.33 MHz at
3 Mbaud, the check now reports the deviation (out of range by -555,
i.e. -5.55 %) instead of letting it pass.

Both bugs date back to v5.4. 64-bit platforms are not affected.

Tool use (see Documentation/process/generated-content.rst): both
patches, their changelogs and this cover letter were prepared with an
LLM coding assistant (Claude Code), which traced the wrong clock rates
I measured on the device to the overflows, wrote the fixes and drafted
the texts. It also recalculated the old and new arithmetic for the
affected rates in a small userspace program; the results match the
rates measured on the device. I reviewed the changes and ran the tests
on the device.

---
Patrick Fischer (2):
      serial: tegra: Fix overflow in tegra_get_tolerance_rate()
      serial: tegra: Fix overflow in tegra_check_rate_in_range()

 drivers/tty/serial/serial-tegra.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
change-id: 20261023-upstream-serial-tegra-overflow-48d3d0f7afd9

Best regards,
--  
Patrick Fischer <admin@tsv-stahl-riesa.de>


