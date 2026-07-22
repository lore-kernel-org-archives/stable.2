Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5FC3B7B64
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784722121; cv=none; b=quk6fPk/el7OFAsUyHuYdBcFNRbyIrxbe4XOEERwXrc/35VjayEWbZRjiqzjxR1DvvrBUynx9SfdlEhxxlVg0o9bkR8A/ZHd6Y/sqEC83ScAjToM8f634s9+YP7CaUppjx98WLvKpW37S4gG5DoaGyaDrakNV4adW8rtYEGQ2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784722121; c=relaxed/simple;
	bh=gUEEyF2GqQ7/xgEKMET1joAj4ywfKGCPtSau56XMsyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQa9TbV8YkX3L6gtoyHAcOuPkT5C/xOjZkCOKwQN6duB8swimf8SEDvyhOVGrfXQs9Xq1/ARgbbFh4EssrxJivFacdT1F5Nlw6bf0lrXGXx9wfiLyZe5RwLl2/j6169/16FXFr2I7jxAVPJ7caNj0cXYOzmBjPMvrREpbxVrDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ga5qhV/c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ga5qhV/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEDA1F000E9;
	Wed, 22 Jul 2026 12:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784722118;
	bh=f6o8nYnPuorJqUswLW0EtUdtvrMdv2nfLF2vGHbBW1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ga5qhV/cdKeLkUzZ/C3PpAHln3F13Xk6sqdoUy9/OAmfRdwoDtwGvSTu3QRQNpnHw
	 nEH+JB7JygyutwKCPq0EhlvPbz5oWa4hmshjt6A1aRjgENlH62LkGEYISEuHuzj7d8
	 lIFPuv/i5Ciu9/e/CB0TV3RBgNiYJs3xmZLFp/f8=
Date: Wed, 22 Jul 2026 14:08:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: mkl@pengutronix.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] can: bcm: add missing device refcount for
 CAN filter removal" failed to apply to 5.10-stable tree
Message-ID: <2026072259-statue-cesarean-bb2c@gregkh>
References: <2026072041-silica-outing-8bb2@gregkh>
 <99ae6366-3d14-4a5a-bec2-d5c43930a165@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99ae6366-3d14-4a5a-bec2-d5c43930a165@hartkopp.net>

On Wed, Jul 22, 2026 at 11:48:39AM +0200, Oliver Hartkopp wrote:
> Dear Greg,
> 
> sorry for the bunch of patches the AI reports and review results created for
> the stable trees.

What do you mean?

> Based on the patches, the stable trees and your status mails I asked Claude
> to create a status table (markdown):

So you want AI to make more work for us?

We can't read this:

> 
> | # | commit | file | message | 5.10 | 5.15 | 6.1 | 6.6 | 6.12 | 6.18 | 7.1
> |
> |---|---|---|---|---|---|---|---|---|---|---|
> | 1 | `9b1a02e0d980` | isotp.c | use unconditional synchronize_rcu() in
> isotp_release() | OK | OK | OK | OK | OK | OK | OK |

What does this mean?

confused,

greg k-h
