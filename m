Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F045E399377
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 22:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931468; cv=none; b=nKor+7NS83IMEdVPeuBrdJKwQAcqTRqsTxcsR+4M3o9TBM5KGZXA8tvwsJ8ryzMh8dUQa5inWacjsTUjSfcF7yRGKIzYsdkd0stJpkxQalPjgOdq/p6yxh15bDlCvYr3a7xt9b10iQ+PmRjWv7yFfsNPEHjZreUYQ+1z440If9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931468; c=relaxed/simple;
	bh=MxW/p9SoaEWXyK/ASzLf3lihmJ+Hxe4/oV/+cjH4Vbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ww8oSpI1LKYKpzVsLuztEJ02G1lvrflzaflhwN/TUFCxkzgrPVGclauX1xO/AltklW+z6CDZp1ryU0GA7HZCEeGhKM+5NNtJjd+TNoNhDl5NIrpOtsBFSfc8JgA+iTreAXjTPM6ezXrvt4lrmXc2B7NJfRnQQ3CSzmaY1wLhwqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=IJch5U2f; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="IJch5U2f"
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id F418E3F0F9
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:36:11 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id DFF703EE20
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:36:10 +0300 (EEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id BB6681FDC9C
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:36:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1791930970;
	bh=SYCWzrGSScC3HWN5RckZZWD1Lre/uOiFxeWF9xM/pjY=;
	h=Received:From:Subject:To;
	b=IJch5U2fKjodrQnnJIHr2hUqjZVl+qGuYq1nmx6D5zBuVXDYdkI0SiuhJpXFr41d9
	 +q/bsYPcDpGUOpdHfi6+D6DEZUSFycg2DM0Y8xZ1o2rFBX1pFtwIY5wVFumCt9+IeM
	 iRnSWSmPpVvQoQ9OcDG6qJ+iAEqB5ykcrmx2jxzMuy8Rw8uMU2D0ipT8VB7EW6DErI
	 MPS5yPASGR1cMGvx60UBjIU7C/fWpdy6maO4XUW98TvpTFrlWlWsN0tHOqYiov1eNC
	 gb2TVj2URM1V+QPW+6xOYTgtJKTojky6OXDP+OFlqDWhWDLrC0dFOZbKLqx+WtiX4d
	 gHjS6Nh94ef4A==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.210.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pf1-f176.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-88b7d853b11so2246919b3a.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:36:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzlykxjTZcofxSCnc4DS7AaCM8g4a5RaI/mSUsdkF2ZsUG4nvMrFQaru3GnZ4ijJSUoVEUc5p0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJH/pIc7nHuem4Nm30Oo6fG4xIbK9Tch+ssh+X6OqllDCFtj3l
	qmJ7262GRfOBs2Gp6HB5yXnpFhpFQetXEkTXUIXTQX0+uOUOh+LtZdNYTRGnWbatMCdfIEHwGcG
	5tbfyrr9btuBjN/z8/03djVNhMotOXg0=
X-Received: by 2002:a05:6a00:9284:b0:890:e1ff:3bac with SMTP id
 d2e1a72fcca58-897c3ef925emr10844320b3a.8.1791930968155; Tue, 13 Oct 2026
 15:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828104159.62399-1-yaseen@ghoul.dev>
 <20260828104159.62399-2-yaseen@ghoul.dev>
 <fe51a4ac-540f-4d14-ba76-b69b0eb17164@leemhuis.info>
 <CAGwozwEdQ+EEjfzHM_DAtoygsch=BXR8VWd1yHeKA-BaS=hCUA@mail.gmail.com>
 <e097faae-6184-4498-9c64-c5736f3b3ac8@ghoul.dev>
In-Reply-To: <e097faae-6184-4498-9c64-c5736f3b3ac8@ghoul.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Wed, 14 Oct 2026 00:35:56 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHsWtA2eAmgPMpbmtuxkfVJc0Qby6t0ws16U_Ya=1ZwRA@mail.gmail.com>
X-Gm-Features: AclHuK_sMJcqGS3LYiw3hdkqgDIznHqojWzKhqkbW_2uYXllk6j4qxTPkcRvlUM
Message-ID: 
 <CAGwozwHsWtA2eAmgPMpbmtuxkfVJc0Qby6t0ws16U_Ya=1ZwRA@mail.gmail.com>
Subject: Re: [PATCH v2] HID: usbhid: skip interrupt IN polling for devices
 with no input reports
To: Ahmed Yaseen <yaseen@ghoul.dev>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
 Denis Benato <denis.benato@linux.dev>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>,
	Kerim Kabirov <the.privat33r+linux@pm.me>, GameBurrow <gameburrow@pm.me>,
	regressions@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <179193096996.1333747.2356005283610976885@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.6 at linux3247.grserver.gr
X-Virus-Status: Clean

On Wed, 14 Oct 2026 at 00:29, Ahmed Yaseen <yaseen@ghoul.dev> wrote:
>
> On 10/13/26 18:11, Antheas Kapenekakis wrote:
> > On Tue, 13 Oct 2026 at 14:55, Thorsten Leemhuis
> > <regressions@leemhuis.info> wrote:
> >>
> >> On 8/28/26 12:42, Ahmed Yaseen wrote:
> >>> usbhid starts polling a device's interrupt IN endpoint on open
> >>> (usbhid_open() -> hid_start_in()). If the report descriptor declares =
no
> >>> input reports there is nothing to read there, so the poll is useless,
> >>> and on some composite devices it is also harmful.
> >>>
> >>> The ASUS ROG N-Key keyboards expose a second, input-less interface us=
ed
> >>> only for RGB control via feature reports. Opening its hidraw node (an=
y
> >>> hidraw reader does, including SDL/Steam Input or a plain cat) starts =
the
> >>> pointless IN poll and keypress reports on the keyboard interface get
> >>> dropped for as long as the node stays open: a lost key-down drops a
> >>> letter, a lost key-up leaves the key stuck. usbmon shows the dropped
> >>> reports never reach the URB layer.
> >>>
> >>> The useless poll itself is long-standing; commit 4ac74ea68f64 ("HID:
> >>> asus: early return for ROG devices") is what exposes it on these
> >>> devices by keeping the input-less interface alive instead of ejecting
> >>> it, so its hidraw node can be opened and the poll started.
> >>
> >> Hmmm, what's the status here? Ahmed, is this still needed, or was this
> >> fixed in some other way? From the the outside it looks a lot like this
> >> regression fix feel through the cracks, but would be good to get into
> >> 7.4-rc1 to finally fix the dropped keypress reports.
>
> Hi Thorsten,
>
> Yes, this patch is still very much needed upstream. The current status of=
 this patch is as follows:
>
> On upstream kernel, this is still waiting to be merged.
> On the OGC Kernel this has been available since 7.1.3 (since July 21)
> On Nobara kernel and G14 kernel, this has been available since 7.1.4 (sin=
ce around mid July)
> On CachyOS kernel some users have opened an issue and a PR on the CachyOS=
 kernel repo and kernel patches repos respectively.
>
> The issue itself is still present in upstream kernel and I'm still waitin=
g for a response from the maintainers. I hope this can be merged upstream A=
SAP.
>
> It is still a major issue and I have recently encountered users who had s=
witched away from Linux to other operating systems for this reason as well.=
 Reports of this issue still come to us in varying ways and we ask these us=
ers to use one of the kernels with fixes installed. In the case of Fedora a=
nd Arch users, this would mean the OGC kernel, Nobara, or G14 kernel. For D=
ebian-based distros, the issue is not yet present as the patch that made th=
is issue become visible is not yet available there. However, when the patch=
 4ac74ea68f64 ("HID: asus: early return for ROG devices") is available in a=
n LTS kernel, all users of Debian-based distributions will get this regress=
ion as well, so I believe some urgency is also required here.
>
> Best Regards,
> Yaseen
> >
> > Hi Thorsen,
> > there haven't been widespread issues with stuck keys on Asus recently,
> > except one regression with the fan key that merged recently.
>
> Hi Antheas,
>
> As explained above, we do still get these reports. We have users in the (=
previously ASUS now OGC) discord server, cachyos forum, bazzite repo issues=
, reddit, etc that do report these issues and multiple commenters who claim=
 they have the same issue.
>
> Some of these issues that I found at the time of writing it are linked in=
 the cover letter of this patchset. Other users reported this in the discor=
d server later, and many users write it off as a one-off issue or a bug wit=
h a certain game and those who hit the issue repeatedly either report to us=
, roll back kernel, or even switch to an alternative like Windows. Kerim an=
d GameBurrow who helped with my testing for example, were users who were ab=
le to reliably recreate the issue in certain games. The reproduction cases =
in the patch description (e.g. running cat on the hidraw node) came from th=
em and trigger it consistently.
>
> >
> > This fix targets hid core, so merging it could cause regressions on
> > other devices.
>
> This fix has not caused any regressions so far, and I do not see a scenar=
io where it would. The patch only affects devices with 0 input reports. Add=
itionally, we have the patch on so many widely used kernels and has been pr=
esent in them for the last 3 months, along with multiple users who added th=
is patch manually with my guidance. The fix itself is to simply not poll an=
y devices that have no input reports to provide. The reason why other devic=
es are unaffected is explained in the patch description and my additional p=
roof is the hundreds of users that use the Nobara kernel, G14 kernel, and t=
he OGC kernel collectively.
>
> >
> > Denis can comment on whether he fixed the regression that primarily
> > lies in the software he maintains separately. I am not sure SDL causes
> > this issue
>
> As one of the maintainers of asusctl myself, I believe I can comment on t=
his as well. There was an issue in asusctl previously that opened the hidra=
w, and it was patched by Denis months ago. However this did not fix the iss=
ue that polling the hidraw by other means (Steam/Proton and even a simple c=
at does this) still triggered the bug. That is what my patch fixes.
>
> I would like to also highlight that this is originally a logical issue in=
 the kernel that should not have been there in the first place, and if a de=
vice regresses because of this fix, it is a device that needs quirking and =
not the other way around. That said, even for malformed input reports which=
 you have described in your v1 response, they would still be unaffected as =
we only skip when there are 0 reports. The quirk HID_QUIRK_ALWAYS_POLL exis=
ts exactly for this reason, and anything without that quirk and no input re=
ports has no business being polled.
>
> If the maintainers still prefer it, I would be happy to have this as a qu=
irk for only the ASUS keyboard device instead. I have explained all my reas=
oning for this approach in the cover letter and as mentioned, no regression=
s have been reported so far.
>
> Best Regards,
> Yaseen
>
> >
> > Best,
> > Antheas
> >
> >> Ciao, Thorsten
> >>> Skip the poll in usbhid_open() when the device has no input reports.
> >>> Feature reports and hidraw output keep working over the control and O=
UT
> >>> endpoints, so the interface is otherwise unaffected.
> >>>
> >>> Fixes: 4ac74ea68f64 ("HID: asus: early return for ROG devices")
> >>> Link: https://discuss.cachyos.org/t/keyboard-input-issues-on-asus-rog=
-strix-16-2025-with-cachyos-during-gaming/30823
> >>> Link: https://github.com/ublue-os/bazzite/issues/4590
> >>> Cc: stable@vger.kernel.org
> >>> Tested-by: Kerim Kabirov <the.privat33r+linux@pm.me>
> >>> Tested-by: GameBurrow <gameburrow@pm.me>
> >>> Signed-off-by: Ahmed Yaseen <yaseen@ghoul.dev>
> >>> Reviewed-by: Denis Benato <denis.benato@linux.dev>
> >>> ---
> >>>  drivers/hid/usbhid/hid-core.c | 9 ++++++++-
> >>>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-c=
ore.c
> >>> index 96b0181cf819..d7cf2b56e117 100644
> >>> --- a/drivers/hid/usbhid/hid-core.c
> >>> +++ b/drivers/hid/usbhid/hid-core.c
> >>> @@ -688,7 +688,14 @@ static int usbhid_open(struct hid_device *hid)
> >>>
> >>>       set_bit(HID_OPENED, &usbhid->iofl);
> >>>
> >>> -     if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
> >>> +     /*
> >>> +      * ALWAYS_POLL devices are already polled from usbhid_start(), =
and a
> >>> +      * device with no input reports has nothing to send on the inte=
rrupt
> >>> +      * IN endpoint. In some cases polling is harmful: on the ASUS R=
OG
> >>> +      * N-Key keyboards it makes the sibling interface drop keypress=
es.
> >>> +      */
> >>> +     if ((hid->quirks & HID_QUIRK_ALWAYS_POLL) ||
> >>> +         list_empty(&hid->report_enum[HID_INPUT_REPORT].report_list)=
) {

Ok, I remember our conversation a few months ago.

The hid descriptor should not affect device behavior.

Just because a hid descriptor does not have input reports, you should
not change the kernel's functionality.

During development, it can be the case a hid device has a partial hid
descriptor. hidraw does not look at or care about the hid protocol of
a device. This is what hiddev is for.

As it stands this is a heuristic

If the kernel has a bug with how it handles polling on devices without
input reports, you need to find the underlying issue and fix that. if
not, you should quirk hid-asus by appending HID_QUIRK_ALWAYS_POLL if
dev->tp. You never responded to my comment so at least by my side I
considered the problem resolved.

Antheas

> >>>               res =3D 0;
> >>>               goto Done;
> >>>       }
> >>>
> >>> base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
>
>
>

