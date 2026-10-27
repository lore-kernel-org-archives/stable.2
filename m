Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106295;
	b=GQzN6q2kbNZ2Wxxxds+JKfFnyJdmrhhwdtHgT/gETxd0AjUuAMae0iSBFfVnqCfu8g8m
	 UPV+Eo0iQwub586u2HPXukxYFR5Ps1MA0Ty9BuqDoG4HOw4Cfsy4zeK4nsyswSIOKDV5h
	 1Q4VY4EPBX7j6U+6b2ckLyftcCoWp72Nr424PmnwcY34QXF6pnlfLtTOGIBPlSw1KDiLP
	 aDIAlxwxw4Qu9pBHmlSjFVIEOy3dhvQErEUE1E2mudYFlP4cODld1aNgSHKU5cobSF1XU
	 4bxTS87pmSte81mAo1gjXpexwhiy3Lb9CX/3F8FB3qDBbX2srwkPLSZFnMLzKSI9ANg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106295;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Of4H9m4bb+oakg+uaiUFhL/+GkDlyL+JKLZHKgUUKW0=;
	b=TPZBjpqnUgT/TGpB4ZLETZHuupfi6seioD5XIDuYh92i6UHZUv28uRhZEX9dYWXbiMuS
	 1vWtEE9UqZI0iOuZQxsXuKKX/JDv4ASBTfTmboiRRF8zNQE79PgRQSxvbMkM3c75TX3IJ
	 kzCvV64W6XgLgYH9ZzxhYRBLD9/O2rCqTsY20Zng0LIgqS8qviOjC26ANqCvNY7dMTTIv
	 Wgo+U6Zu3K7By4oZbG21XTntA0F8UVB1Q7sP41WzrFlxk0LAu7JNPC59ysmJoD7od0CLr
	 TZ9VFYgrr/8UWfz5iicAXKmmUk9e7cYvIbaVRaa8trxBy+pNBaKTGgBsTUMZRTYnaiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yb3i7jEn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344D7606A31B;
	Tue, 27 Oct 2026 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yb3i7jEn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CBC1F031E6;
	Tue, 27 Oct 2026 13:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106295;
	bh=Of4H9m4bb+oakg+uaiUFhL/+GkDlyL+JKLZHKgUUKW0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Yb3i7jEn4N15nyx7Kxt0QjPtrqbkEwaoV8ivyObe1Gmy7WOcD5YND9weJBaOfNiOj
	 Kcev7VDm2ubmChGfN1Y4IagPj1iUXxKU9OnC27cs+zZmy/HcSKj9w/ELMvDNQIDiv6
	 N+BZzUMa1RfhieTctY0KISwmTtzkYkuEVmTQrv2G6kyPsZhQVZSqiESa9p6bqtXpXF
	 fQ0wYtOGGxRpEoSoyeM+klEvp6C3/dkobi826qkB3pBeCHE9vVYeZxoUJdD1di3xfs
	 FfNJFfLp81uOtKkfDt/FzAYY6J6xM+mCAPJ01hSFoSUQwvx1fmiVNLZaU+quPu+imV
	 YUkkEoCPpf4Ew==
Message-ID: <13a3b600-8a87-478e-adcc-2425c75f98c6@kernel.org>
Date: Tue, 27 Oct 2026 14:04:49 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mempolicy: recompute automatic interleave weights on
 memory hotplug
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, ziy@nvidia.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, honggyu.kim@sk.com,
 stable@vger.kernel.org
References: <20261024170415.4121901-1-gourry@gourry.net>
 <e3a1ae72-9370-4c3c-8935-6a410a74377b@kernel.org>
 <at91WFlW96PH-a8A@gourry-fedora-PF4VCD3F>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <at91WFlW96PH-a8A@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/26 16:47, Gregory Price wrote:
> On Mon, Oct 26, 2026 at 12:19:21PM +0100, David Hildenbrand (Arm) wrote:
>>> +/* Recompute the weights from node_bw_table, unless they were set manually */
>>> +static int wi_state_refresh(void)
>>> +{
>>> +	struct weighted_interleave_state *new_wi_state, *old_wi_state;
>>> +	int i;
>>> +
>>> +	new_wi_state = kmalloc_flex(*new_wi_state, iw_table, nr_node_ids);
>>> +	if (!new_wi_state)
>>> +		return -ENOMEM;
>>> +	new_wi_state->mode_auto = true;
>>> +	for (i = 0; i < nr_node_ids; i++)
>>> +		new_wi_state->iw_table[i] = 1;
>>> +
>>> +	mutex_lock(&wi_state_lock);
>>> +	old_wi_state = rcu_dereference_protected(wi_state,
>>> +					lockdep_is_held(&wi_state_lock));
>>> +	/* NULL wi_state assumes auto=true */
>>> +	if (!node_bw_table || (old_wi_state && !old_wi_state->mode_auto)) {
>>
>>
>> I was confused about the node_bw_table check at first. Maybe
>>
>> /*
>>  * We can get hotplug events before any BW data was recorded.
>>  * ...
>>  */
>>
> 
> I went back and forth on whether to do the mutex in or outside this
> function, but ultimately decided inside is just better structurally.
> 
> But yes, this comment seems warranted in this case.
> 
>>> +	/*
>>> +	 * HMAT and CXL report a node's bandwidth only when it first gains
>>> +	 * memory, so recompute the weights whenever N_MEMORY changes.
>>> +	 */
>>> +	wi_state_refresh();
>>
>> If the function fails, should we at least pr_warn_once() ?
>>
> 
> The only failure state is -ENOMEM, wasn't sure that was worth warning
> on.  I actually debated whether to just make this a void function.
> 
> I don't have a strong feeling here, but happy to add a warn if you
> prefer it.

I'd assume we'd at least want to tell the world somehow that something is now
imprecise?

Or is not updating that harmless?

-- 
Cheers,

David
