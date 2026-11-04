Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836004;
	b=kHi0joVUQwPEQMpwrdwaqlFx3izEIynQAVsoPtSNy2nUOILtGhPBW/lorLvKwF3BOX5R
	 5XXJ4RDmUaiS/zaxDHJm86A9IImayutB7uKASSi6fUsAgFA2rwqHKpzZCtwIi3HTBt4Z3
	 TlgAdUck+31XffJ9owlDiEnLAxAa7+3bVQhnwcR+hbtDNMJt7zprW4VW736C3+thC9Rvz
	 l1lhvGxirSRMJWzkqvrh9Zw0QRiC5KJ3KU/HWpBno1nfs+5jaJwDUfHNwFDcNY5wcx4Zn
	 YgMSAO9pihcbYXgUBSheP7YWEsg+34ZStSzTIPJwF9YqKzWcukjqnJJWA340h3JbWvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rKToFDzUi6qhaHyBZmmLDL7zVXQz7iwmFV5QQTYo7qQ=;
	b=KGt0ueMIRkMCTO4jVNUgxnp08DMinL7ClVN7AOc/D4FOx+mkmuZ/nvBS5fulHlmBUPuN
	 IndetLXGR6hAjL5caT7IIorV4OP9DUiCFSTGN76CCWwipPecLn3Pz6ZL7dh00IQkkOULu
	 1qspjioZtlTlv85tL0Un7cR3OoUuPK21pUb4lMrxrzTLHkuyOhht6Dyp1N0ajHmNnQhRt
	 Nm31FK4Tf0+PPjvLKFJA1dznvaxelT+3ezBC0ha3RcQk1RRgFqIORnapcGiGcAb37mjHI
	 /EcPigs2cM+LOXa4VoXGXYMcmhelFOQ/SyoEMI5XjBA3i9p6f0/Mv2kHsaZipcVRGdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v4qTVCCb;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE63606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BE63606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v4qTVCCb
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3514b90bb89so2435391eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 15:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793836003; x=1794440803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rKToFDzUi6qhaHyBZmmLDL7zVXQz7iwmFV5QQTYo7qQ=;
        b=v4qTVCCb7VVhal+oXEIMin9L6U8kT6Yq4/927OR1/wzDyR0v3HuXZSR2FHrMyKaSX/
         ivFqQMctHdPU8OUU9Eu8c1vow2qmhP8IvkXOstT5ait5IWGPdcTK5G+YFV+HRl2/9BKS
         CWTSW7yjW3d/J9mRK4ps5gOToHcdSsfzXBjHHgTS33iOC8jJes4c+rW+6mVpjdhvUuUV
         xysT08LZGEYTQHR6X6wiROX+YZMmlnvq0EV65Irq5uyTRs0B34WY0FKNKPzaHyKkOPOz
         zcLR5TuJ52uS6UxKQW532KJPui7tjFGg3ilYtOkQuDwE4VNcEnOYQ5zfW3YdTNS85Tgo
         dwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793836003; x=1794440803;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rKToFDzUi6qhaHyBZmmLDL7zVXQz7iwmFV5QQTYo7qQ=;
        b=xypIJ6KvDUi28/hM70XcDtsRwIqYCxjGSapghyr+jkMeRgX7bA2J7KujQq990oK4n6
         4fLuFqYV9SdbZmV+aR6VvRDPARTUr5UECr6pFQ+Ch8uWg8s+xRdqpPCAaUpKzh7YJhcw
         HYqlYc19maid/M3cvFYl+qYXjl/HkhEiDvYzcIC0K/EHEqs0PI0h9ehKMGkW1vufhxsc
         zQI0m5z3/1C+I9Vxog7ZSwZWerYX10S+nOugPnMtHkLTQtU2f/6mSPmKfXbRbGcdj8Ps
         HXiVbRGBNSb4PA05Xsvxn+GHhBD5+QmFtMHKqqA8p0fdPAPp6R6AuuQNjQX4K+69yLQ8
         gdNg==
