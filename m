Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF4498904
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817688; cv=none; b=SunFifSVe8VBPeZjVk6SW5G6iXAjb8YcA6VesdZJ8CQSjC2X1istZE9aQdF7CiFlqW8YQx/XvKNWzEQGDCL0GnhjeL66Yn7srrrSxiw/Uep6GPi8jw/K/a1LTWac/GDTpIHNeX7RZWr3C9uFpSiCpvNabyn+tdKlUzg9x5GMKpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817688; c=relaxed/simple;
	bh=OsG9QFWVI7GlIGSTCxFfoFpAyRAObqzzGqmR5pOuPKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O//Ox2PHOP2VC+jdERGgN9H4sga9UAWFdbuycxec641HaGaZ0MLcDjvKSy1vQeiNTFbjiIUb6x2vsPfQD+DvnXAyYbsjYKM09snmbMtmtOPMHh5yBJ1UzDPhSBTp21allP2TaUT8VsWri1oODVE0z1J4R58zzRKAiweFp+ih/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anZN/cUr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anZN/cUr"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so15749245e9.2
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 08:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791817685; x=1792422485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AWiLDXPot0/+PbKR6u2nu/eRULx+LiAnb5d3+K32M2g=;
        b=anZN/cUr65LkXxTiqGKr0m2qcOVQReSICYH3a1YFonZ6RuwtdfQd4DeqeIGvJNU8lk
         arw9EI0zpIsMZBxy2GFjspH5c9J4PwWKwIZEbSkn+pluDxI4f7V2Lpqfibqnap+55asF
         AY8o3BhHY1iTXhViXwyBN3MlwoNJu6iGo0bMICZjeJghEBBWBn4KXpVnO6vx1YK9pXn9
         EwVaW7sSUx1JgJa4N6Z5N/9O5bP3zwaq/huBiT8AOEnHoH3IXWJET9BIaHInsa4NmqyR
         NeJBCeGHqi0j89Q8d49IoxMfL7CxBEggEqs2OL0Kwux7FH32/c0kzgXXrFyQmoHQICoR
         GnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791817685; x=1792422485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AWiLDXPot0/+PbKR6u2nu/eRULx+LiAnb5d3+K32M2g=;
        b=fWPtjXKm/SXffiGkfUDl3ph5QjASuqiOFhxj52NgBTOYtLt1NOPbhMkbPcRE1FhcZa
         sCTq4ra3PKpIOPBtDt4ULwaaGpsznVtKeXBmtqjapPbJpekI0X7lcMKX6QLgP6/8Dn1Y
         1gd2q/NFweki6RQBL9ZEQVmwKvUfMm5FiMLl00ujKuOUchF8+BLgZmtEFirGvR64X17t
         O8ua9jXGjRTqobxsHV5q3AIMtlcTMmpBhi7QobEwPhRx1tJsmB/qMChWBnFHnWLm+zFA
         4FVK/NbdFstmfGEz46Aia+YImGJcvm2u41Jd4EN/knEGssj8Ev/jonOnmnhvflWRe8zG
         bjew==
X-Forwarded-Encrypted: i=1; AKwUvBzxX29nhr6gfkAYCHS9iBX4O96HZaJm6SSHV8T6Of5CUdrOjWzhx8FvJhs88SFnjJwb8mNiU+U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIC95vGbmBoGrh6qh+dlgmBXOtbNtErd2pIDLG0w4/nBGR0rRUs
	wAwpHDgqi4t8ok+pNlPbuKWJO4Ys8ROpi90Puc5WqpPdgNuAXtzGLaLM
X-Gm-Gg: AYBFou2r8kn/6XJepPF+mnOw5cDtubZiAGCYDXK0UDvmJf7jipAojtErueEnb+8XbFX
	mD2ZFTe25XR7+rYeym7VPROvvmXl+K9Lh13xE2SCtPv1IOFwXu2ks/z31eccV4XkN8fjxZXhyX1
	5j2BxZXS3baIH/k3E7zmulOQrjsHjdgyvvMMVmPyUkPoLjg8eth+uw+frFt+Rkb9r8ri37JVk71
	TG+atMF1FuOFmV9LHJFKnpnNEOYjDFKMir3PolWFnOhVtFcnpvwwVML2jjNcSFPURSRtvLHYFoH
	6QCidQfhWUd3mczzOcLms4zzB/Ac0IJSHsdZrY28CpKbL2APKlI8j127LW4uNJ0WHTk2RwFwUsC
	5pmIQ4MKEr5c49Qn4wRS42YGd8vtZc6sQWMJ/C21Yq0Yz2VDyZhIgK+VO1JsBDZQkfILa0iLs7r
	8IWdNBHjIY0NE/oqQDcLKwlQlrWPOVyQnCeL2xb3r/mjGLtj01BCHI2wiFxHIThObIgxvjGXhaf
	/ebDsGwOGR99QV4ZZCtMemdQd6KEiWxJZ9CiFMpZvTw
X-Received: by 2002:a05:600c:8b70:b0:4a0:108:3b48 with SMTP id 5b1f17b1804b1-4a18e4a174amr181863895e9.7.1791817685033;
        Mon, 12 Oct 2026 08:08:05 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.59.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967affsm9916f8f.1.2026.10.12.08.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:08:04 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] livepatch: Fix races between stack check and module load/unload
Date: Mon, 12 Oct 2026 17:07:25 +0200
Message-ID: <20261012150758.207983-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012144933.GW2009045@noisy.programming.kicks-ass.net>
References: <20261012140546.154730-1-parri.andrea@gmail.com> <20261012144933.GW2009045@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 12, 2026 at 04:49:33PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 12, 2026 at 04:05:45PM +0200, Andrea Parri wrote:
> > @@ -201,12 +202,16 @@ void klp_update_patch_state(struct task_struct *task)
> >  /*
> >   * Determine whether the given stack trace includes any references to a
> >   * to-be-patched or to-be-unpatched function.
> > + *
> > + * Must be called under rcu_read_lock(), see klp_check_stack().
> >   */
> >  static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
> >  				unsigned int nr_entries)
>
> As per always, I much prefer things like lockdep_assert_held() and
> __must_hold() over comments.

Makes sense.  For v2 I'll annotate klp_check_stack_func() with
__must_hold_shared(RCU) and add lockdep_assert_in_rcu_read_lock() there,
dropping the comment.  For klp_find_ops() the requirement is "klp_mutex
or RCU", which list_for_each_entry_rcu()'s lockdep condition already
checks under PROVE_RCU_LIST, so I'll just drop the comment there.

I'll wait a bit for comments from the livepatch folks before sending v2.

Thanks,
  Andrea
