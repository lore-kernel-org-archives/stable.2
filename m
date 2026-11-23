Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452567;
	b=IqY1xB4ntcH0Mng8eP4KbcH9GQ0vOuENMdG32kvfD4KaVx7SCQtDSruBtqxXyaNjNFIN
	 N271RUPbI2jcWjBwyzShptd4yMnl9vfaXRDnN6f32AzU3O1YwGRLjzOJmbDOYfkChcCav
	 Y+yHGBSC3HUtoqkGPFZYb1nL0VPprEBaNMFikt2Itw9/0FNcyOufIoD9IOzK6+ujSTi6/
	 8zUbHYzPG7U4AVTyw3kE9OioeQeLoo1uMfnG/L67Q+4FF6Vqei4RbayU706c6C53Px19B
	 uajgo8hZ6+GHIvxC/I9/zZYNNktaWE51UwEhq04Q7oEbIkhgCIkKBzzVuOWaW/xOA6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452567;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DjJMiLyBXDBrdw9gywDJswkwztDbF2+YbaS3eaCGT40=;
	b=V907wc9QrJEsYoQbmyrJ5/zxcFRNoEGlJ1ylvQ1jzuuciNdV8oUry5pR4r19cAyI3fnx
	 WBxcDf8n2SHrzz5XRFWTgRGs6BNlCcZKjW750+K7BabW0AOnpUe/yiJxTK+e7+2OmEpcS
	 eqgCAdDoHKVWzJkcJKNxuIfAv9GdTkWJdLz+QGWHq5c+ITT38hpHIE29l3zg3PWXRONC8
	 LJRNZONALB+lfBXkCQCk/vS0j+0QgAF1Z8/9RJq1CvB0fz2i8SHbFx80Cy/5AQfJV+eK+
	 QkTBLiZOJ//o6xnovnFmiGyneH+PpLeYq1/ub6GTEeJrzJoLGE6KobY6VSrtVG2Glmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvUAV56s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D3B606A33B;
	Mon, 23 Nov 2026 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvUAV56s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58F61F000C0;
	Mon, 23 Nov 2026 16:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795452567;
	bh=DjJMiLyBXDBrdw9gywDJswkwztDbF2+YbaS3eaCGT40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gvUAV56sW1YdktzTK8DfNm8mdHFSkgdycWlLkmrnw42plLC2XJgf6uIjlpvE58P62
	 GEaA2esr5usddp3QwF+3o4JpzaYtUPGb9JxVAYPgTguwz53vhgYjDet9rGKbDeWA79
	 wnJ7ZnE0SknoR9AjX4fugOmT+w0qsii4M4CTDAIL1ZDMaeUgZ1lMxUQRGBVZ9qu4l/
	 9IOUDkj6DrdZU55zOtmSb6qXvErSXw6e4b/l2pWF6uHIY18ZyNFORGcsm0OyaENmTK
	 oFvNYJUCBeA7Rgu0cbHS55AFW0q9G73/zohwVyXxJHw0h1kxjSlkP20er0uA833gJ2
	 LmOspqUd1f13Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jyri Sarha <jsarha@ti.com>,
	Sergej Sawazki <ce3a@gmx.de>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 06/10] clk: gpio: Reject gate clocks with multiple parents
Date: Mon, 23 Nov 2026 16:47:39 +0000
Message-ID: <20261123164834.3330320-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123164834.3330320-1-lee@kernel.org>
References: <20261123164834.3330320-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

gpio_clk_driver_probe() verifies that a gpio-mux-clock has exactly two
parents, but passes an unvalidated parent count for a gpio-gate-clock
into clk_register_gpio().  clk_register_gpio() points init.parent_data
at a two-element stack array, so a gate clock node specifying more than
two parents causes clk_core_populate_parent_map() to read past the end
of the stack buffer during registration.

A GPIO gate clock has no parent selection ops and its binding permits at
most one parent clock.  Reject gate clocks with more than one parent in
gpio_clk_driver_probe().

Fixes: 9a9b5a4af066 ("clk: gpio: Use DT way of specifying parents")
Closes: https://sashiko.dev/#/bug/linux-99ca4204-ff53-407a-8c2c-157738e7babb
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/clk-gpio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index df0856a39c8d..2337e8a093f0 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -208,6 +208,9 @@ static int gpio_clk_driver_probe(struct platform_device *pdev)
 	if (is_mux && num_parents != 2) {
 		dev_err(dev, "mux-clock must have 2 parents\n");
 		return -EINVAL;
+	} else if (!is_mux && num_parents > 1) {
+		return dev_err_probe(dev, -EINVAL,
+				     "gate-clock must have at most 1 parent\n");
 	}
 
 	gpio_name = is_mux ? "select" : "enable";
-- 
2.56.1.750.gf70dc682cf-goog

