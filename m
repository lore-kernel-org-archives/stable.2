Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795013741;
	b=IYknvM3mOzm5DHfJ/ndpYAYj8d3WOMLC/502yo7bnvlBQkd+xtLua4ygQnbOEvjfcaop
	 /OJgERulGi4xVw8H5sSvlgx2cNjkVt76tnHYU6lo7STVj5uKSB8FlBZvQqa+0L7V9PKPT
	 HMqL2ikSofqPAGQin/T0xw7ulQEHvdhrOzXoGErK6iXRt9qigo7L64Y7lYPT/gGmqUV+R
	 ULRwb/LqsRLHPnPnYmSxaCBSB3g04QT+UtWIdi1QLg6IFH05aEUQxKG+A1eU4GMWcnVGh
	 bxqjo/+0RKZ3s4eV7s6SVH4qa1vwb6TRnvaH6FQIaShrqqcaeoXsV5+vUd9ZO3XQV8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=A1AMia2vi1QSpUOJn8VNp1VkrqQ7LwCEUZO4G/j54mE=;
	b=kvSKhcm1TPqPP6+J1GhWBDLUCug6C5A2zkSUqXYP98lp56ykJWbPYTuFaWkDLDhWy+oV
	 Y5PEd7f4c5wxNKfo9stJie6w+oGu1nonneuwjd3qyfmEGA+kdnRRWMDDh0WB+hMZ7+G1E
	 W1Qkma/W3dTc0P8TV5qQTzLCQVCuxUs53eKfKXli43C1lSd0VNlyYfotNOL05ZOqaZlxK
	 XTWHni0TdJou0f5bbLDbLhWwXJgDVieWKWVmnlbLUdgsELyQFJbPy2cZeyHWABwMQVG/p
	 GoFZhKll8Sr2Iul9tRw485UGMGrGDTkR4xMpnkfPLE+KLNePGWgM7PWWhUe59I/FejQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flashbots.net;
	spf=pass smtp.mailfrom=flashbots.net;
	dkim=pass header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=cHd61Vja;
	arc=fail smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262C0606A334
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 262C0606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flashbots.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flashbots.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=cHd61Vja
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-8479f46ecd8so512356a34.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 06:55:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795013740; cv=none;
        d=google.com; s=arc-20260327;
        b=ciAp1MBNGO2cXOOqRyQ+fyd+stpdU+y9/5V2j9L//MFXaOZ65dQ17ZrecxrUxr1VeT
         ykAXyhv4AeRnYvLePoaudK2n2MA9gavzp0D/Q1TmrhNlvH2bMKA6zI9h+DnKhLXNTd7P
         mlyGrMYcxhwZ8xlis6x4X/imi7YjS5lBFhISCvmMZboCnjL9jN47vj0QAvIpMOZEmlEc
         Bw5YcjDWjuta77BM6ghRD/xi2atNDVKkHU1cPYrlMmhMa6amoqLDkmS+PdiZhAgML2vR
         6UO6eZf3kOT3Hjg0Vv2HxAi0m9ZRGZ5BM4GiGnwPfEz96t5SWJJ2GEIClYlpJhX6mSAH
         TVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=A1AMia2vi1QSpUOJn8VNp1VkrqQ7LwCEUZO4G/j54mE=;
        fh=8YqfsXH0Dgj87Rhc7vpaiHbZ/FgeVGBYscy2+HgycF8=;
        b=OPRrFGu0ONFA8tRXCoS65r/wMXXt1GoTZ044+BrnDaR5oUphWWWLCtzuO8t2PlM4co
         8KxkVR8r5eBjp6bUUIn2Ry0u7a1+0XNHoLrIKxCGRgcmL6BBndswDagnHSp+8sox1HSm
         sLslozxl/EeWMDCqeoX5Ra2SPt/mM96/8fr3+0ymCf9RvkEvvEnXD01SOHJfnnR9GYAI
         2pRsbPh1TuffK2WUGKySyDVZ3aT4pe+UrjwlzGN5Lp31ekKfWFvuxX9+4NVtukHmfwqP
         sq0Lh/4+2rGGI6e1Trxy2D94iuRHxjIG14hWv0sY7vObMZFcTj/8X5ohw9AnTw2Qixgf
         oIAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flashbots.net; s=google; t=1795013740; x=1795618540; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A1AMia2vi1QSpUOJn8VNp1VkrqQ7LwCEUZO4G/j54mE=;
        b=cHd61VjaSggyMDg7PknLa0M83mt6nX1/AJyuZZRJIbyeE/cwFkK5TnaQSymRVutPAy
         P3WyQyTe4mvkz+/Z3jDryMZklVVB9VkUzzwGOm2j1R5OO+n3HeXA3x4aPuOh5C6oTAQX
         0mYxfq6rXZNh5YnvR8k4OHZHSpuUwE9y8lN6V5KoTo9qoDJjOZtZrjQjmM7NtMu2kNA4
         Bk+b3cSYrd74/4h5WhSoN82SLgAw7SbsPKQASWPpLeoh30jatTf+9Gs5gW7+tn0qfY5+
         ka70TBQyJr3QV4cG7sXL5vKXdrXEznDj+SJ6hhTRlgwYAt6vbEJWQ64uQgCjZb7hHKOf
         yOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795013740; x=1795618540;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A1AMia2vi1QSpUOJn8VNp1VkrqQ7LwCEUZO4G/j54mE=;
        b=L9yaS/9Zd727Z2FBTRVRTWI0fgRdrL+i7iE4guAPsuxZ0nocQZ1fQOcDcCxpS1xPIu
         /2EUs+wV4wrHOe92JeTR12i0yboOY3YqCLfs1Ju17ywrPugecoUyjpbi8o/ptnzi7plx
         PCAj0xOVcE9WL7xi1pVfcjZfAVwEzyDG2bVJTRkI4Rk27e8UD4212rQRRL1MZE4tKmAM
         cfDhyYdF0biqv5/vvM4lekIdkJ1I0FtlwaKvklEL8iREPS5dT6RvyzBvC1wON8SylEtm
         jWJ+nLNXYzusO5NzrSMhxnHq62SR6LODI/kjlJ5oq5jC7QhYFU1JAdiG3M/fH/N9oE05
         Sj8A==
