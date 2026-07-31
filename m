Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ABE369D4A
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785537769; cv=pass; b=XyzXHshZRDlrDdG3fsjOUsluU51Ncnu3jdfcrzdpkjOjGAOj125taUlMr+zQUR73NpBREEsG8iZNUhXIx4cKVU0e9IK/D+1cP4Zxelh39vU8/9APLSO32m2xx7ngAFW2Bb2Z0OHwnLZiz9VDA/MbXNOmZu4VI1kZYAb28v7+zEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785537769; c=relaxed/simple;
	bh=cegOLujbI2LfUSz6SuewyzDp7MAuSuCLdFkmWG1zMrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pqhhc+dSSNoI7cT6JPrPa1xrQUfoFcVzFW25i/7ncDJdTlWCT3S23wtsW0afV0dUfAAAuYEBIIj0fiDdZlBKAqwxDIzjuUpxfPpwU/5WSABfJRcnxYu1JklZ8pEcIc39T5aJeI6YPqEg1S2id9Lh5or987RoElut9AgCbh2ATXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYKgCDUF; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYKgCDUF"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39c8dbf4ef0so14167971fa.2
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 15:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785537766; cv=none;
        d=google.com; s=arc-20260327;
        b=sqOVvXzhD3Rl0qCn9INJAKvFjYMwMoxMhr29S1JAap64wNxtviTusxwPCLkMyUAC6U
         j8AKwbWVfj3SxE00N9GAsEE6jIaMWO2CM1s8DKGZqZLx0B2bV+nfd4QzuZLr83DobuNv
         9af0+Pu29fHLeKmk7u+tIokRdKJj7pf4xSzAbuUpu5qFFz/8fPZj19LDFyT6RR70o2Ed
         AT1vvmV48GP9PeiTwzDkkcTmhDJPN9+jJ5g7aqWTnIvAE0T4OfcgxJHP/75oLG5ZMDWu
         TiKbrtiGcLdNHOl9njPoKGQHzQr3RFZNeWgqz5zLbBjhZwMC7IGATO8bUazouc26jylw
         QcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=NwrtRUyNKFktqAHy/3WHzCYE4wzBTYRSuF4qoDAGW8c=;
        fh=7rlne+LPHwgha60Z3yAxbnXIFe3K+UgQTxhwTox+3lU=;
        b=NMeC2Nsaz1UPcfKb5LoKot4tCrHLF2wG8Ip2s38ip22tkdl+3eql/NlDP+9s+FUJ62
         nS82LWUdUt8JNcWqHXhVdWTdNAQwZDKrIkBMQ9OssAj7qv2XbtsXdr0F24IEN/0J8TAH
         O0ntqqvIkyzM4mXhWHkHJodifn00OyUZbIA5mBlmRPEnG9pNZV8fkpd6b9Tk0dL++2wb
         08p+OBovY8gJ6OovpF0IToff42H7+EFLtwg8a+07I23VxxVHklbRI6hYxpI082Ejssip
         pW0SuNY+T55l+UfGK7P39JHYQObX866JtHhOfDJfbYEmPKlKDJtnTqVGU2kJrd5Qksb6
         KrZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785537766; x=1786142566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NwrtRUyNKFktqAHy/3WHzCYE4wzBTYRSuF4qoDAGW8c=;
        b=jYKgCDUFAMOyw1qqevqHuIRDDGR+aY4xZj503vXw1CDUcC7Kwogn1E0RSiLxLk6ftz
         OpIau/Qv+/IvAuKwY1yBV9OnMCpoJKJqDJZ5wxc9ewINZYcnfZIkkwiLEu+RZFx/g5JA
         PmYBSzBdq6vbwcmOW3gBQ+9qs+6mTedY2MpMYGGYX3ZndSYvibXVlJj4jC8N9PQMGhDH
         uI4oVOwFZh1n3GdhD65PkwT2HvZXCzKXNl87QQj6LXbxcp44HnUHKVl3/77aVouSQZUx
         XEfR4w4Mc6bOrVl63sM39UHRs+rx7J/rzm/e7PGeIY0JWTt5dxXtqoN4x9QpU2HfD4/I
         kDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785537766; x=1786142566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NwrtRUyNKFktqAHy/3WHzCYE4wzBTYRSuF4qoDAGW8c=;
        b=T1bCV4WsDeUvwrsxiazrJ+Qk4sm+9RjiHW50Sgp4w9CW/QvMk57FFTgqMDVaiZfiLw
         qXkjN3bMGKEQUeM/ve7o2810zrDUN0/GgJfbGSnNxR857P2prL7bcB5qcN5OkPYW/Wve
         d3I4wqNVeKoBZWLV/+1RULKP8iDXo35PGfgplZ90P08bDWhLYtgnUcFjqTsSBlJAkNeI
         wySoxAe6P695bjMeOTfMXEGFH6Npw7rfUoos6cur64W5dh0qp8sDyfxkzXQVST7DQyjr
         UQKtVf8rCo0jKliQcrLVU23dXbVNzezUFINrjU4uJC1Km0QXr2qfimL2c7DDoOrM0ln8
         2ljw==
