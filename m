Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3720475801;
	Thu, 23 Jul 2026 00:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766097; cv=none; b=A2ItCSCNRmI76VgKK/R7cE+hfb+6H+RRGJgBGQgZgcxwa/J94p5kXsYC73giIykLL6IqXkAAtrA/lnLZEgoWaDNqfZk/IXNEqBk6nXo+obEZg6YNufdOU8M313NWQ8EkLAao0aLTtrsH56ZBn6rMEJ3pwaHtVdaX4v6asRXtzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766097; c=relaxed/simple;
	bh=5t+tHWradOrvzkv2dC4BCRsprp3AQKyOhgcD2qvxbv8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pWiN5hR4uBg2LS1wa7UI61aIf3xNozJWQPL7ve1I6j23lS4X055xiNnsksZrSkXvNKCKtVEi6NHLxXN60vfRqYFbendiysFy657uq61EkvkEI5rgv48XIsEG4NGW+hJt/rhKOEX4z4KvQgDnVkQvKYBwCkdzgPxSGhaVD9fI2Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uIVxLcRD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uIVxLcRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AC31F000E9;
	Thu, 23 Jul 2026 00:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784766095;
	bh=sDrL8FMXbZiGN7TBbHyj5Xz5dUBC09M55KWiqBhsNAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=uIVxLcRDp8gAeu9Sfx5IujgvLnDG62tQkxaL7T0dlYTz3nehhFq5XAzhJF8Z++OxH
	 TxD007ZFH4IseeYjZjFy2QtAw4RKeRdVWfLLgdwYOPeLtIvA21CjvyWnPYYsdMjUdZ
	 iNqATuhbJFP/1h20Wm68QQ8OiqX+VKQwtTCBKjbA=
Date: Wed, 22 Jul 2026 17:21:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: James Kim <james010kim@gmail.com>
Cc: linux-kernel@vger.kernel.org, mporter@kernel.crashing.org,
 alex.bou9@gmail.com, dan.carpenter@linaro.org, stable@vger.kernel.org,
 gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] rapidio: mport_cdev: fix use-after-free in
 dma_req_free()
Message-Id: <20260722172135.4fb1e64ce415fb6b8d1d1b59@linux-foundation.org>
In-Reply-To: <20260615070530.371640-1-james010kim@gmail.com>
References: <20260615070530.371640-1-james010kim@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 16:05:30 +0900 James Kim <james010kim@gmail.com> wrote:

> Fixes: 4b0986a36 ("rapidio: add mport character device support")

I cannot find this commit.  I'll use

	e8de370188d0 ("rapidio: add mport char device driver")
