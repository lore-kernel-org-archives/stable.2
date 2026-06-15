Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF063DA5CE;
	Mon, 15 Jun 2026 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513506; cv=none; b=ENn+j0cVzxBFKNjl+ytIHkpgj3uiIg+1/ATQRrEKUP53NPfmD7dsS6mez8CFB9p9oZvGKHdkx3lIQDBvKFVgJ1N8HPCzZZ5E8bv3P4cQe51455f8eCxeDh+uUUoxt1rWWVUceRSBsrHdWMMK6sqMc9mnsLyr/ah/HePIZh/kLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513506; c=relaxed/simple;
	bh=iB5iiAuuaaf4I/DCOhKKDpagC8tBIw10GFLuD3cYz2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZPUNYgLUgPl0Fs4Ky8kDTiFNpOOplAArVgzYYV/+jLMebr8RQgWL3QlFXl2ksAulHJHfQ2KteR2hNZ7YUiQEv8lznoq/upJhT00TEP7aLl4C1GMobQh1xLTpy0RPfe88gBK4oH86GcXZVpiNpZ/UU2IOU/MMSW0vpADKh5rva8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gfCcJ1v+; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="gfCcJ1v+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ERWHpm0rcxQI7VGqVOkDuXv6ZjP9THe81NYexLreENw=; b=gfCcJ1v+IuslnxVYW9JMXOKG3Z
	ztMtmfT0yJQHaT8NVF2RRqORdA7A+Ok4kST9gLLFpTPtkBT47/Bl7sesoTAymcYUsUB6phHZN9Kzw
	/LTGkaH388Y+jOMOXXo2FyQ+QCKdBc3dfSkE+I08CiSiuxlM7fqs0kTdtSHtVsRjTRiFzdDB8Jr+z
	GrL8b7SodDlSqof89Sst5vTamAQGQ3xHBv82awFm+TmE/NyQzt1xgURFBKu2Ms5UULwnALvV6EWa5
	op0tsko5y7fioQOouBGZzZ503E2JAPqF/RcDivCF69MBK2Kn5XXaRSoCJMjlRZLxtti1sYPqr27Dn
	vgy+iSaA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZ32I-00Cx6I-1L;
	Mon, 15 Jun 2026 08:51:14 +0000
Date: Mon, 15 Jun 2026 01:51:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eryu Guan <eguan@linux.alibaba.com>, 
	Yiwen Jiang <jiangyiwen@huawei.com>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] 9p: fix WARN_ON when dropping nlink on files with nlink=0
Message-ID: <ai-842Shp-LJIOBD@gmail.com>
References: <20260126-9p-v1-1-dc234d53ae87@debian.org>
 <aZGRkaFZPXfZW8a0@codewreck.org>
 <aeY32gOaV5jw1s8F@gmail.com>
 <aeZNdxmYw1K0Swg9@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeZNdxmYw1K0Swg9@codewreck.org>
X-Debian-User: leitao

On Tue, Apr 21, 2026 at 12:59:51AM +0900, Dominique Martinet wrote:
> Breno Leitao wrote on Mon, Apr 20, 2026 at 07:31:14AM -0700:
> >     In cacheless mode the server is authoritative and the inode is on its
> >     way out, so locally adjusting nlink buys nothing. Skip v9fs_dec_count()
> >     entirely when neither CACHE_META nor CACHE_LOOSE is set, which both
> >     avoids the warning and removes a class of nlink races (two concurrent
> >     unlinkers observing nlink > 0 and both calling drop_nlink()) that an
> >     nlink == 0 guard alone would only narrow rather than close.
> 
> I need to check this doesn't actually leak memory or something but this
> sounds better to me, thanks.
> 
> Please send as a proper PATCH mail and I'll tentatively apply for 7.2
> (a bit too late for 7.1)

Please, don't forget this one for 7.2. This is one is hurting me from
time to time.


Thanks,
--breno
