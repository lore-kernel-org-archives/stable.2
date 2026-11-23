Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452554;
	b=mTup+9Cal+CX6VbGia8r+1gOKOf9AurGe1p7CzArcd/LJ6BGCMUOlqHgokU+sOkEw+HR
	 8ZyWdHcA6MQYYSbrKXghdt5DYtuuMC1z+YNl0h8yVw3l4Dp2zNIPAR1IvzIdnXS10q1zN
	 Ik6DQVG/pdL1zpb6p2QZgL5l2cJLooizgy8mYMy7Lr6+FsyGML9Wh8pdPDHkMhlGYhXPk
	 PlOsfX6dGjhAZlfMwt0/tA5LNOEYJOZ6ZxQpmitua96k5emmRJMDgbO9hlyWCbKUG4cA6
	 61TTaPm3zRCHrj1pfG7AKglClWs8+cGdRcR4C7KzWXXRfIjYANO0gyU+qCvJCLa88GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452554;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Mkw+ncroL0zLYiSD59Xvmz4bLIDFdFNX5LXWOyWMsOw=;
	b=X9zHRXyVn+JhHjY4MtVTV+S38P5zPyqiP1hc2nogIchm7jGttJf6D6LmecsoTHnb7pm+
	 5qv/ecjyHES49VUZFzTlwQn/sNU68k5nMbVi5QG/vIaGInHdylH8bKqa4YGyv32VgEWEy
	 xXLhZeqNzJOPn92NW6xPXOcBJi7rb9o+OYx1sV2oX9xwX+y1sp15cs7daReZ/MPxnfsko
	 i6Z6FXD4gZnjWwkWNemZpkw+yMvhPDiFsUmmg4j1Wb43EB+ya03VEgJveW8ubB2fdIerv
	 lOHK+xVDzHhL0bElwxoUYkcsHto667sqOuKNDRo0/Ven4gBHJgFpUHaIhQBVb4UdG/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ALgM4EDP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21491606A33C;
	Mon, 23 Nov 2026 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ALgM4EDP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80DB1F000CA;
	Mon, 23 Nov 2026 16:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795452553;
	bh=Mkw+ncroL0zLYiSD59Xvmz4bLIDFdFNX5LXWOyWMsOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ALgM4EDP0l/eVAClVRR666EtCt9Kd9ZEIUJfVq7kRGJ6uv/UAUuK6XeK45vJCQbVQ
	 vS8sJjYg2VOPaVFEUC1XFgtMyb4Z4b53ndT5j2+Nc6dzfS2r3qL+L6xre+bZbFayyE
	 YE9LCPw6zkNuP36KjBaOYCjyiBKPsaIEb+VEFCYX5FmW9hs5lHbs6OrPPBMsJKGRVI
	 eXQ+8np/2tDdwUfXzT6n3+BKUB53h9RfjVBOkNbeCodUm3fYCn3eG4UBMRzJxU2sK8
	 2kA018Wzg14U7/YJzerpgFVa6ZbJA8E/uCakaibJ8b5fdM2WkuYeELM/cV2OkZEE9W
	 dNMT9cEMjXy2w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 04/10] clk: composite: Initialise sub-hw pointers in determine_rate()
Date: Mon, 23 Nov 2026 16:47:37 +0000
Message-ID: <20261123164834.3330320-5-lee@kernel.org>
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

__clk_hw_register_composite() leaves mux_hw->core and rate_hw->core
unset at registration time, relying on the composite callbacks to bind
them via __clk_hw_set_clk().  While the fallback branches of
clk_composite_determine_rate() and clk_composite_set_rate_and_parent()
call __clk_hw_set_clk(), the primary rate + mux branch omits it.

When a composite clock with both rate and mux operations has only a
single parent, __clk_init_parent() skips .get_parent(), leaving
mux_hw->core NULL.  Subsequent calls to clk_hw_get_parent(mux_hw) or
clk_hw_get_num_parents(mux_hw) in clk_composite_determine_rate() then
dereference NULL.

Call __clk_hw_set_clk() for both rate_hw and mux_hw in the primary
branch of clk_composite_determine_rate().

Fixes: 2f508a955a67 ("clk: Convert basic types to clk_hw based provider APIs")
Closes: https://sashiko.dev/#/bug/linux-55b1d094-a5a2-44a2-b323-dddc52661f32
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/clk-composite.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 11842bce5918..c7c1ff590e14 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -69,6 +69,8 @@ static int clk_composite_determine_rate(struct clk_hw *hw,
 
 	if (rate_hw && rate_ops && rate_ops->determine_rate &&
 	    mux_hw && mux_ops && mux_ops->set_parent) {
+		__clk_hw_set_clk(rate_hw, hw);
+		__clk_hw_set_clk(mux_hw, hw);
 		req->best_parent_hw = NULL;
 
 		if (clk_hw_get_flags(hw) & CLK_SET_RATE_NO_REPARENT) {
-- 
2.56.1.750.gf70dc682cf-goog

