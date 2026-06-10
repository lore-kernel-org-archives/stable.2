Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426BD30C629;
	Wed, 10 Jun 2026 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121022; cv=pass; b=bi/duXPvq+Ty+uHV2zf6FhiAaZb4goYnGGsD4CjJxoHvWTHT/HDm0Cbvq7RT2hBHKpda1LB4cWufK3Ma6IFu2zJVCBJAHuRo1L1Sx4QelZ7xJKd+Q75UX5tLzW47hiHi5KS1itIALqYAC0fyjccNLYZO5YTkK4OX3Oe9K2xJjZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121022; c=relaxed/simple;
	bh=HZoiWQxCSYkZEvWWHtyTp3/fT19pKptniMwap4bkHeg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=BjFls/wbssGBzRQoNpmsiWwbfGaUurP2z+79wh+Hqrqhi/JATzZQ+lHq9TZLwUcisxeLBicBc37+9+NFKgMgHGKrGtkuNAl6tnPrij2T/nhV1kRNFB4ZhhZRMB4F2U7Y3s/OUWQbfEmc8Tr+ir6I1eHkbiTi+lSJhQKLnqPZNd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=B7SGjR9b; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="B7SGjR9b"
ARC-Seal: i=1; a=rsa-sha256; t=1781121006; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jTzY5PVm47QvnUws4fX8SDB2u4QyJqYNjfyA/3tyTYlhD9F2srPYylPr396QseeSbQqiWCl8GMHz9KOLBDztwf4XLpxd2zeMzZA1ouBUSVP7IGoky/5l8ZaMbJrIW6jIMXSUXH25Y2N3OIqpDOlmRBokasHgS5pzo/YAwP/cn2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781121006; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cKCZpOTZ/4HE+rnFbGr/8Miq3/o6uYgMbYuuH9ehyuo=; 
	b=ZVI2SbLoL81w4qe4c4t1m9Qb2nnrg4DvfgWOFV/Sx4CosYhUGYZ+w0ftZJOYZZ0tFAd7A3nhSnWtDRlHOzS6cQBwQPeA83FHXNF/u7nx5Hvm70FRq0Xhu3GI3/cVHhHSz2nrLEnsw1iAZNXk2BXKYnmJVx9ZZzVcQtN2p86nsM4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781121006;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=cKCZpOTZ/4HE+rnFbGr/8Miq3/o6uYgMbYuuH9ehyuo=;
	b=B7SGjR9b4B/hhVlRySyZGKzSwBXoATqrJDdQ6ZdwBP6K93Tco56xGzh3agFtGf3T
	83c6MIhEwzZcQxPlLs5WfYbhNzGAMLj3aiizcfj0ph0YgN5wjIzcJnMjznmdG1b2Wp+
	dPmPnEbFX0tpc6to33UUACZketrtO5wjNTACiltCSSR+mviA9E0DqfBYChPbHhJQUXw
	HFcrI4Xo5bwKGxdxXeI3pn1kkloaVW/XD6CAfpjAAu17jE2KljYIZ2nSYx3WNNsCL8k
	HMKjAisHEgOlZBXXKHLQsTbcbBw5qQWX/Ayb6o1bJk6XXJgFkKPTDrHphRSl/oBiqGp
	qnONXeD6ew==
Received: by mx.zohomail.com with SMTPS id 1781121005251948.3443987185943;
	Wed, 10 Jun 2026 12:50:05 -0700 (PDT)
Message-ID: <1c370a5c4e8fb3bd19777a9c5c8fa2f8202d3a93.camel@rong.moe>
Subject: Re: [PATCH v2 0/3] ACPI: battery: Do not generate too much
 pressure on ACPI methods
From: Rong Zhang <i@rong.moe>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jeffrey
 =?ISO-8859-1?Q?W=E4lti?=
	 <jeffrey@waelti.dev>, Rick <rickk1166@gmail.com>, Mark Pearson
	 <mpearson-lenovo@squebb.ca>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260611-b4-acpi-battery-notification-v2-0-4e8ed651a151@rong.moe>
