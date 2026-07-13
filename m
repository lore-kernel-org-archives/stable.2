Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0108B17A300
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925460; cv=none; b=WrBU3EJFgDGnnWAdgGE8pfYejE7lvS4Eaa4/naRqN6owYBs+FKYoqCcy0xsrFJyKuLlE5CfjrqByUxVhxh8nMWNDzWQshr+Omhq543JYDanPHyG5lPNvvbzcAS7iGRZvRf3VwJUMf9+bM9/qNh7HbHer45AJtF8zuPmGxSuVjRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925460; c=relaxed/simple;
	bh=5TdS/ksFwJrzoI/JCVDUgN0F/C6juzrfcjtP2lrrgYk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=PXfedX10Nqojypa7yrY5kfyVGCu9uzkZku3nSt7s+BbpFgh8el7YSz6ql52Xp87syBItQurJ2tLNr5sxKkdkj/3COdmz6CtHENHqw3FVj6R8GSgcAU9vsZou1HkWwE8sOMl8EIiU8U98sie8xguOoZdJsZS4pUA/MWQ4MhBGu5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjTd2LC6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjTd2LC6"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso2660398a91.3
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 23:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783925458; x=1784530258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eWmwa1QUvWmWfZcAMrMrN6lD6RiBuEcOW0PxEeSlbVg=;
        b=CjTd2LC6CcN2cLZMJJPL2NCHbAXfuK9V+lawlm0RnvIo11exHdXkZKxR2jq5DenWTR
         UirkLH98aBbnWMSbUm74hJFRg+x+Ouq6VTa+ZxxNu8npvAdTpz0neyAe5xg7kbzIXxId
         qXTTSKk6D/wv+wC2NeYUT9HOLiT+CCYKDTQsdDDLRLI8gGPqSAexiicE5rYR0Sflmyys
         gb0Jh55TVRF8nN7WER6MUSy5svnYLiuoftz/3ulHcJD5ijL/OsYLHeA7jefNXe7SeASz
         jiQ4rERww18J8N59Zij2XcK5/KOyU+W7dPNimfWsYzFtxq+aYH6naIjjcchqUkhAi5ag
         TDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783925458; x=1784530258;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eWmwa1QUvWmWfZcAMrMrN6lD6RiBuEcOW0PxEeSlbVg=;
        b=IFFRVCGIwkW156RkH8W21uh91kt6SCoX/yU9m778UlZixhE3Pr/AFNJsCAv2XcMm/v
         Qld9/C2yEZ1yWSTv9SCQsBuOSwjUKDpUAJXpFSzFA+T8AqI+3fkLQBBCX+NfgRlkhkLE
         CoHNuzC2YlQmEe4whIU/ey03zGrVX/4iF+tcLHiyEFxP196WyiKWbJ9FRg1t8pbHnkPG
         aXVZhgw88gZaevOBEeIdlPn7oc8vPEOHevhRFXIwL4wSVS8leBDLgT9DXCPNKc9lEiTW
         uz272dbi8e+3bgdlw6movkCYUROJrTxZUBpHEi3PtPj9WC1UvHNFYwP8YeVfLuzHlueN
         ko3A==
X-Forwarded-Encrypted: i=1; AHgh+RqjJDoaJa/VI5jRPZY0dnVE3O4AUQI4Qb1jtfz2gRjr23T5UuuqKcQmPX4j3ofdOUwyBWwwnCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7ZXB1eIO83UV6TwwTgJjbyiNdaVI7EQSdEeUjveO9JP389B3
	ApC9C4IXuLa7Bt8FEqPvAo75XBFnLB+XZAb78reO6yNd6rrDRtMGl68Kef43Bw==
