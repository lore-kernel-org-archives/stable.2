Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809262;
	b=wpZj8/bOlF4U5pd67+vVsV9FDHk3BFyPyuCbGarjGlijF+yHr5UyiJ1XR4kolBfSoeNN
	 d6JPxgaoZd38nxwY3L+3bPFg86lmqhpdGy5dkHh54830FtIxIlgJjQp/8ErWCzAgNeoQk
	 abbxdKUcJVyU0AGpTvWJduvd3a52Yuo/+hQ6a0fNY/LkOgU04ZJQtx0owigaAGxKBish2
	 L+5t/mwMsZGMZ5DsuGLlnyCX4WfXhA/UHfCbFLUNjYk4Wagux/f9WMjNm+fYqdnE98o73
	 Z3JKpyUR6dtU2+QXXfIPpiB0gbJbOH/pinH7pLP0MRo6TKtPLDUTo/aIs1bg/5YllYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809262;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=850ceEz23InKmdiAQpaygOzND1jluzai7nxx+6YSLW4=;
	b=FpQWib93XJisYa89vJEiHmPefvQJ8f5lJ6Q33yp0rxDugVgvU6DJLva2/E32NJlyMe29
	 aHYnYL0Biu07GMnu3GAXB8GXaflvmFM0YI5G656JG9ywsiKUpPm0JU3pAlMJdZJ4fHqVx
	 I+MLDw+HZMKcbErIj930Yd/vctQ3TCdEbDIo7wicIFJcwJvNOqse7Jvp3h/KRHLfZRX/+
	 P+4GqoQQCkUs7DxFPaWSdK2bQRaF3ykF251iOLIy46e+s3G7KI8zSXXimeW2wTzR1xTMN
	 eq4kFS49UkTYSa8Ai/OUyDe6Qk/sZcSaXVoLsZq2fyvbVSyW+3IIWsAl8Ollmb4MiDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PlRxF521;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C691606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PlRxF521
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA66F1F000C1;
	Wed,  4 Nov 2026 16:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793809262;
	bh=850ceEz23InKmdiAQpaygOzND1jluzai7nxx+6YSLW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PlRxF521U84Wo13NJPIRJ9IzzT+6BPYYbJhrbRszd1JOaTm6+UR6jXMFviRsSPM5+
	 C5QNZvTTolQgz7NaVCmqVT43WaeeU9i90JVwLxLajhRHqlruIZntumxpfRl5Hzg6/6
	 etswhTTL/2h6qkjb0P2Cnau2JaABW+JWRY9OIKtY=
Date: Wed, 4 Nov 2026 11:02:06 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org,
	sashal@kernel.org,
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>,
	Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [STABLE REQUEST] ftrace: deprecate the ftrace_enabled disable
 switch
Message-ID: <2026110439-pork-mossy-0316@gregkh>
References: <CAOu3gNgTSWE84fgdc1iUNKwes7E6u_X6b8pjZKBULEJWB=RAqQ@mail.gmail.com>
 <20260820182015.4272b7a4@fedora>
 <CAOu3gNgv91dq8jLShteRWphrSgNWQ1o1dkNxRr577ez7pMuv6g@mail.gmail.com>
 <20261104083903.0d7cdb06@gandalf.local.home>
 <CAOu3gNiggAdifeAUpycoO-zGKb0k2-nZqWrtDXMXm_HXT8L1Vw@mail.gmail.com>
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
In-Reply-To: <CAOu3gNiggAdifeAUpycoO-zGKb0k2-nZqWrtDXMXm_HXT8L1Vw@mail.gmail.com>

On Wed, Nov 04, 2026 at 10:43:37AM -0500, Andrey Grodzovsky wrote:
> On Wed, Nov 4, 2026 at 8:39 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue, 3 Nov 2026 21:51:42 -0500
> > Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > > Hi Steve, coming back to this topic (sorry it took me a while - other
> > > work related stuff kept me busy). Are you still willing to accept  [1]
> > >  upstream ? If yes, can you also please clarify why only the first 2
> > > patches and not the third, selftest patch?
> >
> > I was thinking for backporting purposes. The selftest patch is fine, but
> > not something that needs to be backported.
> >
> > -- Steve
> 
> Ok, so just to clear my own confusion: do we want to directly present
> this to stable as a backport fixing a bug, or go through merge to
> mainline first and then only backport? If we do want to take it into
> mainline then I think the selftest patch is beneficial especially
> because Jiri found some case that breaks there that needs furhter
> invistigation [1].

We can not take patches in stable that are not upstream first unless
there is a VERY good reason why that can not happen.

thanks,

greg k-h
