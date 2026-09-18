Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D83C455F
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 01:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696338; cv=none; b=kEp/5VmQv6ePx8fTi4qEtHym0rUiQ2FHkAhMNkpHdZdADqMumEZmbUiXy5aJbbFWudSbLGvv0Zv9ZwwgXQP9LPMbsDLMrFgVHypq/I3h/4EcsN3i9HCZkPHZXpyDYK1wqYtUiCVoy30GLAy5VRzdKNdcitYqWge31R0XzpBG/p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696338; c=relaxed/simple;
	bh=EH8CfcHsQa5i7e0wbGVp9WWRcntCMVYyE/AUyK//3Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9VvtrhanF8OSwQ3NmzehoYNAe8vxjyFM10VavqCFsajCfqfaLnTeM35+oA0jpQCAPI+khOXE47FUxbnOxxbMAJrZGb4xmcVDm4ocKKEqI5yWqs4ynlvS/ZD3rcD0RWkq0/iLXt53D+jngSNfqYqTuMvnAviZYBcgbaUteU/X0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z3AHiDoP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQosLLP8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3AHiDoP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQosLLP8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789696328;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRT56u7oa89lwXHln4d8jjC746ec/UQz4MnDVQXsKhk=;
	b=Z3AHiDoPvgcrbhYmfdW2+0kNdQOHDZ1sndhVsyCen2gu8Bi3xNyYsw+k+fN3tsdQFaKtZT
	e1XS1Rs2BW8vYb+ZzSSfHQLU+yjSKrGDn7c6BANlhbyOwsuVHYSoYEo8lMcgmlaIwOV8aO
	DIxSi9nd/Q3Pckr7pet4FCNCGiyI2rM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-2EB2YY6nPfyR4iGCn8F2ag-1; Thu, 17 Sep 2026 21:52:07 -0400
X-MC-Unique: 2EB2YY6nPfyR4iGCn8F2ag-1
X-Mimecast-MFC-AGG-ID: 2EB2YY6nPfyR4iGCn8F2ag_1789696326
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-912054a1c29so3686436d6.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 18:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789696326; x=1790301126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QRT56u7oa89lwXHln4d8jjC746ec/UQz4MnDVQXsKhk=;
        b=QQosLLP86WGIyAtFhUKJmw+Kqbm7OqztjTYPxCqHvpY+a1nbQjJHnT9KbYls032AoJ
         rOVT0gCEdukwmuQAHdt1kw//yQB/cK/88Mn5Whr24bRq/P1jI5cv6KHnEBgiA0rqlESQ
         eFqa2doVOqxB1zYKk3LmuQktvpjfkIljKFp51DQA+OYhLTMtyCvvI5RR8b6wad5fOBNK
         FbRiC+N6rstLpCGwBASWwce4Q0Lk0JaM7Ha/Du+N43hDAqqwr72ypZ5DH6p3Lk9vPbzS
         74AT8V0U54Sp5uU6NzuY6u0ooPBu6ouvQL6Sp70oounoqxGj68n9y+1m3iB6sll6LlVm
         sW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789696326; x=1790301126;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QRT56u7oa89lwXHln4d8jjC746ec/UQz4MnDVQXsKhk=;
        b=C19j9+/huIZWICVqv2OMsDlra5IhH0a2oQe5UK3MNfRUfx8w3YhUzrKYjfy/swkGmr
         1QM6+kOsUvukIdmyiS6tD3VsducPw5tqmmUQ/kJaIFu8Sdt+xnGyeqYGHPEbvuz9x0mv
         7kScEqe7Dy/S+dveEtex5kiNZ7EicUhX8JZcrMGFZrqR5n19aPKa5JSbN4RzKIfXpXcd
         Ks87QfbteC8EEs6CF7QrwS8WVQ61NQ0RlN2lCdwZ0xTd3PX1y3j1RCOvsVHcX28FylJV
         bMV8itDpIg9bMzefRc39BEMewi1x6Hiyp9K55Of9h+dfJ915usJ1CRKo36z3sZ1y4ZQN
         KELA==
