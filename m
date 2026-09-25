Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41724746DD;
	Fri, 25 Sep 2026 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324999; cv=none; b=QlODG85IrW2yJ/JUMR1TZAYctaC96ESKMh1YPCJqZk+0Imd+4os0mbjePRO6P86RnxtlZ+A3rfYosbocmPSvz7MbFguT1eMeyxRXf5wpFoh7T4NqhLqciJYDJqhOplnIQFEikZyY012XM7SI6YX61AQHstfAaCLpY1kjb4zV/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324999; c=relaxed/simple;
	bh=xq9pWfNOGhP0hNdpGCu4Qw9RyjihdGZ7mXFFKnZWM6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLzypbAPZOJ78YIpWVz/0mcryR0PShss7eW12OLiODHCjvOKS80vVF76xctfJK0/p/ZC7Cvdbw1kxmCCNIy9vmvGkVy31zccLVEeWUJ8skgmEjibFMf2W7QfAHx3nS+B3W0MneFZUCyTm90L3Z50u1v3ojfgrh8/+QA+OiSHWdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=maN2HJ86; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qjgnarok; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="maN2HJ86";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qjgnarok"
Date: Fri, 25 Sep 2026 10:29:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790324996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1e7GlrEhluYlw0l6ZzgbtVSEad4G1/5+AKEppD83JLU=;
	b=maN2HJ86G7H+9gFXGYsBcbPUEnWNWq7nvBX1J223J4r8KuI8m4E89f6XxH57qS0qVmQnhw
	4v5aDtuUPwyoFXEpsNwp1o1ufFXr25KccIYsrnl4qr9/DUjdjUO7hVfX8gCUVdF7KAEkZh
	h39YESuKU/DoYzoRy8vv9A4HEmjRANOr2Lqjdx6l90MmsR/0ThFBmiu8rP36Rw0jZEmmuH
	PIzlEGphS/YM2AvZIac6Q3eZeGXfpeDUZfCQKH7HKTjRo1osijFDKAwlUQVspd7WZQAVJY
	G371SWc/xA/INI5trwKGjq1Ouw/xHEK9lfwni9jRysnaADyTI4FFeJz8zCv1ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790324996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1e7GlrEhluYlw0l6ZzgbtVSEad4G1/5+AKEppD83JLU=;
	b=qjgnarokQeQsM73Cxln1IifkLDHfeOKejgrxyETCNCDAfPcNLOzEe6OfoOKt7X61ydllTY
	ctG/sn/SxTMBvaAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, xiaoliang.yang_1@nxp.com,
	skhawaja@google.com, liuhangbin@gmail.com, stable@vger.kernel.org,
	sdf.kernel@gmail.com
Subject: Re: [PATCH 3/4] net: hsr: unfold GSO super-packets at the forward
 entry
Message-ID: <20260925082954.MYDugnDU@linutronix.de>
References: <20260809121455.1745-1-xiexinet@gmail.com>
 <20260809121455.1745-4-xiexinet@gmail.com>
 <20260923104346.ur63K3h2@linutronix.de>
 <2cf54664-c07d-471f-af6d-4b70e09626b4@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2cf54664-c07d-471f-af6d-4b70e09626b4@gmail.com>

On 2026-09-24 23:26:27 [+0200], Xin Xie wrote:
> On 23/09/2026 12:43, Sebastian Andrzej Siewior wrote:
> > Wouldn't it be simpler to not allow such packets? 
> 
> For master TX, yes: removing GSO features lets the core segment before
> ndo_start_xmit(), as patch 3 already does.
> 
> The interlink RX path is different. With GRO/GRO_HW disabled, it can
> still receive skbs that were already GSO at the sender. I reproduced
> this with ordinary TCP traffic over veth in a VM. Rejecting these skbs
> would drop valid traffic.

So you disable GRO on the interlink port and still receive GRO packets?
Or is this performance related where you want to keep GRO enabled on the
interlink port?

> I'll retain segmentation for valid interlink GSO in the ordered
> consumer described in my patch 2 reply, before per-frame sequence
> allocation and HSR tag/PRP RCT construction. Each aggregate would finish
> before the next input, without holding an HSR lock across segmentation
> or transmission.

Sebastian
