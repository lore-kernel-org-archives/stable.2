Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFD937105A;
	Thu,  4 Jun 2026 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560193; cv=none; b=aqaGve5vFKmpHC0ox5oeS3l0ZFJUsy/V3igkXod3u7MSc+hMIZPDZyyB5O/ew8c3e0HusPamLTGVuLsZLlTdSf/yqsMo4QPNq8qrKs+D4cDv+RgO4i1ME6Ibwf8kgAdTXnVLd7XFtSOKF3al1K0gI9McGH464+8c5Nj6a1g8ygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560193; c=relaxed/simple;
	bh=h3U4xbU6FRfj5LPw1dUAYyA8i4MkIwkSMyvS3JUHFDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYBiDDLlV3Jpj2Ee5KPHp2/jf9V/3ZAXX9krFwkfN8lgjIjf1ktmYUSGRa4c3XELaO2qu/gGXssUNrdAhZYHAUHz2SqzRGFjYRYSGTpGqSV+B3md/Q9JuEir863xziPKkoHh+/oyNzvK2Kgg24u1of1kTUM2zGYPMJ1dlNH5f5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5SjTtlb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5SjTtlb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338791F00893;
	Thu,  4 Jun 2026 08:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780560191;
	bh=4+qbYva4rUQ36YFQxNrJt2qeBTPLEdc9Pe/mDaSC3ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y5SjTtlbLR3Y70NqdDtHRID0OPhjd6I3u9X77ArcLpYFtaKcqUr0khmjofZ0XEMwZ
	 MfAUEjfkcxREBKCuG/jce90m2W658oWK21aOxxYGxOV+YKlQ48CATGSIEsVbuLsy8y
	 YFas8KGi2NyY43sivQ8J/ePykYQlSzos80HmiMQqlNadk8S6+orC9IgTNaKTUhH2mP
	 b4FCnn0HAl2Lb4Sz2qApyMs6qe0Pcu3V2zXuCy7+3kGrjUcd6Tx8tzBO8p5Jq+prPS
	 ogazCaIiqZ4u4eNtw4MjU9Cafa0ZUbN8lY5QHsoeBd0f0wDeKT6phNR8j9I2gERoQv
	 nnzEp0TB+a+Cg==
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	samsun1006219@gmail.com,
	djwong@kernel.org,
	hch@infradead.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iomap: avoid potential null folio->mapping deref during error reporting
Date: Thu,  4 Jun 2026 10:03:06 +0200
Message-ID: <20260604-ablagen-imitieren-tierreich-648c4c1c277b@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604011858.2297561-1-joannelkoong@gmail.com>
References: <20260604011858.2297561-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604; i=brauner@kernel.org; h=from:subject:message-id; bh=h3U4xbU6FRfj5LPw1dUAYyA8i4MkIwkSMyvS3JUHFDE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQpGlp7nS9qvTTdLvR9OXNZhevaG/IcUxa8CV5RsVBs1 1/mtpdPO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayPYKR4Z1DcbfO7KpFppdO nTWwVjS2MBD9Olv2zJ9TdmwN5wwOBzMybFvDaHFizWdxJoYY8dIfn3+Ff7wZuWg336Q1coet7kZ ZsQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 03 Jun 2026 18:18:58 -0700, Joanne Koong wrote:
> When a buffered read fails, iomap_finish_folio_read() reports the error
> with fserror_report_io(folio->mapping->host, ...). This is called after
> ifs->read_bytes_pending has been decremented by the bytes attempted to
> be read.
> 
> For a folio split across multiple read completions, the folio is only
> guaranteed to stay locked while read_bytes_pending > 0. Once
> iomap_finish_folio_read() decrements read_bytes_pending, another
> in-flight read can complete and end the read on the folio, which unlocks
> it. This allows truncate logic to run and detach the folio (set
> folio->mapping to NULL). The error reporting path then can dereference a
> NULL folio->mapping. As reported by Sam Sun, this is the race that can
> occur:
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] iomap: avoid potential null folio->mapping deref during error reporting
      https://git.kernel.org/vfs/vfs/c/2eea7f44b9c8
