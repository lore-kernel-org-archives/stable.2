Received: from mta1.migadu.com (out-205.mta1.migadu.com [95.215.58.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB36C5012AE
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897139; cv=none; b=YW2IjmzcVZJHlddFnwkdJbcbjDwR7oMwMyKyEG22M0/LBZpjxXiv98/iuUGxqZeJuoq928eHesxEGDFbp/zH2z/sAe2bAcnmnu9o5QcxF/7phHLagP4OzTioeZ+ySxGJi9BuGyvNMGFDVnxRjrOog9EcwHiniptNLj0nkd+hFU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897139; c=relaxed/simple;
	bh=GxGoMm4vBKXboCWqEywkB1ImT232d0kryycTPDywOvA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ngsGkpI2I5vAjgBlUOsn20M063afPN2JSaCNuV5fo/vInYFBm1uPHUV2DUPzOQKbIn6wZutDj20aHA16iOT2JUfR3McFyxzTfmbC1MHEahmgnbFvYrLFzTMnux93rxtvRqdm8Tqbq4Wv7kSeruy0DApHhYiS141py5PgS+2yCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kzZB8/lw; arc=none smtp.client-ip=95.215.58.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kzZB8/lw"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GxGoMm4vBKXboCWqEywkB1ImT232d0kryycTPDywOvA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791897134; v=1; x=1792501934;
 b=kzZB8/lwMeNbLUdjZV8TbLFvLtF/o6EeW3PgDCK1gNj1AtCu4JTADoRJAj7+NAEiWAI1SD+I
 ZB98d8xRPaNVKGRWOmr/TuRrhhwIgwtPKyDbYQJCvk5cmojxhNPFHD1mKBrWB1SORqZKqVI9Xnz
 ZT353KTwb/kXSmHdCxkGwcxk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 66a73f73837eb63b;
	Tue, 13 Oct 2026 13:12:14 +0000
X-Mizu-Trace-ID: 66a73f73837eb63b
X-Migadu-Flow: FLOW_OUT
Date: Tue, 13 Oct 2026 16:12:04 +0300
From: Denis Benato <denis.benato@linux.dev>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Ahmed Yaseen <yaseen@ghoul.dev>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Kerim Kabirov <the.privat33r+linux@pm.me>,
	GameBurrow <gameburrow@pm.me>, regressions@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-ID: <2f85200c-ecc3-4318-9156-16ace09cac7f@linux.dev>
In-Reply-To: <fe51a4ac-540f-4d14-ba76-b69b0eb17164@leemhuis.info>
References: <20260828104159.62399-1-yaseen@ghoul.dev> <20260828104159.62399-2-yaseen@ghoul.dev> <fe51a4ac-540f-4d14-ba76-b69b0eb17164@leemhuis.info>
Subject: Re: [PATCH v2] HID: usbhid: skip interrupt IN polling for devices
 with no input reports
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <2f85200c-ecc3-4318-9156-16ace09cac7f@linux.dev>

13 ott 2026 15:55:33 Thorsten Leemhuis <regressions@leemhuis.info>:

> On 8/28/26 12:42, Ahmed Yaseen wrote:
>> usbhid starts polling a device's interrupt IN endpoint on open
>> (usbhid_open() -> hid_start_in()). If the report descriptor declares no
>> input reports there is nothing to read there, so the poll is useless,
>> and on some composite devices it is also harmful.
>>
>> The ASUS ROG N-Key keyboards expose a second, input-less interface used
>> only for RGB control via feature reports. Opening its hidraw node (any
>> hidraw reader does, including SDL/Steam Input or a plain cat) starts the
>> pointless IN poll and keypress reports on the keyboard interface get
>> dropped for as long as the node stays open: a lost key-down drops a
>> letter, a lost key-up leaves the key stuck. usbmon shows the dropped
>> reports never reach the URB layer.
>>
>> The useless poll itself is long-standing; commit 4ac74ea68f64 ("HID:
>> asus: early return for ROG devices") is what exposes it on these
>> devices by keeping the input-less interface alive instead of ejecting
>> it, so its hidraw node can be opened and the poll started.
>
> Hmmm, what's the status here? Ahmed, is this still needed, or was this
> fixed in some other way? From the the outside it looks a lot like this
> regression fix feel through the cracks, but would be good to get into
> 7.4-rc1 to finally fix the dropped keypress reports.
>

Hi Thorsten,

This is very much needed and we had to include it in OGC kernel to avoid hi=
d devices resetting constantly.

It is a very important fix and we are waiting for inclusion upstream becaus=
e games becomes flat out unplayable with certain combination of tools.

Best regards,
Denis Benato

> Ciao, Thorsten
>> Skip the poll in usbhid_open() when the device has no input reports.
>> Feature reports and hidraw output keep working over the control and OUT
>> endpoints, so the interface is otherwise unaffected.
>>
>> Fixes: 4ac74ea68f64 ("HID: asus: early return for ROG devices")
>> Link: https://discuss.cachyos.org/t/keyboard-input-issues-on-asus-rog-st=
rix-16-2025-with-cachyos-during-gaming/30823
>> Link: https://github.com/ublue-os/bazzite/issues/4590
>> Cc: stable@vger.kernel.org
>> Tested-by: Kerim Kabirov <the.privat33r+linux@pm.me>
>> Tested-by: GameBurrow <gameburrow@pm.me>
>> Signed-off-by: Ahmed Yaseen <yaseen@ghoul.dev>
>> Reviewed-by: Denis Benato <denis.benato@linux.dev>
>> ---
>> drivers/hid/usbhid/hid-core.c | 9 ++++++++-
>> 1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core=
.c
>> index 96b0181cf819..d7cf2b56e117 100644
>> --- a/drivers/hid/usbhid/hid-core.c
>> +++ b/drivers/hid/usbhid/hid-core.c
>> @@ -688,7 +688,14 @@ static int usbhid_open(struct hid_device *hid)
>>
>> =C2=A0=C2=A0=C2=A0 set_bit(HID_OPENED, &usbhid->iofl);
>>
>> -=C2=A0=C2=A0 if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
>> +=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0 * ALWAYS_POLL devices are already polled from usbhid=
_start(), and a
>> +=C2=A0=C2=A0=C2=A0 * device with no input reports has nothing to send o=
n the interrupt
>> +=C2=A0=C2=A0=C2=A0 * IN endpoint. In some cases polling is harmful: on =
the ASUS ROG
>> +=C2=A0=C2=A0=C2=A0 * N-Key keyboards it makes the sibling interface dro=
p keypresses.
>> +=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0 if ((hid->quirks & HID_QUIRK_ALWAYS_POLL) ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_empty(&hid->report_enum[HID_I=
NPUT_REPORT].report_list)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto Done;
>> =C2=A0=C2=A0=C2=A0 }
>>
>> base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f

