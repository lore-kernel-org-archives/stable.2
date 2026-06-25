Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93C378839;
	Thu, 25 Jun 2026 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384136; cv=none; b=qOUd8hNOWBk+qdtgQ0QEy9DtAzoS4uOGCPMoSqNZFj+qZC2PIw6XNuCu9JV7q9JOQCSr2uMkl3ADapBYYY6BrBu9sJadh6FEnN5IR6oGpKzs489WRJjArFo+mEl7WeYl3RTMzc58uHlmLNcw7U/bAptGHjQ05Th7HOCqOxNelXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384136; c=relaxed/simple;
	bh=nd+/EIfepnNIo5PLnS9kqP0mPMVtpLh+XEgbKruww+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsj7ivpoPnOvR/laSswH/FKxTatZ+7Swc9D9a1+gvwG5WQPrcq8nRYiyySDE7BbBgQ12TmRhcEGE8R0FmNQSNSHqLZIjsGlIPrX07Q/dzpUOipwU8i+JFsWNxFJdT55oPXbfJ9wphICrzqYura5tJWKrZYwBn8HuXfHzS485pzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaPH1vz/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaPH1vz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D061F00A3A;
	Thu, 25 Jun 2026 10:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384133;
	bh=nd+/EIfepnNIo5PLnS9kqP0mPMVtpLh+XEgbKruww+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oaPH1vz/FlHyDa4xVMnd6XNR4n2mOFsocCXHFj6LHlktoNcphIMlf2NurP6oqqhox
	 cZmtw3vmb4K6fMbG8anblK8XlzxLAw2GYuOxN+Zf6BNNPHRHV7UoM4F0fU3u+j5WGb
	 uJFo/lIG1rlnN8bZOY4jidmRnptl185c00XEUfpoEDzQHi6Zc/gxPOvdHf9sZxYbif
	 REkm9/BbRreD2laLjG6QjChTgesy/Qz9NeOeDD/vDFmLXdDwT4u7hsiFCqfP5+XVfC
	 Ul9zReYKQoktkAPG6BnsV9bFrxf2o9ciC8HLG9r2tUepC7wZ79yEVwSwEosSVrQdpu
	 tG+FeDT887a0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexander Martyniuk <alexevgmart@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jann Horn <jannh@google.com>,
	Lee Jones <lee@kernel.org>,
	Rao Shoaib <rao.shoaib@oracle.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Jiexun Wang <wangjiexun2025@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>
Subject: Re: [PATCH 5.15/6.1/6.6] af_unix: Reject SIOCATMARK on non-stream sockets
Date: Thu, 25 Jun 2026 06:41:54 -0400
Message-ID: <20260625054005.0007.afunix-siocatmark@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624151651.38894-1-alexevgmart@gmail.com>
References: <20260624151651.38894-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 5.15/6.1/6.6] af_unix: Reject SIOCATMARK on non-stream sockets
>
> Backport fix for CVE-2026-52928. Reject SIOCATMARK in unix_ioctl()
> for non-stream sockets.

Queued for 6.6, 6.1 and 5.15, thanks!

--
Thanks,
Sasha
