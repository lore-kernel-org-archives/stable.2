Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BED1607A4
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781988287; cv=none; b=Oo3OlbY++lpj4O+eUVwKJ8YSBoG6zGXM3MxVRDTF72Vy9vfKIEuKUDtfxQ0gOwOhinlqufWIeL/12v86+FU6dtONb8Oq4JcezoA5x+Yy5QFI2dTOlS+TOEUxIAYf303ro8l6qnWblyFlthM5J5VAXofNcnGL/Lgb0dC+9usxOiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781988287; c=relaxed/simple;
	bh=U7AqPRs5Is8Is9SjOZmekPXBSghQ5JGw1UeCdOvvZvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYg7UXVN6BtyyiugIjimyeIzoUlxg02V4Pcu+tQVvnQW8VhJ/d433nRabJBaU1+7autPYyoWLFsvP/IVLZDggq31+gCir/AIRRp/N2jk/bEUB2BBotqr8cd8IvHTVH8oVT3qaNmieJVbkNrjvZ2WPrTLKWJ4hyu73jHh9PtUuaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUPBIixa; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUPBIixa"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-462bb734793so1995373f8f.1
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 13:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781988285; x=1782593085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEJeIuAOhsEHJ09iO7qVlqN+PvloGiCYoriT6c3hYsU=;
        b=LUPBIixazRPSirqDkp63niS5WeCN1ro9nfbI/OSPEVtweqvBR0fp37KJ68AGl0psaL
         NWBF1s2L8Jbk19PyvrNWeI5AXRYbbgeOJC9Wy8Kn0kn4lio+V7dgYcAywe5gX32PhCcO
         OiuOiHQiKoDL+q0F26VF6jyS+aFINcy2s1td5I5NxLLtykxYIYJN0AslHz/GivWGCKql
         H4t+geJKHgfdesazhdUaMp6jjl0gWi2Cj/xOzYD7+imKSPME5uintZ/HoNHpF7RIaR7i
         aAAVmp65b3IKSQPDyjN24v9vFyJt7m8wOUn/Q7rqIUsdhbh8I4EdeH6QeGiOCZPbAhNf
         GAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781988285; x=1782593085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KEJeIuAOhsEHJ09iO7qVlqN+PvloGiCYoriT6c3hYsU=;
        b=O6pqK9/7E2NYdZqwINtZvIN+fH/Dt1U9G4dEXGd0ilUe7iFS51K9LLplk20PLktJl4
         EvU99GZ00yXe1kR9rmuOVGUVvfpqwptrsysliGwtCb2tAr0S/M/g/dE2ybJPfbuI6wvQ
         fN2ftEA+44/d5n1DMzQnZtdXQGK+xBSEttnT/073QEBNdcWZvM28vvDCFnhngPKGZiBy
         IxbG+xBOoHl0eSIx9gI8VJy7zb+exNPbHJOYlxYl8zbJRwX8EFduyb1NL/O0t3yyxQCp
         brKzflMiPQ+l0MWYeaHKooklwBWGkRsUvvsbRMXz57XR69haz3IevyKmWgq8aX9nO2io
         RgCA==
X-Forwarded-Encrypted: i=1; AHgh+Rr5z1BSrpDPOeA8sv5FE4wOVcunSDjs6wSnhBOkWjLji0h7HyFnZBb6+ic/p19ip75BGxoQlkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqmvQ7GaoAis7CUCZjJxaXm9jycAqck+208acyPSHK55KFPAjg
	zBLxsDjf0PgNmKLegHc93QO1PobFkTH9QVLSrAV14qk48E+msX3djoIZ
X-Gm-Gg: AfdE7cnUf0XnnVgveijd6eT9WceTWg6J5wjLH7Ir0yzrfhHBzgv9RKxH1taFEkesOo/
	gd4n8TcsttBCCq6NV6D7XcFJwAfcEWdAQuWWqaPI0hSBZoz1PIJUS/cWIIhS4QUHs2oo7qmwUPO
	fDvB14wEMAtaqh7xSY0jy3a7lkn+bW8XdwKlITQZxy0j4U35PIc5Vx8wglwaxniftsDAsnZa/sQ
	4HNid+QEKCGbf8KxJ0iAyB076Wm1gI6OPqnXYJXLJCqCk7vFc1RufIERbbpUB+aGHaogOLwHvre
	Qyvi6Q5LKSxjThWmZoGcCvXE/zLcu7/9nDH0bmhDaBvKsb/JXrNX8hNCnwAfeMhrvHPQS9+wayi
	vq8NFdNTtqJ2YyaORY1kBmaMKf9POa8P0XwLNqLjkUOUGRrOk9glNOAwfvbkpBaSvA9JLHdVLHf
	fdX+K+7XrnG2wtryaDOsP7DS4/2tpbTLztWt5bBdMSmVm0ttOn
X-Received: by 2002:a05:6000:46d9:b0:45e:ed7f:1dd with SMTP id ffacd0b85a97d-46662334b91mr4727341f8f.25.1781988284592;
        Sat, 20 Jun 2026 13:44:44 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4e93sm12184790f8f.7.2026.06.20.13.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 13:44:43 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 41C3BBE2EE7; Sat, 20 Jun 2026 22:44:42 +0200 (CEST)
Date: Sat, 20 Jun 2026 22:44:42 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Alejandro =?iso-8859-1?Q?Oliv=E1n?= Alvarez <alejandro.olivan.alvarez@gmail.com>,
	1130336@bugs.debian.org, Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: Bug#1130336: [regression] Network failure beyond first
 connection after 69894e5b4c5e ("netfilter: nft_connlimit: update the count
 if add was skipped")
Message-ID: <ajb7ugG5mYxYIPva@eldamar.lan>
References: <c72a56ab-a16c-4866-9a44-a03393f074db@suse.de>
 <b3cbfd15-acd1-4500-ba30-eac6f48523fb@suse.de>
 <abW2MAAqLnKZm3KF@strlen.de>
 <177322336258.4376.10097494324750307114.reportbug@Desk1.simalex.iccbroadcast.com>
 <4da571ab-fa1d-4ee6-b71c-24f4a28243ed@suse.de>
 <abqfSB0TUik1kRU4@eldamar.lan>
 <e24a281622cedf9e8f4dc93c961813aeb7b6ce4c.camel@gmail.com>
 <8788e351-553f-48da-a6e6-ce082adacb8d@suse.de>
 <0b8607c8-2d29-4fca-961a-b7a677e968a1@leemhuis.info>
 <f67a985f-c6a0-4796-b255-59d99e317b6f@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f67a985f-c6a0-4796-b255-59d99e317b6f@suse.de>

Hi Fernando,

On Wed, Apr 22, 2026 at 12:32:34PM +0200, Fernando Fernandez Mancera wrote:
> On 4/22/26 11:18 AM, Thorsten Leemhuis wrote:
> > Lo! Top-posting on purpose to make this easy to process.
> > 
> > What happened to this regression? It looks a bit like things stalled and
> > fell through the cracks. Or Fernando, did you post a patch like you
> > mentioned? I looked for one referring the commit or the reporter, but
> > could not find anything -- but maybe I missed it.
> > 
> 
> Yes, it stalled and fell through the cracks. Let me prepare a fix as I
> mentioned.

Did that happened? On a quick chek at least 7.0.13 upstream seem still
to exhibit the problem (or would it be fair to let this usecase rest?)

Regards,
Salvatore
