Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBF7412264;
	Mon,  7 Sep 2026 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777911; cv=none; b=AH68RysJkuf0hnFBnWPBxkF5rtmqqdDRbmyvwKJ5+AHoq58n+RBecc297yrdvXYKAPHU0JmIRjD8PKJY0jDAuAzk7ZBw7xdjT7Ej1Laq9dPMYtCp1ibsukHFMy6StuAhzpHIiGbNo8bnJLVVcG2GjE/EL0dEGqiirbK5lqi83pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777911; c=relaxed/simple;
	bh=GgOqK2ftxVGqo5F5dGaYAFOyQu2ErjRl67FkwxVrs0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCD2MMxgH8YpctuKrxQ8wBz3xhWsxpYh5mBKOZPq+rc1tl8+XYPmybJy+TzZJgecVRmIUG6jWWijiaUFwAyKMfyblek0kIK9rL3eVwUYzKu3fNPbn2grsps/e3pVb5qwJl2x43BgE3lvmf/M1f8uMdF6glgypiOCBrLvPzJp89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=RI6Izzk8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gV42Ai7+; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="RI6Izzk8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gV42Ai7+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0DEB17A0125;
	Mon,  7 Sep 2026 06:45:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 07 Sep 2026 06:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788777908; x=1788864308; bh=+RrwGJfL3J
	uxaUg5J53rktsg4suPz5veslg2CafSxYM=; b=RI6Izzk8a8VYevx/T7wNgrK0Gv
	Mqm4P6KqDhbC+PamIdAnw8DbwJIfzUOj3trxOvgnzFLJk981dnPN+0+kwiUoQtGl
	igfMZZ/o3vYnnKRlEBGje/wBKb2MfJJIhzrGdtQralJ5J5SKQxsiTqr6sdV7QLb7
	QBrptEzumJpx5LZB6ABoJHKZYLiht72mwTk53x33QxWsx58uzA3iU2wHUMEZCGD1
	Ger+VqEIOyMSqI3hJTCu6QmjcpdKZAeqvh+06tKz+WwwtICNz2pYWzDJfpMRII8e
	0p0EjdUncqC2sqjXcGvi9D+TCzr8TxFu8DQXrvZE4heAGY9PBC6s6m5cE9bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788777908; x=1788864308; bh=+RrwGJfL3JuxaUg5J53rktsg4suPz5veslg
	2CafSxYM=; b=gV42Ai7+rTLZJ5Ae08Ut6m4kCu5iwp6ay7muN9b4Jtk2AHd2k/B
	OsacfRUG6H7aRwWTtrkRbbS15oZ5ddLWALDZcFF+nIRYeYFk9huZJxuvSCcU5tzn
	fCSqFsjeZcFt4pQlX1Wsuk+UdZo9/ESLYSvUq3V/S7ggpJYm0ZQ62vxHUd+S1mVn
	dFy88RdvdosyVfuZrfp2RWN1HsebtIL9z9S55zQ4YVMVEryClXfAIPWsrJaamBI6
	NSqMqeK1dsXmZ+FOvP6YFBN54N209cyK5j4PSJFKibythKWzT/sdVF8RHeFzyF5M
	Fl4aflVBobLNLN/eiqRoJNKGaiGikXXCqyw==
X-ME-Sender: <xms:tJWeakDlcaPHZcZdvYyo3YjSVNdNngmH6lN2Q9tpQ9jvleSgBOknaw>
    <xme:tJWeakyi7iQuia03Lnz0LZgxw76e4i4ulnMj8XAsxgvDfzSG_V8aUk_c3pq25RAMu
    sJENICowxc6Q7j5fuPU8fcmBd7i0qAR5AkBLGcEbojv3pJj9Q8cO_8>
