Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920344;
	b=0sdPQcWl01NUTlQSoXBhncKc+ykT6eaLq4aXOJXN0GmAKAE7IaF9H20VboG5c/mR5jm/
	 l+hN8mTHG5ufsPRINaPrgOKKSSJ2fsjgOTEVckDQKkTvEhRb6hHsVeU3sgiz9KF4zZlig
	 shxWxtkov9Y5FLfD0DWN36huO7ZlvTx54BUIxnBk2d+ZJ1l7FwqS/TEzzYz8Xs/SjjCA1
	 zyCthK6g/VrXE0gZWFZNNlnI7jhANqNYIcvUfJVC3ce8f3z3/jiB6HvWqdApf8N5enp7A
	 07iwuBk0CzGME0y61ocPuGjLZ3OlGSEr8gofD6lIOqeqx2FLU8cefHYS706GWkGyytQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920344;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=P/iIhIHbJi0Ry1aV+mvg4mIMdsNQGqRfT0aLhVEY/6g=;
	b=JISwqcXRX1vHoLHMc53m12ZiPomq6U4x2yFNfChPgSDTXBXqo6hle4cCvmPS+l4zA844
	 YRO/fSFD5pBFJjVI79UJATjATt2p79Ix7C3YYvZDsydlQiJQdJOvLECEBxHUNn3c04cbW
	 JIO0ql+0E2PKWCNBYtS4eKj4EdDXh7fjswsFP6LxMSwcIcSKhvk2vISD0IfAEtnlZT/VQ
	 tIHZY24D5hGwGzIC3TJT1YkXwLIc9h4xX7+dIxLeuXFZx750FqqXCDns0V/kkmCJWubmv
	 hJEm5Hn+bY2WpfHhNUWhBL6ZrIfuoLqDWaVTazPePYWqOQkDHwNcoOBcH0lyy6IV0tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPAeyU1b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601D9606A89E;
	Tue, 17 Nov 2026 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPAeyU1b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5D71F000C6;
	Tue, 17 Nov 2026 12:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920344;
	bh=P/iIhIHbJi0Ry1aV+mvg4mIMdsNQGqRfT0aLhVEY/6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OPAeyU1bcr8bRfKjvwodvxzewD4ztke+RkTghZNG3xec746dQSVKR7e0AMI3CSvEk
	 9MAxhAYnGHoa99PgtFgvEXOVzdccfvGUD7QS+NXoB79vjmvesVpd0UjcH3UYh/a316
	 a5hyqbDa3FjuJlJr3dWTM4tpzZvSGLBEidzJ35Qj9M5D1Vnm/XGLKNqqPP9vFFeX32
	 lNwMB8odTs7mnL/1cGCIpLi5K4j/5nKf6MVoKPCQspaCwvO4g6sCFt9s57Os3JUeAZ
	 UM2Qnqmj3HyMgYutVzKEMXSVOtf0WDQhoI2ICzWRK1WepJcHnvDfYTj7WcuikOAmYT
	 rSBM+RpWMoDCg==
Date: Tue, 17 Nov 2026 07:59:02 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	Yufan Chen <yufan.chen@linux.dev>, dev@rebasedinc.com
Subject: Re: io_uring/eventfd: registered eventfd signals only once after the
 cd305ee3633a backport (6.18.y, 6.12.y, Ubuntu 26.04)
Message-ID: <avxPlrd77WiXagvs@laps>
References: <oMhla8VwCWoihfrmgn8znIy60W1QXI8g_v2OyB9i6sWESIDlVJlwoGGOLylJgIHRARNoieXUVRGqzeB__KvHMdXgnCfPPovs8vLMOzaMPEw=@rebasedinc.com>
 <draft-agent5-0001-re-eventfd-signal@kernel.org>
 <5d92861f-9a4d-4810-8700-b9e457ed9c86@kernel.dk>
 <2026111605-deskbound-clobber-a4a1@gregkh>
 <07947062-2974-4630-90db-1556e25b50bb@kernel.dk>
 <avxLtZ2YLHdbeZxC@laps>
 <8e6c1d69-9910-4c89-832a-34ecd65a0ca7@kernel.dk>
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
In-Reply-To: <8e6c1d69-9910-4c89-832a-34ecd65a0ca7@kernel.dk>

On Tue, Nov 17, 2026 at 05:45:53AM -0700, Jens Axboe wrote:
>On 11/17/26 5:42 AM, Sasha Levin wrote:
>> On Mon, Nov 16, 2026 at 07:21:38PM -0700, Jens Axboe wrote:
>>> On 11/16/26 2:52 AM, Greg Kroah-Hartman wrote:
>>>> On Sat, Nov 14, 2026 at 11:12:40AM -0700, Jens Axboe wrote:
>>>>> On 11/14/26 10:42 AM, Sasha Levin wrote:
>>>>>> On 2026-11-13, dev@rebasedinc.com wrote:
>>>>>>> If this is correct, a backport of 04fe9aeb4f3c to 6.18.y and 6.12.y looks like the right fix; it keeps the CVE-2026-80920 fix in place.
>>>>>>
>>>>>> Queued for 6.18 and 6.12, thanks.
>>>>>
>>>>> Yet another bs CVE - Greg, please invalidate this one too, it's NOT CVE material.
>>>>> Getting a little tired of chasing these.
>>>>
>>>> Now rejected, sorry about that.
>>>
>>> Not sure how we improve on that, it's really annoying to catch these bogus
>>> ones after the fact?
>>
>> Hi Jens,
>>
>> Since some of our reviews are LLM based, I was looking to see why this one was
>> flagged as a security issue.
>>
>> From the explanation, and looking at the code, it seems that we can register an
>> eventfd with io_uring, then have epoll watch that same eventfd. When something
>> wakes the epoll, the kernel is holding epoll's wait-queue lock. That wakeup
>> runs io_uring's poll handler, which signals the eventfd, but the eventfd is
>> watched by the same epoll, so it tries to grab that same lock again on the same
>> CPU. The CPU spins forever on a lock it already holds. One core is dead,
>> followed by RCU stalls, machine wedges. Any unprivileged user with io_uring
>> access can do it.
>
>I think you're looking at the parent of that, not the followup. Yes the
>parent is a real fix, it's similar to the eventfd fix in mainline as well
>for that exact issue.

If by followup you mean 04fe9aeb4f3c ("io_uring/eventfd: reset deferred signal
state") then yes, I don't think it's security relevant, and it never had a CVE
assigned.

cd305ee3633a ("io_uring: defer eventfd signaling when queued from a wakeup
handler") is what had the CVE assigned to it, and what Greg rejected earlier.
Should the rejection be reverted then?

-- 
Thanks,
Sasha
