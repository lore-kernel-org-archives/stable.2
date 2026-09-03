Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB14202C48
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788393682; cv=none; b=jKj5kP9JMnKOnUqNgjv34Fy3QhmcZlybfl9uk9Efl5WkOwlaAqcfQ9TC7/xogsYDM/OnvKHPKPewH1n++OV6Hnx4VDKF4tT4x1rtiJbG452r7qDk0rSvDwZBZ6Z9gD7WG5FjypwE3WuPcurXbDVDlWhwXDzJ/oZ+0FrA+nuLHvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788393682; c=relaxed/simple;
	bh=/ug1Z2+I/7/9KkF0qxyodAnWWFqdK3oh857MdPbdGF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/tB25Gm38Uwo1g28r4T6c2wYyTmEJHvtfuC7MqG6+bennLWva4++D56F02LQThRG01/sWi4YpLTvMhjnS4lW7G+UTbxMZt9SfEJGYFaInc81fJfDHVdi8PneZB+0E4gvg5MIGoRqRPVam8UWd7GD6Ua/BzghZDTOthu0E+0KAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExG1IEvw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExG1IEvw"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49b0eab380eso4554895e9.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 17:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788393679; x=1788998479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a+rMgzxIZCYE3X97ZXCU5Wap0gn6wnGpiJQ6Mt5cqyg=;
        b=ExG1IEvwz1/NfGx0A1DKm3xiibNAncJBxjV/szzEurRpLpl0MQeMmFhIevRU7snQL+
         qU3r/R+rxHv1oBa1YH2vYoCA+LnJPI8S1cqy83uxLkDeb9ui1gWeUOE776A3KxuvGO3a
         UWeq2CjgXISye9Ock6U0DBHbRjVlliBFWGgzXAt11MxhCu3jCIDdok2Qe4I6md31LqSi
         qPgAYhWZ+pbZ+G2k6macTL2PIxpYHx135ljzgerT00yspZK4r+PZ+2f8+1gRKz+CSKK+
         qGX/9tpkoSWCwCeRmMQl9YTKywJyBTRZ8ovm/klnQ7qEtW6Mh+LKN2UCBFEQUI8vKoSd
         hiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788393679; x=1788998479;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a+rMgzxIZCYE3X97ZXCU5Wap0gn6wnGpiJQ6Mt5cqyg=;
        b=cpXFpl6ygJpaPFSmtTuMLUatnGlgKkMvG87WLRNrVcVNKBVBW+2qb8cxhloSvix6ya
         D7r/Mo8i4GIvW19yVF1j9XOoKyx5JCWAwzoX0H9oh9iQDzF/XR5w7MheM4VkG6X/BBIV
         hX5nYty3ZQg7zWXYfNu1ukYh0OpQWktg5bxMcLPowcmIQCZ5qCE+7z9sGdt8mGqM9gC/
         MaBveWSgdBfaxVQcf9p5K3Xx9veQDzRvgs/IVxUnmJAsbXYzJN7nEt9azzV2C4v9kKgB
         XXIDHPQQCJtk7vVsZ7O5Nma0JUkWFkuYDwUvDhdMXDBia59dcPORpaoeYBkNqkhsnjCW
         Od7A==
X-Forwarded-Encrypted: i=1; AKwUvBwZqT7fevHMi6AGiUC3urr5MMHglEOyaBW0BZOKr/Zqh9RyYl3RORoaCmvBdD17DA3YY9xzzqs=@vger.kernel.org
X-Gm-Message-State: AFuF++npSE3xprv+VwjguvRDyI1TIr2S0N8tkZ32ukUkqmvjDbKImH1e
	BqnA/tAUnJKnY6HXmGk12L60VhAl7m7BIrzw3BN+5TdUdJWlvc++Yk8y
X-Gm-Gg: AYBFou3MffnfMC8NrWy+Vg9Bm118zGGvYKms8scNDfELX/F3jBQRaQZgjqtcgPDkzgc
	3kXAm4vvWBgtBEGg/gsUmYpJGH+zyUfW5Bz7I/PQDCxvYSItPhrmCnALZm0RFl56ulMh3v0q1dP
	uGsMsbvuEoOK60Bk1d58qDXyVy0rmsHdlx/z7sJ9ozvJXRn/5Q2BHF8VvnzEJJbWYyu8J2Fd8pr
	n/g4Ru+il16bWOd0GdiRowIbwfetlBW8WCqTM5rfK7wbqmcxqVfUXF+PF2lbpWO9rxbz9nGOxAH
	+NUBJhR1wUTlU9vkNe2nU1U6IBi4bvhQwhNdA1IpLnJly5ic5d/Q84E/GLP7hEf+IVEL/HpO3hQ
	STzcLbtbD1tF4fr2T8g/cwsyyIwWXKjtfcY0jYtIF0LmXdQvT0E9jhBp1zIB9vetJkiD2MmIEJR
	U9pA9PnlhoULNxoNRGYD1oM8w9Evll2KpN15TRWdzMtg+4twTMz7Bh/Yv6eQciCDJKj3xrV84VQ
	CiWUUJo5SCFlfBMts96IOhqIEKYUWSU7MfOWJg90vMVduk/vHBkK2Oz/kx/1DxosAdAb2ZKLvNQ
	tOasigqiIp1SGgmS6IvCZ0wIF4+PK1349VUOxC707+ANfLfQmO1dfnKoRDLUnA73+mqvJhyoyMe
	nK2EY
X-Received: by 2002:a05:600c:ac8:b0:49c:f13d:ffef with SMTP id 5b1f17b1804b1-49cf13e05ffmr2151795e9.19.1788393679115;
        Wed, 02 Sep 2026 17:01:19 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a1c2-c401-11b2-c123-0d12-6c0f.310.pool.telefonica.de. [2a02:3100:a1c2:c401:11b2:c123:d12:6c0f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492ce5e5sm9115290f8f.36.2026.09.02.17.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 17:01:18 -0700 (PDT)
Date: Thu, 3 Sep 2026 02:01:16 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mukul Sikka <mukul.sikka@broadcom.com>, Keerthana K <keerthana.kalyanasundaram@broadcom.com>, 
	Stefano Brivio <sbrivio@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, Bin Lan <lanbincn@139.com>, XiaoHua Wang <561399680@139.com>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y 6.6.y] netfilter: nft_set_pipapo: restore cloned
 mapping table memcg accounting
Message-ID: <api29LfuC8U_RRUw@gmail.com>
References: <20260831194905.45045-1-kmehltretter@gmail.com>
 <20260902-daily-reply-0014-pipapo-fixes-tag-ack@kernel.org>
 <apitu8BYUvG-WJt2@chamomile>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apitu8BYUvG-WJt2@chamomile>

On Thu, Sep 03, 2026 at 01:14:03AM +0100, Pablo Neira Ayuso wrote:
> On Wed, Sep 02, 2026 at 06:14:13PM -0400, Sasha Levin wrote:
> > 
> > Whatever Pablo prefers :)
> 
> I am fine either way. I just got confused with the double Fixes: tag
> that point to the -stable tree commit hash (if I understood correctly
> after Karl's explaination).

Thanks, I'll leave this submission as is.

If there's a similar fix in the future, I will probably split it to make it
more clear.

Karl
