Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466976;
	b=JNpYQQOzy8U2XfU/ZwhuZQf7Ect2HNCnQm1dNq4xlXmGnHrAwiVkLUsCs6KmVg9p0IcA
	 bLHPeump3SdF9xCiOfNqmApd+j/U5RsUlcGFxidDP//SkQRMyQdCF/Co9pNvJ7Olf4R/x
	 GDViWo/bMQtMua7NoWZSqVNzPTst7/wr/BN0uaQDfdOozxzTIwcB1IZsKXYmMPRe97LET
	 Wb9pfPtzq1XfpLv20PGVOdgyphvbvvaZL2AkxCF5RM9F2pPIEYbsRJBbPuxVPVOogEnne
	 TQug2QKeck8Fii7YoJwQKD3tgMtyaK6rDMW1CvtwzYfAiuYYSE7u5WI89Sz0r0e/Y/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466976;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=rf1cWBs3NuwQOZ32do9Ka6iqVwTFh5JLcgleNWm+Twc=;
	b=RGj3jj3rVYaozTmgbMx69WTFAsxeYVz2azXKDp3dZE/SB006vq2vUTzYVQuVTWu2uzL5
	 ZRoLeG9WzMz5ufO1b5JSUGOKCzhcdx43iRUGEEbL39XBUoAXHEpVqPKCj6kzF4P3NZZXH
	 Qn81Gk5crnIFJ5JJzDJ0plZxJ+RK18gIdkxKEYTqwMDMAs+ZqMlOLGdi1Vp8ZRmZjJT6c
	 aSzzrUVmxxYzhvU+0hWnQGG5lq8sOafQqTW+i9ZOr6dWGMHpw1k8B8fu9Vd3UUmISRRAA
	 goiTUsHxVJdIQh96M3Av4t0vMDImit08EO/rB1ezoJYQ7oh/zqA9ZeUzheN+4N9uchA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ID7BSUHZ;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE58C606A335;
	Mon, 23 Nov 2026 20:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE58C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ID7BSUHZ
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 03577809AA;
	Mon, 23 Nov 2026 20:49:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id CA0092002B;
	Mon, 23 Nov 2026 20:49:31 +0000 (UTC)
Date: Mon, 23 Nov 2026 15:49:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Danish Khateeb <danishkhateeb03@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Beau Belgrave
 <beaub@linux.microsoft.com>, Shuah Khan <shuah@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing/user_events: Handle ioctls from 32-bit
 tasks
Message-ID: <20261123154930.1c81e606@gandalf.local.home>
In-Reply-To: <20260928171424.199202-1-danishkhateeb03@gmail.com>
References: <20260928171424.199202-1-danishkhateeb03@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: CA0092002B
X-Stat-Signature: 4nmdmbybdr9wkkd97g7rrkap68ckt551
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18/vAFX0gv+vT4NjsiBt3LFD5olN82X8vE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=rf1cWBs3NuwQOZ32do9Ka6iqVwTFh5JLcgleNWm+Twc=; b=ID7BSUHZRFjKEc/W6mPjWEYnHL/77L/MPVSLqJ5J8U2bmRs+vd79+oGIcZ3hUKVkQFCj9m2AzCaZw1ciBiEIdHcsw9TiQkX2j6dnzg8XtMXu/LrGaJqFDNb3cZ/7PDCSprUuRrW1CM95TtfWT4z6/747duzT+5je0CV3SauQhpo=
X-HE-Tag: 1795466971-233234
X-HE-Meta: U2FsdGVkX18bBG8rW2vr5gukCrBwstVbNsH+TXxQeu3aCsJjj8JRxyxC4B2YcJ0q0vQYjQYjdrE6CF+Kbrm3L5XzK7SgX2JSvEnP3UDrTJQW91VumbQpsuqVp+5TUcvaNZYoP63Aa3BjewstabByFrgYpPPgCIYkd09jJElPNtO+NoaUl5mnz63KNbgVbncgs2O2RWYQ12gHKy1yfx0R7uJ9NQ/4h5DiBDDnPb2mAipV85BBMcCQvd6gPhRjiPjE0BMoexiqJ3DeoHsvL6Y3A6u49gqD9n6X491zQDLl8mEeuRoTc0h1rvLJc/hZcDU7uhc1qpauKmkj2X4YKzJ534xoDjLMrWXAIzsp7DcxcnoBGeDKPk4FNQ==

On Mon, 28 Sep 2026 12:14:23 -0500
Danish Khateeb <danishkhateeb03@gmail.com> wrote:

> The DIAG_IOCSREG, DIAG_IOCSDEL and DIAG_IOCSUNREG ioctl numbers are
> defined with pointer types, so their size field is 4 for 32-bit
> userspace and 8 for 64-bit userspace. user_events_data has no
> compat_ioctl handler, so on a 64-bit kernel every one of these ioctls
> from a 32-bit task fails with -ENOTTY and such a task cannot register
> any user events.
> 
> struct user_reg and struct user_unreg are packed and only use fixed-size
> fields, so they have the same layout for 32-bit and 64-bit tasks. Add a
> compat_ioctl handler that maps the 32-bit ioctl numbers to the native
> ones and passes the argument through compat_ptr().
> 
> Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into ftrace")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
> ---

Note, because this was never supported on 64 bit machines, I'm putting it
into my queue for the next merge window. It's not a regression, it is
actually a feature. That is, the new feature is: Support 32 bit tasks on 64
bit machines.

-- Steve
