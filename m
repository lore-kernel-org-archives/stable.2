Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794271226;
	b=CWCXFYs1s3WWzpFSPUTWf+RKjVNL8XnZ9NWwuYtP5/nutORaJbQ6XEXFKCizo4HDCw5g
	 s8RN6/1blWaqSh/kPwBGyQA/cwf6HJ4TyE//nh/R+9aeew3tF3hM5ISsojlvFrBKm95Qa
	 0aEUZePSrba8JJKZTmgs49ZK72Hd4ADyz5ntrf9hdeuQ/wOc7NP5+LVq/9xkv6Rd7KbJ2
	 HWkrQSpLhDG+AdDFD2raI6l1QFLRxqoteSYEQzXQCbof3BbzGsRyJ1UWiQY9jIEzKM/KE
	 m7RR1SzofSLsaHIGZxVE+jBJeZq2TJiQFBsKwwSr/6zVV5FBHvNWvVeq//w8UXmdFGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jIHm29cyLSNyacJjUA9APKy30FWwePpOgwq8IJn4zQs=;
	b=JTJMkXmtycYdmQlq4/OIqowdYP9/pLhUuWQM7NroBRK/snTdX7NZzAwgryv0x+dlzOEB
	 oAQy6icU9ylzNfgFG2SMBiiF2N+76jiA+oYBkNv+Ccy13PSOh3LpRZsVhdh9mVNhZxQE7
	 VdaxgaVQ/7V7/Kb3v97Kat3fVwUK1wdrKkolAXbPYQ1nzwPhThSaljPpK9Rbd+QZnjcBV
	 k3bn9297B16eduy5LVV0NldA2ijteZ2W1y2v9XE2O1Nhlt1M9UJzqdhZfg1dsrEQ6vob/
	 NOYurPhpX2kcvQ6aOzxJFKKyYT7B4Ub0BZ1PNSe6jTkhjOTIm8NBMcUP0viHKAYJUfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XZvS35ee;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13E7606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 00:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C13E7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XZvS35ee
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67c0ffaae1dso1673545d50.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 16:40:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794271225; cv=none;
        d=google.com; s=arc-20260327;
        b=YGlgoF4TXBjyyMuEN5hRQAEK/kpv0iq1bPx3FROp3O4h0SOTq6h3rY0W8NxVL0YMlH
         PG4EaGOKfae60EcrHDG55+6uBDz3utaiy7BkA+O5vNpkf+xLgh/SMBUJmyrVaBf7DBmH
         qXTHoXOtIM7NcAu6qxLtTZwIBlm/GPDoW7ZyHmextaLmVcBm3vcy4E60jp6t5J5icble
         4hO0WOG0kzFKMN15uAJbAjlwXu0beKW2UCIHYsqDrDPXirra3W28p6yZ68iUVNwOw01p
         BPRS2a3IliE4/cA3DbX/h5QWpm27SO+0IwDC8z+P0G5n7+ncy6SkyJyz0H1W+11WYRrY
         mH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jIHm29cyLSNyacJjUA9APKy30FWwePpOgwq8IJn4zQs=;
        fh=aPGy2VHTY8OPclRldpxs2u7I0xig3n0t8m9bdSaCOT8=;
        b=hnwJxcT6/QqLf1j4dwXFNRbQ+w7n+oCtpknMJt4559f+ybVTDtQR1G5erMdAQ+Rd0l
         tOPN0kRfU/4EfYMrwetNsszF3laPmRKOLVZJbrZqErXnY98CsKkwhtFaZMZ//RhyPrRN
         jXUSP1IKA2klADdO5ttNwM+iREFEc0NcBmSQoLepcefIhHMUFyfPRLr0ZF7fGtK2ZcQ+
         KtNclYDiOwDMYfjz0vtWJ92aboRU0NI9p/rabzTopm17dThohYF/x0eRxwTd1ENWdnuz
         7+Fv4mZLUMjRMGC3u08TrJRnAUqmPiSYCK2Cdol+33024Z8IWFatCup83L0U+bwvtQNA
         AaUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794271225; x=1794876025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jIHm29cyLSNyacJjUA9APKy30FWwePpOgwq8IJn4zQs=;
        b=XZvS35eeaK/HyQHAK4CF0VPDalq9PdsGuF13vpv1mDwl1hP7asO2uEAesuqd1S4T5U
         1LUabBjUyjFKZUelakH8/V/CmG+PPGXW60/MSNDH1eKKYjI/MGEfEKm8Y8lLGMMO71Bx
         n7O5sHgaflDu7YqtTwxDAwQhsOj2Os1Yfh0H6CWNsOR60dwodXKFLdUD8T4nMu2raQU8
         R9HFYLPax8Bgh+b6AlJ8BG/Xiyz5uVNNl/XZ1kAfrsHDOq4jny5EYDuaCqBYqNOPEZpU
         TjATZrbT+lz32KJjKbodMnOd0K8iCvO4/IO6CsJ8jJKG0Uh9P9bml3kSnG4HZ4aCW3gP
         7hzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794271225; x=1794876025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIHm29cyLSNyacJjUA9APKy30FWwePpOgwq8IJn4zQs=;
        b=gAmbhSlEvwzX94TprnwFOkT4H8pYvTPJgI9DhMmB/F+r3I+iY2Z3rArTo4I2C+RE86
         Uusec+SAVDEEHfcMi6LV4skFxp3Or4uMyCbJpBnGR9j1KI9iTanun+aF3P5V/QXlk5eq
         WXLVwTJqX3W9Psc+CTLcCeyPEQuShvgH/BKPcEBucjzKzv8P24e3CPc5GT4OuqUg5S1j
         2XnX7aeVOKBB4TXWQ4VPSBLOJPIMmTh8ON1RH1LnYxg2BOXQFttsrCKWpCME9Pdj73sJ
         lA+XYD7OXFbmnzfGshQYbhTFFODR2cVzo08NIzsG2b/aDQTfxUqrcaKFqZlNqzCZ2F1n
         QApw==
