Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844135;
	b=olqPqFVufeLFK/5oCDa3hkQaQZS/XhtNUoJuj0Uam13Qn4skNw3sDuRNFfpgaWB19LK7
	 ZkYSBtHAeVUf4KQy4vjswFcozv0FD3evxmaSzPXOchKbqoJ+Shl3wrqzLORNeVTj5qsnw
	 oEYo19aTkomMapyVwZ9L9DEc58YzRXemWgNnT9Z0owSkg6MOekMi8MM3eG7P4judlUyy0
	 j8t/NJRja9fc++S++5B0rGrWQmpG5u+o3/xh/eyipJdXLVtembHhGJ2L6+7EFh/0tPXqm
	 R+6QKxlAB9w/jmHcM/v++Qhnj8ncHu4JLDdFgdpS1EOxQ+O7/YRKH/q0xI8uxydOe2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=FS02JGyQWyDQPrqY2V1gfk2fF4qT2C6KJC4N7D0XFkQ=;
	b=m1QCMdajwlNk5dELXRBS51WHHMQn6RMDVVH1PNI6JOkKHftnmpQSwzvhvNonekgC7Iou
	 2MqP59FZYP4MVGyEc0Y7wsBkLs/pT9voRL8EfS7wytNZE49XTxIiyER0Is6wDnPWs6Twa
	 cMZwRpBs5HZKJwd8YBuIJISJMQjJO464xmKdL4Q/kY6psLluc1rPuAuSIjASadWsalBIa
	 8A9r1AxYywCS4tHNwnQjCjyfLsagVj5jevf+UQAiv4KKKnL5Hp/FzDf5dgcGWQVu55ehW
	 tWbSishIwgLfRLPqfE4kuuQYecvtADH06KCj+s+FflvTTMxgnbsZ8LYQRf9yQkJ/spg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=XouADcMU;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A583606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 15:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A583606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=XouADcMU
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4d28f75d62so714019966b.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 07:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794844133; x=1795448933; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FS02JGyQWyDQPrqY2V1gfk2fF4qT2C6KJC4N7D0XFkQ=;
        b=XouADcMUL0XQFADxs3pBf+Gz919GggZE5ALx55FS9G+ehE8L9k63fjuJTqLxhO54JT
         pmhmVLb2iXKv9EUzT4YT0HTLgL9/7/zyhvhCfKwQYqF/EAZehe0OCkpbYnE5GpagJZr7
         h5ZTxds5IcGTFIli/DkSzd/ZHD/0xmv7RiB8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794844133; x=1795448933;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FS02JGyQWyDQPrqY2V1gfk2fF4qT2C6KJC4N7D0XFkQ=;
        b=zR+v9eR+B6DW7m+RmA+7CTfcmnOm0us2yij5B0KzaFgOTy5sOAA1S4i1BBV2XKOHxA
         128ZE72LmNz9HAqwUoj0lVI0KpbfTT0y3C6ksNiwa0Az7JDexKlOph5PpZkzHOEIFvPR
         LTq7eOZ6J6xQxiC3k9rkpTBwQAAdOS1UrwpkgN+yDujD2JRPjAQMkcmx/15Z3eL7SUXU
         pjDFHF3oQjtq3bEWA/i37b8WO3rJ+BTY+toNyNgW6L1yQNWXaRYTwdhj3gu1X5Nx5Dl6
         f+U5d7NZjyLz8Rgzcf8LpeD/mmpVEcsoFbdPfBdkAXR3iy76tq3/+X0Njrmq1LS6HeH3
         El7g==
X-Forwarded-Encrypted: i=1; AL+hErF18c0eiKFoMgyUPq56LrajrIBOB47CGhuoKtISRtH61sVEQ++qvUjnJyOE7bPm7+8MBfqFcUI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9RG3ue6z//9uwAKvfWMNJYmk1knIDLJEYb71iJ3RT5CHRMMqt
	LCQeDSUQnGdEslyiHZT/qRUnAL5Z/Jmu6aJ98EKYq3QWFaM5YTkwfIF/yl0kJgwBa8DKcBrcuXF
	JbLVJYYM=
