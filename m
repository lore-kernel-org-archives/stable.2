Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795663656;
	b=NQwyWTaJeKKpEaN2AwjA9XPlL1lp8AGS4hMteLWvmjAbrw0hvS0X3Y81/AXPGDO5/U42
	 QjxhR+7iJZgiggbxrQtqaIHz4tisr+jbyQvYy7E1ygtuVSI3+Z0BUnXT+kfg0xaCud43n
	 UvSZWwhXwkix0VXr6z4M9Ep48yMHrpbT4n7PLWVqHSxOVuGSKMLhXo0j8PJZ7MdItFypd
	 bS1z7wIp3rUqty3xz6vhd11VXDhMZkFrALaOla6Bfni3GZr5tJTGuhd7EuBYYy8fgZZGK
	 /PPgLvBOS6/xV1PRobt6RUjgNVQFn6Y4TgprjY4Qs5hsOhnsdYFgkSJWvF+y7RLlrHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rHPmMuoGHNMoQTUIGEVMgOH3fqXjK9wihPYFz2zN4Sc=;
	b=yFkQ/+qvbIWuI0brgLiz8jXBZ+YyoLHlIfR3p26Iy1RXln2LYM/0y9n7wNfKRB6yXQgK
	 ef7wkQs6aGTBi92Td2UKRxtLMRY3WAbOMtRU8u54HmsUdoeTNMmCJvMluOBoRpmGXX902
	 LwyCCzodw2Fp0CkjsnEIUSRRYTtMhq+4jCJLfu8zoMCeGHAUQYunMhTxc0Zy7XgnRWkVV
	 6ZqFikED+M3dfuV4SFunr2tpY8fmAHB0vzX0fVFkWjmkemZnvscr0/+fNALSAzfTH5lud
	 A4VcRlh47xfv1nsr3BlkGA+55kqnsutIacLjj7j2ElvPDcBAgFEaiVGqD8TKpMhjzNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=mOF0oNNZ;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327E5606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 327E5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=mOF0oNNZ
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-94958650b09so629865085a.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1795663655; x=1796268455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rHPmMuoGHNMoQTUIGEVMgOH3fqXjK9wihPYFz2zN4Sc=;
        b=mOF0oNNZ7zs4Aflx2JGqonO8/xWxHuYidUjZ2cXNSL2HJFvmPErd+/XT/bwZ9/u19H
         rXwNWDgMgagZ4652a7bQon6GVV/l3rQPuI1FNb3FGlyxc++Kl80Fgv42QF3dpcdN5POD
         MZUOrP0XoID851f0LINFrM+XtrXg7KmU7VzTDHP9byeGICZuelsX3SCcWaDuVft98DUX
         9CGHs+ShgHJwvlYnTtIGMDBUFB0W5BHv6Jl7isdyWjjVuiODJGCmUcoNt6f7MfqTTFTN
         NSH6LbnlFYs5a8Gfni/3Pd8Py6KWWWFeZWGO/0S//hKen8TCG+OvxS71cyKESt5cItks
         U1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795663655; x=1796268455;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rHPmMuoGHNMoQTUIGEVMgOH3fqXjK9wihPYFz2zN4Sc=;
        b=xq79fGZZmWZ7U1bCEpxPgIKA4TAUOXUc7c+qNDt+DPaxkraZfZPKTCFnkus95MzRsw
         mOJO5m53b0TO0sxab4syD2ZnFOl/f2HDpSveoJ6WnXM3Bv80jO23bw9cqH5w4c7mefSl
         okdYJ5bdjep2c6QzDO5xYJpCWjWwHeD1Cg3WhxJeIGZ3XTCtmUdThJ3DGgJFC3xBwFpd
         a6NVOBc1B7BEkfqBg0j1ikfKX1z7PLXCC+vA9Kcua/CVsx83gz36QXgR4JOKLF6kX//W
         wJOrzPLzLlC9QQJwu0u2bRQvON/Tg9bIwWLbrlwymPDTR2QLbxgrPbtv1AcUzF6iSqAd
         yrNQ==
X-Forwarded-Encrypted: i=1; AL+hErExVnPqmw3TVJgE9c0DhWlFmOjC0MfwMHLE0RgdskHyA8nJ2Ze2vaKTZtQtUnrI1YxGlDRkKVU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xSw/Rk6hKkiJlL0dVVLWQ+FGAmXufE/Pyzn6iiub44IUhaXv1
	4QDSEiWhwqgJZsdOwEZO8mWSCYqNB5TJA7xa52h//0YaoJM4u71n5E7DwpLdjPb5yg==
