Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F6F37CD48;
	Mon,  1 Jun 2026 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322912; cv=none; b=ZTvZ1p4tdqE+xEwjo+NdubfFKTWEkZNECi2nSpnz+Y1p9aCcHQMSiu+fn48/C2CHr3doQ46Hh2uy8xgyjCNwWueyIDkVtLplmm3cw1qr9ZS9aw8xR0ja6vT82lEjGdbU0ozEEcY+XkH7RE0P7kGu4AM0B5NK3Df1U4jsN/J3Y1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322912; c=relaxed/simple;
	bh=Xl/eV74IjmxzM3L5aW6MZQxtWRbZLRcwLO77fn/EMQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9Y1lovZGclLEuFHmcazV+ojvegqf0IDFgalhwP75MGlBl1jEmWg7sXuAKs0PmvNQlGXDN8NvasQFb1nM7eCNrxbv6knplOcGz+7dYLqVYsJ4tS+Jar3qUArd5PFafCmd2zIuPo5ovXuszgwK1ub77wwIdqhntr/RLdjtdMfdIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=f50Wdhmn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CvRImn96; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="f50Wdhmn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CvRImn96"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 6159D138036F;
	Mon,  1 Jun 2026 10:08:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 01 Jun 2026 10:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780322909; x=
	1780330109; bh=6HDDCmBpB46gXJk6VrxDM/1W+kwWfioTlj1zjppZnik=; b=f
	50WdhmnpWrbof2mJ2n/2UVxDplIY7apqkAwaX3Q51n+2ecxAgDySUL5IDRrXlOJ+
	XbRK6eVw0o6T8SoGqO55t61lq8X0rJ8yqMg0Oj0/YTe4zDAhaRY0YTcDGO3gHmFh
	czlzNLS8l8aezOYXLkChuAzc9LgIqSoe9726YTGhhj9ITtx0nr0SXGb1w8039vFd
	KnkhoHTbarirYSdeTwHsKVo/wPbXA1z6sVEAyiP5d7lOwt9pzekFWAxtWY+euBqW
	/NpmyrU8tvyZ7Z1ezTjAcQUfL7mQN/DsKgAwVgHE5uXB18aP584jg1vXhYMv9ml+
	mO/orrjuFL5JKZP0sg+/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780322909; x=1780330109; bh=6HDDCmBpB46gXJk6VrxDM/1W+kwWfioTlj1
	zjppZnik=; b=CvRImn96/UrYQ85ylvZ+0YQu1dYcYhQrJ/EWqM44Rh9tjjq5Fwt
	gzbD9Tb5uAfRfjNQgH/bl9tUdCMF1C9CMXBoxgGtlWFCoGNwFS0kHTHpc20Xkg89
	UvzAp1IZCK33naObZ3XBHlRiIKw4gwE0dcYOa/rb+b7g2Tb8qoL3JHTEB5GT5J+z
	qNe3zHcvfBQ+CEs3UTNzCp0OtIu+PSY8iGaIMCl5OeQ3q3YphRddj5dh8Snop3Df
	76p14boGljDfykuPIiIkGYOQU88+iTlDSudW6zwA6Mzqj5Qj6UOT6O+yiMMCAfXj
	eGIFbPZsfPnfC4KyqVS6qYPKCRdUbhy24Pg==
X-ME-Sender: <xms:XJIdau2xNcew9NuQylE1EIgpeCCBoXgEIiNeyCvfv3YVoQsMtPd0Kw>
    <xme:XJIdapc4kaGaDMTxpX3X_zoIxOSPfYSVC60hylGhnwS-lA32IZI0ScXXKwz4yKcut
    i_8brCswi5BjvknID5IOPoUTtUYbILWoLsXXpyCTec49HVfMYGCxg>
X-ME-Received: <xmr:XJIdahIIGAJBaKj_iMiMWKvfNDVSRON2K1MTGdr5WQkvP7b7PX2fIIsvKSIvKg>
X-ME-Proxy-Cause: dmFkZTGG+BPfjueacM86TULJZov8aM9JltReYywddMsHkqeW/iXnPY1AlEvzFqfAb+8UuU
    kNZHKVUMC+w9mwOzblnHRrtqxDaCmrUv/w7iNRp49/rvhBpC6pp2Swn/kZehABqD2cas8k
    c7UzhEknhBUQfFoiS8CgQAYkLul89H8iAHdZwrIlcSNrtueukIU4xMTcEr3noYPBWYPZ8z
    FCDhZwW33wsmILwqnP7FOfhpiydyfG9hXHD9CoZmhGqLrO/ZbcH2ceeBPWg6GWHjlZNaqR
    8anKZkuTcuSdvA3dV3YHI+bnCc3KKaMj5+rUrICdWNQjrGH5IxkwUmhQSTbe1ETCoSh9k7
    4ZswLeUvtjDvkt6SjVF9kYNeKgo8aFf6uELdJS1viU1f0BPI4tnaINv0np9GS7PRcPA5G9
    bUkGBC0T3ZTuE4a6BfYMiEwk2LaO2YDWmnRqoePtX60Swro9wEwSIPr/b8cZF6zA5i/vrv
    lrwPbjGWbwr5itaeEWnKSSXSrUtpMEtegzzTZkEEkPw6OqaW0oLCTgZqfpBPi3HnoRo1kX
    JbKctXg5jHu40wteAc43cnOuKAeNDk8JoIlk6NJptZmMCCWlBrv8shWoiPjVfLEENw/5G0
    OPU/Ws4E79PtJv3m0XGXAB1jkEkO2lr3PBmZrz3LPLjCRRe+xEWl36bYb3rg
X-ME-Proxy: <xmx:XJIdakal8p8R3wKv36P5NSisGj24SHLqTswt3mM6zbz94vDWNziDJw>
    <xmx:XZIdaubBXAFmCZRBzTWPlVl0h_jFWbBAuv-VeiR3TSqUfPoqAcnROQ>
    <xmx:XZIdavESF8h6R9fgi4zd8woXO5T7hTOwp3PBvHm7IL3ja1NE16Nhnw>
    <xmx:XZIdahB-ks8xcu_DK9fRzojzqK_O165xdaQHcEtMz6sZVebn1u_Ucg>
    <xmx:XZIdaiiQqxWjmz2-jomWktoe-Ad9M2KvZNTEjuPzcrurOEvoP6zwpDcI>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 10:08:27 -0400 (EDT)
Date: Mon, 1 Jun 2026 15:08:19 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Mike Rapoport <rppt@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, akpm@linux-foundation.org, 
	peterx@redhat.com, david@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, 
	sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v5 04/18] mm: skip out-of-range bits in mk_vma_flags()
Message-ID: <ah2SL2c0nMj0KBtP@thinkstation>
References: <20260526130509.2748441-1-kirill@shutemov.name>
 <20260526130509.2748441-5-kirill@shutemov.name>
 <ahmQvfNk7S4F0LBj@lucifer>
 <ahsVyQZ5UXhJLct2@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahsVyQZ5UXhJLct2@kernel.org>

On Sat, May 30, 2026 at 07:52:25PM +0300, Mike Rapoport wrote:
> I have a PoC of yet another alternative:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=uffd/vm-flags
> 
> The idea there is to keep a single VMA flag, VMA_UFFD_BIT/VM_UFFD and move
> all the rest into what's now struct vm_userfaultfd_ctx.

Nice!

I assume it can go on top what I did, right?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
