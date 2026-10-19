Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E6730E83A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792391873; cv=none; b=QqQQzV5Nex4fkWj7ti0iMLIjPJgqBXJthtfPUR6x1Aeq4IwRpHLXuPU8q+IxN915+sCe0wbpd9LAaOtlAelidsawn3uHCX1uObjzbCxGkt+XBYmAyMdC0DlS8xCKKkmJUX1jNiHzEn7dqfMuO+prEnef9xLm3yMhbQpehD+VkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792391873; c=relaxed/simple;
	bh=caWB8CfOrtFmFyXj4TTWB1Rz/T8Sw15yFpB9WJLKWdY=;
	h=Message-Id:Date:Content-Type:Cc:From:Subject:Mime-Version:To:
	 In-Reply-To:References; b=rGronyT/G22xz1wC8oT6wC8QX+p0muiBjTz3t8hYMeOkWNoXFoFSkCw+66O5KxnRhHQmFqszo7/ASXQr2OacXh3ES2JHyOct3JfCn7pUw7lsIDrX1us8zb4SuBipa9e7ln6RKX/g1n5+ARZ73HG8PMWHbwHTxUblP/ZgtEbaEtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PE2TgwBo; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PE2TgwBo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792391861; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=TjWCCJlRJ8H9EFdUHA2mcG+z0PHZmAjw/ePCZbxewok=;
 b=PE2TgwBoWhdxpzNORLX9uTgPXI00GwjLXAJ8uWagaZRqImGDuTK5cY5R22JTfFYeKG3USQ
 6sLn1IgIE1gIYkbT/wIf2wUsDRAxRMhTSePt8JdEmlE4DzRykJ4clNLc/A16zFP3BUkd+L
 c6x7FB+l9mk58yDP5TFe5i2kLEAYiSSP45umekVhd4kJ5OnMrboDYB6fvwD//UpwjPqFlD
 9wzBqW80dUL5m2sw5FdBxfHinXV40HvIMPf+mMMEo+F3nYhIhQs4nN2J7J2qA2HnqT3tAP
 6VGFDOTWN0Y4iPdoUAGjL066JPjtK6kQPlFaN6u2sxV5uqJDkQJMd0xszdmkfw==
Message-Id: <13205cda-0ba8-4aca-b512-ce02526bcf07@bytedance.com>
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Oct 2026 14:37:25 +0800
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: <jack@suse.cz>, <jlayton@kernel.org>, <cel@kernel.org>, 
	<neil@brown.name>, <linux-fsdevel@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Subject: Re: [PATCH] vfs: keep the mount pinned while waiting for a parent delegation break
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: "Christian Brauner" <brauner@kernel.org>, 
	"Al Viro" <viro@zeniv.linux.org.uk>
In-Reply-To: <20261018-mehrpolig-goldschatz-medikament-3de24ee2cf35@brauner>
X-Lms-Return-Path: <lba+26ad5bab3+9a2cfc+vger.kernel.org+zhaogongyi@bytedance.com>
References: <20261016093421.90725-1-zhaogongyi@bytedance.com> <20261016182927.GG989762@ZenIV> <20261016183845.GH989762@ZenIV> <20261018-mehrpolig-goldschatz-medikament-3de24ee2cf35@brauner>

On 10/19/26 12:30 AM, Christian Brauner wrote:
> On Fri, Oct 16, 2026 at 07:38:45PM +0100, Al Viro wrote:
>>> So why not have it acquire an active superblock reference at the
>>> same time?  We don't need struct mount reference there - all it
>>> takes in increment of inode->i_sb->s_active on try_break_deleg()
>>> side and deactivate_super() on ->i_sb fetched *before* iput()
>>> of ->di_inode on the break_deleg_wait() side...
>>>
>>> No need to mess with every user of that thing...
> 
> Yeah, I like that a lot better than touching every caller. All the
> break_deleg_wait() callers wait in plain process context with the locks
> already dropped so deactivate_super() is fine there and the next caller
> can't get it wrong.
> 
> Please respin it that way. Mind the missing & on s_active in the sketch.
> 


Hi Al and Christian,

Thanks for the suggestion. I've respun the fix in the delegation
helpers. try_break_deleg() now takes an active superblock reference
when it retains the inode, and break_deleg_wait() drops it after
iput(). The atomic_inc() call uses &inode->i_sb->s_active, as
Christian noted.

I built the updated code with KASAN enabled and reran all five
reproducers on arm64 KVM. They completed without crashes or kernel
warnings, and stack samples confirmed the delegation wait paths
were exercised.

I'll send v2 separately.

Thanks,
Gongyi
