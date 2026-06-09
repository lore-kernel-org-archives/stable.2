Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887E14A4F0
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972750; cv=none; b=HpMXbmOyTKjC6UKx97NSrS468U9sKuqoDhkmg9/0aGSi2sb2U81KK0jq6xDQ3z1im8Bx18WeiUCcxmIVsTfe2CXqhmTAMIP1Weit5YxwIqHOWw3X3HjhytrC2Gn+aUNtPu3EK0amekm8xRcjhDUIlJyc5a8tgq9eF8gVCwQec6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972750; c=relaxed/simple;
	bh=PGM1C3fpFEs5sFSJ8vb6L7E0ABmDQSN8pwswTLIOy7E=;
	h=From:Message-Id:Mime-Version:Content-Type:To:Cc:Subject:Date:
	 References:In-Reply-To; b=jweMjID2zfapg8XvTWZSVl3UWG0QRQsl/RR66+DT31/2kPErQqLcLgPwWdz6lmS58r68rAh8XT54uEKIvJ0OxGBBkpxpQQAtrvYDyaTPd5Ve30M+TvawWuSza6SoHFu7OP80XfMw3SVhQJrK6Z4xv6sEYmlIlwKpZqoPMieIpMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=brOg4vhY; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="brOg4vhY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780972743; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=YByv+LbPJJ92qkS0OnkgT6wcRgCzHujI4ZV9YijjdSI=;
 b=brOg4vhY5wi9fPZWGOFAilg5r+fJ/d6Skz16f4CSzfm358ImXh6AHZ3V+hPJuheyJI/frW
 Op090BZhx8r6ro+6DK1JbNgCyUGlhzipPTSclHUjTl78vgiuzG+bW2ALJV8/yA808v/wGG
 hrR3WBqBsbgwDIcqCDd/PjAosTW7ZvwAgH7SVXonskIA7wiLpg0K1o/Y3+Ffalx+DAff4U
 EiSIh5GeISLesaEk/uOTCMdwKW7VFr2wO88xLOlSG6oAjlTtnYw7N/PMtlOi8pa67Sq9SY
 UDfVMNXkdrs1L/UEJfipjS3fs9nb5YJXM+C5kdYhnI3e34VAY/a1bblhYEyElg==
From: "Rui Qi" <qirui.001@bytedance.com>
Message-Id: <e48c88e4-b865-47e9-8b23-7c346a11769f@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: <corey@minyard.net>
Content-Transfer-Encoding: 7bit
Cc: "Corey Minyard" <minyard@acm.org>, 
	<openipmi-developer@lists.sourceforge.net>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] ipmi: Fix rcu_read_unlock to srcu_read_unlock in handle_read_event_rsp
Date: Tue, 9 Jun 2026 10:38:46 +0800
References: <20260525063235.990101-1-qirui.001@bytedance.com> <20260608112000.1-qirui.001@bytedance.com> <aibYi72tthY8VX8V@mail.minyard.net>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
User-Agent: Mozilla Thunderbird
In-Reply-To: <aibYi72tthY8VX8V@mail.minyard.net>
X-Lms-Return-Path: <lba+26a277cc5+26318d+vger.kernel.org+qirui.001@bytedance.com>

On 6/8/26 10:58 PM, Corey Minyard wrote:
> On Mon, Jun 08, 2026 at 11:27:54AM +0800, Rui Qi wrote:
>> Hi Corey,
>>
>> I'm following up on this patch which was originally submitted on
>> March 25 and resubmitted as v2 on May 25. I haven't received any
>> feedback so far, so I wanted to bring it back to your attention.
>>
>> To recap, this is a one-line fix for handle_read_event_rsp() where
>> rcu_read_unlock() is incorrectly called instead of srcu_read_unlock()
>> on the error path, leaving the SRCU read-side lock held.
>>
>> This patch is specifically targeted at stable branches (v6.12 and
>> earlier) that still carry the original SRCU-based locking. In
>> mainline, commit 3be997d5a64a ("ipmi:msghandler: Remove srcu from
>> the ipmi user structure") has already restructured this function to
>> use a mutex, effectively eliminating the bug. However, that commit
>> is part of a larger SRCU removal series that is not suitable for
>> stable backport.
>>
>> Since the affected code no longer exists in mainline or your
>> for-next tree, this patch cannot follow the usual path of being
>> applied there first and then cherry-picked by stable. Could you
>> please review and provide an Acked-by so the stable team can pick
>> it up directly?
> 
> I can give an:
> 
> Acked-by: Corey Minyard <corey@minyard.net>
> 
> on this, as it is obviously correct.  However, it might be better to
> backport the changes removing SRCU.  Using SRCU here was a mistake to
> begin with.  But that might be too big a change.
> 
> -corey
> 

Hi Corey,

Thanks for the review and the Acked-by.

Regarding backporting the SRCU removal series: I agree that removing
SRCU entirely would be the cleaner long-term solution. However, as
you noted, that series involves significant refactoring across
multiple functions and would be a relatively large change for a
stable branch. The one-line fix is minimal and addresses the
immediate SRCU imbalance without risking regressions, which seems
more appropriate for a stable backport.

With your Acked-by, I'll ask the stable team to pick this up.

Thanks again,
Rui

>>
>> No changes since v2. The patch is reproduced below for convenience.
>>
>> From: Rui Qi <qirui.001@bytedance.com>
>> Subject: [PATCH v2] ipmi: Fix rcu_read_unlock to srcu_read_unlock in
>>  handle_read_event_rsp
>>
>> Fix a bug where rcu_read_unlock() was used instead of srcu_read_unlock()
>> in handle_read_event_rsp() when ipmi_alloc_recv_msg() fails.
>>
>> This mismatch leads to an SRCU read-side critical section imbalance: the
>> entry uses srcu_read_lock(&intf->users_srcu) but the error path
>> incorrectly calls rcu_read_unlock(), which is a no-op for SRCU and
>> leaves the SRCU lock held.
>>
>> The offending code was restructured in mainline by commit 3be997d5a64a
>> ("ipmi:msghandler: Remove srcu from the ipmi user structure"), which
>> replaced the SRCU locking with a mutex in this function, effectively
>> eliminating the mismatch. However, that commit is part of a larger
>> SRCU removal series that is not suitable for stable backport. This
>> minimal fix addresses the SRCU imbalance for 6.12 and earlier stable
>> branches that still carry the original locking scheme.
>>
>> Fixes: e86ee2d44b44 ("ipmi: Rework locking and shutdown for hot remove")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
>>
>>  drivers/char/ipmi/ipmi_msghandler.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
>> index 188722ec0337..41ae4dac4eeb 100644
>> --- a/drivers/char/ipmi/ipmi_msghandler.c
>> +++ b/drivers/char/ipmi/ipmi_msghandler.c
>> @@ -4395,7 +4395,7 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
>>
>>  		recv_msg = ipmi_alloc_recv_msg(user);
>>  		if (IS_ERR(recv_msg)) {
>> -			rcu_read_unlock();
>> +			srcu_read_unlock(&intf->users_srcu, index);
>>  			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs,
>>  						 link) {
>>  				list_del(&recv_msg->link);
