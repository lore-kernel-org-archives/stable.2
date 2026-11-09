Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794186842;
	b=I6L2ZWPuC0Ckx05nr4rJ945BrncBhBCzo4EOEONJdQv/yDuVEK3AVcxqq3Vh6XP/9RjB
	 /6+No7h1w6UtixjOkq4+mhrI9vbva/11hOBzvh9j7vID4PkOaL9/ocV+YKTp5FkYGUbEZ
	 Dd+BttL3Ykf0en9Grgkp709reTmPLS6dLwv3Kxs7em/A7dji0O67aLduMJSASTNwCc2l1
	 QgglTDdEq/KIU9XpbOkzP6RbBOeq5sDXDDks7cI+RGfWOkOjIEYap1ixSAfhETnHn5FIx
	 9F0YugRQk4DJf8mBmjLZWWLeN6IUBc9qvIfRI2kRjz5XfvUhrA80iQsWME4vY5j552g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794186842;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=mVqi2RplJqC9QdgfFtsdwMVPxwNrbdCkTESnwrts9uo=;
	b=hYLwOXl7qHdLjVkGF2ej/bWmR09LInFw6L4V8vN4ZCCiIwyEjISSJZxufDVXGHC4S6xA
	 qXOXijpSTUSGQvH4DdA8qmPwAwmbXFJjJAwwttkvEYoKlbhL+HeEZmrpiVmlpXQ1tJ31j
	 94lvKhAdag20q3ScI7a56EllTd8q0uwqOOwzMLm9UHXkA3FN9CVzBrhEKiH90WsgDw6aw
	 lq/N2ieIzowNG9mc/hjOFfrKu+jMDAezy4mIjsq0VxQ3hRa0sXdALdSl08wuQp/26rEmG
	 c9kRq5BISvF9+vwdzJVTgNfk7y1ljdBhepRAkUXWiH3PsLCS1BEXd+UtnaTuUWVKmQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wiGvwk4x;
	arc=none smtp.remote-ip=95.215.58.198
