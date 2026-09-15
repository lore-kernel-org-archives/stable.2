Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21241361943;
	Tue, 15 Sep 2026 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464135; cv=none; b=MjY+fwcFOnqEgOcFH2ee7P1640E7cCDmY6xA7la19k8uqG9z2Hrf8X5Mr4+mHfYOErmhzGj8mLWe6cD3QWCauDj4scbEzUuwc29ORF6ifAz5NhPMgjLaXQ9LDNLUhY18wWTmdbE5WSHu7J29WI4tMr3WuknzTdTpaSn+J7pLE4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464135; c=relaxed/simple;
	bh=dKe0auOxolKJz3xLax6E3hEF6i2fhOjbA+KiGWxnr/Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sPnZeZDj3VmNSv5s3QPhsyJcyTwuQhWpKsVEsvne8EwLgCw89khnDLjibnd1PP96Sc2k0zdC6a7f9vZiZfE3XKtNiF0+B6hmuOXwHZcWxVw8bqiAMeK85NbUXzu4pVB9AnbYzLbtemJt3a5F7Dxa+5sO8i6Hy8ZdgABSMbYM+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luyZ/DIs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luyZ/DIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CE51F000FF;
	Tue, 15 Sep 2026 09:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789464133;
	bh=NufV4CC7brVSAHhunPvbXm9qtsDlOiiOuorQ3W/XfnY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=luyZ/DIsdIu9UxePGbK7yhKMb34vHtT0oT2hYgfNT9JOct34wNOTPWw84djRyxksj
	 qFBQxYX6oAbzhEL4St/9XAO3Pc9DXh44yKKP1WHqIpcnlRZhMmpTcf98BgIo4M5OoA
	 xtFwatEq8Jz9BfaBdYbpb6NMqidsBpSdAy1h3+LjOTB+FjubMRxVa17hLU12lTed1o
	 cLe+IFC+8HpB67H9tj7scMfWrG5003rXTJUwewa1VURtfChZbm67CkjJ/UWtIa52lA
	 hQyblMQl+4J9tQdT/8q3WzpFHYXqm40QUe/bPzd2ve26O4lh9iHUrC2GG258Fqz8Ts
	 E2ZW4Tr4m3ZxA==
From: Niklas Cassel <cassel@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: dlemoal@kernel.org, gregory.clement@bootlin.com, hansg@kernel.org, 
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260915065933.1733061-1-vulab@iscas.ac.cn>
References: <20260915065933.1733061-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ata: libahci_platform: Fix device reference leak in
 ahci_platform_get_resources()
Message-Id: <178946413165.744977.6360074567141853266.b4-ty@kernel.org>
Date: Tue, 15 Sep 2026 11:22:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Tue, 15 Sep 2026 06:59:33 +0000, Wentao Liang wrote:
> of_find_device_by_node() takes a reference on the port platform device,
> which is only used to look up its port regulator and is never released,
> neither on success nor on the error paths. Drop the reference with
> put_device() once the regulator has been obtained, which covers both the
> success and error paths.
> 
> 
> [...]

Applied to libata/linux.git (for-7.3-fixes), thanks!

[1/1] ata: libahci_platform: Fix device reference leak in ahci_platform_get_resources()
      https://git.kernel.org/libata/linux/c/26ca58db

Kind regards,
Niklas

