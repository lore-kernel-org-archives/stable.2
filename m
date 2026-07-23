Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F143909AE
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784790871; cv=none; b=JUexNcdZR/J8fxLFgdvkhHso2RVRQW7u11m9nq0JnXFVaKAXE28VzS5MHEKoNlZa6KeXNO+ty/fM7I7j6TI2MRGHln7+3uRAqjaSFlIOWtu4jvUz6iupBFaABRG6ef/ihc8ZaZGEx7yixcZJdsntchCjKjryjOo5resh0GLGSIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784790871; c=relaxed/simple;
	bh=Ss7JoXFHGRd2zbqTCRzWmOflLq0kyEcVLwZZBHbcE04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY+rSGhgI0v+KtZAYFXVz6aoRRoY9f6yX7mBQIuISxX/gLrYBXZDJF9yh0FTl/pj2aalM22xl5TOruEyNbxvIayCOqHBQBCTeW6eR38y20PT9H78czxwWT+7cb9DAJxGv0WD9rIthVnwsKMi/i/L3n6rB45KuP1CBzIjFK+4HjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hpWkWFMM; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpWkWFMM"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c9452243cso2215581fa.3
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 00:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784790866; x=1785395666; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bFo0mK2Twky9T7qEB2bTUDQtTh7rdNsTlOuaha0+uKE=;
        b=hpWkWFMM/RrXnyTNlWu3JEQEbAwEhEIcwxHYDhlRVFQGRFhv+jWUcJtPyEQS6BH8/C
         qI1sNvjBLKU3cg5NGQ+At9fRexRADWbReXDCXBBI58f1oo9s8VE6vCUCCozt1na17pz/
         mTuGW9Q+W4fitEi7qgDUcbynbtitzuu4WyZYEj3fbpG+AtmaPn6Z8XkLvbtVgxSsOFx/
         u8ZaVKbtxCPtkQCdDJdZilc8u/9YSTs6peL9HcPEa2g1tI+BUfA8KY5Osy5ujo+sDII5
         W+OwJ5gmlqC9m6Wnd/nT0wofL3aaYn+hx8X0iFZ7/Id81eNvSOwhlRikUEHJpuqmt1nk
         MIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784790866; x=1785395666;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bFo0mK2Twky9T7qEB2bTUDQtTh7rdNsTlOuaha0+uKE=;
        b=U32k97/1mr7RkCmRPZaf9RzottwBWQgIADkAky7XJz1PugMq6kxdUTZHriu8icpGdV
         +Y34pPEDg+ZKc9VlSAQlyydZLrdJDygIHqfh0G9fbyNVnUFKFV+LWbqTzR8ScEGf6wvX
         cyEG0PnMJbTBQd9kfABYCUupaqCKE32WkkhQu84890k8SCRP+g+ysm4aLuXhCBYkDB7/
         cC4BmxJrCt3Ig/oUFPhVyB5Gc1Ar+1d76zOgKX1lxbhG2TAWBBSYQ90fE4Lp9kcjtUUu
         RSuPk8mFbcbNqm5mF3RBwXFx8RPJYKX/NClO6m3DoaqROwO4dp+gpvK9i4L57BESwBOv
         bn1Q==
X-Forwarded-Encrypted: i=1; AHgh+RpS1s2AWRSm7NEgPK9qGo+3wmxAXW+haZvTB5bht0dhDs8XRoSNloenb+JOV0uj9MTysv8B09Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7hsHULLuDmkwkoSSnGiomz6icJOPqDFn/btNMj6+hP6nhdLeZ
	BWvUqP3eiQtwDjn7aWAu4NJPV65kFKVwfh9QPGAHNH8CgKyoI7caAPatl8dPvKw8kks=
