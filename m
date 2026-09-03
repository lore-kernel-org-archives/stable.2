Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11493E1D08
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427694; cv=none; b=apuFkh3nvQOB8qiu8O/gBUd9mFAQi4qrdK4kh+9VewfNFq9vkVKy9554MjiEzfBGqS6aBlRr/N348HmpSIDz3+lK09UWjVHdyNJVmXRtb0B1NBwDe5WYhghBo2gy0hMLLSUqjEejkoKZ5eQYYNhd6hA1vTMgaAakwYne1Qu2ms4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427694; c=relaxed/simple;
	bh=UOh/LtjcVEdsNgVn0w9DqbI/vqHusHIjkULr7LDYLQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9pi18sJr8msf/9maE4Ct6UOGNXV51lLK4ZMblw+rEPAgfRg12Ann0zszieqfuMLd7OfUUoJjpf/VDRmlHRR2wxC5YHiSwzDQjjhMVp4EYhONC6cRsgHCTQpBt+0odA11yOQL/BT9mp7VubJ/L7QgbqM2VgD+XfWUzi82+Fj+Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yhry8Af4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rdyu1E32; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yhry8Af4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rdyu1E32"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788427691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=viFDAyDVnv0nXP04SMkhGnyeeMoiH2VhaedyYoQeQx8=;
	b=Yhry8Af48cwBU1qnqx1MB6hRKME8yyaYDhgpY2r/ndz4XPrMzNxK9f/ccuG9UEIBSwIA53
	0X4X4MZBkfHE2uaBtUMUJMO1j62F7xP8LLVZ4OpyrxebsdedrvYgBuDK4D1/5K7NewGSNI
	NytMQmbJfeExXm/zbb9vNXvHwX+2hec=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-OOPdFmNGPwCvRshd1W7X7A-1; Thu, 03 Sep 2026 05:28:10 -0400
X-MC-Unique: OOPdFmNGPwCvRshd1W7X7A-1
X-Mimecast-MFC-AGG-ID: OOPdFmNGPwCvRshd1W7X7A_1788427689
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so12620465e9.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 02:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788427689; x=1789032489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=viFDAyDVnv0nXP04SMkhGnyeeMoiH2VhaedyYoQeQx8=;
        b=Rdyu1E32mfT+YMfwWAnMahZHJUvotf+GAeUF8X4YW/ST7OeB+eabBZVgYWXcLSpKcO
         eR2g+fAtyzZOweibDOQq2dd+juaQuRl4wRXIgzRXRJ4Pka6kXLtLxTqexP8XyPBGpXJJ
         7uLSZdcE9ey5ovkAokNO9y9zFhWuMiH+Y9vwIvadnFVG1XVYsCSDpka7Us99dFHwe/YY
         bvkJcfpi+on5SRySyftCpU1pdc5QYKyNafIjo7DLXz/0c2uLgxTxcdGPJd3IW6A7U8kA
         +4v9J/ZT4C6DEKvwrri3UfIfkr8AiJPVliWN+b/SWeFIRQsIzv/LpZX1G7o5/IJN6R4c
         6oKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427689; x=1789032489;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=viFDAyDVnv0nXP04SMkhGnyeeMoiH2VhaedyYoQeQx8=;
        b=jFtDqyHzhLJVYetDCkj3RV71ljD7WejyuwrYJNwwTU61rY86WVnUCIo2exYjgHUIFE
         /n+5vfvxKQCeKBo3NFTQ4+b8IhwcKXgqzsAqSgFxyTaU/z7wKwGLdgzn9izLByZOZe9a
         RSkWJlbVs51EjAf5ODhvz3VhPzOSQatAhLQ1IsLlPKKwp0oYRJO28K3Mdfa9+OxJdjIL
         8Hf3XBChw2OBsQ93k+qK5bVGDjvQvUkJaCUDVVRfZpUuhfMKX2moO1idsBH/PgKLnwMb
         dhh1DOPAoCgGw7rRKwUkYb0kbRt5bjEsxyeNouSwg43GElmelbbJQZ8CuTKP1gU0724k
         nfvA==
