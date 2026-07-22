Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B764749DA;
	Wed, 22 Jul 2026 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735805; cv=none; b=ErcBM+V8jdmEIGmE3UPyzKxpdHJIsOzRDE7OKzMg2sNsad8FZ1kwG1OhdCA1gXEksvl+DNEoYuxdhbfaSOBEpjz5WgJZrXGjVr6PG1lQZ/XzCG7eCym04P9W5yPo5dBi3DVzCmxUAlt8Ic3h3ruM29EdcafHdOo/Dm7qTUzcHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735805; c=relaxed/simple;
	bh=FiSaNzrwg1CDpPh71m+p2IAMEfxRQmqNzBWs6sN2Ygg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVFnsLVDdgpNflZWTsYMCKHc1Y9u0xnlQnAtb7w7ZPhlsx3yOUZTSqQBZy4kWv3vJorKWji6Es4CL/FVKpIg7torFzYplIT4iwOU3aDkE5p/tC7IPqY0pdpBZUjYmaEC3XRedfUftjXTg4MfFBuhZk5k6Vb0Ip0IjK2zbOG6DLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M7Hgk+xE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M7Hgk+xE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BC0271A1170;
	Wed, 22 Jul 2026 15:56:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8E47460388;
	Wed, 22 Jul 2026 15:56:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4227611BD3B71;
	Wed, 22 Jul 2026 17:56:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784735797; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=dsq2tbVfcmwQf/NKkYTrIq5zP9dcp5JI067IGSQchEc=;
	b=M7Hgk+xE8qx4iulBVzZQ1iznkqt8sBvKBKGPnp7VifsVV88YXGjmSk16eBvKvpfP49982k
	76O0XcgyBwcB9pL1wxOYk1diSwunzxBZxEN5uA6RZxXPkIM1ohb4KAbPHWPqGslJ28mrXr
	i/ZCCp/AxryOL9NNPB8QqtPl/qhflxfgFtZyq1OO0EieYH6IlwhU3oNQylIzhklnvotKYN
	ahQ1Tb2Xexcj4OhVAkZvfb6XEGIE/YkioKwpuZ7tQ5TfR80mpYDKfi3uanS/WSLd9ZCCkm
	d1lINXBxMJ918Icu36zTqvDoRrP3GVxs5tzAfo3jYt/0SNMGQvKOTyj2FaqeHQ==
Message-ID: <3adb0a99-95c0-41dd-a701-efaff37e74b5@bootlin.com>
Date: Wed, 22 Jul 2026 17:56:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/vkms: Fix UAF between connector configfs rmdir and
 .detect
To: Ibrahim Hashimov <security@auditcode.ai>, hamohammed.sa@gmail.com,
 melissa.srw@gmail.com, simona@ffwll.ch
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, luca.ceresoli@bootlin.com,
 harry.wentland@amd.com, jose.exposito89@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260709150637.45052-1-security@auditcode.ai>
 <20260709195129.50856-1-security@auditcode.ai>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260709195129.50856-1-security@auditcode.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello,

Thanks for this report and patch. I am currently working on a series 
adding even more stuff in vkms_config, so I am trying to solve it for 
the whole vkms_config structure.

In total I have 4 new places with a similar issue (use after free due to 
dependency between configfs and drm, plus existing one you already 
reported), and I would like to avoid this kind of "do I need rcu" every 
time a new property is added. I will send it to you as soon as possible 
so you can review and test if it fixes your issue. My current 
implementation is basically:
- removing the ABBA deadlock by avoiding the locking when comming from 
the DRM side
- adding few refcounts so I don't have to iterate over the connector 
list every time I want to access the connector object
- Maybe one RCU for the EDID

In the meantime, do you have the script that you used to do the 
hammering? Or even better, can you contribute this test to IGT[1] so we 
can ensure there will be no regression?

Thansk a lot,
Louis Chauvet

[1]: https://gitlab.freedesktop.org/drm/igt-gpu-tools

