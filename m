Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4879407576
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542111; cv=none; b=EIC2J5GTPxIemT7iYWLxsnqfAbWf6E9jLo/Ca83pnXtg/Xuge4iJE9o9UYgnRb1vmG8yK43GAbBKvu0b/7M8euMHcStBwprGd+TSwssaJqDnhMdPbwd5sZjtjqq639PA5RKpj+qLMEZtFcOHHoKxlXVE2g2MyXNf83DWDSpL4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542111; c=relaxed/simple;
	bh=6ci9UZv/7sLUIT9xs0kssxjZuB9QNhMlDzqw+dicRbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhXLDu3T168DWA0qK2wQ7F9KF5FCG+od3WxfO9LW1Szo+hiH7XB6JlhX21ETVTLPpKqeuv5UebP1oYvr6xqyYOMUaU0+puSI4nEoLfxyAju6IWRyggkFYmddgrPWGpYy4A/scceVR9P6pNad/SB0pkRjPhO72BOYNTSCtUUBRs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aWpQfsxW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aWpQfsxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969751F000E9;
	Mon, 15 Jun 2026 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781542110;
	bh=nXnRO8anjVVDZpkfEONBSfAJFDqfBhT91S9VPEMUj08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aWpQfsxWAgYrsZMjq7MjqxGAsV/rI0FBRkJPadWhixg0uQbyh6FSBao2q02WSflqg
	 Kdq4UNm6OhOqogY/nibd+TGtppr94sgCADuO05VqpUyOvdYG6TRbN9oSXu9mMelDPq
	 T5bsvQGqLQShQGOvp5ETRWsPqxzQsMJn8ugNfwac=
Date: Mon, 15 Jun 2026 18:45:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: stable@vger.kernel.org, sashal@kernel.org, brauner@kernel.org,
	jlayton@kernel.org, w15303746062@163.com
Subject: Re: Please cherry-pick commit 00633c468382 to stable
Message-ID: <2026061545-clubbed-uninjured-1c18@gregkh>
References: <d161697b-7c51-4ad7-b697-7ae3a3a78b9b@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d161697b-7c51-4ad7-b697-7ae3a3a78b9b@stu.xidian.edu.cn>

On Tue, Jun 16, 2026 at 12:19:13AM +0800, Mingyu Wang wrote:
> Hi,
> 
> Please cherry-pick the following upstream commit into active stable trees:
> 
> 00633c4683828acd5256fa8d5163f440d74bbe71
> 
> It fixes a SOFTIRQ-unsafe lock order deadlock that can lead to a remote
> Denial of Service (DoS) via crafted TCP URG packets in fasync signaling.
> 
> The patch applies cleanly to recent LTS branches.

Now queued up, thanks.

greg k-h
