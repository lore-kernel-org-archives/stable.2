Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D04D39CCE6
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373386; cv=none; b=CdgHMAySfX26eEDuka445HL5g/LnfQJu3XkCqbG8r4f8gA+4WAALmgaIhKmHeBhLobKWjU4YaC2K4PGB8BuRjpbYEmFNkbk4PaSZh9whWkFm+za2URnJ0dJC+09BON1RbwM07HtXsYWpiUnE3P0zUFMr7z8L+a+IiNOEU580cms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373386; c=relaxed/simple;
	bh=5M98h9LgBz5BhAzDN3vhK3FYBzMg0TL7AH+B/YkN7wg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDGmuOP4sf3pz+bivpJfBXaWVb9y6hjJx9T9/T54b9ZpiV6mf2/Vg5CUJ4vaTP5VyahkkEBz31WelIY0EZM2kd9TYW4ykeNkamYlo5/76ZdxeSIz22zv8ZAHniAS7RedNcEJHpAg1Vvz4cJtOYchnDH4N9yRNye9OFXWYUAzx/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=en27mFQO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="en27mFQO"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso11179095e9.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373383; x=1788978183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bghS+F6/3V7iNdu+BDTLXG9swQB37KksL6iykdp8MRk=;
        b=en27mFQOVSiqEAmWKqzBlDcoWC/E6utr/EHAk3XmBgZVp4kbmbnmL6fZS40AvVVAaZ
         +/XJacK8Tc8IUKxCa8v1KS31uTz4tUmSnL6sVZqlD/hTZC2+JjNmxSRe9QW5eyR4IuI8
         N9FzV38Mrs7iV8XJkGdoe999n1ruSEl196L+2RRJ9FIqY3MMaLagkKK2L0hi36c4oap/
         rwFn+Mi2JupjWJmXYUhu+8Q+6IIBNGiQb1OCzBCucaAQ5fd5nbV7NqlQOyRhJY9y+aFf
         FD1N5IGzg/kd6uxPN7x+hy6K5zHJpcVO/95dK30CTxVVNKlZmKsVvk+jRFW4I/m8x/5t
         xvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373383; x=1788978183;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bghS+F6/3V7iNdu+BDTLXG9swQB37KksL6iykdp8MRk=;
        b=Wc/QCI7zLUP6S6X0MiyW9tYIzyqQCNmugMe/j3Vnb4ZdEQpmb8nrpMF5HC0un0CQxg
         M+L69gTi8CKk7e9V4/wqrHXbq2bNzX5Da6ODOFoL9JvVAwYl4R1khxVc5S4cA0yMEUw5
         vZTCQlzTI3PBSwlmv0AULTZjtWupHG5jDuINnf8P4SH/0La1JgGqLcUzC7kzyZgC+uFh
         Q0MdjjM51fVg7watJhsIjGyZ5UQM09GpQQAtpK1HJgQVX6xKpaWj/BwtHZLNfjOH9atj
         18o9lZgQb9T+mExC++tPjKEWO4Z8kLRl+DJUXKNGo8Ef7CmhzMMitgpdq1hfr7+v/Dhz
         KqPw==
X-Forwarded-Encrypted: i=1; AKwUvByGSTAwQG7isvPOmjmifOe+NmUQZV0WzL6AZ1zVHjLzZ9TwcDbPw1UG107eKr1u8GrIi+sMO0k=@vger.kernel.org
X-Gm-Message-State: AFuF++kBLLtTfsRwD7oHTi/8Hrq4dcBWJkTqATJizUbEHWDJ3hU3T5zf
	iVsnRqv3rg/gZ3+N94FoLpGr1apN0I1Bxh4DLHpn7htPlePqjxm3r4d7
X-Gm-Gg: AYBFou02mZ2Sk93updVO26E/Xd4Pl29UuIZTl/Pd1lqhs+FaF7DJmwuiVCzjN4bzqBg
	GAEuwufTT0it3yx1KHfxjPVON5Z0vvR/u9SQhcf6A0YF5cEL6eLz3HClPpCFFMDIjpZSQM2wfQO
	xRGHTiP0gec3xO1JHvhx2fbrMkCz1Ct+OPio6HQwTBEDsjNx9DEmfEKMSboVzR7IurGAVFguhXk
	Na+2MrZicmFuUiwjPr4hSBOdEDAlP+TZZiG9piPP+C09v6oRyl5vlP6ZBsPUQwOmIlRoYSdG962
	YGk+VTFZWzIZxFnO9WIyUkKDNc9wVbelkX2gq6u0J5ldMfkGkr/1Dy78EQj+S9JirDWYnN5Grzd
	4dmqZPVHuo8UatU/1jG6sXViPiOKd7WLbDYpaaksnOV3Zpk03xnF29Ql821JhhcFenrGx6E58DI
	+g88IYmZdIRZTpJcWzYQePuslcb4RlU5wb9K4Fb5ZST/wnnNyhmGjTBoh5ExOIl5rK9yxZlDbyb
	t59wdbG4CZSob0kxNiFZAgVWw==
