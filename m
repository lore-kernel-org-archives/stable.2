Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795249;
	b=Pf2T7c8xO99x/XeWvwPjIdAOvD3agmkdRlLmRX/Bni7Nkm02j8iWPydznrx4huxCrxtU
	 +ftdO67obm75uxThKrPVETqeuH8zieL85rJ8fd9kX1GOUrwhZyUyKeS4A4wtaHBjWzCaZ
	 lR5FywpMnZMX0J9BBFTEGZct7rj/XskK3s8ZlZ2nwH/mrU87FHgSGwVhtltes1i7Fc9ho
	 p3tfZpe/zDyfzG85h3SZimKv7tOSIsLNLxTnvr2jA8wfY2+/UxDVp0iYoHW2fkxSxkyha
	 v7YvGyD9t4CDYwsFabH9B5izo7La/F69I4dOCArv5Frg9HrDveMnGVDcKX80F0pBv3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795249;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=NnfvYHW5J/1eLikqHhAXWgEFwHKJPRDxIl68okrv9Yk=;
	b=YnEb5/1Kxpi/yt/idl+55HkN1dKtBWcXLKBbYiKZyKk/9mpQhBF01wkWp0da8xoUjZdX
	 Hmpd6a4y286ZdLAkGQ3InDydu8aED6HMOA+mR3PNnU/I17LiAC4sahYCQmkakgzPzohIS
	 WPDjCmVJhrk+/i3un5xRWwtr+oga4C1gB9DGZpgO3FW95mxaGMHuxi061Wl3sllGJrPNW
	 KaScot1slDllY3GesBAV+GtPtlsMY/Rci3bmlH5aZTeekH2x6On2LtsOi4KAz6xvcr+xV
	 Y1tBXXBlYBU7yJ/mc4tz5cKKaKtzkQEoWA8Ty90N6tlxTxSoINMw801AQ4LDQlb7ENQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=moxkZjTY;
	arc=none smtp.remote-ip=216.40.44.14
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E1460A2620;
	Fri, 27 Nov 2026 16:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8E1460A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=moxkZjTY
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 62766140412;
	Fri, 27 Nov 2026 16:00:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 5698E1B;
	Fri, 27 Nov 2026 16:00:39 +0000 (UTC)
Date: Fri, 27 Nov 2026 11:00:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Wenwu Hou <hwenwur@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] tracing/hwlat: Bind the sampler kthread instead of
 setting its affinity
Message-ID: <20261127110037.6ab35dae@gandalf.local.home>
In-Reply-To: <awf4-hjPFkBxPUev@gmail.com>
References: <20261125084600.2306377-1-hwenwur@gmail.com>
	<awbklFE66PIMKFop@localhost.localdomain>
	<20261125103822.2129a7ec@gandalf.local.home>
	<awcLwio_qyE3d1bL@localhost.localdomain>
	<awf4-hjPFkBxPUev@gmail.com>
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
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 5698E1B
X-Stat-Signature: 7got5myipz75fbrydnk8re5536upoc9y
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Aktj7PtXrc0mQG9LusHiUTOJ7SbGI/kI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=NnfvYHW5J/1eLikqHhAXWgEFwHKJPRDxIl68okrv9Yk=; b=moxkZjTY1FoUfCOXKqnWqXM4g2O1XYLZEO6inI1h60r57LzSaR+hnqavEp4uSMGHAbzLDs/wI8tqI4vsaQePo5zT8Dh4+HmVX7d0XqR8etjUxJFM79LnBayi7oLKeMaKZDTrMArWNEb3oc2obWAdu+5s40r+ToZ4xNqhKbfKnSo=
X-HE-Tag: 1795795239-846551
X-HE-Meta: U2FsdGVkX19uSxLZCujuP5ZAigFDF5ngnt8MDC7Y11d92eqyjSXmQPv+ax32CeDSbq1FO8VHG/x80HYLBaUr4+PeGm+Io9tvDqRR/NXjumPYUbdyot+i2GEJph7rZ4D2sMZCp2wB6JGqNghGPF2o6ycxBNHVoOi2VzsT10uFV0dW9hzSt3wWJ+ez5CXHapY6JmWVCch+Vgu99tvMb/hzOUxeMdN3nUSfBcMtl3l4mpo9op/oydKsL8g71YeXhh/ce/9l/96kuGyO1lWFHuOMT2GxtEoa6dA0eFK7cSm0sR9woqtjWXfbObOmHGhkdfbVzeAMcU1UErBjs0383aEX8etdiwB9ItS/

On Thu, 26 Nov 2026 17:16:42 +0800
Wenwu Hou <hwenwur@gmail.com> wrote:

> > 
> > Right, the affinity should only be changed by the kernel if tracing_cpumask is
> > written. Otherwise it doesn't seem to make sense to let the user play with the
> > affinity.  
> 
> I agree. Perhaps v1 is better.

A version of it. It needs to remove and prevent user space from modifying
the tasks affinity.

-- Steve
