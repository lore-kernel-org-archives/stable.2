Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC438E5DC;
	Fri, 18 Sep 2026 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741698; cv=none; b=mTzy7dYoIm0qAn7PvQjyoVxdRPEiVbAVZbHx6+19pR2qZRSr6jr0C63qiVLwA3Lbb6qPkzjIW2GOHa6Mw/nOEki97e4HDxbs5fxxxYd6rouFvT5f0mV1ssPbDYIgmr5ajK6Q1yNq1c9Y1oEI3bq1Pd0btRGxXWYuCP3k0R4jMwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741698; c=relaxed/simple;
	bh=30qmVMzX/J9BfiIXdu4Nb25WhGl5li/5+4BhYPYCtn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s23BexY86HP2t8uh1JIPhGiT0jSbNWu1S0o5UAFreyKU6Ol4ge0iMNrmpKdhpl0Ldu8hF2yD4nzIN91zcvELHl3Fo+dQK3HFX9Q9tkTFw0HYJKmcas2JCm0fJ3Jx1zv5HrKDE/lV2MQEBndUJY4g3a5Jxef7O5SyivXfKAv6d3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MEVttQ33; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MEVttQ33"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1789741684; bh=30qmVMzX/J9BfiIXdu4Nb25WhGl5li/5+4BhYPYCtn0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MEVttQ33rHSgI5YAox63QKMTqf5Z3vgFjlLw2MgTmghFAMp5J8CZeJUYcMxFA2EDE
	 VSjxbqd8ugITSwZRT2geBW7CN2wZOy+O0ZbAXKoh0B5Aaux8FG+PDa+h8vvxWrUYhF
	 61cObnIORLNyfEvSr9mmS9iap4vy9pPv3im0BPQg=
Received: from [IPV6:2409:8a1e:a1f6:6291:8109:68a1:36b:c182] ([2409:8a1e:a1f6:6291:8109:68a1:36b:c182])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 7020406B; Fri, 18 Sep 2026 22:28:02 +0800
X-QQ-mid: xmsmtpt1789741682td5iy8zfd
Message-ID: <tencent_EDFF4CC61926DDD4305C89B451CC67B51E05@qq.com>
X-QQ-XMAILINFO: NT7dO8ok7FP2TrCQG9lCaxo/hQmEV4JMnfTUmdg2z9Kyby9aFcVn2Xp6s18j4E
	 V2kRUIPzlp95YQTkw8uXERVDSvnN3wRYC34eJ8zOI6OvUlEXYl6dWubDVsaMdUhktabYPwAU/6bx
	 jExGL1l1Nmqa4jeG/jdW9hjj2fBpDoW6BH1YDeXle83JiOgxI7CParesHNtBLh+0jRk0JDnlVulM
	 3AZVGql1/c62NqUfB0+T+1TReNX78sM7I72c7ubIdIuBBudZTlEUS7Jy7+DjxA3Hmo7Nf/TlQpSM
	 3t3O2u5w3RwgqFmW9XD6ZJjAMbA7txVzhB33EbTLVJdFcz6W38KqCi7F/o/nHll8Vw0tFUDgvB3D
	 NXBOngVMsIl+8zx1TpxmHHfK4GDIcuYlrkUVNuZ4F4+VQWOImRNvS0doX2itLWOYcG2nLKxnwyjo
	 XTLD6J5E2tE4v7hX9WeQdUTbeFbYA4kKIJ12ThOWXT7Pcdi79Vl1pVf/2sRxrWGWGiujC41ZpZes
	 a5Piq4OHaJlRwQzk+pnsQOz69d8cvIqTod0uFzdEl+hw6RNxWfC4lHuGTUVIxqcR3lQ+CPhIgl4r
	 TXYV/HAh4FtMIgFem8dVoykRUR0fBMiYQzm2Hgtj6bm3RCsfKHaGSeErdr9VTO97zXjtDPAUAwmd
	 d61qvdCo1SplO7WJSN/lzMGo/SiG5px6l6KqCtQc82QsbjaCVT9R20YPORmrZ0jcOJ+LVTm8hgBH
	 vVtMmjGDzZ41ZVdbPPktvEtouGc+bLHGPTmjOCYE7oKk7z4TKJ/ppiije5ZWtDnBC430p+hgWdP0
	 urO1t5AUvCZP+3EcamLRk8IUO2N7bk+Nbjm+UNLH8B5AoDMs1ODfWd2iJQ/BFmDeeH9qBFadHKJj
	 uFp9hmqQAfzR28Mxe48W1Ac7SmY/YkZaymHm0wWDLh4pAdPEYhAedLN0UGjdjEqb2cSBApKfCIeP
	 GJ6xQ3hNhOHofdZdNs1pfsZjrMQOZMr1Hd6Rsb1BB1q6CyR3dA/2wRtKeSWNIqKks89mfIpq+dfd
	 pZoW/9RGvq3363EyB4E3Z5gA88YyoYVCPRjoHIZxuwxkuC0ew/qaq3ma0PrbqLJk6rBeQ+Prhs5c
	 TMIlEBYtcu/WydIh06ESxM+t9BrQ==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-OQ-MSGID: <b04c01ae-d953-4b3f-a3c4-39657da6ebb5@qq.com>
Date: Fri, 18 Sep 2026 22:29:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] parisc: parse early parameters in setup_arch()
To: Helge Deller <deller@gmx.de>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-parisc@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
 stable@vger.kernel.org
References: <7c90662b-903e-4624-bc97-96b1187332c5@gmx.de>
 <tencent_25C26948D9C4B056CBF12565F0600C4C2509@qq.com>
 <42e0fc0c-caaa-4d2b-bedc-164323bddac5@gmx.de>
From: Zhenghui Hao <zhenghui.hao@qq.com>
In-Reply-To: <42e0fc0c-caaa-4d2b-bedc-164323bddac5@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/18/26 16:22, Helge Deller wrote:

> Tested-by: Helge Deller <deller@gmx.de>
>
> Thanks!
> Helge 
Hi Helge,

Thank you very much for taking the time to test this patch. I really appreciate it.

Since you have successfully tested it, do you have any further comments or concerns regarding the code? Or is this patch ready to be picked up?

Thanks,
Zhenghui Hao

