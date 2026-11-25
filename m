Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608467;
	b=yHb8gAMDC6qJgoSelFyKOhiDgdDE+HAjCfmA5N+vNyA4N11pOa98e4TywVdVFNuVpESB
	 StJqJ7lh3grGyrM/0cf242Fu2IZJlWaSvQvsZh+RG8CW5wV/RMuvdTlwgUzQXM0dUfKxZ
	 XVg51EoCxOLtpg8INKxX2cUhciuNxUILCJVhV3YGGydCXuQoPzqDvQuuiP5WeX8XhCgCA
	 EFnevuKGKbsyzDcG270giZznOFjF13yuVE6Qor1QE0nwD7HWxpkKmfpWDe/TDZYGqBOh9
	 +E9VxqPgpSq8k2HUEZttpYgJ45eZ2rznAiBfRieL7na9LinsfyD4ym7DJaYAdZ5qMNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608467;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iGSHGPxe/YqTsXetoU+kpltuV3/IAdLqyGd6ojJUvCI=;
	b=QSW529hUxK3QfwZQVQ+GqUw/NiNBik0sobN4EJXygRt7FAthkt8OgJXbMKA6bS52TGgb
	 AUxAZmcu/rMA8AA+xiVt/L2tg+WAzZ4R80TxGx3AeOESMKc8hFOdK5Fd6Uu/eV3axWr+8
	 jZNC69++GbmK6SqLghhTJ40I/bYlpyCv18GhBfX865a6Lyrq8j0ESAH6cRZC0FRxUF2Wb
	 fH3r0Bz+yHF6rdYfh7HzSYlUQppyMKy+3nuv/uvFbWl0ywOsPDd+l/b/uAEIUT23LRJDj
	 /7xFAmHPRjxYA94ZMEZrDjjkEhKMU+l2fh91ExDcMiYTLNauxuLCnpRnHyxVMjf7C+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VJVXmHLc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19F606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VJVXmHLc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC2B1F000C0;
	Wed, 25 Nov 2026 12:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608467;
	bh=iGSHGPxe/YqTsXetoU+kpltuV3/IAdLqyGd6ojJUvCI=;
	h=Subject:To:Cc:From:Date;
	b=VJVXmHLcr07XFx5m8eg9CGHZPumY5YS6m8Jgwk6wTyhl1MQ3PULo2561w/CEEDLFI
	 cBaIeJDnt6rXtBBZZz8h2V3hPlJu9zjYoFCsLO0jmUEsFDo7//BSdGA/+8j1+Om93a
	 oe6BfZlaDWDXgFlDRPUqz/ZGYtfhSmkilLjd3DW0=
Subject: FAILED: patch "[PATCH] w1: w1_therm: lock the list of slaves for the bulk read" failed to apply to 6.6-stable tree
To: josef@toxicpanda.com,gregkh@linuxfoundation.org,krzysztof.kozlowski@oss.qualcomm.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:44:04 +0100
Message-ID: <2026112504-ember-cranial-3fdc@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1e46334d38e0217f5d255dc6fd63243593052f8e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112504-ember-cranial-3fdc@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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
 

