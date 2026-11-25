Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608464;
	b=TVY4qqgTJAwAMxdJuAjptqQSLMC7YukGy36fPLej5isoepdkyBxlAzIj1nh+KzgbBsoQ
	 XKsvo2Eu+8ZwLijQPotL0ZFtjo0LRkIS3R0gJ9RBFYxxZICvrswKFvDUE2CXabFlgwth+
	 t6hKHZmndtDAY10k1Em2zpknMSdjNrwzp1OSNSjdCuRKwuJxTNmk9jOsSvkB3t92rbMql
	 8N7O4go9IZJ7gSOAnG9ROrlFErizxMe5d0CQsYpadk9y+5vj1A/jzVWVqZxMlf+sQWnYZ
	 7lzgmalOIzgZ4GdP+gyH9/S7FUJGy2q9EeZ4QPigAx0Sjq67eolh7Q/4flq5WRXbDMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608464;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=N4l8U0W9TpnAC9Re/B9nwDilPCJ0mdyPRshOFJ2bIIM=;
	b=5RwwgALIuP0746t4pPD59c+MluJoYl63KRiQLRzMT21eziVtaMwtjJVfI8G+fKjRwC4r
	 cM9OXwQoTjUr+/FWuIYJry/jj8Ra9g36qXDWrfyhUGkNVwuQasMWfFInjqTNiy1cMYZWd
	 pdWTUaWAkTaXhgeM+Lje6Lds/jK3FEG3jxjp5odopZGF5ldzRMIsZzMlcBd5bw72ttKNN
	 RHTrhrPQYMR29WACwnleZczhfnGazjEMKOgBcax4vGyUboOFOVUfIUlUwKonQZpLZ62JV
	 l9yIq/imUl9q738PpZWOObMZJnGDpWpFH8nYbMHvHSjFuxyBeOGkLhpCTYrxZNu0EYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fQ2WC+oK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86394606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fQ2WC+oK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61381F000CF;
	Wed, 25 Nov 2026 12:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608464;
	bh=N4l8U0W9TpnAC9Re/B9nwDilPCJ0mdyPRshOFJ2bIIM=;
	h=Subject:To:Cc:From:Date;
	b=fQ2WC+oKOkC304EwdZR2dW4Im/LitfWsin8m3F/dzNlLw/O8MPamAfoaH6mR620rf
	 Xozm2LCJBj5zaF8zJEf6rlo6WpayMLUT7OwA0cLwSCBN7A81kEKsCnomCNVeyv0JsT
	 EPQ5yVLZpYzWdJ5V/TxixFqfS9TSVK2xdQLjLSgo=
Subject: FAILED: patch "[PATCH] w1: w1_therm: lock the list of slaves for the bulk read" failed to apply to 7.3-stable tree
To: josef@toxicpanda.com,gregkh@linuxfoundation.org,krzysztof.kozlowski@oss.qualcomm.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:44:03 +0100
Message-ID: <2026112503-hurdle-skirt-de53@gregkh>
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


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 1e46334d38e0217f5d255dc6fd63243593052f8e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112503-hurdle-skirt-de53@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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
 

