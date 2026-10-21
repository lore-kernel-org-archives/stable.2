Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792624508;
	b=NujoK/MSVzmFkpy+qbHnfr4I9leR2/3mlEkFiNXutUCnSdNduOob1yiCyBWte79PWtWr
	 37q+xBaJUPNJKwS/oPOrvlMfZ83lbi2c1caZ8ylYy7EW4fQoNbiF0s8hm+6mWF8TGgNTM
	 uANAMV/APt7B8dsz118qT9DM0NNLte6TsmFnw0dr6+gYMi2aS8Z59Wc8CnPF+xUKwKmrR
	 hd7wY2k5vZqCpsxMFi4gjxKH25BZMsupKil+9b+nrK4b9wdVKBf3GKvaI9Ba6nQLWv5mB
	 YHBg6N/fSEwKjobZUThLcHzgbeqb7+PWkjrhDr0TiE++z2k9z1FBy1x5fLRcvazY/sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624508;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/7KJVKeGeRGSyQHPy7x4oaw0DqaNO6jqSgeT0PXKjfk=;
	b=4S2buqNgYYonHBVJGr9LTEIgmbYldSF+hjkXg6k1awzGWDk+hON4fo/BhLOsDzTkkFAO
	 enW0s2rGww43Vpv0tspMv3FpyW3n5+vYrp8KrC/rQ1LrMao4Ppl4wjD59gnKPl6rwtqWh
	 521EyjX7BWkr0eycc6vTLWJstrZZfvSz3nifF0+03iJLI+/dRQOcxqVlzU81jYUo0KrsV
	 FU0YjpieFsrn1JaXbqV2ACfe/0J/OyOdB0RLL+1yp0zUweHb8w/GeAvVRwkYCG8cHcLG3
	 C5xWlr2LBDOu2tCdHzdil7DtxnYIxSO2BVrVEfPG8ePhg4kie0QLJBDvbRfMiGB+exg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=M92pQkTT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72CA606A319;
	Wed, 21 Oct 2026 23:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=M92pQkTT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A8B1F000C1;
	Wed, 21 Oct 2026 23:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792624507;
	bh=/7KJVKeGeRGSyQHPy7x4oaw0DqaNO6jqSgeT0PXKjfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M92pQkTTf1ekioYEsd8uN2bo0UfKQ+GoiB6y+rYNS37ljVTFgL4xChk8ZvIYaYfgB
	 OUnpllaBNXx5Vg+KVU+JZHTbM6+J8qpJJ31Hq279oLqdWZwiMvbmLuh6A4QT3g0psK
	 lMRNDGErpLvAZqd5qu7hw7urhI0u6ldy2Y5EaEQA=
Date: Wed, 21 Oct 2026 16:15:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: bsingharora@gmail.com, yang.yang29@zte.com.cn, wang.yaxin@zte.com.cn,
 wang.yong12@zte.com.cn, xu.xin@linux.dev, jiang.kun2@zte.com.cn,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] delayacct: Preserve delay extrema when aggregating
 taskstats
Message-Id: <20261021161506.7baa42839def1312e177243c@linux-foundation.org>
In-Reply-To: <20261021010022.85881-1-dennylin0707@gmail.com>
References: <20261021010022.85881-1-dennylin0707@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 01:00:22 +0000 Hungyu Lin <dennylin0707@gmail.com> wrote:

> delayacct_add_tsk() adds each task's statistics to the accumulated TGID
> statistics, but overwrites the delay maxima, minima and peak timestamps.
> Consequently, the last task determines these fields, and a task with no
> recorded delay can erase an earlier task's peak despite a nonzero total.
> 
> Keep the largest maximum and its associated timestamp, and combine the
> minima with min_not_zero() since zero denotes an unrecorded delay. Apply
> this to CPU delay and the seven delay types handled by UPDATE_DELAY().
> Single-task queries still start with zeroed statistics and retain the
> task's values.

Looks good, thanks.

To improve understandability it would be useful to include a getdelays
-d -t before/after example in the changelog.

