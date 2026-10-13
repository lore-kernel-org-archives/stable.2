Received: from mail-4399.protonmail.ch (mail-4399.protonmail.ch [185.70.43.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7655C1CE;
	Tue, 13 Oct 2026 22:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930598; cv=none; b=C68bVSAHZDMKI9+Rl8t/b+lJFdP7QvZkxISr9WHqydlnb/yuUAnJueRV6KmcqmHQqrTHQd9aM41bpjxTTtkKtfxZLJ99T+dbEI84Z94mOqDBqQjhL72sSsNo9pOm5JRF875ySngZxKBssfLpFSEalGK0qdVBzSK+f4FZjVA/6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930598; c=relaxed/simple;
	bh=KarW4zuGSKwvAOkpyYc2bQ64pSANFCpJTa8ymC9rW4o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJnUXftobnglHJDS2YlPX9IOPv1qerggmZ+N140Ib5BXxDh/TgB7ck4pJu2Kn9N0G2p3sOB4I2wSDBYhcCU1bXQB+e3WH/9oKXfAYyc5DzT3DlCvPD36MzemalKiMUDdtQcpxapga28tJFh1XiefTHH/Gb9ts/F6OZll9nZC9jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ghoul.dev; spf=pass smtp.mailfrom=ghoul.dev; dkim=pass (2048-bit key) header.d=ghoul.dev header.i=@ghoul.dev header.b=QdWZj4nm; arc=none smtp.client-ip=185.70.43.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ghoul.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghoul.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ghoul.dev header.i=@ghoul.dev header.b="QdWZj4nm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ghoul.dev;
	s=protonmail2; t=1791930592; x=1792189792;
	bh=IeMFIm8AOgD/Oiwh2bjh0FeBEf2AKLcI23kRp9digOM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QdWZj4nmDb5ixoWUZLD/cVX+8b16XMIYQ3c6AlI0oaEySgDN/6gIdxoZxQgu5U1rW
	 qYQ28vFPsXc8mcLea5k3rTSNkd+IlKSH/GQdZf1280jEihalEUqo5zjs/FGDJgXCRV
	 7hXg7gsbYHnKRmGg6RJx3qVUBXOGo9cISaV/lfkfE+nMG5Grs94BxxcWUdgNprV2/W
	 Ns0TvE0q3JqHH9jiBNmptkMsPyBo8PnfS2aeysSFyY/tyl5JEu0D05unH6cYgA1Cd8
	 NTDWQlt0SMtsInw1YjhXaIw6UT/FB+Qogi40bKz8IcEYDjFSGT6FBiI3Jui13dXsWZ
	 p9zQ+dArM/7nQ==
Date: Tue, 13 Oct 2026 22:29:47 +0000
To: Antheas Kapenekakis <lkml@antheas.dev>, Thorsten Leemhuis <regressions@leemhuis.info>
From: Ahmed Yaseen <yaseen@ghoul.dev>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Denis Benato <denis.benato@linux.dev>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Kerim Kabirov <the.privat33r+linux@pm.me>, GameBurrow <gameburrow@pm.me>, regressions@lists.linux.dev, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: usbhid: skip interrupt IN polling for devices with no input reports
Message-ID: <e097faae-6184-4498-9c64-c5736f3b3ac8@ghoul.dev>
In-Reply-To: <CAGwozwEdQ+EEjfzHM_DAtoygsch=BXR8VWd1yHeKA-BaS=hCUA@mail.gmail.com>
References: <20260828104159.62399-1-yaseen@ghoul.dev> <20260828104159.62399-2-yaseen@ghoul.dev> <fe51a4ac-540f-4d14-ba76-b69b0eb17164@leemhuis.info> <CAGwozwEdQ+EEjfzHM_DAtoygsch=BXR8VWd1yHeKA-BaS=hCUA@mail.gmail.com>
Feedback-ID: 177610485:user:proton
X-Pm-Message-ID: cf048d5b2e86ac93ae38fb43f06638b5c7fa1b14
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/13/26 18:11, Antheas Kapenekakis wrote:
> On Tue, 13 Oct 2026 at 14:55, Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>> On 8/28/26 12:42, Ahmed Yaseen wrote:
>>> usbhid starts polling a device's interrupt IN endpoint on open
>>> (usbhid_open() -> hid_start_in()). If the report descriptor declares no
>>> input reports there is nothing to read there, so the poll is useless,
>>> and on some composite devices it is also harmful.
>>>
>>> The ASUS ROG N-Key keyboards expose a second, input-less interface used
>>> only for RGB control via feature reports. Opening its hidraw node (any
>>> hidraw reader does, including SDL/Steam Input or a plain cat) starts th=
e
>>> pointless IN poll and keypress reports on the keyboard interface get
>>> dropped for as long as the node stays open: a lost key-down drops a
>>> letter, a lost key-up leaves the key stuck. usbmon shows the dropped
>>> reports never reach the URB layer.
>>>
>>> The useless poll itself is long-standing; commit 4ac74ea68f64 ("HID:
>>> asus: early return for ROG devices") is what exposes it on these
>>> devices by keeping the input-less interface alive instead of ejecting
>>> it, so its hidraw node can be opened and the poll started.
>>
>> Hmmm, what's the status here? Ahmed, is this still needed, or was this
>> fixed in some other way? From the the outside it looks a lot like this
>> regression fix feel through the cracks, but would be good to get into
>> 7.4-rc1 to finally fix the dropped keypress reports.

Hi Thorsten,

Yes, this patch is still very much needed upstream. The current status of t=
his patch is as follows:

On upstream kernel, this is still waiting to be merged.
On the OGC Kernel this has been available since 7.1.3 (since July 21)
On Nobara kernel and G14 kernel, this has been available since 7.1.4 (since=
 around mid July)
On CachyOS kernel some users have opened an issue and a PR on the CachyOS k=
ernel repo and kernel patches repos respectively.

The issue itself is still present in upstream kernel and I'm still waiting =
for a response from the maintainers. I hope this can be merged upstream ASA=
P.

It is still a major issue and I have recently encountered users who had swi=
tched away from Linux to other operating systems for this reason as well. R=
eports of this issue still come to us in varying ways and we ask these user=
s to use one of the kernels with fixes installed. In the case of Fedora and=
 Arch users, this would mean the OGC kernel, Nobara, or G14 kernel. For Deb=
ian-based distros, the issue is not yet present as the patch that made this=
 issue become visible is not yet available there. However, when the patch 4=
ac74ea68f64 ("HID: asus: early return for ROG devices") is available in an =
LTS kernel, all users of Debian-based distributions will get this regressio=
n as well, so I believe some urgency is also required here.

Best Regards,
Yaseen
>=20
> Hi Thorsen,
> there haven't been widespread issues with stuck keys on Asus recently,
> except one regression with the fan key that merged recently.

Hi Antheas,

As explained above, we do still get these reports. We have users in the (pr=
eviously ASUS now OGC) discord server, cachyos forum, bazzite repo issues, =
reddit, etc that do report these issues and multiple commenters who claim t=
hey have the same issue.

Some of these issues that I found at the time of writing it are linked in t=
he cover letter of this patchset. Other users reported this in the discord =
server later, and many users write it off as a one-off issue or a bug with =
a certain game and those who hit the issue repeatedly either report to us, =
roll back kernel, or even switch to an alternative like Windows. Kerim and =
GameBurrow who helped with my testing for example, were users who were able=
 to reliably recreate the issue in certain games. The reproduction cases in=
 the patch description (e.g. running cat on the hidraw node) came from them=
 and trigger it consistently.

>=20
> This fix targets hid core, so merging it could cause regressions on
> other devices.

This fix has not caused any regressions so far, and I do not see a scenario=
 where it would. The patch only affects devices with 0 input reports. Addit=
ionally, we have the patch on so many widely used kernels and has been pres=
ent in them for the last 3 months, along with multiple users who added this=
 patch manually with my guidance. The fix itself is to simply not poll any =
devices that have no input reports to provide. The reason why other devices=
 are unaffected is explained in the patch description and my additional pro=
of is the hundreds of users that use the Nobara kernel, G14 kernel, and the=
 OGC kernel collectively.

>=20
> Denis can comment on whether he fixed the regression that primarily
> lies in the software he maintains separately. I am not sure SDL causes
> this issue

As one of the maintainers of asusctl myself, I believe I can comment on thi=
s as well. There was an issue in asusctl previously that opened the hidraw,=
 and it was patched by Denis months ago. However this did not fix the issue=
 that polling the hidraw by other means (Steam/Proton and even a simple cat=
 does this) still triggered the bug. That is what my patch fixes.

I would like to also highlight that this is originally a logical issue in t=
he kernel that should not have been there in the first place, and if a devi=
ce regresses because of this fix, it is a device that needs quirking and no=
t the other way around. That said, even for malformed input reports which y=
ou have described in your v1 response, they would still be unaffected as we=
 only skip when there are 0 reports. The quirk HID_QUIRK_ALWAYS_POLL exists=
 exactly for this reason, and anything without that quirk and no input repo=
rts has no business being polled.

If the maintainers still prefer it, I would be happy to have this as a quir=
k for only the ASUS keyboard device instead. I have explained all my reason=
ing for this approach in the cover letter and as mentioned, no regressions =
have been reported so far.

Best Regards,
Yaseen

>=20
> Best,
> Antheas
>=20
>> Ciao, Thorsten
>>> Skip the poll in usbhid_open() when the device has no input reports.
>>> Feature reports and hidraw output keep working over the control and OUT
>>> endpoints, so the interface is otherwise unaffected.
>>>
>>> Fixes: 4ac74ea68f64 ("HID: asus: early return for ROG devices")
>>> Link: https://discuss.cachyos.org/t/keyboard-input-issues-on-asus-rog-s=
trix-16-2025-with-cachyos-during-gaming/30823
>>> Link: https://github.com/ublue-os/bazzite/issues/4590
>>> Cc: stable@vger.kernel.org
>>> Tested-by: Kerim Kabirov <the.privat33r+linux@pm.me>
>>> Tested-by: GameBurrow <gameburrow@pm.me>
>>> Signed-off-by: Ahmed Yaseen <yaseen@ghoul.dev>
>>> Reviewed-by: Denis Benato <denis.benato@linux.dev>
>>> ---
>>>  drivers/hid/usbhid/hid-core.c | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-cor=
e.c
>>> index 96b0181cf819..d7cf2b56e117 100644
>>> --- a/drivers/hid/usbhid/hid-core.c
>>> +++ b/drivers/hid/usbhid/hid-core.c
>>> @@ -688,7 +688,14 @@ static int usbhid_open(struct hid_device *hid)
>>>
>>>       set_bit(HID_OPENED, &usbhid->iofl);
>>>
>>> -     if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
>>> +     /*
>>> +      * ALWAYS_POLL devices are already polled from usbhid_start(), an=
d a
>>> +      * device with no input reports has nothing to send on the interr=
upt
>>> +      * IN endpoint. In some cases polling is harmful: on the ASUS ROG
>>> +      * N-Key keyboards it makes the sibling interface drop keypresses=
.
>>> +      */
>>> +     if ((hid->quirks & HID_QUIRK_ALWAYS_POLL) ||
>>> +         list_empty(&hid->report_enum[HID_INPUT_REPORT].report_list)) =
{
>>>               res =3D 0;
>>>               goto Done;
>>>       }
>>>
>>> base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f


