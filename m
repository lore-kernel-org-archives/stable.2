Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711062;
	b=B1LM3FfYkF+PIWH38Xx1pfGrAQ2T6VTZKuXdSzr78HJxWpHKsbTEdqSnCrLp4nyv6YWC
	 zRSR0scovoKx0SC7uHe/Mh8efDqj4bzSGNoJbRTHpiSkwAQYXA0eCj6B8CxsqNxMnAJ+M
	 wKSyNekQflmVwJpMk2tUAxiBuyAFRFJ1TZgPF1Lhu+DBSZ61rSzyozvBTCkoW3wwiX89U
	 Rb2v8tv6V6KvjHSdujxKeVav6ENTVdJDqOo4Ozrd1rjQMYwkijUSXC8fdZDXFx0liqwym
	 Qqp6iCh5RYIvMgkOMIx044iVzLtR6SmBgEFBGcA2iN3IUTTsmK66c9KaCup9x57z33A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711062;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8DhOvwuNfeg4u/9qEKzmwxVmKvVadK/QDEIdLLEsjqU=;
	b=m0cv46a2721eoeMFcrLhS4aP1/OkhSHAk0cgDG+3fJRuP6WOzMJ7exfhBAFVHeFgN9rx
	 Q7/Nx0aJ8q8hzVNJ/cNEL+CINEN5fzt5iMa7XXDLbemIjPlq4oqiJ5NKZbOksDEfaKbNe
	 c5D4dI0DXsmNFtQZoATg7zjAKLRW7MQk122rHz0doIr2VMn/+AvYWdkblw/E3klpF8rnN
	 jBLONxLJBRlM9+hTumO5l8E8X3rhOfmz02f36cnO9u/wgM6g14K8V6bjLsOTXjvh8rKOx
	 75KdwzaK4wavjJpVlM1fEvc1kodGGYYsm0jWW9WXoi+eZ0GuqX1d+gYuIiWMsAM1VDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GLq2Q+Mj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44194606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GLq2Q+Mj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A23D1F000E0;
	Thu, 26 Nov 2026 16:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711062;
	bh=8DhOvwuNfeg4u/9qEKzmwxVmKvVadK/QDEIdLLEsjqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GLq2Q+MjLhGsPFtCwcNM3PWSlLP8SqqHwlp4V2+GUojZGWcqPay+ptEdQBztdTS5b
	 zT61sn+g6WDyrYSGIiIAgK5qdhfv2sfgXUiGg5LwLETYUbNZHsOhP2th4BHUInDwVQ
	 eGOptdO0r60ShHqgO4WHfoW+68m/j3FBo/obvDDCY0QZSayOta2OpJUhs7hGG1wX85
	 bkiUvSRG4rABey5Kb+/GmZbtLuNBtusVg/w1/M04+pEtqxXA14p93bmjm52lvTG3/6
	 cdjBD3hxY9ftPoHTBHkxfCPhfaeJ8sOBepHEglZTYXTgkKLEXBbSW2wGWMaQkuIbqh
	 qc4BDFV+zCKBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	stable <stable@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] w1: w1_therm: lock the list of slaves for the bulk read
Date: Thu, 26 Nov 2026 11:37:39 -0500
Message-ID: <20261126163733.2621575-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112504-ember-cranial-3fdc@gregkh>
References: <2026112504-ember-cranial-3fdc@gregkh>
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

