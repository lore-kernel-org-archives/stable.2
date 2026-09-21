Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269A44AD4B6;
	Mon, 21 Sep 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003678; cv=none; b=tIWXZTbYBnpK9wxUEoxMtKMExpCXYhwD7swminla5gF/HvoyI+BMUB1wcN19YPbCq9X+i/qHujurN2ASwnKOfMQjJxcQ2X4p1Zv8qqagA99/uDGeAJAVmq4sVp7UAY24SJuC9jBXGE89Z5/69fQojHImQJUbUIF0YDp9lclln1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003678; c=relaxed/simple;
	bh=RWwf8iC50Nu4LxiSioY3uxZC8w0VZhuL7G2pvQRCisI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXq+csAxiM+jlGk0OtZ2oShXEIlAcZTSXzQarXfB8iGXwo+/Haw5Avzf7lVHeTsopXWEzJSwxtnFpnWV+1Li0jBf9OdwS0BuY/HtwrSUBc79pi/MS/xkyyeXOi+dVA+sU6IIwuARHvWKCghMLdN7tJW5QV+nyF6UQFLpRAGOjKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPEQnjwE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPEQnjwE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A97A1F000FF;
	Mon, 21 Sep 2026 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003677;
	bh=boqz8+PMF/1ue5GVjdouEJlWwh/LXzBm76HZYxfbNwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gPEQnjwE/pqD8QsFE7EiHsCpXAreNNniFVyRXSeooP24KBsjPTV4VCT0YS0W+t66c
	 0NYVsuSmJZJCYlluxhBIMcWtOpCFHYEw5c0shyEyqt/T9Vi6pp3F9RvA3XhzJ29ZJQ
	 9r2863WHnY8BL6aPFvVJbm/iHOvpgCF1wSG6YG3pYDegxDaYKycy15SWYrw0QyRaIr
	 YSukzi+lzH7t112dXmxKtR61lq4GA0UaZqLXUPnEAYCghPvCJZTdr8JpAH4iOn8WHa
	 jOVPffI8hpY+uAsXuIlpMnFes8nkqXWgpmowc2/VHK86KwvRK+PlKO9ZxZVvB1IO2w
	 leW2pGjbkX9EA==
Date: Mon, 21 Sep 2026 17:14:32 +0200
From: krzk@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-wpan@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch, 
	edumazet@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, stefan@datenfreihafen.org, kuba@kernel.org, 
	miquel.raynal@bootlin.com, alex.aring@gmail.com, marcel@holtmann.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] ieee802154: atusb: Fix URB reference leak in
 atusb_work_urbs()
Message-ID: <arFJ1_Cc1EmgAyHS@quoll>
References: <20260917114821.2149704-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917114821.2149704-1-vulab@iscas.ac.cn>


On Thu, 17 Sep 2026 11:48:21 +0000, Wentao Liang wrote:
> usb_get_from_anchor() hands over a reference to the URB, which the caller
> has to release. atusb_work_urbs() never does, so every URB collected from
> the idle anchor keeps an extra reference: the reference count grows on
> each retry cycle and the URBs are never freed on disconnect. Drop the
> reference after a successful submission, and after the URB has been put
> back on the idle anchor when submission failed, as the HCD holds its own
> reference while the URB is in flight.
> 
> Fixes: 7490b008d123 ("ieee802154: add support for atusb transceiver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ieee802154/atusb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof



