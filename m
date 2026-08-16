Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71683EA955
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786923766; cv=none; b=tPz76VY4EJlHLzphpp9zbPHKmNFFR0GJ5xXEm5b0CcfSdcLG17RhcMsfMxFa6O0/n+uRaBHqUwvYbmjD+uIe9MP/iCSOtEaLaLWvja/VBQfHiY/iFuSzjYkmaditICI0+WnZN6305ZGJEd3vb0/orq6SaTmy8hFCFUXMjIr+WR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786923766; c=relaxed/simple;
	bh=VrOjBtDyZdaPKMTzH33OYXvmL8G+wknlOLtphJjQl1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4OS45zbJq37/wwXrqRFdDY0dJWbFjN6Hy+plW+8c5rFLx//6Q3iBsCUDIJAPi6dx6+a0pr6fgVCnn7vDpHbL768WJjgrR955UeeLZDz9IfaNGm6Vj9C2+xsvRLfMieS2YsJBqG2njnArloQ4GxJVJg3cVGV5699M4jj5iQUi48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtMmysjv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtMmysjv"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49954b88fffso31543795e9.0
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 16:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786923763; x=1787528563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G8Fz286ccYp2u449U94NCIPiv/rPOIyX29xqISQ0+fg=;
        b=JtMmysjvUjYxClZ2FBrTP3CTcp/Pjy76tr0imHX0XRpBqXQZFaFEnenhpPZIj77Agv
         WQZ3QfTlRLsmIG1IU+KdZrXSDkOi7kgHDMIAIAp0TxYRos8I1LDDiP8/gGw61OyyQxgU
         J1kOobyWSorhYmY30F1pmQiB/uJibhgRTEB6BSCYeiuC1Af5qBbw+PEpdNVFnq6sGp0i
         JiWSL40TvBKFlxLaMpPzAdVHxn0iOPSxVs7k8rTP0UrDXJUsz7jS7fy+8+Zvd6OEcQWU
         e9xfVLEAMNGASctbKXXNJNYmZVB1RliUzKhPwmbDJwyVrzrqJa5hlM9vvAlQX7oNjL/M
         fv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786923763; x=1787528563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G8Fz286ccYp2u449U94NCIPiv/rPOIyX29xqISQ0+fg=;
        b=OOE51oIfyaypbIaAkLR2LTUYsI6Ocw3pnDtrLg3FLnVOR1sZgZEm6BBadI6mGnnkmP
         PdGoU2TkLosUAPjWUUhn0IzB0mBBxo6qSiF4dKszag0MUbYWwxYuMB+/MhpRx6djhrCC
         XuXl+1tGZSkJvZa1COBHMQpDWYh6AEYUh0GMkJcMorkNQV5ukHWWU6KpKIAME3vzL1wL
         oGb9B303u0Si1Xm1Q7bsMMH4OGWcV/9KP2P5d7UJ+e+EUzKKlFMH5u9lFLfvp6LgA8vA
         tYf1LbfGjWX4WTpWyqNZxoR/v0pIypqgVETrKPeuvXmZhxk+fMfVUc9fnyZt+P7hSQV3
         bujA==
X-Forwarded-Encrypted: i=1; AHgh+RpO83szufnhohxiYwBGdhDgmfq+rjrjG2iTHIbPCAZx/9Z38hRQ8tBSuW/lkClt3L4g2vkwvo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpa8xhN8Ti7WnNMyLCIwaQZv66CaEMdH2iTlB+jfVLFgjKKpCt
	Pj0R0LDRwScMuf+4IpUPoh+OixFDX/6ytLFprH8KlGMOL92gEQ5MKUjb
X-Gm-Gg: AR+sD129Rw/5W4016UJbQECJauC6mWBt5rxAiYnm1nGJFLwQE5sYADowRX3h4IvKNuB
	5NaB9WOH7hKQ/ao/VuwIscshHckA6Csu+XATAmqxNLZ7/NjosZTkz6ZlduNdv0OJy5uo66KbRDR
	3/qqqJ9tYUnEhw7C0chGSvBy58qaW8MQrE5COPcsUiK38pp67OMDKgFu3oGZ6x2jraWm/FuxZK4
	Vj1bDwym0Oo1XjzZWA4V3bmzLuQABEwpl4J2RgTWEO9oHsqWJT9+Cfq9Y3yli1FnZUzpoIpyXOw
	6g6nTBBhuz5Ox/nqE5Sv7qMbTGkSuRt2G8SmCVmRlzcKOJ6wGTKoDQ0GGJEeeHbGkPPn9KOEgsz
	9NwOSJaNgYCVvOvoAu/LBi4qmkGVN3Qn+qBUQ+5If5Rnc/SjJllFWxclDnbifOQ7Vfa52h2hkMA
	D6MqlwelMpOcng74Epq0cPYss1I5u2jhhevAGCYYM6rhW8DjFPIE2nrdkkEeG2kqWonFWJ/0+l6
	RwpJ5b3iWUFtDPdvALXRphidHOLcGThqTM=
X-Received: by 2002:a05:600c:3485:b0:499:726a:a017 with SMTP id 5b1f17b1804b1-49987938e19mr343714265e9.1.1786923762984;
        Sun, 16 Aug 2026 16:42:42 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:ac71:8b16:e755:35c9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960ff072sm112915555e9.3.2026.08.16.16.42.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Aug 2026 16:42:41 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Maxwell Doose <m32285159@gmail.com>,
	Yash Suthar <yashsuthar983@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 2/3] iio: accel: bmc150: take the lock before checking ev_enable_state
Date: Mon, 17 Aug 2026 00:42:30 +0100
Message-ID: <20260816234231.14168-3-grondon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260816234231.14168-1-grondon@gmail.com>
References: <20260816234231.14168-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bmc150_accel_write_event_config() compared the requested state against
data->ev_enable_state before acquiring data->mutex. Two threads racing
to enable and disable the same event can both pass the check and then
both call bmc150_accel_set_interrupt(), which tracks enables with an
atomic users count. The inc/dec can become unbalanced, leaving the
interrupt enabled or disabled against the callers' intent.

Move the check inside the locked region so the test of ev_enable_state
and its update are atomic with respect to the interrupt accounting.

Fixes: 14ee64f438b8 ("iio: bmc150: exit early if event / trigger state is not changed")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index d067da9b5ce4..bcbb9f0c830a 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -805,11 +805,13 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int ret;
 
-	if (state == data->ev_enable_state)
-		return 0;
-
 	mutex_lock(&data->mutex);
 
+	if (state == data->ev_enable_state) {
+		mutex_unlock(&data->mutex);
+		return 0;
+	}
+
 	ret = bmc150_accel_set_interrupt(data, BMC150_ACCEL_INT_ANY_MOTION,
 					 state);
 	if (ret < 0) {
-- 
2.50.1 (Apple Git-155)