X-Forwarded-Encrypted: i=1; AL+hErG/9wamxihB4n98q5/lxK4IJU2MxMFySfZuIn/n6IaacZAY8OEkH6Rcgt9tbc8d1kxGAYgBPas=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HhT954F6C8wS1quDjNopoBT2M2UP1C5Tly6Umk3Zvr7OHa4Kw
	npyvK34dn+ZPb8HQiQ4y86dbUsgX06+0ernNgQimNq2oKd60sxVfukQ3SwfkqHsMVnvE3FKB2XX
	sxOw/T7PJQspP/u11EodYrPkd6y4r6dxNW7eed589mQ==
X-Gm-Gg: AYBFou27GlGU9kuFGvopG4/Hg1VQj9u8CtBGELEvf+LUGsh9+qvpHWBs8TI1GXfjui4
	fsR/MOUBDVjOYtDKfNVTSI8dOiG8MhocuRRa1MVKEzlqvKNzWVzE0BPTcLPH/Qt/bUd7RNQ0Fs8
	Eym/YTluYY+Xef56pXcVzYXcuqehKXkgasI0qhQiqAy6VeJ/5/JbhiuD8qFOUw9fNlb1hZg4xo9
	QfHkp9In0r75NMCG64ZO7OaD9xal8QdBUdE34Hx3I1bpesTbJW6dOijeowCRyu4ibMg7OaYF66W
	L6J0Pkpz796341jfgQw8tqV+fGxZeoSmfyrjdCB16Gg1GTLz6u1C1PXy4PVvBmQYAhshbv47VDi
	SpsNGc0ORD/hVHDtqMcaaY/SkmP6Z6PpaJqp4p+tbzwoc3zyDaFs/BrG4eMJlzA0dQhQIdKp56Z
	CO6bNp9Bc5Eq2QMCbJAV7NapqFT4DCBr6z9+RLIeZz/w8gQvp7Hrdx0q82tpAm4K3fCO0KrEHB
