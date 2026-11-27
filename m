Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807660;
	b=rWs5/9esfflV5jXQPo89bgY4P/n2Jni9BouVlZqUQQC4dom2fXRxdyKC50i1i7uCyrfS
	 KqPjHuQ2vro7k6FeCCkf2byeNmhbESmmy/xzI6naDPhrsfW0tEPSXvUEUkP4tyr1au3HC
	 hPmcv1jr3xQDJya6qkUXR4YQbMMQr9Y1NSiWy5GCUUKTKFkqFcexgwoWj5ee/kzGwnHi/
	 +GnbdL4uGQxM0UBLvzIO94vNg3ZS1Ja9iiZ0awO94u3+4Hn3cZw1Wwv/hQ9XhTvZadYlV
	 iH3D56VpI3dEEGCP70gN4+tkBhKj/c6d17Cf9raTYNWuSO8+n+BZmTGLcStQ70yoTNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807660;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+vwIeLDnsOZBbYz2tZ2xYe4yvc/dkMjEB3SP/vBfTJ8=;
	b=TyL2MVAtuur79VMX8a9ioOzfNG7YLZ98ewEWq+YQ3itDl3cfWDKxNRfgqtAzasOD6XYP
	 49I4D7op3ztK9nWWezUO1ULUjjiAe8OYPsOGa9/E+MAiI54HtNbU24qiVvfMVRulzeluE
	 W8Bpoq+J75Rcbm61lvwHkeN7MSNiHkiLACiuFB739z9qBTefo/5gHJXNEKw3MUSqo82uO
	 JcSr9tvCKFBFB9ryqWgSveCN/CKTzWqegzZgaNLBA178LX0/rYqsc1mhHOhvRAa0tRnCa
	 A2scgp0cmb4wvwqRoMXztm5Pb8O42JvlQCfoZ4D3Rj0jX/bFfY0RofvL94fRdouV0UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUR5gNyt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31608606A31E;
	Fri, 27 Nov 2026 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUR5gNyt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547251F0092B;
	Fri, 27 Nov 2026 19:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795807659;
	bh=+vwIeLDnsOZBbYz2tZ2xYe4yvc/dkMjEB3SP/vBfTJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fUR5gNytspVLtdWl/WZW7qxJsoEGAW+2ovp903EpbmDg6PrFfMhcp8Z3ur/d0hKX/
	 V6d0lExTf7jJk9c+R/CDH9ClNOWocw0bqPIwFMDRB2F4aMr6pgLItBFOiO8EPdbHk3
	 9TcuLNWmbnszMkUnojMOxmUYltXygkGk4TNv0XQwy7qIza/v8n/uOGdamgcAUGziF9
	 7n8cI2uihfawDPQ+89qfTxqlKTRY7olZd/yYxQsjJDMXzpZsJI3VQQIkkvtNLWTMDb
	 Ze8Co75nWeskqj8TnMPUb2TZb2iMYjF3KnT9tj1ZWy5okvODThDYbwzcK+t+AqU1zr
	 QAuf+nhXZKE1A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 10/10] clk: versatile: icst: Check kasprintf() and put parent node on error
Date: Fri, 27 Nov 2026 19:25:34 +0000
Message-ID: <20261127192620.3443537-11-lee@kernel.org>
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

of_syscon_icst_setup() does not check the return value of kasprintf()
before passing name into icst_clk_setup(), causing registration to fail
with -ENOMEM after redundant allocations and logging a NULL name while
leaking the parent device node reference.  The IS_ERR(regclk) error path
also omits of_node_put().

Release the parent node and return early when kasprintf() fails, and
release the parent node when icst_clk_setup() returns an error.

Fixes: 1b2189f3aa50 ("clk: versatile: clk-icst: Ensure clock names are unique")
Fixes: d430819d69a5 ("clk: versatile-icst: add device tree support")
Closes: https://sashiko.dev/#/bug/linux-e1f9fcba-856e-41f5-ba69-bf159007e2af
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/versatile/clk-icst.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
index e9c7353aa5d5..10cb34a3e8ea 100644
--- a/drivers/clk/versatile/clk-icst.c
+++ b/drivers/clk/versatile/clk-icst.c
@@ -566,11 +566,16 @@ static void __init of_syscon_icst_setup(struct device_node *np)
 	/* Parent clock name is not the same as node parent */
 	parent_name = of_clk_get_parent_name(np, 0);
 	name = kasprintf(GFP_KERNEL, "%pOFP", np);
+	if (!name) {
+		of_node_put(parent);
+		return;
+	}
 
 	regclk = icst_clk_setup(NULL, &icst_desc, name, parent_name, map, ctype);
 	if (IS_ERR(regclk)) {
 		pr_err("error setting up syscon ICST clock %s\n", name);
 		kfree(name);
+		of_node_put(parent);
 		return;
 	}
 	of_clk_add_provider(np, of_clk_src_simple_get, regclk);
-- 
2.56.1.839.g22a8290db9-goog

