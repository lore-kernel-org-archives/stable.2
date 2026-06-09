Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14672F83A0
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969522; cv=none; b=hGTe70/jpFv6qIts4/pz0y8iLKqWEKAqv1L+6+Tfv6GbhiwWx7W8pnzxuyQDfUoSJSCz8+xV1QB0zVZ5NKk3mEZOo/lWFGCF9E3hK+XjJaGTvxkmnbEI+1mfDMt9PHzfeZrnuMnCyCm00YR7a478/aA9GziZv2H7dn46rcGC4sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969522; c=relaxed/simple;
	bh=6O8YqZs6YkDTVZyHdWn88TRHYchEYKKdHFjvaz5OpCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9gMQ36411uY+AUzvBWfnAK1VeP+dlUq6ZPBgQZv72QgV/H4Y59Kb/1zHjXq2n5/S+6bW41IWvVS5fvSkn8CPLe+oetUznDViAtStpQpIYQOscybDbdxP+qEKH5uMe5KbZkyZGXVNgEvMtpCLI1gKoMBNmOM84efi0rKUwwxYFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FpisHdtb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FpisHdtb"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf2d865383so386215ad.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 18:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780969520; x=1781574320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/wdxfyH4JAOSK4spHVo4nmbREVFxJGYB6KTPGdKO7A=;
        b=FpisHdtbMCU3QX2sPKmuCROGv0IH9yLmuPNgXMkXXY+OJ/yFS4iy6f955mjFKdmgZ4
         Wmr4NyE4gBMgVUzo8WwaNZcNnfH75Whatq+JIhM1q6Kuk8LBVR6V/czSI4RG7ClKjxwb
         GJXu4Q5IGGSINZBm4I0QisCL7T+pXzBT6aaEk0uJ07XNIpOuhr/s48NHnIkHjBxMBfci
         lIYUxRbelulL6DSu0H1KnhwyxBGtu5juYuvGRe5m9nFc09GLgg0eg1sC6SGr5e5jqyA0
         X9/yVh93EuAPBjP9aKVz40kxKzIiz4deDs7XbibjQnkMVNA6UrHYSzwYX6yalGNF4Blt
         ioFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780969520; x=1781574320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/wdxfyH4JAOSK4spHVo4nmbREVFxJGYB6KTPGdKO7A=;
        b=EHN0hBQPZuNPncQU5RdDzowa5ToxL80dRRFbDIHCRaVanvWUwZ/TAM8dOtloi/waW2
         VobAmz54oBJPf1g1c1ixBDv3itTL7TZEU5cjIWcFZCuORfVqShiivLsoNDk7CYVm8w7d
         DEzr4hiE3Knw/bG4wNwDMWpJDR6nhH4MIezteWNd6HhRC60MRvxwN3vKszHj4wADajHw
         WtVCH48fV3bGbXKcQjg4o7A4jhryA0ad57oWEd4JjGy6qMIjdW1ctPKvmXxKBbCdBfdp
         v4aYfbCX8DHdtgmzqICZq8zBp82eXKcYk7X82tT6rx8vMaw/9kZc54J3DrNWVHeiXAQU
         f7gg==
X-Gm-Message-State: AOJu0YzF74bjbQmPJOBN+OD9NCiBpytfmilHyqVmxeIPySlGY3Taq8NA
	p05xyKxzNjvid93UVbRBV8UWP+m7WTd0Hue1GzfQSw6tBNrgpfqypeoYjFaZH1M41w==
X-Gm-Gg: Acq92OG6gsLyqpjDy2XAwnBgBeIKf/dLcVkFNBteEN9UaMgZ9p92tLZsKVSGtXbphYo
	dFEGmdRonkuZ5a5gzvV53Dhz8okTQdB1XNITw3tsefQWN4DKg6hnbW4XxCh+WBp1skOpI359rL3
	0Nk7NhY3HF8Wbj14l73XhwPqGju/RCyDjR/w75pBd/jw/8ydZ4zqvBkX2I2XFcEATsjrdN8ogmv
	S9A2/FK0l5JELyJw9uzh66GjahhRrxvIfElUvlqKPUEBvbmt4l8p5mUyVMlmngpHhKF0EUqcx+h
	9whKirUuXUh4Y37v78tODpi7cmR+etOSKIR8zbIufaKzA2C3vlIokchl6csEj5Lasu9cM8aU8z7
	OVpWX8vyKe0XZL24gsWLI8I1GlSGYE5PZH+rThuHgpYL9Rj/qSFwQpJjmk++JGG/LKn7bFY5ebJ
	u4AjO9R+oBmAZnpeG09fnS4zJRJQyzMM2Nh2XIjcXj+oKghNU241MHUNgKHNw+UjaSqXFWO5mVl
	tVzKzSqcD27+zRuiqxr7FOrF3NQtKW/IWbbo2b2JuAStoyZYvSPRrqE
X-Received: by 2002:a17:903:11c6:b0:2c1:4228:3321 with SMTP id d9443c01a7336-2c1ebb62205mr7223595ad.12.1780969519693;
        Mon, 08 Jun 2026 18:45:19 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f68b03ef6sm17613184a91.0.2026.06.08.18.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 18:45:18 -0700 (PDT)
Date: Tue, 9 Jun 2026 01:45:14 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, yichenyu@google.com, kernel-team@android.com,
	Johannes Berg <johannes.berg@intel.com>,
	syzbot+fd222bb38e916df26fa4@syzkaller.appspotmail.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	"open list:802.11 (including CFG80211/NL80211)" <linux-wireless@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.12.y] wifi: remove zero-length arrays
Message-ID: <aidwKjYHa2yQmxsv@google.com>
References: <20260608133216.1396790-1-cmllamas@google.com>
 <20260608-stable-reply-0011@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-stable-reply-0011@kernel.org>

On Mon, Jun 08, 2026 at 08:51:57PM -0400, Sasha Levin wrote:
> > [PATCH 6.12.y] wifi: remove zero-length arrays
> 
> Queued for 6.12, thanks. I dropped the leftover "Change-Id:" trailer from
> the commit message while applying.

Oops, sorry about that. I was working from a gerrit mirror. Thanks for
fixing it.
--
Carlos Llamas
