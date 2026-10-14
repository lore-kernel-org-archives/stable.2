Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19702541E7B
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988209; cv=none; b=oTLWZZ2NRYPw+c/pp64/2jrzThhISQ3VGHco0QZ2gJ5tMYAvQi339axAsdI7cOQBoHdDVQsN2aFfpjXck8H1ZBJD/R1eU5VFSmNScKRv++FbM35pMazEXd/hEWh3aZWDVMxefMKVzqyLFBp0ZXbqlA0W/jbCBdY/1RDBMYFyqtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988209; c=relaxed/simple;
	bh=TZu1ogCR9/Yc9VSUls35zP5sygIEbTMRDEQIXAAp7gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SE21CKSy8vzCzupbzgKlqE4x5UwEK/EOqXjxN1hS6diGTiMZQpyKBsKsCJh4jpJnh5Q+4qekX1yRjwG340GCq5NSmifG1vILBQV5V4f6Jti1/GMQw/TSj9g9X4VPQQzqlmgV8hTPQFRUNEAHHGOr3bG97SzFkjzamk33xs9LTGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UV7I4xQF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UV7I4xQF"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso32559615e9.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791988206; x=1792593006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EAgEB1RSVFBt/ZrZLJNRHgb7cf1jvPPzS0HkEoz7fIY=;
        b=UV7I4xQFWgOoskqVx51R4eYMvbNTN8J3uZ2X/CuIba++0BprEAYRdJtnmV0SfqQHl2
         gS+qz81H+w9rLqubSgnpNvbj5Wm9ebj0AQhui+QGGGlzsYDxEr0KaBUKFMe+0A9NMWqM
         otN43hCEwRaxfN20gFV/FQPOG0FbSFb8tFXNRCigB7sPBVxG7wxCA+87lAlioqxy7ipk
         q9nsaXKVTeNCys8a3yCj3oytt/MZYtuf4qo43BST69Etaf4Alq1RXbyftNNlZSyKTkUe
         wsE+Y1cCJ9jU1sCwj7GCOYHooNgSzhk3rn2nF6NrJwZOpgCP6NY5TvHCqauhu/wK8NSw
         ob6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791988206; x=1792593006;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EAgEB1RSVFBt/ZrZLJNRHgb7cf1jvPPzS0HkEoz7fIY=;
        b=ePzTHBBy89slkKxgfWEVXNelGwTPgIOYOiYvrKwpr4UgCQPriq1oqQZKJJdX9crMc9
         Z5tlj1G0dfTxkklJjQqLWxXPsg02r4UKqYNXCOpIrPkrAksj+dUdXGAD5bgofWZ9fcLR
         WZr7vSDJtTHOArXRyATuNIcyiQTB8mNm5XvZn5YXgQrrrEW/ej1E0zba2YHJZDI+Tqc9
         hXjgghhRiKgR+0ID4UtXqDiKlGadGf9wVYj9i/j8eDWLsgqbRGTsZtCDfPnF1GqBJldz
         O8PRJjBetuzKROxpoTbuWURFF5ZQ/F9a/S48KpGgQEonq3flz5z+jqkSaDdYUrBSah48
         j+dw==
X-Forwarded-Encrypted: i=1; AKwUvBw0bHm1TTUP1G7Gz5+sxcA2S0OzubbxhT7kL82QU54Dte26V7aNLfgUijo6ujyST/KC5FdgEHU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJz4QSIcnST/RAb8grMoR8e4f6FShTqc7P8rdijweNOBfhReEqU
	1ChP1JdWoHh8DDnqHjEyRENR6m51ExBx1wI2gQ/9Yea+sRH7BYuCQnAcLeoTmw+WzZA=
X-Gm-Gg: AYBFou3MJr/I/7MoQ2vpyr0wtjiiXrZucGJr+Hx5/I/0WomFIc3cgMlvD33yIbtmMPv
	0X6IYe8mNZe130r0WlqlFQwQ1xz3VcUuDH57hh9G8aX6DQ78kmjrUgLu5mmVzIaew14rGamAUSB
	vH7besmGx0qJvHv1y9ebYDD3IwUscUFXy1rPkm9OZikI0LI/yV+MeuH+zlbPy4ETfPIreZAlQwV
	rLH1d7GDtBWwG0jJiZtithiqaZpuV9jTZM9OSNgo1tlTSpPG1G6cbU0Yo5lgOOdya8MgOtsHB+E
	l425ZXPWxMjUeAyPWYtdnLcD8taIrOeRR6dhNelnYGziHqMi6+lG1rhlPSYX86B/vPhupNK/rCu
	sAHH8ij9l30D2m3Yg7+4SQIurMDw9JyjrFmeCLCsp6KVTh6jWjNuhW+h8eiRS10JVWtlL0v5gVY
	ZjWp+g5535nZgNFcYaqEr51nzb5GfUwMp+xDFtoF7aygzDvY7mjujvYwQAMH5bohG/MkrxCMG6O
	Q==
