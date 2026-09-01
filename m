Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310F94756C5;
	Tue,  1 Sep 2026 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277865; cv=none; b=cgx5qw9AfHYeWwVVSwzZQpXnuffeP5hymEDpwdbMkBqceogWqNBbvsJ11W5CyQrn3A3eoPMj7VXgIJxVUjlK6kF72yD5tvk4k/jo8jExoHPLoJ6UQTTOdM5sre3rfvQaT6JfvFICfnwHV7DMudGXZFOpB01AyfUbB3m+Ls7KLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277865; c=relaxed/simple;
	bh=ToHThVCDySstnyKF3NFwJU+zE3/A5gRpQSuRB2GgglQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utHeZvMMUENYzPfYqVAMG0jjF1V/WGaMeuvpF8hWGO6+Y+KxV3CKvj4EERvzz/6q6bgryvvfv46V6BUeXfQDAplvC8jb2njGd9IWSamAS1PUYCGsiwj4GEsgEgnVvyqbc69my5+8j0vvTgweTzYUZv3OFPkRFORAecRSkTUBDNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2imAX0w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2imAX0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088A41F00A3A;
	Tue,  1 Sep 2026 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788277863;
	bh=86mz1zBsYJxYteYGY8/eiNb9ga64XB5+yp9k3f1MioI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S2imAX0wctuwrlBoB2YOBqW+QwFJkStnuidRDR9kZWVdHWMGwi3GhGLSu4hIpvA90
	 I+qHX04AA7agqM6v3dk2jN7ALVUJOKKPRmAGXYZAotfV8cvhxiVZl1QO8E3gBYSzLG
	 oLtsG2ov+FIFPee35U3da1/VMTEE/AH0cvCfcVARPPTHzLdrBb9EKDINlmfgs5nYe2
	 IIVQH7CWRiw8y0LFvxVi4IVD3XXinoSNcTCYywQ4JpXeaQlmTQJFSX9w0+hR76ibd6
	 TKA+L191HNlGE3Q4vUufq6vm3kLNXGt7+9tVzK2uTsrN/6RKNKpaySFxGYKSJkTBXB
	 JRax1BDuMd/Qg==
Date: Tue, 1 Sep 2026 08:51:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, ncardwell@google.com, dsahern@kernel.org,
 idosch@nvidia.com, kuniyu@google.com, horms@kernel.org, willemb@google.com,
 andrew+netdev@lunn.ch, kees@kernel.org, jiayuan.chen@linux.dev,
 kerneljasonxing@gmail.com, ij@kernel.org, martin.lau@kernel.org,
 shakeel.butt@linux.dev, matttbe@kernel.org, martineau@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2 6/8] tcp: fix use-after-free in the lockless
 listener path
Message-ID: <20260901085102.5c58a5b0@kernel.org>
In-Reply-To: <e121d343-9a4a-4f93-86c1-c96dd37f1ae1@redhat.com>
References: <20260824033331.1084971-1-imv4bel@gmail.com>
	<20260824033331.1084971-7-imv4bel@gmail.com>
	<apaAskNL-IvdcR7h@v4bel>
	<e121d343-9a4a-4f93-86c1-c96dd37f1ae1@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 10:03:51 +0200 Paolo Abeni wrote:
> > Looking at this further, unhashing the listener and then calling
> > synchronize_net() lets the disconnect path handle it. MPTCP needs a fix
> > too, though, because it closes and reuses the first subflow directly
> > without going through tcp_disconnect().  
> 
> This looks like a more palatable approach: this patch in the current
> format looked way too invasive to me.

I likely lack context on this, but I was wondering whether we should
potentially disallow the transitions between listening and data sockets
instead of fixing these endless bugs?
