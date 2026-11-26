Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710086;
	b=uNQjWy8UB4oYHRqBG6858h1jwXhTUeP8e95odPHkKK6//nZkWvxrcl5GNFLT4S5TDvqt
	 amZexqqX5IN1rHC4xXuMIU38HmSLrXrTR7MyAv4VSMVZSfJ21chOtmE4jcXxZYL6itfyx
	 fZDWwaUUeHP5Z8TEQs5Mp56RJ1+vJpePWG7gqZxVe6sUsThW1bk3ihtJyRoekBFjV40Fw
	 yZX2xCBarl8cUFmG+YghNgP1kF741MuDBhXDBq7TNsDCFnd4mdK1FLXLZB1RBaUywPbNG
	 EyhaM6NME/FyMqI0bVGAmTHt6lsNNJCT/WVUVSE3QakEOROaxOm3VjVKb8lFq5KCTpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710086;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IK9cYHpK2pusQF+HEfIqkWs53MaC4PH6Nrl0yNDg0Qw=;
	b=Blu9zJest9t5yhG7iaw3eH3ds8LI0pSaqRfrlLEZMPSzDIkFa8tM2qXFow9cc5dx2vep
	 sMcnmPN37O+INhMKEHLjH+DkaL57muiut13tyYnYJMWHxlaouOvg5PNflDDLrDUODNHjj
	 0X+9Ki9Kg71VHl4SZekoQE023nw1eY+NpuPBLbgXykw9N9MLCHlVyhQDjL2oCi+xM7x+b
	 LNyuBl9ulNfJvXbAbL+u2MTZL5zxiSLYEYGQI/skIH2tFezzYLi+MaqpaGo/HbzQxim1n
	 tBOsroxdm+E9nd7FWbas1OdQabVct8UYgnhqhy6Ei8qEDThgzgXnyXFODAGCiIdpnXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhnTH8AT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC20606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhnTH8AT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624941F000C0;
	Thu, 26 Nov 2026 16:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710086;
	bh=IK9cYHpK2pusQF+HEfIqkWs53MaC4PH6Nrl0yNDg0Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hhnTH8ATurRfSoBZtfk/LjIhZyeN7wvxj37xOJJeOsWGBJ3PGqnbsg2LT14Bk6wXo
	 WJlWc05s+fuMW5tk77FQV86oOc1F1uy1FB0kekH6slHi3Ypt2eeoAATpr8uqolH0Qc
	 LhiFavDv68V7CMK5Q34f5RtBTV3KQCILYXxEForZeIs2KhmSzMCtHf7p32X50olomf
	 qyOEArQQo1T00RY/8501FipS2VcAOHN11kFms/SmDO0kCwBF0v9u1tCEBbholiI5/c
	 OY6BcDehpgxR4r9mRA4Px21j3nNg/hIbTY9//uNs1u5Oql7yy/qvXdUDxcCWmYg4Ig
	 5L/QTkNN2By/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	stable <stable@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] w1: w1_therm: lock the list of slaves for the bulk read
Date: Thu, 26 Nov 2026 11:21:24 -0500
Message-ID: <20261126162115.2574779-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112503-barrel-retying-eaa2@gregkh>
References: <2026112503-barrel-retying-eaa2@gregkh>
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

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 1e46334d38e0217f5d255dc6fd63243593052f8e ]

The callbacks of the file therm_bulk_read walk the list of the slaves of
the master, trigger_bulk_read() three times and therm_bulk_read_show()
once, without the list_mutex which protects it.  In the meantime the
thread of the master may find out that a sensor has gone:

  write to therm_bulk_read              w1_process()
  trigger_bulk_read()                     w1_slave_detach()
    list_for_each_entry(sl, ...)            w1_unref_slave()
      bulk_read_slave(sl)                     list_del()
                                              w1_therm_remove_slave()
                                                kfree(sl->family_data)
                                              kfree(sl)
      SLAVE_CONVERT_TRIGGERED(sl) = 1

The walk reads, and writes to, memory which has been freed, and follows
the poisoned list pointers.

Take list_mutex around each of the four walks.  No pointer to a slave is
kept from one walk to the next.

This could not be done as long as w1_unref_slave() held the mutex while
it waited, in w1_therm_remove_slave(), for these very callbacks and for
the readers of the sensor, who need the bus_mutex which
trigger_bulk_read() holds around its second walk.  Now nothing is waited
for with list_mutex held, and none of the other mutexes of the subsystem
is taken under it, so it can be nested inside bus_mutex.

Fixes: 57c76221d5af ("w1_therm: adding bulk read support to trigger multiple conversion on bus")
Cc: stable <stable@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20261027-llm-char-misc-w1-v1-8-d2e6bfafb6a4@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/w1/slaves/w1_therm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 8e0e6f122b08c..f06f87bf976da 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1509,6 +1509,7 @@ static int trigger_bulk_read(struct w1_master *dev_master)
 	 * and compute duration of conversion for these devices
 	 * so we can apply a strong pullup if required
 	 */
+	mutex_lock(&dev_master->list_mutex);
 	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
 		if (bulk_read_slave(sl)) {
 			int t_cur = conversion_time(sl);
@@ -1520,6 +1521,7 @@ static int trigger_bulk_read(struct w1_master *dev_master)
 					w1_strong_pullup));
 		}
 	}
+	mutex_unlock(&dev_master->list_mutex);
 
 	/*
 	 * t_conv is the max conversion time required on the bus
@@ -1546,11 +1548,13 @@ static int trigger_bulk_read(struct w1_master *dev_master)
 			w1_write_8(dev_master, W1_CONVERT_TEMP);
 
 			/* set a flag to instruct that converT pending */
+			mutex_lock(&dev_master->list_mutex);
 			list_for_each_entry(sl,
 				&dev_master->slist, w1_slave_entry) {
 				if (bulk_read_slave(sl))
 					SLAVE_CONVERT_TRIGGERED(sl) = -1;
 			}
+			mutex_unlock(&dev_master->list_mutex);
 
 			if (strong_pullup) { /* some device need pullup */
 				sleep_rem = msleep_interruptible(t_conv);
@@ -1576,10 +1580,12 @@ static int trigger_bulk_read(struct w1_master *dev_master)
 	mutex_unlock(&dev_master->bus_mutex);
 set_flag:
 	/* set a flag to register convsersion is done */
+	mutex_lock(&dev_master->list_mutex);
 	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
 		if (bulk_read_slave(sl))
 			SLAVE_CONVERT_TRIGGERED(sl) = 1;
 	}
+	mutex_unlock(&dev_master->list_mutex);
 error:
 	return ret;
 }
@@ -1944,6 +1950,7 @@ static ssize_t therm_bulk_read_show(struct device *device,
 	struct w1_slave *sl = NULL;
 	int ret = 0;
 
+	mutex_lock(&dev_master->list_mutex);
 	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
 		if (bulk_read_slave(sl)) {
 			if (SLAVE_CONVERT_TRIGGERED(sl) == -1) {
@@ -1956,6 +1963,7 @@ static ssize_t therm_bulk_read_show(struct device *device,
 		}
 	}
 show_result:
+	mutex_unlock(&dev_master->list_mutex);
 	return sprintf(buf, "%d\n", ret);
 }
 
-- 
2.53.0

