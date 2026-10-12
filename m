Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6DB48D893
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819141; cv=none; b=hLES8OXVIVitg8+sE1yRb5WAMBhZ6ISWShq9DobBUMuiIgE+w3WQyJK0RWunuC4eIZ47AU6Ky2uokwiQYDNSvQepmWy7gH/ep1utGbfasvlO2U5jceiqOYboJQ/bLLKS3i6ZzJrIxem16jmamv/ECSfpRddy4c1lQFO2h2a6iO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819141; c=relaxed/simple;
	bh=L5jtRPjIsO+uDWSGlR0QEx6/z3qfOlXkxI/cawPz0PI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TtKhVe+7gzLSHSJVZcBvqSXCjkye00+LAh2q976rKKvdHs+yTGmPOw9MxO36n6IKBj+CkZPrSCKUsk8Oj3pN4NjcQOlwm84651LJre2FopjmfJYPWILcHaAN9/EeVvZr/qLEjr9v7XeU4eu/9z/a+iFWg4u+mhpOUm3DusLIdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ke/E1Zd3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ke/E1Zd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFAE1F0089B;
	Mon, 12 Oct 2026 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819139;
	bh=LubloEzAZKpzSSSIhIOcEgAYC78u0jgG6qxrbLvsbNs=;
	h=Subject:To:Cc:From:Date;
	b=Ke/E1Zd3DTKccoQeSAeE11WxYdsW83aPbbLboOh/nNvNsL2UKv+pL9NDevYiG99bz
	 BmUgLHtVmfUuHyfm9qwtyg3iKSz9idXVkiR4gG9nc6zNbAGKZSO9oyY7bdkm7d3U8Q
	 iqmQivNpqUi/w2ZONOTltO2TG/EMr70uOvYhVW1k=
Subject: FAILED: patch "[PATCH] drm/xe/i2c: cancel the client work on remove" failed to apply to 6.18-stable tree
To: fanwu01@zju.edu.cn,heikki.krogerus@linux.intel.com,rodrigo.vivi@intel.com,songl@zju.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:31:17 +0200
Message-ID: <2026101217-clumsily-geology-fe31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 611857adc9e7b0ee1239a0baf38498922ca5a12e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101217-clumsily-geology-fe31@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 611857adc9e7b0ee1239a0baf38498922ca5a12e Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Mon, 5 Oct 2026 20:04:14 -0400
Subject: [PATCH] drm/xe/i2c: cancel the client work on remove

xe_i2c_notifier() stores the DesignWare adapter in i2c->adapter and
schedules i2c->work when the adapter is registered under the xe I2C
platform device, and xe_i2c_client_work() then instantiates the AMC
client device on that adapter.

xe_i2c_remove() tears down the AMC, unregisters the client devices,
the bus notifier and the adapter platform device, but it never drains
i2c->work. A work item that is still queued or running when the
adapter is unregistered dereferences i2c->adapter in
i2c_new_client_device() after platform_device_unregister() has
released the adapter. The work item is also embedded in the
devm-allocated struct xe_i2c, so a work item still queued after the
drm device devm unwind frees that allocation runs its callback on
freed memory.

The bus notifier is the only thing that schedules this work, and it is
unregistered after the client devices. An instance that is still queued
when the teardown runs can therefore write
i2c->client[XE_I2C_CLIENT_AMC] while the loop is unregistering and
clearing the same array, and an AMC client it instantiates late is only
cleaned up by the adapter's own child sweep in i2c_del_adapter().

Move bus_unregister_notifier() in front of the client teardown loop
and cancel the work right after it, so no new instance can be
scheduled and a queued instance is drained before the client array is
touched. A running instance still finds a live adapter, since the
adapter is unregistered later.

Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
Link: https://lore.kernel.org/intel-xe/20260912085932.101598-1-fanwu01@zju.edu.cn/
Cc: stable@vger.kernel.org
Assisted-by: LLM, in-house static analysis tool
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260928013030.612592-1-fanwu01@zju.edu.cn
Link: https://patch.msgid.link/20261006000413.318561-2-rodrigo.vivi@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit a23f27d5ec11c3f418c5e5531eea34ccda2b5b20)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index f4f381988289..b82caaff80d7 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -324,12 +324,15 @@ static void xe_i2c_remove(void *data)
 	xe_i2c_irq_reset(xe);
 	xe_amc_exit(i2c);
 
+	/* Stop the notifier from arming the client work before teardown. */
+	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
+	cancel_work_sync(&i2c->work);
+
 	for (i = 0; i < XE_I2C_MAX_CLIENTS; i++) {
 		i2c_unregister_device(i2c->client[i]);
 		i2c->client[i] = NULL;
 	}
 
-	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
 	xe_i2c_unregister_adapter(i2c);
 	xe->i2c = NULL;
 }

