Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532955;
	b=L4FcXvlvxLYUts1Py4BffmNPVVcviBOm92ry9isrFvjFRF5MfuXnEJlLSBxADDM1V/zh
	 kAh/DudJlyQp9Napt2aCP4yQ+bivrzWYel8leDl16T5tO7ip9VFzL7597S9g4IlmEQVK3
	 gY5NNmFKT5Gwn9auwjZEN2TpjF6XciBj+gRdPUKf95nKMfJuGqHkBRLEhGDS655s/HOp5
	 3D8t9cWp6WrbGyMW63D6jro4MxY6+y/MzIkC8ze41aiveAgcAj2LnHUINIy9mNg88FIF0
	 k9vu6Uspy+FoveSxJRFO85hFKQnzoXDpvLMxfEpYD3z2D38MXRrSibIcIJQNI0C8Rew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532955;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=enBVvX1k6DHuUyx9bzwRXTq+Qx99sH7KK0CGQinMRgw=;
	b=H0XPX7dySQU4xudGvEbXHEexHhyGPCUvEiHgeFNTz+IQej+MbBPmE7z6cNOX+ejdkmN5
	 nev9XDb+r8psuCRiclS5rB4qY1nqSL3GgFyH6NyNCDLuUqTIhKwOZMfp/GjZEutZysh2e
	 FYEnQC6l3VcIvR4wcLbl8c4DAk0XDHzftmoLeaRB1YaBthM65QXAbJizHwS2vUPh/8LRb
	 //Ba+UnRe8XWEtydOh3qRqTlNkCJIeTdNFy/Tl4YloBk7QsHcyqSahouvTz6U3P+ppaVc
	 NOwaY06shf2WXzPVwnyw3J1ZkDWVdjUhCs3/U5QXSe9A7y8d9ZEf6MQTyu1ifxwy5Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+rVKpr2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B72F606A31E;
	Tue, 24 Nov 2026 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+rVKpr2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAAF1F000D1;
	Tue, 24 Nov 2026 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795532954;
	bh=enBVvX1k6DHuUyx9bzwRXTq+Qx99sH7KK0CGQinMRgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y+rVKpr2Rj4o9vcYMYCo4+t0vsY7Gws87i5Zuk7jaF2TYerlKqKlfKLm9QDpF/COk
	 NH+EFy7IcRYxW4blMHZcm9A1+6mekg7iD2VBtZFFfMX71XhO2PLSe3Ftznh3vUrYfS
	 4HVC+MSWisXjPx+FCsAw6crsewKKEHYCojQXCBjTICmIyegobxmodSSSI+XoCMJLC9
	 SQ7lcOZUDoHBOGQtF3it9vkYGm6CVbV9LnEB8f4C1Rl9Ja+/yOYcvtU6jNIhRnhRRP
	 Od/cgS/IdR8WZ7wA8M3mXJwrEq5PpX5dXamlXSQYJv2cCPTWcFlMyFQEV5VmanMp0k
	 pbfHWffYbaxvA==
Date: Tue, 24 Nov 2026 16:09:08 +0100
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, 
	Cen Zhang <blbllhy@gmail.com>, James Morris <jmorris@namei.org>, 
	Lee Seong Hyeon <ihopenre@gmail.com>, Marco Elver <elver@google.com>, NeilBrown <neil@brown.name>, 
	Nickolai Zeldovich <nickolai@csail.mit.edu>, Paul Moore <paul@paul-moore.com>, 
	Peter Zijlstra <peterz@infradead.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Yihan Ding <dingyihan@uniontech.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] landlock: Do not hold exec_update_lock across the TSYNC
 wait
Message-ID: <20261124-gehisst-modeerscheinung-hermelin-b3e1d5983901@brauner>
References: <20261120151554.2651743-1-mic@digikod.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261120151554.2651743-1-mic@digikod.net>

On Fri, Nov 20, 2026 at 04:15:52PM +0100, Mickaël Salaün wrote:
> landlock_restrict_sibling_threads() write-locks
> current->signal->exec_update_lock to serialize TSYNC callers, and holds
> it until every sibling thread has run its task_work.  This wait is
> unbounded: TWA_SIGNAL does not wake a TASK_KILLABLE sleeper, so a
> sibling blocked as a vfork() parent runs it only once its child execs or
> exits.
> 
> Meanwhile, readers of this lock block, mostly in D state:
> /proc/<pid>/stat, mm_access(), pidfd_getfd(), kcmp(), perf_event_open(),
> etc.  An unprivileged process can thus stall tools run by other users,
> including root, such as ps and top.
> 
> Only a per-process "TSYNC in progress" marker is needed.  Use an unused
> signal_struct.flags bit, protected by sighand->siglock, which is held
> only to set or clear the marker.  A second caller still restarts the
> syscall, and a cleanup class releases the marker on every return.
> 
> Like de_thread(), treat a group exit or an ongoing exec as a held
> marker: a group exit may overwrite the flags, and both kill the other
> threads, which the restart lets the caller handle.
> 
> Add KUnit tests for taking a free marker and for rejecting a held one.
> A concurrent TSYNC caller cannot be started deterministically from user
> space, but a KUnit thread has no sibling and can hold the marker itself.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Nickolai Zeldovich <nickolai@csail.mit.edu>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Yihan Ding <dingyihan@uniontech.com>
> Cc: stable@vger.kernel.org
> Reported-by: Lee Seong Hyeon <ihopenre@gmail.com>
> Suggested-by: Lee Seong Hyeon <ihopenre@gmail.com>
> Fixes: ff88df67dbf7 ("landlock: Serialize TSYNC thread restriction")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---

Yes please, this came up in another series that I'm about to send and
this has been bothering me. exec_update_lock should not be taken lightly
at all. We really need a way to limit the exposure of this forsaken
lock,

Acked-by: Christian Brauner (Amutable) <brauner@kernel.org>
