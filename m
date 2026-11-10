Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354348;
	b=O9LcJHfbbvFrlVNwO+Xgy2hXpvC71WoVj4qE3ByCgzVorB9kTT+xykeTY4w/wl/aquh2
	 P4cE0zH5GsHfvZtxib7Cq2k7WzGkViOYcV68eOMAmk5ohBQaouEqS6goeLw/pDj4TYBPj
	 WiAvLTn4MLKlZDI2iMj1WeYQDJGTbke8zle3Gork+evQasTc4vdfvp83tD9rlw9uu1V0b
	 gt9dEtlvqC/cMYzZGFTzxvRZDDEdeI7GWLmKCXxZPOAdYfgSZSDdhp4szNTitYeBlx3pW
	 xVi+8xbWx0CRWJrOSHQozekVinr11TKt/jTbOnXNeuC/jHBDGCiw9oZiLDTIt6Qv/Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=4Lsy1zyB+gZPkYYNWFQCNSOq76EenYc9gTefr5K/zps=;
	b=3i9KvgjyVBuvjgGJO79kx5HwPdWn12wzxZgdH0iU8wa2MmfGcpK0zTdHqUfmQ868ebxJ
	 GE5SgfpYqX/YAex14ZjWryOxiEzauudS6KkuNpE5zJ+5LArtzkC9LI6LHkzsxrRvaOZr+
	 OC3VBxOJyTXMB7AZoTuR5AWs0SfRg8Ek6lQ49ggnSoGUbv70Gmd/y0N3qOxFZ4sBUzKMS
	 YViroQwloo/FBdoyejX8253e8OE38O7wLs/kfowG03ns0PZyPyNgromKro0xdSU4TFfpZ
	 /g41yFLTrVh02Uj9SUYRdXJxmjmcpGq/Z73SRzQsD/SrkbGvlQwgj//rT+zGkV0rYBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxfmtrg6;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3D9D0606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D9D0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxfmtrg6
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a210470b49so21224825e9.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794354347; x=1794959147; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Lsy1zyB+gZPkYYNWFQCNSOq76EenYc9gTefr5K/zps=;
        b=kxfmtrg6hICMHR/In+Quy6FtPzrP0qEjJrogJcgX5m8fZd5Cc4i6EkbuNbBfat6HvA
         jYkEgpBgf+8KWakwxcFHTzqJxNFY/eZvLGXUeqnTzZP00Ya/pRdKQB7a+85C3iU/TzSK
         l9pM1aazZib8wTjm0WiZ3wKNSWR7gXoFKc0TAWO0BQUFzJ+AGiqNs1Ix/Vng7CWEknz/
         H8UUTQOreCE6tBxpOwmpiHmwkp7CgXX/8S3RizmQ8Ghbs5xXZJ199iv7J+v8VjhXfOqX
         4rnL8Gc+kUKAWqxL1eIN69C5fplCmdzM/AlrH6yMbKBH1CdNLEOLT1YHQbtR0EApHuMe
         IKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794354347; x=1794959147;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Lsy1zyB+gZPkYYNWFQCNSOq76EenYc9gTefr5K/zps=;
        b=FST9fcm35q+iHVrOXFFeO4KXPuPO6VzUIHoshxvOuwL7+PQ3VQiZFRZLvRsUGiiOb9
         sU6teB/Ve7emqbsxFB1ZMw/CwoIl4mmRSk8MUucD++8A+HGzQrzynp8fA/7iQpKNhEIc
         2tVoRZ176onxLxDjSG8Bf6MdXZOgiESWPgTWru2Q60HYrChPLEpnbNdDyzHBPnA7dNXJ
         +WdV7wXhUi/0Dquaa3+zDu9RIPUN5sGM33lUqYfvTGIglAHQs8bZqbAMxZbJGE3vz7w3
         1n2MVKdbsAXicD+Y9OmV1SVivAgJ5v3rUQIUwl+C8YoOjtmunu90B2D5bnBzIxw/zLZa
         Fd0Q==
X-Forwarded-Encrypted: i=1; AL+hErH2HHsXn5Mp+tPocfYWZx+NGdJF3n/mh32inn8Pd49AYgdiW+AjFxXafOoiIPhuj3KtwnOzX+Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9K7Jbldnc8nBkVEc1x8pBMuFWK4uHA3t3IFrxjv6nazIz0OKOY
	tN/SJfQJG5ItqyPCmKpfP7eUjOMOmvlO5XM+HCCSS+jndTNLRjcy8bd0xadu
X-Gm-Gg: AYBFou0znFnWLeGobkzLPDqxz6Zs/cWX8m9kTR2jcWg9yVtzAuceOVOpP1IjD8HKXPF
	drJ4PhZPfz3udhd+IYjWRtnk2BHq+Q4MaTB5DHImSxWmcuKLFX6VAR9f5NOLIgBOpVwZZZBSljk
	ZCVQMkfFKvd3c/W5tYeCy7mPJXwCwFL4wELQJwleuhngOA+lcZ8IUmrtcDxjIXyL+QiFW8P6DLs
	m9wc+m4q4KNAC01VXBE8MIMskpnHLKPNnu5aAX+zwTm9TUhfLtv5GCQkxZ6+93gW/TM0unaLW0P
	h/08yj4lp45WtuRcu2xovRIKD1b83NX7ntq1XpZZos9Le7MdWGY60gGcwHkangwdtMDOBnpf7lB
	J31GKE0OEahWlfhBX7R/4VaaB+anV0mf3l5CfF75zJ+9tsk+69cHMohkZPe43l0cm8Jfkd44Erx
	9z0+EeFLrvFZa6imr2YAKuWtv3P5iZLZIuXR1TQ3UKBLrmvPGGlVY8l2iREsxlUO5X99mNdD9em
	HW6smCa6+gY9LGsTo5eEuXxm8PcO8vb6CPCLb9gjhiYwJA+/jNPC2U3Ri6Mcvm8BbcJeAv2tweg
	0BXWtrK3
X-Received: by 2002:a05:600c:4ecb:b0:4b9:ff69:19ac with SMTP id 5b1f17b1804b1-4ba093811d3mr8644335e9.11.1794354346600;
        Tue, 10 Nov 2026 15:45:46 -0800 (PST)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4983f7801bbsm7532615f8f.5.2026.11.10.15.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:45:46 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Azael Avalos <coproscefalo@gmail.com>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: toshiba_acpi: validate ACPI object type in
 tci_raw()
Date: Tue, 10 Nov 2026 23:45:45 -0000
Message-ID: <179435434594.2276199.18274627858522339873@talencesecurity.com>
In-Reply-To: <7ac2114f-f4a5-c94a-0578-7659a7a291eb@linux.intel.com>
References: <20261102181827.1989460-1-tristan@talencesecurity.com>
 <7ac2114f-f4a5-c94a-0578-7659a7a291eb@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 9 Nov 2026, Ilpo Järvinen wrote:
> Your ACPI validation patches seem to lack information whether these
> actually have been observed to occur on some device.

No, this was found by code audit, not observed on hardware.  The
tci_raw() function accesses the returned ACPI object as a package
without checking the type field first.  If the firmware method ever
returns something other than a package (e.g. an integer or buffer),
the code interprets whatever the union holds as package.count and
package.elements, which is undefined.

The sibling hp-bioscfg driver already validates the return type in
the same way (biosattr-interface.c line 159), but toshiba_acpi
predates that and never picked up the check.

I can resend as v2 with the changelog explicitly noting this is a
hardening fix found by code inspection, if that helps.
