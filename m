Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8023E0C44
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335096; cv=none; b=lufb6ny04TBOWva72A6ryw6s/XlGA+gkWKFUw6b7YNey+y7vcPyZbOo788x40LnyGkfP+iYkmUGMcrSk9cEU6GS+eb2Y5WIQQbL9AgbF5GaOU8seJAJDVaQmixnNFUndF9wCQhrbxc33cOX1aNBSFayE6a4gQfb3UyifMcUOpI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335096; c=relaxed/simple;
	bh=+iGzM7HonutIf/1fYWQXIb0gqsC2l31H6CniBpONzbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpsnz3dOPir3s0Da9hipFOBgJcXYDlGAwr6sfybEh/m+XCtK7Yf3Z4EPCJVSNqqjysDXu9PLk+0DcprK+ZKeXvStv01I5nmSu/S7f8ZheUVcEeZ1KvjlGs5x1RpSJKKQ7k3fjr0CHWEVHsR+HTmLq+5pnpPJHrppNnbrkHDw8XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcBP0NHa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcBP0NHa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EC61F0089D
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 17:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780335094;
	bh=cs/TXGwOXqiDQxl+x5whpiJodvIicydtJzJyPq8Pn0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YcBP0NHas6DazuOWE4ZTQg9cm+JXIuu7RUgjXgke0TOmZpqDRvQ7FOSybYVUwP/i7
	 6SbWySBvfNQN6vVTV+aY/4aCDtlYrMALMnrBgn+MBGehdpMYDRZhyiAlRiE1i8O/6x
	 QcrcHwF+CoP6MqeJopSLXlk0gkjFduEcjt+vbhysOaD0yPO2Yqa3IysXFbo+Exbu0e
	 Muy1Zz+ttVru5pc/BzJ4IM27+BQhBZv+VPvPampgYJGd/Dny319rdDx6orS0rn9AFr
	 x+UQATpzDuw/lg02CiyL1Ce0t5IsyZy7z/c1YtjcWR/EMf/ThWaXCXQqMUqwZyxEfH
	 1c05sbFrfM9kA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39677245e15so18072151fa.1
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 10:31:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9iEwu8gmRxbBBIJpH3ib9BL4lIDaUkEl4gE8x0N5k/0oIqCNYqWP2Od8tr9PQ8qSKxHNbCsfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPYgUn9RIv1jyld7tFxPHpncF6sXdhxUTub5VtzUxHog82nPqz
	DQRh/FebeNDF9JMNUecrEtUjH3sICIBNqMzCzEhZGcgbIz8txX9QRjgjiRXSKUPSXUVuqWs+dOV
	k8Fjtv6y6FrTp8lbeCRjZoy3HgoWua40=
X-Received: by 2002:a05:6512:b8c:b0:5aa:7107:268c with SMTP id
 2adb3069b0e04-5aa71072919mr977471e87.28.1780335093102; Mon, 01 Jun 2026
 10:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527-b4-acpi-battery-notification-v1-0-2303bed8ec0b@rong.moe>
In-Reply-To: <20260527-b4-acpi-battery-notification-v1-0-2303bed8ec0b@rong.moe>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jun 2026 19:31:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jY5ew8pA2HZ+t5MfbANT34euTOYe6F0kCt6=X9aVecmA@mail.gmail.com>
X-Gm-Features: AVHnY4JGIP2k4QeyO3EdbKvb31eVSS9HS3TWXWlHkZn4svSAUpiRIEL5bWWGDKY
Message-ID: <CAJZ5v0jY5ew8pA2HZ+t5MfbANT34euTOYe6F0kCt6=X9aVecmA@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI: battery: Do not generate too much pressure on
 ACPI methods
To: Rong Zhang <i@rong.moe>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, 
	stable@vger.kernel.org, Rick <rickk1166@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 8:33=E2=80=AFPM Rong Zhang <i@rong.moe> wrote:
>
> The acpi_battery_get_property() and acpi_battery_notify() callbacks
> sometimes generate too much pressure on corresponding ACPI methods. On
> some devices with fragile ACPI implementation, these methods share the
> same mutex protecting EC accesses (hence slow to execute) with a lot of
> other EC-related methods. Such pressure on them eventually leads to a
> catastrophic situation that a bunch of ACPI method calls fail to acquire
> the same mutex due to timeout. The firmware of these devices doesn't
> handle mutex acquisition failure gracefully and return garbage data,
> causing even more chaos.
>
> For acpi_battery_get_property(), it generates too much pressure on the
> _BST method because of the lack of synchronization. In detail, it
> sometimes nullifies the cache mechanism of acpi_battery_get_state() when
> multiple processes read power supply properties simultaneously, which
> usually happens after a uevent. Normally, emitting a uevent implies that
> the cache must have been refreshed due to power_supply_uevent() reading
> all properties, so the mentioned processes should have seen cache hits.
> Unfortunately, these fragile devices' power_supply_ext properties are
> somehow slow to read after battery events, resulting in cache expiration
> before power_supply_uevent() finishes. Hence, once the uevent reaches
> userspace, the _BST method will be executed multiple times within a
> short period due to userspace processes reading all properties again.
>
> For acpi_battery_notify(), a very common pattern in EC queries that
> emits two consecutive battery notifications with event IDs 0x80 and 0x81
> updates battery state and calls power_supply_changed() twice within a
> short period, generating significant pressure on _STA, _BST and
> _BIX/_BIF methods. Not only that, power_supply_ext properties may also
> rely on some other ACPI methods, so both uevent assembling and userspace
> processes call them. It becomes a nightmare when all these methods share
> the same ACPI mutex and hence vulnerable to lock starvation. Even worse,
> after the first uevent reaches userspace, some userspace processes start
> to read all battery properties in order to refresh their internal
> states, which competes with the second notification's handling and
> uevent assembling, exacerbating the lock starvation.
>
> Fix acpi_battery_get_property() by protecting it with update_lock to
> synchronize it. This also prevents potential race conditions, e.g., when
> multiple tasks read power supply properties simultaneously, or when
> other synchronized methods are called during its execution.
>
> Improve acpi_battery_notify() by merging consecutive battery
> notifications within 10ms using a delayed work, so that they only
> refresh and/or update battery state once. ACPI netlink event and
> notifier call chain are still triggered multiple times in order not to
> break other components. Finally, call power_supply_changed() once and
> lead to a single uevent instead of a bunch, preventing userspace
> programs from causing too much pressure on power supply properties and
> the underlying ACPI methods.
>
> With the series, the lock starvation issue on mentioned devices is
> greatly improved according to the feedback from one of the device
> owners.
>
> Tested-by: Jeffrey W=C3=A4lti <jeffrey@waelti.dev>
> Cc: stable@vger.kernel.org
> Reported-by: Rick <rickk1166@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221065
>
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
> Rong Zhang (2):
>       ACPI: battery: Synchronize get_property() callback
>       ACPI: battery: Merge consecutive battery notifications
>
>  drivers/acpi/battery.c | 113 +++++++++++++++++++++++++++++++++++++------=
------
>  1 file changed, 87 insertions(+), 26 deletions(-)
> ---

Please see sashiko.dev's feedback on this series:

https://sashiko.dev/#/patchset/20260527-b4-acpi-battery-notification-v1-0-2=
303bed8ec0b%40rong.moe

and address it or let me know why you think that it doesn't need to be
addressed.

Thanks!
