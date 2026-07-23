Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD86D3955F0
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 05:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783869; cv=none; b=fdElNHim1zBUOSHpq3bKpxRtuczUU3aoK1T5cfue+PCvaEQQ0VDBus79QWMpnx5Lx9bLntAVmopOCUtM4uRNgYacLw9pjzE6Zi9Hutb+kZlIFrL9NAjncZyYn93KZ1JghwUj/enhMkh9J4/Wd4opnu81J1jfvj3HE2EPn6HXd2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783869; c=relaxed/simple;
	bh=GsyO0B0tOmW3YR5e1MtpUWb80foN14e9R90H/xa0Jfw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GwLRFeGsgLP4JvKlfZmmO23MMXh17yJCA4DYaFxD0QaHdZHfpco2PmEuu/m/QJ6uL/4U7+dDRilWpocZJ8w/3mAui+9lGDMjpWTg4jRnEThEXDROAYEwaA9JvmEBe1hziZ5sffa6vaO1wQdb7TCzdGHzAMN4qrL8iiIVHb7k3/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kggfFqWh; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kggfFqWh"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e6a434cabso19410385a.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 22:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783867; x=1785388667; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vuP9/gSqdX9lmwz03muUgaTWRqk+7NadRGuJuqH6n7o=;
        b=kggfFqWhm8Q7Q1O7Q2jA6xjbvCMmxm7mv5v27ZXoRA2N66pypcEtucvhys0OriCBmJ
         RXVuU6LrmN4VBjbchSIOTgIbBKOybWzvAchnrr89mrFpLcoRRrZTG1P7DGSyVUux69k0
         Zml0vA8k5nwLYkTQgFX99ZCRP5oxcZEjGb04WMltcd0be7sKc0fQnVvg1qBZjwfTJwNB
         hkUhbiOaXATuZmYRpY+SqibrAw1n32Ae1o9QnP5aezBd4+x1HKSyTV1Fbc/K+97UYrFy
         YbitOAOZ7T/MX31nbxpngLD7j0mWGpLfPBSIaJgGGfoPr73sm4UTuwAfH1/n9grGQBv0
         UHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783867; x=1785388667;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vuP9/gSqdX9lmwz03muUgaTWRqk+7NadRGuJuqH6n7o=;
        b=P3vlHkwRiWHFCdqtQDQ39JyHsIwyTenlbB05RhO9S3XtF/2kg45vm4PQimQHi08IG6
         IoXjNU9lzhHf1ndZAQNXiR4OyTSvA87aNf9DXeabmu1hsCGvHOnyOkg5AmIJ1LCp/4d6
         GlVoT0+BDHGWDnCAA9zwVY71P9AdLJKbpKHWAzYzMXUk6psdAi2Lrl4KEJwaKWetSnzK
         dbIhYhQfDcrcfRwMuvIIRF0CVPt5qL4CDcYlnFpDMs5SVxFDd9hiyASFd3kUykg2L706
         tC0DJaUhiv6CIJenkk08KR8WcmHJ4F6F+JFn3vFV+3MnpVfYFcOGdTC7FgZDiZMub1CN
         CcOg==
X-Forwarded-Encrypted: i=1; AHgh+RrRqxP1YxAoybBeB/9p6j9oECMPbowIXZTaw8ygvMNR/ePkt3/PuAkKOKb+Z4zJ41qFW1fIQs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXEQgBuTXmt2Bry+vp62OU9R/RgnjjXXzxuAC1V4JqSj4M3iJM
	z35pEEvF0h44CFDznPsJRG9bzeb9WwUkF0NLEirZnHt1zUClUyZF0miD
