Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605F446D551;
	Wed, 23 Sep 2026 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152837; cv=none; b=J2gS+0ItFwMA7navSVuYDj5KFoA11Swyg+UPJZOm9iSMc39Y5jB6YiACP18MRIMHVUXYYk5ewweYqT05GhBpV9feGsR0C+NWGjZOfr+ViTDRt5Mh7g6u3JxV/yW3phjQB2fr3TNc/rXC70i+Yaqnue/Jz5gl4vrDHghVPbHQrT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152837; c=relaxed/simple;
	bh=K38GKIhYygo40OSAIx5jp4HreWHfMJpznywxecd+EBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNiL8fOAqY6fu4sWctVl7G5uBQxKBvQq94KwK/X9vluZDBZI322/UhWI3epsxMHOZRtm33wlGLH7qNlflAt8p8/DYWlATqGQdfp7vclbduAdftZWXj/ULKzB74c5YiU/iNadqYYta5yleaeJ2hADnPvfAO6Tcu+CZt9HzjdbJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2ZLm6b/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2ZLm6b/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EE11F00893;
	Wed, 23 Sep 2026 08:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790152820;
	bh=4/p/6NzABfZh2W4lA/ZfbZiaJjOtmu4YBNzB36CjHBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l2ZLm6b/EI4CvUZmROWPI/SqMxY/QSpl89lkgz9wNf8GnG+Lsb+gfl67mDRt6sJ05
	 hPFcyQt/foxrR8cGAC4pebexm6WxaKdxSZh/Uk9spJU3ozviD8Fe4t35fJ6bpm3jin
	 syumUjlGgCmtBj7664n0qqiFOV3IJAS3Qmte+FtoLqLNm6CmiUJAzl/suH0h1wGrJ0
	 d+U63KGBO7kj/J76vkYGjE1R7LfIHUdLy/HnHSYY2mcybF2If5wgK4NJmFhp1D34pk
	 sKPHhyNfLnYHDofP8lqDqKV8tl53T0hrMDv5YWGRmEo5AxIdA76nO6nkT4nsi9qw9L
	 34xO6HYm4eStg==
Date: Wed, 23 Sep 2026 09:40:16 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: dakr@kernel.org, driver-core@lists.linux.dev,
	Sudeep Holla <sudeep.holla@kernel.org>, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rafael@kernel.org,
	rob.herring@calxeda.com, lkml@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/6] driver core: cpu: Fix OF node reference leak in
 register_cpu() error path
Message-ID: <20260923-uncovered-worthy-capuchin-a75edc@sudeepholla>
References: <20260915043523.1725991-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915043523.1725991-1-vulab@iscas.ac.cn>

On Tue, Sep 15, 2026 at 04:35:23AM +0000, Wentao Liang wrote:
> register_cpu() assigns the device node returned by of_get_cpu_node(),
> which comes with a reference, to cpu->dev.of_node.  If device_register()
> fails, the error path calls put_device() and returns, but nothing ever
> drops the OF node reference: cpu_device_release() is empty and the
> driver core does not put dev->of_node on the failure path, so each
> failed registration leaks a reference on the device node.
> 
> Release the OF node with of_node_put() on the error path.  It is safe
> to access cpu->dev.of_node after put_device(), since the statically
> allocated struct cpu is never freed by cpu_device_release().
> 

If this is part of a series, I can't find 5 other patches or the cover
letter anywhere.

> Fixes: f86e4718f24b ("driver/core: cpu: initialize of_node in cpu's device struture")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/base/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 875abdc9942e..bc96725c8d4c 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -431,6 +431,7 @@ int register_cpu(struct cpu *cpu, int num)
>  	error = device_register(&cpu->dev);
>  	if (error) {
>  		put_device(&cpu->dev);
> +		of_node_put(cpu->dev.of_node);

I would also set the of_node to NULL as I see some archs like PPC is
making some decisions based on non-NULL pointer. I want to prevent any
further OF reference operations on that pointer.

-- 
Regards,
Sudeep
