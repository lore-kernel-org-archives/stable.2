Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD93824A076
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782449464; cv=none; b=s5I46BEJzZ0JR3qmdliBJKhkkk2Qr0/m4rxBDOfs6TfGlrO8QWFEvzPDO8A3UJ6QUpw+ioJxWd+yVKAGI0TyxKT3OYedH/S25ad+/Qtms4xSONNamntRYVZc9dm0M85OCgH/sBrvThiQiwZcf4QcU1V5fy9CUNQuMMsAR4B3kfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782449464; c=relaxed/simple;
	bh=7wskW+iSP5DApCTNsrQ1QAy/V2Bq2aLiLOKOm78jcLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doIacEtFH2xfGAZdzuYsiKk15iwNdxgxLFq5iH9CvSmvE+3WLUkm6CCzVyY0QhrcQxRfCk6kpADzbeBCZ6+wRhGTlFtIfpQRehHmkAEkLN0k8nHBHjjLbqDtssJ0pZxAgJ6qhPFQzbFxg0AHT8+kSzmiFjxH9NY5bmIzfLGuhks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P32H+IGo; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P32H+IGo"
Message-ID: <46eb172e-7b31-48cc-bfd5-ca4777bf37ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782449451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+VAD6kx1YH7226mbPd2tBdtR/GRqu2/JEMjoE4xVok=;
	b=P32H+IGoTdMWMRX3QdLXm+nN3H1478ZO/lGcErfCRDKgnHC2YsBgCNMd2ry3tau5Vf3TZ/
	rR0CXvMvsDZF/uO+QEF3yUerRMoy/nRLPqD8/wc68cgs6K1cKKK/G8r+g2tlL9AOzX5Tel
	iMToO9tmYYWuGJT2qfDm6yoMTFSr4MU=
Date: Fri, 26 Jun 2026 12:50:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, harry@kernel.org,
 muchun.song@linux.dev, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <20260625151554.55105-1-qi.zheng@linux.dev>
 <0559695533E1C70F+31684237-e405-48da-ad8f-4ba7ff4ddb38@smail.nju.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <0559695533E1C70F+31684237-e405-48da-ad8f-4ba7ff4ddb38@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Peiyang,

On 6/26/26 12:29 PM, Peiyang He wrote:
> Hi Qi,
> 
> I have applied this patch and tested it against the PoC, the warning is not observed anymore in the kernel log.
> Thanks for your nice work!

Thanks a ton for testing this!

> 
> Best,
> Peiyang
> 


