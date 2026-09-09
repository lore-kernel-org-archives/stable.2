Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD2560AA0;
	Wed,  9 Sep 2026 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961541; cv=none; b=G1eB+m8cYSf5wkWp5HvNRZdut6BigMBjQI8D8EskEwlcaLTqfjfdaqtDbeXgqw248+gQMMiHMpmCIYbvxT7Ggpic0Ydv9UGJ6q+OGMkTGVQjkMaRXOFdav8YgmFFBXxvHAN5f4S2L3N9qOwr8B0wh05/Q3fc7V/uglPIDDgKm8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961541; c=relaxed/simple;
	bh=K7Og0xh+CK78Jr1wE50d16ZuR8sPW3tSVEBFHxXOlJA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=POnsLcoiPnCwY8bA0eoYcymciodCOafUiIRt8zzAWhk/6vytMDpyWxIy7vpcRn2Svl3sxNlm067bTAIoV8e3lQh5Bptbt4BMil9OWIv94NX2O04CgIhZPGrrZaNf6qR81x6KLoRz2v8ROI1G/VvyG3dk59nQXHH/KMWLsQVIIKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyxcNJh0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyxcNJh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065D61F00A3A;
	Wed,  9 Sep 2026 13:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788961539;
	bh=QYRHV/zNn2kE44vI4Gwn+qFsYPwBJ8jWjQJ2f6N/j1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nyxcNJh00mAOdkaFmOssybmy/TnTir92VvTia8IJJ4Bfrtc0ATMMCv9vL/v7HUY0+
	 oKRAlDQgrdNqkBBKtUR1hTVpSWH+m6vQYAocQ1MERgu+zjTo42y4EJOoJwYyBJD9wC
	 LH+pVEOA74WK6L9hAoOIO6tUrMBfq+dXD9ey4szlkb5BvNIH2lOUBd2589POTj11ld
	 +my8YtAtKl2uJKmpcRKC4Xn0qEoMdTFR4gQGx8Vg+mxr5x0nEErmch2OK2DGw8L05j
	 mPF9GwPsCMXGcbstfBMzyidZSr8jajef5YxpxGV/a2fFtmH27dDiZLSquGDEX3+9uZ
	 JMHIG1blKX00w==
From: Thomas Gleixner <tglx@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker
 <frederic@kernel.org>, stern@rowland.harvard.edu, boqun@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, "Cc: Hyunwoo Kim"
 <imv4bel@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Christian Brauner
 <brauner@kernel.org>, John Stultz <jstultz@google.com>, Ingo Molnar
 <mingo@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, "Eric W.
 Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
In-Reply-To: <20260909125132.GR788244@noisy.programming.kicks-ass.net>
References: <ap6urw5aAxrKO3Ck@localhost.localdomain> <87ik4h2icz.ffs@fw13>
 <ap8bUiYYwQT1nVg5@pavilion.home> <875x0g3de3.ffs@fw13>
 <ap_gOSWtPNjwWS1e@localhost.localdomain>
 <20260909080407.GR4121339@noisy.programming.kicks-ass.net>
 <87ecf223n4.ffs@fw13>
 <20260909095518.GL776954@noisy.programming.kicks-ass.net>
 <aqFNV4k6DcbyxYCe@localhost.localdomain>
 <20260909124555.GM776954@noisy.programming.kicks-ass.net>
 <20260909125132.GR788244@noisy.programming.kicks-ass.net>
Date: Wed, 09 Sep 2026 15:45:36 +0200
Message-ID: <87y0dazgfz.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 09 2026 at 14:51, Peter Zijlstra wrote:
> On Wed, Sep 09, 2026 at 02:45:55PM +0200, Peter Zijlstra wrote:
>> On Wed, Sep 09, 2026 at 02:13:11PM +0200, Frederic Weisbecker wrote:
>> > P2(int *next, int *prev, int *pid, spinlock_t *sighand)
>> > {
>> > 	int r0;
>> > 	int r1;
>> > 	// get target
>> > 	r0 = READ_ONCE(*pid);
>> > 	spin_lock(sighand);
>
> There is no dependency between r0 and sighand. While I think there is in
> posixtimer_send_sigqueue(). Does making it smp_load_acquire() help?

sighand is r0->sighand->siglock and obviously not known before r0 is
read. So yes there is a data dependency in reality :)

>> > 	// queue signal
>> > 	r1 = READ_ONCE(*next);
>> > 	if (r1 == 0)
>> > 		WRITE_ONCE(*prev, 2);
>> > 	spin_unlock(sighand);
>> > }
>> > 
>> > exists (prev=1 /\ 2:r0=1) (* Bad outcome. *)
