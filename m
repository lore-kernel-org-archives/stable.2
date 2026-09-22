Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA9039F188;
	Tue, 22 Sep 2026 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790063656; cv=none; b=hPe0XptgM/+PA1ld4utRlfl/AnYxZYlgE5UDD2a0LlkbHkYaR3w1VLgUFHFN9BIqlPiQxtUe9bj2tbFza3pBaQNcIT8gHFIX4ue94ZmKN/rmJMIz4+83qxTkpTzK+2umAp/2QcGneTOFurhz1mgjDRSlMR1Kmf7WWFkZz3988fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790063656; c=relaxed/simple;
	bh=KoI4mNGuiofuUwVL60X69VSUVc8IOT6JSlFKwqLihUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efi2x4toZs4WgvBrEQCllr8TVdJU7GvCmfaZtQ6B3YEguQ5c9GvuChKlF+fVANPZRTgyvAJe8HW2htpuKNPr3WOibqN0x1mtbI3Il5w7VAq7h0eCPvtDrLgqXEXms56nL9cAzPmDvUo+d00PuDrtslI0+8+ccLcIGOtafLGK+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9BNng5S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9BNng5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3371F000FF;
	Tue, 22 Sep 2026 07:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790063644;
	bh=TgeKIblBe1/xue7/qgjT+0OwbKuQ61ADgY1/uG2WxQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E9BNng5SOdG3QtfLBVMfwAhd6vZRaeuy/NtiYcnDS2aeIxtLBHFX5f63dlGNlZ/ak
	 2Qa6GexUuAveE70dANZINtMcuYh63lGnpYhTI/GPXV+r64J24Ej2oDXlJLnUvOO3Bh
	 C1eOO1mzwNxPTacVvQGE0+BfRqmz9Wig2OJR4qLGdW2rcWbMNQMWpfx1TXVLI4oSZc
	 3h/YznfnIWSUtP52RFQfg5X+UDorROWzAjs2P8aw9AX/ff1x7Dc2VX/2jxm8kuknFW
	 rtkbafqw53HwwzARrULrRFJX73HGFyn++O4vC5daugLZn21PtE2WoArpQI1Uzxe7lh
	 vkynowTjDGSlQ==
Date: Tue, 22 Sep 2026 08:54:00 +0100
From: Lee Jones <lee@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, stable@vger.kernel.org
Cc: Benoit Sevens <bsevens@google.com>,
	Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [STABLE v6.18-v6.6][PATCH] HID: logitech-hidpp: fix race condition
 when accessing stale stack pointer
Message-ID: <20260922075400.GA2268440@google.com>
References: <20260401144811.1242722-1-bsevens@google.com>
 <81n26386-p78s-5rqq-5s7o-p8s01sr95q74@xreary.bet>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81n26386-p78s-5rqq-5s7o-p8s01sr95q74@xreary.bet>

Dear Stable,

On Thu, 09 Apr 2026, Jiri Kosina wrote:

> On Wed, 1 Apr 2026, Benoit Sevens wrote:
> 
> > From: Beno=C3=AEt Sevens <bsevens@google.com>
> > 
> > The driver uses hidpp->send_receive_buf to point to a stack-allocated
> > buffer in the synchronous command path (__do_hidpp_send_message_sync).
> > However, this pointer is not cleared when the function returns.
> > 
> > If an event is processed (e.g. by a different thread) while the
> > send_mutex is held by a new command, but before that command has
> > updated send_receive_buf, the handler (hidpp_raw_hidpp_event) will
> > observe that the mutex is locked and dereference the stale pointer.
> > 
> > This results in an out-of-bounds access on a different thread's kernel
> > stack (or a NULL pointer dereference on the very first command).
> > 
> > Fix this by:
> > 1. Clearing hidpp->send_receive_buf to NULL before releasing the mutex
> >    in the synchronous command path.
> > 2. Moving the assignment of the local 'question' and 'answer' pointers
> >    inside the mutex_is_locked() block in the handler, and adding
> >    a NULL check before dereferencing.
> 
> Now applied.
> 
> Benjamin had some ideas on further cleanup (allocating with __free__ 
> instead of using stack pointer), but that'd be a little bigger cleanup, so 
> let's keep that separate.

Please could we have this commit backported through to linux-6.6.y.

e2aaf2d3ad92 ("HID: logitech-hidpp: fix race condition when accessing stale stack pointer")

I will follow-up with a backported version for the older releases.

-- 
Lee Jones
