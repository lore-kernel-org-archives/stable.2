Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3CA4E2F2F
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789732802; cv=none; b=HG7/Rtyo/7bIKTVj/gvM2+Q2x7J0mcxmnV7U38L6XBFT0/X9QwLfyzoanf1Im9iAGoxroLY50CzTkp/YBWYbHqVvRfQtCnm5tshArZAVmaHvlEpxg6Uz5J6prHhiWlPhI5EBhvvEnQSQtN+t3CJ17eJ0iNCWROOpvfnfzfXvbbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789732802; c=relaxed/simple;
	bh=txhqtuEPWi7nD3urKElDbbpKMOAPkwNT8dosnT1pZE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gi796guVSDDEcUhlcum7ifk9U2JBuxsuOKcivzF6bJIkrtDebkuq1k989lG045Is+dJmYcXl+faoNckfexzPGl5i0hbbJ5Fb/9CuYypIAd3X5Ia+IjJ8cgxW4FNOeFmcj2vZ1/E9vLrac6ehenLu6ETZw6Vodggddn7wtmmDkk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCiSmCRR; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCiSmCRR"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50dc1so357813a12.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 05:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789732800; x=1790337600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xYcJRra+LcCNHLwBdH8ymzEfMxOB7CWtfUUDK8cCiZQ=;
        b=mCiSmCRRXRTw81ytFymGzhKFcq+EM6p0FTeNRtVASeu7qaMcuILfgl42DAChfoB3RS
         S4mBT0fvnmc8ny+pLciMQ9F3Lkb4Rq4mmMi+5dX5vQTbZH6si3lSEcDnOAyP3sY6hNkr
         g2/H04cnZ7fW7XFYqV16nBQAkJoHRW26WiE4O5hnmzqseDTThD419+1VtdvEwc7yAawJ
         OY7SgH3n7YjJ1oJl4u2/yZ45ki4huvPd5vVQmohnmYb0E5vVjG3KK/RUuTkcEUFVP1VC
         NDgewBmjmiwr8dkCyXc+VG9SwrYp7jwo90Avt/NUGaEL+nMXyDCS1kSC2VIpIHgj2FT4
         GEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789732800; x=1790337600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xYcJRra+LcCNHLwBdH8ymzEfMxOB7CWtfUUDK8cCiZQ=;
        b=PBNb8qi7xtr8lIhmmnOaRM+OIyAxkc/5N13TYmC/5g7M0rSUcGUcM2fy6zH5IiVzL9
         3BcJspaoKAULfkONrBSFSt7POVa2J/3L9K3uT/3XlTbEQbMAg8808mf3OddPgqwa2Jl2
         pX3hePNnwuTZZJFJ/Ajv89Fk3r0Flum1zfTfjMV2kjAuV3v2U05YGg/kWzfusioME37d
         dnvka7KS9k95E4ATGpjfRh430t8BkZB1hTmSZ8uY53JndwFcZoKe6v1PXmO9bWXXzlN+
         +kAN9WSr7Tik2OlfC4qWLhi5EEQBACa0wlDArdk7ieFTUrTCJT87f9JF6lPqZGe1NzUI
         F8Dw==
X-Forwarded-Encrypted: i=1; AKwUvBwe1iiEN1/oCaWQTNMZl4LYGRgefLsLHcdgc9HjP8ZB2Mw4nmZVsCARQbQ7SmZoek7U99t3yd0=@vger.kernel.org
X-Gm-Message-State: AFuF++kc5FFnsBnU/3TbZvTVN3H19LvqskReJJ0nj7nCLhEyW/YWO6SE
	WcMH50mJ8GJN4hWiRKCMdJWGWXPXsNtNpt+955ZQskrQVrNVPLFUTj/2
