Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0991CCA6F;
	Thu, 20 Aug 2026 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259271; cv=none; b=Z0/wX0JEvrtIxFhItO6bsAqRoiwWDErT0C5Al86ZY8WpAyqCDCvHGQUw7ifxjL890tsnNRleAg65pMNujmVrCYbF0Z2JYhRF6uQ5/Vwl12yUTTwg1MBic0jRq3MN5YQ+C4ILSOm0uRTz/8O785IHcpkGn7M/oVLL0knz2bAJ3qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259271; c=relaxed/simple;
	bh=gjYv/sZPpauPPsmtrhwR2+Knfusl5yB+2Mm+ivh5DrE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BrIX8yQT6rAch/UHgoRSzXIAZfYF+c89YllSVVVtx7OS8kqxK9vA+ocrheCe1/1yW1bT3R65QjWsL6lg9MwU7oph32hGF2X8t8+pq8xrzA11rQt0wbvhLpKlr2hjiLasKmQ557MncxWTWW8WAc6c7P7xscfXyDyLSUdJiH/F0cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BudRnSVp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BudRnSVp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C5A1F000E9;
	Thu, 20 Aug 2026 20:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787259269;
	bh=+HEwizpIpYAsid9ngnnSHJ6MVcdntbVQLVVhuYpw6sc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=BudRnSVplWNziID8uR4R1sNnzd3z9n16lGH1iJxaHdKx9llucyWsio5R+/bDIffZv
	 6TNTbkGmCY0X0GjtrkIZNWqzsWbHkL/MfhRfgmMKnWi+8F591+MvjXMEuArrw4vmMR
	 NnfLqw4gm80oDk9HoWWgkb4DZBR3kckFc12Jw/hF6ZXOJ5MAlBxQp0VxqA2o2PylsF
	 sksMNu58wtvRPRRD6u7HPhr7bvGFOga50oclJAgMG9/mQUEXTanzLEvOHsCJ4ysvg+
	 4YEdtI5tmGWtEtg1qnZjT/6deFnNyy1s8hL/cQJziurh5+ThSRZpVKNjEPY/HbzmmJ
	 bo/Og7+FW9t7g==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 22:54:26 +0200
Message-Id: <DKU2J83B6IX6.2CG1WOB66WC39@kernel.org>
Subject: Re: [PATCH v4] driver core: avoid klist_remove() on unattached
 knode_driver
Cc: "Nguyen Quang Le Kien" <khiemtranzo532001@gmail.com>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <syzbot+87188222c77c0dbbdb4d@syzkaller.appspotmail.com>,
 <stable@vger.kernel.org>, <linux-usb@vger.kernel.org>
To: "Alan Stern" <stern@rowland.harvard.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <2026082042-coma-moody-5b4e@gregkh>
 <20260820084557.129908-1-khiemtranzo532001@gmail.com>
 <DKTWKZFYC6TL.2ZESRE0NWAV2T@kernel.org>
 <0198b9fe-4bc0-4e12-b788-85aa2c9f8162@rowland.harvard.edu>
In-Reply-To: <0198b9fe-4bc0-4e12-b788-85aa2c9f8162@rowland.harvard.edu>

