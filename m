Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711879;
	b=rPjPY5JWHGo0NGmvNBFnOrFXsixP0h0vYjwKS+YXBVZlXWPeXTxzsu6Agsgen9hr7k3u
	 oDsYnAK88eZTrip1Y4BMV7oFSw1fn+2LOSQ19p+rVjYTA500QoLwaK/uXokwndES+AW/p
	 GPnsRANQp6yTazohqgKhLHlxR+Ro/TDrdyc0DZm4bxmpGz/JChLOtve+vPzpyETrH6xJf
	 JrZGomNTArgl+Wwp/aRJzeP1QnyQtCHy2r/+6rV8ZxntY9qsPuPfbN3aVPuS1KSJkWQni
	 3Vn639Wdj+fadkZq+o0718K6MiqwEqNqurItftNwBwIVKpd2lZgQkvw6X2IqDi6Hclg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711879;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R5bEUT11WpL3ym+xneG0lQ2d8KCDMs8XcSYZA7AdmTM=;
	b=wsHfxdWDATr9x0eU44OxCq5ZnVT8aCQUyBpXpliEEYyXgel56TRdUJXUvhCW0747xoBb
	 Q+HEign3n7r5UtugII3UQ4mKo1MfY8Ulju762vGprj6t9gyKXobMQLH/D/nGgxWnvQdSL
	 rh7wHuiaJ2NflQ6qI/RVpNUpV1cKVkgVUdJQ8X5Cm39op/IzYlqeWQbRd0ID0uEcwIPqr
	 Ghzl5mgAwnLZMRzeunuxARryx/99GV97yFHO3LpvC2HRpWFzH4a8jQedzEATolc68fwtl
	 YVMezpHJZyk6+03t6nnhD1F6VODtsgWr4tJ9pZKV0atzvOKZHq3FEBB1Wu3OErW4PYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c7s7MZD+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C92C606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c7s7MZD+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387311F000D0;
	Thu, 26 Nov 2026 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711878;
	bh=R5bEUT11WpL3ym+xneG0lQ2d8KCDMs8XcSYZA7AdmTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c7s7MZD+mZpvcgRP7qeO+bqhfsPJ/eydYxHwmqAcASxUUZsheIMEM27mBnNkpD+H4
	 cOlvae46Ana7BC4hOh6jjU4Dqw5WvYbOVi0+Mfc/DF154vi7Jjja5vNq2HZpNMFA3k
	 FVdxZvEA3OzxqUoO/gpce8DSvBQczJWFJ0fcChr3wypCmyA+uVk/Wq0kZ0z8Q+1hKM
	 uBORq+lPy6PksyB1BZdou/wQX+pLfu7MZeUPIVHiS0o5x2KzHgCsaEneCn4Hst4yel
	 9d6sV6AIYxOlUdBxgCg/z2M7h7DiYehgoErYVxKZf8v9Jz6pBAmC/WjwFVxzjFheh8
	 mQlKVdh+zfakQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	stable <stable@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] w1: w1_therm: lock the list of slaves for the bulk read
Date: Thu, 26 Nov 2026 11:51:16 -0500
Message-ID: <20261126165109.2654467-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112506-level-cogwheel-41b2@gregkh>
References: <2026112506-level-cogwheel-41b2@gregkh>
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
index 71ca4a48f96d7..5ad65346d6f33 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1454,6 +1454,7 @@ static int trigger_bulk_read(struct w1_master *dev_master)
 	 * and compute duration of conversion for these devices
 	 * so we can apply a strong pullup if required
 	 */
+	mutex_lock(&dev_master->list_mutex);
 	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
 		if (bulk_read_slave(sl)) {
 			int t_cur = conversion_time(sl);
@@ -1465,6 +1466,7 @@ static int trigger_bulk_read(struct w1_master *dev_master)
 					w1_strong_pullup));
 		}
 	}
+	mutex_unlock(&dev_master->list_mutex);
 
 	/*
 	 * t_conv is the max conversion time required on the bus
@@ -1491,11 +1493,13 @@ static int trigger_bulk_read(struct w1_master *dev_master)
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
@@ -1521,10 +1525,12 @@ static int trigger_bulk_read(struct w1_master *dev_master)
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
@@ -1889,6 +1895,7 @@ static ssize_t therm_bulk_read_show(struct device *device,
 	struct w1_slave *sl = NULL;
 	int ret = 0;
 
+	mutex_lock(&dev_master->list_mutex);
 	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
 		if (bulk_read_slave(sl)) {
 			if (SLAVE_CONVERT_TRIGGERED(sl) == -1) {
@@ -1901,6 +1908,7 @@ static ssize_t therm_bulk_read_show(struct device *device,
 		}
 	}
 show_result:
+	mutex_unlock(&dev_master->list_mutex);
 	return sprintf(buf, "%d\n", ret);
 }
 
-- 
2.53.0

