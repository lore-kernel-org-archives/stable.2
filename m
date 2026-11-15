Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794756307;
	b=QbfH21v5Z7Q+4cw7s0YqB5E7Y/En/1PCOA2d+rXX/6DBNcU0xRNB5RObihpWfh8jpbi3
	 p87MDlqct3IeaTTahjZKzhhmhWVVjD/sqqDji9GK7CHTlZdHvExJy4UDj8EJyJN6YsHv0
	 2rbzw40VPl8FHBYlwWooPFtX4u5e8SuIeKPZxuNjf8T0Ge9El3pRvcdvzFzlmPY2sMIzM
	 kDDA6Ouu0oGP/ujEMDH3Cfs5c4Ksty6a9CmsJHn4a2Img7Xa2b+fytPY3jIAxKUbbS/4g
	 RhYJV1vQLEKdfRve2XP/LX0nIyQpQYxJnpMzWphAeJa9GHUmLEHuG9aq4Bw9nOOzgSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UeeEThuh222TXFAsYtZtRa1ScqQ+7ELFGplLuxcMQxk=;
	b=mMBb3NIR29pzwuI+NASMLjs6YnMScNoqCHWgqOx/O7R2JeLReTDwrLDrtVWZD512NUR7
	 AXHwAjHvRiE/UQwjke8qi38pfmuMBwC35LJT+vMCUa4PEzsPMN8rVMNv9XGAGUuP+wjyk
	 Qy5IjCqgHm+th1Bip7FT1gH7c8DlDyrzhSREozCWJK+k0nppyVymAzuwn0XniXN52o/WW
	 I+yaD7LVIMaAa2V37bjTc/J0Ud0MKI9P80+w6tgNN1YbKjZzmtcS30CN3WcGuEEVDpu//
	 i45+0WhkMIhato82lQf59BcQv/OKusUeCEcUdxYXBdRLG1nPGVNs7HcBUGtSbqRvaHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AcQ77r3c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED4606A31E
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 15:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11ED4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AcQ77r3c
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4b190cdc9feso2537736b6e.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 07:25:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794756306; cv=none;
        d=google.com; s=arc-20260327;
        b=fqEGIaxQTQhXZVAGHumZb5BzHlTFzyuKB7t6YrAXHjmy5I4ZOd8BITvw8IIrNQDEHx
         s3qo8dMGSpZNx23c6yXPCOaqUSUdFwuHfsR54lQhC8szHx1wsNxr+uC0GMo/PIIZBmSA
         bKk1fb1HDLaxGMuTQ2lBJcKxUNkjC1aEbv/EOiXcw4wz/p21YYLzyWw6U5yJ2H0v2kM/
         26rLFoV48iJldzRgIMimglBO2McGN7XSt2n55bE0Nom4erC1rajIP6NWZKZbAq5uiXkY
         vw+jDseGinGcYkwe8yZd4r4RWD8yeXEhbE1GBeP2hmDvMo8/kMQti+fCElfHAjH/ClRZ
         0zNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UeeEThuh222TXFAsYtZtRa1ScqQ+7ELFGplLuxcMQxk=;
        fh=yOFTxGS3Yk0i8SsayWzYAavTLSYiAV42y2bJuFflvQo=;
        b=JX+EOANn633+MOAJ7DaT6tndaH0IzZWQAY4D7RlM8MYpVFnZK8l+AuUMeDMzityCAp
         l4Tpk3Al83WxCf9XDA6aammv5c67i2WyI+8R5bHeBkxLLcfxwQ3u6kxzsAdZlLG7IeXx
         A97zgwMWHW93YrEJ451fbepQhuwgOruScVK19hCzMaTIWmyHCV9EyHM+8laN0Tz96Jp9
         htMAiIXMfpKSyxC372DeXZCbIWVUlFkHCiy8f/WEjV3ErS573pTy4ikJ9l7GlbN4C+2y
         nFGG+VA/9K/CNobtNEoKktoSn+XODVUIz7GR3xZJ8pyDIkCyTzyVqW+C+xKsadNnke8H
         yj4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794756306; x=1795361106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UeeEThuh222TXFAsYtZtRa1ScqQ+7ELFGplLuxcMQxk=;
        b=AcQ77r3c7zTM9pfup4JKJg9SbR0d0+ODaAqSYIBI2w7LhKXqAwj8nqI4iJGyVTDf5o
         LOnGR7RXBolyd9PLA4wIf77ZKU/US3Uw2HCzYgIzbldD/XPgvBG7B0iVuBtDksMaErqH
         nXrRK6Nk6iNRTj4XXDtNxRo3TCpfVPVAoU+k6iIVatXMNB4J817MJq6ZH/JsoXvIjXIe
         /cOc8Hqffzz5NbuxHb7ep16WCsKY6MtvlfJna4SkDyR2X795p5c3xCsj7Icmb0wdLjmA
         6GKXGopR7lAlNz+OS+Qc1cpFd6iKX97WEQUl8GP/snq9812shp3wAWYKZAiCwPrLFzjn
         WMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794756306; x=1795361106;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UeeEThuh222TXFAsYtZtRa1ScqQ+7ELFGplLuxcMQxk=;
        b=lGlKIQU0WF3RJya7t4Cg6KcN+c6LH6jVGp8/Rf5DFnCK5i6OprrxZj9Dkp99wTQUR8
         fSMfUpGzrZgyntUbbSFGe14St5IKioiXVPcSS3xqI3xUks1+9UGvCJMDqarKtR4+bh6G
         76GYaYjjjdjjD+IpQ5qk//WRc9nBWDOi9ZeuRIeTBv1quKsjDCGL9hsyyc68iLD9BG8I
         tNmIPKSuO7yJwrIQvEUUNb5wHEGswbogAXhpL0uWOGxnaofSSov9Vp3owZRaZQFGcThK
         04gr76qwsFpN+pLoSANykoJAkqSDnsYPIOWOiOh128pVHUwsHc/G5cIcIOGWzCtnC9Cu
         mX7g==