References: 
	<20260611-b4-acpi-battery-notification-v2-0-4e8ed651a151@rong.moe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 03:44:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-9 
X-ZohoMailClient: External

Hi all,

On Thu, 2026-06-11 at 03:22 +0800, Rong Zhang wrote:
> The acpi_battery_notify() and acpi_battery_get_property() callbacks
> sometimes generate too much pressure on corresponding ACPI methods. On
> some devices with fragile ACPI implementation, these methods share the
> same mutex protecting EC accesses (hence slow to execute) with a lot of
> other EC-related methods. Such pressure on them eventually leads to a
> catastrophic situation that a bunch of ACPI method calls fail to acquire
> the same mutex due to timeout. The firmware of these devices doesn't
> handle mutex acquisition failure gracefully and return garbage data,
> causing even more chaos.
>=20
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
>=20
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
>=20
> Improve acpi_battery_notify() by merging consecutive battery
> notifications within 10ms using a delayed work, so that they only
> refresh and/or update battery state once. ACPI netlink event and
> notifier call chain are still triggered multiple times in order not to
> break other components. Finally, call power_supply_changed() once and
> lead to a single uevent instead of a bunch, preventing userspace
> programs from causing too much pressure on power supply properties and
> the underlying ACPI methods.
>=20
> Fix acpi_battery_get_property() by introducing a mutex to protect all
> accesses to battery properties, so that acpi_battery_get_property() can
> take the advantage of the mutex and synchronize itself. This also
> prevents potential race conditions, e.g., when multiple tasks read power
> supply properties simultaneously, or when other callbacks are called
> during its execution.
>=20
> Since the series touches acpi_battery_alarm_store(), also convert the
> use of sscanf("%lu\n") into the more preferred kstrtoul() beforehand.
>=20
> With the series, the lock starvation issue on mentioned devices is
> greatly improved according to the feedback from one of the device
> owners.
>=20
> Reported-by: Rick <rickk1166@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221065
> Signed-off-by: Rong Zhang <i@rong.moe>

Oops, Sashiko found some silly issues in the series. They were my last-
minute changes.

https://sashiko.dev/#/patchset/20260611-b4-acpi-battery-notification-v2-0-4=
e8ed651a151%40rong.moe

I will resubmit a v3 soon, so please ignore this.

Thanks,
Rong

>=20
> ---
> Changes in v2:
> - Address Sashiko's concerns:
>   - Return from acpi_battery_notification_worker() early when the fifo
>     is empty
>   - Use pr_err_ratelimited() for potential event storms
>   - Add missing `\n' in a printk message
>   - Use a separated mutex to protect all properties instead of reusing
>     update_lock
>   - https://sashiko.dev/#/patchset/20260527-b4-acpi-battery-notification-=
v1-0-2303bed8ec0b%40rong.moe
> - Minimalize the critical section of acpi_battery_notify()
> - Rearrange the series
> - Dropped Tested-by from patch 3 due to massive rewrite
> - Link to v1: https://patch.msgid.link/20260527-b4-acpi-battery-notificat=
ion-v1-0-2303bed8ec0b@rong.moe
>=20
> ---
> Rong Zhang (3):
>       ACPI: battery: Merge consecutive battery notifications
>       ACPI: battery: Use kstrtoul() over sscanf("%lu\n")
>       ACPI: battery: Protect all properties with a separated mutex
>=20
>  drivers/acpi/battery.c | 236 +++++++++++++++++++++++++++++++++++++------=
------
>  1 file changed, 178 insertions(+), 58 deletions(-)
> ---
> base-commit: acb7500801e98639f6d8c2d796ed9f64cba83d3a
> change-id: 20260520-b4-acpi-battery-notification-90d781a3f217
>=20
> Thanks,
> Rong
