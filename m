Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794263743;
	b=uf9uck8Kr5cU64qyzyQs0Hshq8hzUv6lHQpZZSev04iD/o6ga8ly4TIRX/+mHlwYZm9m
	 NeC12hQD02dBN9J4Yj3mak2HZVV1R1uEpFbca9Bkjvp9PVUOiTByzKgZ4aqj1LLhaOz7A
	 Sx/6UcKVO8n1rX17bKJo+j1qxXKva8r3T9alLUmuXBp/UsQ6Te/bpdfTlHz6j8VsSe/29
	 IkCmv3CNjDmHuTvRHYbvXoyJoLIGMG8MiP0Awu8n6l+WO9Ye3hUkFgy2ngAxWspqBbeEy
	 XZZL136D2PMG9h0njcD+hDrgwDtYVnUX5k6GRz4Jumgp3kRQeDJe0TotNE0R4KzC+Cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=67p1G3+w9tarQfWyJ/zTAqZ1CBC4ltn0eogZwjXmF2A=;
	b=k66wAOaP+guNPQYVIIZz7BpOWaOH0d7wa3sIFyCRImYo7QL/ddn/AOo9tq2DvJIdG5tH
	 em7iM5ig8TA+J0Xo2WCVbsOrjPJMU3zQzSkzB75IvE1mcnRFfrVym8ZVjVJuX5DHd/I0v
	 OIpfPWrgClNigpz2wlwE0qEltfAnA0Tvv7Ec7++lPOf97UYCLyQ2pI1boINKBykrqTmBD
	 3w4XN1FfML0oy3LH26IyF4eowdWjeNbHl4mTLAjtsVS2q+tm5Fw6JMgh90ZMmVxf4wGxG
	 CuXgG9ZA8duRSxjsEUxTVdA6U7XrzRLwOBgyAYmGh8Q2G4xmZuGqb6RJllEdtmdBtjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Z7315H/0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22314606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 22:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22314606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Z7315H/0
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso716608f8f.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 14:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794263741; cv=none;
        d=google.com; s=arc-20260327;
        b=qwzdy3BIoM8O01Hd9SNJBNe23kFm67D9P5TkWDQh/pOIM3I5xrquOUZTH6Mr/Iehex
         PPmC5FO4e7+L2hvZBSGzQ+jhQrAKVR4rxbHG0Bv0uk2PHHeoDI0idSW9TjDSg/K9Zhgg
         tdMawy2wc/BDjqg4so7sYqe/pPb3AU/VSh4fmNBVtWeuvIfT/jJThG0MvQMq82K0LMSv
         mhAo/Wq33ydQlEdTw5da6BXulz3I2QOpilw7+1JeTwP2vZv4Zd9rvBIXcS3B+ysCNGXg
         ks4EeuyxKY3emKOGvu0JA2v3toPIdP+B4z7wgyHYAV4YlzL0TsAY48kgbOlUySQCyvRM
         q8tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=67p1G3+w9tarQfWyJ/zTAqZ1CBC4ltn0eogZwjXmF2A=;
        fh=reNRyGKh/6IZLXdEO3KVTcigxsulI1tCJy9p5iBcexI=;
        b=a0gFQaytxu0LMaNCuRSImq9T69z8x202ZPKchNHb7WwfpmGNGx8qeJzkCXhs5GlMuL
         YqPu9rmx2uUtfB2BsJIOZASLNJ2OdMrIuBLm4ZBBm5Kb/FAQnECj9NiXDR2v2o1vYT3Z
         OK09iz5YOKNT6rCU8HyjNriUQQd3f+I2xRvORgKTNcpUfs0LON4YDU1W2rYIo5YZUWaf
         cXiYBlcv41lPjZA9Zmr7HpMUNYqIR2H4QguGsozjJOkOwLcXgbKhOfoXecbkaBNlMF01
         NuryG9JinPKl/Oy0cTP7gl9iT5YkLSUWzHjbhTMDM6PPP26aWGqSuaxVfvVXR4y9O4KB
         V7VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794263741; x=1794868541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=67p1G3+w9tarQfWyJ/zTAqZ1CBC4ltn0eogZwjXmF2A=;
        b=Z7315H/0Km2zQ3FDV2EWUJecKwbasT7mET/f/fQWy52qEG6qLZEU4wXcIoefS7eXiK
         HD37CyfID9UFs/yfH/wPemBpx8nSR8Kvl3Jv+p+8M0sKB5ilsJiPyn85T7Dzh6InFzEn
         JvL9TaS8vmRS3+Li8h8GjaFgnbIfsjRux1FyDrGqvCGTYsEHRhDe48zoZ+fy3nzdgeK/
         nmmw0XWftfSBjn8HHqRhsuXAVR4OSoNAvsGLs2byQJcIOeGYE1ZuNSSzQIWFHpbCJVfi
         Q5GHkaHfL0vaTWa986Oo9p97SB7e6HBjCuP7ud7DUO2Dlazoh2yYhxtSJdYr2s6nQyNd
         lIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263741; x=1794868541;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67p1G3+w9tarQfWyJ/zTAqZ1CBC4ltn0eogZwjXmF2A=;
        b=ObA3y7cfE0/wUI9FIEWlB1UrN3BAZLL+Weiw1t7JV+WYPHsoJfQDsUFn4cwxojIf30
         DPHsnRCQzViRBPpgbp2rACUm8QkZLpyFR9a1hpofreDY0fkSLmEY5TVMYqsdtgiZsyEv
         0ez4KlUO6dOQ2tyWUJbYrXjFxL1OxSzVHSp3scjkJLIrnAC4FFlNvoYxzNXEgW336uMz
         cQAytXxihJsCjBEpT5Sn9s+Dg91B3wiNBZX+XyMh1xgn9oChM7WoraZPCntUkuGixRV/
         Bqv90CGhUFQPSmRev98B0I1nLBnIuXDFvwSUlnAONMVF28T94sn2FLets1bY0DT4UMCR
         Bq2w==
