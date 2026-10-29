Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266958;
	b=oZE65PPUoK14arwA09QovB/4ixhoixwOqGYpo6SJdBwTV4IcT4WyNwYozg7THrxvJ41n
	 rwpltfJ01FixDglsRRQkAd9946yQdWNdOYMZbfS3KNYOZTr3xQROPLoe+vNXaevXWOzfF
	 PU0oRFFNb8OCgzqrULQCa4UsH+gytzu+5ptGjUHDMkUXZlSPwDMIHrIGYaqrN6g7+RSUx
	 6WAGbY6aRCOO2UtDYDvlK0+qmDfg79k5j7uWPxSJZXH3lcoqL0zBSp0VVMWP7EC9FgC2L
	 m/cmLpOPPCB6gWpshIonYwCMf0x/LbI6g6Q4XSoYLqbiu9DlDaH0l9QrBe7huyyltKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266958;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Jhw6qeNQo9llRqUs7kr3ZQLpkz6zlG1jOAOvfJ8myBg=;
	b=inP6l0EjI1cBC7Fwvj8yqEsz9ZUVu/CCcqPcHrPlcoJ+AlPEFG/ZWk1xglmxrx/42GmF
	 Iy8QVQQvxRsBvmRX98TsnJIKnAdaJ2/AVRIeDJruPfVo2+1e8h13NoQax/PqrGS8L+Eic
	 v0T/J47qL1gLi8ALZMdXGhw46sX4DjpKbFQm2VuI3UN/zY/4hMb6v4nxjQOyrxRRK3RMu
	 o57JQtWIRTfswLQU+XxveuQQ64ELXfQ/LAtmMtKISuQGS67laIYF3qh22x3Y1nAumWJC0
	 LUGBTKp6+bk4wubg0hEvxymwngeJW2bSTU3tUX13xGMcBJhbwdiuhj6wsmp1bq+gxNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ecK4ptG6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA1606A31A;
	Thu, 29 Oct 2026 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ecK4ptG6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3E71F01825;
	Thu, 29 Oct 2026 09:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793266957;
	bh=Jhw6qeNQo9llRqUs7kr3ZQLpkz6zlG1jOAOvfJ8myBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ecK4ptG6cU1iihlyIk0k3HU/ttbCUkob64T7zZ1vmbFepugqvHugPZha3anx6GRfV
	 CwC6q4RykI8IFAxezm6KOvxJq9hE3wC6X/xLAhb+JSP6qbJK34iypsE+dk+0+93IkC
	 QEeQxen7J5+aqorvXCmMHJKpGXljPFtfkiLf3yzo=
Date: Thu, 29 Oct 2026 10:42:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: IgorpetinDev <igorpetindev@gmail.com>
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>, Tejun Heo <tj@kernel.org>,
	Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] usb: core: hcd: flush giveback work on stop
Message-ID: <2026102924-flashily-myspace-60a8@gregkh>
References: <20261023174015.54793-1-igorpetindev@gmail.com>
 <20261024155614.2732-1-igorpetindev@gmail.com>
 <20261025000643.425c57ca.michal.pecio@gmail.com>
 <CAG21Q83f_Oj5+-OPjFdxzmLWnFkjfYhY9ordyO0zoGtxkWEW3w@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG21Q83f_Oj5+-OPjFdxzmLWnFkjfYhY9ordyO0zoGtxkWEW3w@mail.gmail.com>

On Sun, Oct 25, 2026 at 10:54:57AM +0300, IgorpetinDev wrote:
> Hi Michal,
> 
> > No such domain?
> > Looks like you trusted an LLM ;)
> 
> good catch, that was just a clumsy typo on my part: I accidentally typed
> appspotmail.com instead of appspot.com in the closes tag, anyway - the syzbot ID
> itself is valid. If Greg or Alan prefer a v4 to fix the URL typo, I'll
> gladly resend it, or it can be fixed up when applying.

Please fix up and send a new version.

thanks,

greg k-h
