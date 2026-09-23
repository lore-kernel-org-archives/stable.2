Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86760305687;
	Wed, 23 Sep 2026 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175057; cv=none; b=QZmWxOtSI8oD7m19eSHv8FYeza7eRk5wv5WijM8d9ySvkCSYnGg8m621usd69wYWpOeTPlkTBDBOvwzj6Snq0sJaH+WsAt2ZEE036z4EtO8JAUkIX71Rzaw6nNXraq9myjRO3kmKl4inpjV8dykZXZoERSNaSgxrlulzlf8bnR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175057; c=relaxed/simple;
	bh=BTFZEyaGHn0aSDPwc1oAYgsNJ5iFRLhGT0U1Rv2NCdo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GdSxWwpgonW7j5u95C7khxKmNu54smfhWAryjQpdJ2G+NOW0XlkwnAPgWTUAjxR6QuyT8agw3YIhgIiprZ7OeJXzGHjSZVeli/XgtRJeXk4iz7PW3/m/2+JNhrWjTRKIdbftvfZjSu8uN7RQN/ckp9gbhzMUvJRrk03a0C9HN7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=dOHvdPSN; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=qk24tv6g; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="dOHvdPSN";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="qk24tv6g"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790174918; bh=AeN6n7kFukf8ndloeNqVY+2
	cC3ng9FodT+JQv/3mwq0=; b=dOHvdPSNjS3aHiq8DD0T6zVPQ1k7QjFk7QKi/qUCSMdv0E3lde
	bgSqPLQ/7Ul83S2oofOP4gzb5Q5dYQa/LS+yzu7Y1/4CYGSnNudfq4Ukgqt3jmU0C37awJAyDZ/
	wt8gsOPvKANlRprpjFp/Am3BtE1w+2RT0iWVZqeba0PoPLqXSO7ie+/SzMkDC8Enek3oqhjejzZ
	0SccZGU/u80cIocvPiMjrxRbT9JHt37CCO7IXMqRD4nWsfbTvAAVz+Fxq9qkegh2dD6sCh+FdPk
	AQcHIuQ+df+LUp/Jmk0pYuukt5lVe4kqd2m6pgU5+3/PhhrPW0nOrJMBUHqtzdcQASQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790174918; bh=AeN6n7kFukf8ndloeNqVY+2
	cC3ng9FodT+JQv/3mwq0=; b=qk24tv6gYWQ9cGJXwczDAhe1f3m5JpDj+pjKfrV6elk+jLJtjd
	sG+Uh6HlBxwP/x8allHaBCgsvT7gVLVxV7Dg==;
Date: Wed, 23 Sep 2026 15:48:38 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Joel Granados <joel.granados@kernel.org>
CC: zhanxusheng1024@gmail.com, kees@kernel.org, kuniyu@google.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, zhanxusheng@xiaomi.com
Subject: Re: [PATCH 1/2] sysctl: Negate before converting in the int read path
In-Reply-To: <j55ziuijejg3kefuhi2du37d7qechruzchgigp3c55stuhtkh2@fddifpg5kxzq>
References: <20260922031229.2300283-2-zhanxusheng@xiaomi.com> <867A30A7-5460-4988-A078-09D0B4BCD44C@mainlining.org> <j55ziuijejg3kefuhi2du37d7qechruzchgigp3c55stuhtkh2@fddifpg5kxzq>
Message-ID: <84187B07-C732-44A2-9DDD-CA95FEE7E8D5@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 23 September 2026 14:07:11 BST, Joel Granados <joel.granados@kernel.org>
wrote:
>On Tue, Sep 22, 2026 at 07:37:57AM +0100, Bradley Morgan wrote:
>> On 22 September 2026 04:12:27 BST, Zhan Xusheng
><zhanxusheng1024@gmail.com>
>> wrote:
>> >proc_int_k2u_conv_kop() reports the sign through *negp and the
>magnitude
>> >through *u_ptr, but for a negative value it hands the sign-extended int
>to
>> >the converter and negates the result:
>> >
>> >	*u_ptr = k_ptr_op ? -k_ptr_op((ulong)val) : -(ulong)val;
>> >
>> >With div_hz() and HZ=1000 a stored -1000 becomes
>> >(ulong)-1000 / 1000 == 18446744073709550, and negating that wraps:
>> >
>> >	# echo -1 > /proc/sys/net/ipv4/tcp_fin_timeout
>> >	# cat /proc/sys/net/ipv4/tcp_fin_timeout
>> >	-18428297329635842066
>> >
>> >Take the magnitude first and convert that, which is what the open-coded
>> >version did before commit 2dc164a48e6f ("sysctl: Create converter
>> >functions with two new macros") folded it into a macro.  The
>> >k_ptr_op == NULL branch was already correct.
>> >
>> >proc_dointvec_jiffies() and proc_dointvec_ms_jiffies() are affected.
>> >
>> >Fixes: 2dc164a48e6f ("sysctl: Create converter functions with two new
>macros")
>> >Cc: stable@vger.kernel.org
>> >Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
>> >---
>> > kernel/sysctl.c | 2 +-
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> >diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> >index f7b75985d542..38597f26b34c 100644
>> >--- a/kernel/sysctl.c
>> >+++ b/kernel/sysctl.c
>> >@@ -483,7 +483,7 @@ int proc_int_k2u_conv_kop(ulong *u_ptr, const int
>*k_ptr, bool *negp,
>> > 
>> > 	if (val < 0) {
>> > 		*negp = true;
>> >-		*u_ptr = k_ptr_op ? -k_ptr_op((ulong)val) : -(ulong)val;
>> >+		*u_ptr = k_ptr_op ? k_ptr_op(-(ulong)val) : -(ulong)val;
>> > 	} else {
>> > 		*negp = false;
>> > 		*u_ptr = k_ptr_op ? k_ptr_op((ulong)val) : (ulong) val;
>> >
>> I didn't do much crazy review here, but I think this LGTM! :)
>
>If you didn't do much, please don't send the mail.

I said "crazy review" which means I scrolled through it, looked at the
code a bit, and thought it LGTM, I suggested doing acked bys for
situationslike this but maintainers hated that so I just say what I did? 

I usually commentate it all if I did crazy review.

>
>> 
>> Reviewed-by: Bradley Morgan <brads@mainlining.org>
>> 
>> --- Thanks!
>> "I'm not a very positive person" - Linus torvalds
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