X-Gm-Gg: AZFdTZeRWFNgRWb1wh4LKyiH2JrxOOE0pe9CzuNlfZr3nGyezqyufofkS3WULL0Ubwy
	PrZl0z55diJApgmPenJC/lQqt4R/2PANcMZVEY1E8IWr9Sn3UHodofXT6w2/i0OejIXnXBygyII
	V68LeXUjSf6AH/8o1tir8RPsBeIlNnXBJ9kz9jdBXEhFtf1U03r7aHBHkFV2Jd6vuwk3iWcKx55
	YhJy64vnj6fHcXKrX2Mn2Ozv33FismiKl2Vk6PSF9lPGmsVQTF8rI9Z1Aa0WUbIYQPSsBIEsGF5
	e81wHmk/bx0/+rGqHfDl0nmu1XSEXICvxNM6tLFP4iEK1sY54dWJcAQ1PAsCZkwA83aoe+IMAdE
	sxhtXgZY3XC65xTitsIdA4dMwGul3qbS1DGb4Fy877VvhmfE6lfSXcloik4/v6JH+9gbRwr2NeE
	xKIMw6qdk0xFH0gsXSuqOT3AKT10C5YmWq9jiI6gj2UiIkXJjIJr7rOk1DnyKT1yBrdE3UeY78x
	sChtvHnv2wTbjjjCFRMncAjYCSEQhFm8ZFZ24mSQ/JepV2YXZb4i7jLf9FAnoGri43+NlQ7M7tj
	ou+9m33t3XQY4REuRFH6AtWOfQquAQ==
X-Received: by 2002:a05:620a:a8d4:10b0:93e:c03c:c2ab with SMTP id af79cd13be357-94a0327418cmr649897185a.20.1795663654963;
        Wed, 25 Nov 2026 19:27:34 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d00:161a::9a34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38319asm1470186885a.16.2026.11.25.19.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:27:34 -0800 (PST)
Date: Wed, 25 Nov 2026 22:27:31 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: kayano050408@gmail.com
Cc: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v8 2/4] usb: gadget: gadgetfs: fix ep0 setup abort and
 unbind state races
Message-ID: <c304b43a-0a75-4408-8cce-9f4e6a1c5a59@rowland.harvard.edu>
References: <20261110-gadgetfs-ep0-v8-v8-0-8f90434574fe@gmail.com>
 <20261110-gadgetfs-ep0-v8-v8-2-8f90434574fe@gmail.com>
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
In-Reply-To: <20261110-gadgetfs-ep0-v8-v8-2-8f90434574fe@gmail.com>

On Tue, Nov 10, 2026 at 12:13:23PM +0800, Jing Lin via B4 Relay wrote:
> From: Jing Lin <kayano050408@gmail.com>
> 
> Several ep0 state transitions lose setup abort notifications or leave
> the file descriptor in an inconsistent state when control requests,
> disconnects, or unbinds race with userspace I/O:
> 
> 1. ep0_write() drops dev->lock while copying an IN payload from
>    userspace.  If a new SETUP packet arrives in that window, the stale
>    response must not be queued for the new transfer.

The window can be reduced but not eliminated.  After all, once dev->lock 
has been dropped there is no way to know if a new setup packet has just 
arrived.

> 2. ep0_read() waiting for a delegated control OUT data stage only checks
>    dev->setup_out_ready, so it does not wake when a new SETUP packet,
>    disconnect, or unbind aborts the transfer, and can consume a newer
>    transfer's payload if dev->state re-enters STATE_DEV_SETUP.  In
>    addition, gadgetfs_disconnect() overwrites STATE_DEV_UNCONNECTED
>    before next_event() checks for STATE_DEV_SETUP, skipping setup_abort.

The problem will not exist once new setup packets are prevented from 
aborting older control-OUT tranfers.

> 3. Early returns in gadgetfs_setup() on oversized OUT requests or a busy
>    ep0 request skip setting setup_abort when aborting STATE_DEV_SETUP,
>    while ep0_poll() clears setup_abort before ep0_read() or ep0_write()
>    can report -EIDRM.

These should be relatively easy to fix.

> 4. gadgetfs_unbind() leaves queued events readable in STATE_DEV_UNBOUND.
>    Delivering a queued GADGETFS_SETUP event after unbind puts dev->state
>    back into STATE_DEV_SETUP after dev->req and ep0->driver_data have
>    been cleared, causing a NULL pointer dereference on the next ep0 I/O.

How can an event be delivered after gadgetfs_unbind() has finished?  The 
unbind occurs when usb_gadget_unregister_driver() is called, which 
happens when the user program is closing its file descriptor for ep0, 
leaving no way for it to read any events.

And as before, these issues are all totally separate so they belong in 
separate patches.

Alan Stern
