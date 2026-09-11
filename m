Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB753C1D6A;
	Fri, 11 Sep 2026 05:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789106204; cv=none; b=PFrD3tUmvzvONUMmotXfkwoyNvQM+RibfYfQovzOLW6i4gLJQfyAFHLIySp0lRRUU49iG3/I6FFzXO7sfqLd2uf3Q3WmP5VLujtApQ5unG4wcI8AJrq20ka6322pMxT9F/1F8lyQoaGx81Hf3OPeC/ZUQWnlMMlP9f2cr1N3jmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789106204; c=relaxed/simple;
	bh=NLyemsweSeGvwJD2bH8uBZSUiejSEu6zAUNLISlN/o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6tIWTKFtTJ7nUbYjo8Hrw9sl7GwugJGuLAY1xG9hA5JVLdP/D+7lag+M596OWFKerD4Gn7frxSn5LSg2tt7vSNqfVaYsT3nIM3uhYDB9Gh0laPnCJhPmyenuzI6yKMKduLaOWgbXeGPjj1QWEYiFzdqQGvhpwZs+abm9RUG/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vKjlEJTo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vKjlEJTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90321F000FF;
	Fri, 11 Sep 2026 05:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789106203;
	bh=Vp2huifkj/NDkmsq+EpqpzNNB526u78XAPFimHwhQas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vKjlEJTo6BAmdrI+iSU2IObwGln4yTswnadtX6r3VsQseRG9xco7zhfbDrB1Xd9Xy
	 UaKSiXe2bLEZ6a8K3fiv6/B/H8vpaKxQeMRvke0fDb+iSDt2F6/VAKNPAe2IeUFOOr
	 L0QedJrOXraUz25/i5szYudXIOD8QwyzUeezHS3Y=
Date: Fri, 11 Sep 2026 07:54:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, bleung@chromium.org,
	akuchynski@chromium.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: displayport: Fix OOB altmode array
 index
Message-ID: <2026091139-spindle-zodiac-2342@gregkh>
References: <20260904234401.2339633-1-jthies@google.com>
 <2026091023-numeric-husband-1b03@gregkh>
 <CAMFSARfnRpkq21j7WZYqdthy4aC7VSPjQAKm1eHvbYxhM6pOnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMFSARfnRpkq21j7WZYqdthy4aC7VSPjQAKm1eHvbYxhM6pOnQ@mail.gmail.com>

On Thu, Sep 10, 2026 at 12:52:34PM -0700, Jameson Thies wrote:
> Hi Greg.
> 
> > Does not apply against 7.3-rc2 :(
> 
> 7.3-rc2 and usb-next include the v1 version of this patch which fixes
> the OOB issue but doesn't incorporate Heikki's or Andrei's feedback.
> I'll send a quick series to revert the existing change and followup
> with the v2 version.

Why not just a fixup patch instead?
