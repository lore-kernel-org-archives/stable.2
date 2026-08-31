Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278E43E557B;
	Mon, 31 Aug 2026 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177456; cv=none; b=qiU4IKS0LbqfTkWdFvzj//m7XTYxFJ5fUqCi/bdimK74WBZt0/JIcqxjvWy+mBd1g1R/7U0wvcNOSbnmEq1JEg/Eu9Ji3Q4oulo5vq3M+DOxYQNSlZzXdBZLI38vQ4SjZJSI8ixdUW+ow3QZUdwgiJ7EEFpxTIoIYe8L0hPlXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177456; c=relaxed/simple;
	bh=DKcd3qP5aTbb6xzcZWi4DE81YdIlR6DchWbe0l64JC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjMG0ZtwgQeg7y++vkh4R6Wr5Mzy679QfWWn7VWe1PvAOtalj+Vkk+wP82gnIr/ltNSA2s1vNZJE8z0cptJqZdFL/+5hGTTxEV5mlHZo5bzAoTSBh8NUJM6l0MrmwS6S9THDmK3C98/W0UmA23ceEJvpCaCiie257OVmY/QUvBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bnw60PBE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bnw60PBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A131F000E9;
	Mon, 31 Aug 2026 11:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788177454;
	bh=DKcd3qP5aTbb6xzcZWi4DE81YdIlR6DchWbe0l64JC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bnw60PBE826dBDUjT6a+KmUm/Sm3W4vGrj6tQzjfenA3paEWBf41bTW0LbCZn9Fd5
	 +m+CCbzpa/w0S+vOL2b4wFKFiiuHmEfnTX/rnSPN51Z15L4Lzv/tMPx1YcGObdHIJ5
	 GIfRr7dI/ON2RmH1bE8hbnWeNZHzZVims6C29r5s=
Date: Mon, 31 Aug 2026 13:57:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexandre Bard <alexandre.bard@belden.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, justin.iurman@gmail.com,
	kuba@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 6.12] net: ioam6: fix OOB and missing lock
Message-ID: <2026083122-chalice-shading-bb56@gregkh>
References: <20260825140732.220188-1-alexandre.bard@belden.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825140732.220188-1-alexandre.bard@belden.com>

On Tue, Aug 25, 2026 at 02:07:32PM +0000, Alexandre Bard wrote:
> **********************************************************************
> DISCLAIMER:
> Privileged and/or Confidential information may be contained in this message. If you are not the addressee of this message, you may not copy, use or deliver this message to anyone. In such event, you should destroy the message and kindly notify the sender by reply e-mail. It is understood that opinions or conclusions that do not relate to the official business of the company are neither given nor endorsed by the company. Thank You.

Now deleted.
