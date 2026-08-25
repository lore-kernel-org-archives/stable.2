Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C01447ACC6
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668191; cv=none; b=QV6N4LtbuPXGi4T8W2OFiEBf7NV2lxPoTW+GCWuV/OhVLwpk8bhpmbgw/lSxEB+sw8M3o/okZrzxO9llph6imauYjAsmZ7NtQAg9k6xwVOwtru0V4iVcpi6934hqilI2Shlu/5mHw3tB2kTiPAiqFNMTo78z2yWRACVrBPlL8Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668191; c=relaxed/simple;
	bh=fP7ZVgo77mek34H/l/6QdsjYQ6XTfRYxEZcesK31tCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HciF6LNeD6dDaBzgnslA+mjreQVb7wNqBSnI4tqomVBMfS2W0q3KKwJP6Ki6JhF8G3EcogKAEcs57AaFGZGpT3iUBB/bzIhm8UYzSvwRQYYsBVcJjGH7X+Cfnv9sLHLOWXlNShg8ZCmeDRo+s9xeHp5JImQnBqkWXE1iq5lrqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M50q8YPA; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M50q8YPA"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7ec58fa3e01so3613396a34.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787668188; x=1788272988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n3AWeXIUE0hbARghyBBXHPbPROSf2bjB7jztp6AV4jQ=;
        b=M50q8YPAvwd9gxWyrVqC7MCgQTaefzyFIW5RROnZO5N1ojETYBv37YmW0NlHRxaY6+
         k7u/L89be7/2I9yfCcINfhLCwMGcc9EguifVwDJgALwFqD82W5533Zx16d/l0QwDNDTx
         0oCfpOdUnNCf2e2aOuLdMxHoUEIYmkTUysElZ+JT3C68dglNgiPX+bxyAi8T1q9AYtbj
         +tzDtvKHPFyOg4wH8W9I/rZBn4mv2q2jxB3ohcZlLB5GYdpqhT3vE9jefWsdhGG6Z7Gv
         Fk6CM2WziCYMZqhRDc74tdFenZfNJDsVO+AM4BIoQTbr1bpcC84ygd0YI38kbMLiAxyO
         eLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787668188; x=1788272988;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n3AWeXIUE0hbARghyBBXHPbPROSf2bjB7jztp6AV4jQ=;
        b=HNSgb+FNTu5X+vJKlSdIx2Z/B7zoXhuWJb/8d59EeFnJ/W2JpiLMDd6q7AtVDrlp0C
         LsVHh0HiesOoZm8QyKM1TFE3l1l04fw4u/W4XXqcXeO5TYGNVObvmaFV6BM9s9/Etc0S
         lCXmQRrmoQvRzP0SBFhPnXl/VqtF8MkyQmBvI99pV5tjP+9xbD4zBSud+EB1/fMA8XJ5
         Om0+dquSdiucBYYIh4zG894bh64xtY0LUuovx6JyojqgGHSlBWg1kYpcouqvBS5e12Vh
         0XTFLvutqqQ8aamrbPWta7TV8e5Y/dtODNTuiqTVeYocpFo4JkSFA302jI8pDiu/hbO5
         QKyQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro5fynbMiJidaDBvu0ewjXPtHgP/nRcXNFW2q7Fdf//s85g6Ez3VGpS7Q9TdGFmOMImhKlMf4Y=@vger.kernel.org
X-Gm-Message-State: AFuF++kNFlMky1sMs8ABrNrPpR8Dy9yM+ANg1QSA0XSPS/RmkHKX/17U
	comIFP70lAFI6DG7WgBBemq8wafOs2ucwbUu4KAwIuQwW42mh+LqiEGK
X-Gm-Gg: AR+sD11JPgrPkqjx+uwpna/ZuFQRIWidU03p9QJjWh8+9CcNWS085Fv/q2HOgjajJsv
	s3QchhVz2lq/5xKJvCMPj4xqYuyBvmlBJIVobHfXbbK3Xc+mO6P1FdGqCl+OvZm62GZXmgQ9ZJO
	WVvuY6FJzWfgFTKpYw6NEo82cj1aiKeJ0keCk6Mz8j5JFvgpowRvnY5HkSXoqytRt6e/STQ/9Ga
	0N7JlyArneCUE8fXIasrhbuqPKglTKpTB6IHLTgfF+ht7sV81rOn7Tx4W8hbHXoE688eWUCbdET
	URkxZ7SVXTpflO1Q+PMRQlOvjlBmFrSsq7GT37cZD29EaWTq5cwEJJ5AjNCtzzUwvjp+7hBYg5J
	Y9Q0XL9hD7Eu5JtxE7TXJ8lgx/nJ/WyIUHpOn7+Hm8x7+Lk8FL2WbGVUaS3wynjypwtfKJcK5NZ
	ub9QrHNm8YL3qTWc5zJS1TfEHI2ncoaDzBwTWlTMvp+1IGkLqgl/cWMOHTfzoaukxyd/Sl+vJo1
	ZNN3iQ3DzAJnv+ZH66uN/5sejQ5hN1BPj0SKVoWscvB
X-Received: by 2002:a4a:ec46:0:b0:6b1:63f4:daef with SMTP id 006d021491bc7-6b1905225f2mr5942939eaf.30.1787668187777;
        Tue, 25 Aug 2026 07:29:47 -0700 (PDT)
Received: from localhost ([2409:40c4:13d:8046:4d30:e4cc:47a7:83a3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f909c6c9sm43089493eec.6.2026.08.25.07.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 07:29:47 -0700 (PDT)
Date: Tue, 25 Aug 2026 19:59:43 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: jjy600901@snu.ac.kr, brauner@kernel.org, eulgyukim@snu.ac.kr, 
	gregkh@linuxfoundation.org, jack@suse.cz, kees@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, mjguzik@gmail.com, viro@zeniv.linux.org.uk, 
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: gadget: fix NULL pointer dereference in
 gadget_dev_ioctl()
Message-ID: <ao2mZdrHdkRTypkU@eggarch>
References: <20260824113510.1141236-1-jjy600901@snu.ac.kr>
 <20260825105801.319997-1-lovekeshsolanki00@gmail.com>
 <903f6c28-57f1-4aa2-a111-910fcfbee52b@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <903f6c28-57f1-4aa2-a111-910fcfbee52b@rowland.harvard.edu>

Thanks for the review,

On Tue, Aug 25, 2026 at 09:14:37AM -0400, Alan Stern wrote:
> Why does it matter that you read dev->gadget before the state check 
> rather than after?  If it doesn't matter, there's no reason to mention 
> it in the patch description.
The order of reading it doesn't matter. The important part is to read it
while holding the lock, perhaps the wording is unclear, I'll reword it
in v2.

> Also, why does it matter that gadgetfs_bind() writes dev->gadget without 
> holding the lock?  Again, the description shouldn't mention things that 
> don't matter.
Because ioctl can get a stale dev->gadget before dev->lock, while
dev->state is checked after acquiring the lock, which is the cause.
Is the reference to gadgetfs_bind() unncessary? Or this part of the
explanation is irrelvant?

> Why did you add this test for gadget being non-NULL?  Is there any way 
> it could possibly be NULL at this point?
It seems it doesn't matter since if read is correct it can't be NULL, it
was an initial attempt to fix but its unnecessary now, I'll remove that
as well.

Regards,
Lovekesh
