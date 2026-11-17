Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794901363;
	b=in/3Lowwbe2Rh+aTg4AnOI3qUqLPP1l2BQWq7ET0/SWWwcayVUc8Np66CgYaFCBEgXUT
	 c9u8TfR33+uzo4RCtaYlaI8+Q5DpIvuVySRd4UHmbCWc2QFt7Sos/Rs/kD1QP/D36OICu
	 7gFtzXKQ+igpIhJ3wQdEKrSU3deS3udCv4dJjaZGBvg1MXUdd5V068VPL1otuAPtSNJjS
	 E4u85T4erC6vD9u4HSGK4xJ5aaqi+ucNkwxyFoVuBOGTnYCfsPtY8r/zdEcPZ+V8gI12F
	 j5SIP5iisZmPRsdFP8wA93j61oWpU2Y+sIrN761uJ9Z9nIuXsdK0+HKK6sL11e+blPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794901363;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=71rWNQosyZapuLeWqtv0uoV+azwsO/OtRmOKGXRa1s8=;
	b=Iu1A4hPWkpsBWELOnP8pdYIsGLZv3zdbSydJiuqwACE2S9ZiuJNiE93TmPHBsS2ZpRPr
	 5r0qzw2Ewq4FvRS/D96ak3bkIUfAx8us4mXupst493Ar/O+q5uG3WyNXvpK7yEGl98CKJ
	 xCFQxlmqxTbO6s7Thlibl9PR2NGeLbE5YkYxOSho4Udw0l9XhkY5mJ/K/fhqhDYQ0eMaL
	 PstjP6Ko2e4ChlkC2CeAou81umZNYA4XkZYCwFgPT7DmAQFID+2AOwngJ7If9YcELczVu
	 07OG6BgnOXAymlQNeimDIQ9LnIFSFxFihVygoWTx3eQPItNqAL7pbUcGEigUegIXTUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qX1QkTb5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64041606A335;
	Tue, 17 Nov 2026 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qX1QkTb5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF5F1F000C4;
	Tue, 17 Nov 2026 07:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794901362;
	bh=71rWNQosyZapuLeWqtv0uoV+azwsO/OtRmOKGXRa1s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=qX1QkTb5QYz4/deP7nXKDmeZM4uDkb5szhFlh33pXNEC2X7H5RJilBy/iG8B/GBAk
	 Z3PUjBXccqCV1zdIBFXKWganrW7Fwok69Yxv3IGBlGh7lVEeLCGhnBAD+A9xGuhiS6
	 5JaPfyX6yFs08zSvsy8yFka0Y0SVupQu5f4yaTMs=
Date: Tue, 17 Nov 2026 08:42:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	Yufan Chen <yufan.chen@linux.dev>, dev@rebasedinc.com
Subject: Re: io_uring/eventfd: registered eventfd signals only once after the
 cd305ee3633a backport (6.18.y, 6.12.y, Ubuntu 26.04)
Message-ID: <2026111722-unfocused-ride-065c@gregkh>
References: <oMhla8VwCWoihfrmgn8znIy60W1QXI8g_v2OyB9i6sWESIDlVJlwoGGOLylJgIHRARNoieXUVRGqzeB__KvHMdXgnCfPPovs8vLMOzaMPEw=@rebasedinc.com>
 <draft-agent5-0001-re-eventfd-signal@kernel.org>
 <5d92861f-9a4d-4810-8700-b9e457ed9c86@kernel.dk>
 <2026111605-deskbound-clobber-a4a1@gregkh>
 <07947062-2974-4630-90db-1556e25b50bb@kernel.dk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07947062-2974-4630-90db-1556e25b50bb@kernel.dk>

On Mon, Nov 16, 2026 at 07:21:38PM -0700, Jens Axboe wrote:
> On 11/16/26 2:52 AM, Greg Kroah-Hartman wrote:
> > On Sat, Nov 14, 2026 at 11:12:40AM -0700, Jens Axboe wrote:
> >> On 11/14/26 10:42 AM, Sasha Levin wrote:
> >>> On 2026-11-13, dev@rebasedinc.com wrote:
> >>>> If this is correct, a backport of 04fe9aeb4f3c to 6.18.y and 6.12.y looks like the right fix; it keeps the CVE-2026-80920 fix in place.
> >>>
> >>> Queued for 6.18 and 6.12, thanks.
> >>
> >> Yet another bs CVE - Greg, please invalidate this one too, it's NOT CVE material.
> >> Getting a little tired of chasing these.
> > 
> > Now rejected, sorry about that.
> 
> Not sure how we improve on that, it's really annoying to catch these bogus
> ones after the fact?

How about we make the "rule" that we don't assign any kernel CVEs to
io_uring things unless you ask for us to?  We do this already with the
xen portions of the kernel, but it requires you to remember to ask us
for an id "manually" if you want one.

Or any other ideas?

thanks,

greg k-h