X-Gm-Gg: AR+sD11FxiiPxVhoNMvpp89SuPoVxH/iK3s2+/dBfrMT1bX2zCEWgRPEh/RELekSHd4
	2s8MHi3EYhXKt1HIIUEsEtP9QSqZ46KhIQu0OZkaJ7Nd5oenIEyiF8CxHRQx6XM0bajsJ40P5P5
	x/N2mzqCAIKooZi/UL6VkMG/5T37trHTWpSzUDlFGi8VYTbAafnrzwO6eRLi2WN3xYmNEkJI9fJ
	LRE4Ib0mLQjtDTvQd04BJITXX/vRZSgYg7TNNnW9W6fvtPrE1AgfSv5+ClCqc9YD8rx3N3fDEvN
	CZGMWTVE6xYTIuntryRF/hOIYe8n73SlHvkACN8qiD1cxZ6ASSGJISHfceDN8dIOgNhWVoHzdjw
	yqaTCdVJwUAoEjlD89crJRcHCqGhgUwBXAJDI/xZaaUejlPBtSR2mSV9xw/h9oVagcyYDyis3Sv
	CNEkywB2b5A0T1L0MIdVcrgkOogf1h4g==
X-Received: by 2002:a05:6512:3e2a:b0:5ae:af98:497f with SMTP id 2adb3069b0e04-5b2b2e4995cmr317702e87.7.1784790865836;
        Thu, 23 Jul 2026 00:14:25 -0700 (PDT)
Received: from nuoska (78-27-71-225.bb.dnainternet.fi. [78.27.71.225])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9f4d42esm844102e87.79.2026.07.23.00.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 00:14:25 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:14:23 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, stable@vger.kernel.org
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/virtio: fix deadlock in display_info_cb by
 removing hotplug from dequeue worker
Message-ID: <amG_T7Kb7DW3VTxm@nuoska>
References: <20260713-virtiogpu_syzbot-v2-1-2958fa37d46d@redhat.com>
 <ba8a2de8-8ac7-490d-b48e-767d1e7893a9@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba8a2de8-8ac7-490d-b48e-767d1e7893a9@collabora.com>

Hi, adding stable@vger.kernel.org

In Yocto distro, this change released in v7.2-rc4 seems to fix quite severe qemu
boot hangs seen with 6.18 stable kernels. Details in
https://bugzilla.yoctoproject.org/show_bug.cgi?id=16217

Please apply this to to 6.18 and other stable trees.

Cheers,

-Mikko

