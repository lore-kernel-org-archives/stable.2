Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.197
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793702064;
	b=KyGeXJ/8K0/ArKZf6gQRdN8Rb2/raSdMRGEYo/iaMP5hlb6kNKj3fh5EW7H+rnZGVcQ2
	 74bpqFREQC8Rp9qTKLqWz/6zA+WiDWmWYz5Lonzz1y/8Q21lWvSBy6K385m79BHCYGOSJ
	 kncMrJdU3t3EJOmKcLVwvKB5hEtzgtsmD9NLVpSaGkC1PM9aqvVlwkW/esGFfGFAuGwZm
	 AwLoCPBj+2XSGL/egSOpxoP+naEUOF0PEXBUbfwCRCchaI4SU3Pp9aEzxuToDc+e/MggK
	 dsXMZP0FyEYVjNBfjIOBXF9PUbHYfuJr+U6naVpN8bjUO+SncFFd6N33FBECWYPujSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=XOmN6uI5+wry7lHPZoeSnGmX96UmyVh3KKEQZr7ankQ=;
	b=jsF+Di1bzpZiwnaz8OJ+xSqrYGou8ANvcslcJEdmPOLPDHgxZUEz+4d9AlUOaElXIkdp
	 v3cwZyKocQeCXu+BqKii0No825y2V0MKt6X9oDvVMw3zb5i6t/lqfS3oHlRQAFTsz7sYA
	 PvW8C1pk9tGSQvxvTDqtWjA57ZukH1Oty4LoyLlaPFpvN8jxO4vfb04yH8ZpB4crkyH4G
	 1SCda7JQp9FlJrFde3sd7gE3pOSAcAael7aMnqrI362O6Tq0L7lQBXTlWrgFh2Fyn7sXR
	 8A30EjTtarKi0rOA/jVAwD27eje13voasvet12emzzxSNxeR0C6nQN35iLMMfoqO0HA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QQNKNuGj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.197
