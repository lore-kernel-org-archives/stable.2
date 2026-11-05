Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874171;
	b=MFV39kpR9sOlwSMEj09NoAiECUasH5GbGkpqJJ/p7FxlGRTUjYsi+1cdjqKn7eQJ1kdQ
	 /PlrFo8mfT3P+fcXo2IyVq102Efjx3wigNOyOMUw9DU094S3Mtx1pkhiDo+pXWld0gnMD
	 8mtLYbz+JUZR4ieCFirZQzt9frAkHvuE2YJG1EabH7mJhrGQpMq81tH2PDhXUcBX6jPdC
	 4UM557BZ9Z3OYTvcoiljcuNTJFlqJlAIXgUGxoRbxp5F4YT2auz/EYwd5v/yySW6Wygi5
	 IhEcZja1CSyMUqFMXgqnI/f1H5H0xeK0BKtJzihKktaISX/TJK2LuPK0PI3E2LI+INg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874171;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mA0JUWIMJDLe3trqouiE/a4ohypc9UC+FqDIAXVqBsQ=;
	b=KrPIfpu1v1pUe2WwHmEN10wCBZfWtf45+6nEobcqaBMzQ7hlqwKBBiP0k+5dfWMLKEkJ
	 xS0NAY8VKajcToN/KsQbPK4TpsSN+zMzp87AyGSCQGrkLV84OiXu6MuIfJHKWJG3+pU1j
	 dugWXbpohWd8dggaFG9nJsm9TnSArHARZCb/3dLkjCBWEB7vf68hxYSSGm/3cMZnNMdgm
	 RlVkDGSjHigNAPzCd6CtQ2f+g7pJ+rugmlWHFuMSs8gUX8oMnVz6BhMR5W6C++Kc0jQGw
	 szm/z6YzecuxdmFg5rUNJBLYce9w4A76RIeZr6O8P8+TMpB+exX+4qO2t8BOfMTN7lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=temperror header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UeONTUv0;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="qC/e/HgG";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977C8606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 10:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 977C8606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UeONTUv0;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qC/e/HgG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793874164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mA0JUWIMJDLe3trqouiE/a4ohypc9UC+FqDIAXVqBsQ=;
	b=UeONTUv0UgbS5IUIOd2M8qcgqpI9bup4ehO2VCa6ewq4x1MYJAwx6ft01Ive/vgQPmNKGi
	B51756vtLbZspiZcqvueGLxArHlu9yOJClOBjaLP6vE4o1QQ0BOzwHKW5U1uCH7Pzjg5H8
	g0ToCWbB9ajtcd6wwt8VLJXy45ul9hk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-P0bEnvF6PyKHqmAJAM-s9w-1; Thu, 05 Nov 2026 05:22:43 -0500
X-MC-Unique: P0bEnvF6PyKHqmAJAM-s9w-1
X-Mimecast-MFC-AGG-ID: P0bEnvF6PyKHqmAJAM-s9w_1793874162
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-490d2ac331bso969477f8f.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 02:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793874162; x=1794478962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mA0JUWIMJDLe3trqouiE/a4ohypc9UC+FqDIAXVqBsQ=;
        b=qC/e/HgGDYx/2Lh64K+89w43sgmoFIHWuFrBEhX60rDYwVSNtChRz09WqDqoa22QP3
         e+RVTc/axkWchbGnZ3bhlpNKuPgym35DUljxtawDPCmFsmx777kOCV+ov8IzqAcZ/zCj
         +m61HPAOhT4aaK+kunQ9lvKI9eb7DRq/zTkCF88XFdg8MfS59WYJv2wsJlIs17ttGDlZ
         l04iU5g3LWp2lj1xaCjSfMW21OaWaWKSyNo/7BhXdOUfvHKpt/gxvo16mpMSe4BDPBED
         6KeLgf6F0gh81FV1kkef3Co93QjgWMlUFqLJ2atYtMmUIreGL0IogeUNiQdWbznpjUJa
         UwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793874162; x=1794478962;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mA0JUWIMJDLe3trqouiE/a4ohypc9UC+FqDIAXVqBsQ=;
        b=o2bhLKMduXbibsgLRL4IelsGnMhzyTOPVcJo1DD9QULloaUajmj9oyXZ5jrUVnyrs3
         WAvHeMfQwhJuqh7n0tHmhnPY3AGGzKRLtEfjq4/DQYsK+bHlJhPQJBHFHWvrtqi8WgTK
         DdHkn/IInIQ1F73nsNGs/nn/wGoxjG5IH4FoDo865H0i6IeW94K6DXZZfc5ppEaJhnPp
         QDInqFuFZN0qoEHUuB1cMoHYpBm5pa9TF+NlDM+cRngZnT5wPlaZt+qtJ5pZXMBy4d/6
         UF3HCqp7pTrgRy3UrSx/lx+BIkMu0Z2bLznVrnORhr8jgq1cL7irtqUiegICQOGFZb49
         m8Nw==
X-Forwarded-Encrypted: i=1; AKwUvBxsRHMsbmDbn7xqrG6SbRfgWt0ZHj6ffTreOrhqdfTwbSEk71R8IBQErKe6lgtKDGQWWG5tKgo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5UT7UngNIw9+jBe6jF2zRjbYZ/5K1w/Tl9VnTuCjr115qxYPT
	/pztKk78j+r95xjsgzBNR7sXByUoXH2IwOI4bO6AQpofkUccluwgaf26kYszE7yGhSfWIZ/DVme
	WQdTvSyEzraUsmBzxM5pquSbr2RWnW/PTj3IJ2r4eGvxe8HuwtfP4MPYz8A==
