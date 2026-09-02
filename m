Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F259485CC1;
	Wed,  2 Sep 2026 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352036; cv=none; b=NiKxHpXQfGnT9tN2c+7dXhCvcF0AvfL5re4ncHwdkeeQxc4BiymGR0rrag7f7YCZVs4rJbYuYCmSH+v6S7FTwW8OKfYNS9nQdx2V9L+BnwHzY7v/B/TT2vnZ1R3dB+10bYKTs7YajlYqudA9Ux2ha39IYsDz1p5yKBV2eG3oULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352036; c=relaxed/simple;
	bh=pGycmUvpHsjt4kA8EL+jNjj3mEp7ZczN4uVtbVIsGOY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ioGLywZoCAcjsO1v2qWiIPjcs2wxDFhRe0+YXibUWg8q7QvumPhHFPFx6ubB5MwZg+H5BjttmNTpOu9TffRiiMM1Wgu3LJQbI7iNAIVTWFRNY08J5r6AimuotecxSDjbyTeSb1nhbK6toYdtrQp9k5EzfSb4m6xRddRD9ehGuKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ddB31ghl; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=RGGPKqIq; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ddB31ghl";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="RGGPKqIq"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788352029; bh=Mcq8yBengrd7ufXFm8cXmoU
	2EH8oDDkyj8lMVI6MhC8=; b=ddB31ghlEme06JyWnL6Zt7klao6d4gjSrcl1/vrpaBYGDQ1nN6
	G+u89nQ3uSnLH5ETfdPXku33vomSPIelYzXKhD+lX36j0HiVEqNIPXOhxFcwf5npnATLzzflTdJ
	akiKV258BBXD2DXcir33ShwWDXpBeNMafOCcFdpH83K+7h15LFhA+jNQgDKBaAcB/wR85+RAxDn
	hO7zVAWshaXOTyTw+ykNB5bv6Wj6X3XG3KjCzmK9cFnTlxmRg6VIokQvJgUaj8pAesew5+uEqBb
	AaKk7iMNBvfi2myMgPwTT3QXBK5v5T9MGEtLklRkaxE/ZLCQRgcpJ2JRrjKJ2oVDSUA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788352029; bh=Mcq8yBengrd7ufXFm8cXmoU
	2EH8oDDkyj8lMVI6MhC8=; b=RGGPKqIqMyqSayJs5LAf5gh4aS+qQ/ez4Ed5oldlBK0XevUiOZ
	jPjtZImT4JFhoU9T0ayntZjnJTiUURkYAqBQ==;
Date: Wed, 02 Sep 2026 13:27:10 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Mimi Zohar <zohar@linux.ibm.com>
CC: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com, paul@paul-moore.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_ima=3A_Check_for_ERR=5FPTR_fro?=
 =?US-ASCII?Q?m_dentry=5Fpath=28=29_in_validate=5Fhash=5Falgo=28=29?=
In-Reply-To: <2a4b80e4e1912183ba4a5d1046d718b4f455720f.camel@linux.ibm.com>
References: <20260827174339.1729-1-brads@mainlining.org> <2a4b80e4e1912183ba4a5d1046d718b4f455720f.camel@linux.ibm.com>
Message-ID: <4ECD5D0E-DB70-44E7-AB68-B048EE3A902B@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 2 September 2026 13:21:36 BST, Mimi Zohar <zohar@linux.ibm.com> wrote:
>On Thu, 2026-08-27 at 17:43 +0000, Bradley Morgan wrote:
>> dentry_path() returns ERR_PTR(-ENAMETOOLONG) when the path exceeds the
>> buffer. validate_hash_algo() passes the result straight to
>> integrity_audit_msg() without checking. ERR_PTR is not NULL, so
>> integrity_audit_message() sees a valid pointer and calls strlen() on
>> it, which faults:
>> 
>>     BUG: unable to handle page fault for address: ffffffffffffffdc
>>     RIP: 0010:strlen+0x30/0xa0
>>     Call Trace:
>>      audit_log_untrustedstring+0x19/0x30
>>      integrity_audit_message+0x366/0x4f0
>>      ima_inode_setxattr+0x512/0x5f0
>> 
>> Check for IS_ERR() and use NULL instead, which makes the audit message
>> skip the name= field instead of crashing.
>> 
>> Fixes: 4f2946aa0c45 ("IMA: introduce a new policy option
>func=SETXATTR_CHECK")
>> Cc: stable@vger.kernel.org
>> Reported-by: syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com
>> Link:
>https://lore.kernel.org/all/6a8f89e5.1d9ded08.62e62.00bf.GAE@google.com/
>> Signed-off-by: Bradley Morgan <brads@mainlining.org>
>
>Thanks, Bradley.  The patch is now queued in next-integrity.

Cheers, +CC Paul, the syzbot issue should now be fixed

>
>Mimi

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
