Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9F73DA7D4
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508133; cv=none; b=eKoxCc1ePhcIfxgAAdazczvePgkOTj2Eht6QTKjAuvfrI7/+nMc5cue+XMBepMTzNXees/KOUDuPpL2IazfG4uCpOwL9QZG1WCPlNUjohkKeG0i80FgaI0oeVHTF73Oe51kWIiNQO6T5ErnHGzzfuoALT+Ac2y5I/aK8zD5hwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508133; c=relaxed/simple;
	bh=o7h3INURFTfXK6QgTDQq4IGKVSWPwgcwVnzFukZs7QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKUT4SMQ4+gv3wqpRliURb7pGkzuJW/OHmDOLpLgqhX6LV9iPTZmxnwnKOESnJHzy0my6/sQuTRcT3bZ1kxJO0QUq6s0vskThVqmuVT0qqa+Gy2iUyngd7aaUB9OcDMcvSppSHGe+OiXWjtEGWHAC1nkK2bWKoQz3r0XwBEwXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F85KWzCT; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F85KWzCT"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f91so101931f8f.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789508130; x=1790112930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lIdvdTzoCaqdSuezaWsjFH+gv+z5XekzXwYZss6OlpQ=;
        b=F85KWzCTp0WTEznDsdYJru0PPAEkJEf2yur/XqR2Ny3tOaTXw9L6rsHgH2WUaWSmEi
         T+RIP1/hoMrimn2/nyFwN71bbAqBL4ttnK4EGsgDmYEfcZNf7ojieWqo1NGfyRnWphJY
         4CnjOgJDukdiS5nxd9LAjZeDuE3YZq081j3HSA4w+aLgqOd0Zk6WYrpGoCK/D/1dlu6I
         judXfDcvhgQg3dkua0i8UA5tc48lwBpYO1tB1vI0TBUwsvNCfIgO7fh7AIsA4OKBuAuQ
         UOqeahj7K/2rXo7ULPJJddM3PzO8uQXlpR9kXomUryJeHN/RbxSuiQFg99OVOCtOLMe9
         fnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789508130; x=1790112930;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lIdvdTzoCaqdSuezaWsjFH+gv+z5XekzXwYZss6OlpQ=;
        b=1zDSGKt92zasrklM8zmtco7RnbO8l4TZKOPzw2OIHKPgIJhfoqRAmjl2ByFyebX7kh
         etB7wEsPz9bZeZ/N2RelvpidVv6b62hSS3+Qby4y7zr6xcakM+0y0Gh7w/1RIlSLzTmQ
         gdojVz0nNyAVT8sqUBa++XyhKcuKMKqqCcMrTp3L6nbTq5YrO28Ac29BjkxJ6VW9IJNw
         au4Xzszfbb7Zu+/10mm4TtEUhtTCZy+CiievmKk0v8YAh4fUDyvyZLZgYlrsDTkPCVMa
         4mu3soYM+crfBd9BchpA6Xjp7u1uM4UKww1e8tgLj8n1GEomZ7QNglu6NsyCnGvGeSJj
         bkiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJqqNtFHd8/YRXvLwFCMb1IjVq/65LoAeSA5VlF9DDOQr1LRynfVBcbES4QDDp2JyEyScpJGM=@vger.kernel.org
X-Gm-Message-State: AFuF++n7COeUQW1HLdRhgGn3SiMovyqLmIBLcqEobUD8vE9WBY6Bb6Tj
	f2b3MU8cX3HuLhFhlzON8hBdOaohbUUGsdUactCu4T8Czw7c+N/we+Oz
X-Gm-Gg: AYBFou3CYu9W8gEioGCBRng7MFCEfmXWo8CfS4CsBXUWWwDYx9Xa8d2DwWZPxq6QNwT
	xEGXEezm9yte4RwYw60iAwL2LryrE0q1BaMvkBG/9xLCxqSgi6TtPA0v2DRI9gJp987BR7mRhMO
	u6N0T96LEADcTAC6WVv013fBdKU2z871zuBCwL9sbMxQ1bzjotTyEfqlUAUqgOC9dEtZcKp6unQ
	yZAyPbXQMorZ6KRhBqrXqx3x4hNyA7bhyi9QEdZSpMRqQZ6dlZBzy5VuWVYoSGmurJhJu20aTGP
	GJhsgtJicjPwt9N6edxVcLaidRIVcJW77X0cfSuDEprkmTWDfdYXZU27GjOGRzcbAOl2J9a30CD
	IAmH02yvNydISbGuVsO84IJkjR/ZU63p3tRKhsa6YgNMudO2USicdlbxk8jdFooLrRGG//jEFcs
	9v/dxId7K3He7GTHe3gcPHaQHmUHODZg+MJ9oJXuRbC/+9k4qwc+errcJrfttH+ZJpsp0I5nCwg
	KMQbUZvlxQ8YtdWWaRadC0p0LcK2XniuyhvPqLerjPY4ZST60C4n9Cd5oIed4Ws2Kqk6qHvh1rS
	Y6pRKhz/pGAKKT32dtn+TIW3vq8H1ILWIeTQwsEA8jlbCQZX7KOXDJAu+hKgJLtLfa9Q7lI=
X-Received: by 2002:a05:6000:4383:b0:487:8ec:1fc with SMTP id ffacd0b85a97d-4870cf09c40mr288821f8f.12.1789508129738;
        Tue, 15 Sep 2026 14:35:29 -0700 (PDT)
Received: from MBP-von-Karl (dynamic-2a02-3100-afd5-c801-ec9e-1a2a-2fc8-3f88.310.pool.telefonica.de. [2a02:3100:afd5:c801:ec9e:1a2a:2fc8:3f88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf344fcsm2047321f8f.26.2026.09.15.14.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:35:28 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:35:27 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, patches@lists.linux.dev, Edward Adam Davis <eadavis@qq.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Subject: Re: [PATCH 5.15 879/935] bluetooth/l2cap: sync sock recv cb and
 release
Message-ID: <aqm57oNzuXR8EvN-@gmail.com>
References: <20260913202907.3100-1-kmehltretter@gmail.com>
 <daily-reply-0008-re-l2cap-recv-cb-deadlock@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daily-reply-0008-re-l2cap-recv-cb-deadlock@kernel.org>

On Mon, Sep 14, 2026 at 10:03:24PM +0100, Sasha Levin wrote:
> > Please hold this patch unless the applicable L2CAP hunks from upstream
> > commit f1a8f402f13f ("Bluetooth: L2CAP: Fix deadlock") can also be
> > included.
> 
> Separately, while looking at this: both 5.15 and 5.10 carry c531e63871c0
> ("Bluetooth: l2cap: always unlock channel in l2cap_conless_channel()") without
> its prerequisite, so l2cap_conless_channel() calls l2cap_chan_unlock() on a
> mutex it never acquired.
> 

Good point regarding the unbalanced locking.

I believe a backport of the applicable L2CAP hunks from f1a8f402f13f also
fixes what you found in l2cap_conless_channel(). I will test and submit
that for 5.15.y and 5.10.y soon.

Thanks,
Karl
