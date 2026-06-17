Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CEC3DD509
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691134; cv=none; b=o/S+7eekCXKtVBMpXz6O1WRYOJP0O1/r1XRAzMa5x3xjqxSSATAjcX1vrkNfqFI68oILr2NpMoHoXhCV3Bt4F0mZOb87oHdakg0iqYAURSfzUqaxaBmolX2853bj5fzFweBI5azndifd2emY0CgUfEP+rNjbloGtLOxFe2DxBw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691134; c=relaxed/simple;
	bh=zqiyKisxnhy0xgzQCFdf1v6HFhpfFmktZ4vRlTJ1+Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IANqKcN6UKTufzjgPaaIKJ0sVWXxWUvLBb/YjLF+5IdfRvavj3vuNLimipEDZf0eLpisITQVTlrgrfHHz9A5lMRbGB4Vpdxg/vSigVB+xhH//OYXrcVVlqEfF7Z+IihAlIDl5TT5Yl+hFYBBlfNe/lS1ImcaZn+yKyMlod6RBfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aVNC3uOY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aVNC3uOY"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4908b92904fso69236345e9.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781691130; x=1782295930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9e/QpG56/O5B7hSvy+0kATSJ4lRQbuxYrUIyg9GDMZQ=;
        b=aVNC3uOYxjkigJdmFFgZzwQIAsMOd7t2U9Y9CxIRKBiJHROx6zN1bkNFmyKZq7D6bE
         rhA3HFT6VVTz/Of1zcXQ/O9To9BVF7w5nu/rETdfvabpgspwdHah6IoUcLXSZReKMNik
         0nRNo02h9ofSWFLhFY+fJGkQEOgPhlld1fpfcYRnZAZ2R+xXdc1YQtgMczTO+kUtctqJ
         Ig6gpYl+468auogQ+z5vmsQoXeTQj41CPzvLrKeM632JVK7AUk0OFU8TRm8lpm/eAwxQ
         pcuobJZWHmNLtS2TkJKJzy3vRAXv4tDIcmooP0up4aWeHLAUlaHJn2nagqPE6pKMEtS8
         iuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781691130; x=1782295930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9e/QpG56/O5B7hSvy+0kATSJ4lRQbuxYrUIyg9GDMZQ=;
        b=QqqMh1KU5LcIwlElcK3H6PwO8iBP/HOhGcpAcTg068BITNBbFjzvWN3htphtmP/2rg
         CdaULKUFbYIswlLzmb+B6bRM/G/GbWGdTa2HTSiw/1EkGLyAB9z+Juvd/A4DSdPaAxAJ
         Fy/Adzur81ahnwAFlDAQSNoNEh9xx5PROkXdpUbAdChe5Pfat0xGlFhivyajn6KCARem
         bpxByDgQTXmPBnsMADumsYQYS8gclnGQy8nZTItUFdscKmy1den5wCm6c2ewysofCBhi
         mebSr5k1HQVThtHuSGryQEW1mgqMEek3I7Fi6ZaDXV/u5guG5edSueOzwbKegmPPb/8N
         9jaA==
X-Forwarded-Encrypted: i=1; AFNElJ8EeD7+nZ/nFeDuc+g4YPW4hNYxmRgxr5gvi+qrlXb3Z+8owjd6T3cW3kQfQmOTVTeB8Ojd7Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXzcXQnmFr/uT9VNFeJR9AJN42Pr1l2VCRZvYsTWVOPzNEafVv
	/3jq5XuLrqF0VGulAgD3krjSuAvQN0glNrihLQ16Es3Aur3DSm/0Hv2WEv0W2lDGU04=
X-Gm-Gg: Acq92OFLf/EfnIO5BVXFzLYY/9MqOglomIE3KQ2fMRgexjrEQjQFRhsxGPmIUaXxiLc
	p4VzM13uZo/CXZCS5JOuMyP6kZ7NnNhrdx+SINb5RVFZSxeGyv4g3n4x9IccF6PzDmhzjl/Ar3x
	D2nwQjAhH07CN+ERclO8YcN8amUjjEhpMPwlb7loV2QwZY72I5Xw9vy+zWaTUkFvCcJ+5gGfk4F
	F4Xj4GpzzGwMvGyYLlL+fp3KOj2bBdBYcSfbedUi/XcElBuiaeAco8Cg3quQ92rotfLSBzpw7RY
	yc0FPyObnEpzgA4xtGWgzABP60nQLgERz8iuutrjBQIQI/VwdFrgcNr2zQ18CSetvFJCoLcH/8v
	iDNLtO5VgBIY6N/BRezxp1B01YH00vk1OkGwUhXxMfL3rioMq3bhh19mQLl0Zqk7BF1N+k2Cs7r
	sdIJ9sbiQRsxuc3eY=
X-Received: by 2002:a05:600c:470d:b0:492:25a1:e2f9 with SMTP id 5b1f17b1804b1-49234131e65mr39184075e9.26.1781691129811;
        Wed, 17 Jun 2026 03:12:09 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923686fffcsm1799745e9.0.2026.06.17.03.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:12:09 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:12:07 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlad Poenaru <vlad.wing@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Message-ID: <ajJy92ES-Q8ro97A@pathway.suse.cz>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616081128.04e2c8dd@kernel.org>
 <20260616153122.keHMKvVT@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616153122.keHMKvVT@linutronix.de>

On Tue 2026-06-16 17:31:22, Sebastian Andrzej Siewior wrote:
> On 2026-06-16 08:11:28 [-0700], Jakub Kicinski wrote:
> > > 
> > > Adding sched and printk folks for opinions while eyeballing
> > > WARN_ON_DEFERRED().
> > 
> > Thanks a lot for looking into this! To be clear - the printk_deferred /
> > WARN_DEFERRED would be just for stable? Or there's still some
> > sensitivity even with nbcon?
> 
> We already have printk_deferred(). WARN_DEFERRED() would be new. I
> *think* this is not limited netpoll/ netconsole but all console drivers
> not using CON_NBCON if the printk (via WARN) occurs with the rq held.
> I don't remember all the details but printk_deferred() was introduced to
> circumvent this until printk is fixed.

Just to make it clear. The problem with the legacy consoles is that
they are called under console_lock() which is a semaphore. And it
calls wake_up_process() in console_unlock() when there is another
waiter on the lock.

> Once we get rid of those legacy drivers and NBCON is the default we can
> get rid of printk_deferred() :)

Yup.

Best Regards,
Petr
