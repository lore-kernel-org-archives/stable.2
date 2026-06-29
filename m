Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3265380FDD;
	Mon, 29 Jun 2026 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739605; cv=none; b=D0h8+BkpyJQ2eX7KfmDb2ZpxbSKpASZzLjiZe5KuM6waFRkcn0nENiQeVoz8PO6Y2ND1GAKdIdsUUVpa3PKhSI9YrvmeyU/Crq4W0DJYnhqFUYKsiCTzwrYmhZvXgCeJyyNTRRIDAiT0e/1TV6zFIFRQfrj4vgiyPMDt+ieFbBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739605; c=relaxed/simple;
	bh=Myjk9FpNVvgWWkpk4VdH7knsD/hljr/GXMBrJx9wqq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZBqHHQG4CJGbWt1IhWLzHaX22WyOOvpepV0ZujwyjNQNZ3VpspfvcaSDvWgdAUoYUDxCXB7MVz6JxEMInXBes0OGAMf+mRlFXUTV6P+SptuWJbLjnnF5TYOEK96VfcR3op1kvY+YYuxhy2y5XmQAro0bAzoq3BUA8dR7+UuiyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyOkg9Oc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyOkg9Oc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C7C1F00A3A;
	Mon, 29 Jun 2026 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782739604;
	bh=u8ULakCzLsWXbut5dk0qJu4BUbPuCQCs0oXe/SzVkos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hyOkg9OcJ2pdQbr3lKDnJd3n10vcR5hkZ12R70W40Tp+M69i1hJFYPRp/7+K27rj0
	 fm+4ODdXl/T2Aw1QEy+xihsoycDNcycYmv/RcxbSY0u2Nzp+i72Vj0j2GoLeCGypb+
	 H/CJqlp78ubNiCpI9a8RPFINrH0M7Gk9YIY33+wvocGDXcQoyGZVSYlDjuVWCZ4PTG
	 tEX3XQlU+iXk72Q+i/rVNPXSVYbw4gZsXD0yBm7fKGzMwYMG4aZ/1CwW4k1RuCgBS8
	 uWbmr0B66Phk3fM/sBsFQQeBKWbpOZXSQfbuX0SXzU3Emg2kMzVYGEHYrL7Jv136gi
	 tNVWvCFiMYR5g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/6] samples/damon: handle damon_{start,stop}() failures
Date: Mon, 29 Jun 2026 06:26:40 -0700
Message-ID: <20260629132641.159851-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628214900.243ae17b910c18a4434036d7@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 28 Jun 2026 21:49:00 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 28 Jun 2026 14:54:39 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > All DAMON sample modules are not correctly handling failures from
> > damon_start().  Among those, mtier also has an additional problem for
> > handling of damon_stop() failures.  wsse and prcl also have a problem in
> > their damon_call() failure handling.  As a result, memory leaks, next
> > DAMON operation disruptions, and use-after-free can happen.  Fix those.
> > 
> > Note that only the damon_start() failure caused issues can reliably be
> > reproduced.  Reproducing those issues require the admin permission,
> > though.
> 
> So it doesn't seem that we need to fast-track all this into 7.2-rcX?

Yes, I think it is fine as long as they can be merged into necessary stable
kernels in reasonable time.  And 7.3 also sounds reasonable to me.


Thanks,
SJ
