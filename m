Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585068;
	b=dbZDLCMVvo0mAckb9+VataRK2j++mRlGlUyDJvRSznJsK90IQ9z6J4QnwpImaoVQ/IwL
	 lM8phiNxKcPZcLqZXEbLCJCvbjO0VKXM2y6y9kUk2wfS9K7xqDTTpf3BXV65+4dyOS70S
	 ZPo2bv3CwHx3153g7wFvtUi7on01VyDTGKwRmsFBry5lHpscW35a/nnlAbRBWLYhHAPPx
	 alTORiMGJqsj1xGCF+7IMDHVR5eu3sl8RA6j6iRDZBOqm3wt2e7xz1X1amZwDhBXsAKZe
	 cMDArxivl3JTdCz/hhUg7TXNO7HlTEyaCIwNck+BdYerx1vNXDr93tosbk3TA6L56Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585068;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aQ8Z58R/hTyFw2ouZE/gUSOiBop//SC/eqGEGwGnljo=;
	b=xSPLSAMrgdWwLrIReecJ/JZizJytXm1mz7PHP3Ez3Uo47Vl+8SCKuR8jvYhiHSioyZII
	 naHPmlwXlcECSMx4Hf9ja7an1pAXPvGQwp6U+fmDpYRfabHjbmRS/L0nMwaB/HXpjJuhx
	 fcaobXDdhT3IHClEb1JzLOKOaVTeci2Bw8BSE0iQc3neJed5Ufh9Xp5RVvzaV2ZEpFSMW
	 6w3eyYH+uNlSfJNKs7LxIe0aecjOsIZZEmzoHNv8q5anJhadgGVVIsLBxHZUZwKCP2wga
	 js1wqu5HqlqOFPHFtsEIHuDWwEvqGvBLhpH7iV/epSrczYGeSZIfsXKUD96p4mJyCHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="MYa4/DHX";
	arc=none smtp.remote-ip=91.218.175.179
Received: from mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A3A606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98A3A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MYa4/DHX
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=A/AmnZWEYWikBqc5eV8eYfvyQwT7TRZgxe3Vx14+ezA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794585065; v=1; x=1795189865;
 b=MYa4/DHX+qGhqVZTthTQbCTyT+/r5F05PjaJQrQBkv7WZYhf9xZSXpGNF/hMq5AvZDN9coi1
 DzaMFuJ/Kz1xmjVfWsSaPN7MJ3AeucmiIdEAtPQQ6YohlZxgzmY1Mhn2seeJzmtreYqS7SBzgYE
 Wthp4yHghqfKb6gDSwyczsl0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id af9b908daa4435a9;
	Fri, 13 Nov 2026 15:51:05 +0000
X-Mizu-Trace-ID: af9b908daa4435a9
X-Migadu-Flow: FLOW_OUT
Date: Fri, 13 Nov 2026 15:51:01 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: leitao@debian.org
CC: akpm@linux-foundation.org, angelogioacchino.delregno@collabora.com,
 ebiederm@xmission.com, kernel-team@meta.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 npiggin@gmail.com, oleg@redhat.com, peterz@infradead.org,
 stable@vger.kernel.org,
 syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com
Subject: Re: [PATCH] reboot: halt when power off fails
In-Reply-To: <avWGu4l_nXP_eFyh@gmail.com>
Message-ID: <2D88DE92-A563-41B0-AB0B-5F9EA5CE3EF4@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 12 November 2026 09:33:22 GMT, Breno Leitao <leitao@debian.org> wrote:
>On Wed, Nov 11, 2026 at 09:02:38PM +0100, Oleg Nesterov wrote:
>> On 11/10, Breno Leitao wrote:
>> >
>> > --- a/kernel/reboot.c
>> > +++ b/kernel/reboot.c
>> > @@ -791,6 +791,9 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2,
>unsigned int, cmd,
>> >
>> >  	case LINUX_REBOOT_CMD_POWER_OFF:
>> >  		kernel_power_off();
>> > +		pr_emerg("Power off failed: System halted instead\n");
>> > +		/* kernel_power_off() already ran the shutdown, only halt. */
>> > +		machine_halt();
>> 
>> Agreed. Even if I don't think my ack has any value in this area:
>
>Thanks, Oleg.
>
>I tried to find out who merges changes to this file and it is not clear.
>akpm seems to be the closest, as most of the changes went through him,
>and somehow he was not CCed here. :-|
>
>Andrew, would you be willing to take this one?

No maintainer, Andrew merges.

I tried asking to be one, no avail, whatever.

>
>thanks,
>--breno
>
>

--- Thanks!
