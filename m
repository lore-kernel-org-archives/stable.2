Received: from smtp161.vfemail.net (smtp161.vfemail.net [146.59.185.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDFB3C4167
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.59.185.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369147; cv=none; b=XazGh4IseBUHGnG3WHtijhtOAAx6UCr+w6Nfck+OieyQM+OkgMq94aHcJYwhzyOwoj9yIYYiMxbsiNOEnNQuRDmsNGYdUxFu/GZlqLXK9tJHcrjTTbJNDgyQrlT85GmxkVn+G4YPQYR8UV5vnNxmaz0rWhyH4GTadLd0/FHwhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369147; c=relaxed/simple;
	bh=a+J7tdPKyHsKuAkk1mQ20zUKGmoe3x1TvOV647oemxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H07NChZM9y0J0hAI2oRobSnje0ameYgrKft6k0uQSe4KECo2AJ2PS7K8GML3aEz+Uf2KK4qaHqcksvoM6v3i3+RsS76oU3d4ktqDw5RGlJq84m2s/E6ZOimRRSAT4uvvAShmkthfRuwQLKCtdterav9pjNDFRaN4AQFuncS6zjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vfemail.net; spf=pass smtp.mailfrom=vfemail.net; dkim=pass (1024-bit key) header.d=vfemail.net header.i=@vfemail.net header.b=ZJsI8j2I; arc=none smtp.client-ip=146.59.185.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vfemail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vfemail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vfemail.net header.i=@vfemail.net header.b="ZJsI8j2I"
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=vfemail.net; h=date:from
	:to:cc:subject:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=2018; bh=a+J7tdPKyHsK
	uAkk1mQ20zUKGmoe3x1TvOV647oemxg=; b=ZJsI8j2IMmQg2w34yRGluRe/wR2t
	d97Zr8SW5OA5zWocmTXD2UhB2DY5D0OGS4mTH2xBmrjzmeq9M74naPAkdhXa8XR7
	NPBJwgdyq5L1QAdyv+yjY8f7iRe9e1Cj2SnTl5onEWCu/S9vdoR5lII+BcOISPUX
	A8svY4Q+w/EQTAs=
Received: (qmail 21846 invoked by uid 89); 10 Aug 2026 13:32:22 +0000
Received: from vps-dc174dc1.vps.ovh.net (HELO d3d3MjIxLnZmZW1haWwubmV0) (aGdudGt3aXNAdmZlbWFpbC5uZXQ=@MjE3LjE4Mi4yMDYuNjY=)
  by smtpout.vfemail.net with ESMTPA; 10 Aug 2026 13:32:22 -0000
Date: Mon, 10 Aug 2026 09:32:19 -0400
From: David Niklas <simd@vfemail.net>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 stable@vger.kernel.org
Subject: Re: Linux 6.12.99
Message-ID: <20260810093219.21c847f2@ZenIII-X12>
In-Reply-To: <anlKlnYz1on6qET_@codewreck.org>
References: <2026072931-buddhist-lethargy-769b@gregkh>
	<anlKlnYz1on6qET_@codewreck.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 12:50:46 +0900
Dominique Martinet <asmadeus@codewreck.org> wrote:

> Greg Kroah-Hartman wrote on Wed, Jul 29, 2026 at 06:17:30PM +0200:
> > Lorenzo Stoakes (1):
> >       mm: refactor mm_access() to not return NULL  
> 
> FWIW if anyone else cares and looks for this, this backport was required
> due to a NULL deref in 6.12.98 (and likely .97 as well if commit
> 4bfe8c481846 ("proc: protect ptrace_may_access() with exec_update_lock
> (part 1)") is indeed the culprit, I didn't check):
> https://lore.kernel.org/all/2026072933-widow-grouped-f9e4@gregkh/T/#u
> 
> 
> Greg & Sasha,
> this is purely selfish and I'm grateful for all the work you two do
> backporting patches, but (for next times) it'd be great if the backport
> commit could also point at why it is backported after all this time
> (for example add a comment or even just the above link between the
> original sign-off and your's) -- it doesn't have to be much, but it took
> me a while to find (I was curious because this was an urgent release
> without -rc, with a single 2 year old patch branded as refactor not
> fixing anything obvious...)
> 
> Ultimately it doesn't change the fact that "all users must upgrade" as
> said in the announce, but I need to judge the urgency of the upgrade, so
> having a rationale is extremely useful.
> If backported commits fix something obvious then there's nothing to add,
> but in this case I believe I'm not the only one who'd puzzle over it (if
> someone is actually looking...)
> 
> Thanks!

Thanks for pointing that out, Dominique. I'll second the motion.
