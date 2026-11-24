Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526489;
	b=xx3sRT+0u8Imf5RxzJ/leDL8xXB8rbwSXKc2t+dc4IUd8ytqXl7JwZHZqqMwIHIea5Gp
	 D8c5fSF2nSTAkqhd5Bzb05ImguMm+OHmYviEIT6AokuIHGoTmokl1jcjxFlLJvOdZRxXI
	 NueBYOjgIDheS6lXLf19uxlmRMn61NPpirC30rOD4XqiQzo/t79bdniW2n8Z4Oh4188pa
	 NHDMlQBjivKm2SxNCg/ZE+tGn+baIh+FJzkAIAE3UaV79nrGIOY+70G5pG3vjt4/y/e+v
	 fOvm0Vpdk/ubbAOlbq9y0VadZHH/ErCqNjsmTht0OxGO+Va+g3I+VpdOrNEHAVwRjpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=d/UbTX7w9C8C4q6IDHL7EUYQeNfUj43LN0srGzDRwwY=;
	b=x1hAdR0V/D5zjnotb1bVqvAcG/oysIVgal6SjwHfKw5otYuiHaxudlX+Z+mtXKzaxJZ1
	 9U6UE1f+kJouXEC8XSTI3QK0oKnyxwvqL2AUdnuKJb/8FD3O8DDJ8Nawq5iDryXB2KgUb
	 ZZlnN8mz4V4NCGVYFuHlrL4sc+vLj2DP6FBGot4ak6l3d3gyMIdKZNPRVOU2OGcavor4j
	 peRaQRLmDYB1O8X7nv8rCFmdomqI0iDW0Nm9FHD9KYtnmI8CY+uMTwzpBvknnZvKN7U4h
	 MEGoZp8SFGuk4TI5/UtzexinLJQCO+3AjIGr9WnAiqRub/M11kWM/iAhGq5Wocev3hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XvcxKqla;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AE3606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85AE3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XvcxKqla
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3282db206d3so2651696eec.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 05:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795526488; x=1796131288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d/UbTX7w9C8C4q6IDHL7EUYQeNfUj43LN0srGzDRwwY=;
        b=XvcxKqlae6rQZb59KPpFV5YLGR70gyFPY48rh1RzIKbEyaErkfTXemu/MDTTzbaQ8o
         Ixwmrb/GH0ErSFy/pErx00T5h6fhw40tDi2OJbPd+cVNdImCNCnMCX4rA89z4fwP2xQB
         34O5HlTVLfJHOTSnqIjia1QXaA+7+eqeqEHAlVK1BTozBY/mvbpzJEqVAB1pNQ4pRrUw
         7eTzTDy23OULQpNDeQjAXZh18RS3ICXm0b9IoVnOkw5cna3B5IPqr5o7cUpi3w5tSF2m
         a8nc2qJv3R+yoM2AW5lxyS17edKvB8uVP6jWW/x1vQOKiAazbKq7n0LXafexG4zfbmid
         s6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526488; x=1796131288;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d/UbTX7w9C8C4q6IDHL7EUYQeNfUj43LN0srGzDRwwY=;
        b=UeUhKLmPe+oLsKNAVmSNyhuZukLoc09wdZiVhMcl1Nr6Te7lAoygknC+Vo7WJO5P5y
         LZs4pdcM75Ibpt3lIGZapnBo/CzCMN9I1Z6MriU6e1LgMbBo+lIKx+gZVdMlowZ2oRnG
         j+u1dxOHkvBpQ8c/92enYv3qsBx2VhVL/H4vWB2BvA1k7bdxZt+XEceqnd1VyHKMrAf/
         cXf3W68wJjEzr0xRQDbafsGsXebjH7WwcOkK29pgdGE04VX3shYafFYr/BZZykmOOkJA
         n0wJw0VNMzFHB/AlOtoMFDX6v+PTTxI/zUv8y8RK0V/pzHefNmXLEXo09G0QdECK+0l5
         bkyQ==
X-Forwarded-Encrypted: i=1; AL+hErFYEdtcR+BINE0mXqZDEE7A+V7Ab3oAtaQOA56lh1v+4zYzRLoNF67SQralgFnFbR4U0RRbOrw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+s3q+zdEmx6Ml2tFy6dCIp3SrrrjOrmyDBMWJtgcXIW74yjRPV
	l0p3yg5oLnbRfuqkAvl4CL0hmsrhNlbP/Y2Wy7wqrhdV2Zo9tgvnX7bt