X-Forwarded-Encrypted: i=1; AKwUvBwVsZ7+VgCtcTZ8gsrue5frWTqGiHPeE1EW7ktn3bSB0en3TL06p6AM4sbbB4bGQIsS84gTXEM=@vger.kernel.org
X-Gm-Message-State: AFuF++kOZ+USOeSTtqpwUhcLTGAtysKT3R07vKa1IgskD82Sy1eYJhVK
	R/UUGigezKockFhv14woP47jLPP7a3rKzjZ5+5BXXY/6/SVWMIDlYJ9T40pFA6YU6ax5R0qp3OD
	sazqfbZYq021lrjAoYtOKFulYsMay/OWtLNsAGehNIELCZcPErI1N09zskw==
X-Gm-Gg: AYBFou1sfRddQFx3qoMUf3Q9/9hzZUDLaLCnBKVsh2vjAg9oMhm9C76Da4liCqbKeB5
	iIC5qvMw7L7/o/A/6hrfkRfVsTgCHvKedyDUPno/98KX/TGzHrSFuwC8k3eh+KO7fLajq/BFfWb
	mS0Ei5/6MVKzeMddkFmXgUsTp5HZl8QYBdaqYKp/bioLKvevuD0l/6+/fFqtE/eoRy76XYts/wE
	HGD8KAMA4Je18zXYUmv7/WZlp54sNfRwRBBGMTSWeRN0rbgkvQkhjyCn+KOhONC78Uwat7cqYBO
	A1SFsoyibL3f+7ex5DE2OJvkAZ4w1AqihWcliqQZVpuHPBBpaD1mJbP89Fv9Wi2akCJGmx8GFrJ
	85HY0nxVI1sm09dTO0iSx/if21HJbjmLkKxy7w7z41UQP4GsQ9MYe3g==
X-Received: by 2002:a05:600c:4688:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-49ce5822b73mr185276225e9.14.1788427689198;
        Thu, 03 Sep 2026 02:28:09 -0700 (PDT)
X-Received: by 2002:a05:600c:4688:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-49ce5822b73mr185275505e9.14.1788427688799;
        Thu, 03 Sep 2026 02:28:08 -0700 (PDT)
Received: from debian (2a01cb0580324c00ef50076415969b7f.ipv6.abo.wanadoo.fr. [2a01:cb05:8032:4c00:ef50:764:1596:9b7f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm234561285e9.0.2026.09.03.02.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:28:08 -0700 (PDT)
Date: Thu, 3 Sep 2026 11:28:05 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	horms@kernel.org, aconole@redhat.com, sbrivio@redhat.com,
	laikabcprice@gmail.com, aroslavdudkov622@gmail.com,
	rough.rock3059@datachamp.fr, stable@vger.kernel.org
Subject: Re: [PATCH net] tunnels: Drop stale dst when building an ICMP error
 for PMTUD
Message-ID: <apk9pZv3wu5WtEMU@debian>
References: <20260902190112.4126199-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902190112.4126199-1-idosch@nvidia.com>

On Wed, Sep 02, 2026 at 10:01:12PM +0300, Ido Schimmel wrote:
> Bridged UDP tunnels such as VXLAN and GENEVE build an ICMP error packet
> around an overlay packet if the packet is going to exceed the underlay
> path MTU. The ICMP error packet is then injected back into the Rx path
> with the source and destination addresses swapped, so that it will be
> delivered to the overlay source.
> 
> If the overlay packet was routed to the UDP tunnel or locally generated,
> then it is already carrying a valid dst entry and this entry is not
> dropped when transforming the packet to an ICMP error packet. This
> causes the IP layer to reuse the dst entry, leading to the ICMP error
> packet being dropped or routed out of the UDP tunnel interface in case
> of forwarding.

Good catch, thanks!

Reviewed-by: Guillaume Nault <gnault@redhat.com>

