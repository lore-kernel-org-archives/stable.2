Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571109;
	b=AesAEw/GBuGUaP90G2tLhG73qezhXXbMW31FFMNsI63A3VSZFVdLYfw8qCqUSHmw9WpR
	 0p9I4norusLNZGo+M1gUUVmPQIlefi4cfZpyWfdcFC0eWbtzXTaF0fK9NK9I/LcNPyC2U
	 dZ5gX+LKx3E2ff60aW0coNtmwBl7LRQIzrfpIIKN5tMzJQUzHy10b1QQz3or1cDpVaQTU
	 456J+mZ9VLZd8BpYVh1ZBpYvuKZVJU8kscYlxst3FrxUuKtyVdSRSztqhEvOMEAgDXlej
	 6fDdX/6Fy37xpMqZsMQbyyDiqUH16U8y0wEbK17iGR+Dak2tqDO+qLij4OlG4PGiI6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571109;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NSdHvJ1c4zpPbn3GmTZcrFFhDVtyN2FOhraiFJ68E5o=;
	b=Me1lDSHzbxKiuKOMtvPXBvq88CQLCn7I4PrCECZ79CSI2EGRbY/U5JNy7st+nyxg5XkX
	 W3dOeaRY9Jg7rr00PK0b3gwJdSkiguzhaKiGMxGCl2oTYLSaQt08fnOrZT2XZD7vcUzS+
	 4tm9VDl51PNj05ysih72QOsQFmg00zyJxHjbADSwGTaDjEiOuwJL9ZVqO6RRrgDA+8UEq
	 42FiHy5xAjC2qslonPNzbjO/1iXhPlNZ6NZvhcBVXyJhtP6VoZhy2KYA27x57ZMfNQMrf
	 s2aEaAWKD6b+8Yl3q50lU+FE7rGsk5cQr9NVkdvbcVnn1VdfIRU3GebxDs8v1eis97w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="s0gU/OWm";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94555606A32E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94555606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s0gU/OWm
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so6349385e9.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794571107; x=1795175907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NSdHvJ1c4zpPbn3GmTZcrFFhDVtyN2FOhraiFJ68E5o=;
        b=s0gU/OWm8v6mJwnBITQZHRyZGMnBastiVUUJwJ2grcp9wWCzIeqbZDGsdqUNCmEdK4
         o+pImQoBBA/w8RERNzYVlVY2C+JvnkGPwFEapewM9oGDxf4hYi+ZjE7KjtAUuayw+NEe
         6cmf377gs9AYu3Uz7NhknAparrBPlDUhxuC1rw/tkRbrDS/PscoPpbjs9/TbkcTrIig9
         HAHmteYPcZu8tIGnotVcY9HpR3w/vxtGpqip+B2Xhjh++yveRZpYhDxE/jPxDpHk8uFc
         m4dv7PSytl7uJ2SMIP0N9tHj2FVGa/eQjWNquFtIDvTgqol2+FCa5xi/HMSL1slKwnCF
         k6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794571107; x=1795175907;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NSdHvJ1c4zpPbn3GmTZcrFFhDVtyN2FOhraiFJ68E5o=;
        b=gsSx+an1z5WX6StowFGHbWPmbkcAJtpIMtmeE/z2qecAQpwaeSDvFzdUOpT+dTYH1A
         0dMQst9T1+aFXDz7UZwUt5ncnczRjr5F629zd6m62wd8QZmihNKLgfEDtl6aZvikjwaQ
         iHgmpSxizd8qFxe8g+RfIhxpH1ODXcaY0wIQ8DwMFoPS4m8NQzzBcQgRmPXDh4d/hD21
         xQyysOnZD+ffAmko/aqecBpM0l3R9m7RRu21ml4FJWTwl9392yCR8wQ3pdZ5/Jelygr1
         +1t0AL10NWW0d6vPSvlA97B2NKorHbEuyE8DxDuh7nEJRG/EpRiUuZOo4+Re23QcqxK5
         Us7w==