On 7/9/26 21:51, Ibrahim Hashimov wrote:
> vkms_connector_detect() walks config->connectors via
> vkms_config_for_each_connector(), which expands to a plain
> list_for_each_entry() over vkms_config::connectors with no lock and no
> RCU protection.
> 
> Concurrently, rmdir'ing a connector's configfs directory calls
> connector_release(), which takes the configfs device mutex
> (connector->dev->lock) and calls vkms_config_destroy_connector(),
> which does:
> 
> 	list_del(&connector_cfg->link);
> 	kfree(connector_cfg);
> 
> Unlike make_crtc_group()/make_plane_group()/make_encoder_group()/
> make_connector_group() and the possible_crtcs/possible_encoders
> allow_link() callbacks, all of which refuse the operation with -EBUSY
> while the device is enabled, connector_release() has no such guard, and
> in fact cannot be given one: release() runs after configfs has already
> committed to removing the directory, so it cannot fail the rmdir(2)
> syscall with -EBUSY. A connector's configfs directory can therefore be
> removed, and its vkms_config_connector freed, at any time while the
> device is live and its DRM connector is still being probed.
> 
> vkms_connector_detect() is reached from userspace by writing "detect"
> to /sys/class/drm/<card>-<conn>/status (drm_sysfs status_store() ->
> drm_helper_probe_single_connector_modes() -> .detect), which runs under
> drm_device.mode_config.mutex. Nothing prevents this from running at the
> same time as the configfs rmdir above, since the two paths take
> entirely different locks (configfs connector->dev->lock vs. DRM's
> mode_config.mutex) over the same vkms_config_connector object. Both
> sides require local root/CAP_SYS_ADMIN: the vkms configfs tree is
> root-owned (0755) and the connector's sysfs status attribute is
> root-writable by default, so this is a local-root race, not an
> unprivileged-user or remote issue.
> 
> The result is a classic race-into-use-after-free: the unlocked iterator
> dereferences connector_cfg->connector or follows connector_cfg->link
> into memory that connector_release() has already kfree()'d, or reads
> connector_cfg->status out of freed memory. This reproduces as a KASAN
> slab-use-after-free in vkms_connector_detect() under a detect-hammer
> vs. connector-rmdir stress loop.
> 
> A tempting minimal fix is to have vkms_connector_detect() take the same
> configfs device lock (connector->dev->lock) that connector_release()
> already holds while unlinking/freeing. That would deadlock:
> vkms_destroy() (reached from device_enabled_store() while
> connector->dev->lock is held) calls drm_dev_unregister() and
> drm_atomic_helper_shutdown(), both of which take
> drm_device.mode_config.mutex internally. That establishes lock order
> configfs-lock -> mode_config.mutex on the teardown path, while
> vkms_connector_detect() always runs already holding mode_config.mutex,
> so having it additionally acquire the configfs lock would order it
> mode_config.mutex -> configfs-lock, the exact reverse (ABBA).
> 
> Fix the race with RCU instead, decoupling the free side from the read
> side without introducing a new lock-ordering constraint:
> 
>    - vkms_config_create_connector() links with list_add_tail_rcu()
>      instead of list_add_tail().
>    - vkms_config_destroy_connector() unlinks with list_del_rcu() before
>      it destroys the object, then defers the free with kfree_rcu()
>      instead of kfree(). It unlinks first so the object is removed from
>      the list before it is reclaimed; xa_destroy() of
>      connector_cfg->possible_encoders then runs synchronously between the
>      unlink and the deferred free, which is safe because no RCU reader
>      (i.e. vkms_connector_detect()) ever dereferences that field.
>    - A new vkms_config_for_each_connector_rcu() iterator
>      (list_for_each_entry_rcu()) is added alongside the existing
>      vkms_config_for_each_connector() for the other (non-concurrent,
>      configfs-lock-serialized) call sites, and used only in
>      vkms_connector_detect(), wrapped in rcu_read_lock()/
>      rcu_read_unlock().
> 
> This is the same pattern DRM core already uses to let connector
> iteration (drm_connector_list_iter) survive concurrent connector
> teardown without holding mode_config.mutex across the whole walk; here
> it is applied locally to vkms's own configfs connector list, matching
> the existing "protect the config lists, use RCU when a reader can't
> take the writer's lock" discipline already present in the file.
> 
> This patch is scoped to the .detect sink. vkms_config_show(), the read
> handler for the "vkms_config" debugfs file, also walks the plane, CRTC,
> encoder and connector config lists without any lock or RCU protection,
> and is subject to a separate, pre-existing use-after-free against a
> concurrent configfs rmdir. Fixing it properly requires RCU-converting
> the plane, CRTC and encoder teardown paths too:
> vkms_config_destroy_plane(), vkms_config_destroy_crtc() and
> vkms_config_destroy_encoder() still free their objects non-RCU (plain
> list_del() + kfree()), so the RCU conversion done here for connectors
> alone is not enough to make that debugfs walk safe. That is left as a
> separate follow-up and is not addressed here.
> 
> Verified on a v6.19 KASAN-instrumented build: a detect-hammer vs.
> connector-rmdir stress loop reliably tripped a "KASAN: slab-use-after-
> free in vkms_connector_detect" report before this patch; with the fix
> applied, the same stress loop no longer produces any KASAN report.
> 
> Fixes: 466f43885ac0 ("drm/vkms: Allow to update the connector status")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07
> ---
> v2: address sashiko-bot review of v1
> (https://lore.kernel.org/dri-devel/20260709150637.45052-1-security@auditcode.ai/):
> reorder vkms_config_destroy_connector() to unlink (list_del_rcu) before
> destroying components (xa_destroy) for remove-before-reclaim ordering; drop the
> v1 claim that vkms_config_show() is safe -- it is a separate pre-existing
> lockless-traversal issue, noted as out of scope. No change to the RCU .detect fix.
>   drivers/gpu/drm/vkms/vkms_config.c    | 28 ++++++++++++++++++++++++---
>   drivers/gpu/drm/vkms/vkms_config.h    | 22 +++++++++++++++++++++
>   drivers/gpu/drm/vkms/vkms_connector.c | 16 ++++++++++++++-
>   3 files changed, 62 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index 5a654d6dead8..a44e0567f8a3 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -1,5 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   
> +#include <linux/rculist.h>
> +#include <linux/rcupdate.h>
>   #include <linux/slab.h>
>   
>   #include <drm/drm_print.h>
> @@ -599,7 +601,12 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
>   	connector_cfg->status = connector_status_connected;
>   	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
>   
> -	list_add_tail(&connector_cfg->link, &config->connectors);
> +	/*
> +	 * Paired with vkms_config_for_each_connector_rcu() in
> +	 * vkms_connector_detect(), which may walk this list without holding
> +	 * the configfs device lock.
> +	 */
> +	list_add_tail_rcu(&connector_cfg->link, &config->connectors);
>   
>   	return connector_cfg;
>   }
> @@ -607,9 +614,24 @@ EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_connector);
>   
>   void vkms_config_destroy_connector(struct vkms_config_connector *connector_cfg)
>   {
> +	/*
> +	 * connector_release() (vkms_configfs.c) can free a connector while
> +	 * vkms_connector_detect() is concurrently walking the connectors list
> +	 * under its own RCU read-side critical section (it cannot take the
> +	 * configfs device lock: it already runs under
> +	 * drm_device.mode_config.mutex, and vkms_destroy() takes the two
> +	 * locks in the opposite order, so plain locking here would deadlock).
> +	 *
> +	 * Unlink from the list before destroying the object's components, so
> +	 * the object is removed before it is reclaimed. After list_del_rcu()
> +	 * no new reader can reach it, and the only RCU reader
> +	 * (vkms_connector_detect()) never dereferences possible_encoders, so
> +	 * tearing that down next is safe. Defer the free to after a grace
> +	 * period so concurrent readers never touch freed memory.
> +	 */
> +	list_del_rcu(&connector_cfg->link);
>   	xa_destroy(&connector_cfg->possible_encoders);
> -	list_del(&connector_cfg->link);
> -	kfree(connector_cfg);
> +	kfree_rcu(connector_cfg, rcu);
>   }
>   EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_connector);
>   
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index 8f7f286a4bdd..127076a9280b 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -4,6 +4,7 @@
>   #define _VKMS_CONFIG_H_
>   
>   #include <linux/list.h>
> +#include <linux/rculist.h>
>   #include <linux/types.h>
>   #include <linux/xarray.h>
>   
> @@ -108,6 +109,9 @@ struct vkms_config_encoder {
>    *             It can be used to store a temporary reference to a VKMS connector
>    *             during device creation. This pointer is not managed by the
>    *             configuration and must be managed by other means.
> + * @rcu: Used to free the connector configuration after a grace period, so that
> + *       vkms_config_for_each_connector_rcu() readers (e.g. .detect) can safely
> + *       run concurrently with configfs teardown (see vkms_config_destroy_connector()).
>    */
>   struct vkms_config_connector {
>   	struct list_head link;
> @@ -118,6 +122,8 @@ struct vkms_config_connector {
>   
>   	/* Internal usage */
>   	struct vkms_connector *connector;
> +
> +	struct rcu_head rcu;
>   };
>   
>   /**
> @@ -152,6 +158,22 @@ struct vkms_config_connector {
>   #define vkms_config_for_each_connector(config, connector_cfg) \
>   	list_for_each_entry((connector_cfg), &(config)->connectors, link)
>   
> +/**
> + * vkms_config_for_each_connector_rcu - RCU-safe iteration over the vkms_config
> + * connectors
> + * @config: &struct vkms_config pointer
> + * @connector_cfg: &struct vkms_config_connector pointer used as cursor
> + *
> + * Unlike vkms_config_for_each_connector(), this may be used without holding
> + * the configfs device lock, from contexts (such as &drm_connector_funcs.detect)
> + * that must not block on it. Callers must wrap the iteration in
> + * rcu_read_lock() / rcu_read_unlock(); see vkms_config_destroy_connector(),
> + * which pairs with this by unlinking with list_del_rcu() and freeing with
> + * kfree_rcu().
> + */
> +#define vkms_config_for_each_connector_rcu(config, connector_cfg) \
> +	list_for_each_entry_rcu((connector_cfg), &(config)->connectors, link)
> +
>   /**
>    * vkms_config_plane_for_each_possible_crtc - Iterate over the vkms_config_plane
>    * possible CRTCs
> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
> index b0a6b212d3f4..c43948de2b01 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
> @@ -1,5 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   
> +#include <linux/rcupdate.h>
> +
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_edid.h>
>   #include <drm/drm_managed.h>
> @@ -26,10 +28,22 @@ static enum drm_connector_status vkms_connector_detect(struct drm_connector *con
>   	 */
>   	status = connector->status;
>   
> -	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
> +	/*
> +	 * configfs can free connector_cfg concurrently (connector_release() ->
> +	 * vkms_config_destroy_connector(), on an rmdir of the connector's
> +	 * configfs directory) without taking drm_device.mode_config.mutex,
> +	 * which this .detect callback is always called under. Walk the RCU-
> +	 * protected list instead of taking the configfs device lock here: the
> +	 * two locks are already nested in the opposite order by
> +	 * vkms_destroy(), so acquiring the configfs lock from under
> +	 * mode_config.mutex would deadlock.
> +	 */
> +	rcu_read_lock();
> +	vkms_config_for_each_connector_rcu(vkmsdev->config, connector_cfg) {
>   		if (connector_cfg->connector == vkms_connector)
>   			status = vkms_config_connector_get_status(connector_cfg);
>   	}
> +	rcu_read_unlock();
>   
>   	return status;
>   }

