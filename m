Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA6F37AA96;
	Fri,  9 Oct 2026 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535971; cv=none; b=IqUweQc/x7tGIioVGNgm444U7+ZS02mf7m8lmNmqsAuGNCQGH/TOCkYLFKIOs8sJtNmTO85DiGt7CyvZDk+PiqQVfYdaPvPb8eTRW+r0bxweY8B40Be02Gk7wUjv4+OF7GexfcKrtllZw5kzlVbaXbZjX141k60aZbYbOZSHSX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535971; c=relaxed/simple;
	bh=PbWDDnbDKJpKo1noXbsSv8bgvB8g+XBoEOQayiNpSbg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=eDITr1XP6C51kbU24e+6ZcIqB3QplbGszvNoje45mfXRWJTr4CqwGO7UZb9wnLUGpdWr9k7sZrTLhV6p6ZFOw5Akwz93yDEw9eW5mlZxK9ymReZ0wtynVVdw/4jYdL9RYWg0xZ+0DJMkWoScInbU+Kc0i2t2TTpAzkCc3fM1vY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWKv+0NH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWKv+0NH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8672D1F000FF;
	Fri,  9 Oct 2026 08:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791535970;
	bh=P9UyNsLxuXi7pGaCCF2/c2YgYrk5hHCKdSdcZrUS7tM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=TWKv+0NHNCi9W6psEE3NSZHQvCOoPiq5v6egPATfdg30K8KJX2+3JCk67q3yiKupA
	 cCfeRkrBPswn3KLNIcWj7Vt+booiVMMDk5A9fym8SBoSBx7x7N0bHNp5MNC7AptDXm
	 lnMLEuHvGKK4N6J6qTj74txe5oX8qLL5/qco379G8izG7QihNBr7sgdNqUInXLpocn
	 C7oZNw2EuPoxVNoEU/5Ii7ncSRlgIuZX7Bi6NKzve5Fn7zwOnU8F3EitwMDKfD4OOo
	 zuUY1uYgKlrjWTAkVFP51ebAjZtt/u3M5dXDX5hb67iLLn07j/+Z3ZPwOx1+GkiyOw
	 /mt4uHt5sLbPg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 10:52:46 +0200
Message-Id: <DM06HWVAFSOW.2F050J0BT27TK@kernel.org>
Subject: Re: [PATCH] driver core: complete deferred binds when
 drivers_autoprobe is off
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <syzbot+863936f50214e843ae0c@syzkaller.appspotmail.com>,
 <stable@vger.kernel.org>
To: "mosafer" <mohsafer@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261008154105.256340-1-mosafer@node0.quickhttpnode15.cloudfaas-pg0.wisc.cloudlab.us>
In-Reply-To: <20261008154105.256340-1-mosafer@node0.quickhttpnode15.cloudfaas-pg0.wisc.cloudlab.us>

On Thu Oct 8, 2026 at 5:41 PM CEST, mosafer wrote:
> From: Mohammad Mosafer <mohsafer@gmail.com>
>
> device_add() registers a device and then runs the bus's initial probe
> via bus_probe_device() -> device_initial_probe().  With
> drivers_autoprobe disabled for the bus, device_initial_probe() skips
> __device_attach() entirely.
>
> That is correct for automatic *matching* against the bus's driver list,
> but __device_attach() also doubles as "complete a bind that a driver
> already initiated": when dev->driver has been pre-assigned outside the
> normal match/probe path, its else-if branch finishes the bind by
> calling device_bind_driver().

We've recently had another patch to fix up cases where dev->driver is
pre-assigned. Please see [1] and the corresponding thread.

IIRC, there was no reasons the remaining users can't just use a proper matc=
h()
callback instead, so we don't have to worry about those edge cases in the
future.

[1] https://lore.kernel.org/driver-core/20260820084557.129908-1-khiemtranzo=
532001@gmail.com/