X-Gm-Gg: AR+sD11QZ4uDCFRqyS/f51Hz2Jm0B9ot5/5ogJkRqpLJ2FBaOElTY2UTYMbUfxBjrZ6
	Z8T1I6E9lpWVbvm3CjSZHMmPQbQRs/fIsFR+WSfkP3pa39+G22PYk/bWwDCy53ITqy6HSklD79J
	6GwdvKeur1U8Pzgm4gGntKZQxwE4chc9Z9Ch/u9kHnNPxR/EmEN04InxKvbEV+dV2yYkYa6gpYw
	qZsGJlTM/3zCR/e3Rzj1h5AypkaRzxrR7JcVdH/ATtBL0C2Y7nDgNdwg6ZzEMNmKFAV9Q4FG6oC
	VWNYfauqeyt3LD87FbFSOibe6NSCepLhKmAADOLnCQgAOhd0TnXalNUC9gCtCg9PJOZtDb/qS8K
	B31QiO8wPvP/wrBC0xerhAhV9G2hWBtcppc0xkVC3T0VZQcr7WxlH/RP/pRYNQKhCCO5s+nQ1ns
	Ny9KS90Gs7ODNkgVd0Y+5vzcV4zzSjSY5noJy0BREkXw==
X-Received: by 2002:a05:620a:a1d6:10b0:930:f889:3093 with SMTP id af79cd13be357-93103a60b96mr122133485a.94.1784783866545;
        Wed, 22 Jul 2026 22:17:46 -0700 (PDT)