X-Received: by 2002:a05:600c:8b05:b0:499:b65d:124f with SMTP id 5b1f17b1804b1-49ce5823d9dmr152107355e9.11.1788373382397;
        Wed, 02 Sep 2026 11:23:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce554d52esm47864385e9.3.2026.09.02.11.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:23:01 -0700 (PDT)
Date: Wed, 2 Sep 2026 19:23:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Vasileios Almpanis <vasilisalmpanis@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ihex: Fix 16 bit truncation in ihex_binrec_size()
Message-ID: <20260902192300.65202e38@pumpkin>
In-Reply-To: <3552bfc7-ac6e-4133-95f9-69b4e96a5005@gmail.com>
References: <20260902-ihex-v1-1-67fdbf8d97ff@gmail.com>
	<20260902163151.59ffe47f@pumpkin>
	<3552bfc7-ac6e-4133-95f9-69b4e96a5005@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 18:35:28 +0200
Vasileios Almpanis <vasilisalmpanis@gmail.com> wrote:

> On 9/2/26 5:31 PM, David Laight wrote:
> > On Wed, 02 Sep 2026 12:21:19 +0200
> > Vasileios Almpanis <vasilisalmpanis@gmail.com> wrote:
> >  
> >> ihex_binrec_size() returns uint16_t while computing be16_to_cpu(p->len) +
> >> sizeof(struct ihex_binrec), so record lengths of 65530 and above wrap.
> >> __ihex_next_binrec() uses the result as the offset to the next record. A
> >> length of 65530 gives an advance of zero, so ihex_validate_fw() spins on
> >> the same record forever. Lengths of 65531 to 65535 advance by 4 or 8
> >> instead of 65544, so a 14 byte image passes validation while its first
> >> record claims 65535 bytes of payload. emi26_load_firmware() passes it to
> >> emi26_writememory(), which kmemdup()s 65535 bytes out of a 14 byte buffer
> >> producing the following splat:
> >>
> >>    BUG: KASAN: vmalloc-out-of-bounds in kmemdup_noprof+0x3b/0x50
> >>    Read of size 65535 at addr ffffc90000075006 by task kworker/11:1/174
> >>    Workqueue: usb_hub_wq hub_event
> >>    Call Trace:
> >>     <TASK>
> >>     kasan_check_range+0x10f/0x1e0
> >>     __asan_memcpy+0x23/0x60
> >>     kmemdup_noprof+0x3b/0x50
> >>     emi26_writememory+0x29/0xd0
> >>     emi26_probe+0x2d1/0xb64
> >>
> >> Return size_t so neither the addition nor the following ALIGN() can wrap.  
> > The ALIGN() can't wrap, the u16 value is promoted to 'int' before anything
> > is done with it.
> > What it does save is the pointless '&= 0xffff' after the add.
> >
> > Since the result is added to a pointer it will need promoting to 'long'.
> > But the compiler can assume that adding sizeof(*p) will zero the high
> > bits and nothing extra is generated.
> > (Not that this is a super-hot path...)
> >  
> >> Fixes: 9fb4ab4d3dd6 ("ihex: Simplify next record offset calculation")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Vasileios Almpanis <vasilisalmpanis@gmail.com>
> >> ---
> >>   include/linux/ihex.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/ihex.h b/include/linux/ihex.h
> >> index b824877e6d1b..0da1c4e3e693 100644
> >> --- a/include/linux/ihex.h
> >> +++ b/include/linux/ihex.h
> >> @@ -21,7 +21,7 @@ struct ihex_binrec {
> >>   	uint8_t data[];
> >>   } __attribute__((packed));
> >>   
> >> -static inline uint16_t ihex_binrec_size(const struct ihex_binrec *p)
> >> +static inline size_t ihex_binrec_size(const struct ihex_binrec *p)
> >>   {
> >>   	return be16_to_cpu(p->len) + sizeof(*p);  
> > I'd always put those in the other order - matching the memory contents.
> > (But changing it would be churn.)
> >
> > David  
> Hi David,
> 
> Thanks for taking the time to review my patch.
> I had already posted a v2 before your mail arrived.
> https://lore.kernel.org/all/20260902-ihex-v2-1-30bb117cfc77@gmail.com/T/#u
> So the problem in this case is the fact that I misplace where the wrap 
> happens.

The wrap happens in the function return - as you said.
But there isn't a second wrap 'opportunity' in the ALIGN().

> Do you think it makes sense to send a v3 to fix the commit message?

Probably doesn't matter that much.

David

> 
> Kind regards,
> 
> Vasileios Almpanis <vasilisalmpanis@gmail.com>
> 

