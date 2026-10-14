Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72C836167F;
	Wed, 14 Oct 2026 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989377; cv=none; b=KAlJ+Tp98BMnQJmR+Br85/NW+RmnPCikJf/xqRZqjjMl1uW2+CQ7qOmti1LDnfuC3+WsNRPVkNaUyZ49YF5mlQutTrmRkBedDMBTHYlPVr8x2lEF08Ce/e+OgajujTXgvsIX8+aC91nxbwLW0isMkfDv5uEhfqNYbmVu+6ECaIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989377; c=relaxed/simple;
	bh=hPLpi6Ywz/Zi35eBcOCtNrznDFL590clNlJ0uAarxJI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=t9I8cR0Gj77aVtrnXCxIykIMMdwaeyFKS5X5vXmQbNebh5+sU2HsuDYN/asisUYL7h89vUy55ZZOzzl6sZ9iehD+jDcYXFNZGebVOc0lygBn5csVbUjkBIyBz5Zkic0C2wQDAP2P/rH3P9cLnFPLyAsBHGgLxNtLs4pJs+Ft1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyCTxP3Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyCTxP3Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5510D1F000C4;
	Wed, 14 Oct 2026 14:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791989375;
	bh=VkGQywlxdW2HyQHqD30g0LqoOskVB091xOSb05TMLLQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=JyCTxP3ZSbOviMEedo7hhb+khoq8e+WoR94HfK6EShZJ99ecsU04ojxCqpb3ieZOP
	 aHR1DCtVyQJeFtJSNok4h/hoT4EbmxTh3BU1wFNYdkFqtwH8NByu9JugznnCoQKYH8
	 hT/ru1N5W4vC82sF9YIXDuiGy7Jzt6yM8sPeUKUQXv/wOFtmGNDu3iHGuzpkSjMV3r
	 avl+uflpiLE3DZceQEosdbJqOBQm2MXDh1B4DWHZXsNSScUuEGFriyPJ6J8yC/iDY0
	 6U1lwDWIWuLUXmiuRvGApIaWJiB55OibS9cq0A1F6oO0H/E5LzYAMVPj0b8rT93YMw
	 GytLbLihXGlGg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Oct 2026 16:49:31 +0200
Message-Id: <DM4N7SKUMF98.32GW04E2EVM8I@kernel.org>
Subject: Re: [PATCH v2 1/3] driver core: fix parent lock use-after-free on
 USB disconnect
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Alan
 Stern" <stern@rowland.harvard.edu>, "Mario Peter"
 <mario.peter@leica-geosystems.com>, <driver-core@lists.linux.dev>,
 <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
To: "Johan Hovold" <johan@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261014133109.1392265-1-johan@kernel.org>
 <20261014133109.1392265-2-johan@kernel.org>
In-Reply-To: <20261014133109.1392265-2-johan@kernel.org>

On Wed Oct 14, 2026 at 3:31 PM CEST, Johan Hovold wrote:
> + * @need_parent_lock:	When probing or removing a device of this type,
> + *			driver core should lock the device's parent. Note that
> + *			the device must hold a reference to its parent.

For the reasons described in [1], I object to making subsystems responsible=
 for
the parent reference needed by driver core's delayed accesses.  The driver =
core
should acquire and release that reference internally.

[1] https://lore.kernel.org/driver-core/DM4N25JXKTQM.3K7TP9HM68KQ2@kernel.o=
rg/
