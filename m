Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4A030AAA6;
	Wed, 30 Sep 2026 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752703; cv=none; b=PMOvSVVmuTIpr/eqsEn15tzcx5KzZljQGWmjffkrh5/anlu2/T0UVvaXO89xdeZuH/UBvk4ayLgl8a9rK7VOhhYTJ7/tw2kElhmun+1p1kR/5a9QaqH7AohAmFaA0IeOpKyP3fQG/6d+ZXfsCtogT3414Sf5xLNzTTuNkcCsdfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752703; c=relaxed/simple;
	bh=IRuEOvn+P9NHCXvDczeaEafXsgTlQgMT1brmBN6Rc4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia6uzAP/GJeRFD878z7a2J/8U3zxkTa/zQD3LxWp+SY2BXzhwhRd45drHzkz6ExYaImjNaOYl3u6go+pA9iBSA39z9k6h5a12JSvsxXY0QtkeCRj90IHzdvJqDaIvJ1QakWHaOah3iXMq89u4jZ2wEGqYdmAi3LBxRWTUHMfEbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UZuiItwk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UZuiItwk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F1D1F00893;
	Wed, 30 Sep 2026 07:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790752701;
	bh=MtnFJY5EgnbwSIEvDOkVYSWDANaG78dxOG4A0/caQI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UZuiItwkHcRgrQfoSYFpZ49VWEVjqjUF8ueB4EjfWpik5v/yJvhmzaB2JTVRqHsJ/
	 YxdrHSNhxkYSWN/myBU/pN+5eVQXObBSeFRVD8rYrfGjSksn5wbNBpwJ48f9x/yYN0
	 hFlX6OwU5ry74N+XYPWr+u1Mtlhq+zcbJp6Y7RcE=
Date: Wed, 30 Sep 2026 09:18:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vladan Kalaba <vladan.kalaba@gmail.com>
Cc: ovidiu.panait.oss@gmail.com, gustavopiazdasilva2102@gmail.com,
	error27@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: fix integer underflow in
 tx_fifo_depth
Message-ID: <2026093005-retouch-rockfish-ae3a@gregkh>
References: <20260922215849.16739-1-vladan.kalaba@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922215849.16739-1-vladan.kalaba@gmail.com>

On Tue, Sep 22, 2026 at 11:58:48PM +0200, Vladan Kalaba wrote:
> Fix integer underflow if tx_fifo_depth < 4 in axis-fifo.c due
> to check in axis_fifo_write() subtracting 4.
> 
> Fixes: 52ff2b840bc7 ("staging: axis-fifo: fix maximum TX packet length check")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vladan Kalaba <vladan.kalaba@gmail.com>
> ---
>  drivers/staging/axis-fifo/axis-fifo.c | 5 +++++
>  1 file changed, 5 insertions(+)

Did you forget an "Assisted-by:" tag for this?
