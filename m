Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BD5405C29;
	Mon, 24 Aug 2026 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580000; cv=none; b=QsoNWEAeBykpYmX0SG9Vc6JPp2swHh54RlvpADrpziY6MJnFzfsJcumjkoKdRiRl3RE8j2d5dUVnyuNs5XUtZ821xM+5+nRGKa/HuLeeaJm3Zq0CFU1gIL9lQiwclQKgvIT+8TLyVM1ewU+pLjsfF7h1xqZXYpjXxojkBz6aIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580000; c=relaxed/simple;
	bh=UY/TX+5oYoPw6zQhBQFsq9McF+v1eNdrpsCc+gWLdGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUYvQkjEgeZ7liSWWNR16VfXXQ2RKUsPgh8D8Twk2vLgWJKqKHSkDomSrE79OtZ/Fz8l/o/eYuoY0TA+IUS3To7PLbR/iJYXGJPuTH9DJb7kaI9QWczRZmiLfn0c3sFSyMCd0PJfJFCuHcNnHrtuWSvzwA2Nf5vNwKJXnsBQCIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=h7q5jUoX; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="h7q5jUoX"
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id C076CC0140;
	Mon, 24 Aug 2026 13:59:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id A175720010;
	Mon, 24 Aug 2026 13:59:46 +0000 (UTC)
Date: Mon, 24 Aug 2026 10:00:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bradley Morgan <include@grrlz.net>
Cc: =?UTF-8?B?SsOpcsOpbXk=?= Jean <jeremy.jean@oss.cyber.gouv.fr>,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, mgorman@suse.de, bsegall@google.com,
 dietmar.eggemann@arm.com, kees@kernel.org, kprateek.nayak@amd.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, vschneid@redhat.com,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] fork: initialize function graph state before
 copy_exec_state()
Message-ID: <20260824100027.75075b49@gandalf.local.home>
In-Reply-To: <B701B25D-C39D-46FB-982B-5681B3D45CC6@grrlz.net>
References: <20260822195321.962383-2-Jeremy.Jean@oss.cyber.gouv.fr>
	<4E2240F5-1211-47CE-AF04-24E1F0BC4707@grrlz.net>
	<20260822170928.1acba2cc@fedora>
	<603183e5d6abcae2229c61b8e266e60c@oss.cyber.gouv.fr>
	<20260822174053.26aa2f56@fedora>
	<B701B25D-C39D-46FB-982B-5681B3D45CC6@grrlz.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: A175720010
X-Stat-Signature: 1qedd17km8qzq14gn6pwwtxzechet1k9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/t461MF3656M+VT5xuERRLBzzJqPTusn0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=UY/TX+5oYoPw6zQhBQFsq9McF+v1eNdrpsCc+gWLdGE=; b=h7q5jUoXPivbXbnPoRe7oHbkpcVDCiLWjCW18oTeYzZkRS+AbAPpOL0aH1eQiQ8vp08+JEBG8zrxXkfhXegexqaV3CRzsqDjEU18llgFLtBO0w/TErc7o4061iT2LPYCRUnIq8GaLzCF0ULRQzCUcKv3tse+ow7Fn9a68CH7FP4=
X-HE-Tag: 1787579986-570648
X-HE-Meta: U2FsdGVkX18fzBqcLU3DmWyGEFydI6myBoJlGyzycwRU+Etp5+QVqabUTtg7nwsUF4lY+jpHmyAmIhV0QwW4VGnNbYiOhPA56mvr3Ev5mW7IZ75pADCxTW9kErwwx1MlF4XHr7/asnuyQeJsid7vqgEmHspoUU7+PdyDi/9PITdfWumOsDF0SALJzJFbFWUOjoFChnAl84fixX1PnPCIhGmKaHcE+bP5HzQJuioGTcL1MryxPrJC+JU3nYG32I6tEohUcAsy7bEB7l0Vd/LKjCwP/wKaiWZ//hiSVGrZ1Zxm0+2MWKr5UvyNoCXc9pgE8EG7swhLyLkPC2lnlbu66jNgxm8WSKDQEaG59Fka9LAJP8uDFSf1TsWmlFwptQCM

On Sat, 22 Aug 2026 22:47:36 +0100
Bradley Morgan <include@grrlz.net> wrote:

> Will you merge it to one of your very cool tree(s)? I've merged it to my
> friends distro tree, not maintainer tree or anything, but I do tests, I
> guess that's like future learning! ;d

After my tests are done, I'll move it into my fixes branch. I have other
fixes that need to happen too that need to pass my tests and I push them
all together.

-- Steve