X-Forwarded-Encrypted: i=1; AKwUvBxSw1DhsL7NmJumZaE6TB/r1+iJS8e2/ZTnpxwrmz6K4JA0jbVE74s1fGDVHE7VQ4+FTaQmQaQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CeTAK1BEVrof0sR2aoTkm6kdlHlcHtxKvbRK2+lAurr9xG46c
	vtdqJCL5JpIqVLPz7OI77aKYiahtSSItVFXcVPyy0SF2cdT13Hrwg2XT
X-Gm-Gg: AYBFou2VM/FkVP7jnEKriAQseor+QUk9lcQCZHUWA8dqDMSuEGl4K/BC03vRQaNVgPj
	s2+zeMi4k9wYClKiZ4sfF7MWh0r2BzQ4n+8l2l6B/QPL34bAxsQF83Jam+wNIAkd6XJ3xtC9s5J
	AXEJLG7NGjj07oa4nSmugNw2r9R2RUVx96zLK9XyRMYYgl5GnKWVbEs/YHxA9WwD7g+1ccvq2/e
	jQodyA4MVBXh6+ZzVrM2mCgG7rHMPlkgdFpowY3e/Wxju7t/cQCAKqTLZJvJfTmde32RTjqNGG/
	A7lYua0D+fuyubP9ovGjkE1kiRPswjW8wMFEXFSJuAWfcPQQWonx69TcmBqBrUE/4TTr5gIQUQj
	oBECQ2okdfl9/+WsPR/3nIAp5AMtyQI/32Q/1mBOOHxXpZQFMGXy2EAOHCpX6S/AHECaajgmz5p
	r3MqYq2aTUhVDQVc2YtJkJog3MqK2MREiEoOH91VbNySMxLZFhJdaHIiwY29KOhuYRSkZ4/LVBK
	LmBKBA2xXkIiMiVobtS580dAvxexLlyg0fNCwAEegJmJbahbC8XBOWU/rUJrBmVteTFJSjiZv1K
	2ng0CsPRLPFOTyJl7TCLEZS0QwxpKNEFwrJQSurPhgYsI44koTm34lt22Jji7G56WitaGA==
X-Received: by 2002:a05:7300:7a83:b0:35e:2c6:d46c with SMTP id 5a478bee46e88-36a42362460mr24871452eec.10.1793836003085;
        Wed, 04 Nov 2026 15:46:43 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm9855784eec.9.2026.11.04.15.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:46:42 -0800 (PST)
Date: Wed, 4 Nov 2026 15:46:39 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liuc63@xiaopeng.com, stable@vger.kernel.org
Subject: Re: [PATCH] Input: db9 - enlarge the Saturn multitap packet buffer
Message-ID: <auvD3ISOJKoQv0cZ@google.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com>
 <20261103084135.426629-4-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261103084135.426629-4-zhugl3@xiaopeng.com>

On Tue, Nov 03, 2026 at 04:41:31PM +0800, Guanglei Zhu wrote:
> The Saturn multitap path fills the packet buffer block by block:
> 
> 	for (i = 0; i < 60; i += 10) {
> 		data[i] = db9_saturn_read_analog(port, type, powered);
> 		if (data[i] != 0xff)
> 			/* read each pad */
> 			for (j = 0; j < (data[i] & 0x0f); j++)
> 				data[i + j + 1] = db9_saturn_read_analog(port, type, powered);
> 	}
> 
> Each block is ten bytes apart, and the low nibble of the block
> header - taken from the device - allows up to fifteen more bytes,
> so the last block can write up to data[65]. The buffer, however,
> is sixty bytes, and the six bytes past it belong to the rest of
> the stack frame.
> 
> Give the buffer the size the protocol layout actually requires.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Applied, thank you.

-- 
Dmitry
