Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8A53B6360;
	Mon, 21 Sep 2026 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985883; cv=none; b=n9rOYDNJpEOUAqdQUbkW8pLuz0PJZI/qEC7Ntf561aQP0vgSAT1o5+yOsErv52aQmJJoiLmox0+JzEQowG3dBsz8rWn8EyXUqLOLlmbWuI+J7+Gn9MgQsnFvwOoBrUjBiw5khOcMt5Rxp3OIjwR480g8qJWqyWVl75DctUjH6m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985883; c=relaxed/simple;
	bh=pQumcm//+P5FtC23oznOvWATM5/MVXaxervTe7ynuvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwZpt4oHEnrxfw6VwMhPCtEpJNiTGBqqe9yDVjFsACM65VdksrKH/skMKpUcBLosG/IlnqgY3r5K4a6dbhL/eOTKq/11lgzLIeAwcnlhvaUIdm1fQ5CZHmUkH+U0eNAVrIz/W+pl+qeczUJX8jxddv39gIrIjvRGRzEJf+w8/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkzZ8rMH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkzZ8rMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CA01F000FF;
	Mon, 21 Sep 2026 10:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789985881;
	bh=uqOTbxWzk8L5l6BA2p4u811uJFFtZmHzvX1cPgWzEao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VkzZ8rMHWhP5HZK31X8dH0pCJ9y3qfwA7WbxZII0OT8/6PqgFeZdxZFfkR4q0Q+WS
	 4GwcL5008wqyQJQKjdE+7MK7KHPvCBEZefAbLX1LCd5narPa7uBpMYKY+91vYel8Lg
	 chyrAyKbvODnB1kx9m3l8CRnHWFju6BbpKywy+Lut1kQFTwuE5hMMVdmIcXrLWJEKI
	 a+MfwZPov4klFPb2Hi3P53pfXmYaNrx2zvBjGyBmO7u8acPH7rII7N8PTT39O4QaH2
	 8hLdObzlZD4ww1AOS0oEg5gsl3Wefjc2gggd1C/MRvmZIAMWLJMwePkLlVN9+Z6QRh
	 Crxm7nQaJRtvw==
Date: Mon, 21 Sep 2026 11:17:57 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	madalin.bucur@nxp.com, netdev@vger.kernel.org, nsaenz@kernel.org,
	pabeni@redhat.com, sean.anderson@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] fsl/fman: Fix fm_node reference leak in read_dts_node()
Message-ID: <20260921101757.GE13925@horms.kernel.org>
References: <20260917110342.2148155-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917110342.2148155-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 11:03:42AM +0000, Wentao Liang wrote:
> of_node_get() takes a reference on the FMan device node. That reference
> is released neither on the success path, which returns straight after
> of_platform_populate(), nor on the failure paths that jump to fman_free
> without going through fman_node_put(). Neither read_dts_node() nor its
> caller keeps fm_node around to release it later.
> 
> Release the reference on the success path, and route the remaining
> failure paths through fman_node_put().
> 
> Fixes: ecb239d96d36 ("ethernet: fman: fix wrong of_node_put() in probe function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Hi Wentao,

As flagged by W=1 builds, with this patch applied the fman_free tag is no
longer used. It should be removed.

Please be sure to check that your patches do not introduce any
new warnings when compiled with W=1.

Link: https://docs.kernel.org/process/maintainer-netdev.html#testing

-- 
pw-bot: changes-requested

