Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60201388893;
	Mon,  6 Jul 2026 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363896; cv=pass; b=ArO2zg6/RM1Uu6BBgM5VkkBmJYFf3Nxx4vYKi6eBwlcygqKo9yTosd90cR3/qsYS+LIyG2nFFJzG9MBhsbTswbdj7NSiDX3y+T7PxnKEokJt9mvvlj5Bm3TiLnuhcFhxwsqlC/+gG1goCzjRHHPVZFC5ZZg/QGzLaSozq9SNRLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363896; c=relaxed/simple;
	bh=gYAXFv0k8xmEg6jR2J5mUzbRmMh3aCMbVTQg+9zKLCM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UeGgo18Z2I6xwTcU9ZMLn8fKyH2PDMNlO4fFaIwZ+QQBkAYYET9kjVuGuy7bChk6UaZvwbau7WI0Wmsqbl099CPVIeiFGsbIlKw2yn+GDB3YWZ2VSq8/Is2i00hDg4Fl03Z8QgPx+Pp8qomCoandYg6Pd/MaPJCG3m3nvAhqsEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=BA6b6wFv; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="BA6b6wFv"
ARC-Seal: i=1; a=rsa-sha256; t=1783363864; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=F60Dz1chs6FIeL9WQ07BjBszDiTJfIOrGY1nc9WqgIyJdeg1/xlykP00fNxT7nsLisnWvSf54cO2LqB/DNS9JVklxHe7y5vrZZpPuSPTtXwD2yfTABDjmApN9jUxUbCvTqaUIn9V2NoF8xf/7n2kpG1ga8KW+PsEe3AFgUuR/Dg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783363864; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WsWuSkIjrYIwkRT79fYTiqTmuaZ0x7ZznpepJ7PTeSk=; 
	b=b1ysSoKkOu9P6imQ+Nq+cZPZDeiw2AOnHIRPXnDwXsfORRpvDZgayoBPBy/uFqAcL8nhjX8zaAmIABwvsY+BTTxrCMwp6unYIU/ny4rCXaitRqkKfovRbPl0zKVsuq3I69QgFJm0uzOJDMb8OAIl5yb1EA89X6ZHkzmMILP72tY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783363864;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=WsWuSkIjrYIwkRT79fYTiqTmuaZ0x7ZznpepJ7PTeSk=;
	b=BA6b6wFvyKZAfPCKV6lnzxlWzADXdRd3aJGlva88++fe/OkUruGBYwoXws02h5u/
	9m6FxY9gnGdvaeAjVkBJv+FNqd6rZeI9SdpNVcdHRYCt74ocTRi7EbHrzotYUMZZtd5
	bVRSaggwIy5PIzDUfB5Mb1tk1+vYyoJmqlLxWocZIN4jpD71GdGXdrfrWX+um/X3bqm
	2YKNvZfyT2dUZ/5kBHpsTHO4vEQyD/xVrpF5WRa4ztB8C/q0cNnymwYPJSHG6TP1jCi
	quCLuZzpmBoibOeIYhe/j5adQa3IuVTdUxIu+LqnT3reyW8oMxDwQshMqYSD87/f9Sq
	pPc8vOSnnw==
Received: by mx.zohomail.com with SMTPS id 1783363861357667.8549086307319;
	Mon, 6 Jul 2026 11:51:01 -0700 (PDT)
Date: Tue, 07 Jul 2026 02:50:53 +0800
From: Rong Zhang <i@rong.moe>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 =?ISO-8859-1?Q?Jeffrey_W=E4lti?= <jeffrey@waelti.dev>,
 Rick <rickk1166@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/3=5D_ACPI=3A_battery=3A_Me?=
 =?US-ASCII?Q?rge_consecutive_battery_notifications?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAJZ5v0iVkVWfCNMuuE=9egBZvRF31camh_okxe1pWs9TTViPSQ@mail.gmail.com>