X-Forwarded-Encrypted: i=1; AHgh+RoFYVtRoe/LUKbwFhJStdTx1TeVOa1YENL+O1Olft27KVWfkWU2HkBaUMH9866OCusjYclVt/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmkMcHDO/jgQ6YTEQrxlBBQ3vqqa7R401cc8Uovv3UVHa5akW
	M6iBzW2YdLIsE/b0MigBo4rGeA5rqn7gYC3SlRrk8CjW06wemH1tioQWNGTRr1fHOkPYUFl0gej
	piYyFTr+YHFOLVOrQBlneC4y+vYqvxEPVWbIo
X-Gm-Gg: AR+sD12e3iBIDk3XjSfqgJdTQLkgy2k3fjPbclWUAZNJTPxD8Wb66awhd0kfkEzSykl
	p+WWCDMMHqzAUSa4nXqHGstJ8KpyuoCVVCWJCzpycTcHopDc3bmKTYl8f9i8f886gzlh/bVAdTn
	ME4D1AGoqkG6QXKfcJG0fV0kJi3ZT7hP7HBKIU4BkWmGp8MfAeJRtKqx0vUGmq33R2PPa53Fjpg
	ZSMtWQorn0aCMeoYme7I6iKq/1sFPXi8K+cbvebKVd8WIm+qRpeGldIyFQTFk/ZzBaQ2EFXlT+A
	qUuVg3oUSaAzL51stJap7bRadQrU3zIkvHG7v1aKq4kp+9myF9kZ1SrV2mRwdKObDv30sqI9YdM
	nhDFB1KBVDYmm+3/X/TLmyw4sUA7jK8R9a8mpKS1Fw25xS3Nrf6ny
X-Received: by 2002:a05:651c:c8d:b0:39c:74ef:1a86 with SMTP id
 38308e7fff4ca-39f8640cf26mr2452871fa.33.1785537765380; Fri, 31 Jul 2026
 15:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712-pci-rebar-root-bus-v2-1-a1b9107a82dc@honeycomb.io>
 <20260731162424.GA1571989@bhelgaas> <CAC0H+B-p5MT4M03MMkbxr_dLjsuThkxPv3--Ciant0i2MvvqDw@mail.gmail.com>
In-Reply-To: <CAC0H+B-p5MT4M03MMkbxr_dLjsuThkxPv3--Ciant0i2MvvqDw@mail.gmail.com>
Reply-To: bjorn@helgaas.com
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date: Fri, 31 Jul 2026 17:42:32 -0500
X-Gm-Features: AUfX_mzkvLUGzJCYHgtRvb9G-SIli9XZ_yCQ5x2jz8b5Ly_BQwxe_F38zuwne_c
Message-ID: <CABhMZUX+8tjN1Hz=tf6bm+K7BV4r=1RxctiN6W_UPz9+yxG+Qg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Fix BAR resize for devices on a root bus
To: Liz Fong-Jones <lizf@honeycomb.io>
Cc: Bjorn Helgaas <helgaas@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org, Jon Nettleton <jon@solid-run.com>, 
	Jon Nettleton <jon.nettleton@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Liz Fong-Jones <lizf@honeycomb.io> wrote:
>>> This breaks amdgpu completely on the SolidRun HoneyComb LX2 (NXP
>>> LX2160A, arm64, ACPI), where the GPU endpoint is enumerated directly
>>> on the root bus of its segment (there is no root port device, so
>>> pdev->bus->self is NULL):

On Fri, Jul 31, 2026 at 12:15=E2=80=AFPM Liz Fong-Jones <lizf@honeycomb.io>=
 wrote:
>> Maybe this is a tangent, but I'm curious about this topology.  Is this
>> running as a virtualized guest?  At the hardware level, a PCIe
>> endpoint must have a Root Port somewhere, even if it isn't visible to
>> the OS (as is often the case in virtualized guests).
>
> Defer to Jon on what the actual hardware configuration is, but this is
> physical hardware, no virtualisation, running as the UEFI rather than U-B=
oot
> (devicetree) variant. See:
> https://dev.solid-run.com/nxp/lx2160a/com-som/lx2160a-com-hardware-user-m=
anual#block-diagram

I guess this must be the drivers/pci/controller/mobiveil/pcie-layerscape-ge=
n4.c
driver.  The commit log mentioned this:

>>>   amdgpu 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa40fffffff 64bit pref]=
: releasing

so the GPU is on bus 01, which isn't a nice round bus number like root buse=
s
usually are.  The typical thing would be a root port on bus 00 with a secon=
dary
bus 01, and amdgpu being on that bus 01.  Can you share a dmesg log?  It
should include the lx2160a host bridge details and the PCIe topology below =
it.
