Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595E642F6E5;
	Tue,  7 Jul 2026 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435045; cv=none; b=alJQwwX7/qoHhHHVHyx1LqhMKX+EAkPZ84mc4maLEABEaDaI2WM0jItk5ALjGt8TcsGV39JXAxSifZ/1i/K2B5NE7TTcvwQektLuHFQgEjPY3GKBP7Y6Nm5lOupzER2hm89sZo8R7zg1+UtjUyVD5YNWq3GngK5FOTTiovrcymE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435045; c=relaxed/simple;
	bh=o2TARrpWo8vqtW0kZHBxOFO7tI8soNubxkLSKCCZBtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAXTa48aVPXBQrUZvK7zCqQI63hmwaI1VnGCLKfOMNXq2ZWmQK/o4Bc5PDnYpwSw4P8IJzKPdUPDAv5vzkDopjTnTWX2dfWVfHZ+g1xoBdCTkCXNQFiCunrNImv+/J0iLpRUMqFQR/RfKAvK85iIVLwq3yVVuO1kn/Wr8/nQN1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 0C2C7168D60;
	Tue,  7 Jul 2026 14:37:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 05D9B33;
	Tue,  7 Jul 2026 14:37:20 +0000 (UTC)
Date: Tue, 7 Jul 2026 10:37:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
 syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com, Yash Suthar
 <yashsuthar983@gmail.com>
Subject: Re: [for-linus][PATCH 05/13] ring_buffer: Check page order under
 reader_lock
Message-ID: <20260707103724.1b64b679@gandalf.local.home>
In-Reply-To: <20260707134623.914907495@kernel.org>
References: <20260707134604.275787924@kernel.org>
	<20260707134623.914907495@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 05D9B33
X-Stat-Signature: 44xeehycxgyqtuke5qzwj51h6ui8piqc
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+LcWp+mRPr0dr5XDyLfS04dNpWUgYjyEI=
X-HE-Tag: 1783435040-88840
X-HE-Meta: U2FsdGVkX1/qBOPkA7JVOI8pJ59cf3HDqViBTYEv1kyfjD+PlLHa6tYnX7ffw8iYbQ2KaUNqIIZAYzHwrrnQO+ROYxskxc0Sb9BDn0BZh7zMFi3p7HNUN6LxE74gb4PIGTReLwqYJdUrSIZf3YoVBYb60PZYHQ4zvrakkuZzg/p9LIhvv5vVH01PoLKTpBUEajX3XK+xxvpDA+zIW5oU40hPWmAKneoM7M0z2108JbOQJI7rUXBn1ZvW9FSAlN4Grrd0EgtQOm5+PlnmotkYbSmv62f5bZvrl75ArqZmInnlTc0kf85ArNrwtXv3iBItl5WCm8xxg8meKwAGf637GYynNHCa38JliVGaDeR/iwAIYUqYUEqOSCHJEIWy1TGtffrYbpIfSOg0I4pRFFTFIDfmYppRR7zz/AFYlc6/AtyZOCQ4CWJ+WqCFgwjy2XADv3QFzNrnnF+Rc1cC/UoNzD784K9IqfwhegJ6PYwN3Nm1js5tij7T5O5pZEa7RhmyEYsZEUbYIPPpkcZGmtHnDt04UxdYKSwnLLFO33va2u4B3pL50WXsv3gQh3dbOqioFM6yfy0nsFe7kk1gbfgN8BeLPbvIGzsyidfV8PY5Isx7WgyI5NICdkYnpM2VXB6g

On Tue, 07 Jul 2026 09:46:09 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> From: Yash Suthar <yashsuthar983@gmail.com>
> 
> When the ring_buffer_subbuf_order_set() is called the same time as the
> ring_buffer_read_page(), the wrong buffer->subbuf_size can be used as
> there is nothing keeping that in sync. This can cause an incorrect
> allocation and initialization that can cause a crash.
> 
> Move the saving of the subbuf_size into a variable within the
> cpu_buffer->reader_lock, and use that throughout the function.
> The size only needs to be consistent throughout the allocation and
> initialization. If the buffer->subbuf_size changes when used, the reader
> data page will be found to be invalid and the read function will return an
> error (this is as expected).
> 
> syzbot did not provide a reproducer for this crash, the race
> condition is logically sound and found via code inspection of the
> trace.
> 
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20260611151736.255767-1-yashsuthar983@gmail.com
> Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
> Reported-by: syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2dd9d02f60775ce5c1fb
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
> [ Rebased to 7.2-rc2 ]
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

I'm actually dropping this. It's not enough, and there is work to fix it
properly:

  https://lore.kernel.org/all/20260628004653.28065-1-alhouseenyousef@gmail.com/

-- Steve