X-Gm-Gg: AfdE7clMUQo3xsQ59V5CJQiXfofLMjoxrYKEY+yB/Kgcse8lC7PehlKYY5XZuOIC2Ec
	Facc0acqL8VF7zSQcTBUbDNNxZ1OJd6zh8KbnKca1tcTv+k2gM6JOyPnVSSpe+5b04afLxATUQt
	D/RlKjOp1TUdySgd26qAp7X5NamfOz4cqzLjpahBlVvJN0mGeGcpujNbNlVkrAuY9GnWskyJ4rt
	S1y7zwEco32sNWlxdqswZEkf2uvQFseoJT36Z/W1XHRoPgZJbov5aKePGN4NgY6+fRh2YLMeHSp
	67AZDA/Rt1AHUSZ31DJgI+ObeK2HYjl6fNQdC/Z9xtfepQfAcLVkvh1Llj8/D8vNzvjINBUhuKH
	PeVraZHVVglfJa6iDYMq8RePBF24vHu3+VHnB1geVNzFU9/n7ZyOMLwLsi8EV20++7XqInur5xW
	WwqcOxyKaBTsE=
X-Received: by 2002:a05:6a21:1b81:b0:3b4:93b9:2b91 with SMTP id adf61e73a8af0-3c110009b82mr8720511637.12.1783925458332;
        Sun, 12 Jul 2026 23:50:58 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b8fc7c088sm18775525c88.2.2026.07.12.23.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 23:50:57 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com, venkat88@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] powerpc/crash: protect kdump from active watchdogs
In-Reply-To: <91e04278-aa90-4cbc-aeb4-f4663bf1f058@linux.ibm.com>
Date: Mon, 13 Jul 2026 12:10:06 +0530
Message-ID: <ldbfv1dl.ritesh.list@gmail.com>
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com> <mrvvv515.ritesh.list@gmail.com> <91e04278-aa90-4cbc-aeb4-f4663bf1f058@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> On 13/07/26 10:51, Ritesh Harjani (IBM) wrote:
>> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>>
>>> Changelog:
>>> ==========
>>>
>>> v2:
>>>   - Move H_WATCHDOG definitions to a common header for shared use
>>>     across pseries code. 1/3
>>>   - Added a new patch to handle pseries watchdog device registration
>>>     failure. 2/3
>>>   - Stop active watchdogs in crash hanlder. 3/3 Ritesh
>>>   - Add suggested-by tag 1/3 & 3/3
>>
>> Reviewed the changes and mostly looks good with some minor nits added to
>> the individual patches.
>>
>> Small request -
>> Could you please also update test results with v3 in your changelog
>> (since you mentioned we are able to reproduce the issue easily with your
>> test code).
>
> I tested this fix with the program I shared in cover letter. The watchdog
> was successfully stopped even when H_WATCHDOG is called form crash
> handler.  I will share my test details in v3 cover letter also.
>
>>
>>
>> aah one other thing I just noticed since you are ccing stable and you
>> added a Fixes tag in patch-3.
>> Patch-3 alone cannot be easily backported now due to patch-1 and
>> patch-2. There must be a way to define the dependencies if you are
>> looking for backporting the fix patch to stable tree, please check that
>> and follow that accordingly in v3.
>
> I thought about that as well, but since they are part of the same patch 
> series,
> I assumed they would be picked together. However, I don't think that 
> will work
> in all cases.
>
> I checked the older commits and noticed that a backport note was added. 
> I think
> we can do the same for the fix patch. I'll add a note indicating that the
> following patches should be backported first:
>
> powerpc/pseries: Move H_WATCHDOG definitions to a common header
> powerpc/pseries: Handle and log pseries-wdt registration failures
>
> Since these patches are not upstream yet, I'll refer to them by their 
> commit titles.
>
> Does that look good to you?
>

Documentation/process/stable-kernel-rules.rst
  Note that for a patch series, you do not have to list as prerequisites the
  patches present in the series itself. For example, if you have the following
  patch series::

    patch1
    patch2

  where patch2 depends on patch1, you do not have to list patch1 as
  prerequisite of patch2 if you have already marked patch1 for stable
  inclusion.


In that case, I think, we should mark all 3 patches for stable inclusion.

  patch 1/3   Cc: stable@vger.kernel.org
  patch 2/3   Cc: stable@vger.kernel.org
  patch 3/3   Cc: stable@vger.kernel.org
              Fixes: 69472ffa6575 ("watchdog/pseries-wdt: initial support for H_WATCHDOG-based watchdog timers")

-ritesh