Received: from smtpclient.apple ([2601:985:4601:5df0:5dea:ad0e:8d05:3c1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a88b88sm332236285a.42.2026.07.22.22.17.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2026 22:17:46 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH can v3] can: gs_usb: fix hardware timestamp state for
 mixed channels
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <da89a51e-3e42-4bcb-8e80-c992b1887ac8@linux.dev>
Date: Thu, 23 Jul 2026 01:17:14 -0400
Cc: mkl@pengutronix.de,
 mailhol@kernel.org,
 uwu@coelacanthus.name,
 kees@kernel.org,
 linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <97232020-922B-42BE-B050-A42B6FF40B85@gmail.com>
References: <20260720184042.1712217-1-shuangpeng.kernel@gmail.com>
 <da89a51e-3e42-4bcb-8e80-c992b1887ac8@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
X-Mailer: Apple Mail (2.3864.600.51.1.1)



> On Jul 20, 2026, at 18:35, Vadim Fedorenko <vadim.fedorenko@linux.dev> =
wrote:
>=20
> On 20.07.2026 19:40, Shuangpeng Bai wrote:
>> The hardware timestamp state is shared by struct gs_usb, but
>> gs_can_open() and gs_can_close() tie its initialization and teardown =
to
>> active_channels and to the feature bits of the channel being opened =
or
>> closed.
>> This is wrong for mixed-channel devices in both directions. If a
>> non-timestamp channel opens first, a later timestamp-capable channel =
does
>> not initialize the shared cyclecounter/timecounter because =
active_channels
>> is already non-zero. Timestamp RX then calls timecounter_cyc2time() =
with
>> parent->tc.cc unset.
>> Conversely, if a timestamp-capable channel opens first and starts the
>> shared delayed work, then closes while a non-timestamp channel =
remains
>> active, disconnect may close the non-timestamp channel last. The old
>> teardown check skips gs_usb_timestamp_stop() in that case and frees
>> struct gs_usb while the delayed work timer is still queued.
>> Count the number of active timestamp-capable channels instead. Start =
the
>> shared timestamp state when the first such channel opens, stop it =
when the
>> last such channel closes, and unwind the count if open fails.
>> Initialize the shared timestamp lock and delayed work once during =
probe.
>> The first timestamp-capable channel may be opened while RX URBs are
>> already active, so guard the count and timecounter access with the =
same
>> lock. Keep the count zero until timecounter_init() completes, and =
make RX
>> and delayed work skip the timecounter while the count is zero.
>> Fixes: 45dfa45f52e6 ("can: gs_usb: add RX and TX hardware timestamp =
support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>> ---
>> Changes in v3:
>> - Drop Suggested-by tag.
>> - Move active_timestamp_channels management into the timestamp =
init/stop
>>   helpers.
>> - Protect active_timestamp_channels with tc_lock, and keep it zero =
until
>>   timecounter_init() has completed.
>> - Make RX timestamp conversion and the delayed work skip the =
timecounter
>>   while no timestamp-capable channel is active.
>> - Initialize the shared timestamp lock and delayed work once during =
probe.
>> Changes in v2:
>> - Count active timestamp-capable channels instead of tracking only =
whether
>>   the shared timestamp worker has been started.
>> - Stop the shared timestamp worker when the last timestamp-capable =
channel
>>   closes, even if non-timestamp channels remain open.
>> - Unwind the timestamp-capable channel count on gs_can_open() =
failures.
>>  drivers/net/can/usb/gs_usb.c | 81 =
++++++++++++++++++++++++------------
>>  1 file changed, 54 insertions(+), 27 deletions(-)
>> diff --git a/drivers/net/can/usb/gs_usb.c =
b/drivers/net/can/usb/gs_usb.c
>> index ec9a7cbbbc69..be25d82cedcb 100644
>> --- a/drivers/net/can/usb/gs_usb.c
>> +++ b/drivers/net/can/usb/gs_usb.c
>> @@ -337,6 +337,7 @@ struct gs_usb {
>>     unsigned int hf_size_rx;
>>   u8 active_channels;
>> + u8 active_timestamp_channels;
>>   u8 channel_cnt;
>>     unsigned int pipe_in;
>> @@ -447,14 +448,20 @@ static void gs_usb_timestamp_work(struct =
work_struct *work)
>>  {
>>   struct delayed_work *delayed_work =3D to_delayed_work(work);
>>   struct gs_usb *parent;
>> + bool active;
>>     parent =3D container_of(delayed_work, struct gs_usb, timestamp);
>>   spin_lock_bh(&parent->tc_lock);
>> - timecounter_read(&parent->tc);
>> + active =3D parent->active_timestamp_channels;
>> + if (active) {
>> + timecounter_read(&parent->tc);
>> + active =3D parent->active_timestamp_channels;
>> + }
>>   spin_unlock_bh(&parent->tc_lock);
>>  - schedule_delayed_work(&parent->timestamp,
>> -       GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
>> + if (active)
>> + schedule_delayed_work(&parent->timestamp,
>> +       GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
>>  }
>>    static void gs_usb_skb_set_timestamp(struct gs_can *dev,
>> @@ -465,6 +472,11 @@ static void gs_usb_skb_set_timestamp(struct =
gs_can *dev,
>>   u64 ns;
>>     spin_lock_bh(&parent->tc_lock);
>> + if (!parent->active_timestamp_channels) {
>> + spin_unlock_bh(&parent->tc_lock);
>> + return;
>> + }
>> +
>>   ns =3D timecounter_cyc2time(&parent->tc, timestamp);
>>   spin_unlock_bh(&parent->tc_lock);
>>  @@ -474,25 +486,40 @@ static void gs_usb_skb_set_timestamp(struct =
gs_can *dev,
>>  static void gs_usb_timestamp_init(struct gs_usb *parent)
>>  {
>>   struct cyclecounter *cc =3D &parent->cc;
>> + bool first =3D false;
>>  - cc->read =3D gs_usb_timestamp_read;
>> - cc->mask =3D CYCLECOUNTER_MASK(32);
>> - cc->shift =3D 32 - bits_per(NSEC_PER_SEC / =
GS_USB_TIMESTAMP_TIMER_HZ);
>> - cc->mult =3D clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, =
cc->shift);
>> -
>> - spin_lock_init(&parent->tc_lock);
>>   spin_lock_bh(&parent->tc_lock);
>> - timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
>> + if (!parent->active_timestamp_channels) {
>> + cc->read =3D gs_usb_timestamp_read;
>> + cc->mask =3D CYCLECOUNTER_MASK(32);
>> + cc->shift =3D 32 - bits_per(NSEC_PER_SEC /
>> +       GS_USB_TIMESTAMP_TIMER_HZ);
>> + cc->mult =3D clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ,
>> +        cc->shift);
>> +
>> + timecounter_init(&parent->tc, &parent->cc,
>> +  ktime_get_real_ns());
>> + first =3D true;
>> + }
>> + parent->active_timestamp_channels++;
>>   spin_unlock_bh(&parent->tc_lock);
>>  - INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
>> - schedule_delayed_work(&parent->timestamp,
>> -       GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
>> + if (first)
>> + schedule_delayed_work(&parent->timestamp,
>> +       GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
>>  }
>>    static void gs_usb_timestamp_stop(struct gs_usb *parent)
>>  {
>> - cancel_delayed_work_sync(&parent->timestamp);
>> + bool last;
>> +
>> + spin_lock_bh(&parent->tc_lock);
>> + parent->active_timestamp_channels--;
>> + last =3D !parent->active_timestamp_channels;
>> + spin_unlock_bh(&parent->tc_lock);
>> +
>> + if (last)
>> + cancel_delayed_work_sync(&parent->timestamp);
>>  }
>> =20
>=20
> tc_lock serializes active_timestamp_channels updates, but this work =
manipulation
> is not protected. Imagine CPU0 doing gs_usb_timestamp_stop while CPU1 =
is doing
> gs_can_open:
>=20
>    CPU0     CPU1
>=20
> gs_usb_timestamp_stop() gs_usb_timestamp_init()
>  spin_lock_bh(&tc_lock);
>  active_timestamp_channels--
>  last =3D true
>  spin_unlock_bh(&tc_lock);
> ... spin_lock_bh(&tc_lock)
> ...   timecounter_init()
> ...   first =3D true;
> ... spin_unlock_bh(&tc_lock)
> ... schedule_delayed_work()
>  cancel_delayed_work_sync()
>=20
> And the device will have no worker while active_timestamp_channels is =
not 0.
>=20
> I think we have to find another way of synchronization here.
>=20

Thanks for your check.=20

I thought these paths were already serialized by RTNL through
ndo_open/ndo_stop. If additional synchronization is needed,=20
do you have any suggestions?

>=20
>>  static void gs_update_state(struct gs_can *dev, struct can_frame =
*cf)
>> @@ -980,10 +1007,10 @@ static int gs_can_open(struct net_device =
*netdev)
>>     can_rx_offload_enable(&dev->offload);
>>  - if (!parent->active_channels) {
>> - if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
>> - gs_usb_timestamp_init(parent);
>> + if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
>> + gs_usb_timestamp_init(parent);
>>  + if (!parent->active_channels) {
>>   for (i =3D 0; i < GS_MAX_RX_URBS; i++) {
>>   u8 *buf;
>>  @@ -1094,12 +1121,11 @@ static int gs_can_open(struct net_device =
*netdev)
>>  out_usb_free_urb:
>>   usb_free_urb(urb);
>>  out_usb_kill_anchored_urbs:
>> - if (!parent->active_channels) {
>> - usb_kill_anchored_urbs(&parent->rx_submitted);
>> + if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
>> + gs_usb_timestamp_stop(parent);
>>  - if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
>> - gs_usb_timestamp_stop(parent);
>> - }
>> + if (!parent->active_channels)
>> + usb_kill_anchored_urbs(&parent->rx_submitted);
>>     can_rx_offload_disable(&dev->offload);
>>   close_candev(netdev);
>> @@ -1152,12 +1178,11 @@ static int gs_can_close(struct net_device =
*netdev)
>>     /* Stop polling */
>>   parent->active_channels--;
>> - if (!parent->active_channels) {
>> - usb_kill_anchored_urbs(&parent->rx_submitted);
>> + if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
>> + gs_usb_timestamp_stop(parent);
>>  - if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
>> - gs_usb_timestamp_stop(parent);
>> - }
>> + if (!parent->active_channels)
>> + usb_kill_anchored_urbs(&parent->rx_submitted);
>>     /* Stop sending URBs */
>>   usb_kill_anchored_urbs(&dev->tx_submitted);
>> @@ -1577,6 +1602,8 @@ static int gs_usb_probe(struct usb_interface =
*intf,
>>   parent->channel_cnt =3D icount;
>>     init_usb_anchor(&parent->rx_submitted);
>> + spin_lock_init(&parent->tc_lock);
>> + INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
>>     usb_set_intfdata(intf, parent);
>>   parent->udev =3D udev;


