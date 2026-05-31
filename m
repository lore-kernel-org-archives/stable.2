Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53483112C1;
	Sun, 31 May 2026 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241191; cv=none; b=kDH4KOubr+/QA55F8Op2ozN8WRPwFRDVxjGrPIOZ6eVQJI7KDny9CuX08wMZieHZIb99ujtJ9tyPAxn4LJULZ4PQ/R4UOspyQrwWPe+Ofd3IOqINST5O706aRFm7qk0Sym0HRiv2Lxl+420HURy3rb0X5PaBHVq4wR5sdcmc2PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241191; c=relaxed/simple;
	bh=xW4ka1DZpu7P2cUnHjBUEMfDUHAeRAPOyMtbF+394+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOUmo+WBK8WKhSDJ6p3gKsErcnkW/IiCyME7bKXEOMU7AKDP76LpPzZUjKAN3bOr8XlY+QQL6CvYmZvBuuSuspLUyACBU80upr9gF2sR7kQcUNXOrqJCxz7lIlaFC10okrtfaasIdkeV15KPIsAocf3G7K5GG6eGAk6RhkSA8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nhbaX4Nw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nhbaX4Nw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D681F00893;
	Sun, 31 May 2026 15:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780241190;
	bh=z704NJZDS6mAj4oNh35dy4uyshG7Q7lM1eefKHZO5B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nhbaX4NwOU06t8ZNdaIO0VxywgUqso+21KIvjTGnO/dDzWyLgFVlSnXu1SKqAqAWa
	 Gc1/Yty+0S8fbXvIQuX+5nSVl2Uvi931nBhBaIjTwOqIyFQLmWZnUHbcsWnPUXJrMN
	 5QhiO+JCfjEQ+85odRPaGugXyv2V2ueo+g7uQJfY=
Date: Sun, 31 May 2026 17:25:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yanfei Xu <isyanfei.xu@gmail.com>
Cc: Yanfei Xu <yanfei.xu@bytedance.com>, harshpb@linux.ibm.com,
	zhaotianrui@loongson.cn, maobibo@loongson.cn, chenhuacai@kernel.org,
	maddy@linux.ibm.com, npiggin@gmail.com,
	sashiko-reviews@lists.linux.dev, seanjc@google.com,
	pbonzini@redhat.com, kvm@vger.kernel.org, stable@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	caixiangfeng@bytedance.com, fangying.tommy@bytedance.com
Subject: Re: [v2 0/2] KVM: Validate irqchip index in routing entries
Message-ID: <2026053122-splashed-supernova-90c3@gregkh>
References: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
 <2026053158-cussed-outweigh-6f0f@gregkh>
 <5ee310d9-d432-400d-8506-751ee4a41fc6@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ee310d9-d432-400d-8506-751ee4a41fc6@gmail.com>

On Sun, May 31, 2026 at 10:36:27PM +0800, Yanfei Xu wrote:
> 
> On 2026/5/31 22:15, Greg KH wrote:
> > > -- 
> > > 2.20.1
> > > 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> 
> Thanks for pointing out the correct process. I saw
> that PPC maintainer added "Cc: stable@vger.kernel.org"
> on v1, so I mistakenly thought v2 should cc...

That's great, then take a look at the file above to show you how to do
that :)
