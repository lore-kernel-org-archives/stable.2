Received: from mta0.migadu.com (out-160.mta0.migadu.com [91.218.175.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07F73839AC
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 03:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010851; cv=none; b=QTy+2oDTNrO7s2+bJ3CjqyWAFjrkmoSw0qbWD9ZWkjIw2+rC55Y1bTZ+bDM+MRspHm4e8qI+RjekdD7r31KlFWuC+Fn3+g2KPp1mcYqT6/KxZUa54hlGAeiFH9QQbdbu0WAvbBunoXkDV3hfVpIvLzc1E9Bz2KU14reFdtr8Kk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010851; c=relaxed/simple;
	bh=gHja9HIu/bxkuNrmbSELtJIfILpHnzbnGexXRFGXaTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEN1AyIqzUqicbC52dOfSBQoVVnaTkNDCUdbMyCqkcGGWO8GOi2vGF7f+tTppdbsndTDUjCW8tFonDvg+jSusUK0koOnjMP+H76gxy2Tz6KtBPVa9N0zxQANBTc76Ons3sVXOUehtmlcaLj421Lcd9xVD52HhZpTKjU+XI8lly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lo7NfiWl; arc=none smtp.client-ip=91.218.175.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lo7NfiWl"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gHja9HIu/bxkuNrmbSELtJIfILpHnzbnGexXRFGXaTI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789010844; v=1; x=1789615644;
 b=Lo7NfiWlBUoaMBaVabNZEMA5Hs7BA69FJRiR3Q1CbsfHcDF9CedmR4Q0XWAf+igMS1b6UpzL
 G2DFPaU5o0f3mt/0hmXT/m0gubSrEsHiMy5lSdEhfnkzztgNMGJ4uAqIQEIjplLYl0+S/LkHYYc
 fPj/jzQrHlVKK0XUTtrwHeoQ=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d91fe77cc28b0de6;
	Thu, 10 Sep 2026 03:27:14 +0000
X-Mizu-Trace-ID: d91fe77cc28b0de6
X-Migadu-Flow: FLOW_OUT
Message-ID: <675259f9-c093-439c-a411-1937b23ddaa2@linux.dev>
Date: Thu, 10 Sep 2026 11:28:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: fix lost error code from codetag_load_module()
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
 Bradley Morgan <brads@mainlining.org>, stable@vger.kernel.org
References: <20260827030503.49171-1-hao.ge@linux.dev>
 <20260907213815.0-da.gomez@kernel.org>
 <9acf2cd9-b808-42f0-bc86-7ffcaac965a0@linux.dev>
 <20260909234838.3-da.gomez@kernel.org>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <20260909234838.3-da.gomez@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Daniel

Thanks for you comment.

On 2026/9/10 06:00, Daniel Gomez wrote:
> On 2026-09-08T17:50:33+08:00, Hao Ge <hao.ge@linux.dev> wrote:
>> On 2026/9/8 03:42, Daniel Gomez wrote:
> 
>> I skipped it because alloc_tag is the only codetag type and it
>> already cleans up after itself.
>>
>> With a second codetag type the problem Sashiko reported could indeed
>> be triggered.
>>
>> My thinking at the time was to do it in codetag itself, as a separate patch,
>> since it feels odd to unload something whose load just failed.
> 
> Then, why returning an error at all? I don't see why not doing it inside

codetag is a generic framework with a dedicated section in modules.
We keep this error path to account for possible future data stored
in this section, allowing us to perform security and validity
checks for codetag within codetag_load_module.

> codetag itself wouldn't work but it's a "bigger" change. IMO, the error
> is supposed to be handled at load_module() then, the unwinding as the
> rest.
> 
> 

I'm worried about this as well. Invoking codetag_unload_module() here
brings kvfree_rcu_barrier() into the error path and triggers two runs of
->free_section_mem() (used=true from the unload, used=false later from
module_deallocate).

My idea is to let codetag handle its own cleanup while keeping the logic of
our current patch. Maybe we can put this patch on hold temporarily until I
work out a proper solution. How does this sound?

Thanks
Best Regards
Hao
