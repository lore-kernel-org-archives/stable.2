Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046622;
	b=NyduNAMxVWSzzTbFtxYirwJUYYDvYX9DMB8mvEixsdRz9PrPhS3Jo0nR8sGT5+Ln3ReE
	 nv5mkRTd0pcf89crX22EsoTRp4NaFharplmTkXi2zuI6tA2IKqAJJ7AYMUm6g/mW34Crm
	 6pQWbD32T/kqTYIian0wwfXQuBbnBcwhVaJ1R7tuemgjBGydaVx5WQ1OppoDqfg1Uxzk2
	 wmctZkazZ6DbaN7m5sLyBpzU3C4lOIjOgBJUdYDoX8Ip4rYdLPZMJg1qf7nAlAFfz7NZ2
	 qo9DhauAeDHbxzMqL3/OWQgVVu6bWvKZZRBkn/cC1ha7ICKG1szGD15y6h+3aMwIyQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046622;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aTMosOuWcTHiRWa/qpZqDqn8MRkwBLncXHcKf1vokQw=;
	b=STjf4dnHvdhWoN3e4/n5duNvRDxlR4DynNNDzpbm5kg6rKUtOTaO2HrfmF8l4uRmMAOB
	 W2R8/53lqj6dV3BYP7ir/kiigMhKy1ATFBiRiSZN33sS0SKzovB0aZGK6uJWKNv69N0cu
	 5TtevMUK16S8BV8oPTnpiLr7HPuUwVNAh8441TkEfotbf/6SCqZ7xOp/A3WRBvZris0+y
	 g23hBFePVg+L37v0AZCDqjpQEraBCr8m4nwToXmmSZSJ7eDhKsDX9nWiFq8yCB5B915xQ
	 B2H4hOELTOpb5cJ2UdrReXl+1OIgGJgsoBBzWbz/ojuc7MFacksYR0geECVYL8YvxFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X89RruJf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A3860A261D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X89RruJf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAFD1F008A3;
	Sat,  7 Nov 2026 10:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046621;
	bh=aTMosOuWcTHiRWa/qpZqDqn8MRkwBLncXHcKf1vokQw=;
	h=From:To:Cc:Subject:Date;
	b=X89RruJfA7KaAt+0yrdHZBVlp/qucfLRKcsUnV6ozUnhgt0nXKYyJvz5NPqndgJkr
	 BC5o4pr2xRWJTbh7Ye97wA++dXFrS4OvA2qMIjcoA2sPXXFAC+keVF3i5mTXJIzddb
	 wJOhVgdl+2z9SKuPQE0DjMdfyAzkmMaGzVodXbtLizZJd01Ug0ML356dqBUe7kfg2k
	 ikzvqy9rZvoiteiHvLyX13dxfMHatPjJ7BpPMlEBKzR4xSCnx4DUTzbJQdwsJCW7Tr
	 uscWz+4ne3uMCewbH6VbH9lxtfTxsqbgQS0mlM980KY3Ud8CU/uaMZEOsFC7CDLxTc
	 2Em4j5Qunf6nw==
From: Sasha Levin <sashal@kernel.org>
To: fabio.cesari@gmail.com,
	joshua.crofts1@gmail.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: light: isl29028: fix runtime PM reference leak on error paths" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:16:59 -0500
Message-ID: <20261107051659-failed-6.12-0e30d15b1564@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0e30d15b15647df786e60022650613e16dd70645
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051659-failed-6.12-0e30d15b1564@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0e30d15b15647df786e60022650613e16dd70645 Mon Sep 17 00:00:00 2001
From: Fabio Cesari <fabio.cesari@gmail.com>
Date: Thu, 10 Sep 2026 08:24:35 +0200
Subject: [PATCH] iio: light: isl29028: fix runtime PM reference leak on error
 paths

isl29028_read_raw() and isl29028_write_raw() take a runtime PM reference
with pm_runtime_resume_and_get() but return directly on their error
paths without dropping it. The usage count never balances again and the
device stops entering autosuspend for good. In isl29028_read_raw() this
needs a regmap access to fail; in isl29028_write_raw() one rejected
sysfs write is enough, for example

  echo 200 > in_proximity_sampling_frequency

which is outside the [1:100] range and returns -EINVAL with the
reference still held.

Take the reference with PM_RUNTIME_ACQUIRE_AUTOSUSPEND() instead, so it
is released on every return path.

This also stops the return value of pm_runtime_put_autosuspend() from
reaching userspace. That value only says whether the device could be
suspended right away, so -EAGAIN or -EPERM turns a successful access
into a failure, and with CONFIG_PM=n the stub returns -ENOSYS on every
access.

Fixes: 2db5054ac28d ("staging: iio: isl29028: add runtime power management support")
Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: LLM coccinelle
Signed-off-by: Fabio Cesari <fabio.cesari@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/isl29028.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 33deb1726689e..e481ac908fc13 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -342,8 +342,9 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 	struct device *dev = regmap_get_device(chip->regmap);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
 		return ret;
 
 	mutex_lock(&chip->lock);
@@ -392,14 +393,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 
 	mutex_unlock(&chip->lock);
 
-	if (ret < 0)
-		return ret;
-
-	ret = pm_runtime_put_autosuspend(dev);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return ret;
 }
 
 static int isl29028_read_raw(struct iio_dev *indio_dev,
@@ -408,10 +402,11 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 {
 	struct isl29028_chip *chip = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(chip->regmap);
-	int ret, pm_ret;
+	int ret;
 
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
 		return ret;
 
 	mutex_lock(&chip->lock);
@@ -461,18 +456,6 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 
 	mutex_unlock(&chip->lock);
 
-	if (ret < 0)
-		return ret;
-
-	/**
-	 * Preserve the ret variable if the call to
-	 * pm_runtime_put_autosuspend() is successful so the reading
-	 * (if applicable) is returned to user space.
-	 */
-	pm_ret = pm_runtime_put_autosuspend(dev);
-	if (pm_ret < 0)
-		return pm_ret;
-
 	return ret;
 }
 
-- 
2.53.0




