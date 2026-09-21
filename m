Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAF14963D2;
	Mon, 21 Sep 2026 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993094; cv=none; b=qoQP4ROjAyQV8JhYawtROgVe/4fQAy+4AOOuYgkMOvnLZ2sLFeIYfAp3ZJPSbH1+lgIGSL2pRH2WqIBow/qzJT19Wo0V556PFR/mXkcaOZrPNqOR2VFlZPpU5QPs/jWBRNvXuZ0/GAByiJ2i0SKctBzeOQWhqjNzaCnp7sWq9fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993094; c=relaxed/simple;
	bh=Sbn2uEgpIS3SsSMIhAEvouD2WRMXJ/ObifdBHQakeF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l35PXJkGRHkK3/tWegesA3bRmnODE89Tf9qsazXletJlTd2RaVLvyi1Bz0qARuaR78QKMr4Xu3pxNTB7U54N8FKwLWTDqGdqusmAtcQnp2V1/POyN/N/akbLMUV3QkMtO70apIdkaewCfdwYWqcarwD0z+b7+WFEBwMIoZ3dCo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m4Gc+8Wb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m4Gc+8Wb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC8E1F00899;
	Mon, 21 Sep 2026 12:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789993092;
	bh=5chGrERlO2JNtoli6TVR+2hC3D7Ro/hKBKe4Ig2fTuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m4Gc+8WbhMx3kjj7myVNcyW4eJyefQYnDR8akkiblmjrFGl6mzATLDmZsB07Jxd+W
	 6r7FRMAXWBZT9Jx3GavyVc724XLDcA82glLPX/ktt11yQls1VMJvT/forufU9otmq/
	 s5ILrt1xH7SvlOye608ik3thcvajO0Cz3I8kNUOM=
Date: Mon, 21 Sep 2026 14:18:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?B?67CV7YOc7ISgL+y7tO2TqO2EsMK3QUntlZnrtoA=?= <ts930@dgu.ac.kr>
Cc: Hans de Goede <hansg@kernel.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix buffer overflow and OOB accesses
 in rtw_check_beacon_data()
Message-ID: <2026092142-awoke-bacteria-94d9@gregkh>
References: <20260921073730.83679-1-ts930@dgu.ac.kr>
 <2026092127-rigid-anchovy-3aa3@gregkh>
 <CAFPGN2jhZhPW1zeJc9f7OjSYP4SvvCi1uVf3uG=fddiKiF7Piw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFPGN2jhZhPW1zeJc9f7OjSYP4SvvCi1uVf3uG=fddiKiF7Piw@mail.gmail.com>

On Mon, Sep 21, 2026 at 06:12:13PM +0900, 박태선/컴퓨터·AI학부 wrote:
> > How did you find this?
> 
> I am a computer science student and I have been studying the staging
> drivers to learn more about kernel development.

<snip>

Please respond in non-html as html emails are deleted by the mailing
list.

thanks,

greg k-h
