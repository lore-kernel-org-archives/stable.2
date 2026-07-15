Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF4E43FD3C
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111262; cv=none; b=jXc2ud+CP4cyPb0WomnorraOE33wGkeQJbztfgqgIBrfIesRCuiH0jlC8cUnMdmQdhrc9tvtxXo18T0CoK4rvsZy5lRuQoLwqTagT4yM1ect5yKALTj3uPnH7fLQN+H6VysmlVD4/yQ70Z6pquxLNB1sPKt7jvWDPBUzFxMJekA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111262; c=relaxed/simple;
	bh=OVjlheHjjOHpoVmOZt0fCpgp2cj2W35gwkCUk+L9yUU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W55XKKyfC+/M+jrrXwyC88vIZ/qhgxTqPhWFPc53W8DXrJHwrCX2K/XJeZ7+JF3++ta/VmFL2ePCRwC8z9ZOru/NFJyw60MT7DPoSEMH7oH2Ndei79xtoNemfaObfppF2QYn3qfFnV/cxxskkXbkJW0O+YBeQ/jlooMpoEAjMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XTowxR+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XTowxR+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2FC1F00A3A;
	Wed, 15 Jul 2026 10:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784111260;
	bh=VB8o1u3tIGPvde9XYX38b/OJOpcFQ4p2NsxZ5BIA5gE=;
	h=Subject:To:Cc:From:Date;
	b=XTowxR+5rW48FSlLD/WJV3nKWLEn2qEQQ3KMEavRacRMaHPDdI5B3s8tFpGHY5IK+
	 oPbEnVG0gKSLlcwj3XO+QMPDwNC9V4atGCMZwgx9SaOUt3QeIQJ3qL4I1TYBNeO7vZ
	 mpByAtgrqccr2XfqoCMnt5dNIsQrJe+Ooh8APAUg=
Subject: FAILED: patch "[PATCH] crypto: qat - protect service table iterations with" failed to apply to 5.15-stable tree
To: ahsan.atta@intel.com,giovanni.cabiddu@intel.com,herbert@gondor.apana.org.au,maksim.lukoshkov@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:23:33 +0200
Message-ID: <2026071533-skipping-woven-800c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5c6f845e77ec35f9b7b047cc8f9789bf397cdd3e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071533-skipping-woven-800c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5c6f845e77ec35f9b7b047cc8f9789bf397cdd3e Mon Sep 17 00:00:00 2001
From: Ahsan Atta <ahsan.atta@intel.com>
Date: Wed, 20 May 2026 13:41:55 +0100
Subject: [PATCH] crypto: qat - protect service table iterations with
 service_lock

The service_table list is protected by service_lock when entries are
added or removed (in adf_service_add() and adf_service_remove()), but
several functions iterate over the list without holding this lock.

A concurrent adf_service_register() or adf_service_unregister() call
could modify the list during traversal, leading to list corruption or
a use-after-free.

Fix this by holding service_lock across all list_for_each_entry()
iterations of service_table in adf_dev_init(), adf_dev_start(),
adf_dev_stop(), adf_dev_shutdown(), adf_dev_restarting_notify(),
adf_dev_restarted_notify(), and adf_error_notifier().

The lock ordering is safe: callers of the static helpers (adf_dev_up()
and adf_dev_down()) acquire state_lock before service_lock, and no
event_hld callback or service_lock holder ever acquires state_lock in
the reverse order.

Cc: stable@vger.kernel.org
Fixes: d8cba25d2c68 ("crypto: qat - Intel(R) QAT driver framework")
Signed-off-by: Ahsan Atta <ahsan.atta@intel.com>
Co-developed-by: Maksim Lukoshkov <maksim.lukoshkov@intel.com>
Signed-off-by: Maksim Lukoshkov <maksim.lukoshkov@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/intel/qat/qat_common/adf_init.c b/drivers/crypto/intel/qat/qat_common/adf_init.c
index f9f5696ed476..1c7f9e49914d 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_init.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_init.c
@@ -155,15 +155,18 @@ static int adf_dev_init(struct adf_accel_dev *accel_dev)
 	 * This is to facilitate any ordering dependencies between services
 	 * prior to starting any of the accelerators.
 	 */
