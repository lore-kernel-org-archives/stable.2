Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD113290D1;
	Wed,  7 Oct 2026 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791414538; cv=none; b=TF1M0Vt36b+y8B4XZFWdleQvYhZl1AjrWMATCfQ1JMrpvsfa3rQ7IGUQW9QZh60+t6BjxTrfftqeTcGXwBA5y0quDFOJUnI35+oGE2wlqHPTxrv4EpFLsJRNnuhTv/PHd/nmie5iN8bxLo3JldnAS68J6/isAjOe0VtPByA2DJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791414538; c=relaxed/simple;
	bh=QlMvk3WAkYAJOlXJTBsxKwYenu0sNmCmDZMh+tLKc9k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XezEpHlDv9ICeLdFZ5DrUp+n1sqOOFeLfI7DnXpRt+qXU93cAiI5/2yLhmT3DCgmjazPVi/gEwdYZfb26E4rfeypoYUrNzOQPelnMB4Wr2HwFqynD/zjVNxPyK/omrI+TLnes+shrC54H51Vg+DyTHLVpDpI5lpBZZUf8IZ7od8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qJH293Af; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qJH293Af"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F12F1F000FF;
	Wed,  7 Oct 2026 23:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791414536;
	bh=ZXsBdmBma5sHcEMaXSiQjGo4Oq5zzhH7jT6NiFei8H4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=qJH293AfPHlJ9RFMwW94bLAXAizzWga3IPXRPVoLt/vbzknP/FvgcnE+h/P+C64nH
	 HIZeLoQPuqFqm1pNYy4o2olzoOtA4y40/VRSb+cqawmtKXpT7Op6ujVTE22b1eZg+p
	 iFzV5IInr7BTbJlZZYIcux839oxVxvAP9baQuKkA=
Date: Wed, 7 Oct 2026 16:08:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: LZ <lzsx618@gmail.com>
Cc: Armaan Sandhu <armaan.sandhu0504@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] lib/cmdline: fix get_options() count and overflow with
 large ranges
Message-Id: <20261007160856.c97b2d48db0fea0b3744d6aa@linux-foundation.org>
In-Reply-To: <CAGD6qbSfTmHq7Y_jM7-QS26at=w6OQwfOZjCU8n4PnnFmqgDNg@mail.gmail.com>
References: <20261005213945.359905-1-armaan.sandhu0504@gmail.com>
	<20261007150007.c7c6f2a4e41fd9f950c8427c@linux-foundation.org>
	<CAGD6qbSfTmHq7Y_jM7-QS26at=w6OQwfOZjCU8n4PnnFmqgDNg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Oct 2026 18:01:08 -0500 LZ <lzsx618@gmail.com> wrote:

> Hi Andrew,
> 
> I came across this issue independently while using ASan and UBSan to look
> for potential vulnerabilities in the Linux kernel. I do not know Armaan and
> have not been in contact with him, so there was no coordination between our
> submissions. The timing appears to be coincidental.
> 
> Regarding the KUnit changes, both patches add a test function named
> cmdline_test_range_overflow, but the actual test cases are different.
> 
> My fix focuses on preventing the index overflow in get_options(). Armaan's
> patch additionally handles overflow in the range-length subtraction and
> corrects the count when a range exceeds the output array's remaining
> capacity.

OK, thanks.

This is the weirdest thing!

> Based on those differences, Armaan's patch appears to address a broader set
> of related issues. Using his implementation as the basis, while retaining
> any complementary regression tests from my patch, seems reasonable to me.

Great.  Can I add your Reviewed-by to Armaan's patch?

Armaan, can you please check the regression tests, see if there's
anything to be incorporated into yours?


