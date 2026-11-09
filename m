Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794192191;
	b=Lvi8JLOmwTehLnk4/fdxAKrOZXv1sTKK2QApSyHiwMczXm9/ZLdqCgYecJ3kU/LlMW+V
	 VrIk9ig1uwbxhI8EEZlrhekyp2gF7xvk9XPBCeTjAFTiGu7M95Gg0N07VStYr3hzszNim
	 omY5+jE+WEuE5DWU4EnuPBlJFFk9h+9NvcBP/8j3+FZcc7hiVP/s4p6qfgkgVtQugDot4
	 /VnZz5IEaF9zF16Yh+am4EWXn3XbpX/rlA132BrQXpAGoKSn7kLcocT6U8fMjkP69doQq
	 l2mUTfV3QL0Hp7y3w45FeY2aFxSX7bf5hXIgEu9+WtEe/ZY49cgavFoK175IWY0rnGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=lbsHrjkpK1cq0QRwZ9oauLF2GZ88NqZOcvz5poLBJyg=;
	b=5gX/tESPiEldqSXAPIuAltr7p0YvmTxktOO/jzNbgfOXWyLj4910BTz24dKiGDyhjbGp
	 D4kC+4PD48ZmhZwyMrykVMCsWA75wGQA+DP8yqaXzHTzHMoVv1HZKXLTgykliOW2Jvkv/
	 8sH7hvaHq3JhwxGGUsRGShNrEVoB22HUQVi/mG/v0yjDkUJ1Qwmm1NRgcaRZfxYqoU5BO
	 Tb92hSXy6I17r6x3PZbE1MKlxYEi/90OgYPGpsci+bgBiZBg/C3xSxaJ65ononv9Lzq2X
	 EDFW8ieQiQcDBKmeCpxHpc70npOxisTzF/IFKSYm3q2PFm2CPAjs0xlIb3/PWrP66/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=cbxiXzcB;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D6606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 02:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B14D6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=cbxiXzcB
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91ea5600c9cso4964416d6.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 18:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794192190; x=1794796990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lbsHrjkpK1cq0QRwZ9oauLF2GZ88NqZOcvz5poLBJyg=;
        b=cbxiXzcBq1YTRCRTQ5SpDNs57XNcRCOklDPWlZDn2EVhGusLShQSlRFpqQp4aJNUGm
         TzAfh2JvnGlVH1xt6ca5uwisyuC/guT42PwIC1/gjLSVdqvPdKgHokbMEzSkXZECnaow
         YtJEeG2TMwYHywh6hmjFXAwRDdSRYzQ0of8bg2ZsdIEt1bsu8POrC8NUg4D2mhgXgZ4l
         yXQUA0OxTzasWnvl1UxIkKeBh0N/n5E2tioPhTevlGXrzWO1O9nvB6osZY69KUbUqc7G
         rmCS62U+mF3PyNnfR5iyO1yR01jv3iYytpSMgnr9cMV6Cg1tMhQg68ZstJeLpTW5SMSe
         aHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794192190; x=1794796990;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbsHrjkpK1cq0QRwZ9oauLF2GZ88NqZOcvz5poLBJyg=;
        b=uA+Y++BuEJCT2S+nJLxJKW7D0PWS3TcnTgeM+zuvfwcDZoNDYBEu5C3iAvZCeJ6fnn
         GTFg9xjxfwpxxoiNccjF1zcIub3anqEHVVMN5o1zTIjbaQkkkWB6H6g1koBs3MUyO9ZA
         nncQZQzTfno9PLfpiH2izMDea4UT0qHU5lDAKg60W3RIT+ZlCTPoUtNdkZ5hsaD+005b
         VsD78m5U9C7HBkgKfMyMamVPj6HiETbPcD6EE+4WQgdGR59yXeG6z6u4IqbgiigC8tBw
         h/vGFQxWHMq09y1X8Gtpws9TllD2qfe5WE4fy2VKOJlcLlJoaDr0IgHwqMBCd47EFePA
         Sg+A==