X-Forwarded-Encrypted: i=1; AL+hErERzjAiBkVWaHm8mUfyRHm+A43TZ5qqUQ+Qa0VEyjPFEtBsRlAcMp8Porggda7rUVm/QddUFQU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sYyaeN7cY8EUnStAvNJ7AYsPUZmff7DQAc+C/t7P60B4QS3j4
	Asyckmohj1/SrOeEH3wxObOz9p8wyMzHP4Qzjs8VK3a53V9cf3bRRd3novmhk+Yg5S2UQgMEibX
	ml4lL5N/JUOT89dWhEjR0PIJIqS5nzqA=
X-Gm-Gg: AYBFou0YvzNgscDzXOIdCwe+8PYkZAn/nnQ9DbVfit5nrJIoovILcyeHOcnMOACENtD
	vr0R48g7znD+rJXqbaW2WaJ4rp0K6F8qeGTOj53cLqCD7B4ZwctusMoCU9NhvZIwLk5kJNsPWU+
	DGrBA6sKdK1okKVsr/osXRN7RHxLlSZnU/QGEh12W/dC3+M1Sge6I5FrEoKIqGlRYdWoAbIZC7k
	ZEV9nvE9AF+ri0zDnhWb+ssBg24WJCypdrwYPXcW3djNHdDWZdjCvVs4MG9mbnR/GGkZnsLAL90
	VQwHJX5PMm79xgkpfrv5YPrthV4pvEaS/6+OCvH0TmyP93URpSDU4e0JC9RuVQ4jJHgoYvUsPqJ
	fLbtJghWEyOPi4fNTeOwKEpXfUpgyQwRrvY/XILejsWWEeKMEfDJSh3SwHCO21+jcds32bw==
X-Received: by 2002:a05:6808:4fd2:b0:4df:5cd0:89c1 with SMTP id
 5614622812f47-56e63ba5727mr6988700b6e.23.1794756305774; Sun, 15 Nov 2026
 07:25:05 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110121534.3566028-1-karol.wachowski@linux.intel.com>
In-Reply-To: <20261110121534.3566028-1-karol.wachowski@linux.intel.com>
From: Toast <swizzguy76@gmail.com>
Date: Sun, 15 Nov 2026 20:54:54 +0530
X-Gm-Features: AclHuK9q00Y9hV3eTDXkQShBoFF6n1SS0pwFA-pss82uZgNEzVH35DmfBvC_TTg
Message-ID: <CAHBKUQaxYcVQvUc336wCOZzpS+GDw7yEbmAWvpT8CEUSg+cK2w@mail.gmail.com>
Subject: Re: [PATCH v3] accel/ivpu: Defer recovery until probe completes
To: Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, 
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dawid.osuchowski@linux.intel.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested v3 on Meteor Lake (Core Ultra 5 125H, vpu_37xx firmware 20260219)
on top of v7.4-rc1 (d48723711bae):

- 4 kexec runs with the NPU runtime-suspended (one from a 7.0 kernel,
  three from 7.4): every run hit ATS_ERR during probe, recovery_work was
  not queued, probe failed with -ETIMEDOUT, and there was no oops
- FLR plus rebind brings the NPU back, and it autosuspends afterwards
- debugfs force_recovery after a successful probe recovers the NPU, and
  it returns to runtime-suspended

None of the runs had probe succeed after the error IRQ, so the deferred
recovery in ivpu_pm_enable() isn't covered by this.

One question: v2 had "Cc: stable@vger.kernel.org # v6.10+" and v3 dropped
the annotation. disable_work()/enable_work() only exist since v6.10 and
the Fixes: commit is in v6.3, so should the "# v6.10+" come back?

Tested-by: Daksh Sahni <swizzguy76@gmail.com>

