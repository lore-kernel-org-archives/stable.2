Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D915B3D88E0
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663684; cv=none; b=d7gV2KWq95UirHnDdXbYQ5STcJYEhdFZKcB7+PoHcMg3TPDvESFu/0x2jIzXDyeOTHj9e6Xsn+Y4OIgxcMLYZ+3wT7oY17RyQ6yi0pxTCUwwM8dB6krXP0N2x/QvzVkQ+TtiB6vfi6+O7njrn8WPlf0gPsrvEWcCngNRtuwSYbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663684; c=relaxed/simple;
	bh=JF/CVG73KqfEPG77YYQV6D4E8ClQUIo15GkRtnfr+Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQ+gm+qVHmPF8s8hP5pTFanveCNt6rjyOpYoxCpG01eoj+qj3HcIWXpf3f1k0A58DCXEYI9xTwtEOZpiDGjX7L+S49cKKxT/l+/LI3Z7LFWLaaasHtKIyc/ZtbxVm0h261pRVD4n2ZrRUhYFsZJzjsE5556+zwiDjUQ1bGrw3Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=UIudQWWA; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="UIudQWWA"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-52d590ce5cdso32997921cf.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 06:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1787663681; x=1788268481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l854SOS3CVE+wanQ1v81miZng0iI4m/OyUmhCjNS8bM=;
        b=UIudQWWAnSxJfjscs2jwfXiy+zL6bsSMh2j4czdfHsjkrTpti8NmLTnTBMzVKuHjrE
         7wqImZ1SRZrs1C/xmdWHRgw/5MAIl4Mp3y7VmVFcG6MWFxyDQQGizHN0zO094pR9dCdO
         +9Bpd8XQ0zVg5A+Gi/GfSC6qzYdZ+Soss+dFwikAK22zUmzOTk9MGhFLISl8+3HEuxfS
         wiAQa73gwteWNxQVam/+8uxX2JMVybfTNgX4f3XGKksP+M29NWXCtvZGLOaLa1QPgDHb
         xmjaOywDIOavt00nxmEa9e0Q6H/dFR3V+lGhdkQTfohHo8SGTs6lzhH6RX3SQqZN8rJJ
         PErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787663681; x=1788268481;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l854SOS3CVE+wanQ1v81miZng0iI4m/OyUmhCjNS8bM=;
        b=p5fboKBSoY0sqj6I5GiREsh4LJh00alsJ8rbmbEIUm14E1SoQOKI1d6Wtt/GAHMIzs
         hLhitAxrXLSfQXL98OMIQxyE2PVRkkF+QCZ2DvDTsHPf0olC2MQZG6jWK4KKubBSRPq7
         pd3AbRCvfan2N8j+8o1yDeN/gIy5/O+qNGS9hKdtcAQ67WOPdi3Td0rVHryFXhI3srNv
         uk006XHemZ+uMz97AyjBnJMBuJBHKhfnKA251Kn1REsCnj5Jv2oK/VAjnAfaQY8wmgdr
         f36ykHBQt8WFp0lmfthqhvC4JauB6as+CmKuguZYfsvfH+kaQF8SeAHDZyRzYKcfsLXK
         6U4g==
X-Forwarded-Encrypted: i=1; AHgh+Rpi4lLRGMrmBI4uvwhq8vss5+DZugCvd3Rm4PNskyVCPQTBHJmzpR7laelyc9gUty6XqcR2vhQ=@vger.kernel.org
X-Gm-Message-State: AFuF++niChr9/hW1RBoV1Oy55Zs/bYqtLYlcG97XhJ3ywFKsawpBF3v7
	w23RvANF0jvqCLu6nthTD+g6GQfurix485T/nXG5pMFsVLy5BHjkcA7P115NgCe2zg==
