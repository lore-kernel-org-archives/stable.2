Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8A229B77C;
	Sun, 28 Jun 2026 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782688730; cv=none; b=HA42m/t75dv60Ap9j7ZxuHbNSfkmIVAIs90bLP0dQG+QYD2nD/d5IoeYy81npLlH3lHdv9G4yPP3FK0JQkaPIc2XB1xcd1LQUtaOvxzfWyJTn6vI9j8ErEuu/ezEIsjR4j5UxOXNJCTj1SkIAHZa57ZahcHG3cLS889zhQryIyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782688730; c=relaxed/simple;
	bh=daN9yDTyzllmJb95sFxNeH9icNCjcuJiQmDVHyt4r2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixUJi5zaKLATA2WzoajUEd5lfJU9ME5xAhuHLS8xTh2j6xdwvbYt0zrMcUKndRSk7afqstqXGg70kQiPFxgZ8+/lORI4Ea7TqzQdllcu8LWyUfYyfUi7hH1tZQEQvgAMvD2O6c2czCNDw7nrCyKTqdMip5SJXtnKozi+VCawNV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJwcNw51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJwcNw51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8791F000E9;
	Sun, 28 Jun 2026 23:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782688729;
	bh=N+wAdu33iwEmwAs7LyBV/cvUDjaSWb7NO8ad1laYz78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJwcNw515qih9tcr+pTAgKsF5vyEOpaf0jHYuppcXStK4+nUb5xuwgljk7rivvrSQ
	 JO+gmmTUMGthSp/t5fJwczjUYdvzxzNKOup2ZHySthKjmghuZVffcxJFnmFgWpRiDg
	 nftEWbX3rXGMu/Su9KWyXMdJlHnxRoRcMg5iO5nBdV/2FNrgWTgrld6s6BHWQjaI11
	 +37KCFA4Px+ZfHrovp4B0Jhm/yA0GasHkg++vZRXKIYKemcQSqrnhR71dFH5DDrWS0
	 EnNWytd3wBIpmxsL/0fTOkCNDTsINvFvsdjExw6aZv7h0hOm7e3B+phCqM+Ey/g9TH
	 XExfDHDZ1cjFg==
From: Danilo Krummrich <dakr@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: add missing kernel-doc for union members
Date: Mon, 29 Jun 2026 01:18:45 +0200
Message-ID: <20260628231845.2708894-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623190023.407781-1-rdunlap@infradead.org>
References: <20260623190023.407781-1-rdunlap@infradead.org>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 23 Jun 2026 12:00:22 -0700, Randy Dunlap wrote:
> [PATCH] driver core: add missing kernel-doc for union members

Applied, thanks!

  Branch: driver-core-linus
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] driver core: add missing kernel-doc for union members
      commit: 667d0fb32149

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for Linus's tree and should land in the next -rc release.
