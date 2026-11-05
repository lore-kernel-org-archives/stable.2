Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912647;
	b=TX3diHMVVBEcmJhsfeDzYVZrtJipNPt6FLbihgP5lp8EBnZ8E99M0k9+wLAMrJQN9Zbp
	 eR6TfoqfkYlUJSDg/o18W3XVqNXVbl/Z3Ztt5fEZX0DXHMJW+VpKCtZMmorGPbev3eXZ9
	 /67ZO/BoaWF35oiz3qzOrt95e3Nr0Fmm7rHPsOQOLhHEh9z6eB0Ed/aQ9NZuTnnMwIsab
	 L2ensu51Zj9mQ/24snNasZM1o/3LkQE70jg0DvZE55VU9wCjEVbs94xutLrojlbZHeMMO
	 lm5uKt3eADWulcMGSPlv2pOA59BdLOCOODwJKFve70EDTl8vmXNwku0nITjn34F8nDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=EGxIARHwfDH+PiGjWxKomdVYqHv4YKk1Tq7/8Jn6Wag=;
	b=2eMnYqn3nxtDHRgSMcgAZh6e66/j766juV1puqUDLqjwEdifmftdROoj98hr4oZCEOGv
	 5NxH6nyi5cebOE9JgAUrew8R8E+0yksTKyoJrzhbeidg+C5Eqk8RR8Q2KPUe2PW1lGb+F
	 C/1bD1cfMd5hpcu3ZiSy4TcySKQhJYfUR+rPDX6ES301kZIwGiJ7mdYYKZ0ZohBcidDLs
	 QypvOAZtVasKwXVkoo76yVPMxtFbTVcKm/cUsTRpEQLs8h5fneeepxQ5Z6kuGEKnDb53M
	 oSXkCmZD+CivIo94GRw4vW/t3qOpY8H6b27I+3hcornLC/GMOZzIKOppd36FrvXN8GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bobrowski.net;
	spf=pass smtp.mailfrom=bobrowski.net;
	dkim=pass header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=RR3ez42l;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59700606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 21:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59700606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=RR3ez42l
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so4400532eec.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 13:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1793912645; x=1794517445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EGxIARHwfDH+PiGjWxKomdVYqHv4YKk1Tq7/8Jn6Wag=;
        b=RR3ez42lbroTR0C7UAFjLFoiwgCT4dVKo2bv8J6+/n5BtMBcBzpgdfeUPjSBmEF3Xz
         hbx1NKwaXgJOSk2qVFv+KuUq3AenJUb9yZ5FfI1DDcIVzOuqWDgLL9YSJprGylG9zFKG
         VdR5TyUxoabuh47Z8B5MNNnopXGLMVjLpxPbc19rCQGxomIUocvckcIWO0B6dV1TJsR4
         nhI/cKC0sJXADNN0w2beQgsvvnkh1/v8YyJy8D8mpS9oWCtfUVKtN2sNLf6lnWFbOgHl
         Mq9XYNZt2fyxKb2RsWLuZ3G7QkPe4SBJZIZBuYxskyAHso3PvYF7QMnoUo/GLLifLjpw
         Nlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793912645; x=1794517445;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EGxIARHwfDH+PiGjWxKomdVYqHv4YKk1Tq7/8Jn6Wag=;
        b=COBb57tYBLEGBIWU44jwYbFAqgaAikPBx1Po7ItHwSLUzAW5CKFEcsE+tDojsQOTt3
         c5a4z/P8OeJoCpTlJ2QZqgoPSEEFj9ywoIOjYgJGIxujXSeLvPgRFyub1CjPzDVgQ/FX
         8JVoJXtWZMlXg3HTg9iwSdSNxfloaU2eK9ByeztKVQnqg93B5zWwkHIKYC+Zpzzb4bG5
         jeZ7/aedAqenXeySIl0mHbqRYRHJX0JrQv3O9sTBQE8ucdSGcZ0Ub7XQailyFYteO/cI
         ldMGyaik7MdRH1srUoMdNCUJ+3qIO3tNh1/flGwVwtyIJELgMaK5mGsVW87+EQjTea2B
         tgAg==
X-Forwarded-Encrypted: i=1; AKwUvByGxsWggJLOHRw7LfyR212utbslzfZBnHsYOBCoJ+Dpn12JzBUQT/K2omyd6bXrMa0+k4/PxPY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FLx+9vl2CHaLQU/XuToa7LAIrmI3mgE6b8wxBR96S5u/IF3zN
	dAvePXnK8Dk1b42KCq83ErlCxkVxY5uN8vHckiMVaruFy1eF9xwiagSDf86Jh9Ml/j+J