On Mon, Jul 13, 2026 at 07:31:14PM +0300, Dmitry Osipenko wrote:
> On 7/13/26 16:01, Ryosuke Yasuoka wrote:
> > A probe-time deadlock can occur between the dequeue worker and
> > drm_client_register(). During probe, drm_client_register() holds
> > clientlist_mutex and calls the fbdev hotplug callback, which triggers an
> > atomic commit that ends up sleeping in virtio_gpu_queue_ctrl_sgs()
> > waiting for virtqueue space. The dequeue worker that would free that
> > space calls virtio_gpu_cmd_get_display_info_cb(), which invokes
> > drm_kms_helper_hotplug_event() -> drm_client_dev_hotplug(), attempting
> > to acquire the same clientlist_mutex. Since wake_up() is only called
> > after the resp_cb loop, the probe thread is never woken and both threads
> > deadlock.
> > 
> > Fix this by removing the hotplug notification from
> > virtio_gpu_cmd_get_display_info_cb(). The display data (outputs[i].info)
> > is still updated synchronously in the callback.
> > 
> > For the init path, drm_client_register() already fires an initial
> > hotplug when the client is registered, which picks up the connector
> > state updated by display_info_cb.
> > 
> > For the runtime config_changed path, add a wait_event_timeout() in
> > config_changed_work_func() so that display_info_cb updates the connector
> > data before the hotplug notification is sent. Also replace
> > drm_helper_hpd_irq_event() with drm_kms_helper_hotplug_event() since
> > virtio-gpu never calls drm_kms_helper_poll_init() and thus
> > drm_helper_hpd_irq_event() always returns false without doing anything.
> > 
> > Fixes: 27655b9bb9f0 ("drm/client: Send hotplug event after registering a client")
> > Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
> > Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
> > Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > ---
> > I checked whether drm_helper_hpd_irq_event() is needed in
> > virtio_gpu_init(), as Dmitry suggested. AFAIS, it is not needed because:
> > 
> > 1. drm_helper_hpd_irq_event() is always a no-op in virtio-gpu.
> >    It returns false immediately probe_helper.c:1088 because
> >    dev->mode_config.poll_enabled is false — virtio-gpu never calls
> >    drm_kms_helper_poll_init(). Even if it passed that gate, no
> >    virtio-gpu connectors set DRM_CONNECTOR_POLL_HPD.
> > 
> > 1082 bool drm_helper_hpd_irq_event(struct drm_device *dev)
> > 1083 {
> > ...
> > 1088         if (!dev->mode_config.poll_enabled)
> > 1089                 return false;
> > 
> > 2. virtio_gpu_init() runs before drm_dev_register() and
> >    drm_client_setup(), so no DRM clients are registered yet.
> >    drm_kms_helper_hotplug_event() would iterate an empty client list.
> >    The initial hotplug is handled by drm_client_register(), which fires
> >    a hotplug callback to the newly registered client. By that time,
> >    display_info_cb has already updated the connector data.
> > 
> > For the same reason, drm_helper_hpd_irq_event() in
> > config_changed_work_func() was also a no-op. The actual runtime hotplug
> > notification was always delivered by display_info_cb's call to
> > drm_kms_helper_hotplug_event(). This patch replaces it with a direct
> > drm_kms_helper_hotplug_event() call after waiting for the display info
> > response.
> > ---
> > Changes in v2:
> > - Dropped the work_struct approach from v1.
> > - Instead, removed the hotplug calls from display_info_cb entirely, as
> > suggested by Dmitry.
> > - Added wait_event_timeout() in config_changed_work_func() so that the
> > display info response is received before sending the hotplug
> > notification.
> > - Replaced drm_helper_hpd_irq_event() with drm_kms_helper_hotplug_event()
> > in config_changed_work_func() since drm_helper_hpd_irq_event() is
> > always a no-op in virtio-gpu (poll_enabled is never set).
> > - No changes to virtio_gpu_init() — drm_client_register() already
> > handles the initial hotplug and hotplug event does nothing before DRM
> > device/client has been registered.
> > - Link to v1: https://lore.kernel.org/r/20260630-virtiogpu_syzbot-v1-1-0aa06630750e@redhat.com
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_kms.c | 5 ++++-
> >  drivers/gpu/drm/virtio/virtgpu_vq.c  | 3 ---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> > index cfde9f573df6..b4329f28e976 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> > @@ -49,7 +49,10 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
> >  				virtio_gpu_cmd_get_edids(vgdev);
> >  			virtio_gpu_cmd_get_display_info(vgdev);
> >  			virtio_gpu_notify(vgdev);
> > -			drm_helper_hpd_irq_event(vgdev->ddev);
> > +			wait_event_timeout(vgdev->resp_wq,
> > +					   !vgdev->display_info_pending,
> > +					   5 * HZ);
> > +			drm_kms_helper_hotplug_event(vgdev->ddev);
> >  		}
> >  		events_clear |= VIRTIO_GPU_EVENT_DISPLAY;
> >  	}
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> > index c8b9475a7472..e5e1af8b8e8a 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> > @@ -840,9 +840,6 @@ static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device *vgdev,
> >  	vgdev->display_info_pending = false;
> >  	spin_unlock(&vgdev->display_info_lock);
> >  	wake_up(&vgdev->resp_wq);
> > -
> > -	if (!drm_helper_hpd_irq_event(vgdev->ddev))
> > -		drm_kms_helper_hotplug_event(vgdev->ddev);
> >  }
> >  
> >  static void virtio_gpu_cmd_get_capset_info_cb(struct virtio_gpu_device *vgdev,
> > 
> > ---
> > base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> > change-id: 20260619-virtiogpu_syzbot-bdab508ffcd5
> > 
> > Best regards,
> 
> Appled to misc-fixes, thanks!
> 
> -- 
> Best regards,
> Dmitry
