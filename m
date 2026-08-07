Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB33F4845;
	Fri,  7 Aug 2026 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145361; cv=none; b=aoYu3tY1lzZctrR0JafT1WWJ8X1DwRJI07mgemTQHuon5+qlAG8mdsNYPvEeybi9l0WqODvmA66yn8QPvV4wec5kKhqWcyujsSucuMd/8Ffbui750IXMEM7HFGDr89ayqMMWqVFrun2RybS6EPUGiewChcIW+ghE2xL6xw7+KyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145361; c=relaxed/simple;
	bh=1U9D00chGx9eu21TOd7HaIlO5ndkNBfGJHeZDUxpt/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHVzNu6PEqV8K6yvSl4ztL72s80T+Fjubw0V0c8JkwCg34GfLQVT2/f/9XrQVOtZPzyfgpoItd3tPhF04172R/D5levmL1eeWWBql4LB/10J0jdMOsSRzwOGDIqZAZG898PXlCGSoN7SFZ/HMXgbAJpmWYSSuf8+dfLav6Ukcgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Lg25hY9D; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Lg25hY9D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1786145355;
	bh=1U9D00chGx9eu21TOd7HaIlO5ndkNBfGJHeZDUxpt/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lg25hY9DdWPYXNnD9gMYhRdndoPbND4FhuX/PxTKVVr/2DosXyXb1MXicDr0GY4za
	 8AF3BQcHrKqxJ7GsABwsBww7/s/mqQlweifETpDZv4057DKmb2cEF9NGkCPs/ELZmW
	 jX0n+WXaa+kZVA5m24WMwKs4D3em+O4CsvHycOIkVVItIoN0X7SpratoKJDttbVtBE
	 /QPr9Nj8/mDXxjrrZrCoM8ZYbX7YcLwwip5uh7EoCSrJzHbtAauA7zAMHTGwTTlkH5
	 19TFQTLA8m6zZR17pA0sUHWINWJI9ZxBs3gyrsbFi8/eF9Ly13voLEv6vVBB3r/pZN
	 IlnLuB+JVbnig==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 171E9600C1;
	Fri,  7 Aug 2026 23:29:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 40112200F79;
	Fri, 07 Aug 2026 23:27:15 +0000 (UTC)
Message-ID: <dcb59215-35f3-4518-91d6-ca265be5d9c8@fiberby.net>
Date: Fri, 7 Aug 2026 23:27:13 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: reset late connection after listening socket
 close
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kristian Nielsen <knielsen@knielsen-hq.org>,
 stable@vger.kernel.org
References: <20260807194513.1263310-1-ast@fiberby.net>
 <CAAVpQUD9RTxs742Ty-UQXJJwTbN2wrnFGQDffKN0eZL4udq3Ng@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <CAAVpQUD9RTxs742Ty-UQXJJwTbN2wrnFGQDffKN0eZL4udq3Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you for your review.

On 8/7/26 9:05 PM, Kuniyuki Iwashima wrote:
> On Fri, Aug 7, 2026 at 12:47 PM Asbjørn Sloth Tønnesen <ast@fiberby.net> wrote:
>> In commit c82199061009 ("task_work: remove fifo ordering guarantee")
>> Eric removed the ordering guarantee, thereby changing it from a
>> guaranteed FIFO to currently LIFO ordering, in an effort to reduce
>> jitter.
> 
> Could you elaborate a bit more on how c82199061009 introduced the issue?
> 
> I didn't quite see the connection between the first and second paragraphs.

Sorry, I didn't elaborate more, it was already getting quite long.  I had also
hoped that the bisection had yielded a stronger and clearer connection, or that
this commit had been blamed before.

My understanding is that due to the LIFO (Last In First Out) ordering, the order
and thereby timing sequence is reversed. I haven't looked too deeply into the
specifics here, like which items have been scheduled together etc., as I don't
suggest reverting the blamed commit.  I have rather focused on fixing this TCP
quirk, and make it work with LIFO ordering, and not restoring the FIFO ordering.
I have mainly used netstat counters to debug the path taken by the affected
connections, and identify where and why the connections died.

I was also skeptical of the bisection result.  Did my reproducer have a false
negative?  However by reverting the commit, and thereby re-adding the order
reversal logic I have reliably proved that the blamed commit is deeply connected
to the experienced symptom, on everything I have tested post-v4.3 (the revert has
a trivial conflict on v5.10, but can then cleanly be cherry-picked on the current
net tree).  I have tested with my reproducer on v4.3, v4.4, v5.10.y and net, both
that my reproducer detects the issue in the tagged release, and that the issue is
gone with the revert.  I tested v5.10.y as the original report was against v5.10.


> The listener's state could change at any time on SMP.

True, but it won't schedule work items, and execute them in reverse order, which
IMHO makes this race condition a lot easier to hit with LIFO ordering.


>> This allows for a TCP handshake to complete, after the listening socket
>> has been closed, and after inet_csk_listen_stop() has been run.
>>
>> In that case the client sees the connection as ESTABLISHED, however in
>> tcp_v{4,6}_syn_recv_sock() the call to __inet_inherit_port() returns
>> -ENOENT, and the new connection is dropped silently by put_and_exit.
> 
> Note that if __inet_inherit_port() passes, inet_csk_reqsk_queue_add()
> calls inet_child_forget().

__inet_inherit_port() consistently exits early with -ENOENT, because
inet_csk(sk)->icsk_bind_hash is NULL for these ill timed connections.

inet_csk(sk)->icsk_bind_hash is NULL, because inet_put_port() has been
called.

inet_put_port() has been called by tcp_set_state(TCP_CLOSE).
