Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6577D38E121;
	Sat, 18 Jul 2026 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784383178; cv=none; b=bUQBjsOS1nqwL9mDVSAHfPrV5ililbCI4zRF8r21Eu2iA0iJCT4eF6wMiDkw67j9yoUv86fWahLeDhObUIpOSsescJ+W4iVY22hT1iCTYqQhLZ0T7jQg3WB39ha2y3pbnj8hq7il8hHnJBy94O3sjfetuhJkQeEVan9KIp5b60g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784383178; c=relaxed/simple;
	bh=1rkOcMAKahVXXzdbwL6jp+tHQq1MrjFUD+tz/EaSkck=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=uZvNHTM3qdjvoRuGon6aJ1goPK/S99h3M36ltwKQbGcazWs1Oei0cMJwFSAb+/f8yuPPLsx23l+IrbXlXSJOTnjC9gp2L4ozOTx3tE4CsF8dz732E59q2I2wFfDeOnAOlpjL71BRE9QSmX5oYfj9WioxoRQPy8v42+qPcM7/tP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=lJQVKSau; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="lJQVKSau"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784383171;
	bh=OTpp8yf78iDR2OXfdNQC44b97GzxYwSSmTcX94DZ0eg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=lJQVKSaudD4s84uc7zVJ5jP1xrW/8cxLjMbVBG/GB1x8odQGpCUwy/3OsKCEcoq4J
	 dYJLMdGEJSRjUzNuRtW7FJwbjUy1DO9AQ3qi9j0lnSQRAI4k+4C1GruChaEaH+7/I6
	 taMTnvLXhWOxmJWbLiZGdaL8lm1wXKKkLnQ4HWWI=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4h2T0z6c04z10yd;
	Sat, 18 Jul 2026 13:59:31 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4h2T0z2dmTz10yX;
	Sat, 18 Jul 2026 13:59:31 +0000 (UTC)
Date: Sat, 18 Jul 2026 14:59:31 +0100
From: Bradley Morgan <include@grrlz.net>
To: Oleg Nesterov <oleg@redhat.com>, "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
CC: brauner@kernel.org, akpm@linux-foundation.org, jack@suse.cz, avagin@gmail.com,
 ptikhomirov@virtuozzo.com, mjguzik@gmail.com, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pid: fix cad_pid use-after-free race
In-Reply-To: <alt9fbrO1WlJg-Jh@redhat.com>
References: <20260718032000.9184-1-blbllhy@gmail.com> <20260718032000.9184-2-blbllhy@gmail.com> <alt9fbrO1WlJg-Jh@redhat.com>
Message-ID: <FF14144B-5235-4805-8E78-5C1AFBCC631A@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On July 18, 2026 2:19:57 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com>
wrote:
>On 07/17, Cen Zhang (Microsoft) wrote:
>>
>>  int kill_cad_pid(int sig, int priv)
>>  {
>> -	return kill_pid(cad_pid, sig, priv);
>> +	struct pid *pid;
>> +	int ret;
>> +
>> +	rcu_read_lock();
>> +	pid = get_pid(rcu_dereference(cad_pid));
>> +	rcu_read_unlock();
>> +
>> +	ret = kill_pid(pid, sig, priv);
>> +	put_pid(pid);
>
>Hmm. Why do we need get/put_pid() ? I think that
>
>	rcu_read_lock();
>	ret = kill_pid(rcu_dereference(cad_pid), sig, priv);
>	rcu_read_unlock();
>
>	return ret;
>
>should work just fine?
>
>Oleg.
>
>

On 07/18, Oleg Nesterov wrote:
> Hmm. Why do we need get/put_pid() ? I think that
>
> 	rcu_read_lock();
> 	ret = kill_pid(rcu_dereference(cad_pid), sig, priv);
> 	rcu_read_unlock();
>
> 	return ret;
>
> should work just fine?

youre right that the get/put is redundant. kill_pid() doesnt sleep, it just
grabs tasklist_lock, so doing it inside the read section is fine and the
extra ref buys nothing.

but i dont think either form is actually safe, and thats the bit id like
Cen to address. rcu_read_lock() only protects the pid if the freeing side
defers to a grace period. on the cad_pid path it doesnt:

proc_do_cad_pid():
	put_pid(xchg(&cad_pid, new_pid));

put_pid():
	if (refcount_dec_and_test(&pid->count)) {
		pidfs_free_pid(pid);
		kmem_cache_free(ns->pid_cachep, pid);	/* synchronous */
		put_pid_ns(ns);
	}

thats a straight kmem_cache_free, no call_rcu. only free_pid() goes through
call_rcu(delayed_put_pid), and thats dropping the hash reference, not the
reference cad_pid holds. and the pid cache isnt SLAB_TYPESAFE_BY_RCU:

	kmem_cache_create("pid", ...,
		SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT, NULL);

so:

	cpu0 kill_cad_pid		cpu1 proc_do_cad_pid
	rcu_read_lock()
	p = rcu_dereference(cad_pid)
					put_pid(old) // last ref, freed and reused
	kill_pid(p, ...)		// UAF
	rcu_read_unlock()

your form and Cens both hit this. Cens get_pid() is no safer either, its
a refcount_inc on the same p thats already freed, so its a UAF too, not a
more careful variant.

to make the rcu_read_lock() mean anything the writer has to defer. either
proc_do_cad_pid() drops the old pid via call_rcu instead of a bare
put_pid(), or the pid cache goes SLAB_TYPESAFE_BY_RCU and the reader uses a
not zero tryget. with the writer fixed your clean form is exactly right and
the ref stays unnecessary.

its reachable when cad_pid isnt init: root writes a pid, that task exits,
cad_pid ends up holding the last ref, and the next write frees it while a
signal is in flight.


Thanks!
