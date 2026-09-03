Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE6B4AF14C;
	Thu,  3 Sep 2026 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441600; cv=none; b=YiSj51n66tRoJlVltfttL1QwywWKvcNz1ojZqDJz4PyccK90FbgoNRjAtZoVc4zpjLqCRHxjSRYeWoyyXn4QB9VdOTHia5XxxGPBYFd4l3MgfKr6wu0QU2fPOKLf3HUXNGplzg9f8XTTTrpi5RaGlQIlfSKTFCu3t1GKoaO23d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441600; c=relaxed/simple;
	bh=kbj6AMyiVAbFtydzrvgZcyhMYQC25piDXUOE8D5G4v4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hp0GVsHe1Bxakfqfc4DhjkFXeR87wgD59D+tAIo91iGQiBLw783jh+6DKxsCdYjhvY4FdkJDgFaJtXgeKI348xGX2goLtKaYZu19ks10+p9Z0sxbdKklbYL9+9bS7U7FIUFxHsEGfWrZZRaMmodV2j9YvzXFkSNa5MJcllb5jVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=QAGPVoQ8; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="QAGPVoQ8"
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id E4EDE14052A;
	Thu,  3 Sep 2026 13:19:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 0639B8000E;
	Thu,  3 Sep 2026 13:19:34 +0000 (UTC)
Date: Thu, 3 Sep 2026 09:20:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Peter Zijlstra <peterz@infradead.org>, Martin King
 <martin3kx@gmail.com>, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-rt-users@vger.kernel.org
Subject: Re: [REGRESSION] sched/rt: NO_RT_PUSH_IPI causes multi-second
 PI-boost starvation in pro-audio workloads (dd29c017aed6)
Message-ID: <20260903092037.5b739980@gandalf.local.home>
In-Reply-To: <6db9c47f-a1f8-49dd-9e80-f9014d75f9e8@leemhuis.info>
References: <CAEB5A_91hob8ddOhW=PrO1=O7GrFmSxY3r1-_Ard6x8KHHuJGA@mail.gmail.com>
	<20260814183652.611e7ecf@gandalf.local.home>
	<6db9c47f-a1f8-49dd-9e80-f9014d75f9e8@leemhuis.info>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: n7gg1dkmn3igakffpjb4hy3jiraagsra
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 0639B8000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19SV2aoloGzEWFLE1rcYw0EtPVdoEjm/70=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=kbj6AMyiVAbFtydzrvgZcyhMYQC25piDXUOE8D5G4v4=; b=QAGPVoQ8d1h0loQUCSQc/mijJongP3octDBnDmVjmdGhW7bSwbc7aICdUYTzWiTSIANpIJTq16CX8ISBdntkSR8535bZoGMPQD9RF1JSeGc5r1rECp6pa1KKVBJIcW0x5fshJEP2r5GT2LJnygN8iXB6uBJHSTYqF0i0AMWvneE=
X-HE-Tag: 1788441574-241105
X-HE-Meta: U2FsdGVkX1+jM1TGt04JbL22BGmUazuhm/NuZrOObeLobyj/AWwZNm3HXS/xfQMc8rpIOfUc7cBEk7KUBLVBvIR/dENp1enor7PgbTVy+sr2vq50OTkTxnfm/DSkS19ntIsqPSs1CkMO/Y9ZGahgIltNJKm5MG7gQqi/VHbi0hBI0DW5ZDLL9PWidRBcwZIGr7V4t2BPk57onaCKiA9k3WPelfI9PJG4CJyKlbDb8wp1wLt79ou1rt4A0qusYKB4zsuBnV6uEoSTve4laooUKQmm65cFuNpIU28bgEk65fQkQB+p1siGC5rAxFPjMxGBza9Gy27WuAd+UR/cdde3aGBJFTnmSm2FFNxBEwTc0jbQ9E6E3vlwAwxcgQ6f2dxU

On Thu, 3 Sep 2026 13:27:59 +0200
Thorsten Leemhuis <regressions@leemhuis.info> wrote:

> This made it to my list of tracked regression -- but it looks like there
> was no progress for a while. Is that the case? Steven, did that maybe
> fall through the cracks due to the travel you mentioned? Or was this
> resolved meanwhile and I just missed it?

No, I was traveling during this and now I'm way behind in other work. I'm
not sure when I'll get to look at it.

Feel free to keep pinging me about it ;-)

-- Steve
