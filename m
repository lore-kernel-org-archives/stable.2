Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710517;
	b=UQCoLlFZQBcTOlVU4fadIqe4uaq9dgtaTcvjEa3kTab8HbG9q1BZ27CsZ/xvLka/buGj
	 M7YBBf+rCZq8PftmYD+D1GFnddJYg4EG1irmtzpaprtrIDlb52+LgY8h4ur0cDoWjjuT1
	 P5i6sZrlklSPNVL09c/lOqod+qSHxXGzg7nZYgpTddMFsZa8nCzLcwHXoJsbYaBMw6Hh7
	 k1BF8Z97qbJNtMLkPCxP5ddfx4AROy+mUDWfUp2+7HwKLFemD0SKp//+XdAOhzcrzVjVm
	 J6ebrUkVbnqlh5jZk/tT8f9GeqCzStaOOT+OEE1nEtuPORZq/ZtPusYFmeRL1ExtzAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710517;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8DhOvwuNfeg4u/9qEKzmwxVmKvVadK/QDEIdLLEsjqU=;
	b=MseOb0l0/xfrJcKWFc637kAedT/7tuKV6Qx+bOCqTQBEuiEY305LZ/wfcVMaO4a6ullB
	 HxTVGbTKP4RDrms4DC78WD5lM1Ze7cj3XaN+cKhd1fWWA7WdE09WL7a6BJqEhdtoRu8QE
	 il7RBxZfKma3EYcpj75gCA0bDBxJ5hO/2ZlhE4k4dcEgNi+9SU/oajyUkVesWlva2rcu2
	 Le9sPRVJX/OlkHYkFIaGgQrhi3DbJ55x94CoRzs5Yo/j+vVK8SMokJjAefNhq07tjm5iN
	 lPsG91RtnU2NE79p1VD37bXclLKNIbrU2YQZgj+X/972JBUkZ/YUXMrqmLTAkni1HGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vce8HF2v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB9F606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vce8HF2v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEC51F000C4;
	Thu, 26 Nov 2026 16:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710517;
	bh=8DhOvwuNfeg4u/9qEKzmwxVmKvVadK/QDEIdLLEsjqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vce8HF2vsdJ1JvTSCvIisouWjkg/tC/8NFqU8EZH4ohjm7nl4LGdsyMUM9ir6cbpP
	 8+pYfxv7zWfVmg+RLKSfDUcLSl32ZP4IKogXa5SJou26J8Te/A1q3S36/18YIhQk1X
	 rp373rkp215DV2jka3cdeXYWmATZPIz3weKgnpeRQ2636IDoQmMwaZ2Z+Yl5zR5F2E
	 Qsf81vDPS53dkqZ1pbdtBR1v64bDOCLH+opmYmVmPoi9SUbQ4rLXrtqpl/xS4C/uJm
	 6p+hOmOL1F9kAUM4PfJwdH1J1J0JtohhthCF8NiDFuKQyPW77I7BsJmN/9jtkPGrNd
	 HwtXVRIY64YDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	stable <stable@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] w1: w1_therm: lock the list of slaves for the bulk read
Date: Thu, 26 Nov 2026 11:28:35 -0500
Message-ID: <20261126162827.2594628-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112504-skyrocket-unknowing-75e3@gregkh>
References: <2026112504-skyrocket-unknowing-75e3@gregkh>
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
index 361067390b714..58ba8a41dc7e8 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1519,6 +1519,7 @@ static int trigger_bulk_read(struct w1_master *dev_master)
 	 * and compute duration of conversion for these devices
 	 * so we can apply a strong pullup if required
 	 */
+	mutex_lock(&dev_master->list_mutex);
 	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
 		if (bulk_read_slave(sl)) {
 			int t_cur = conversion_time(sl);
@@ -1530,6 +1531,7 @@ static int trigger_bulk_read(struct w1_master *dev_master)
 					w1_strong_pullup));
 		}
 	}
+	mutex_unlock(&dev_master->list_mutex);
 
 	/*
 	 * t_conv is the max conversion time required on the bus
@@ -1556,11 +1558,13 @@ static int trigger_bulk_read(struct w1_master *dev_master)
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
@@ -1586,10 +1590,12 @@ static int trigger_bulk_read(struct w1_master *dev_master)
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
@@ -1954,6 +1960,7 @@ static ssize_t therm_bulk_read_show(struct device *device,
 	struct w1_slave *sl = NULL;
 	int ret = 0;
 
+	mutex_lock(&dev_master->list_mutex);
 	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
 		if (bulk_read_slave(sl)) {
 			if (SLAVE_CONVERT_TRIGGERED(sl) == -1) {
@@ -1966,6 +1973,7 @@ static ssize_t therm_bulk_read_show(struct device *device,
 		}
 	}
 show_result:
+	mutex_unlock(&dev_master->list_mutex);
 	return sprintf(buf, "%d\n", ret);
 }
 
-- 
2.53.0

