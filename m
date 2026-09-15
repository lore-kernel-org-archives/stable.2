Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33A4A5EC4;
	Tue, 15 Sep 2026 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461208; cv=none; b=FH/PE+6zH6ZxIQ2bXymMfivH7D6452gnNuOvP2Xt1qU+/r4qBNgqlKXctGDb+dqFvINNkTOlFBpv6I+BapjrOaZk9gFojub3q3jYyZteaga3LqWPByEjrSdtlWNK1GUYAgldoK27qZaVoENqyz93Bx5+VUlBRFaaIXX9l4B10u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461208; c=relaxed/simple;
	bh=Uv0Yov8JAiK5YEYKgmjYw5ZlbWxjU58cDlvmzD4Dh6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mu+wkIYjwqasOw6pqP0TvdNn8qGE9RerbqA91pzsKu8yHxGZn1Nklm519I51E8dYv4+gTCBQykr+/Muz6ac4Y2bMLxRPHYPe0kWwqDU521MWld40xii7ltAzVeYUhSQWXWeuVET8TTJFoxR11mIr1GK6ZaLqfkH3KJ4GfScjed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=Y6yx7Bwn; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=h5oAG8H1; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Y6yx7Bwn";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="h5oAG8H1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461205; bh=Uv0Yov8JAiK5YEYKgmjYw5ZlbWxjU58cDlvmzD4Dh6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6yx7BwnnL5wMdDdFr2jAnR4f1XXutEVKMgKnpsizm9t28+xOyZtsyC7prM+LuVaQ
	 nkbICOyYFGzEoAadWq5lwvPJs+6uPQqMfVTqi8vt3YREI1WLCKzGrCyXHlrtsM4Idx
	 5F8HEAtXgaqpvAyjpN94sqUecu8lYbwlDbm7hh/k/Yjj87yHEOB+rt+ZfZBtzJiEzO
	 SZzJkCY1ebCGRBzCvKLdZFRfVLjoVGVSLbZFTwk4QGwUXDnozllxdnHmpK3FcNqTKi
	 gpSMhOsxOJsNz6yfi7avcvc2NqEh/QsV8hWvyCzeahXzIplMA6ecOneUPzscYxvr0t
	 RcnpQsTvv+JFg==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id B098440BAC; Tue, 15 Sep 2026 09:33:25 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461204; bh=Uv0Yov8JAiK5YEYKgmjYw5ZlbWxjU58cDlvmzD4Dh6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5oAG8H1qlsBA9WIWKR45SOMKuWvb5BiesczV9COwAlv09kLIbHTCdO7GvOUlJrxj
	 VRa6KleffZnUccPJqBhpPMFocdiQaWard2YjSOtb4Eqfq3wMw5Ti1aFaZUQytnvWOV
	 NLMpsHEc8sIXlGrxZxW4r+VE4Dvab/9cKsENBS9RDbK7oSo6U4CkRhkoYnkU/4Fcfc
	 ppmhhAB4n1ZOI7EwegZWg9koNDht0q16OeSPVaXgdbM/UmcLaQi6536zObiEFAbEPF
	 FTxIXHAP92O6i9mWzbgOOlwEiyG/65yRQOnWQjJ3Cwcljw/q+0X5R7z6jugKavNDO8
	 FPbv8SMZ2pZDg==
Received: from maru.home (host81-158-254-226.range81-158.btcentralplus.com [81.158.254.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 8332D40B72;
	Tue, 15 Sep 2026 09:33:24 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 20/20] media: meson-ir-tx: Prevent divide by zero in meson_irtx_prepare_pulse()
Date: Tue, 15 Sep 2026 09:32:30 +0100
Message-ID: <662a613d00359191d9debce0b5a53019070a5e44.1789460680.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789460680.git.sean@mess.org>
References: <cover.1789460680.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an excesively high carrier is set, meson_irtx_prepare_pulse() will
cause a divide by zero if tb_us is 0. Prevent such a carrier from being
set.

Fixes: 49be1c78d575 ("media: rc: introduce Meson IR TX driver")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/meson-ir-tx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/rc/meson-ir-tx.c b/drivers/media/rc/meson-ir-tx.c
index 1ab898069e67..a0d07da09f67 100644
--- a/drivers/media/rc/meson-ir-tx.c
+++ b/drivers/media/rc/meson-ir-tx.c
@@ -219,6 +219,9 @@ static int meson_irtx_set_carrier(struct rc_dev *rc, u32 carrier)
 	if (carrier == 0)
 		return -EINVAL;
 
+	if (!DIV_ROUND_CLOSEST(USEC_PER_SEC, carrier))
+		return -EINVAL;
+
 	ir->carrier = carrier;
 	meson_irtx_set_mod(ir);
 
-- 
2.55.0