X-Gm-Gg: AYBFou0Gui80vGsibIrXV0YPWGmEJphS7+EOP+5qyivsZVwNObUTL4IvIsuNVLLnsm5
	EFjvGhnmIX0VdJ+vhBisPOYdwGk1iIOEfSdOTY27ngT6Q6J5k8bAuUUtMfFVWEyesLqi5ni64fD
	khGHbMmee8ZOHb7HkJyC8C/k9zLBHA/sYnv9EjvrePd7XWYxRyqcFOJ4p3vfCBaig0NtdltEyiW
	Rdz2u3mV8s9sx6xGBrTJh8MjCyKJ67onC+wb+xMew1ZNmg5D0lhMBHv42ldlJmsQGwqVXQSzdfZ
	vsdrfa0LW0Bvs50SZCHOOtiJ548MLPWxVzpY9ndJEUwDQz/OGxyXRATDlDEM0wIBP1s9T+Lngag
	pKhefG58VHTRGWzdCQWmQ+G7zyeg5V4s7Uu5KR9FU8OcQpOhD0jlQx0pndhSsY4lvjxWlzk4b74
	o5mVQvy7jb6gi8GMIHf+rHzUSqjBxNu6JrL8EKPq2THbAp52xkv0G6YWphXLLEReJRjaeR798OL
	cdrGhpCh+np3ZKzfK4=
X-Received: by 2002:a17:90b:4b87:b0:39e:345b:3323 with SMTP id 98e67ed59e1d1-39e54fb121dmr4831022a91.22.1789732800428;
        Fri, 18 Sep 2026 05:00:00 -0700 (PDT)
Received: from kernel ([103.219.206.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c2876a52esm4179626eec.20.2026.09.18.04.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:59:59 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: clabbe@baylibre.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	linux-crypto@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] crypto: amlogic: Fix IRQ handler return value and fallthrough logic
Date: Fri, 18 Sep 2026 17:29:50 +0530
Message-ID: <20260918115950.9121-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In meson_irq_handler(), when an interrupt matches a flow but the status
register is empty, the driver prints an error but doesn't return. It
falls through the loop and incorrectly prints an `unknown irq` message.

Fix this by returning immediately. For empty status registers, return
IRQ_NONE instead of IRQ_HANDLED to avoid masking spurious interrupts and
allow the kernel to detect interrupt storms. Also use
dev_err_ratelimited() to prevent console lockups during an interrupt
storm.

Additionally, the handler returned IRQ_HANDLED for genuinely unknown
interrupts. Return IRQ_NONE instead for unhandled interrupts.

Cc: stable@vger.kernel.org
Fixes: 48fe583fe5417 ("crypto: amlogic - Add crypto accelerator for amlogic GXL")
Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
I have addressed the IRQ specific issues in this v3. The other
pre-exisiting issues mentioned by Sashiko are already addressed in my
separate patch.

Changes in v3:
- Revert accidental clock management changes that were squashed into v2.

Changes in v2:
- Return IRQ_NONE instead of IRQ_HANDLED when status register is empty
  to avoid masking spurious interrupts.
- Use dev_err_ratelimited() to prevent console lockups.

Link to v2: https://lore.kernel.org/all/20260918110504.7207-1-raizudeen.kerneldev@gmail.com/T/

 drivers/crypto/amlogic/amlogic-gxl-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 169c6eeb51e5..09d3ccd92b80 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -37,12 +37,13 @@ static irqreturn_t meson_irq_handler(int irq, void *data)
 				complete(&mc->chanlist[flow].complete);
 				return IRQ_HANDLED;
 			}
-			dev_err(mc->dev, "%s %d Got irq for flow %d but ctrl is empty\n", __func__, irq, flow);
+			dev_err_ratelimited(mc->dev, "%s %d Got irq for flow %d but ctrl is empty\n", __func__, irq, flow);
+			return IRQ_NONE;
 		}
 	}
 
-	dev_err(mc->dev, "%s %d from unknown irq\n", __func__, irq);
-	return IRQ_HANDLED;
+	dev_err_ratelimited(mc->dev, "%s %d from unknown irq\n", __func__, irq);
+	return IRQ_NONE;
 }
 
 static struct meson_alg_template mc_algs[] = {
-- 
2.53.0

