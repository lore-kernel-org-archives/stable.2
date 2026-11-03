Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741432;
	b=E8FQaL/jqFkeJ0IKnPnNniE9rRTu86K9jCo0oVcZF9JOjsWzDX42weZD1FZQXsxqpdcz
	 0QdNcLQh7ltPbQpZoL7QPgtG7U4wNGAFl13DTITL9Vv1kby6p45WPHheJIsJqE4xRjllf
	 jIj47gLwoip/ahQNTps7TN8NygHC7yabtmIbcXm2iihJmf2F3nbMnC8f9KxkhQTh4/WNX
	 YQCcgJJTaysDq54dseBexN9WEMBnHjyUhroFHX/o0f7DE/7r0wxuIcwvPCe/E5B7+wcUa
	 U5YxhVp1BsS/PdpZtHJLCX3PAi21+B9SIrxlt7hYR5YHTLudlCLwxJmqLx+PmUpCCpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741432;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=X7RhpAKffCHdzvQoGlwptm12a7CFvyWWIGsH6qxaK7Y=;
	b=yHOJWU4HK4d64wG6NRYp3wOg0iSlZSoq25tYcRwk31YYeGUvpwQmcNRZyjNkJQEzjJ1g
	 i5ZIEptt/vsc9b4Pnqv4oLIBGNBbRwExCy7w8U42066+8jJd0FOSsaO8pGsDdlpsJNMCc
	 Sz0Id8qbkLUbW5w3d0K8OVvUya09NUyHuhN2TKp8rkUsZMxtqf7eHRJ9nGX/mfAl6iRzc
	 KB4ZnGg42XGDfYIoUFA1Zc4M2xwvYMMXXGKOKBZ6PrIsYjMLq24d75sPK6/eFuV7Ch2m+
	 Cyz8SviBzcfSOw1xdlc6zN7Mx9lYlck1PN4D3AyPl5UesXztNDBFrYVhsmwxdEPcSTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cz6mfIPX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17423606A32C;
	Tue,  3 Nov 2026 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cz6mfIPX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1F81F000C1;
	Tue,  3 Nov 2026 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741431;
	bh=X7RhpAKffCHdzvQoGlwptm12a7CFvyWWIGsH6qxaK7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cz6mfIPX7rxR45LHlTnWumxGl4kaXg8apWoF14/m0XGYtUZkxLydEDVc0bFsWvb8W
	 X2vQs0fPg0QQPvWgEYH/FXF9d5ZRgSpQCMh4mhaZdoyFxN1smEUOHJF1KkqOhZkX11
	 sRthbGtjj8ul53JJYjzpmSZ6RmqCwfswP7EKFV6setmiMwqCmixpMJFYaBnbIbq6ew
	 OOgImbIQEMsqbMRp7pZp/KlQR4TIuNGvFm0sXFMADaAyCXyZchD3oa/STEDEf+k6Mz
	 dcm3ut+qK7dhZPP8L39KhHeGW0Y5zemSTA1ys8fXO/LbmFR5seVeWD+qIBawwDeWJ6
	 Caei25XIKA0Ww==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Paul Cercueil <paul@crapouillou.net>,
	Linus Walleij <linusw@kernel.org>,
	Paul Boddie <paul@boddie.org.uk>,
	zhouyanjie@wanyeetech.com,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	linux-mips@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 03/10] pinctrl: ingenic: Fix element type of x1600_sfc_funcs array
Date: Tue,  3 Nov 2026 21:29:08 +0000
Message-ID: <20261103213002.1673560-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103213002.1673560-1-lee@kernel.org>
References: <20261103213002.1673560-1-lee@kernel.org>
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

ingenic_pinmux_set_mux() treats grp->data as a u8 array of per-pin mux
modes (u8 *pin_modes = grp->data), and every other *_funcs array in the
Ingenic pinctrl driver is declared as u8[].  Because x1600_sfc_funcs[]
was declared as int[], indexing pin_modes[0..6] reads the first seven
bytes of the int array (0, 0, 0, 0, 0, 0, 0) instead of reading mode 2
for the seventh pin.

Change the element type of x1600_sfc_funcs[] from int to u8.

Fixes: 4da56f9c6f14 ("pinctrl: ingenic: add x1600 support")
Closes: https://sashiko.dev/#/bug/linux-5dccd0ae-9450-440a-87d0-44cc86d1af45
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pinctrl/pinctrl-ingenic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 1aa6a6dc1209..5c06208b8854 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -2456,7 +2456,7 @@ static int x1600_mac_pins[] = {
 	0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b, 0x3c,
 };
 
-static int x1600_sfc_funcs[] = { 0, 0, 0, 0, 0, 0, 2, };
+static u8 x1600_sfc_funcs[] = { 0, 0, 0, 0, 0, 0, 2, };
 
 static const struct group_desc x1600_groups[] = {
 	INGENIC_PIN_GROUP("uart0-data", x1600_uart0_data, 0),
-- 
2.56.0.385.gac671c819a-goog

