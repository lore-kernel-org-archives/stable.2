Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F303603DB
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 04:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784090804; cv=none; b=Xiv/BHU8zFvZ10CO977NB5Aj3K+a9EljmRTHTA4T2fxGV1G4dCL6pPRAe97XOgalRCtSEFtkH9j/hA0zSqQNi7Ez3vsPw8NhlYN4xG/Ucb8UUa6kbHZJop1RDRtXsrK+GTMEz7m7xPat+3sIMBGmxfggzwaUhjsfyKGhWYqyEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784090804; c=relaxed/simple;
	bh=jY/BeOxBb5fV1kgcjRS/xmlBjYHJVOAXMwEIqs1IT1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuF3IZNJSkXj0nHIg2QmDG3oK4SYLCAHFuNxLR8Eym6DDsn/0O33sGQDps69R3MzK2IMN268uPgeCX7gwLerkWAtJRx/bj1KoAc+qLpoJXvI+HLBEgt4LqhDDg+CaXAkAlrw4lhzfJJO/Vw/3m9R8kzoGLN65sLhGHzVaZ2ijtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gwNwi5ZO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gwNwi5ZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD191F000E9;
	Wed, 15 Jul 2026 04:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784090802;
	bh=ocsijGN9KEQMu0zf8iIykb37wYZKngOKg+5mySAYPRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gwNwi5ZOJEKv69QGQFsdGb877trzzGolYUwEYrdPromBpnGlzUa3ghlqSlkrZo8d9
	 gcreS1/zhgGFMzOU8yM2ZYwwa4lgN0zAjl2Zh4Zz2kkoiG9BHFOBw8nsKAcLcCJr1h
	 IaIW6D8K9KH7bz99n3sgPe3h4MWUX0rw9bAPYYAg=
Date: Wed, 15 Jul 2026 06:46:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Cc: linkinjeon@kernel.org, stfrench@microsoft.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] smb/server: do not require delete access
 for non-replacing" failed to apply to 6.1-stable tree
Message-ID: <2026071515-dutiful-anthem-39fb@gregkh>
References: <2026071409-clamp-reminder-aacc@gregkh>
 <b5901dc2-0d5c-45ac-a817-81e2a3934131@chenxiaosong.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5901dc2-0d5c-45ac-a817-81e2a3934131@chenxiaosong.com>

On Wed, Jul 15, 2026 at 09:58:10AM +0800, ChenXiaoSong wrote:
> linux-6.1.y linux-6.6.y linux-6.12.y linux-6.18.y does not include the
> bug-introducing patch: 13f3942f2bf4 ("ksmbd: add per-handle permission check
> to FILE_LINK_INFORMATION").

Ok, so what does that mean?  Can you provide backported patches for
these branches?

thanks,

greg k-h
