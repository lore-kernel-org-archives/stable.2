Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369721;
	b=PAnKrYNxgnwuAS9wYYPQJ4mKv7zMJPzAr2er3gbeNvW6eMiC8Ij2LD6CcGLuto2CoGDy
	 iTw0HZzjfxBa8Jkd4KEXrD26IZ+TO4jc3pq0Hs1bOyC1keevMHKEonvn8Fs02EM5iSpGv
	 ZdjoS0ebVH62AgIbi9TEaSGHIbx84j2Tgujip5oQcuSv63M9MbcNxb036S44xL8JT+x/A
	 ME8EqxHSJGNaL82YWU3jgz0/ZRr10XbXd9NsTEoonMWqC5yC7bo58EemXfmqNH/2+hCkg
	 VuaxeWXjHCnRTnpEwup2ezUUWT7nOWW+IA2m1g/1d3ZZiScEXnXm9pMs/ZOoVzzIM7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369721;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=6o/wru8YGsBJ8nISiaIwKRCzFTUDQcQKEKhFrnSO15Q=;
	b=s3jsZQJkZnzM4L0YG9HfsimFlS3oprlRJuUjPwbtELA+8ersyLIvWK/FniUx4KbbtuYX
	 2Xih/Itcp0fhnLs5Tc3dVkCiy9ZPrOLVPTOmtjY7Qciev5lchmD41Q+HGfVHqMikwRqy1
	 8TWtRrBskLJpXVbRGn2CZeuVLY87Um5BasTrxNE3XQyhT3KQip9mSapi2+Xk9gTQxvLj9
	 KireQ9pGOOw1PU85jRhxV2pKkSk6FB+rpWDJ/21zZGxlEm968nflKtxRdZG08uBdfq/KP
	 YNuLZTEWlaTML2PQqs15osZnDULPUgT+VF4sV+QhItWf6SEVx6fuuAa6WPk2RlJDUFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=2ThaJ8qB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB8D606A320;
	Fri, 30 Oct 2026 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=2ThaJ8qB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841A61F000C1;
	Fri, 30 Oct 2026 14:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793369720;
	bh=6o/wru8YGsBJ8nISiaIwKRCzFTUDQcQKEKhFrnSO15Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2ThaJ8qBhraU6rDhRkC/D6TOscfYLnqxHXJG6QdzkJxpd7V+dj3zuwzSBw9XblvFY
	 aC57fqDmqaCcYWSVA4Xxom0B/xj/62qrlM4aBxN6EKJMAmhr1M0QiIqgg5hy7Euhx3
	 dhTKsaLu7JtgjBUcQCdAihs79tw4eSXLgrA3ipWw=
Date: Fri, 30 Oct 2026 15:15:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Gyutae Bae <gyutae.opensource@navercorp.com>,
	stable@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Minsu Jeon <minsu.jeon@navercorp.com>,
	Jonghyeon Kim <jong-hyeon.kim@navercorp.com>,
	Siwan Kim <siwan.kim@navercorp.com>,
	Gyutae Bae <gyutae.bae@navercorp.com>
Subject: Re: Backport request: Revert "softirq: Let ksoftirqd do its job"
 (d15121be7485)
Message-ID: <2026103018-gothic-sheath-5c34@gregkh>
References: <20261029054200.97234-1-gyutae.opensource@navercorp.com>
 <9024faed-854d-411d-96c1-7cefd4d68dc6@redhat.com>
 <CAL+tcoAmq0WfSzo01xbAQ=g8OtE+GpJ5+RGs1G1SdNPdHx_eZg@mail.gmail.com>
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
In-Reply-To: <CAL+tcoAmq0WfSzo01xbAQ=g8OtE+GpJ5+RGs1G1SdNPdHx_eZg@mail.gmail.com>

On Fri, Oct 30, 2026 at 02:16:57PM +0800, Jason Xing wrote:
> Hi Paolo,
> 
> On Thu, Oct 29, 2026 at 4:33 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 10/29/26 06:42, Gyutae Bae wrote:
> > > Please backport the following upstream commit to 6.1.y and 5.15.y:
> > >
> > >    d15121be7485655129101f3960ae6add40204463
> > >    Revert "softirq: Let ksoftirqd do its job"
> > >
> > > On a production 5.15 PREEMPT_NONE node, long-running overlayfs
> > > getdents64() calls prevented ksoftirqd from running.  RPS IPIs
> > > continued to arrive, but NET_RX processing on that CPU stalled for
> > > up to about 3 seconds.  Over 15 days, the node logged about 1,000
> > > bonding ARP monitor failovers, with no link-state changes recorded
> > > during that period.  The failovers stopped after the workload was
> > > removed.
> > >
> > > On a 5.15.27 PREEMPT_NONE test node, we used a livepatch to make
> > > ksoftirqd_running() always return false.  This removes the same
> > > softirq deferral checks as the revert on this build.  Under the same
> > > load, we measured three 10-minute windows: before patching, with the
> > > livepatch active, and after removing it.  The number of HTTP requests
> > > taking more than 200 ms was 17, 0 and 11, respectively.  TCPTimeouts
> > > increased by 25, 1 and 21.
> > >
> > > We verified with patch --dry-run that the revert applies cleanly
> > > to v6.1.190 and v5.15.223.  Both already contain the related RCU
> > > fix 1dd1eff161bd.  6.6.y and later already contain the revert.
> > >
> > > The original commit was intended to prevent user-task starvation
> > > under a softirq flood.  The revert's changelog points to threaded
> > > NAPI as an alternative, but it is disabled by default.
> > >
> > > The revert was merged in v6.5 without a Cc: stable tag.
> > > Syzbot has also reported bisections to this revert [1].
> > > Paolo, Thomas, Eric: I would appreciate your thoughts on whether
> > > this revert is suitable for 6.1.y and 5.15.y.
> > >
> > > [1] https://lore.kernel.org/all/000000000000a249880603717c15@google.com/
> > IMHO such change should not land to stable lightly. It's a behavioural
> > change with subtle side effects. The threaded napi feature is disabled
> 
> Technically speaking, yes, it's actually not a bug but an optimization.
> 
> > by default for the same reason. Also the revert has some soft functional
> > dependencies in napi threaded cleanup and improvements landed into v6.4,
> > i.e. 6bb218b5a6e3f3c5e2e76faf8fc976f3f6f72496, likely more.
> 
> Maybe I have a slightly different thought on this: since I really
> received/noticed there are not a few reports showing the 'issue' in
> the older kernels. It's not easy for some people or company to upgrade
> the stable kernel. I'm wondering if it's still possible to land it
> with more careful consideration in the patch if Gyutae volunteers to
> do so? Please feel free to reject the proposal :)

Given that 5.15.y is about to go end-of-life in a month, that's a
non-starter.

For 6.1.y, you better be planning how to move off of that _now_ given
that you only have 1 more year before that is gone.  Anyone hitting this
issue should be moving now as that gives you an incentive to do so :)

thanks,

greg k-h
