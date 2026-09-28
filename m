Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010BB4746A3;
	Mon, 28 Sep 2026 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584007; cv=none; b=NqacszQ8QSMTcyHqBq3ZixVlnewihTZpNVQlXqCYAkfYSljLV5SlqUTHh6k06/1+idZdauGDlyvE/NJtIR9INfYynuxVRxazYQC+0R9UsiBbJeqstdMio2jiBzPspLXSPEUUJe+zvsgcsGkc36I0LTZ3e6CWs/2Mk99hPcnCblw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584007; c=relaxed/simple;
	bh=7g4Bx6VcNobxJ0NKjiVjkZ2NfOoDHgnEhpsjeZEGI9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k+sG8V0V7dtCclJPVYuZx0QAb/pvxnS1zS2pn5yztagUlz1bsOiJmD8+IVDcqt2O9yL7QtdmMawoCy3QSJ9Kxliy1IMn6EMExopCsl5gBib6dETvm8KB9vcBiYAdnjOBNdZbdAWni4epL3m1fNsSzexbExULnGp+q77cWtalj9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=QCwGg2aV; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="QCwGg2aV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1790583991; x=1790843191;
	bh=KdnGPyMt+WNrC+sXSZeon9pFIAKeJSHes4isdLhm8wg=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QCwGg2aV6Ljp0sU8JTdCvDyZjb2H+DjHRYSIKhYvwliw25PlYhDN7fb2K9+ygymTq
	 3ZsbyqbQSaahHncMgRA9iujoLkqmL/2uUUcAeamjcrnjl4teo5aTfoW+x3+kHZdSM4
	 PWKwYxRN2P7yb8YfHvLqEzVkYp3rGMJqMxibXBZv7kS4lxa31swR0elorUqgiJFZ7b
	 hNFkHXj9GUsUrJ2etUltiSdAfP5LH2saglSP8bMdeURRLdPKxLt6P0wuwEa0U3xyNV
	 HhZlKHRf7hbbhL7GO5xckIasKazLzJ/JdzVujNpQAsi1ouZ3Lj487YrYduw0fMBSsf
	 bR8n9ODvPFp7Q==
X-Pm-Submission-Id: 4htZCT6QNMz2ScpX
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 28 Sep 2026 10:26:19 +0200
Subject: [PATCH v10 03/10] iio: accel: mma8452: Fix runtime PM bugs in
 mma8452_read()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mma8452-open-drain-v10-3-b906fb408386@geanix.com>
References: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
In-Reply-To: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790583982; l=2127;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=7g4Bx6VcNobxJ0NKjiVjkZ2NfOoDHgnEhpsjeZEGI9Y=;
 b=txX77s4OaVR6OD1k8sTLGTpuIPLUvakGwmS4wze10HMHy3j43ChPZynnkTq1QL4MHV2e9PV6w
 J1hwwYlxOS4C7lczPQfMLisZULSYUuf6dluG/Occ9js5IabHTLeMa4M
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