X-Received: by 2002:a05:600c:46ca:b0:4a1:7a1e:6910 with SMTP id 5b1f17b1804b1-4a18e48363amr323662825e9.4.1791988206222;
        Wed, 14 Oct 2026 07:30:06 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bcf11edfsm4818345e9.3.2026.10.14.07.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:30:05 -0700 (PDT)
Date: Wed, 14 Oct 2026 16:30:03 +0200
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, petr.pavlu@suse.com
Subject: Re: [PATCH] livepatch: Fix races between stack check and module
 load/unload
Message-ID: <as-R64i6eT-8FpJt@pathway.suse.cz>
References: <20261012140546.154730-1-parri.andrea@gmail.com>
 <alpine.LSU.2.21.2610141410370.16733@pobox.suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2610141410370.16733@pobox.suse.cz>

On Wed 2026-10-14 14:23:50, Miroslav Benes wrote:
> Hi Andrea,
> 
> Cc+ Petr Pavlu (you can find the whole thread at 
> https://lore.kernel.org/live-patching/20261012150758.207983-1-parri.andrea@gmail.com/T/#t)
> 
> On Mon, 12 Oct 2026, Andrea Parri wrote:
> 
> > Unloading a patched module while a livepatch transition is in progress
> > can crash the kernel in klp_find_ops(), called from the scheduler.
> > KCSAN reports
> > 
> >   BUG: KCSAN: data-race in klp_find_ops / klp_unpatch_func
> > 
> >   write (marked) to 0xffff9094c09ece10 of 8 bytes by task 381 on cpu 2:
> >    klp_unpatch_func+0x1bd/0x280
> >    klp_unpatch_object+0x6a/0x90
> >    klp_cleanup_module_patches_limited.cold+0x4a/0xd4
> >    klp_module_going+0x54/0x80
> >    __do_sys_delete_module+0x247/0x380
> >    __x64_sys_delete_module+0x39/0x50
> >    ...
> > 
> >   read to 0xffff9094c09ece10 of 8 bytes by task 146 on cpu 1:
> >    klp_find_ops+0x55/0x90
> >    klp_check_and_switch_task+0x228/0x320
> >    klp_try_switch_task+0xb4/0xc0
> >    __klp_sched_try_switch+0x9a/0xb0
> >    __schedule+0x60a/0x1450
> >    schedule+0x3b/0x100
> >    schedule_timeout+0xc0/0x160
> >    ra_target_a_loop+0x97/0xa0 [klp_race_target_a]> >    ...
> > 
> > followed by
> > 
> >   Oops: general protection fault, probably for non-canonical address
> >   0xdead000000000110: 0000 [#2] SMP NOPTI
> >   RIP: 0010:klp_find_ops+0x55/0x90
> >    ...
> >    klp_check_and_switch_task+0x228/0x320
> >    klp_try_switch_task+0xb4/0xc0
> >    __klp_sched_try_switch+0x9a/0xb0
> >    __schedule+0x60a/0x1450
> 
> Interesting. So to sum it up... you load a live patch which contains a fix 
> for a module and while the transition is on, you remove the module and it 
> crashes (btw, I do not think that those traces are necessary here. More 
> btw, it would be nice to have a human readable changelog instead of what 
> looks like AI generated description of the patch itself).
> 
> How did you find the issue? Is it a real problem in production?
> 
> I wonder whether we could just decline delete_module() in this case and 
> return -EBUSY. It should be a rare operation anyway. Alternatively we 
> could increase refcounts of all patched modules during a transition and 
> decrease them after. Petr P., what do you think?
> 
> I am not saying we should not do the RCU protection but it feels like a 
> can of worms a bit so if there is an easier way...

I agree that it is a can of worms. This patch is not super complicated.
It seems that it can't break anything. The bigger problem is whether
it solves all possible racy accesses. And how to prevent regressions
in the future.

Preventing the module unload during a livepatch transition might
be one solution. But I am afraid that people might want a better solution
sooner or later because the transition might never finish, ...

I wonder if we could use some more strict locking for the two
operations, e.g. (raw_)spin_lock. And then use

		if (!raw_spin_trylock(&klp_unpatch_object_lock))
			return -EBUSY;

in klp_check_stack(). Plus take the lock in __klp_unpatch_object().

Hmm, we could not take the spin_lock around klp_patch_object()
because it does allocations and might be running for a long time
when there are many patches objects. But this might be avoided by the
smp_store_release(&obj->patched, true) trick.

It still might be conceptually easier than making all the
accesses RCU-safe.

What do you think, please?

Best Regards,
Petr
