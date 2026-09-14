Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4CC43F08F;
	Mon, 14 Sep 2026 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392465; cv=none; b=BhjuXkWqvwXeWmdnoyncwaHHkQeF/Vbg8VXv4KjpnjKJg+rnWZFnY4j7iQygMe87Y85dAT1Hh9ab50BVDK4d1GxRzPZSs8B3YlwaqkHGKHk/xPUGYbKcyGSJvyFdBX7oUXIW4FolCkJ6zHwre4yTlLhWBU6vRTlY9+h74uR23mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392465; c=relaxed/simple;
	bh=IDClGm/u5/6/Ld5pfo1E/ayTU+yZaDFb018a+0WvsTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Skgq5KZE/ZvWhl4cZGw9YLsBBwiA9Yr6KPhF7I7UNUGySMAK4r/aapaqEuR0a19nZbVTZli5aQsuqQnirwXaR2RQE6BdfD1KWqpGP1jysuiDGb7yCLZfGFAcZAY29B1T1s7ARdNqUNL2KWDXnvFIoGJMRWh30RlJIIXzWGrE4Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=hIOTmmVF; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="hIOTmmVF"
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 6175D8011D;
	Mon, 14 Sep 2026 13:27:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 702FE1A;
	Mon, 14 Sep 2026 13:27:39 +0000 (UTC)
Date: Mon, 14 Sep 2026 09:27:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: David Carlier <devnexen@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Check resize_disabled before publishing
 the new subbuf order
Message-ID: <20260914092738.20fce3e1@robin>
In-Reply-To: <aqcKav91XJsCLxPJ@google.com>
References: <20260912103938.1127021-1-devnexen@gmail.com>
	<aqcJq1-R-LaK9uBi@google.com>
	<aqcKav91XJsCLxPJ@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: gs94zzzux4i6g4zrcjdazzfi86djftsw
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 702FE1A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+sN6irbeV0cFKLCZhAKfAd/1hlOwlg4lQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=1wtw99A7cFc2ZKKyzuHvI83te1iAzjPHupLu8WdCCYQ=; b=hIOTmmVFgEd23fNuibwdoM3AT0Fy4MPds+NDvztEvvMRMWT9IZSVGHzwUiF/FI1JLfahwwkAgZG8HTPMLQ4wKuQp30Q4cHCpcQGtelztctJ2+mW87ustTHeXiS8YCs1YrVoZjmlURX8Ovh+jL8u7sR3DQ7IPBcyOD95iB/T5Pf0=
X-HE-Tag: 1789392459-940715
X-HE-Meta: U2FsdGVkX19z/2yoy6Sjvrwrd+kXbJNnN2McyfoAKC5ymtA0aU3AMkDVBE7F6pKYFvKaMtdtQhb4fNcdXUjLUKdioGdxPGRqW37j8KKt8XLVMb8guE/rIqPLLfAS4Dh5n4JoOX9ybOflmC8aLBoR14J+kl+is6bNOlRh/zXnM1iZRIrRnTjP0d64xHdAz1AwhEMYyTmntnGY/VAQ5pNn1CUnmsqB1pL0Z7gm43IkVciRo4WDo4VVcfDswqAaRY9nPXfrzsV7MGSayrnjKW68O/hhRkUmcL9zIeW/hqyBowBpZ249zcfF45R78IHQSk++iJt8VOZe9FVKsdQuGprcp8MuNvugZOw+nYyGHKXhJpVq6FzS06tEtg==

On Sun, 13 Sep 2026 21:41:14 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> Ha my bad, that function also modifies the subbuf_order __before__ checking the
> resize_disabled.
> 
> Could we also clean the later resize_disabled check in the following loop?

FYI, I already pulled this patch and it's in 7.3-rc3. It looked fine to
me as I was just kicking off one of my long test sessions, so I threw
it in. Perhaps I should have waited to this week. :-/

Any update needs to be done on top of this patch.

-- Steve
