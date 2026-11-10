Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794297141;
	b=3ygovBQ8tKszFwu8Ci6/Ir0TecOwbcFwsfXho+JeJllQwQ7tKYAjlY19zPXNxWw8nI/q
	 yKx4YbZ8IZx365lxLKGE9koTkqK6MRPhCtGsArFy3EyFtJCc1GTPWEpIH68NuuO0NwPA4
	 KX9BjeVNcNGan/J0rcwnEenspYpKru+tsgc/lSluXa4laT7XEn6sxCZFAcjx5r3x2cQ8z
	 bV6bQPR/gTaqAQc4TqR5vwexpEwf8ZSMd613ZV85GjZ/GNtewSiB+C1G4Dm82pg+RSiSM
	 HxJPp7rTfnsseJtQEwcYqPPXxHyGZb2HtSVdAT+7aqYX2ULbNfGFyzmvMGzjO1zcMtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794297141;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=HOR1+kqQhwJITF9mrUMDzf7ZzPSccks+bMhcYnxMQ/k=;
	b=PeGn8Ho6Q/S8GWzZSWGQfXdPDZjAp02QMTXJ6KXD9UzQjLcldDfcgTtAP7kI4z07PXAk
	 dQT83PDF5EYvA1c+VKdHs+qCLJzf5XNybKDA91mpYaU6qHqep6wTWYxRr5CX6++ZLmxdG
	 ewiJCXa2tLnZT8Qu2J32H5VZKKtrpptbDoicDaDbvXqDnUiB1trA93OkTEEliSn2PeLVi
	 fnfJ0EQYSXnm3W63FTEbnqjFxa4/U1/QptpQuMkjzk2Xsn0bFznbO0BFmBPLWPk4vmvAg
	 gUGxucemTURr7kh1umB/r8rmNwCGmqlxC7Sd0vEjoEcZHiTUKcSApFX/jIQ0EcOAOTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Wo0WadD1;
	arc=none smtp.remote-ip=216.40.44.14
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B41606A334;
	Tue, 10 Nov 2026 07:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1B41606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Wo0WadD1
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 6959A140503;
	Tue, 10 Nov 2026 07:52:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 1BA702002B;
	Tue, 10 Nov 2026 07:52:07 +0000 (UTC)
Date: Tue, 10 Nov 2026 02:52:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Breno Leitao <leitao@debian.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <srostedt@redhat.com>, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Handle a reader taking the new head in
 rb_handle_head_page()
Message-ID: <20261110025202.78c8c03a@fedora>
In-Reply-To: <avGQnBjyUMwunknT@google.com>
References: <20261105-ring-buffer-head-moved-v2-1-05da40cebccc@debian.org>
	<20261105155729.0f9c7e4d@gandalf.local.home>
	<avGQnBjyUMwunknT@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 1BA702002B
X-Stat-Signature: erqs333doy343w6acayxmgdjtkgouj9d
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+YQOdajhCDf1ZjZQfnHpfSD5rLF0zgf5s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=HOR1+kqQhwJITF9mrUMDzf7ZzPSccks+bMhcYnxMQ/k=; b=Wo0WadD1kJznyFIlA6jRp+DI7L2vl/XdShuuFurlVUnOZW8enSWCf4tTmX8XqPYhIYO+74AuaTtTUfTsxtk6eyVW9RZrG29QbG9n/6kOUVsBN48xeHTGhpLh3F8SHLikyRWKwLMOjIyzUX2hJlUozCfOqyvc3ya0n8MGTvAebyQ=
X-HE-Tag: 1794297127-995168
X-HE-Meta: U2FsdGVkX1+hTXjhiPB/SOj4L/XPStP7ECk2j9J4x/CsE0t8QgKNpm9izosUDHdljRIJTbLF4rRiA/aFukUGls7Y9P9meRaZDRHrmTc/xDDJdHrsuzRqcTU+YviHj0930OyYBGYD6NOguoAf1ebrXF1wnnqJ5356UB0WiNN+M6paW1SRvUgubYwabm7Po6e/6/zL0gkjPvzJ3QRW9zQPr8VOzhr/U5mcSJpcXaynm6/RKPuj8L5Db6hBNIX/85+RESUCtwW3UShT7Zrw9bTGeC3ViAdQxqVQDCfrmKq4a5ZvF1R6X7nAL6b5EQyTRdAvknI1oj35S5XMUGHaQFBvUYl52H0jLw/1

