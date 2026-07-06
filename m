Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D9437848
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362156; cv=none; b=Dsds/TK2g8/F2+oChvQ31bd8f0mIDMpcElmSMDuNJ1mXALx0dTdIWoHeIqKTIUuEbEKnpRiD4tSxggQhvFWvmlY8HCdg628+4mUXnWoBUp6G40ypkT4lqWlCmNP/hdkS1wnL5JYUAtyr6J8T82Usaq/RSjnO03yvRVzfC9E84zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362156; c=relaxed/simple;
	bh=nJ4jnnw5mLr6Y0rU6AJZQxgQ/mnd2Cuiypzgxv2w37g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxEJiq8C0OC+5pTjBXWfDB+eAJwbIuEje4WdV76tXpqkvqx+PencZwPQ7ODLY6Eaxz4nZYjmrJbkOD5IbZKd7BDv+cnALYAOHOhEKhZJOoDUDmDn3ovK7nRM5v+blmmI3aZNxXoEUQvGg69M56oKQH1SU82BrDFIZujhTL8u/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0uLj7rx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0uLj7rx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940951F000E9
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 18:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783362154;
	bh=YjyKAGUBLZ01acBy8iDZWODq0VizLC5yJO1dkRkXO2E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=h0uLj7rxSZAGfN4dPyDWj2MFxQel7zfmtWZQ02TomXgfFHItQFqEWHeSbKkmfwFSi
	 fAEI+rWFtFM8FQ5QCpcQzyY3QAJ5W5WYRN/NDVb8IrBKfal95FUE7YetNV0+52MrTP
	 dECZ6ZGdEUUx3CiFKG91e5JQREOFTrORKF+BfALdmxSdt3uh8cyI2/OEHsMOcuMw6c
	 tqdoPpaEhIJKK8djRnlFX8UeZz5dCiWEYdXu6AUA10AMa5fItya5fCQr9FoxdP886e
	 YSfLoaqWIukzL9D5VkLylM+0cvAMEGMy/7LHJ030ahexfJ5bfqcyzhZqWhumppCepI
	 KZaMCp/eC8lpw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aeb91c003eso3655643e87.3
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 11:22:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrypH4yGCicWa2CJnguuhg50Apg+ZNUKKuW01rFDVtYn4L5PfWIqeV8tvxwzZDi27u1Q9SCtmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE0k/vvPYCteiW0VyuLzWaXmp3Y8uWsdBiPlb74GwSUrudKKh0
	EFW1ffCIEsf6CJ8UYfPVFXGUo7TVJkeEny20rZaDfyVtOIuO1KxWuoNvWk1YfnfOMlpX9PWpVJH
	pWtwzOkDYFn0vnA+4bqOz6xs+yX8Ytr4=
X-Received: by 2002:a05:6512:66cc:20b0:5ae:bb19:1864 with SMTP id
 2adb3069b0e04-5b007b7681cmr272441e87.21.1783362152967; Mon, 06 Jul 2026
 11:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611-b4-acpi-battery-notification-v3-0-f9390382c5a4@rong.moe> <20260611-b4-acpi-battery-notification-v3-1-f9390382c5a4@rong.moe>
In-Reply-To: <20260611-b4-acpi-battery-notification-v3-1-f9390382c5a4@rong.moe>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 6 Jul 2026 20:22:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iVkVWfCNMuuE=9egBZvRF31camh_okxe1pWs9TTViPSQ@mail.gmail.com>
X-Gm-Features: AVVi8CfoSn8Sq87ovA72xV7U2OXUD0ML22p-eWkF37ea9Yp7LCRRGj0h98yvddY
Message-ID: <CAJZ5v0iVkVWfCNMuuE=9egBZvRF31camh_okxe1pWs9TTViPSQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ACPI: battery: Merge consecutive battery notifications
To: Rong Zhang <i@rong.moe>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, =?UTF-8?Q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, 
	Rick <rickk1166@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 10:11=E2=80=AFPM Rong Zhang <i@rong.moe> wrote:
