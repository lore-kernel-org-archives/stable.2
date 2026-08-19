Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C327F3932E3;
	Wed, 19 Aug 2026 00:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787100381; cv=none; b=Sou66msaEi3SyrD4ehHxpPirf4nkA0UfFkwb5i3O2KdXeLq2lO1j/kJPhWhu0vrkVwMuGP/bxAetjSjPbkZrg6Q0ZsVZYEdOWVjWTky39r+i3QjQ3ZE1hKPo998WJabSXC9XlqpDClTkA69eQmKMoS9unTIMcs/jmMI33RWtx9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787100381; c=relaxed/simple;
	bh=f7ZzbJXiWYe6cqCPyu+Pvx+E6WuRFNs1uNXwCfuZwqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZg8j5U1Qiyu25J2GypygLlf6Q9K2BNm1Nlljx9bLM5SpUPdGBo9fyVuiNy+zW/izTWoSgYObu/sRgrPV1bGiAju+l3avS+SrU6jrFZuiFmqS+XkPjEz78XYekXsCAlZyHjA3aiLTHf0mH+WFedMiPE/hiPh6RBYe9h/VY3XgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpA4wjQX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpA4wjQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E321F000E9;
	Wed, 19 Aug 2026 00:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787100376;
	bh=sYu7vlU7ywUHEBUGxxn0ADtdMmrC2dTyAmvbHTDXZaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZpA4wjQXXJiJ7DzbCAeHGWxpGX6oFC0/Wx+2NB0LG7FLn5Iu2DrktdLJJEXbklu8K
	 8EyF+ozf1i5Eh6MhYnJ3xinoDfZ6g6OvwxTJFGptoDIRgSaZvHAgdYdwPxNx2+Srga
	 9rnmIY/URngwDlto8jMXeq3rThwQ5QnxUB5HNYTITaW8CPasCaClvLxSkrQkoKjpZp
	 VmhiM/2HiIF7lSQA3iHTn4au6Ee/CzqnqPqGs9Rc3K1AsfVT9WxHNn0HL16JvYFHsF
	 qH3Pv3QnxB83A9q1c2lIOcOrOHM4592fQGlFB9diPGpevI62qYS8lxQfy5ydqZKrb3
	 dfHz/CZ69M7xQ==
Date: Wed, 19 Aug 2026 01:46:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] iio: admv1013: initialize callback mutex before
 registering notifier
Message-ID: <20260819014611.18db8689@jic23-huawei>
In-Reply-To: <aoR6tWAewJiVxOBS@ashevche-desk.local>
References: <20260818142811.2264343-1-runyu.xiao@seu.edu.cn>
	<aoR6tWAewJiVxOBS@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 18:31:01 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Aug 18, 2026 at 10:28:11PM +0800, Runyu Xiao wrote:
> > admv1013_probe() registers a clock notifier whose callback takes
> > st->lock on POST_RATE_CHANGE. Initialize the mutex before
> > devm_clk_notifier_register() so the callback cannot observe an
> > uninitialized lock during probe.  
> 
> ...
> 

Move the (devm_)mutex_init() up here to keep the notifier setup all together
after the change as it was before.


> >  	st->nb.notifier_call = admv1013_freq_change;  
> 
> > +	mutex_init(&st->lock);
> > +  
> 
> Make it also to be devm_mutex_init().

Hmm. I'm a bit borderline on this as the minimal fix is indeed the
move done here. I guess it is trivial to do the
	ret = devm_mutex_init(&st->lock);
	if (ret)
		return ret;

so we might as well do that as part of the fix rather than
adding churn by doing it as a follow up.  So indeed, lets
have that for v2.

Thanks,

Jonathan

> 
> >  	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
> >  	if (ret)
> >  		return ret;  
> 