On Mon, 9 Nov 2026 09:21:32 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> > The issue I think you hit was that we have two HEAD pages, when interrupts
> > come in. That is, we can get a state of:
> >   
> >   --> subbuf --UPDATE--> subbuf --> subbuf --HEAD--> subbuf -->  
> 
> How we can end-up in this situation? The cmpxch will only swap HEAD for UPDATE. 

The cpu_buffer->head_page is only updated by the reader, when it did its last read.

Let's look at it one at a time:

                              cpu_buffer->head_page
                     tail               |
                      v                 v
  +--> subbuf ----> subbuf --HEAD--> subbuf ----> subbuf ----> subbuf --+
  |                                                                     |
  +---------------------------------------------------------------------+

Then the writer moves the HEAD page around the buffer while there are
no reads happening


                              cpu_buffer->head_page
                                tail |
                                  v  v
  +--> subbuf ----> subbuf ----> subbuf --HEAD--> subbuf ----> subbuf --+
  |                                                                     |
  +---------------------------------------------------------------------+

                              cpu_buffer->head_page
                                    |          tail
                                    v            v
  +--> subbuf ----> subbuf ----> subbuf ----> subbuf --HEAD--> subbuf --+
  |                                                                     |
  +---------------------------------------------------------------------+

                              cpu_buffer->head_page
                                        |                      tail
                                        v                        v
  +-HEAD-> subbuf ----> subbuf ----> subbuf ----> subbuf ----> subbuf --+
  |                                                                     |
  +---------------------------------------------------------------------+

                              cpu_buffer->head_page
        tail                             |
          v                              v
  +--> subbuf --HEAD--> subbuf ----> subbuf ----> subbuf ----> subbuf --+
  |                                                                     |
  +---------------------------------------------------------------------+

Now, I'll break up the update part:

                              cpu_buffer->head_page
        tail                             |
          v                              v
  +--> subbuf --UPDATE--> subbuf ----> subbuf ----> subbuf ----> subbuf --+
  |                                                                       |
  +-----------------------------------------------------------------------+

                                 cpu_buffer->head_page
        tail                                |
          v                                 v
  +--> subbuf --UPDATE--> subbuf --HEAD--> subbuf ----> subbuf ----> subbuf --+
  |                                                                           |
  +---------------------------------------------------------------------------+

An interrupt comes in and moves the head even more.

                                 cpu_buffer->head_page
        tail                              |
          v                               v
  +--> subbuf --UPDATE--> subbuf ----> subbuf --HEAD--> subbuf ----> subbuf --+
  |                                                                           |
  +---------------------------------------------------------------------------+

Now  the reader decides to read again and starts between the UPDATE and the HEAD


                                                 cpu_buffer->head_page
        tail                                              |
          v                                               v
  +--> subbuf --UPDATE--> subbuf ----> subbuf --HEAD--> subbuf ----> subbuf --+
  |                                                                           |
  +---------------------------------------------------------------------------+

It finds a page with the HEAD pointer set but not the UPDATE pointer and does a swap!


                                                        reader_page -----+
                                                                         |
                                                 cpu_buffer->head_page   |
        tail                                                         |   |
          v                                                          v   v
  +--> subbuf --UPDATE--> subbuf ----> subbuf ----> subbuf --HEAD--> subbuf --+
  |                                                                           |
  +---------------------------------------------------------------------------+

Now the commit finishes and moves forward and will even hit a blank
page but the last write is now on the reader page. This breaks the
entire integrity of the ring buffer.

Does this make sense?

-- Steve
