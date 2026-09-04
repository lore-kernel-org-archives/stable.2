Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87A148CD55
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539967; cv=none; b=Z2sDXbh9B+pTuMELxmlQTO8w94Gy/iRmSJMObzNJ79kkCidoZE1s85u/TwN27jyCYXZiMrxsmfaab71RbLLo6PJrHv4mVhNmf2Cc72TX28CXS23nQ6kQRAflW7Yo7A1DcOzNe/36MalLLU9bIVIQJTMxzs+OEW7sjPpVKNQ+URs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539967; c=relaxed/simple;
	bh=WPnS+oRfyctCrPxOBkUbfOQpVgY0L8SRlIPOllWyO5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDNZ9zrI23YDJTBbj1IQZyUD8vr7ssmso4rUnFptFnE7EsIAg/xKpwoaHhFRIDByBwDoep1YCScfBGhN7QPFIsEe9mQS7Hd2qWCKLhOuXDxst6OV5dpUUOiBby6SH5zmZwvYcXunB45kpQcp8GDjCSG+Y21eftPrtRjvxyLvy88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UPKpy0Pb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UPKpy0Pb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767731F00A3D;
	Fri,  4 Sep 2026 16:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788539966;
	bh=AEN/BTuDnqInfaPya9WwUjv6NknCSuZ4Gn/ZcoJ1p0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UPKpy0PbAbbAwBZcTIqO7xzTv5ZkuNvoSn17pnJPsWSlgeOL+WNkFIWEw3qXiuHsX
	 /QuuZ3LG2tqKN+xBU8nKdkMZr49JFkxwj9N5YdzsDwNgRHG+3cSildcQjemhjkvEQ7
	 SZRS/xvtClLCc0aF2fqJ299iHze5qxjoh2AxUVl0=
Date: Fri, 4 Sep 2026 18:36:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
Cc: stable@vger.kernel.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	brauner@kernel.org,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Subject: Re:
Message-ID: <2026090444-conical-carbon-be59@gregkh>
References: <2026090317-trapped-overload-3e96@gregkh>
 <20260904154240.68162-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904154240.68162-2-gnoack3000@gmail.com>

On Fri, Sep 04, 2026 at 05:42:41PM +0200, Günther Noack wrote:
> >From f4c2168991ca1b1f4a1d00e755f43621f2ed89d1 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
> Date: Thu, 13 Aug 2026 11:31:53 +0200
> Subject: [PATCH 6.12.y] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for
>  whiteout creation
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> From: Günther Noack <gnoack@google.com>

Something went wrong with this submission :(


