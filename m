Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67F04E323D;
	Wed, 14 Oct 2026 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978268; cv=none; b=pbXCBdohFpEZYNxfXAQCdMww0gBgazc2RwbhiJt8k5c2MzE3lVKZT/ZGy5fAaUzEmJULIdXaY9wGC4y/cnEaQspnjS/kiPXWdl5TGN3XPehnDOOX6TtzGE3q9B5S/oNouwqBjUGoymZ6bwXzc2rBK0pjQonUZaRt50AiqoOFiiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978268; c=relaxed/simple;
	bh=eN3i8bDNZV8OHcc+xFfPvvz8mlSLFyWr0mNB+KrdvhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBnmgU8qdW0pXTF/u5irQjhPKXxNV+DyTos71t2TJvtB4aJB8vow+tEYluoV8pRvVdo0ERcKFoYutX/wHCKhAKMR9JZm/ZEmLVS9VlwD+fBbMC1Grnbr5z5iWFzm3KYznEhkGJUVXQDH3jDY9iKNWDiUsoJziTP2FHzzQcKfPb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm+I3cHP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm+I3cHP"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E4A6B1F000FF;
	Wed, 14 Oct 2026 11:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791978266;
	bh=5N4rtmjEIqLUTN1kR4qbG/CPvBRxI4AoFf4S+1wft78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hm+I3cHPbCT+kjsrSsNf/gUn6zxCGneCfISAw9+3+8Cmwz5CYN/JpfW6OsdAHEz/J
	 oI2x4oU9Twdw8M6LFySJWzift8rzSYIMp/ZIDWURLfJqtQ1vsibsnR8yCmwkV7D7Sb
	 9674nnf59src0ODG4ZmgbWgr1uGWkI1T5v6R2zeCCB6jiP12oLlOqt0MJhFSJYinln
	 3uJm7A0FF+uuJZzbycDjg9NdSgH+WpDy5jeTk2nIQav+yCrYpWpIn2f9+U6kyiu9FH
	 qxY3ta39c/wrKBh5n1gy5kAg9TNhdguJdcKeFxKn20fuaIUUNlyp5fIbO8irA82Tb/
	 5fkPRmJta01YA==
Date: Wed, 14 Oct 2026 14:44:22 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/2] keys: Serialize ownership transfers with key
 accounting
Message-ID: <as9rFtolVVn0NVD1@kernel.org>
References: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
 <20261013090358.1178367-2-nicoyip.dev@gmail.com>
 <as9pUYoOmLI2l5oB@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as9pUYoOmLI2l5oB@kernel.org>

On Wed, Oct 14, 2026 at 02:36:53PM +0300, Jarkko Sakkinen wrote:
> On Tue, Oct 13, 2026 at 05:03:58PM +0800, Chengfeng Ye wrote:
> > Protecting individual accesses to key->user does not make ownership
> > transfers atomic with accounting updates. keyctl_chown_key() holds
> > key->sem, but instantiation is serialized by key_construction_mutex and
> > need not hold that semaphore. KEY_LOOKUP_PARTIAL also permits chown of
> > an uninstantiated key.
> > 
> > The instantiated-key count can therefore be charged to the wrong owner:
> > 
> >   instantiate                       keyctl_chown_key()
> >   increment old->nikeys
> >                                     observe KEY_IS_UNINSTANTIATED
> >                                     skip the nikeys transfer
> >                                     replace key->user
> >   mark key instantiated
> 
> 
> Same here there's another below.

This was also asked last time. Actually last time (since I missed the
spurious comment), this was the only thing that wask from you.

Br, Jarkko
