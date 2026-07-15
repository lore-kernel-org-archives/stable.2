Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9660386C36
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 01:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784080735; cv=none; b=PqiCNfHCeQsmhF/wpq5AAs3m2tLs5+ID9JvOpr5LcCFELyRZBnV+Lno+Kyy66TPFT/48kUxHucTk3CkbO4WDURTmSxv7UtquIXvs/1yL75sKLkKZOR8I58jaeqoyAAYsVso4ezfjCFMWieSkrE38ejNeQ1/gNi1zKIyaOpK10Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784080735; c=relaxed/simple;
	bh=v6UEsQTUeCdKptbJxuHtunkSXd/logF0yqy/qJBt/D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhgO7dmN4LsagaUPsHNtfIiNiHpngWQRkt6RWggWygXupfY6jRjY67OwEu74DpEy9BamdgsGd149tyfQLSFadHcBhSOR2EbRavAFWW5h8W39YEuZMivhV/GWl0X/ygUVrg+Z3+ezDGCsxwrD3akQCdix492j0ZAmcjtmX8glpq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=gtiv0YRi; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="gtiv0YRi"
Message-ID: <b5901dc2-0d5c-45ac-a817-81e2a3934131@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1784080728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cb2hcIFH1acyVBewhIhQNw1fbffn3Z4mXJA9sWKRQ+Q=;
	b=gtiv0YRiYJjunMqowMWo4lC+hKwIlWhLxg47wT0NwN7rnDi0sJ0P47GjylmxIcF9TdOpo8
	vkXMDj9V/0gRwZ/vJGbmBKBS41jISzc/ignSi2uzf9Oi83OpHKK543Gs//wrs+W7ky0Nt+
	RBEGvL0pynpN0dhT8NphhowQmlqkfQ9P+opGkGaxgzLD0HrDyDlRsLYQf4yJIm38hGvIR+
	bdE5oVYLkxPg3afLO6fmrY80jRCExDjxiACFTFb32dGva7kSytEtoNU8aHdjZrnQarxbEl
	4P3iUw2+nG1q9pUXEFtNzHe0nCNTsfyl9s9QfOUTPBYpWp72SsINbgZfEJhHZg==
Date: Wed, 15 Jul 2026 09:58:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: FAILED: patch "[PATCH] smb/server: do not require delete access
 for non-replacing" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, linkinjeon@kernel.org, stfrench@microsoft.com
Cc: stable@vger.kernel.org
References: <2026071409-clamp-reminder-aacc@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <2026071409-clamp-reminder-aacc@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

linux-6.1.y linux-6.6.y linux-6.12.y linux-6.18.y does not include the 
bug-introducing patch: 13f3942f2bf4 ("ksmbd: add per-handle permission 
check to FILE_LINK_INFORMATION").

On 7/14/26 22:47, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to<stable@vger.kernel.org>.

-- 
ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Chinese Homepage: https://chenxiaosong.com
English Homepage: https://chenxiaosong.com/en