+	mutex_lock(&service_lock);
 	list_for_each_entry(service, &service_table, list) {
 		if (service->event_hld(accel_dev, ADF_EVENT_INIT)) {
 			dev_err(&GET_DEV(accel_dev),
 				"Failed to initialise service %s\n",
 				service->name);
+			mutex_unlock(&service_lock);
 			return -EFAULT;
 		}
 		set_bit(accel_dev->accel_id, service->init_status);
 	}
+	mutex_unlock(&service_lock);
 
 	return 0;
 }
@@ -233,15 +236,18 @@ static int adf_dev_start(struct adf_accel_dev *accel_dev)
 	if (ret && ret != -EOPNOTSUPP)
 		return ret;
 
+	mutex_lock(&service_lock);
 	list_for_each_entry(service, &service_table, list) {
 		if (service->event_hld(accel_dev, ADF_EVENT_START)) {
 			dev_err(&GET_DEV(accel_dev),
 				"Failed to start service %s\n",
 				service->name);
+			mutex_unlock(&service_lock);
 			return -EFAULT;
 		}
 		set_bit(accel_dev->accel_id, service->start_status);
 	}
+	mutex_unlock(&service_lock);
 
 	clear_bit(ADF_STATUS_STARTING, &accel_dev->status);
 	set_bit(ADF_STATUS_STARTED, &accel_dev->status);
@@ -315,6 +321,7 @@ static void adf_dev_stop(struct adf_accel_dev *accel_dev)
 		qat_comp_algs_unregister(hw_data->accel_capabilities_ext_mask);
 	clear_bit(ADF_STATUS_COMP_ALGS_REGISTERED, &accel_dev->status);
 
+	mutex_lock(&service_lock);
 	list_for_each_entry(service, &service_table, list) {
 		if (!test_bit(accel_dev->accel_id, service->start_status))
 			continue;
@@ -326,6 +333,7 @@ static void adf_dev_stop(struct adf_accel_dev *accel_dev)
 			clear_bit(accel_dev->accel_id, service->start_status);
 		}
 	}
+	mutex_unlock(&service_lock);
 
 	if (hw_data->stop_timer)
 		hw_data->stop_timer(accel_dev);
@@ -375,6 +383,7 @@ static void adf_dev_shutdown(struct adf_accel_dev *accel_dev)
 				  &accel_dev->status);
 	}
 
+	mutex_lock(&service_lock);
 	list_for_each_entry(service, &service_table, list) {
 		if (!test_bit(accel_dev->accel_id, service->init_status))
 			continue;
@@ -385,6 +394,7 @@ static void adf_dev_shutdown(struct adf_accel_dev *accel_dev)
 		else
 			clear_bit(accel_dev->accel_id, service->init_status);
 	}
+	mutex_unlock(&service_lock);
 
 	adf_rl_exit(accel_dev);
 
@@ -419,12 +429,14 @@ int adf_dev_restarting_notify(struct adf_accel_dev *accel_dev)
 {
 	struct service_hndl *service;
 
+	mutex_lock(&service_lock);
 	list_for_each_entry(service, &service_table, list) {
 		if (service->event_hld(accel_dev, ADF_EVENT_RESTARTING))
 			dev_err(&GET_DEV(accel_dev),
 				"Failed to restart service %s.\n",
 				service->name);
 	}
+	mutex_unlock(&service_lock);
 	return 0;
 }
 
@@ -432,12 +444,14 @@ int adf_dev_restarted_notify(struct adf_accel_dev *accel_dev)
 {
 	struct service_hndl *service;
 
+	mutex_lock(&service_lock);
 	list_for_each_entry(service, &service_table, list) {
 		if (service->event_hld(accel_dev, ADF_EVENT_RESTARTED))
 			dev_err(&GET_DEV(accel_dev),
 				"Failed to restart service %s.\n",
 				service->name);
 	}
+	mutex_unlock(&service_lock);
 	return 0;
 }
 
@@ -445,12 +459,14 @@ void adf_error_notifier(struct adf_accel_dev *accel_dev)
 {
 	struct service_hndl *service;
 
+	mutex_lock(&service_lock);
 	list_for_each_entry(service, &service_table, list) {
 		if (service->event_hld(accel_dev, ADF_EVENT_FATAL_ERROR))
 			dev_err(&GET_DEV(accel_dev),
 				"Failed to send error event to %s.\n",
 				service->name);
 	}
+	mutex_unlock(&service_lock);
 }
 
 int adf_dev_down(struct adf_accel_dev *accel_dev)

