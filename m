Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E178C9C
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787624495; cv=none; b=VYFQFxAswjvBMViqKWG6LNUV21npb82t/RulwgiII7pvyjw/DEGKG/T8pYQJhfYjSumOiCfP5zPfTHM44unCEbmz4mLykpKRfK5EtTqxzKNOmXyzPChIlvGs/SgR6GqbUgxCE/eXD1vTNEW+qSlTbzUE+ckPqkroFbEhmW/u5xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787624495; c=relaxed/simple;
	bh=mlFMa7vglT7lqDi3QdqbpINNRAXMVZR/az7R8YzdFJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/IZtz7bgEVF61e7o1zXXGVpRZzsj/eC7uxGUg90ojbtLxNyZxcedHxSQbJ/1qAp0jAX7Xk5YQxqoYmH3RWNHYvGT0oUGlZTW7wG2Z3Dn8e5eDrxi7zEFrYtSJYiSxw0UiWHRiFsLBQvZ/gFKQUJJCl4a3u+4AQnWjYL3zJxEl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHQsth16; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qc9ueYe3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHQsth16";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qc9ueYe3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787624492;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMXu7YvAgSkgB3IplsVQSj0uA2SLhYSZAaqiMsWSuXw=;
	b=VHQsth16CMGPjwdIn6K/k18IGlJAT3ncjacUrv0bqHxAIIw/Z3e06JNimXlEg5z5FTLVYb
	X95xE8kPMEDEFGarVbdNsbPvm2DtnBJcbk2BSrNkLDtUnKR8DJAx+Kr9v6dDg0XOydyVPm
	t/pV11EGQbcwgHk2hpFrlApETY4paig=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-h1VbwNb0OdGbi8hSg53eBA-1; Mon, 24 Aug 2026 22:21:30 -0400
X-MC-Unique: h1VbwNb0OdGbi8hSg53eBA-1
X-Mimecast-MFC-AGG-ID: h1VbwNb0OdGbi8hSg53eBA_1787624489
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1a439db36so1729112a12.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 19:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787624489; x=1788229289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vMXu7YvAgSkgB3IplsVQSj0uA2SLhYSZAaqiMsWSuXw=;
        b=qc9ueYe3nH48clbQPy1pnaQjeungJSouOKGLZed/kw6dJbSz81yK1M0j/H7LFDLgU0
         f187pp1bOBs3cS0ZYqZvaHtDwwseMj9HhTA8OzZ1VxKXgiE/MDnh9HNhiFHhsfQkgq06
         q8kno2Qg0XXLr89ldk8HESkW7qmQokSsBS1acH0RyWKsNyo8hyiHKqWDRM1sElCR8436
         aBSiJ8ZiWXMme/w9g/GUgNXAUkFSkKUISShvt+EOAwlDjSgx61LkohUPB6wYCYTLUO/X
         1yF/Da3Luu8h1VmulU9qjXJx/dpzAnOrruzzAtFtCaj/O00ceN+wxoy0XPr5K7XugUCe
         ONKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787624489; x=1788229289;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vMXu7YvAgSkgB3IplsVQSj0uA2SLhYSZAaqiMsWSuXw=;
        b=SN+2XKd9k+aEWX6rGR3fd1Z6DXF/LjXPGccdhNlcFGxiAFAIpMm2gs4s8NxujQmRYC
         dG9N/9/kQujBG60Lg/2ihPrNNcN+8HeH26YeFKTOq4en46hHfZQe7Yqmo1qekZEaN1j0
         W7aamTGgpNqGJNrp99lRzj1y8EOB64ABmpkpy2G+ovlLQBM3s8aggYM68rerWIQzSPbd
         Bf/r6jAUeC+iQZrnvG9F5F8XsMf3IqI5osccxBKTdvJeWHk1rCALMO8yb9l6tQ3yW1HC
         WvBWavKLD9D1BIGaLpoWBAAxVVNccs1L1lKpQ/Ac13KDlvNf0x1X09bUfOUIFeAv+7AW
         7/6Q==
