Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608470;
	b=tJ1ocmC2p2Ytqyeol307j/pUGUH8pfObMgwKz2ID4lWz75EplDYhfP0qbSpc20pxXOCd
	 qMxdgJq61j8ZnX2ENKE8J9/yTpA/iPkJcr26KkWQsQ7uoFrSj0eNpQ847w5XIXa6izmRY
	 CAehmvcBvKnUcew+BIIThfDEv78yrx5buRnPjcQJ9hNn/fVNAOWX4thPcn10CBWu/qC+i
	 TPdGZl9Ply0MiSEAdY+7IUk1DT2aUL7ZYSfL6zCTFPyoDI170u2FXTSp8C7ziU94h7pxM
	 GrulnrXKlceHE9eEtQfWtpsBFbpomXN7PWZR7G6Uc84AJCvXxUWe3H1aqKcuK9Ms0ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608470;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VoSs5fV0n5yr4HXWOm74PFOAkc6dhsC5iGlPwAaZ+EQ=;
	b=fja2VS4qjNepRXTtY5kCKTZb0WVnvI1ExPzoQSv0xmeAW29TNW9lizp/RbQMZPDfw3/c
	 uFsxhW6zkdHvOCz+OdND9m+oK5Mkf3IbE3bmWXeFNxxo50Ejx5rB9+miootWDyoif4V/r
	 D089hU00Dxjmz4GEgLiHmi7G6kGyWd5ZC6e3Si+S6W4olY8RluhPvintlA/GUSjdGl8aa
	 /BMNnQcLsXxZGVT4oV8WGofi0IvKV7lnhaKg5wzQtcfk7z+87vShlbzLd4SU7YY9l+Bnb
	 V5Apt+QW5s7i7CHsWqZVHwp52/1rVHMiEiWwREN7pH6lTlpf5nQv6Q6vXd7XJaMnZxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NhThSJaJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A7F606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NhThSJaJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A161F000C6;
	Wed, 25 Nov 2026 12:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608470;
	bh=VoSs5fV0n5yr4HXWOm74PFOAkc6dhsC5iGlPwAaZ+EQ=;
	h=Subject:To:Cc:From:Date;
	b=NhThSJaJ933x1cWmL7FYJH3U/xETaVIIJkUOqqhFjmzxUNJr7s62SvId4cjibkkpY
	 b6Qx6HjIPN8U9eQRv0VfvjsQ+dOhIHTBQAQn/Tk4B8idFFq+QaRDWRjgKFE5vQSSRf
	 r935bNRymJeLuHHE3+EgwWjMaRdlJVySrri3Wuow=
Subject: FAILED: patch "[PATCH] w1: w1_therm: lock the list of slaves for the bulk read" failed to apply to 6.12-stable tree
To: josef@toxicpanda.com,gregkh@linuxfoundation.org,krzysztof.kozlowski@oss.qualcomm.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:44:04 +0100
Message-ID: <2026112504-skyrocket-unknowing-75e3@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1e46334d38e0217f5d255dc6fd63243593052f8e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112504-skyrocket-unknowing-75e3@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1e46334d38e0217f5d255dc6fd63243593052f8e Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 27 Oct 2026 17:04:41 +0100
Subject: [PATCH] w1: w1_therm: lock the list of slaves for the bulk read

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

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index d96b224e2215..6db0b534b338 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1495,6 +1495,7 @@ static int trigger_bulk_read(struct w1_master *dev_master)
 	 * and compute duration of conversion for these devices
 	 * so we can apply a strong pullup if required
 	 */
+	mutex_lock(&dev_master->list_mutex);
 	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
 		if (!sl->family_data)
 			goto error;
@@ -1508,6 +1509,7 @@ static int trigger_bulk_read(struct w1_master *dev_master)
 					w1_strong_pullup));
 		}
 	}
+	mutex_unlock(&dev_master->list_mutex);
 
 	/*
 	 * t_conv is the max conversion time required on the bus
@@ -1534,11 +1536,13 @@ static int trigger_bulk_read(struct w1_master *dev_master)
 			w1_write_8(dev_master, W1_CONVERT_TEMP);
 
 			/* set a flag to instruct that converT pending */
+			mutex_lock(&dev_master->list_mutex);
 			list_for_each_entry(sl,
 				&dev_master->slist, w1_slave_entry) {
 				if (bulk_read_support(sl))
 					SLAVE_CONVERT_TRIGGERED(sl) = -1;
 			}
+			mutex_unlock(&dev_master->list_mutex);
 
 			if (strong_pullup) { /* some device need pullup */
 				sleep_rem = msleep_interruptible(t_conv);
@@ -1564,10 +1568,12 @@ static int trigger_bulk_read(struct w1_master *dev_master)
 	mutex_unlock(&dev_master->bus_mutex);
 set_flag:
 	/* set a flag to register convsersion is done */
+	mutex_lock(&dev_master->list_mutex);
 	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
 		if (bulk_read_support(sl))
 			SLAVE_CONVERT_TRIGGERED(sl) = 1;
 	}
+	mutex_unlock(&dev_master->list_mutex);
 error:
 	return ret;
 }
@@ -1932,6 +1938,7 @@ static ssize_t therm_bulk_read_show(struct device *device,
 	struct w1_slave *sl = NULL;
 	int ret = 0;
 
+	mutex_lock(&dev_master->list_mutex);
 	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
 		if (sl->family_data) {
 			if (bulk_read_support(sl)) {
@@ -1946,6 +1953,7 @@ static ssize_t therm_bulk_read_show(struct device *device,
 		}
 	}
 show_result:
+	mutex_unlock(&dev_master->list_mutex);
 	return sprintf(buf, "%d\n", ret);
 }
 

