Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792454142;
	b=3oYl6C5s3lUdTIqJPmqoXtgRQ+5mpb+XcV61aGCGu7XdZGmcHuvzTTUv8mZhuA1InUez
	 StBa3zUJ8kFXbRbdcHyj435JDk3vMZL0MH5jz/QcNNT1ZhcaRMvEIsjDwfLSsCnSaicSH
	 AH+rOsmSphsN0ND61MlJoETnWhVZWR7go0lPTROhOGY8pJca+MBClJYJ/nwfNrolK4j+N
	 HWgicurHEPcvocPddF802aC2gof9DoiYlniN0zil4jfdK+/jthE/kj7IiQprlHt3Iqo9Z
	 lBOCytNVi0NLmuIU0xPTR5zQuunvxImicllR2wUDIQbu3SEdtbAotixUrz26e2WlULg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792454142;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Bsi8OJ4atLQ9WSwYb71EUGVfr2GPb/FAlpYjhx+M8Aw=;
	b=OJhbu5ENS0l+vQ11+kwbTfeGYHQPKq0+VRzcNsct5C2UL7Ic+i+mmYHPpwo8rtC2tKSo
	 D+5kj6Hv0YnjhYq0gJd5IUt6aJlrPQFCEvWLxrZoKe3eubaVD5HU05qfnXoESW1pFfY5n
	 aSX5jAnimO61Gl66bVcRZgBPS96LlWDaVcM8P0QDuBSPvS8DIjt674nn1DR1MR7OsWj51
	 ldTGVqrLX++75c2a/4W6wrPMhHHDEqcZbH6m6nbnDDLVO2Iek7GRopXrV4sywQSEJYvJr
	 lxtfjw1vg5Z2wXiFZB4fCUiTR8tKnwVzcLdr6AqcynIP6eLAsHvC99iwzt2aG4LZE8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Rwi7t1/H";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 15911606A319;
	Mon, 19 Oct 2026 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rwi7t1/H
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 09E951F000C4;
	Mon, 19 Oct 2026 23:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792454141;
	bh=Bsi8OJ4atLQ9WSwYb71EUGVfr2GPb/FAlpYjhx+M8Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rwi7t1/HqEa6snCtQBF5OBhiz4yWj0EU4RNmpXcUNMEm0D8/zW5oTSNC31JeocD5d
	 p0mbkyYfl6TmC4g4kYmTvVoeis2x+tnTl+xaWtk7AP1DEj8z7mm5yeeJl74iRRQS+Z
	 OozqVPDCApcf1sdWim+EpTWx8RDAFOit1+Ibb2DY+Xa/8SOqivu+uH/kbDjsWs4Bjy
	 aYHARgWbqwbThkZ4m9z3fCCjhBrnl8wBAOrLrc+HVtMIv9Po/AksptZeSBXYk4QFif
	 V0fVdxwSDqgRgldFY/7GuGN8bg8fi63jwRfOHigVjpPPBvcR5cYsbKxjK9I1b/RfDY
	 t03wdPLlimMlQ==
Date: Tue, 20 Oct 2026 02:55:37 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] KEYS: Reject @datalen values over INT_MAX
Message-ID: <atat-Td-fEPQq3c0@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-6-jarkko@kernel.org>
 <20261019193148.GE65095@quark>
 <ataGlDBhDaHsLT_q@kernel.org>
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
In-Reply-To: <ataGlDBhDaHsLT_q@kernel.org>

On Tue, Oct 20, 2026 at 12:07:32AM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 19, 2026 at 12:31:48PM -0700, Eric Biggers wrote:
> > On Mon, Oct 19, 2026 at 09:17:25PM +0300, Jarkko Sakkinen wrote:
> > > Protect quota from overflowing by rejecting @datalen values that
> > > surpass over INT_MAX.
> > 
> > Is there an example of how this can happen, and why the limit needs to
> > still be so large?  add_key() for example limits the payload length to
> > 1 MiB.
> 
> I did a bit scavenging, and to my knowleddge, no. So I would retain
> this as safety measure but would not consider it as a bug fix.

While it is true that add_key() has 1 MiB limit there's also
root quota. That was what I was originally thinking about
now that I scratched my head a bit.

But...

However, it is capped by /proc/sys/kernel/keys/root_maxbytes, 
SYSCTL_INT_MAX already.

So that makes the check this patch adds irrelevant, and thus
it should be dropped.

Phew... At least it is now investigated in-depth enough, I
think.

Br, Jarkko
