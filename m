Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A6B53C3A7;
	Wed, 14 Oct 2026 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988935; cv=none; b=KTSewnbxjMGqwK8jj3MlIe72AZcfkz+l40TtwancgSk3gy5lzq3fuLAeIwaRWJL3mFRZWL12dNRSuBongjk2jopmR85pIAugqHpVBtN1S4lLq+3mwNITMMti+JUqynIkkyGXTu7srSc/utMBoZrG/vjlR8TKYiYqOW79o47UjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988935; c=relaxed/simple;
	bh=XjfKLRSvu4L3gpdGW2juMmTeFlNUos21ZDNZRBgykcs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=MI1c0KS0r7xrwgBFq0KyESekpkb753Bp/ZY9e67DgqKvhqfcqUfZtFJWXW2SkeWL34pSj/W/+SBBsCCkFP6v0zDfI41F3YO1g8dR+tbx0gU3AThabdDKPc+L1F8kDgbSnWL/JMRkkQBodXPLZ2OTeOgvaCvvnwPJMajb6D7ID/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8EmEvtH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8EmEvtH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399EB1F000C5;
	Wed, 14 Oct 2026 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791988933;
	bh=VAmNjGyzL2bxLeA5A9j8euIlZrtkfmuBRP3pD7RPjPQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=H8EmEvtH0l4fAeFBgdXtLWDfqjwSIRSXGRiPxSXPtscylipv73FvSMs6icsHT9VXi
	 xiutcSM9hMDcdREJg+SBEcg5KFdHYrbDKXFL7bW9yDa2FILVtQYlku/uqe9c4jbbwo
	 JzgNXDGd4FYkOHOcvvKBsip0pvdfsOQ4YPbVBU2ACtcbHGjtyuXlyQSJx8CaL79ded
	 tGQTS6dH61JURr7f0X7iDh3m89VFE1FeVccmcG20z+ZzIpD5FeyDTSHzyTIP6gKJj5
	 0oXdMWQz0FGX9e7HloHuPuuZbNMGwSstQMkA30hA3GG9OHP8XLn1FN2OckODzSAjOd
	 NUDIj0ZMfNFkA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Oct 2026 16:42:09 +0200
Message-Id: <DM4N25JXKTQM.3K7TP9HM68KQ2@kernel.org>
Subject: Re: [PATCH] driver core: take parent lock on deferred probe
Cc: "Alan Stern" <stern@rowland.harvard.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 <driver-core@lists.linux.dev>, <linux-usb@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Mario Peter"
 <mario.peter@leica-geosystems.com>, <stable@vger.kernel.org>
To: "Johan Hovold" <johan@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261013140615.1226992-1-johan@kernel.org>
 <DM3WA69YX6WE.2Q4DY9MIU7A0L@kernel.org>
 <ba24846a-7403-4bb1-a0cb-869cf1d44e05@rowland.harvard.edu>
 <DM40HVOBKMFI.3W1DK371ZWI80@kernel.org>
 <as86K1qm1sHtgTFL@hovoldconsulting.com>
In-Reply-To: <as86K1qm1sHtgTFL@hovoldconsulting.com>

On Wed Oct 14, 2026 at 10:15 AM CEST, Johan Hovold wrote:
> On Tue, Oct 13, 2026 at 11:01:16PM +0200, Danilo Krummrich wrote:
>> The issue concerns a USB device and its parent hub's USB device.  (This =
makes me
>> wonder whether probing a USB device actually requires the parent USB HUB
>> device's lock to be held, or whether this is just a consequence of shari=
ng the
>> same usb_bus_type?)
>
> Indeed. We could consider making this a device type attribute instead
> and move it to usb_if_device_type. May speed up USB enumeration for
> people using async probe too.

Great, that sounds like the better approach to me then.

>> In theory a USB device could also keep a reference count to its parent, =
but then
>> the driver core code would rely on an implementation detail of its users=
; I'd
>> prefer not to make driver core's access to dev->parent depend on referen=
ces
>> maintained by individual subsystems.
>>=20
>> I'd even go a step further any say that if subsystems try to keep this p=
ointer
>> valid beyond what's guaranteed by the driver core, they should do this w=
ith a
>> separate bus specific pointer.  The reason is that otherwise the lifetim=
e and
>> ownership definition of this pointer does not depend on API contracts, b=
ut on
>> individual implementation details, which is a very common source for all=
 kinds
>> of bugs.
>
> But it's driver core that needs the extra reference. It seems
> reasonable to require that any subsystem that sets a new
> type->need_parent_lock also makes sure that any device of that type
> holds a reference to its parent. And importantly, it's already the case
> for the only user of this feature today (i.e. USB interfaces).

Exactly, it is the driver core that needs the extra reference count; for a =
field
that is owned by the driver core, and for which the driver core manages its
lifetime.  If it needs an additional reference count for async or deferred =
work
it should obtain the reference count for this scope explicitly.

USB interfaces already holding an additional reference makes the proposed
contract work for today's user, but I'd rather not make that prerequisite o=
f the
API.  It would push a prerequisite for an implementation detail to the user=
.

Please, let's not add this API contract. Let's have the driver core deal wi=
th
this internally.
