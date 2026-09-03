Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0982A360EEE;
	Thu,  3 Sep 2026 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429093; cv=none; b=sUiHPD5pZeArg/uXaW3bakZCg50xZBTDXJszR+WqsYnNupynUeALnvxbtjS57GJEihq5wF8eAX3I8IrzdM6JiIUPAnkL5sjVqRQTFcJ+qT9pztQB+4mOC4MCZBd0QNRQZVjGC+jbkIkXkYtUU8lCIja22Sthuf+vKqV+e5TGCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429093; c=relaxed/simple;
	bh=tk0XKv/xbGysV5EUHKtP/b5QDrr4+DZ7gZLg8zJWezc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGR1o2PevC+kYD9ikcdplD8tvs0r52LHbWsAKKIRdQ2Kmz4zCoOcXnoOCJ859La/WG32i5i2eO8wpDgvfYQHYqwKPYZxniO88tX68jYR6cF0V/kOIeu6GcnEEPJDXDJ/AIooi31f4fUMARND/vB2WlLPvmb6HVxdQZvTNmaqKmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tzqSK2z1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tzqSK2z1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 491F41596;
	Thu,  3 Sep 2026 02:51:27 -0700 (PDT)
Received: from [10.1.39.91] (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D7D83F7D8;
	Thu,  3 Sep 2026 02:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788429091; bh=tk0XKv/xbGysV5EUHKtP/b5QDrr4+DZ7gZLg8zJWezc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tzqSK2z18xeUjfX+79jfyQmlmg+SAhdjvPBRtPQthYdW3zwo3mGY1c9EUA/yUyGCz
	 mToKxgIDI3896p2/aoXorWi7LPqniyQ3t+Oj/h83s15XvinW81+dMkRFJBURbqlsnL
	 LvXwCPep94lUoulkaYYGqppkhlpYRaXyPVGXFqg4=
Message-ID: <3c369451-be95-4c64-9e52-b456f4aa8c42@arm.com>
Date: Thu, 3 Sep 2026 10:51:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: pcc: Synchronize channel IRQ before unmapping
 shared memory
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260828161033.3783599-1-christian.loehle@arm.com>
 <20260903-impetuous-exceptional-python-db8aba@sudeepholla>
 <20260903-subtle-cornflower-guppy-b64a03@sudeepholla>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260903-subtle-cornflower-guppy-b64a03@sudeepholla>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 10:10, Sudeep Holla wrote:
> On Thu, Sep 03, 2026 at 10:03:38AM +0100, Sudeep Holla wrote:
>> On Fri, Aug 28, 2026 at 05:10:33PM +0100, Christian Loehle wrote:
>>> pcc_mbox_free_channel() unmaps the PCC shared-memory region before
>>> mbox_free_channel() invokes the controller shutdown callback. For
>>> interrupt-capable extended subspaces, an in-flight handler may
>>> consequently access the mapping after it has been invalidated.
>>>
>>> Release the mailbox channel first so its IRQ is disabled and synchronized
>>> before unmapping the shared-memory region. Serialize PCC channel
>>> acquisition and release across this sequence: once mbox_free_channel()
>>> makes the channel available, another client must not replace the
>>> shared-memory mapping until the old one has been unmapped.
>>>
>>
>> Breno Leitao has already posted the fix for the unmapping before freeing
>> the channel. You just need the mutex guards.
>>
> 
> Failed to add the reference to it [1] earlier.
> 

Thanks, I didn't see that.
I guess I'll wait until Breno's patch hits linux-next
or linus' tree and rebase?
