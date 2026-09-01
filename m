Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAB743B4BD;
	Tue,  1 Sep 2026 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277950; cv=none; b=qv3HWei8iyifhuntkkYLD0neUr4FRqcRoE/xIKBo2WjtV/m2gbndDLd2RxJj+Xudc2R9qKL1CU2PYXYzSmRvwLGYEDIIesEpmXoHKnNTe0+nPN828KyDRqUNn6IZ8i57XSuQTh6w8911hnvMLdL9rCXhWLQ6nVRksMSOemHRgAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277950; c=relaxed/simple;
	bh=LnrT61gbrs5df1Rrfv5reLCpviLfBkAwyVtR42CZpU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAYnpWS7yXHdi98g4jbAGuGb0MlxabttsEXYGZozCEhnCfFI4bLIT3DXXh9jao1hpR816zwUCVlMBu8gidpTpQiY7ivL0Dn0TZ3R8JrBmA6Tvme8ZpMzfD6EZERl4QuKy8E0886zzzqo5TC5nD8yttW+vv/YPT6B7av0fVYpR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SBf9aWD4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SBf9aWD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311921F000E9;
	Tue,  1 Sep 2026 15:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788277948;
	bh=Hqs6wSuRVgu8Y5PWAnnbkuSSsOeRyQqHhWSmeTjO53E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SBf9aWD4FJKTeghw5zWxY6S30kwWQy38iv7wjE8YUkjnHIItCWAKVDLUpzu0w0R2n
	 1NzG4sWFZAlOexrEVkx841bUO93xRxQjj/9VrUwH3Gkfcl7IsjP16qrA+d9v7EdUSK
	 hgZ/LtYRs2u7TRfzIQgpsc1sea2dQCCgfrm15Xt4=
Date: Tue, 1 Sep 2026 17:52:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Sasha Levin <sashal@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Chunfeng Song <springbreeze@stu.pku.edu.cn>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com,
	kuba@kernel.org, ojeda@kernel.org, boqun@kernel.org,
	hkallweit1@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH net v4] rust: net: phy: fix off-by-one bit positions in
 device status accessors
Message-ID: <2026090145-rebuilt-eldercare-9ff3@gregkh>
References: <20260901031824.1377498-1-springbreeze@stu.pku.edu.cn>
 <DL3YRAXKKEEI.GOGNVOO3AV02@garyguo.net>
 <c4740d62-6d51-462a-9d47-0af8477d39e7@lunn.ch>
 <CANiq72mXDgdFXy6w1qy=fewJwrjV6ognGrTgNkn_O6zVpzbgYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mXDgdFXy6w1qy=fewJwrjV6ognGrTgNkn_O6zVpzbgYw@mail.gmail.com>

On Tue, Sep 01, 2026 at 02:51:12PM +0200, Miguel Ojeda wrote:
> On Tue, Sep 1, 2026 at 2:48 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > Probably a FAQ, but what is the policy about toolchain versions for
> > stable kernels?
> 
> As far as I understand it, we are supposed to avoid changes unless
> they are truly needed.
> 
> So there can be exceptions, but I doubt we can easily change a minimum
> version without breaking a lot of users (e.g. distributions or users
> using those distributions that have a particular version provided).
> 
> But Cc'ing stable just in case.

Stable kernels should be able to build with newer toolchains, but we
shouldn't break them by forcing a toolchain update unless there is a
very good reason to do so.

thanks,

greg k-h