Received: from mta1.migadu.com (out-198.mta1.migadu.com [95.215.58.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BD9606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 01:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15BD9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wiGvwk4x
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EWP48PASoTLGXrCYzvC4DPqeMouUPYhHoQTdcbU/rTM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794186839; v=1; x=1794791639;
 b=wiGvwk4xQnRVfkaKWag29hQp/qzcZhyNFf6THZUJJkFi79m8AUB3preCoZGNueQQs2uE0+ke
 c3qNQ2UOWXbQfmdLYHx7UjEmcH6CkVcRIYfJiRZVAXBuJ6a+sygCR/tPpCTF15WJ+OhgCQqPka3
 LMTrvn3FRUeKZgw+F887JfzE=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 469add5eee026373;
	Mon, 09 Nov 2026 01:13:58 +0000
X-Mizu-Trace-ID: 469add5eee026373
X-Migadu-Flow: FLOW_OUT
Message-ID: <725a6890-6460-42d0-8cd8-5aad8a75f3f2@linux.dev>
Date: Mon, 9 Nov 2026 02:13:53 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: Ignore kbd backlight read-back on
 rejected writes
To: Antheas Kapenekakis <lkml@antheas.dev>, tarrihmoad@proton.me
Cc: Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Sercan GOKMEN <gokmensercan@gmail.com>, Burak Goncu <burakgon12@gmail.com>,
 Denis Benato <benato.denis96@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261108-asus-wmi-kbd-readback-v1-1-bf38f6400ade@proton.me>
 <CAGwozwENHjfYUJMT5CP_Jvp6fYr54jxrgbrZBKfSH+8K_3wqMA@mail.gmail.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <CAGwozwENHjfYUJMT5CP_Jvp6fYr54jxrgbrZBKfSH+8K_3wqMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/8/26 15:05, Antheas Kapenekakis wrote:
> On Sun, 8 Nov 2026 at 14:44, Moad Tarrih via B4 Relay
> <devnull+tarrihmoad.proton.me@kernel.org> wrote:
>> From: Moad Tarrih <tarrihmoad@proton.me>


Hi Moad!

>> On the ASUS ROG Strix G18 G814FP, the brightness attribute of
>> asus::kbd_backlight always reads 0, and every read breaks the keyboard
>> brightness keys.

Is this from a fully updated machine? Bios especially...

>> The firmware reports the keyboard backlight WMI device as present, but
>> DSTS(0x50021) returns 0x50000 (presence bit set, level 0) whatever level
>> the keyboard shows, and DEVS(0x50021, 0x80..0x83) returns
>> ASUS_WMI_UNSUPPORTED_METHOD for every level. The backlight is driven by
>> hid-asus through its asus-wmi listener instead.
>>
>> Since commit fac55d29581f ("platform/x86: asus-wmi: Add support for
>> multiple kbd led handlers"), kbd_led_get() stores the level it reads in
>> kbd_led_wk, and the brightness key handlers step from kbd_led_wk. Any
>> read of the attribute, for example by a desktop environment or
>> systemd-backlight, therefore resets the stored level to 0, and the next
>> brightness-up press sets the keyboard to the lowest level instead of
>> stepping up:
>>
>>   # echo 3 > /sys/class/leds/asus::kbd_backlight/brightness
>>   (keyboard goes to high)
>>   # cat /sys/class/leds/asus::kbd_backlight/brightness
>>   0
>>   (brightness-up key: keyboard drops to low)
>>
>> systemd-backlight also saves 0 at shutdown, so the level is lost across
>> reboots.
>>
>> Remember when the firmware rejects a write with -ENODEV, and from then
>> on return the stored level from kbd_led_get(), as is already done when
>> the WMI device is not available. The first write is queued right after
>> the LED is registered, so the read-back is only trusted before any
>> level has been set.

I would like to avoid issuing writes that we already know are going
to fail.

I think that if after testing the updated BIOS this problem is still
there the best thing to do is to implement a quirk and match by
model.

ROG laptops are basically all hid-controlled, no idea why that
method returns supported in yours.

A very interesting question would be "is it only FP or all G814 2025 are the same?"

>> The cause was found and this fix written with the help of an AI coding
>> assistant (Claude Code, Claude Opus 5.5). I reviewed the change and
>> tested it on the affected laptop.
>>
>> Fixes: fac55d29581f ("platform/x86: asus-wmi: Add support for multiple kbd led handlers")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Moad Tarrih <tarrihmoad@proton.me>
>> ---
>> Tested on an ASUS ROG Strix G18 (board G814FP, BIOS G814FP.317,
>> keyboard 0b05:19b6) only, on 7.2.14 as a DKMS module. With the patch,
>> the attribute reads back low, medium and high correctly, the brightness
>> keys step from the real level, and the level survives suspend/resume
>> and reboots. Build-tested with W=1 against pdx86 for-next
>> (c339f4010dea): no warnings. checkpatch --strict is clean.
>>
>> Limitation: a machine whose firmware rejects writes but changes the
>> brightness by itself would now report a stale level. I don't know of
>> such a machine.
>>
>> Sercan GOKMEN posted a patch for the same symptom on the B9406CAA:
>> https://lore.kernel.org/platform-driver-x86/20261030-b4-asus-wmi-b9406caa-kbd-readback-v2-1-ca93bb9039f6@gmail.com/
>> On that board writes succeed and only the read-back is constant, so it
>> uses a DMI quirk. The two patches are complementary: the rejected-write
>> check doesn't catch the B9406CAA, and the quirk doesn't catch the
>> G814FP. They touch the same condition in kbd_led_get(), so whichever
>> lands second needs a trivial rebase; I'm happy to rebase onto it.
>>
>> This touches different code from Bartu Alev's pending series
>> '[PATCH 0/2] platform/x86: asus-wmi: fix and unify keyboard brightness
>> key handling' and applies cleanly before or after it.
>>
>> A more general option would be to ignore the WMI read-back whenever a
>> hid-asus listener is registered, since hid-asus drives the backlight on
>> the G814FP. I didn't do that because it could report stale levels on
>> machines where the firmware does change the brightness itself, but I can
>> rework the patch that way if preferred.
>>
>> AI assistance: Claude Code was used over several sessions to trace the
>> read-back path in asus-wmi and hid-asus, run the debugfs DSTS/DEVS
>> probes, write the patch and draft this message. Testing and final
>> review were done by me on the hardware.
> Try to rewrite the commit message in your own words. It is hard to
> follow. This patch adds too much code.
>
> From what you are saying, your device always returns 0. So that is the
> bug. The code already has handling (as you said) for both the case
> reads are bugged and the wmi device is missing.

Hello Antheas,

No: the bug is that the TUF keyboard brightness devid is answering
with the presence bit set, that after removal of said bit becomes 0
for the user/caller.

If that interface cannot be used it shouldn't return the presence
bit (or should return the unsupported feature 0xFFFFFFFE),
and writes are rejected so we know ASUS intention here.

> Therefore, in your case the proper fix is to either piggyback on that
> quirk so that we do not read that device or, if you want to also avoid
> logged errors, introduce a small new quirk that sets kbd_led_avail to
> false and does not initialize a WMI device. The latter is an ideal
> solution though, minor errors in dmesg due to bios misconfiguration
> are common and harmless. The simplest solution for you is to use the
> read quirk.
>
> In both cases, if Sercan's patches are queued, find Ilpo's remote and
> base on that so you get no conflicts
>
> We cannot use a heuristic for when hid-asus is present. The device
> reports a WMI handle. There are devices with multiple aura devices on
> them.

I think we can, but I don't think it's a good idea.

> If it is found that a lot of devices report bogus reads, a potential
> future approach is to remove readback from WMI altogether and always
> use the bios stored value. This allows dropping the read quirk
> altogether.

The bios stored value?

> Best,
> Antheas
>
>> ---
>>  drivers/platform/x86/asus-wmi.c | 24 ++++++++++++++++++++----
>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>> index b33ebdb21aa2..c47ebc1f184a 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -258,6 +258,7 @@ struct asus_wmi {
>>         struct led_classdev kbd_led;
>>         int kbd_led_wk;
>>         bool kbd_led_notify;
>> +       bool kbd_led_write_rejected;
>>         bool kbd_led_avail;
>>         bool kbd_led_registered;
>>         struct led_classdev lightbar_led;
>> @@ -1724,8 +1725,9 @@ static struct asus_hid_ref asus_ref = {
>>         .listeners = LIST_HEAD_INIT(asus_ref.listeners),
>>         .asus = NULL,
>>         /*
>> -        * Protects .asus, .asus.kbd_led_{wk,notify}, and .listener refs. Other
>> -        * asus variables are read-only after .asus is set.
>> +        * Protects .asus, .asus.kbd_led_{wk,notify,write_rejected}, and
>> +        * .listener refs. Other asus variables are read-only after .asus is
>> +        * set.
>>          *
>>          * The led cdev device is not protected because it calls backlight_get
>>          * during initialization, which would result in a nested lock attempt.
>> @@ -1896,10 +1898,24 @@ static enum led_brightness tpd_led_get(struct led_classdev *led_cdev)
>>  static void kbd_led_update(struct asus_wmi *asus)
>>  {
>>         int ctrl_param = 0;
>> +       int err;
>>
>>         scoped_guard(spinlock_irqsave, &asus_ref.lock)
>>                 ctrl_param = 0x80 | (asus->kbd_led_wk & 0x7F);
>> -       asus_wmi_set_devstate(ASUS_WMI_DEVID_KBD_BACKLIGHT, ctrl_param, NULL);
>> +       err = asus_wmi_set_devstate(ASUS_WMI_DEVID_KBD_BACKLIGHT, ctrl_param,
>> +                                   NULL);
>> +
>> +       /*
>> +        * Some firmware reports the device as present but rejects writes,
>> +        * and its read-back does not follow the level set through other
>> +        * paths, such as hid-asus. Stop trusting the read-back once a
>> +        * write has been rejected.
>> +        */
>> +       if (err == -ENODEV) {
>> +               pr_debug("Keyboard backlight write rejected, ignoring read-back\n");
>> +               scoped_guard(spinlock_irqsave, &asus_ref.lock)
>> +                       asus->kbd_led_write_rejected = true;
>> +       }
>>  }
>>
>>  static int kbd_led_read(struct asus_wmi *asus, int *level, int *env)
>> @@ -1975,7 +1991,7 @@ static enum led_brightness kbd_led_get(struct led_classdev *led_cdev)
>>         asus = container_of(led_cdev, struct asus_wmi, kbd_led);
>>
>>         scoped_guard(spinlock_irqsave, &asus_ref.lock) {
>> -               if (!asus->kbd_led_avail)
>> +               if (!asus->kbd_led_avail || asus->kbd_led_write_rejected)
>>                         return asus->kbd_led_wk;
>>         }
>>
>>
>> ---
>> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
>> change-id: 20261108-asus-wmi-kbd-readback-236245e82de8
>>
>> Best regards,
>> --
>> Moad Tarrih <tarrihmoad@proton.me>
>>
>>
>>