X-Forwarded-Encrypted: i=1; AL+hErGil7lZp3bLQwvBjw2VuxXxRlSE2Al8IQUkkjlpcUpGmw3FzmSZYjhup8Wsluzy6x8So/jpUe0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wTUDGaoYVn/M2E5DrQdVtGdWvIs064Jw9bbzAgrc99OS3uIer
	9mknEXn099geGQQTvb3VsEhLyoD2zcuGea5qnLCF27hIIkBrJAMVZROq
X-Gm-Gg: AYBFou3+304voMMI3VHn+o0Artzrjml6KafaP7Dy0BBkomW+Md/sm8VvkansXU3sqAJ
	nPiBJcoQ6c+keawDbvfgyYXtXtFxXuqWS3rRIBm7hwiyyuTVfLYnyR9EZ0BqA0BP9zsutIW42KI
	gSFbmwupuXlI6mibUuldpqImUng34QClicigm2XS3zOuVvlQsDgQXtELKhr1nJXk3Gj8CB+anmK
	pxL+EKfW+kbjlsskc9MdhtVVcTGOHCTMt4lQmkYbv1oCke0Kqrz01E5vt/g6Izm4mQKfXLeOpBc
	tkiYEvRuhhUnKcH6Qq+3jg2RxX5Ye0UsLvG9MFCaxSrx9tK1zJPdRyYnCT4ePrQZVLfm5CviHWY
	Ay5SpIbrlWNgsamRLtkjTel2goniLfVsxZibR5oZJ+TaXGfYjUvXVGN1RuaIff4/gMpK1sL0CG6
	Y1P5hnGniXMPbA6YIkpgbNF52FR3YDAYtSP951FxDJEKjnYU/RSKn+KtH47/UeVR2n3N0FJXIeZ
	sdnOSkmSWPUYXpUhVKmzpjdcL7iEh5gJjgX8BOvO2ia+ayTosGl+hISfbwyzefpxDMNQN123CfQ
	uscEBSH5xdZzqvfMsf+U9dNgUOtLMVqU7dDvXZ6kBfpCNuUYeCyzgD7HCIIxg73R9Fk=
X-Received: by 2002:a05:600c:4e49:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4bb55aa999dmr44030125e9.33.1794571106573;
        Fri, 13 Nov 2026 03:58:26 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm252917195e9.1.2026.11.13.03.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:58:26 -0800 (PST)
Date: Fri, 13 Nov 2026 11:58:24 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Martin Belanger <martin.nvme.dev@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke
 <hare@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Martin Belanger <martin.belanger@dell.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] nvme-tcp: use an aligned buffer for the TLS
 record type
Message-ID: <20261113115824.2f96b66b@pumpkin>
In-Reply-To: <bc96a186-5a19-4896-8465-ccd1df5a33bf@gmail.com>
References: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
	<20261111-nvme-tcp-live-ctrlrec-v2-1-6295202b84de@gmail.com>
	<20261112223707.3bf1e1a6@pumpkin>
	<bc96a186-5a19-4896-8465-ccd1df5a33bf@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 06:34:06 -0500
Martin Belanger <martin.nvme.dev@gmail.com> wrote:

> On 11/12/26 17:37, David Laight wrote:
> > Is that right?
> > You are changing something that was CMSG_LEN(1) to one of CMSG_SPACE(1).
> >
> > I've a feeling it would be right if it was a struct, not a union.  
> 
> I think the union is right. buf[] covers the whole control message:
> the header, the data and the padding. CMSG_SPACE(1) already includes
> sizeof(struct cmsghdr). The cmsghdr member only gives the buffer its
> alignment. With a struct, the header would be counted twice.
> 
> On x86_64, CMSG_LEN(1) is 17 and CMSG_SPACE(1) is 24. The union is 24
> bytes with 8-byte alignment. put_cmsg() writes CMSG_LEN(1) bytes and
> sets cmsg_len to 17, as before. It then advances msg_control by
> min(CMSG_SPACE(1), msg_controllen), so CMSG_SPACE() is the size it
> expects.

Ok, you are changing the size - which is what I noticed.
In this case it makes the on-stack buffer 4 bytes bigger - which
probably doesn't matter.

I'm sort of surprised it is 8 byte aligned.
Historically it would have been 4 byte aligned, and the kernel still
has to handle requests from 32 bit apps where I'm pretty sure the buffer
will only be 4 byte aligned.
But I've not checked and it isn't really relevant here.

David

