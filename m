Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281729;
	b=jY2v9ZJfbrVLWS2f8lb9F/QBzSyqIQ/2f6vFl1AqJ/Ho/PQ49Ki4hgKre2XLqZkVmIsU
	 JxFGtOvwZea9bzEqmUZ1NtaCzYAd+wylgMg3EOF6x/ftaLYRJjK8UkDuiBVi1HH473S1I
	 RpX8d0BNs+Kv8whuUMV52iejTSubbYS/OEQ33ApUM97mg84QIGZjS6h9Ty1T8zobleryt
	 dy7AXGtZILpnxi7A4V5mjEoYx870cMXcl4cH28ocSh6jUD/EAhtj8IrMEIEO5NtXlJXnB
	 PSn1kvK14Zm59El7XAI/BFrc5CTcv/hq7m0+DCsJyXfi9h5bjS/cLumMYLsK55jQ1bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281729;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=N6vcUb6SJzRTcfauxbDiejxYjIsBkLgqIhSS3kXkYQo=;
	b=EjOg2V+ZPrsDHNvogeGLRDoRgEbgbSq9JA5KgohiY1T38KWO+RdtbKaJC4BGg3qgKgGY
	 pntuEfGXwqoZ40kglBhIjeNreYVkv0NZWqC7LqZ6fSpML+C2WzoWt1uN6Qwc6XqY2qJS4
	 Hao2eZGbMSDnRLgQ6QTl+D+/I6qVCQfnPp0H2QhiBmR3jZkuSQDneYb675Qn1e0Xtg058
	 Ml+2Rjq3Xl4g3TembteDT1QyJZ2ipHQeUKzg02hWuL39erPpN5O7ezEwtufw+JQlUMKhB
	 qzvhj4KNE13rXcrquP/SdOPb+ieEqEIlgIBYAot+9qmuN8mPrUSSHPFuoSMoikEqCdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=h0khfuiX;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73F60A5BD5;
	Thu, 29 Oct 2026 13:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F73F60A5BD5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=h0khfuiX
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 63C87C03D9;
	Thu, 29 Oct 2026 13:48:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 33E4920026;
	Thu, 29 Oct 2026 13:48:44 +0000 (UTC)
Date: Thu, 29 Oct 2026 09:48:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Anvik Loitongbam <permissiontogallop@gmail.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Olivier Langlois <olivier@trillion01.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] io_uring/napi: fix list use-after-free on PREEMPT_RT
Message-ID: <20261029094842.58dc252d@gandalf.local.home>
In-Reply-To: <502f31ed-dd70-469c-b433-577ccee36c3f@kernel.dk>
References: <20261029102244.141621-1-permissiontogallop@gmail.com>
	<502f31ed-dd70-469c-b433-577ccee36c3f@kernel.dk>
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
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 33E4920026
X-Stat-Signature: i4wa8zmaz8efohxc8xwyt1ps7bp73wox
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/n6TvaN0U32J07q2RORdP1mOlBY1nJQIo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=N6vcUb6SJzRTcfauxbDiejxYjIsBkLgqIhSS3kXkYQo=; b=h0khfuiXO5ayJH1jQjBMv+Rg+qX+wvggPKXB+6xczdNfQjHWuHTBILhsb+UvURDzkAkrBUUbjFAFhUDnSBfxqTahJXde13xQs4PWZ9E0ag1OKJWgdhn2Z/yKUS8NTe6mgKPk33GosRzE9472jsdqmQHidvlidDlpSOIRXY+ptxE=
X-HE-Tag: 1793281724-722511
X-HE-Meta: U2FsdGVkX1/tbr3Ieis1YJltcvmKNmAuEETMJT2+weDKtNQ4wcmVF9jqePB91f/lRSAVykrGmGhbdm3Upc63qLsEs5JHxaiDBNLkf9FC8VTE0VnmKVI4MIJAY0gMGclIHfMc8Dy27XYrEnOtpS370FkTJWM54Degv8zL0XLCH5mS9wU7C1cX2JfM2Tm6Ck6c7gD5EdRYtOv8O1jXuhMIU87C2ULW56pGQqM+OjbZyRq2wmdCQQuQZDwnwOtGIiBLJkMeIM3/eZKDptlFoatoqiuFq8hKtdcONcUz4ynfTZMitOrcZ3peIHvDpBaQ2LUw

On Thu, 29 Oct 2026 07:42:09 -0600
Jens Axboe <axboe@kernel.dk> wrote:

> I don't think your analysis is fully correct. On PREEMPT_RT, spin_lock()
> should still be an RCU read side critical section. __rt_spin_lock()
> calls rcu_read_lock() after taking the rtmutex, and then
> rt_spin_unlock() drops it at the end. There's even a comment on
> kfree_rcu() callbacks in there too, it should not be able to run until
> napi_lock is released, which is post the loop.

Good point.

> 
> IOW, I think this patch is unnecessary - there's no bug there. The list
> safe change could be done as a cleanup, but it's not a fix.

I agree, it should still be applied, but as a clean up and not a fix.

-- Steve
