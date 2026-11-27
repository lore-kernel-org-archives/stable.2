Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807640;
	b=ihFJVIHsVZjA0CPqNY9SaV07UPmwLnEHdtwFI5exEK/PZbWrUk78fk35ff5gpWzxVl7s
	 CrJfnmad657+9fhfB5QDke6K+OavkMCR5GQcar94X3jWdzVfH/yKbP5Jbg2JS12XFylPM
	 3LIRTjkr297wYhYqV58b4xGtQCShYQHHnS+CGw1QbRvzf5lZujkuswcGd2/c6nlfNPl2w
	 N1FxYEvqclUZLkydoXiN91mr84Cbfi3BuoNtZ6hX0aUtoGjFcZVGrQjiNg5iJ6gXntKMq
	 giFqkmKitbnJywd4rxIxstF0t1HKvfbHmB0mlqZEga5yxFVC3p8yfN2aNZtN0mClY0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807640;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=easOfokm1QHLisLSbFSZpXQP8eAtR4rhVbTn+MoldcQ=;
	b=oZ/mkRhQ28m1aC67wbnsRIECqyDew4TOtDygDjKVzSewt/8anFBUDYf6E1lSeXhzuNb3
	 nUJ+0qXoJZzSyUJAvaG483mSJy/wpsqVJO8+xkMJdl3+1cLGKfgnx/qhNP0Mui/ESJeaW
	 FMi62rlyO0gnL+Fmh2jfkxolU8KHTSllz3sp6jI2BGm3V3owpvsnFIYra1ZqCZHS6DLlE
	 QVPoIlPgt33yKaZ2hHGaQjyiDQ7ifGsTyNxPfbqmrMVLFiwDh8sYs4gh8/7RmjAepEIl/
	 pUXzsVaeJZdeQDp7i7yQjmgMm4kPhtBHXKwDtj6DZBhgCZNDf9dCRhbRmKgMQzMta+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoR7V+8Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC99E606A31E;
	Fri, 27 Nov 2026 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoR7V+8Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682C61F008A0;
	Fri, 27 Nov 2026 19:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795807640;
	bh=easOfokm1QHLisLSbFSZpXQP8eAtR4rhVbTn+MoldcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LoR7V+8QWzhsVl2lbqzuDOdPc0JzexeccbE/pWqQAo2wH7BkJ7EcIaqv9/9v31WcQ
	 4W17iklURuiU9c3eZUD/2p4u8jn+jM2nV2tI71u0Wfvlbds7eW7Ca3G1L2ZsfkObJL
	 FUPE0630sL7A5tKpOXeIkfYVjgQhNZIeTornog4bJzIW7YbKOa8y6s08WT056F7htP
	 ZaDiDQdYk0w7J4n10LtoxQN3Tk4sODgHYLXsQzTektXoAxboTCr8JxAoUCmC9b7Gmm
	 6Jb4fCB1L9vxgR0bFUC23CNCxWA/QQQddGw/l8ukgpoiPpifEoLjoIAzlFw1VYUWZg
	 nN/gFHQ9E5kWw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Andrea della Porta <andrea.porta@suse.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Naushir Patuck <naush@raspberrypi.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 07/10] clk: rp1: Propagate determine_rate() return value for PLL dividers
Date: Fri, 27 Nov 2026 19:25:31 +0000
Message-ID: <20261127192620.3443537-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127192620.3443537-1-lee@kernel.org>
References: <20261127192620.3443537-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rp1_pll_divider_determine_rate() assigns the return value of
clk_divider_ops.determine_rate() to req->rate and always returns 0.
Because determine_rate() updates req->rate in place and returns 0 on
success or a negative error code on failure, every call overwrites
req->rate with zero or a cast errno and discards errors.

Return the result of clk_divider_ops.determine_rate() directly.

Fixes: 41c9570e4178 ("clk: rp1: convert from round_rate() to determine_rate()")
Closes: https://sashiko.dev/#/bug/linux-ce521c83-c4f2-4949-91e9-1e9702c8bbd1
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/clk-rp1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
index 1dd276dd2bb3..cfa7cbefad2e 100644
--- a/drivers/clk/clk-rp1.c
+++ b/drivers/clk/clk-rp1.c
@@ -770,9 +770,7 @@ static unsigned long rp1_pll_divider_recalc_rate(struct clk_hw *hw,
 static int rp1_pll_divider_determine_rate(struct clk_hw *hw,
 					  struct clk_rate_request *req)
 {
-	req->rate = clk_divider_ops.determine_rate(hw, req);
-
-	return 0;
+	return clk_divider_ops.determine_rate(hw, req);
 }
 
 static int rp1_clock_is_on(struct clk_hw *hw)
-- 
2.56.1.839.g22a8290db9-goog

