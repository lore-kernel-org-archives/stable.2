Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916816;
	b=vGljr/qkPUfp4yCtsY5k9KoB3xa+QjBa5q6vehBfgH6PcJ2vPe2aUcWMdzxP6+7LImpp
	 4/98nV6uOYyULZtiuY7Q9QkkPdl2AkMRHw1/OSo5I9mKWoA+3QDC/teozH1XlPibwIKMo
	 KuP5F8gB59kIAvPINSSDqbrX5SFhQFpBNy0N7aQksKz6LDeZ8hxXeTrDpGEXfPcnNe1NE
	 A2OKelwwwvzVFyj91OA937A1w5dyHMCsr9yZ8EzIl8Bmp0lLClEEuG2yg1XwfWrzsHhEj
	 T5nWEnkVy23kcs824gmoDmBRAaKVZ1RwRe4VVa/3MZDFbdDqc8YESabMGMOv+ERwEcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916816;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4KVE0mlIb8Pa60CBHZvDD8qqhUD9QNgg/6EGkqm9L1Y=;
	b=cY/xio9BzBgNUhndld6LKHHna40SHxfXRfs4Xg4TWeCK2EuiTrR90xxPUO5h3Ka/ST3A
	 zaa3P6/DoMyg4cUMOzJXQWHevya72zpwT1Z7GuCqrsV0uE855B5038GAE1qcjJJ7VlhQL
	 CURm3mWVpaabnwUf8YUWSkUR3APMSu0N9hvgOrqfX/7+3DBDlvO9KsoJfrDVDmscAZMfT
	 2a3aYgSJ0Q5Ml16tuOojmNBPA4BuDSdqcmfrq1kAJ9FnD2pomBkzW5tyfdVdF1WhR22W8
	 72+cwFd3usaFsxnERRs+kYxZ05EZxQeHH2fEvY5DCMnatADBIGerxrlq7kg4/7bWx1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="FZL/4bYI";
	arc=none smtp.remote-ip=95.215.58.236
Received: from mta1.migadu.com (out-236.mta1.migadu.com [95.215.58.236])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53AE606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 22:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B53AE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FZL/4bYI
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DkefybD1i8xvQ56jyQ09h/HTM19UexBk7u12ksvN4Ok=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793916813; v=1; x=1794521613;
 b=FZL/4bYIYtPOxgYb2t6NdTInSEADFu24zE8bVTWhV8d7DKiaTGawM60fbUJSi3opG7QUYT7r
 5UnBWjhj0KMKMEeoUUIC+NFwUUQIA+EkX4eLPy8KMDb4oSee8lfUntIzswfHl5C7tAwIKFlgRV/
 vpx80WMwdwnvpLm0xvNOTR/c=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c3dbcbf73ad53fc4;
	Thu, 05 Nov 2026 22:13:33 +0000
X-Mizu-Trace-ID: c3dbcbf73ad53fc4
X-Migadu-Flow: FLOW_OUT
Date: Thu, 5 Nov 2026 22:13:30 +0000
From: Jose Fernandez <jose.fernandez@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, David Hildenbrand <david@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Krystian Kaniewski <krystianmkaniewski@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/filemap: stop fault-around when the walk steps back
Message-ID: <20261105-jf-filemap-v2-akpm-testedby-reply-r1-36ef39856b46@linux.dev>
References: <20261031-jf-mm-filemap-map-pages-lower-bound-v2-1-21029744e589@linux.dev>
 <20261102092750.e53073b2c7b872f9d70c0711@linux-foundation.org>
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
In-Reply-To: <20261102092750.e53073b2c7b872f9d70c0711@linux-foundation.org>

On Mon, 2 Nov 2026 09:27:50 -0800, Andrew Morton wrote:
> Can I add your tested-by to [1]?
> 
> "xarray: fix index jumping backwards in xas_find()".

Yes, please do:

Tested-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

I ran it under the stress test from my reply to Pedro in this thread.

- Jose