X-Gm-Gg: AYBFou1HvkoC5ylUn7TrmeW86jbKaTJ0uxkuHJI3iGIZB6y9tm07lb9aD09Zjv1Bz0H
	Q1XSmnLfbOWRo5SUg+sYah8EcNATT4YPo5quj4RIPgEA7oYwW6s5sLWfE4gE21LNqMFrfceA+YK
	KQUqtWkLOkFYGIgGseBtkDNObkzaCa0jI4+THIyFMHvwYoj4XpGtIkLKeTJWqc591PU0nulOl/W
	yhYZ1FX3QNA0SCaaeuQvWS3emfXGE3TMdLsz4C2ErkoP76Lvf2oonRxcEs8MxCZrU7hCRJuAOuw
	9pkOBuBU/bCW1Z16lpsCY/2wLgLpG0iA9o4cxy4UojgQ7Ti+zRKaBF4sBdRsyyhCPaF/WGwr48J
	wWSIG2zSK6oObyc8C5mthpCc0OUhFCMKEdTwu/PuAAR/oyui0tRhcD61F6rk65hGUegwJKTaOva
	IuFu6tIlDPH4rYCWAGlmjXP0wbmFaOr6jKMIYfFZzxqQv30MNBAyvb0l69ZIegAM5WWgNXGkrqo
	c+G1o1Sbj9Pf0OE7oBPAXYz6KnfV+wq62jgdQF7ZeH5VUW9r6dlDxEJpPyx/yU+XZHs6ITAnnbP
	mj+lHvdgEQqyIrdxByF5RxZKTRexM1ZqbIKTYta/hNrr2Hm9BflJSyI1QkLZUfCPbKwyO6y5xFF
	aTCzaqA==
X-Received: by 2002:a05:7301:251b:b0:36a:1e0a:accb with SMTP id 5a478bee46e88-36f7631c69amr422598eec.35.1793912645000;
        Thu, 05 Nov 2026 13:04:05 -0800 (PST)
Received: from lima-development (163-53-146-70.ip4.superloop.au. [163.53.146.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f74069e31sm761960eec.0.2026.11.05.13.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 13:04:04 -0800 (PST)
Date: Fri, 6 Nov 2026 08:03:56 +1100
From: Matt Bobrowski <matt@bobrowski.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: fix crash in bpf_path_d_path() for
 exiting tasks
Message-ID: <auzvPMnq2vrLaBdB@lima-development>
References: <20261020105014.97985-1-matt@bobrowski.net>
 <20261020105014.97985-2-matt@bobrowski.net>
 <DM9VJTFJGVXB.3GH9LO3NGV5PO@gmail.com>
 <atiawbBo6WRPA6QA@lima-development>
 <at_MbcW0OlciNLrE@lima-development>
 <20261105-berglandschaft-mitbringen-baufinanzierung-c0542594d218@brauner>
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
In-Reply-To: <20261105-berglandschaft-mitbringen-baufinanzierung-c0542594d218@brauner>

On Thu, Nov 05, 2026 at 04:44:34PM +0100, Christian Brauner wrote:
> On Tue, Oct 27, 2026 at 08:55:57AM +1100, Matt Bobrowski wrote:
> > On Wed, Oct 21, 2026 at 09:58:09PM +1100, Matt Bobrowski wrote:
> > > On Tue, Oct 20, 2026 at 06:24:42PM +0000, Alexei Starovoitov wrote:
> > > > On Tue, Oct 20, 2026 at 03:50 AM Matt Bobrowski <matt@bobrowski.net> wrote:
> > > > > Fix this by returning -EINVAL from bpf_path_d_path() when current->fs
> > > > > is NULL. Only the task itself clears its fs, in exit_fs(), so the check
> > > > > cannot race with that.
> > > > 
> > > > The crash is gone, but so is the path. file_release progs will get
> > > > -EINVAL for every file that a task still has open when it exits.
> > > > 
> > > > It also breaks what works today. The d_dname branch in d_path() returns
> > > > before it looks at current->fs, so at task exit a pipe or a socket
> > > > resolves to "pipe:[123]" now and to -EINVAL with this patch.
> > > > 
> > > > And it's not specific to bpf. The comment in fs/cachefiles/namei.c says
> > > > that current->fs == NULL in do_exit() breaks d_path() called from ext4
> > > > open.
> > > > 
> > > > can we fix it in d_path() instead ?
> > > > With an empty root prepend_path() goes up to the global root, the same
> > > > way d_absolute_path() does. Then the check in bpf_path_d_path() is not
> > > > needed and the selftest can expect the path. A chrooted task gets the
> > > > path from the global root, but it doesn't have a root anymore.
> > > > 
> > > > Something like this (compile tested only):
> > > 
> > > Prior to sending out the fix, I also considered addressing this directly
> > > within d_path(), much like you've proposed here, but decided against
> > > it. d_path()'s contract is to build a pathname relative to the current
> > > root. It does fall back to a root-independent name when the path isn't
> > > reachable from that root, but that fallback still presupposes the caller
> > > has a root to measure against. An exiting task past exit_fs() has no
> > > root, so d_path() has no correct answer to give in that state, and I'm
> > > not convinced we should invent one for it.  That's what
> > > d_absolute_path() is for.
> > > 
> > > You're right that my patch regresses the d_dname case though, since
> > > pipes and sockets resolve today without ever looking at current->fs.
> > > Rather than replicating the d_dname check in bpf_path_d_path(), which
> > > would mean duplicating VFS logic such as the mounted pseudo-inode
> > > special case, I think the cleaner fix is to move the "no root, no
> > > answer" check into d_path() itself, after the d_dname branch:
> > > 
> > > 	if (unlikely(!current->fs))
> > > 		return ERR_PTR(-ENOENT);
> 
> That seems ok albeit fugly.

Yeah, not super nice, I agree...

Anyway, I'll respin this series with what I've proposed above.
