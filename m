Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3EE33D51A;
	Wed, 16 Sep 2026 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546190; cv=none; b=E/yQPXfR45Ni3l1v7y5XTLAL9Txd+dvXixxqzBAb+fWKJJAsQsu4XtoOexaWkxn19hkhBrghMAhyXKvFvdTsdqyswT2iiWcEgHUfHVTLclYmbRiSoRVt1zCHDfoo+jul+8DIM38CEY5Lp2q7R4O/C1BzH/AZSu7I0KnlkrkBhvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546190; c=relaxed/simple;
	bh=7g4Bx6VcNobxJ0NKjiVjkZ2NfOoDHgnEhpsjeZEGI9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oYAIQQbbFUdrT3mKR03m5a7HitnB4qkEGHhduMByXTdxBO45UDmUfUxENhObYvvR5LyiGlF1sGHAzSXlEMVL/OwoYecSm6NOTRLYso3QPbxMCNVYAmVcUaWTyAiOLxvSv7/ZOsZZxJQLNm9MLuLt4ikJBxoNQeLRJBu+yOn0hwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=WmVvQ/vA; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="WmVvQ/vA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789546167; x=1789805367;
	bh=KdnGPyMt+WNrC+sXSZeon9pFIAKeJSHes4isdLhm8wg=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=WmVvQ/vAFKIGgYgFaFzLL/zeSDtybfwg6us4vVK33nYMgpdc9ARj5MMmi3yGfDH/O
	 4a+7n5/O9jWvutBSXpUdeUtdbCF+Vjxf1WvLPz9mm8kb+UeRQXFNknn5sDuJ4fHozN
	 YJi32bE6pBoAy1YU7CuXZd+I8leNl+NYnfyt9YbEKZTBkvFl57qi5nc7GgQXnNCgs4
	 yZlogwpisshoNLnxV0EAg9ktAgVKMR6+mm2/DwZ+A/pywA4P4lrz0gwnNaljKj83SK
	 CXXf6Embn7JM+ShyajUt/v6t0C52iqLLRmfUVSSyznEtHJo61BDq/RB4nTcZfkirG5
	 RjPzyY9oDR5FQ==
X-Pm-Submission-Id: 4hlBPJ53csz2ScPH
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 16 Sep 2026 10:07:59 +0200
Subject: [PATCH v9 03/10] iio: accel: mma8452: Fix runtime PM bugs in
 mma8452_read()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mma8452-open-drain-v9-3-0dd24fa2f3d7@geanix.com>
References: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
In-Reply-To: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, 
 Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789546157; l=2127;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=7g4Bx6VcNobxJ0NKjiVjkZ2NfOoDHgnEhpsjeZEGI9Y=;
 b=Ju2uL8tn7OgC+R/Nfn5weZgamzhJrK5EWQ/i4i4Y+TUcEj5WmjfoYRvbJiMrRLAFiXjUX0ECW
 3JJZ9qUruXjB5httPKCE5KovQ1PtEooEjuY5h9yd73h6ct6bvefhOrU
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

When runtime PM support was added [1], the implementation in mma8452_read()
was done incorrectly, as it calls mma8452_drdy() before ensuring runtime pm
has set the device active, so it can cause read from STATUS register while
device is suspended/off. At the same time, the return value from
i2c_smbus_read_i2c_block_data() was discarded, and the function would
return the value returned from pm_runtime_put_autosuspend() instead.

When the latter bug described above was fixed [2], another bug was
introduced, as mma8452_read() would now leak the runtime PM reference
counter when i2c_smbus_read_i2c_block_data() failed.

This commit corrects this mess.

[1] commit 96c0cb2bbfe0 ("iio: mma8452: add support for runtime power management")
[2] commit 5bdff291d20c ("iio: accel: mma8452: handle I2C read error(s) in mma8452_read()")

Fixes: 96c0cb2bbfe0 ("iio: mma8452: add support for runtime power management")
Cc: stable@vger.kernel.org
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index a937cbd84f30..a77c4b88b61d 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -242,21 +242,25 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
 
 static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
 {
-	int ret = mma8452_drdy(data);
-
-	if (ret < 0)
-		return ret;
+	int ret;
 
 	ret = mma8452_set_runtime_pm_state(data->client, true);
 	if (ret)
 		return ret;
 
+	ret = mma8452_drdy(data);
+	if (ret < 0)
+		goto out_runtime_put;
+
 	ret = i2c_smbus_read_i2c_block_data(data->client, MMA8452_OUT_X,
 					    3 * sizeof(__be16), (u8 *)buf);
 	if (ret < 0)
-		return ret;
+		goto out_runtime_put;
+
+	return mma8452_set_runtime_pm_state(data->client, false);
 
-	ret = mma8452_set_runtime_pm_state(data->client, false);
+out_runtime_put:
+	mma8452_set_runtime_pm_state(data->client, false);
 
 	return ret;
 }

-- 
2.55.0