X-Forwarded-Encrypted: i=1; AHgh+RoeQYE9gq8lRUjYQL/MrK3BaqYviwN0l4NNhoF9P3aLB1z7+koNVyRW8yggMzItkAp9TwS1StQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mdGTkEuYg0H49f+qoFxPDQvUlFio1xdRyZQ4LJdAt7oG7WyPSd
	RudvS6KXIhRfkQPcr/RJxEx/ccvZxhqCRsjq9CepXc1AShaDOc13TZeTUBvXpk5cqAnCNWNQKzH
	gGK9Ko7laUrCVzvQjTq/hih3ggqVtPImVPVyxpmabV2lW5Si4QQHuRBiiNA==
X-Gm-Gg: AR+sD10A2GDaEQhm3B6oE1mrCB4jSP5W2xUQ5GwtXu2o1hErtE2uY064m8ibfhbDHLg
	CoL5qc5dvHOl5EXVmyoxIr5wGpY1SjMeVuXPZA/L22XxocVVAxv1IIBCpasfxwZRNN02toX8OpV
	Bv8Nq1U8ajscdJdOee4/cKH33eE/Tp4nfT9JeZ6pO4aG/w6Noo401bYGThR5A+2RzEP7a3iX4Co
	f8oxn47ZgtRMfbSjMN3gi2Iv53A2cnBSYgHleDmu3D+MJLtXBaJf0Bs/jOTiupJk3GE1PsNxJbJ
	sbF5CxH7EAiPDPXaaF8wYVXgrvMdbuy+Z1h5JomnmF98It8Kox35hT+tvOX94H0M8vc0yCo9AeH
	omhaGWvTTs8XQEIYVhdkFctgzL9mut+HIJncxCzev
X-Received: by 2002:a05:6a21:918a:b0:3cb:e8b4:f03b with SMTP id adf61e73a8af0-3cd912a03a2mr6511702637.17.1787624489081;
        Mon, 24 Aug 2026 19:21:29 -0700 (PDT)
X-Received: by 2002:a05:6a21:918a:b0:3cb:e8b4:f03b with SMTP id adf61e73a8af0-3cd912a03a2mr6511601637.17.1787624488597;
        Mon, 24 Aug 2026 19:21:28 -0700 (PDT)
Received: from [172.16.0.69] (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90cb8e3sm45551831eec.12.2026.08.24.19.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 19:21:28 -0700 (PDT)
Message-ID: <bbbe50db-52d6-4ba6-a349-f84f67956e1e@redhat.com>
Date: Mon, 24 Aug 2026 21:21:21 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sorenson@redhat.com
Subject: Re: [PATCH] smb: client: fix OOB pointer arithmetic in
 cifs_to_posix_acl()
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org, pc@manguebit.org, brauner@kernel.org,
 stable@vger.kernel.org
References: <20260824231030.3502884-1-sorenson@redhat.com>
 <CAKYAXd_E2ZGzXzRJWCu4knD50LjXrC+dn4JPr8jxNMi5daWLCg@mail.gmail.com>
From: Frank Sorenson <sorenson@redhat.com>
Content-Language: en-US
In-Reply-To: <CAKYAXd_E2ZGzXzRJWCu4knD50LjXrC+dn4JPr8jxNMi5daWLCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/24/26 7:59 PM, Namjae Jeon wrote:
> On Tue, Aug 25, 2026 at 8:10 AM Frank Sorenson <sorenson@redhat.com> wrote:
>> In the ACL_TYPE_DEFAULT branch, cifs_to_posix_acl() forms a pointer
>> from the server-supplied access_entry_count before the size check that
>> bounds it:
> There seems to be still oob issue in this function although this patch
> is applied.
> Should we also validate acl header before accessing ->version ?
>
> +        if (size_of_data_area < sizeof(*cifs_acl))
> +              return -EINVAL;
>
>          if (le16_to_cpu(cifs_acl->version) != CIFS_ACL_VERSION)
>                  return -EOPNOTSUPP;

Ah, you are correct.  I'll respin with all the necessary validation.


Frank

>>          pACE = &cifs_acl->ace_array[count];     /* count = access_entry_count */
>>          count = le16_to_cpu(cifs_acl->default_entry_count);
>>          size += sizeof(struct cifs_posix_ace) * count;
>>          if (size_of_data_area < size)           /* too late */
>>                  return -EINVAL;
>>
>> The pointer arithmetic is undefined behaviour before any bounds check.
>>
>> Add an access-ACE size check before the pointer computation, matching
>> the existing guard in the ACL_TYPE_ACCESS path.

-- 
Frank Sorenson
sorenson@redhat.com
Principal Software Maintenance Engineer, filesystems
Red Hat

