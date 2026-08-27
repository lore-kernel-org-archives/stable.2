Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80CA1A5B8A;
	Thu, 27 Aug 2026 05:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787809617; cv=none; b=ZIU6Yuy8A1PSCjXNVGGawZYsOYKNs1UQRuxR6uMuj7kAtginjlG1sqOOqWqUUv7vxqd2Hd5qsKDO5LdHCgfh9rTRPQ2wjEl87/KCcB2hcOTvqfGCOpRhblOEZFKqO/Whfr9Du4w3SX6HFYaStUbhUbc+NGjzf/ZJEr16u7DcNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787809617; c=relaxed/simple;
	bh=dLmG91zn2oU/M66kJqcWLHbRnLjYZMJnxLcKZFD4hSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FE3bNkYSxl03F+42mT1HN1bKQx6kj58ffy+wrHM9p7mrNXBw1IXDhvacDaevJPQTBu9RZHTTy+xJK0kh9ENoj7rZRoDwadzSPmS+rbgnTdAaz8EzGO5n3ESTaymv4b6+ncuSBtTzsT3m8PyDa8JNWD6qL42ZMA7XjLvzbwq7Yiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=cNemag5M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XDUGfX4r; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="cNemag5M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XDUGfX4r"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A27B71D000EB;
	Thu, 27 Aug 2026 01:46:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 27 Aug 2026 01:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787809614; x=1787896014; bh=o+ssIJuGRD
	zgshjvCjYAVg8jF8+dDtGdr+Sa5sOLKs8=; b=cNemag5MVyRMdp1CrxBtOXLCht
	eIy7XSlTlTcwr+YW7RsFJbt9qrtSp88EUscX62veabb4RSROrBYjU0w5f5Z5aSXN
	1BnRQlxHjF1ervYgCoijC+PoaqZ/hI5kXztaW1LzwV5GbBC2y5rn80LeThRSwosv
	6oFQbcxpFy69KkL1EDS/70YLdlHNOzEXuIDXSQy5f8hw7Mnwql2ogVkGd9gINIGF
	XXgNiNz0ltzzLUqrJeuJxHc7xWmi0s3NIuG66gTIn/PszaGm2H1FneOFVq0CYEZH
	VsHXUCFB6Ug10sawWUxBRjlGFtPIrGNNPxzieuHfEFmPjlIxQ4briclzY9Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787809614; x=1787896014; bh=o+ssIJuGRDzgshjvCjYAVg8jF8+dDtGdr+S
	a5sOLKs8=; b=XDUGfX4r68IUs0ZnRnc5obH64HJXJLL0hWt3nLimE6cwiPeUXSu
	gIZ3XbXYtyktTkQR49es6ZxdUnGzrc7csbxtGfb+/avIVsBmRkOsvIeftaqRb7/3
	0JS6gnVDH5AcPs4dlUNbvA4EV619rzqp3nDdrYQONSLPxco4U8povdBitLZIApoA
	0+XZKmm3xrHwjdJ8j2J+qyUAhh9GSrWNxltKtB2+GPe9FzSWNc/xPW/kJjLyJ7ip
	VJnfyrQR5ax1Okt1eC4zsZvO/jD1+JwLJg2IAIy+kSVTabU64CXRM8iYRJm9eEXD
	rQV4vG9uNlvajqT5Mh7UvNLDDLm6e/onXOA==
X-ME-Sender: <xms:Ts-Pav38FpxxDhp_g_nh-K_Zc964QE1tcinby_pcc51XnGATyRunNw>
    <xme:Ts-PatzHy0U_-i_GTF4MFNLvEhJ7ravloNwbTEk7ywN6T8PmHm4rZD43I8xvHgI0U
    WmQQYjQ5e6C2njEPpzllnM-JuuSzBj3EbSpIpv-7tWAwMyUbs8>
