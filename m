Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED97390222
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117133; cv=none; b=BxSYjAvC4AtHqU5h1KuHyYh/kX5WNP5ocMAboFsqOrzBvD2WfcEPQNR6S8cZy9fMrPXgoGySBnwBvutxDxi6UNuH6NGMsgXnhNQY1XYUgJO9SnVM2RBn77e/+9ooB+a48nD/z7bICGKWHPdwQiZxJx+xccJGNHuBORc4Vd835bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117133; c=relaxed/simple;
	bh=CI9r8gXaJAJxDR/OSOHt5wIIPjuUUhwoEiqHNhKl8/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1PxO/OnP94UeGdBl562ueALQNwHUWPr/vaqJqm4xr+0u0mOAA4+1fJq3uQ1OeqUqsE6VLiUziOS1eN49pt/AX5+9cQHImP1mE/27vm9Fw/IKjHeHVFgFg7noI3ozaAYl6rhRpsABxPe9Bu0Bp/MJzPPB9QenapYUHA4FlYbe+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KPfb0Qlk; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KPfb0Qlk"
Message-ID: <ae54f2e2-c53e-40ae-8016-bf8302236c88@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782117129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XMCUdWNUTNxQ+9ZHfsfx1rhff+sOJFnxDlJ/S/dO+Q=;
	b=KPfb0QlkKAZcla/m1msSiD/Q3b06hIc5jEUOmF+RO2/tSrKJxZbuq4hvqnOM+U5bwS9nVL
	GNby/UkJZ564BXhs/sDkhvG0gxcthGULbOPT7lkeIlBp+vwUEe2VqRLkcCchM+4khUamlY
	91m+a8VjMqhp4fFF2bjIHTcdz4ORzkQ=
Date: Mon, 22 Jun 2026 16:31:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, harry@kernel.org,
 muchun.song@linux.dev, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn>
 <20260622073703.79258-1-qi.zheng@linux.dev>
 <F5EBCFC495955241+61489c47-c792-43de-a8f8-4b1030f4ab6a@smail.nju.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <F5EBCFC495955241+61489c47-c792-43de-a8f8-4b1030f4ab6a@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/22/26 4:24 PM, Peiyang He wrote:
> Hi Qi,
> 
> Thanks for confirming this bug and proposing the patch. The fix I previously proposed was indeed incorrect. I have applied your patch and tested it using the PoC script that previously triggered the warning; no warning is observed anymore.

Good news.

Thanks for testing this!


