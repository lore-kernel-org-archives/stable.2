Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711376;
	b=3buivMUBI9XIwmrgKdLj9qH3CLS17P5UkjzP1VqLRBs8UBCIBOMfelO+lwVV5r8OA/2v
	 i2n7cQ7F9dy5tpSQQ+my2mWl93qIqrhLzNn0vgmS2n9sFYwZcrUqJADhdnGKYttKx8H5g
	 GNdDb2tcM2slmDCLDDMXVrOLMLKDKha40BXSZbJ0znW9dRo0WJ+QzUm7kW5/gG26882Y2
	 XIvNfcVFdVBxh9G8hoYjMhBLddWwhFwyHHp47vGuylbqLCW7kAGfZubcOc4KACpf1t6Ke
	 5hRL/TQB1UpjhQMesrIAOhXw479zHCzkbM0DQIy9uJJzRy0/JkqtEDDBnVG7VfiaQ2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711376;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Cc/+Uov7Ahtk1PZ4JQRnL0SwI6NBJ0Zwr1q009bMdVc=;
	b=YG3yfjSEJuBI3fuzfTtli74zyqZnDFBLLLFxRHWCdP05qpZDH9/LjZhK9sonFaR+T298
	 C3cWse+rglrZBiFoOJwxvJBzXD6HAAGd4CS2FBguh3Wq6qaUKOmHJ5VY2LMj+YaH0m5W1
	 9qUabvC8Kb/yTYcjktqgA5LEzvmCX3IMqmqGQ/BGuVRYLcX3/0Fqmk2XaPn8YRNYztP7y
	 5zc25AcAM6emRq2TQlu5rjrRWWvyQzI2pryB+bYXwma8le3URJofzimamFFqyzGfrq4NL
	 QMD8EBlzECUhoYMzgBERCt5iKwO53NMkHKTUy84/QaLjxEg1PRDS4WkfSwGxrQcDqjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CX1iMdlw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8F2606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CX1iMdlw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B241F000C0;
	Thu, 26 Nov 2026 16:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711375;
	bh=Cc/+Uov7Ahtk1PZ4JQRnL0SwI6NBJ0Zwr1q009bMdVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CX1iMdlwkKeqWNj+9FxUFdPVlKsHkPMJzjCEXbkqF6m9wYlVEYPGZD4oqZM5sEMMg
	 /J4JQOIPwAoNlURn0CDPdbPo3GnI8aM0NJYfAzhEjrEfZb95BNTQixOMvBn4KmumKt
	 VEztXtYdwrLsbl4Py/MMEis7t97ROUbvD6jk6P+qZV51kFy0L8dAWw0ouKezLBpR1I
	 gkWMa6OpnA/GUAoK5k28mT57ls8A87jTvUz36wGYYjb+0sC4Vc+R81GFaFwHAsovNI
	 kwwvWh2X9uLLmxpcTMel0yv3T2BcJqOiww0LsoZB6inWUShBhZF87ay8boVUjjtryj
	 FYDXbPPkYaoLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	stable <stable@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] w1: w1_therm: lock the list of slaves for the bulk read
Date: Thu, 26 Nov 2026 11:42:53 -0500
Message-ID: <20261126164246.2646299-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112505-kitchen-stoplight-351a@gregkh>
References: <2026112505-kitchen-stoplight-351a@gregkh>
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
index 7d82f75d40083..e09f8baa94b12 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1453,6 +1453,7 @@ static int trigger_bulk_read(struct w1_master *dev_master)
 	 * and compute duration of conversion for these devices
 	 * so we can apply a strong pullup if required
 	 */
+	mutex_lock(&dev_master->list_mutex);
 	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
 		if (bulk_read_slave(sl)) {
 			int t_cur = conversion_time(sl);
@@ -1464,6 +1465,7 @@ static int trigger_bulk_read(struct w1_master *dev_master)
 					w1_strong_pullup));
 		}
 	}
+	mutex_unlock(&dev_master->list_mutex);
 
 	/*
 	 * t_conv is the max conversion time required on the bus
@@ -1490,11 +1492,13 @@ static int trigger_bulk_read(struct w1_master *dev_master)
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
@@ -1520,10 +1524,12 @@ static int trigger_bulk_read(struct w1_master *dev_master)
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
@@ -1888,6 +1894,7 @@ static ssize_t therm_bulk_read_show(struct device *device,
 	struct w1_slave *sl = NULL;
 	int ret = 0;
 
+	mutex_lock(&dev_master->list_mutex);
 	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
 		if (bulk_read_slave(sl)) {
 			if (SLAVE_CONVERT_TRIGGERED(sl) == -1) {
@@ -1900,6 +1907,7 @@ static ssize_t therm_bulk_read_show(struct device *device,
 		}
 	}
 show_result:
+	mutex_unlock(&dev_master->list_mutex);
 	return sprintf(buf, "%d\n", ret);
 }
 
-- 
2.53.0

