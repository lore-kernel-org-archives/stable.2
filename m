Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BF23630AC;
	Sun, 14 Jun 2026 22:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781475024; cv=none; b=L/4P8mutkz5WTkPbrhN5rYFZCSMldjDt8ArXJBJ94C5meD5ZFswbJu5ja6yESUvvjWQ00A71hfriJjfP7zWs7Y0cFFrNE1w2kGvbtGpt3OXsJek9MW9DluWAuKmwPttYNgNnINeRib5owAdovA3ynnwsSckz/3rN0x5D2gWiM0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781475024; c=relaxed/simple;
	bh=LRbvOsOWovPZH9qU0dmkZSpf0guZLtIAOPRD7LL58Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB3izHeocpvt6OYFtR2VUAkPl7dO11ur0r5kRbqypczMYUUujYmT5GkgSNscm2qhlZbF5SEH5hYVoa0AEmL4v90heJ92IdeOt4LzOEHSVO8ZQ0Ggde9P7hEtYgpDyFbx6EQ9jbcK021V+zlsMBunGeg0Ps2rsufgnE9RhZIUBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKVGDZMl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKVGDZMl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BD91F000E9;
	Sun, 14 Jun 2026 22:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781475022;
	bh=KjrYwf8+CGJvAspf62xTPMZf7Nn80nEbSHBElVWQDkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SKVGDZMlDwKSdV+mCoh4SzN/s8m1vBmqFQzzeqloVuQhd7goh/9aVp9oHfh/FwD9J
	 30OcTAEXHGV635FFw9hR5A5wjn365MOefiD8PMMB/DY83xjtk7Wo/EG3+cFOsyNlBc
	 ll0LRb2fcj+BIjEUWFdLxNRAS6H++LuGmKRk//wKHH618f4m32x7gC9b5P0fzIh6+E
	 EKBbnhlAXHbOoNdaFhGU1JV8krUDzJWVhaKRbWZoeL0RoBPKwnvuS/MWbqW3TINz4e
	 cIYCm4ruDyJdb9wp/y+hI8LNMYU0acd32l7asH8pxPBfjJOBbWmcrHnLgZbGfNsjBD
	 pYQly6W18oSnA==
Date: Mon, 15 Jun 2026 00:10:18 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: brgl@kernel.org, khilman@deeprootsystems.com, chaithrika@ti.com, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: davinci: Unregister cpufreq notifier on probe
 failure
Message-ID: <ai8lzZi-vWvkQlIF@zenone.zhora.eu>
References: <20260610030513.2651018-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610030513.2651018-1-haoxiang_li2024@163.com>

Hi Haoxing,

On Wed, Jun 10, 2026 at 11:05:13AM +0800, Haoxiang Li wrote:
> davinci_i2c_probe() registers a cpufreq transition notifier before adding
> the I2C adapter.  If i2c_add_numbered_adapter() fails, the probe error path
> releases the device resources without unregistering the notifier.
> 
> Add a dedicated error path to unregister the cpufreq notifier after
> i2c_add_numbered_adapter() fails.
> 
> Fixes: 82c0de11b734 ("i2c: davinci: Add cpufreq support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

merged to i2c/i2c-host.

Thanks,
Andi
