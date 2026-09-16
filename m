Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3EA382F0F;
	Wed, 16 Sep 2026 05:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789536589; cv=none; b=UmXSePyVMCRVem0IbpdcWBXDlKg2u7MrIADcAk8pLCfAU6xqhSml3S0cuF23FHQbzaDFo+qrkwrrxxAIeneX4IAoHegTwLIAvJCoxPVT+3yLglO/ZZTiQqavC5kDeIBgciZHFXyJ4HNpCgooK1kX8JmqQm3MolyBS76YL4A13SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789536589; c=relaxed/simple;
	bh=CLOgoOtZKMkjpf7Cqv+XO6Kfp9M38MrquGQLBW0WLpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sslL2hkwlSLVCpK0ngjwbWkiP0V8XIoizFvTcnIijq575XApjJkgxaqzuggBs9rhTUYU8+6eWjUx5Db8vYia3pJTcfcEBco0X2+qmA3yHCS7+dpkZ2craJCjSIH+0ii4fPN/PRED8dATfVMIAlSlWleh1S6LevpFqKBGiG7DMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgQ5pyb7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgQ5pyb7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E31A1F000FF;
	Wed, 16 Sep 2026 05:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789536588;
	bh=HHkeARwhy1oTYtVNs8kUEtMRFomwDPXBcSsRb64+kX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BgQ5pyb7FNNGk43OjG8peeErAeG9Op400xqgbVv/IHgi5QcC56KtIrdb2gdHIzz6U
	 rZ6GIbzmI5AuLPbSMmpL6874iJGf3iaX0Ph7nZtUgmWAY/7PZegZb2K7tbxgX960SW
	 /rImGDc3Ty7bGzbNyQpf3aeDdIDiubQ+3AyyBU8qeQfKQIvLGp0Omz8vj65dkZq+Dd
	 fzA5D4NNL3hpG31tXlnJ3qSCq62C8UKM4cfICa/yMqisrtWbh0RiPBoIPjbzXLAgYl
	 P9eKS5q6/nXgREHRhVpUFUO4vScXtzX0pHkjehj0sIvaYAmupDvilOxSuddF1Ev6s6
	 0lwD+mYQv7plg==
Date: Wed, 16 Sep 2026 07:29:43 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: dlemoal@kernel.org, gregory.clement@bootlin.com, hansg@kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	tj@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ata: libahci_platform: Fix device reference leak in
 ahci_platform_get_resources()
Message-ID: <aqopR6DfznLqgFx5@ryzen>
References: <20260915065933.1733061-1-vulab@iscas.ac.cn>
 <178946413165.744977.6360074567141853266.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178946413165.744977.6360074567141853266.b4-ty@kernel.org>

On Tue, Sep 15, 2026 at 11:22:11AM +0200, Niklas Cassel wrote:
> On Tue, 15 Sep 2026 06:59:33 +0000, Wentao Liang wrote:
> > of_find_device_by_node() takes a reference on the port platform device,
> > which is only used to look up its port regulator and is never released,
> > neither on success nor on the error paths. Drop the reference with
> > put_device() once the regulator has been obtained, which covers both the
> > success and error paths.
> > 
> > 
> > [...]
> 
> Applied to libata/linux.git (for-7.3-fixes), thanks!
> 
> [1/1] ata: libahci_platform: Fix device reference leak in ahci_platform_get_resources()
>       https://git.kernel.org/libata/linux/c/26ca58db

Wentao,

Since your commit was top of tree, I took the liberty to amend your commit
to address Damien's review comment and to pick up his R-b tag, new SHA1:

https://git.kernel.org/libata/linux/c/0d1cb833


Kind regards,
Niklas
