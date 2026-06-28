Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD03B19067C
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782633130; cv=none; b=Hw2KqFbOlq+AMe76LGU0RZRUVPETrGgPrhrL/dh73fIzdT+NvZTIO2twVm6B2o+U8bwFhsRNu54CX/mJwuMktC+jknjva53xrPTu/2RhmigwYuh1r2cLFClj+Qdf0Luw0Ug5Mf6qgixNEffSp4H7LTKkdeqXCZwaF8c3DKhhXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782633130; c=relaxed/simple;
	bh=h1soUnYGY+dQolL6Z3UpjNthIWytuu5ZftFJIykzq+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGreETkl2TtqrksQFyUQQee/OHq9RRxQIuCPQfCZ3m3ZgpEY8zdrh4+r7M12ZYBBDPhWMbuE8fNDSHcLrGc+T1jaLz9etIVof/iG653CzPUkfKTjllXG4WH0gso8uwHZq1S3O9QDhkwn5EFtWD+ar/L8rOxoul97aEqToIU0X4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=RNXENx1N; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="RNXENx1N"
Message-ID: <9526a947-446d-4db9-8901-6e730ff440d7@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1782633126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxGuATbpxyoep/ZktiVqqFVsgckLjpydoO3YMno0AYQ=;
	b=RNXENx1NTw6NFHpxcxL/SyagqRCOaFGL1AmSSXyQZzzel/BBXcVLRJkZBqSSlVbsZL6j8f
	kMQ0GOJjWHknlImrv2iAbCsL7qOxu6jMQQPRqZgi0WB/zBEonOEwOn4z8cov5OtI9I/UpJ
	ztMBiGSCTgTzYH/YwMvPAcC/G/Rbvc8speKgQQFT9Xk8+1uH+2Ayrs9z3jx4h7BcihiuyP
	dpw3OJ7b1/oAD5+D1S7RKunJAJjSXdNIE4N9TgxYH4d5t4AKiVyjVqolKEdpKBrVDGS+ef
	agMYN3pqnnOFhxpAomDp+wMO0quaRonCXcc/wWvFr2XT7DtcQN0QUuOmtX9cXw==
Date: Sun, 28 Jun 2026 15:51:56 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] smb/server: do not require delete access for
 non-replacing links
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>, smfrench@gmail.com,
 linkinjeon@kernel.org, pc@manguebit.org, ronniesahlberg@gmail.com,
 sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com,
 senozhatsky@chromium.org, dhowells@redhat.com, metze@samba.org
Cc: linux-cifs@vger.kernel.org, stable@vger.kernel.org
References: <20260628074243.629589-1-chenxiaosong@chenxiaosong.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <20260628074243.629589-1-chenxiaosong@chenxiaosong.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Reported-by: Steve French <stfrench@microsoft.com>

在 2026/6/28 15:42, ChenXiaoSong 写道:
> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
> 
> Reproducer:
> 
>    1. server: systemctl start ksmbd
>    2. client: mount -t cifs //${server_ip}/export /mnt
>    3. client: touch /mnt/file; ln /mnt/file /mnt/hardlink
>    4. client err log: ln: failed to create hard link 'hardlink' => 'file': Permission denied
>    5. server err log: ksmbd: no right to delete : 0x80
> 
> Fixes: 13f3942f2bf4 ("ksmbd: add per-handle permission check to FILE_LINK_INFORMATION")
> Cc: stable@vger.kernel.org
> Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>

-- 
ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Chinese Homepage: https://chenxiaosong.com
English Homepage: https://chenxiaosong.com/en

