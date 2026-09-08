Received: from mta1.migadu.com (out-78.mta1.migadu.com [95.215.58.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A61A6811
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860988; cv=none; b=Yud3a4q/U89kjnqTR3YYNI/SZdi4ev/+Vq/Qd4myXgOtCrvX/UdUtcjrZHlVFGnn+NLr9SNught/p31KVtk4mK98sQT5RWLU2BlhBBMLyQfP1wwIEvlJTTA4LPseHF+kKW02JE7auPQdcSc3Gi5tPZdefue3ldEhcpqZ0DJbsGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860988; c=relaxed/simple;
	bh=XjCBQfB5c95x0PN2WIgKnXxwCw4fmBfLkIw/36nsHMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p08fJ90EsK/YN+3ZaGes520Wm+DLFTkyVdf/97bIDvgIoOSR/wqyrCc8P3oGSyCG9JBcolq4enQ85KXhas5+w24nNkkLXNnSwVGjzBNaGfHzD+W9MpR2Ci9uc/S7TtV9Dz3JY+3dOeybbyYIx2kYQLQnx4XWCF5YyfIwTPkxsnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WsVhbKYY; arc=none smtp.client-ip=95.215.58.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WsVhbKYY"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XjCBQfB5c95x0PN2WIgKnXxwCw4fmBfLkIw/36nsHMU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788860983; v=1; x=1789465783;
 b=WsVhbKYYWIuIfm5Vobdzcq1liMaudpbzGlXZqR6ZHsdmJ1tGU6uZBAEOyuPJs7DxljcXez4J
 oleKHz2WzTj4bmJETLZLVZsyM2pm+vi/EvoJwiktEK29yYOPY7c+FtGVcXo86QxRHZZe+SvuTNJ
 yR8ASaOxy10AH9CvkAn5B91Y=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 18a49419a59823a6;
	Tue, 08 Sep 2026 09:49:40 +0000
X-Mizu-Trace-ID: 18a49419a59823a6
X-Migadu-Flow: FLOW_OUT
Message-ID: <9acf2cd9-b808-42f0-bc86-7ffcaac965a0@linux.dev>
Date: Tue, 8 Sep 2026 17:50:33 +0800
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
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <20260907213815.0-da.gomez@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Daniel


On 2026/9/8 03:42, Daniel Gomez wrote:
> 
> 
> On 2026-08-27T11:05:03+08:00, Hao Ge <hao.ge@linux.dev> wrote:
>> If codetag_load_module() fails, err is not set to reflect the failure
>> and load_module() returns 0 after the module has been torn down.
>>
>> Also, if the module is a livepatch, mod->klp_info allocated by
>> copy_module_elf() leaks on this error path. Free it via a new
>> livepatch_cleanup label.
>>
>> Fixes: 044d2aee6c57 ("alloc_tag: handle module codetag load errors as module load failures")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
>> Reviewed-by: Bradley Morgan <brads@mainlining.org>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> 
> We need the unwind from codetag_unload_module() as reported by sashiko.
> 

Thanks for you review.

I skipped it because alloc_tag is the only codetag type and it
already cleans up after itself.

With a second codetag type the problem Sashiko reported could indeed
be triggered.

My thinking at the time was to do it in codetag itself, as a separate patch,
since it feels odd to unload something whose load just failed.

Happy to hear your thoughts on this.

Thanks
Best Regards
Hao
     
> With that,
> 
> Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
> 
> 
