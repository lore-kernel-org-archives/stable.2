Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317D73BB672
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791601567; cv=none; b=lrWF4EQ+XGbBIFR1rKJRhVm4rBsX7Bc3UqHq4z+xSbkQJVMhigt4qmAmwRMObxechgVbYLtvaPVvWf1DpbzSidFfWy9PaV3zd+lTNoBXHlqwb0i9wrhFA0W24kzwF+GSfOZMfUJCse9tcdJ9MfcKhl9Mpiy9/H/2h3USFUSzR3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791601567; c=relaxed/simple;
	bh=SQm2L1WnAvOzt9czOf54PXiFLVwKkZpDA3uUyWtGD70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSldkfGQvcXY7H008CJPyHNqk24k836Z50t62II21BgHkrE+zjeERFzmg/VyGkx48SsSb1LYKvCNEH5//a4jaSE7dULzgBh4K19SPp3qxMntwbM3QeYi04J7ErNGRTNboAdBGKZXn6nh5fUbfiLn8lWK69OFiUQsnQtR0iInmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0eWvc5M; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0eWvc5M"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4877837890fso237941fac.2
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 20:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791601565; x=1792206365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NUIEYGnE8BKwPbIYe8Tft2q9XP8PDGs7PYIrSC6//ig=;
        b=Z0eWvc5MzULkJiu7IRQIU/mzKL8sBS2sGrTf//tWJndgChQ0T72jdw36CdnS9Dj5cZ
         8pNDgrCDqXjTHqiLhk9uqe8hG46vgrNXu7k5zSlN7fSSFFUV9PFos9zQE/H7Y5Dd3LrR
         lUdEBuNet5v3P0/NS926bCn430i99IsP+yy7vg4NQzN0bh5juVVbQyEu1RwlE7FKRvbY
         LQUmn2asMlg7NamK/Q95FKcgIE5owtlUdLtJ2Av+Ns6kBemzzcOMoAtppXrKxRvudLp9
         sGHZ3yDQXNcfF37bs46eByLxqyrtiITAnGwAxtyBBomJknTsFwCnGZcDKXyvU6YxtWcX
         b+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791601565; x=1792206365;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NUIEYGnE8BKwPbIYe8Tft2q9XP8PDGs7PYIrSC6//ig=;
        b=i7pFEzMnxG9Rrsu2F2CbEVI+/QfEelm7P6ZJIVjwse6cJMD3yfnEC1EGvErjpJEQRb
         1d4aPDySptD+myVovOaONMh+OnjKSaiZV1GzDfaGngQPxKb9l1w+pg/Xq+CvSHkDz5yi
         2vQZz5X14gjsqQ3+H9ZQ7szzAAjUmHDXn/SmjMQrImgpk/nNBgoxAO7+4J6iDlqgioGN
         Yqy7braszi9rJvycmIUWiBJponktnJYeGOq7a0FCE+OrOUfRMsTTqenASZ/6/Ke//31p
         hvdWvC1wEhqd7UMzAmpsMzul5nAjWr3Br1U294G5+GOQiPeHC+ul6qXgBGcTLiiyUmLo
         nDUA==
X-Forwarded-Encrypted: i=1; AKwUvByPgf05GZrvMr4EW4huUsk2umET6LtxMIjbMBCZ5V0EeZb/VYj/oWJd1J6B37fI7lo9nuzuMO0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwolRFzqxM3vZg+hwLfqDyiu6rndWN5SPBpGdpYSW/nd0kWvcJ
	2a9KV4Tzo7hw81aFuvbvZaSGC+sMvTmVZQz/JFanya7cw+LcLpM9INyJ
X-Gm-Gg: AYBFou0ryRPy6lKG4eRhb7fMdg3KzoIGg9cqg3GMb+NV4TlQ2pA+/K1hoseEez5VJaf
	iBzZUCZpB3zRydHncL9RV8tQckldGH9aTALiArdI2xXwz7QdlTcY8VX4pX83Eep9hGlI02Ycf+M
	rhA/MCJ3MZAfaiNmiA+hWg7+TfBwh2sHlSl+0vRkUuPUFGciURtjdqbA12N7wqeALBa5IpXQyAC
	L6SWWI8SIADTvQ0l9HDZUvfHshKKJXpxzyXR2FQwWLUwNwvO9y9dCoh3SfIsDVzIjXgY58ra3ll
	N042NI7RY5Upns6wPN6/38NsW7jUZYNr773RckCNDkkYzAUHB3293ssiXXZt+58Ne43BsszP+To
	fiCJYMqP8zy1rHlRPSXG3SV25V0lUXuYWPz9uaBgClN4lIhBlTYWu/N55ZLFAsoSFROnEdyr1eh
	Bs87lchLTm4GY+ia/PsUjL79hQP+voMt0a7qpl9nHQvWRTy/5UscOHhK9R71bhM0A0HH+gK7eY3
	CE3UrOZBSrahSaezu357xptnkQzLf+7LDUp8jOn+2G5psnMQw4QtZWrSm2lLLkBm4cAl2i2IkhT
	HtZJ
X-Received: by 2002:a05:6870:e08f:b0:491:47e1:6280 with SMTP id 586e51a60fabf-4a2a8938915mr3416608fac.15.1791601564761;
        Fri, 09 Oct 2026 20:06:04 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a85edf81sm3689450fac.15.2026.10.09.20.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:06:04 -0700 (PDT)
Date: Fri, 9 Oct 2026 22:05:59 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Wen Xiong <wenxiong@linux.ibm.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: run the hw queue synchronously for unplugged
 scheduler inserts
Message-ID: <asmrlzbmQ0TU3rO6@fedora-laptop>
References: <20260930-bug-blk-mq-noplug-sched-dispatch-v1-1-ff1e49e52b00@gmail.com>
 <20261010023548.3666200-1-odys.yuan@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010023548.3666200-1-odys.yuan@gmail.com>

On Sat, Oct 10, 2026 at 10:35:47AM +0800, Qiliang Yuan wrote:
> Hi Jens, Ming,
> 
> Gentle ping on this one. It fixes a v7.2 regression from 9cbbac29d752
> ("block: Remove redundant plug in __submit_bio()"): unplugged I/O to a

It is hard to say it is one regression cause 9cbbac29d752 is doing correct
thing, and single request isn't supposed to dispatch via plug list, and it
only recovers to previous behavior before 060406c61c7c 
("block: add plug while submitting IO").

> device with an I/O scheduler is now run from kblockd, and the kworker
> preempts the submitter once per I/O. A single-queue null_blk device with
> mq-deadline drops from 289K to 193K IOPS, and a single-queue ublk device
> from 265K to 113K.

For both SQ null & ublk, you can switch to none for better performance.

> 
> Every single-queue device that defaults to mq-deadline is affected, so it
> would be good to get this fixed in 7.3. Any comments are welcome.

Not sure you can observe big difference for other real SQ device.


Thanks,
Ming
