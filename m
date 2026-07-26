Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC19D42A82;
	Sun, 26 Jul 2026 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785085486; cv=none; b=Xwbgsu/k88qbhVDDsfoF0ehoSe3BhE/C4eZjyyYNk/zTBwJ8otmYUdF7HFv/egq1Zym9p291EOh96RSbGNOuNHKq0R9imnP3F+1L9IOO89+HvUh/1fAoo6yCaQknq0FKdrgJ5PlF4TM731tIVAH5UM9LU+pbHY751VmaW28t6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785085486; c=relaxed/simple;
	bh=YFMIw/TPyPoSBZxKvVXS8rZUgbCbpJEq+Rc/rtkJOs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVdY3BmZT6ORlTqsTGZ7UIVLtJMmBA1/b1d2IlFAyigwZs1Botn/UXBnUjmPwYkMMEhHSBxye1faq+SqaWfrxg557UGCo150H1+z9TZyNrjRpkVQaYbcGYBBlo/1l38RKB/a4uWbc8Rwo9mOTtJyBAqyJY6MvJYt0XlhnuAnEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r5Fq4FoL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r5Fq4FoL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jXMI9BFQiG9jlQ2l2fyxcmN4VIAxwDIQSn0+S4DOkG8=; b=r5Fq4FoLJI6s85rn3iIRETAGqj
	H6lnYoV2BbqJ/0mQP/SyvXuFUYkNyPcF0Tx1cVHeBVTjKvif910IJA3fz8iyIscJI2tczdtQd85l3
	G4oSnhwE7ylNHAfJCNG/wUYQ/7fHJY7uDmPTXfXUaa6X3wmP5TInff7auWprHgeOMsDI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wo2HE-00EJYa-1e; Sun, 26 Jul 2026 19:04:36 +0200
Date: Sun, 26 Jul 2026 19:04:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Baul Lee <baul.lee@xbow.com>
Cc: netdev@vger.kernel.org, linux-x25@vger.kernel.org,
	linux-kernel@vger.kernel.org, ms@dev.tdt.de, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net/x25: fix use-after-free of the socket by its
 timers
Message-ID: <1fd2d181-6915-4cf1-84e7-cd33ee210275@lunn.ch>
References: <20260726071808.47781-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726071808.47781-1-baul.lee@xbow.com>

> Verified on v7.2-rc4

Wrong tree. You are posting a networking patch, so you need to test on
the net tree. Given how users of AI is finding the same bug in
parallel, it is very possible this has already been fixed, it has been
merged to the net tree and you are wasting our time.

> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>

As pointed out elsewhere, drop the reported by, unless there is a
public link of a real user reporting the issue. This is to give credit
to the person who spent the time to write a good bug report which
helped a developer fix the issue.

    Andrew

---
pw-bot: cr