X-Gm-Gg: AR+sD11bWZFxK3jW92u9btixf4+BDeJw6bsEzu+72n99cx4Ylnl0T2H1Qnt59TgYBK1
	n7gYHNqWWK42slJHMhKOzzkiW2IYahQYZG85MSUCk5hdb8mKZ5BwnZBYiP9NUaA47whzVZEtwH0
	PSkHCFWdny1sz/igPDubQKw4uPsV8o8dxO4CKqQctm+xJ7YEHRizbYm6fmwmlObzI0RH3zB3PcV
	jPFIJZ3GtohamdN5vieUNw0SIg4R23uMYQXbNJluOs8IMrEEUuM2b6t15vYX5hcOXMKRVz7iar2
	Xi8bhX6DLjcASM4VoeVNc4DxXSB6Lol7cLb7Kz28G7YaaGDXx8/1l817IOKE98u7MvbMx4F3GX/
	q3EWLe7YHKb5bFZdoG4POTJXd0eJDiI6CtBk9bK0U5+PHbeNl3TrWUdMMM/40Rdj2Fpvoe4QG5A
	Si5lw/zLj7uPbp6Xzd60n98y2/tblbKD6SGzw2yhtmPnkMrMct657U0Ru1A+dnGg==
X-Received: by 2002:ac8:7d13:0:b0:52d:3d46:bfd0 with SMTP id d75a77b69052e-52df5a4a41emr335195481cf.32.1787663680764;
        Tue, 25 Aug 2026 06:14:40 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::dfd8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e099ad287sm67854031cf.10.2026.08.25.06.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 06:14:40 -0700 (PDT)
Date: Tue, 25 Aug 2026 09:14:37 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: jjy600901@snu.ac.kr, brauner@kernel.org, eulgyukim@snu.ac.kr,
	gregkh@linuxfoundation.org, jack@suse.cz, kees@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mjguzik@gmail.com, viro@zeniv.linux.org.uk, stable@vger.kernel.org
Subject: Re: [PATCH] USB: gadget: fix NULL pointer dereference in
 gadget_dev_ioctl()
Message-ID: <903f6c28-57f1-4aa2-a111-910fcfbee52b@rowland.harvard.edu>
References: <20260824113510.1141236-1-jjy600901@snu.ac.kr>
 <20260825105801.319997-1-lovekeshsolanki00@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825105801.319997-1-lovekeshsolanki00@gmail.com>

On Tue, Aug 25, 2026 at 04:28:01PM +0530, Lovekesh Solanki wrote:
> gadget_dev_ioctl() reads dev->gadget outside the dev->lock, while
> gadgetfs_bind() writes it without holding the lock. A concurrent
> bind can update dev->gadget and dev->state under the lock while the
> ioctl thread holds a stale NULL copy, causing a NULL pointer
> dereference at offset 0x28 (gadget->ops->ioctl).
> 
> Read dev->gadget inside the locked region, before the state check,
> so the state and gadget pointer are always consistent.

Why does it matter that you read dev->gadget before the state check 
rather than after?  If it doesn't matter, there's no reason to mention 
it in the patch description.

Also, why does it matter that gadgetfs_bind() writes dev->gadget without 
holding the lock?  Again, the description shouldn't mention things that 
don't matter.

> Cc: stable@vger.kernel.org
> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> Link: https://lore.kernel.org/all/20260824160022.2378192-1-jjy600901@snu.ac.kr/
> Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
> Link: https://lore.kernel.org/all/20260824160022.2378192-1-jjy600901@snu.ac.kr/
> Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
> ---
>  drivers/usb/gadget/legacy/inode.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
> index d87a8ab51510..e9f7d7c1a6a3 100644
> --- a/drivers/usb/gadget/legacy/inode.c
> +++ b/drivers/usb/gadget/legacy/inode.c
> @@ -1251,14 +1251,15 @@ ep0_poll (struct file *fd, poll_table *wait)
>  static long gadget_dev_ioctl (struct file *fd, unsigned code, unsigned long value)
>  {
>  	struct dev_data		*dev = fd->private_data;
> -	struct usb_gadget	*gadget = dev->gadget;
> +	struct usb_gadget	*gadget;
>  	long ret = -ENOTTY;
>  
>  	spin_lock_irq(&dev->lock);
> +	gadget = dev->gadget;
>  	if (dev->state == STATE_DEV_OPENED ||
>  			dev->state == STATE_DEV_UNBOUND) {
>  		/* Not bound to a UDC */
> -	} else if (gadget->ops->ioctl) {
> +	} else if (gadget && gadget->ops->ioctl) {

Why did you add this test for gadget being non-NULL?  Is there any way 
it could possibly be NULL at this point?

Alan Stern

>  		++dev->udc_usage;
>  		spin_unlock_irq(&dev->lock);
>  
> -- 
> 2.55.0
