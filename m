Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13845A29F
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792153250; cv=none; b=WNi2sQ7rF27k5vj4MCxbm/I5pr4TlijCWYCtUS+jeFXOd64XF30wAMuci+HyiIP28POhMF1vY/UcIZK636nd8mdjWOymXulGTGQ/3279kK+Xahg8DEP167kOFBa21Wwa2hRWdteY2aU5cEg+2s+busyoY/AfaK2uzV3DiU1OvCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792153250; c=relaxed/simple;
	bh=PybKD7oFEDWCFearhn6BczwAbDHlSd/P3rpXO4UYmJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZWzD02YlhmUWBprsyo3KVfqtMEZrQwC8g6z7PxRIjDwHoDNxfKeit1ky3HjyQsZhEG/1g1hW7jPMSIjzu10CzIz6UXPRLwuL+JIRw3Btyksl4U6RsExHW0rA12g0/rVn9p8SebRVmWteAOLh4gq/V1y+c1I/L9BqJaSSEtPvFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQlrFZor; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQlrFZor"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e00eee27dso309928f8f.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792153247; x=1792758047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NSmb6XGI1Gp1hjZxIN6yrwoPW6ujDDUYbz0vs1SVhBs=;
        b=XQlrFZorWZAYwR2BPIY0U9a8S0Jf+kX7dSqe7Fh+UfaIgkrXaJkyRHokoo+bZDVI2G
         KHY7yMyOjwl0WT7gGz5O+k8ZdnRi03JTdqySc2hwneSjHLAXY7MJqsFt91lhG0A+FLwB
         6vvMFe1NHzifiUnGeJxwAMhWTL0TCxVQe5JWIlzTalMkhSMA/VsY0iWv/kEuscfn/r9n
         tyXuifthFK3hO7L1P6r5LZBLcEb6qglPS9r3bpUl2aiHtujQPsOamXxq66ddx5WKUAFh
         M8bGiBDUgTezCrqT7ziRR+dSp01ajafLlorY8RVITOoZqeKp0fJixSg7ifE1bL5+WcEk
         Ruzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792153247; x=1792758047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NSmb6XGI1Gp1hjZxIN6yrwoPW6ujDDUYbz0vs1SVhBs=;
        b=mFJnZ8lv8t00aGREm7aDM2BDIHZS5qFN+MnGiWTOp+UJ8a27pBXyWGl42cGSZdMM92
         nVvPkZLVhnwLG3Xsu1sjsvaqJ0gA9/F2pfpWo3XSk27CT/r4fIGE9nWKMnc7WZFmBU8F
         mgJnKUDH3hIqKJ/YykEBR1eqlnWekxYGlWwE9u5MZRK6Z9fd1pbeEtcV58Rq1cELlE8o
         c+FikgSBLc44Q6BdAFHMZ9O2lSHQMh5jSwp/c40gI+1ARZaAdzU/g9vRq5uLqpFFo/rd
         +IImkVpKW7GDEYD0xolqan8iMdHeWc0ueqlQVcj+RW4tmItQ3G7wlxAVXWOJpvp8WJ+U
         6TPg==
X-Forwarded-Encrypted: i=1; AKwUvBzcGHfLT1+kR3S8YHMIOC+uFgm7+/wkM7S3a6N8VZrD2nqZJnnuzHrpSB5sJoVr3XpcfNz0Nws=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1+GfEg4TfQGaSqzPWx1GaYv3VDH4PwzTrAxaCNyoxO7DX2qGL
	6IATrSzCjI5PF8+v8ZdocPN6EbofsB5kIfZC9oaq89DHPYPOkVKDd6oX
X-Gm-Gg: AYBFou0DcONPRVcx2NINgl3CEggy4LZG/uQFxGjAji2tLPQ3cKkbqQ/zinrBiLYJihg
	DgpDf+bHHItBDwmiDoukGlxrgPZxh8LfiD8OqIaSm/fuKhGdSuAGedtePdhnMkrRJwWnx1dVVhr
	rktkYlUbTVWN1RYuvY7gZpeDgpXBWACgHVvEFdhG/5ODrPXDwfrdyNzP4I75wMff8z3wlrdLriu
	+G60YaoWpcmZOBFLgdEZI+Pj1RbwMwx3HScYeFsZoFt6wrIU0tHVKz4RX3Aa+b1O+tGOrgLe2V8
	J3jy9SQiaVqWK7ZTFDUVocWwRqbwIvpyF3fPZHoH+kiGCy0KJv3L+5p36EC29e49gU8frFD7pO/
	lfGAmhZBqxi0p1WuRRmUMAztiixipHAg1dcOuUaD3ji8SeSBWBM3jcxlfwn7JzXZouP6sqzattU
	B8exm85pi+v8jUS8+O8z22H0zJAKs5Ej3C2WbRwIg9kiw+GSF+p53F4KTiVJkYAKsYAb2C51wKb
	Fq8CqZJ32f1onzeR0OEG03AwoGm7ypNJPYOdPCFt93oBK4MUA1kt2x1qUvi4h8hPotjzVRybjfZ
	/HWwfrWuAnIvLBjDWA/QrsKGQrwCZY4LSy+nOgh3qg==
X-Received: by 2002:a05:6000:4288:b0:488:6ed9:b11d with SMTP id ffacd0b85a97d-48dbacf554cmr43716985f8f.52.1792153247234;
        Fri, 16 Oct 2026 05:20:47 -0700 (PDT)
Received: from cachyos.tailab2f6.ts.net ([217.180.53.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5008e7sm4752728f8f.43.2026.10.16.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 05:20:46 -0700 (PDT)
From: Chaz Bailey <charles.s.bailey@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	Chaz Bailey <charles.s.bailey@gmail.com>
Subject: [PATCH v2] usb: typec: nb7vpq904m: Set client data in probe to avoid crash on remove
Date: Fri, 16 Oct 2026 13:20:45 +0100
Message-ID: <20261016122045.187862-1-charles.s.bailey@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nb7vpq904m_probe() allocates struct nb7vpq904m, but client data is not
set during probe.

In nb7vpq904m_remove(), i2c_get_clientdata(client) returns NULL, leading
to a NULL pointer dereference when accessing nb7->retimer or nb7->sw.

Set client data upon successful allocation in probe.

Fixes: 88d8f3ac9c67 ("usb: typec: add support for the nb7vpq904m Type-C Linear Redriver")
Cc: stable@vger.kernel.org
Signed-off-by: Chaz Bailey <charles.s.bailey@gmail.com>
Reviewed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
Changes in v2:
 - Rephrased commit message to state that "client data is not set during probe" (Krishna Kurapati).
 - Picked up Reviewed-by tag from Krishna Kurapati.

 drivers/usb/typec/mux/nb7vpq904m.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
index d1fa26ff44..52e3c9db35 100644
--- a/drivers/usb/typec/mux/nb7vpq904m.c
+++ b/drivers/usb/typec/mux/nb7vpq904m.c
@@ -396,6 +396,7 @@ static int nb7vpq904m_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	nb7->client = client;
+	i2c_set_clientdata(client, nb7);
 
 	nb7->regmap = devm_regmap_init_i2c(client, &nb7_regmap);
 	if (IS_ERR(nb7->regmap)) {
-- 
2.55.0