On Thu Aug 20, 2026 at 7:22 PM CEST, Alan Stern wrote:
> On Thu, Aug 20, 2026 at 06:14:37PM +0200, Danilo Krummrich wrote:
>> (Cc: linux-usb)
>>=20
>> On Thu Aug 20, 2026 at 10:45 AM CEST, Nguyen Quang Le Kien wrote:
>> > Fixes: 94e7b1c5ff20 ("[PATCH] Add a klist to struct device_driver for =
the devices bound to it.")
>>=20
>> This is not the correct commit to reference, this commit seems fine.
>>=20
>> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> > index 60c005223..4154b4499 100644
>> > --- a/drivers/base/dd.c
>> > +++ b/drivers/base/dd.c
>> > @@ -1354,7 +1354,8 @@ static void __device_release_driver(struct devic=
e *dev, struct device *parent)
>> >  		device_unbind_cleanup(dev);
>> >  		device_links_driver_cleanup(dev);
>> > =20
>> > -		klist_remove(&dev->p->knode_driver);
>> > +		if (device_is_bound(dev))
>> > +			klist_remove(&dev->p->knode_driver);
>>=20
>> This looks like band-aid for the underlying design tension in the USB co=
re
>> (which we should address instead) and does not belong in the driver core=
.
>>=20
>> It's not visible from the above diff, but with this patch the control fl=
ow
>> becomes:
>>=20
>> 	if (dev->driver) {
>> 		if (device_is_bound(dev))
>> 			klist_remove(&dev->p->knode_driver);
>> 		...
>> 	}
>>=20
>> but dev->driver already indicates that the device is bound to dev->drive=
r in
>> this context.
>>=20
>> The reason we "need" this check regardless is that usb_driver_claim_inte=
rface()
>> (ab)uses dev->driver to indicate that a certain USB driver claimed, or r=
ather
>> reserved, this device.
>>=20
>> There are two cases in usb_driver_claim_interface():
>>=20
>>   (1) The device to claim is already registered with the driver core, in=
 which
>>       case device_bind_driver(dev) is called and dev->driver is correctl=
y set
>>       during the bind attempt.
>>=20
>>   (2) The device to claim was not yet registered with the driver core. T=
his can
>>       happen when the USB interface the driver actually binds to is regi=
stered
>>       (and hence probed) before the additional interface the driver want=
s to
>>       claim is registered. The USB core sets dev->driver independent of =
the bind
>>       state to indicate it has reserved the interface.
>>=20
>> The first case is perfectly fine, but the issue with the second case is =
that now
>> dev->driver is semantically overloaded:
>>=20
>> The USB core treats it as "dev is reserved for dev->driver" and the driv=
er core
>> treats it as "dev is currently binding or bound to dev->driver", but tha=
t's not
>> actually the case yet, since device_bind_driver() hasn't been called yet=
.
>>=20
>> IOW, dev->driver should only be set under the device lock before calling
>> device_bind_driver(), and, in case of failure, should be cleared after
>> device_bind_driver() with the device lock still held.
>>=20
>> Besides the reported crash, another implication of this is that all othe=
r
>> functions from device_release_driver() are called as well, even though
>> device_bind_driver() was never called before, and there is no guarantee =
that
>> this does not cause other unexpected side effects already or in the futu=
re.
>>=20
>> I think one solution could be to add a new claimed field to struct usb_i=
nterface
>> to indicate that the interface is reserved for a certain driver and make
>> usb_device_match() reject the device if ever probed otherwise.
>>=20
>> Another solution (but that's a bit more work) would be to separate inter=
face
>> registration from interface probing in usb_set_configuration(). Of cours=
e that
>> needs help from the driver core as well, but it would also get us rid of=
 the
>> slightly odd situation that a driver may operate a claimed device alread=
y, even
>> though it is not yet registered with the driver core.
>>=20
>> I'd suggest going for a claimed field in struct usb_interface first to f=
ix the
>> immediate problem and then take it from there.
>>=20
>> That said, I wonder if there's more to think about with the
>> usb_driver_claim_interface() / usb_driver_release_interface() API.
>>=20
>> After having a brief look it seems that drivers have invented various di=
fferent
>> approaches to protect against the case where userspace could write the c=
laimed
>> interface's name to:
>>=20
>> 	/sys/bus/usb/drivers/<driver>/unbind
>>=20
>> I think this could be much cleaner if the driver core would support "cla=
imed"
>> devices" natively. OTH, there's only ~20 drivers across USB and PnP thou=
gh, so
>> probably not worth.
>
> I don't object to the idea of adding a "claimed" field to usb_interface. =
=20
>
> However, isn't it true that the driver core has always supported the=20
> idea of a driver being associated with a device before binding?  In=20
> particular, __device_attach() specifically checks for dev->driver being=
=20
> already set.  If it is, the match and probe steps are skipped.

Ah, I also wanted to add a comment about this, but forgot about it, sorry.

This was added ~25 years ago to be able to hardwire a system device to a
specific driver, which less than a year after was replaced entirely by some=
thing
else and later converted back to a bus with proper match() logic. But the
dev->driver special case in __device_attach() was never removed.

So, I guess it is fair to say it was always there, but the driver core does=
 not
really handle dev->driver being set "randomly" outside of the bind/unbind
lifecycle in general. It is expected that it is only set when the driver is
actually bound (or binding).

One example is __device_release_driver(), if device_bind_driver() (or
really_probe()) wasn't called, we should also not land within the
if (dev->driver) conditional of __device_release_driver().

Also note that usb_driver_claim_interface() is the only callsite in the ker=
nel
that does set dev->driver without a subsequent device_bind_driver() while
holding the device lock.

(Well, actually, after a thorough check, there's w1, which hardwires the
w1_slave_driver, where it should actually use a trivial match() callback.)

In general, matching should be done through the match() callback.

> Are you saying that this code path should be removed as well?

Yes, I think we should remove it. It's a rather error prone special case th=
at
can easily be handled with normal match() logic.
