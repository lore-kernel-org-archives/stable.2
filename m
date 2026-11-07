Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794086089;
	b=TI5C21BiC2UkB6wZAK7kQUi6mkZDjwzyqvonqaqMqIL1guwE/2MafY+G3ry/rLvFyzYj
	 VOGspVEcMMiT/gIudyw0WmUe70zCrnQsHJjHDtNWekPOC/R4sXKndwipRL+wJNsIOIlSq
	 V+nzHPPUaQmgigVeWcRE4tcTKQM2aFqHEuCPkTTOwnRhzs3HsaZ0uQHb96GW0N6MSVbIb
	 Ha/JnJvc/TIp45HfQCInUjtE1F+z6EIHu3kickQ6sY6eFJk+WigXHAgpkuwLaQgvarv2X
	 8jngtHkYgiUO5H5wJ7CqpA74lBWCAHEBLWSxUfZIfirCrwm0WyOlxm/Cvrmy+1od+gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794086089;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=L8V3inSiCvYAoVBReXI9vvNcWuNJxsnYO7X55U0Kf6k=;
	b=z5KZllmNNcFq2TfQXIuBdwpDhwQwS0Ghl7HDr+rgO13x49JfKCA6bJ49xgDJjMCFSL5/
	 Pc2A6e8hctOTibDN5NW/anRKoXNbSl9G5A7pDtwu5IDFkiVUF1hZpeATeqDq0Im2skReH
	 Yat+FpBxRzF01clfyljNOWOG+WLXHpJQ5CksKwGZg16FwjZwiaCXqRoCIOuS6ZKp0Ltw9
	 TRNbnOv2AMll7fezN/ZonptdWwV4R7nnSyJf+IC18KMoH0i5O9VQJp96wNrlHW1q4/Xm0
	 0X8CHhgcNmmrrmr46JDPu5Z7q+GF8o5UpMiCN3ktiS1T8xJ18VUqQpimPKnJ/8m4bdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ITg3T+LE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B0606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ITg3T+LE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A7B1F0089F;
	Sat,  7 Nov 2026 21:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794086088;
	bh=L8V3inSiCvYAoVBReXI9vvNcWuNJxsnYO7X55U0Kf6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ITg3T+LEiE/G/+YgujeXFBD8hgerSGUR1CnV8l91iz6n86IYQw7uCiaZsOEJSU8Fh
	 sW2GtgvO7UjZXo0P4ImmXfA5PxTfWeuTxWRZd4TrdRscgdnXW1+YLvZ04+GFWJpAp8
	 jVqBasj27U7xxEtAlHk0qeSEN7mb9XbJJK1l5SzhY8pQ7AmSS26oCOcB+Bd0TU4ujq
	 XZwfcax9cITNAvFcXSAkz+p+N25MuIwMey6Xz4VafzB/9Wz1ep8oRPsG4TBuIH2/Rn
	 M7dcgO4EhBhkKbab2jnluRjlkydLQQlyh1+sMfQ+MFbtlToQHtZxrB4Q9ERQxJfiQE
	 pyLpQjOwyz3sA==
Date: Sat, 7 Nov 2026 16:14:47 -0500
From: Sasha Levin <sashal@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] fsverity: Explicitly require FMODE_READ
 to retrieve hashes" failed to apply to 6.18-stable tree
Message-ID: <au-Ux9Sunxhat_jo@laps>
References: <20261107051544-failed-6.18-1acb4fd2d011@kernel.org>
 <20261107190447.GA6049@quark>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261107190447.GA6049@quark>

On Sat, Nov 07, 2026 at 11:04:47AM -0800, Eric Biggers wrote:
>On Sat, Nov 07, 2026 at 05:15:44AM -0500, Sasha Levin wrote:
>> The patch below does not apply to the 6.18-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
>>
>> To reproduce the conflict and resubmit, you may use the following commands:
>>
>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
>> git checkout FETCH_HEAD
>> git cherry-pick -x 1acb4fd2d011c4bd6cc961095ae17361c71ff61a
>> # <resolve conflicts, build, test, etc.>
>> git commit -s
>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051544-failed-6.18-1acb4fd2d011@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'
>>
>> Thanks,
>> Sasha
>>
>
>Actually a clean cherry-pick, and failed to Cc the fsverity mailing

Ah interesting, looks like my scripts were a bit confused about the two Fixes:
tags. I'll look into that.

>list.

So I feel we have had the Cc discussion quite a few times now. We really have
to limit how many mails end up going out: this last release had thousands of
mails which took hours to send. Adding more lists will simply kill the mail
server and will harm everyone.

We have solutions for that!

See Konstantin's writeup[1] about lei with filters like dfn: or dfhh:.

We're not going to change this on our end: the kernel.org folks will complain,
mails will take days, and people will be grumpy at us.

If this is really not something you can work around, then we can figure out a
filter to exclude your patches so that all of us can continue being happy going
forward.


[1] https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started

-- 
Thanks,
Sasha
