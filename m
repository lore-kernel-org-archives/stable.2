Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7411E39DBF5;
	Sun, 13 Sep 2026 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789322970; cv=none; b=bxvEICjAuHbCuYIep3+IOl7Za6d9kXtdccKYDeVAYE1wLy26DH8/NmSgBjN7QTwqtlkiAWfvQTxbAmfSH1M3I/PIeyMnsFaRV9FZuBexHe6XjnF1HE5XtwNBQHHb8SLuaRNuoh+kunVA/UOkrq4rb6i2zNLM0cvK8ANHpe67vvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789322970; c=relaxed/simple;
	bh=W1KqqOx1YbH8sdbRoH/JNG7FhJu41SqvlypZyw8Bnew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaQiyHOlM0fGSXlp+KH6SNfmquzkbN/zYN8grJ6iAKEh0CuHWT2+stikNfg9BEoEZCJcUtTpLrqFwE0aJbmk2dkgkxg22cgObVCTQgigmEk0h42jCz+myezdX1s/eFw10uUCtvIrJcx/0UZaN75N5dx2dZDm4WxCJvISbNAHw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=HJy6wM7P; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="HJy6wM7P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=IhtVvDygfJKIAvAuEo9iHVqsWcUzw9MlgNgHb1YJAVE=; b=HJy6wM7PHl/y6HGj8ah3Cm8vTZ
	C/wQcEFDYWLM+Y9dtFdP7YQOOTHulcZP/YXQAyV5YPDPGZ7eXFRFDRjswq4Y/pKOnduY+7xkKxUd7
	ga8A0qJpNw/SKbx9GjD8JMcJvDuAW/dbE8Mfx66iU4YUzaRU9TQ6m5CG+dqi+vdYj28wWEe6VHGgr
	FwqTzqViY6Rq32FcGbCiF+g4+CzLaCFxwzNqHYjyk28i4gMXpRUdj5TW5oavpvYpSdyvHC4rvTrjf
	B/kfPOFVadL4mOUUEubkUoDVRX0Y9izWy13UuOkneLW3JkXt1R3GPdB7RII/zaDB0ZQ/BYufOBHdu
	W6QCJXGhXyql/6OqHa0dfzlgYsk/YCgd4hGmTOKL9d5A5jldcNW84JP1M6IRbLnBDF3tqsKEax2Xm
	izuXG78pzfJZikOpWLUC99/vJvbs6OzbL2F/hZr4FXzjWbVAYDw9tCESQWSkN37QaTAq3oHODn2Kc
	1bsxGR9EvKoWPSMOZ7FHd/nR2Yen0SRsGX7NaqEVl4RH3PH9dl5hFwI3rN9GXg/GJG/mH/x5nPCKo
	G70wOtB1TCcIh0sUYdhrCGBbLLspWqsQYgpUHurp7Lq7gDksse6h1N01ZL3m/+zGZUkGc72U64S3D
	ejnystwqoplrUL2M0X2r0JNxNc6iILvRfYt5xn68k=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org,
 Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>,
 Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>,
 Ke Xu <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] 9p/trans_virtio: bound RERROR copy by mapped pages
Date: Sun, 13 Sep 2026 20:09:05 +0200
Message-ID: <23241140.EfDdHjke4D@weasel>
In-Reply-To: <aqZwqdnm7PW8OUv-@codewreck.org>
References:
 <20260607140603.24342-1-zhaoyz24@mails.tsinghua.edu.cn>
 <aqZwqdnm7PW8OUv-@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Sunday, 13 September 2026 11:45:13 CEST Dominique Martinet wrote:
> Yizhou Zhao wrote on Sun, Jun 07, 2026 at 10:06:01PM +0800:
> > handle_rerror() copies the variable-length error string of a zero-copy
> > RERROR response from the receive pages into the request's static response
> > buffer.  The amount copied is bounded by P9_ZC_HDR_SZ, so the data can
> > span at most two pages, but the helper is not told how many receive pages
> > were actually mapped.
> > 
> > If a malicious or broken virtio 9p device reports an RERROR length that
> > exceeds the remaining bytes in the first mapped receive page, the error
> > string is treated as crossing into a second page.  When only one receive
> > page was mapped, handle_rerror() still advances the page pointer and
> > dereferences the next entry, reading past the allocated in_pages array.
> 
> I'm not sure that can actually happen:
> If there was an "in page" (if there wasn't this is all noop anyway and
> data was written directly to req->rc.sdata), then req->rc.size amount of
> data was received into the pages, so if it does happen to span over a
> page boundary then there are at least two pages and we don't need to
> double-check here.
> 
> Christian, do you agree with me this patch is not required?

req->rc.size is coming from virtio device's used-ring len, and that is written 
by 9p server, and this server-written value is not verified anywhere against 
the real sizes of the descriptors that guest provided, neither by the kernel's 
virtio subsystem, nor by 9p client.

So the patch's premise is: 9p server is untrusted and lying about the written 
used-ring len. In that case, yes, it could crash the client.

Should you pick the patch? You can, it does fix what it claims to do, but this 
is one of those project-policy / maintainer's personal opinion dependent 
issues than a real-life problem fix IMHO:

- Malicious 9p server: of course server can lie about used-ring len and crash 
the Linux guest this way, but server could do that anyway, at any time. This 
is a virtio specific issue, 9p server is also Linux guest's host (i.e. it 
fully controls guest's memory, can simply kill/shutdown at any time, same 
outcome).

- Broken 9p server: that's an argument that might justify to pick the patch, 
i.e. the wrong length was unintentionally written by server, everything else 
server is behaving fine - very unlikely though.

P.S. Remarkable backlog processing today! :)

/Christian


