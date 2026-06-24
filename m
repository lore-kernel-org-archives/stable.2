Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9996226E71E;
	Wed, 24 Jun 2026 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291718; cv=none; b=gS4MY5hi/m+n2ZjbBqw4iphylUGAiucIEUSUoGaWmKxiP6kPMY3p4dxP+8YaVtNu3G7aGZ7xd+3IM25UmflxsmDvE4+Mqet6QbLyAMTBNQNSL06PxYAAUqYt1E8Zt/CGsDy49cIRX9FYZ2oa+daNlpWP8TcyrGIrt1ZsR8piI1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291718; c=relaxed/simple;
	bh=mG4kqmdJnkhWHZE+f5aO87axog8zU1qKaoOXCFnNm+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2Ain9OxQ9Ud+4c64h4Ejl+Axdoft1YDiTFu921jony1Yu86WOsmgW3igqTT6GVQsCStr6cP0bZV6blk2nAtSOZbQZDBA5qaqMQSrJ2R34DneVC2fyf7u1Xwf4tjbeGAlgUbO60gYpRLmJigK0hol6nN3tkEaF4/5z9Lg9dhzks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ULbq0g2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ULbq0g2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A821F000E9;
	Wed, 24 Jun 2026 09:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782291717;
	bh=JQQFU0Uj4J/mvgiMOlCqHxgkArpeIUmKsdk5kg7XB0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ULbq0g2cKsRQAPmuA54r489t5XzTOQLejeH6zBRkEYamrqVkaKVZwzydkFd1zPXMJ
	 o4qVnMBHPST2GRUasjobUVEZtapCSexe/Hc39GFdbQcnuTTGkusVw2rKESMDFduPlP
	 ab67dkh1Tgkfee+daI2ixgtmI2hgoD6g3nccoG3s=
Date: Wed, 24 Jun 2026 11:00:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wongi Lee <qw3rtyp0@gmail.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jungwoo Lee <jwlee2217@gmail.com>
Subject: Re: Please apply 736b380e28d0 and eca856950f7c down to 6.1.y
Message-ID: <2026062417-conceal-driving-0ebd@gregkh>
References: <ajuR7rZYU943EG6p@DESKTOP-19IMU7U.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajuR7rZYU943EG6p@DESKTOP-19IMU7U.localdomain>

On Wed, Jun 24, 2026 at 05:14:38PM +0900, Wongi Lee wrote:
> Hi,
> 
> Could the following upstream commits be queued for the active stable
> trees?
> 
>   commit 736b380e28d0480c7bc3e022f1950f31fe53a7c5
>   ("ipv6: account for fraggap on the paged allocation path")

I do not see that commit id in Linus's tree, are you sure it is correct?

>   commit eca856950f7cb1a221e02b99d758409f2c5cec42
>   ("ipv4: account for fraggap on the paged allocation path")

Same here, no id of that one in Linus's tree that I can see.

thanks,

greg k-h
