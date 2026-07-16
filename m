Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE20423E98
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207679; cv=none; b=E0ESXtPNP7oKKF2Lk/PgZfDzy5OvNWVxUo4muznSVFF4npaLIWP1Po1dGfkAnj0gGOSPWpM2MSpl2zWGcGHwKehy/QAH7fIQXGwJ/ZAUg1qO1XnwiM7Ad/mkPfEd0cVdD/KPWwC9z1eAXH1tg+bguqBtF8EyErsTTi5bXKuCtbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207679; c=relaxed/simple;
	bh=JAoWNzpOOc0xKrjrlqVuYH+zpLf64fzoQgMSGMxplqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkm3oasm78bmlzVL8iu76IFDY5i70Cgl/MzQfGXOU0Ej/6/3sjLMv9a1g28S4WpE7g4VBpxzmpCzHUtfCBEChRnIY4rIm+9d4bmGoscyBXFlx3ebWaB1u71KGwfP30CF1/wIM18dGiEeDaIrj6ipkoeucvQVeiS70olpjieHsvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WlWHrqKb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WlWHrqKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C7D1F000E9;
	Thu, 16 Jul 2026 13:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784207676;
	bh=JAoWNzpOOc0xKrjrlqVuYH+zpLf64fzoQgMSGMxplqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WlWHrqKbDMPN40+FHoCt2bxZ6qi0kXqUoGECecRMkwqU2ntHMCP4cdZjbtHep9gYK
	 +zKAgn//GCzPeRSy7keX6hBGsB32s/22FmGijVeVITCb5biKdx5g2RHnhTZDICc2sT
	 Qkgt8KGCD8TSmwicn71yn0Sc91BtE4upuq7MmjaA=
Date: Thu, 16 Jul 2026 15:12:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Erwan Velu <e.velu@criteo.com>
Cc: stable@vger.kernel.org, Adam Li <adamli@os.amperecomputing.com>,
	Peter Zijlstra <peterz@infradead.org>, colin.i.king@gmail.com
Subject: Re: sched/fair: Only update stats for allowed CPUs when looking for
 dst group
Message-ID: <2026071635-goliath-clamp-5cef@gregkh>
References: <d4ec6ce9-7c08-4c76-89eb-7bff345d397a@criteo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4ec6ce9-7c08-4c76-89eb-7bff345d397a@criteo.com>

On Wed, Jul 15, 2026 at 04:29:09PM +0200, Erwan Velu wrote:
> Please backport commit 82d6e01a0699800efd8b048eb584c907ccb47b7a, introduced
> in 6.19 as all stable kernels are affected by a significant performance
> issue.

Now applied to the 6.18.y tree, thanks.

greg k-h
