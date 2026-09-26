Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECB423ED60;
	Sat, 26 Sep 2026 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790438026; cv=none; b=M8aisT8Nnpx6n5LhFX6aPCUdgBrJZZpn9QruRxvLkcGZRJlrgwRlfWFYWmidOuR4jkgfgfFoXNsFGut4cawFyy37l4Lu9PBA6FmO0g4HQIlBdrqBJwmPDob29c2SnJ0dL94mu7ulF9lbI55r6mX8I0wEEuTeuBPiwya5MSVysWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790438026; c=relaxed/simple;
	bh=dVrxkBvCTFGq+yVKiWfed7FhCtG4Pu0AXXDWlENwnUI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=pHS1NR65v+d/T5Afsbf56u0QdYzpwcoDzurR8JPkxI3rd5t76tms4J7sNSebXOpSWknRTXD1/8UOQpkEy4D0tv/Bo3Hc9jtPZWHJgb4QwAeasJ2KNSG+deRKHadBcPIA4R97cDck138/PrPH1rrvtI6X0TuiGWNQnmw7zMy56g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgiKVu8K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgiKVu8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F5D1F000FF;
	Sat, 26 Sep 2026 15:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790438024;
	bh=Mx6PqK1cOd2dbFt6I+X1sEC8gGaegk9pcYdLp4nRBnw=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=OgiKVu8KIi6Hna5NSGn+jGVf+1j+FsPciAd4gh+eJhQX1Gl7VhMkALcW2s+pMbUhs
	 E/9eAW2Ie/9pgB9qPrXXSOPABA+w/LRVaBHaAKuVHlOkxuInvvYHsANypRPgP3IyJW
	 /0/ISap6NFP42Mch+UDLg+nS1+DYY02asEkrSkNav2mwQ1HhmjBsDVXJhPiCS/u+DM
	 G84nizCQ8omYZBBMtqrMBWasvatKNrJPeh+fojg1BZyNghcxzMj/vtPOgd7dhhNkx6
	 AVAHYKX0PmTXz0Zw3AUJ3+h+99mk0ZEDldmbDC7yDf9cBkyLuQW6CbvMVLdAQJwfwy
	 jK5EJXhqbB02Q==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 17:53:41 +0200
Message-Id: <DLPDB44JJRGJ.3K6JNS746M7QC@kernel.org>
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 1/2] debugfs: fix use-after-free in
 debugfs_read_file_str()
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <johan@kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "sashiko . dev" <sashiko-bot@kernel.org>
References: <2026092647-ebony-unlatch-d3d0@gregkh>
 <20260926140918.1077347-1-qwe.aldo@gmail.com>
In-Reply-To: <20260926140918.1077347-1-qwe.aldo@gmail.com>

On Sat Sep 26, 2026 at 4:09 PM CEST, Aldo Ariel Panzardo wrote:
> Switch to kmemdup() with GFP_ATOMIC so the allocation stays within the RC=
U
> critical section.

I'd like to avoid GFP_ATOMIC for this, as this doesn't seem to justify acce=
ssing
memory reserves.

There are a couple of alternatives for RCU:

  (1) Measure under RCU, allocate, re-check and copy under RCU, or grow the
      buffer and retry.

  (2) Use GFP_NOWAIT and just fail under memory pressure.

  (3) Allocate what userspace wants to read, not what the actual size of th=
e
      string is, i.e. min(count, PAGE_SIZE).

For this specific issue I'd probably go with (1).

However, I think that the whole debugfs_create_str() API is a bit of a foot=
gun
to begin with as it implicitly imposes the same RCU constraints on the call=
er of
debugfs_create_str() (which also incentivises GFP_ATOMIC usage because it i=
s
convinient).

For instance, icc_get_set() [1] has to do the same RCU dance and uses
GFP_ATOMIC.

Other users, such as soundwire, just get it wrong and just pass the unprote=
cted
pointer to e.g. request_firmware() [2], which is a potential UAF.

So, I think this API lacks a proper synchronization contract;
debugfs_create_str() doesn't mention anything at all, which may be why soun=
dwire
got it wrong.

I suggest to add a new type, e.g.

	struct debugfs_string {
		char __rcu *value;
	}

or if we want to just use a mutex for synchronization (which simplifies the
allocation issue) we can just make it:

	struct debugfs_string {
		char *value;
		struct mutex lock;
	}

And then we can have helpers, such as

	int debugfs_string_set(struct debugfs_string *s, const char *value);

and

	char *debugfs_string_dup(struct debugfs_string *s);

which take care of the synchronization for the caller.

Personally, I'd just go for the mutex, as it avoids the need for the alloca=
tion
dance and also allows us to provide a guard if we want to access the string=
 and
avoid a duplication of the string in the first place, e.g.

	scoped_guard(debugfs_string, s)
		matches =3D !strcmp(debugfs_string_read_locked(s), pattern);

Thanks,
Danilo

[1] https://elixir.bootlin.com/linux/v7.2.7/source/drivers/interconnect/deb=
ugfs-client.c#L51
[2] https://elixir.bootlin.com/linux/v7.2.7/source/drivers/soundwire/debugf=
s.c#L268