X-Gm-Gg: AYBFou3koRWa79+jy2geZ1gEWTLfqYWfa0FyH5ya3pw2CtnGNJf025qDteHLMz6bLhZ
	I7c1o1BMBOLdH5SO5XO6ohwyidG+yPnL6BPnjrJnqWeS40J+5NaX9bcP/+XMM74dNvoNWQYT8rR
	CXxl2SmjyScAnlspnZ8E6YyalDm70+m7qgkvEms5Vd43IcqsdHBwHCtuALXEVigMfDJdH/qjlfD
	1kCuPzL4f+h1SeIOoCnBQVIxg6TqKrHVvc9uIZ2xcdNG/V7WU1De0aEOmDzX4+U+Dvekp0ocZFY
	ZvEarUSEW63wLHgBhdPi6XvmpMWZoGpvy0YtU7Kt26MDOcPvYepvkfRnRUZUhnHVU6Wbq2+tzZ9
	H42qRylhixT7MJ6ttb/aF2kgwol9Lrf1fe5e7pHNYFvKGTLQ0Ckzn
X-Received: by 2002:a05:600c:c87:b0:4a8:cb23:f71b with SMTP id 5b1f17b1804b1-4ac186b1a2amr423568345e9.18.1793874162253;
        Thu, 05 Nov 2026 02:22:42 -0800 (PST)
X-Received: by 2002:a05:600c:c87:b0:4a8:cb23:f71b with SMTP id 5b1f17b1804b1-4ac186b1a2amr423567735e9.18.1793874161708;
        Thu, 05 Nov 2026 02:22:41 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56f0237aesm56586085e9.9.2026.11.05.02.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:22:41 -0800 (PST)
Date: Thu, 5 Nov 2026 11:22:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] vsock/bpf: release sock lock while waiting
 for data in recvmsg
Message-ID: <auxYWGV4l-xEAajy@sgarzare-redhat>
References: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
 <20261028-kbh3-1-022-fix-v2-v3-1-bc0752b2d3db@eldare.de>
 <auSkQOU6qmj0NPEt@sgarzare-redhat>
 <179381093020.9.4719932034061956856.1746278795@eldare.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <179381093020.9.4719932034061956856.1746278795@eldare.de>

On Wed, Nov 04, 2026 at 04:48:44PM +0000, jrmmhm.kernel@eldare.de wrote:
>On Fri, Oct 30, 2026 at 03:18:10PM +0100, Stefano Garzarella wrote:
>> Ditto about commit message, please put more effort on writing something
>> readable by a human.
>
>Agreed, I'll rewrite both messages myself for v4, much shorter.
>
>> >+            if (sk->sk_err) {
>> >+                    ret = -sk->sk_err;
>>
>> Why?
>
>Same as vsock_connectible_wait_data(): an error that arrives during the
>wait is returned to recv(). Without the check the loop still ends, since
>every path that sets sk_err also closes the socket or sets peer_shutdown,
>but recv() then returns 0 or -ENOTCONN instead of the error.

Please add a comment with the reason.

>
>> >+            if (sk->sk_state != TCP_ESTABLISHED) {
>> >+                    ret = sock_flag(sk, SOCK_DONE) ? 0 : -ENOTCONN;
>> >+                    break;
>> >+            }
>>
>> I'm thinking if we should split this in multiple patches.
>
>From reading the code, it can be split without breaking bisect: first
>loop on all exit conditions with the lock still held, then drop the lock
>around wait_woken(). The order is fixed, since dropping the lock alone
>brings back the early -EAGAIN, and the loop alone does not fix the
>deadlock, so both would carry the Fixes tag. That is why I kept it as one
>patch, but I'm fine either way. Split it like that for v4, with the
>current 2/2 on top, or keep it as one?

Okay, if the entire change is needed to fix the deadlock, then it makes 
sense to have a single patch. Please make it clear in the commit 
description.

>
>> >+            if (!timeo) {
>> >+                    ret = -EAGAIN;
>> >+                    break;
>> >+            }
>>
>> Is the move of this check changing some user visible error?
>> I mean before this patch it was one of the first checks, is this okay?
>
>Yes, for non-blocking reads, intentionally: -sk_err, 0 on peer shutdown
>and the not-connected result now come before -EAGAIN, as on the native
>recvmsg path. I'll say so in the commit message.

Yes, please.

>
>> >+            if (signal_pending(current)) {
>> >+                    ret = sock_intr_errno(timeo);
>> >+                    break;
>> >+            }
>>
>> Why? Should be a separate patch?
>
>No, the loop needs it: with a pending signal wait_woken() returns at
>once, so without the check the loop spins until SO_RCVTIMEO expires, or
>forever if none is set. I checked it by removing the check: a signalled
>reader without SO_RCVTIMEO never returned and used a full CPU. The
>native path does the same.

Okay, please explain this in the commit description or in a comment on 
top of that check.

>
>> >+            if (data < 0) {
>>
>> Why not data <= 0  and void the other if?
>
>Right, will do in v4.
>
>Thanks,
>Jerome
>
>

