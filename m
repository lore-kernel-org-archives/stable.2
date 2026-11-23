Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452561;
	b=HvLL7Y5uBitCeypHN4SVe3DtvlnN0riXsLQnQ+aWj147KC2VEd+jRY/Bt2sotOcGkgLC
	 X2aRzgNwpOLFWjzOvtCAnICMtbJAnjIp40PElZGg4Z0hNaMae1AI29X5ozECDK6YsxZZ1
	 Pzihhz6GOWKzp/TkLF2vMkxuHNsgs+aPl89VRSkmoQ06HIc7nuaw4s32d15wY5hR4oc9I
	 d4jQB/buN2QOjJ4tZPbvN/72YdBxkIvI/zWQzcOARFNovzbpt8fuCHFKaX256OciAPwld
	 A5g//mmZTGL/SLbNTawWCIJuLI2EfNuYUHQGUe3c1xQDmlI0ntd/SsNL6w0Smh5glDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452561;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kvS3xeKxs3/CiTBsXJ8JrtarO3mE6CVow1pjCiwn35I=;
	b=zHBpHyg+IpPhJEDepKz1tS3KjVlk4h7VyU6Wk0x8fJIjUfEwS6nTeAgsZYK291v16GFX
	 zvyJb1ByPX6dW+PIttveAQtpgSRZ+Cr2/aREzesZ1mtFDFotmjW05xeY/VuTFuSIeyHcI
	 XouYU2CtNBpP4ffwGa4kBicFYUV1YmwuNSgSKI5P96OUhxyxCXrj85XtD03DbZm5OF/9N
	 iVGd5gPCabxacrSwDs/qyO5PprOROkSWpMNAb+kKDeOpHaJ+Q/uYT1QCKg8dxHjQgxqOB
	 Wf2TO5LiC1K87P1TYyaltbRh1rt4BZYZgEYYo7PmhR5D/5QjhDEJcyLdIFlI+tpvRuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViHLXAvr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3160606A31E;
	Mon, 23 Nov 2026 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViHLXAvr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8477B1F000C0;
	Mon, 23 Nov 2026 16:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795452560;
	bh=kvS3xeKxs3/CiTBsXJ8JrtarO3mE6CVow1pjCiwn35I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ViHLXAvr90wLwDGJ8DeBx2qpERGAET6ZPWnqAi9VoV40vWPhfFczjHsPQG7vWLpme
	 dQwXu96Alf4PfW/qKxVZFANapWPSHXjMBtGdI+Tp/Kl8BLBE3QyQpo4/1udOGffm7N
	 xtzjS46roDp/ZagoJgp7Fo2H67O+1W6I1XZABjHeG02yBLyR3zXlev80/W1vWpgYv5
	 2v3zLS3N359yYe+XLJxIGYw8ScW/8w3xtDHtrLxgwUvd5CU8stWFPzbMYK8WZDlC3X
	 zLLtvAeuGY0Bb3OLT4Nub7mOaA41FT0FGdvFYNiTZzuUwZ/aM6gQSAml+B1Hza0bUG
	 gMbdNJ42kHTLQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"Zhao, Linaro" <richard.zhao@linaro.org>,
	Linaro Ltd <mturquette@linaro.org>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 05/10] clk: divider: Avoid division by zero in _div_round_closest()
Date: Mon, 23 Nov 2026 16:47:38 +0000
Message-ID: <20261123164834.3330320-6-lee@kernel.org>
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

When CLK_SET_RATE_PARENT is not set on a CLK_DIVIDER_ROUND_CLOSEST
divider, clk_divider_bestdiv() invokes _div_round_closest() before
clamping the resulting divisor to at least 1.  If the requested rate
exceeds parent_rate (for instance via clk_round_rate(clk, ULONG_MAX))
or parent_rate is zero, parent_rate / rate evaluates to 0.

Passing down == 0 into __rounddown_pow_of_two() triggers an undefined
shift and truncates back to 0, after which DIV_ROUND_UP_ULL() divides by
zero.

Since a divider cannot increase its parent rate, return the minimum
valid divisor directly whenever rate is greater than or equal to
parent_rate.

Fixes: 9315514252a9 ("clk: divider: fix calculation of initial best divider when rounding to closest")
Closes: https://sashiko.dev/#/bug/linux-cc7c0851-a317-4348-ab29-9d748aa20cfc
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/clk-divider.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index f68216c65d3d..d05dc595ec4c 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -244,6 +244,9 @@ static int _div_round_closest(const struct clk_div_table *table,
 	int up, down;
 	unsigned long up_rate, down_rate;
 
+	if (rate >= parent_rate)
+		return table ? _round_up_table(table, 1) : 1;
+
 	up = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
 	down = parent_rate / rate;
 
-- 
2.56.1.750.gf70dc682cf-goog

