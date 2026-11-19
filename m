Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121289;
	b=3oDdjocAMftMj0d6QPnuaB4ZkPCBBiRRfUncrOIb8VmWXpL8JC6TKQibNFvIs6fLePWA
	 nbnP86aSxWYbphWqyz66gFZ+3sGkYjlb8Mr24/66hwarZkZCveXlMieiwuy/72kq8hhRa
	 uTE5Zv9Xsx3Yvjq4UJSKm+YBXLwNswiICOlx87DRxc3AdQ+Iqpc+/xfDrl8QKNwXXDp08
	 TGbK6y4Q4VwxDrssX2JFgN/9vKyOXimtyiqH3a09FLh6XwFNE+ForOwc6zgLgRJgCQ28o
	 67dmUiN3CmewZJqqiasreyBtX0dUQHwM/N04aHczkiTE9WcsrkCTJgC/Le/eMf+hqNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121289;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XaEN+WtCBwJMJ7rAddYaMRKfk9I458y+qYuisXAn+1g=;
	b=fNiFT8IkljSbdLJthgsf35mpWTNL4yaduELYGd6JryPwJGkkFIGRjJ2EJwIaOyh/7gn8
	 VmG16H22i8h6st/oAHk9E20REJA3/xJxvt91xfUec9WuhgXja6+ORHUnhD/YrGZuRbwrs
	 7VO1WJaeeBMAxYYtUAu19Z8iuMDtHt4Ori/uXrJlcaW8gPUvcU9pop3RKQGjEglcouA2l
	 vkx2VXQe1E3kxI60Npa7+Eh9S3eTcRSaOLQ/ckMri2TFv3K+6HTXkYcjywwqaeg1E7JIn
	 SJhKqQgtqPJbcrCFX8gpj1r6WribFI3Awm2xFQ3iKCfXmjAF/Ixs+D0uNO+uWk87YCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GkrwZp2g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13D606BBA1;
	Thu, 19 Nov 2026 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GkrwZp2g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404791F000D0;
	Thu, 19 Nov 2026 20:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121289;
	bh=XaEN+WtCBwJMJ7rAddYaMRKfk9I458y+qYuisXAn+1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GkrwZp2gA70YVmUW84ItruUaV8d0lFkKqwyX0Cj+xcTNV1aO2TlHBmk0kxID9MqCe
	 r8ojHw+9sffN/uG7i7iFrjli6zKF7YA1IJdbewAI24/cgkLwLz7+c/5aEgfogLubP3
	 5rMS7X8eo3bgLEeSgZ7FtWUeAns5nE2Cc9iyoTwCyZM5lozxzOf69RNDc7BAdBYqgO
	 p8c2kYgcHpVgUqsL0GSymiVkbs2XKortcggiUKCNrSXte5Yx95MrGKa6fn1uLiY1O6
	 3JmS6Xfq6d0dVkZjn6EBH2avUNGXpTMGW4lOOjY7V6okr+e70NFo52cPvJCvYq8+n4
	 hrnjRu0QTgtsA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Paul Cercueil <paul@crapouillou.net>,
	Linus Walleij <linusw@kernel.org>,
	Olivier Louvignes <olivier@mgcrea.io>,
	Paul Boddie <paul@boddie.org.uk>,
	zhouyanjie@wanyeetech.com,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	linux-mips@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 2/6] pinctrl: ingenic: Fix element type of x1600_sfc_funcs array
Date: Thu, 19 Nov 2026 20:47:17 +0000
Message-ID: <20261119204748.2558209-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119204748.2558209-1-lee@kernel.org>
References: <20261119204748.2558209-1-lee@kernel.org>
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

v1 => v2: No changes

 drivers/pinctrl/pinctrl-ingenic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 4d27ec03f15f..d39bb901aaca 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -2470,7 +2470,7 @@ static int x1600_mac_pins[] = {
 	0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b, 0x3c,
 };
 
-static int x1600_sfc_funcs[] = { 0, 0, 0, 0, 0, 0, 2, };
+static u8 x1600_sfc_funcs[] = { 0, 0, 0, 0, 0, 0, 2, };
 
 static const struct group_desc x1600_groups[] = {
 	INGENIC_PIN_GROUP("uart0-data", x1600_uart0_data, 0),
-- 
2.56.1.750.gf70dc682cf-goog

