Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E7E4279FE;
	Mon, 28 Sep 2026 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790579730; cv=none; b=lmOYJzIkbzrmqTnhRfD7p9FnpRWCZ1ePguy45csBqSxaLqltE6ghXrNZRbY5bJ8ri1wTTzSAZExYy2xHTvSMztwjPewnU7UGCidQG8/VEs4tHI8xuOCvt+E3qXvq80ueX5uQEIOjUfkpomsRjqq+Sof2m5njAcPhNAuS4LZWMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790579730; c=relaxed/simple;
	bh=pCLdWFMgKsKisy2WjAepMo5/ZGxFC2PlKshlWqROeVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dS1xI612WWSGPnaA9qD7JK6zPdFgkm/RJB77BymV5TAcmIjVfsR97WpMTmPL06QhhX+rmvTjfDMQiQlRaKG811KO/r3aWXFSxLLodryCKAh+LsqclBPLg+aq1ugIexVOdZK0C0IXJJItF+bDkHjsW5D7V4QXa2IIXgzmNkpcCAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=mYcxzWId; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="mYcxzWId"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=2TBoZsP4tks+iFccUSUyZdtg7yhhLexUTkXVqLs0Rb0=;
	b=mYcxzWIdxREOFPjdOg46SXOuWLcBx+aB+r/LbWjE/sYac9F0H5n1nExpRuNILY
	MzYPctgCgEaJh1AF1Zbvp6mu4T16CIkZ+4/KHzV+q9K8GcqWSJGCgI4IBHYLiJiw
	mu1RZ9EbX5O9+yTgvSI6fNFWYZodIbkYEcAQeFo8PyU1A=
Message-ID: <d3f4ae98-3340-414b-9bd0-9f4588810821@126.com>
Date: Mon, 28 Sep 2026 15:14:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 1/2] ice: detach the VF representor when
 ice_start_vfs() fails
To: netdev-bot+sinfo@kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
References: <20260928065306.1514795-1-xiaolinkui@126.com>
 <179057875290.31693.7249107578001642813@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <179057875290.31693.7249107578001642813@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PykvCgD3l7bRE7pqg2NgAg--.15825S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar17tw17XFyUJF18tFyrZwb_yoW8Zw1xpF
	Z0vFZFgFsxJF1IkFy8Zw40v3Wftrs5GFWUWr15KrWjvw15GF15KrZFgr4UGa4DGFyfZ3W0
	9wsFqrWqvFyDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxDGOUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqBNCGWq6E9MC1AAA3m

Hi,

Thanks for the review. Please find the missing information below.

- How the issue was discovered:
   Found during manual code inspection of the ice VF setup/teardown 
error paths. It was not reported by syzbot, a static analysis tool, or 
an LLM scan, and was not hit in production.

- Whether the issue was actually triggered:
   Not actually triggered. It is a theoretical error-path cleanup issue 
found by inspection; no stack trace or error message was observed.

- Hardware tested:
   Not tested on real hardware. The change was only compile-tested; no 
affected Intel NIC/firmware test was performed.

The same applies to patch 2/2: it was also found by the same manual code 
inspection, was not triggered at runtime, and was only compile-tested, 
not tested on real hardware.

If a v3 is needed for other review reasons, I will include this 
information in the commit messages.

Thanks,
Linkui Xiao

On 2026/9/28 14:59, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 
>   - What hardware the change was tested on. For driver fixes please
>     mention the device (and if relevant firmware version) used for
>     testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

