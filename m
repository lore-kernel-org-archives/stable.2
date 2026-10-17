Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0FD3BCD36;
	Sat, 17 Oct 2026 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206033; cv=none; b=Dg370nrsHXHkgd82HPTfDTafF0Bq+CTTWes1G6DtxCm/6dX7qts2VNhSOLOVtmAGPP0QTjYCzb+1BkK20qe+ZLdWwkVR8UQQXCkjb3Y9KZLlUi+Iy+0MW1ygxlIrctmpwVB6lUil5H5cGV2SGubOA+0QFeAhRRrjPAwNG9HrW1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206033; c=relaxed/simple;
	bh=BmJNZe/WBo6eSuZVl8ZldYuhfsbXT7TaeSylPhuZivw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqzJ2U4RTsoTMFwfeS1qbrpFmIbsWV9bAlVgV1dABKqhP3Dz95LYvCIzzUt09thth0GMUmblMxe5nQzpqFRx4+2X+D+5XaNWhKIl5OyDOh0/xgc+2+eeGiG/wQJtIvuJAiuMZ3DyrDQRPWeYn2JUorCBVu/VoUSh7NgQ6tu2P3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwzDwsE5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwzDwsE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C711F000C8;
	Sat, 17 Oct 2026 03:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206029;
	bh=TV/OONfo/vYbg2v0SwyUoOX48Sl8joB0GbAK7FEE0+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SwzDwsE5KrSRr4NU2JteHjaQd4ZvvSYpINrwymb11qFMAo72R3jnR912Hgipac9tu
	 tAnv1GhCSBTtNifVE5aKNhLjf12JNq7CzjrLwn7GWxU/V3e4664w+r3DmM4ffiJ7iJ
	 3W3nEpLGGnrfD0Eva8naAaixVH8kvwq+i9yUeJjiC/+b71sveu5C0AImyD3VUGr0SK
	 goN48BtvD66t7KLxCMMG9D15ikX5BLIh5LG4Qs6wXZO3MVi1sVtSKmgRZvBn6c+kE4
	 +W3E/k8/ACheC+jdLNmDUqbcUYkv3MzCPsPZjI7EcbhbuSHNc3IRDZgMxK4SO2fTRY
	 5nK4rgeOMSdBQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	kuba@kernel.org,
	linux-hams@vger.kernel.org,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier (merged out-of-tree in linux-netdev/mod-orphan)
Date: Fri, 16 Oct 2026 23:00:09 -0400
Message-ID: <2026-10-16-1-daily-reply-0004-rose-incoming-socket-ref-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFAa3YCEOWvxm3q8k9BXn5SVH4oAZj+b1hH=zwU8T9yCw02j2w@mail.gmail.com>
References: <CAFAa3YCEOWvxm3q8k9BXn5SVH4oAZj+b1hH=zwU8T9yCw02j2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> One more ROSE fix for 6.18.y, and this one matters: it fixes a
> regression from one of my own earlier patches.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
