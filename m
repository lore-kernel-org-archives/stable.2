Received: from mta0.migadu.com (out-105.mta0.migadu.com [91.218.175.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB38390614
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 03:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010214; cv=none; b=mY0mjSc2I3QadZ65LWT3mq7mh1Jmjupqv6VIDLM5k1X/xQtHHaSUs4foxYhe6EVNp3of0GcTPmtjc/po2sE/JkUC4lsahvBX6QwmD9omi3RRtHWZpA1+6hMpWbH1BnVFg2pCTXd5bDY2SlSLFJS9zX7qXDLzBGQZD11avvQmN3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010214; c=relaxed/simple;
	bh=Knvj+VPZsAtqLDiQ3Jx3vB3yWmalcCvTEycyDBhhTa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpjZM6pW7XEek/bdwXlxxocb29bi+DZQVqhKeK34nop9/gEXDRfJYqni1xGh+eNN8gWF040d5o2wcLC+8fng4F8XEMwkljbzqWAIIGjECHP3FIjSg59KyaCrlkYhiGP2GRyXJ5+q8wfqdNoui0bTN7tTXMveLKHzh/x9faerZ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=njO63hK0; arc=none smtp.client-ip=91.218.175.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="njO63hK0"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Knvj+VPZsAtqLDiQ3Jx3vB3yWmalcCvTEycyDBhhTa8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789010209; v=1; x=1789615009;
 b=njO63hK0MTHREW0+rd0MKx0osLhUVAIXgZyMrNudpFqN5u0SoN5LlxfEz/wgHjeJtmg+Jh0S
 0GbB3/Pml9skSlCirQvaLGJmeYD1nFkIgjUIbQSSp34ALapnvhrv1Pwo5Ga8FIvyOl71K03Sk6f
 GPcW1fBTOWflsLW34hoFkXQM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9e91a4f534bf631c;
	Thu, 10 Sep 2026 03:16:49 +0000
X-Mizu-Trace-ID: 9e91a4f534bf631c
X-Migadu-Flow: FLOW_OUT
Message-ID: <89a099f4-b18e-487c-9b92-b4988a79e9e5@linux.dev>
Date: Thu, 10 Sep 2026 11:17:35 +0800
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

Codetag is a generic framework with a dedicated section in modules. We keep
this error path to account for possible future data stored in this section,
allowing us to perform security and validity checks for codetag within
codetag_load_module.

> codetag itself wouldn't work but it's a "bigger" change. IMO, the error
> is supposed to be handled at load_module() then, the unwinding as the
> rest.
> 
> 
I'm worried about this as well. Invoking codetag_unload_module () here brings
kvfree_rcu_barrier () into the error path and triggers two runs of ->free_section_mem (),
(used=true from the unload, used=false later from module_deallocate).

Perhaps we could put this patch on hold for now, until I come up with a proper solution?
The intention is to let codetag take care of its own cleanup, preserving the logic in our
existing patch.

How does this sound?

Thanks
Best Regards
Hao