>
> It's a very common pattern to emit consecutive battery notifications,
> for example:
>
>     Method (_Qxx, 0, NotSerialized)
>     {
>         Notify (BAT0, 0x80) // Status Change
>         Notify (BAT0, 0x81) // Information Change
>     }
>
> In this case, the current code path will update battery state twice
> within a short period, which is not optimal, as the same data are
> fetched twice. Moreover, both notifications are likely to call
> power_supply_changed(), causing power_supply_uevent() to read all
> battery properties in order to assemble uevents. Even worse, after the
> first uevent reaches userspace, some userspace processes start to read
> all battery properties in order to refresh their internal states, which
> competes with the second notification's handling and uevent assembling.
>
> This generates significant pressure on _STA, _BST and _BIX/_BIF methods.
> Not only that, power_supply_ext properties may also rely on some other
> ACPI methods, so both uevent assembling and userspace processes call
> them. It becomes a nightmare when all these methods share the same ACPI
> mutex protecting EC accesses and hence vulnerable to lock starvation.
> This is exactly the case of some Lenovo devices, where the mentioned EC
> query pattern eventually leads to a catastrophic situation that a bunch
> of ACPI methods (including but not limited to the mentioned ones) fail
> to acquire the same mutex due to timeout. These devices don't handle
> mutex acquisition failure gracefully and return garbage data, causing
> even more chaos.
>
> Improve battery notification handling by merging consecutive battery
> notifications within 10ms using a delayed work, so that they only
> refresh and/or update battery state once. ACPI netlink event and
> notifier call chain are still triggered multiple times in order not to
> break other components. Finally, call power_supply_changed() once and
> lead to a single uevent instead of a bunch, preventing userspace
> programs from causing too much pressure on power supply properties and
> underlying ACPI methods.
>
> Tested-by: Jeffrey W=C3=A4lti <jeffrey@waelti.dev>
> Cc: stable@vger.kernel.org
> Reported-by: Rick <rickk1166@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221065
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
> Changes in v2:
> - Address Sashiko's concerns:
>   - Return from acpi_battery_notification_worker() early when the fifo
>     is empty
>   - Use pr_err_ratelimited() for potential event storms
>   - Add missing `\n' in a printk message
>   - https://sashiko.dev/#/patchset/20260527-b4-acpi-battery-notification-=
v1-0-2303bed8ec0b%40rong.moe
> - Minimalize the critical section of acpi_battery_notify()
> ---
>  drivers/acpi/battery.c | 80 +++++++++++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 70 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index b82dd67d98c9..5f476c074c68 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -14,6 +14,7 @@
>  #include <linux/dmi.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
> +#include <linux/kfifo.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -21,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
>  #include <linux/types.h>
> +#include <linux/workqueue.h>
>
>  #include <linux/unaligned.h>
>
> @@ -43,6 +45,9 @@
>
>  #define MAX_STRING_LENGTH      64
>
> +#define MAX_QUEUED_EVENTS      16
> +#define NOTIF_MERGING_MS       10
> +
>  MODULE_AUTHOR("Paul Diefenbaugh");
>  MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
>  MODULE_DESCRIPTION("ACPI Battery Driver");
> @@ -95,6 +100,8 @@ struct acpi_battery {
>         struct power_supply_desc bat_desc;
>         struct acpi_device *device;
>         struct device *phys_dev;
> +       struct kfifo acpi_notif_fifo;
> +       struct delayed_work acpi_notif_dwork;
>         struct notifier_block pm_nb;
>         struct list_head list;
>         unsigned long update_time;
> @@ -1059,14 +1066,24 @@ static void acpi_battery_refresh(struct acpi_batt=
ery *battery)
>  }
>
>  /* Driver Interface */
> -static void acpi_battery_notify(acpi_handle handle, u32 event, void *dat=
a)
> +static void acpi_battery_notification_worker(struct work_struct *work)
>  {
> -       struct acpi_battery *battery =3D data;
> +       struct acpi_battery *battery =3D container_of(work, struct acpi_b=
attery,
> +                                                   acpi_notif_dwork.work=
);
>         struct acpi_device *device =3D battery->device;
> +       u32 events[MAX_QUEUED_EVENTS];
>         struct power_supply *old;
> +       unsigned int count, i;
>
>         guard(mutex)(&battery->update_lock);
>
> +       count =3D kfifo_out(&battery->acpi_notif_fifo, events, sizeof(eve=
nts));
> +       count /=3D sizeof(events[0]);
> +       if (!count)
> +               return;
> +
> +       pr_debug("merged %u battery notifications within %dms\n", count, =
NOTIF_MERGING_MS);
> +
>         old =3D battery->bat;
>         /*
>          * On Acer Aspire V5-573G notifications are sometimes triggered t=
oo
> @@ -1076,19 +1093,50 @@ static void acpi_battery_notify(acpi_handle handl=
e, u32 event, void *data)
>          */
>         if (battery_notification_delay_ms > 0)
>                 msleep(battery_notification_delay_ms);
> -       if (event =3D=3D ACPI_BATTERY_NOTIFY_INFO)
> -               acpi_battery_refresh(battery);
> +
> +       for (i =3D 0; i < count; i++) {
> +               if (events[i] =3D=3D ACPI_BATTERY_NOTIFY_INFO) {
> +                       acpi_battery_refresh(battery);
> +                       break;
> +               }
> +       }
> +
>         acpi_battery_update(battery, false);
> -       acpi_bus_generate_netlink_event(ACPI_BATTERY_CLASS,
> -                                       dev_name(&device->dev), event,
> -                                       acpi_battery_present(battery));
> -       acpi_notifier_call_chain(ACPI_BATTERY_CLASS, acpi_device_bid(devi=
ce),
> -                                event, acpi_battery_present(battery));
> +
> +       for (i =3D 0; i < count; i++) {
> +               acpi_bus_generate_netlink_event(ACPI_BATTERY_CLASS,
> +                                               dev_name(&device->dev), e=
vents[i],
> +                                               acpi_battery_present(batt=
ery));
> +               acpi_notifier_call_chain(ACPI_BATTERY_CLASS, acpi_device_=
bid(device),
> +                                        events[i], acpi_battery_present(=
battery));
> +       }
> +
>         /* acpi_battery_update could remove power_supply object */
>         if (old && battery->bat)
>                 power_supply_changed(battery->bat);
>  }
>
> +static void acpi_battery_notify(acpi_handle handle, u32 event, void *dat=
a)
> +{
> +       struct acpi_battery *battery =3D data;
> +       bool queued =3D false;
> +
> +       scoped_guard(mutex, &battery->update_lock) {
> +               if (kfifo_avail(&battery->acpi_notif_fifo) >=3D sizeof(ev=
ent)) {
> +                       kfifo_in(&battery->acpi_notif_fifo, &event, sizeo=
f(event));
> +                       queued =3D true;
> +               }
> +       }
> +
> +       if (queued) {
> +               schedule_delayed_work(&battery->acpi_notif_dwork,
> +                                     msecs_to_jiffies(NOTIF_MERGING_MS))=
;

Why can't this be done under update_lock?

It looks like the lock could be held across the entire function and
the "queued" variable could be dropped.

> +       } else {
> +               pr_err_ratelimited("too many battery notifications within=
 %dms\n",
> +                                  NOTIF_MERGING_MS);
> +       }
> +}
> +
>  static int battery_notify(struct notifier_block *nb,
>                           unsigned long mode, void *_unused)
>  {
> @@ -1256,13 +1304,22 @@ static int acpi_battery_probe(struct platform_dev=
ice *pdev)
>
>         device_init_wakeup(&pdev->dev, true);
>
> +       result =3D kfifo_alloc(&battery->acpi_notif_fifo,
> +                            MAX_QUEUED_EVENTS * sizeof(u32), GFP_KERNEL)=
;
> +       if (result)
> +               goto fail_pm;
> +
> +       INIT_DELAYED_WORK(&battery->acpi_notif_dwork, acpi_battery_notifi=
cation_worker);
> +
>         result =3D acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIF=
Y,
>                                                  acpi_battery_notify, bat=
tery);
>         if (result)
> -               goto fail_pm;
> +               goto fail_kfifo;
>
>         return 0;
>
> +fail_kfifo:
> +       kfifo_free(&battery->acpi_notif_fifo);
>  fail_pm:
>         device_init_wakeup(&pdev->dev, false);
>         unregister_pm_notifier(&battery->pm_nb);
> @@ -1279,6 +1336,9 @@ static void acpi_battery_remove(struct platform_dev=
ice *pdev)
>         acpi_dev_remove_notify_handler(battery->device, ACPI_ALL_NOTIFY,
>                                        acpi_battery_notify);
>
> +       cancel_delayed_work_sync(&battery->acpi_notif_dwork);
> +       kfifo_free(&battery->acpi_notif_fifo);
> +
>         device_init_wakeup(&pdev->dev, false);
>         unregister_pm_notifier(&battery->pm_nb);
>
>
> --
> 2.53.0
>
