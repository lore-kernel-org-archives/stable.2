Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E780F259C9C;
	Thu, 27 Aug 2026 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787790229; cv=none; b=blzgWY0SGS2vvlJBnN1sfDmGfRIjj2gswblmjQhw5x8hByyChRBuGET2SQsww/qNzzTElW1GUNoCb9EqoPOowt5JbD25FI4/8uyvx9KoZCuCpP2Lg1y33OXmMvRj9GuwSANC4ppfk4sdJM5IUTN/27AS1tkfVAKqEHEEgwVGpsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787790229; c=relaxed/simple;
	bh=crGY0vaQX0nuy5u0oY1fHp0M+2FR5BpUCDIzzsS7kns=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=C0LhnZU5huENMmkR7teI/U0qbVAL+5Vi8+pq9yNjfR4IxiGS6rr+/2yI6AfeLbvorFNwXoLUbXyzXdaczW4WKsOM0P4q+Q83PRChKYjQkQ/sZMtYjzcNhPqubwM2pjq48OEkgc8S4eU0FpG6dViKEbJDUS/bYohLTk0+9Q9MTLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Iwbz1HMu; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=+tJZLGoB; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Iwbz1HMu";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="+tJZLGoB"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787790210; bh=NgPaRN5/tZCS06yH0JKmCV5
	SMFeutpCfqewY1FAHsBg=; b=Iwbz1HMuMeHkYWctYTUD1OvD+jdVo0qEETg7e/W9Aecf0M35aT
	gsJP5DA518R1Rm8p7NjshRJot4rjRGahBEUgpD+6ofhseG0qiEz6PNyq42vP/C6BJAcn3FfCH8M
	7f8l07kv8MRpGMxbdfK+lV8NjKw9yl3obKUE6hbKmXJNST+CBNlDkddAQ9VhYbyvDhcPYuDvZ+k
	Rkz/+ghUzee0Wyi1iTdt36ComjvJKoxpzJ9Wh3dUaGvqBk39AoZ5tRZDxVN79iT+Us4YQem9Zet
	KYpMfvNpK+J/80CdC1yv0lWRsYiZiZBHDVUSoPasJYyOLtzeGmd41ktFDB+PAgoevjg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787790210; bh=NgPaRN5/tZCS06yH0JKmCV5
	SMFeutpCfqewY1FAHsBg=; b=+tJZLGoBHI2wPKtv14/7o9KyxWibQY1aQ0gkqeau4Ht/Fpb9qv
	NegUDvRHAx0D0HXC+erpPXSRs4GYvnUr3NDA==;
Date: Thu, 27 Aug 2026 01:23:30 +0100
From: Bradley Morgan <brads@mainlining.org>
To: petr.pavlu@suse.com
CC: akpm@linux-foundation.org, atomlin@atomlin.com, da.gomez@kernel.org,
 hao.ge@linux.dev, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, mcgrof@kernel.org, samitolvanen@google.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org, surenb@google.com
Subject: Re: [PATCH] module: fix lost error code from codetag_load_module()
In-Reply-To: <cd6b372d-cc68-445d-bcae-6cfc83d9e4db@suse.com>
Message-ID: <4D26A8B8-A974-454C-8E38-7958443ADDBE@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 26 August 2026 10:24:03 BST, Petr Pavlu <petr.pavlu@suse.com> wrote:
>On 8/24/26 3:47 AM, Hao Ge wrote:
>> If codetag_load_module() fails, err is never set and load_module()
>> returns 0 after the module has been torn down.
>> 
>> Fixes: 044d2aee6c57 ("alloc_tag: handle module codetag load errors as
>module load failures")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  kernel/module/main.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index 46dd8d25a605..afb810f0154c 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -3568,7 +3568,8 @@ static int load_module(struct load_info *info,
>const char __user *uargs,
>>  			goto sysfs_cleanup;
>>  	}
>>  
>> -	if (codetag_load_module(mod))
>> +	err = codetag_load_module(mod);
>> +	if (err)
>>  		goto sysfs_cleanup;
>>  
>>  	/* Get rid of temporary copy. */
>
>This looks ok to me but there appears another bug related to this code
>that would be good to fix at the same time. If the module is
>a livepatch, the preceding call to copy_module_elf() allocates
>mod->klp_info. However, if codetag_load_module() fails, the code doesn't
>free it.
>
>I think we want something like this (not tested):
>
>diff --git a/kernel/module/main.c b/kernel/module/main.c
>index d0e1e0bd2ad0..c1b34dc1e89a 100644
>--- a/kernel/module/main.c
>+++ b/kernel/module/main.c
>@@ -3581,8 +3581,9 @@ static int load_module(struct load_info *info, const char __user *uargs,
> 			goto sysfs_cleanup;
> 	}
> 
>-	if (codetag_load_module(mod))
>-		goto sysfs_cleanup;
>+	err = codetag_load_module(mod);
>+	if (err)
>+		goto livepatch_cleanup;
> 
> 	/* Get rid of temporary copy. */
> 	free_copy(info, flags);
>@@ -3592,6 +3593,9 @@ static int load_module(struct load_info *info, const char __user *uargs,
> 
> 	return do_init_module(mod);
> 
>+ livepatch_cleanup:
>+	if (is_livepatch_module(mod))
>+		free_module_elf(mod);
>  sysfs_cleanup:
> 	mod_sysfs_teardown(mod);
>  coming_cleanup:
>
>

If patch is submitted!

Reviewed-by: Bradley Morgan <brads@mainlining.org>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
