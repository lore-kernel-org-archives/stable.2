Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.142.180.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795815757;
	b=kCSeghKVZs0wf1RXViWSvnfCBYuWPQzYfzTY+0tI876RYTwJVe5iS7fLRCkkJIAMVcbE
	 z9NCUkXvKSrHfFrEryPMWclnVMz93UsWreFpYti8uhIRuXcvb+Z1quo3AQHc75QfKzokr
	 fhHUDZPWiqAtsmG4NNF7gSocyo6ENB2kWKifqD/LNjgQ8qsm2xwF40gBYTeNEfZg8Xhj/
	 rxDLDOTTebzDKetICMwdTPkBSq3DDRzVE6GGrAqi6jx9sgPpStjGOhGhBw7UE9V1XahyO
	 Kmc53t3JXPiSGCKG9GKgL8U3Uoxu+0ZeiPcU0KezFSaS6WhmjxmjEEKkT9M5zoTk1+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795815757;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=hPcUXXPJ9lqr7gnnI/WO2aVWDUyWi+0TICJP+pC4I58=;
	b=EHfwCixMXiJe6mn+NIYlL6OYEigEAAk+2Ha+1Y87GnJ0mo3VLhAJewHEKHYIwilCHktQ
	 43abDwEqmNoygK0r9EvVVg1HNH18AQfonofV5LcDpgOEU+Ta6yCUjNaKa3hn2VbcCNrxu
	 14Kq1/+3ceh3YRfzcAVrGW1eAgU+3fj0bszDgZBiKb4XqDfPmfAOGDhYi5Ys7olE/74Up
	 UOMi0JzoEGdBA2WP3sRJ9mRje2lGlfq4mO7HayoD1lULwIhYXm2MgOQ7jqaXuj+vt3j1p
	 wDffD2XMZaFTYpIIpmgFmyTbp5r1fhJX/9Dh6HlLf5P7iOHYDDaAsmf9OEeBDy0JglQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=makrotopia.org;
	spf=pass smtp.mailfrom=makrotopia.org;
	arc=none smtp.remote-ip=185.142.180.65
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67305606A31C;
	Fri, 27 Nov 2026 21:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67305606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xX3i1-0000000008G-2ORN;
	Fri, 27 Nov 2026 21:42:21 +0000
Date: Fri, 27 Nov 2026 21:42:18 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, bui duc phuc <phucduc.bui@gmail.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Andre Przywara <andre.przywara@arm.com>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org
Cc: stable@vger.kernel.org, Marcus Cooper <codekipper@gmail.com>,
	Philippe Simons <simons.philippe@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 0/1] clk/ASoC: sunxi: fix H616 audio PLL and codec clock rates
Message-ID: <cover.1795815223.git.daniel@makrotopia.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The H616 CCU reports the audio PLL at half its real frequency since its
sigma-delta table was added, and the H616 codec support was tuned on
top of that, so the two errors cancel for the analogue codec. Other
users of the audio PLL run at the wrong rate: sun4i-spdif plays at
twice the requested rate once the codec has moved the PLL to its
sigma-delta setting, and an I2S driver for the Audio Hub that asks for
24.576 MHz gets 49.152 MHz.

The fix is a single patch spanning clk and ASoC. Correcting the CCU
alone halves the codec rate, and doubling the codec request alone makes
the codec run at twice its rate on the current CCU, so a two-patch
series would leave one commit with broken audio for bisection and for
stable backports, which need both halves together. I would suggest the
patch goes through the sunxi clk tree with an ack from Mark for the
sun4i-codec hunk; taking it through ASoC with an ack for the CCU hunk
works just as well.

Tool use: the root cause analysis, the patch and the text of both mails
were produced with an AI coding assistant (Claude Code) during a longer
session, which was asked to bring up HDMI audio on an H618 TV box, then
to find out why the analogue codec played at half speed after the CCU
correction, and to prepare this fix. It measured the PLL, the module
clock and the DAC drain rate on the hardware with devmem and the
AC_DAC_CNT counter, and checked them against the PLL formula of the
H616 manual and against the vendor-derived H616 codec driver carried by
Armbian, which requests twice the table rate. The measurements in the
notes of the patch come from those runs; pitch and channel order were
checked by ear.

Daniel Golle (1):
  clk: sunxi-ng: h616: fix audio PLL and codec clock rates

 drivers/clk/sunxi-ng/ccu-sun50i-h616.c | 4 ++--
 sound/soc/sunxi/sun4i-codec.c          | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)


base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.56.1