X-Forwarded-Encrypted: i=1; AKwUvBzm72JkFztrZZmaBn1//NXWOI4DL/VCixZKAXIXNvGR617s0Bg5/quQs7aYPCBRmfyjw6EIaP8=@vger.kernel.org
X-Gm-Message-State: AFuF++kiOwG6Ezuq63FVXFTktk1d1y7EA9lyq709JFwdwthfs6WBtO6w
	lJE/gxj5czjmYQgYTlvjoTtibVh1FwH2qT5S/JFrccsbs9Fr0IrOe+HaIhE12u7yjxYVe4fYw+a
	tvCo0gYsN3PrPVM1Qty6RC3KUHrHWV2HPKvipf8Bt31rDY0GvyqGDpX2QAkLSERisMQ==
X-Gm-Gg: AYBFou0KAQzt539/LW3bpAdrofKDXqn5rFE6PUrKGSW2WcMraqVfk9iOFGDfJ0pOxZx
	blsjBLfFI3VIaR/o5SdsOu6+vAZFgx0TD5OB7A1sJKU9UpJJ0Hiv5TfNVopewHbwyhQEJlaPefF
	OxXSzyYn1MrjPv2uFzfxnX4oNjErl0DpnjUIbvlujg0AeTKf6v81PStZba0mKn7aTxDrCUl4cb1
	4nrYkCCMymYGZiNrS7sWc+opmI42huZ4POYYbV0TEAlbyIwHChMWk1yv6rwCQxLOOcZ7xKJWUX4
	1Y1UvUq68wiuJKnTHeOiNvspGN3RT9r26slsv56mqrIajHkn+VtUPwT+/dUM8n3H1wbAGvTjXS5
	moGGhHcJPjwzLx57w/YntOCmM47SbI9hSUQWecL/Z
X-Received: by 2002:a05:620a:f10:b0:93a:2e8:5af1 with SMTP id af79cd13be357-93bdc9d5537mr128367385a.46.1789696326365;
        Thu, 17 Sep 2026 18:52:06 -0700 (PDT)
X-Received: by 2002:a05:620a:f10:b0:93a:2e8:5af1 with SMTP id af79cd13be357-93bdc9d5537mr128365385a.46.1789696325917;
        Thu, 17 Sep 2026 18:52:05 -0700 (PDT)
Received: from [172.16.0.69] (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0cc8ae4sm16695385a.2.2026.09.17.18.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 18:52:04 -0700 (PDT)
Message-ID: <c2dd4bc7-413e-4ebb-b94e-2c61e3fcee17@redhat.com>
Date: Thu, 17 Sep 2026 20:52:02 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sorenson@redhat.com
Subject: Re: [PATCH] smb: client: fix potential use-after-free with
 TCP_Server_Info->hostname
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org, pc@manguebit.org, stable@vger.kernel.org
References: <20260918003327.2539470-1-sorenson@redhat.com>
 <CAKYAXd9UW34G21Xr6kUArCGsKUQZxz7ttkuCcdE9tVgyXNWTNA@mail.gmail.com>
Content-Language: en-US
From: Frank Sorenson <sorenson@redhat.com>
In-Reply-To: <CAKYAXd9UW34G21Xr6kUArCGsKUQZxz7ttkuCcdE9tVgyXNWTNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/17/26 8:47 PM, Namjae Jeon wrote:
>> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
>> index dea05aeb53a1..bb30cfa156aa 100644
>> --- a/fs/smb/client/smb2pdu.c
>> +++ b/fs/smb/client/smb2pdu.c
>> @@ -173,9 +173,8 @@ cifs_chan_skip_or_disable(struct cifs_ses *ses,
>>          unsigned int chan_index;
>>
>>          if (SERVER_IS_CHAN(server)) {
>> -               cifs_dbg(VFS,
>> -                       "server %s does not support multichannel anymore. Skip secondary channel\n",
>> -                        ses->server->hostname);
>> +               cifs_server_dbg(VFS,
>> +                               "server does not support multichannel anymore. Skip secondary channel\n");
> Since SERVER_IS_CHAN(server) means that server is a secondary channel,
> Is it intentional that this now logs the secondary hostname instead of
> the primary hostname?

No, not intentional... I missed that server != ses->server at this
point, so the patch is wrong.

Frank

-- 
Frank Sorenson
sorenson@redhat.com
Principal Software Maintenance Engineer, filesystems
Red Hat