X-ME-Received: <xmr:Ts-ParhGnDbyGn6TcRfSOA51sI0li6dl0T7flet5OmChPL9y3GYmx1IlSt0AUR1pGcbgRqQqd4tnmLYPmY6ROBztdVL7Z1h7w2AX-fn6h6E>
X-ME-Proxy-Cause: dmFkZTFHo3LYfQEVYjvD3mDk/LUtj8RqIPPvAH2MqYercJI7otQ1cuo81Pd9dsYcpoeo1B
    AFaXgMK7gHM6xs/J70914zYs3eFa7Xw2KNe/8w9xLC+OuQmvDPI4yv56qJfWqpFmv84hl8
    ZiNWq1J/fNXgsOElNk/wjiVnGHWQT00vIySQ7s1wXmJv4wQy3+hdlzjLPSktM0ALVBveHt
    fFhotIxt+Ke1/pgguR66ucuxIAKqvBIBsbKyQWEO1C0YhQcqJiCZ/9Iq89WzUNu8M1jX23
    gRaBvy0qKNdAMbPVH2PjQgCzmRVJhS0TKGgtyq1EeIpiCW2pQ5u0o3afNu33RiEtYXl7AM
    PtCIM3Ag7uuSgWAykLRxF0SoCFi5rx7QXtwFtdIyZz16pzF+aWZ13ZcYbmu9u/9VBGZKPK
    +7nBFoMG+BCFoc3i5R9zNsf7+T0/2hgxdn8kD5QutDYJBAZP0ClJu6MDut5QQSiMhGJUJS
    Arbi8ev+Nn+GnHQLbtYlsc+SBSf9eY7ii3leU6kVF9/+CJJGej4vvntgF2tum8iW6PW4qS
    Ns9oVkWJh/uknmGA4ewl8qae6QtzwQYDIFZT91yWPApO7oxPlhyg2jE6Nw0Q6Kruu06Bh8
    ssD9E7TUyIC9vdro6qpLwLUfZ1z5xht0j71z2wGX0V/nm+GEO0g4oniCMgNw
X-ME-Proxy: <xmx:Ts-PagqwAWFmqsxENnN5nhzD9IQ5xy9WGEC3McDf03nbcHjXiOhHnw>
    <xmx:Ts-PaijD_b3n8zz5RJ3Fxa9aRb6NHtFAIx62zsG0t_E8ErdCpLjh2A>
    <xmx:Ts-PaiMjDUvLZ_0FrIdqXxtSh6UZnjjBI7-wvx-GMryf9KGnJQkzWg>
    <xmx:Ts-PaszSnj0dy2_B83YzMjYc3_UxMV77r0_tW8RnG7uwDcib-z_3mQ>
    <xmx:Ts-PaloahrRUAcZQIPlH6Ut4cxemd6RPgYAnsc6eX3OdxrKANoo5CJW5>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 01:46:53 -0400 (EDT)
Date: Thu, 27 Aug 2026 07:45:12 +0200
From: Greg KH <greg@kroah.com>
To: Hackdale <445735441@qq.com>
Cc: linux-acpi@vger.kernel.org, hdegoede@redhat.com,
	rafael.j.wysocki@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: resource: Add MECHREVO GM5BG0E to
 irq1_edge_low_force_override[]
Message-ID: <2026082751-viable-tamer-1d6e@gregkh>
References: <tencent_751A66BCB84E931ADBAB5073E0EB6FC8CF09@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_751A66BCB84E931ADBAB5073E0EB6FC8CF09@qq.com>

On Thu, Aug 27, 2026 at 05:33:14AM +0800, Hackdale wrote:
> The MECHREVO Jiaolong 15K (GM5BG0E), an AMD Ryzen 7 7435H based laptop,
> has a defective DSDT that declares the PS2K keyboard IRQ1 as ActiveLow,
> whereas the hardware is actually ActiveHigh. Starting with Linux 6.0,
> the kernel no longer auto-corrects this polarity mismatch on AMD Zen
> platforms, causing the internal keyboard to become non-functional.
> 
> Add the GM5BG0E board to the irq1_edge_low_force_override[] DMI quirk
> table so that the kernel forces the correct IRQ polarity for this model.
> 
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=XXXXXX
> Link: https://lore.kernel.org/linux-acpi/XXXXXX@XXXXXX
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Hackdale <445735441@qq.com>

Real name please.

thanks,

greg k-h
