Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF93F104F;
	Tue, 13 Oct 2026 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913437; cv=none; b=Zg4yJLN4hMjAt7fchFQ5Vh4zsWdhFk0hhoc5thYOmj/vAXdzQTJRBnoZYYHpWXVaR6lFpUd9XWbB+H6odRsgRefuEOQuq6qjLMoEAnb3D764dz6qQvLKrKkVFCjOyETNhAwIRfC5eX8V9gxn6MfwW8PgvPBOgZaVbCA0A/VpCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913437; c=relaxed/simple;
	bh=tdUs72401n33j981CWcvSuFtpdGWhvOp52GC9o9iWKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S50YP+iEDrdUBXhq2zXjqJTwJ9WiWReIdCFf9tr/ukMqBKPN6JTCyWBHjZ4n9G7sFsYET6U2eeZAyrrSco7pXinBZcmfbuVzw4NP6RgK3lIcNfSQGvdCduutrTgGbIMGxx2k/bw21ibnS9SY4Z36d8ZG7MB2vF2UWW55qX+O9yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyRyyaQM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyRyyaQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140981F000FF;
	Tue, 13 Oct 2026 17:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791913436;
	bh=PmP+1qDuiByKpC+7bA701v8DM/LXLmC8gESMptbIB2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YyRyyaQMumg0saS/PK8Zl+KD5OQjqU2RN9h0rsXd9QZIj6jrfNHGpNb8VIEniCxsy
	 y59fSP/9j+GzCkWOMZ8RS6ibouN9BEsrQamk/r56qr+Iyfs7kNZ4q+nBAGyX/HIuP1
	 ZkXIYa6jcwGW8gWK1IVFcsAJGJRbVWDSYlWf5FQPSiYkiANEcyfeqZogRANMxnEOih
	 CgIFJSX5akzJUIYutvVBnfgMmDKiB8qwHqeCy7ykkudcH7gAr8lKoof4Xb5WxL7hwq
	 rfyB51hFxzAytCHyr7BOyI87gO2AsW40aRnMdty5pQnDw/ere9/VZ4Ut4IAt0lq03z
	 a/faMZxDI57cg==
Date: Tue, 13 Oct 2026 20:43:52 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 0/2] keys: Fix quota-owner reads and ownership
 accounting
Message-ID: <as5t2CZmQXP7u39S@kernel.org>
References: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013084056.1070923-1-nicoyip.dev@gmail.com>

On Tue, Oct 13, 2026 at 04:40:54PM +0800, Chengfeng Ye wrote:
> This revision keeps the v3 topic order: the lifetime/namespace-reader fix
> is patch 1, and ownership accounting is patch 2. Each patch can be applied
> independently to the base, and both orders produce the same final tree.
> 
> Patch 1 protects only the three quota-owner UID snapshots. It relies on
> key_user_lock already held by lookup and final reference removal. Its
> READ_ONCE() pointer loads pair with a WRITE_ONCE() replacement in chown.
> The reference-release ordering and lock handoff keep a sampled owner alive;
> this does not require patch 2's new accounting critical section. The commit
> message gives the lifetime argument, including a final put by another task.
> 
> Patch 2 serializes chown with quota reservation and positive and negative
> instantiation. Each critical section is complete within this commit.
> Atomic counter operations alone do not serialize owner selection and
> count/state publication with chown, and instantiation does not require the
> target key's semaphore.
> 
> The messages explain why keeping a key alive does not pin its former
> quota owner, and why key->sem does not exclude instantiation. They map
> those two requirements to the three reader scopes and four accounting
> scopes, and explain the existing protection at unchanged lifecycle sites.
> All seven scopes in the combined v3 series are retained. Reservation and
> instantiation locking move from v3 1/2 into the complete accounting fix
> in v4 2/2; no lock scope is split between commits.
> 
> The procfs changes cover the originally reported proc_keys_start() fault.
> The filters continue to use the quota-owner UID, since key_fsuid_changed()
> can change a thread keyring's key->uid without moving its quota owner.
> 
> Changes in v4:
> - Keep the v3 topic order: lifetime/namespace readers in patch 1,
>   accounting in patch 2. Both fixes remain independently applicable.
> - Put every accounting critical section wholly in patch 2.
> - Make patch 1 independent using existing lifetime locking plus explicit
>   pointer access marking.
> - Explain the root cause and every critical section, plus the existing
>   protection at unchanged sites. Keep allocation, notifications and
>   reference release outside the new accounting scopes.
> - Correct the reader patch's Fixes tags to the namespace-filter commits.
> - Rebase onto for-next-keys at 22430ae5d90ab and request fresh review.
> 
> Validation:
> - Built security/keys/ with patch 1 only, patch 2 only, and both patches.
>   KEYS, PROC_FS, USER_NS, KEY_NOTIFICATIONS, BIG_KEYS, ENCRYPTED_KEYS and
>   PROVE_LOCKING were enabled. No compiler warnings or errors.
> - Both exported patches pass checkpatch --strict with zero diagnostics.
> - Both patches apply directly to the base. Ordered git am in either order
>   reproduces the expected intermediate and final trees.
> - No new runtime, lockdep or Sashiko run. The KASAN excerpt is historical.
> 
> OpenAI Codex assisted with the review audit, series split, pointer access
> marking, commit messages and build checks. The existing author sign-off
> is retained from v3 for human review before submission.
> 
> Previous revisions:
> v3: https://lore.kernel.org/r/20260927162528.943886-1-nicoyip.dev@gmail.com/
> v2: https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gmail.com/
> v1: https://lore.kernel.org/r/20260823170448.3856516-1-nicoyip.dev@gmail.com/
> Review:
> https://lore.kernel.org/r/asL2UQjYCxt9SF9K@kernel.org/
> https://lore.kernel.org/r/asMQMzqVkmYhwgMB@kernel.org/
> https://lore.kernel.org/r/asNCIs3OshLwGWrB@kernel.org/
> 
> Chengfeng Ye (2):
>   keys: Protect quota-owner reads in namespace filters
>   keys: Serialize ownership transfers with key accounting
> 
>  security/keys/key.c     | 15 +++++++++++++--
>  security/keys/keyctl.c  |  6 +++++-
>  security/keys/keyring.c |  7 ++++++-
>  security/keys/proc.c    | 15 +++++++++++++--
>  4 files changed, 37 insertions(+), 6 deletions(-)
> 
> 
> base-commit: 22430ae5d90ab288b0ee2ad99ae941f4a666b694
> -- 
> 2.43.0
> 

Hi overall this looks good (or better). I'm off work but I'll
look these up first thing in the morning and likely pick them
too.

Thanks for the patience and hope you understand that my previous
feedback was meant to be constructive :-)

Br, Jarkko
