Received: from mail-wr2-f43.google.com (mail-wr2-f43.google.com [74.125.225.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94F4134CF
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618121; cv=none; b=Ww4fQHCxs53gJ1u+n4DQ9JolcDmi8LcquxY/sLwaaLLCYRa1/00x/qZzkE/ijvrAj3bCqFtOrme1L1PvYYGuaijHkNaAk8Ov7lvocO5M/r8LUaBopRb9wa0AAV1tAW6Fd9nBYBVspU+jkLLdkSrMGoUzshIycVPpEK939Vepsxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618121; c=relaxed/simple;
	bh=HwauYC9D4u3O794NhMrtXulcF3FuA+UuKQ+QwgJBzfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLr/85T4dP2yQtfALUpR7ROq/p/SKQiUQHDJ4uB7Iy1lcucRqYB/Xiutkhu+OwyVSnWQg6tOXUuOaQrmkLS58ulKYQuYztCRuwhsL605o2m/z/tVf5KFzgUvzhTQqTYfULMxjqVJj7xmCAqsyFBtaRMTAYrwlx61OFMFcmAAG7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNmegTIp; arc=none smtp.client-ip=74.125.225.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNmegTIp"
Received: by mail-wr2-f43.google.com with SMTP id ffacd0b85a97d-482f62ccdb1so109602f8f.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 21:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789618117; x=1790222917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=upbDFswdev9zDbHI+yVPYldzxiCqjAm18ndZfHkWv3s=;
        b=gNmegTIpFTSh7Wns6T0Rz9v3XOZ1LBlZI8dvpV2jFm0NdFJu5kn2xq881SpzyIDWn/
         zXCeiWQJ0o1ipFLySF+a/pB4LgAL4RRg0kJ1UtrdlZTmwZnGaG+w3jKPtXQwNc2YmNuT
         NShjMweLUeIK1Jl/yscGZrOkvLyq6qBoSz/BgXnWTFUQ3vV+OH1+eyINBZT/j6x+yWZ3
         nyO0sosmgJb3c769LdGv21EPDURlvIZjLFjOnZa6TouIxolRjdBTscH8cYURxSErYzpo
         wuKZAM7LcGNjGJ8Q93ccRvDUZkWcZzoEC+K0xqjfYiNChflVyr9B9SqgrwWHrqqVXpEa
         5+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789618117; x=1790222917;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=upbDFswdev9zDbHI+yVPYldzxiCqjAm18ndZfHkWv3s=;
        b=gHE0oisIC8H/SdG0KBPZoL9sgqvob20711r9ndn+899eco+ryhRThBccuE6JHs5F4p
         3dbwOwTK3mSLv6nwGRJJyskfCcp98VZSBRocF58kCfBSuXHjr1dfGGtZZt99zKSfi7GV
         owg2avBedrfHDj5K4tE/6bRgB80A/rSmV9wx+Dvbn+x23MS16dqBf3Ny4JOK/YvuAkoN
         JngdcB54egKdsHJbeE9igRQdpJ98JdFuUeYwt7WkKbiHLbsI4wgmN0wyuVZgalYsmH11
         TjXpqPdY4GEwitmSCI9oKOBgleB99nOIgw4RT3f6aqUFvnnwjxZTXQOgwHfpi92jLdwT
         fjWA==
X-Gm-Message-State: AFuF++khoX6TGmmiYdFqVQATS7wI4L97fRKE91z3+yxXJSj0GCNxHhZn
	V1Xy3LAGLWUGmJ7WzTpibNibhW1dtxgH/tyGPuqTPLVFYSSd60ZYWpbr
X-Gm-Gg: AYBFou2eGXaR5hm6WEDJg5oX97gyCFWLUsVX1RHyqk+mR9iw11+iXs+h5B8233by+Sa
	IartUgEgOxa7gjPPkRGjvUtD54lfor6dBfG1n8oIMn0HUgB4b1rPuPgh/oQw9TJkJJ3LIF9OiTT
	0Bd3Wvrqbxs6Lye6mJ12OZisg1iHu8THUxtbA1Rkeq3oQFWWLGEK5LGt/NhBhigF/q4tU8GjuGh
	MPMJaAf9eYp+fWaFxcOOaHH4BY7aMr7mHP09u8RPn+7b9KxgnOTqVtNfSiiOIIgtZOt29oAnBLw
	PEP6MBwTXD7qZ2061/zSY1PvqUBIIJbpHNbFZMB21IRsIBvJCtP54zy6uGCDHfAimpSdHOUlfDK
	E7CAf6dO0JC56xgZRhPUZpNgtwkY4jNgCqWWKmCBmSbYpZykFWShwhAERrusFsY2mKikjM1vlLh
	bkzqtV4mSv/C7PdIL2fdIF9+DYl4RCQ48F3Xk038sWN4mGnbuwsMISOiLTIOOg3bRYVC9Gaa+x0
	ePooA2ahbhwhxoQnO7SJ/ToEhPke9ZBuTk2Nb1nMmsWC3S9osqZmWFAO/PrSlZA8okFDA84RVn/
	9vnYDL2eQoRe7I1q+LVdyK9HRLh/e09jPyBEHVflkxIinxJ2Q/pdYtiEdLxb47H7/JuoiVJ8tw=
	=
X-Received: by 2002:a05:600c:a11:b0:49e:63cc:6324 with SMTP id 5b1f17b1804b1-49fbd1c2448mr21678245e9.6.1789618117494;
        Wed, 16 Sep 2026 21:08:37 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-9dc6-c001-54ee-4741-4927-0a28.310.pool.telefonica.de. [2a02:3100:9dc6:c001:54ee:4741:4927:a28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23ac75sm39976185e9.13.2026.09.16.21.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 21:08:37 -0700 (PDT)
Date: Thu, 17 Sep 2026 06:08:35 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Edward Adam Davis <eadavis@qq.com>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.15 879/935] bluetooth/l2cap: sync sock recv cb and
 release
Message-ID: <aqtnK6b1rvxwJjSU@gmail.com>
References: <aqoaFdvSsDiiLb5I@gmail.com>
 <daily-reply-20260916-0024-re-l2cap-5-10-revert-hold@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daily-reply-20260916-0024-re-l2cap-5-10-revert-hold@kernel.org>

On Wed, Sep 16, 2026 at 03:28:14PM +0100, Sasha Levin wrote:
> 
> Thank you for running that down. I am holding the queued 5.10 revert of
> 89e856e124f9 ("bluetooth/l2cap: sync sock recv cb and release") out of the
> next release until your series arrives, since shipping it alone reopens the
> NULL deref you reproduced.
> 
> I also withdraw my objection that f1a8f402f13f ("Bluetooth: L2CAP: Fix
> deadlock") is unlandable on these trees. You are right that the fix is the
> l2cap_core.c and l2cap_sock.c hunks and that the hci_sync and hci_core hunks
> are an unrelated hci_dev_cmd() refactor.
> 

Both are now posted.

5.10.y, one patch:
https://lore.kernel.org/stable/20260916193454.9996-1-kmehltretter@gmail.com/

5.15.y, two patches:
https://lore.kernel.org/stable/20260917040004.21041-1-kmehltretter@gmail.com/

5.10.y needs only the one patch because it already has 89e856e124f9, so both
L2CAP hunks of f1a8f402f13f apply there unchanged. 5.15.y never received
89e856e124f9, so it needs the conless lock first and the guard second.

Thanks,
Karl
