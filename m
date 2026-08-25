Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46BD459AD3;
	Tue, 25 Aug 2026 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668163; cv=none; b=MOcrIIhXxBFyKxxb7E9NeBW/ZAVsfaJghlQQ2LtCpLEo6NBozxQ0er7LDITskuDbatzeEiitWWeX0BZdaFMdLt0EyIRricRoImY+6DPA6OG/rxeYnIlvegk9ioJo9wIUIw4KGqIggqBz0qz2zCFcnkqXeKSIu0Q0WO9EaNBKeEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668163; c=relaxed/simple;
	bh=6S0YbHeuV7rcLGBVFnSNmLWJO3e0WBCtCKspI3Hb7h4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BHmJGs76YSayAqygsW5Mg5RVClDEZ92NkSQD8ov7VtYlV5/I3RhbU4MrBQI//Y3tFOh9cibWS1OzlFnSEyomaA7zet8vO0/lbNVJy/ZdrhsXJQ/cldgmfiYCx67leAdcEUjxZTSjrJOjOwfkn1FmqXWc8ooVSgw70VEniVoYiAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT+JuHE8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT+JuHE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73D21F000E9;
	Tue, 25 Aug 2026 14:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787668162;
	bh=GOSR1taEG3bwZuibyWiTdB9oSs/CdGGTaM9Pb7Xb8uI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=iT+JuHE83mYN2geKn+zn6/D4wzaaOYTez4ntljcWRvh6V7m1iclYJTiFPimXxcupn
	 4IE3GmIghJxmiy/cbWV5kyC14jBqQsEXQ4q+iR7TfWkTMEbqq7JiGSxeQ9Rk5SH/Yh
	 bsN1k1blmWX4Nr3WZumGWE8AnDKQFUop4wAYx28Viw6UxbAYQGsrTk5fKxWuPufOi3
	 Gn0mysbbyEOaIvrXVZmz9h8GbTh3/5cqtcKWkpySCmx+pt0I0qI6lefVkBvaNN3aKP
	 bZD3pbswdw5ZJI4QVdX2FBx+e4Px1/6gdr3AwuUjXE2reV0C+cmVCZUdOCInX0PQkr
	 1NbaleLSpJOKQ==
From: Christian Brauner <brauner@kernel.org>
To: Moritz Tanner <moritz.tanner@linbit.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260821085451.65206-1-moritz.tanner@linbit.com>
References: <20260821085451.65206-1-moritz.tanner@linbit.com>
Subject: Re: [PATCH] fs: don't return -EINVAL for successful nested thaw
Message-Id: <20260825-fluor-zehnkampf-weinfest-3a52191c5ef4@brauner>
Date: Tue, 25 Aug 2026 16:29:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6S0YbHeuV7rcLGBVFnSNmLWJO3e0WBCtCKspI3Hb7h4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT1LjvQnzDV1L/V961lyvH2E/fm+K55752v9rjVlSWWb
 SHH0pU/OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbywJeR4c+Ps2ozbYQaAy5o
 3kjZanJxeo5553nb+OPdHWsvXrmZepHhf6qf+prJbjuau3z7Yizq5ZQrPLP1XBebsKQkCDy2sz/
 LBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 21 Aug 2026 10:54:51 +0200, Moritz Tanner wrote:
> fs: don't return -EINVAL for successful nested thaw

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

[1/1] fs: don't return -EINVAL for successful nested thaw
      https://git.kernel.org/vfs/vfs/c/fe967191e585