X-Gm-Gg: AZFdTZe/P/gOZXElGd4IV9EjoeiGWhvwhWBFbQzP8RBE7XhFju/Tra0f9dIcCOttcHK
	eDqaA5aCuW+8wYqnX8JOj5B2PJZ6X9tNIJtUJD97CQrece61iuJmdqRcMLUuYF6WGZ/8yntapgh
	iyBW/gg7N3USzRUKrlwAa5KBRhdOZFBY6E5FhuLQGvYUP1cETDeKwhGF0xlirELdcueTpGoGcfn
	l2o1uKBcT0cap8oTKA9AgCTb/vlEB6ACxF+5b8CjNom7SXTOjMMX0dGpshfdYtjxELFL99oZqYW
	PtO4ZBlAp1xHXitUX9bE3CDFQu/sDiYp6JvijQ/kPY95yAoaNKuLxxmGLHyZoPJMSFVwYF7nBwI
	YH3/KRCLTHZdR2vGUb2gQCoF4y4qm+B/pxQfx9X8PbBE23L3SCGevSgeqB29BeL40zscg0oDUuz
	ENE+pQ3wmoNu8Wzx0nkEIr725geNHBEaFDQE9giS4SPM8Os3aq9YpLpAVjpFTlPQJY8hJ/jyTW4
	PR99UcsXJQxiqNoc1GjDWur+pKGzIxk/ovDUVbIrWDRUVpOW2x9LPEdWtO/gDYeBmm+gT/J7cVL
	Qa039GJr3pS1pbVgUy0qmA0i8SWkmXj75Q==
X-Received: by 2002:a05:7301:c016:b0:386:5adb:ac01 with SMTP id 5a478bee46e88-3865adbb1aemr14694694eec.24.1795526487360;
        Tue, 24 Nov 2026 05:21:27 -0800 (PST)
Received: from user ([2405:201:c052:b00b:9fbc:e0b0:e020:ae3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm47392736eec.28.2026.11.24.05.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:21:26 -0800 (PST)
Date: Tue, 24 Nov 2026 18:50:57 +0530
From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: michael.christie@oracle.com, nab@linux-iscsi.org, mkp@kernel.org,
	leitao@debian.org, skhan@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+a9efa71b884a23e74153@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_tcm: avoid NULL dereference in
 usbg_make_tpg()
Message-ID: <awWPORzewOifCGde@user>
References: <20260915080523.15979-1-pavankumaryalagada@gmail.com>
 <2026112001-emptiness-rewrap-28ef@gregkh>
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
In-Reply-To: <2026112001-emptiness-rewrap-28ef@gregkh>

On Fri, Nov 20, 2026 at 11:59:11AM +0100, Greg KH wrote:
> On Tue, Sep 15, 2026 at 01:35:23PM +0530, pavankumaryalagada@gmail.com wrote:
> > From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> > 
> > usbg_make_tpg() can race with creation of USB gadget function
> > instance. tcm_alloc_inst() adds the function instance to
> > tpg_instances before configfs links the item to its parent group.
> > 
> > As a result, usbg_make_tpg() can find the instance while its
> > ci_group is still NULL. Passing this item to
> > configfs_depend_item_unlocked() then causes a NULL pointer
> > dereference.
> > 
> > Verify that ci_group is set before calling configfs_depend_item_unlocked()
> > and fail TPG creation if the item has not been linked yet.
> > 
> > keep this validation in f_tcm instead of changing the configfs API to
> > accept unlinked items.
> > 
> > Reported-by: syzbot+a9efa71b884a23e74153@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=a9efa71b884a23e74153
> > Fixes: 4bb8548df632 ("usb: gadget: f_tcm: add configfs support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> > ---
> > Changes in v2:
> >  - Move the NULL check from configfs to f_tcm.
> >  - Restore configfs_depend_item_unlocked() to its original behaviour
> > 
> > v1: https://lore.kernel.org/all/20260914094426.25595-1-pavankumaryalagada@gmail.com/T/
> > ---
> >  drivers/usb/gadget/function/f_tcm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
> > index 9e6d4f39900a..2c2cf1164edf 100644
> > --- a/drivers/usb/gadget/function/f_tcm.c
> > +++ b/drivers/usb/gadget/function/f_tcm.c
> > @@ -1682,6 +1682,9 @@ static struct se_portal_group *usbg_make_tpg(struct se_wwn *wwn,
> >  		if (!try_module_get(opts->dependent))
> >  			goto unlock_inst;
> >  	} else {
> > +		if (!READ_ONCE(opts->func_inst.group.cg_item.ci_group))
> > +			goto unlock_inst;
> 
> Why READ_ONCE()?

I used READ_ONCE() because ci_group is updated concurrently in configfs's
link_obj() without holding tpg_instances_lock.

However, since link_obj() assigns ci_group with a plain write rather than
WRITE_ONCE(), READ_ONCE() isn't needed here. I will drop it and use a plain
NULL check in v3.

Thanks,
Pavan

> 
