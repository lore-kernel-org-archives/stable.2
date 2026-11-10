Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278672;
	b=O5C85nA1TtAcupy/x6m+NO6BRa5YtUHGomzTRq18LdHFsCP+hKkBux3vw0CFgP5/Pmyc
	 0/KeVxpDMZ4IBz7Gnd8vceKUENXlctSDz6vgB9iB5X6DxP9pEE2rFw369FZe83abGuM9U
	 8W6ovKB9ds6z6C+WQ3lKNZSc9DGWu6zeHWu6RtofnT/O/7wqg5DscxGW3jEc6fOkYK5H5
	 iuywDhEWyOqh0FGx8Du3FALLXx/DluKk3mhQ59A6xERydUz6ljd51Rs0dM2zmJO7o44m6
	 XWPDi4NaMZjS6OglCytPzyByLgekB3g5HakMWH4DNX1CEEDP+1UjQuA/6RCDD4FUWAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278672;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rtkAG3JgTlI7NEBIytrM4VwqZ0pu2H3UF6bKHoZ/wig=;
	b=MMyqI7KOe/BAXOxAtM2rpA7AUjp81GqN8iGw7pL6i1hkBhs0mE9vLzyY9G9fAr1IoQCC
	 JAtqj+F8amNYP3A9S46P1qwe1NN5Vl3M2aUHpYhP/YVgIv74w2iXyDoV8nUmo29jY3lIK
	 KmdkV8EREvZ35np9NqjlSf7U3WAPSXPDld6c5RxEvZh9ji6pmsummiW5uYhslmjShFNyM
	 YQ+cCRzPyMOUlUtXVJy547PDfQxot/egiuBPgjKz1weXGd2BYww/5VZ59mYbWH6goKJL1
	 +Yj0i9NyptKQG+ckiw/UMyfpjgTnwh96d5lNONXONOxIbEdxasxhUt80GczmixJ6FPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFfKuC9V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63D6606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFfKuC9V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAFC1F0089F;
	Tue, 10 Nov 2026 02:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794278671;
	bh=rtkAG3JgTlI7NEBIytrM4VwqZ0pu2H3UF6bKHoZ/wig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AFfKuC9Vwpxp5v7O12ovlGIxqnu5xr9YgZlUkNRJ1LJyXxEVuUzKl2+M8irjekWN6
	 OVI6FxyPdhvQ/VM3zrj2uvVv2k7sGvtkT3qnbdLBNp4NgRYkFTMgHZFmvfEstoJ3HI
	 fNxcgmoQnNi3bBRwlPDVUJahvxGBPvKqh2Y1nCTBZRBJjW9DlT1bQIpeuyPmQa0vBG
	 TZ/aaeOxvmjg0BZSsg0JRnxG/9TtCuuZ3hXlJq+AlfSNZYWxG71fXRw6EiokhkpvmW
	 0Bi8Usp0Sjql0pLbiZK28GUka+mO6acVeC5G70wx3SQ4EUj9Xuk57nD0or+Z7/FvOt
	 JwtWWrFevvk5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: light: ltr501: Power down chip if request irq fails
Date: Mon,  9 Nov 2026 21:44:29 -0500
Message-ID: <20261110024418.3922639-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054045-failed-6.1-8a9bcd587d7d@kernel.org>
References: <20261107054045-failed-6.1-8a9bcd587d7d@kernel.org>
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

From: Esben Haabendal <esben@geanix.com>

[ Upstream commit 8a9bcd587d7d768e6c8e9fff88bb89645e412731 ]

In case devm_request_threaded_irq() failed, we were leaving the chip
powered instead of powering it down again. Power down the chip switching
ALS and PS modes to standby.

Fixes: 7ac702b3144b ("iio: ltr501: Add interrupt support")
Cc: stable@vger.kernel.org
Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: adjusted context to preserve the existing IRQ request failure logging ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 49f293232a709..e72bdbcf9540c 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1576,7 +1576,7 @@ static int ltr501_probe(struct i2c_client *client,
 		if (ret) {
 			dev_err(&client->dev, "request irq (%d) failed\n",
 				client->irq);
-			return ret;
+			goto powerdown_on_error;
 		}
 	} else {
 		indio_dev->info = data->chip_info->info_no_irq;
-- 
2.53.0

