Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629082;
	b=1ItWG67VLTEH1PyVW3mkJHylu9+UvHJhi5DP36OyBd7D+K4cJLKVcKBvUjlrnTdIWqCv
	 IbHOY6MdyhkUL/4TJacLsaV+ocy8vLFuzxfSzguloPBEWv7MTh0pYXtpzRcBLLb839j7b
	 tp9smF5OC/YnQj4XRDXOtATZWdKfxGw89bvxuB4HEekTXk7WVgnn0KoOyxhWNEYWAdyF0
	 za4RYwnWg0WeR+Qhg2xWrBEmLgj+OnqtbMTu8DENSA6/mFBHyEP7EhWVV5+7s8HTSLFwE
	 5inCcv0reZhvgrW/zAWyEu8TOL8C+amiz55BneINVkE6hyZw4uRFqHfn+evb9mTAW0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629082;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=0vE2MW8oPr2NcLO5kkPhYCSI7fkp6SgzAyef2r6+0G4=;
	b=MRyTL6Kzo1NsLda3c88cL1eiHijpwDj+FgiKSv+0327iUNZVP3xLSM9S1N26L9fbwAc8
	 xfR8Ckz5+sf3te6Z7J28FwAtR57VLwToxHzEhLdZSKjp7X+A/cDwD9rj2SMadNRM1LrC8
	 qhAvAwnDk4t05gk7apibnrQtlGyPGjdVnryAfpcHrZKzdw5igRkj1tw+iUR8XmAv2KYRf
	 YzM/JzVOMv5Nhl14Q3B1HEOUIMqNNzwu0Gbysg4W6LAlU6EEqOd8/SRvoBqdIPJa+gwJp
	 Jkf6ZmieUqmrHhdTKyK1z1Tn08kD5+K5xZIfcPKGyC09u0cddGLr6g2LZeDCumFQmog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=PxLVRN95;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D44606B5F7;
	Mon,  2 Nov 2026 14:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4D44606B5F7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=PxLVRN95
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 8963816012D;
	Mon,  2 Nov 2026 14:17:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id AEB112002A;
	Mon,  2 Nov 2026 14:17:52 +0000 (UTC)
Date: Mon, 2 Nov 2026 09:17:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jaewon Jung <jaewon8868@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Keep copying markers when one instance is
 stopped
Message-ID: <20261102091751.2ee7c4d3@gandalf.local.home>
In-Reply-To: <20261031073549.2991066-1-jaewon8868@gmail.com>
References: <20261031073549.2991066-1-jaewon8868@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: AEB112002A
X-Stat-Signature: zisrbxd1p3catgtzpzq16r3ymu54ifq3
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+LOQGCiAMa+/kHer8Q/vyDiTbyEEJ4w+k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=0vE2MW8oPr2NcLO5kkPhYCSI7fkp6SgzAyef2r6+0G4=; b=PxLVRN95U4bpQKmnGAh8I2tiSNseVUpUC2AlABDjfIPi30rhUTXFr6+glpukh0p2Z4gDSTkUl7SwsqoCAorOmmQzSNHnDRcYssXXltRTuH+QEmRWpMdkz37nz1KvDF/4b85bUTz2dW0Qnx9QPuSC8ZTuBy9m6MUgkLLPms3aJwI=
X-HE-Tag: 1793629072-197361
X-HE-Meta: U2FsdGVkX1/9V4bQ67ornv0sgZ2E2DvtnZJNxhCMiLeDuzXBR8vVQiE+JLgAHYljUVFoJBOTqweDrUCPau1qI3h2uZp9cvTPuOJVk3c8pkMuiyOK0LrC+vEmnzlqduUWK+4DFr/89ia6DjMed62TG5OhpbiTcxEQVUvVc5L24tIai5Q2MAYcpHSzELewvrqwnvprsf8zaFjObSng/gXLQhUlB7Z31o7cg6IwCpVTKWXBQm9dT9ET+Q/dC4f3nHiNCjXbDP9iN46O3xprz2CE7uJ+W6wGTkXyF1QRkz6PH9iLtVTz3dtOkHl+hXvkhzaK9Gd3CPseDtDKIlzgw1IJG9J+9nmlpOo472XdaDjo+GVwFEveSO4KxA==

On Sat, 31 Oct 2026 16:35:45 +0900
Jaewon Jung <jaewon8868@gmail.com> wrote:

> When several instances enable copy_trace_marker, stopping one instance
> can prevent the remaining buffers from receiving markers.
> 
> Continue copying text and raw markers even if one copy fails, and
> return the last error after trying all buffers.
> 
> Fixes: 7b382efd5e8a ("tracing: Allow the top level trace_marker to write into another instances")
> Cc: stable@vger.kernel.org

Please remove the stable tag, this is more of an enhancement than a bug fix.
You can keep the fixes tag though.

> Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
> ---
> The current code stops at the first error without trying the remaining
> buffers. This patch tries all buffers even if a write fails, and returns
> the last error.
> 
> Returning either the first or last error cannot report all failures.
> I chose the last error to keep the code simple. Per-buffer error
> reporting is outside the scope of this patch.
> 
> Please let me know if you prefer a different error return policy.
> 
> Tested on x86_64 QEMU:
> - Setup: Enable copy_trace_marker in multiple instances and set
>   tracing_on=0 in one instance before a live buffer in the copy order.
> - Before: No markers in live buffers after the stopped instance;
>   write() returns an error.
> - After: Markers in all live buffers; write() returns an error.
> - Existing text/raw marker and instance selftests: 6 PASS.

Honestly, just skip the warnings of the copies and don't even bother
returning its value.

-- Steve
