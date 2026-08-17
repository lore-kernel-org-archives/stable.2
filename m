Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C163C2B92
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786956050; cv=none; b=s9fjXIBWbtj1kvk8V4HI+fEarOwubS9QoiwJL+pR6Bajiz/BV5NqomDrNcyz8QS/aDcKZ+M85rRy9AP6ww2FzA/dHW52vq3gzVMWp0WUvR8qL2aDkHEi1wnZbBPXeDrIPZtOf6z87Bph0OPA5QTTgQfCk/64kQcc83fEoTgw8cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786956050; c=relaxed/simple;
	bh=UiZrryI/woLbzrHwPZuKXDp6mTnlhFPB8es5+z7jzxo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ul1wZ7mQPhmGsZw3okvfxFfP4Mnda4aRFyGoyPScSSBQkrwKFVKatMFVzTdAPhQftJS/VcRza3YWcgwWL6TP+H+sxdl56/ecJpK/VkLx9fifTaCzUEhbGVvDvYvm4M+4LXTkdEMz9CVAFzWSD4nETYvgxngTcgChjAG97bx9nUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=r1L3D7zo; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="r1L3D7zo"
DKIM-Signature: a=rsa-sha256; b=r1L3D7zo4W81pdcIuldBiMxTPs+GNkl9UupMlHj3xj3eZDpAxyvlzszqjpKPLVVXIRZHO+NW4MpSZXUclO6VG2oAkFtVItIxnoH7g0ORWFukgB2YG59JtHDywEpB2/fb9iK7b7gFyUJ25UFm1wQGi0FsBwkxFlDCDn6Bx+5f7ts9E0fNL2FeBqdUkMS6XB5Ehxfc3tOYChu01PK9d1tiul/Ze9ZbHYVBYcOcVbQZr5eMNHhO823p7IAWc68Dx8+ixkFVG9OovZgtOgI0gPUYBI3HHthafFrs/qBU1EjYiIl+VGv4EA4cyrfHvMpVZPaMUJLg9vCJaxpMGbSzcqYfrA==; s=purelymail3; d=purelymail.com; v=1; bh=UiZrryI/woLbzrHwPZuKXDp6mTnlhFPB8es5+z7jzxo=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: stable@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 875708539;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 17 Aug 2026 08:39:54 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.98.2)
	(envelope-from <peter@korsgaard.com>)
	id 1wvssq-00000002Jc4-11bM;
	Mon, 17 Aug 2026 10:39:52 +0200
From: Peter Korsgaard <peter@korsgaard.com>
To: Linkai Gong <gonglinkai@kylinos.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Michael Zimmermann
 <sigmaepsilon92@gmail.com>,  Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>,  John Keeping
 <jkeeping@inmusicbrands.com>,  William Wu <william.wu@rock-chips.com>,
  Marco Crivellari <marco.crivellari@suse.com>,  Ethan Tidmore
 <ethantidmore06@gmail.com>,  Kees Cook <kees@kernel.org>,  Chris Wulff
 <Chris.Wulff@biamp.com>,  David Sands <david.sands@biamp.com>,
  linux-usb@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_hid: do not copy_from_user() under a
 spinlock
In-Reply-To: <20260817061141.82597-1-gonglinkai@kylinos.cn> (Linkai Gong's
	message of "Mon, 17 Aug 2026 14:11:41 +0800")
References: <20260817061141.82597-1-gonglinkai@kylinos.cn>
Date: Mon, 17 Aug 2026 10:39:52 +0200
Message-ID: <87o6f19m3r.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

>>>>> "Linkai" == Linkai Gong <gonglinkai@kylinos.cn> writes:

 > f_hidg_get_report() already copied the report from userspace into a
 > new entry, then called copy_from_user() again under
 > get_report_spinlock. That can fault and sleep in atomic context.

 > Update the existing entry with memcpy() from the copy already taken.

 > Fixes: a139c98f760e ("USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL")
 > Cc: stable@vger.kernel.org
 > Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>

Acked-by: Peter Korsgaard <peter@korsgaard.com>

> ---
 >  drivers/usb/gadget/function/f_hid.c | 11 +++--------
 >  1 file changed, 3 insertions(+), 8 deletions(-)

 > diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
 > index 3c6b43d06a6d..e4621e5a0b69 100644
 > --- a/drivers/usb/gadget/function/f_hid.c
 > +++ b/drivers/usb/gadget/function/f_hid.c
 > @@ -667,14 +667,9 @@ static int f_hidg_get_report(struct file *file, struct usb_hidg_report __user *b
 >  	ptr = f_hidg_search_for_report(hidg, report_id);
 
 >  	if (ptr) {
 > -		/* Report already exists in list - update it */
 > -		if (copy_from_user(&ptr->report_data, buffer,
 > -				sizeof(struct usb_hidg_report))) {
 > -			spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
 > -			ERROR(cdev, "copy_from_user error\n");
 > -			kfree(entry);
 > -			return -EINVAL;
 > -		}
 > +		/* Report already exists; data was copied before taking the lock. */
 > +		memcpy(&ptr->report_data, &entry->report_data,
 > +		       sizeof(struct usb_hidg_report));
 >  		kfree(entry);
 >  	} else {
 >  		/* Report does not exist in list - add it */
 > -- 

 > 2.25.1


-- 
Bye, Peter Korsgaard
