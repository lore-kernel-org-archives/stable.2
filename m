Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94031399374;
	Sat, 18 Jul 2026 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784384898; cv=none; b=vBzox9a2zrUslpXWtOIj2U5/xSdN+XDDVAxpDzDN1e6zshgsDSKrqbFxw9EZ4m33iMMi+Ulj4axeglMfbeP5ENbYJKgGhHukl+VZ02eiRwHCaG60lrFA4mpMOQVEUV4gcS/x6BSLFVC1buKpQdYub7lMmLnf7agDUUCOORW8Xcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784384898; c=relaxed/simple;
	bh=1VkXhmmb0DhF7Og9v2tE2Kla2LQqS/fNi988e672Rxg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=L8jyWlHvG91HuvaUHn870uVlnlLbU+dtUKye2ui9YgGuWwjzoZ8IauWyU21lq6b9U5PU6ByEc/aFg0QX6F2Iw/d6qjwu4K3vUFNnzJBk7sHg7m8vfWDh0Ag/zwjBg67whBnCv5DPqVDhd7Pfx8pPWufJMgiecGF30LD3qdIsZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=agizPuk0; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="agizPuk0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784384888;
	bh=ufsgsrTSiJWaJLvJwdnseOvCwN0XDtHy+S3pzI85IdI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=agizPuk0VsCBS8KXuzrfcHzzwsAxZdWqDsxufwdEHLG396svHYxgZ8dpzzeoVsoFS
	 8luEUIa3GcDTqIM+U2f8LADjrKHwGnAmAKpHu+0+6wtS5Sz+mLHk/8L+1sOdk8HOQq
	 6L0O2Rl4BgbS6kNg3BgveKRcmam6qLZoyyqCZhJQ=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4h2Tf03Bbkz10y0;
	Sat, 18 Jul 2026 14:28:08 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4h2Tdz59f9z10xJ;
	Sat, 18 Jul 2026 14:28:07 +0000 (UTC)
Date: Sat, 18 Jul 2026 15:28:08 +0100
From: Bradley Morgan <include@grrlz.net>
To: Oleg Nesterov <oleg@redhat.com>
CC: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, brauner@kernel.org,
 akpm@linux-foundation.org, jack@suse.cz, avagin@gmail.com,
 ptikhomirov@virtuozzo.com, mjguzik@gmail.com, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pid: fix cad_pid use-after-free race
In-Reply-To: <aluKEZtkhbC0yUcT@redhat.com>
References: <20260718032000.9184-1-blbllhy@gmail.com> <20260718032000.9184-2-blbllhy@gmail.com> <alt9fbrO1WlJg-Jh@redhat.com> <FF14144B-5235-4805-8E78-5C1AFBCC631A@grrlz.net> <aluKEZtkhbC0yUcT@redhat.com>
Message-ID: <D0BBE2D6-3D4D-4961-9A79-9C4D3F035642@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On July 18, 2026 3:13:37 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com>
wrote:
>On 07/18, Bradley Morgan wrote:
>>
>> On July 18, 2026 2:19:57 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com>
>>
>> > Hmm. Why do we need get/put_pid() ? I think that
>> >
>> > 	rcu_read_lock();
>> > 	ret = kill_pid(rcu_dereference(cad_pid), sig, priv);
>> > 	rcu_read_unlock();
>> >
>> > 	return ret;
>> >
>> > should work just fine?
>>
>> youre right that the get/put is redundant. kill_pid() doesnt sleep, it
>just
>> grabs tasklist_lock,
>
>(no it doesn't take tasklist)
>
>> but i dont think either form is actually safe, and thats the bit id like
>> Cen to address. rcu_read_lock() only protects the pid if the freeing
>side
>> defers to a grace period. on the cad_pid path it doesnt:
>>
>> proc_do_cad_pid():
>> 	put_pid(xchg(&cad_pid, new_pid));
>
>I must have missed something.
>
>But this patch adds synchronize_rcu() before the final put_pid() ?
>
>And. If kill_pid(rcu_dereference(cad_pid)) was not safe under
>rcu_read_lock(),
>then get_pid(rcu_dereference(cad_pid)) would be equally unsafe?
>
>Oleg.
>
>


oops, my bad. Brainfog.

Thanks!