X-Forwarded-Encrypted: i=1; AL+hErEP7sMt2dHaY2btN744JbW2+Xk472ahsyvD2732NMEnULGtCDQNdnjjhMwQZRA2po/t9/WThSg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tIyXMrjxvY05/MRSmQe3Dt3lRNMWtFwMGfEVwzHL0/IHWtd05
	yexbR/0zt+n/HIZq31ZbxEgAFgdq9BCYx0GfZBK0Zoimyv4Y+Obh0yr7nv0iwLrzN9DO3yC515Y
	qsIuEBCnVlqX2I1zr4AEDD3SUPuV8E7J2yE1UidHy
X-Gm-Gg: AYBFou3JJoDImgC3uF4HZB+gSr/9A+fU9Sa7Pe+A/rjmbw2c7e3ejJsI0XLf6tUJ0kf
	YR1DVgGaUrJX97Hehr8sdIyR7WPEh5QnhhArOth06vGfoP09rZm5RJVV8fbA5lwbopFZSWuoWZU
	7cCeaoqZVIvgOoW3hEjB4UHhLZLK3pfTg2z/AqffCh1lbM+FWPwGZt9PNgmC4k6zEhhIAQJtRN+
	sQraix/Sje/oXF1tQ95tNIaRq5fmTO1mJ+Tehu8b9CyXuzH7oU0RnWwQnrgIxzAFtteTHHTzuvQ
	S7RMLFeV+aZcx8d9YKX7Ve8K8aYU67xPOhBFCnUob6T+/9EayoaXnMrGrqv8CDcLcRWFkqkBG/C
	1mSsDHywl+dBtJDHceXsIMRBT9t2+pTYr68KK6U/lr0NnKcbSk0/AUIXe8Dr3U55F7BKFQ9Z/aj
	T8UDuDd/uoTBUMZ4g=
X-Received: by 2002:a05:600c:190e:b0:4a1:d97e:cd60 with SMTP id
 5b1f17b1804b1-4ba0234178dmr9170815e9.16.1794263741215; Mon, 09 Nov 2026
 14:35:41 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <18e61a85b0d13e9c.3137322e32332e3235332e313736.9c152.0000sendgmr@google.com>
 <18e61a8cb2ff887c.3137322e32332e3235332e313736.9d011.0000sendgmr@google.com>
In-Reply-To: <18e61a8cb2ff887c.3137322e32332e3235332e313736.9d011.0000sendgmr@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 9 Nov 2026 23:35:28 +0100
X-Gm-Features: AclHuK_aJUtfmZ40TE6V9dcFQ2Gw7esH26asDQKpi0oS6cQ6henkfr4bldL6-J0
Message-ID: <CAH5fLghTUOHcTAUC9_wqtP0xB18AWsca76xgptN9=wBx6mXUTQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust_binder: account for deferred work size in Thread::read()
To: Chris Wiseman <chriswiseman@google.com>
Cc: Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 4:11=E2=80=AFPM Chris Wiseman <chriswiseman@google.c=
om> wrote:
> +                    deferred_size =3D deferred_size.saturating_sub(work.=
size());

If deferred_size is zero, then this evaluates to zero. It'd be ideal
to avoid calling size() here since it's a dynamic call.

Alice