References: <20260611-b4-acpi-battery-notification-v3-0-f9390382c5a4@rong.moe> <20260611-b4-acpi-battery-notification-v3-1-f9390382c5a4@rong.moe> <CAJZ5v0iVkVWfCNMuuE=9egBZvRF31camh_okxe1pWs9TTViPSQ@mail.gmail.com>
Message-ID: <425F8FBD-69FF-42BB-8767-AAEB75E51B4B@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hi Rafael,

=E4=BA=8E 2026=E5=B9=B47=E6=9C=887=E6=97=A5 GMT+08:00 02:22:19=EF=BC=8C"Ra=
fael J=2E Wysocki (Intel)" <rafael@kernel=2Eorg> =E5=86=99=E9=81=93=EF=BC=
=9A
>On Wed, Jun 10, 2026 at 10:11=E2=80=AFPM Rong Zhang <i@rong=2Emoe> wrote:
>>
>> It's a very common pattern to emit consecutive battery notifications,
>> for example:
>>
>>     Method (_Qxx, 0, NotSerialized)
>>     {
>>         Notify (BAT0, 0x80) // Status Change
>>         Notify (BAT0, 0x81) // Information Change
>>     }
>>
>> In this case, the current code path will update battery state twice
>> within a short period, which is not optimal, as the same data are
>> fetched twice=2E Moreover, both notifications are likely to call
>> power_supply_changed(), causing power_supply_uevent() to read all
>> battery properties in order to assemble uevents=2E Even worse, after th=
e
>> first uevent reaches userspace, some userspace processes start to read
>> all battery properties in order to refresh their internal states, which
>> competes with the second notification's handling and uevent assembling=
=2E
>>
>> This generates significant pressure on _STA, _BST and _BIX/_BIF methods=
=2E
>> Not only that, power_supply_ext properties may also rely on some other
>> ACPI methods, so both uevent assembling and userspace processes call
>> them=2E It becomes a nightmare when all these methods share the same AC=
PI
>> mutex protecting EC accesses and hence vulnerable to lock starvation=2E
>> This is exactly the case of some Lenovo devices, where the mentioned EC
>> query pattern eventually leads to a catastrophic situation that a bunch
>> of ACPI methods (including but not limited to the mentioned ones) fail
>> to acquire the same mutex due to timeout=2E These devices don't handle
>> mutex acquisition failure gracefully and return garbage data, causing
>> even more chaos=2E
>>
>> Improve battery notification handling by merging consecutive battery
>> notifications within 10ms using a delayed work, so that they only
>> refresh and/or update battery state once=2E ACPI netlink event and
>> notifier call chain are still triggered multiple times in order not to
>> break other components=2E Finally, call power_supply_changed() once and
>> lead to a single uevent instead of a bunch, preventing userspace
>> programs from causing too much pressure on power supply properties and
>> underlying ACPI methods=2E
>>
>> Tested-by: Jeffrey W=C3=A4lti <jeffrey@waelti=2Edev>
>> Cc: stable@vger=2Ekernel=2Eorg
>> Reported-by: Rick <rickk1166@gmail=2Ecom>
>> Closes: https://bugzilla=2Ekernel=2Eorg/show_bug=2Ecgi?id=3D221065
>> Signed-off-by: Rong Zhang <i@rong=2Emoe>
>> ---
>> Changes in v2:
>> - Address Sashiko's concerns:
>>   - Return from acpi_battery_notification_worker() early when the fifo
>>     is empty
>>   - Use pr_err_ratelimited() for potential event storms
>>   - Add missing `\n' in a printk message
>>   - https://sashiko=2Edev/#/patchset/20260527-b4-acpi-battery-notificat=
ion-v1-0-2303bed8ec0b%40rong=2Emoe
>> - Minimalize the critical section of acpi_battery_notify()
>> ---
>>  drivers/acpi/battery=2Ec | 80 ++++++++++++++++++++++++++++++++++++++++=
+++-------
>>  1 file changed, 70 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/acpi/battery=2Ec b/drivers/acpi/battery=2Ec
>> index b82dd67d98c9=2E=2E5f476c074c68 100644
>> --- a/drivers/acpi/battery=2Ec
>> +++ b/drivers/acpi/battery=2Ec
>> @@ -14,6 +14,7 @@
>>  #include <linux/dmi=2Eh>
>>  #include <linux/jiffies=2Eh>
>>  #include <linux/kernel=2Eh>
>> +#include <linux/kfifo=2Eh>
>>  #include <linux/list=2Eh>
>>  #include <linux/module=2Eh>
>>  #include <linux/mutex=2Eh>
>> @@ -21,6 +22,7 @@
>>  #include <linux/slab=2Eh>
>>  #include <linux/suspend=2Eh>
>>  #include <linux/types=2Eh>
>> +#include <linux/workqueue=2Eh>
>>
>>  #include <linux/unaligned=2Eh>
>>
>> @@ -43,6 +45,9 @@
>>
>>  #define MAX_STRING_LENGTH      64
>>
>> +#define MAX_QUEUED_EVENTS      16
>> +#define NOTIF_MERGING_MS       10
>> +
>>  MODULE_AUTHOR("Paul Diefenbaugh");
>>  MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse=2Ede>");
>>  MODULE_DESCRIPTION("ACPI Battery Driver");
>> @@ -95,6 +100,8 @@ struct acpi_battery {
>>         struct power_supply_desc bat_desc;
>>         struct acpi_device *device;
>>         struct device *phys_dev;
>> +       struct kfifo acpi_notif_fifo;
>> +       struct delayed_work acpi_notif_dwork;
>>         struct notifier_block pm_nb;
>>         struct list_head list;
>>         unsigned long update_time;
>> @@ -1059,14 +1066,24 @@ static void acpi_battery_refresh(struct acpi_ba=
ttery *battery)
>>  }
>>
>>  /* Driver Interface */
>> -static void acpi_battery_notify(acpi_handle handle, u32 event, void *d=
ata)
>> +static void acpi_battery_notification_worker(struct work_struct *work)
>>  {
>> -       struct acpi_battery *battery =3D data;
>> +       struct acpi_battery *battery =3D container_of(work, struct acpi=
_battery,
>> +                                                   acpi_notif_dwork=2E=
work);
>>         struct acpi_device *device =3D battery->device;
>> +       u32 events[MAX_QUEUED_EVENTS];
>>         struct power_supply *old;
>> +       unsigned int count, i;
>>
>>         guard(mutex)(&battery->update_lock);
>>
>> +       count =3D kfifo_out(&battery->acpi_notif_fifo, events, sizeof(e=
vents));
>> +       count /=3D sizeof(events[0]);
>> +       if (!count)
>> +               return;
>> +
>> +       pr_debug("merged %u battery notifications within %dms\n", count=
, NOTIF_MERGING_MS);
>> +
>>         old =3D battery->bat;
>>         /*
>>          * On Acer Aspire V5-573G notifications are sometimes triggered=
 too
>> @@ -1076,19 +1093,50 @@ static void acpi_battery_notify(acpi_handle han=
dle, u32 event, void *data)
>>          */
>>         if (battery_notification_delay_ms > 0)
>>                 msleep(battery_notification_delay_ms);
>> -       if (event =3D=3D ACPI_BATTERY_NOTIFY_INFO)
>> -               acpi_battery_refresh(battery);
>> +
>> +       for (i =3D 0; i < count; i++) {
>> +               if (events[i] =3D=3D ACPI_BATTERY_NOTIFY_INFO) {
>> +                       acpi_battery_refresh(battery);
>> +                       break;
>> +               }
>> +       }
>> +
>>         acpi_battery_update(battery, false);
>> -       acpi_bus_generate_netlink_event(ACPI_BATTERY_CLASS,
>> -                                       dev_name(&device->dev), event,
>> -                                       acpi_battery_present(battery));
>> -       acpi_notifier_call_chain(ACPI_BATTERY_CLASS, acpi_device_bid(de=
vice),
>> -                                event, acpi_battery_present(battery));
>> +
>> +       for (i =3D 0; i < count; i++) {
>> +               acpi_bus_generate_netlink_event(ACPI_BATTERY_CLASS,
>> +                                               dev_name(&device->dev),=
 events[i],
>> +                                               acpi_battery_present(ba=
ttery));
>> +               acpi_notifier_call_chain(ACPI_BATTERY_CLASS, acpi_devic=
e_bid(device),
>> +                                        events[i], acpi_battery_presen=
t(battery));
>> +       }
>> +
>>         /* acpi_battery_update could remove power_supply object */
>>         if (old && battery->bat)
>>                 power_supply_changed(battery->bat);
>>  }
>>
>> +static void acpi_battery_notify(acpi_handle handle, u32 event, void *d=
ata)
>> +{
>> +       struct acpi_battery *battery =3D data;
>> +       bool queued =3D false;
>> +
>> +       scoped_guard(mutex, &battery->update_lock) {
>> +               if (kfifo_avail(&battery->acpi_notif_fifo) >=3D sizeof(=
event)) {
>> +                       kfifo_in(&battery->acpi_notif_fifo, &event, siz=
eof(event));
>> +                       queued =3D true;
>> +               }
>> +       }
>> +
>> +       if (queued) {
>> +               schedule_delayed_work(&battery->acpi_notif_dwork,
>> +                                     msecs_to_jiffies(NOTIF_MERGING_MS=
));
>
>Why can't this be done under update_lock?
>
>It looks like the lock could be held across the entire function and
>the "queued" variable could be dropped=2E

Thanks for your review!

I originally would like to minimize the critical section here, thus schedu=
le_delayed_work() was moved out=2E

It also makes sense to move it back for readability and simplicity=2E I wi=
ll resubmit a v4 with the change=2E

Thanks,
Rong

>
>> +       } else {
>> +               pr_err_ratelimited("too many battery notifications with=
in %dms\n",
>> +                                  NOTIF_MERGING_MS);
>> +       }
>> +}
>> +
>>  static int battery_notify(struct notifier_block *nb,
>>                           unsigned long mode, void *_unused)
>>  {
>> @@ -1256,13 +1304,22 @@ static int acpi_battery_probe(struct platform_d=
evice *pdev)
>>
>>         device_init_wakeup(&pdev->dev, true);
>>
>> +       result =3D kfifo_alloc(&battery->acpi_notif_fifo,
>> +                            MAX_QUEUED_EVENTS * sizeof(u32), GFP_KERNE=
L);
>> +       if (result)
>> +               goto fail_pm;
>> +
>> +       INIT_DELAYED_WORK(&battery->acpi_notif_dwork, acpi_battery_noti=
fication_worker);
>> +
>>         result =3D acpi_dev_install_notify_handler(device, ACPI_ALL_NOT=
IFY,
>>                                                  acpi_battery_notify, b=
attery);
>>         if (result)
>> -               goto fail_pm;
>> +               goto fail_kfifo;
>>
>>         return 0;
>>
>> +fail_kfifo:
>> +       kfifo_free(&battery->acpi_notif_fifo);
>>  fail_pm:
>>         device_init_wakeup(&pdev->dev, false);
>>         unregister_pm_notifier(&battery->pm_nb);
>> @@ -1279,6 +1336,9 @@ static void acpi_battery_remove(struct platform_d=
evice *pdev)
>>         acpi_dev_remove_notify_handler(battery->device, ACPI_ALL_NOTIFY=
,
>>                                        acpi_battery_notify);
>>
>> +       cancel_delayed_work_sync(&battery->acpi_notif_dwork);
>> +       kfifo_free(&battery->acpi_notif_fifo);
>> +
>>         device_init_wakeup(&pdev->dev, false);
>>         unregister_pm_notifier(&battery->pm_nb);
>>
>>
>> --
>> 2=2E53=2E0
>>
