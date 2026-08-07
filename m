Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB91684BE
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786076576; cv=none; b=IRSotWM13nESnjWkyxNqZJuPngpIV/Txy9vFTpu1k44Npb6zebZHRruO2jC8IY+J0F6eu/Q6CYAKH2prk0DqfFJMuV58OtrSOOMyheCuQkiHhnWIrFpa7l9ESxuG3aRCSNyVj84IJQmZsX+y6RAUayenfmtuOBwJzXASsebVoNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786076576; c=relaxed/simple;
	bh=iFF1Ii4BbRtvgCuTzJ+dT2gNzke1lY9L5cq82zA0A+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlnQHRNV2Dhpv+TG581ofvW/NKLa+g62gn5R2N/MglJ0v5bZwHH37JKgOH92zSx0HUHLJLUgsN+qXe1cV4mGMhuoBxU6LpPqsA2TCGz8tmVCrC2r6rMNn+J/mK+1wZ2Wjy+FsplG8UQdMSK2He2PJR4TlmxuzmS8CapNNaiVa8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiTXdcfG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiTXdcfG"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso1483150f8f.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 21:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786076573; x=1786681373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GwROwkmiHrpoWilT8NKMPgQZsuspf+l7q9+MCcf4wEo=;
        b=HiTXdcfGDz7onJuRKB6A2B2omxntwVrToqPHW4OPyjR3VE1BcA5nDUHnVE1OzJBA+j
         Q5KbcleSjs9YWgMFjVDrlbLA7HJUKmzYYxbwsaIMY/thpI6kOiD/SFwSG35ANcvnSc1c
         rO7Mf+WPQpkDp7OSPTragg0CrO7bhJttHKEPr1pdZy2cdKZeLcTOedIpwkxB8NpepVy0
         YkSDMhrknS+nBvXXYtWtTZ4TzARdReOVcIf4MqvDOG3c9Rh+gAEEVyXKuHvqwmWdH92/
         DUiKcCIzzSxcLvBzPAfgUMBvuhVi7dc+pQNkEJi+hHx35kEuLWVIp0OMHFV6fN6lsxd3
         i/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786076573; x=1786681373;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GwROwkmiHrpoWilT8NKMPgQZsuspf+l7q9+MCcf4wEo=;
        b=jWbwrxMefOlYp5zyMJRqdaO0RAjd8Uo8aNkcUlNzcVZpMCy5Nm+KOVHY3iXrnAydn7
         GFk49NlXyV/J4sIgjE7+CF8WeoaFwq0i13agt9YwPLUyR2y5Um1aoABWuNtmWWdrvCO1
         N/0VrtY2wh3Ytca05OSfxBXul56sPG9Adr4sCsCOe+OgACgzQm1khEG3JlLHwrNKDyWT
         ZRAKRWTpon3ZOLzwgmt/pB5e8D+sFSWqUkfiWKPoNyonNzKh54jwFhUnSCydicMVZT/z
         3zUdaEvxKCMC34EqVbKgLJR1ZgLP9WvQ+O/lmK3yYAW2xWGPq0Gd4mgAzMNOLgZiHMMb
         nCeQ==
X-Forwarded-Encrypted: i=1; AHgh+RrOyb50GuHbNSJ/oZbcxAE6RkkFgsoENJQzScRF7nYhk+12VZD1Og7cEhIUXuQ0A8EQ0goz7UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoHltbqP4Diw46bfhB6emDBoClb1hL4rEFxx0ZcXruhqb1bJSJ
	ypT6cassRd7wUtrbp3/Nnl9y2bFb4NnYzH42dI0q9hQL1bkqsH9/j90E
X-Gm-Gg: AR+sD12bjhH6J+fx+MhxK7/I+qXxy3NKZIwW7HDpjGEclJ2yu0jaC1NjWHg8/oQBTwH
	0EemIrLlA5RTnpIQ2MVBkiAieeaFgn3UdoJnBJcNKquwUlZ9FSkj5UEwHXBus5JyVb6n8WuS1KA
	awnJeVQqrJFuQ+xvcyeUrgBRZHjIuo3tQA3PG5gXbOrMqkHvB33An9eXzVDVOZ37GAphfHZz+CK
	MC8qqSboxO09Tfl6j8IkhwDyq7CmlrRu/ptMoMtwD0M5luHGXvfdEY62tjxcKy7ljQEouxGxFut
	PEwTQJK/beED+E2Asf37AfHscS83pBDcfC7k6S089gZb1p8IcaeDnruePvu23+xhdNWGXRo3QWQ
	FSu9zSGHssIE0MHXtTYTles7Ln98QPQrf0KXB0TGvgpQV15+ZC8OOE68fN0zvpxIuzI21PrdBE3
	oi73m9S3soXTIMQfFiPX/SNymWl8IHPVjG+7vizjsuwvrxx01qnVIppAhWzQDEp82+eOiqJEskJ
	T8FCRhv7NUCMSyYPN09+OpA
X-Received: by 2002:a5d:624a:0:b0:47f:9750:26cc with SMTP id ffacd0b85a97d-47fec630b5cmr24277446f8f.23.1786076573196;
        Thu, 06 Aug 2026 21:22:53 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e902dsm1786284f8f.21.2026.08.06.21.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 21:22:51 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 41479BE2DE0; Fri, 07 Aug 2026 06:22:50 +0200 (CEST)
Date: Fri, 7 Aug 2026 06:22:50 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	David Kaplan <David.Kaplan@amd.com>
Subject: CVE-2026-68480 mitigations for older stable series (was: Re: Linux
 6.6.149)
Message-ID: <anVdmsj0Ko294nBP@eldamar.lan>
References: <2026080618-mulch-nullify-723f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026080618-mulch-nullify-723f@gregkh>

Hi Greg, hi Borislav,

On Thu, Aug 06, 2026 at 07:32:17PM +0200, Greg Kroah-Hartman wrote:
> I'm announcing the release of the 6.6.149 kernel.
> 
> All users of the 6.6 kernel series must upgrade.
> 
> The updated 6.6.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

It got mentioned outside of the stable list that the backports of
7e7f81cf6f5c ("x86/bugs: Make Safe-RET robust against interrupt
injection") to address CVE-2026-68480 will not work. So raising the
problem here.

In fact at least they depend on CONFIG_MITIGATION_SRSO, which only was
renamed in a033eec9a06c ("x86/bugs: Rename CONFIG_CPU_SRSO
=> CONFIG_MITIGATION_SRSO") v6.9-rc1, correct?

Borislav, can you have a look for the older backports?

Regards,
Salvatore
