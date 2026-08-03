Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C123F27B340;
	Mon,  3 Aug 2026 18:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782544; cv=none; b=Q2MTztKGK2IjLMh1NjY4PviwVW/jbG8UQMFg03oc4hYhWmTBJvJk8cMdFovHlJdW+TBcA5++JKMvzDIGNe9vbAUNKhQ/VEtfxQCrQ3qy+JWH+9qLik84ZJS4CJDlbjHzvjvP0ycdSOTVP2UebgKzIR03l5nOdJc5OVECJS6R+DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782544; c=relaxed/simple;
	bh=pvd+aNiQfbaYNIdoOe+0L183qaMccbNa6asoH8I2L/A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Lnv3VHKTUDsjbNpn9pgcq7Mll+j2J5As6tCEqaAmwhNWflf/pXVNupsUlLZgceJUWmOatXpyFBn8VjJbXtursavrtmheT1H4eA8mpE+mOe9OTYBaxXXjqbKAe25ehDwf77rZMo0XJ8FsBCL64HRQNs0Q+j8X6wo9/pXCI7sJQcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGE9Ym5k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGE9Ym5k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C361F000E9;
	Mon,  3 Aug 2026 18:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785782543;
	bh=2ooiK6t9LGEiEm9R9qYnYVLQv0O4AAFKR1ZIP1b4fFg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=GGE9Ym5kZQHAvWD7jXwnfQCUZqvZXqpMVJDWYuGlQOkkPM9/RooWq0Gz+UTmYvobm
	 7hCQm/gjwRhRJEnAoakMmrODF2M0d8UXqGigqn6IyGKtVJDeFRhJ9YDX1lz4mZSdPO
	 owE62hgOcBNF6WzRS3lYku8FwgZLHQ6rWd6jyUVok2shtBsEREgP5tzh9KgTNWseyV
	 KKrU56YF5F/hqeJaLi+Gir6nQkuRQgUCwcLtvmkst43ne9b29e1ShQRdKmKVo+Cl/O
	 ENGImAvMxLDXw2d8YEnOPqMCLNPy55FLcbvH/9rlCnI0ARKysql+IyHhglkOxoeZgY
	 yPq5YIqLrvnvQ==
Date: Mon, 3 Aug 2026 20:42:20 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Jann Horn <jannh@google.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    "Luke D. Jones" <luke@ljones.dev>, Miao Li <limiao@kylinos.cn>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] hid: fix missing hid_is_usb() checks in three
 drivers
In-Reply-To: <20260703-hid-usbcheck-v2-0-c5ed7bc94772@google.com>
Message-ID: <7q67s0p2-1250-45p6-496r-8n6o57005o86@xreary.bet>
References: <20260703-hid-usbcheck-v2-0-c5ed7bc94772@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 3 Jul 2026, Jann Horn wrote:

> This fixes missing hid_is_usb() checks before to_usb_interface() in
> three HID drivers.
> I've split it into three patches so that they can have separate "Fixes"
> tags, hopefully they are easier to stable-backport this way.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> Changes in v2:
> - patch 3/3: fix typo in "Fixes" line
> - patch 3/3: add USB_HID dependency (alternative would be to implement a
>   stub for hid_is_usb())
> - Link to v1: https://patch.msgid.link/20260703-hid-usbcheck-v1-0-e80259ff625d@google.com
> 
> ---
> Jann Horn (3):
>       HID: asus: fix missing hid_is_usb() check
>       HID: huawei: fix missing hid_is_usb() check
>       HID: rapoo: fix missing hid_is_usb() check

Thanks, now applied. Sorry for the delay.

-- 
Jiri Kosina
SUSE Labs