X-Received: by 2002:a05:6830:2b24:b0:844:4959:e856 with SMTP id
 46e09a7af769-862f08f6d8fmr2997887a34.11.1795013739853; Wed, 18 Nov 2026
 06:55:39 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
 <3b582cdcfe37f1d01ee71611ab2611f845261089.camel@intel.com>
 <CAKV3HMM9BKpmgWeFqRqamAsqqiofj+TG4DrOEHmbUyE0FjA7+w@mail.gmail.com>
 <0f9ba1a6acb57a8c126739175b4e38dafac08c9d.camel@intel.com>
 <CAKV3HMMfx4APmardWdtL8yhirXMuuBQMZ8xrtowHNRnTKXNRiw@mail.gmail.com> <86f99f3010775eeff6269fd9bb8f4edac10a7d85.camel@intel.com>
In-Reply-To: <86f99f3010775eeff6269fd9bb8f4edac10a7d85.camel@intel.com>
From: Moe Mahhouk <moe@flashbots.net>
Date: Wed, 18 Nov 2026 14:55:28 +0000
X-Gm-Features: AclHuK-d2hbNILXughUCStMRcZnLFB956aXQFG2DezCp6dotXFDkjtwD-G3N_ds
Message-ID: <CAKV3HMMjyHig6LTiCsXKLvgvsW+0GVitCc0ziBD9RNxH2TAuvA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5B=F0=9F=9A=A8ext=5D_Re=3A_=5BPATCH_v3_0=2F2=5D_virt=3A_tdx=2Dguest=3A_Fi?=
	=?UTF-8?Q?x_and_speed_up_the_wait_for_a_Quote?=
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "Miao, Jun" <jun.miao@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "djbw@kernel.org" <djbw@kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2026-11-18 at 01:28 +0000, Edgecombe, Rick P wrote:
> I'd think a simpler shortening of the time would be better than something more
> advanced. But...

OK. In v4, patch 2 will replace the backoff with a fixed 10 ms sleep.
Patch 1 stays as it is. It fixes the timeout check and is marked for
stable, so it could also go in on its own.

> Shouldn't attested TLS just be used to set up some other key such that
> subsequent connections can be as fast as normal TLS? 0.1s is still kind of slow.

The 0.1 s was the total for ten clients connecting at once. Each Quote
took about 8 ms with v3 of patch 2 (median of 120 back-to-back Quotes at
HZ=250), and quote_lock runs them one after the other.

Our HTTP proxy already does part of this. A client keeps its attested
connection open and sends all its requests over it, so it needs one
Quote per connection, not per request. What is left is the first
connection of each client. Many clients can arrive at once, for example
after the TD restarts. Today the last of N clients waits about N
seconds.

We don't trust a key from an earlier attestation for new connections.
If a later connection relied only on such a key, a leaked key would be
enough to pass as the TD without any Quote. The recent relay attacks on
attested TLS used this kind of gap. In CVE-2026-108269 (CVSS 9.1) the
Quote was bound to the TLS key and a client nonce but not to the
session, so an attacker with the TLS private key could relay a genuine
Quote onto its own connection. Binding each Quote to keying material
exported from that session closes this. The exported value is unique to
each handshake, so it also serves as the nonce.

> In the end I think quote based attested TLS is not normally expected to be fast.
> So is this trying to optimize the wrong thing?

It does not need to be as fast as plain TLS. But the second is not the
cost of attestation. With a local QGS the Quote is ready a few
milliseconds after the request, but the driver does not check again for
a full second. Any user of configfs-tsm on TDX pays that, whatever runs
on top. The patch shortens that wait. It does not try to make the Quote
itself faster.

If that works for you, I will send v4 with the fixed interval.