X-Forwarded-Encrypted: i=1; AL+hErHLzm5wqIRmCx8B/kC5KBS2VejuJYqWq8RkH3DrgVpxZtBp2X7aabl2HK0Wk5b0jYHiHtsRI5U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xIH9v/60V043vjcPHAwTthGEgcm/WLdbQcOvRXTsRkITmuDLW
	ymFro1GJrBn340/JposOkibw5HPgsWXw53DTVGFdNXLc1AcdANlyYPS8bPnycEODWg==
X-Gm-Gg: AYBFou2B4l+IucDZXbjpTlj9IZt366PL0JyUzvJOj67+1UdBTMqSF62lR/c0I/VNWP4
	ftVr082kSsr7PUDgc/rJUjHo1DLXU1QijrBUysHN/iiMKX6WcADC3s2B1uDttdupxa/Zb/8BhxM
	hvfQWHpy1r7qY1toU5MEP2qzHj8Dn5ugSy3IoiVthLU9LOnuyB3ACHqOVbatbQV4kIvqPhMDrGT
	aVtbYYCkA5iIDXfD1YBsfWRQtTyisOD8m5wLJQCI1O6Dmf+ARbJQ6WAbEzBCMJDCCZM+IfUI30P
	pFT+PmBRy3JIxjZVQsIQJSJm+A8z6KOU80n2TJXiNKoBcdUALY77gXL8jrt6kdKoRYmmgv9Ne0o
	8AWiSm5ZGkcSM/vHvHCwyMoI4KXx1AR768uasxFYggq8Jq+34rJXY6Sszr71cZbajT7PCF6k1d0
	BTtnwO916ANOFkP9oVNF7xRNF3XBWWXyWfQS3nqbIlJkDGyNWnAvRyNRYB25D4fvfE+ZzKqqb8R
	sFssMYBjJQBJgMwJ6jRsA4kTWeBN0aZyGd52kCN25b+JvsolKbfusL4AjJYojcayMWhsmYRcmy5
	zRm3vFx88wVwfusBm0gNIj3H8gDb
X-Received: by 2002:a05:6214:c4b:b0:91c:8ff2:51ed with SMTP id 6a1803df08f44-91ebd14d862mr87689676d6.2.1794192189470;
        Sun, 08 Nov 2026 18:43:09 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ecee18a77sm32078146d6.26.2026.11.08.18.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 18:43:08 -0800 (PST)
Date: Sun, 8 Nov 2026 21:43:05 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: kayano050408@gmail.com
Cc: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 0/2] usb: gadget: gadgetfs: fix ep0 request lifetime
 and event counter
Message-ID: <071e601f-4a8d-4ff6-bf1f-bae9606ade0d@rowland.harvard.edu>
References: <20261107-b4-gadgetfs-ep0-v4-0-86bdfd684b54@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107-b4-gadgetfs-ep0-v4-0-86bdfd684b54@gmail.com>

On Sat, Nov 07, 2026 at 09:46:12PM +0900, Jing Lin via B4 Relay wrote:
> gadgetfs_unbind() frees the preallocated ep0 request after disconnecting
> the gadget, assuming that no I/O remains active. With dummy_hcd, a
> delayed userspace response can leave the request queued when it is freed,
> which triggers the warning in dummy_free_request() and a use-after-free
> when dummy_udc_stop() drains the endpoint queue.

That's right; gadget drivers in general are responsible for cancelling 
any outstanding ep0 requests when they unbind, and not submitting any 
new ones.

Another thing worth fixing is near the start of gadgetfs_setup(), 
where it casts away the constness of ctrl.  This may not cause problems 
in practice, but it definitely has a bad look.

> gadgetfs_setup() and ep0_write() also race on dev->req and req->buf
> while a control transfer is in flight or while a completed delegated OUT
> transfer is waiting for ep0_read() to copy the payload to userspace.

Can you explain these races in greater detail, showing how they occur?

> Overwriting req->buf with a descriptor pointer causes clean_req() to
> free the descriptor buffer instead of the request buffer.

Can some of these problems be solved more simply, by using a new mutex 
to protect dev->req and related values?

Alan Stern