Received: from mail-oi2-f5.google.com (mail-oi2-f5.google.com [74.125.231.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D760850B5
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A48D760850B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QQNKNuGj
Received: by mail-oi2-f5.google.com with SMTP id 5614622812f47-5413fa881a9so1559089b6e.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 02:34:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793702062; cv=none;
        d=google.com; s=arc-20260327;
        b=B+OwefAY+/7gLhqdiae7ztYjSY6VaSCx9NlaEAJlOkuN3EnM0gLZg5Sz5tYA7aNfyq
         9wK5WTSJ7j4ynJjoWnM8DWLcNWCyGN8gOZNBXiBMua8NnPrAqoVysX7BJrixf+ZvWlQn
         K57CyHduAejjjOstnzgcAeQ9VLorQ5QClTvJxYioj72yRLRzSBOnbzi5om4t7L2V6q9Y
         YLuf7QE+LI5xmM1gUGedx5o2Q8LniBTe1TTKYnR0VLVNM5vh+RV8YtsUYF8UOvStEkIC
         zZE5TyxbsTWz4SeXAk5e502VbLe0iqzZmotybCuQ4QwAgIIY1XynpDy0wTuYtwSBoPF/
         E0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XOmN6uI5+wry7lHPZoeSnGmX96UmyVh3KKEQZr7ankQ=;
        fh=ygzqn5b/yTQThaUaVG80+Lr9IsEChL+ESlvwag5EyPc=;
        b=P0p57diBf0ML9tMGQrLqtcZtpN797uaVarF1Iq/sEsO3ZwjwoXma6ugYlguwGLisej
         UNJDUhKMU1teMnPn3Mc79lX3Xy3khheT5lWtdMvIyJsjFo86JTXdGUiZWob7ugaAbqwj
         O9BgKk3Z4GaSZQGC7hiCBZoUqEkSDOycSiKYhhmpa9lRxr45tl3WHdrJgjFa+zbx7/co
         ziklcTSlK+Sw7AOdhJfCEHCVAgjGr2vnuFpVdyC0F4OjF24sY4WrufRdx6upuWxnFd+H
         GgrEuqMyfwXPk4AjuQhmpk37Z+5akJrlhJEyK4kFjOXxkQKG7L3e3YWNsa78IOgQL39V
         inKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793702062; x=1794306862; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XOmN6uI5+wry7lHPZoeSnGmX96UmyVh3KKEQZr7ankQ=;
        b=QQNKNuGjmwA56Mma1Gzi+QHMJju7hE3+AoXWA3w9Zjk970uNOO4ovFZiZl7gzB5C1N
         J7WDvynk50Mni27wvfa2ZXPcKBIQV7G8qE4YL6dohmV7MJhJZNdbni3r56oF052NtPEE
         rC0hv7+Mb4utA4q325CTjjqnxVlAbk/PWq8CneGcLzt/x0FAn9t7lXYMLmcPAAMbg3y9
         XX35lOXUbDcP4NCDFD4M2k/+YYaOWIHgYxLbAwVWAXG8XCYa1uWUwH9nPg238lQPEqgD
         KKuXTu996skOcqWgntwgfR/vgg1y+bV/07UYm2mU/VvfXwx6uDVXfSzF0pfpntXydSBD
         v31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793702062; x=1794306862;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XOmN6uI5+wry7lHPZoeSnGmX96UmyVh3KKEQZr7ankQ=;
        b=p8uRvqiW29Q5e09YKVvMHFvilYE/8XZ2Bt8g2mdjTEg1HFjjQTS8PAjI8JAzDvoj2B
         eR98At4f8Ki8EDNCfunh8Ixw2EeAusNPhGtsrzK31d1PYGT9eqRwI/GBOQe7ANwg6z6s
         im/4iSmsEfQR8RxLaagkoq2DoxOwb2lxVxUINYZRVuVMMqj3G67G1IQXy8Ni8wxRNpii
         Ab709UJi580ILJrvuD/Lp6fpRw1qzS1NbhVvpzeKsOQamhVEvTwCxycP/65DU3MBpwrX
         y7PuUYIQtgj9SygOSB+mRCOVQM+6EVB7wi1p8kuWUGjeZ0Gz/y5k7VHo0QskPynMeM1Y
         fgBw==
X-Forwarded-Encrypted: i=1; AKwUvByGgbz6ktVouZY55g9sZBurIHosVraPypHHd6w1FQbItp9Iu6+wFyK9o3A9V0GnQH82RjgBbC4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DwZdkTdDXyoDoWc6QfMFK8AR60/6NbdAL5chUrYOO79y8PPwy
	gZ6uIVV/ZFXMAspcGUFAjbOxiWLThOHkdG6nXAJpYyR3WovDkoGT89rbT/rz4p8RDEb1cQt1DGI
	Rb5q7wg7tp0y9AUnKcZRoRcKjBoIzp3yIhtPgrBoL4+1B
X-Gm-Gg: AYBFou34CG+rnsNQoxMej25YhmOGtPbGndryc7SpGG3KmJf+D5ClJ9Ksns+PSp/1NgJ
	oumlx/hlb3WBk7BhpE6I6Dn3KY13WHTwHJa2pOHO+gM+3hd0/zh59/J6ZKT53vc4QumV7bcLN8Z
	17Hef2G8MTI7MsFa6ByO+0vd/CVihBWUcAmB//QsQ83Cwi/TmmhXR03cgSNBcC41JWt+//kz9Dz
	PPRI8pa9ge9F8EfbKV93ljwkANpXJoGDI909l9tJ0Iis8KKZdNib3v0uRaDMZgk9rT5p979pB+i
	0AmT3HCmiOuFCQYiCcHP+hCfNfgtPViD4GwHuQywGkzuhZgTDHBnBNBs9N1838rSpoH7BDPSX+R
	7Ksa2kbLvauf2zcqR24RmYfR1SzYxMABKuksXZauLGPLw0A7ANdl78CP1lT6EOTH6HWk2FQ==
X-Received: by 2002:a05:6808:17a3:b0:4ec:4c7e:37b5 with SMTP id
 5614622812f47-5640ddb4f38mr7698087b6e.29.1793702062547; Tue, 03 Nov 2026
 02:34:22 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025164619.89992-1-dennylin0707@gmail.com>
 <at9xXRhD2xZhszEj@thinkstation> <xmp7ni65vbinfj4j2baisrhp6xzro3asbepuq7xp3mvx6maptn@r4dnoj63uw4t>
 <at-XtWBQg3jv3H8Z@thinkstation>
In-Reply-To: <at-XtWBQg3jv3H8Z@thinkstation>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Tue, 3 Nov 2026 02:34:11 -0800
X-Gm-Features: AclHuK9ZD1xD5M3EAerFCyanz0JIq-n7E7W9-r11Oa-jyzsbvAJqtwo7Cf6PVcU
Message-ID: <CAGEkeHfq1xZf_jMw9a9cz3iunj6O3UZ4-=iW-65aN2Ss0oT3Uw@mail.gmail.com>
Subject: Re: [PATCH] shmem: do not extend i_size when no data was copied
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Jan Kara <jack@suse.cz>, willy@infradead.org, hughd@google.com, 
	baolin.wang@linux.alibaba.com, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 26, 2026 at 06:18:39PM +0000, Kiryl Shutsemau wrote:
> The per-filesystem alternative is a 'copied &&' in every ->write_end.

Would it make sense to keep this fix local to shmem for now?
I'll check the folio handling before sending v2.

Thanks,
Hungyu