X-Gm-Gg: AYBFou0MKtaRqA1ZctAawX+v4PoD00Jrjse0ViuPbxdLO386bUYZmxDVw927qMJrYVq
	Q57pAq8xgI6GR2zXMwsKS1DsohgX8Tzd/Je8+egmLVLK8Yp0abvRvUrAhWbUiFuyXxjgi6etvLD
	HN34s8gS2ES0RTwLlCWytfMzA8uxXRbSv6Yd5yei3hORfpPXXwAZ1Ibo/3y6FIvDzCVhzQk4HKE
	oqbqu+TZUBikqVXTnCuBTHymBQn5Zu0gjXGgH+TDSehNxC/HabgpEt+Px5vf/GDRNHzh3WT6hLa
	5nAb7dfygYlSpyRt8HmsD2OADdTmKn5UHK3vd4qzm1xB3DPBRq9hxCXxbbtuBKTjicJm08Y74FY
	eWZaImf87XuIo+2AotEdSZqpOTnyFGHBdgDuYLN0rOhipFd3cgo/fe5n2n2G/ydMwDCrKlXRJnM
	OfFGW15O/l/PREj5WYsEHETPalRUkBiWet/CWmPyjXyFU0NkMTg6ouhgx9SpmR6VD6ccDtsOkYD
	3HcOBvdsaewY8eB3riFjJiz8M9cEwxPFJAGYgIdSYNOhw7/DPaIPVKOtP/OAQ4MtCh3zuvKEijX
	8ek57BaPD2zODxvWOk1nz1uv24JFzlXrs+CnFzIXdbxb+Iz8h4aZt44BdHGbhU+YmmKEbKXX3ff
	9Bvu4d55vN1kS5S5tJbQlUwsj
X-Received: by 2002:a17:907:c06:b0:c21:9b4b:2690 with SMTP id a640c23a62f3a-c5096328858mr852922966b.17.1794844132943;
        Mon, 16 Nov 2026 07:48:52 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b42782sm442775266b.38.2026.11.16.07.48.51
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 07:48:51 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4d28f75d62so714013266b.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 07:48:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFQFxAlj3rnEjHO1p41qg/xcuGItTeDUuZQkL3uqIf8MXYAjowHVIDVGYCl/5w68esQf5O2UzM=@vger.kernel.org
X-Received: by 2002:a17:907:608f:b0:c2e:317e:d711 with SMTP id
 a640c23a62f3a-c509638a784mr861145066b.27.1794844131072; Mon, 16 Nov 2026
 07:48:51 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179480914308.3191731.6125228756396043444.tip-bot2@tip-bot2>
 <avrPcQ4sOkgJPbkZ@gmail.com> <20261116130159.GA1327949@ax162>
In-Reply-To: <20261116130159.GA1327949@ax162>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Nov 2026 07:48:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgmkoWHWwaQ6nsGoCiBp0hrpJuiwmoVbQ=Efun8JyUNKw@mail.gmail.com>
X-Gm-Features: AclHuK8IIj-MneOH8L5W6agOUkuIoQlSh4TEbGiPlvCYhRM7OLWTDF_kmyXir5I
Message-ID: <CAHk-=wgmkoWHWwaQ6nsGoCiBp0hrpJuiwmoVbQ=Efun8JyUNKw@mail.gmail.com>
Subject: Re: [tip: x86/urgent] x86/build: Do not allow X86_NATIVE_CPU to be
 enabled when compile testing
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Nov 2026 at 05:02, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Nov 16, 2026 at 10:40:01AM +0100, Ingo Molnar wrote:
> > Can we just limit the feature to when host == target, ie. to not
> > work it around in such a crude fashion?
>
> That was my v1 but Boris didn't like it:
>
>   https://lore.kernel.org/20261113-x86-no-march-native-on-non-x86_64-v1-1-cbc8b096d1c4@kernel.org

Well, that is admittedly very crude and hacky.

Maybe we should have some config variables that depend on HOSTCC, and
detect it *that* way. It does appear that we don't have any model for
cross-compiling in the Kconfig setup, but maybe  we should..

I'd actually love to have support for making the compiler itself part
of Kconfig, so that the gcc-vs-clang could be *in* the .config file
rather than being an external thing to it.

I've mentioned that before, and the problem has typically been that we
end up depending on 'CC' outside of the Kconfig scripts and
independently of the current config.

The recent work to move the compiler flags into Kconfig itself may
have lessened some of those dependencies, but there's probably still
lots of small details.

But for the whole "cross-compile", maybe we can just say that
X86_NATIVE_CPU depends on '$CC' being the same as '$HOSTCC'.

Or even do '$(CC) -v" and '$(HOSTCC) -v' and check for 'Target' being
the same, and having a CONFIG_CROSSCOMPILE thing for that?

               Linus