X-Forwarded-Encrypted: i=1; AL+hErGirrs8fdSEndsxiRqQoucGNd6dpYm/cEQ9klcIS/tNSwSm1TgaZeb81IJp+GlxLo8VgXsAnvc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1JZ56isDKS4jj84MSFLesuYjEnipbKSqHccpQCwP3ss9U2D94
	MUwjm7UdIoPOdyuOXaZ744Bio9jfKMisD2yQ5K822cGkpR+9dstE6EqiTtAIWNuayIm7pC9tAIr
	uAqc7kGGNJZdPNKPwdlJur6BbTG3/+T0=
X-Gm-Gg: AYBFou2KIThyZTODiwR6VTg39fuH+nPtRK9DcKBQ0xzDXGnjjGtQcMzbKebmoGrU1Yc
	XTavu1osX1W26Ey6DLpP7DAVjopMuaD+EmHIv/IRe7WLam1NpXeW5FNW5/vsvBBlMhAJsDdbVcR
	Tu2QWNMhrnc5xLOWJq/wBrH6NjWVwkN7fMavBSjIu0ALOdrQJKBnEsZvYRzczB+uFPfBrkDGD/j
	J96l+gX770bNks0eryk0SGwoEZjNeMt5zxjNl64TsPkiZLY/aLMQHZmZhaqjFMiR/lq5r+XRl/V
	mZpyJwvaNPFMxcpX7YZtW+FrOvWG30/OscsfHOb4N59LLQCgVgtI8ybfe0eVzQe7gXVeKJz3MIq
	Q9XFI2TFi8DrjWD51ankDlQsQ469zyce1fFnD/V16xYv1lNsV5T5JzHy1FULE9v+9hD6wsixVoy
	JRxSD5s5nJwI9/vPpUtO+iW+G/
X-Received: by 2002:a05:690e:1689:b0:67b:f2b4:5598 with SMTP id
 956f58d0204a3-67c5721ba80mr634363d50.47.1794271224699; Mon, 09 Nov 2026
 16:40:24 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107134939.482764241@linuxfoundation.org> <20261108040721.203040-1-navonjohnlukose@gmail.com>
In-Reply-To: <20261108040721.203040-1-navonjohnlukose@gmail.com>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Mon, 9 Nov 2026 21:40:12 -0300
X-Gm-Features: AclHuK9SHgHcicUs2AUaH2zErP3Dq7iLJexRZNx6FYTyrctQbb6uYGleUviNq6g
Message-ID: <CAHBRX4FXKxphkMUzBsV0Scqo5ZbFryUa7MfYa+6_wD5f_vDh-w@mail.gmail.com>
Subject: Re: [PATCH 7.3 0001/1257] drm/xe: Implement Wa_22016122933
To: Navon John Lukose <navonjohnlukose@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, 
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Sasha Levin <sashal@kernel.org>, =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-xe@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg, Navon,

From my side I'd prefer this goes in now: it fixes real platform
freezes on MTL/ARL (TLB invalidation stalls on the media GT), and the
probe/resume cost Navon measured is the price of the stricter UC
mapping, not a functional regression.

Navon's follow-up keeps the fix with a WC CPU mapping and removes that
cost. I've reviewed and tested it, and it carries a Fixes: tag for this
commit, so it should reach stable on its own once it lands.

Thomas, Rodrigo: could you take a look at the follow-up when you have a cha=
nce?

https://lore.kernel.org/intel-xe/20261003222145.67240-1-navonjohnlukose@gma=
il.com/

Thanks,
Tales

Em dom., 8 de nov. de 2026 =C3=A0s 01:07, Navon John Lukose
<navonjohnlukose@gmail.com> escreveu:
>
> On ARL-H at least, this commit adds about 3 s to xe probe and 2.5 s to
> every s2idle resume, because the GuC buffers are now mapped UC on the CPU
> side. A follow-up maps them WC and keeps the TLB fix. It has Tales's
> Reviewed-by and Tested-by and a Fixes: tag for this commit, but is not
> merged yet:
>
> https://lore.kernel.org/intel-xe/20261003222145.67240-1-navonjohnlukose@g=
mail.com/
>
> Whether to take this now or wait for the follow-up is up to you and the
> xe maintainers (added to Cc).
>
> Thanks,
> Navon



--=20
Tales A. Mendon=C3=A7a
talesam.org | communitybig.org