X-ME-Received: <xmr:tJWeag6myZxgU6Ly4-lKvv36Ybkh6_Px38GNx_g9VaJEYpXfhPEx2qYTin9120TCVGhf6LkDY5cg6ClsnaxtoA5qvihWa9kxbCQ>
X-ME-Proxy-Cause: dmFkZTEpZ37bV4WAbkr9w4Sjl1i+LGHCK0Z5tw4Ea6D9Stl38OBgl43DDxBEw2rl4fcZbG
    HXqcdNArxZlhomcadAqdQKJfIjkOBSn1fPIRagr4/tpbZtNDxT6tEobXOqmKW1S+MX43Hv
    vmud5whkkkEPpT807XSIPSoyN/NlVUzVXepHgf4EyV5Gjo3CzoYVNrL0j9jxJtUIfju3IO
    6M3qtEB8S1Zz0OVDLyBrV/Wi+Q1YXS1czzm5+1JL5BH+faLFNWI4vPqjzAWZCh9eaj1O7P
    yQViG8ITIkMV+ytiviEt1DOuJ0nOnYiUxttDTFqqRozLuu3eCCLc/mBpQJP+bCuz4hGTa1
    27WAdTFhSItm4Mp9cmiQV3iRfbzlUxSqOP1C3Sk1t4v2sVE7Jzq76N4qXee3rc6RoYeXAH
    MBH6DiiOsG3tpGfbF1bPmNo5WUQOStVo02gnbnTK+LWCh1dD16hio1F6r8WUvuCtNh2Su5
    CYGpXxgxYpl/D/gwC5WhQz7xIsGCj76BHCUd/ydW25+V65CF5o7ldqjieWz4NhVk6c+vCH
    5cB615ht3Byb1mbUxvn4dZPrE1dDl+fgLvgIaHpEJAOoI2QTu4eP+ixQ/S9l5NK0Sxotlm
    9h7KPBVimfM9Rwk0SzuNo0Ut4plwgzXYBY+8vpYrMFGqr8v82aQAIH8D0mXw
X-ME-Proxy: <xmx:tJWeatwa2RybXBWUDvxZrCDiZNmJIbZzpx16Bcns5GDk210ezQbzmQ>
    <xmx:tJWeascyLbFdZ45Ay2VpeuhcHdibjaLg8fMhnWqq8crlIcgRZZAg6A>
    <xmx:tJWeaqDTgirLdwnxQ3s4zbukNzuYtP2UjRgLiIbl7FH7OBwy9Vzugg>
    <xmx:tJWeao4Up0PkgeqZv-YkQVuZRiG9_NheT807ib665Sa2c3Vg_F6sQA>
    <xmx:tJWearN8eNZ6BsTjmBS9CCeAOuPQcCkXu4ZXuhKT5JBW-BhfEq0gpiQo>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 06:45:07 -0400 (EDT)
Date: Mon, 7 Sep 2026 12:45:05 +0200
From: Janne Grunau <j@jannau.net>
To: Sven Peter <sven@kernel.org>
Cc: Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Paul Cristian <p4ulcristian@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/3] phy: apple: atc: Prepare USB3-via-4 tunneling
Message-ID: <20260907104505.GB2760037@robin.jannau.net>
References: <20260821-b4-atcphy-usb4-v1-0-45c0b741e0c0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821-b4-atcphy-usb4-v1-0-45c0b741e0c0@kernel.org>

On Fri, Aug 21, 2026 at 03:50:26PM +0200, Sven Peter wrote:
> Hi,
> 
> This short series first fixes an oversight that prevents USB2 from
> working when DP AltMode with 4 lanes is used. Then it adds the required
> sequence to point dwc3's PIPE interface to the USB4 Native Host
> Interface which I plan to submit soon to support USB3-via-USB4 tunnels.
> 
> Best,
> 
> Sven
> 
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
> Sven Peter (3):
>       phy: apple: atc: Support DUMMY PIPEHANDLER state in configure_pipehandler
>       phy: apple: atc: Factor out the PIPE mux sequence
>       phy: apple: atc: Implement the USB4 pipehandler state
> 
>  drivers/phy/apple/atc.c | 91 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 59 insertions(+), 32 deletions(-)

Whole series

Reviewed-by: Janne Grunau <j@jannau.net>

Janne
