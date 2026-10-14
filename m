Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8B501F37
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982415; cv=none; b=jZV1RrkDL1rHVfiG7tAfM+5g1xbDwdDs3PXLALozVpmZOEWNl/TlvkS8M5o+0qxJ7llBouG49EhZ9LVse9yvLy70IxoDpEyKVJSxIoMiIiEMzmhiY2+1zH1SjSkqMsg9epFkQxOu348JPoucN4Myz6DbxLqvdWC9MqA4NAA/j9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982415; c=relaxed/simple;
	bh=JHVx4PXMqJYlp8lW2UAdemmaCWI7bWUZI1+Vxrjerj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivYcoPjUWIB7wSIFVzBT4ZNcnCrMKBooi3M6AYLEHuMtj9DdeACAcledlp71JxPTIYb1gVvC5NWOgI6e5eKsfGsXYmWvuWhmVVU0G4Ll3ti0MHkDb0Ble4dVpC6socruaqezB+rgJyYXxyTmg+u5bnveu1doT+WT/Jejn5maURg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRcyrkL1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRcyrkL1"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a02667ccebso29638775e9.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 05:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791982317; x=1792587117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h2lXGRufG/CkzlVDEuwvfDVQ2gYthCpgB+y1GvWyU9A=;
        b=sRcyrkL1QvMCxpmrkoJxmjZrfWjWnmwTp/swz4YF5AxP1FZmlxobb1aVwq2ipFaAAe
         kVbje50RcdNSBXfUzbLDdtMaadvFz/G7KjFSZIOH3jkJR7VLX2aieA56FdJm2yQwGMhF
         5sl04lHWb4Nsh0LTHBmfjklx3grdRew1CVwv8RcsSs9ySYiDzBShO7j+FgMKAPXw6IbD
         oYSXHKv+KNAGpuszTYmtKIID7xdeZ/m6jNhLr5iiSuTU0h6Lc9yes7YgN3cYDMuwZ8xE
         6Q2+O5AER1C+S7NHEADtk5dCySAf1NWqPFsAPCCVQ0g/NjJkd/BvghIEmH92JOHhwHAZ
         +Y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982317; x=1792587117;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h2lXGRufG/CkzlVDEuwvfDVQ2gYthCpgB+y1GvWyU9A=;
        b=yUv1nhqvouV8dvv0Yibo85a5mGa8RPCehypqooRWaW9djvX0FhN0X6u9VbWxn58SsU
         ZLJFnfmSttoR2frREdG+pJM/rluwcZohS13o9Fn0nK5bwA1MsdKooBh1QziwPrUlZAMD
         OJ4tQ2Hkkn4WEvbwE4AfbGK+I0JDPSnWNf7oP3+Ib1B6qmN5KYWhQyoD9XJjQvQetOAu
         TVXC/5qbje7h2R2AUmvhWWiinFgB8VzGC1xN1mPmroPqjkDuxt7sbvv3EJTjiI4alDsb
         VDt0z7Iwrs+GHk/hdJHuAxaSyIidRkdKTeCEv7PJ3Ga+YsaNAyTe9g317V/0XSwdjbYw
         Npgw==
X-Forwarded-Encrypted: i=1; AKwUvBz+9RIp2ua7PKPgEw/FkGIVkkN6v8VpEjwleXQL7+uxkPgxll4uUP9E+rheF8n+K/rq+xMkFSs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJaJyYWBETu1EvNGU/sutwDuOP7aDKFXiKH+hB9CoaczDtVhlI
	eD7YAEg5mmX9jt3EIu3Vov+AdPQWZ6myaAYb3h/U2pfHY4OZjDu3s6BF
X-Gm-Gg: AYBFou0pa4hcmeiY834uIr2QPcYLjHVxEwS/gdrVY1y9k36UKECkCfyHuTiy7FH5zL0
	qOvwmzZpOaZR8FXpV1mVjSDR/UZMTHn8FWuiK2+keGPplN8PI+XShPzMoxC+aTg8KUtiam075dm
	hJEiEd5inqhzaDb+js13vTE41dKRHV98d5YI7VtwLxbuqXv554Itu55AZq1idbYVIw60dmg5/nE
	D8SR+oAxYua7Lc6yNtYmmf1J804WDCtxg43UsOdIYGI9sKEPYjThXu498lwVB/LHwkDEqxypgPw
	YlhlRU65I1zNuK2k8t8o5gvm89iSz/DxXGiCs6SuN4gbZH1ZgqEq6sNpWeWCNbLMqpQIrqghZ+t
	lMdwg5cSzx6P10xsEj798V5BWDVoFLG+6Lb/EaIfeKNUwlHCWRQpuvlpsTVuuckX4rA74S5+7Hs
	MiUdSEljAK2JcxacI+hFYxV9ioGVjJcpzz4vXAtoR3x8Ugp5ZTQGng1KqdqoBvZAXIqZnx5G2iJ
	y5qDL8NjT+W94ARkZJ8+YkqObedPC/ZxuY=
X-Received: by 2002:a05:600c:3e16:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4a1992fd259mr236072475e9.16.1791982316612;
        Wed, 14 Oct 2026 05:51:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf35930sm435944885e9.13.2026.10.14.05.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:51:56 -0700 (PDT)
Date: Wed, 14 Oct 2026 13:51:54 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
 <anna@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Mina Almasry <almasrymina@google.com>, Kaiyuan Zhang
 <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: skbuff: make skb_copy_and_csum_bits()
 report unreadable frags
Message-ID: <20261014135154.05de968e@pumpkin>
In-Reply-To: <20261013-b4-skb-segment-nosg-unreadable-v2-1-6c28d8ffa51e@toxicpanda.com>
References: <20261013-b4-skb-segment-nosg-unreadable-v2-1-6c28d8ffa51e@toxicpanda.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 18:02:44 +0000
Josef Bacik <josef@toxicpanda.com> wrote:

> Subject: [PATCH net v2] net: skbuff: make skb_copy_and_csum_bits() report  unreadable frags
> Date: Tue, 13 Oct 2026 18:02:44 +0000
> 
> skb_copy_and_csum_bits() has no way to fail.  When it reaches
> unreadable frags it zero-fills the rest of the buffer and returns 0,
> and since commit ab9414ed70bd ("net: skbuff: don't leave stale bytes in
> skb_copy_and_csum_bits()") that 0 is the correct checksum for what's in
> the buffer.  Its callers can't tell the copy didn't happen.

Can't you use that fact that the csum function should only return
either 0 or ~0 and use the other value to indicate an error.

ISTR this coming up before with the 'copy_to/from_user_and_csum' code.

David
