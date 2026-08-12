Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B35348C6E
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524856; cv=none; b=mSFm8ZjPUuhD9BxpfpnrdTRLTuCEBkOcrXIBDjS6Y+YOLC0PbNEBAS3xvu/k4OPhtt9aV6352cwCSjF0N9JlquzmSZJwdr2Eo7boBr+w9ZC4YLVCnWZ5Cz6N9mixvuSCg8+86NpvwqtvAQOjn3eSdTuWWkbc0/3zpG+sQuyUvuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524856; c=relaxed/simple;
	bh=+Lfxq2ZjyPvr07gLupgr+oiARgQLW52G6/WXT2W9PkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uth41VLsUsz8O6o8QA4kBYAe1+T8SE69uNAGo3/91W668KKSw+ECMEexvw0tKq2faZNnDSjKzPjefsSgZ78NczUQZpKMrwtwqjz5S3m3hZ+jtaGY5uSNI39JaEdS/srQoL7vqPvJN0gRQfIVeSk5lCG3DeT5h7CwxhFL2HWJ/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=YfLAqLzQ; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="YfLAqLzQ"
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp4-g21.free.fr (Postfix) with ESMTPS id 04CA519F57E;
	Wed, 12 Aug 2026 10:54:04 +0200 (CEST)
Authentication-Results: smtp4-g21.free.fr;
	dkim=pass (1024-bit key; unprotected) header.d=morinfr.org header.i=@morinfr.org header.a=rsa-sha256 header.s=20170427 header.b=YfLAqLzQ;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0hJ82Du2Ry2MVsMHCkdkNdK2n5hEGfzcKMG04oE39+M=; b=YfLAqLzQtt8kT3XO5+oEfUdaIh
	Nn5j8oI9djLlT7GacyuDqzxnyY2aQd84dPASAeFSluBKzBReetUiYyxMkJKvXEtFFrwBS5vnhbRUB
	EV4VID+5aMsTuDXNFX6+3SAPzAEpmbrxr8Yk3w7OKNMdbcIWvNZjwwRYt9t4Wc2c+Y1A=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.98.2)
	(envelope-from <guillaume@morinfr.org>)
	id 1wu4iq-00000002k66-1bxH;
	Wed, 12 Aug 2026 10:54:04 +0200
Date: Wed, 12 Aug 2026 10:54:04 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guillaume Morin <guillaume@morinfr.org>, stable@vger.kernel.org,
	sashal@kernel.org, Zijiang Huang <huangzjsmile@gmail.com>,
	Kairui Song <kasong@tencent.com>, Hao Peng <flyingpeng@tencent.com>,
	albinwyang <albinwyang@tencent.com>,
	Baoquan He <baoquan.he@linux.dev>
Subject: Re: [Regression] 6.12 port of CVE-2026-64415
Message-ID: <anw0rOlHuRG1tUFa@bender.morinfr.org>
References: <ansgKOOXi6KE3oKf@bender.morinfr.org>
 <2026081226-herself-obvious-3955@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026081226-herself-obvious-3955@gregkh>

On 12 Aug  9:14, Greg Kroah-Hartman wrote:
> Can you send a patch to fix this?

Done: https://lore.kernel.org/stable/anw0I3HwhISAvVt2@bender.morinfr.org/T/#u

-- 
Guillaume Morin <guillaume@morinfr.org>
