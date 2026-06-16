Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7220A4218A3
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603510; cv=none; b=CRrObJfGkzrYLBGWv1Mv99dCQOXMS7jfooYP6X4e1tdkN45ZwrfW2pHmrLMLvaEYzB+ZuCs9iCb/DuS2l36chtfGc9XLUugoKO8qqjdU/3qNUzgXatBGjrKd8g62ME0diJ6+bXe+5vctE7k2UyIb9mA2NYjMkdFg/GhV9rSIJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603510; c=relaxed/simple;
	bh=4QJiPHhQcMVIgoWrGQcv7JcIHUWB0PJwmlzg53rbZnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MP3a6oqwoYjWd/wFDHlt/QVP40EOF5OxhzJOKNjwPr+UPOTD0VbOt+/SnJ+Qdg+1MD0kE/UDGQeX3qwBLOYPf2hFczuZALVtHQC6gCuxBcQMdgFg1yxLg5yKwi29ode+nqSy27S+ldiac4f3dT7hobbu0gumGTCAE7N7fNro37w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IS9er9Zy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IS9er9Zy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AC01F00ADF;
	Tue, 16 Jun 2026 09:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781603509;
	bh=tnPXwz8Ljl+BTZQqNNRCKO7wyV6CLmiC3uhVOmPGa5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IS9er9Zyzzja3pNL6479/n91Kfbrlv3GEao8x87CZ/kwMX315D/3NAjgQ6Q96E4Ec
	 LtQkYBalW4ZMC3+yMoSRTFMhk/w5GNh5CgPfT8busqSdleInsbtCN4IZcwZ4OXrTM9
	 8Dccd/xjnadhwjlUuYAKwhwZMvsmnB/vybX5//PA=
Date: Tue, 16 Jun 2026 15:20:42 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Waiman Long <longman@redhat.com>
Cc: bigeasy@linutronix.de, tglx@kernel.org, tglx@linutronix.de,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] debugobjects: Don't call fill_pool() in
 early boot hardirq" failed to apply to 7.0-stable tree
Message-ID: <2026061622-manager-quarrel-8346@gregkh>
References: <2026061558-amiable-showman-7ea7@gregkh>
 <1ba5a885-ac2b-46e2-b18f-f5b3e02e8094@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba5a885-ac2b-46e2-b18f-f5b3e02e8094@redhat.com>

On Mon, Jun 15, 2026 at 04:03:09PM -0400, Waiman Long wrote:
> 
> On 6/15/26 10:31 AM, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 7.0-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 0d046ae106255cba5eb83b23f78ee93f3620247d
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061558-amiable-showman-7ea7@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 
> > 
> > thanks,
> > 
> > greg k-h
> 
> Commit 0d046ae10625 ("debugobjects: Don't call fill_pool() in early boot
> hardirq context") has dependency on commit 5f41161059fd ("debugobjects: Do
> not fill_pool() if pi_blocked_on") as they both modify
> debug_objects_fill_pool(). So commit 5f41161059fd has to be applied before
> commit 0d046ae10625 to avoid a merge conflict. Since both are fix commits, I
> supposed they should both be applied to v7.0.y in the right order. Similarly
> for the other stable branches.

That only worked for 7.0.y, which I've done, but it fails to apply to
all older trees.

thanks,

greg k-h