On Tue, Nov 10, 2026 at 5:45=E2=80=AFPM Karol Wachowski
<karol.wachowski@linux.intel.com> wrote:
>
> An error IRQ that fires after ivpu_boot() enables interrupts queues
> recovery_work during probe. If probe then fails, the device is torn
> down while the work runs, and the work faults on the unmapped BARs:
>
>   BUG: unable to handle page fault for address: ffffcfc6680200f4
>   Workqueue: events_unbound ivpu_pm_recovery_work [intel_vpu]
>   RIP: 0010:ivpu_hw_ip_ipc_rx_addr_get+0xc/0xb0 [intel_vpu]
>   Call Trace:
>    ivpu_wait_for_ready+0x155/0x220 [intel_vpu]
>    ivpu_boot+0x9e/0x270 [intel_vpu]
>    ivpu_resume+0xa4/0xd0 [intel_vpu]
>    ivpu_pm_reset_complete+0x2c/0x90 [intel_vpu]
>    ivpu_pm_recovery_work+0xf6/0x140 [intel_vpu]
>
> If probe succeeds, the recovery runs concurrently with the rest of
> probe, and its pm_runtime_disable() discards the initial autosuspend
> request, leaving the NPU active until first use. Any recovery that
> starts while the NPU is idle loses the pending autosuspend the same way.
>
> Keep recovery_work disabled from ivpu_pm_init() until ivpu_pm_enable().
> A trigger during probe still runs diagnostics and masks interrupts, and
> ivpu_pm_enable() runs the deferred recovery before the initial
> autosuspend request. A trigger racing with ivpu_pm_enable() can cause
> a second, harmless recovery. Request autosuspend at the end of
> ivpu_pm_reset_complete() so the NPU suspends again after every reset.
>
> Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
> Cc: stable@vger.kernel.org
> Reported-by: Daksh Sahni <swizzguy76@gmail.com>
> Closes: https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail=
.com
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
>
> Notes:
>     v3:
>     - Request autosuspend at the end of ivpu_pm_reset_complete().
>       pm_runtime_disable() in ivpu_pm_reset_begin() cancels a pending
>       autosuspend request and pm_runtime_enable() does not re-issue it, s=
o
>       a recovery racing with the initial autosuspend request in
>       ivpu_pm_enable() left the NPU active until first use (Sashiko).
>       A trigger racing with ivpu_pm_enable() can still queue recovery
>       twice. The second run is a full reset that leaves the device in a
>       consistent state, and autosuspend is now re-requested after each
>       reset.
>     - Replace pm_runtime_mark_last_busy() with pm_request_autosuspend() i=
n
>       ivpu_pm_reset_complete(); it marks the device busy itself.
>     - Shorten the commit message.
>     - v2: https://lore.kernel.org/r/20261110085003.3527014-1-karol.wachow=
ski@linux.intel.com
>
>     v2:
>     - Rework of Daksh's "accel/ivpu: Disable recovery work on probe failu=
re":
>       https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail.c=
om
>     - Keep recovery_work disabled from ivpu_pm_init() until ivpu_pm_enabl=
e()
>       instead of disabling it on the probe error path, which is too late =
as
>       recovery may already run concurrently with ivpu_boot() (Sashiko)
>     - Run a recovery requested during probe from ivpu_pm_enable() and wai=
t
>       for it before the initial autosuspend request, so the NPU is reset
>       before use and the autosuspend is not lost when probe succeeds
>
>     v1:
>     - Link: https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@g=
mail.com
>
>  drivers/accel/ivpu/ivpu_pm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
> index aa813262253e..e4b79c946ca0 100644
> --- a/drivers/accel/ivpu/ivpu_pm.c
> +++ b/drivers/accel/ivpu/ivpu_pm.c
> @@ -150,8 +150,8 @@ static void ivpu_pm_reset_complete(struct ivpu_device=
 *vdev)
>         up_write(&vdev->pm->reset_lock);
>         atomic_set(&vdev->pm->reset_pending, 0);
>
> -       pm_runtime_mark_last_busy(vdev->drm.dev);
>         pm_runtime_enable(vdev->drm.dev);
> +       pm_request_autosuspend(vdev->drm.dev);
>  }
>
>  static void ivpu_pm_recovery_work(struct work_struct *work)
> @@ -415,6 +415,7 @@ void ivpu_pm_init(struct ivpu_device *vdev)
>         atomic_set(&pm->engine_reset_counter, 0);
>
>         INIT_WORK(&pm->recovery_work, ivpu_pm_recovery_work);
> +       disable_work(&pm->recovery_work);
>         INIT_DELAYED_WORK(&pm->job_timeout_work, ivpu_job_timeout_work);
>
>         if (ivpu_disable_recovery)
> @@ -439,6 +440,12 @@ void ivpu_pm_enable(struct ivpu_device *vdev)
>  {
>         struct device *dev =3D vdev->drm.dev;
>
> +       enable_work(&vdev->pm->recovery_work);
> +       if (atomic_read(&vdev->pm->reset_pending)) {
> +               queue_work(system_dfl_wq, &vdev->pm->recovery_work);
> +               flush_work(&vdev->pm->recovery_work);
> +       }
> +
>         pm_runtime_allow(dev);
>         pm_runtime_put_autosuspend(dev);
>  }
>
> base-commit: 54d3ff1b5ac08d0e28029b93a1719ddd9ff670a4
> --
> 2.43.0
>
