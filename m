Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB2C488237;
	Wed, 26 Aug 2026 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787778887; cv=none; b=KggONjrz9Lli+enRP1Z93DSfk9zS53JYMrl8yDFY7a9/FkRFuZPuQzqwtRq6p+VZ1irOeVanLjzAmTPMUZGKTChRW+6/kpmGMpQED2iZmoND14ZlPU4IudImfFV+HegR+cPmXFPt9JLT0JCRDjDPKlx8h6QXY6L1usLXJW9/zlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787778887; c=relaxed/simple;
	bh=oJA4xPT2ANoR9sRkaZJee8iJemXWJTIkOmbADhg3dT8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=DoXwdfCe38Cp8yjcItebTjSX9cU+PAf1ZtTe8q2WucBcXxFfkWgNuOYoyJ6x0WG0+4zYWKL4NhHQb6RSnedjb1GgFjSjKPryLdYUT2NoD1sNVpfJ8sgOyhUPRp/5BMFY4XvKuUOYLa5Pp3rZ9RqayAZNkCHaQ0r+tfzaoeKiByI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CT/ytiss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CT/ytiss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805A21F000E9;
	Wed, 26 Aug 2026 21:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787778884;
	bh=oJA4xPT2ANoR9sRkaZJee8iJemXWJTIkOmbADhg3dT8=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=CT/ytiss34RQH9eyKLnihn6aSo8N+mrrK+odduV6P+fOyv6ijeDj/MHEpHsiZceTh
	 Hcxwq3EjokKxu2EFp03LSt+aQsi/BX7T4dxrTTYxTIPXrKvxO5CtMIOGeYzFHvsYRv
	 P4L1zRddbXbZMn+oiva9Em/MD4CAO/+HGY20f8YXhFvbZbbznQ9zZKw+rxZcpWBR7N
	 v6ZrPvcWzCeosMltL99UV7zlkWQbUnebuHZ4+UmjCzKyq6TqeXe9uKOzGs9D7zuVCA
	 SgmXqPqRloNw1awrk7pgtGwJMCqorXe79Vc0VNByQ2Qzag0I9hbqEcS3ZrnZdQgb8i
	 ocMXFzvjepVQw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 23:14:41 +0200
Message-Id: <DKZ6PZV65PYX.3M9UEZC4ZMLLC@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4] driver core: avoid klist_remove() on unattached
 knode_driver
Cc: "Alan Stern" <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>,
 <syzbot+87188222c77c0dbbdb4d@syzkaller.appspotmail.com>,
 <stable@vger.kernel.org>, <linux-usb@vger.kernel.org>
To: "Akihiko Kai" <khiemtranzo532001@gmail.com>
References: <2026082042-coma-moody-5b4e@gregkh>
 <20260820084557.129908-1-khiemtranzo532001@gmail.com>
 <DKTWKZFYC6TL.2ZESRE0NWAV2T@kernel.org>
 <0198b9fe-4bc0-4e12-b788-85aa2c9f8162@rowland.harvard.edu>
 <DKU2J83B6IX6.2CG1WOB66WC39@kernel.org>
 <CAEe5be5OjseCMxGQP=QMd1L-muOTDguaay_-21moS1+xRNNNyw@mail.gmail.com>
In-Reply-To: <CAEe5be5OjseCMxGQP=QMd1L-muOTDguaay_-21moS1+xRNNNyw@mail.gmail.com>

On Mon Aug 24, 2026 at 6:47 AM CEST, Akihiko Kai wrote:
> On Fri, Aug 21, 2026 at 03:54:44AM +0200, Danilo Krummrich wrote:
>> usb_driver_claim_interface() is the only callsite in the kernel that
>> does set dev->driver without a subsequent device_bind_driver().
>
> Small correction, I think there are a few more. usb_port
> (drivers/usb/core/port.c:782) sets dev->driver before device_register(),
> and usb_port_driver has no ->match and no ->probe, so it depends entirely
> on the __device_attach() dev->driver path to get bound. ccwgroup
> (drivers/s390/cio/ccwgroup.c:385) and pata_parport
> (drivers/ata/pata_parport/pata_parport.c:515) do the same. So that path
> doesn't look USB-claim-specific, and if we ever want to remove it,
> usb_port would need a ->match() first.

Good catch, I think those should be fixed as well.

I had a brief look at the usb_port one and it should be exactly the same ca=
se as
w1, which I already fixed [1]. Actually, it is even simpler, usb_device_mat=
ch()
can just handle the usb_port_device_type, as the USB core already does for =
other
device types. I can send a patch for this later on.

[1] https://lore.kernel.org/driver-core/20260820225430.1847356-1-dakr@kerne=
l.org/

> For the root cause, what about this: in usb_driver_claim_interface(),
> when the interface isn't registered yet, just don't set dev->driver --
> record the claim on struct usb_interface instead. Then, once the
> interface gets added in usb_set_configuration(), bind it explicitly with
> device_bind_driver(). That skips ->probe, which is exactly what
> usb_audio's claim-now-bind-later needs, and it also attaches
> knode_driver so teardown is safe. The __device_attach() path can stay
> for w1/ccwgroup/pata_parport.
>
> Does that sound reasonable?

I'd prefer to get rid of the dev->driver path in __device_attach(), I think
there's no reason not to use the common match() path instead.

So, for a fix that also goes into stable trees what you propose sounds
reasonable, but eventually we should use the match() infrastructure instead=
.
